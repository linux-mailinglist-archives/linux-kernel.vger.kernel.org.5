Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F777CA1E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjJPIms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJPImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:42:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E173E6;
        Mon, 16 Oct 2023 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697445761; x=1728981761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sfoji+shNV+1VzWXwfHMny7DtC503Lw/wBZxnTgYQMU=;
  b=WlxmY0Zo3mqEWHryXISLbqGMPuPFcRmP/r1MTs/z0zxXeb6jj089s0t0
   CxcV68Kh00PovxpP0XZAGEcKc2dU/c9K1yuoNElORmKAkC2dTjPV12Om6
   FWZZlbisNEnOmIaFhdnHbXsWBQIut3V9MjkZ/DbZegGMa6Y2xqSRno9KX
   EdTbLDv3vJGkb0YIBRGneuIvkc1ieD1wPRkLMBMiADNwK2YJbNDHU9rAk
   6P38K/UDMo2kO0e2G75oyXixOOZrytn76NvBQ8AhL33OlWAv2i85tYh7T
   850UC+Uatbzpbk2ze4MMHOooH2mXUY71DRdgZYl9k7eALoE4Y7ycYPwBZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737124"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="365737124"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:42:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749221305"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="749221305"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 01:42:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 01:42:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 01:42:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 01:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So8TdKU9BaBCv9kwQ9QUzPQqYQMHqHLgdZIQVTCyzmfBdWyn85yjgZw5/xE0dfGgKFyV8Jt2B4YhaWYaochaziZITkLuzfcKP510M/ly6JLxYJvsxXiJdH47763xXsFU9ThphUZ/FeslaJA0h7CU8bfUXPT6YUn4fQtJ7bc8ttw+no1Gq8WSZA7E+CKTjr/AR8gakmcZdwWwGxlUbNXfb2XDegzxRubIDjtlk9Qm63rxXRTDZtttY4+XXxi2yPUeKAhqTb86/+0xYnc3bgkPw6EaFeoHTQt20fFrKcbhZ3T9e4exjcKrPZ0XNIZ5Hr5IVd7MKqdvmhow+32JZC1XuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MQlTVBZ+HYqi4bAYUeCTRBLz9LrqP6PBjwZiQvIO7A=;
 b=klGr1BASzAFkvmzlSx984gl/7rLu352DVPyjJ4CMB0e7/mNLwld2jZ9DM1QM2UwvDq3qKT6iZNVJr4UBVYg/j9h2lNsi0JtdlWPP6gfF984RpWBoqCjYE6ISFjHX6UyfVX2kk89p84fJBdiL9K8OCovmSGhQF0Ui7uNgWd0emPeBFuCyYL/OxQcfcZzLev7c23++7QqD8t9gu/fBJWOr+JN4rY92aM6dc+AhPHYi+4Yl96GfczRBvwKL98UhD5SaZe7JECQ08+hcVDLR1jDljAeqwBlhzR7TlmXfMmfPsTdLjpiCFESQ/pH5go4jcvYaa/GHz4/R5DxG2bgA/4TYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SJ0PR11MB5582.namprd11.prod.outlook.com (2603:10b6:a03:3aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 08:42:37 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 08:42:37 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH v1 net-next 5/7] igb: replace deprecated
 strncpy with strscpy
Thread-Topic: [Intel-wired-lan] [PATCH v1 net-next 5/7] igb: replace
 deprecated strncpy with strscpy
Thread-Index: AQHZ/T+bPCFv583f20G7YZ7XpIuXg7BMHmuQ
Date:   Mon, 16 Oct 2023 08:42:36 +0000
Message-ID: <BL0PR11MB31226EB326F7170325155973BDD7A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
 <20231010-netdev-replace-strncpy-resend-as-series-v1-5-caf9f0f2f021@google.com>
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-5-caf9f0f2f021@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SJ0PR11MB5582:EE_
x-ms-office365-filtering-correlation-id: 4298f313-bbd0-40d4-290f-08dbce23d967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1JCkWujbxA84ZYl6zTiNFnMm91Ez9eGMkTW9IB0ZTPFJeP9clJW5WZvX/NCaRWNK+H2s03omqCxbNNWVFvzFWA53CTXnuJLFJXSBGhIXQfS2PCo6s09F9L1P3UlLJI+fGGwfc/9rNEl5Rmob5dX0idRoEkORhJB25iBG/2Z+hTlFPf3AWxkXurOS8ugEeWRF8FG8Z9ik0pUWzao6tvj4fvjfb9lmhLMz/g6H1X6NeV9hb1XGZVM1e3XNnCoK/GFHYyJopHkrMrITW9Zeg1eEDJSKmE2zNxa7lgTmKCEPleAjBGmfCyCKSrXGXcoTklPpHqEDFsDKX7P8J+T6Mvs6dOKgsRRK6U3O/gGmr0N5mZ94HVphyV2lA4sdrPR3JZxXOjV0jgK27vfB0BtVfh5BNOTnY1afgtPfZwBrq9T6M6rIeKiSt3KqRw2VwYRSKLmDX7JFRkZghy4/WGz1UwkP8aVVJ7xhqP3V5570xwOcm6e85mmfKb5MzeK3ez+CPx10yuR4f+PuI6gxmv5LRx0ndYrc5KO6/8UJea+j16ci01RkH2Nzhx4qpLTbuc//M2axt+5PeZ4lnVCa9rjjVL0QLi6aLoyVwprOoN6m0O3VX7Lj8+/1KhHrCyfLzRoG3p7ItzGlkVRoy3z99LKowsg7zD+3PXS0qDpApQV9EYURE6o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(7696005)(6506007)(55016003)(53546011)(5660300002)(71200400001)(52536014)(2906002)(26005)(83380400001)(33656002)(38070700005)(38100700002)(82960400001)(122000001)(86362001)(9686003)(478600001)(966005)(41300700001)(316002)(110136005)(66556008)(66446008)(64756008)(54906003)(66476007)(66946007)(76116006)(4326008)(8676002)(8936002)(156123004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RLSPLCu/eH8ePT6PbcHI2CjkmKvM7quRxIiycbUgZCoGQIsiGGEFl3NAMQ6J?=
 =?us-ascii?Q?Lpf/QDS8TRYzJt5SHR9Ag6HJ84XqwnaAp8MhY0h5IMX/NpZqe30EI2/xJHDO?=
 =?us-ascii?Q?Pz3wUco8/+n2qd/lGXh0/qbfIZE59A8qjNOyj6BgbyR3xm4MlU66HJNJi/gf?=
 =?us-ascii?Q?atj1Q/+i5ck0oQPMOCfEAd7DSnM2pwBB9S6sG1CjRDWSV6m7NQyt6qGB2BYq?=
 =?us-ascii?Q?1T/vNCLHAx02j5bzE8xr6AXhbFb5AscaJ5FL2mNY+3LG2s592JL4/cTlVaVu?=
 =?us-ascii?Q?wq1snMdYxL0ECdXDuxGSsGzj/LBrpsnT6YGSqddXW+y4R5hboos9QBLLc9HR?=
 =?us-ascii?Q?9NhTKqiDelCHYGYY4ZbUqFA1ttSAu0y3sm4ZIkTOKH0xx4CCjyfsuPEzTl5g?=
 =?us-ascii?Q?gibHNV9GxeyEPYxQdlrdM05npPIfJPEtaxqlfZMHmJR2PeobPYLjsrlRc52B?=
 =?us-ascii?Q?WMrzOriwg3cLf75p3EdsoJHvoYBqwRjpsevwCknxP7w7xPvm0emNjXOMOm9B?=
 =?us-ascii?Q?xXhbNbHrXe7Olc1LpjmyACXgSW2eM5r/CpkxhQm9w8up+DSydWEx5koxVjUm?=
 =?us-ascii?Q?32yFTZXj0dDSUGJ2ZF9jpaksFEdQ5Z5LpiFRb23iP5CEckZPYXTw9Q1IGooo?=
 =?us-ascii?Q?f/qAXthLXMMk1ztBBbq/HWluCdl3QTAaqTY2/coaC4d1qvrpVvJ8yr68tc+T?=
 =?us-ascii?Q?6QGqvnXUj8t+WrLaM+5RlbLCnxBv/vQQGB/owG3VvzsUdxH+CpyPK0xieXMx?=
 =?us-ascii?Q?idD4qHZcmY0igcPrkctmNXwfwNismpNYqCYXjwdKmsdLR+1cK7HKIqfCnhbS?=
 =?us-ascii?Q?PPtUEPfP3lNKDeEq0dBWUUgr6D1oUXoau2otFfHQGyNUi+7bbJ1dvc+IAhnb?=
 =?us-ascii?Q?K35QdMevRUd0OwVjoYxZAm8hT5d+3597LQSg+LTQ41lZWlo1I/RvcnYIhPVX?=
 =?us-ascii?Q?xiPRNF80jGzFrqrAsoZCqB+eRvm4CQ+cZSdLHXF8fjXRfpxJwVp4OlBRzJ5b?=
 =?us-ascii?Q?wo9qvbr5BuMdn6Ifq4vdKyhMkI83B6vtLrLHEgGHnZcKnZrFf+tA+Bbsa2EU?=
 =?us-ascii?Q?K+hxH9OI6bWkeQir7pVK7xeH2XKPscKn0btTP1/9Y5OpFezEl2WCki4/S4i2?=
 =?us-ascii?Q?xU2BogNKYAr5EUCg6rl3xMNTePrgr3LBuKJyTQSydjED8ZzrSWkT7xP7hRK+?=
 =?us-ascii?Q?4ZSCbxNj4OQJieD8d1x9OlokZS6iAAzZIKtwLh7v3v98fD3HZ9IixupSgldh?=
 =?us-ascii?Q?PQ57I4fXReex4jLGhYmLNVhXvk3N9U0q41C/kOjfeEcJdVM0ZlCIfZqRO5oP?=
 =?us-ascii?Q?5vspqe40FX+V3MoKaTgH7U5eazPsjH/5LEJJGq02HGgJoKcnyjMfVLIyEGiX?=
 =?us-ascii?Q?EhZbqOCezEgxcbYzS5YLmpwDvddsuYDOo1z1+BWkeiXwBrfp6EGfYdiSzhDV?=
 =?us-ascii?Q?iq2UJc01DuZ2/9LYdMfZ7X13au6KbJFE7URysvghg/fs1B4ucDyDkeZmuoyG?=
 =?us-ascii?Q?MwXPJI/KQqHnVD18e6nxy/yBgWzcPrOajxU0hu2oq8jEGwqD9Ahc8qusAl2R?=
 =?us-ascii?Q?/iClTo3dDh6Zp7TqNg2E93BvBNwLPqu8DDvMuixs0D/kjLMQjUneACTK6rVk?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4298f313-bbd0-40d4-290f-08dbce23d967
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 08:42:36.9161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /g3f/67YF9jdjVotD7Aj72KnRL9PLAE8WMNpfjP1UytDObPBKfSIrkoBAteNvWqYymytqu2nwIoXItWkRa+6D7EFqKaiuxg10vktK3yLvZVoqC5GPxHjg0/vfelvvasy
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
> Subject: [Intel-wired-lan] [PATCH v1 net-next 5/7] igb: replace deprecate=
d strncpy with strscpy
>
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We see that netdev->name is expected to be NUL-terminated based on its
> usage with format strings:
> |       sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
> |               q_vector->rx.ring->queue_index);
>
> Furthermore, NUL-padding is not required as netdev is already
> zero-allocated:
> |       netdev =3D alloc_etherdev_mq(sizeof(struct igb_adapter),
> |                                  IGB_MAX_TX_QUEUES);
> ...
> alloc_etherdev_mq() -> alloc_etherdev_mqs() -> alloc_netdev_mqs() ...
> |       p =3D kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFA=
IL);
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
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
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

