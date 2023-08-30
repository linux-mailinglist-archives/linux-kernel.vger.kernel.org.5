Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9197D78DDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244069AbjH3Su3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbjH3Kri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:47:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF0F1BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:47:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbLVS5vXWz6J7gc;
        Wed, 30 Aug 2023 18:43:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 11:47:32 +0100
Date:   Wed, 30 Aug 2023 11:47:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Amit Singh Tomar <amitsinght@marvell.com>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: resctrl2 - status
Message-ID: <20230830114731.00003590@Huawei.com>
In-Reply-To: <MW4PR18MB50847485155B226B07DABEAAC6E7A@MW4PR18MB5084.namprd18.prod.outlook.com>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
        <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
        <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
        <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
        <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
        <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
        <20230829112321.00002b55@Huawei.com>
        <MW4PR18MB50847485155B226B07DABEAAC6E7A@MW4PR18MB5084.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 17:18:53 +0000
Amit Singh Tomar <amitsinght@marvell.com> wrote:

> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com> 
> Sent: Tuesday, August 29, 2023 3:53 PM
> To: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Luck, Tony <tony.luck@intel.com>; Amit Singh Tomar <amitsinght@marvell.com>; Yu, Fenghua <fenghua.yu@intel.com>; james.morse@arm.com; George Cherian <gcherian@marvell.com>; robh@kernel.org; peternewman@google.com; Drew Fustini <dfustini@baylibre.com>; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: resctrl2 - status
> 
> External Email
> 
> ----------------------------------------------------------------------
> On Fri, 25 Aug 2023 13:20:22 -0700
> Reinette Chatre <reinette.chatre@intel.com> wrote:
> 
> > Hi Tony,
> > 
> > On 8/25/2023 12:44 PM, Luck, Tony wrote:  
> > >>>> Alternatively, can user space just take a "load all resctrl 
> > >>>> modules and see what sticks" (even modules of different 
> > >>>> architectures since a user space may want to be generic) approach?  
> > >>>
> > >>> This mostly works. Except for the cases where different modules 
> > >>> access the same underlying hardware, so can't be loaded together.
> > >>>
> > >>> Examples:
> > >>>
> > >>> rdt_l3_cat vs. rdt_l3_cdp - user needs to decide whether they want CDP or not.
> > >>> But this is already true ... they have to decide whether to pass 
> > >>> the "-o cdp" option to mount.
> > >>>
> > >>> rdt_l3_mba vs. rdt_l3_mba_MBps - does the user want to control 
> > >>> memory bandwidth with percentages, or with MB/sec values. Again 
> > >>> the user already has to make this decision when choosing mount options.
> > >>>
> > >>>
> > >>> Maybe the "What resctrl options does this machine support?" 
> > >>> question would be best answered with a small utility?  
> > >>
> > >> A user space utility or a kernel provided utility? If it is a user 
> > >> space utility I think it would end up needing to duplicate what the 
> > >> kernel is required to do to know if a particular feature is 
> > >> supported. It seems appropriate that this could be a kernel utility 
> > >> that can share this existing information with user space. resctrl already supports the interface for this via /sys/fs/resctrl/info.  
> > > 
> > > I was imagining a user space utility. Even though /proc/cpuinfo 
> > > doesn't show all features, a utility has access to all the CPUID 
> > > leaves that contain the details of each feature enumeration.  
> > 
> > For x86 that may work (in some scenarios, see later) for now but as I 
> > understand Arm would need a different solution where I believe the 
> > information is obtained via ACPI. I think it is unnecessary to require 
> > user space to have parsers for CPUID and ACPI if that same information 
> > needs to be parsed by the kernel and there already exists an interface 
> > with which the information is communicated from kernel to user space. 
> > Also, just because information CPUID shows a feature is supported by 
> > the hardware does not mean that the kernel has support for that 
> > feature. This could be because of a feature mismatch between user 
> > space and kernel, or even some features disabled for use via the, for example "rdt=!l3cat", kernel parameter.  
> 
> James probably also has views on this, but I wouldn't expect userspace to go anywhere near ACPI parsing. If the description of what MPAM features are supported (before resctrl is running) is necessary, then we should add it to the existing description of the various caches etc.  Maybe somewhere in /sys/bus/node/devices/nodeX/cpuY/cache/indexZ/
> for the caches
> and
> /sys/bus/node/devices/nodeX for the DRAM controllers.
> [>>] Or may be all the MPAM features list is unified at one place, something like this ?  
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.5-rc1&id=c32874cd1d68241c481a9d0c32c8c65d019c247e

Fine for debug, not for generic tooling.

Might be possible to do something separate but I would expect to see this
info associated with the entities being controlled, not off on it's own
somewhere else in sysfs or similar.

Jonathan


> 
> I'm sure we can find somewhere sensible for other things covered by MPAM.
> The MPAM table parsers and some early code to query features from the hardware should be able to figure out what is needed.
> 
> Perhaps x86 systems could provide similar descriptions but originating from CPUID etc.
> 
> Jonathan
> 
> >   
> > >> fyi ... as with previous attempts to discuss this work I find it 
> > >> difficult to discuss this work when you are selective about what 
> > >> you want to discuss/answer and just wipe the rest. Through this I 
> > >> understand that I am not your target audience.  
> > > 
> > > Not my intent. I value your input highly. I'm maybe too avid a 
> > > follower of the "trim your replies" school of e-mail etiquette. I 
> > > thought I'd covered the gist of your message.
> > > 
> > > I'll try to be more thorough in responding in the future.    
> > 
> > Two items from my previous email remain open:
> > 
> > First, why does making the code modular require everything to be 
> > loadable modules?
> > I think that it is great that the code is modular. Ideally it will 
> > help to support the other architectures. As you explain this modular 
> > design also has the benefit that "modules" can be loaded and unloaded after resctrl mount.
> > Considering your example of MBA and MBA_MBps support ... if I 
> > understand correctly with code being modular it enables changes from 
> > one to the other after resctrl mount. User can start with MBA and then 
> > switch to MBA_MBps without needing to unmount resctrl. What I do not 
> > understand is why does the code being modular require everything to be 
> > modules? Why, for example, could a user not interact with a resctrl 
> > file that enables the user to make this switch from, for example, MBA 
> > to MBA_MBps? With this the existing interfaces can remain to be 
> > respected, the existing mount parameters need to remain anyway, while enabling future "more modular" usages.
> > 
> > Second, copied from my previous email, what is the plan to deal with 
> > current users that just mount resctrl and expect to learn from it what 
> > features are supported?
> > 
> > Reinette
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.or
> > g_mailman_listinfo_linux-2Darm-2Dkernel&d=DwICAg&c=nKjWec2b6R0mOyPaz7x
> > tfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=ri5Ay9ia3NmwAS6P94yjZ7rPIR1dIqrIAIjpslfwcd5ulIIs5BNEG9jmTlq6H6o8&s=KZMxmC8InOxAyxgrDig96R2aKf2hc1C_hk_1413pjCI&e=
> >   
> 

