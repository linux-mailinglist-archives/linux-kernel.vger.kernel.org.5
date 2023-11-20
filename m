Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6107F2024
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjKTWWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKTWWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:22:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B9CA;
        Mon, 20 Nov 2023 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700518932; x=1732054932;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xjUvBJTTQnZp3m+hVm9BSG9vJvnsE8/fJMpy6S/WRZU=;
  b=j2pIjZh4EW7r3BmS2/W6MtT2+7+MLGaIsLZhmdU+16i4+HKzZsInhFdh
   Vpj5kfxssb++07TUfGi2qsrk2cX+eSyN4QULPu24SDn0EIr8jkA2oWFps
   riAmtCZX5PsCh7xqt/9vb/D3cUhr8PIlNi0YUK4r6NJb8RRcI9bD9FMi1
   A8tOKFfj/K/7REtOCvcpnNZfxze2NRMf4ta+GEdOs0t/MvRdRvgyePUbI
   s1M44rxl7HkwN4BDbOxbGSz7FjRoIsB8y4uHatBr5nmgwdYYUbEewIf6e
   IXpZoYp/ZTNCWCSaNGupfg317F7ipvVcfS2uQUOimTBpXlt+DEwgKdD6G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371058746"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="371058746"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="857130558"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="857130558"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 14:22:10 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:22:10 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:22:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 14:22:09 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 14:22:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hShgusPkQ7E4FuINarcvPvWy5e8M5+/+hzyi5tW2THg6f8AJd/2KLJ+R8u/sjwSTT3IKIUFjBUvd8YlcFZ0Yss9ZgqJmADNP0kHInpQjKKVw/37X8DbfOWJujOA9EM8QIFPAugYgyMbvNpimagS8aa+GfI/5+Ik7XElxDh3jN5OAIKC/ckr96n16nx4PV/dxE4SPdt7Uok/+GA77yftEjMClRiZ68oUxNEmpfgTxEBmvIztnjVNNOOHBinN+3sg6+IY7npPoqhSVr26lXh05qcdrlKz6ohgIlKhPh/C/aQXKgKuirDxXx4iNlYBD73W4A/u/RChZhGnQw6tQXsaVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzT80QX3mmyQLY3QkbgBVRpp3fZ3SvBnvvPTosF25wc=;
 b=LWaaEJI7/B7d538uhzlaq8sIW4g8X8UmqZlAvQQ0yVmRg7IPy5mqHy5KXoEyT3MbwwVwwjMiESXGvx0L16w3H2OrMRovAloKduhdaGdwwa5MAmmnWygwebpYinn0wV1IPGEkYWIURz3FFzAao2BF6ytpqdurbc93RkyYvNMNrdTMZOLEt7rakN72/tpUdAOfjjJxlXtvl3dGmhOuem4KGQokKZsSko2YFFmxPHiecHVh/jE2VNePCK+Vr6AzreEEV+bnedzU0dxVVu3sYepks1zzuSLH+O6mR2/oxaXVsyx13rgT5fiCDu65jmcG2wZTBXefEsZNpCWjNNHcSMTTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7797.namprd11.prod.outlook.com (2603:10b6:930:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 22:22:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7002.019; Mon, 20 Nov 2023
 22:22:06 +0000
Message-ID: <532da5f5-f191-4abd-8452-ec7594275b6a@intel.com>
Date:   Mon, 20 Nov 2023 14:22:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/8] x86/resctrl: Add node-scope to the options for
 feature scope
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
 <20231109230915.73600-6-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231109230915.73600-6-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a3a7b4-6207-4a27-f3f9-08dbea1720e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28h/uoWHPQ8i6CWH09NlnPuHAdYoxY3pnFnZC3I2AMvOK7a2Sxx20YpIKKneQ51xtwQxv8snamawBKwjzruJNqYzs5mCj5v64+vLymgzQF/EcTQzIL0L1FKKH6bGCsFYn72+trT4boUa0vYkN9arXhOoCEdM9wTgCqPTKpR9Ubx4NRS1Mmu3NJW9evhQDMnSJ75MXtfZdgyB20B+3LTogmL2GqlOQBgj70x/gopwfyfRCtVWhmkMnBl9itt8+pHynJ9VW01phbh42skBgNyvMJbF2jFZwvujrunD1gkkKhS7uTepRGvTDvBWhaB2bgWgJ30FZ/5V3lGFZ1nAFCOV/WhgeiLJOV63IoCAjZJO+IuR4kovIrKyuEYcfgbCsyQdsZMfRlsd/udokfa3y9ePpPtPZ3v3tlGsohBcWrNAfoRPvESbR+QhAo7qNPiiX2dZkBiPwnacbtVvo9ast89rDXvtjDs0SxVhNDXlRFFDQi6j9q83Qr1pUn2Nyjr0h39B/CZPvqaInvRXoQFDBoYTsNnJ+fm3EuYgYc8DQ7hwteKXiKhfwHQcVLw0E73hgQnMuSqznN5mJe3VL5fkEKguaRQ5jSjg+yIBOdCxaHS6LHcnb3ivbcFnwJYue8h6WPJ7146/ZfAXmFG0IDpN3+3FHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(53546011)(6512007)(26005)(41300700001)(4326008)(8676002)(8936002)(38100700002)(7416002)(2906002)(4744005)(44832011)(5660300002)(478600001)(6486002)(6506007)(110136005)(66476007)(66556008)(66946007)(54906003)(316002)(36756003)(31696002)(86362001)(82960400001)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Q4NzEvejU2enZvRkxQWHFFSysrbGRVVWRJcnFIMEZrY3REemhHUkRKN01S?=
 =?utf-8?B?eGtzdW10a0tUNFpkSmo2SWEvUTViVWNPVmJpVnJ6UlFDeTNhaXkwWUdyRTMv?=
 =?utf-8?B?M3ptSlJ4elJsQWpYL3hxYkZXSDJucVg3TERMNURqMDcrWm1lSjkwSTMyVERY?=
 =?utf-8?B?REY3alJtczN6eU51TXVGb1FTNVRldTNpQTFpNzBNVVZmTFFaZVZKUS85TjFP?=
 =?utf-8?B?S2p3ak54bXpvN2lvam9HRVA3TEpZeGlTY3FTQm5VekN3U2kvZEczMGZ4TU1o?=
 =?utf-8?B?R2JGc3FESVcvY1FVSHZaZHlpNTlUaXNpeGZmMyt1Zmc3NjlvdlU2akJGbzVF?=
 =?utf-8?B?am1NcjF0Q09kY0pXWElMWU9WVUNrQktlK2lVcUxsOGFXV2M2RXBsSW5NNXBo?=
 =?utf-8?B?NkNQRjZTbWZpS1MrTkJkSm84UVhOaUpBckpTUHhnYXpXdWRUZ28xYUNUTFI3?=
 =?utf-8?B?RHhKVzdjOVdIU1RHUk1XSnF6d0pYcHhzOW1jb0piSk5TSzJBdGZYTlFCdWIy?=
 =?utf-8?B?dkxacXdUOFFsRi9VY3dZRWhzU3NTL2JxejAxRmtjWm9haUc1UXJWbTB4Wk1B?=
 =?utf-8?B?OGZxS0hUb2xRbmkzMFNwcTBSNDRwM0pQL3JVdWYrN0RTTzFEdmpWc25kQ3N0?=
 =?utf-8?B?ZlorMFV0akRBTWtUWjM0VUMyTDV4THd1bWc1eHZzTm1VU0NaSURMZmV6ZDVz?=
 =?utf-8?B?bUxOczAybk94WFdFZkY2M1NvcXhUNVB0bDMwWUpuQytpUTNwQlkrR1ZaU3E2?=
 =?utf-8?B?Y3lMdDZqaTZZVnJ4OU4rWkVXSkxIZzc0c1hvVS9CVzlUM2s1Ykg1TENjaFZs?=
 =?utf-8?B?aUZ4VTlGdjlLZXJIeXpnYklZYmxnSFNVYzFVWXQxTXQ5akVpZXAxQWF0N014?=
 =?utf-8?B?YUVuUG9TN3pxcDMrNGlYT0VyQTR2RGwvMy9TbzJlcEdCdEEwbmZUUE02UHRE?=
 =?utf-8?B?eWtYSy9rRVhzLzkwOXFLMW1CNVdtUjBzTTQzbGFyWEZrZ3dmcXpSZGJrbWpK?=
 =?utf-8?B?aVlFNDhOcDV4ZXFQNHFxMW9aZWhNTHY0Q1J4T2F0bm82UUt4ak9zdFRwZm5M?=
 =?utf-8?B?TUQ2ZXFPTkwvUUtzcTJrMnhxSTNSd1dHN3FDcTlCbjV2dmxPQldCN1J2Ulhu?=
 =?utf-8?B?cmpIUjJSL0d5SHNMaFpqZm9NSyswL3FwcEFsZkZVNG1CaHJYcFQ4WUY2WW94?=
 =?utf-8?B?bW1KMVVKTnpKeXFxM0xqZm9lMmRpWmFqVVZUbGlLNThoMG1BMnJacUQ4NU14?=
 =?utf-8?B?dHg4a0VyRERLV01xdkFJSHd2aUpVSGhXbkRqVVM0cGl1bGdxakVEWjRCYVBR?=
 =?utf-8?B?Vm16Mms4R3FMT3BFUERHWDdtUkhtbW5sbWc2L1Vka0gvY3EvaHdHS3hDVVMr?=
 =?utf-8?B?cVRLSGZmNFRXNTJYc2xvK3RwNFFQOW1uQmhrU0F3UnViNU56TjJVTUF1aWFm?=
 =?utf-8?B?TVRHRVlXQUxOTXM4Qlp4cDNUTXRvckJMeHBsUVZWZFZuU1UxaHRNM2MzTmVl?=
 =?utf-8?B?Y1lGSUFtd1pEZXp3VDh3QjVvSklDcjBCdll3MzdINmhUUFhVeTZKSWJnN3JR?=
 =?utf-8?B?a09nMzl4L25GTGJuU2txeU9ZbDFvWEk0V1gzYm1BRDg1YWRPaVlCTjZJNTh5?=
 =?utf-8?B?bVVHNnl5MUdKVGhPRnVSSXFwbDZYNG0rOXNlVTFmZk9lZkFXWXBndTlTVzZV?=
 =?utf-8?B?UWVDMGVOMk5xZUpoS0sxR2M4b3Z6NXVIMTg2MFlVZlF0T3FNQW1ta0d0R21i?=
 =?utf-8?B?dXN5U2hjeWZrM2w0RXFvanA4MWhpazZDNUVXUzdyTnFMcXpsNTg1Z2x2NXA5?=
 =?utf-8?B?WDJLbDIwVlcrZ2ZRZU03T3ZHcEZiODhrTW11UVJ4QXEvWGdLQjZIdXVQQU50?=
 =?utf-8?B?UnlCaFdLTFRtSW16SGpOTE1PSXpZaFlyRGNKTkl5QWYwc09DNHlvaFBrOFNh?=
 =?utf-8?B?SkZhTUE0K0Y1KzR3d1JReG5ORFRENCs4anZ6RWtMQ2Jpc1F1Q0krU3VnUXBz?=
 =?utf-8?B?NDRmczRseTJac3V6ZnV4TEJ0SnFKUms0TzNSUnIvU25JY3ZqcDA2KzdwZTB4?=
 =?utf-8?B?YktGbTdoWk93T1kyZEJ1aHpoMjZTdjJ2bndWUTRqdzdNRjIzZ2ZWaUdlMjVY?=
 =?utf-8?B?c3VZUWJsMklkanduQWwySE0zVTc0dTJQMWloYUsxdkQ0SHoyR0hLTWNHWlB5?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a3a7b4-6207-4a27-f3f9-08dbea1720e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 22:22:06.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dot9Ax6/5miglCJwcQ/jsUF2Idt+jWqHp4tki69rpkoAiN6IqAxt28TE6xrI2mAGofGLqeo7ILnJsYzNDzKfcNLkVTQD58WtnyMsnYzOmK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7797
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

Hi Tony,

On 11/9/2023 3:09 PM, Tony Luck wrote:
> Currently supported resctrl features are all domain scoped the same as the
> scope of the L2 or L3 caches.
> 
> Add RESCTRL_NODE as a new option for features that are scoped at the
> same granularity as NUMA nodes. This is needed for Intel's Sub-NUMA
> Cluster (SNC) feature where monitoring features are node scoped.
> 
> Reviewed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

Please follow guidance in section "Ordering of commit tags" from
Documentation/process/maintainer-tip.rst

With that addressed (thus adding Reviewed-by tags after your 
author SOB):
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
