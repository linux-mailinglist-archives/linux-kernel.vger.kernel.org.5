Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1BA7DCB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjJaLP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343734AbjJaK0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:26:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7773DE;
        Tue, 31 Oct 2023 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698747995; x=1730283995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eJKe/U0XGkiuAqREVsEDuZezL9zQlbEQtg1cXFO5yTM=;
  b=XBeAob+tsyS9CoepEFeIAKYjOCn84U5Szx5z2k3W45z6/5JIOoDkWKaf
   fDMyvkp5zeFXuTvjFG+RyKH19epelhiwXxMfcW8YzkVjQgioAEG0dMP1L
   TDBlp6BPVwd7ke2138VdYpbaxdJKFcSQu0fbLpzIF2RIlo13d+7CpBGN6
   6Nd+eLrKNXEeb8rPnGC3Yk/7L12wdvScbtmxydUB1q44SrYyuAAQtRF6P
   AHPvp/QUJ5XC5ChJ3S5FPVRTYr5Su9eDA89sGfdIBql5W8RRBZikL2POa
   AvA2Bu13dkuo3kRAS2muwolC10DAwomMFwXljMcczXARUoizSwx71uP0y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="388080856"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="388080856"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 03:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1806021"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 03:26:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 03:26:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 03:26:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 03:26:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPvHmdOHPqStqoyNiUzmScTfNrgsR4VzRAV9ikJTrKKat7T8t6TuCl+ECjWC7pvNbH9DIlN7apBVbBg4riUCIltB/nJCELorQJHi+BlPSdPkq9sFxEsDKP4P3DnycNgXJKV5j3T+GQsdyjGyFVN9tPOplORC4ZoIRzCUoBa6WYJzerxCmyIlrbedVQDidW8j3QW0bbpr5hlK28qv1sX0FdDcCT/sFZIxYsLIRj/7nOpa7n8xt7M+YWjU6C+o5+CXaPPpTxMJITZLwh+KtdnIxOPEhDkuIgXsLYlDXoIsWGZ22V0j+l5IS8DpUBLY5XkbRtJX3QlqTnT3YS+Sfqd9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGvR41TzD052JFUXgc1gLvEtzbmgLGilogaRc5VlZDw=;
 b=Ngi8ezolpSI/zFCEjVzkRJBhhAguiEOgllvEMJDvDrrGiJlnW8gQy8yWZzYDvCJA8pAltoWAzC5ocrTQahWUAzZz8nNZ+IZD2m/GLukePLDFqCHL0ItCNuN5n15iQpxzAudytFYAcSj7Yb0mPorIfcPbjZmZcCmN4LBnI7joDtM62Nv6/gXx2ntZpQZ6NWFDEfenPlW+ia1Rhp5+i8vocQ26WTMMO591ig1joVaIN5SBiVT7u7zj2x17X6F6R0Z1pimMItyscflQs107fNqxdt2xDb2mVf5YIc1AUNPLPAIA/y1dXZc4w0fpc3Mi+0hTiuHm+Kw989KHOQ6vCIRtig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 31 Oct
 2023 10:26:32 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097%6]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 10:26:32 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Eric Dumazet <edumazet@google.com>,
        "dacampbe@redhat.com" <dacampbe@redhat.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 4/6] i40e: Use DECLARE_BITMAP
 for flags field in i40e_hw
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 4/6] i40e: Use DECLARE_BITMAP
 for flags field in i40e_hw
Thread-Index: AQHaA40EBDtrBw1XrkuiBkFRa1RunbBjwcuA
Date:   Tue, 31 Oct 2023 10:26:31 +0000
Message-ID: <BL0PR11MB3122EDD2B35B53606412BE52BDA0A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231020193746.2274379-1-ivecera@redhat.com>
 <20231020193746.2274379-4-ivecera@redhat.com>
In-Reply-To: <20231020193746.2274379-4-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|PH7PR11MB7964:EE_
x-ms-office365-filtering-correlation-id: b09de26c-8d85-446c-5eef-08dbd9fbda01
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vh7/XxN2ZTTC3nAvwLtrydIpHKHY/z9vFLe2gLL8LsyaHHc3/7/l+OdDUW5zDpBxE4Hx7AuZm7NdHQsuWc8hfbKjDle5FOm1FPjJX8C2NsCZtJv1vLrwpcrVnL9HlJ34zSuvcgQxzqOJllLfrk05JtGtGaNVHC+cGcA+kgMkgmI15rK3mEDZ21Z+ylp5JfFatNlUEvcavwNGQCk3wPb6kTnMnjVTM2E+3JzemotbW6Q/QOM7Q0fsJF/z1c5+Uq4xt1KuBhCVJTcLeZ+4Tpm0hR8TIp/ycugpXKJUwPwRfmcllDblokKbK14kZo4jATgW354+brAIx/lFNLpUkHQGSUH/DNZZcT1V9MT1JqnWp1yV0DNCQn44yqvJP9lro2R58d9Nvt4Xt4Zc1TeEa3l23tx5gQiJliXFkwjuATwqnzto7SYgqFuSWNSE03nn8p2Apy5lUF5WHDBl4+I2s5+GGHO7IoPzzmRqYHzDffoHKKNt/iNwihC29R4pC6TBY9nh3Z4gtaX911USRdqwPsjBWRcHGD+vS8YYQvHJjJKFR05VWRUGvCYjb9nj51vPTvTcYnryQArJEmGMiXnSBijAtkdy56vWQesVtM0KMeaVQBhRXo4ONGnqDAwWB/uoA+N6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38070700009)(6506007)(53546011)(7696005)(55016003)(9686003)(122000001)(38100700002)(82960400001)(33656002)(478600001)(41300700001)(54906003)(2906002)(26005)(110136005)(71200400001)(316002)(83380400001)(8936002)(86362001)(66556008)(66476007)(52536014)(4326008)(66446008)(66946007)(76116006)(5660300002)(64756008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0B42DGgj3OYtO88yvTP93wspWD/wnx5s0GVF6Dhd2wPIb9piHOMOvsm04xtE?=
 =?us-ascii?Q?3UQr0a364PY1YU02Wciw6wc3p7CuXPIgIohzcCuYXrDJ3mHgGbSViD/yY4Gm?=
 =?us-ascii?Q?wlggkoAvyj/FoIZln0gKCBTxGXLsuZaFiAe8nl81N4F+f65bAXAXyjmzYq4x?=
 =?us-ascii?Q?q6rfV0PMhqXwM0ngzPXEE4h1MfQXpSbH1oB50f8zmhUwps93R2DnWYTvkqHL?=
 =?us-ascii?Q?5ZokHV+aL8UzJVdpUmp9rGEQTHkns4hnX+8Z0vPuYrchNyDK7t+ZFhp4Oe95?=
 =?us-ascii?Q?1rAyMOip3M5RSYB649DsXtk7XfMok2xuTtsxFgPDZVvFAw4Uh/lqtkn4k0UI?=
 =?us-ascii?Q?3WHQ3rk6qKbxXSKCgsGP6Xd5oJEL/JLj2Q80MIBqSaNKZxsjRsCb040eIs1O?=
 =?us-ascii?Q?gHb6kATdB2nMzzRwMAj7ozNOL6VX+k0djqsKBjDwUi/z6JDeAB7zXqf9yf2t?=
 =?us-ascii?Q?Jhpxss8UTylegLDheGvf5r/0X72ChA8iVIiYBat82wz7U2qNkUMjk/tuny34?=
 =?us-ascii?Q?iOs4mWyJNI49UnmDAL5OrR643JN+RuEM3KsGzgYgTujVXaREBQ0FG+7xUTwq?=
 =?us-ascii?Q?dy263/yYOyGkHeUQK4eyRQUY9tPBYQrvWKYMoVEE6/Ra2fbHrEjorGbi03b0?=
 =?us-ascii?Q?YuvIPp01g5CN1r//l2WlzVHkfX6A0V/6sHrvNumqkGfy3OdpB5lqblbIUTNy?=
 =?us-ascii?Q?8VGKh150jmX4W9WFh1WxixmF2yCUlr3ALZc5CHl9+Le+XvX4YHa71jpwG8QZ?=
 =?us-ascii?Q?ZRil3G5kifV7EU40pRkI8a+shluJ00rW5f4vpP0rdBAW+jiBshAiJAAb5yYx?=
 =?us-ascii?Q?5LvK/6ijTJkFyKsFaF9r3Xx+0IJAKfZcggtvsPUuKV7/miz9UykFqMlskND9?=
 =?us-ascii?Q?5y0m3ERV0mDj/Oq1m7f0i+U3P3gOaeNIpOZrj9QSMuD+TZ4EPCboVyfSKQRy?=
 =?us-ascii?Q?Pdt7erxhPcxTLdIbb4sVtDA70QeZaQdtehZ9nfp7WjcSHhiS8xDTGC23xD+H?=
 =?us-ascii?Q?YPvfKUAooSULdrksx9PlwWRA7LF4J+ivABqyoRcrY8l2qMMbAHYgYQ0TmB7i?=
 =?us-ascii?Q?zvgbj1ny0DIaoHps3UbaAmag7bTUgbNgLQP4u4SGLM7RZ0rjWWJCU7M9cPsO?=
 =?us-ascii?Q?rcFIAh9ZX/kWILxnijc8miMFruX925DKhOqDKvn6iFExUh0U6FlHmzjnSO8W?=
 =?us-ascii?Q?XxzqgKZSQed3RN/huXN9FzL87VObR2oIAvf4nJFBar9AfGdsNcZS1pXi/KDX?=
 =?us-ascii?Q?rsk7WdtPRac8xd8uzBDyG624HHTIEsYS/ww48N6sad3eU2FBRoEjDABPS1Eo?=
 =?us-ascii?Q?ba9lSpc7sddxz4gXQKfNABQ/eOoA6AVIxR5tm1Iqw4fu5gB9ujK6R2Pj9TDy?=
 =?us-ascii?Q?B7rv9SLsm+IpjtamUsr5x4T1zNPDQjtF7+N/104zsCcgT6ce256eHCVVGhXw?=
 =?us-ascii?Q?I+ABv2mxSRK49kIUI/Vx/zjkbgNh0iQd65xqrANDvLyqglS+97pBgygn5mrX?=
 =?us-ascii?Q?ZPs2aOyYEpk9BnJKxrwiL63eqZoESB5R+BfxG5qcmMSUrlCqdZHkkxdFVtsh?=
 =?us-ascii?Q?HIg+8SvdGdrntTnsDm+F6xAlx2BdV/nsXHrjoaOBTEnolIeZQINry0Rg+Ez+?=
 =?us-ascii?Q?1g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09de26c-8d85-446c-5eef-08dbd9fbda01
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 10:26:32.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDrIqFPRie8sWhPf9xHPC+BtqGC51N0x8ENWIkZ84cXvrP6UzOPFHyx85H4uFj54sl3H7gY5ft8n3kT/CGcZDHhE/8nyROKJaor9YmthKvvxFwWdMaXl/mswNkdgf9yI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Saturday, October 21, 2023 1:08 AM
> To: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>; dacampbe@redhat.com; Brandeburg, =
Jesse <jesse.brandeburg@intel.com>; open list <linux-kernel@vger.kernel.org=
>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; moderated list:INTEL ETH=
ERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; Keller, Jacob E <jacob.e.=
keller@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@re=
dhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next 4/6] i40e: Use DECLARE_BITMAP =
for flags field in i40e_hw
>
> Convert flags field in i40e_hw from u64 to bitmap and its usage
> to use bit access functions and rename the field to 'caps' as
> this field describes capabilities that are set once on init and
> read many times later.
>
> Changes:
> - Convert "hw_ptr->flags & FLAG" to "test_bit(FLAG, ...)"
> - Convert "hw_ptr->flags |=3D FLAG" to "set_bit(FLAG, ...)"
> - Convert "hw_ptr->flags &=3D ~FLAG" to "clear_bit(FLAG, ...)"
> - Rename i40e_hw.flags to i40e_hw.caps
> - Rename i40e_set_hw_flags() to i40e_set_hw_caps()
> - Adjust caps names so they are prefixed by I40E_HW_CAP_ and existing
>   _CAPABLE suffixes are stripped
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 38 +++++++++----------
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 20 +++++-----
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  2 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 10 ++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 10 ++---
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 22 ++++++-----
>  7 files changed, 55 insertions(+), 51 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

