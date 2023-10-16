Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D28B7CA21B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjJPIp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPIpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:45:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98680E5;
        Mon, 16 Oct 2023 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697445953; x=1728981953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P95BGPikkKaotLsLbvUwo3peYx7DCy0Vd3VznuC3P5M=;
  b=YN0MYrZPD2p3Mr89ON7LqFzAB0ov39bNRhC/O1hGRg5fLJ0qqEat9CuG
   zbhJZ90ymOZMJjgKpSptVCNIrN3xJnjCpjZf9F5FgeMkDuXqB7+G8LXfU
   Qr+kk+sZHgr75qit0DoHii7AgPYTxIVuU5W54hVtvX1UJHxUJal/o0Mm7
   OueYeUuT64hUyGkRNMAwLlfuIxhfrJnlggS/s1yC5RyVIMi0DDmqRVSp6
   FdYeg0+FitTFGyiAD18AVGPiP8RAMeAAjrQ1YUxuybcLGMuhqe2xHzS2m
   LCZruVDz8jdtA5drMXD86t2B+NR+pYhHkn6nH82BqA0+tAB3ZNCTqEH0Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="471707803"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="471707803"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790727815"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="790727815"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 01:45:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 01:45:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 01:45:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 01:45:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 01:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgqvI0EWyn7MKSZo8PMTgdcuNj3FB6PIRPakA27IfAEPqEKxYAhe7fBU3ZOSN5N35+rdw1/g1kAprAIejJRwi55ZlM9ORBVueeqkg5Zrts3UTgAO43bl0zz674Kb3XOPownoUvPbmmot96GABwHXjtLrRO4JRg4BzsaixehiJCJNtleK7+t7HGKVYCI7qEXLv3/VwShbBsEaEzJQjohQQlWpmrDtnv1M63mQuyFlgIKbNTyuTQmQepv95KyH2vbyq6ubggSOkFZ8OIPbYuDVfJ6rdz7AcLZlBuQTAhCGCwj37RxrIzXXdv1ZWYEvPj2gQWDiiud4b6AqJOrI4BpGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTAeeRVvOzVwx3ZNatbEdAcgFIr1nMfBKevezOCD56c=;
 b=drMzEznEjxEBTssV6bDkAuRJEk6gunSoPWNX5dW3qAGWhgD/dTGL5KEdg6SIZgV0914YgRTgs9wPRlumlvaCuW63AddAW0UP5Voco9dgO1Q+7HDTC/rZNK5ZGCbYOQgC1W0HnvKabjC5ZUg9Fg+f7IP8HidOSa9zRiQ/wFStEJHI9er6hyLxXHxY7nGVJC4+nZS1F+W+9I0rlhEtatYPjUimgLc31gotKILee4R5obWGrl3KNYZy83709IH20724ga5twR6yF9BdD7P65B1JyxJOnB684uGran3XZfPEltzFiAateVLbzUvChDvx/maUmtWDY3mcoUuW8VjqZAEYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SJ0PR11MB5582.namprd11.prod.outlook.com (2603:10b6:a03:3aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 08:45:38 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 08:45:38 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     Justin Stitt <justinstitt@google.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v1 net-next 4/7] i40e: use scnprintf
 over strncpy+strncat
Thread-Topic: [Intel-wired-lan] [PATCH v1 net-next 4/7] i40e: use scnprintf
 over strncpy+strncat
Thread-Index: AQHZ/T+Y8jlt2Vjx7Uex6MSFzmYz4bBMHy7Q
Date:   Mon, 16 Oct 2023 08:45:38 +0000
Message-ID: <BL0PR11MB3122A776FB2F62D5044B1D60BDD7A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
 <20231010-netdev-replace-strncpy-resend-as-series-v1-4-caf9f0f2f021@google.com>
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-4-caf9f0f2f021@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SJ0PR11MB5582:EE_
x-ms-office365-filtering-correlation-id: c7823be9-0f01-4b2b-4add-08dbce24456d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FiCByS0OAsGx72es1EWcz98nksm85kP8hri1T4XAWwUKI6TQIgpO3Gf8ROO3sSFA/crkAihoot7Kz/KRMPNkySl7oRRJrsaHXSWuiDRY2g8Lsq1vq3URY3+FGCWwj+5TWtWcj9GdFqq+FO5vKm1rN9fkFgl7ijEBSoQR3N6l8CKQfPtavQaVQ2QgYPNq1roqEX8gQ8I8ThZNse1JIDVNuH3oDdJAUn2IOtKSV8WWAkdY3A9/qIHH12neIZtaqgde0Je+BcJ0X/xwNDdzJfDOqM3srK85MWYpFAHqzyy0EMUkYUpiuhAg20+E73NLvuYomqpns6GcG5LXt3u0dPokoHhenVTwD9dk39oq3wIut4BkMrCFau3YR7MA/V3TGfHBkGV3Zh6MTHq1hEC/7OS4ZqHYzrNKbt2G9rkpBX8zdERRsBlWhIDu42ft7P/YvvulJUP/uEzFqpUhQTr0a9grzCNDjTcZnfkikzWLy5P7MMpqfvUiZ0V6HtnnB7UK6+ZmSSGH/Sf0U7JgtV0++Dr+KQOLKcZPmS9CrU3MI0xCDTJDG13zVLCE0uZb60QY8ToFHrfAXXuzc5VJ0cA4jfGRH2+Tx4OI8J2PNOL2p7gra6gXK7p1ETevzseOAFiDhxhuxu2bDzhE+fiEJBpzLRbQbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(7696005)(6506007)(55016003)(53546011)(5660300002)(71200400001)(52536014)(2906002)(26005)(83380400001)(33656002)(38070700005)(38100700002)(82960400001)(122000001)(86362001)(9686003)(478600001)(966005)(41300700001)(316002)(110136005)(66556008)(66446008)(64756008)(54906003)(66476007)(66946007)(76116006)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2nFfsDy7LJwWwlx5fLKcImx1HChDyzOEdHySIdb77JnQJpnC4bTfX+g2HlXX?=
 =?us-ascii?Q?FRRY00wdAcghZzXek+N+5Zm4xNPr6dJYLIafPnwiRDVqEV6t9MRtNU23fwh8?=
 =?us-ascii?Q?6YwIfVp4DSFwc9XIhbrTs6fQOVPPh7aNRxOcrTLUh7FRnqT/hgyHD/EFfMXs?=
 =?us-ascii?Q?iVGgrtcrjBzEABZ3ZQvjsTinusuJskXfCQ/dWesuMgDHcbfXGOcujmdrMwcU?=
 =?us-ascii?Q?7YwEEeSv5PWkrH9al9rQJVmgB8+zTDEcfNi1V71pH15KUtD5yfGK7BwXoAG1?=
 =?us-ascii?Q?LxBHq9YjDShV/gud2ggfvbVfIncDjxeJonvIpTc3dT1rxJV5QmZWGzYPqgBl?=
 =?us-ascii?Q?NhB1few70+Eds2xUXRj8P+P/jg8EL+V/j7z4iy0Ne56MvOOyLD6Cfta7vSPQ?=
 =?us-ascii?Q?Y/Gdh7GBOXQgJg0hcQRIIGDWn2HnYvfqkVRmzwJcQA2AI0aNbyTG32/d/+fM?=
 =?us-ascii?Q?LoNcFGJWLxyUEtBRj0YnmA2nI2sIm0YPPg1Q+qvVg5y/tMPt1pGRl1t+jXSU?=
 =?us-ascii?Q?hvi4cQFjfKv9Ztcs9omGnHsJQgN6dvVU/uhEzqMiTz+LV0+ogWRR05UR7KYG?=
 =?us-ascii?Q?qmuV7apxQ7NbebsV4LM69rqOIekg/EZy4S7AqAxs4FZlbygMq+wPEmdk9hxq?=
 =?us-ascii?Q?ekObsCBtRDaeQC+NuHkH+umb+EEIaXrvirH6hZHYkEe0iCg0zYfZBGmxNGRg?=
 =?us-ascii?Q?bYi6VIPuwq/yNVywgr4D532PNRtyPJMPalivXwZAwk0ZbC7VPMIupv8dQGjm?=
 =?us-ascii?Q?jQdpHZyHU0xpNQcBSD4DgC4z0m3VJPGNHmVkKrvyILZQakAAnQ1TVs4YaY87?=
 =?us-ascii?Q?fGBl4LID645UJVHDJ+3DhJxKWwDBmgjM43+I4DyN3xa2esj1JDNafjtQLB5S?=
 =?us-ascii?Q?MMKU/rYZRdFzQY9K4899YX/8sWmA8bNiy2xtBdBdRvh8RFyYMP4FHXtk3eQO?=
 =?us-ascii?Q?p2j6hJuiCl6qW+TWjzcTOEAagPe3+GzccT9UaCiyKE3lZYMSGrK1XWfU2iPE?=
 =?us-ascii?Q?wFVIvfweZwAKZDhdOsmWX3aHH4PkzrzuIeH3SMRm7AKzFqIgUK7l9J1xhh81?=
 =?us-ascii?Q?XnXE73lyevNm+AStF3w//08lSAxNsupRVaYg0ZCWOal07lG67PRPtenadGcM?=
 =?us-ascii?Q?iztegDOz7fpOIIbVEe4vzX9b1RcJ8+qqx0IpAOj2SgrWaJDNf7G6+IC0+scF?=
 =?us-ascii?Q?R5vgugx8aopLrmCCZy5yN8bdVYypB3EfZiSvHCONlN9DU8mZVua/xvbqsSJJ?=
 =?us-ascii?Q?2o2fes/jaSsnh9ss2JZIVtkpwosdNTILbSAdMVc0q09Y8UtB5wLHL9r/kAdk?=
 =?us-ascii?Q?8XpuIh5VOZQyO0TytLjGhsTHFvjSwew5dOX9CfM9TlaP/btixbgr3Bx6lfcW?=
 =?us-ascii?Q?e80m94pP+mjr9wNpZxp6q/SjXltYX9fd1iLq2xp4Fp46FmeVWC+z4erJ9CzE?=
 =?us-ascii?Q?bDCjl4ayFY8EOIQHR/+QYEa3BEP1eixdxkrLK0+31RYJeiz834CkwC10irLi?=
 =?us-ascii?Q?7LzCehcykXjzSJ486q0ADxrmwFTKq6BGVpz9zULxowQjAPCb05vTU0zbPdSK?=
 =?us-ascii?Q?29uivkv0toOFdAgViLorEdaG+TzsiHCbJBtRPoyCUGiLOfpY7pJjL7k7dfkV?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7823be9-0f01-4b2b-4add-08dbce24456d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 08:45:38.1420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5i92Jv7WbVSsT2jg6Q+lsE7xj+7CfzwFhPzNi2Ur05YRtd9LK/4jTvN5NqQ32pYoPTY/32tHVsDH9lo8xTzvc/WJ6X5qR5GsG/2dYToL644mlech92dxjQiy1Js2yroW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5582
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
ustin Stitt
> Sent: Wednesday, October 11, 2023 3:57 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric Duma=
zet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <p=
abeni@redhat.com>
> Cc: netdev@vger.kernel.org; Justin Stitt <justinstitt@google.com>; intel-=
wired-lan@lists.osuosl.org; linux-hardening@vger.kernel.org; linux-kernel@v=
ger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v1 net-next 4/7] i40e: use scnprintf ov=
er strncpy+strncat
>
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> Moreover, `strncat` shouldn't really be used either as per
> fortify-string.h:
>  * Do not use this function. While FORTIFY_SOURCE tries to avoid
>  * read and write overflows, this is only possible when the sizes
>  * of @p and @q are known to the compiler. Prefer building the
>  * string with formatting, via scnprintf() or similar.
>
> Instead, use `scnprintf` with "%s%s" format string. This code is now
> more readable and robust.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

