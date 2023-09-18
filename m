Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072187A4E74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjIRQSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjIRQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:18:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168967680
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053519; x=1726589519;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u8H3BEX+fDwKo5bAU9ZeISpcs+3ZQSsgPQMGtp6LmZA=;
  b=nj1j0foj0DwezO3yVOFFpfG7u+Jef4MGIjX91RQyl+Z/wFthUULANvi+
   GxaVu1/UWGT7kA7YPcC0Rdn6s08Z6C100/uT9quMJra2rCPeRWsfGREBr
   5ktD5l8ae+to1jP8h9IoZwBgwqSjfxlDGt78MK0ElKp/Rs/63W974Diei
   bS9XwPk0hNCEYXtVTZyQAmDkc5FJnJXwNUukGI5cFKGhRf7rfTsopnb0A
   BecHfNEFidfHbffEd/u3XLu61dyjLGswGMGks7G5MvxEocd/7LUt+smS1
   Wi3BbLiWJi79cw57mqpANwKan3ePdR4CIC0DqoJHvNeclGs6z7lp/ynU/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="443777334"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="443777334"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:06:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="861118772"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861118772"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 09:06:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 09:06:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 09:06:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 09:06:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiQ0Odg2drOwYuUVvnNDyteRlqo579vcLdh7CKW7d2eSnM/VxSwhtT7jCrQvpGfNPUnRd5HUzATRuqxEPoEMg7e31eAWcy0je9TQaB8j3GuclQTF3ZNSJZmsProOm/SjYM/G4mMna30EAQjvXHZDRiFMiiP3FAYyk+a9T+4AgQNuk6h9zpgFsxqBl2gF5VMDziOioe0QpIBafVYo9L8+oYLzonoNAmNq+v2VaxD+FssYhjhtkrZao9yhkse4kMi7Cla98Z9lmwk/Wrgkbl5Xkc9uAupPEoZHiWBRuXJFmFrTa34s1ItZx38c3W5ClqOFgrdtPtLF4qwZYnwwk51qEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+afMKyPfwZK3BLHbs+NYcvxCOemlkCO4lf0su4THl00=;
 b=Q7HxxPB03C8Ot2y80q5XeO4zuwiEZMFDE7u1hpvox5sJ6JtazYWpeIg1tHFr+oXg0U7yvIW9sVsBrt8S63aFD1BV+cz43hy/wo4R2tWGyaWWY0B/zX802oOIaQS/Q8L9hV/w0ltMAnN0qzTA11SgqW2OUzb3x3yQMmYCI0ScM2aLapP51+VAHLHkNEeLEzV6VI+1K2ULBPl+Xdya4n7vqKNFMVSmSRhqZpsHWoHCffK9bG8Px85GsmE6cmqzkOe2sto7eU/k6GcWZQXaw/oaLyByxTXVnNzpNXdAU0waxrTwcHVNu+4jktHDyuVWv1aWyTgYIqVyL4+8tSrq6qbY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by SJ0PR11MB6670.namprd11.prod.outlook.com (2603:10b6:a03:44a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 16:06:48 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 16:06:48 +0000
Date:   Mon, 18 Sep 2023 12:06:42 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Tomas Winkler" <tomas.winkler@intel.com>,
        <intel-xe@lists.freedesktop.org>
Subject: Re: [Intel-xe] [PATCH v2 0/4] drm/xe/gsc: add initial gsc support
Message-ID: <ZQh1klXZSf9/qqf5@intel.com>
References: <20230914080138.4178295-1-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914080138.4178295-1-alexander.usyskin@intel.com>
X-ClientProxiedBy: BYAPR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::21) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|SJ0PR11MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa8e739-dd84-40e4-e3ce-08dbb861433a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNKMJAmYPY6D38KTP625Fa8OAPIPmlQg+86YLbR9fBn20xZYLFj8PLZu2kLm/rYXeyPrDiXdwPQzuBF3ONSKgeuajEvz3i0vQAy6/PQlyL60L7OFq3ftPYjWSSAP5iqnN0ehAhfK3mpKP4237mLofytArxDekLYW3CXq/f+5zNAXYaJpxSQusU6489VlB9ekTQnHCMkFXUFmLzjhp8UgbNIYxdFECgaGcaycUGYwKxPOgbeLUMPtKUkUAjcXMDQ8mFSOE7CRkdkuXHiGdCTyc9mnsbLgkY2SV+gEeoLmkC+8RO3CQUj3qB1SiOKUcK8jt/tLv6C/oYXPJRElJy6ioAlQm1t16IpmqsNkj7HZ3ZyNjiIqpo+NU/fF0woo/KLADr/maw5mt8nenOire9PhvgEChX5iZ2pQ3QqrKQ94mKMImbPo4yJ2rKprfwd1z/yPVN289WIsnHLKjcaGHIFf7KvrhxtQ6FSaj1ErypZ++U+nv2WIpK0kwg8qVO+9L6ljxSx7ZtpAUFX5OTKlZmn/Fz9K/b1GwyEY8F735MPm6gz46nl/EEAS4R4JCQ3T1MSq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(5660300002)(26005)(8936002)(6862004)(4326008)(8676002)(2616005)(2906002)(86362001)(82960400001)(38100700002)(36756003)(83380400001)(44832011)(66476007)(66946007)(6486002)(6506007)(54906003)(66556008)(6666004)(478600001)(37006003)(6512007)(41300700001)(6636002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KxkAM65r+CULH46aTVyBHzGVNn11BuuCbdf3ASgimGyZUegzeHmLYPYc8ATg?=
 =?us-ascii?Q?nyObdPP4W3dqSY01T7gtObR3alNU1bpSR1M7k57A1ZGqRSU4zFqlDJ+4f0Io?=
 =?us-ascii?Q?KQVCxMz5TH6L4GHQY5n9oTThT2+1Bbnv/lfJuAliRWpVrTrGgR2CMKRuYmjb?=
 =?us-ascii?Q?eb6THp6wEyVUOM1Er8hiKFzLjkzQWgmUlDwn+ecYL0IkqXlbn3NWXPATR5zb?=
 =?us-ascii?Q?gVqNIQaeF3o6Alt5Uq7T39KuOgh7JlqFJLa9Kwr2IfwiAov3d3vpbHRJ/bUT?=
 =?us-ascii?Q?RibbxfTISZoklY9gJyJykHUm5HkKQGVKmQUA+eMbOAyy1XcPg9hr0C0bBtmY?=
 =?us-ascii?Q?moDNFTDRU6LS8u8yKdn8LM+QnrsivfarCkeluOjJYi4k2Qv5unJK8JJbLoi1?=
 =?us-ascii?Q?mWnT9JUMKuQk1/7S7IEBOT4Db20j+4CQn0hh1pG+eL0xnM37pExTbpwQti9H?=
 =?us-ascii?Q?r0HS5wbf98nmXhGRd4oeyxG8hMbDjwXIOpJS9JYXV52zKmSEa0L1FaqUPjn4?=
 =?us-ascii?Q?C/X10YOsnhKPfjnToLjKsq9MfA4IL4Ni+6ZIlhgrY+H6v8ZDZTMUiCTwIW/T?=
 =?us-ascii?Q?P2W5ngx9qGREGkK6dSQ/XtHZaXozNtQ4w6Ynmpw7dqV/2lxlKtRxJzhjPlhm?=
 =?us-ascii?Q?W1t9SZ/sNztclwqOnrCfvHxmuGDf/dWaacobYCNk8pTk3c9zQ+zg3igs50+J?=
 =?us-ascii?Q?1jqYYLOhb5KcwzMCRK3W6llqsmVeDTDU3fzuJG1oks+4OO65025iOSNhWaye?=
 =?us-ascii?Q?zyEXPkTIEc7GCmWqa/HXx2658HFkYu4fEIFBOnGoYLAssubXR9BnFc5uMlGO?=
 =?us-ascii?Q?TAR1tf46dfRcgznR+Nxv6gqHxlNV4XJi9NPGsanWFKUULR0tvFqnxTinfWU9?=
 =?us-ascii?Q?/8QPdO/ekCTAQ3Cy+2L9jhVqZCKbG8JgZ/dmwX6/zfId+veLdF22wHeR4tGL?=
 =?us-ascii?Q?AmLHtTxkhlw56wYR4TpVwBlHHq6DKGD/swsSeGg46K/12J2gnnLfdeidem3x?=
 =?us-ascii?Q?09XrSa/2YDJaHtWBc3KYmc5c73aHH5ZGijGMqL6+Q9GDvy2ngozk7ffNlRSA?=
 =?us-ascii?Q?oGVcNf4GLQ+agaar5zKnYUGtFt136suLd54lt9gEwZOp3MgoG/4pRLTgmcTw?=
 =?us-ascii?Q?LJ4e8mYmfgvRRrZNM+30UGFIKax5k4+5E25lg+6nr8DgkKckdRLIPXgf97ok?=
 =?us-ascii?Q?zZPfdWauZ/BMx4cA9QR9tAYPAzSrQJ6/pF2EQcyPSjQNXPQdwjG0o/Nhmadr?=
 =?us-ascii?Q?ElaM1U6T/FrcGZuz/9IqUJaKUowZ/+MdN5/Kqm7bYekGjiDlqa1My8DJtzfj?=
 =?us-ascii?Q?Gcfg+f6NokKEJ7d9wTk9Z2B5Wpp9mrIh/xgcwJZPZhhHv1xjp539jP2sXvGQ?=
 =?us-ascii?Q?EJallelP+AC4WRt8B/64Fc+/SfKxOQrSxnuc9GDMDIZIV6779X6K6y1DZqXa?=
 =?us-ascii?Q?rrhLB6fGt0UWf2Hxo0eGwIIKhYv9UHXH4Ibf85mylJ8WhV/h/J8bnd4DP6Rw?=
 =?us-ascii?Q?XlBL1HGvAg/GSU7B2fcoPP6pEElGwIVmD8wjGQ0mEeg7LKqr3lK5wQJ4qQxA?=
 =?us-ascii?Q?DzfgDBoeNjD4hhBEjqBbvOnSNxMTtg3AmEyLHMMi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa8e739-dd84-40e4-e3ce-08dbb861433a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:06:48.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlfLwO78hDpOI7WzlJ+YL9VDNffuil+zhTuE5oIgvOEW5MMVNkmSbQPTe2qegJPjZr1JW/yO+lLkUjboRd1fIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6670
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

On Thu, Sep 14, 2023 at 11:01:34AM +0300, Alexander Usyskin wrote:
> Add initial GSC support for DG1 and DG2.
> Create mei-gscfi auxiliary device and add
> support for device created by Xe to the mei-gsc driver.

why are we not adding the GSC already? because dependency on the GSC
engine or something like that?

> 
> This series intended to be merged intto Xe tree,
> the only patch that touches char-misc is addition
> of id and alias in mei-gsc.
> 
> V2: Added heci_ to struct and APIs
>     heci_gsc moved under xe_device as GSC is not under GT
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> Vitaly Lubart (4):
>   drm/xe/gsc: add HECI2 register offsets
>   drm/xe/gsc: add has_heci_gscfi indication to device
>   drm/xe/gsc: add gsc device support
>   mei: gsc: add support for auxiliary device created by Xe driver
> 
>  drivers/gpu/drm/xe/Kconfig           |   1 +
>  drivers/gpu/drm/xe/Makefile          |   1 +
>  drivers/gpu/drm/xe/regs/xe_regs.h    |   4 +
>  drivers/gpu/drm/xe/xe_device.c       |   4 +
>  drivers/gpu/drm/xe/xe_device_types.h |   7 +
>  drivers/gpu/drm/xe/xe_heci_gsc.c     | 205 +++++++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_heci_gsc.h     |  35 +++++
>  drivers/gpu/drm/xe/xe_irq.c          |  14 +-
>  drivers/gpu/drm/xe/xe_pci.c          |   9 +-
>  drivers/misc/mei/gsc-me.c            |   5 +
>  10 files changed, 281 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.c
>  create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.h
> 
> -- 
> 2.34.1
> 
