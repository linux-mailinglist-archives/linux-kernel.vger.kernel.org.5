Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0845D80C072
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjLKEvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKEvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:51:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7460ED;
        Sun, 10 Dec 2023 20:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702270302; x=1733806302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xBteMtVNBM/q5+LqKWEHFZ3k6h1E5wckeAmPNGPiP2w=;
  b=hgMRPBLddbsW+c+vEkATatUfZ+Sl9hSxaDnxvLNBYsVKB+xHdP4KyfrS
   /edfhdFBqjyAoaxpY3Me1mR1ArMlJ1w64UDrpSHCgCIfnjr2qfib+yLgF
   gCOaDfcAxh8YV+xGShApZpvmu9g2AVufh+c9+1KrJzcYcXCjJhad1uEHh
   muXxgs7U5AdaGoJUODUzsZKWL1bL9PGYiv1kKfI9Rjv5ujPlqI8sgRI/h
   Wv+ThP2dKImgzZtTAfAXJW0F3hV8a1jSyt+4pAVVcptOtMuUrIt9tk4sQ
   jOXXsHIGpc5z11q07iN2YcF3S1yxMgDW7jL3US+Kr31fpLERLxu/hqi1a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="7943514"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="7943514"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 20:51:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="843350066"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="843350066"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2023 20:51:41 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 20:51:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 20:51:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 20:51:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jphYwqnt91VORNr3FKFsTp+VZi47OR/WsZ+QsAC2bLXxAC1Q8bHMfO7Ffb7W3P1X2sT6MCuVyZWCHHC0kUq3VwtyssP+ONqQ10lHgNHUc5vw+ytjuQY0fvk09cphTw8zLJEWPiPrZWRDOibIOjAlexBPLFqBqnp/MUoG7n8knRmbzxKcg7P9kpm0S+86/0216d+OQHzgTDUrSzqVr5prjRPJB9/8KV91aeb/O3L6vjS3/C87720rWUnfNcPymCpLrzlZmaN9YPf1Gu6P1g5BUAPb6o3svj6L45AUMbepnTCg1kPzM/L/RHKD4R7eLbkmlxprlDeMFKKArPUZfAytxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyWEbdXWgwoo4CRV6yqiDONRD2/bY8XmVI397mosr5s=;
 b=ECXlyCRts9KkUutLtCEgHUhN4MoqyvZF5iZZpUui3BBU/rf467U55qveBF+pphamr4dXNog3ElzZtv/silYjR7u0pWZmA/u1q502uRFLH+lyp1b1ZR8AfOLrwIpSAnnUk3Es8WCU9sZBAHbT2Mc1B+Rsx/bY/EqU1PuruIxawzEsofWS4eZlF7es9IvpciJGigTWW89IxMncjr+hQ2puzsKUgv3S1yy9doNLfOQwy72X5/ppv7PklPwGpMe0JiZin6IFBklD7aTNGgkX0fFpgZ5NlPOA7NIqbD7qwuqmLAiUmqtcgMzevLc9ZaL8x8djn9P6teXOyKj3hW98PTR/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by CH0PR11MB5690.namprd11.prod.outlook.com (2603:10b6:610:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 04:51:08 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 04:51:08 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix ST code value for
 Clause 45
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix ST code value for
 Clause 45
Thread-Index: AQHaIt+aBkKZwGG+ek+cGB8OLLj3M7CjlFvQ
Date:   Mon, 11 Dec 2023 04:51:08 +0000
Message-ID: <BL0PR11MB312254D5E654EA3C029E910EBD8FA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231129161711.771729-1-ivecera@redhat.com>
In-Reply-To: <20231129161711.771729-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|CH0PR11MB5690:EE_
x-ms-office365-filtering-correlation-id: 4c79293a-9246-4667-3100-08dbfa04ca64
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eaMC7JedQ1CJcdAhwb261sPBLNHinNsF+Zad8y+KVyZGfaPZBU2fLX4cFVEGnOdw7KVw7etdZKv7DviQmJO9MGTJVcNrK+LFUQ6/yAHWMUaWBhb0BNaJ/KPbWwYLvO7BDebYBn2LkcgrXVC8UawRcB6w8k33/F/Ert01KF8jZk3GBWSmzm62NHgU5gsgoS571GBwOpCkEn2+yh0EAs7c8kXFsyhUrAe953P2EFlFpsU7X2qwQrQJCS6YSKAO+yNvgKELAy9MSkMTOfbEkzdiHmy9l878gMX5q4MroHy5tGSMCyYizWxQOFMkpdoKSOZ54Iyqu2rHkX9XZ/vnUwfAKwM5azb5RWFXgRtbJL+ODTzb2OB1CbslNyiv+hh28bHfbfAg79ACMhqTwTs2GIlEEyY98AOHHm9dgEXDeiPd4vpQQwaCWcGw/jcrqeoWyHHg9Ox7y2qbBS11MCbv9swtFyhFr0gBcdWKlBj0/vFMANvJjqqhOBHvPbSlrRycvYKwZ3K21hU5xyZo95CegjIl+G8kYPy4P4YKee2tKuBhGlFMyZ+fX/xtCWdGM8GRG4LIx0Ls8hYZ8hFYC3NDtmHe3eCJm/CPizVJXo2xtecYN+XNxo9eX8nBroM8vvLHwHbz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(4326008)(8676002)(8936002)(52536014)(5660300002)(7696005)(6506007)(53546011)(71200400001)(9686003)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(110136005)(54906003)(316002)(478600001)(41300700001)(38070700009)(2906002)(33656002)(86362001)(82960400001)(122000001)(26005)(55016003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p/uNhdWNRe73Jct8NAlvw08lTqppQKbiROXC7exzOwuCHIsMAhyAW5hn9T2v?=
 =?us-ascii?Q?aqqWozl3HECxWVfiTy4JOo1DPW5IIZn8WOER5c4pZ3s2AsbXa+Meq81IgLup?=
 =?us-ascii?Q?5tE6HoefyqkhdbeGoq3ldTSRulczH2oh1fYtuILcCPaeSzVQysMgiwcUj3nk?=
 =?us-ascii?Q?w/7AcaA+RFaJXoxayoFeTLTP2VAx26rzcydHCjsPIgi5vQtBUZZXACtJ5gk9?=
 =?us-ascii?Q?mSG+9IFJcY/5rdVWiSIGbO4O3cnzH+ZwKNx+UM7IfwCk4nKitr8v7koQZDRg?=
 =?us-ascii?Q?VFwMB1gIGC2KmT8YnC3aXQ5fELSOJSwHhWiQ2NlBbPFko0qsTbD5FJL1WKRb?=
 =?us-ascii?Q?NPojpbq3xo06SlXzgCb+S5lKBFZpXOePIjF/cv4RDB+FBjk3acN6s2V5nEQt?=
 =?us-ascii?Q?XuuKBx+2lf3dEkVEDVQRUKkjmYzXKF1YqMHMV9tHkmNpHYTKEL/Dr0B1Q97m?=
 =?us-ascii?Q?CokOzkiWRgxTz1OMZPQd0wejj1F6+sP527bxt/6EfdzzbscnqMvjNPQZiqTT?=
 =?us-ascii?Q?gf/9+E05INXpCzf1xscYKm4a0nzkEIBvsmaGdKYpiyv7ywdk58UFVMaDuH8C?=
 =?us-ascii?Q?nXFrfqmnIyirT162H6/e1HgeIe51LzumYbrLY800Bmkhk9A0VKJWAfquzjX8?=
 =?us-ascii?Q?Fne4z45nsQ+P1nm0qLE5bSaZZ7SQSX0zzfT/BroOQfO/A+SNs8oR0atxw88p?=
 =?us-ascii?Q?Pm+lS0m4tMDJAQhW5FzQYkD4rJ7d1yRqvVrjgk+dylHPmDIBJL5wRvpDjlkM?=
 =?us-ascii?Q?o5aIZBt1o+NYXIGbUmxyEUj7crarlmE6y4i7YW7Hp1EBIj0Fcjb+OPyz1yJ/?=
 =?us-ascii?Q?8u0MldONRMKEBbcH15U6a64tF3OxL8fYUb+m78jGfsLjB1UKI5EN6h1sS+qH?=
 =?us-ascii?Q?31obKibHORtDGJrLBtv75v8nTPH4yA03MTlzmnYu8Kw/4d+vqqvnW4Aar3qh?=
 =?us-ascii?Q?itBMJqViA4JcblYE/UDW24BIZqFRBykbDdNDoStueyl6HvYNGENWuNxIWda9?=
 =?us-ascii?Q?AvRB7QsVC2sPDMr9KngLFLZuDzLJLWN+zKrISoJqWYGonR9iiqfnuayMBrOM?=
 =?us-ascii?Q?JnNmtCEvFniUgDFFpgYXrD52052fFujjv2O2PZmCLjWS6z8jTfYw0xRf3tAI?=
 =?us-ascii?Q?BFt3w5ir0IvsG3AWqn+QH2bwhh/OMUr9pASAUuFH+B9YTmj76QpLF+UnCFOe?=
 =?us-ascii?Q?+tK4KEWSuNg1YycT83URvmPirUKzBOS3RFhvlEC1ejfg6li12CkkUCH8XjSW?=
 =?us-ascii?Q?Wan4TQfhUIanqGvR6HcOUXXYdrideJxoeJJKxXzdUE5+KY9PpXuSDb/xXHFJ?=
 =?us-ascii?Q?d5Yez4mecnzDeA7To1rMxiIGOgzRqsLITkF3xZ+0aDUERyCAjHX4SV38FPOu?=
 =?us-ascii?Q?ny14Y+qZQWhayCaqSXO1JIhXaaf+Izh/koqjxhd5RDlbBv0vrle8kBtqH1yA?=
 =?us-ascii?Q?+LDE/opo2B+obkQTLLMTuJbN+Huvoso4ovWj/hV9kEqp29SztQCjFHaKZfmd?=
 =?us-ascii?Q?weZ6YUyAptc/SKdoXTIKWftL16MJsH9y9iWYR/X6CNugnuCrdp2eRBmK7C4q?=
 =?us-ascii?Q?kfYEo+8Oxb/lB4pMw5lqTXHDzXq/UorkNb+ObcD4MGw+gd8fNo1FeIKPH8Vq?=
 =?us-ascii?Q?Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c79293a-9246-4667-3100-08dbfa04ca64
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 04:51:08.5330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPy52Vi+wLaC2gDx8o76sLRnuZEhtKnXYkpL5N8YeWDrIYgNh48g0YMkkFoVAttIukkYOcB+YkoCZ0ZooC3u/xT3sO3C+YNB07PFgaz0XpZ6sNTApYw2fVvz5l3ZQp3x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5690
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, November 29, 2023 9:47 PM
> To: netdev@vger.kernel.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Brandeburg, Jesse=
 <jesse.brandeburg@intel.com>; open list <linux-kernel@vger.kernel.org>; Lo=
ktionov, Aleksandr <aleksandr.loktionov@intel.com>; Eric Dumazet <edumazet@=
google.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; moderated list=
:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; Jakub Kicinski =
<kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller <davem@=
davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix ST code value for Cl=
ause 45
>
> ST code value for clause 45 that has been changed by
> commit 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
> is currently wrong.
>
> The mentioned commit refactored ..MDIO_CLAUSE??_STCODE_MASK so
> their value is the same for both clauses. The value is correct
> for clause 22 but not for clause 45.
>
> Fix the issue by adding a parameter to I40E_GLGEN_MSCA_STCODE_MASK
> macro that specifies required value.
>
> Fixes: 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_register.h | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_type.h     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

