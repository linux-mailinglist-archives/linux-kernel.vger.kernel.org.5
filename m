Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA897D639A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjJYHip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjJYHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:37:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF07B1FCA;
        Wed, 25 Oct 2023 00:35:50 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39P5lajh002210;
        Wed, 25 Oct 2023 07:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zZQJyqYnoH2mzbn59fDX9/iMeNtBFAOOWV3pVH2j/QI=;
 b=nvPQfugpHLczE4gwcBZCU+aIugpqorc4IuAPjtawzOgw1Ad+8Lq2y9zqptO0kb2SgBXr
 l5ypbZ28ewhyT56SjqRpVImCHFfQEUHXd6YjfwhSoiNRqFQVGgbrKtqN3oT30cR5qBxs
 llaQQX9EB3dgiUS/K6yszebzG3g7hoWMFUZSCEOj+pSOX5Rvv02OoH6NJahhRVKPDIS2
 WNrFZr+73SlQKFDqfKMBGuFceqecBINvGUWczZEsUyAgqhQKDbDExwcVmxo24r7NrgHw
 9ozAbQHVALkf3ubA1Ui4VxsEdztEtjTWittRibPChhvr4mR7XK4hHKE4S2gm5AZv9jJU UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txw662spq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 07:35:48 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39P6eM0s004566;
        Wed, 25 Oct 2023 07:35:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txw662sgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 07:35:35 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39P73fEg010290;
        Wed, 25 Oct 2023 07:32:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbyn7rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 07:32:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39P7WluP23003820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 07:32:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C922A20043;
        Wed, 25 Oct 2023 07:32:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4955A20040;
        Wed, 25 Oct 2023 07:32:47 +0000 (GMT)
Received: from [9.171.33.174] (unknown [9.171.33.174])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Oct 2023 07:32:47 +0000 (GMT)
Message-ID: <a528b8ca-dde1-1cd2-19c8-be760e5de14e@linux.ibm.com>
Date:   Wed, 25 Oct 2023 09:32:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] s390/cio: replace deprecated strncpy with strscpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231023-strncpy-drivers-s390-cio-chsc-c-v1-1-8b76a7b83260@google.com>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
In-Reply-To: <20231023-strncpy-drivers-s390-cio-chsc-c-v1-1-8b76a7b83260@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xinD0Af57LbnLx_POYEuKSJBZNjhrwwR
X-Proofpoint-GUID: 4BzELyR0UkvbYAYckLgbrc3_9b-I-vLi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250064
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/23 21:24, Justin Stitt wrote:
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
> Link:https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings  [1]
> Link:https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html  [2]
> Link:https://github.com/KSPP/linux/issues/90
> Cc:linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt<justinstitt@google.com>

LGTM. Thank you.

Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>

I can push this to s390-tree and Heiko/Vasily will upstream it.

---snip---
