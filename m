Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53647DFBEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377374AbjKBVJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjKBVJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:09:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4885B7;
        Thu,  2 Nov 2023 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698959382; x=1730495382;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=apbU3aFM7d6FER40uh/ikOaNVqX//tNLV501AtkLwWA=;
  b=Zi2H1fDkWsHI/7CaSnR38PoJTBjoqTCXnSXEMbn0cbFteMLaj+CQDHDx
   gUGbv+NLpW1WQbfjkwPKpuYLSjmvZYM8ng4nl1gQyoCqsHNRj5RiYeBpn
   SfJxvgeXLh7KMhaxzWC1gunU8I08U9OsvhABqUgIYqO1TPvDv0oBTUf10
   nVKG7NYgTtzR4gD6GfUFIE8TDpaComQZXxJ+SGW86nyFTkGo6djNxdWfG
   ocbrodx/KcmDcARnqymSIMa/bbsAeYGH0S/MQIelbpa71J8A5w/9mKBJH
   TJmF718p6Uj6R5YULnqedtd9rNb/KklzANqRQxLqSLpEZy7sW5z/K7S6U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="453119325"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="453119325"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 14:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="765048080"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="765048080"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 14:09:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 14:09:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 14:09:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 14:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QILnvWmsybttD7F4E/PEfz7wgRoTzgTPRhS41WW/rRDVDkijFdqks17755Uc6fCk3FAdjk9N2mklcnfviZot6KPcNFL5CkezHIqhFe3HOzjrWvQNXzilkdNS/CRr0xpMSR/v6WuD4wgRlwtBpWK0zX8jeLg9VwcK94GGiXq+Wjm1FoWwHOaiTEgDPw2hsInxrqtA1FYcOsc+txqlenStoLZWUuzraJqLtADNes9fs8JY3OfhsC9VwvYb/yd1iDFT+gq4t0BaWfJuuOtWTWhg0rvsP4FF5xN62k6TX4YSiBk/MCi8jHCEYhY+PsKmfwcAWmJrobxcQmOpcMHidDYCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUquRWNGY8TxGfFjPHeWCTyMQMWCl9sB+XPiLTQkSF0=;
 b=RdkZ4Ex+cEsnFeq6GM5Zpf4Wpj/r2ApAauWgr4RsXo9YxY58zGDd35Ok0p4r+01Oy6qq7zFrAjPVZT1U6h3Eh8dXhvJ/QZSGHCe4+ukf0r1vlLXNvX2JFVInGkL/RqWjIjv8OA/thOm5Yu0Cl4DXEfi1hsLmwd6ABxf5noOrxi8l896PjtLBf2aX1ES+Ywq7mMagxfnwmM+ligZNwdi25+gny/Wr/FUizz0k/HwCovv2GEhWPQVCW6Bt5JFMAF36wCtMjcWVE2Df2BdGcFkgkapKxPZkDNP9g9Cs6GDwpPO+cBQl2UzICj3v7t3ZMamaxH4bmNtO/onN9wlZyQXIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7340.namprd11.prod.outlook.com (2603:10b6:930:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 21:09:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6933.026; Thu, 2 Nov 2023
 21:09:26 +0000
Date:   Thu, 2 Nov 2023 14:09:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
        <rrichter@amd.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/pci: Change CXL AER support check to use native AER
Message-ID: <654410047189f_780ef29411@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231102155232.1421261-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231102155232.1421261-1-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:303:8e::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3c99a2-afdf-4a44-ba57-08dbdbe7ff21
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hi2m/DSBVQOQppOTpmNHOpkK/cwi2ABi6Y5c50i6rifSt9Nr29yHyE1bm395r2HplFpblhlxLteZ2iIlG0JJYyjBCEFudP/CnERDwV2Qa/JcAp+mfCFy3BldAB6Re4eca1GSVWdxXPYcBf52dlNaJOOzM7vhg1PEGQct/xHvqVZKHUVcOqo5GBy+8bUavTmrceHGsQ+yv/bVnGvsg3yWgUEqs3bOeycCR+7p3ARAK+j+XmjGEzkDToQQ0YqYg0Af1Fp7v7FodlXLq9zfzywcBitTwX1+MGsMNfX4tG2mJp37Mw1F0+CBUvycxbfcw3/uRbo6bX5c95Hh6CigNmykaFKd9god6yWebsQtro9eHUL/vKPWhm7ktrmKC8Rwtg2VVQtBJKWdRLyGxiIcZHaXVDpJ4KNNWPxa8WQoo/MzHThRcMMLneIbhkyJU7eq1Q5Ky4vDzG8nkxl7NmtroG+Ho5IxsAERZ8dzouv3zpbwdVmHNPec6BN1ahPrmU51z5f+pK0tTO8l2ptBoFr6rjHQT7VWQvl7/q+gdN2yPw0k55Z9yRzWIvYMgRmBSJHW/CoR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(86362001)(82960400001)(2906002)(6486002)(6512007)(9686003)(41300700001)(478600001)(4744005)(8676002)(8936002)(4326008)(6506007)(26005)(66556008)(5660300002)(316002)(66476007)(66946007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jgZOp4+LeqjMIlIGnTGP9nNUyimUGMRuxh1vxP3oCBWKTxtUZRZ4ki6egPMF?=
 =?us-ascii?Q?gignUh/0MQfTe5uNCRroCiKqn6cvj21dCNFqvh6gSm9k7qiTCZwCQOpt2xUq?=
 =?us-ascii?Q?PuJFyl5D4M5fy7GZbQfUdC/5gaAgJ7fhPJypGhMix940nm26BmwHMzpWtgYH?=
 =?us-ascii?Q?buQ5iaXrDU1FtsBrR+DZ6WGG3SDewFTTwuORVPHXsP4WBTdgQdAnlCypZOuZ?=
 =?us-ascii?Q?72AEkoX6wFpfE5Byla1VOfkBcbEQJsi7ESX6cLT4ZncP+JQurpUdiU6O1ofJ?=
 =?us-ascii?Q?Qdc63AyunMAgufzqcRGiH5xzHxJwR7Gx1aDOD52kLAVAzLtnbi3XW9eOKibb?=
 =?us-ascii?Q?3tCf17ODI9SNdlzq+eeWneAOK16U86IZwnibnVinTP0Rgo4gY4fTHEuqgpp4?=
 =?us-ascii?Q?cARkn8iktvCpIOl5+cD7u1BcD6CisH3FlKymukducImfU8ZJ5PH3euQRD1wi?=
 =?us-ascii?Q?JZly+j8LojQY4QDx6R2wfYUoN4a+bhCcokrNGJy8Et9m/o5rWNjdljp+kuam?=
 =?us-ascii?Q?j8jEEzFsWD003Mk8+z/I/Ld9wlB7T3V7WWALDCgr759VvQMWT7V9Wi1xKmp/?=
 =?us-ascii?Q?yfxWED2SnZi4oL1CCdis2XVjfH7+9TCL5q/7dAOQ8gM07uRjHy9kxdrnKEfo?=
 =?us-ascii?Q?pDwD2Q1KimChHs6+Hy2NLwnUt/4Q2uldAksH2MZkk7BF+56/hTBhVw9okHpo?=
 =?us-ascii?Q?jDRNJmH0fR3oaN0O8v3ZrmQ0IYfTxupIDrxsee4+lL0nreUVcJ+8ICaJKVWw?=
 =?us-ascii?Q?nDXPqKWCWDPfCryMTN+4HNNtKrxqhQun1ClMXQjb1Xn9v7mJZqsnsdoSOSYS?=
 =?us-ascii?Q?kAJEjv7dG1MLTEsj7/LvHWsvuItDfWKtyF0H2h2SYXO335+n/6iz+0I4go/m?=
 =?us-ascii?Q?l+9ieJPEJNVrDRloCXficriN0h2eScAOTWyN7+YzzBYctu7zHKYpUfLA6O1m?=
 =?us-ascii?Q?Bq6A0rTYTdwMzelh+RlPDmolIbIWBtHFmLJiem5TAEHKlD7T2aofae9fjloz?=
 =?us-ascii?Q?gMbGh+rSHP/i4mAIZFNrbHIvKm9Ail1LkM1S4Cu8vpw3wvYXhCaAtlnNXDS6?=
 =?us-ascii?Q?yDbKnuY0vKRzD0JdD2whrSFRBDhBSJ56TOo6h68718EbD7avgoFLnzpbbdCZ?=
 =?us-ascii?Q?QEXMRAh/NH7E+baEa+cLIQfowqEaM1AybruJGSmrDz4mHs3bIurY7BEak30/?=
 =?us-ascii?Q?6RJR9+PbGHE5xnHAGPZKogqMn9DPeOeaXCYWy/tzdSizDZoNi+g/NrvgFr+m?=
 =?us-ascii?Q?YsVSkbysxD31vUKO6MaRVAtpLGhikyduJ3CyU+MDXlbk7sK1hbaisYzdj05y?=
 =?us-ascii?Q?Qm+tLSOYTXeRFFw6jOVSmTapd9EESdHtLesNSbmYbnFmKbUIUjSM2MnnkCqN?=
 =?us-ascii?Q?wYSqvubvFRSJXKzjpPYyeiKZGo5gz2Me2VT3vB+yrYJLGQsxOVf+WvcTPU3M?=
 =?us-ascii?Q?qkHzaJBUuM7FG8WpkRlqIgGGfiAFFFkrdQndJU1wZLRUj1eujeS6GjasEYKN?=
 =?us-ascii?Q?rov3RyLAczyV3RCioSdf2QGJQurkun+nr3BXJzEqJll8USrTdMUI7ka99ywT?=
 =?us-ascii?Q?ZiJohV0OpqXjdAUc/ocTwcvY7xRrZ42/xBF8QcJyZI1oYw2r4OzRQ1UR76t9?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3c99a2-afdf-4a44-ba57-08dbdbe7ff21
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 21:09:26.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioeLhdE/w2lP4p6Kf8mKKupQYDk4EyfrHamJnRoOt9kIll1m2V8q5LIaTuw2x+gkTqr4PVulDg2LYR4fD4cM0JSQL+0tTkbBqHraWO9BS28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> Native CXL protocol errors are delivered to the OS through AER
> reporting. The owner of AER owns CXL Protocol error management with
> respect to _OSC negotiation.[1] CXL device errors are handled by a
> separate interrupt with native control gated by _OSC control field
> 'CXL Memory Error Reporting Control'.
> 
> The CXL driver incorrectly checks for 'CXL Memory Error Reporting
> Control' before accessing AER registers and caching RCH downport
> AER registers. Replace the current check in these 2 cases with
> native AER checks.
> 
> [1] CXL 3.0 - 9.17.2 CXL _OSC, Table-9-26, Interpretation of CXL
> _OSC Support Fields, p.641

Makes sense, applied.
