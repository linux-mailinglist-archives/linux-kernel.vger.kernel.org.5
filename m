Return-Path: <linux-kernel+bounces-162482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1E68B5BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AAB5B26E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901DE824B5;
	Mon, 29 Apr 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="nrJRJhwv"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC357F7DB;
	Mon, 29 Apr 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402054; cv=fail; b=JSDatF5MYTxsm2A11qvQq3/QrZSSTlxsborpiN8wJ95qVaJHVvSECyU01cNrIUi+0etq0ARRT9S8bXzF0ZofsrBYRNeepK5SXtGqRjae1lXGWD35A8/RDNNwCIj7rggg5ZKgXLY2Xjs+d8l/2penCtyvRzbgcHo+Bh5+TdzqhOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402054; c=relaxed/simple;
	bh=RkJq7zzAqCaFJnTjg7EZoLX+sxU89GjdpU38TIq4tW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C+ZnLcEg8eaXEgovA4x9ephfeI2Ea/jqA46lAq8aQX4mJqL6MvMuwYXjVfbAWds4TvopE/bz3HOwFxxfGSyY218b7zQhFUks26bBAnZmQlXjgjQfbpZ998ooqKHSfSk2qtU8nxrauJyiGgQ/G4pTN8GRSJQLcBS00MR+qGP9Zu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=nrJRJhwv; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TEVkpr000923;
	Mon, 29 Apr 2024 07:47:27 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xtdcn85jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC864XzP6PQUPh6iA1eptUgpTl8DUhbofPFs/MO7lOymSUGBgqKXoH98GhT/yNWn0f9gqvjUSGv+LoydR/bJCqo3qifDsGypc9rUn2Jl9AZovP+0ZKpalc+UffqWUj5zr0gsTguybw43eaUVeIs/ebb7o8E+nufR0AMwoy07ceJ8fD+wFrITZxdTycklDIYfhzUvz6XcF/KqjMSJwiEL2/uJvkNs4Ln0LecF2xYyLx5uiyh6yojeuxU5HZyQeuz5bA9lIfdrp8Y327T0Z4X23RM2T3RtPGVc8m77uQFaKL3BiEHuUMoujq90UfFEZ5nvT9sshGG4Q0xtv7fBJOBxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJtx6q9hsu1K+E3tGOL0UyndyJDtSuuDuzKtyFnjOBU=;
 b=SCnA7tCQv05R4UbLsV61wgbAmkLTJ2a1fl+qI+uxIRnMiQ0niSNQV5pgRRM9LvmcZaYUS7lc67FkwLeZtfyW1nBIfm61B3v4iAODF/AAz6kzX8mEj4UDaTJ5nzmL9xZVpzYviUuYWore7t7dmBNR19wUtVDK23yEcoE/AfUR36KDIaFA4u2ATD87sGqp/cEzCm7DKkHX6T3PCo8SpahHeFsn/4A7tLsOSWDzd0Gn+cQSq5EbzT0wN6twXN4yq9Ma5M5OUv5gKBHr45HGc7zsAFc1a8V7X29CWRaT0LgCC+a7A6ajspk7JCp/xbm3JIBCKd8lBPW+RXuPAGbCWejDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJtx6q9hsu1K+E3tGOL0UyndyJDtSuuDuzKtyFnjOBU=;
 b=nrJRJhwvn5AGcIjkdVn/INGI/udNXJ4pBLpRdl3+N7dRPOHxxjnyUnTgfrb84UXOFoyBvBa+z4Thjf/W0VNMLPq8CaaRPP1GcWWq5e4x/EnOV3NcNO9mLNlteQrSES9j59mbltzqt+fMiBmGyJAP/66g7hABEyamH48Et45MGxk=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 MW4PR18MB5134.namprd18.prod.outlook.com (2603:10b6:303:1b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:47:23 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:47:23 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 2/5] spi: cadence: Add MRVL overlay
 bindings documentation for Cadence XSPI
Thread-Topic: [EXTERNAL] Re: [PATCH v3 2/5] spi: cadence: Add MRVL overlay
 bindings documentation for Cadence XSPI
Thread-Index: AQHakS28W/KzCqcstE+2q5E6FRh8o7FuNt8AgBEr6pA=
Date: Mon, 29 Apr 2024 14:47:23 +0000
Message-ID: 
 <CO6PR18MB4098C815325699975B1BD794B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-3-wsadowski@marvell.com>
 <20240418-sacrament-cornea-fd6fd569827e@spud>
In-Reply-To: <20240418-sacrament-cornea-fd6fd569827e@spud>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|MW4PR18MB5134:EE_
x-ms-office365-filtering-correlation-id: 83de240f-356a-448f-5949-08dc685b47cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?fO7M6gEy2ZizFxWpEwi62d8Q4Q760YxuX79pyZciCz5KxjLNOE872xU44nEh?=
 =?us-ascii?Q?t+OYNR+NXVsmWNn0oV6nBT2UXgRtzDOQ7FlS7uKjdgQhRcAZYNeNS2aNNLA+?=
 =?us-ascii?Q?XqVtngkTgUG5aURIunvQIE4dg+bmXnJilHs8PKp9TGtSqX6QZHPRN5eBYmEJ?=
 =?us-ascii?Q?70bCfsGg3cqy5j3Pbp6b8WAWTq+HzHMUUqFuxfLMONQ4C5uX31+aYHA7gc9i?=
 =?us-ascii?Q?p+lhMcUgUzCyULnePAmbdCjksR6I5JOAkVnCcw/TIOUqqzAf+npmMRJQr7oN?=
 =?us-ascii?Q?ZlSDB4sFYBJ+iw9MzRXFtdqQOjOGYbRdKAdcDCVKy70MJVkfepMJ7hf25gyj?=
 =?us-ascii?Q?TF7eVssxQSh8FforgD9FExcKc/cm+U56ZNTJtKilGPPevy+Zt0HeGlvrV+8R?=
 =?us-ascii?Q?nMhw5Ug6CaZa9oVF8juckMQOJp+qCt/98I+a6/iNFziyE874zTwwVbv8ATo8?=
 =?us-ascii?Q?I7e2UV1I59pEhzJTE54LjeRas+mOuYZH3vHDhGhwqQAPReIpWvfFNJqzCI8n?=
 =?us-ascii?Q?i9sZZ89X3jdSJ3WAevrj7FsPsBc+sRr3Zl81K0gA0kL5fQuk82Y66YkD7Nuw?=
 =?us-ascii?Q?b6SXkROR1VnMacIoWCJ+TGtRfYlVBjt5+hbu20y7BtBW7vhrMyal/N6cFXvX?=
 =?us-ascii?Q?E9XgFqEehiDt8LarbLkcJuL3WE1pQJob9uHTAfrryCY0REYXYzev2MBbmP1Z?=
 =?us-ascii?Q?Eqhy+ljqE48uTXvmkbo7Gzhm9Q4fKqDF/wYh+3lNCx8a9UEgvO1m3o0XnKRR?=
 =?us-ascii?Q?bdU0gdCNEM0cO5Lfqike+Dw3BXBi5YKs+l12E9czJmTRkpyNFhwGH2d9iRFv?=
 =?us-ascii?Q?TmfWjIKbG7j11S4RWambmC2E65puhMRaGbeWLe+3br+qwcVnXGQUJGH7o/eW?=
 =?us-ascii?Q?Yq3ddMTuaq79oMXoNc1fV2ymevpO2KU1Dd0ct9aIq2V6aPmxyRxUzIqvsiFY?=
 =?us-ascii?Q?oK7zuQx6BrB6Csm3BZzqges8vWE3REKZ8om420NHGa6uDrs91vmU5G6yVKqJ?=
 =?us-ascii?Q?Kd8vdSS4lywqp+VBPTlIgS7mNFyDaBHrj4I397SYuxE46cK95zmnRCc1qfWG?=
 =?us-ascii?Q?5YwnjXb5NIuj+N98ElWRz3JZaVfEbswwK1iSrK7vmaM28oNicKmGwfytdpS2?=
 =?us-ascii?Q?Qt9SqXZBKaMQfhbdPRYBRnD8Th/mZUou5sOGJ0H6r3JUL9+9T7I0A3fXSUCf?=
 =?us-ascii?Q?6TL6ugLWylWhy1/l/Ob+MV49/6XYTvdpRYn9qAPhPF+JP5WzuUKasCWNBieM?=
 =?us-ascii?Q?lvIcuvqX07jD0JqCzY9M3bZXLn/lHNILs9TQJtzSxSbsR9lqix/U8+FL+zXn?=
 =?us-ascii?Q?ohn92ASlMVbSVl/agvfiZAZoyLwd2t2nZmCHPt66ipr7Fw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?3EnlJFvIG4lkNkV3FXd1A9AK5ofw/iKAfI5iQ4CqBt1U4m2pPj4zmC6a7KBT?=
 =?us-ascii?Q?cF/y0J8amvB+zJEmRTPSARreuIbVI2txW5cxT9GAIOXHp1l0lE/qAnGbPA2D?=
 =?us-ascii?Q?n2r+iQqtK3EekVamEiIxv4bqrzp3ehhPVuu2wZkRKx0r8B9OQ7GFCq0rUjG1?=
 =?us-ascii?Q?EdS35Z1eoYQGdnw2VNUyQzbiA+PC3fdAULNcMck8v1k6GZGIrMM5jh16J0/P?=
 =?us-ascii?Q?VvMX6dqEVOBnsO658H6rOF5woiiZEAcHBPK8s2aJJ9WfKOIMdxXLmDxUCrTa?=
 =?us-ascii?Q?etM0wPAx4NP31C1udAE3gxRZQujYY/hyArN3OIdRAerCGNPCruk6r+unNgyQ?=
 =?us-ascii?Q?8NaEnfD7d29Luo5CjSeU9yDY/Chq8Xq+My82NfZg2FgvMdLeLp9rRadjPRfL?=
 =?us-ascii?Q?K1CZnGo3PChRBsMkplIA2NUPfzNd006l7ljbacL67PjJiZzNULK+vDGyl9Xb?=
 =?us-ascii?Q?jGPAMeVfUJH6N65OMNzCcmiiPHQh+rxvr3y0swyyiW2pgM/+QvlG3sZQBfek?=
 =?us-ascii?Q?2yGyGYepQp05yILUf/lFT3xLdrTSmJm05Lh0F7ouSXdfs3m9NPwOy1s902KU?=
 =?us-ascii?Q?8I5qSql4jfXr7EyQ/dTT5D3T+9t4iTPMgMGGZYWpR/LlQ8pnkimo47ZpDWSg?=
 =?us-ascii?Q?zb3j/T1ujN0SZplSxAi/dJVnf4OIPd9xb8ij8NExthVC14UM6JQ+vWsc4QbQ?=
 =?us-ascii?Q?THgflnaHyChO3dxNwNnP/ek1hoJTdaLk1g4L71OX9GHcLBR9kkAtfHDQMHDa?=
 =?us-ascii?Q?vyDqHu6mXzs9ZGi6vo9jfWXLNKjrIB86BoHy04FlWxQo+F/y7bJ3ihpfsMUv?=
 =?us-ascii?Q?EEZIyyC0ZdpdU6JtNCenvFC0DeB7LmKi8RPlFpPGJZdpLoiALeAXPY/mEv/7?=
 =?us-ascii?Q?KBF3mxepiO196P4w8Kfi5kE1VJEia/WwQlQxuT8ohv80MgAvMQieOaWTcpZQ?=
 =?us-ascii?Q?3ZdvBhoKOJzXqM7gTlqwZA6VV167w2KDDRob7+zdiUexDgdBVtvggAmCEzCp?=
 =?us-ascii?Q?64zTUNxHI8DzJN/RRfIM7n17ShUw0D+lvTfGq+OmqoSKofOtvf8IZ5ZcrnOT?=
 =?us-ascii?Q?VgdjEkaIaeHRtHmZPogJj18kd1UoidAdGZHL/OXIACee2JEuxhYLVoZ62M9c?=
 =?us-ascii?Q?7vdPIW7Y+4fPGr0PQ4cNC7/tBCVrDkA4HEkERPhLO4T3lVRWabPDbeLnMv+B?=
 =?us-ascii?Q?2jS9LDtubZeoBgcJ6wo8B7huAShjO/YHnUf3BeV23Y5O0NvmTlsjDMAYTKzV?=
 =?us-ascii?Q?Pcv2BTgCNgg+RpDyxfdjMWzMJoNjzmc/Go1FViMUSXQ49HSeAVZweOn0DO8z?=
 =?us-ascii?Q?IFzBOjphxyLXweCWtPkMjR4kemjdai4VoQDQBqcYzhT2FsCCrcU7u1Y8FW/p?=
 =?us-ascii?Q?BXy6b7teLL/VL4z5dIi+QJIxIL6RaYDV2aTcmb7JsLoFzlc32E6l+fy+HrF/?=
 =?us-ascii?Q?cGwUIzHtGO3CzWz0WKMMZ/juu8+3Foad4iwiFm8Qno43Ic26A0OtKORd/xnE?=
 =?us-ascii?Q?3wAuwo9yXfG7yiD74tiVVwl8mmvLRGuWd5uBvcRa1zxQ+RV6QWeWZPhO/PQZ?=
 =?us-ascii?Q?XbwWzHTmNVPi9XGqKTJNJSm9JTS8EhqS70rHvESM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83de240f-356a-448f-5949-08dc685b47cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 14:47:23.5563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCNDOXLsCeoZq+dYHBncNMETgQePYT0jkB4ayxoye88tUAtmjxwwCvu+CY6ZPQ8YS8sZNE1VmXHIBbFxb/Azwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5134
X-Proofpoint-GUID: egHA7_DIcm7RvcXuwZ_u_s_indDJLm5f
X-Proofpoint-ORIG-GUID: egHA7_DIcm7RvcXuwZ_u_s_indDJLm5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02

> ----------------------------------------------------------------------
> On Wed, Apr 17, 2024 at 06:13:49PM -0700, Witold Sadowski wrote:
> > Add new bindings for v2 Marvell xSPI overlay:
> > mrvl,xspi-nor  compatible string
> > New compatible string to distinguish between orginal and modified xSPI
> > block
> >
> > PHY configuration registers
> > Allow to change orginal xSPI PHY configuration values. If not set, and
> > Marvell overlay is enabled, safe defaults will be written into xSPI
> > PHY
> >
> > Optional base for xfer register set
> > Additional reg field to allocate xSPI Marvell overlay XFER block
> >
> > Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> > ---
> >  .../devicetree/bindings/spi/cdns,xspi.yaml    | 92 ++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > index eb0f92468185..0e608245b136 100644
> > --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > @@ -20,23 +20,82 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    const: cdns,xspi-nor
> > +    oneOf:
> > +      - description: Vanilla Cadence xSPI controller
> > +        items:
> > +          - const: cdns,xspi-nor
>=20
> The "items: isn't required here is it? Can't you just have
>     oneOf:
>       - description: Vanilla Cadence xSPI controller
>         const: cdns,xspi-nor
>       - description: Cadence xSPI controller with v2 Marvell overlay
>         const: mrvl,xspi-nor
> if you don't want to use an enum?

It works without items, but I will try also with enums.

>=20
> > +      - description: Cadence xSPI controller with v2 Marvell overlay
> > +        items:
> > +          - const: mrvl,xspi-nor
>=20
>=20
> "mrvl" is deprecated, please use "marvell". You're also missing a soc-
> specific compatible here, I doubt there's only going to be one device fro=
m
> marvell with an xspi controller ever.

The intention is to add overlay on top of existing IP block to gain some
More features from it. So if there will be different SoC with same xSPI
IP, we can simply use that property, as internal SoC structure will be the =
same.
On the other hand, if there will be used different IP to handle SPI operati=
ons
It should use different driver. Also, I do not expect that new version of t=
he
Overlay will be developed to handle different IP.

>=20
> >    reg:
> > +    minItems: 3
> >      items:
> >        - description: address and length of the controller register set
> >        - description: address and length of the Slave DMA data port
> >        - description: address and length of the auxiliary registers
> > +      - description: address and length of the xfer registers
> >
> >    reg-names:
> > +    minItems: 3
> >      items:
> >        - const: io
> >        - const: sdma
> >        - const: aux
> > +      - const: xferbase
>=20
> Please constrain the 4th reg to only the marvell device.

Ok.

>=20
> >
> >    interrupts:
> >      maxItems: 1
> >
> > +  cdns,dll-phy-control:
> > +    description: |
> > +      PHY config register. Valid only for cdns,mrvl-xspi-nor
>=20
> Under what circumstances do you expect these things to change for a
> particular SoC? If it's fixed per SoC, you could deduce it from the
> compatible rather than needing properties.
>=20
> None of these properties explain what they do and all appear to just set
> register values directly, which is not generally something that we permit
> in DT. Some explanation of how these values vary would help a lot...

I will remove that PHY configuration block. That can be d in driver, based
on SoC version/HW overlay version.
I believe to change that values or some internal clock should be changed,
or whole internal structure, have to be changed. After few internal
discussions, I don't think only changing the SoC will be enough to change
that values.

>=20
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0x707
> > +
> > +  cdns,rfile-phy-control:
> > +    description: |
> > +      PHY config register. Valid only for cdns,mrvl-xspi-nor
>=20
> Please enforce constraints like which compatibles something is valid for
> in the binding, not in free-form text.
>=20
>=20
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0x40000
> > +
> > +  cdns,rfile-phy-tsel:
> > +    description: |
> > +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0
> > +
> > +  cdns,phy-dq-timing:
> > +    description: |
> > +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0x101
> > +
> > +  cdns,phy-dqs-timing:
> > +    description: |
> > +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0x700404
> > +
> > +  cdns,phy-gate-lpbk-ctrl:
> > +    description: |
> > +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0x200030
> > +
> > +  cdns,phy-dll-master-ctrl:
> > +    description: |
> > +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0x00800000
> > +
> > +  cdns,phy-dll-slave-ctrl:
> > +    description: |
> > +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0x0000ff01
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -68,6 +127,37 @@ examples:
> >                  reg =3D <0>;
> >              };
> >
> > +            flash@1 {
> > +                compatible =3D "jedec,spi-nor";
> > +                spi-max-frequency =3D <75000000>;
> > +                reg =3D <1>;
> > +            };
> > +        };
> > +    };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    bus {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        mrvl_xspi: spi@d0010000 {
>=20
> Drop the node label here, nothing ever refers to it.

Ok.

>=20
> Thanks,
> Conor.
>=20
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +            compatible =3D "mrvl,xspi-nor";
> > +            reg =3D <0x0 0xa0010000 0x0 0x1040>,
> > +                  <0x0 0xb0000000 0x0 0x1000>,
> > +                  <0x0 0xa0020000 0x0 0x100>,
> > +                  <0x0 0xa0090000 0x0 0x100>;
> > +            reg-names =3D "io", "sdma", "aux", "xferbase";
> > +            interrupts =3D <0 90 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-parent =3D <&gic>;
> > +
> > +            flash@0 {
> > +                compatible =3D "jedec,spi-nor";
> > +                spi-max-frequency =3D <75000000>;
> > +                reg =3D <0>;
> > +            };
> > +
> >              flash@1 {
> >                  compatible =3D "jedec,spi-nor";
> >                  spi-max-frequency =3D <75000000>;
> > --
> > 2.43.0
> >

Regards
Witek

