Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6223A7A15C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjIOFzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIOFz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:55:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0961BC7;
        Thu, 14 Sep 2023 22:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694757324; x=1726293324;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qchAMYZNQPXK7Ecv2VEkTgAdQJ/Z4ff3JboIgSfuXeY=;
  b=SQ573i3k5rzHk8qL+CUimc+tKAzcfxO7+KvlsOZLl0UlzrC1ODvv9BLb
   mefMOzHgcY2mxzRetcGygaZbDeFcrHfVKDimJtQrp93ekpJ83l9vljIxQ
   xjgYLS8isk39rOcs3ZO7OhdcHpBkCJqGAjgJwXKVpkPb0ZbC7ZswA/9v/
   8f0QQZXUuzInlLHcitRgvRK2HYczLjqzfuVduI2pxz/uqVGLeFKrFYNxG
   StwO7gpmLw4e4iBTOnv1ZZKgbgkZ8boz0E2lMh36cMadmIkx7jd/mCemQ
   9LwlxLKK0PlcWrAccfio55WnNAsHf4MUkOHlXnkOkHsHZVHB8LT/VWeTa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="465529913"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="465529913"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 22:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="860029118"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="860029118"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 22:55:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 22:55:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 22:55:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 22:55:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhYsG0BQrbTf3G/d//oRcxLNl/ExpIw6lI+B4pUTra02/MZQlC4iz5OY6jmsRwpN2Z0adccYrZiNOESe2YVyv+XHh63r5Aa3pjJkv2bNRCFcPHjb/SKU0avDbaIKmeOoUt37mfjfM/qZ1CpgI3ad2CgW5hhMw83iH3jNqRkZhsBTWcjuYAC9O74aZke6taUG6KVy1q9JDNd2XPcEq6CIMb7cHAtf+TsvqqxglIOgJxaiFL/JyJSSPnr6oB8T/1VDbyeFcpuao3jgPT6RQPw+1QsuNGMDUzt/t0jPKUmJdHL8Bb4IKw7girYLEgXAEmj0m5FucKlZqOax4Ukv72rRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNjUKDwaKswr+ylWJMM7V/+CMj5TmcIsXCegaJx81co=;
 b=SFRxg8zhWRsIyfcPGwMFOjgmE/pAOVgYb2tN0UQ9/GI2b6vEKCSLqRyMvgPDtcN2fqn22seXhLT49fKTtsfniQP2rP2lO/9FCCHHilUFkWwW42boDdgZrjXUcbLHH6ww4N4t8UncqNdjcJAMNvRMthjNmE0rH73zoWcpSXyegWii8KKNtIjQH4Gx8Or5OB4jnq0BcBpEOTHMtLr3OWNjkd11IvszSW5hq3kScpUCeSz9EfhaWYdsCYWQNtdJJXYjtjprxVbV75pAWi5TtXwxGn+76TwSWe+qq3hfnt+TGxEv4uPpRDgn05qbtt1dsXxFQYXto2LcA5NdA93PPg+9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DM4PR11MB5280.namprd11.prod.outlook.com (2603:10b6:5:38b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 05:55:15 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 05:55:15 +0000
Date:   Fri, 15 Sep 2023 06:55:05 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Kyle Sanderson <kyle.leet@gmail.com>
CC:     Linux-Kernal <linux-kernel@vger.kernel.org>, <qat-linux@intel.com>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: Linux 6.1.52 regression: Intel QAT kernel panic (memory
 corruption)
Message-ID: <ZQPxuZ2tifa9bQKJ@gcabiddu-mobl1.ger.corp.intel.com>
References: <CACsaVZ+LkHwTKO4XE_FFM62SbF3gGD4DZyse-9Y1UbJUgrhvfA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACsaVZ+LkHwTKO4XE_FFM62SbF3gGD4DZyse-9Y1UbJUgrhvfA@mail.gmail.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0257.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::29) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|DM4PR11MB5280:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a4380c-c920-42a1-a9a2-08dbb5b05504
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqh9kQo2WVC2JvsxRcnfg+Kok6WQDu9LpBlIUF3j/0tZNGChet/sl2ybtzLeyolFmoIJWzHRhDPkKsR4+lcqcE+xdyjFeWywpnUnwCrDZ2fHUcpyFXKUIrnoXbJwsPQasyWBmFEykznjrSBu1F/SQa95kKCzOI1+aptHIKSDeQA1g/sNEf679VCgvwRKIYXuy4WMXDt9pnHSBhYTuxS6ynnutEFus7yHBVy/oVGHMd5ZjESOuhXNV/BKk+myqR36oI2nMCQerOfwgU3mhAl/bMy0EV9M69qB3y/eOZ4W5Fl+XYtgYI7poX21X7bxadebiNrO2RsZ/kyWcOz8BELVyB5uSoE4//KxM+9pKY+oBQ0QgJvFKmCYPCum9Uf33efQTjBzUIXulWuaWXUhHzLh4o++xyki97CWODESuaGK98Wk5+Vm1KlR5GYXOE8/Vy28sCII86byce1JR+H4tyyv40g74PvVe1ozDnRb4a+uubt2EHe0rvtCjNgkX1EiXB0Z1fdT7byWbbjxHUdaz0tyM/ZoIZqfGg/TL/452suO/OU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199024)(1800799009)(186009)(44832011)(8936002)(8676002)(5660300002)(4326008)(6512007)(6666004)(6486002)(26005)(83380400001)(6506007)(36916002)(478600001)(86362001)(41300700001)(316002)(6916009)(54906003)(66556008)(66476007)(66946007)(2906002)(966005)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WYA6Hoc+OLxR/riseT5vR+i329oX0Gp+1Fxwe3rVDs07yAyLIVvYYKkZODFx?=
 =?us-ascii?Q?CHhpvK0sHqeBfC57wS+tsshV0qq0E/6YQkaW2MT4g17VPu7sv78Sbt+wiJUd?=
 =?us-ascii?Q?oePTfFOPnLnSh42LfHgzpgI12EAhh1ZB7Y9xBkR1yRRYUqB2ik2u4o91/V4M?=
 =?us-ascii?Q?6sCy+tvf2c8gizZ+8oWD6m1pOqtmc1TrCsWxGq2C1lEggOzqfls1Pbin0cGq?=
 =?us-ascii?Q?gEmmeZh6zJB/S0Tv+60WvZg0gMQ/pbzCRC74Aaj4ulHZ+JO8+7bV/PpBRl/V?=
 =?us-ascii?Q?Rt7uy4aRcWgFRu3VuAb+Oy1GPRDQbk5vUvYPwkkFuzI5LTdEViKr5gu/5zG9?=
 =?us-ascii?Q?64N0HVg/aR1EV6pxMki5/5aXnA5NY/Gc3x3Kv9UHXLuuzeaAxEkm9g4WcuQd?=
 =?us-ascii?Q?b76F99RRG8qiawklWdvsiS5igddLakdXwureUMz9b0VdLIDfFqqoDnxIROW9?=
 =?us-ascii?Q?e6Gm0r0oFiXUOT+gpzFM8HdHWahVO/PmKNCEFvIggbv1lm7shG5/uiP0Wy7m?=
 =?us-ascii?Q?dtZD0nnkUXS8v6AelLbSMEioI51CtXiW4JGFGd7pBGPvWwNwSymPYr1CSCod?=
 =?us-ascii?Q?m/W1477+Rr5rt8BQNRrqyy8Avq5pUYvjFPIPlAAi+kdGytK+AY2VBcEKX3mr?=
 =?us-ascii?Q?ZhhoG/OeAmwe8jdBRVv0665gEfrJrIQyP8XcZy6+tubegJvkyNayzsf/IWAp?=
 =?us-ascii?Q?seR3vDdmZGzKdgxgTyumUSd10HWDFT5U1Z6me4fZkcH0mnbSMOYyRU2SioSL?=
 =?us-ascii?Q?+dQhJ0QkuORdzxCnAjJuXAe5I0Ja8GALsKBFhtSweQlrUkeV+AeOrEYnB0YI?=
 =?us-ascii?Q?sB42nDO6vTuFfW89sm2j2bl60NrZhFoT2wVWZKzU1edxqb03NCiiVuuUA6wy?=
 =?us-ascii?Q?5GowG32ohqudS+F6nze2PUs1oaf1fpMa1SzjgGliFy66M0jOzu7ldDMooPOf?=
 =?us-ascii?Q?ZGv6e364RsBQsMS/ZbEmEERto2l/nUzNbbUCjEYNdByDf1/tAoi35YgT3Z4q?=
 =?us-ascii?Q?f9wRqEYJOa3bfL9Er7u0ixkJOhxNCk1KCAH1cnktf30uV2MeUIR3OI6ngW7U?=
 =?us-ascii?Q?ZNc8Rb23w/u8FACmuD4Ha+pfRwGCRI1dttgyNQ64DwhDYGTjMwtnqXWdDlBZ?=
 =?us-ascii?Q?ACM7sr4PeCeLXM4ygDi1q1zWgK/g8+bT3wnNRWyW7pPRK7wXIbGIirVlPdjv?=
 =?us-ascii?Q?RyBhuT47OlmhkwKl0Yv6cPAm/lvouazXIv456eMMzPvf+oHEiqnAUobWqrk3?=
 =?us-ascii?Q?/BStUng7SwlM76zwg7BJLmfzVbC2QpKja8Qw5Xg7tZq9Lx8I6xFaaZDDcO31?=
 =?us-ascii?Q?0K7rWZKaXT2VY1K/XY8oUqoaZLyaaccapSXdtqtuyHcZj+uFtnt/50BKLwx2?=
 =?us-ascii?Q?6I4oCOe2yFUPWpmsOTG+xuNnw0X/satpzHAF7RWW/8EEERf7TMAKCwEMHi1m?=
 =?us-ascii?Q?25V9K5ArGz2xQarMWaEFK0rvbailKmSsxOuymrnoPwZxLPvczXkqhMiZUq2l?=
 =?us-ascii?Q?ULS2Nd2bdOpfF+ymXshPQLLVPZHDeLpHQOt5ve1v2F7bKBHKL+jtVLD7yf4W?=
 =?us-ascii?Q?ZIEtp1yv68nWry6XQAB2tYCL/TwHnBP4X7j86QhcB2ixGC9uweDszBR3+srl?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a4380c-c920-42a1-a9a2-08dbb5b05504
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:55:14.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6CqHv7Ug2nctigSasw/GB/14J9RrNSGLIm4ZFM0Q3IE4avafr+05OaGFRSbQLXFgIgTa8ZNDy4hd6YZXjhs+T712AKqHlue59OkR7cbjqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5280
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

On Thu, Sep 14, 2023 at 10:27:22PM -0700, Kyle Sanderson wrote:
> Hello Intel QAT Maintainers,
> 
> It looks like QAT has regressed again. The present symptom is just
> straight up memory corruption. I was running Canonical 6.1.0-1017-oem
> and it doesn't happen, with 6.1.0-1020-oem and 6.1.0-1021-oem it does.
> I don't know what these map to upstream, however with NixOS installed
> the same corruption failure occurs on 6.1.52. The stack traces give
> illegal instructions and all kinds of badness across all modules when
> the device is simply present on the system, resulting in a hung
> system, or a multitude of processes crashing and the system failing to
> start. Disabling the device in the system BIOS results in a working
> system, and no extreme corruption. kmem_cache_alloc_node is the common
> fixture in the traces (I don't have a serial line), but I suspect
> that's not where the problem is. The corruption this time happens
> without block crypto being involved, and simply booting the installer
> from a USB stick.
This is probably be related to [1].
Versions from 6.1.39 to 6.1.52 are affected. Fixed in v6.1.53.

[1] https://www.spinics.net/lists/stable/msg678947.html

Regards,

-- 
Giovanni
