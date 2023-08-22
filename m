Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E563783ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjHVHTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjHVHSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:18:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CADCC8;
        Tue, 22 Aug 2023 00:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jynj75gb9DHuw9g3EpcVCmf382sUCueHEwquGjup+i5PJQbLiF6WLxaoJw+lt/V0JeYIyAvFD7KlLvbqaYZALLPyqXKjqb5NxIlXR1zr2pwx31zOlCN+Nnvgs+b41b/7Sz2yi1pqos1X3ZRxyjMdVk1clmOSLQi/XV6HxrCyi6jXWSSXwxxL46BsrwUPXamaMP+yOjtKpMqhwGtpnnLmt6OmNtCalic8NCqCWS1aqahJF+bPJK/VlJycnm8RnnllhVFT3g9uJWk4vQ6kM9EUKKU9cmVjb3SJnSx+YnAf1/RA0sMhPo/ECxe7PZXa1NYdSjjdhhij9xnQBcHuFcSxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2PuXH32eHu0jE3UAwJwAxUYKmy5fMqdgcAlGOG5zhE=;
 b=JZ1helfDx8wGkvkP2SeF2pqt4co3ITjysWDwtfulakeiWl/qUJxZkTJL5pnccqdl7Ou67N2mFWPNjZhTYkKkV72YTMGRdYVpZgGa+LcjjhFWcdv5TegjMsrku7UcQdm94OndjpkRYUOhAGgVffpSeA1DNz0+SOXag6D6KJuHmE8bnV6M4ZduRVe+4lQHoyfEqSQB7882Mmsu1a1h9Xe0jC9Fcmu7yA0bo10rBJmrvt+5AbR8rS8OrjJ6YQn3LRTCwLDxtpmFNBMQxz8yweuoKkJM7s+lfYmQITSF+jbAFBQCr99QbPtVg0iRc1RxInUrcr6xAVqL2NRkB2O4CdUK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2PuXH32eHu0jE3UAwJwAxUYKmy5fMqdgcAlGOG5zhE=;
 b=EQg+drTNKk76C2LZkGU8/r45K+ruO+TLORKbEQxm26LpOIEPT0pRFY0FcJyZibDssccpUtlU/PdkfZLbwrKsbf25FhagNpHRLD7/Dsjn1rG/UQ0DQFRfAaeosDmnjTzuBh9OKgYt7NL5NxFpevfBz24PX4iBtkw3Jo+vJiOs3NwxtMWyDgpLTBnYFPEdG8lleqgtwLW9MC6NFqkJ3TuJ+x5n9g2kwftnI+7a48R+/8BuSIrfbFcJzcCwHvg9BP6LkNGqUBTwiBEP+dqTu4J7+U5r/9BqD8LHdtdg/Pj2ViTgqnf954mVXOTxOLA6aNz5ZNgNJduP9Mf18TYJYQE2qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 07:12:04 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 07:12:04 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-2-ying.huang@intel.com>
 <87r0owzqdc.fsf@nvdebian.thelocal>
 <87r0owy95t.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87sf9cxupz.fsf@nvdebian.thelocal>
 <878rb3xh2x.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87351axbk6.fsf@nvdebian.thelocal>
 <87edkuvw6m.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87y1j2vvqw.fsf@nvdebian.thelocal>
 <87a5vhx664.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87lef0x23q.fsf@nvdebian.thelocal>
 <87r0oack40.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87cyzgwrys.fsf@nvdebian.thelocal>
 <87il98c8ms.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87edjwlzn7.fsf@nvdebian.thelocal>
 <875y57dhar.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH RESEND 1/4] memory tiering: add abstract distance
 calculation algorithms management
Date:   Tue, 22 Aug 2023 17:11:34 +1000
In-reply-to: <875y57dhar.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87wmxnlfer.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0038.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 2382f94c-8d73-4ab6-72d5-08dba2df169a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcS9pyukz9jSzli9IjPOFXpUX0KicYxSNNgGJxNcmzS4MncPEbmlIO07yUXvo2NPnF020ihQs2MzwquHxpOMl4EpjEW+T5NIIZCvxBX8dOr4q+Zww/P/PWp3izZewZRjbpZTP46ZRw9T8Y5kCgGOY+l4GJb/AjlGbp39uLJhgdSFFhIcBSNIucNUpCsMwWs7QlnLdufAZNMorh2pny/R5vBKd/EPnWOraMuT6Av0suQz3A2BnTyw76mygTLrpjoh2/0PLpRMJs+ZWEyWx+tJp0YL6VWhexE+NnVsLLqYfgBiBDqQw4QXRLy1jb/SaSz1J+gxlBPNI2IM1m2o/Fg9YTtosGHW0LCut/FUoY52KszxfzqBt3eX6F+R4UegIcd04Is0XCi6DOAwrCHKgLzadCZbbU2D6elClxI4jVot4eddtUnUZ2Hk3k/pf58/7UUaMUpbhJIXtYmTz3Vz0UHTqWd6zNYniy9GxAtUEqW1g5U5hYcCx0TQvuoDoRV/WN07CI9GUC2pWoeRrZEgZ+rtbJ0tRcC363MMqI9BuuqAnkYC1sxTmylZdZJ3yLfR0A7r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(9686003)(8676002)(8936002)(4326008)(41300700001)(478600001)(6666004)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VndzWHPjXOdbS0TsErf4xQrCuYnVbQIUeTabUcyLlpAPuRYwtC+MDxBar8I?=
 =?us-ascii?Q?G+7SQ+blGbq1k9NCHfgiZKVh/FmGvWuHxqBz5Wn/fg+kDNfoGev76sS3oGNw?=
 =?us-ascii?Q?zZcbUm73XwQhwNPCyOJLRcq+UpaRJajzUKxrh2F86ZO6Vgh6yvNdclDpGxij?=
 =?us-ascii?Q?DL7NDt9U12n8iov+SkhTe7zCJ5liVT2dzFg1RuSo44TJze4hcpM22xrCM8yo?=
 =?us-ascii?Q?vADRb0h9QjIR/bVsdH8JSCNeCK+UVMqZUsAgvzQZCI/B0gaU6FaCYh6LILYM?=
 =?us-ascii?Q?BWwrVD4F8cEilKbJwwhIEdL++V/JAyKzYgvxeZhSaqTZ0dHUh9lQEsw3RuP8?=
 =?us-ascii?Q?+h5Ts/zsvfaAXcAgNsM/Vavp04FhPrEnq9XLSrmL17IHm3vKmqpc2lG2mDVF?=
 =?us-ascii?Q?dUQcdFv5zIxdO6IsEzRwulSxERThXOwJ4wRhM+ypRsYjeT67cgsPhA+LB3Rk?=
 =?us-ascii?Q?2K+Tuv7rdW9On4voQlah+jcfgvY6QM5cHruLryjVvcHnp02Qmv+svDEoArju?=
 =?us-ascii?Q?7QRb2dpMvxz5gKW/Vr3fnj/PmqnkUUNWEEiAiPbPYz0jiXvLrMvM/MoO+Etf?=
 =?us-ascii?Q?8vD7SEfYFeNtXwbz/fAXslhVocnaDo7GU2EiFI5HJ1U6h+bxO3ueuuK+mxWd?=
 =?us-ascii?Q?AAQLSPJ58t+HtvZ9tSY8V+Pz3qvYwNc7NZqgOch6ufhQ837tTxmuTM+o81M6?=
 =?us-ascii?Q?vcV3nb9esHY8FKMJ7P6mUDZNm4oKVDwDl7aFaWabzU37CyxHWfXJa3TYTJsv?=
 =?us-ascii?Q?ZuyiJfV2dqmableRcUTf1+yQxDhxfoHlxDslmv0saMETrOENmjAWLiW8q3uf?=
 =?us-ascii?Q?z56jUwxHUzFtr3JUajHS6schkN0WuSWqO4+KpiddIqgNkQG7EXvsBq3njwV6?=
 =?us-ascii?Q?GpUaRr9dqNORBE3p+EpqxOFKvYN545HFO4OsJPB7g8VAoouFZnOjIkljWqT/?=
 =?us-ascii?Q?BDR8GzmbBv+He9z2Z/kpgk8fH898zPMCggxJhfEktklEKROJE1wB4JWsGQun?=
 =?us-ascii?Q?MYWWPYCHOjlDbCc5y0MXiTuK0+TPGwGKUcNUj4Kd0scSg3F6QYbtwkCjDO6P?=
 =?us-ascii?Q?Paj5mbIgIAZchDpSu/C4ZOHtFzwJ6vETuCRX1UoDkB5qG7YttIuSrCeC+trO?=
 =?us-ascii?Q?Akvjpylf0p0G2xpOIhL5QoVIzfehsqqHGEImDz5yzacFh+bgcuz/SxugB/rA?=
 =?us-ascii?Q?AOqM+uzQ5NArEeBUSN1bJYNPoMA0AFv7dGncKXAVNb7NJV/riOzTLqliqJA2?=
 =?us-ascii?Q?AYmPd3dY/9u7vdh045m4ITv6Lstt+5EOmUZM/vNf2+cNW5WHGbUxG0IlErQa?=
 =?us-ascii?Q?azuXLvJU1VdRAPyfmuEV6OSeWDE/n+bHkYazNibh/Xd5cczDnbrVcGVdcqwM?=
 =?us-ascii?Q?FgOTC02L6XiPAynyDluCFFzZHTSXY47zSATRIYys0wWMf9UkpMUunHwwCKop?=
 =?us-ascii?Q?pmN9ORoX/EcIZgDt5YTW8PRECU4yePzMm0aOUa3xptmNinQm8/W109urfsk3?=
 =?us-ascii?Q?BFU9dL6ZHFJKn+29YNwyKcahyFS9yg6X4wVTZYQ2tdiFdEPPZEgcNHxRjF0C?=
 =?us-ascii?Q?q8h7ow9sd6yyKmj54CaEOxa8N6K9qCo7XxMVpeMW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2382f94c-8d73-4ab6-72d5-08dba2df169a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 07:12:04.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBRZvUUMWg98/knLOWRT4yofH05X+eq6LdcoAUrJsfIbBNwgZuux+j9YFIWlRnX6gMrp0J8k1wnEzL4jAJiWyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> Alistair Popple <apopple@nvidia.com> writes:
>
>> "Huang, Ying" <ying.huang@intel.com> writes:
>>
>>> Alistair Popple <apopple@nvidia.com> writes:
>>>
>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>
>>>>> Hi, Alistair,
>>>>>
>>>>> Sorry for late response.  Just come back from vacation.
>>>>
>>>> Ditto for this response :-)
>>>>
>>>> I see Andrew has taken this into mm-unstable though, so my bad for not
>>>> getting around to following all this up sooner.
>>>>
>>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>>
>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>
>>>>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>>>>
>>>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>>>
>>>>>>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>>>>>>
>>>>>>>>>>>>> While other memory device drivers can use the general notifier chain
>>>>>>>>>>>>> interface at the same time.
>>>>>>>>>>
>>>>>>>>>> How would that work in practice though? The abstract distance as far as
>>>>>>>>>> I can tell doesn't have any meaning other than establishing preferences
>>>>>>>>>> for memory demotion order. Therefore all calculations are relative to
>>>>>>>>>> the rest of the calculations on the system. So if a driver does it's own
>>>>>>>>>> thing how does it choose a sensible distance? IHMO the value here is in
>>>>>>>>>> coordinating all that through a standard interface, whether that is HMAT
>>>>>>>>>> or something else.
>>>>>>>>>
>>>>>>>>> Only if different algorithms follow the same basic principle.  For
>>>>>>>>> example, the abstract distance of default DRAM nodes are fixed
>>>>>>>>> (MEMTIER_ADISTANCE_DRAM).  The abstract distance of the memory device is
>>>>>>>>> in linear direct proportion to the memory latency and inversely
>>>>>>>>> proportional to the memory bandwidth.  Use the memory latency and
>>>>>>>>> bandwidth of default DRAM nodes as base.
>>>>>>>>>
>>>>>>>>> HMAT and CDAT report the raw memory latency and bandwidth.  If there are
>>>>>>>>> some other methods to report the raw memory latency and bandwidth, we
>>>>>>>>> can use them too.
>>>>>>>>
>>>>>>>> Argh! So we could address my concerns by having drivers feed
>>>>>>>> latency/bandwidth numbers into a standard calculation algorithm right?
>>>>>>>> Ie. Rather than having drivers calculate abstract distance themselves we
>>>>>>>> have the notifier chains return the raw performance data from which the
>>>>>>>> abstract distance is derived.
>>>>>>>
>>>>>>> Now, memory device drivers only need a general interface to get the
>>>>>>> abstract distance from the NUMA node ID.  In the future, if they need
>>>>>>> more interfaces, we can add them.  For example, the interface you
>>>>>>> suggested above.
>>>>>>
>>>>>> Huh? Memory device drivers (ie. dax/kmem.c) don't care about abstract
>>>>>> distance, it's a meaningless number. The only reason they care about it
>>>>>> is so they can pass it to alloc_memory_type():
>>>>>>
>>>>>> struct memory_dev_type *alloc_memory_type(int adistance)
>>>>>>
>>>>>> Instead alloc_memory_type() should be taking bandwidth/latency numbers
>>>>>> and the calculation of abstract distance should be done there. That
>>>>>> resovles the issues about how drivers are supposed to devine adistance
>>>>>> and also means that when CDAT is added we don't have to duplicate the
>>>>>> calculation code.
>>>>>
>>>>> In the current design, the abstract distance is the key concept of
>>>>> memory types and memory tiers.  And it is used as interface to allocate
>>>>> memory types.  This provides more flexibility than some other interfaces
>>>>> (e.g. read/write bandwidth/latency).  For example, in current
>>>>> dax/kmem.c, if HMAT isn't available in the system, the default abstract
>>>>> distance: MEMTIER_DEFAULT_DAX_ADISTANCE is used.  This is still useful
>>>>> to support some systems now.  On a system without HMAT/CDAT, it's
>>>>> possible to calculate abstract distance from ACPI SLIT, although this is
>>>>> quite limited.  I'm not sure whether all systems will provide read/write
>>>>> bandwith/latency data for all memory devices.
>>>>>
>>>>> HMAT and CDAT or some other mechanisms may provide the read/write
>>>>> bandwidth/latency data to be used to calculate abstract distance.  For
>>>>> them, we can provide a shared implementation in mm/memory-tiers.c to map
>>>>> from read/write bandwith/latency to the abstract distance.  Can this
>>>>> solve your concerns about the consistency among algorithms?  If so, we
>>>>> can do that when we add the second algorithm that needs that.
>>>>
>>>> I guess it would address my concerns if we did that now. I don't see why
>>>> we need to wait for a second implementation for that though - the whole
>>>> series seems to be built around adding a framework for supporting
>>>> multiple algorithms even though only one exists. So I think we should
>>>> support that fully, or simplfy the whole thing and just assume the only
>>>> thing that exists is HMAT and get rid of the general interface until a
>>>> second algorithm comes along.
>>>
>>> We will need a general interface even for one algorithm implementation.
>>> Because it's not good to make a dax subsystem driver (dax/kmem) to
>>> depend on a ACPI subsystem driver (acpi/hmat).  We need some general
>>> interface at subsystem level (memory tier here) between them.
>>
>> I don't understand this argument. For a single algorithm it would be
>> simpler to just define acpi_hmat_calculate_adistance() and a static
>> inline version of it that returns -ENOENT when !CONFIG_ACPI than adding
>> a layer of indirection through notifier blocks. That breaks any
>> dependency on ACPI and there's plenty of precedent for this approach in
>> the kernel already.
>
> ACPI is a subsystem, so it's OK for dax/kmem to depends on CONFIG_ACPI.
> But HMAT is a driver of ACPI subsystem (controlled via
> CONFIG_ACPI_HMAT).  It's not good for a driver of DAX subsystem
> (dax/kmem) to depend on a *driver* of ACPI subsystem.
>
> Yes.  Technically, there's no hard wall to prevent this.  But I think
> that a good design should make drivers depends on subsystems or drivers
> of the same subsystem, NOT drivers of other subsystems.

Thanks, I wasn't really thinking of HMAT as an ACPI driver. I understand
where you're coming from but I really don't see the problem with using a
static inline. It doesn't create dependencies (you could still use
dax/kmem without ACPI) and results in smaller and easier to follow code.

IMHO it's far more obvious that a call to acpi_hmat_calcaulte_adist()
returns either a default if ACPI HMAT isn't configured or a calculated
value than it is to figure out what notifiers may or may not be
registered at runtime and what priority they may be called in from
mt_calc_adistance().

It appears you think that is a bad design, but I don't understand
why. What does this approach give us that a simpler approach wouldn't?
