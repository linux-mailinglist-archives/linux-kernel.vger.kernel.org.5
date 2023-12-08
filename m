Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FAE80A4AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573826AbjLHNs3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Dec 2023 08:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjLHNs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:48:27 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3157D172B;
        Fri,  8 Dec 2023 05:48:33 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SmssF151cz6JB1X;
        Fri,  8 Dec 2023 21:47:45 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
        by mail.maildlp.com (Postfix) with ESMTPS id 9394D14011D;
        Fri,  8 Dec 2023 21:48:30 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 13:48:30 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Fri, 8 Dec 2023 13:48:30 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
        "leo.duran@amd.com" <leo.duran@amd.com>,
        "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "jiaqiyan@google.com" <jiaqiyan@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
        "erdemaktas@google.com" <erdemaktas@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
        "gthelen@google.com" <gthelen@google.com>,
        "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
        "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v4 00/11] cxl: Add support for CXL feature commands, CXL
 device patrol scrub control and DDR5 ECS control features
Thread-Topic: [PATCH v4 00/11] cxl: Add support for CXL feature commands, CXL
 device patrol scrub control and DDR5 ECS control features
Thread-Index: AQHaI8KwgMGD3E1NJkm1EO0u0hTVFbCcsBMAgAJ2I3A=
Date:   Fri, 8 Dec 2023 13:48:30 +0000
Message-ID: <9bc4b5fac46d4f37b675de4e0f65931b@huawei.com>
References: <20231130192314.1220-1-shiju.jose@huawei.com>
 <6570cdbaa96e0_45e01294e0@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6570cdbaa96e0_45e01294e0@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.159.242]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks  for the feedbacks.

>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 06 December 2023 19:39
>To: Shiju Jose <shiju.jose@huawei.com>; linux-cxl@vger.kernel.org; linux-
>mm@kvack.org; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dan.j.williams@intel.com
>Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>tony.luck@intel.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>rafael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com;
>james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>mike.malvestuto@intel.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: RE: [PATCH v4 00/11] cxl: Add support for CXL feature commands, CXL
>device patrol scrub control and DDR5 ECS control features
>
>Hi Shiju,
>
>I have some general feedback at this point before digging too deep into the
>details:
>
>shiju.jose@ wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> 1. Add support for CXL feature mailbox commands.
>> 2. Add CXL device scrub driver supporting patrol scrub control and
>> DDR5 ECS control features.
>> 3. Add scrub driver supports configuring memory scrubs in the system.
>> 4. Add scrub attributes for DDR5 ECS control to the memory scrub driver.
>
>For a new a subsystem that is meant to generically abstract a "memory scrub"
>facility the "DDR5 ECS" naming has too much precision. How much of this
>interface is DDR5 ECS specific and how much of it is applicable to a theoretical
>DDR6 scrub implementation?
>
>My primary reaction is to boil down this interface so that only generic scrub
>details are visible in the ABI, and DDR5 specifics are invisible in the sysfs ABI.
Sure. I will check this.

>
>For example the Linux NVDIMM subsystem has an address-range-scrub facility
>that is independent of the specific memory technology scrub mechanism. That
>one is based on ACPI NFIT, but I realize you also looked at enabling the ACPI
>RASF scrub interface. It would be useful if this patchset could plausibly enable
>one non-CXL scrubber along with the CXL one.
Sure. I will do this. I will add ACPI RASF scrub patches to this patch set.

>
>> 5. Register CXL device patrol scrub and ECS with scrub control driver.
>> 6. Add documentation for common attributes in the scrub configure driver.
>
>Going forward, please include the Documentation in the patch that adds the new
>ABI, it improves the readability / story-telling of the patches.
>It also makes it easier to analyze which code is needed for which ABI, and
>whether a given ABI is justified.
I will do.

>
>The regionY nomenclature in the sysfs ABI looks like a potential opportunity to
>align with the "memregion" id scheme. See all the callers of memregion_alloc()
>where those are tagging device-backed physical address ranges with a common
>id namespace. It would be great if the memory-scrub ABI reported failures in
>terms of region-ids that correlate with CXL, DAX, or NVDIMM regions.
For the CXL DDR5 ECS feature, presently the regionY  corresponds to the IDs of the
memory media FRUs (1 to N),  defined in the DDR5 ECS Control Feature tables Table 8-210 and  Table 8-211. 
 
>
>> 7. Add documentation for CXL memory device scrub control attributes.
>
>Do the CXL specifics need to be in the ABI? One thing I missed was how the
Ok. I will remove. Should these DDR5 ECS specifics consider as generic and 
be part of the memory scrub ABI?      
>series of log entries are conveyed. For CXL in contrast to what NVDIMM did for
>address range scrub is that CXL makes use of trace-events to emit log records.
>That allows the sysfs ABI to remain relatively simple, but the various trace-
>events can get into more protocol specific details. For example, see
>cxl_trigger_poison_list() and
>trace_cxl_poison() as a way to genericly trigger the listing of a flow of device-
>specific details. In other words put the DDR5 ECS specifics in the trace-event, not
>the sysfs ABI if possible.
Did you mean remove the readable attributes for DDR5 ECS from the sysfs?
For example the "ECS Threshold Count per Gb of Memory Cells" and "Codeword/Row Count Mode"
in the Table 8-78 DDR5 ECS log  of  section 8.2.9.5.2.4 DDR5 Error Check Scrub (ECS) Log.
  
>
>Lastly, dynamically defined sysfs groups are less palatable than statically
>defined. See cxl_region_target_visible() for a scheme for statically defining a
>runtime variable number of attributes.
>Specifically I would like to see a way to define this new subsystem without
>scrub_create_attrs() and all the runtime attribute definition.
>
Sure. I will check this.

>Overall, I like the general approach to define a common subsystem for this, and
>get off the treadmill of reinventing custom scrub interfaces per bus, but that
>also requires that it be generic enough to subsume a number of those per-bus-
>scrub-types.
This is the challenging part to make the scrub interface generic because the scrub control
varies between the scrub types, for example as seen in the CXL ECS.

Thanks,
Shiju
