Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F9777F85
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjHJRrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHJRry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:47:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B70270D;
        Thu, 10 Aug 2023 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691689673; x=1723225673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=73d4fXwbQAUnmYlX5nKwtkfZ7EQ3ew+DbOMV/u7edp8=;
  b=lKCe/xAcZHpdvLKUm0tNRYf05zfqnQlUHwdhAJUNdinY8qduFZ6T4cSq
   Cx9pb5ibLDqbeFhXG2OB8l3xfvyNi4QEm24rJ+Q3gc5l7jsj4oHAtqR+N
   G/UwZ137buGx/aYPs71+0/baHzfwO67JxldfDhFEXOf1CFqnJt0LcNyfs
   t2x8ojyxc3Y+nNnetE/IJAG2xPBwRIFJjJvu15MRpZdx7Mb9SoJEvEQdr
   YEJ52zAMgD+bh6ggXBeQede2pyLWTsGIvjC0mdUzQ1K+J4M+m8sHlUURK
   kMJ4+9nf8vUHU8SspqakGcCtr4DWeYgO6B/P4XMoNSBYaYsUh+6Qx/Uq+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="402449809"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="402449809"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 10:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="797697998"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="797697998"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2023 10:47:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 10:47:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 10:47:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 10:47:51 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 10:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/PynzNZfpvlmbMqBMK6WPVmoBf/WG2BcQ+W/EIfV09qWce6MYwLih7W0DqHUgzb+9FwA2RUT9c1UYL3YSS5BsfjE4ADQ2v2Pwu7/bzI9XSCO0BMCyhOCbeLEFj/BHHiwRNFqUTZ7khI4AiOywUaTVl+0qsm7HZo/faeUuZMn0tKvOd14T4+0pkLvl77dUwsLMS5KXtuRB2RJAiu4YAPiY+2GxP109FWHgQgAl3QeheRptf6I7iuh7lzpy2cdkcSupxgl0n0Vqknn2np1dF6MC3UhfJUOso6PbPM37lraRsRZnTyIfsVZeQ9LYtaZbaf7mVU4AhLx+CXYPVsBSQcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TXWgzCcAlHWQVuw2Tq0jyZdCD3xpu1X/VtfO3njlPM=;
 b=CVmCzFrifSRqeY5uvlcDeffUnsmAh61lMoqHM4JKHklXejTtzcVBlH1du5mPNmQuOhhmD8P9o7+ZUGpiDd4j2ARsTvdfFlcxfLMw/14tCpRXg+NqBkYAW9H81TNIp3zlUZ24ZBVxVFpHvvtZUY5fMm+W59ipLFGyKI1Bk0vdQIH7y1QcxA8o4wblFfvShAgVNbKuJxgOp60p2T6GPJ/sFx11e1/OqlMUnlyAEV7SyU/TksBZF58nfS6SUF9EQ7Ak8vQ+WLXJdNorku8/c6TLkiI/mGOngX8VkrhNJ2thQ4AU6m9mWD980icPae34/tqag3eG60T59weI2DFmoO1dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PR11MB8714.namprd11.prod.outlook.com (2603:10b6:0:b::18) by
 PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 17:47:49 +0000
Received: from DM3PR11MB8714.namprd11.prod.outlook.com
 ([fe80::b393:daa3:e9cb:58d9]) by DM3PR11MB8714.namprd11.prod.outlook.com
 ([fe80::b393:daa3:e9cb:58d9%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 17:47:49 +0000
From:   "G Thomas, Rohan" <rohan.g.thomas@intel.com>
To:     Conor Dooley <conor@kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Tx queues with
 coe
Thread-Topic: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Thread-Index: AQHZy5vzXU8toRx87U6CwLClASZUn6/jqnuAgAAfHYA=
Date:   Thu, 10 Aug 2023 17:47:49 +0000
Message-ID: <DM3PR11MB8714839031B25C932B13DB5CDE13A@DM3PR11MB8714.namprd11.prod.outlook.com>
References: <20230810150328.19704-1-rohan.g.thomas@intel.com>
 <20230810150328.19704-2-rohan.g.thomas@intel.com>
 <20230810-avid-perplexed-0c25013617c9@spud>
In-Reply-To: <20230810-avid-perplexed-0c25013617c9@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8714:EE_|PH0PR11MB4917:EE_
x-ms-office365-filtering-correlation-id: b20d1920-37a5-432b-ab3d-08db99c9e9ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSXbwBB3zYGDe1swOWcHNfEMC8mweLwYRPeErD+AA8RYL6Y69gbJFlaBg2Mb0I65WQcuu9MA/fLvE96w6P+WraxPF78dAfNFHuqpmknkAnnmEGJlARtw7wnI3D7WTpGDHbdP5z28zMJ5JQLDyM7SPvWkjZsXJtSoHT2sKOLN+U6sCJyFRjqJl62ohFxomW42lBYGtPFm0XLxPunrqA2urLnog2K1WkckyVeQEAaU6gO2Vqyh0bD/6irdB0ZioTwcxoz5qxxsGOr5momNBV1sz9KQUMvcAzuxTh+NQTR7lJ4KxJyZ2xauZSLAAsTa4PSPC5nFsSpzLnGb9wfGs7smtFvmTaDRg2tusLQG8SqEmcvA1MqIKtqbJ8z7GWH+E/0BQqigGlIgoVuOivGiSeGvCuAn2Y9QUqtv2L7C0zz6jnLfJ09rAP9A+4s3eqHmcU7/Y0+OoMeVgqeTYjKsPkHgADCfyknCbwGwopfJfnQEoVa4kYk8bDgIMHZQm49W1aR8Fpf7ocI/Y4stCplkWzCPFIldV2qeJW5NqGi2MfWSSKurAZ6+77s6Yl+nbdvI9d547XrcC1tjVMvwO0uHRMoQ2XEz90V4+DIdzOtk4l/5dcXzhGu41SPzB252ENt8Bo5i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8714.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(186006)(1800799006)(451199021)(66446008)(5660300002)(26005)(71200400001)(82960400001)(41300700001)(38070700005)(52536014)(8936002)(8676002)(7696005)(316002)(6506007)(33656002)(66476007)(9686003)(6916009)(4326008)(64756008)(66556008)(66946007)(76116006)(7416002)(83380400001)(2906002)(86362001)(54906003)(38100700002)(122000001)(478600001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?08lm03o/iSr3pBJQ49nGR92hUmnxFRcliBq6rxr0M4nG7tQGpT9aRIaD5h?=
 =?iso-8859-1?Q?KYXOoTCrz0OyEnd9ml+dhP92oKzuPxYfre5KMMsImW7T8p0NlBzhwp1R4a?=
 =?iso-8859-1?Q?EWPLGC2HfYqtQpvssTBKf2/1dTr9PfnsXMW1ZwVrPR+rnpf+/HY0zCZFP1?=
 =?iso-8859-1?Q?CLvxcuY4AGB0uasuZepEJlp+JI4lByz7DjhvSyKY4fQ0yYoamCQXna65/q?=
 =?iso-8859-1?Q?DVOzvZFYOEn/rG0MScXL8nocXd2iW+PShOhFYWSYPZga91HHbGYd9Zicl0?=
 =?iso-8859-1?Q?EDTcp2et8/1H015uu5mQMgevp8Cv3NnaNBINgjr9Cnj50ZqWtUOCjg2LsJ?=
 =?iso-8859-1?Q?XKjtV+i0444mHQ4BumXkkLQhvhUb60EV5eVOqaFMLeUBvPvM0G+j1kA9MJ?=
 =?iso-8859-1?Q?+Hy+VU9ZLZzGZmTleG/+T41OHFtxIG+yGCL+d5HcVJRfGKtOCYKdezO+ih?=
 =?iso-8859-1?Q?0VGQglYdGhHAhfdWJ0+b/bKIZ2C7u2Y7Yw18bHGXKfRzAwmn4oxptfjByY?=
 =?iso-8859-1?Q?A2ydLB3kKMkbOeLOuXFz/jbKewm3TcJ1W/qQMcTz51f7/5765V9f9+ufKv?=
 =?iso-8859-1?Q?ijNqgJIVGgDbEWc6fBf0/ezQNa4SXQvwtrmTUFJARRrUxIcmy5ma0aUpkT?=
 =?iso-8859-1?Q?Vx2BcNELI0hjHdVI6sIbQsUcGJuTEyL1Th3t0yxvNUi7BpVEREKuVxbUKI?=
 =?iso-8859-1?Q?mpmE3rLuMWb8gsx35WMEEa9Lzcrc1JbMmeK53cLQsKkDLPhqFOgc5JX2K2?=
 =?iso-8859-1?Q?mBKTHLXfyLq349RFWw96wsqWmiOb7MTQuHHbSVnI+IOV3ZWTHy3QYV1xEi?=
 =?iso-8859-1?Q?7NcNDkfpsytm+TASBcGXbyHQRCtIe/QiU6OZVybl1nibIHThpakNDRbtPx?=
 =?iso-8859-1?Q?3CiBylo62/ytP5fPCTLyc64bCKPAoXFAJ1tcZJIYwZJeBktPYcFMGTou1g?=
 =?iso-8859-1?Q?6iG6VFs0a0bH1WL4UkRoSL4sw6Pl6zeYW/2Oro2zJU2tToaA7GOcSWxoEk?=
 =?iso-8859-1?Q?eus0BLvMtBR8QrGh8PE1bu+mWaioiWec1dx94oNFqmNpXmK3FhHwNtxOis?=
 =?iso-8859-1?Q?Q17epLEMMyuRF9X1rPGQp6YGfALnu13pgyvkwhJ1ZKyBSbmXe0DYQ41Urj?=
 =?iso-8859-1?Q?gVV0FfWcmmMuvRlFvnQkbOEPaeOoKWmzpFB+E6y0qdcV6p64000I4YTC8D?=
 =?iso-8859-1?Q?XDEZeKCmp4wDNhwJkjdMDdNc3XJ3I8UlA+TmQVoTtpgAsRDBMysArNDScq?=
 =?iso-8859-1?Q?UOklg3HD5A4ZhzagkZGUkYj0MxIaDFpSzzgQJleoFb1OMgcgfyHTFi415J?=
 =?iso-8859-1?Q?s0cWB1Ywjd0iIH27l3eJWH2AXrmHBbC1gQNUQlnt+DmQbA9+M/tZsjUeoi?=
 =?iso-8859-1?Q?H13oITKeEjZzvzHzmNrK4rigCFsdjO8W3sKnjACicGcPniMk1SLlYAkN0k?=
 =?iso-8859-1?Q?zjseukEUf9K09DGieeHnlY7AJeBoZwRipmzHm9uTepFR5ST6pa2s/JMJL8?=
 =?iso-8859-1?Q?Mmj5dNHdZDSk4R8a/10P6OH/jkv9PwQTRVgkLj+4N6aRgvIC32X72RSQsY?=
 =?iso-8859-1?Q?kn6zRICkuM9AsreU8MGgVDDKU94eI5Ltgg8O0tHK5PMLG6BZTgqVzqt255?=
 =?iso-8859-1?Q?Iqn6ON3Ah2MGXVGqWXXfpALfe1jahN6hBS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8714.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20d1920-37a5-432b-ab3d-08db99c9e9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 17:47:49.0600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aEAxIDPyonWoTGAQfFR8F3yGvvskH/YYw1nSKufV1zbJP8MPuLQTRWG0xFDOCpSdNe1LDX81kHp5qgxGCegNBeI82UBlinHwViuEYoAF++Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Conor,

On Thu, Aug 10, 2023 at 11:03:27PM +0800, Rohan G Thomas wrote:
> > Add dt-bindings for the number of tx queues with coe support. Some
> > dwmac IPs support tx queues only for few initial tx queues, starting
> > from tx queue 0.
> >
> > Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> > ---
> >  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index ddf9522a5dc2..ad26a32e0557 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -313,6 +313,9 @@ properties:
> >        snps,tx-queues-to-use:
> >          $ref: /schemas/types.yaml#/definitions/uint32
> >          description: number of TX queues to be used in the driver
> > +      snps,tx-queues-with-coe:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: number of TX queues support TX checksum
> > + offloading
>=20
> Either you omitted a "ing" or a whole word from this description.

Thanks for pointing this out. Will fix it in the next=A0version as below,
description: number of TX queues that supports TX checksum offloading
>=20
> >        snps,tx-sched-wrr:
> >          type: boolean
> >          description: Weighted Round Robin
> > --
> > 2.26.2
> >

Best Regards,
Rohan
