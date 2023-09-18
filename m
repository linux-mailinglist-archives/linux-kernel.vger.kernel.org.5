Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088C07A4772
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241143AbjIRKot convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 06:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241270AbjIRKoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:44:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFD3D9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:44:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rq1WW5kYTz6J7rC;
        Mon, 18 Sep 2023 18:39:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 11:44:21 +0100
Date:   Mon, 18 Sep 2023 11:44:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Drew Fustini <dfustini@baylibre.com>
CC:     Tony Luck <tony.luck@intel.com>, <babu.moger@amd.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: resctrl2 - status
Message-ID: <20230918114420.000058c3@Huawei.com>
In-Reply-To: <ZQSY5P8R5Q+OuvXB@x1>
References: <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
        <ZOkU+d4AsLGSAG+y@agluck-desk3>
        <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
        <ZOlRNTq3lE7VNHjU@agluck-desk3>
        <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
        <ZPjDHN0nvHz9kWFn@agluck-desk3>
        <18f3a209-8dbf-4837-6bcb-a71a1ee1abb3@amd.com>
        <SJ1PR11MB6083849D1AEF44806C4D669AFCEDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
        <09e2894e-eb2b-12a0-c4a2-5000b27bbded@amd.com>
        <ZPuqsupe+BevodqO@agluck-desk3>
        <ZQSY5P8R5Q+OuvXB@x1>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 10:55:58 -0700
Drew Fustini <dfustini@baylibre.com> wrote:

> On Fri, Sep 08, 2023 at 04:13:54PM -0700, Tony Luck wrote:
> > On Fri, Sep 08, 2023 at 04:35:05PM -0500, Moger, Babu wrote:  
> > > Hi Tony,
> > > 
> > > 
> > > On 9/8/2023 1:51 PM, Luck, Tony wrote:  
> > > > > > Can you try this out on an AMD system. I think I covered most of the
> > > > > > existing AMD resctrl features, but I have no machine to test the code
> > > > > > on, so very likely there are bugs in these code paths.
> > > > > > 
> > > > > > I'd like to make any needed changes now, before I start breaking this
> > > > > > into reviewable bite-sized patches to avoid too much churn.  
> > > > > I tried your latest code briefly on my system.  Unfortunately, I could
> > > > > not get it to work on my AMD system.
> > > > > 
> > > > > # git branch -a
> > > > >     next
> > > > > * resctrl2_v65
> > > > > # ]# uname -r
> > > > > 6.5.0+
> > > > > #lsmod |grep rdt
> > > > > rdt_show_ids           12288  0
> > > > > rdt_mbm_local_bytes    12288  0
> > > > > rdt_mbm_total_bytes    12288  0
> > > > > rdt_llc_occupancy      12288  0
> > > > > rdt_l3_cat             16384  0
> > > > > 
> > > > > # lsmod |grep mbe
> > > > > amd_mbec               16384  0
> > > > > 
> > > > > I could not get  rdt_l3_mba
> > > > > 
> > > > > # modprobe rdt_l3_mba
> > > > > modprobe: ERROR: could not insert 'rdt_l3_mba': No such device
> > > > > 
> > > > > I don't see any data for the default group either.
> > > > > 
> > > > > mount  -t resctrl resctrl /sys/fs/resctrl/
> > > > > 
> > > > > cd /sys/fs/resctrl/mon_data/mon_L3_00
> > > > > 
> > > > > cat mbm_summary
> > > > >        n/a      n/a /  
> > > > Babu,
> > > > 
> > > > Thank a bunch for taking this for a quick spin. There's several bits of
> > > > good news there. Several modules automatically loaded as expected.
> > > > Nothing went "OOPS" and crashed the system.
> > > > 
> > > > Here’s the code that the rdt_l3_mba module runs that can cause failure
> > > > to load with "No such device"
> > > > 
> > > >          if (!boot_cpu_has(X86_FEATURE_RDT_A)) {
> > > >                  pr_debug("No RDT allocation support\n");
> > > >                  return -ENODEV;
> > > >          }  
> > > 
> > > Shouldn't this be ?(or similar)
> > > 
> > > if (!rdt_cpu_has(X86_FEATURE_MBA))
> > >                 return false;  
> > 
> > Yes. I should be using X86_FEATURE bits where they are available
> > rather than peeking directly at CPUID register bits.
> >   
> > >   
> > > >          mba_features = cpuid_ebx(0x10);
> > > > 
> > > >          if (!(mba_features & BIT(3))) {
> > > >                  pr_debug("No RDT MBA allocation\n");
> > > >                  return -ENODEV;
> > > >          }
> > > > 
> > > > I assume the first test must have succeeded (same code in rdt_l3_cat, and
> > > > that loaded OK). So must be the second. How does AMD enumerate MBA
> > > > support?
> > > > 
> > > > Less obvious what is the root cause of the mbm_summary file to fail to
> > > > show any data. rdt_mbm_local_bytes  and rdt_mbm_total_bytes  modules
> > > > loaded OK. So I'm looking for the right CPUID bits to detect memory bandwidth
> > > > monitoring.  
> > > 
> > > I am still not sure if resctrl2 will address all the current gaps in
> > > resctrl1. We should probably list all issues on the table before we go that
> > > route.  
> > 
> > Indeed yes! I don't want to have to do resctrl3 in a few years to
> > cover gaps that could have been addressed in resctrl2.
> > 
> > However, fixing resctrl gaps is only one of the motivations for
> > the rewrite. The bigger one is making life easier for all the
> > architectures sharing the common code to do what they need to
> > for their own quirks & differences without cluttering the
> > common code base, or worrying "did my change just break something
> > for another CPU architecture".
> >   
> > > One of the main issue for AMD is coupling of LLC domains.
> > > 
> > > For example, AMD hardware supports 16 CLOSids per LLC domain. But Linux
> > > design assumes that there are globally 16 total CLOSIDs for the whole
> > > systems. We can only create 16 CLOSID now irrespective of how many domains
> > > are there.
> > > 
> > > In reality, we should be able to create "16 x number of LLC domains" CLOSIDS
> > > in the systems.  This is more evident in AMD. But, same problem applies to
> > > Intel with multiple sockets.  
> > 
> > I think this can be somewhat achieved already with a combination of
> > resctrl and cpusets (or some other way to set CPU affinity for tasks
> > to only run on CPUs within a specific domain (or set of domains).
> > That's why the schemata file allows setting different CBM masks
> > per domain.
> > 
> > Can you explain how you would use 64 domains on a system with 4 domains
> > and 16 CLOSID per domain?
> >   
> > > My 02 cents. Hope to discuss more in our upcoming meeting.  
> > Agreed. This will be faster when we can talk instead of type :-)  
> 
> Is it a meeting that other interested developers can join?
> 
> This reminds me that Linux Plumbers Conference [1] is in November and
> I think resctrl2 could be a good topic. The CFP is still open for Birds
> of a Feather (BoF) proposals [2]. These are free-form get-togethers for
> people wishing to discuss a particular topic, and I have had success
> hosting them in the past for topics like pinctrl and gpio.
> 
> Anyone planning to attend Plumbers?
> 
> I'll be going in person but the virtual option works really well in my
> experience. I had developers and maintainers attending virtually
> participate in my BoF sessions and I felt it was very productive.

FWIW I'm keen and should be there in person.  However, I'm not on the must
be available list for this one ;)   Agree that hybrid worked fine for BoF last
year.

Jonathan


> 
> thanks,
> drew
> 
> [1] https://lpc.events/
> [2] https://lpc.events/event/17/abstracts/
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

