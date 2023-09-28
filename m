Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0541F7B1D75
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjI1NOs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjI1NOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:14:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60030F5;
        Thu, 28 Sep 2023 06:14:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RxDR217frz6HJ9N;
        Thu, 28 Sep 2023 21:12:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 28 Sep
 2023 14:14:38 +0100
Date:   Thu, 28 Sep 2023 14:14:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
CC:     "Luck, Tony" <tony.luck@intel.com>, <dave.hansen@linux.intel.com>,
        <jon.grimm@amd.com>, <vilas.sridharan@amd.com>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>,
        David Rientjes <rientjes@google.com>,
        <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <pgonda@google.com>, <duenwen@google.com>,
        <mike.malvestuto@intel.com>, <gthelen@google.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
Message-ID: <20230928141438.00007e0a@Huawei.com>
In-Reply-To: <CACw3F539gZc0FoJLo6VvYSyZmeWZ3Pbec7AzsH+MYUJJNzQbUQ@mail.gmail.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
        <20230915172818.761-3-shiju.jose@huawei.com>
        <CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com>
        <20230922111740.000046d7@huawei.com>
        <CACw3F539gZc0FoJLo6VvYSyZmeWZ3Pbec7AzsH+MYUJJNzQbUQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 22:25:52 -0700
Jiaqi Yan <jiaqiyan@google.com> wrote:

> On Fri, Sep 22, 2023 at 3:20 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 21 Sep 2023 17:07:04 -0700
> > Jiaqi Yan <jiaqiyan@google.com> wrote:
> >  
> > > On Fri, Sep 15, 2023 at 10:29 AM <shiju.jose@huawei.com> wrote:  
> > > >
> > > > From: Shiju Jose <shiju.jose@huawei.com>
> > > >
> > > > Add sysfs documentation entries for the set of attributes those are
> > > > exposed in /sys/class/scrub/ by the scrub driver. These attributes
> > > > support configuring parameters of a scrub device.
> > > >
> > > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > > ---
> > > >  .../ABI/testing/sysfs-class-scrub-configure   | 82 +++++++++++++++++++
> > > >  1 file changed, 82 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Documentation/ABI/testing/sysfs-class-scrub-configure
> > > > new file mode 100644
> > > > index 000000000000..347e2167dc62
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
> > > > @@ -0,0 +1,82 @@
> > > > +What:          /sys/class/scrub/
> > > > +Date:          September 2023
> > > > +KernelVersion: 6.7
> > > > +Contact:       linux-kernel@vger.kernel.org
> > > > +Description:
> > > > +               The scrub/ class subdirectory belongs to the
> > > > +               scrubber subsystem.
> > > > +
> > > > +What:          /sys/class/scrub/scrubX/
> > > > +Date:          September 2023
> > > > +KernelVersion: 6.7
> > > > +Contact:       linux-kernel@vger.kernel.org
> > > > +Description:
> > > > +               The /sys/class/scrub/scrub{0,1,2,3,...} directories  
> > >
> > > This API (sysfs interface) is very specific to the ACPI interface
> > > defined for hardware patrol scrubber. I wonder can we have some
> > > interface that is more generic, for a couple of reasons:  
> >
> > Agreed that it makes sense to define a broad interface.  We have
> > some hardware focused drivers we can't share yet (IP rules until
> > a release date in the near future) where this is a reasonable fit
> > - but indeed there are others such as mapping this to DDR ECS
> > where it isn't a great mapping.
> >
> > I'd love to come up with an interface that has the right blend
> > of generality and flexibility.  That is easiest done before we have
> > any implementation merged.
> >  
> > >
> > > 1. I am not aware of any chip/platform hardware that implemented the
> > > hw ps part defined in ACPI RASF/RAS2 spec. So I am curious what the
> > > RAS experts from different hardware vendors think about this. For
> > > example, Tony and Dave from Intel, Jon and Vilas from AMD. Is there
> > > any hardware platform (if allowed to disclose) that implemented ACPI
> > > RASF/RAS2? If so, will vendors continue to support the control of
> > > patrol scrubber using the ACPI spec? If not (as Tony said in [1], will
> > > the vendor consider starting some future platform?
> > >
> > > If we are unlikely to get the vendor support, creating this ACPI
> > > specific sysfs API (and the driver implementations) in Linux seems to
> > > have limited meaning.  
> >
> > There is a bit of a chicken and egg problem here. Until there is
> > reasonable support in kernel (or it looks like there will be),
> > BIOS teams push back on a requirement to add the tables.
> > I'd encourage no one to bother with RASF - RAS2 is much less
> > ambiguous.  
> 
> Here mainly to re-ping folks from Intel (Tony and Dave)  and AMD (Jon
> and Vilas) for your opinion on RAS2.
> 
> >  
> > >  
> > > > +               correspond to each scrub device.
> > > > +
> > > > +What:          /sys/class/scrub/scrubX/name
> > > > +Date:          September 2023
> > > > +KernelVersion: 6.7
> > > > +Contact:       linux-kernel@vger.kernel.org
> > > > +Description:
> > > > +               (RO) name of the memory scrub device
> > > > +
> > > > +What:          /sys/class/scrub/scrubX/regionY/  
> > >
> > > 2. I believe the concept of "region" here is probably from
> > > PATROL_SCRUB defined in “APCI section 5.2.20.5. Parameter Block". It
> > > is indeed powerful: if a process's physical memory spans over multiple
> > > memory controllers, OS can in theory scrub chunks of the memory
> > > belonging to the process. However, from a previous discussion [1],
> > > "From a h/w perspective it might always be complex". IIUC, the address
> > > translation from physical address to channel address is hard to
> > > achieve, and probably that's one of the tech reasons the patrol scrub
> > > ACPI spec is not in practice implemented?  
> >
> > Next bit is kind of an aside as I mostly agree with your conclusions ;)
> >
> > This obviously depends on your memory interleave. You want to present
> > physical address ranges as single controllable regions - probably
> > most interesting being stuff that maps to NUMA nodes.  The short
> > answer is that any firmware control will end up writing to all the
> > memory controllers involved in a given PA range - firmware can easily
> > establish which those are.
> >
> > A memory controller can support multiple scrub regions
> > which map from a PA range to a particular set of RAM addresses
> > - that's implementation specific. The memory controller is getting
> > the host PA and can carry out appropriate hashing if it wants to.
> > Many scrub solutions won't do this - in which case it's max one
> > region per memory controller (mapped by firmware to one region per
> > interleave set - assuming interleave sets take in whole memory
> > controllers - which they normally do).
> >
> > I would expect existing systems (not design with this differentiated
> > scrub in mind) to only support scrub control by PA range at the
> > granularity of interleave sets.
> >
> > Note that this general question of PA based controls also
> > maps to things like resource control (resctl) where it's only interesting
> > to partition memory bandwidth such that the partition applies to the
> > whole interleave set - that's done for ARM systems anyway by having
> > the userspace interface pretend there is only one control, but
> > write the settings to all actual controllers involved. Not sure what
> > x86 does.
> >
> > Taking a few examples that I know of.  All 4 socket server - with
> > control of these as bios options ;).
> > Assuming individual memory controllers don't allow scrub to be
> > configured by PA range.
> >
> > 1. Full system memory interleave (people do this form of crazy)
> >    In that case, there is only one set of firmware controls
> >    that write to the interfaces of every memory controller.  Depending
> >    on the interleave design that may still allow multiple regions.
> >
> > 2. Socket wide memory interleave.  In that case, firmware controls
> >    need to effect all memory controllers in that socket if the
> >    requested 'region' maps to them.  So 4 PA regions.
> >
> > 3. Die wide memory interleave.  Finer granularity of control
> >    so perhaps 8 PA rgiones.
> >
> > 4. Finer granularity (there are reasons to do this for above mentioned
> >    bandwidth resource control which you can only do if not interleaving
> >    across multiple controllers).
> >
> >
> >  
> > >
> > > So my take is, control at the granularity of the memory controller is
> > > probably a nice compromise.
> > > Both OS and userspace can get a pretty
> > > decent amount of flexibility, start/stop/adjust speed of the scrubbing
> > > on a memory controller; meanwhile it doesn't impose too much pain to
> > > hardware vendors when they provide these features in hardware. In
> > > terms of how these controls/features will be implemented, I imagine it
> > > could be implemented:
> > > * via hardware registers that directly or indirectly control on memory
> > > controllers
> > > * via ACPI if the situation changes in 10 years (and the RASF/RAS2/PCC
> > > drivers implemented in this patchset can be directly plugged into)
> > > * a kernel-thread that uses cpu read to detect memory errors, if
> > > hardware support is unavailable or not good enough
> > >  
> >
> > I more or less agree, but would tweak a little.
> >
> > 1) Allow for multiple regions per memory controller - that's needed
> >    for RASF etc anyway - because as far as they are concerned there
> >    is only one interface presented.
> > 2) Tie the interface to interleave sets, not memory controllers.
> >    NUMA nodes often being a good stand in for those.  
> 
> Does you mean /sys/devices/system/node/nodeX/scrub, where scrub is a
> virtual concept of scrubbing device that mapps to 1 or several
> physical scrubber backends.
> 
> For example, starting/stopping the virtual device means issuing
> START/STOP cmd to all backends. And...

That file location would work I think, though in some cases it
may get complex with single memory controllers covering parts of
different interleave sets. I guess mapping that mess is all a
software problem.


> 
> >    Controlling memory controllers separately for parts of an interleave
> >    isn't something I'd think was very useful.  This will probably get
> >    messy in the future though and the complexity could be pushed to
> >    a userspace tool - as long as enough info is available elsewhere
> >    in sysfs.  So need those memory controller directories you propose
> >    to include info on the PA ranges that they are involved in backing  
> 
> is it acceptable if we don't provide PA range or region in the
> interface *for now* if it complicates things a lot? I could be wrong,
> but the user of scrubber seems would be ok with not being able to
> scrub an arbitrary physical address range. In contrast, not knowing
> the scrub results seems to be more annoying to users. So simply giving
> some progress indicator like how many bytes a scrubber has scrubbed.

Progress is usually a non starter given it tends to be continuous in
the hardware controllers I've seen. So you control that it does it every
X hours, but doesn't provide a progress indicator.

I'd stil like PA range being there, but maybe RO fixed values.
Should be easy enough to establish. Also, won't matter if multiple
controllers identify same PA range, assumption would be control them all from
userspace, or use the NUMA type mapping above.

> 
> When we really need to support PA range or region, under the
> /sys/devices/system/node/nodeX/scrub interface, it basically uses NUMA
> node X's PA range. Then to scrub node memory in range [PA1, PA2), some
> driver that understand all backends (or can talk to all backends'
> drivers) needs to translate the PA into the address in backend's
> address space, for example, [PA1, PA2) is mapped to 2 device ranges
> [DA11, DA12) on backend_1 and [DA21, DA22) on backend_2.

Agreed.

> 
> >    (which to keep things horrible, can change at runtime via memory
> >     hotplug and remapping of host physical address ranges on CXL etc)  
> 
> CXL memory locally attached to the host is probably more or less the
> same as normal physical memory. I wonder what it would be like for CXL
> memory remotely attached through a memory pool. Does it make sense
> that the controller/owner of the memory pool takes the responsibility
> of controlling the CXL memory controller to control scrubbing? Does
> the owner need to provide/mediate scrubbing support for other clients
> using the memory pool?

Good and complex questions but lets leave those for a while ;)
beyond comprehending the fact that we can't always map interleave to
particular memory controllers as they may use only a subset of the
memory on that device. 

+CC'd linux-cxl for info, not because I want that discussion to go deep
at the moment.

Jonathan

> 
> Thanks,
> Jiaqi
> 
> >  
> > > Given these possible backends of scrubbing, I think a more generic
> > > sysfs API that covers and abstracts these backends will be more
> > > valuable right now. I haven’t thought thoroughly, but how about
> > > defining the top-level interface as something like
> > > “/sys/devices/system/memory_controller_scrubX/”, or
> > > “/sys/class/memory_controllerX/scrub”?  
> >
> > No particular harm in the rename of the directory I guess.
> > Though some of those 'memory_controllers' would be virtual as they
> > wouldn't correspond to actual memory controllers but rather to
> > sets of them.
> >
> > Jonathan
> >  
> > >
> > > [1] https://lore.kernel.org/linux-mm/SJ1PR11MB6083BF93E9A88E659CED5EC4FC3F9@SJ1PR11MB6083.namprd11.prod.outlook.com/T/#m13516ee35caa05b506080ae805bee14f9f958d43  
> >  
> > >  
> > > > +Date:          September 2023
> > > > +KernelVersion: 6.7
> > > > +Contact:       linux-kernel@vger.kernel.org
> > > > +Description:
> > > > +               The /sys/class/scrub/scrubX/region{0,1,2,3,...}
> > > > +               directories correspond to each scrub region under a scrub device.
> > > > +               Scrub region is a physical address range for which scrub may be
> > > > +               separately controlled. Regions may overlap in which case the
> > > > +               scrubbing rate of the overlapped memory will be at least that
> > > > +               expected due to each overlapping region.
> > > > +
> > > > +What:          /sys/class/scrub/scrubX/regionY/addr_base
> > > > +Date:          September 2023
> > > > +KernelVersion: 6.7
> > > > +Contact:       linux-kernel@vger.kernel.org
> > > > +Description:
> > > > +               (RW) The base of the address range of the memory region
> > > > +               to be patrol scrubbed.
> > > > +               On reading, returns the base of the memory region for
> > > > +               the actual address range(The platform calculates
> > > > +               the nearest patrol scrub boundary address from where
> > > > +               it can start scrubbing).
> > > > +
> > > > +What:          /sys/class/scrub/scrubX/regionY/addr_size
> > > > +Date:          September 2023
> > > > +KernelVersion: 6.7
> > > > +Contact:       linux-kernel@vger.kernel.org
> > > > +Description:
> > > > +               (RW) The size of the address range to be patrol scrubbed.
> > > > +               On reading, returns the size of the memory region for
> > > > +               the actual address range.
> > > > +
> > > > +What:          /sys/class/scrub/scrubX/regionY/enable
> > > > +Date:          September 2023
> > > > +KernelVersion: 6.7
> > > > +Contact:       linux-kernel@vger.kernel.org
> > > > +Description:
> > > > +               (WO) Start/Stop scrubbing the memory region.
> > > > +               1 - enable the memory scrubbing.
> > > > +               0 - disable the memory scrubbing..
> > > > +
> > > > +What:          /sys/class/scrub/scrubX/regionY/speed_available
> > > > +Date:          September 2023
> > > > +KernelVersion: 6.7
> > > > +Contact:       linux-kernel@vger.kernel.org
> > > > +Description:
> > > > +               (RO) Supported range for the partol speed(scrub rate)
> > > > +               by the scrubber for a memory region.
> > > > +               The unit of the scrub rate vary depends on the scrubber.
> > > > +
> > > > +What:          /sys/class/scrub/scrubX/regionY/speed
> > > > +Date:          September 2023
> > > > +KernelVersion: 6.7
> > > > +Contact:       linux-kernel@vger.kernel.org
> > > > +Description:
> > > > +               (RW) The partol speed(scrub rate) on the memory region specified and
> > > > +               it must be with in the supported range by the scrubber.
> > > > +               The unit of the scrub rate vary depends on the scrubber.
> > > > --
> > > > 2.34.1
> > > >
> > > >  
> > >  
> >
> >  
> 

