Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E42075DD66
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 18:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGVQPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 12:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGVQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 12:15:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1E51FDF;
        Sat, 22 Jul 2023 09:15:13 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36MFYMKv008838;
        Sat, 22 Jul 2023 16:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=fcPaZKlUfF97BItefZgfwzcbT/04W5hIBwn0mC+LAys=;
 b=mWxCCjZGIZN64zn0PBaEp98e1FqPn0126n2Ja7ROy3pA4zGThUs7Z9FaOZBt7kapb8zp
 /0JQ7LAc6fkToccJ528nrLehnUFlrp2KUk9322+3+AmX21jYJ8kqLlBY/TfkIdFE/PEg
 yIWmgeTePpoll+hwrVsWHI76Zjj92cfsUHuc6WC/psIwmB6lnVz28pzK8mXf0Xg4zZk+
 sECohJ+JnAA+ZmJwvSVhlowX3yGkqyn/d9BWM1npocyfllJSYtn+pNmb3BDnsbs7Earp
 MFXjp0c8ueuLMQI0CUDynVr0MY+rSHCKxNYvtKpZM2Xpnbh4kvWN5LrFdhUwljmfhI/H fg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s0gdp9gsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 16:15:04 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36MEa3Sj003390;
        Sat, 22 Jul 2023 16:15:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65y819u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 16:15:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36MGEx843146312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 16:14:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F4252004B;
        Sat, 22 Jul 2023 16:14:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E07D72004D;
        Sat, 22 Jul 2023 16:14:58 +0000 (GMT)
Received: from osiris (unknown [9.171.82.123])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 22 Jul 2023 16:14:58 +0000 (GMT)
Date:   Sat, 22 Jul 2023 18:14:57 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2] s390: use obj-y to descend into drivers/s390/
Message-ID: <20230722161457.7417-B-hca@linux.ibm.com>
References: <20230721171358.3612099-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721171358.3612099-1-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AMpnYRmKKivFCMYBjnapAa-u-V0nxNnk
X-Proofpoint-GUID: AMpnYRmKKivFCMYBjnapAa-u-V0nxNnk
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=385
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307220146
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 02:13:58AM +0900, Masahiro Yamada wrote:
> The single build rule does not work with the drivers-y syntax. [1]
> 
> Use the standard obj-y syntax. It moves the objects from drivers/s390/
> to slightly lower address, but fixes the reported issue.
> 
> [1]: https://lore.kernel.org/linux-kbuild/d57ba55f-20a3-b836-783d-b49c8a161b6e@kernel.org/T/#m27f781ab60acadfed8a9e9642f30d5414a5e2df3
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Tested-by: Jiri Slaby <jirislaby@kernel.org>
> ---
> 
> Changes in v2:
>   - rephase the commit log
> 
>  arch/s390/Makefile | 1 -
>  drivers/Makefile   | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)

Applied, thanks!
