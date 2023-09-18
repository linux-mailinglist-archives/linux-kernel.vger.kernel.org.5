Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905287A499C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbjIRM3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbjIRM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:29:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2869F;
        Mon, 18 Sep 2023 05:29:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rq3wq4mn7z6K6Qt;
        Mon, 18 Sep 2023 20:28:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 13:28:59 +0100
Date:   Mon, 18 Sep 2023 13:28:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Hildenbrand <david@redhat.com>, <linuxarm@huawei.com>
CC:     Shiju Jose <shiju.jose@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jiaqiyan@google.com" <jiaqiyan@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
        "erdemaktas@google.com" <erdemaktas@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
        "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
        "gthelen@google.com" <gthelen@google.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: Re: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add
 documentation for scrub driver
Message-ID: <20230918132835.000031b7@huawei.com>
In-Reply-To: <7282d074-15ba-4fe7-bf62-6a4dd6089817@redhat.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
        <20230915172818.761-4-shiju.jose@huawei.com>
        <887344ee-068d-f78f-d5f8-e816b966d875@redhat.com>
        <946f29d2370c41deb7a7c5a6f2bff0f3@huawei.com>
        <7282d074-15ba-4fe7-bf62-6a4dd6089817@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Mon, 18 Sep 2023 14:15:33 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 18.09.23 12:25, Shiju Jose wrote:
> > Hi David,
> > 
> > Thanks for looking into this.
> >   
> >> -----Original Message-----
> >> From: David Hildenbrand <david@redhat.com>
> >> Sent: 18 September 2023 08:24
> >> To: Shiju Jose <shiju.jose@huawei.com>; linux-acpi@vger.kernel.org; linux-
> >> mm@kvack.org; linux-kernel@vger.kernel.org
> >> Cc: rafael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com;
> >> tony.luck@intel.com; james.morse@arm.com; dave.hansen@linux.intel.com;
> >> jiaqiyan@google.com; jthoughton@google.com; somasundaram.a@hpe.com;
> >> erdemaktas@google.com; pgonda@google.com; rientjes@google.com;
> >> duenwen@google.com; Vilas.Sridharan@amd.com; mike.malvestuto@intel.com;
> >> gthelen@google.com; Linuxarm <linuxarm@huawei.com>; Jonathan Cameron
> >> <jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
> >> Zengtao (B) <prime.zeng@hisilicon.com>
> >> Subject: Re: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add
> >> documentation for scrub driver
> >>
> >> On 15.09.23 19:28, shiju.jose@huawei.com wrote:  
> >>> From: Shiju Jose <shiju.jose@huawei.com>
> >>>
> >>> Add documentation for scrub driver, supports configure scrub
> >>> parameters, in Documentation/scrub-configure.rst
> >>>
> >>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> >>> ---
> >>>    Documentation/scrub-configure.rst | 55  
> >> +++++++++++++++++++++++++++++++  
> >>>    1 file changed, 55 insertions(+)
> >>>    create mode 100644 Documentation/scrub-configure.rst
> >>>
> >>> diff --git a/Documentation/scrub-configure.rst
> >>> b/Documentation/scrub-configure.rst
> >>> new file mode 100644
> >>> index 000000000000..9f8581b88788
> >>> --- /dev/null
> >>> +++ b/Documentation/scrub-configure.rst
> >>> @@ -0,0 +1,55 @@
> >>> +==========================
> >>> +Scrub subsystem driver
> >>> +==========================
> >>> +
> >>> +Copyright (c) 2023 HiSilicon Limited.
> >>> +
> >>> +:Author:   Shiju Jose <shiju.jose@huawei.com>
> >>> +:License:  The GNU Free Documentation License, Version 1.2
> >>> +          (dual licensed under the GPL v2) :Original Reviewers:
> >>> +
> >>> +- Written for: 6.7
> >>> +- Updated for:
> >>> +
> >>> +Introduction
> >>> +------------
> >>> +The scrub subsystem driver provides the interface for configure the  
> >>
> >> "... interface for configuring memory scrubbers in the system."
> >>
> >> are we only configuring firmware/hw-based memory scrubbing? I assume so.  
> > The scrub control could be used for the SW  based memory scrubbing too.  
> 
> Okay, looks like there is not too much hw/firmware specific in there 
> (besides these weird range changes).
> [...]
> 
> >>> +-------
> >>> +
> >>> +  The usage takes the form shown in this example::
> >>> +
> >>> +    # echo 0x300000 > /sys/class/scrub/scrub0/region0/addr_base
> >>> +    # echo 0x100000 > /sys/class/scrub/scrub0/region0/addr_size
> >>> +    # cat /sys/class/scrub/scrub0/region0/speed_available
> >>> +    # 1-60
> >>> +    # echo 25 > /sys/class/scrub/scrub0/region0/speed
> >>> +    # echo 1 > /sys/class/scrub/scrub0/region0/enable
> >>> +
> >>> +    # cat /sys/class/scrub/scrub0/region0/speed
> >>> +    # 0x19  
> >>
> >> Is it reasonable to return the speed as hex? You set it as dec.  
> > Presently return speed  as hex to reduce the number of callback function needed
> > for reading the hex/dec data because the values for the address range
> > need to be in hex.  
> 
> If speed_available returns dec, speed better also return dec IMHO.
> 
> >   
> >>  
> >>> +    # cat /sys/class/scrub/scrub0/region0/addr_base
> >>> +    # 0x100000  
> >>
> >> But didn't we set it to 0x300000 ...  
> > This is an emulated example for testing the RASF/RAS2 definition.
> > According to the RASF & RAS2 definition, the actual address range in the
> > platform could vary from the requested address range for the patrol scrubbing.
> > "The platform calculates the nearest patrol scrub boundary address
> > from where it can start". The platform returns the actual address range
> > in response to GET_PATROL_PARAMETERS command to the firmware.
> > Please see section 5.2.21.2.1 Hardware-based Memory Scrubbing ,
> > Table 5.87: Parameter Block Structure for PATROL_SCRUB in the
> > ACPI 6.5 specification.
> >   
> 
> So you configure [0x300000 - 0x400000] and you get [0x100000 - 0x300000]
> 
> How does that make any sense? :)
> 
> Shouldn't we rather return an error when setting a range that is 
> impossible, instead of the hardware deciding to scrub something 
> completely different (as can be seen in the example)?
> 

A broader scrub is probably reasonable, but agreed that scrubbing narrower
is 'interesting' as not scrubbing the memory requeseted.
It's really annoying that neither ACPI table provides any proper
discoverability.  Whilst we can fix that long term, we are stuck with
a clunky poke it and see interface in the meantime.

Jonathan


