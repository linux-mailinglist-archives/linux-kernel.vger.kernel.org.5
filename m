Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEB17859BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbjHWNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjHWNts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:49:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F729CEC;
        Wed, 23 Aug 2023 06:49:46 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NDkPNM000992;
        Wed, 23 Aug 2023 13:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=BvsJqRxjROcrJONT4v827/N/n+GC3nRM2LNlaPqw7po=;
 b=oXrAJkBwIchgMIJfd8CLD3kVBZCb8OpJniicgdBplqNmxc4NxWLyqB8JmGN1oRh7V1JH
 ajokCe7f3KVNIEalrltiv2FZR81aPbdE91BMFuKqZbnHcZsaKsouKeVxtHVspN6T3kNF
 lFa5fUJH3BBZ7TKGp80WD1pIbcCmI6FU2SzbMFuMmLUWO+r3bsZAPJqcH9Q9BfeQsnu5
 9T9NlwU0qCD8cOrOE5zrbYau7nDoZosNqM94kGb9w10444nDwLXOcGJLT94Gkk3qrQ+O
 kbDNpVRx5eg15vBfqE/LCPDJTiDDTIoiHuyV/ARwQD6ItcNOYJpOWJrH5WlZxJgDNXeW wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snk0xrg79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 13:49:42 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NDaO9i029238;
        Wed, 23 Aug 2023 13:49:42 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snk0xrg6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 13:49:42 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37NCCJwn020117;
        Wed, 23 Aug 2023 13:49:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn22aeq91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 13:49:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37NDncRD44630524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 13:49:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BFDF2004D;
        Wed, 23 Aug 2023 13:49:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CC0E20043;
        Wed, 23 Aug 2023 13:49:37 +0000 (GMT)
Received: from osiris (unknown [9.171.11.14])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Aug 2023 13:49:37 +0000 (GMT)
Date:   Wed, 23 Aug 2023 15:49:36 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Justin Stitt <justinstitt@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-s390@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] partitions/ibm: refactor deprecated strncpy
Message-ID: <20230823134936.14378-E-hca@linux.ibm.com>
References: <20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UB7biBxPmFfUReZBIw8MNumAiqIFpVrZ
X-Proofpoint-GUID: 252SuzsGcBtdvErTIcgeQdrJWOCSnR5Y
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_08,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:59:26PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  block/partitions/ibm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
> index 403756dbd50d..e5893cf71b57 100644
> --- a/block/partitions/ibm.c
> +++ b/block/partitions/ibm.c
> @@ -111,11 +111,11 @@ static int find_label(struct parsed_partitions *state,
>  		    !strcmp(temp, "LNX1") ||
>  		    !strcmp(temp, "CMS1")) {
>  			if (!strcmp(temp, "VOL1")) {
> -				strncpy(type, label->vol.vollbl, 4);
> -				strncpy(name, label->vol.volid, 6);
> +				strscpy(type, label->vol.vollbl, 4);
> +				strscpy(name, label->vol.volid, 6);
>  			} else {
> -				strncpy(type, label->lnx.vollbl, 4);
> -				strncpy(name, label->lnx.volid, 6);
> +				strscpy(type, label->lnx.vollbl, 4);
> +				strscpy(name, label->lnx.volid, 6);
>  			}
>  			EBCASC(type, 4);
>  			EBCASC(name, 6);

I'm quite sure this is not correct, since both type and name are not
necessarily NUL-terminated, and this code operates on purpose on such
strings.

Since currently Stefan and Jan are both not available, I added Peter
Oberparleiter to Cc who hopefully knows better than me.
