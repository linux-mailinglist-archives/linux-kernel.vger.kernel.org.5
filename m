Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4F48078BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379385AbjLFTio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379376AbjLFTil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:38:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F78CD65;
        Wed,  6 Dec 2023 11:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701891527; x=1733427527;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9epjVGXDJBbZLrQ55qfQ+bEj530zLB18lLWwNRfo08s=;
  b=Ch1bEBf8RStv/7qPveCCTl+ZE0BxklzTDiEZO96G3o7yOXbv3BZfbcys
   hB56F5MWwrdyGMHpuO8Lxm8RSemsb/uez1FYL7Gjp11vKJW1W6npdidUq
   3j8Mh+hhLQuKGXlG+CPmdT4ZuAIKscYPuIXsDtgQS91zhRy30d15TG0aq
   fy/b976KqWo29tquUGdB7jvzLe3lvPFcIl4CM1X/OsuwgiZ/L6v1PCy/q
   UFyeQimyGepj72p+J2bPc6ml5al59NbYXj8dLfzICoKFoBM3RUmL3rzGU
   7UCNzXXMQY9tKT+kvZG9tTXKzo63UWdQudf5+5KG7FbM7UGAVM72XfJPa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="374289485"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="374289485"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 11:38:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="721197179"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="721197179"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 11:38:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 11:38:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 11:38:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 11:38:43 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 11:38:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiQ5URHDCjhUdAtRzrAsQlv5jfwc3V27ZEu+NuO2OcLjneC1iM7BSSMgDhYQlDFrqxtyWE3GFkMvuUAhaobiXdj2cmgOLhuZlFf4/fRdJGI7VNcMTQ4BtHZBBX0dHwjrpozkfJ6dAfCnHjFIQzrvBOvZUZ2tCx9wzBCZe8jvvdADBAghWA/2b3j+3ZRJy9KFLnIZtOcitOyLYPPkXdwbXKw0w8GeaeOB+OZD2fSqkoATqqaKMrwTGKBK3o+qkG/SxlMZkmWD4vmykX4Zq8IfPnWryYVHMdt7Fotkec/HWt8nBiEHAwS8oEMsGst7xNTiDcH/Nt8NfJXpp+YAuPzEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tj1YchFAsScFiiLpGf5TnCq7+6YmgsDB6V6n4hBkjwA=;
 b=SbinyWAgAIhqVPYd9nBL7gZDKzSAt61grUBxQngZ9mZMeoGYT89n4fhQDAX/dPlly0UJoQAMZYPW5YyOaC6NfWuof2oVcmCNRvBfx+kBbFlOxeR+4U8gj72e+5BBrJyN3JdEmhNcTZwaPIm6Pl3curI//duicDLv1hOg27ML80EyR9cq462DSPN+2bQkgKT/6K9WBPYCk9X68KyY2iPXWbQn3CrkWCSb2guOSmjUtD1oreiRtgwxMB1CNyz5O13d93Hf1fPV3VDB+pKEj/rs2y3B2erZzWPmrDZ55Ej1LpnEJjVIDSbwRNGp4HuwrHHe66aJjpJAae9RYj9bzv+TGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 19:38:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 19:38:40 +0000
Date:   Wed, 6 Dec 2023 11:38:34 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>, <dave@stgolabs.net>,
        <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
        <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
        <jiaqiyan@google.com>, <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <pgonda@google.com>, <duenwen@google.com>,
        <mike.malvestuto@intel.com>, <gthelen@google.com>,
        <wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: RE: [PATCH v4 00/11] cxl: Add support for CXL feature commands, CXL
 device patrol scrub control and DDR5 ECS control features
Message-ID: <6570cdbaa96e0_45e01294e0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231130192314.1220-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231130192314.1220-1-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a318b6e-0019-4554-5a49-08dbf692f2bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsVRYbxOHKFm3WEz2jgb3+Ze626v/VrEVwmzLAL/1EZL1mtbrkLy/gux6Va0rCpgFFmyGtKKN6c3VmRdm4Dx7/7K/bvbPMUgUtDMS7bRBHAmVrBxvY6KQPi/hhsc4CNfNqzAxTgLl2tdkKDtZgSVXGIgBZHhASHYamQ7xo0JY5EwIe7PahtRZMsiF8xH889CTnHeEIanHykzfvI9JfxCl+1L120IMEBsrpBF4/6G1q2aJ9NloG8+X368MuYIoTrRWrEC/454St3XE7d9iTnp9gMMvuOTnXksHU2w4OIGcygXKprxh3SquDiUe3r5gJJnFemzrgZ+R8N3es8vBEzrA633p2qh+9atooPsAiCrEo3X31l4UD0qeRzI1hrwKsFBh98fa2ogD4FScrTUSRpG8UJ5daEzS0+lEx2X8QFkrt+vKlHpaaQnz5OdZQ2QFNhWLUW2v9eeKJEwi9b+s3rrsIwE0XJA2V5JozEnYkl2PdusdTagCUECTu+uIh/7g7q/vgFj0fH7kEpHqZeONGZLG2yLcYgp0oNFMRxhCUr3va0hbG/uD0zshhrSlyR+R1TtXYct1Mztf+za9JX1x7aIkpoCG2O0wZt8j+Hztg+MQF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(2906002)(921008)(82960400001)(26005)(83380400001)(86362001)(5660300002)(6486002)(478600001)(6512007)(9686003)(6506007)(6666004)(8936002)(8676002)(4326008)(7416002)(7406005)(316002)(66476007)(41300700001)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PUPP/FnQJ3TsIT0uEPPCYzTZ4gByfCX4bUPW8UPv1Z4z5uV/S2wNIJr3Ddtv?=
 =?us-ascii?Q?Xtv2MAdX+jBLw/b+TlpT9wQhPms6j1/Vu+5hTTOatahv+kv3heccRdRZHlQI?=
 =?us-ascii?Q?3suwa/Du+fsX4pGcqBu5fp1DanQw5SB31dZnP8gNCn3fu43dDf27qBvdZFiD?=
 =?us-ascii?Q?DUW0Z504fSBz3TATcy75jVvak1Ndzsz+BkStmrq3y34girYuEeklp4zYggzt?=
 =?us-ascii?Q?o7qplK0b42BECee9P0JvgNCM3cty1BtwF8cKW3sNMnhpVsxP8ceXPYk5pYP4?=
 =?us-ascii?Q?LxAZCCZA9mSQWFT+HRS+381Vj56nh/SiAdRa6xoftPtWsB0szz3Ttv2UG1N9?=
 =?us-ascii?Q?rpB+I1pDg+QOiEQd1HOzXwJgnTvjgRFy8DjOVkPaVZxO27VTZVQFA4nl9A61?=
 =?us-ascii?Q?jPv0H6v1ASTJYarZstb9/h0sNEB86IrdKAQo3cMh9BzcG2zzC0csZkyw4Mp+?=
 =?us-ascii?Q?lygqnlSk4zr2zsYlIY9bXN2D+xRShyreR7Z62xYovLZ3qP+iMbFne4sPzy6x?=
 =?us-ascii?Q?2kIenaJ8EplMpARR/sG36Ga/QUjlIVyEpMI5YWckhL9+ZDrBlr4KMf71H8rg?=
 =?us-ascii?Q?4EEtZrWiwlowQV4qHP7ek/jq2nxSCC16mJAZyxDQOvIG7Nm7tqnqmggijssL?=
 =?us-ascii?Q?TvdPsDlQjUCR+swCixmgq/xABkBskYc8smdcBhVmk/2mC7gqwI6vfNKhRFzj?=
 =?us-ascii?Q?mW57j1dxCllac0elGTbSd/Ht9cXn/ADWv3qWTblpHleS0TaAWcO2I0tFen7x?=
 =?us-ascii?Q?oo9Nd8qA3mTpcd2N0pS4Stnu2S8n9br0XJtKnb8YE8x46ufj6v7yjVc18Gug?=
 =?us-ascii?Q?eRKk9IltwHhHGiE+eF+8ox+ryN5Y9hBBLjXO6qBKHtDuYs5YP8I72ISWPC1r?=
 =?us-ascii?Q?K0+kcy1CvC1559sYHbqhUc7HFZaOLR3p+42yahmBA8Y8CCqgqmmaHNzIRjqv?=
 =?us-ascii?Q?kiuPUW+S35xqt1+h0S+Sx0yc4Esrq8IsYUNIgwzS3KJjQ8rwdKnmazvwm8BA?=
 =?us-ascii?Q?MkHfhVCatEbTOg+Ll3zQhwYZyzDukDsEvjofaS0Crbwi/zCRJSCzfc5JhNL+?=
 =?us-ascii?Q?WNg3hetgwYjZeDvEkzp/tHyD9iF/t/V+Iqwms19pvSKaaFxaqKMjlNH5nUKv?=
 =?us-ascii?Q?+XsEpophnn9amixV9/iVLJRd2MX7aQKfxGQEiUYG4L5JtO+Xhmszq28GOOIS?=
 =?us-ascii?Q?W9G/KLe3xnxejICkg4uIyYNNikvL7/doHNBzfqHAdkx9X3E3YkQs/2q05Z5z?=
 =?us-ascii?Q?JfraSOlwNaDgBlpevw/mgNImyLPTCJFGW3sOEhQ8sozHXsyeFXTvELODeAfy?=
 =?us-ascii?Q?t3h+RDQWcuzn1Ac1R64cDGS1ItVsQNKjYVCnasWiP4cQe4aOLh8zkqGaYB4X?=
 =?us-ascii?Q?dTGah9TeJ0mWIbAqu4lrtuuzXpdb/kiOb4Xln7jnakyUdhJsc6xA8cdiZZCm?=
 =?us-ascii?Q?7BuZMPzZp0ysJE956HOwh22xEkQ2EN30W21t+7cDn6GbZ/3oYliJjzmRd6bL?=
 =?us-ascii?Q?7gsh6CORKcVeygTg7rFYLzSxl28I1hnJSPsvN4OMmBY+4BgJGM7Mo4+oAePM?=
 =?us-ascii?Q?Gn+cHADrp477s2WX9C9swvxu2cVCX9ylyI/rCJhe5P+xLaxjFl/4L+s8dEGe?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a318b6e-0019-4554-5a49-08dbf692f2bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:38:40.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcd8rZiD/SlV6/oZSkGs5W0wSbv/UkwEJ64NmpZQrDdihnXjnJQrTP3AALlCqZqiWihtTV89aaVZcqlUPJ65lt4LJlZ063hV2ySTCCW+roY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiju,

I have some general feedback at this point before digging too deep into
the details:

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> 1. Add support for CXL feature mailbox commands.
> 2. Add CXL device scrub driver supporting patrol scrub control and DDR5 ECS
> control features.
> 3. Add scrub driver supports configuring memory scrubs in the system.
> 4. Add scrub attributes for DDR5 ECS control to the memory scrub driver.

For a new a subsystem that is meant to generically abstract a "memory
scrub" facility the "DDR5 ECS" naming has too much precision. How much
of this interface is DDR5 ECS specific and how much of it is applicable
to a theoretical DDR6 scrub implementation?

My primary reaction is to boil down this interface so that only generic
scrub details are visible in the ABI, and DDR5 specifics are invisible
in the sysfs ABI.

For example the Linux NVDIMM subsystem has an address-range-scrub
facility that is independent of the specific memory technology scrub
mechanism. That one is based on ACPI NFIT, but I realize you also looked
at enabling the ACPI RASF scrub interface. It would be useful if this
patchset could plausibly enable one non-CXL scrubber along with the CXL
one.

> 5. Register CXL device patrol scrub and ECS with scrub control driver.
> 6. Add documentation for common attributes in the scrub configure driver.

Going forward, please include the Documentation in the patch that adds
the new ABI, it improves the readability / story-telling of the patches.
It also makes it easier to analyze which code is needed for which ABI,
and whether a given ABI is justified.

The regionY nomenclature in the sysfs ABI looks like a potential
opportunity to align with the "memregion" id scheme. See all the callers
of memregion_alloc() where those are tagging device-backed physical
address ranges with a common id namespace. It would be great if the
memory-scrub ABI reported failures in terms of region-ids that correlate
with CXL, DAX, or NVDIMM regions.

> 7. Add documentation for CXL memory device scrub control attributes.

Do the CXL specifics need to be in the ABI? One thing I missed was how
the series of log entries are conveyed. For CXL in contrast to what
NVDIMM did for address range scrub is that CXL makes use of trace-events
to emit log records. That allows the sysfs ABI to remain relatively
simple, but the various trace-events can get into more protocol specific
details. For example, see cxl_trigger_poison_list() and
trace_cxl_poison() as a way to genericly trigger the listing of a flow
of device-specific details. In other words put the DDR5 ECS specifics in
the trace-event, not the sysfs ABI if possible.

Lastly, dynamically defined sysfs groups are less palatable than
statically defined. See cxl_region_target_visible() for a scheme for
statically defining a runtime variable number of attributes.
Specifically I would like to see a way to define this new subsystem
without scrub_create_attrs() and all the runtime attribute definition.

Overall, I like the general approach to define a common subsystem for
this, and get off the treadmill of reinventing custom scrub interfaces
per bus, but that also requires that it be generic enough to subsume a
number of those per-bus-scrub-types.
