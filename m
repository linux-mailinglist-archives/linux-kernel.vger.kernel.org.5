Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5375CBDB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGUPfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGUPfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:35:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F2B30DD;
        Fri, 21 Jul 2023 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689953747; x=1721489747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DH8mPjNn80BFQs4qM17R21j0oiGkcA2odNnoytoWMMI=;
  b=Eslklz5IrVDzpFn6iP+wnS7NVcFOaW4NdMC14o+W9V0G7hNsHDsyNI4J
   tp9yKymi1LxqNgtEYOKgv/taAs0w22muItMvEAmiiAeSYySV1jD9LN0Ev
   48klKci93zJqhanf414pNtQ8V4iOjJ2HRfZZV0t1coa6xRKMeTuq4J0eP
   Esb4/yWy5h7D2R/pQlYTBombM6Rw44758NINE/gkHtyBF7eAr2F/ppCeE
   pPuP3AyjbR8CU8kMb34uHJQe3GElf1FEX8jYm+fWYxwDLbfAK10YLt2g6
   LfNNiFK4csoeGL/6ttEktrFwi2njAP7ZnMu1HUpFyIRgVX5r90xDvb/d9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="430841268"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="430841268"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="728146331"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="728146331"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2023 08:35:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 08:35:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 08:35:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 08:35:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAKJIvf0PFC4MAWSWBYKP3yWc30/jS69v3dUzhR6flZRmT/dJ8gH5zLflpGfHq4sd1LhmM441v8DdC8FkZV6cxoxbiTmCmYdAGa5ITisv6iZu+i2LW2FYc8ZImdjXpAzjMWwBOUtYFLWA9vMBiDjg6y6BpAarHH7EFKG4sfTroB+moS3qZ+1pJg9YJX5Tkgi4ddgX0Eit9Pc7TEmFGXnpdoGaivou0EN5b3q2GmcPjQRchqSUGe7/GMk2rl9HcS+rvwRmGp5p248LslPBUFDf9u7iLJMtiyZI3dSP+P1EDVAVJyRLOl8Blzx2dmYFNUUNj/MJmDl+anlAYjkNvwlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaEvI/4q07ez90c3U/aOd0IzjcI1chw80DxWKW3xej8=;
 b=MeaQSTZiZxj2dUmdN82b83/iUQYk/MVuDi4FV6DWFLoyHQOSrlu+sxNlSGVk1lykeE0bFtGA0sVPNTuls280cbxzmS92VPSXmH8T+/mfW5gC9PnarUGvIc8ATEEhso89LMnaa39QS2qW83yTtIZki31o+xt+IlfiKL4WXx2B/r0ldA85Pfn5/WvXDMitAd+7oMEcC40gFcPjONrY/dR9HGU9UBvDi2P4uri8sqlBgkplt8jV/MlSeXjM4QAov0qw+6cEyLC8GN8oLm4vuYjeKAwZDvuFT/4hs1Zc+bE4kE5rU3e9QTc4jBqkNYBNG9sVN9jQf9/DheWJUDNeqkUYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Fri, 21 Jul 2023 15:35:44 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 15:35:44 +0000
From:   "Ng, Boon Khai" <boon.khai.ng@intel.com>
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        "Swee, Leong Ching" <leong.ching.swee@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-bindings:
 net: snps,dwmac: Add description for rx-vlan-offload
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature 1/2]
 dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
Thread-Index: AQHZu5xgG1a+wZGOqU+EmB1OiRdona/EAemAgABXzQA=
Date:   Fri, 21 Jul 2023 15:35:44 +0000
Message-ID: <DM8PR11MB5751E1290649A690A0B50F7AC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
 <ZLpbPxy4XHEGyU6I@smile.fi.intel.com>
In-Reply-To: <ZLpbPxy4XHEGyU6I@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|PH0PR11MB4949:EE_
x-ms-office365-filtering-correlation-id: 08d65827-c2c8-4e92-9963-08db8a002626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZY66yRrUU1doh7gUgMmvUhA0x+e5MYHH9MkbptRI7Q0+ltPC+vjjZyqBL062eMC7txOrpNPO8o0QhPZ9cXiLeJS+6LQ6hw1qnGFcupVDUQ9t8pXP8z9Qh5HFT+2Z+5JxKM9UhUv1u1GRyGmGeBFRXQL5WXEBjLEfkfWVBcL/Ra89J0fB3VQ4LDnxSVLExJEnsldVPZO34ClbLR/MEOWUakjF8s1uCSuy8lmhEm8FnpYl9dyZ52glyMDloA2wr6gSnfHkfMhvVFTuqEb5b/AX38yAjxPqhKExCyKsqcYnUg5vW7SdzQI3vNewS5SBsgwDUx5PmftczMI3jWxRAwh7B+MKHJY2W3eqErTIzW1wNq+aMc4JyTUhGjqxRh28+z0VpfiUqq4LO79pQqTlE0tBTuCRjAtJPgrU5cMq93lnfb8LlXvXedeR5Dk7pcVFQCp0jYYmGrBEr5td0xyru7bTkPygf56kQZSZDc3YB6ebA11NiPpwDcdNkozpfssxXRaOe78FrX5xmMRr8w7FDnh/L17ILvFV7MYEgwaDLmrAq74S5Yf28/akR2UXrYamhNni6X7lmBKOkIAkIj5HlH7QjwF7sqmTvjfTu5wEWoOlii6zPEqcAWGuBk2MSZ0+L9F+c1kEtdVW31zLpOqzMZDmuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(55016003)(26005)(186003)(71200400001)(107886003)(6506007)(4326008)(64756008)(66556008)(66446008)(83380400001)(66946007)(316002)(76116006)(6636002)(9686003)(52536014)(7416002)(8936002)(6862004)(5660300002)(41300700001)(8676002)(7696005)(66476007)(478600001)(2906002)(54906003)(33656002)(82960400001)(38070700005)(86362001)(122000001)(38100700002)(168613001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1L9IqHtd2I/aUo1SqngRAKdJwMWbxalGYW2ljJUvldPJScSfU8XKFYDpbv0Z?=
 =?us-ascii?Q?ycvNSFsZWI0UoYJwUJ4Jw39ll/n7W/f1GcGWyw8vglLbXZqu5u8uTEWNFI0/?=
 =?us-ascii?Q?d/l0k1YGq5sKdEVgIx1t3GMhkrz+qAraLNaLgAN7E/2LK8eTO67EyNaY3e82?=
 =?us-ascii?Q?IC4ANymJ9IWHPYAzIN8JXwB8TtBCoUJJ89FAB5FIHtVTxZ4Qpb/65y17nRwR?=
 =?us-ascii?Q?BJJXucLmpWUV145rWuosf+eXu9rkXdDW8QlOddhwNmoHzaWxaxuTgthh/abd?=
 =?us-ascii?Q?ZIe1bamEkXEjuHTk1GHRfLqAjvNt6JnYTmNNSdxoWSqAxcS/YeXdUP8V8Nuo?=
 =?us-ascii?Q?H4ULIPSDsilGMJxvFiRova6P6G9PJc7Vj6+MX0PBrmAxdN1vztyjXgEc5Zti?=
 =?us-ascii?Q?hlhgec/Sg73lsUB3RsRhDe9jNbCNjwCnIAEchyUhPl+xqFX0Yi8td0mygfCY?=
 =?us-ascii?Q?pJmVVp65A9/MTMUPbOAYyBbOh3HR5TFCPsNkN1/75fWkAmEhbhJ3rauDry3s?=
 =?us-ascii?Q?Bd8BVoyvkOfsKXvCM8/mO3pTelHLrthzI3LhyoG/wtmK35HcQegD2/ZYcXPI?=
 =?us-ascii?Q?ACQKiz6J8ZuhPkYUMWcbiOE1Wj8IqFPMiaWL16a30LPcQUvUPUBR9Kfkcd+L?=
 =?us-ascii?Q?all5dIDeQj+rBILA9Jp0IKrtQmXNBSFn1y8OaAGp3jqlFfGwNcx4qSShF3oz?=
 =?us-ascii?Q?qqLjyP1C3R528R009GhlSaK23tErohHk6FV3xWUlkSOpTyMwBK14RcLxQ5gI?=
 =?us-ascii?Q?opTYuzOZ2QXxHbo7Vu6sUBW6QSzxyR13BnGt088Vk2jJ1TTfyKnTfki3WU7Q?=
 =?us-ascii?Q?WuleTTzGSKqiopSkZCIZ+WPjvPz2EJh4qwV2wwgI0kZY4Shw/QqXxUSlJKsg?=
 =?us-ascii?Q?W7nLB8Mq6krhiKGQbI9JHiDXDBnqDrbowUYNNVn73r1qRPy1b/AtWAWHgAUm?=
 =?us-ascii?Q?EOULi3ryMl5EEh6LGm6/ss3SeftyamUydmM4BxIMwMgh91HXtHi4BfoekvoE?=
 =?us-ascii?Q?0129LesxKN33kdVW1oyFPMZ/zguqCVNb3hTgLU87aDEq4eLpdpBrZI4PnKnO?=
 =?us-ascii?Q?pl1WfStFuJ2mudtlctypQUbSYdDzhdURUiWgnzN0jru90Yn4ZUoiCNL73DTd?=
 =?us-ascii?Q?jemjuoAT0tisvl+l9ax62a14EqiRKedlW12rw2THci3Uahb5KdfIFq8xtwGL?=
 =?us-ascii?Q?qEluY42QQ1nUItz8bMBlZsKVOk0bhAC2WMViN7q7WQBS7Lox+E9+4YDU+87y?=
 =?us-ascii?Q?mayr7QA2P+KKRsKoyqtcBxwU/Mthxnfd+XHXb1w5mySnQDSF1qCgkvgrxegI?=
 =?us-ascii?Q?P0ZzsjkF57Et8eT8D5u+FTrXJZQ7ePpL2pwMtehnLY4uU37wGP1bQx0xBOef?=
 =?us-ascii?Q?oEf7tupPYjxgJxVOhu97A7aDOgt0o4OnA20g00wwwruEnlvDVr+5ioI80ASl?=
 =?us-ascii?Q?Fp89cDndblM5W05Sr1pwM/AjkFV4nlvh9Z0vgtxt6a54wdq22ttr3oujjqEo?=
 =?us-ascii?Q?5Z5P3677cUDHStxtB3J7NDr47h7CkDwj7iPoyM3b76VoWTaugb0QFdBu52i3?=
 =?us-ascii?Q?YyS3YYX+1Sy1cYWo1WsljV10+sYa3GdOGWX64iW5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d65827-c2c8-4e92-9963-08db8a002626
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 15:35:44.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+nhKKkfEvRCNvkvPHmoViQC45E57SbqEpS2Qfd6U9kjcLY0XdqY8KnJ9kuxZwjEl7gDS/nweJWWYiF2T6VlfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Shevchenko, Andriy <andriy.shevchenko@intel.com>
> Sent: Friday, July 21, 2023 6:18 PM
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Ng,
> Boon Khai <boon.khai.ng@intel.com>; Tham, Mun Yew
> <mun.yew.tham@intel.com>; Swee, Leong Ching
> <leong.ching.swee@intel.com>; G Thomas, Rohan
> <rohan.g.thomas@intel.com>
> Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-
> bindings: net: snps,dwmac: Add description for rx-vlan-offload
>=20
> On Fri, Jul 21, 2023 at 02:26:16PM +0800, Boon@ecsmtp.png.intel.com wrote=
:
> > From: Boon Khai Ng <boon.khai.ng@intel.com>
> >
> > This patch is to add the dts setting for the MAC controller on
> > synopsys 10G Ethernet MAC which allow the 10G MAC to turn on hardware
> > accelerated VLAN stripping. Once the hardware accelerated VLAN
> > stripping is turn on, the VLAN tag will be stripped by the 10G
> > Ethernet MAC.
>=20
> ...
>=20
> > Reviewed-by: Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
>=20
> This is wrong:
> - I never reviewed DT bindings in all your series.
> - My name for the patches is also wrong.
>=20
> P.S. What I mentioned in the internal mail is that you can add my tag to
>     the code, and not to the DT. Sorry, I probably hadn't been clear.
>=20

My bad, sorry for interpreting the meaning wrongly, I will remove all the=20
"Reviewed-by" stamp from all the DT patches on the next update.

However I copied the Reviewed-by: from the previous email, your name=20
Shouldn't be wrong.=20

> --
> With Best Regards,
> Andy Shevchenko
>=20

