Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4607718C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjHGDXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjHGDXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:23:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B01BA6;
        Sun,  6 Aug 2023 20:22:50 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3771YsHu009663;
        Mon, 7 Aug 2023 03:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=WkbyyRf5bgNL3icM/FNlLcOLU/1AZiUj/Yh9Je0Hr5s=;
 b=PVGnVG1QIJHGQLkEzkQcg5s/NAp6+ZCLZ+nW3si97c/by2yFmioFZvUf3/wkgGB8O3s1
 2ecv/gGHzKY8VELfuMfBVntSUTil2YANao9YBQzPB8JRRywR+OoKZjgG/VB0vZvWr9Eq
 g9yCP8amd4b/JB21ycXwq8+9Iheg/GzRI+AsXTX4ZbAvS1xUBxU+K4jx0j/CU7ApMqpV
 fGNZmAQgehMPAhEUhTNp3M8Xhhmwn6SIVjTMPGLCPfLxlqj5UunRQTUQcqkCQ1U7/fyU
 PZnWMKTxZvCCnQW5CyU3NJd+v6wZfsPA63KL9NRKI8AWYHLO3oNTAJcXio+KsRMk5fRG Iw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9drrjg4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 03:22:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3773MLKb004476
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 03:22:21 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 6 Aug 2023 20:22:14 -0700
Date:   Mon, 7 Aug 2023 08:52:11 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     David Dai <davidai@google.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Oliver Upton" <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, <kernel-team@android.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <29bae535-6292-400e-813d-063498adbfce@quicinc.com>
References: <20230731174613.4133167-1-davidai@google.com>
 <20230731174613.4133167-3-davidai@google.com>
 <80f47262-9354-472f-8122-5ae262c0a46d@quicinc.com>
 <CABN1KCKUt3GN=LqF9AK3Dc+4x98Asj-wpW4UNYsfjRz4Di8N5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABN1KCKUt3GN=LqF9AK3Dc+4x98Asj-wpW4UNYsfjRz4Di8N5Q@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hNzdvwkD-05os6gB5mznBPDZEGyqdzx2
X-Proofpoint-GUID: hNzdvwkD-05os6gB5mznBPDZEGyqdzx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-06_24,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:46:11PM -0700, David Dai wrote:
> Hi Pavan,
> 
> Thanks for reviewing!
> 
> On Wed, Aug 2, 2023 at 9:18 PM Pavan Kondeti <quic_pkondeti@quicinc.com> wrote:
> >
> > On Mon, Jul 31, 2023 at 10:46:09AM -0700, David Dai wrote:
> > > Introduce a virtualized cpufreq driver for guest kernels to improve
> > > performance and power of workloads within VMs.
> > >
> > > This driver does two main things:
> > >
> > > 1. Sends the frequency of vCPUs as a hint to the host. The host uses the
> > > hint to schedule the vCPU threads and decide physical CPU frequency.
> > >
> > > 2. If a VM does not support a virtualized FIE(like AMUs), it queries the
> > > host CPU frequency by reading a MMIO region of a virtual cpufreq device
> > > to update the guest's frequency scaling factor periodically. This enables
> > > accurate Per-Entity Load Tracking for tasks running in the guest.
> > >
> > > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: David Dai <davidai@google.com>
> >
> > [...]
> >
> > > +static void virt_scale_freq_tick(void)
> > > +{
> > > +     struct cpufreq_policy *policy = cpufreq_cpu_get(smp_processor_id());
> > > +     struct virt_cpufreq_drv_data *data = policy->driver_data;
> > > +     u32 max_freq = (u32)policy->cpuinfo.max_freq;
> > > +     u64 cur_freq;
> > > +     u64 scale;
> > > +
> > > +     cpufreq_cpu_put(policy);
> > > +
> > > +     cur_freq = (u64)data->ops->get_freq(policy);
> > > +     cur_freq <<= SCHED_CAPACITY_SHIFT;
> > > +     scale = div_u64(cur_freq, max_freq);
> > > +
> > > +     this_cpu_write(arch_freq_scale, (unsigned long)scale);
> > > +}
> > > +
> >
> > We expect the host to provide the frequency in kHz, can you please add a
> > comment about it. It is not very obvious when you look at the
> > REG_CUR_FREQ_OFFSET register name.
> 
> I’ll include a KHZ in the offset names.
> 

Sure, that would help. Also, can you limit the scale to
SCHED_CAPACITY_SCALE? It may be possible that host may be running at a
higher frequency than max_freq advertised on this guest.

> >
> > > +
> > > +static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy *policy,
> > > +             unsigned int target_freq)
> > > +{
> > > +     virt_cpufreq_set_perf(policy);
> > > +     return target_freq;
> > > +}
> > > +
> > > +static int virt_cpufreq_target_index(struct cpufreq_policy *policy,
> > > +             unsigned int index)
> > > +{
> > > +     return virt_cpufreq_set_perf(policy);
> > > +}
> > > +
> > > +static int virt_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > > +{
> > > +     struct virt_cpufreq_drv_data *drv_data = cpufreq_get_driver_data();
> > > +     struct cpufreq_frequency_table *table;
> > > +     struct device *cpu_dev;
> > > +     int ret;
> > > +
> > > +     cpu_dev = get_cpu_device(policy->cpu);
> > > +     if (!cpu_dev)
> > > +             return -ENODEV;
> > > +
> > > +     ret = dev_pm_opp_of_add_table(cpu_dev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = dev_pm_opp_get_opp_count(cpu_dev);
> > > +     if (ret <= 0) {
> > > +             dev_err(cpu_dev, "OPP table can't be empty\n");
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &table);
> > > +     if (ret) {
> > > +             dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     policy->freq_table = table;
> > > +     policy->dvfs_possible_from_any_cpu = false;
> > > +     policy->fast_switch_possible = true;
> > > +     policy->driver_data = drv_data;
> > > +
> > > +     /*
> > > +      * Only takes effect if another FIE source such as AMUs
> > > +      * have not been registered.
> > > +      */
> > > +     topology_set_scale_freq_source(&virt_sfd, policy->cpus);
> > > +
> > > +     return 0;
> > > +
> > > +}
> > > +
> >
> > Do we need to register as FIE source even with the below commit? By
> > registering as a source, we are not supplying any accurate metric. We
> > still fallback on the same source that cpufreq implements it.
> 
> The arch_set_freq_scale() done at cpufreq driver’s frequency updates
> at cpufreq_freq_transition_end() and cpufreq_driver_fast_switch() only
> represent the guest’s frequency request. However, this does not
> accurately represent the physical CPU’s frequency that the vCPU is
> running on. E.g. There may be other processes sharing the same
> physical CPU that results in a much higher CPU frequency than what’s
> requested by the vCPU.
> 

understood that policy->cur may not reflect the actual frequency. Is this
something needs to be advertised to cpufreq core so that it query the
underlying cpufreq driver and use it for frequency scale updates. This
also gives userspace to read the actual frequency when read from sysfs.

In fact, cpufreq_driver_fast_switch() comment says that
cpufreq_driver::fast_switch() should return the *actual* frequency and
the same is used to update frequency scale updates. I understand that it
depends on other things like if host defer the frequency switch, the
value read from REG_CUR_FREQ_OFFSET may reflect the old value..

May be a comment in code would help.

Thanks,
Pavan
