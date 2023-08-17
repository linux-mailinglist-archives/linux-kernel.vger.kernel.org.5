Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A852977F494
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350056AbjHQK4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350069AbjHQKzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:55:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553AE30D6;
        Thu, 17 Aug 2023 03:55:27 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HAho4s027471;
        Thu, 17 Aug 2023 10:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=8xtNiP/WZBOJ72OHI0H/zwkloNQuR5oziHXd/5lUyL0=;
 b=rshH8bS0oYlx1tFnMZiGtaXBb+le6xdIvYqK2by3liGv3iztE17erCWI2AYdX1B1Cspu
 UwZqyQbtoWYUEEI3zWc+HRewY8oVux0ZgKqsokLfJ+zs/rvBjRE0xWLFfTEZRlJ7NJ7q
 ZaN7cum/OovQQrLqcVIk3c/CFWjOB+pAgH1ZObR9qnhbgEdCSM5sdP1iFqxyooyUTyBd
 4p3nNRXuHMaJuUUiPEFgODnLpenaG51ncucwVoO/w+N3PWMU25o0qG1fTpFcvHP2ZIyA
 11YECTX85j9xC+FcgIXZe6YemL1n5S3o+QSak3L/zX4hUFfaafzMSHnRIDUzFGafYKmj Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shhuwrcxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 10:55:14 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37HAhsci027936;
        Thu, 17 Aug 2023 10:55:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shhuwrcx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 10:55:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37H9xt7k003436;
        Thu, 17 Aug 2023 10:55:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semdswxae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 10:55:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37HAt90F22872642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 10:55:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF01720049;
        Thu, 17 Aug 2023 10:55:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E5202004F;
        Thu, 17 Aug 2023 10:55:08 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.63.64])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Aug 2023 10:55:08 +0000 (GMT)
Date:   Thu, 17 Aug 2023 12:55:06 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH 28/36] tty: propagate u8 data to
 tty_operations::put_char()
Message-ID: <ZN38ioKn5kj6Rn/G@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-29-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810091510.13006-29-jirislaby@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hl6iP8oKiDPyOqP_bfE07qJbrNeB_Zmk
X-Proofpoint-ORIG-GUID: rNUJVaCeV7Dh96RNoSFvHXzO-K0g3Kgf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:15:02AM +0200, Jiri Slaby (SUSE) wrote:
...
>  drivers/s390/char/con3215.c            | 2 +-
>  drivers/s390/char/con3270.c            | 2 +-
>  drivers/s390/char/sclp_tty.c           | 6 +++---
>  drivers/s390/char/sclp_vt220.c         | 2 +-
...
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index 16b6f430dfd3..8bbce6a4d7f5 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -1030,7 +1030,7 @@ static int tty3215_write(struct tty_struct *tty, const u8 *buf, int count)
>  /*
>   * Put character routine for 3215 ttys
>   */
> -static int tty3215_put_char(struct tty_struct *tty, unsigned char ch)
> +static int tty3215_put_char(struct tty_struct *tty, u8 ch)
>  {
>  	struct raw3215_info *raw = tty->driver_data;
>  
> diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
> index 123524bff734..6374555a0937 100644
> --- a/drivers/s390/char/con3270.c
> +++ b/drivers/s390/char/con3270.c
> @@ -1821,7 +1821,7 @@ static int tty3270_write(struct tty_struct *tty, const u8 *buf, int count)
>  /*
>   * Put single characters to the ttys character buffer
>   */
> -static int tty3270_put_char(struct tty_struct *tty, unsigned char ch)
> +static int tty3270_put_char(struct tty_struct *tty, u8 ch)
>  {
>  	struct tty3270 *tp;
>  
> diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
> index cc0f6a97124e..831a8c7cacc2 100644
> --- a/drivers/s390/char/sclp_tty.c
> +++ b/drivers/s390/char/sclp_tty.c
> @@ -48,7 +48,7 @@ static struct sclp_buffer *sclp_ttybuf;
>  static struct timer_list sclp_tty_timer;
>  
>  static struct tty_port sclp_port;
> -static unsigned char sclp_tty_chars[SCLP_TTY_BUF_SIZE];
> +static u8 sclp_tty_chars[SCLP_TTY_BUF_SIZE];
>  static unsigned short int sclp_tty_chars_count;
>  
>  struct tty_driver *sclp_tty_driver;
> @@ -168,7 +168,7 @@ sclp_tty_timeout(struct timer_list *unused)
>  /*
>   * Write a string to the sclp tty.
>   */
> -static int sclp_tty_write_string(const unsigned char *str, int count, int may_fail)
> +static int sclp_tty_write_string(const u8 *str, int count, int may_fail)
>  {
>  	unsigned long flags;
>  	void *page;
> @@ -250,7 +250,7 @@ sclp_tty_write(struct tty_struct *tty, const u8 *buf, int count)
>   * sclp_write() without final '\n' - will be written.
>   */
>  static int
> -sclp_tty_put_char(struct tty_struct *tty, unsigned char ch)
> +sclp_tty_put_char(struct tty_struct *tty, u8 ch)
>  {
>  	sclp_tty_chars[sclp_tty_chars_count++] = ch;
>  	if (ch == '\n' || sclp_tty_chars_count >= SCLP_TTY_BUF_SIZE) {
> diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
> index 44974d801c1e..e148350c1e2c 100644
> --- a/drivers/s390/char/sclp_vt220.c
> +++ b/drivers/s390/char/sclp_vt220.c
> @@ -579,7 +579,7 @@ sclp_vt220_close(struct tty_struct *tty, struct file *filp)
>   * done stuffing characters into the driver.
>   */
>  static int
> -sclp_vt220_put_char(struct tty_struct *tty, unsigned char ch)
> +sclp_vt220_put_char(struct tty_struct *tty, u8 ch)
>  {
>  	return __sclp_vt220_write(&ch, 1, 0, 0, 1);
>  }

For s390 part:

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!
