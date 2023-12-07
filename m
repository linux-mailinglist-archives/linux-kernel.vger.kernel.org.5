Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB4809330
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443966AbjLGVS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjLGVSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:18:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C962D12D;
        Thu,  7 Dec 2023 13:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701983910; x=1733519910;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LuFnh+rhiBWvPYBGamRORRKVvqfB2DzYXyj/XdXO+rE=;
  b=TMYvVDdCqGrulEcmHCgeUz0YA5Xq3ax4WPGA/RI8KiFKCakJyxU6k9eg
   Spw8ZkqneOGOuM7dMBbOzRq45B+yg0MdTTdtkZ4YlGGaXq2LTZHUbwfVz
   7gCiJU+yer7ypXu4yxkOT5WEpRXy8gtPVLMVm7s6YAneJTf2hNJf35/iN
   ow5RIPRWxuoGM7ezg3yi6ih+bsuHzhAYSvJhCubdTfFbllR2uTvF5xDMD
   4l+MSc97i2rMYM0F+Qn/CcB1OeMMX+GFuwQZ7xfFEx6H/MKUk0KYzkiFk
   JtkIDNKhHWSDdFipLag3veRuHTns4bme26ItgBVYldRy8rEWhi2iNk5Uw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397097783"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="397097783"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 13:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="806164680"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="806164680"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 13:18:28 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 13:18:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 13:18:28 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 13:18:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8nk303FklwzHlR9fUwn+ur1JP+WVHwawkczDtBC3vmuqopOh7koSTqeZGmqejqztqdjDNDpKIFO9jX1DXqdjA8ZhOzk1zm66JHmjrj7MHq0kmSefCtICX2agc0xjWNg3IRl4QOUE3GWw9J/xAhb9/BALPXICsDLzuXGKjof/yZlluhS/wJQa1iScxXPHX7yZu336ef6ZtquQaKMEhjPaUgbXEwPkyu/lF/MViQSEPOrEK4PVhcmtI9P3NScYQrs7LNEFGSwwa5g//gqZRU6b4yt4Y566GagK5pdwuA5hG/hJyNVbCZbd/ls9JiOALtIcEeT2kC7UPMBpGmggojyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR7aCi7IvdnMZNSHP0FeAfxaJqJHocalxGXya+eZw+Q=;
 b=UCI1fGTtRKxSsMoN9v+slx8V1HI4l0tLsRDT/b1NKA4XOnRl4LHBvlQ+NMwT9Yo8zVnW5EQ2yGUThfejusgKhgokRiivOJkZFkI3WButaDYXVj20Q/rWNMZkGeuv627DhpiuvAJvSZd+ngFW40F7iFwpAFUx0FdiYRzuY1wyiFPACepq85l068I+QAiKurpQzYKB2EHogE98rSeEAmgN/2wX+t64RXJLAcLWXlu7mLCKGfoQaqOrQhY6ROK+biykLiJfCcYTLoD45wKwic9W0s+Y7rDBXy/fxBBZkJA2PJKL52rqntCCx9DbkFQv/VgRNip8f34mm2qjTmx1ckjW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 21:18:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 21:18:25 +0000
Date:   Thu, 7 Dec 2023 13:18:22 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>, Robert Richter <rrichter@amd.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fan Ni <nifan.cxl@gmail.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
Message-ID: <6572369ea4080_4568a2945f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
 <ZVfIaNhiSc-yQZo5@rric.localdomain>
 <ZVfJ6Fxidvw_gz7r@rric.localdomain>
 <656648433bd82_888fe294a6@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <656648433bd82_888fe294a6@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ffa599-688b-4a84-b59d-08dbf76a0cb9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8wiJ7TMHK4rYyh7m6+/S+1NcoO8WbWk/Ylhv6ZcYV0T6DIg4/V8zY4JdycdzGWqj41blYpp5kMzv9fn6UWAuvAf4kQn9WwmnO+C9iES+C9THDh8qOANFYPgBHQy+2FgHvOKcb8x+5WG7LUQrlmmHMaf0/PT6hjogx4KfVMX6aNeJiOxh080R1CeOKu6l9sK1R0t4G+mfeU8dent2BDeBmQsetghNsAeYoPdNhRFn4jRMlZxImFNxH80T7o7ySZxzdk8uGCgRy5jfUoZLuYT7yPKWKli3r9FfPh1Hx2mqWOeo5W/2ZVKouIfAQxpUT4xp0b+m2gm2APXJmcNgYhM8R4Jy/qt/4teWHpiML3J+IaMmfJRK3gqTg8JAjY2tQgfbTNvvumZR64Kl6yWGrj5/Nm0Hc1hp/EKy1Kyr1PVMLmAM+xAGIjkrwc/9LmK/hMv4lGYsgepUMfEIuIpQ7pLiRps+4P9/HB5vWr44oHwn7TCE7Km2MULuivntSeKKP+7fuGfKQQsW0gs2fkl4kQw6x53Eux3VkedkKB60oZbc5Fyi6NHYgOTis5LXB/ZWxJ61KSuSlvR5a60haZcSq1qzNmOS2AoQcwtdk0TLxh6rzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6486002)(66476007)(66556008)(478600001)(54906003)(110136005)(316002)(8676002)(66946007)(26005)(6506007)(6666004)(9686003)(8936002)(6512007)(38100700002)(41300700001)(82960400001)(4326008)(2906002)(5660300002)(4744005)(86362001)(26583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D0HUA3OVo+yZY6i+xzZITTc4FWG3tIegrlM/2HbtrpQjHIqvBtO4ryxMpEcV?=
 =?us-ascii?Q?yakT0sDBwkRJB2RJ1zwG2WghLfnk5omwudFBtRPBJukYyu5H1Gy9cvvam9SP?=
 =?us-ascii?Q?5CxX06JE/dISxc/ItRmbxSeW+7r5p6OGFK9Ebdfbh9e7Z+Ee6GeRlP/hQ6Iw?=
 =?us-ascii?Q?6W+Teg9+uVeg5bYsKOjYmuCJrvd5pBwNao3Yn8X40oCkPszdmY1r4/aVS3fl?=
 =?us-ascii?Q?gEkNyJWty6RwCBXNCxQ30ziL4jj1uXaQIVhlWcIACKHfnLVPIHFYv3wCNREm?=
 =?us-ascii?Q?znSmvSMbzQ4Rg4BXoaC0+9h2X2cs5QV3semCWXUCs0g/MouUcuDkgPWB4Lzi?=
 =?us-ascii?Q?TCS7LF/0RQv/B2OTNBZpbkTFi+V2AflEQHo5rXH+Hu7dpEnxDtJ3Q0oB7g1U?=
 =?us-ascii?Q?3yswhcU+zgI0JMMw2ndl9UQVqhYyQ56SatWWliOFFn6QxerbZvEah3AN5pHI?=
 =?us-ascii?Q?tA3PuKRXrySuoEWBU+mTV2zb95QOMC4wjcewTOYpNMpt/646zvHxBBHkelo/?=
 =?us-ascii?Q?+O3D3ShcuaeYCbcBaks5WByD2NQ3UIC9sqG2m/4Gh0SxjLhuZ+/qmZwSgrCT?=
 =?us-ascii?Q?s7MW/yTb3jO1ZlCM3zeyb0Y0m6VqZGoR8rLXJzrbJYMyHrdVGP6RA03aFV9H?=
 =?us-ascii?Q?wroXGe1Yryc6paogGVlBwkZSHGtWhbR5Rk8DkuX76j8moS52h8qcOzlGBj/s?=
 =?us-ascii?Q?+BgDDnrhClFwWCgq8fVuk1nr3MQ42be3dRfKE27nazfhCECLfRUPodGgTVsr?=
 =?us-ascii?Q?FYM6WOMhOnlPPamZGv62tkb0k8uYd46mrA28haNwaWK8wgkkJEv+CfqrwnYF?=
 =?us-ascii?Q?TvA58FUM3Mkv+YPEmqxMo+ZJbushgGio7q6ZLa8th19gPEvN0Qv88aMond4c?=
 =?us-ascii?Q?YP59FbFxEGY15d3S+U0M+GrwsLpyKG544+YDte1vnxqAgw74RDrFb+B+RRrE?=
 =?us-ascii?Q?itdsgVrnPlh6p2A7mN5nrs/dcC+WDa3eVt2qnHBCNnjY4XuaIFWz3BHwC01O?=
 =?us-ascii?Q?htV7FUmXD3x8BuPslnn+HHfkYpyNl7unlZKf/Jam2vEzFhKtCvweYsxoPjNr?=
 =?us-ascii?Q?jhMvhzuGaCyF0FaAXNWtJdXOO6a51ppSiqyNN8X076qF1uxm1jAtW4IZFEMl?=
 =?us-ascii?Q?DaMz6VJjcMl7Rn8vQuBw1MvLecW+kninUBU42RzhVO/CjSSW4mb1Ec9VLWM3?=
 =?us-ascii?Q?z7GhRh3BPYIdG8ZksuyJl5pECUJJdoaImSt0n3i0kKIF67Pm6wC9V/YbSIlX?=
 =?us-ascii?Q?RjP9CjPUAD//Loh/1mwVPpHuLP9fzqFl3zoGADt3Kkc9A/0BxRsSWXJcfCna?=
 =?us-ascii?Q?JY5vabYpc4INRgm/2F97neL3gLPc++Tgvwfj3m4JRZsc4E/0PVoOLfW8Bp5i?=
 =?us-ascii?Q?kl2ZJYc/1TzBE0lURT3k/HaGv4YzKnXDA7TQ724bYkS7NNFcQeKKvotdgcNW?=
 =?us-ascii?Q?0FlCzBeze7I+lXC2qccEYpH0V/NSMOEZc3YijnBAJAmtQIel7nJkbabeGPYN?=
 =?us-ascii?Q?x6JyTQtqgmHsCQ9DsLeyGJpK7vh4s1CZMrHoZasMg6b5FZl1xedFjJqKmonE?=
 =?us-ascii?Q?OGaJ9qsAqRqXGdJaBj/4pVfUaFiQj7OucAXAHIiZoKu4uihqtwzfWxT83wjg?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ffa599-688b-4a84-b59d-08dbf76a0cb9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 21:18:25.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcluFKQBhROcG0R8fSDh0PwcOESfHCYAjSWfrHXsyf9S5D/WflZqttANoBmCUlx+zQqbzeJPd3xjDYBvIRfLCvyGXhSOcaPaPoemOIRsNuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> Robert Richter wrote:
[..]
> > -	cdat_table = cdat_buf + sizeof(__le32);
> > -	if (cdat_checksum(cdat_table, cdat_length))
> > +	if (cdat_checksum(doe->table, length))
> >  		goto err;
> >  
> > -	port->cdat.table = cdat_table;
> > -	port->cdat.length = cdat_length;
> > -	return;
> > +	port->cdat.table = doe->table;
> 
> As an aside: the type of port->cdat may need to change at some point too.

I did not understand this comment relative to what you expect to see in
the next posting, but maybe Robert will when he respins this patch.
