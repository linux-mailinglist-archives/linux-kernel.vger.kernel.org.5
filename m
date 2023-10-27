Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661A47DA19A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346374AbjJ0UEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0UEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:04:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E51AA;
        Fri, 27 Oct 2023 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698437077; x=1729973077;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5obnVApmVgsehn4+Omi1Ehng3AdsbrMqi3Y1i8FZ05I=;
  b=NwREeAQI/ScyptuEqA2295LM00eU0ScpWjp9m6B1gKXhFLHOa1blULnK
   ZLe5TXDHrPdaiGVfaucuyLJsCyowLyQ9cJ/O1Xp1gd+jN42qYy5Y/kkdA
   /qUdX5eIjTW7rZspB8xqwxImkTpi+Cdu0FBfyav6LVp1hzOBA28n+gnFN
   H8wAQP4tNdvrGlkjLberCmTkFyRsN0f8aaAswpu0X1SUlr+6Q35B+4vV7
   BsHeRAINfZUfwQ56bgH9YnC5FeANVpjxPxBkrkdmGIse6vWPl8baQZLJY
   nSK4m/jsy2sBHSqBDfEhagMUwhAQtskoSPwDni370W3glYzd8QibUyrNe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="378209218"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="378209218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 13:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="709509388"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="709509388"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 13:04:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 13:04:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 13:04:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 13:04:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 13:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIQbBuTOMuY0D+GQwmcmPdXJtmQUkUs5qN4KkLSIoMZMtH2d4RtXqvrwXBhtl3ilciFJjZ7L7qjoM3F36niMgk2h6duTDCxyhQu76B+hMVs7eKH+chOCGmXRh2pP97SU2jDp0KXzOJZkq22R+hDqpGG9GiucuVo/il7S71EYl6YO39ecfO1chOBoAupyFqEI4MjzQlxN0cpPMU6HuGKk8g8pK9QyDa67MyooLNOjVS7BD6+OQxYY7KcXmn34sbUQMhxKyuTtMH8NpB8R4sJUS0ZWGug7ua/TJAev4K6ylEER8IUHwmkswxxipLUCKDY4sSEkauvEA/SY8Z6WnwNV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmFX44+w9F6BYzY0Isqcuh/OkDXVgq/+p4ediMBPSmI=;
 b=hWlOo3s5aeuRhAwJJMSkjXuuxm9HgjesCx8AL75YhgDvvAH/ZyjUHV5Y/fFtDypwX5hB1wwwp2m2BBMHZRqdZi4Y0Bk2wdz87KGYtCdNdrQigcRKNU6jJGrgqeHzR7GIoIYFKnd1eR8+W3OKwYjDAb6rkZ8Clk7bwS0XLsjMhFmw8VtavziQGP7grqlP5df8sLCTXSnUZeJ9qr+NOQccgge+e6brmPJ+NrlAyJX0MK4TF1YivDMElPQ29KCDT0yzUY1jqYnN77AUsnnnxcG5VPlNde5z7Jiv79+AIujfgkvIacdVAy4KghNEgD6AIzgMTxMZuiO/QoaRYOkdaxvdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 20:04:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 20:04:32 +0000
Date:   Fri, 27 Oct 2023 13:04:30 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Terry Bowman <terry.bowman@amd.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v12 02/20] cxl/core/regs: Rename @dev to @host in struct
 cxl_register_map
Message-ID: <653c17ceaf30_244c8f2943a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-3-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018171713.1883517-3-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:303:b6::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: f50f8b1e-67bc-4ec2-b8d5-08dbd727ef8c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PcTV+x64X26LzHWG5tv7o6NUFqBkIuwwaQiXRjgoCqre7cn+cqnCuxZq5cIuGRH8pTtLDPEveQ5X/ex2GvO58EWPXs8WeAb5z5Fl8EdvHKgQHuIVLcMCY3jx+AIACPiXqtMFrcPrdRQdbln7Vf1H9alLT0H172XA3a/YG82V6i8WaSMc8ITRNaDSGxqYwDnjw2EH+GRo1s19nnMMnUmL+cAz9DciAoCYtnutkeoISRJW37OFKmIBh6BEFbSjX4TBltcyHrsAS2pi/+//rTQTJpDEn8Idn19MKdHTDKmg24GtMh5hJncIDik3pxytptifrQxEUBdrBL7oHYxZdALLmXEMGuU1J4/cAfXuqcVm+90kH5xsnmymmXpVsu5RrBNEfB9yFyo6oFd6CibmIiOxd17kF4/od+o23h/7DPd6SAfpKJucLBSFpYbeKZIwo9hkJUHmjPIbYZzTyQihh7V6SFOYbP5PJ+27w+yzJxvrvk1ciewWci1pgUE3vLchE9ICpsjOWsWosGSsi7QfB9vBgEHMVMRAUp1r8fx99byFglpZuy44AjFwH7NsNpsZ5G+rvarGKiBVwaYQCRR5Sa5iNLjgWZK8Ex3cL2cn1iAoG/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(86362001)(921008)(8676002)(8936002)(4326008)(82960400001)(6486002)(6506007)(478600001)(6512007)(9686003)(110136005)(66946007)(66556008)(66476007)(54906003)(316002)(26005)(2906002)(4744005)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8yZRmhsWUBXDxzSQ6OtjNzZh6t7utW6blDG3KFiphwJdHn9DD9oxNdDuUkV?=
 =?us-ascii?Q?QMI7QEijEFdpMoWmcPo2aIuu+iIXUhzWpG/0Ac/g9HUUBpDWotLyKyG22qsZ?=
 =?us-ascii?Q?jKTdQvk3rzdEI0QfdpNbhl6pV1bdvDFgoJb24db7ubwt/P1hnL3fbKxIhDse?=
 =?us-ascii?Q?24aUNwU1bpetB7i1f01MYUdx97ti/AmfRZJNf8u/WES6xDHInqBWHXNS5IZm?=
 =?us-ascii?Q?ilKJHI0pXVsNAa9MF86GH2tQf214u6ZadyFQd6NrGdcof2CTshwG++EquMei?=
 =?us-ascii?Q?c5UanmbJg7pUc2Y0MO93ldGOixmr4MjXRvJWcB55sX1w09lJ28B3RsIhmc1P?=
 =?us-ascii?Q?I5nn/rM2InVEi4oQOHob4slOA857ZP7k81/+F0gCAnKogTgBjmB0AfGPmzYd?=
 =?us-ascii?Q?u7q3JTt4w1V7/m1A1sIYp1mlkz3AQXvoUW2FyT+v7zZqXsZ4NoFITu0VLjpL?=
 =?us-ascii?Q?yysbghfp0X3eiOJXf//8FhakBXWt6EafBImcz/NuhCxXrMnKoFfosgy4kDIP?=
 =?us-ascii?Q?8YO0sZPJjNVCbLlQ1UyOUh9uwuGXdXkWELOPYyOomrgNrBk4/zIHvyDciYz7?=
 =?us-ascii?Q?Ee2Vmar92IwFbH69kAoO9NdXYf0s4YqDMXirqVo/Z/Oq/m+d0AJn8W2SmQ0l?=
 =?us-ascii?Q?vFaw3BuOAfKE6y50aIy6V92txUpDRP5Kg9KWHU2iYQPpECnpN61yiF4k8xc0?=
 =?us-ascii?Q?C7F/bNFFKfPP3K47OYHOFcPB0La1pvuGIAQ20HhvK11A+aMCTgkc04yNfLgq?=
 =?us-ascii?Q?vcg/4k34yT4dCmH3HiyznQCeqwBuCvhrR3pNeCMrnDpcTTMCpmQ/tVoih48R?=
 =?us-ascii?Q?o2MUgSrqMi4t9tqSmIhWfx1VAHUeQpCZUBkgkSr6jSp0MI4VeT/6MaigYnZH?=
 =?us-ascii?Q?y2UYWIk2bsdRODN8sf2Tuv2lhMBaPtp2R4QC4s7fCWjtu0MaqrGZ2owJEoWT?=
 =?us-ascii?Q?AaWJ6VF7ZC71/xaFIlbOp5VQUzmtfj8koIjzzu7ruI7ToVDx6c4wNFj83jZj?=
 =?us-ascii?Q?BA+mU9bblTTg+DwmeH/JKmlE0FpKRdx7SCeXyBs9Yyny0w5hUXt6UeasGrwm?=
 =?us-ascii?Q?SXF9teGF1n+Dt7P1zN+EDVHspmNVCCvubtES4LY3Fb/oofk6oae5RfJat98x?=
 =?us-ascii?Q?VbwHu7lT6EjvzkKdBJ/dTL4CRroM5fuWXyCPvZ3dWgl/xDg8z9LInn1tS5fl?=
 =?us-ascii?Q?dMuu7iFJUPwv660FV+K7r14LZNqnOd+wgsNaVD0tz9fUxPokKNUsLzjGJCO8?=
 =?us-ascii?Q?KqRRMMhWvSIOhTTH34A1ZbYNNexilVE61Qe4EX3I4GlsC9HcJTdwyc1X6yjT?=
 =?us-ascii?Q?/QFKpNx+Q1I5ufRgnMnxgIstbhdaPnMGg513NR8sa0g+pmhOnWFgoLu9RbCx?=
 =?us-ascii?Q?k7dA38CURLrsmyuhGBKBGtxDEaR+S6sGxtwIadzr48A8pc/WYYKJSAbdTm5n?=
 =?us-ascii?Q?2z0wNJOsxIFale5aJpqWRx9XZujLdJH8EU2P2XV+DiXCNeLkBp0O/V8XQ1l0?=
 =?us-ascii?Q?YTIvM33ApBV1eeu7PU9FBydHWf50+gN6ujpTDbHrppYdNB3XoCqdAofWwX8/?=
 =?us-ascii?Q?UJIjKrFni7fdVuiMXP99zpKGmhsO/pCTLV31qmz0gV6O73pCnK9cmF1dzHKa?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f50f8b1e-67bc-4ec2-b8d5-08dbd727ef8c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:04:32.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iy/RxFq07y201BspumeoQ2CDFiUX/HzbmvJdMcP8UmuOY4rpLdIqAhaoJM7jZNmBYqtAvXiPknjcQtdyLlT3ywmHEC68RiGkMPNuSk5eMRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> The primary role of @dev is to host the mappings for devm operations.
> @dev is too ambiguous as a name. I.e. when does @dev refer to the
> 'struct device *' instance that the registers belong, and when does
> @dev refer to the 'struct device *' instance hosting the mapping for
> devm operations?
> 
> Clarify the role of @dev in cxl_register_map by renaming it to @host.
> Also, rename local variables to 'host' where map->host is used.
> 
> Add Fixes: tag as the fix in the next patch depends on this change.

I tend to not add Fixes tags where they are not needed. When the next
patch fails to backport automatically we will get involved to send the
full backport set. In fact I prefer that as a checkpoint to review the
backport.

Otherwise, looks good to me.
