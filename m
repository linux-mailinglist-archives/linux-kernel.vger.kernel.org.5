Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6FF7D6864
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343542AbjJYKZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjJYKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:25:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A8510A;
        Wed, 25 Oct 2023 03:25:12 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PAD2o6009968;
        Wed, 25 Oct 2023 10:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=dkngY/uGd72QquiKqtcqhmUawOZGFn6Q2/mrRwMoXOI=;
 b=feNU6oA06+oxLvt8OVk4isxTTZrHa4ZLtcGHzCluIYfD2LYQGj11z1PPJ/ljpz9dq8RY
 g99TvP39niEGdQ2QbwfulZoz2oq/091oT228dWS6WfuEahciJrLt5aRlr94Kj9nVARtF
 1S/Nbidw/fVZkySnLqO0TQ0KtxDI23++PI696po3k1+8HyUkKbW5GRDCvz7J35wn/H8w
 fpFC2fevnhqGobPUvkg+xu6ExGmAZumOZ8zitZzMY3Tpyj/e2yzbiSKJLdetbEbjMKxM
 8NZZAVgt9XNRvF3xrAphwhScHyrQzJfAdHwzGMOu0hKOPi1IFY8Dm3sQ5B4wTfV0BrIW 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty12hgfbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 10:25:11 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PADHxR011526;
        Wed, 25 Oct 2023 10:25:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty12hgfb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 10:25:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39P9jwmr023804;
        Wed, 25 Oct 2023 10:25:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvryt65fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 10:25:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39PAP6N221627458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 10:25:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 609352006C;
        Wed, 25 Oct 2023 10:25:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C053A2006A;
        Wed, 25 Oct 2023 10:25:05 +0000 (GMT)
Received: from localhost (unknown [9.171.93.15])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Oct 2023 10:25:05 +0000 (GMT)
Date:   Wed, 25 Oct 2023 12:25:04 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/cio: replace deprecated strncpy with strscpy
Message-ID: <your-ad-here.call-01698229504-ext-3663@work.hours>
References: <20231023-strncpy-drivers-s390-cio-chsc-c-v1-1-8b76a7b83260@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-s390-cio-chsc-c-v1-1-8b76a7b83260@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3SBpjJkcNnbczjvgkGjTSrryDl5jq5VM
X-Proofpoint-ORIG-GUID: 91nL1D4q-fQhbSJX2D92Akiq1Y2gfbsz
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=823
 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 07:24:38PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both `params` and `id` to be NUL-terminated based on their
> usage with format strings:
> 
> 	format_node_data(iuparams, iunodeid, &lir->incident_node);
> 	format_node_data(auparams, aunodeid, &lir->attached_node);
> 
> 	switch (lir->iq.class) {
> 	case LIR_IQ_CLASS_DEGRADED:
> 		pr_warn("Link degraded: RS=%02x RSID=%04x IC=%02x "
> 			"IUPARAMS=%s IUNODEID=%s AUPARAMS=%s AUNODEID=%s\n",
> 			sei_area->rs, sei_area->rsid, lir->ic, iuparams,
> 			iunodeid, auparams, aunodeid);
> 
> NUL-padding is not required as both `params` and `id` have been memset
> to 0:
> 
> 	memset(params, 0, PARAMS_LEN);
> 	memset(id, 0, NODEID_LEN);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Note that there's no overread bugs in the current implementation as the
> string literal "n/a" has a size much smaller than PARAMS_LEN or
> NODEID_LEN. Nonetheless, let's favor strscpy().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/s390/cio/chsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thank you!
