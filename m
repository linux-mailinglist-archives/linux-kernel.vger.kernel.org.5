Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B608A7EBD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjKOGfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 01:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjKOGfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:35:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67721D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:35:50 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF67Gll003267;
        Wed, 15 Nov 2023 06:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=ut7fifdv33BYvwHtYbVTvqP5YI7gnOZ6t4YXoSMkfGI=;
 b=J9SaU2JpwMgCY/5dsRzWMbkol7KCRf9wdd7xLUiIWX/YUyBYLofwS0xOcMdAnvBREfra
 lFjbXlcFhKQopKtaGTGuZu91oSx//nhH+fNKjc+nLRKpFH2zpBzG2ACVOV7pzgImfOqA
 HtM3XDz0Fk9gmHEQTRxDV+GyftyhkhSS73f7ZnSdX2WeG+r1WfMoLR5vwhb6PQqKKuy8
 cHCF27UGA65OcdXBaS83rPyS4EZbPhYObCoh3uVjDnlZ/xNMH5GnhPfLlHHgcGn04PQp
 VuiimpweNZCBU0w8qBCq8LLWvlspdXSa0XTfdRQWDaRZF3EO5zQhOImaNRhSvQVOFpYn LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucrej0t1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 06:35:30 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AF67WWO004918;
        Wed, 15 Nov 2023 06:35:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucrej0t16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 06:35:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF4oQ5q026532;
        Wed, 15 Nov 2023 06:35:29 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5k4xr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 06:35:29 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AF6ZSIX16188122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 06:35:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C23B58060;
        Wed, 15 Nov 2023 06:35:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E2015803F;
        Wed, 15 Nov 2023 06:35:24 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.109.250])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Nov 2023 06:35:23 +0000 (GMT)
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
Date:   Wed, 15 Nov 2023 12:05:22 +0530
Message-ID: <87zfzf8qxh.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QAZM2NYRk9by9piyiZQly4B8ZaTZku5C
X-Proofpoint-GUID: XYYMQwFesiGHGZnDMijCfZBK3cm8Xvkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_04,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150048
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
> To achieve this, enable SD_ASYM_PACKING flag at CACHE, MC and DIE level
> when the system is running in shared processor mode and has big cores.
>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
> Changelog:
> v3 -> v4:
> - Dont use splpar_asym_pack with SMT
> - Conflict resolution due to rebase
> 	(DIE changed to PKG)
> v2 -> v3:
> - Handle comments from Michael Ellerman.
> - Rework using existing cpu_has_features static key
> v1->v2: Using Jump label instead of a variable.
>
>  arch/powerpc/kernel/smp.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index ab691c89d787..69a3262024f1 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -993,16 +993,20 @@ static bool shared_caches;
>  /* cpumask of CPUs with asymmetric SMT dependency */
>  static int powerpc_smt_flags(void)
>  {
> -	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
> +	if (!cpu_has_feature(CPU_FTR_ASYM_SMT))
> +		return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
>  
> -	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
> -		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
> -		flags |= SD_ASYM_PACKING;
> -	}
> -	return flags;
> +	return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES | SD_ASYM_PACKING;
>  }
>  #endif
>

Only relevant change there is dropping printk_once(). Rest of the
changes are not needed?

-aneesh
