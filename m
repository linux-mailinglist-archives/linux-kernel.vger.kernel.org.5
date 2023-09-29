Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60637B3B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjI2Uku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Ukr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:40:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0EB1AB;
        Fri, 29 Sep 2023 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696020044; x=1727556044;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZxJJnFaPKwuzPcByPeH1kQNMWz+kY+ZV/I11n+m4q14=;
  b=LdPWPPH+Hsx7emV8AyVH8gWc4qTQmgH4M9Qjjm6Tj0IsL3B7lnDFcM8S
   51PBjjrE8bOgOn0MSyN8m/cPiLHuY6w5Oj8sByBMDoj+Yb81d33xCuwJ/
   LVs7R5/AxI3ZkjRv9QsujO6T513cd9ohpdqWtrGjeNDLU4ZU3Eq9K6aMC
   BN9oyfGnYLx49rzTwbBbQqsi/2SYbh6BB5gf5rpJpiJyRPPQ7l8Qr0tXJ
   9MVYAq1dK6GaTKFWtpEbA0s91o/ru143mv/kSovoqQ/BTneaMOzPq4ogd
   kr5lcE1qamvda3vVa+nzen9nC9GnALyGCMsQhznN4GarbWjHmnN42BGmW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="971658"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="971658"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="923689855"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="923689855"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 13:30:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 13:30:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 13:30:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 13:30:26 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 13:30:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cW73yHVQ9gLeEUfUrP0GNijMjW7ncJDpRoDrzJk/d9N93sQkhOrJ5+1ZSiL6Ziu4MyrqK7l1ZBKfac91FnD3CVDsLLpnJ/oeJzILuBAFSHrFs/NARMi5gxJv1UdiaKEeSJfK/7tOlbdmixKEC/15TT5KAWAU5v1T369fLz4c7xy1dT5O4W/egLMvEOYhDEXKtekpAXzaqHL6uczAhnqVsgZaFZAAuTmllSm5VMY62R1P4zOyTd/2kr8l3mXrbrTZJu5HZH/taTEIWMxgR7jvyPZkcHh5ZQ4QM+407tPoA74xBvQ2PCYm6GNL2yOcqtXPhnF8cq1ZxBtCPJixv2rJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGfKlimmlvQ77drHMIyPLBeqQLdgwOALck3QyfxJmBA=;
 b=Q/1PBmp4WQOHcHmVhifGTouoFXzg7URkdlpFNXfCS/Mn+9cbKJeOu+I0rPfJzVhqlQNhJYB/EyxFyaJbOmYMC8F7XXjyizm+yxblWFUc9sLIIUYFSHx8tHd0ty3PQG9dqr/JZOHI2qbU86LuryI8LUvGRGJSsLLiTnk9oFhsPnS0EKg/I4TAILS76DzWdlEsbmNbn/vJMh0YqIbjHA13CHahcVe9chRc+nlg3Hic+CPxTOmf1azZKQj+RxKE9qmwM/OInns5FiyCP8u+mUAftHJdk5bHrjvw5JmFP2bT3p/UntR4QiPKBhQBRHwDatlyKSO3B4YBBObiPfPpYwYw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BY1PR11MB7981.namprd11.prod.outlook.com (2603:10b6:a03:52f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 20:30:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 20:30:25 +0000
Message-ID: <4358da86-1347-cb20-b19b-88982d1f8e20@intel.com>
Date:   Fri, 29 Sep 2023 13:30:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/4] x86/resctrl: Non-contiguous bitmasks in Intel CAT
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <corbet@lwn.net>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>
References: <cover.1695977733.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1695977733.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BY1PR11MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de63d30-ffd3-4fce-db0e-08dbc12ae95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gS/JAMXReKrQI1XVnSoqCTMm3L+38xuPYLAhqdiHMakCPzwvQa3Yn17WQVJfSdA6fsXG2H3CvwimFPCgLHtWHlYp0/zXTxUdF90Y0nK88AXG0rFxK2tb9XOmwyZgy3cNCeGpF+8gXUlYs+anxRKzvsloCSnn6JLSfRwCb3R19zyQaKPrFdJrE/wHXjUBXSfvmwsQ6IxFOCaOLzSlT4v63oYYCXRyrs/TP2ILfh6cWHwR2KNcrPv9iGS0GTYJlXOaBpvYowTbEnPnNS7gKeYCvYpZXSNjDwkNF3DWXyKtX9qpXu/M2lJtiFnph4ci3FPnfIz+o58/+A/o/zdGG4XdDzU//b/LpYUnzdTX4tM7u30sTH8Mk9IO4g+BMjmdsyLArHKKPHOIXwR0dYdHaXpS8LeQvA7K0TszaTOWPzzeoxwUxkzxEXMH1yLbzNJne3MXfqE017m4HssFDIm1Vr4lWugRSRpqvNdE0vrJqAYnW2ObRcWw+VoTPJkrGzE3fGYIG6Gob+5oLFWjWB24JWNsM2WAWpkKdt8F9vd+CcNFY6GrCZt3sMDFw6PfgI6WagK0Q9c79QTbtOfv8KUxFFZ1GpW8LfKqNd2SyKvSXO/V0/exA+5Q/0UMyfd25Ywm/3U0wVxHgtTtFpST9LoSj3RFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31686004)(8936002)(2906002)(41300700001)(4744005)(4326008)(316002)(8676002)(82960400001)(44832011)(5660300002)(7416002)(36756003)(66556008)(31696002)(86362001)(6506007)(6512007)(53546011)(2616005)(6666004)(38100700002)(478600001)(26005)(66946007)(6486002)(83380400001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3ZZUGZKdmR3c2xHRzlRN24rS3YvQ3RmWmNwUU82UWYxY1ZFNWdHcHM1MjFz?=
 =?utf-8?B?NFVqT1E1TUtxcGhBVHBuOVE3SHUxalZZRWh0MkF2RElMTjkrbi9mM3FMRWxE?=
 =?utf-8?B?YnNweXVsbThUQUk0R2hVMXFDSlhCdno5Z21wbFZJcjZLZzlvejJMWklOU05G?=
 =?utf-8?B?L2NuMFNHRW9US1ZRS2ViVTZ3Z2EzQUtQOWpXelo4b2hLOEJVbXFiYjJwbnda?=
 =?utf-8?B?QTd3cFpJL1k3bmZKcHdTYUw0S3dGRDMyTE11eloyNDZ0clRRS29hamRjS1gr?=
 =?utf-8?B?NVVGUXNScHpLc29veTBRRzZpc0V2eW8zS0ZYRVdCZ01kOWdXME53YzNadjVn?=
 =?utf-8?B?QzRPc1F6S3RFdU1MRlI2My9rekJDeGRHSFYrdHpLeHVrVmxQUzRxa1hUN2tp?=
 =?utf-8?B?ZmxNTnNBKzNqUDVhUHlCdktaNTNZdDVTNlBzL0NlYTZ5cUcvUjBUYno4UFpU?=
 =?utf-8?B?NEJqSVgrL3FCZGZDVE5HSHFXcDI1eG1nY2Z3M3J3TFVkSldibmluRkhDZWUy?=
 =?utf-8?B?WWRmb1pnYzE2dFpUaUNBZ0lxRjJBVVQ0MWtTRjlsNHVYTkZQZVZWVDUybFp2?=
 =?utf-8?B?cW5rQjlVZFo5T3o5bE1sTkFpcm5JZ3NsWVdpMXV5V2VPZURHRHhYUy9FUElk?=
 =?utf-8?B?cEQyRkJpYWRGcmk0TSs0Q0JwbGE2SFZ4aVZ1dnVhOTJQdm9xdXhINzFvbTh4?=
 =?utf-8?B?SDNlTzdDYytqL2JCTGtpRjJrQ2dmVVVZU0xEVXVhZlVKeW12S3pxSnFtQS9q?=
 =?utf-8?B?K3p6aGZyNldJVlRHRUp2UHZYcWtVbk5weEtWWElyVkJjRXJabVNXekRKRzI2?=
 =?utf-8?B?SDhJVnBINERWUEhnRkh1NHg5MjBlSmtWaDcvN3RlVElFOUFoWGY0b2ZTRDdP?=
 =?utf-8?B?cnd5ajQ4NFA2WmhaV0dDei81SGNRNE1acFYrNlRGL2loRDZQYVRoOStVNkJD?=
 =?utf-8?B?ckdhWnZQZUNZakxnSHg1T0V0bCsrc0o0Ri9PbThyVUdoSi9Bd0VpdVdpeGJL?=
 =?utf-8?B?akFBb2JyZ2drZDkrMGU4a1FObFk2QzBUUTFkUi9GakZ6STA5cXhzbkhTN2Qx?=
 =?utf-8?B?eXdpNWNHMkhpaW5PSFlMcU1kWTdjd1NjU3Q4TVVYNzBHb1RXNzVWWFIzWnIy?=
 =?utf-8?B?WUlMVkFRQ3NobGF5Qm1sZUFRYlVqV1ZSUXBDRGlXcnRhcTZaWHZ0cHEvZGx2?=
 =?utf-8?B?ZzlhZmVGeCtQa2RlSXJ0QXRFcFlmdjhZa2RzWW5rcjZ6NWlESjQxalhmUlVO?=
 =?utf-8?B?Nm95SkZzYUE4NnJpcHhtMk4wSmEra1FJWTNzQ21uSDkvZXoxV043aHZ4UU93?=
 =?utf-8?B?OVoraDJueEhOZVo1SG9ybkpBQndtYVRxeXRISGhWZDQvRVpvM0hNRE1QWDlv?=
 =?utf-8?B?QjF5S1F0Q0QwSGdJL3QwanZ6TW9iL3AxSFg0UHloQ2s2bEQvR0RvUTBpcW54?=
 =?utf-8?B?cHJKMUhNT0FaRzRLZTA3WW9QOWFnUlVqMXpmTXhzaWZpSGFvK2gyVE10WDFo?=
 =?utf-8?B?UElSb1YyOVJlR0J5NXM2MFJCRVFadEtLeWozeHpIVmgyN1R5QkxRWGpNa1d3?=
 =?utf-8?B?cWFydnRGL2ltUHlycGdZcDErK05VbmtocEVHbmVQZndrV0FPY1RkWDRiVVdy?=
 =?utf-8?B?UCtzYXhKVUZ2UVVvWWdxaVhvdURUVnZySUhpdHYxT3FqSmplZFM3Z1B0US84?=
 =?utf-8?B?WUpIcFR3cGUxQWVLenFwR3g0RnNaUW5YTTVmaXB5SU9hN3JWMElkMi8ybFg2?=
 =?utf-8?B?VW5VZkQ3Q2xsQWlMSStsTC9ldWwyY24xZGhLS3E5MzQ3RGhadG9sVlhSOXBw?=
 =?utf-8?B?Y2tnVm12a2JsUTJjRm1FdDVzWmN1cmUybDZTNGVUeWJaa3ZmSjF1Q1hBTitt?=
 =?utf-8?B?Ynd3dmpYUW0vM0Q1eGJrS1NzSEo5Y2ZBd3cxa2V6VEtDU1RuQzhUVkNkelFU?=
 =?utf-8?B?U2owM2hNbDNFUEJlc21YeU1WQ1d2Q0JiL1RacGYyaWk3TEVaY1FkRGg3dlM5?=
 =?utf-8?B?UlAxS3pCTThUazUvWVpDRStTRUd2cmFPRi9BakxtQlRSTWJES3IvWUtxR1lq?=
 =?utf-8?B?UkcvSnRXRXY1Y3VRaERnREZXNjFzbXNHV0xZUHBvSUpkOGNkS2lIdFIwdDMv?=
 =?utf-8?B?ZUdndEQ5UmxoRWxpaGFCUzJNTlRRTVZjWk15ZkFIbFZtTFQ2TXRqRWZ3TWVX?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de63d30-ffd3-4fce-db0e-08dbc12ae95d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 20:30:25.2542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HN0AGg7RuhmcbUOoIFrSqgIA0KzyKobb8vKdfOjULsd0as9PcrutixNyGCj+DAc/IyO/kHrAnYsGCBUpx0t7YjdTEKIoNR5o+fIAF1wAav4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7981
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On 9/29/2023 2:00 AM, Maciej Wieczor-Retman wrote:
> Add kernel support for detecting if non-contiguous 1s in Cache
> Allocation Technology (CAT) are supported by the hardware. Also add a
> new resctrl FS file to output this information to the userspace.
> Keep the hardcoded value for Haswell CPUs only since they do not have
> CPUID enumeration support for Cache allocation.

This series looks good to me. 

I do have one comment that applies to all patches: Could you please
take a look at the "Ordering of commit tags" section within
Documentation/process/maintainer-tip.rst and apply it to all patches
in this series?

With that done you can add:
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you.

Reinette



