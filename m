Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F0B79C1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbjILBnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbjILBnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:43:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C0611EBD0;
        Mon, 11 Sep 2023 18:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694481583; x=1726017583;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BExOGv6tQSpQyfviRa02jiawODdESxLM3oo1hwYhE7U=;
  b=lDCGkOOCVE4jYUVfBAvLxy4XK5okUfWVtfQCuLiXd9WRXqPrvIjDdBmc
   2PtH91aiAVUxa7yk8rJUoyoynl177hWZRnpwiMGkzw/jKqK+Hxwpe+2ZP
   xfqhCiY71H+xDzKRNUct0oEVbLbs3yQmfjKlvg9F9p1I/i2YjqLUwcaZe
   sUfanUmxBkBFreo92lHK4WxJh3ZSSAo6bwWxW6lK0oIBNHt9RXoCm+LOL
   J3KbTcwPVbT8FSGEgZYNgLEvxtR+fpYaFXOlQbZBtYj5FVzwaao8o0pzE
   0zmsL+Q/O+9AUViKc73y7RO4QnvWZCDjD0BR1KUahxtmHBk2R58AcMgXx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375581938"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="375581938"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 18:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="736951717"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="736951717"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 18:19:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 18:19:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 18:19:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 18:19:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 18:19:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPlc/04hDWeXioeUDTrPoDMKlO3lZKz4qPACPASZkqnFTQdnpSy23ZS/graoH/a3QK4V7ln40PnWftKncQK0uPayAhoVJwV3Cw6yDkDABkCDFfMC4JgiDcA8nmZosFuOWMm7i/C+r5WGMUeKkFLOjY32v8PGQORXelETDZxEu7b/VxkIXMpLmFe14iReLoXA203hdRdbQMUWi3L1gD4BNppkesbyrZbYm71xGfR967uy2kelZViwmgAEhjEpzFr9O5Gg0qbtcnLmDCllmoy+q/N9Crj/lYenwRbKAQgYv/gDifAnfqSg8SFS0eGBh3Rz287OeD3zcY93AqE6Kpy2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bSe2jBZI3oq7pIvDuYH0vUYUID1i/Mr+iDojvDy3oY=;
 b=XmklqWuJPdtgqjGu9QYxFHVQ2vImoN4AHUtFgQcAeW3mddDVa+vYd4+CHDrWRZxZonBal9AkoNScNgnh78/hsDah31fktcZ/mM01aufePJt31uhVnnWvuMq/x+p1ixAwp8z2Q6CchiKjVG07YOAIOkzYqDAJiz64rg2xXUZ356q9UJpEnmtcTjt93UDCBbpKRkgdOjezt14F4DcQ8PCYBahCck5ytLtmWLjGoUTTmzkW5br/gWEoirGDKFhrRs5niBzBMkDXbM0Jf/7T/4ioAiHh4ZPB/7xxl9ujCE5UDVR60Crz6As8n8x6yWjkmHzs7QcyTnFgs9/l0H1r5gOfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7478.namprd11.prod.outlook.com (2603:10b6:510:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 01:19:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 01:19:38 +0000
Date:   Mon, 11 Sep 2023 18:18:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 03/18] cxl/mem: Read Dynamic capacity
 configuration from the device
Message-ID: <64ffbc6d449db_2f5aa329489@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
 <ZPnwPDZrKYT7hp6X@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPnwPDZrKYT7hp6X@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 437b3bc3-d44f-4732-1b78-08dbb32e5368
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DoLcr2eC0ky9eYkS1bzoxI8uuWDIlBEQd/CtWBq33NV9rdw92yb2YPq809L3X5EAR/D/5JEL0qx7UCEtTxWPiE2FtLCX+4eIa5UOQ/GIMLMjkwEX91v4nnV4sQVWRug7b/xbpAegs6o2ZoKBGPg0UvRHRRwiyLXO3kF8bG085D27GFagW1/kDAimtUagKlHnWIT2sqbJP4Zt/rnVvisHas4lsfJjLY8NTB2aI0KL5b4M3WLKlRzLF8Le2vbklUxq05zpsAsGFv5UyrwQD6g+DVfFMlkuEYxjwEsb0XuuQ/3jmVFGhiC6qfYkuJYjB28VLOVz+FSPKivBJfv5YPTZOSZklkE8jsVX1iXiNgpgqu+02IlAGsNAOjAGTs/z2DjGh8XUQgngt0CzM/bpF/3jskMWbk6GYpSo0GzSzzlc9OrptqFx4mzfPenbuJ1JsLgLD+kbYGkwJ4Q9z6EXTitv6HBHOfM3sinnyxsTg56jc7d6Lpu8Fgloca+l5UtOed0ZQTiQ96x44EpEOhNKueSzegK9YdVaCvSGV7q9rQ2CAbzup8fbaQ1LZO5GfGrpVCI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(1800799009)(186009)(451199024)(6486002)(6506007)(41300700001)(316002)(478600001)(2906002)(86362001)(38100700002)(54906003)(66556008)(82960400001)(66946007)(66476007)(5660300002)(8936002)(8676002)(4326008)(44832011)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ksMjL2U7wH4uMXTelkWlLmHCqWugQzFcBBEK0zhHMwtWKR1HHjQLbQc9HyW?=
 =?us-ascii?Q?nYTK8bXmaV8m/dVzQlmjykJ/uM9PMtczv61wCPDTbwEfJTZBhqOZPwhEduDY?=
 =?us-ascii?Q?jLhANbQoditau2UlZi6sjl746xUY9YsBAOHK9wYa+Tt7unlt272SFlOZeQtK?=
 =?us-ascii?Q?VsxuCXt3n3dw1V9flz9yr0KCUBmoIPnDmb6iGUDiv92WbnmJ9OjeBTWLfH6W?=
 =?us-ascii?Q?4wwUJe491DyKX8cDiecxPYbvCsPWaaRcELD0TIGlqGca+4WajYLD2zYNcQfo?=
 =?us-ascii?Q?hUDflWo6b2IfKStgQe4yJK1KnwkuXC/qe9+TA9Ida4GGjvsS9do7cQsC2Y7E?=
 =?us-ascii?Q?UReC4PhP3YaM591M5NZ2aUCge76zKt4rGISr0tTPK+IIyKfR0QhA6aGjLzFg?=
 =?us-ascii?Q?wepN56WK6o5J7QAzDc8ksOgo6aH7/nGL94AFBhJTjax+8RSSRAf9Zb2zMuaz?=
 =?us-ascii?Q?O9rX1MF3Y5IVr4eQrSAC8swZBsYP9m8uIhUMjzYhW06zL84FEGie0EWjB1Ej?=
 =?us-ascii?Q?TE/g0ktpXSezkPS7GwSzvG7Xmhk8FvrlmrIKhp9FsDm7kgNPxrPrjoYg/x9i?=
 =?us-ascii?Q?CJZhMF0gp8C2YGsVI/XSILs2atzAPK2C6k2l1Rfa+slGMsEURGbXQTdiyE5a?=
 =?us-ascii?Q?/y8tDTXBJM5YCdFMcR99+SrA6h6mIrcFhM1fi0Bj910jy405N0FKBGUABpJw?=
 =?us-ascii?Q?cK+7rbQQi/SzgolLcPvgFv3qUfoDD2WV9L9hjtSKJ5oTSRmt+uutjRhZ2RSt?=
 =?us-ascii?Q?W6zuMN7cTNbeZXNfiOufeQDeuICiZaPWx8cnxXCBCG6NQ7Xvp3syYYUetK+4?=
 =?us-ascii?Q?4b1p6ik+l+p8ygzYSSH5aPum0JdOV9CSWd/oBU0NxYuk2EJvsqPUtzGEIrvx?=
 =?us-ascii?Q?QijJiQGtld9KuyGYcgGzH2PPuHu5u4t+shioutjJ0FihbxZGWDK6h7A2nknO?=
 =?us-ascii?Q?OirSaX5iT4wsOYjDJ46i1a9dY8vin451dyWiVz/DjwIhiy0kbk/KrVE+oFof?=
 =?us-ascii?Q?3VQGcSZ4g8Nw7TBYFv7U2ifZKD41SU/t0yrcyEX//OLhMfm3xRSRU76C4rK/?=
 =?us-ascii?Q?62kXCxhMQLJrJYz/YhqLrZNVUmRkAYLVHqyaBg4+Z834AfG2bA+op1JTDHwL?=
 =?us-ascii?Q?XlswuPC2rbVrGvdAW1oZuvV5nJwj17tQ4zn3GYIayHlYJZopmbe3EUbWok+5?=
 =?us-ascii?Q?83VTu13yTf9ySMzpNb2QMqV7msq6+dZrqz20HXUhOBKYgNL0+TQrATUP6aBr?=
 =?us-ascii?Q?Vdp/WZHxgZkdzKLp1ywlfu4nTsdS7kIDKkV/U6oFJTDpbch7u1MeioG9KZwx?=
 =?us-ascii?Q?09x/XO9qMsr6asBzruo/2+p/cCsRUPy2XATOGaEM9G5+6Jbc0J31EIIRD5Sh?=
 =?us-ascii?Q?F4Dy+wg2BdNKSWVg/CDWJ+T7NdsatS97/X2Xs0hYPIF+ZpSR07ZzwJhmYcH4?=
 =?us-ascii?Q?zZROAk0whV2XcuJfYOu+xu4ZU7kEyrTLCY5GKx9imC+dQ6pjRZPNrPFBFTxy?=
 =?us-ascii?Q?2FcSpgaCw166oEUFk+gG9MBuk8dFEAGGR82Co/dvZa+ejO3M/eTln5HiFZJy?=
 =?us-ascii?Q?HxC118W4xZZtb2V6SssVavBombd1tQCjtER8eLWtT6qybT5MKtdgwWqL6Vv+?=
 =?us-ascii?Q?MalwNATvbYWEBbJoxl8yg40Xz35TfwV7S3EAlwK0kJZK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 437b3bc3-d44f-4732-1b78-08dbb32e5368
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 01:19:38.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqPP0cu52mUH8io5nPuDFSUsQc72RpU8iYbf4jygwHtOVOaaV/Ck2CWL7P44ClSskW2IPad/qSmihFlIIZ1deg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7478
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield wrote:
> On Mon, Aug 28, 2023 at 10:20:54PM -0700, Ira Weiny wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Devices can optionally support Dynamic Capacity (DC).  These devices are
> > known as Dynamic Capacity Devices (DCD).
> 
> snip
> 
> > 
> > +static enum cxl_region_mode
> > +cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
> > +{
> > +	switch (mode) {
> > +	case CXL_DECODER_NONE:
> > +		return CXL_REGION_NONE;
> > +	case CXL_DECODER_RAM:
> > +		return CXL_REGION_RAM;
> > +	case CXL_DECODER_PMEM:
> > +		return CXL_REGION_PMEM;
> > +	case CXL_DECODER_DEAD:
> > +		return CXL_REGION_DEAD;
> > +	case CXL_DECODER_MIXED:
> > +	default:
> > +		return CXL_REGION_MIXED;
> > +	}
> > +
> > +	return CXL_REGION_MIXED;
> 
> Can the paths to return _MIXED be simplified here?

I suppose:

...
	case CXL_DECODER_MIXED:
	default:
		break;
	}
	
	return CXL_REGION_MIXED;
...

I don't think that makes things any better.

> 
> 
> > +}
> > +
> snip
> 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index cd4a9ffdacc7..ed282dcd5cf5 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -374,6 +374,28 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
> >  	return "mixed";
> >  }
> >  
> > +enum cxl_region_mode {
> > +	CXL_REGION_NONE,
> > +	CXL_REGION_RAM,
> > +	CXL_REGION_PMEM,
> > +	CXL_REGION_MIXED,
> > +	CXL_REGION_DEAD,
> > +};
> 
> I'm concerned about _DEAD.
> At first I was going to say name these as CXL_REGION_MODE_*, but it's
> pretty obvious that these are mode words...except for DEAD. Is that 
> an actual mode or is it some type of status? I don't think I see it
> used yet.

My first reaction was to remove this.  But I had to go back and look.  It
took me a minute to trace this.

'Dead' is not used directly.  If a decoder happens to be dead
(CXL_DECODER_DEAD) then it will eventually fail the creation of a region
with CXL_REGION_DEAD as the mode.  CXL_REGION_MIXED fails the same way but
only because mixed mode is not yet supported.  Therefore, decoder mode
DEAD indicates something different and CXL_REGION_DEAD was added to convey
this when converting.

The alternative is to be more explicit and check decoder mode to be !DEAD
prior to trying to convert.  I think I like that but I'm going to sleep on
it.

> 
> > +
> > +static inline const char *cxl_region_mode_name(enum cxl_region_mode mode)
> > +{
> > +	static const char * const names[] = {
> > +		[CXL_REGION_NONE] = "none",
> > +		[CXL_REGION_RAM] = "ram",
> > +		[CXL_REGION_PMEM] = "pmem",
> > +		[CXL_REGION_MIXED] = "mixed",
> > +	};
> > +
> > +	if (mode >= CXL_REGION_NONE && mode <= CXL_REGION_MIXED)
> > +		return names[mode];
> > +	return "mixed";
> > +}
> 
> snip
> 
> > +
> >  /**
> >   * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
> >   *
> > @@ -449,6 +464,8 @@ struct cxl_dev_state {
> >   * @enabled_cmds: Hardware commands found enabled in CEL.
> >   * @exclusive_cmds: Commands that are kernel-internal only
> >   * @total_bytes: sum of all possible capacities
> > + * @static_cap: Sum of RAM and PMEM capacities
> > + * @dynamic_cap: Complete DPA range occupied by DC regions
> 
> Wondering about renaming RAM and PMEM caps as 'static'.
> They are changeable via set partition commands.

True but they are static compared to dynamic capacity.  I'm open to other
names but !dynamic is normally referred to as static.  :-/

Thanks for the review!
Ira
