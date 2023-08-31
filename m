Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D778778F1E6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbjHaR2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjHaR2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:28:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A4AE5E;
        Thu, 31 Aug 2023 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693502898; x=1725038898;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qfgpQe8JSD80zPn6b4jsimP/HhM7LmqNAyM+K4Ls1rM=;
  b=DPvRo67ZlqG40lQvYXYmRtmbmC9Z/Ex+DtsR5BxTRjl0mqKiXDYrCxpt
   cPmk110w4bo0tZMzrrZBLnNoobVQhU4uJmfVVI8GCflHjh+PEs9I/UBQY
   US8xgePQG4XY/ZXb62gQgOJ/maUDZR2AIMbOoyJUlvKdTM8lZrNzlhDDw
   CB1KUx2fChPB1jduEES21L6e4xBdK68Do+j7AbRBeGOU9Qlf7JBe2uDgs
   5X9cfOind6SVz3EhAKcKMuKFnw3NGUHa0k/Dxqz1Bw61qwQSlfNdGv5/O
   cja1insTRXRjWyTAHFPv+qr1GFIGPkOPd3dG5Q/HycRgRo9uS1OoXR0xD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="442408407"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="442408407"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 10:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="809726588"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="809726588"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 10:28:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 10:28:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 10:28:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 10:28:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 10:28:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6l2JGRmxSsFjwx+bLd1rjhjEg9fngYN6UL4fwvXyeTtB8AJVLQv4aEOiEWaU353cSPcXPEORXbe55EcWHvSRVSlK6Ro9UyCNyQPcJwiT6Chh863ULyS1NeJcb7LBLF8PUsIsCd58oJrg0yt2ybkGtMFqrZQ3Z7MxxJiFksYLW1VgaBwsykqwYA9eEvxvjyh5N+cEWkMatMmBzuqDVxZgpZOdYAg5VmVZ6ET6CCq6NySy2MLStcEnqJFRI0BZkn/Y4JhntK55pE9ifHG6RCzDtnr6g7hVNxL2BZ7vYIjha9OaIbJowubnFYGh061lVQ9Apxy0+8RlVElAUCZZOceUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjE8K5iJKL6kgPdA50C35X6mammm0DU7P7xlkFxP0HU=;
 b=bPzwpsro9HTavxHmpBN8DPjSTGJsWLwwBTru+i7wTEz9gYI3AbyWLBYJXWCT2+SCrj6hZB+fqmvAsJ4fgxHvBy4xUqwMdcpYNflovzqWYC0R7agGMaqKHLJJEafG7cZROzXjEfVeuTDvQt9efWl51UmnV/rqG+RA5Yb+PsIVpqTvj1TKu04S8nXroB5q7Cv0kslYGAHvznk3fdE0E4btnAyEctma2AIN+UKew0oViImUnB4mztyPH3zVweON4C4jvaB+K1m8Lm+Npv8zj8JuQL/zl6aW2cRxGyuUqVARj0IEJyxOBrh9F4nm/6YECAbBvre0bKqC6uraxknDkk3YAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Thu, 31 Aug
 2023 17:28:13 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 17:28:13 +0000
Message-ID: <3546729d-d67d-fc93-5c03-fc864fd23b4e@intel.com>
Date:   Thu, 31 Aug 2023 10:28:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH RFC v2 10/18] cxl/mem: Handle DCD add and release capacity
 events.
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-10-f740c47e7916@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-10-f740c47e7916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY5PR11MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 283232bb-ed5a-4c89-fd4b-08dbaa47a739
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6kXi9p3Ss6pMT+c0ESjHumapc/ozeYnp5A8ohO1lilsdH1h9hp4peyamxl9RGTwdBzmYTnHkD4PuGyW/Irj3Nx5ZKkC3HercVdXcWpZ4soP/QsM35o3drMYIPip4dV6liYo3MKZI/Ncd3fLXIvFvp0X7JDOkG3NiQsnodD+PUofDCDCP9hy1+epsC1hqOD6UhwYvtRpwB/bVGo1TLxZJZ6ZbheBEopElVugowdUohX+px5wWHw9udhCHbig//PVAjEXL4Y7ivwYqHDd4DzdPayZVvnVq2dbgMIgX0w+kYTQb17a4Zv+LsXBvGdVS7L5tfrkDqOj/s8V+S5lPfEm6LNOfFNBsScLmaUh8W9SHJrkml8suicCCZRlhLP+OalS2WVQ7Aokdv1Y4FJaOytag3ZokkSFatI5zAkGgGGyadDQ4x7B5dHDZZ+pQ6fAtwGFgNyPi3cu50yO3BbERq6WMf85bnmEIvK+Y8xPUwlC0+uvJG0F5o+YSJk5yRkQCWDZOflWIGk+t36hlKkIVZyG1HBovo6meOnL9cZH+2EAHNDIF58dU0XkdBDhUP2liI5mIg+sMhZAzvDVHPa+2lWh7R1ZGHIojmJ5jvkhvcoJUk8hggva5SxiW+LHyLQKFsHIScjj3PmajCTyynzJVqJxeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(8936002)(6666004)(478600001)(110136005)(53546011)(31686004)(66946007)(66556008)(6506007)(66476007)(6486002)(54906003)(6636002)(316002)(38100700002)(41300700001)(66899024)(82960400001)(6512007)(44832011)(26005)(83380400001)(5660300002)(36756003)(2616005)(31696002)(2906002)(86362001)(30864003)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmFrcisrU2FmdWViY1lyaW9wUTNpenN3VEZlUkhjMlplb1ZhSVNLb2FtQlQ0?=
 =?utf-8?B?dWozZURqT1B6WmhKOGUreW5JQ1NjYWlGajFRYW8xRWIxWUtDdUNweEtTMW90?=
 =?utf-8?B?U0FBVk1nWTZuZkZOUzU4cHlWMlpsL05oYzZPM2pxNmpjQlhOUmNTbU90U2k0?=
 =?utf-8?B?bjAwMUdVdHFjSzk3ZlRPT052bWwrRTh4Q09RUmJsa3JmdmxxemVjN3hIUmFa?=
 =?utf-8?B?N3p2Mkk2dy93T2d1Snd6MWZqYnFCTllRcmZjZzlXaFMwZ0JLYnhFY1FWZENl?=
 =?utf-8?B?eVV4L0VWbVFpVTkwSXdwVnIvRXZqQzJQMzVneXVPdG5mK3cxNEt5NmN4ZzR4?=
 =?utf-8?B?bmRhcS9aU2NPTkxQaFF1WkIrQ3BLRHNYVHJRYTZrbHRsSSsycEVVZ1FzOStL?=
 =?utf-8?B?dVBMV08wb3FiZ0xwcWRReEdTVmhaclFqYlVTKzMzU1k1dUVoU3RvMUlqU3M0?=
 =?utf-8?B?aGVJRDZGV0hjWTlYQTZSMHRndnVBZjZoYnMxZGJwa3hVQWdra2F1TFJrdUM2?=
 =?utf-8?B?MUppbmt6bGgvQ05EZldHNXFlc2JlN01OMHNkbDJwMmZmZVhOOWdsNXVpUkYx?=
 =?utf-8?B?TE1aRjVVYW1ldGNrZ3dUSzJMUDM4dUJwN0V4NHdiamZtTTc3UU0rS2ZUSWEz?=
 =?utf-8?B?R3dwMWMxbWtTemxNL3B1bnBsMjBzSk96eTcrOGtyRm5ObmV0cUM0UG5ONzR3?=
 =?utf-8?B?OHR5Sy9kdXg0ZHhybS9kTWhhcHozVkRBS3dScHozZ1VzUm5oSXJNNjdZRk92?=
 =?utf-8?B?SmkyTzNFVDZ2bmd2NjNsRHBmSFFtb2YrU3FPUW1kY2srSVc1bTk3MkFRKzBR?=
 =?utf-8?B?ODZNY3dRdURxa3NYYUltNXdBcll2dndhTHptQjVZeFF2dEUzMkxzOGkyQU5L?=
 =?utf-8?B?Rk5XK1dZZCsrQVRmOGZtdjZBS0hIQjJCVmM2UG5VMnFrRmJtM3h5N1pocVF3?=
 =?utf-8?B?SmRmdzVCT3pRZ0NoUjNxeU9TTjFmK2M5RFVtaG02bmM5aE1rK0Z6QzlWNjNS?=
 =?utf-8?B?NGdpUEo0MFhad1dhREZET3FQZGUvczc0TUdOcm0zU2owZ2xyejl4TW56dldH?=
 =?utf-8?B?b0VSMG11MzFXSUtDaURwWlI5REwwSFoxRDJDZEh0bjJQQ1RaRlIyZG51cU05?=
 =?utf-8?B?VkpzQS9RcnFMakRuOW9VbTlKYVJDdWtrWnJtVGRlTkFEVEd1Yi9abFJwblBm?=
 =?utf-8?B?cFlpdVFWZHlGTXl1YVQ5dDlRclpBSGpoMVQvZHF5bjNJQXR1dWNFQnNCeFhk?=
 =?utf-8?B?RFhaekdDeWZPWTNyU0tCZEVKYnk2UW9KOC9ZaGZyd3B6RkE4eS8wWmNKVnMw?=
 =?utf-8?B?NENtWEFBNi9wUUtYN1A4RklEdHVPYjh1WXVXbHo1MEZqYldFdzFZRkVyTGlZ?=
 =?utf-8?B?WUxjL1AzMVhLM0dVUTZuMDFCamp3VGkvb2VJWlFRUkltVk1aaW1aTUZUbEJV?=
 =?utf-8?B?M05DWlRnekJRQjNPejIrbE1MZTQ0azM5RFMvay9majhkU2syeGdtMytXb1lB?=
 =?utf-8?B?TlZNVENYM1JjeHlyM2pLT2xjQVZuZUs5Nk92a0h1ZmVUc2thSDlnK2RhL1Zl?=
 =?utf-8?B?UjVjemFxUTZ4MXduZ2dGaUJVUHJaZFJ0aW9yZ0V3c2VvUXNQN0k1L3hqY1M3?=
 =?utf-8?B?SXZEUnE2cVV6ekdTU3l0Y1d5Z1hDOHBGYjZaQVFpY3V5cC8waXhuVWdobVRQ?=
 =?utf-8?B?bUpJbDNDQlJSbnZ3YnEvWHZzS1BIOCszVWJrSXVORlZYZ29uTFBoOUdTK3hI?=
 =?utf-8?B?MXBqNS9PNy9SV29zNm9lMndzZHFEUUtaR2FYczZudG1GMlB4R21zYk1PMEs5?=
 =?utf-8?B?RGdEQWo4TUJwcDVxUWRhVkFVYWhZdTdTQmRaZUlqRThWYTlCZ285OEd3ZXFC?=
 =?utf-8?B?YnVFdUhNcDdQRFR1ZDBBSGhDcW8zWndHUzBrVWNDeDRvQklobkM2bTVDYWNm?=
 =?utf-8?B?YWtVK2IxU0tCKzA2WDU0cjI4MzRUSTUxeXk4ZVp4OW9HTDJvek94WlBCNFM5?=
 =?utf-8?B?NnlPYnRtYTJyVngwYnZMcGpadDVuMVlXTThHcXNyeS9TOEpXRFRYdVFBSG41?=
 =?utf-8?B?Y3ptZldSczAxcGJNcTRSaGFSQnpsa2Q2Y29pemZRWGg0RjIyeFNJUkV5UEVF?=
 =?utf-8?Q?7BIXQeKORd7PQQWXa6b0pZEUJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 283232bb-ed5a-4c89-fd4b-08dbaa47a739
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:28:13.0190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D09LRt9EZF86UglgMC4AVC8rhMgoEPQWlCXZlhhl5StYG6+9IzvUBHVLc+a5Kh43h4K9VmzHCm8bHaZot949qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 22:21, Ira Weiny wrote:
> A Dynamic Capacity Device (DCD) utilizes events to signal the host about
> the changes to the allocation of Dynamic Capacity (DC) extents. The
> device communicates the state of DC extents through an extent list that
> describes the starting DPA, length, and meta data of the blocks the host
> can access.
> 
> Process the dynamic capacity add and release events.  The addition or
> removal of extents can occur at any time.  Adding asynchronous memory is
> straight forward.  Also remember the host is under no obligation to
> respond to a release event until it is done with the memory.  Introduce
> extent kref's to handle the delay of extent release.
> 
> In the case of a force removal, access to the memory will fail and may
> cause a crash.  However, the extent tracking object is preserved for the
> region to safely tear down as long as the memory is not accessed.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> changes for v2:
> [iweiny: Totally new version of the patch]
> [iweiny: use kref to track when to release an extent]
> [iweiny: rebased to latest master/type2 work]
> [iweiny: use a kref to track if extents are being referenced]
> [alison: align commit message paragraphs]
> [alison: remove unnecessary return]
> [iweiny: Adjust for the new __devm_cxl_add_dax_region()]
> [navneet: Fix debug prints in adding/releasing extent]
> [alison: deal with odd if/else logic]
> [alison: reverse x-tree]
> [alison: reverse x-tree]
> [alison: s/total_extent_cnt/count/]
> [alison: make handle event reverse x-tree]
> [alison: cleanup/shorten/remove handle event comment]
> [iweiny/Alison: refactor cxl_handle_dcd_event_records function]
> [iweiny: keep cxl_dc_extent_data local to mbox.c]
> [jonathan: eliminate 'rc']
> [iweiny: use proper type for mailbox size]
> [jonathan: put dc_extents on the stack]
> [jonathan: use direct returns instead of goto]
> [iweiny: Clean up comment]
> [Jonathan: define CXL_DC_EXTENT_TAG_LEN]
> [Jonathan: remove extraneous changes]
> [Jonathan: fix blank line issues]
> ---
>   drivers/cxl/core/mbox.c | 186 +++++++++++++++++++++++++++++++++++++++++++++++-
>   drivers/cxl/cxl.h       |   9 +++
>   drivers/cxl/cxlmem.h    |  30 ++++++++
>   3 files changed, 224 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9b08c40ef484..8474a28b16ca 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -839,6 +839,8 @@ static int cxl_store_dc_extent(struct cxl_memdev_state *mds,
>   	extent->length = le64_to_cpu(dc_extent->length);
>   	memcpy(extent->tag, dc_extent->tag, sizeof(extent->tag));
>   	extent->shared_extent_seq = le16_to_cpu(dc_extent->shared_extn_seq);
> +	kref_init(&extent->region_ref);
> +	extent->mds = mds;
>   
>   	dev_dbg(dev, "dynamic capacity extent DPA:0x%llx LEN:%llx\n",
>   		extent->dpa_start, extent->length);
> @@ -879,6 +881,14 @@ static const uuid_t mem_mod_event_uuid =
>   	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
>   		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
>   
> +/*
> + * Dynamic Capacity Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +static const uuid_t dc_event_uuid =
> +	UUID_INIT(0xca95afa7, 0xf183, 0x4018, 0x8c,
> +		  0x2f, 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a);
> +
>   static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>   				   enum cxl_event_log_type type,
>   				   struct cxl_event_record_raw *record)
> @@ -973,6 +983,171 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>   	return rc;
>   }
>   
> +static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
> +				struct cxl_mbox_dc_response *res,
> +				int extent_cnt, int opcode)
> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t size;
> +
> +	size = struct_size(res, extent_list, extent_cnt);
> +	res->extent_list_size = cpu_to_le32(extent_cnt);
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = opcode,
> +		.size_in = size,
> +		.payload_in = res,
> +	};
> +
> +	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +}
> +
> +static int cxl_prepare_ext_list(struct cxl_mbox_dc_response **res,
> +				int *n, struct range *extent)
> +{
> +	struct cxl_mbox_dc_response *dc_res;
> +	unsigned int size;
> +
> +	if (!extent)
> +		size = struct_size(dc_res, extent_list, 0);
> +	else
> +		size = struct_size(dc_res, extent_list, *n + 1);
> +
> +	dc_res = krealloc(*res, size, GFP_KERNEL);
> +	if (!dc_res)
> +		return -ENOMEM;
> +
> +	if (extent) {
> +		dc_res->extent_list[*n].dpa_start = cpu_to_le64(extent->start);
> +		memset(dc_res->extent_list[*n].reserved, 0, 8);
> +		dc_res->extent_list[*n].length = cpu_to_le64(range_len(extent));
> +		(*n)++;
> +	}
> +
> +	*res = dc_res;
> +	return 0;
> +}
> +
> +static void dc_extent_release(struct kref *kref)
> +{
> +	struct cxl_dc_extent_data *extent = container_of(kref,
> +						struct cxl_dc_extent_data,
> +						region_ref);
> +	struct cxl_memdev_state *mds = extent->mds;
> +	struct cxl_mbox_dc_response *dc_res = NULL;
> +	struct range rel_range = (struct range) {
> +		.start = extent->dpa_start,
> +		.end = extent->dpa_start + extent->length - 1,
> +	};
> +	struct device *dev = mds->cxlds.dev;
> +	int extent_cnt = 0, rc;
> +
> +	rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, &rel_range);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to create release response %d\n", rc);
> +		goto free_extent;
> +	}
> +	rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
> +				      CXL_MBOX_OP_RELEASE_DC);
> +	kfree(dc_res);
> +
> +free_extent:
> +	kfree(extent);
> +}
> +
> +void cxl_dc_extent_put(struct cxl_dc_extent_data *extent)
> +{
> +	kref_put(&extent->region_ref, dc_extent_release);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dc_extent_put, CXL);
> +
> +static int cxl_handle_dcd_release_event(struct cxl_memdev_state *mds,
> +					struct cxl_dc_extent *rel_extent)
> +{
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_dc_extent_data *extent;
> +	resource_size_t dpa, size;
> +
> +	dpa = le64_to_cpu(rel_extent->start_dpa);
> +	size = le64_to_cpu(rel_extent->length);
> +	dev_dbg(dev, "Release DC extent DPA:0x%llx LEN:%llx\n",
> +		dpa, size);
> +
> +	extent = xa_erase(&mds->dc_extent_list, dpa);
> +	if (!extent) {
> +		dev_err(dev, "No extent found with DPA:0x%llx\n", dpa);
> +		return -EINVAL;
> +	}
> +	cxl_dc_extent_put(extent);
> +	return 0;
> +}
> +
> +static int cxl_handle_dcd_add_event(struct cxl_memdev_state *mds,
> +				    struct cxl_dc_extent *add_extent)
> +{
> +	struct cxl_mbox_dc_response *dc_res = NULL;
> +	struct range alloc_range, *resp_range;
> +	struct device *dev = mds->cxlds.dev;
> +	int extent_cnt = 0;
> +	int rc;
> +
> +	dev_dbg(dev, "Add DC extent DPA:0x%llx LEN:%llx\n",
> +		le64_to_cpu(add_extent->start_dpa),
> +		le64_to_cpu(add_extent->length));
> +
> +	alloc_range = (struct range){
> +		.start = le64_to_cpu(add_extent->start_dpa),
> +		.end = le64_to_cpu(add_extent->start_dpa) +
> +			le64_to_cpu(add_extent->length) - 1,
> +	};
> +	resp_range = &alloc_range;
> +
> +	rc = cxl_store_dc_extent(mds, add_extent);
> +	if (rc) {
> +		dev_dbg(dev, "unconsumed DC extent DPA:0x%llx LEN:%llx\n",
> +			le64_to_cpu(add_extent->start_dpa),
> +			le64_to_cpu(add_extent->length));
> +		resp_range = NULL;
> +	}
> +
> +	rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, resp_range);
> +	if (rc < 0) {
> +		dev_err(dev, "Couldn't create extent list %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
> +				      CXL_MBOX_OP_ADD_DC_RESPONSE);
> +	kfree(dc_res);
> +	return rc;
> +}
> +
> +/* Returns 0 if the event was handled successfully. */
Is this comment necessary?

> +static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
> +					struct cxl_event_record_raw *rec)
> +{
> +	struct dcd_event_dyn_cap *record = (struct dcd_event_dyn_cap *)rec;
> +	uuid_t *id = &rec->hdr.id;
> +	int rc;
> +
> +	if (!uuid_equal(id, &dc_event_uuid))
> +		return -EINVAL;
> +
> +	switch (record->data.event_type) {
> +	case DCD_ADD_CAPACITY:
> +		rc = cxl_handle_dcd_add_event(mds, &record->data.extent);

Just return?
> +		break;
> +	case DCD_RELEASE_CAPACITY:
> +        case DCD_FORCED_CAPACITY_RELEASE:

Extra 2 spaces of indentation?

> +		rc = cxl_handle_dcd_release_event(mds, &record->data.extent);

Same here about return.

DJ

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +
>   static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   				    enum cxl_event_log_type type)
>   {
> @@ -1016,6 +1191,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   				le16_to_cpu(payload->records[i].hdr.handle));
>   			cxl_event_trace_record(cxlmd, type,
>   					       &payload->records[i]);
> +			if (type == CXL_EVENT_TYPE_DCD) {
> +				rc = cxl_handle_dcd_event_records(mds,
> +								  &payload->records[i]);
> +				if (rc)
> +					dev_err_ratelimited(dev, "dcd event failed: %d\n",
> +							    rc);
> +			}
>   		}
>   
>   		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> @@ -1056,6 +1238,8 @@ void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
>   		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
>   	if (status & CXLDEV_EVENT_STATUS_INFO)
>   		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
> +	if (status & CXLDEV_EVENT_STATUS_DCD)
> +		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_DCD);
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
>   
> @@ -1712,7 +1896,7 @@ static void cxl_destroy_mds(void *_mds)
>   
>   	xa_for_each(&mds->dc_extent_list, index, extent) {
>   		xa_erase(&mds->dc_extent_list, index);
> -		kfree(extent);
> +		cxl_dc_extent_put(extent);
>   	}
>   	xa_destroy(&mds->dc_extent_list);
>   }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0a225b0c20bf..81ca76ae1d02 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -163,6 +163,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>   #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
>   #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
>   #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> +#define CXLDEV_EVENT_STATUS_DCD                 BIT(4)
>   
>   #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
>   				 CXLDEV_EVENT_STATUS_WARN |	\
> @@ -601,6 +602,14 @@ struct cxl_pmem_region {
>   	struct cxl_pmem_region_mapping mapping[];
>   };
>   
> +/* See CXL 3.0 8.2.9.2.1.5 */
> +enum dc_event {
> +        DCD_ADD_CAPACITY,
> +        DCD_RELEASE_CAPACITY,
> +        DCD_FORCED_CAPACITY_RELEASE,
> +        DCD_REGION_CONFIGURATION_UPDATED,
> +};
> +
>   struct cxl_dax_region {
>   	struct device dev;
>   	struct cxl_region *cxlr;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ad690600c1b9..118392229174 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -582,6 +582,16 @@ enum cxl_opcode {
>   	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
>   		  0x40, 0x3d, 0x86)
>   
> +struct cxl_mbox_dc_response {
> +	__le32 extent_list_size;
> +	u8 reserved[4];
> +	struct updated_extent_list {
> +		__le64 dpa_start;
> +		__le64 length;
> +		u8 reserved[8];
> +	} __packed extent_list[];
> +} __packed;
> +
>   struct cxl_mbox_get_supported_logs {
>   	__le16 entries;
>   	u8 rsvd[6];
> @@ -667,6 +677,7 @@ enum cxl_event_log_type {
>   	CXL_EVENT_TYPE_WARN,
>   	CXL_EVENT_TYPE_FAIL,
>   	CXL_EVENT_TYPE_FATAL,
> +	CXL_EVENT_TYPE_DCD,
>   	CXL_EVENT_TYPE_MAX
>   };
>   
> @@ -757,6 +768,8 @@ struct cxl_dc_extent_data {
>   	u64 length;
>   	u8 tag[CXL_DC_EXTENT_TAG_LEN];
>   	u16 shared_extent_seq;
> +	struct cxl_memdev_state *mds;
> +	struct kref region_ref;
>   };
>   
>   /*
> @@ -771,6 +784,21 @@ struct cxl_dc_extent {
>   	u8 reserved[6];
>   } __packed;
>   
> +struct dcd_record_data {
> +	u8 event_type;
> +	u8 reserved;
> +	__le16 host_id;
> +	u8 region_index;
> +	u8 reserved1[3];
> +	struct cxl_dc_extent extent;
> +	u8 reserved2[32];
> +} __packed;
> +
> +struct dcd_event_dyn_cap {
> +	struct cxl_event_record_hdr hdr;
> +	struct dcd_record_data data;
> +} __packed;
> +
>   struct cxl_mbox_get_partition_info {
>   	__le64 active_volatile_cap;
>   	__le64 active_persistent_cap;
> @@ -974,6 +1002,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>   int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>   int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>   
> +void cxl_dc_extent_put(struct cxl_dc_extent_data *extent);
> +
>   #ifdef CONFIG_CXL_SUSPEND
>   void cxl_mem_active_inc(void);
>   void cxl_mem_active_dec(void);
> 
