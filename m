Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB71180A450
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573799AbjLHNTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:19:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C91F133;
        Fri,  8 Dec 2023 05:19:40 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8DGT7m002379;
        Fri, 8 Dec 2023 13:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9X1fR4BT3F8yTjGhdEq/6jugaXgw5k2pHo3Sujs+Htw=;
 b=hqwpCPnUSr/K1oqzB1tUDSXUi9deSN1k1UHavtHJk/rGPHhlmZgRpBLnNYsC49zvih91
 Xd5s4r7MruId7FIvJqzIPbulQpgaU3eaVvGhDM/7Z7Q9ECDwDxIoNR1m8SUOXoTF0yXn
 J9Ore0TkYgsS6P/14xMqOHChrYJqIlEDSaXID35oJszmjIOFPWksLihEPna8HSa9hafy
 bH6cf00eIxouNWC+Mv9kvd5naLS1IRxLrbDo6tR29tGJgoJVY7NWwGUix1G0oiQF3Mde
 2ubUvAPZK7ZYZ9KZp28y1JjGR4kLDbWj6gHMUL7/nM/NKTq2qhcLo1D8/IZ1lomhLGvV Gg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv30yhfcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 13:19:33 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B89iZgg027026;
        Fri, 8 Dec 2023 13:19:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav39nt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 13:19:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B8DJTnN8389192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Dec 2023 13:19:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C128D20049;
        Fri,  8 Dec 2023 13:19:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC0B020040;
        Fri,  8 Dec 2023 13:19:28 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.66.245])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Dec 2023 13:19:28 +0000 (GMT)
Date:   Fri, 8 Dec 2023 14:19:27 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 08/27] tty: con3215: convert to u8 and size_t
Message-ID: <ZXMX3y/75ugvzk9L@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231206073712.17776-1-jirislaby@kernel.org>
 <20231206073712.17776-9-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206073712.17776-9-jirislaby@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VxIbW2HwBpffVQoLsIwvj_nfiWuYaFh_
X-Proofpoint-ORIG-GUID: VxIbW2HwBpffVQoLsIwvj_nfiWuYaFh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_08,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 08:36:53AM +0100, Jiri Slaby (SUSE) wrote:
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
>  drivers/s390/char/con3215.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index 34bc343dcfcc..0b0324fe4aff 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -79,8 +79,8 @@ struct raw3215_info {
>  	struct ccw_device *cdev;      /* device for tty driver */
>  	spinlock_t *lock;	      /* pointer to irq lock */
>  	int flags;		      /* state flags */
> -	char *buffer;		      /* pointer to output buffer */
> -	char *inbuf;		      /* pointer to input buffer */
> +	u8 *buffer;		      /* pointer to output buffer */
> +	u8 *inbuf;		      /* pointer to input buffer */
>  	int head;		      /* first free byte in output buffer */
>  	int count;		      /* number of bytes in output buffer */
>  	int written;		      /* number of bytes in write requests */
> @@ -522,12 +522,14 @@ static unsigned int raw3215_make_room(struct raw3215_info *raw,
>   *	string	without blocking.
>   *	Return value is the number of bytes copied.
>   */
> -static unsigned int raw3215_addtext(const char *str, unsigned int length,
> +static unsigned int raw3215_addtext(const u8 *str, size_t length,
>  				    struct raw3215_info *raw, int opmode,
>  				    unsigned int todrop)
>  {
> -	unsigned int c, ch, i, blanks, expanded_size = 0;
> +	unsigned int i, blanks, expanded_size = 0;
>  	unsigned int column = raw->line_pos;
> +	size_t c;
> +	u8 ch;
>  
>  	if (opmode == RAW3215_COUNT)
>  		todrop = 0;
> @@ -558,7 +560,7 @@ static unsigned int raw3215_addtext(const char *str, unsigned int length,
>  		if (todrop && expanded_size < todrop)	/* Drop head data */
>  			continue;
>  		for (i = 0; i < blanks; i++) {
> -			raw->buffer[raw->head] = (char)_ascebc[(int)ch];
> +			raw->buffer[raw->head] = _ascebc[ch];
>  			raw->head = (raw->head + 1) & (RAW3215_BUFFER_SIZE - 1);
>  			raw->count++;
>  		}
> @@ -570,8 +572,8 @@ static unsigned int raw3215_addtext(const char *str, unsigned int length,
>  /*
>   * String write routine for 3215 devices
>   */
> -static void raw3215_write(struct raw3215_info *raw, const char *str,
> -			  unsigned int length)
> +static void raw3215_write(struct raw3215_info *raw, const u8 *str,
> +			  size_t length)
>  {
>  	unsigned int count, avail;
>  	unsigned long flags;
> @@ -596,7 +598,7 @@ static void raw3215_write(struct raw3215_info *raw, const char *str,
>  /*
>   * Put character routine for 3215 devices
>   */
> -static void raw3215_putchar(struct raw3215_info *raw, unsigned char ch)
> +static void raw3215_putchar(struct raw3215_info *raw, u8 ch)
>  {
>  	raw3215_write(raw, &ch, 1);
>  }
> @@ -823,12 +825,10 @@ static struct ccw_driver raw3215_ccw_driver = {
>  	.int_class	= IRQIO_C15,
>  };
>  
> -static void handle_write(struct raw3215_info *raw, const char *str, int count)
> +static void handle_write(struct raw3215_info *raw, const u8 *str, size_t count)
>  {
> -	int i;
> -
>  	while (count > 0) {
> -		i = min_t(int, count, RAW3215_BUFFER_SIZE - 1);
> +		size_t i = min_t(size_t, count, RAW3215_BUFFER_SIZE - 1);
>  		raw3215_write(raw, str, i);
>  		count -= i;
>  		str += i;

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
