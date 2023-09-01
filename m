Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5178FE1A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349698AbjIANLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240420AbjIANLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:11:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0851410E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:11:03 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381D6nE0029386;
        Fri, 1 Sep 2023 13:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fEr2JRFigSBDdZRf/scxMZloezJT8p/88vec6YYaeiE=;
 b=W44w3q1NqZPlF38faJy/bJOuXMHFEgfhnRisZWJYbBuQ4ozUVcnHSkDFMow0jvZCB5mj
 r+PjxvfeC9eAAKNtISiutM+oyVWdZYAXI3bPXSFnGEcMlJcVN7W0t+JQE85NmI9bfrPL
 H3xg12+wqvWSylVbMAKKF5XW1aQGKVlZh4JJEcek8y5tzXw/pmWFKg1uDgi003GXelqo
 tLsc8z0g7OX6dSuJFx2SOGmZfOJbCoaaZbltRaLAPNYaCCTyjQZNDbpcaT6yvdDVHeCA
 S0DC16A+Hh7JOqjUjNuwYJZo1rQC0nPEfdTik2xwhjpkLTiKr7eIpN7XoH+FGj/9WegI Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sufg0t1xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 13:10:47 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381D6tEu030380;
        Fri, 1 Sep 2023 13:10:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sufg0syvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 13:10:00 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 381AR6H4009907;
        Fri, 1 Sep 2023 13:08:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7m4q6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 13:08:24 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 381D8Nno328346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Sep 2023 13:08:24 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDBC758056;
        Fri,  1 Sep 2023 13:08:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAAF058067;
        Fri,  1 Sep 2023 13:08:19 +0000 (GMT)
Received: from [9.171.49.185] (unknown [9.171.49.185])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  1 Sep 2023 13:08:19 +0000 (GMT)
Message-ID: <5401cd08-c7fc-86ac-23df-6e6a59ef84cf@linux.vnet.ibm.com>
Date:   Fri, 1 Sep 2023 18:38:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org
References: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
 <ZPGzxEVZhpyZuTvj@chenyu5-mobl2>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <ZPGzxEVZhpyZuTvj@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l6ZHnl9xeB068akUCCjHYSerRNmeE4Xr
X-Proofpoint-GUID: rKPy93UR1UIa4gWYMX8kI4Cje6KjtjiD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010122
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/23 3:19 PM, Chen Yu wrote:
> Hi Shrikanth,
>

Hi Chen, Thanks for the review.
 
> On 2023-09-01 at 12:22:49 +0530, Shrikanth Hegde wrote:
>> Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
>> some of the architectures. IIUC its meant to either force rebuild the
>> perf domains or cleanup the perf domains by echoing 1 or 0 respectively.
>>
>> perf domains are not built when there is SMT, or when there is no
>> Asymmetric CPU topologies or when there is no frequency invariance.
>> Since such cases EAS is not set and perf domains are not built. By
>> changing the values of sysctl_sched_energy_aware, its not possible to
>> force build the perf domains. Hence remove this sysctl on such platforms
>> that dont support it. Some of the settings can be changed later
>> such as smt_active by offlining the CPU's, In those cases if
>> build_perf_domains returns true, re-enable the sysctl.
>>
>> Anytime, when sysctl_sched_energy_aware is changed sched_energy_update
>> is set when building the perf domains. Making use of that to find out if
>> the change is happening by sysctl or dynamic system change.
>>
>> Taking different cases:
>> Case1. system while booting has EAS capability, sysctl will be set 1. Hence
>> perf domains will be built if needed. On changing the sysctl to 0, since
>> sched_energy_update is true, perf domains would be freed and sysctl will
>> not be removed. later sysctl is changed to 1, enabling the perf domains
>> rebuild again. Since sysctl is already there, it will skip register.
>>
>> Case2. System while booting doesn't have EAS Capability. Later after system
>> change it becomes capable of EAS. sched_energy_update is false. Though
>> sysctl is 0, will go ahead and try to enable eas. This is the current
>> behaviour. if has_eas  is true, then sysctl will be registered. After
>> that any sysctl change is same as Case1.
>>
> 
> I think this change makes sense. Just one question for case 2,
> sched_energy_update is not strictly tied with sysctl change, right?
> sched_energy_update is true in rebuild_sched_domains_energy().
> rebuild_sched_domains_energy() will not only be invoked by sysctl
> path via sched_energy_aware_handler(), but also by other path, such
> as update_scale_freq_invariant(). If the system boots with EAS capability
> disabled, then it becomes EAS capable due to the frequency invariant
> readiness(cpufreq policy change?), then
> cpufreq_notifier(CPUFREQ_CREATE_POLICY) -> init_amu_fie_callback() ->
> amu_fie_setup() -> opology_set_scale_freq_source() -> 
> update_scale_freq_invariant(true) -> rebuild_sched_domains_energy()
> Since sched_energy_update is true, the rebuild of perf domain will be skipped(but
> actually we want to create it) Please correct me if I miss something.
>

Ah, More cases!

You are right. let me see what can be done.  
maybe specific variable be used for sysctl change? it already quite a few variables there. 
Will think if this can be simplified somehow. 




