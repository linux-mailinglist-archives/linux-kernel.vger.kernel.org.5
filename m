Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58AC7BFEA5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjJJOBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjJJOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:01:33 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCC499;
        Tue, 10 Oct 2023 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696946490; x=1728482490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JtmNuQpgK0DWYEL3EhBAbmO9v+zu3Q/+fkZo3TwGCfc=;
  b=IeWG9tDQnjESSET9+/ZGvzu0dIjZphJsjQuEGbGmPS43q7XMhNFDbLwT
   duOrEB5Fc2Yz1Hx5+1wqlqIt+Lx09kHug+3kck21ImlcEPexCLFO9yB1S
   u+Ro8TC3K4ImUcuQgyQzu9LGEu/o/HCa6s/ue7/o5IPd+uFiv8uqE+lVe
   Ay24K6u37iwhz6F8vLtvKkktKnJ8fxHXrNyHzicGIJF8+h/0+yan0oO9k
   q/FrCQYT6wpWydKVVIWJO9r+jGwMEb1JhXKLyzbgV64QLysEmEd3GLpcQ
   o2i5f3qy/kANnq/fiZBM1nTrCqj1UZdzCs1W0VMmKTDSaR/GnCxsXqqvm
   Q==;
X-CSE-ConnectionGUID: zhb0EemwSsq3oPmTqF/Vvg==
X-CSE-MsgGUID: lCNvyYD9RB22LDQOwgmSYg==
X-IronPort-AV: E=Sophos;i="6.03,212,1694707200"; 
   d="scan'208";a="358273348"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2023 22:01:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvHRXKUJx80zgPu9KwoXkSCRiM01FcvI+lTNfZFh+dFZfd3oCys6ibnkDlSuKgQnAd0bQbpIl8ybx/twbx+0dx5yf7OlTutN7/qoVZyuTFmC4roHZ0JZPpiKlEc/DuV5K2uHYsdcndmgs0XCMSJDVA5Wp939X/bpH+DN67qut8I1u7DT5s9n0j7Qj9zCMawT2FLMXulSOZTozdOrASqJcsIXPoL3P3I+xQHDcTCAWERidzV7szaLuA29cOnRK9INdVw7cvMATOYiMTnm4ixijQU/x3zvZr3gMhaARamRUvtYataBZnq3TzuV6O12bnVDRE13WNN/OFo6Dx8jK41Byw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBwENy1GAEtUexf3abBwML/LXccLbuN1kClWLVTMzJ8=;
 b=mO9ONwZvpCTpmeLYXPGLlP1jJaN8kguipccorzV8X5IkaUlGZPCqLlxyRQExOfpQ9QVMTJLjPIEc2qLYKWTfIKyiHLk9RsAKVomG7f1zyWDT8WlW+pqy2tCuTemj7D3a3Uim/Yc5A6n8gkhPdOQ3lo4JXtYahWQz+LS3qKLIO+qv2HI+qKXozVFNo9L10zNrrXxPM6fi9XNWqBPt/yXf0Xi1lyJDZzxtcgJHwneshREoQwWQtisnv31k33PrUhRPBmw+uoowok1y0kLLvEbGACuhQc6j1hWdBxTNI/xmSxsS7OKgeQNV87ic2itKwD31jYapaed5hV8lvwVKQjhqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBwENy1GAEtUexf3abBwML/LXccLbuN1kClWLVTMzJ8=;
 b=H7E6xjtmu67+nXmLk+3BGhXNK4VJMQ4qwu619LkQ3IJEcbbfeDEr2rdJrlPzyBj4KiRrh3KHuEQsjTECX7vyaS0wCSJY1i+nDZ0h1sUdU3Q3DE1VlsXglcSd7kprE0bQ+4rDZ78KhbTPNjEHvIzjh3V+Owt9ATndh5dOVazn2oo=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6945.namprd04.prod.outlook.com (2603:10b6:a03:22c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 14:01:27 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:01:27 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Ma Ke <make_ruc2021@163.com>
CC:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ata: sata_mv: aspeed: fix value check in
 mv_platform_probe()
Thread-Topic: [PATCH v3] ata: sata_mv: aspeed: fix value check in
 mv_platform_probe()
Thread-Index: AQHZ+4JDiYrIXbxR9Uql7BwJKWL5mA==
Date:   Tue, 10 Oct 2023 14:01:27 +0000
Message-ID: <ZSVZNlQMFa7hjtNJ@x1-carbon>
References: <20231010122916.4080132-1-make_ruc2021@163.com>
In-Reply-To: <20231010122916.4080132-1-make_ruc2021@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6945:EE_
x-ms-office365-filtering-correlation-id: 278362f2-44fe-4a71-6939-08dbc99965bb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qR+r7YLhNtVFNIAu7Ah1OXl20/EVO263P32MpF/5S22DCCu0OXhrcHlkfzxJaaxRxrWeqhTyFe359zYji0zIBOzuI0kDqlLxGYIw5oBuwKS1HLKa40igGoVvzptBVH2jaB9193c2yc/v654KJRUCGcIrQSAd6JEJH0i1ar0x+ZU2voSkddtdyaR8WgCgC/0BoT2HyyzvxhAEEMD4YUU0ZWtymNf5ZnDGiPTOfPCFmvalPoMBLFKWgImxT71baL11VtdVsFFa3SZBD1PbIvIserujulGhqPqzdqkAAJj+/oAF85nI1leBfLDVe2ScTXRCt2qp/ArXHQhz3tI6ehau4KiaonB9J66kbB0kq2aWl+TcA3KSXM2rGeaJNZoQTIGbyJMx04MNb1XJBn7v3t53HT2tW8UzH4AvIvdnJw3df/4oDgD8ua0wYs+ylJ0jggQYKTNWVYOPeVNGp0/5tOAgprIrKejAzilQXzkxN6RtePlvcqQ000XPrQGFDSIaEHbrjEcspLcJGPlWcvDlxxqh+KIaX3uYSa+SR68tRDumoKmYkNf2bcuBY+ogHREOGMkIeuF4h0EBEUGPaRKPK8ldCIslyyuO5F1NaF+sY5OONHhUlJDhpvklU5bidCdkCHCZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(76116006)(83380400001)(316002)(26005)(64756008)(66556008)(66476007)(6916009)(66946007)(66446008)(91956017)(54906003)(4326008)(5660300002)(41300700001)(71200400001)(6506007)(6512007)(9686003)(478600001)(8936002)(6486002)(8676002)(38100700002)(86362001)(82960400001)(33716001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7RZk+Ux/yy9a9sO77NZ68gpGGXDs5BrPJ9PpWsBPd/wMTr0yWgyUjQfMQiSj?=
 =?us-ascii?Q?BVXdgZo1M51ivAlq+IqmvJbnjjQNHGBJRQELuPxcAEXFQRF8KAYnQIvy3t41?=
 =?us-ascii?Q?zDT4jVoqmWhbMtsBi7sliFVCA9LH6yZMa0OLw2mxJt0wP32rH5x2iKsb9Dqo?=
 =?us-ascii?Q?5Nvaim+PEFNUAyOko8XyLB9KanbqaB49q3fmPam4iEHB/gJtR90Pex/NRJeO?=
 =?us-ascii?Q?gwH4AF3saeNwpPK3JMJVE7HfWoVUGcSwtbiPIYalZKOVlKmA929nOz3de0t8?=
 =?us-ascii?Q?+ou8YwDEUwATqfhqB1XMPtotqoKU0J9vMslFZxReJ8mCOGoewWKPSNrZe62u?=
 =?us-ascii?Q?DRCs47X/wLkR0xOZZrmCkZY+ZQHo8RJYJUwRXphIeUx2NVAFyvpm0NgHJhBY?=
 =?us-ascii?Q?EQksWbUrJ24PcxkLNm46IN1VeydJ2zZKlnr4PlR8aNEE9/jh0LpbpQppcamn?=
 =?us-ascii?Q?Iepo+/ZokfR5NHPzVjiGR+ka+JXhz6pW9TdaQsrhTWo2wxIoNToMUOlxLc/1?=
 =?us-ascii?Q?ZXHsoxhmEiqG29SKHQIU+NpLt9MBZH6Tns6h+pmxINO7UldYOrH6PgzZY2Dj?=
 =?us-ascii?Q?+vlzUnx0KsbZ2Vz8XoumPJKgmLrw4ydBn+7youWT0ECs0HsVGol5ONbbHkN4?=
 =?us-ascii?Q?MX5ngmE4LEBTm4n7bWRwg2V7o2wBZxeQNMR5RP15Ielw/VjHXpTlRQnelJ+m?=
 =?us-ascii?Q?7QAKJlzAMjlJOjy0uHDG1G4/V3OPXtY47TwuJcYdnKmLgW4VisdVCBWIj+/4?=
 =?us-ascii?Q?OIDk0coYl/cy7rqR9wPwS2HJ2zPoK43dYKsEaqGjlLTodDJE+LW5cz+D+JW1?=
 =?us-ascii?Q?Ipsnq8/tBWFXi0TOYbdTaLd+F7/eOZd9VYuDSUNNu7yNTHkScPicGbQwQqNd?=
 =?us-ascii?Q?rjBQJuzzolLdN0Y3Sg8iqbNuQN2UE0VMkNqQErHLOu0Tzs1DxYOUhRKTZhyi?=
 =?us-ascii?Q?O7nRIjpW1zWdwy3cBSrOJPyDVRlB2GEfPDqo4Voc/vha4UNif47QI1g6oWvU?=
 =?us-ascii?Q?k2Ync7yDLB7gRgEYHsFnBKSuI/izgJyokP54Xug6Fbx4hSGTSKcX1hLvBNSI?=
 =?us-ascii?Q?yYAjsJHBpzXJNykVDnAVDmebPhEfL5ZbU3XO4DJ9jDtVp+nGU0Lasc5I7mOA?=
 =?us-ascii?Q?82dg3B9v3s/UeP3f+CLRLoGNOLTTSeOYPMNwLzhpJCaUCxma3s66ZnFFfO6p?=
 =?us-ascii?Q?mhnUAGJw4B07vkJAXKCqW5/KWk2SWdmq3M9JCXvgPVoiV1zqq8SiNDxUGL/R?=
 =?us-ascii?Q?dI06fyJWn9oPMyo3PFBW/Wti9JsQI89qNfLqaNikzENcW2T1wJ23Al6x7zFR?=
 =?us-ascii?Q?tOUHVyYH8u8rN2ZcifPjtc/42K01oFUXjIAl4X/bzOC0oiBCIUSSW4kkAhHs?=
 =?us-ascii?Q?npFmMlr9URUPRth+BuCKDJ0mFimh//OmozsdfL+0+cAQ8dI/Jx8MnEFhXIGv?=
 =?us-ascii?Q?LFGCd8oR5YMuCRL+B6ycbx5+E65oRHGBomujouPpjoGuovMlIcw2TMzYsFaz?=
 =?us-ascii?Q?dDkCsKhpiM/JX+jYiOHdh8sgIm3czlu4Qu6miFiwFLyqQGd1rZnhwh26g6iQ?=
 =?us-ascii?Q?55+z2hmtc6JQQXk+jIstTLQA2tHrzwa0DFQnOxlANEbXBfgJo7/ik3YTpsBY?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F66A34522DC8094AAF83835BED4EB223@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yxYA6hXmEhgLpw3w5qIEffhEA5Eg00kZVb8yGxdjG+BxFJRYsbeELsY0BHFY0NpZANwM5sqf5LF+MXLxrf8/WnmkAQ4cmXlkLIRGR75WcB6R3Q6ZbT1C6V/kesVZajbOL3poivaiET9WhL81aIf5QlVw/ep94rGdqPVHFGLGMdRcLym1fGdy8Z7uFFtB0M0WmqudfL9GLeWxacI12wfW+ogml1qfRJ9dYtBPQS0ABznOQNVxuw6YHEzsSuJl0JAxivZrwhxZu0dLqUhwOiyn+yQ9AoXmAW9mF8qvrdJHgsP9Pq2abgMdTEPCrjO7CTAUZvXmu5Qu7rtpN8zg8ouR0MaoFX6Vi46/LLEP12pZcKTw/UIJQFBw+xyzyDoDje/ohLraZ27PwOip7cDDC8D8ozdKN6NTZx51SOMhbl0/ApRXqAc6NsUePROcuJHv1xfw/JKDL8GGW0ub/zSopyBea+d9HBjn4lY4KcT9SGzpBLI6710KMrXPT7CtjaX8uj0y6u0xGf9O7B8nmk/wlxFR+cRaqhlFFFjxJJVeIN+bNIhrOz08Smv9wEqPnC9r1i2qRfD8Se/3VVW1kJuf0aU4+q1AoVVBlMXTozH/Mv4eJOuY2oRq/ttvSz6Bfd4oyEIcdjX54NRoEUSb7V9wMJNFTQ9kDm81ePkZTvHYs2MtlBzqkqhMrE6BrIC5yzTJMmAAYP0Myi2GxYXoHpzIYFvh92xGi6brewCVv7gofYa5lt1D2MBNo0CP33aydM0LYPNwqSnPQK9hzvZxuYJVbFKeAezhde9qpYBl7TXS9T70P/faTyMhPR1gpDtOxsL6GU/HVwLDciTsxAHk/c07Lw7rzg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278362f2-44fe-4a71-6939-08dbc99965bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 14:01:27.6987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJhOhtdtknr4vpFeQ6eoPQQhaFw13A4c5Gck3ZDZjpmPMo+u+nrAL8iCVoW1Z7BZdyP9MPA2JWgPhQB1zMGYdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6945
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:29:16PM +0800, Ma Ke wrote:
> In mv_platform_probe(), check the return value of clk_prepare_enable()
> and return the error code if clk_prepare_enable() returns an
> unexpected value.
>=20
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/ata/sata_mv.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 45e48d653c60..e82786c63fbd 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4123,10 +4123,13 @@ static int mv_platform_probe(struct platform_devi=
ce *pdev)
>  	hpriv->base -=3D SATAHC0_REG_BASE;
> =20
>  	hpriv->clk =3D clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(hpriv->clk))
> +	if (IS_ERR(hpriv->clk)) {
>  		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
> -	else
> -		clk_prepare_enable(hpriv->clk);
> +	} else {
> +		rc =3D clk_prepare_enable(hpriv->clk);
> +		if (rc)
> +			goto err;
> +	}
> =20
>  	for (port =3D 0; port < n_ports; port++) {
>  		char port_number[16];
> --=20
> 2.37.2
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>

Nit:
Instead of:
ata: sata_mv: aspeed: fix value check in mv_platform_probe()
something like:
ata: sata_mv: aspeed: check clk_prepare_enable() return code

Might be slightly more descriptive.

Will leave it up to the maintainer though.


Kind regards,
Niklas=
