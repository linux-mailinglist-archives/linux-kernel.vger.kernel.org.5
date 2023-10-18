Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0787E7CE61F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjJRSQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjJRSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:16:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBE610F;
        Wed, 18 Oct 2023 11:16:38 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IICYHl018187;
        Wed, 18 Oct 2023 18:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=JXYWDyiW1JWQMSgIR9Wmq9AjhDVUSqBRcb+FAPMPPO0=;
 b=fbSQaHpxJaR5g2fymOhEELchQsyQ2Kl/XD2xMUqsdfjNMDuHI7eqPq2nyCmSaLrHGWxm
 srcYiinznONGnFcMqmkylS4dZrSq/veVSBSlnf9YKi/3WVE3jWt2Iofe2SJmYfw/rgvb
 8qNdkuI01PkJ9HKtm4+TBrSfytP6BNUk20qblMdc5PCI/N0NlN1k6b7/sK5cVQLL3oCW
 c2lq/N6Ry3KdWOZWjLxk5AiXtb5PO4XyyrT6pHdCwM4NbvlwzYamORS6HZrtTSAZr7oh
 5mxZXUzyv0xC6QoTH+cc6dSE/P8ERWR90pChgUmMmRckW41Td/lIHcF/e4184V8bRjg/ 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttmef05j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 18:16:25 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IIDsWn022464;
        Wed, 18 Oct 2023 18:16:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttmef05db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 18:16:24 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IGdfRr012876;
        Wed, 18 Oct 2023 18:16:20 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5pyjyen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 18:16:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IIGJBH14811884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 18:16:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEAE35805D;
        Wed, 18 Oct 2023 18:16:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39ADD58059;
        Wed, 18 Oct 2023 18:16:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 18:16:19 +0000 (GMT)
Message-ID: <3117d99434303b00f5057bfbe4615cf8cd26b72a.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Add __counted_by for struct modsig and use
 struct_size()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Wed, 18 Oct 2023 14:16:18 -0400
In-Reply-To: <ZSRaDcJNARUUWUwS@work>
References: <ZSRaDcJNARUUWUwS@work>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VgXm1I8MYbDieq0_K6zSaJizz07j5t7Q
X-Proofpoint-ORIG-GUID: ZnTnGrQ5qSE-VkGMaOS6SvsrK70Vyy6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_16,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=611 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180149
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-09 at 13:52 -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Also, relocate `hdr->raw_pkcs7_len = sig_len;` so that the __counted_by
> annotation has effect, and flex-array member `raw_pkcs7` can be properly
> bounds-checked at run-time.
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

