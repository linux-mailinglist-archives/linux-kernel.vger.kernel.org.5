Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378717B5389
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbjJBNBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbjJBNA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:00:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F54F99;
        Mon,  2 Oct 2023 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696251653; x=1727787653;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eQV1grK6LNijgcCkhXU3Mfgt8aKIOPazwErlFGyJkhs=;
  b=mWoiY884NLDVhwmQeW5ym+zQZvl/K8d7l0EvjGQj0jYDO9zltNI8crlz
   zhN2vmYCQP6+OLWLxo2cG975S+F533srK7EaLYF0Fmbv9RLD8HKgjJsz1
   Zksl8MJ8vSbrDnV5fPyztgu37P9iu00puPvtnYf+uXTpdU/DE1VNS6snf
   ulwSB984B1ag2mszD/N/is7eEH+vibbQOpt/QZa+dJXVWS7pxNiiqAc5b
   sCJfiJKL35JQDRcxPpe20+BjTPJq6+c/qBT+0WEVpFU0qEuWgAqrql78t
   TRk2Wl5YgCNOM+6RAZLrE78wltjLFT4ZD3k1BruI3+EXlk9G8UHzGmcbf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1217672"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1217672"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="700339227"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="700339227"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 06:00:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 06:00:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 06:00:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 06:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgIMXSlke6C6zmbeoQJ/ikHDfmiQhGOb276IsEz1stgSfL8bqMvuNkx/E7F2OKoMMQevIAzPHUKvAUt+IJxyjsLuVNJzx6LZdnw8vI8ACS6OgERtF0n3/NowvkK6TVXEHb9FaRUvhG3CUJE0njcVFbf0yO0lqJ3C2janvNuQ+m/wLf8n/izmPGb6wr4nKvaNBhCXpT2eSqCw0kZXESh/GJogOzL8o11NHtMRuRe+2rNuePmfdKFa6YZh/BQKVGnKs7BlGQhMaDIyOSdopwkE/2nzR6gGiCC46iB+Bm2u/woOoCJXyMqZdO9XrUqnGlX40M0V2Jai1GtQf+xAFHlGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mprh6SYlzJpJ0l9FjYVEI9O+bUlWSGRj2f+H1n0JLo8=;
 b=Rn+BWeV6VcHkMpguZgbLhnbHZ21/AHgl/2+xjgzaPIgKXoh8LzqR5oRcyi0TsWhiaTHjzFJpiHj5M+tUMuun/w1xJ+ANSPUzLDn16k+8E7PF/umJXI3QRCss54IYi4Z0iuCY0BOiN4KrOpiyc1Q0tNAZI+KmP2XDz+36zU628zkB5WuRb8tLqkSxF+oIWETvgRVTFzpSrwgJ2r8SG7E76Dx+zC8Prmss6IFQwbHv+06TYWJEKkkWzb/cGh5SFYELnzdx1cNXJJCBS2qeoEHfZX5QD8rVcvtTa6N6ZchzRpsUBCh/t2IxQQ/ia8DDVNlcrImnn5GJNYRG3+qICVweNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BL1PR11MB5493.namprd11.prod.outlook.com (2603:10b6:208:31f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 2 Oct
 2023 13:00:43 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%5]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 13:00:42 +0000
Date:   Mon, 2 Oct 2023 15:00:35 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <corbet@lwn.net>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 0/4] x86/resctrl: Non-contiguous bitmasks in Intel CAT
Message-ID: <rqgo4rqnhnj4k5tiguoh7piwgc2kon4wze2jot7txx3z5djcag@tp6qitqu24am>
References: <cover.1695977733.git.maciej.wieczor-retman@intel.com>
 <4358da86-1347-cb20-b19b-88982d1f8e20@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4358da86-1347-cb20-b19b-88982d1f8e20@intel.com>
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BL1PR11MB5493:EE_
X-MS-Office365-Filtering-Correlation-Id: e66adc38-3276-4f1e-55d5-08dbc34795a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6wdnofX77MW+jpPpOa6j4U/Q/Hs7DoJ26pR4ncOUsCm1Jg5bT4GeAnpVa2C9VGbBiN+sNq9iuy4kJvQSff4RlvkPE1FhLTeXVUjvNozrTfbICblpgLzBEVjuip//8ZtO12hK2GYU89YbQYtG69lAr4133pScsgRu+HuNmD2veIhlShqW1id4zhWGWbf0bTjoc2RpF4ml8UsMb8cL9xdANhM7P3zd5P8WRGNJ2Z+2XJRMEO/ERxrGLHhipm66Lp5hYQLCQaz1rG8fve6Z4qpBHPOPfuGISNcAmehfFMRyjr+cgK5Nmn9Q2aJ1VFmz+s9vAIJQRMDnXydly8CmTYhwNVM4/hKABpg7P3mvs30VMGLufKmPhv0BKeGMb5yTMuutNZV0kQyIl7nySz33FwPx5RCr0/VqLX4EwwJ8MUsQ/3oln417A+DGfKYcPBkbYZrOcc9cP0nO55RdnwusOPXQdNm3uObIwxLVNGb535x6vW2AszxUMWh3k08g9hGaXq3pDAA2g4SNvxUKaoL+T6fc30pOFkuQrzg78rINYs4cArKhulyAULA36YpnSDcDZx/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(7416002)(41300700001)(66476007)(2906002)(6666004)(86362001)(6636002)(4744005)(6506007)(6486002)(33716001)(38100700002)(316002)(66556008)(83380400001)(6512007)(9686003)(478600001)(53546011)(66946007)(82960400001)(26005)(6862004)(8936002)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9Z1aCrWU4gw1JLr1BWZVOAXu+FlYWYbxJn3/GhnxnLx3hMV64EEVauSWiU?=
 =?iso-8859-1?Q?MW4YTPKTzCVqxJrAzSY0UgDA3VxCgL/DP+8G4INnLuJApAnt3wfpHUzEb4?=
 =?iso-8859-1?Q?xgGde5vLww6dex9JSkE8lxB5IMIC19+kyoV9cRUAVk4+RhiHXZ7nokN2HS?=
 =?iso-8859-1?Q?MeHE/pIFnWC93wnzLOSmq1Qap59uYx0iqEtai22VrR9JB5N+0pcDLKYcw/?=
 =?iso-8859-1?Q?yCQxNsSuydqBiD2KFfwCOyozLMTsRoSaHplCH7zNNr0bFuymknPopqWoUn?=
 =?iso-8859-1?Q?vBCfCYr2uUtojLwuYSPe6zKKCSAbqJejWl/w0dXePYGM/o8uHK2sGlT6Yg?=
 =?iso-8859-1?Q?MRRfhgzT1J2ikCntRvYZ2VRMwz7lQz2pnpg9FWTdmBKjEyAeN3ICUWpHoL?=
 =?iso-8859-1?Q?r4DMHhtxx1ITFOtvx0111VQJqlhpfz2eIyQWaQjCimgU8jpCKMw0gVmznc?=
 =?iso-8859-1?Q?xVQaSKrkCPafL6PZ8pcohKyUBzgeOnWRTWhpnF9bu5WMkKNlB8akoW6gdv?=
 =?iso-8859-1?Q?SKNhReaDzQh+ufOSE4J+uEFZqBsGhzjZx5dZMUGgVGbU94C1KSNA0IBMeW?=
 =?iso-8859-1?Q?o9hjnLKfxdmqoc63Y6dIKmHd+doN/jMQzVznyMxwUHLQsxf1Jfjqmd5TDN?=
 =?iso-8859-1?Q?m2Pg0lUPowa6tGNmN7zu3PoPXDutRG5pqQpg1ZlajNaFdeQxGi3omVXwDV?=
 =?iso-8859-1?Q?tuATaaewoZv3qhlRO0SX3C/2iEbGCsrl5BIE9xDNjgfUuGwwbnHne9jEkV?=
 =?iso-8859-1?Q?Xgv5QK24XPg5cxkCnRwIddPpowTargW44asBuxm8mMRNYd5MQF2HF0PuIq?=
 =?iso-8859-1?Q?9gpbyB7PVK6JSXh3yo54wPDjdBj4haMjP7SQaeZhIToGC/YnU1k388SLXk?=
 =?iso-8859-1?Q?fSlPdCS36PgBw46/teKwVgNgWlLRmBAB7ZBrmIkyRSDBboy/LMHZutgOu/?=
 =?iso-8859-1?Q?jRvxaSbjn9G4eAZwrDUoW8wpxoDAaCOPg8KX8IsWNX64ZhsjDh6v4Uc+MZ?=
 =?iso-8859-1?Q?FE5toXtJTSdqzAh6QJkNnQQM+zzwsiGQ4O/vuxuz82I+r3NT4NaKpnB/U3?=
 =?iso-8859-1?Q?zCvOoMd3pj0VuvREuqszJF4mRSoRxKcLb/8FhZ1bKUxPD5msggBt8okSPn?=
 =?iso-8859-1?Q?iXFFWuBM8tiPC4OLqv+yVMf02lZmoF+QFhT3BXwh15f7YRJLExU+V60o8s?=
 =?iso-8859-1?Q?YttbZgXeRj9Dq8IqMefiCwS+5J97JJhbZ3Gq9SYvMXnZjn7gEM5/wI7RRs?=
 =?iso-8859-1?Q?WOMxCVM8XBsbEYQT237n0a7QRdwWcjqcXHiV3s8PSxa6MYYUDk8z+Ug5z8?=
 =?iso-8859-1?Q?M+vyZlqvn6/cnm2XMl1DAtKcL/Rc6qI9Vb2ZrQtdeUm3cqnXuqpgWj1EI0?=
 =?iso-8859-1?Q?oLXdemPnrhvC+aVVmiPQDoGyi/XLf0YNWifEaSR1OEhjY054dHY3jnfeTW?=
 =?iso-8859-1?Q?//qHnN1r5YEsBBd2Cy45q1e99YW/4ofOhPkdh0kFsFlosr2nBTM68W4Pow?=
 =?iso-8859-1?Q?3U7foRv57LGfiAgAU9lMlU7aD8lvOeKShUSDUdPILTzNp8+Ilx3BFwYIut?=
 =?iso-8859-1?Q?vnXII/4q4muEf52tAWKpsHnptX4y8AR2Lk3q+s+Bswuuft3CRB7ltUCp9W?=
 =?iso-8859-1?Q?nZxadZk9OwK8GjcUCjVemCLrzZ/ASfoCXGYLbIEOgLnjJn7cuPWvguNLHM?=
 =?iso-8859-1?Q?vlraL2E1Cv2fDD/DBYQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e66adc38-3276-4f1e-55d5-08dbc34795a7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 13:00:42.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKVVAjPZi+kng0F9RaJgpYQqDYZr38d0Tyou+UDgFJbJqDZC8ipB6E5nX2MBc5H9n0yQhU3tjPgeWZNX6oU2L9kodluY7OZ230939wcYyWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5493
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-29 at 13:30:22 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 9/29/2023 2:00 AM, Maciej Wieczor-Retman wrote:
>> Add kernel support for detecting if non-contiguous 1s in Cache
>> Allocation Technology (CAT) are supported by the hardware. Also add a
>> new resctrl FS file to output this information to the userspace.
>> Keep the hardcoded value for Haswell CPUs only since they do not have
>> CPUID enumeration support for Cache allocation.
>
>This series looks good to me. 
>
>I do have one comment that applies to all patches: Could you please
>take a look at the "Ordering of commit tags" section within
>Documentation/process/maintainer-tip.rst and apply it to all patches
>in this series?
>
>With that done you can add:
>Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>
>Thank you.
>
>Reinette
>

Sure, I'll fix the ordering, thank you for reviewing!

-- 
Kind regards
Maciej Wieczór-Retman
