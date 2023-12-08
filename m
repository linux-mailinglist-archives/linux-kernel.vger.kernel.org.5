Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8678E80A45D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573814AbjLHNXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjLHNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:23:01 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EEB1724;
        Fri,  8 Dec 2023 05:23:07 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8DMwuB025638;
        Fri, 8 Dec 2023 13:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VpMyP+5lKWc2TeAM094ZGRRxASyLksi3vhPSZU1DasA=;
 b=rlXBLWSJS+/d+xR2I9SYpFby6+Ate/Ae1f+9SSmdlV1OndjfK7ffpuP6Etfc7yBozs//
 B5DBdogp4eu5460C8rAofDIQXJ+AMMooan4SnpKBURXONfLTnJ3EdKBoZIBHtlKlo30/
 4yaoKm6qRoD7aaZkgWTBnDoypNgMkiicCU1j3Uxz6jh3kwxQoZXgi/0/g2BRQJ5DWrL7
 0w91SZoBSc1kaKD6GmzIfQ3Y/i63FWJv67deQFVkuEW2zciI6+YUHOvtPvcviheilf1E
 M+PX9Zaa82lls8+ZMr0DXmU3USu6dKlHWIxgGdU2QUFu4SyT9/bM8z0AjVJIApXKavoY Mg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv3191ubx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 13:22:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8A38fU027003;
        Fri, 8 Dec 2023 13:19:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav39nu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 13:19:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B8DJpEv5571210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Dec 2023 13:19:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67FA52004B;
        Fri,  8 Dec 2023 13:19:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D5BD20043;
        Fri,  8 Dec 2023 13:19:50 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.66.245])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Dec 2023 13:19:50 +0000 (GMT)
Date:   Fri, 8 Dec 2023 14:19:48 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 09/27] tty: con3270: convert to u8 and size_t
Message-ID: <ZXMX9AmWwR6hPSMr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231206073712.17776-1-jirislaby@kernel.org>
 <20231206073712.17776-10-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206073712.17776-10-jirislaby@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v-Y6C-375jqxig-9iiMhvuQKEK9RLMiX
X-Proofpoint-ORIG-GUID: v-Y6C-375jqxig-9iiMhvuQKEK9RLMiX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_08,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 08:36:54AM +0100, Jiri Slaby (SUSE) wrote:
> Switch character types to u8 and sizes to size_t. To conform to
> characters/sizes in the rest of the tty layer.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  drivers/s390/char/con3270.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
> index 363315fa1666..251d2a1c3eef 100644
> --- a/drivers/s390/char/con3270.c
> +++ b/drivers/s390/char/con3270.c
> @@ -54,7 +54,7 @@ struct tty3270_attribute {
>  };
>  
>  struct tty3270_cell {
> -	unsigned char character;
> +	u8 character;
>  	struct tty3270_attribute attributes;
>  };
>  
> @@ -123,7 +123,7 @@ struct tty3270 {
>  
>  	/* Character array for put_char/flush_chars. */
>  	unsigned int char_count;
> -	char char_buf[TTY3270_CHAR_BUF_SIZE];
> +	u8 char_buf[TTY3270_CHAR_BUF_SIZE];
>  };
>  
>  /* tty3270->update_flags. See tty3270_update for details. */
> @@ -1255,7 +1255,7 @@ static unsigned int tty3270_write_room(struct tty_struct *tty)
>   * Insert character into the screen at the current position with the
>   * current color and highlight. This function does NOT do cursor movement.
>   */
> -static void tty3270_put_character(struct tty3270 *tp, char ch)
> +static void tty3270_put_character(struct tty3270 *tp, u8 ch)
>  {
>  	struct tty3270_line *line;
>  	struct tty3270_cell *cell;
> @@ -1561,7 +1561,7 @@ static void tty3270_goto_xy(struct tty3270 *tp, int cx, int cy)
>   *  Pn is a numeric parameter, a string of zero or more decimal digits.
>   *  Ps is a selective parameter.
>   */
> -static void tty3270_escape_sequence(struct tty3270 *tp, char ch)
> +static void tty3270_escape_sequence(struct tty3270 *tp, u8 ch)
>  {
>  	enum { ES_NORMAL, ES_ESC, ES_SQUARE, ES_PAREN, ES_GETPARS };
>  
> @@ -1726,7 +1726,7 @@ static void tty3270_escape_sequence(struct tty3270 *tp, char ch)
>   * String write routine for 3270 ttys
>   */
>  static void tty3270_do_write(struct tty3270 *tp, struct tty_struct *tty,
> -			     const unsigned char *buf, int count)
> +			     const u8 *buf, size_t count)
>  {
>  	int i_msg, i;
>  
> @@ -2052,7 +2052,7 @@ con3270_write(struct console *co, const char *str, unsigned int count)
>  {
>  	struct tty3270 *tp = co->data;
>  	unsigned long flags;
> -	char c;
> +	u8 c;
>  
>  	spin_lock_irqsave(&tp->view.lock, flags);
>  	while (count--) {

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
