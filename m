Return-Path: <linux-kernel+bounces-29170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC78309FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37473286376
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8121A16;
	Wed, 17 Jan 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VJ9tAyNx"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A421A06;
	Wed, 17 Jan 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506380; cv=fail; b=ov3/j/VI1bA/ioUmtmygpK/WjCIkdRyOxoUuq2dnNQsNI9QEWqLmtIlV9en1od2LtN+qEN1i+mGS+qZvzead9hvIoW9rn2yQkX9atrOTYaD1E3k2j3KPQ7BaRvqiMSEtjM7ilwbV9WNdcTcrDRYvTQBynWZOK11TYkdXSi8SF60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506380; c=relaxed/simple;
	bh=grXRl379SJehrTOAEUgpG6bChQewO/hG6N/WBHND/8M=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=fsnd9LjN6wm+pugSi1cON03EokDnALo1wUctZgaTEk0p/ND5miGt0KLO0NSs5pEYUfnC4md2LxB/mmL4XCbrRjXSCllP111OmtSv8zdaWiCWYROsRO5lOB666uSRxNL2HYZy+bSgZHaM9c7woPWTOpDNigY7OUkdgcSZeTY69P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VJ9tAyNx; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAqpmyhRibifw+gTQsh9pXYYyM5MDMQkQ3yBfzpatdtQklM/J226AKxxLMWXvM///9W7i7tcytJo7dPduR9XkxlL+jtZ06dnbF0ZK09bdJ02VIm8WBmzapkhvT6v0jRMy8e62wj5uQilDfqFfnKeawsEDYwwvSG5nIbCoQe7yVIu5o1iL5XntHp8wDKrPAa54vBgajP5/pEElH7Czy3QkuFkJa83TI/UQFXbZINV0Sej5hA0KAuOCnnLg28eyfePWXDPbWN/Z4TxKqROkJpX8nvbzco/348dFkwxdPYJ372ZB6XiCAdsizR6NfDH58U7vxLVTlqH2lj8CVtrIysBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4Svi5P+z+IbrTm9D+9sExcWxUeHo6iA6Fs+IFcELBw=;
 b=CAbJFD874jqLUKL9+UshSQXi69U9obSNmJ9NLVeyfgNodmNCwcHPmuUZWk0TPB5JuBIq0fGOydzQkV8043BXn0tssp1n3ROLi5a0QvPTsUVki6D+LQPs18iTFhWipClq+T7c3K5sTWYg36M0AisLyLvmFLrsmJ0Ot3yPdL84+iJeCEo1hd6bnOcplUv25PJwFRphF08HSXQXft8o1WXOj5AxGRxZWvAVMJ6htmGsOXjJjm3mdRJZY+rKoszNLGUi9x9uGQXJDmxsjzcC4mMrmY0x19U1NW5cCIzfQzneYbIPE9sx0nfuFI1O8ts2I1DNskiUlIdGx5uhX1HffrOwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4Svi5P+z+IbrTm9D+9sExcWxUeHo6iA6Fs+IFcELBw=;
 b=VJ9tAyNxaNw4pls6/nD9b/9jo1aDdzoabI+66WKABILfumeBGp8SDROWdByTvwuLtyJ7zkN6Ao/iPV7cenbdYj5kOjDfqYo69IgC9llymm0xmztNFaANNgw/QH7H3aEMTR2mr5T57TYcc9aEK83adb2tY0f9KRjz7AebUpMNAOXzQ6NkdhNhliLVshW6XZgOXmHRBRw6fjzfzxsP4tjWlBT4J4O3jIf3/sj8WvWtHD2iJoHcm9G+3bc47KJQ6eOlTwDoUq7mPdqbMXojkIm1LGN2XSGerEI+26eDRSlmjMT6nc4Fgwq9YU82YATEf6ngZRpwSTg+SdDbqRfufhOI7g==
Received: from IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 15:46:13 +0000
Received: from IA0PR12MB8906.namprd12.prod.outlook.com
 ([fe80::c1b:dfd5:17ba:bde9]) by IA0PR12MB8906.namprd12.prod.outlook.com
 ([fe80::c1b:dfd5:17ba:bde9%7]) with mapi id 15.20.7181.020; Wed, 17 Jan 2024
 15:46:13 +0000
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: Rob Herring <robh@kernel.org>
CC: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jonathan Hunter
	<jonathanh@nvidia.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Kartik Rajput
	<kkartik@nvidia.com>, "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	Sandipan Patra <spatra@nvidia.com>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: tegra: pmc: Update scratch as an
 optional aperture
Thread-Topic: [PATCH 2/3] dt-bindings: tegra: pmc: Update scratch as an
 optional aperture
Thread-Index: AQHaQHVXi8lSHewdikO4T3WqC1nA87DQWU+AgA3dKoA=
Date: Wed, 17 Jan 2024 15:46:13 +0000
Message-ID:
 <IA0PR12MB8906AD9357DBB41BEDC08FA5B5722@IA0PR12MB8906.namprd12.prod.outlook.com>
References: <20240106075134.3933491-1-petlozup@nvidia.com>
 <20240106075134.3933491-2-petlozup@nvidia.com>
 <20240108195857.GA1959040-robh@kernel.org>
In-Reply-To: <20240108195857.GA1959040-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8906:EE_|SA1PR12MB7198:EE_
x-ms-office365-filtering-correlation-id: 40fa9d2a-5c7b-4465-a9e4-08dc17736f6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GRfcCUfLBQXvKOvkd/NKQo6uTKAHkKaj/KL0bfbH5PGhKIyDg2O3hlQaChJ72nYMumlepHCuWuhshGY+av8ZQaB2/z0gAqhCLTX32BhFIABNrXBkYXQ3DD04eUxy44b7SfXkfwKoevpujPnRqPy64mZUmLvYoDvAAf6dBS9eAAjL4AMYCN0CK1gnF6oOTfI1yGTCY4HrvOdNa70434sIVZNeM1XnyZlmlx7v/kxChK5MooBgOvLblIgTg2cR4Ga4UobIazqlRBcRGzD6xmcbA7AfJPRVAJTRk8ZkzlEt9G9lI4ceUL7cTrreZxiyUmnj1F1/WqdaPAVSEOiGNoWKf8Y64U4QzkiO9X/cfkVGWof9NcwDi9ojWa8FV7YfhfoGRsPJd7kCn4beFpeUzoz3rklD/+OJJej9gucH+6y7+igbnUVa1akXEEv2m0BS0aKDEFu1PHmEVi/m0C6iEngEVJEc2qmpTiUTbyIqikdVZNzksyxcAyej15ghXgratiA7QkBdVjN1/DIzP5jzrm2bdOMzlaUlW+pdX8YVVEE0mNv+PjYc00byZ7gUNJPZghwIqgOojSXRAEjJ6pQZpWXLi2wDQC3kBCKDh6c4ps8Rpb+dtLfb+LElS87wK4ZGZa/y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8906.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(9686003)(26005)(122000001)(52536014)(7696005)(6506007)(38100700002)(83380400001)(55016003)(71200400001)(66556008)(76116006)(66946007)(478600001)(66446008)(86362001)(6916009)(64756008)(54906003)(316002)(8676002)(8936002)(4326008)(66476007)(38070700009)(41300700001)(33656002)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EqfdjmWEWVPDRTeaPdxyRW6xoa9LnAvke/D27i7WJt67ny1Wt7xBVj+RyDUr?=
 =?us-ascii?Q?LCNIoLsPMkB4GjBKnc9vQfFqEI33QjpB3W1Ocj8pqqT6aHCq6zJoAYG2k5kk?=
 =?us-ascii?Q?H3zg7oScLb94WCmjkI+C56itd8mnegpbNzxgOIHp+FAwbT6jjBdh80DQM9e/?=
 =?us-ascii?Q?Zrxpw3PJ5KFT3xMZENpU4mvsNgRhh1stEtRp3N1b5ueZ/+bZZtanlm8Uz/QH?=
 =?us-ascii?Q?B/GBuhSc9JxTLcxHLc3oM1LQol64LBmy2N7u1WCOgTSagPW/Gj16p6K8FRd6?=
 =?us-ascii?Q?BIeZUzVfmWYtWwGR+/jCoeJMnGQzoZalBQnVpucztDiUQrQA8Zr4Y10VKafr?=
 =?us-ascii?Q?uWtxypKnzlzAmWxGstGtj8A+f+YvTcdj5P3cBk5FnP1vySUbLb0RcnlemDsT?=
 =?us-ascii?Q?+5DVRwX8JCuV5Un4WqMxX8i+qt4eJjJb2CbyvyP3cY9KFvmdFiymSTSqAFZ7?=
 =?us-ascii?Q?Sj+cRsrCyfgNqg3d9NknL8DyTKEhXPkzkx+vgo1zNE5FN3gZORSrkg9s5ffd?=
 =?us-ascii?Q?gdC1XI2cueZSFmt8CAzQBg67SSQ1XMDdliX+Zzz7XJmK6NM2vbzAO+bCs7Jc?=
 =?us-ascii?Q?SCvhw8azGkt0buRr2LmdNVy3Wk00YnDx4GZMOKx5x1l3Gd4tjV3g5dAbToFl?=
 =?us-ascii?Q?YRfkbsAobRzXYa5IEoDlhKHkJXU3p2ujHqetZLhZgaL+0LeBIFZ1n5ftxc0g?=
 =?us-ascii?Q?EKzONcQNTF+n/EuIgaLXRZR1jsrbvj375u8wxzAhOBi9Raxwfzc+hD8p4UOQ?=
 =?us-ascii?Q?SlgQEwR1e+f4hIyTQuZXTd3Mgls672GROVEVGQ5bKAdttDzSN7/EflTA2vZi?=
 =?us-ascii?Q?YN4A6sNMbilbY36mxUiMkOhfzSim/gc8f3qVotz7R0ocNxhsJfkIXsm2N7aV?=
 =?us-ascii?Q?xNKvFh8BquJOTVTFyecdrKAUSg90cQaEt0lBtRD8nK4kBLlCsK9xvuLG6yC9?=
 =?us-ascii?Q?h0hILCW28/GUGIin77q/GYPepOI1c0roYHBdjRI1Zuas3AOxEoRkwS2YE+s5?=
 =?us-ascii?Q?rGSEYJZhjK59HhUST1buGGTmAHqeuLVlSqSIy/pO8VNNylVFrH2l27T/RZ7j?=
 =?us-ascii?Q?PWKrNCELl7BmqXJhmWzRKwAbcR+26PBMBDUpy9pWPx0//FOT84bYOELmwGKh?=
 =?us-ascii?Q?0tIEaULMH+7w0PeKNS0KRqR5M5NMM+tk6XRuedozYNs8chJCosg8DCBLfeVR?=
 =?us-ascii?Q?6o1xitHsUdoNfAafZie7SBj4q0nWxmEt1Dy2DpfsEBsUhRIOjCqOWhT25jze?=
 =?us-ascii?Q?pWo8KYTgz8rYvICH7LspWF03Qt8zqhhWzYWkcw6zAtgXtp7EcuKFp0BP/UqM?=
 =?us-ascii?Q?GnGvfAgZHVzX4GdODBSNGWQ1GVvS1MMmcYR1rXJiA+7QcBdj5rTh7ar0oPFl?=
 =?us-ascii?Q?wbCwhd6+KGNSfBUyyHgOpFuxqTpk24//Xip4Vr2rS9T1hcfKCkjax0fxzt09?=
 =?us-ascii?Q?zQydvjSLgL2WLgWqNzMYs2xd7yqdzuuWMFqV7e9xGNmES2Oq/zGshovXYyyb?=
 =?us-ascii?Q?f9ZBjEBlTFEvFT58otw9n8xXDD6LZIM2BSLxMlJOCwbEmHeHI5+R4qExhdmy?=
 =?us-ascii?Q?1n09D6+xCznERFO/HE1UHJhhq3khFN3meFzBexx7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8906.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fa9d2a-5c7b-4465-a9e4-08dc17736f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 15:46:13.7683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXlD5+lz1zI/uCgnOlEN1qtPeiLb4pjPjTXu0FInS8IlMJQdgrsBCa0R87SGFEQvd2vkVsZBnPZH7mzJ6JwWpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

> On Sat, Jan 06, 2024 at 07:51:33AM +0000, Petlozu Pravareshwar wrote:
> > Scratch address space register is used to store reboot reason. For
> > some Tegra234 systems, the scratch space is not available to store the
> > reboot reason. This is because scratch region on these systems is not
> > accessible by the kernel as restricted by the Hypervisor.
> > Such systems would delist scratch aperture from PMC DT node.
> >
> > Accordingly, this change makes "scratch" as an optional aperture for
> > Tegra234 in PMC dt-binding document.
> >
> > Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> > ---
> >  .../arm/tegra/nvidia,tegra186-pmc.yaml        | 83 +++++++++++++------
> >  1 file changed, 58 insertions(+), 25 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-
> pmc.yaml
> > b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-
> pmc.yaml
> > index 0faa403f68c8..2716610a1a02 100644
> > ---
> > a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-
> pmc.yaml
> > +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-
> pmc.
> > +++ yaml
> > @@ -23,12 +23,7 @@ properties:
> >
> >    reg-names:
> >      minItems: 4
> > -    items:
> > -      - const: pmc
> > -      - const: wake
> > -      - const: aotag
> > -      - const: scratch
> > -      - const: misc
> > +    maxItems: 5
>=20
> You can just make the 4th entry: enum: [ scratch, misc ]

Agree. I would address this in the next patch.
Thanks.

>=20
> >
> >    interrupt-controller: true
> >
> > @@ -41,25 +36,63 @@ properties:
> >      description: If present, inverts the PMU interrupt signal.
> >      $ref: /schemas/types.yaml#/definitions/flag
> >
> > -if:
> > -  properties:
> > -    compatible:
> > -      contains:
> > -        const: nvidia,tegra186-pmc
> > -then:
> > -  properties:
> > -    reg:
> > -      maxItems: 4
> > -
> > -    reg-names:
> > -      maxItems: 4
> > -else:
> > -  properties:
> > -    reg:
> > -      minItems: 5
> > -
> > -    reg-names:
> > -      minItems: 5
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: nvidia,tegra186-pmc
> > +    then:
> > +      properties:
> > +        reg:
> > +          maxItems: 4
> > +        reg-names:
> > +          items:
> > +            - const: pmc
> > +            - const: wake
> > +            - const: aotag
> > +            - const: scratch
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: nvidia,tegra194-pmc
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 5
> > +        reg-names:
> > +          items:
> > +            - const: pmc
> > +            - const: wake
> > +            - const: aotag
> > +            - const: scratch
> > +            - const: misc
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: nvidia,tegra234-pmc
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 4
> > +          maxItems: 5
> > +        reg-names:
> > +          anyOf:
> > +           - items:
> > +               - const: pmc
> > +               - const: wake
> > +               - const: aotag
> > +               - const: misc
> > +           - items:
> > +               - const: pmc
> > +               - const: wake
> > +               - const: aotag
> > +               - const: scratch
> > +               - const: misc
> >
> >  patternProperties:
> >    "^[a-z0-9]+-[a-z0-9]+$":
> > --
> > 2.17.1
> >

