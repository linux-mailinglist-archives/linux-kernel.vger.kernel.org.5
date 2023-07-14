Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15DE7535F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjGNJAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbjGNJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:00:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54413A98;
        Fri, 14 Jul 2023 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689325184; x=1720861184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UuXzM0tmoaXix+vPyfDHlSKvNdIVB/y3E66XOL1cQDU=;
  b=VQaW/WF3XNYslwpLchvVSaJ4esuGWl5hltnzHiXNl1aD36Bo3GF1LVkC
   Qao/Ool93IlcyEn4EIsrhFqYwd3C16yKMcYWA1PHNV4KzEa/AYTJxUi74
   dnar16uyrszWqEwnvk4VX9NrjPTTkHJ7PxR7fMI3eotkvHxwxDzlXBqvb
   60rhiQmZIuPqxFQJOszeFZ4Lu6OKb9R7qpNZhHxVzb7qrY3FzJ9gqpIGR
   AufJZDwxIdL88zNNLNsQ4D8cHy6v5lTZ3SLp0TPcLVdkTh5E3nB2mdqUO
   IwpKM7WNVZgWP7ztgzoFwzInPL8yvwR1ZNhMPr95+NIUwoUlkGNWixzR9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364301676"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="364301676"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 01:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="672623778"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="672623778"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2023 01:59:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 01:59:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 01:59:42 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 01:59:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5wbgsQn7cwZ9Mqew4WicgZ/eVZ3ES/EJKlSj34JIVFbKixx9IeGLtQ9zOBF5ahuOq3uDM2XXB1uC89JFW4EVQ23NmF49RJfVU1Wn47wlpaNmqbmfcPLcLtRtc6ipVPwGl0sl7pnyNT1ght3RbqNOWYo34ksfJLN0m71fmST1VAjpSgasd6lTZdpFbSn3wwQQ+JYFyx4tLETUfeWNBp9gjXTqrnGbYrLB8nGnnJm8ki7bnJhz60xywBOnmBD5Yib5UpHby926t9alC1a33zZDRHYycl2uyk/zHWbxH/O++QJs1K7zST2VtR1FKMJlSTTTM0cFp1bE+iL33fnZefmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uA4GKyK6sgG7AFWamF27BcIUc9B0GtBP+Or51r4XqYk=;
 b=J2Ae4Wio+/ugBsYzwap+iY24IA4HEu90Naw1ikYSMb1WiAE/+y1GINPc0yPlY1BKD0Vf4V481U6e0KiTi5iMUvnbOz4uQjlXuzjZ7YiPc8U4cfWgy2fRfh6zqKAAaXShIZ7vQ0kzCoFCXN1Clx/6qbX32zHEqlQqgauKAsBSb3IpjOeWJUn/K4UzkNt/tW/Awd5MmlERuet9F+RTDsCiM2D+0qSuBvUVeOMyC8heTJnA6CcsvJhHEhzP9hVyrL4LBaB7F9ofPzFA4j+zTecxQjA8vch7e7BryURH+muNDVmC91HVAEnhr0GIEUz8x2BtoEArRytw+5uO6OPX6Ndqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB3133.namprd11.prod.outlook.com (2603:10b6:805:d2::14)
 by DM4PR11MB6288.namprd11.prod.outlook.com (2603:10b6:8:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:59:40 +0000
Received: from SN6PR11MB3133.namprd11.prod.outlook.com
 ([fe80::19e3:8c1f:7eff:d656]) by SN6PR11MB3133.namprd11.prod.outlook.com
 ([fe80::19e3:8c1f:7eff:d656%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 08:59:39 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     poros <poros@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net v2] ice: Unregister netdev and
 devlink_port only once
Thread-Topic: [Intel-wired-lan] [PATCH net v2] ice: Unregister netdev and
 devlink_port only once
Thread-Index: AQHZop0LbIIMLWJjyEaIjyugXFNgSK+5HOiQ
Date:   Fri, 14 Jul 2023 08:59:38 +0000
Message-ID: <SN6PR11MB31335737BFB272C88106254CBD34A@SN6PR11MB3133.namprd11.prod.outlook.com>
References: <20230619105813.369912-1-poros@redhat.com>
In-Reply-To: <20230619105813.369912-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3133:EE_|DM4PR11MB6288:EE_
x-ms-office365-filtering-correlation-id: 4526f43d-370e-4274-3557-08db8448a797
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pLdBrgBYDYBL9E6PtngetPw/BqSYYuJ+BDKOWRfq3kbt0afq/u4DHPuEpFrVuxF6yfusW7hciizwnbyzARXl/Z8tHf+kHPJPngNpXGuEjHfa1RD1CmNFIAkWPMKiWqBEakmJCtjm+ht/94/03+dSTxBobjynDjO07Lri3j139oymoZEWjGqEMh0/jVhnC/T0f89n1rcZcGnAz0DZyKoF/Mlwi90wmesXgP5pizqDl17geuLwjKJ2IycahqjvuYTegl6W4L0qWFfnyycqNXI5wh3R5Y5mjD3pe8uck5e1UUQ7kDEMNVvidSF0TtJtzeRaSVEZiZ5mDJku2ryVrUsT5297sOmX44KzIxLhP++idQ/7a28PVX+2tWUIe/fWdpO3RVlhqpRFsYAF/WSRUJo7NW2jbQwNGfUMesI5Sx3wjXH/23AF9El0CgpJUiIM85j56MGfsLVq6GU8BKHmnpFtredkV4NhWtyIUwA+JRTypyUU4wyPwZe2BYApWgzMP3Dvb0E9JW2c+2rc8k9SQ+uGajEicORtNJl4/R6ZKAk+QPeAuBGNx5XPzD0AnM6GJFs4hJIG7r9jujYEJzAtRwQ6ypUTI65pMWdM9g3nI/5yBK8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3133.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(478600001)(7696005)(71200400001)(110136005)(54906003)(186003)(53546011)(6506007)(9686003)(966005)(26005)(76116006)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(5660300002)(52536014)(8936002)(8676002)(38100700002)(122000001)(82960400001)(86362001)(33656002)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mLn9lmO8HykCyVY+YLxZyJPpuIx9ClvrZZ3fBFKWDC9kUfdgQWZOpazP3z2g?=
 =?us-ascii?Q?lJ6bsFkK0VC4nvA8qUaMO3IgDbBHktoKzRALajYFmPXphxnlFO0R7e/Nz7u1?=
 =?us-ascii?Q?G9nIpCqXrOnArI+Zbb0+HpYQ/NeD4bT6fuNN0rA5ika4dq8r1RYzyh6eQV/P?=
 =?us-ascii?Q?BDc8gVZEyI6h0XgD3W1xQ9bHllyyiQ5+XxyO7HqwpKOtgHWrcVyv7lroTodV?=
 =?us-ascii?Q?4nNoYPIP/Qc8PElJ3doeWfeoWQg4ml4CzkFB6AxFNlxum8BgVcV7RQPVe9Fq?=
 =?us-ascii?Q?RgJ0a20gU7p0IZVcekd82NnuO5H3N1+9nj/tJfHzxHLYV390vPU+e+zMyBOV?=
 =?us-ascii?Q?17oANIX0RWWq/pmhAqA/H+Mj75wb/8nZUEN056cKa14TnMNxO5Ll4dMN2IZS?=
 =?us-ascii?Q?tj7cbIhrBXUW5og2n73nmXUMLWc29H3eaEXORBNcAWqNP0hM02d1Oix0mP68?=
 =?us-ascii?Q?PTwQdeoJNTPgVfsWVj0Ng/tMX1GoA1jSJACHROH6uaZqjz19BpNYPuD/MTDI?=
 =?us-ascii?Q?ko4+bKCnGwJ9KAthI0a7AwNOkjO5DOVPHAO2f9WgRN4+zw88wQn0dRaqMeNg?=
 =?us-ascii?Q?xRuo8ghTHGJnTIXvJ7qLaY7yhg4jIApvxTBoBBYj5wOpqWEJq4t2CWZ8yW0e?=
 =?us-ascii?Q?mM+wuL83CrJcCzKrg7cWjiN3I/mh/4V8B2Q5kA5hNF8z8V33t/D2gZF9LDbK?=
 =?us-ascii?Q?Px9Gsq3nm9PhHiBh7pxNAaEDqZxG14vMYxX5eruGIxrmL9ajg2P4Zm1Ps6Y9?=
 =?us-ascii?Q?OgimeKMiaHZO68Wlb6c+nqX4AWWjNut+2+otl9Cs0iH8+0U4xGwKfRs1k4ZX?=
 =?us-ascii?Q?pVRcoVjVknmbm8Lcuo5ud3b2A0qtXLqyYJzdoo+poUVJGshn7T8LbkSr69CY?=
 =?us-ascii?Q?Na+fZaOXX1wmaS2vD3DI7uc8C+XA/1w5bTdyXvP3xxVPKf9D+UpXhWQd4B7h?=
 =?us-ascii?Q?9ctPsSJ0X/J6EUKRyWbNKnPq61H2EScvks9uyfQQPGdYPX9DovXo+fGv6b0w?=
 =?us-ascii?Q?NresviOfkYXzZn5EVwqupPJ00PU0YtTUYjt3zG1lOpMVWC89kBDDGFWGmlAl?=
 =?us-ascii?Q?CIYL+WY0DSqpfaSRbzEP+XeVydcLhfBgUmt7u4ssnQ0/UIIwvWvOX+B5/YAJ?=
 =?us-ascii?Q?PFfyK6ZNd9yntSWWOJvjmsTG+DSxZBvdbVcudxJQd8tGRwlA/LP3+FRsavMK?=
 =?us-ascii?Q?0aooNyv/X1yyN+zusqMJOSNOw6gNBVh6TBEYAiiyLUdFch4fBOCjVG/cIn2k?=
 =?us-ascii?Q?B8emaXopgeuha14mdWyZ/cvAHk91BtJqOibwjGxwzhcGRQb6wEpX4/+Zw7GE?=
 =?us-ascii?Q?fwxNG0IEeNqkiqOp7GsbhkPkzbuKpBP776bYiJNUpPwNZJ69SpkZ/uySwFyw?=
 =?us-ascii?Q?I9GQnfsjEOyqoHyw9kDazDgXKT4eB5Yl1oLynTxhg4DktOPG80+66VknQNOm?=
 =?us-ascii?Q?06o7sCqXr3+ItWBoLkhQ9K78Zd34jyt6pjDQSR0GUSmjVI9GqVzXbEglRyqi?=
 =?us-ascii?Q?BoMqwUZIcDskUYPk9yN7rKRVnkzXE3HMVqsEfYmgHLYhe4V0Rct/4gtzwAjt?=
 =?us-ascii?Q?TP2FGWLpqTGYYJStsbn0gY4Dq407buAENVK5FL8GgJUEu3Jb44aU0Va7xoiZ?=
 =?us-ascii?Q?WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3133.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4526f43d-370e-4274-3557-08db8448a797
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 08:59:38.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2Dte9DLMFXW4ovPXYM4SUOAjnJNm13orT6nF77S3IQOpO/n+fWgmUv7BQUPWYjDFmeo/q3a7KCw7uR1R50s9d9+0bqVWqjRME7MBnN46Jb8Tlr1k9zgWBTpxA6uYiWu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6288
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
etr Oros
> Sent: Monday, June 19, 2023 4:28 PM
> To: netdev@vger.kernel.org
> Cc: pmenzel@molgen.mpg.de; intel-wired-lan@lists.osuosl.org; Brandeburg, =
Jesse <jesse.brandeburg@intel.com>; linux-kernel@vger.kernel.org; edumazet@=
google.com; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; kuba@kernel.org=
; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH net v2] ice: Unregister netdev and devl=
ink_port only once
>
> Since commit 6624e780a577fc ("ice: split ice_vsi_setup into smaller
> functions") ice_vsi_release does things twice. There is unregister netdev=
 which is unregistered in ice_deinit_eth also.
>
> It also unregisters the devlink_port twice which is also unregistered in =
ice_deinit_eth(). This double deregistration is hidden because devl_port_un=
register ignores the return value of xa_erase.
>
> [   68.642167] Call Trace:
> [   68.650385]  ice_devlink_destroy_pf_port+0xe/0x20 [ice]
> [   68.655656]  ice_vsi_release+0x445/0x690 [ice]
> [   68.660147]  ice_deinit+0x99/0x280 [ice]
> [   68.664117]  ice_remove+0x1b6/0x5c0 [ice]
>
> [  171.103841] Call Trace:
> [  171.109607]  ice_devlink_destroy_pf_port+0xf/0x20 [ice] [  171.114841]=
  ice_remove+0x158/0x270 [ice] [  171.118854]  pci_device_remove+0x3b/0xc0 =
[  171.122779]  device_release_driver_internal+0xc7/0x170
> [  171.127912]  driver_detach+0x54/0x8c
> [  171.131491]  bus_remove_driver+0x77/0xd1 [  171.135406]  pci_unregiste=
r_driver+0x2d/0xb0 [  171.139670]  ice_module_exit+0xc/0x55f [ice]
>
> Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v2: reword subject
>
> v1: https://lore.kernel.org/netdev/20230619084948.360128-1-poros@redhat.c=
om/
> ---
> drivers/net/ethernet/intel/ice/ice_lib.c | 27 ------------------------
> 1 file changed, 27 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


