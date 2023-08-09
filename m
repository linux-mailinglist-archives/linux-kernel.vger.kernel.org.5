Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7874776794
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjHISoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHISof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:44:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140CFE64
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:44:35 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379INVbF029618;
        Wed, 9 Aug 2023 18:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=dieaoOskNFaiI/TYGiGVaDrPUNaqTTpFU1k33ZzJS2Y=;
 b=evMnjyOHtpb9Ziss3wzZj826D5FAyIHKB9Q6gGA3wqUeImiVTUJt0zhCKdhV2e77JQpy
 2Wm0+OQqL1c0nfoVVipFBwV/l29UsS+73ILX4nk+LvCeKE8p1lIgcWB0RCCpuGSMVDO8
 7pWUJQQonUGQ0Azd+dW+l8rW01hOK57IXpYCcGhsxetW7c7s8ypOYhQoux4M4zl8IYTB
 sjp+5KEiyF39vFBKmsx8FEH342GSxg11brQ889IRoPneOWK06BZlVtjLsxXWE3nfgSER
 QxBYz3owGmV2OqbXz57zvKvY43xL19k4YB9UtoM2mx1bQZw2ma2+6Cw+r7r37x5P1pn/ gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scg1d8gkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:44:20 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 379IiJDd010152;
        Wed, 9 Aug 2023 18:44:19 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scg1d8gk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:44:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379GfoBm006646;
        Wed, 9 Aug 2023 18:44:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa0rtb6a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:44:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379IiGr341484878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 18:44:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC4BD2004B;
        Wed,  9 Aug 2023 18:44:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0F8B20043;
        Wed,  9 Aug 2023 18:44:14 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com (unknown [9.171.6.106])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  9 Aug 2023 18:44:14 +0000 (GMT)
Date:   Thu, 10 Aug 2023 00:14:04 +0530
From:   Vishal Chourasia <vishalc@linux.ibm.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de
Subject: Re: [RFC PATCH] sched/fair: Skip idle CPU search on busy system
Message-ID: <ZNPedInw6Cgh++Xa@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
References: <20230726093612.1882644-1-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726093612.1882644-1-sshegde@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QxmyEysApdAej7ZgAm8bAZSj5PKxsqkX
X-Proofpoint-GUID: Zeja_yLdYfJelt5ybvxXQziA2L7XpAwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_16,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 spamscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090162
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 03:06:12PM +0530, Shrikanth Hegde wrote:
> When the system is fully busy, there will not be any idle CPU's.
> In that case, load_balance will be called mainly with CPU_NOT_IDLE
> type. In should_we_balance its currently checking for an idle CPU if
> one exist. When system is 100% busy, there will not be an idle CPU and
> these idle_cpu checks can be skipped. This would avoid fetching those rq
> structures.
> 
> This is a minor optimization for a specific case of 100% utilization.
> 
> .....
> Coming to the current implementation. It is a very basic approach to the
> issue. It may not be the best/perfect way to this.  It works only in
> case of CONFIG_NO_HZ_COMMON. nohz.nr_cpus is a global info available which
> tracks idle CPU's. AFAIU there isn't any other. If there is such info, we
> can use that instead. nohz.nr_cpus is atomic, which might be costly too.
> 
> Alternative way would be to add a new attribute to sched_domain and update
> it in cpu idle entry/exit path per CPU. Advantage is, check can be per
> env->sd instead of global. Slightly complicated, but maybe better. there
> could other advantage at wake up to limit the scan etc.
> 
> Your feedback would really help. Does this optimization makes sense?
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..903d59b5290c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10713,6 +10713,12 @@ static int should_we_balance(struct lb_env *env)
>  		return 1;
>  	}
> 
> +#ifdef CONFIG_NO_HZ_COMMON
> +	/* If the system is fully busy, its better to skip the idle checks */
> +	if (env->idle == CPU_NOT_IDLE && atomic_read(&nohz.nr_cpus) == 0)
> +		return group_balance_cpu(sg) == env->dst_cpu;
> +#endif
> +
>  	/* Try to find first idle CPU */
>  	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
>  		if (!idle_cpu(cpu))
> --
> 2.31.1
> 
Tested this patchset on top of v6.4

5 Runs of stress-ng (100% load) on a system with 16CPUs spawning 23 threads for
60 minutes.

stress-ng: 16CPUs, 23threads, 60mins

- 6.4.0

| completion time(sec) |      user |        sys |
|----------------------+-----------+------------|
|              3600.05 |  57582.44 |       0.70 |
|              3600.10 |  57597.07 |       0.68 |
|              3600.05 |  57596.65 |       0.47 |
|              3600.04 |  57596.36 |       0.71 |
|              3600.06 |  57595.32 |       0.42 |
|              3600.06 | 57593.568 |      0.596 | average
|          0.046904158 | 12.508392 | 0.27878307 | stddev

- 6.4.0+ (with patch)

| completion time(sec) |      user |         sys |
|----------------------+-----------+-------------|
|              3600.04 |  57596.58 |        0.50 |
|              3600.04 |  57595.19 |        0.48 |
|              3600.05 |  57597.39 |        0.49 |
|              3600.04 |  57596.64 |        0.53 |
|              3600.04 |  57595.94 |        0.43 |
|             3600.042 | 57596.348 |       0.486 | average
|         0.0089442719 | 1.6529610 | 0.072938330 | stddev

The average system time is slightly lower in the patched version (0.486 seconds)
compared to the 6.4.0 version (0.596 seconds). 
The standard deviation for system time is also lower in the patched version
(0.0729 seconds) than in the 6.4.0 version (0.2788 seconds), suggesting more
consistent system time results with the patch.

vishal.c
