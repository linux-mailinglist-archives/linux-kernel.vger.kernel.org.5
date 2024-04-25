Return-Path: <linux-kernel+bounces-158256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12A28B1D93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E3F1F22061
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A50E85269;
	Thu, 25 Apr 2024 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="RGQLDUJs"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197B83CA1;
	Thu, 25 Apr 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036557; cv=fail; b=e8JLrD0ntiYLgNqHgCRK8CL3LqbdSr4CuglmIivalkAZb0umEE1qyN+eseJiQ1geBPkC4nYDs2ouFpQZGnn3Ix5cE14UNtwx4SP2Kmhehz4HtVKHlKmYl6EqZrc4poG4XnbEAnwfsE6IeprrVgw5olGY9ffkF/WelVkXvHmjhb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036557; c=relaxed/simple;
	bh=otmeC8jNafY2a53LwD5fZGOGAbu254cR10zN1XIA1Wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BihWE5Wg9NuDU56QsKp5JUo99WM9ILvQ9sS2TcSw40ItDFntGTovoexpadQ70yVz9RuDqpBoDLFaEtX3+Ny1FOpncS8vo3XzsiEBowO270E2j89ku5XsV97oT3iu0mjtcXfTP1kzUUkIxEzECuM4Ok74VV2Fj52mvLuMPxtTU/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=RGQLDUJs; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9FHIR011746;
	Thu, 25 Apr 2024 10:15:18 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011007.outbound.protection.outlook.com [40.93.132.7])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xnxsfs3k5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:15:18 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqwKEqkEIVoIiVkXheU9v0PeFZFb4amAx4cEOH8rIu9q52LbfigPS8mQIQNzasFJkWFTMouHHguSb7kOrkyevb/s1pSWL46/BI+j57tX6egArRsJiLZqy08UQJruC5zcSVsfxv0SkJBxFJfGKwxMAG25+aRU+xVr+vFAsiMhTzK1eeCeWgUPDxAyxLk/8kFPPi++2uZhgad69VL50Lhfe+bc0XFowNFR9Yd3amNvQLzRzle+l/JRVj6LXnBQNo4OorC6wWPFxGfXJzXG7OoG/3BuETzLytod+tmsQKx8AYzEKYz1bs4rBMAi8bqHthXeUXdJQtNj27PsYHs9FhGyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E//GxHF8CuON8Ap8NdTk+Gsl36aGz+QEVeS+5zOVUQM=;
 b=kj1YnE4fcxVw+5ED4jxBFiT0GHaxbsEQd3j2AUAVqXRP3X8sv/IIz4ichfU0qzBzLksU0Gb39oIVUcpmJNqhCUI+Eu3Alp34XDetPmRLSlWLeQ0USJBlAB2d+nn2HQ+Rf8KdrQWiRlRVFynKTpIu2RHVkuKkVQ7slOVPdYETn+vSoqfEBq2Ftxf/I3LakQtxwJ5OLmOgGV2kyKpC2vP7T+bElk7DxBsMulsxzRSMc/TY62NycLoR4kO8Ctw6iMQFRmN88SDjO5OfEhr+mVjIpB6gGm+MH4yQIiH1tLvKRKxJ0Fm0L6U4/GcQ29Prlf0C8/Ofr4Uj8UaOo+Kn7WXbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E//GxHF8CuON8Ap8NdTk+Gsl36aGz+QEVeS+5zOVUQM=;
 b=RGQLDUJs4N1CGTyzh/W6oGbh4aBgjzeGIbEND0KIHWjZ5lYsviDKSX/6QAXZvyQOAARgvFnUK6NpChtwXOB92gDjfz5Ofba3+9KMzG3f3sIoWnTEy+vdyMKkV4yUWwGgI1TwAAdgKFFn5kfRO3shWCshWgAuJhWQ9aMJS1q6+zw=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB9905.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 09:15:04 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 09:15:04 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "olof@lixom.net" <olof@lixom.net>,
        Niko Pasaloukos
	<nikolaos.pasaloukos@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Matt
 Redfearn <matthew.redfearn@blaize.com>,
        James Cowgill
	<james.cowgill@blaize.com>,
        "heiko.stuebner@cherry.de"
	<heiko.stuebner@cherry.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
        "sre@kernel.org"
	<sre@kernel.org>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "rafal@milecki.pl"
	<rafal@milecki.pl>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org"
	<konrad.dybcio@linaro.org>,
        "geert+renesas@glider.be"
	<geert+renesas@glider.be>,
        "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>,
        "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>,
        "nfraprado@collabora.com"
	<nfraprado@collabora.com>,
        "u-kumar1@ti.com" <u-kumar1@ti.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/5] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Thread-Topic: [PATCH v3 2/5] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Thread-Index: AQHalvEO42bqaUXUz0uYtplzKtu8VA==
Date: Thu, 25 Apr 2024 09:15:04 +0000
Message-ID: <20240425091403.17483-3-nikolaos.pasaloukos@blaize.com>
References: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB9905:EE_
x-ms-office365-filtering-correlation-id: 75d519ff-1813-4298-d989-08dc6508315f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?tn0DxFPuiC0VW9b6r04eGQVYJs0P0sUodwFzeBrFLtFkhm2+wRNClA9M2r?=
 =?iso-8859-1?Q?g6ZjmulhwdnLvRJv8KzlUm0g0OQpwEn21ebF4XCtp8xLb7cUiJ6iW/ay9M?=
 =?iso-8859-1?Q?DAIi7lnoR/1ZdkfmkUwTasFdb/vR0c3q+Ia9t2lNWV5FmcX2RJyGO6I2wP?=
 =?iso-8859-1?Q?mhWDbvyADiYg4PBvIalz+OBi9bKAFwKSRYsm66s4We3BR2OBVht/42ZH66?=
 =?iso-8859-1?Q?2KKmNehcLW8AJ+39aufFzAGRsds3f8Vrfwb9wB/IgsnsxwVI9/YwIGW/DK?=
 =?iso-8859-1?Q?pN3l5Hjff+HameE/Deot6XatfN6GyOWsoFpnq33dJIsam/gLNhaXtmVOy1?=
 =?iso-8859-1?Q?22mBtDu3G3Oe6UqCUpT10NtekhLCpuH/PUG8RKVpg5t88tHGjdPgnNSPHZ?=
 =?iso-8859-1?Q?29DwRUiyG3cVw2fnjYc/r2p+ywwLNmf+dlwWu2x0PFCdUllBxDCoH933gt?=
 =?iso-8859-1?Q?NH1KvQNUDZbo7jeMfDl2Cm7iotS33JyVBQv/h3BrA76M8Sz6S5zJLkQUTx?=
 =?iso-8859-1?Q?l/IAI3GX+EFWsEj9uPSbh8y9L/OlJkvb7GdWknKFzX7eydXLlc9mq6h2zz?=
 =?iso-8859-1?Q?v6/izVuRX/ETSvaz2+SKAFUunbSHrdhcb5x1pGBJs7hRofNvLerhEXwp3f?=
 =?iso-8859-1?Q?jwJRoH2mIzquvpEoO2Zy+YFrfgVamhDp8+6vi+XvL5o1RADx3SPch9Wrug?=
 =?iso-8859-1?Q?Sf13rYml/+CM2rp6HLwQWUf89pJ64rznhyOF69bHhwBe/L+BqkY0sxFzzy?=
 =?iso-8859-1?Q?HxVR8+9P4OJ4G/sPzOVrVVxedyQZ/2f5gVI4kuOLQClzCdQa86CcLN+vip?=
 =?iso-8859-1?Q?oXPQ6KX/pQce+bnoTp8DGEapqnZ8qb6dVSpecUP6mOkbnDSvO88EpVM2Ip?=
 =?iso-8859-1?Q?BCxNk/tnXKpTEOf6ITiSSSmeg2XWgJWrA5On1imN2CjJ0K4SHfL2f9NLYo?=
 =?iso-8859-1?Q?50kBtq0mkbmgYXyU3yM4iJtIdq1lCq8j/bZOOj5ZfDHsbZZfssIovNdJ/k?=
 =?iso-8859-1?Q?OhQ6Ev3dkd5zQcJ/GHyRhmQK4fAjVo09N15WEU73z892j0+7vq8f8D7HXK?=
 =?iso-8859-1?Q?H4f140r5C8lXHhRgb17TN3ZJdAianZLXySrdkGCvaTBHt62/inmQzGdAqi?=
 =?iso-8859-1?Q?Z8hC96yCm+4PQThpPM5SzxEKaB6HgxkkDJltc5aw+F7wAm0R5MdYDbTOuu?=
 =?iso-8859-1?Q?548k6QD/0b8fRXoyPB7+7+eaDznVBFfES83NrGsm3kzRd/hG8irVPFwiSg?=
 =?iso-8859-1?Q?QJLvM9jGc6eqhhXdipXZHCQoxvGntmJJLdUlui6leATQUdauouuuNSrjbM?=
 =?iso-8859-1?Q?wYKtXV8+ia1PuqcsoU5zLxGBQgHHvDn+UcJdxttxg3Lq4o8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?j4m1RKP8IjcGeDTiQOsrKpfuM57Q7GdFbiRfFqTUdg5T41KRHyqHPcN47v?=
 =?iso-8859-1?Q?FlXx++QPTmDMlTDWb9GxMuniHTITjao6Aqn2MMIYzZRuIGrHuKWlfF1Hq4?=
 =?iso-8859-1?Q?jnaOR8BbQnnrfTcoo+cx1PJTvZ8GZF3B7egKqV0RwegdQlyOI9vg30XpPF?=
 =?iso-8859-1?Q?NcJhyGkdWJ3zMCfcOipg1+creZe10EdMS9rSDY1xe7v5x/c6A03nzCa92T?=
 =?iso-8859-1?Q?fxtn4Y3JVYEyI+xCVd3IPEdqiauyq8u6HL8UsGbT/YaHN/Y6k9bWn8xgs+?=
 =?iso-8859-1?Q?OvQj36B0to4Ywf+L2jcoRFopCQuuvTEnFffwRD6HLNeZrhr/mTu6nDPtgB?=
 =?iso-8859-1?Q?ssqYnUG42/durBlslRsKENMq3YGbETenAASWIj1pxMYEBLxmTCQ96qNwSv?=
 =?iso-8859-1?Q?KafV0MAI6h9UhR+9Vh4mjpwIKdMkDppIhBncXfvzHA9T8sQq71aMrLfA+x?=
 =?iso-8859-1?Q?kogKsM/pAWFWwS49Ek/CgsuFfemBibkDSxTsLpk2UiUjXSN+nIxkTTEpDR?=
 =?iso-8859-1?Q?Ih04G/sNEia2JnEgi/8I/AY5U0n023ImhZegbgHTy8Euhtp3OIzLyOJX52?=
 =?iso-8859-1?Q?rIFWjDlqNSfbTmmaeVn8nLPrEby69jKU+cCxU9ut5j7+m4LzXp2zuFtp3a?=
 =?iso-8859-1?Q?PDMJkSbVo7K06W50qi5MdbJY3ENFEy7NG8FvtxcDwMnKU//O3KA86V0AjQ?=
 =?iso-8859-1?Q?BeOaJ0EO2VLfhUmvRijD8c8bBR2yr8BiEW6JZt54Y+EFPN/X7WBc/++l4D?=
 =?iso-8859-1?Q?I7GRFOtJsyPtQUsXc9zBYKkWX35SVIq2uX84Coo7SNABz3O3Xhy9/FWyOt?=
 =?iso-8859-1?Q?an0lMZeUR5+9s1GB7de7BDkBYyZFgNHgeGeFisUOB7dFQqUlB2o1G6AAwb?=
 =?iso-8859-1?Q?28tkYyYllVX/vDHWG4hvbpWDqPVbfJs5Or43v2XLtq8mRnerLR9py4x9MG?=
 =?iso-8859-1?Q?SgqbLJGrZo9TaTYaUJOx24FKwkPhP8DFmQLv8wophnKQy49oA0Iqfd8uHe?=
 =?iso-8859-1?Q?ffEYufEimu61ccFoNYbTsEKPMN0h2FZR3DeHFl0qd7m9jj+gfWy+36hvF9?=
 =?iso-8859-1?Q?8igxdi3eaShfzZvnSqd/QJ2D6V4OHJNWIT/4QtfBXI1KngAU7JKIWtyBOV?=
 =?iso-8859-1?Q?XRTuKFYgkO2NAF8IAH+g9PsrrFBta7L61PUT9FjYPz3hXV/1xcXfuVF9tF?=
 =?iso-8859-1?Q?sNG4kEJ7N8hTu4bK3LIluHCQNk9t4vVz5VLRmgx4EU4GYwKqQvhv2vgJJa?=
 =?iso-8859-1?Q?2ai1E5pZcoH+pHrvSm6K/2a2dPkBLbzkbJcEn0HvNKQNIMlp+/m8gQqG1g?=
 =?iso-8859-1?Q?x5SXEapPrvjaf+EfeMIg/QJ4x0SmjZy22L/BXjCRi2wI5ij7yL7FUleXNl?=
 =?iso-8859-1?Q?XhE/N/VrXufZuVy7N+1O9LI3mkgyYiE80eWH5++wtU7XmjWunOqnfYAwqB?=
 =?iso-8859-1?Q?N2FJrdu3A8gXrPFXcuuvTs4QlzTMHtnNIZqwJ6CM1QzLeUV6ELZcd7+ZD1?=
 =?iso-8859-1?Q?MBwRYzMkCaaxh/3rlFn4O92YoXZkMAB307x3DX7cwTP6uMJM0MJLIgsEPE?=
 =?iso-8859-1?Q?B48gCsLxHV95QBTbp4287hicTE43oACos89g5GuyL9ksxR1WXjEWSMICwl?=
 =?iso-8859-1?Q?ZgDHoIbCkuUKprr5THZSkDILmksGWiTSR8GuypPvC9jNUE+4TG1hEx1A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d519ff-1813-4298-d989-08dc6508315f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 09:15:04.1897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gft9pGp3eKRagMxZUP1ZzbmEFHVZI/0SI6zXgWW50ptXpddkS+rQuV+4uasZ3wd9gqMzrArcth/MA4N9simRuiWsOoXIOwqDHOAXoxgI9Ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9905
X-Proofpoint-GUID: jMH1v95-LTk3s9ZepMh7A3l8lN28qkud
X-Proofpoint-ORIG-GUID: jMH1v95-LTk3s9ZepMh7A3l8lN28qkud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=984 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2404010002 definitions=main-2404250066

Add device tree bindings for the Blaize BLZP1600 CB2
development board (carrier board), which uses the
BLZP1600 SoM.

Reviewed-by: James Cowgill <james.cowgill@blaize.com>
Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
Reviewed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 .../devicetree/bindings/arm/blaize.yaml       | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/blaize.yaml

diff --git a/Documentation/devicetree/bindings/arm/blaize.yaml b/Documentat=
ion/devicetree/bindings/arm/blaize.yaml
new file mode 100644
index 000000000000..8034aeb7a2b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/blaize.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/blaize.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Blaize Platforms
+
+maintainers:
+  - James Cowgill <james.cowgill@blaize.com>
+  - Matt Redfearn <matt.redfearn@blaize.com>
+  - Neil Jones <neil.jones@blaize.com>
+  - Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
+
+description: |
+  Blaize Platforms using SoCs designed by Blaize Inc.
+
+  The products currently based on the BLZP1600 SoC:
+
+  - BLZP1600-SoM: SoM module
+  - BLZP1600-CB2: Development board CB2 based on BLZP1600-SoM
+
+  The compatible property should follow the format:
+
+  compatible =3D "blaize,blzp1600-cb2", "blaize,blzp1600";
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Blaize BLZP1600 based boards
+        items:
+          - enum:
+              - blaize,blzp1600-cb2
+          - const: blaize,blzp1600
+
+additionalProperties: true
+
+...
--=20
2.34.1


