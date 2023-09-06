Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234ED793B82
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbjIFLgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbjIFLgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:36:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B2B1733
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:36:33 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386BRd6i008692;
        Wed, 6 Sep 2023 11:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8BDsM+mzKGJApuKokUWJXKkb2ugTNcQ2tvnixnI0/54=;
 b=F6gOzGi/c9MqieOBM6kSfGGUH9L+QYkCHEZTUkh+HbXBKvoLmjuwcAXzqyOauuuQeVzN
 xArZ/NOExpQyt6qHquPWTpwe/dJznlfADWKAb75qM8dtV6cVlamoIVY3lzXOKf0PUjbR
 Iw++IRMBx6k5FM8g4/Uc4mFkdrOCLQ5dU3Zq3PJDq0uk+p326ZfmJ8iXRuuLFuiAOIXe
 COQinqathyWHPVjoOp61Xv1JZ9A/A0JhuYQLuYyzxj6s63pGFYZ50jeblman1Hk6luWZ
 mfU2WxXsAO6L1wbkmQxIEmlUGSLaDvWpnkx5TD2d5EixojmfL9MQtnRcvkPPVdodGtYt mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxrjj0fxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 11:36:09 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 386BST4j011719;
        Wed, 6 Sep 2023 11:35:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxrjj0e26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 11:35:42 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 386BUSWK006611;
        Wed, 6 Sep 2023 11:35:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvkj91u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 11:35:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 386BZJ8Y1770034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Sep 2023 11:35:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DF9F5805D;
        Wed,  6 Sep 2023 11:35:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1F9258052;
        Wed,  6 Sep 2023 11:35:13 +0000 (GMT)
Received: from [9.171.19.125] (unknown [9.171.19.125])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  6 Sep 2023 11:35:13 +0000 (GMT)
Message-ID: <d2c945d6-c4f0-a096-0623-731b11484f51@linux.vnet.ibm.com>
Date:   Wed, 6 Sep 2023 17:05:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        peterz@infradead.org, mingo@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com
References: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
 <b81e3d8f-88e3-e7b5-0dbc-78268193db7e@arm.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <b81e3d8f-88e3-e7b5-0dbc-78268193db7e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hKhJQc3FfjLYZwYs8z5jc0p6mOS6xG4g
X-Proofpoint-GUID: n4bsvKChDnPkfK3oR5GLxbDe5gKDSSWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309060098
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/23 7:33 PM, Pierre Gondois wrote:
> Hello Shrikanth,
> I tried the patch (on a platform using the cppc_cpufreq driver). The
> platform
> normally has EAS enabled, but the patch removed the sched_energy_aware
> sysctl.
> It seemed the following happened (in the below order):
> 
> 1. sched_energy_aware_sysctl_init()
> Doesn't set sysctl_sched_energy_aware as cpufreq_freq_invariance isn't set
> and arch_scale_freq_invariant() returns false
> 
> 2. cpufreq_register_driver()
> Sets cpufreq_freq_invariance during cpufreq initialization
> sched_energy_set()
> 
> 3. sched_energy_set()
> Is called with has_eas=0 since build_perf_domains() doesn't see the
> platform
> as EAS compatible. Indeed sysctl_sched_energy_aware=0.
> So with sysctl_sched_energy_aware=0 and has_eas=0, sched_energy_aware
> sysctl
> is not enabled even though EAS should be possible.
> 
> 
> On 9/1/23 08:52, Shrikanth Hegde wrote:
>> Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
>> some of the architectures. IIUC its meant to either force rebuild the
>> perf domains or cleanup the perf domains by echoing 1 or 0 respectively.
> 
> There is a definition of the sysctl at:
> Documentation/admin-guide/sysctl/kernel.rst::sched_energy_aware
[...]
>>
>>
>> +static unsigned int sysctl_sched_energy_aware;
>> +static struct ctl_table_header *sysctl_eas_header;
> 
> The variables around the presence/absence of EAS are:
> - sched_energy_present:
> EAS is up and running
> 
> - sysctl_sched_energy_aware:
> The user wants to use EAS (or not). Doesn't mean EAS can run on the
> platform.
> 
> - sched_energy_set/partition_sched_domains_locked's "has_eas":
> Local variable. Represent whether EAS can run on the platform.
> 
> IMO it would be simpler to (un)register sched_energy_aware sysctl
> in partition_sched_domains_locked(), based on the value of "has_eas".
> This would allow to let all the logic as it is right now, inside
> build_perf_domains(), and then advertise sched_energy_aware sysctl
> if EAS can run on the platform.
> sched_energy_aware_sysctl_init() would be deleted then.
> 
> 
yes. that is true. and there is no variable which holds the info if the system
is capable of EAS.

Retrospecting, the reason for starting this patch series was this,
sysctl_sched_energy_aware didnt make sense on power10 platform since it
has SMT and symmetric CPU capacities.  with current code writing 1 to
it cause rebuild of sched domains but EAS wouldn't be possible.


Possible Approaches: 

1. 
Make this sysctl write as NOP if the platform doesn't has EAS capabilities at
the moment.  Do those checks in sched_energy_aware_handler before handling  the
change in value. Return EINVAL.  And Update sysctl description that on such
platforms value change is NOP. Relatively simpler change.

2. 
Current patch approach, remove the sysctl completely on non supported
architectures and re-enable it if the system becomes capable of doing EAS.
With the current patch, instead of using sched_energy_update, use another
variable called sched_energy_change_in_sysctl(maybe different name).  I think
that would handle all the cases. Another variable can be avoided by encoding
the info in sysctl_sched_energy_aware itself in the handler call, since it
takes only 1 or 0 as the value. upper bits are free to use. update the sysctl
as well with this behavior. plus minor cleanup to remove the init of sysctl. 

Suggestions?
