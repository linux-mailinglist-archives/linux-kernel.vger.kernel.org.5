Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D227EBCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 06:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjKOFcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 00:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOFcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 00:32:14 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B01BC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 21:32:08 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF5OfXI005999;
        Wed, 15 Nov 2023 05:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=GJ+xyw9eti00D2f4thO4SOwJTmfGeFzimTog69Oh4DE=;
 b=oImSohtO3WpXb+BCViAf1PLYNv/+NGgucymKFS7Z2T55zK9SC+leLdB1+SdXZR2NI1cm
 Rp8irn3nyrqLf6JHruhE/QjSiDofbyTfK90DqjKZwBycuiErBGQDdkvyKC4RMw2DAH2G
 Kk2oecEjlccEQV/pQG6ttVOpZOvCNIsdG63LU2uOY9hpimtb9htof4dBl0YGn/BvnKSZ
 jcNhwtl6GqRFo/KGuzLP2ySASMTw3bDGWlOk2BjX1LyZT42pTrDDked8STr2VmmXZ7K0
 lpvaB89iksRJ7NQACxqAMV07BPS+za5yaolmuHrapq/H03pLhByyIDP6ePJtLcQ9JNz7 xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucqtfr4ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 05:31:33 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AF5P4gA006549;
        Wed, 15 Nov 2023 05:31:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucqtfr4dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 05:31:32 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF4aT2x024387;
        Wed, 15 Nov 2023 05:27:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnd1nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 05:27:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AF5RGZK8979098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 05:27:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D3A658055;
        Wed, 15 Nov 2023 05:27:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 310EE5804B;
        Wed, 15 Nov 2023 05:27:11 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.109.250])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Nov 2023 05:27:10 +0000 (GMT)
X-Mailer: emacs 29.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Rohan McLure <rmclure@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v4 1/5] powerpc/smp: Enable Asym packing for cores on
 shared processor
In-Reply-To: <20231109054938.26589-2-srikar@linux.vnet.ibm.com>
References: <20231109054938.26589-1-srikar@linux.vnet.ibm.com>
 <20231109054938.26589-2-srikar@linux.vnet.ibm.com>
Date:   Wed, 15 Nov 2023 10:57:08 +0530
Message-ID: <87y1ezzivn.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P9S993U8EmsbsdPVPDifF6fIIErNdZdN
X-Proofpoint-ORIG-GUID: 4iz3V3JE1RwOAw2t7jShDz8OuzhJVCYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_03,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 mlxlogscore=865 priorityscore=1501 bulkscore=0
 clxscore=1011 phishscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:

> If there are shared processor LPARs, underlying Hypervisor can have more
> virtual cores to handle than actual physical cores.
>
> Starting with Power 9, a big core (aka SMT8 core) has 2 nearly
> independent thread groups. On a shared processors LPARs, it helps to
> pack threads to lesser number of cores so that the overall system
> performance and utilization improves. PowerVM schedules at a big core
> level. Hence packing to fewer cores helps.
>
> For example: Lets says there are two 8-core Shared LPARs that are
> actually sharing a 8 Core shared physical pool, each running 8 threads
> each. Then Consolidating 8 threads to 4 cores on each LPAR would help
> them to perform better. This is because each of the LPAR will get
> 100% time to run applications and there will no switching required by
> the Hypervisor.
>

Will this patch consolidate things to first 8 threads or just the one
Big core? /me continues to look at other patches and wonder whether 4/5
should come before this? 


>
> To achieve this, enable SD_ASYM_PACKING flag at CACHE, MC and DIE level
> when the system is running in shared processor mode and has big cores.
>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>


-aneesh
