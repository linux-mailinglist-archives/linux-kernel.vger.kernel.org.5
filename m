Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09B9786B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjHXJKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbjHXJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:09:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD610FA;
        Thu, 24 Aug 2023 02:09:51 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O91AeV012673;
        Thu, 24 Aug 2023 09:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=OLuVdAXB/YRIVa6KwfTKGyM1URZGho5Zn4DvYDDw6uY=;
 b=m1nyXru5Dh6WSJ15aK8gEXzFu3nKKlYWtATsTHJYh8MxiFoi64gam/z4EVvKigiHqgjz
 cnvS55OOm/dlfUqsuFI2MOVgOlCB4hMH51YqzHMmgEbI2PxVjEZNeGIRx4I/Zj+ibGMI
 PTk/IX5yCGhKtMK6j+5uCererL+76KYKvp8D88ZjTEZHQbDqmxWYvZfD/J3ME85mQFr0
 +hKrfoR0l+kNOPx8s28/LF4O6Yc1HcDL2TrfECxgY2KvMkcqQL5DWzecUOJS/FFZeBaB
 ggcoFmlkWh5BH+OypYp0dxGvE3txMPHzdbXtunOEElvOWa2gGgF+Vlp8UxCEITefOkSs 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sp4750ht7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:09:47 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37O91chG013388;
        Thu, 24 Aug 2023 09:09:25 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sp4750epv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:09:25 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37O7C4qp010383;
        Thu, 24 Aug 2023 09:02:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn21swren-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:02:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37O92OZw3998426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 09:02:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7750B2004F;
        Thu, 24 Aug 2023 09:02:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BC8F20067;
        Thu, 24 Aug 2023 09:02:24 +0000 (GMT)
Received: from osiris (unknown [9.171.81.161])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 24 Aug 2023 09:02:23 +0000 (GMT)
Date:   Thu, 24 Aug 2023 11:02:22 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>, linux-s390@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] partitions/ibm: refactor deprecated strncpy
Message-ID: <20230824090222.10112-B-hca@linux.ibm.com>
References: <20230823-strncpy-block-partitions-cmdline-ibm-v2-1-40c77f7182fc@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823-strncpy-block-partitions-cmdline-ibm-v2-1-40c77f7182fc@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IRdlo-mLY59h8tOrlT9IzrEhNwurc7Ns
X-Proofpoint-ORIG-GUID: J3I6_x2GjPwypkI5AuWoQ6VdhlLACqUK
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:24:22PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated [1] and we should favor different interfaces.
> 
> A suitable replacement is `strtomem_pad` as it is a more robust and less
> ambiguous interface. In this case, the destination buffer is not
> necessarily NUL-terminated as Heiko points out [2]. Using `strtomem_pad`
> over strncpy means it is now more obvious what is expected of the
> destination buffer: 1) Not necessarily NUL-terminated and 2) padded with
> NUL-bytes
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://lore.kernel.org/all/20230823134936.14378-E-hca@linux.ibm.com/ [2]
> Link: https://github.com/KSPP/linux/issues/90
> Suggested-by: Kees Cook <keescook@chromium.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - prefer `strtomem_pad` over `strscpy` (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com
> ---
>  block/partitions/ibm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
> index 403756dbd50d..56c076c5523d 100644
> --- a/block/partitions/ibm.c
> +++ b/block/partitions/ibm.c
> @@ -111,11 +111,11 @@ static int find_label(struct parsed_partitions *state,
>  		    !strcmp(temp, "LNX1") ||
>  		    !strcmp(temp, "CMS1")) {
>  			if (!strcmp(temp, "VOL1")) {
> -				strncpy(type, label->vol.vollbl, 4);
> -				strncpy(name, label->vol.volid, 6);
> +				strtomem_pad(type, label->vol.vollbl, 4);
> +				strtomem_pad(name, label->vol.volid, 6);
>  			} else {
> -				strncpy(type, label->lnx.vollbl, 4);
> -				strncpy(name, label->lnx.volid, 6);
> +				strtomem_pad(type, label->lnx.vollbl, 4);
> +				strtomem_pad(name, label->lnx.volid, 6);
>  			}
>  			EBCASC(type, 4);
>  			EBCASC(name, 6);

This won't compile if find_label() is not inlined due the BUILD_BUG_ON()
within strtomem_pad(). However instead of sending new versions, I think it
would be better to ask Stefan and Jan to have a look at this. I think there
is room for improvement with the string handling besides getting rid of
strncpy().

And they know best the semantics of the (non-)strings.
