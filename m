Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4B77F1D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348724AbjHQIJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348855AbjHQIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:09:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2564210E;
        Thu, 17 Aug 2023 01:08:58 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H86UIP023246;
        Thu, 17 Aug 2023 08:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=0r60og3YEUN8ZqsDcZOEUbw3dIibpQWZ1a10/3/mZS0=;
 b=ej9Lp+YM+pYhzy9r+N/L94XXRSHqzWEulqzudXgk33Tf7ph8QrOyWNQQGNv8OF552CNV
 MIm0DDr8zjvzdueV8ypwddceu1kZC9VMONtvzO9brsOWi6SZPh9NsQ2hqjSRput+jxV2
 nur1wwF/6L7TKyaeokdEKHTdA1COGCtjbqfKlW9UXhey0T045CRFzg1mkrGHUNYzQdBj
 BcozYXMjudTGpFIGsGUR19dVThIQFVbfULTTNzZzjPLMidhS0OZp+OxswhtmHGM0hmON
 vEu2JwO8Y2ixoIqlw70rRLE3qxzOWn07NPygWHI1eTXXOpiZJ7oJE0h8BvqPk1zmc6pJ Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shfh6ga0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 08:08:54 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37H86j9l025129;
        Thu, 17 Aug 2023 08:08:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shfh6g9yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 08:08:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37H5qDEv018920;
        Thu, 17 Aug 2023 08:03:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq41ur46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 08:03:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37H83nP819989180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 08:03:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4D4C20040;
        Thu, 17 Aug 2023 08:03:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 958C12004B;
        Thu, 17 Aug 2023 08:03:49 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Aug 2023 08:03:49 +0000 (GMT)
Date:   Thu, 17 Aug 2023 10:03:48 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/ipl: refactor deprecated strncpy
Message-ID: <20230817080348.5996-B-hca@linux.ibm.com>
References: <20230811-arch-s390-kernel-v1-1-7edbeeab3809@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-arch-s390-kernel-v1-1-7edbeeab3809@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5eoW-KfEw0BT4SLN-XEbp6TFr0r3RBRd
X-Proofpoint-ORIG-GUID: BgyRKex5i_FiOkMbt4IRCFgHzzsakvmw
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308170071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 09:56:15PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Use `strscpy_pad` which has the same behavior as `strncpy` here with the
> extra safeguard of guaranteeing NUL-termination of destination strings.
> In it's current form, this may result in silent truncation if the src
> string has the same size as the destination string.
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  arch/s390/kernel/ipl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 85a00d97a314..a6dcf6f28197 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -266,7 +266,7 @@ static ssize_t sys_##_prefix##_##_name##_store(struct kobject *kobj,	\
>  		struct kobj_attribute *attr,				\
>  		const char *buf, size_t len)				\
>  {									\
> -	strncpy(_value, buf, sizeof(_value) - 1);			\
> +	strscpy_pad(_value, buf, sizeof(_value));			\
>  	strim(_value);							\
>  	return len;							\
>  }									\

Patch applied, but replaced strscpy_pad() with strscpy() like it was
suggested by Kees.

Thanks!
