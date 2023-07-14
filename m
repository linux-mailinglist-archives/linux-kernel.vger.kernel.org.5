Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9327535EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbjGNJAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjGNI74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:59:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45027271F;
        Fri, 14 Jul 2023 01:59:35 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E8psNI032166;
        Fri, 14 Jul 2023 08:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=FuK7WoDYFre2EusVTB41G7Abki8Ywsqo2h5RKmMHpdE=;
 b=OcSxFHlfEfzWKE9BPqGwNz88Ab4V1F/EcKPAWJIeuvgrAYlIbePx9x1QWDuNft0jpU6m
 Dm5lPd9kZSsRzvF1sj3pQKdKjPska6Hz8HrgidVI62y8cwwd+2MHk4xH003eM7QBbMqr
 C9NjjP9415hRAV4SbsJDcINlQ7cnj6XcyMFL78Ra6DfippPdX39ayJv6wbBgPpSNUupE
 72V3qUFkFYfLwSdMdyRY3mI9dRb+GwiKBbfqbISxCX58j50iYJ7HyU2ol82Rxw/1g3lp
 /ND/Es60KvNvT5BQB7VyHUACathKiGGNf9JB9Ph8rcweWGpCzH2/6rpjMSXmDbcdDiyM jQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru37pr4ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 08:59:23 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36E4eU13007411;
        Fri, 14 Jul 2023 08:59:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rtpvs1aap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 08:59:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36E8xL3w15794852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 08:59:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0282B20043;
        Fri, 14 Jul 2023 08:59:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99F8A20040;
        Fri, 14 Jul 2023 08:59:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.117.172])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 14 Jul 2023 08:59:19 +0000 (GMT)
Date:   Fri, 14 Jul 2023 14:29:16 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the ext4 tree
Message-ID: <ZLEOZK7tOHNNFNlH@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230714084334.23413801@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714084334.23413801@canb.auug.org.au>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nE83rdT1I6GgCvl278cXUZfzQNc5lgQv
X-Proofpoint-ORIG-GUID: nE83rdT1I6GgCvl278cXUZfzQNc5lgQv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 08:43:34AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   7c79210b15ef ("ext4: fix off by one issue in ext4_mb_choose_next_group_best_avail()")
> 
> Fixes tag
> 
>   Fixes: 331122aa930 ("ext4: Add allocation criteria 1.5 (CR1_5)")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").
Hi Stephen,

Will keep this in mind.

Thank you,
ojaswin
> 
> -- 
> Cheers,
> Stephen Rothwell


