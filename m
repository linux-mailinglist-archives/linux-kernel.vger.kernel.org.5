Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EC17CE158
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjJRPi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344750AbjJRPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:38:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C6A111;
        Wed, 18 Oct 2023 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697643532; x=1729179532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hR037pG90zo++4v1RwR5ofT7XlJQUPTVD88U34ILkV4=;
  b=Xv8JXoCgvuyuk87eWKcEqpdwIrTE+UstXhSM1HuQBDqN7GYtNXyPFB16
   PAiyKUWbr6N9RPg4tbhb5N+bFI1XFHjRmEiQyYiMEXjy3YT12vZFJzamn
   hIZlysK9uSclTOt/a/K5Oprpz83WnSBfCYsEdCDKZCeaPeC+3PoL5FE2+
   X2KqtdaEDjlwhzxQol0pfbqEJMLJkrCsQpPvFlnU5gIt0VsZECNF4M62+
   0ruyiUzVl0yo8bV6mPf1UxbmaEy1M8ReHawNLZgBucjaPAOymiY+wACjF
   IlmIWnRST7ZnOZjc0sNnv1RMT3y68kcawDx1Rv+Jx3OuqCTePVR3qcoMZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452512206"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="452512206"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 08:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1003847604"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="1003847604"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 08:38:51 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 08:38:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 08:38:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 08:38:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MesKsACVS1LNsv1T4kRxu7L8JzuR4gUKzy/Ih1YQuIVcbJzNhZsqBwUFqx1dGJzwnBszbunnkMlX0NopZMmdiXv45605MQHhJ9C+EGPKF0WpJe/HgtWiq35KLXNnbHrNJEUOuJlYMipp8YKv0ZzEQfmyyXkPPFEtDqw6WTHtoET3APO78KqFFbHfTnisQwaLl6sf19qzWNe2tVqEQzNR/W0vEaiOmnS1TcYQxiYhvepWXHHFP/pji7Gt7c4OlUYtIFN/omoq+ygrtvngo9AbqWpiP+aotXbkS5N67bXg+dR2uD6LbCtJ6ksvSLdwNDXEGEfApYRRh0P4nTDEBLbniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VV6n7ybnlZjWSKGZ8BYub8S2B6nq/pjE3wu+bsTsAg=;
 b=gEUeZQFsysEI1bzwt38AOaQFrqUztjwXQNfq++tJwliXjzaHktqeWdK+62+/wS5O1EfaquMvusAmHLVPK17YsqYXFYqUG17OJx/Nfw36iOq4DqjDFzRQuXRXy40UTK2f9oTu4bJm5gNbAIoXhpx0kM8dI4TaWr/0O9Bit9QsfM3VZOC1x2S/Icco1df7u5LTrpOsXB3Fql2qbNGAxekBuf4+6/LskxTPJesCV3kaJWGNX6nciEBhZIrrBCzTLPFTjjcvP1aZ++XHQ/NwzThIHslYY1crJLuYsmAbF1nVsQFiJDDWZLwRmX2UlUBe1US1CJFWF/4GakMyT1AIiiJkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SJ0PR11MB5136.namprd11.prod.outlook.com (2603:10b6:a03:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 15:38:49 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:38:49 +0000
Message-ID: <db9ac034-35db-417a-9328-b97e5f9a5a11@intel.com>
Date:   Wed, 18 Oct 2023 17:38:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] ACPI: NFIT: Replace acpi_driver with
 platform_driver
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
CC:     <rafael.j.wysocki@intel.com>, <andriy.shevchenko@intel.com>,
        <lenb@kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-6-michal.wilczynski@intel.com>
 <652ed155ef8e_780ef294f@dwillia2-xfh.jf.intel.com.notmuch>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <652ed155ef8e_780ef294f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::22) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SJ0PR11MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e7a8d5-f45b-477b-0b1d-08dbcff052cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gd2G0ZNLjFClEdseuu04r47gEByvA7e7ZZGBopgZlMpl7luAbRRHdASlEXx0dY6RNJ7ZnFyL6ptMisLKYqyU8yJBY52ImtQmRBLoZQuNaaDZmldaALiZ3fsQ7Ek6OyMBsAUweX4yZr7uqt+zGY+bfagUl/dRhEx9fhgbeeEqOEo8GwefxiCYhMIncXifkBu1S+qyUfWFesl4BTNXt7YenUnZYSYV9i1uEr1fX+VjkeavCRIL8pa+7rTszvow6KNy10GxrTaQh42YOXBHoDRzuXwugzNa5Q39fmVsTGwRF+Q0iilKc7gEVteNsX4ygqyfMZ6of+NUJY4UR16YoWieGfGYJvFIL3OdNSWxmrLw5nrVKNGuA8pk6+X8G4jP+2uM0ZmxFNTJq6S/a+ZA40ynqdEfsRgJ2GnLnpoL09XoeBA9jvfawJ41tI088RK3/ns8ZPhX9/ZzAQsiXPbG/eTOXTu54irEPW+fRJz4XuMuB+LICT662RCiuUum+SiWtOyXiWnRm8xTGFkRvVyZjWjBXBXmq2cxwE5B92SLqJk33zIW7aUHOXg8vY5Yx/QN/SkcaCfgdGMxw8eT7b4XBi8TnpVc8VvTrwT0vYrp+LHGCrXSeKNB4V5nPyHpsZHIDlUwRqhkwmPMHLHtf+/ejyM/jQCWEBAYc1AMBLw1oA/xrAXwpftPqN79mZuJqNeNd9QJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(5660300002)(38100700002)(966005)(41300700001)(316002)(66946007)(66476007)(66556008)(8676002)(6486002)(4326008)(8936002)(107886003)(2616005)(6666004)(83380400001)(6512007)(26005)(82960400001)(2906002)(36756003)(31696002)(86362001)(31686004)(478600001)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlRkWXBUQzJ0V2dvMzRyQllRa0ZDWFNieS9mT1pqVWtJRUxWTlVLcHZYRGkw?=
 =?utf-8?B?ZzRaQllDOUtUbTJLd3NINnU0anFvaUxPK3E2Vkg0eVhWWXE0ZWViSUVBajZo?=
 =?utf-8?B?RkQ4RzlkWi9aM3Z5QXQxUThRR0lUNk5TNWV6OVZ6YWRwYjhlT2djN2xJcUNL?=
 =?utf-8?B?VTkzK013K2RzK0I3am44eHF5SWNPbXhRVW83NEdWamd0VkQyN2dpOGFKSkxW?=
 =?utf-8?B?Q0dvU0JaWGZXMHNYWm1lVGZxYlVqR0U1REd3SjRmdUhWTkZhWkR1Tk44aWRU?=
 =?utf-8?B?b3BNTFVKVUNpRWoyd2tRY2l4d1g0TjIvTFUzbDZHOURINXc4aHdZWEYrUmJ5?=
 =?utf-8?B?ZUduUXo5eHBDVU8xZVFFK1JoaHFoLzQyWlJENjhIeWRhK2FjWS84N2lXTVZo?=
 =?utf-8?B?Ky9ic2xxZDlqZlgwY1BocVhTaWJwNDlJWU9jOGFPVjN5cUxMY1B4LzRzU0px?=
 =?utf-8?B?ZkZHRVJXWk1SUENuc0t3NjBmQjhPckdpWlFKUWduQldsQkt2UktZeXR1TE9D?=
 =?utf-8?B?RW54UjNlRG93a2ZmMjdmT1J6T1dOQ09xdFljMDArUTNoZlVnWU5jY1NOV081?=
 =?utf-8?B?VFdEMG1scytDaHdObTVsTjUrd3hDZWwwbXRNbit6UUJybkxRM0tFL1E3bHNy?=
 =?utf-8?B?MEpMeE1PQXR5d0pXc0Q0d3JhTjM2Snp4a0FndjNxYWJ4aE9FbW5HQTZGd2tz?=
 =?utf-8?B?T0EwV05xdXIrMDM3cENzMXVXWVZEdHRXaGR5S3M4Z2V5VFJhb1JSY0ZyNXRZ?=
 =?utf-8?B?Skd2YzZQRENGQnhVMStsRUNMMU1MTlFraU96WDVLK0orZnFNekk0Mkg5aWJQ?=
 =?utf-8?B?eDJEUjZOVWwySnV2QU94NUdZWTNYa1VZRldWMnBMR0svc24zT3I4ZVZTK0FU?=
 =?utf-8?B?SzdHQThGalAzdXBQLzZjUUlZeU15eEQzd2ZQWGRJTlpKaG9IT2J2RFFQYVQz?=
 =?utf-8?B?M3VEMUI2ajlqSGhQQTFoMWlGcEVueGpIQi9oUTAxVWZaY0tDSWplQWxkU2NO?=
 =?utf-8?B?RFQxWHJldCt3TmVRc0lVT0hHYWgxWEZCSDZvWG1acDhwSmVFTEtnaHVkZEdj?=
 =?utf-8?B?U1JVc0p0UTRwcGZvZzd1SzVYQ3VzNVIxVVU5clR2Y0pYNGZScnR2UDN1UTcr?=
 =?utf-8?B?dEpOY3V3U1QybnU2b2V4NDRMbUorRC9EMW01bUpKZU5ZNC9kaks2akFENXFn?=
 =?utf-8?B?L011OWpoOGsrUXErM2VCQ3pDTERXTWlTcVBDNXFWZ0ZjaW5yU0VvWERNdGNp?=
 =?utf-8?B?Q1dwUWpTR3VKVUlxTXQ0eFRObUZBdVh1NWpOVHYwTmZwTVo1Z1N4djlQNVky?=
 =?utf-8?B?WEFRMVVqWWdEUXZVTG45cFdhWFY3amtRLzVmeUJ1aTBkZS9LVit6Y2JQc3c2?=
 =?utf-8?B?dGsrTFc3Q0liMlB3am5KQUFOWTQ4Sy80M2JqWDRIN29kUmFHOWk3WlR2dXpX?=
 =?utf-8?B?dHRpZTdYZjBjVTd4Sk9iSUlsang1K0xGNllwQS9hL1A0QzNwL1JuK0UyTlBL?=
 =?utf-8?B?d3JOYjl0cUVPanM3NG5LbFhJbzdpNXdiakxoSFBKS05RYzZOL2NiazlhOEdm?=
 =?utf-8?B?cmg1VGFZNDU4VkRNNURoNXdSb1dNMXMrdzZUaFhYN3BTbTJrbFo0Vkd0Sk9Z?=
 =?utf-8?B?WHc5WWM0VFZWQ2YzU3QvcmZKTDVQYnl4ellXSmJaZFZzWGhyRmdpTnFWZVlK?=
 =?utf-8?B?S0RTYVRVbVFVZ2cvR3JYVmJReUtpY2JHUCtXYVBiMms3R1kyWURhU3VrTUNx?=
 =?utf-8?B?ckwwWVdvd1NlMWo5N081RjVvUGF3TFhiUGxQeUYzQ2F1UENXUGhVYzN5aytR?=
 =?utf-8?B?OTNOeWsrc3dXTktuSzZvMjdHMXNzREZsUGg1bHJHMTRIMXk2MndETTV5eW9J?=
 =?utf-8?B?TkRXUVNZYVdQRklTbXRsUHBCWkNxd2ZHdCt4aHc5TUplaEN0Q24yZGlaemYy?=
 =?utf-8?B?NXVWLzVReTkvTVFsbWNIL3d2WlVEcDNCaXJhL2s2WHlQUEN3YldVdGMybkU4?=
 =?utf-8?B?YnNHRGR2d0YrNjVyeWYvYjUzZUlLZ0VCbGFlOFUvNWN2LzVQelVwbDgzQ2xz?=
 =?utf-8?B?a2V5azk3ZFF6c09ybEpWS1lMdnlCTXdLY09VeHc5c2pwRW5ZU05qdHVHSFdx?=
 =?utf-8?B?b01INDhiTG1vWWJKRU5iMUwydWRpWjdRWnFua3pjY3MzdmMyQWpNeElpRTBk?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e7a8d5-f45b-477b-0b1d-08dbcff052cb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:38:49.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PM14BpfH3E1jnVZ0ZG3lW+T8Pv8sNaQrgxutfrx6jDZeXF0O4lmJTagsKDfrqc+exyDIkV9khOOYJUttHKosLrp4u3OLBaBH9droo8jcsgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2023 8:24 PM, Dan Williams wrote:
> Michal Wilczynski wrote:
>> NFIT driver uses struct acpi_driver incorrectly to register itself.
>> This is wrong as the instances of the ACPI devices are not meant
>> to be literal devices, they're supposed to describe ACPI entry of a
>> particular device.
>>
>> Use platform_driver instead of acpi_driver. In relevant places call
>> platform devices instances pdev to make a distinction with ACPI
>> devices instances.
>>
>> NFIT driver uses devm_*() family of functions extensively. This change
>> has no impact on correct functioning of the whole devm_*() family of
>> functions, since the lifecycle of the device stays the same. It is still
>> being created during the enumeration, and destroyed on platform device
>> removal.
> I notice this verbiage has the same fundamental misunderstanding of devm
> allocation lifetime as the acpi_nfit_init_interleave_set() discussion.
> The devm allocation lifetime typically starts in driver->probe() and
> ends either with driver->probe() failure, or the driver->remove() call.
> Note that the driver->remove() call is invoked not only for
> platform-device removal, but also driver "unbind" events. So the
> "destroyed on platform device removal" is the least likely way that
> these allocations are torn down given ACPI0012 devices are never
> removed.
>
> Outside of that, my main concern about this patch is that I expect it
> breaks unit tests. The infrastructure in
> tools/testing/nvdimm/test/nfit.c emulates an ACPI0012 device that allows
> for deeper regression testing given hardware is difficult to come by,
> and because QEMU does not implement some of the tricky corner cases that
> the unit tests cover.
>
> This needs to pass tests, but fair warning, 
> tools/testing/nvdimm/test/nfit.c does some non-idiomatic + "strange"
> things to achieve deeper test coverage. So I expect that if this breaks
> tests as I expect the effort needed to fix the emulation could be
> significant.
>
> If you want to give running the tests a try the easiest would be to use
> "run_qemu.sh" with --nfit-test option [1], or you can try to setup an
> environment manually using the ndctl instructions [2].
>
> [1]: https://github.com/pmem/run_qemu
> [2]: https://github.com/pmem/ndctl#readme

Thanks a lot !
I will run qemu tests and fix the verbiage,

Michał


