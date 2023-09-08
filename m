Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1897992D2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345259AbjIHX0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245401AbjIHX03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:26:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8B018E;
        Fri,  8 Sep 2023 16:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694215585; x=1725751585;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gplC4UL8r/hCpy+suKljMSdpfIIhE4KlcytdcQFqBYw=;
  b=a0zMCsnbA7NSHMKN68i7WFWfcPgMOY/qPoWGOkOI7dcYsE7LQanervby
   bUUvGmi1JXlfud+zZAjqyXKc2Vawv9063TxlG30CloNN/9HSusTtKvTB7
   2wKdJAiaqBFA6qtyuhHVcEA1twf6TYOlmZSMxpgxSK5xuNankoOVWLf9l
   jNeaeMGkfDv/Dd2TAu52ZBWokF5GY8neI49VCqOVW0FlwfUtVC7G1f2n8
   Xo/doWcm9lpWGI13tl0R4C2HoS0BYTtYT5RA2BFKf1bc6PQ/NlOkcc4o2
   RyBGRYlG1m2z3dkwMKAMpVG25Lg8Sd6kXrA6GGPS49cJPKpt/cKz7E5nN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="362821293"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="362821293"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 16:26:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="808175381"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="808175381"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 16:26:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 16:26:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 16:26:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 16:26:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 16:26:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFLaqLHYwcwunb1Jsy9slmarH1o6LoxAfUvszbMBtZTRmD+1aOdTRqh0bkLWUTWMUEFstCf99Z+l9aqT0MtxNMOs7Q6xnVPiJBtxYsnjCTwXj2LbiMf48ZM6NDD2WJgp+SCA6WSXxlXj4/d8fl8uRnEoh7oVdxydaDDUf3yUH3qR0nTyOPplLvYLPXc6T+bI+r8PeUxZ0++jabUu4pj4XPZI0OIyChW8nhn6JYgV0ZeJF6JHoGaaGiaMDyjH0pw2Vf0vKnZePqp33BudgaiiU0XM/dO7Nri3dIXGZNLwBoizWGMyJkDf58n6L0+T8KScWn2C4fVjCCqx8fekJXuGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOxQVB1iqiRRSbp5MHuC9MtaJbO7S6w//GupyK+IDY0=;
 b=NxCcEZnsV4yy1DDNStIg95/beQdXcgvflQNdk8xI9tUGzSMZBGK0yzel6y34qIJkOkakbN3NpOm0c3RkO2cLfo1KqYbWp82niPktMOUljNr/igRQr6/u+h1OcIfNfPcERF4NYAU3PQGiqdZuuCqtuYVcA6+zaGfSLXB+OzSylRbxJik1T1kFqunZcfcFOkkiqg4itxqSSi6xuA++ZehLjMbivJwNXzO44p4eMXVFS1nEJ7dg0GvIqe+QR6FXFmliRm7p0Pt/vIxlD80TIAFOOroPBmj9/XgTZlmtqNS5+wdSelqsu5LuK1VO/5ts4cc8a/kKbztDvYwSk2OgizXFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB8068.namprd11.prod.outlook.com (2603:10b6:806:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 23:26:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 23:26:22 +0000
Date:   Fri, 8 Sep 2023 16:26:18 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Fan Ni <fan.ni@gmx.us>, Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 05/18] cxl/port: Add Dynamic Capacity mode support
 to endpoint decoders
Message-ID: <64fbad9aa5f17_1e8e782945@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-5-f740c47e7916@intel.com>
 <ZPDNFEi1RRGoTWhr@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPDNFEi1RRGoTWhr@debian>
X-ClientProxiedBy: SJ0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f0cd36-6b7d-4053-c279-08dbb0c3032e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBBRctyIJPxaa6D5YZP8cCjjcaOskU+oyDiMTSROyleS+r9HRI7mJ6mqHmI8UvsKW0Oh0FUwoPxok+hYw2Acg8BcpxgFVEFXsf4+DMPC81Qqq04GvA454TS7/tBf5D1ATwfK7CMfz/Lgea5oyQZsvxczf052PNXx/tbX/p6a2KTNWr/HQKfwtAqWbcEPLRtr/vxj/IeTZdhRE2kt5v4Dc0dxL4uanLDXYR/rJZTaD1y+xOkGdMZ7DEOkKH0hwwHKNGJWV6kFEkHLcbDbVqNaYhw8nat+8KpHatHjpI9jRwXwvSevNHNQcEIKu/uFTiXd/1ebh/a4+4mw5dXtkxXlOGeVy+GGn63XQc87H5ocoEeckAP7YvGvMyAYocfmD4hL7ASz06f3Q5QQtjnJok3boD+VFNWoWLdH2cu3KymPjaSHiiBCK0SgHxCAK9dAzyhL/ri+ttmHtlttZwo0rFtLCykiUWETWfC+M+2K9OPNoH+GB5T8LvCgZ2Zz51ZHpC5mWc0yB+oYHqEJny32C7oVaAJwrB26ygXhDRroaLqSnZ0Xz9Nea3+ajJPBIoHirElD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199024)(1800799009)(186009)(5660300002)(44832011)(8936002)(8676002)(6506007)(54906003)(4744005)(316002)(66476007)(41300700001)(66556008)(6486002)(66946007)(4326008)(478600001)(2906002)(6512007)(110136005)(6666004)(9686003)(26005)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YLocispTLp+29DqcjgOUEk/kH+SG3zFhpp0FPbtY2AXyuemC8/Uw7DHSUPHy?=
 =?us-ascii?Q?6hJevd3lyE5NgBlKk6hnO5iMeL64SW5Fz/nYzhq9bT2gwD0tTCaIMn7tu41h?=
 =?us-ascii?Q?m/N1mS/dsOT0DdPc7Z234PYS0BO94MqJajJGbORx50qSAxu7Bh6wJGmAen6O?=
 =?us-ascii?Q?S6bYKf0sqoJgOahuGQxJYXNkGI9IZ7wECDfIkfbEPSUQ6p54BzKRMdGvkZQw?=
 =?us-ascii?Q?GaB50Chrx/F11zEoznXlGpM7wDRaTgbPxs93HDDig1PyiKSsZIeRSubmcVZh?=
 =?us-ascii?Q?nURpX/zociQk/NYSiSfSr29RQXMOt8/Cw5nVSym7BAtxKF+CdJV7YlhaXZpX?=
 =?us-ascii?Q?C7T/SJnkpBvJxRPbWluDrpCakKWeONk8skujoa11ra+UxwwQIJ7+Vq5K1BgV?=
 =?us-ascii?Q?V8UaaZX0nP0iufpS1ZTGMgNrqLThxf0xcSUyEZ7ZzApkawIuuxebHM6uX/vh?=
 =?us-ascii?Q?8MB1D6whpYt1yxBLu+woJiVvmeXiYLwTVToev1NnFVS+oXtgQfHV6OOkLoyl?=
 =?us-ascii?Q?tNtz4BRTP0HMulqo0BoqyDN6OOeBql6lPylnsT0YshZDL4GSJHSEO6C5r54b?=
 =?us-ascii?Q?zP/5XIE2hYjafRV7AIwptSR033D+eK3TG+BltSP8yl/43xMfznzgJDE693bg?=
 =?us-ascii?Q?+plikGmcf83kWF4Sj1IgHG9NMA3fz3yTI7En6Rb0b8fgcFoB37Z6RLSap+ul?=
 =?us-ascii?Q?fJU0v6DOc0CU6QRoUxq9x33RCJm+LXOczoS46qlsjZ3v7m+8/1i7tTPnIH3g?=
 =?us-ascii?Q?puSdGJvADpU4/2FnIqUz8DH62iK7tW84HNyYPvM7qMQLryL2s8xe+SpVw5CP?=
 =?us-ascii?Q?h8uDk2inE3nwkIHxoB2QsXQ9SPaq7cx7cDzajAhoQN+0xQNzLngidqi3BaHX?=
 =?us-ascii?Q?rCQ+4eZVlgyH/0INx/ZEVloSvs2Ms2XQWLrKMeQpS+yDooPmNZu/AdKz1OIP?=
 =?us-ascii?Q?NezCQzHvuhEH+XZBrakU46dWhtJY37X86sjBDrFoFrQ/Ck0qw3p8wHTcoCIe?=
 =?us-ascii?Q?jKR/yk8UokJ6QNXImqu3QsaE/Dtjre8oiGH+HqpmDu2Lx92Rcl4NjRazDo4q?=
 =?us-ascii?Q?iEjA2mgH2qQ/jMAurudXzQL2aW19Xt5O8KnOD0dLqVIzMzrgs4knndMmeYEb?=
 =?us-ascii?Q?1YXFCz1AY6cgbO5ZY43RsTEk2+IqNZpOdOnpyQXCO7Vq7cdt56xS5ABhRlYY?=
 =?us-ascii?Q?agE7yXLhjZZpYYV4RPXde+YsIDYsAC8Bo3143Vr4c+vPYiL47F/uuBfICfok?=
 =?us-ascii?Q?6SVEMGeLcX16Nod2mngWh74YMjQpULXvuxgm5ZiIm3hYIwrRb3u3LmDMnrbg?=
 =?us-ascii?Q?OHSXwoKi5LQmS3p2W22SRdhLDVKCsrvaoOEbWx+RyUQeTm/bA2LjOKSsUftU?=
 =?us-ascii?Q?+ephSqhDd5ddtPEb+vJzzQfP68SDRjEISxK/6zjFsUHI5Lk+qmETSpDK4UDv?=
 =?us-ascii?Q?bCFV07TlDVQxyBXkrUAVCxB2ZQ2KDv0AIv+h3TxSEbMRYaL8ZcmjwHzIpE4O?=
 =?us-ascii?Q?iRzLLa5KMygR4Jz+jjhw5ugBD1e7HLf8tnHQPUvvZ7e+VICyzWPAha5V6B1x?=
 =?us-ascii?Q?waRZ8r23bW4N0hoYTzojHsfzpRg2r/uyGRznZNJy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f0cd36-6b7d-4053-c279-08dbb0c3032e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 23:26:22.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u24eojfMgLbQtuA83fBPlkFVJbMa2XCNuyiksUULE64EAmNc6HYiUrdfiWC18iPkyqIl+wC7K1I1WT2D7EfoXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8068
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

Fan Ni wrote:
> On Mon, Aug 28, 2023 at 10:20:56PM -0700, Ira Weiny wrote:
> > Endpoint decoders used to map Dynamic Capacity must be configured to
> > point to the correct Dynamic Capacity (DC) Region.  The decoder mode
> > currently represents the partition the decoder points to such as ram or
> > pmem.
> >
> > Expand the mode to include DC Regions.
> >
> > Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> 
> I have the same question about how dc_mode_to_region_index is
> implemented and used as Jonathan.

I changed it per Jonathans recommendation.  Was that satisfactory or were
you looking for more information?

> 
> Nice to see the code spit out, it is easier to review now.

Thanks,
Ira
