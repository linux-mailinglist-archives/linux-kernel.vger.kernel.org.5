Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC5778E40
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjHKLx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjHKLx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:53:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9337410F;
        Fri, 11 Aug 2023 04:53:55 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BBmiT3031797;
        Fri, 11 Aug 2023 11:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Lr4aL49HTD62v0Y6Z+UFW4DuRGTZ0zL227b/wXWzqkY=;
 b=g1XlfD1ZSuV13k0fl1GY4TNZW3i3aaHwSuKY7dU82foEG/DZ8fE5UlOiWqzFCO9uugTL
 JQ3yM1coIXV/rkklvbVYIYqEpj8dEqt40yDxCQUDAS69Ue0aBghRdm9n550K88y3Psth
 XUhqrEvv1b2792QjdAkyLsCBqYZtB7Fx/ry/7oCxpS0vTcrccO0PF7xJ0CtIhKGLGU0Y
 3XXy/Rk40IHff2SckU27uf7nQXPOrzg6KeQLUQzijKAxgvS6nY+ROVC5ayd0G6vGsu89
 29xukiQHktFcMT0YyUqbZih4fZlGDLSBuAzzQEaFO/fkBFKqHBrapADK2bdTRoeZYvQ1 lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdmej01re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 11:52:47 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37BBogkE004393;
        Fri, 11 Aug 2023 11:52:46 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdmej01pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 11:52:45 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37B9v8VO001801;
        Fri, 11 Aug 2023 11:52:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f2hw3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 11:52:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37BBqeJO39912150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 11:52:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC3E120043;
        Fri, 11 Aug 2023 11:52:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C100C20040;
        Fri, 11 Aug 2023 11:52:37 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.86.49])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 11 Aug 2023 11:52:37 +0000 (GMT)
Date:   Fri, 11 Aug 2023 13:52:36 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH 27/36] tty: propagate u8 data to tty_operations::write()
Message-ID: <ZNYhBCKWPdyuBhtz@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-28-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810091510.13006-28-jirislaby@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iXKVCbOoSZIUTvxrw6djE3c_aGrdWVKE
X-Proofpoint-GUID: xQWyMkRH_K93iqonGwktKsDoq1WEfqzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_03,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=837
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:15:01AM +0200, Jiri Slaby (SUSE) wrote:

Hi Jiri,

> Data are now typed as u8. Propagate this change to
> tty_operations::write().
...
>  drivers/s390/char/con3215.c            | 3 +--
>  drivers/s390/char/con3270.c            | 3 +--
>  drivers/s390/char/sclp_tty.c           | 2 +-
>  drivers/s390/char/sclp_vt220.c         | 2 +-
...
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index a1fef666c9b0..16b6f430dfd3 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -1021,8 +1021,7 @@ static unsigned int tty3215_write_room(struct tty_struct *tty)
>  /*
>   * String write routine for 3215 ttys
>   */
> -static int tty3215_write(struct tty_struct *tty,
> -			 const unsigned char *buf, int count)
> +static int tty3215_write(struct tty_struct *tty, const u8 *buf, int count)
>  {
>  	handle_write(tty->driver_data, buf, count);
>  	return count;
> diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
> index d9983550062d..123524bff734 100644
> --- a/drivers/s390/char/con3270.c
> +++ b/drivers/s390/char/con3270.c
> @@ -1803,8 +1803,7 @@ static void tty3270_do_write(struct tty3270 *tp, struct tty_struct *tty,
>  /*
>   * String write routine for 3270 ttys
>   */
> -static int tty3270_write(struct tty_struct *tty,
> -			 const unsigned char *buf, int count)
> +static int tty3270_write(struct tty_struct *tty, const u8 *buf, int count)
>  {
>  	struct tty3270 *tp;
>  
> diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
> index 971fbb52740b..cc0f6a97124e 100644
> --- a/drivers/s390/char/sclp_tty.c
> +++ b/drivers/s390/char/sclp_tty.c
> @@ -230,7 +230,7 @@ static int sclp_tty_write_string(const unsigned char *str, int count, int may_fa
>   * routine will return the number of characters actually accepted for writing.
>   */
>  static int
> -sclp_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
> +sclp_tty_write(struct tty_struct *tty, const u8 *buf, int count)
>  {
>  	if (sclp_tty_chars_count > 0) {
>  		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count, 0);
> diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
> index a32f34a1c6d2..44974d801c1e 100644
> --- a/drivers/s390/char/sclp_vt220.c
> +++ b/drivers/s390/char/sclp_vt220.c
> @@ -463,7 +463,7 @@ __sclp_vt220_write(const unsigned char *buf, int count, int do_schedule,
>   * number of characters actually accepted for writing.
>   */
>  static int
> -sclp_vt220_write(struct tty_struct *tty, const unsigned char *buf, int count)
> +sclp_vt220_write(struct tty_struct *tty, const u8 *buf, int count)
>  {
>  	return __sclp_vt220_write(buf, count, 1, 0, 1);
>  }
...

In this and following patch it is only ::write() (and other) callbacks
switched to u8, while the called internal functions stay with old types.

Do you plan to follow with part II etc, or it is archs/drivers that
are expected to sort it out eventually?

(I speak for s390, but the other affected archs are in the same boat I guess).

Thanks!
