Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57357DFBF5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377357AbjKBVRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjKBVRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:17:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F2E194;
        Thu,  2 Nov 2023 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698959829; x=1730495829;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=delBN8wb2Nv8Ocwj91rwFuf4nQOZrTA55mcEVRmcoCU=;
  b=UlFEP9h1eBG5OY8tiPox0puccO1dFk8OBT6706ccpNIvkPLp6VHfQvWD
   96HLZ2r9E986rJK/iczixYj1NTazRXtcqiE3Na9Lm49tPUqfWMv2awQEA
   bGlx45euhubuBcXgCj8lNpwW7+nsVZ8ZND4emsgPJqKhBoIvPDMmRc8QC
   FvSBo09hxOOu7eW+gi8NFx+Rh8rMzVX9eZEUB5gQlTIBYHlI69yA7KdSu
   HwfPOAA4a+AYC7w159b/h/3XCAaVB5Ans+x6BWOre/GSm4FaDsOUkjikv
   w6rLPWAdHEui5+OtYwalBidWgejWMTQTZmjtYEm+8vrDANy6SBKpJTa4s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388641411"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="388641411"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 14:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1008597919"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1008597919"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 14:13:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 14:13:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 14:13:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 14:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feic7Ng3xpjGAV+S/d32VFKAi4ttnYrOGyTv/vcTSdqPR0UcD+senF2RIy4E8LT9a35AdxzJEryqeoZV6pkNqse2/5C8wdMp4rbKPanGIjg6faETjtSsuJUnd/0BhtHMfSHH77GnpoR3Q0TS6ZQKvEwvQtrMq1Os0yWO3YOrasxA+y3SLyi0579n8/jpoohFFHrp+GAHFhBcD+leSRqr28tkfKg9gqfXr/36rv0ECeiYp5MJEan1VzJotumnFqhSJgOIB/IKgSI6P8yJIyoM9oq7FaEmYG/+KT5zgNCBQSpMHWIiGbWIOS55V79ilfEWau2ixIJnzXYl87Lv+2Mo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh7gvslDC+1dQt7HEL2CsP3GK0jJUQ4WdxpSHEyNveI=;
 b=hnOCaBKUOQVHlCQNunHuAP3K72Bbmlv5P98+szirZFVzg3MYz9A4SvbknqeMOkEuL1fAa7ezIGUl1FshJ1XFXrYtEi2mPEKCSGXzXwawArb0qMXKyvDCiKxVbIMYuRpZt+fP7RZ/j2+HjKcU+dkXnEKdElJqXBTQo2YZxaZb6mYT80YM6eqHzzM1yw6lKFjPoKFls7g3jZuaNGaZlNVwBbtCykg1wy+qT6+Yi+Rcbek2Wa7VrGVIFZI73xre2E+gYVgfhGM50WUMP7nDKI8lFqbrg1BnvD9yPRQSTXeLYNiwElKmY1vfxvkQ4jdImRjbdBH99PhKSpjwCM+o/hvrWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7340.namprd11.prod.outlook.com (2603:10b6:930:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 21:13:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6933.026; Thu, 2 Nov 2023
 21:13:42 +0000
Date:   Thu, 2 Nov 2023 14:13:39 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Terry Bowman <terry.bowman@amd.com>
CC:     <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/pci: Change CXL AER support check to use native AER
Message-ID: <65441103b3b1b_44d229485@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231102155232.1421261-1-terry.bowman@amd.com>
 <ZUQEa1q/R2KBF/3W@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZUQEa1q/R2KBF/3W@aschofie-mobl2>
X-ClientProxiedBy: MW4PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:303:b7::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: f4955f19-066f-40db-8fbb-08dbdbe89762
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKB3KW6rtBh/VX6EmtR3QCyWBD5PKzlZAHbGSsoSFyV1mbesIU3zsz+RDHl8nVINbpaqiV8bwcyT5DPl63T+N8ZwKjQUSxBFtHoqzWfFqB3o8PXBXEWq/wb2UdBLfn+o7tsg1K+h3Sl/h2O5H85ajeVbXW7VHYS6Z0sBcnLuRVSx4rwCUfZuXwlTK8PhpsScu+/AMxOuyLSTYTzJy4n4Snk0IUz2Re7Ls4iop4DvTK9nPZ1k7ZJYu+SSyTGnGNOmiNyAUpP/X//4aL6edKgo5iZCIHbZWqsxbDxntbd5NpGrKl6085iU/xEBBuYULyzfKNC0ihATjo2fcwWdPIeD1e/Wye1V+XPI2+yBfcUMHW8qrriI0LkUPjdFnbnQ1BmrpMmbLf42219xXkrJ2blqm7IMgPqAKGP2BwLw5WKrmc9D5cqdYfcp/rzc7s+m1Qw3KCBMsoohCwbti980D8fDGarX7MUyGM1WhPpXAk2wvtshOEwTGm9wGx4/e4gyEq/S6zpzyYV3rVCo3YVeC4Y5U358M0v+ej4u92QDuq215hpfFuyUn56Hd2kM1aAyoyE/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(86362001)(82960400001)(2906002)(6486002)(6512007)(9686003)(41300700001)(478600001)(8676002)(8936002)(4326008)(6666004)(6506007)(26005)(110136005)(66556008)(5660300002)(316002)(66476007)(66946007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zJCrI9hwK9EjocqzVhNzzqM74WggV06uv1hDj+KmxKLmXSQZP1jU2tqJcbh8?=
 =?us-ascii?Q?dQ4lh2rgrace7isIDOpdg8DVFSnZamdnMyCCyW/F39r962J7F6C80pVH15Jm?=
 =?us-ascii?Q?42cWZmHfizxlSTNSYGuNa6vQTMyuIwjWK80VmcTdNpEMmYBP7iLCKmINGJ3r?=
 =?us-ascii?Q?A4mIu5ctkdwlQIKaiTNMF3EI+aubNO/AjcxQCyPxDmigjsPgRYBvH5Rt/kxE?=
 =?us-ascii?Q?I4YxuthxVncmhDIQy6L27MJ+aA79zbYlrqWLdVGa1S9IWfcCV9pVYEL0Q2Ip?=
 =?us-ascii?Q?2IQqsRI4hSuuTzo+KYlFm6T8mdFJ1ELDLNBakBvLAvF4GwaYKIqFa8xBJAY1?=
 =?us-ascii?Q?UDkPmc7NShFkiMaEIuFwSOhA/xprTboFhrPi1sNJdz3gl5BMVDch/m/YW4FQ?=
 =?us-ascii?Q?trt2Svh3GbLyaRoNjPvqZ7jOBxOjJt7rGlXd93VT3acr3D+CSiV7UQahVoxV?=
 =?us-ascii?Q?cYyWlHvbI4+UOC6YYDkULxnN1wYp+s6FycnI/8/ToapbSFKonLZPP+g9AELB?=
 =?us-ascii?Q?IhseMtZAGeFj1YlDc6B8/TGN3vmLc8Xnr1Jb2o0t0ZCfiwKpI2pNgb4IXXHu?=
 =?us-ascii?Q?ESv8zoNcEAgJx4GCgRqVZXX/moIgg4Dy8I8/nhtkaRaYRTcyKIBtmMRW+pvI?=
 =?us-ascii?Q?HJH9hhfqVkQ55R9d4a3KFtpCUYwrGa7eZMXCRGTVAjqgOKcFsh6KptT2e3in?=
 =?us-ascii?Q?6Qr9E8jrE3fcvLJymYWgZmcQa8Olo6Vrtm8l/xscn2XStehgK0dD/gucyQpI?=
 =?us-ascii?Q?k9wn3iIosAKoxTR/F2q5jr7arLYvVyBKl7bsmybW0GrepMsjlM0T2f4BUPdq?=
 =?us-ascii?Q?LyXbdwILhWKSRdmBYM9wvJB9csf+gjLzQasNiaHofv0/thwQEwBMwEE9HOYW?=
 =?us-ascii?Q?gVHIoHeVEkyCHmJ1rryxM11T5H5EcuBxUvpaVANqy56rKdVQ34S+92wQVyRQ?=
 =?us-ascii?Q?KOawvlnxbUQrGQaHLGFTvKzdbkuryCyNSsK+cMmTQu8Ci0T3Gp/lpuMV69WW?=
 =?us-ascii?Q?dUahUcMAs1EEqhiMqaY11Rugd61dWAZpfRNxadMn574E8thmLAKpatwJX4gs?=
 =?us-ascii?Q?Nume7GYJ1ePyGtgwDvSnSzVmlXvE5u/F9eRYk44M70zFGWMlmTDwEaRJ2/TL?=
 =?us-ascii?Q?3i7tQ6fG4uHW8GTQsA9PDRy9Thh/ZRPjutm3BT1XeUcRkq4JU8PxXvaJ7z/H?=
 =?us-ascii?Q?9mjoRZ9Nezw8m41CSBw4y2W7EzKFCJtHlqOgg5zvEIbimgKfnzBAUZiAMQbV?=
 =?us-ascii?Q?YLpE0BoTJpG0V3pbRdHAJBNXZmsCo1OIvSpVzSOo/51gIXxDXu5OUx73su2I?=
 =?us-ascii?Q?Qpjl99ubiJx1qjkjKlaQ4i5h0zwfV0MQzoydoED7JHuZCg3x1+zwQmts//8F?=
 =?us-ascii?Q?j4kG/f2DkguNE6oX7ULpON62uhZeo4m1MJngjUOTZCKaMnl/U8L7AZIKFpED?=
 =?us-ascii?Q?rZcVjF4GMgHCtoJqRdr4DVIaZuQ6rL4zcvd8U6uUxCIBuLCScAeTAjenVJXB?=
 =?us-ascii?Q?i5E/Tl1ds/6WMzEfR6OfWOWtmI9w3/RZd7XmRP4WKQdQci66yiiuUNOGpN59?=
 =?us-ascii?Q?2CXzVWIUGSUxW3ctfmwavtTTZGBMS08SytKaIJuYPDaSyrvBDW3eGhaFUwlO?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4955f19-066f-40db-8fbb-08dbdbe89762
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 21:13:42.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ohhh/H70VdIqr/qLKCaKnB54EgvTQ/GK4ABXQ0KqfABoK9yJTwu9jDbk4QeQYS9pfjHJViYTuAojRopFjmCELYq28PDNVfvAQMU4q4kX5A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield wrote:
> On Thu, Nov 02, 2023 at 10:52:32AM -0500, Terry Bowman wrote:
> > Native CXL protocol errors are delivered to the OS through AER
> > reporting. The owner of AER owns CXL Protocol error management with
> > respect to _OSC negotiation.[1] CXL device errors are handled by a
> > separate interrupt with native control gated by _OSC control field
> > 'CXL Memory Error Reporting Control'.
> > 
> > The CXL driver incorrectly checks for 'CXL Memory Error Reporting
> > Control' before accessing AER registers and caching RCH downport
> > AER registers. Replace the current check in these 2 cases with
> > native AER checks.
> 
> Hi Terry,  Does this have a user visible impact? 

Saw this after I applied it. It is good feedback in general.

The reason I did not ask for this clarification was that this is fixing
brand new code and was just using the wrong flag, so I had the context.
A backporter will never need to make a judgement call about this patch.

The end user impact is that CXL protocol errors that could be handled by
AER will not be handled if Linux failed to negotiate memory error
handling. Memory errors are strictly related to memory-error-record
events, not protocol errors.
