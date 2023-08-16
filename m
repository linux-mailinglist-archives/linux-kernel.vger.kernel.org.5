Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64A177E1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245337AbjHPMuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245350AbjHPMtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:49:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C43626B8;
        Wed, 16 Aug 2023 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692190182; x=1723726182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IGeIGByr7BRBCCETH96WZGFrVwA/o4YZ+sddX05y5BM=;
  b=dG2qgi1Q+/vJLjK6xHLW7bi7U7D3v6ykpnEDdSXNC9R/W2TPLHya4oot
   wEwheWoH5b6uz1N/oJgOgfUJioj6wwTiZ0wLfGJbisCGp4mvg8lY1S3Rz
   Ep54usGF4jgv4l62JoGeEqvul2lfd8QGdbNRxEvQHQAXXNDtAwLN1XR9b
   MWGy7yzpeNIa0bJBhIzQHuuVGxwNwkHc3Y6Ie1RhdxfZyA1vWVj3m+bnU
   ECi0LBemyHr82ZSXa2L2a/yraZTCzVrJQhdDAdFWL5W1/vBVdcehMA4Aa
   I0mTJ3OAZ/sEKnttgjj2ZOqpWKOc/Nx5yBFyQxIv4rUBYYrg010w5SjnP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376251344"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="376251344"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:49:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799566385"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="799566385"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2023 05:49:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:49:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:49:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 05:49:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 05:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID0GP5OsMW2Qj1x2Uo/DoDx+wqPZzF4Mi4BfoS3rOp4/NR8wh0rNMi/oWjMTjok7LbW0VoQtFRmLy5uYHHHQ3SIVgJsS2WrdZrR/emPtwZGirFCysMcgFO2npdZQxnFr9Ixrc5+cqwl9Z8yGEN9cogZdScxbZxWC2Jfrqp27PKy7krBpCQyI0gBf7a6t5EtkIxPRbGDTKViRTUdeRgnkO7IIery88TtJiJn+N5Pbi1cl2mjWqLSNKmf6JCsBKo2/x8BrVOWItJpiMhvsjFU/tDhyL2sx89eChheCwACd7znIKLdwkwoJiTgcOUKcAyP/scuDBQBT9ji96EWQoSIfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGeIGByr7BRBCCETH96WZGFrVwA/o4YZ+sddX05y5BM=;
 b=Z3v25hbmZNsTw7nfmPt2uJ6/onyDOMglaeFXXOX0G7zdb67qwE6JWyTwoUmMjgp9Te/hB0094Ma4rEgBI5SnrPaHAOWPE+xLmplGhyRTFb6k0WG2cdSVEc4NOOehJNxZWmIyYKzqQ2deMoDfu3PHiDkSAQQtPxsKdc9bjkZghVScdHfgk7+AewlEA1g98i/rYcKVEZ86Ph1SEnjj1NR5LOcn2TeQnKkexNkD03q1rN9I1jUI+7mG/M8HIAOQ06zVXN8WGhaDGVHpyyTfgZjyuulg8T3D35VUaln4gFBvrU0ltnSC2WIf9f+r+fAUVgmz/NxuuZ/9OcSUskpy26rJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by MN2PR11MB4760.namprd11.prod.outlook.com (2603:10b6:208:266::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 12:49:35 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac%6]) with mapi id 15.20.6652.028; Wed, 16 Aug 2023
 12:49:35 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Zaremba, Larysa" <larysa.zaremba@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next 2/3] virtchnl: fix fake 1-elem
 arrays in structures allocated as `nents + 1`
Thread-Topic: [Intel-wired-lan] [PATCH net-next 2/3] virtchnl: fix fake 1-elem
 arrays in structures allocated as `nents + 1`
Thread-Index: AQHZwWvVrCDzJ9+/XkafqiFwYx/rba/Z2JmAgBMkrxA=
Date:   Wed, 16 Aug 2023 12:49:35 +0000
Message-ID: <BL0PR11MB3521D0C88253614A59E8E1548F15A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-3-aleksander.lobakin@intel.com>
 <202308040128.667940394B@keescook>
In-Reply-To: <202308040128.667940394B@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|MN2PR11MB4760:EE_
x-ms-office365-filtering-correlation-id: 5b66f4fb-5b48-4378-192a-08db9e573ebd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /XYl9C+4PgvjZzcyeXy1NjKLtlsR7u8i1+fdoF2OTn0aC4NfbxgygW1yC0i/cpPJZmqA2AksUM0YlzyE0E/UI7Qacvf5U6n82djjPOlzvHLppRSFrlO6Q849e6NEMyLDf8QTfqAnBumhU6YS5SRKjzxtHYmn+ShjLmQ/67G2I4bt/nmZOVt2kQDnZMcHNBjuCPtFVlNg5zpfS5zJfvfhBYbQSZZBvu0dNjf/qs7NnWwDbRrGA5prb1vbiGCwBNs7ohWZ3AnBJfSXmlv6WbHUpMpgvpH8QWh/531NLb8kv64UF1DQdHU4LEfjfjtaSjgKD3hz/Yssf0bSM6HpdBYtG6gE1Pt6o+d32yoEvWVU42WSjdP9Z0OMwjyVZmc7mD5/MCQc+MexeltOy03aQLf9412d2ygDk673olxYdMEYIpnF3++1y6nZn0FchA+bG3Mit9jzjrkFErqLndPaCo/ITP4SqPKiczmVxFFReSsBQ+UE5JshkhYSXNKWwaod0lm2q5r3tw3upucLoOShBzh5+IY7JyNCjFTiv1ST87fr8XZ///FqikvmQwjCrxJkj+jppFTXO42EjAVzrUGGKyhlgTcNZ2h3GSkaz3qCKmOfJ5HU3TdDALgTrxccUxxzXC2f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(6636002)(76116006)(66946007)(64756008)(110136005)(66476007)(66556008)(66446008)(122000001)(966005)(41300700001)(52536014)(5660300002)(66574015)(38070700005)(38100700002)(8676002)(4326008)(8936002)(82960400001)(2906002)(83380400001)(26005)(55016003)(478600001)(7416002)(86362001)(9686003)(53546011)(33656002)(7696005)(6506007)(71200400001)(81973001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?HD6b3G8/E8Vvdb6SKotNXUHaBmdd4gZe5RkuDCl2253bqyVkf58Pf5I8ad?=
 =?iso-8859-2?Q?ZIB3HwQXRCKPrQxbYSx+U5bTfuOVflmREIW3GqX2x2MNSQKGufigOISUk2?=
 =?iso-8859-2?Q?fCacymUCfiNZDbayguOPPCwK53MCRv4Tvq4iwQPHChvNkauXYeTw2XVhSD?=
 =?iso-8859-2?Q?sUUlrOxc+vqkZQ6YO7EBrI2cB/UjhvFJrD/zXhRNkYKeVOkV3+TNX5K4v2?=
 =?iso-8859-2?Q?508GuIAjc3fQfB5FYtAV9mrCq0FoJ93xd4JHVfcR1QO9miwP3EWHx4/jrD?=
 =?iso-8859-2?Q?1VAaZ/pTfZaLQ+EAZyDcfEiTfHPiq8u9FkxxKiViJRlo1nECn69QaGm/My?=
 =?iso-8859-2?Q?49Tqi6Zf6/DbrYlogp/qjRdZXZIp23andamcFRVeYtuUB9JDC46b4lllLQ?=
 =?iso-8859-2?Q?zxqfai997pNi2MXYKSc5hwa2G+XWxL0ZVEwgIGZPQKsso1XegcUFFhxmEN?=
 =?iso-8859-2?Q?EE0CTYoEB136TxnvpWsVp6Oiur1n8ppbLbFwYp2O61n8BdU2/129PvxBKX?=
 =?iso-8859-2?Q?/Y10ydb5YJNggvKZ6dwd6ay4Pba918LaUaWrX+qi1lu7wxBLvzZlXX7Yg7?=
 =?iso-8859-2?Q?YVhF6Lu6inLnpwSl/THwdbgkp9E8yRG52pn0nZe3Z9LXzKvW3VlJG90Oi0?=
 =?iso-8859-2?Q?9n2jaBYjxPQcc4Le/hpSvoE70KPsSRm6R0y14sbyf6TEAp8MtSAYPCs5pk?=
 =?iso-8859-2?Q?FOlr90ZYXrSFCxJpHsYFh5Wi2hXl311a2YGPurV2L+hyXmSMD9GFC9YwaZ?=
 =?iso-8859-2?Q?CjOS7Jr04tecxEiptpBbTJjL+6/UxF0cQzsCTgOKGhkvQDDoJjWZAEkicT?=
 =?iso-8859-2?Q?Ax34naoujavQ0f0Jf40xE4OcjQqow1+T9zFqJZgOS6rwjOxbjqq0Q5ovje?=
 =?iso-8859-2?Q?wg5/SqEPFvbfGoQmWcCvB5fgk0rPVQNkZNzfJ8sqGZrZDC7o63sIBPeiIW?=
 =?iso-8859-2?Q?rC0kOg8If1/DW1LW2qMArDM8I2+iceCWTWG5DiVPfSEmu3fLMfd8WoVFnQ?=
 =?iso-8859-2?Q?y3XLR4McJmgskaIAB1Rl52sAg8XhlxwomtsI5R22qVmCPwYrTXp4HO3fhV?=
 =?iso-8859-2?Q?wbP6oWfoiTfguaNr2Re0ZukU1mpR8UHuaz/L8YTevIZEffvuTYLhnyHkfp?=
 =?iso-8859-2?Q?63unvyZVdKlOVUBSxTGuVSKfi46JuVmgOgEfntkAsktzwph27XQr4KeQGS?=
 =?iso-8859-2?Q?mG9WYiNE7UA8UzWOcUA70URCmnsP/+ncxjMYRYvBBpOWKFEstl+y2sK9El?=
 =?iso-8859-2?Q?ssvPDjLfJeeZ0GAk5H6tdutonuywyyDQlfKTM2QS5zXm89stmD9PKW+VO8?=
 =?iso-8859-2?Q?QD6xJTsq0ni6QJcG6lcxjlhbW0St9au2Ue5bystY6QjOAQAqd+gNXxzkQz?=
 =?iso-8859-2?Q?wikIWH2M075SRVqC1bHjuYoI5jGgdY7DFPUo9MQdWb7sX/6xpJMI7SkOue?=
 =?iso-8859-2?Q?HoyknN8q+qxp2W5+HzYgKqqGeAl2xuj0ksbTwgIP8H1nFwXa2gOhRwxn7A?=
 =?iso-8859-2?Q?J/GotJZBNPlQnDskmxPP1GlceWyaR89CsvcDCVXjbQvval6EAXeM5o018b?=
 =?iso-8859-2?Q?4ykR3dfm4OmIIkC9DwNc8QHUTpxD+lGULrMU5T9ktQGkaAQOTdrbPj9vgR?=
 =?iso-8859-2?Q?ObsygHjiFvn9MkGSLT3QSMpb8jxRoDpvedveaQHv46F32qQeuxRT4alw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b66f4fb-5b48-4378-192a-08db9e573ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 12:49:35.4902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYaLVwMkCPCcua9Hk1WyqQxgKdxoSNErdv0Y/L5i4zSGhyNVNFKcBohJwM2louwWwCVMAUsUWAukAwCLpECDYrgTi5J2orwBGLYisZFJYFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4760
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Kees Cook
> Sent: pi=B1tek, 4 sierpnia 2023 10:29
> To: Lobakin, Aleksander <aleksander.lobakin@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Zaremba,
> Larysa <larysa.zaremba@intel.com>; netdev@vger.kernel.org; Gustavo A. R.
> Silva <gustavoars@kernel.org>; linux-kernel@vger.kernel.org; Eric Dumazet
> <edumazet@google.com>; intel-wired-lan@lists.osuosl.org; linux-
> hardening@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH net-next 2/3] virtchnl: fix fake 1-=
elem
> arrays in structures allocated as `nents + 1`
>=20
> On Fri, Jul 28, 2023 at 05:52:06PM +0200, Alexander Lobakin wrote:
> > There are five virtchnl structures, which are allocated and checked in
> > the code as `nents + 1`, meaning that they always have memory for one
> > excessive element regardless of their actual number. This comes from
> > that their sizeof() includes space for 1 element and then they get
> > allocated via struct_size() or its open-coded equivalents, passing the
> > actual number of elements.
> > Expand virtchnl_struct_size() to handle such structures and replace
> > those 1-elem arrays with proper flex ones. Also fix several places
> > which open-code %IAVF_VIRTCHNL_VF_RESOURCE_SIZE. Finally, let the
> > virtchnl_ether_addr_list size be computed automatically when there's
> > no enough space for the whole list, otherwise we have to open-code
> > reverse struct_size() logics.
> >
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>=20
> I remain a fan of _Generic uses. :)
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
>=20
> --
> Kees Cook
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



