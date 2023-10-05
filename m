Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174117B9FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjJEOcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjJEO3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:29:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741AA1BEB;
        Thu,  5 Oct 2023 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513800; x=1728049800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Ab5OAPXLYfkCz2kfKxP482ctdJ/Yd8jWnqaZtj3Z8c=;
  b=Eh8l9/F5QKIFqvnGq1ACoktrsIEW+tCVpAZr47nR0uyvY9BgoPhsK8DZ
   oXjs4JHIgZiVdgkd4hoC3lXxl0Kzq+0gnvPW98woHF2X62w/ps418O11v
   nNnM48PIPGtcVE0Xic+dpGbKPVCEJBLyBa5F1txgi4d3EAOwIEvZBPePo
   L1/yHj8do5TuB56ixbNt2hAd331ftDV0FjBqcrnujG9TCBFUkNBM0n6tS
   jGAza61JDM16G1mJxII8saOkqrfQD5UxCxNi/xobizYVxNRoE47kul23w
   b7ReqkUwtqLd+bapBfyS5ywp8AzHDzAeZ22JHL4BH4LMmmYkajtoCDVkW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383340992"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="383340992"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:18:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="875480017"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="875480017"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 01:18:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 01:18:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 01:18:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 01:18:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WznPsRtFWchZ5tkWJYPSG1MNds0L2anINuDwQzUTON+xKwPwM3itE5Vja3sLi2ynhMejDQg794IO1oyvA+5Pza4dOIUXFALafE6bvKxSSa3npbrdvhVmNnEjWhrqtniK9azjTCBgbASCiHEGLimcvfsfjeWPhsYeKHcnmZ1OV2Bw2dvEXvvHhr+YFd/9oUCUo6ARFjz2ET5D0iGraM7EGHVak88xPgWaRssl7FmZHVuZWGUWq/nCGXRD0Jd7EG9O3oOEqDaKDG8kbcRk2hiqGlT333jD9b5+SJNoRz4sGkZpTYAjJN8w/Ni6N2Q0Zpgn0kg15R1UHYr0VDTkMba3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDX7jjg+ZgbWr+0zR4lFoZJvUPE6TPIs94xmvsuwzRo=;
 b=XvRlyCGUdnJN6UyQNzyVjbMd6FgStC1oo+k5/4NQutZiN8tuCldqYZWnaWhRQNcFeGD6Ynfh/blfnNsLtMHxtGx3krpH5zterzBUKJ4BtWEiyVlICCJmcOaJbAKBn+oiMDsgGKH6nvOYHEVbHBCAm2h/yd7sw7vQJZhcHxhFER/96PN1puRRjStUEaDf7lcshdtzOq4EPrvaP5sxFoxDHDG7sRpt7frabxeSiI3y+Y9s+/Hnu90L9PtR9tE1jJqGo3mYjlaFOwBPljnlyaUZHVCPvl+yva2hUqMX/TTCXog0xHO/ZW/h6MwIFsZ25sHANG6MKJ46MRPdbP/eaIkL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SA1PR11MB8473.namprd11.prod.outlook.com (2603:10b6:806:3a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 08:18:37 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6838.024; Thu, 5 Oct 2023
 08:18:37 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "edumazet@google.com" <edumazet@google.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 7/9] i40e: Split
 i40e_osdep.h
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 7/9] i40e: Split
 i40e_osdep.h
Thread-Index: AQHZ8R1NqNHvagwvyEi6nK5nHRalw7A65m7Q
Date:   Thu, 5 Oct 2023 08:18:36 +0000
Message-ID: <BL0PR11MB312250DDB16AD54A610CFF56BDCAA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
 <20230927083135.3237206-8-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-8-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SA1PR11MB8473:EE_
x-ms-office365-filtering-correlation-id: e1e0d2af-e587-417a-0820-08dbc57baca0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6SXVLWf1krgXwKys73ZiVKssC/t9+IuuXPuqniT/wH34MfqYC2n1jmiS6rwF59vcjcyWdE74eFpolNCujmrdF0xzkCyWd97xcRxyX6KkXJquZ5u8BAnl5C3xA0QwcELu3aFf7nbzJQ2CggJeIh63gKGSt3quSKPYhjJG+JjwwEv/gaR/atuJ7LkgTF+vHz+3h21eeC0Ku3WkryqgsoEjf4mknov4KCwndJZ7fGW6U8JKeYLRQ9VOKs/dCN9YMNWVrCuqpjLnrwcOq/OxOFX/iZYCaerLYhwbUpk04Z7cv9Y3uUtd2LVd0csgvoBzjHVki/1mTEJAoEcAq26turTGzGjzJ32urCm3kr95SIsNGj2hEuvZlEbqaIYDjHx+v1D+T5Eno0WBfpkWAlAC10Ju+HJ8B/yS2WM16oDkRVRwU/5K7HK83syfPWGxYly1wDID10l8vIgwWDMcWMabRvB5ULdBSBejuAXfYCZ5f0Q3sQbcH8d0fz4UvOO3B9BMSNVxGIB2UlPKF9qwed+O25uG6qOGwCGNo2sQwYdokZp+LEQnC7wR2c/T7omRC3p4Fheycrpy6LFxA77IRssurAKL5ujyHOuZ+cApDVrGi5wCIJ4ih0pp8XxMZYquqJ+QIdR+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66446008)(53546011)(110136005)(54906003)(86362001)(66556008)(66946007)(76116006)(66476007)(4326008)(41300700001)(33656002)(38100700002)(2906002)(8936002)(52536014)(8676002)(38070700005)(122000001)(5660300002)(83380400001)(82960400001)(316002)(26005)(55016003)(64756008)(9686003)(71200400001)(6506007)(7696005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8tIDYeQ7cr8IcF+1f7HnNwwiR4Nl+klVx8+lGQh8ubr4bTIM3RrTSKkldspx?=
 =?us-ascii?Q?HC6zBp3Li1nG7wipnBy0fbeMC1bE4zigzNfwcOnSLpQdGli57X7Ol+vRgCKN?=
 =?us-ascii?Q?/syiVqQeKWPIIWrtMBh4dyDCFQxmatqZKinQn/l1A3tAaeRV7ysjX4hmoPrW?=
 =?us-ascii?Q?CTe/sJMDisdNy7DcKe++oapu0E/sskw19tIBnCnvyR7G5EixbxPdvgBI0PMs?=
 =?us-ascii?Q?IQ9EN1FS1HrjoqzdRJLahMaEGsYrxsVrsVzWLvsEg/M3uM7JT3aODCp9YV6G?=
 =?us-ascii?Q?sjLiyFhkl9QXzc4gyrSGNTPYIi+cIxN7DMpar13LDPWwiU8IYYUxU6hQLQBF?=
 =?us-ascii?Q?1zdO3eeRe1u1dZMtMpH5iFPHVHOH2JhbBeC1i0d+l76E4jEIpQPBpkU1OBLx?=
 =?us-ascii?Q?ekh3q5JZilwjvKKf74wm64hq4YxahDcy14fI6wsYJZgkJmj5nRatw7z2VPAJ?=
 =?us-ascii?Q?3we9i1gJFnMlfKEQszyjXuYGkelJ5R+GUy1D42tMOX0AY93n78+B3dA0xZk8?=
 =?us-ascii?Q?RdVWHve9Pdp+qDooB2l3t3cukEb4uE3bpk0G+sViCxSrlO+7KgU+j70vge8Z?=
 =?us-ascii?Q?1zQBBlr9Cvy9JyPVvpcf4siSKVPDqM9zM9S4BTbG32SN5vvEySbRnXtsbuk6?=
 =?us-ascii?Q?9pINIsEgIuK/QxgfE+Rxpm0uGlzp5OdmLVG7JzsiS7kng8jrmc++EGQlu44i?=
 =?us-ascii?Q?AGltuQBOvBH+8HCCa12Af2wXgEOX7+N/LtZkbTXVA+b894DDdLXcofCpHsOB?=
 =?us-ascii?Q?ULjHsLHTywD3lIqSQk4+S7h66Z6DUxozGtwDkYO4UaRxGEVfJOijJto09vL+?=
 =?us-ascii?Q?M2JqG1qTpi/1MwdWrQoW3bJSwemv9eLQINzhE2WqCqH/wizJINJevAON/Hik?=
 =?us-ascii?Q?H23QRTXYeMZAWnjWZpd4b9lcWJI2xK1KDFcDxt1CqGOjVplUjwtu0/u37ZN5?=
 =?us-ascii?Q?BOwRmUrW6mxoStsRvB75l+UGF4FGQB1q5nnnh+Wprsz3x9G1nPNS5r0nPaoP?=
 =?us-ascii?Q?Yl+S+nFlHvNfjnJ0iTfTighkpbxzr51+glcaglc/w8qwyctt78vCJsfq1JCV?=
 =?us-ascii?Q?G7qcIs3q66ja1ckMxHEaSguXrqDQ55fPTqhaw0aURmOHnUxvHuWFrqisLgJB?=
 =?us-ascii?Q?uEPZ2zVmV5qEkznC1rivTTts5FddsK2HhlQP4JCrGPUpmszu+d2q+zOc569Q?=
 =?us-ascii?Q?FkgXsyjDnaWsUlFNOfz+Ii6mS4y4MxWuymwLu9ehQGJt5JtTzXYXUzJWuNQm?=
 =?us-ascii?Q?D0csmy2sP8WHUa/Cq2vhZukSWG6pXcUbtGsRXdQQh3UroIcsTRIsbwMZSFhD?=
 =?us-ascii?Q?M8aAEDat3aBnRWism9q7apDiNIutLqyoJp8A+B1H1MfE2L2O2bGvaacN/2gh?=
 =?us-ascii?Q?iVPg03LIAeDdX+w5evjp5lwqJdu7wUW4lx3Qb6qVMaFh8wGzMt3mHb+JEvFa?=
 =?us-ascii?Q?NSMmfKjjDAYaGaCA/bF97mYBKpfNk1WW4XFWqh+baB0aLcWP4za9YiCt3kkt?=
 =?us-ascii?Q?YxwDe8aYO+SODCd1ZRsQXyN4EOW2EEOTCiHNksNH5wuQMiX4IhbaAV7xyFNQ?=
 =?us-ascii?Q?xrRhe6Clz5dM+VeH+MBaGimrvhBc+EYnrnaA1mJ1weXhj9cJhXt1rWa0AHsc?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e0d2af-e587-417a-0820-08dbc57baca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 08:18:37.0176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Uwn30gjjkbths/3FZs/YDAHuX/OGVWHW2Ru+Q+sPlUbvKMidoBhRXpiPA9+CsbI4m/d61kw943LyK+g6Ys/VD7NAvxdcqPSuhVJFd/cHeiXxYW+SK0gpyuQYkxJlt8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8473
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, September 27, 2023 2:02 PM
> To: netdev@vger.kernel.org
> Cc: edumazet@google.com; intel-wired-lan@lists.osuosl.org; Brandeburg, Je=
sse <jesse.brandeburg@intel.com>; linux-kernel@vger.kernel.org; Nguyen, Ant=
hony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitsze=
l@intel.com>; kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH net-next v2 7/9] i40e: Split i40e_osdep=
.h
>
> Header i40e_osdep.h contains only IO primitives and couple of debug
> printing macros. Split this header file to i40e_io.h and i40e_debug.h
> and move i40e_debug_mask enum to i40e_debug.h
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_debug.h  | 47 +++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_hmc.c    |  1 -
>  drivers/net/ethernet/intel/i40e/i40e_io.h     | 16 +++++++
>  .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |  1 -
>  drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 40 ----------------
>  .../net/ethernet/intel/i40e/i40e_prototype.h  |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 31 ++----------
>  8 files changed, 68 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/i40e/i40e_debug.h
>  create mode 100644 drivers/net/ethernet/intel/i40e/i40e_io.h
>  delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_osdep.h
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

