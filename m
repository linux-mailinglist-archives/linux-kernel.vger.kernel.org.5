Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D553D7A1906
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjIOIjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjIOIjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:39:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAB2E7E;
        Fri, 15 Sep 2023 01:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694767175; x=1726303175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4gj6awcBBSA3rqk1yNWBfg+42M/26S9h7WfkduAzSq4=;
  b=dPoUB40deZCIhO6KluOm0/GVK4VNXhKhNGFvm9M7ywcuQT2xPpotnVuK
   62GlMNPxpk6j7+lsSJg3lYw066H2b64FuT7/Fy4VD7Vb3/HZAPfy2LXkW
   PAFncfInV55M70ERCxmsiX3PPiLOrXFR/eQsG/Q4jxb+3LmQV0Gkqxoby
   m2v0M3mv+sHyqrQV5WZP6H0ACjfh8NFNcVYGASIMQb8rdBZzDxhpURqn2
   nCLC297WeQ7fItZJEzCaFR03j09Ab+CtDOrEz/Onh4FVVGZO/OpKhhLCU
   9dFeaKv0uzSRnb8sXjAwpXcPsg4854AfcZqBkGD7IJp6RgRr2r3hSgtI3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="358614095"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="358614095"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 01:39:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="721606274"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="721606274"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 01:39:34 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 01:39:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 01:39:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 01:39:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDAHpC/6eDyJBJXHxDGJGOWjAZHIQq5NARWVW+ByfEIiSirNDmxOhSB1XMLpqRabqvK336skNcnAykieuUEvyBDcXmCEdqlMUq6uKu4gpbKapJiQYxMp0Dz3w4jP+AT0CwxPY0GW/vJjMEMzcNRmrZ7VCcQd/s6Zj0KUUs6pgX0PN3Izh0Yp6z4VqooFBR7945U5NPr41y9Yih1gCUIOZ35fQPKvN/i9KLFbRnlzVvqc3gf9eDOY0AHhe7ae1sHx9cWPo9uX4grsW/+z4PXvvmL5FW2zI9khKhjFrAzsjZbvhk/J2wWIZuuQaT/SGyj6QYZD7zJZrIIG+uQonzPuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gj6awcBBSA3rqk1yNWBfg+42M/26S9h7WfkduAzSq4=;
 b=TmNAFkdpdSaAb6wSNKDknFYVgBOUse3Kd4qTw+qKNbbL94K7TxPwYRcXrhKBbJq4DdXcln5BuLlAwB04BnyWrY/YQmEmcw0FrvogzkxWJ+iqUGIO8jgEGI+3p+m5gA7bwSHHuv0on9bXEGxRawnKz4muOA3mMfKrkr7j4cEforCGvie+ihjazz//EOCSge4ChfFo5P+1m2DErPvhZmPAk5RA/L+1mnLiUMKrGu/6RbMDlyd6hi7U6UC6ZpaXRMrPZJ0kx0hPcMWFii/APgPYqeynELh94AD841JCD+HLZ5Mf+gFN3QGqrhevniarlQNm2pRojOteVJqxfOl8ocpxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 08:39:30 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::d36b:7f39:5410:6b30]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::d36b:7f39:5410:6b30%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 08:39:30 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     Simon Horman <horms@kernel.org>, poros <poros@redhat.com>
CC:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net v2 1/2] iavf: add
 iavf_schedule_aq_request() helper
Thread-Topic: [Intel-wired-lan] [PATCH net v2 1/2] iavf: add
 iavf_schedule_aq_request() helper
Thread-Index: AQHZ4aKYLXxBg+Zx6EqyQt3bahjh97APfXUAgAwffAA=
Date:   Fri, 15 Sep 2023 08:39:29 +0000
Message-ID: <BL0PR11MB352130E58397568B663930708FF6A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230907150251.224931-1-poros@redhat.com>
 <20230907153126.GI434333@kernel.org>
In-Reply-To: <20230907153126.GI434333@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|SA1PR11MB6941:EE_
x-ms-office365-filtering-correlation-id: 2c1d6966-eb88-4217-96ec-08dbb5c74728
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7S7ZEuNpsC0s+CkUj7psEGSPtd8IZ0K49m1n2qPDKBaGeZQfw260hq/63Q1qjed6z8KvyozonrkjrwqXaHP4GynDqvaPbL1T/+QbaUg9wZDrVk+E8+DXMp7JuGmemSfHf6nLZkSQz4jVKICYlRJ+ngH3hUn39ZTfFmOBec9PEr54Lkbem0MmrnlAFiDDTr8SNdO6N7ATqEe0lM+Fjm8mAtN969mBIJhSo5jxmDwZ13EH0lXx/czOtxhiWoI6BaY/PY+j2vEIugkw5mTaaIBi0EYO6nFZ+IH5qj0R9ftKGnmcpL2JUBGsXx2QlAYKL4Oc4X/piBcg9hUqhquZdVDbZOxy4PkZXvlD5Pbw5V224ARyEHCNpzcwOgfuMHN763RWxJRv4e0faMwvWuj5pUgDwetWTdfTRuLxQUaTLR14QZkrhDN3ayv01z32fEXZ2zNP3CmouEX6lenBZIjOK8lFyFPR3e2t/HH3wd6c3BMCLt5GkZsCQcrwBBslDMJ9NSvX9V/s/ncO12lckIKwL0cGsw/mrbwL2/v3MT1oHop8wwzWsVJ7+MqSTEojytUJ9SAUfD/iUcm+Pcp1UHlGtCtxuMzkxb8MTiUl37wRg69aU4o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(186009)(451199024)(1800799009)(83380400001)(478600001)(122000001)(966005)(38070700005)(9686003)(71200400001)(8676002)(2906002)(53546011)(55016003)(6506007)(7696005)(66946007)(64756008)(52536014)(66476007)(8936002)(86362001)(4326008)(41300700001)(5660300002)(54906003)(33656002)(66556008)(66446008)(82960400001)(76116006)(110136005)(316002)(7416002)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pYlCD2hAnM+gMMgoO8TflTR01VbwpR1+b3YAxzPkb1IXUSlF5ZIO4FlPkUR9?=
 =?us-ascii?Q?yT9zl5o3qbEZ/jpqZEfASa5anqr4RqdwpLjPi7TDIzIpnsgoC4lKSwCEAr5W?=
 =?us-ascii?Q?GeDmOh7LePjWMVr+XVIHQghQWNHK97Ssg8eMJWNcBQ4I62YiYPrFQYVHali+?=
 =?us-ascii?Q?0mM7UgrC1QoGWYWRkxuLKaBswyLEgaaGlw4K4KluzPAUFph4mg4yZFG/FKfY?=
 =?us-ascii?Q?Y+VtXEeDrQfa18A94bTfaBvOc/z6hAv7mdmBUcZEW0xJA2TXVeUuAro6dw2z?=
 =?us-ascii?Q?3HLcQjy+oPXOpd2e/qc9xgGK31uv3/YGdar9JGAPJ13J1ozpQGPOsD478aV2?=
 =?us-ascii?Q?DYcWXPPiGhbPh9Vunr6+VDvNUqzxX5Lwa4fWWjOks77JNaWW9tGVRSe8NkaT?=
 =?us-ascii?Q?7T2ONDyRRt+sCkILJHBGFXsCnudO8t3BQ9Dt0AOiqenkrwpbtLgr/5iVFXd0?=
 =?us-ascii?Q?8EEU1ro3BTioSFC103WGtkuLN1WDmI7KKZ3oQLYrn/cb9ZeqrboRWqcBJNM+?=
 =?us-ascii?Q?LmgsYXm1pM2exs6y8ZPYROObxr0Al7bjdCcrudUAdbJd8DypeAFcD5vlFNKr?=
 =?us-ascii?Q?kogIbsIHfOI+xc9yllxqA9lWysVSFjT9PE6C+B1EGwOIVxMZibwzAyfTNGPZ?=
 =?us-ascii?Q?gtkulY+vZ2KHRgVSR47OLmBB1xzUaAX2RFIEDzaa/el3JJF19WNTwKfxFNGY?=
 =?us-ascii?Q?byNXjbfCy4NqSi8bb1dbFkhD3piCWz/2VWSOO4qOhGrb0cQLc58fcA3X6+WN?=
 =?us-ascii?Q?7TPfQs0Cusj/8G98MsIV7+0EkE33dmVKuBzZ+djzhugoLkIONRdUUIkMt65t?=
 =?us-ascii?Q?4zGKc8MlBHbCKySbZ0/YGXFgXxCX8P2ADMFTzmnu0XtCvcQPPCGoyvm37wRI?=
 =?us-ascii?Q?4MRhtxMU8ahJuiuvxgjkVLSZh8+U3nYLJ7osaYlh97Wvx2c9+NYAyIRF3V/s?=
 =?us-ascii?Q?PGOO01CvrXhSXjeQ+7NjwAijldTJwEF6HLNbHnlVVtEr4xMiBNrgoHWNW4ub?=
 =?us-ascii?Q?KTACoPhIJhwBipka/OHJFxQfaAISAiR/rAj6wwKQbNpE0q7LkZUSv42YR2ZJ?=
 =?us-ascii?Q?Kf2G8OJ+utKlG5l35cT8v4KzPI1PnBkMEnjg7LCc2x6pOEmIyvH/4D+Hj8Ot?=
 =?us-ascii?Q?lvyp40YbaoWkZWDog32E0fp4e2w6HVAxf705trAMAA5fXOQO3kgro15JX/0p?=
 =?us-ascii?Q?iDVt+82/yvZZzJdk4aFvqXxWiczRhGdGYGuloqn+cvSPk1fa3PxGvTSLzBov?=
 =?us-ascii?Q?yt2ETZmwoS7JxwBbuClmAatyaCJybsIqLVyMc0g1/SgOr+eYq2mdjwayT+XG?=
 =?us-ascii?Q?AOHTQsv4m+J8tJbFopir/dOkvpnaH2/tgb5x6ft/juVdI5crCdoLaTgnDq8c?=
 =?us-ascii?Q?YaShVD589LzZHrXafhDoIs8LotICTsuikOal0iIvmSNKbk3YF2tpEa/ogQPe?=
 =?us-ascii?Q?UuH76CeiLl2ZvHzjylhuIW0E3Uf72xQThdq0YAgHvblpF3rXeFkADNzVqcIR?=
 =?us-ascii?Q?kUVxJ9B5a1d2Cf40TAG1/BEeIl9ZcwsG+wgZqGIn4cpaywMV9BUByNm0yFEI?=
 =?us-ascii?Q?IAnJKrhs7Uazoy7Z8C34WC5MYZmJ0IZrBRjnxVYuFIExBMW7ZahkTInVv2c4?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1d6966-eb88-4217-96ec-08dbb5c74728
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 08:39:29.9456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bpLSFWz3wgNP2Ce6p3kyWAsTkIGXTTE44+1/JVFJZj5lVrbK9hvUK0TVGrn6KVQFgVO3u4FlIJb1PgDFSR+Kwn9hyAPL13ebE1tNUhJuwnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
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

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Thursday, September 7, 2023 5:31 PM
> To: poros <poros@redhat.com>
> Cc: ivecera <ivecera@redhat.com>; netdev@vger.kernel.org; Brandeburg,
> Jesse <jesse.brandeburg@intel.com>; linux-kernel@vger.kernel.org;
> edumazet@google.com; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> intel-wired-lan@lists.osuosl.org; kuba@kernel.org; pabeni@redhat.com;
> davem@davemloft.net
> Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] iavf: add
> iavf_schedule_aq_request() helper
>=20
> On Thu, Sep 07, 2023 at 05:02:50PM +0200, Petr Oros wrote:
> > Add helper for set iavf aq request AVF_FLAG_AQ_* and immediately
> > schedule watchdog_task. Helper will be used in cases where it is
> > necessary to run aq requests asap
> >
> > Signed-off-by: Petr Oros <poros@redhat.com>
> > Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> > Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


