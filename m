Return-Path: <linux-kernel+bounces-163118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6C58B65F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FE628303F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D38281AA2;
	Mon, 29 Apr 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="N/IyF7I8"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AD71E886;
	Mon, 29 Apr 2024 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431589; cv=fail; b=l+jLVcZ8f++qDb7/eorllONjnc7T1DcMfZTzii8ft0yuXp2YPJQgOZAbXNQyu8VMmsevkGo0ho1naQjK1XtrGT98ge9/HLiLqogVDbl1wYz8Za5TepiSLS68muJ2bgs0CMFXzE0mAOuog+PvOZU/xu7N4Rc1zGaLWMhepq2AgoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431589; c=relaxed/simple;
	bh=5p+zZm4JY5G2L1OQuaHJD/kIoYTVwBAh3IcurxggV9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p7U69ZqHECWsdm/LjHTrLFAbakVAJ3Xp/wHMWykhHUrV5vzIEvaBq6f3X2kt+puOG8xLbhkcADndcAaKDM0srUSsxjWhC5bYkJhj5JfQhByCoXX7gm8XyQcGL9bX33P1oIgpq7e+4PIOTR6fCj4oNJBFVJgi2z+Qf1wM9tHpbHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=N/IyF7I8; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TEVt0x001520;
	Mon, 29 Apr 2024 15:59:42 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xtdcnc43k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 15:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avdzLrElGbunVHUAqhqEuk2XB8f9NII7XrWCbgRkoj2x69rG3bx1TwWtZOv5r/AmRV4rmncKod/8wxDPHObKBMh6/lztQfjzQy0F+HJBqRlcvkh2wsRqrE9iquikyY9rIe0Cdf+wCaZzRQHlb1+/ki2O2PDZ5NvhEuv4MUzihawJz3HvyRRzJRRGiAa7xHuDx5Wx6jO5w+qpKMB6lzuhOquLkvaYrqwAB6HyILFb5JFFyNrJftZ2oSaH7yYta1KAdxd1R3IcDkhd4CvfrgOBaJpaZ8Q1Bk0i+mjBJAFmhi8anCqBo8JNVj0RZFmKYmVfxXXM+qNzcmBw8yvlf4w1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9JgMgnfvQXp6WG018AS7JPdg3drcqH68umOWpgPz20=;
 b=mSKfJ3jMhJmGUorVoqwXY0eYTG8dQZ0CuEgQCCYiwJZAmZTvTvGabt/xxSqJCtPKRAo8noZltlDI/IfLbdDaGFF8Tcbjggnaa1RQRvWGmgj+yUxd5SK1eDhvzK0XSrlY/eyDtxcFFpn1UFoIwuJ23jQdwZ3Py6Sp9nLHmBXNm3f2RmrTktnfbZpR2mq/O4+D8wUBsIbxngpA62qSxsOr55nOglDd31Jqz2f6JH3T4l5AbRmttVdGUZUJqIm6sreDo1rykRJUi/K+kcdH6T8LyjY19Oe7dl0QxzKmFZG8HdE97dLoLSVg4hIiTuioepp7huwg/GPQu8qrqH/3W8a3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9JgMgnfvQXp6WG018AS7JPdg3drcqH68umOWpgPz20=;
 b=N/IyF7I84KEClBHeZWCCMVKMc/B0lkeKz1BAjNCmg2bUjpluV7YoC44b++kfiR8f56kcvpXqVMbAcXyHs/HWPwqaVbRrXBatVw4g9S+AeOk+tGUnCIbwe5zilK3P54AH6cTg2ol0ihiyKLv6O8xiUGo6AvXzsnEyqWwpbWaaS5A=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 LV8PR18MB5677.namprd18.prod.outlook.com (2603:10b6:408:191::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Mon, 29 Apr 2024 22:59:37 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 22:59:37 +0000
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
Thread-Index: AQHakS28W/KzCqcstE+2q5E6FRh8o7FuNt8AgBEr6pCAAHSOAIAAFNPg
Date: Mon, 29 Apr 2024 22:59:37 +0000
Message-ID: 
 <CO6PR18MB40985FCD4A28467DA36E07C0B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-3-wsadowski@marvell.com>
 <20240418-sacrament-cornea-fd6fd569827e@spud>
 <CO6PR18MB4098C815325699975B1BD794B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
 <20240429-quickstep-hypnotic-5b8d1fbeb920@spud>
In-Reply-To: <20240429-quickstep-hypnotic-5b8d1fbeb920@spud>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|LV8PR18MB5677:EE_
x-ms-office365-filtering-correlation-id: 739bcf36-3185-46b9-bea6-08dc68a00b43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?K0T5UYprHlA2w0PILgq1Nih0057kmQy/qhfYmwpJNuSFF15pXJmgf5KOECrG?=
 =?us-ascii?Q?d2ghAM4dBhtDG15t2a9SClyZX7PGy0ux2XBytQqjHHAZTsJPYJx1B3econkr?=
 =?us-ascii?Q?OZpaq7j+YODPWcN6rc4djQ23EvdgZEvqNuLWV3doaWr3qT66i7tUqyQ+KstE?=
 =?us-ascii?Q?ZzIQtIBj8fYGpwv0JnQaiHf0Jnu9mdxljotQCm1is4yqzq3rte1k1geA46tP?=
 =?us-ascii?Q?xQ2RrsXxzbAr/rmNxpgm672W5tjkamp/3zZBRi0wQLHXXlfAiMouTl+3J/Fx?=
 =?us-ascii?Q?84f5d67HeUIW3k/PDsSPlWj7KEnFY9cAi5KPoMYivbye5bsM64V9UYBejdur?=
 =?us-ascii?Q?LUS3rBcGxZSfY189iIzdJQz37PQXPAjjL91lQMoR7FZsYY4gVR9V4v+vHVIw?=
 =?us-ascii?Q?u5kuq5ws/64TejVCSqTKVSVA0U7nOCdP3N6r0x2q61wd/jz/PtwDAwl+CGLt?=
 =?us-ascii?Q?Fh7ZJB3P1I7sRNGRv5tws6ZRaNio6NsZ71WDOl+RvnUc7uPWaFB4EVR/retx?=
 =?us-ascii?Q?Owo30gg0tjVdX3zVUrUqjVfg4hzZ2igOY6VmmuyeEMhr7NG4z3T8vq1MBIVX?=
 =?us-ascii?Q?k7rBEoIYEcXRHqTv4JCzkrZFCfCUvD8EatQyLfl0D0RQW7a1fzh3b7Vskx5T?=
 =?us-ascii?Q?sTYvktaq6j96FGLutKfEI/B/FkAmptM4nMBV3dKy04IzYV+TivFMM4loC2Tf?=
 =?us-ascii?Q?6fCrJiGWc7YZCiSWhfme3doGFbDg3XfagJ5+TSo9L20FRu8EvGLsklsQ0owM?=
 =?us-ascii?Q?lY824wyWIMuvEtFRxGbXrx2PIYRDRTKCUKN+N70VLnE8f8sNE6QuIgUty4zi?=
 =?us-ascii?Q?xgtsq8ZKk2YyWI9ukwUd+4KRk8ykqmmgP8J5IHPruzhYwMHFJfKo64EbiJ5b?=
 =?us-ascii?Q?u3Lki5pIml8Co76gdvGeJqgqv2Vb2V5SZWica15LV/ZlZdkSHTv/zIdjm2eI?=
 =?us-ascii?Q?MoofUvg+gZv+CM0y88M9E8tOWmrWbkKkMv8ytv2h2Y8+ePrXosuK3tDW4DRJ?=
 =?us-ascii?Q?jKBq5UzOMRIQvOpOmNgI/MBkSmiaIo8/elYgP3nE4lZHYqkn8HYrHbR7b5cl?=
 =?us-ascii?Q?E2Qj146bJU/Qszlo9ON7W2N2Zh39NbdWGtSJ7RQZuAmBfCkod2b21GsXT45J?=
 =?us-ascii?Q?Q7lt2pGJwa52PKevAE3cg+f+dhEf4eWAesCEmkPyFOe++I80rOzhhxDnTtC3?=
 =?us-ascii?Q?LmAnGIvCbU6hOnKFhvQ8te8MxfPX2ZSwkaR3TXdMF4JyqF0wPHbwvD3Hl4id?=
 =?us-ascii?Q?LWtIiKkJ+j9LXxRsB+/0FTskKLqkIHB0epg/poffy0WpJ9OClVnOUBgYQLue?=
 =?us-ascii?Q?OJHnh1rLRox1K8DldcqhnE0BPWZ9ZeUwXII6L6RstoAJrA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?uX3MDs/V83NRtXTIy0uRpp50o+vMVkDzjXh/EDzIqzjm/qonfo5oNnW+wjZ2?=
 =?us-ascii?Q?nA6inl+wzJS3VTPFHwBPxHR7G8Fb+F9iyxrAVw3LQXmrGz+Vac2XLKuHZLRD?=
 =?us-ascii?Q?zudwvp+MNQKHMV71/5Rk8ibVzGGNtxh20HAJ7q/LaKN30VfLXZtARjAHKOGX?=
 =?us-ascii?Q?mrJ0eJ/3sYSJJ2kqMlX1lmkepT1+XRSRSYbWBFeQNiNutyYRV5CSxQgeNw2e?=
 =?us-ascii?Q?CJ6yzqTbuxxZDjAFxbwA9GZujuclNl0vBx2nkuTOTMZDeg0VaNSEGtvUKmr3?=
 =?us-ascii?Q?0TamZWiGCr639ZcalUXYBuljRAfcMP17tT9TDYckoJsaIXNPJWBew2Pd2sQ3?=
 =?us-ascii?Q?s6HItV62Hf4O+kHgvcL5wQn8173CuG8g9V4zOgKDlsaUdQw94XsYPgCKaZzJ?=
 =?us-ascii?Q?JLa7+OzmuEDHC4dE05Zvd9a2Dh3q6b7TEFqz6GCIi5ouNtaAqihm/AmNGT7A?=
 =?us-ascii?Q?b/OwL2QfsI1+vJV1a/jiO6oGhaKqAVFG07yQfJIUy8a0jnckPbQMrQa/w72Y?=
 =?us-ascii?Q?twBDhMan3LcqjFxnIf+ism+RZYfjtjsiZRUStycPW45f/fpt4UlpMpBzWBNz?=
 =?us-ascii?Q?EzOcEllEfINj94vCdDGQkKFqwbhkPhpWI5fpRdlQn4caVJxqV8jJ/ChzVI8I?=
 =?us-ascii?Q?NrA+4AgGfDEjU4FeSc22j/zQHIjsg3LkdNp85COdrIw/0G92r2xQt5MCo9TT?=
 =?us-ascii?Q?m+bTB0OW2m3tXQyIvOvr0BHK35DLjunaW7GDGQMwjUZMzN8IjiuvRWdAlFjs?=
 =?us-ascii?Q?kBDKzgU2FduFzzrP4w40y3g0sIROzbRsc2ClxQerfUBqSruB3XnVKJkQ9Wb5?=
 =?us-ascii?Q?2fL8SEOgEHNLf/1mU2RkYq12mvd+pwOqigmkeoZ8+5N40Fs2m7CwLQw0W5IQ?=
 =?us-ascii?Q?731bG0lISq+Qn8UKZ7bNeN/hWDY7Rfy7WEYE8AzAdbOeeByaOTJNOeMmXMXq?=
 =?us-ascii?Q?xcnWE7JUFp7ebrCo9qy0V76QdlTrM80LwegYiwxDlkhoMdtk0bR9AK9UYZFr?=
 =?us-ascii?Q?36WeChOSaepUyJ5qfLel+BYgBwvKjbm0YTriESYhPD946byPWyQgX0S8D635?=
 =?us-ascii?Q?/wH1LmxKnxJD1D4jYgYhZQpHbAV2vaqMQcr7sOfpk9InDhRBJHIW0JvcOlnI?=
 =?us-ascii?Q?FOguMsolPX3hxULf/EkR0gcSPxprFaoEFED/PcdeAzSQFlDpiH1wX/q6MNot?=
 =?us-ascii?Q?cZ+pVGsevkQ+msn89crJ29ntxT9RqqCMj+aPOpmadJ1RxxAwFd3oFH9JotnI?=
 =?us-ascii?Q?SRxs9zFTw1F6b823Q8NRUQw1v8su+zWabV+GmM6XjRbWeQA6LuadUcIIr1HY?=
 =?us-ascii?Q?5Psy4GoDsj2qSXsqFLarWSBlKrb6UatQmA+s5Tl8dzTDoDWoR1Xvx+1hkhTa?=
 =?us-ascii?Q?nYFnst25yCGvaL1nZSvGkweQI/U7tc/Q1SNVxDbkl4ENwSBplk2vZkphqtyJ?=
 =?us-ascii?Q?HeEqqsPSGo6JGgvf0LmicYyIlDtwkxJ7sNrWvhZpV3OEpqVmY3qE6d4zmSlw?=
 =?us-ascii?Q?XdBHNzgsB90PVYyan469/4NN1WmFOljc/hokR6dlAwpI2b12/8hpg2nl5i3v?=
 =?us-ascii?Q?8+rFoAH6JCQcTn5KGpVx1bzvXiqxNWlQwh4WT6Ac?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 739bcf36-3185-46b9-bea6-08dc68a00b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 22:59:37.2250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAuyEF8Mqmi6CGYQWxhz+nkHohgDcDidM4kk0BiQ1LD7sEkDU1MkzwwdNJSkU/t/JER7Jr6n61gTK3yUFnq0RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5677
X-Proofpoint-GUID: 0TJ6Gpnw6A9Y5nC6qwg7TX2kFhm5K65A
X-Proofpoint-ORIG-GUID: 0TJ6Gpnw6A9Y5nC6qwg7TX2kFhm5K65A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_20,2024-04-29_01,2023-05-22_02

> On Mon, Apr 29, 2024 at 02:47:23PM +0000, Witold Sadowski wrote:
> > > --------------------------------------------------------------------
> > > -- On Wed, Apr 17, 2024 at 06:13:49PM -0700, Witold Sadowski wrote:
> > > > Add new bindings for v2 Marvell xSPI overlay:
> > > > mrvl,xspi-nor  compatible string
> > > > New compatible string to distinguish between orginal and modified
> > > > xSPI block
> > > >
> > > > PHY configuration registers
> > > > Allow to change orginal xSPI PHY configuration values. If not set,
> > > > and Marvell overlay is enabled, safe defaults will be written into
> > > > xSPI PHY
> > > >
> > > > Optional base for xfer register set Additional reg field to
> > > > allocate xSPI Marvell overlay XFER block
> > > >
> > > > Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> > > > ---
> > > >  .../devicetree/bindings/spi/cdns,xspi.yaml    | 92
> ++++++++++++++++++-
> > > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > > > b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > > > index eb0f92468185..0e608245b136 100644
> > > > --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > > > +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > > > @@ -20,23 +20,82 @@ allOf:
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    const: cdns,xspi-nor
> > > > +    oneOf:
> > > > +      - description: Vanilla Cadence xSPI controller
> > > > +        items:
> > > > +          - const: cdns,xspi-nor
> > >
> > > The "items: isn't required here is it? Can't you just have
> > >     oneOf:
> > >       - description: Vanilla Cadence xSPI controller
> > >         const: cdns,xspi-nor
> > >       - description: Cadence xSPI controller with v2 Marvell overlay
> > >         const: mrvl,xspi-nor
> > > if you don't want to use an enum?
> >
> > It works without items, but I will try also with enums.
> >
> > >
> > > > +      - description: Cadence xSPI controller with v2 Marvell
> overlay
> > > > +        items:
> > > > +          - const: mrvl,xspi-nor
> > >
> > >
> > > "mrvl" is deprecated, please use "marvell". You're also missing a
> > > soc- specific compatible here, I doubt there's only going to be one
> > > device from marvell with an xspi controller ever.
> >
> > The intention is to add overlay on top of existing IP block to gain
> > some More features from it. So if there will be different SoC with
> > same xSPI IP, we can simply use that property, as internal SoC structur=
e
> will be the same.
> > On the other hand, if there will be used different IP to handle SPI
> > operations It should use different driver. Also, I do not expect that
> > new version of the Overlay will be developed to handle different IP.
>=20
> I'm struggling to understand what you mean here by "overlay". Ordinarily
> I'd expect someone to meant a dt-overlay, but you're talking about IP
> blocks, so this sounds like hardware modifications.
> I am also a bit confused by the claim that the "internal SoC structure
> will be the same". Usually different SoCs have different internal
> structures, even when they re-use IP cores. If they have the same interna=
l
> structure then they're not really different SoCs, just different packages=
!
> I think what you're saying here is that you intend using the "mrvl,xspi-
> nor" compatible for multiple SoCs that all contain the same modified
> versions of the Cadence IP, not different packages for the same SoC?

Yes, by HW overlay I meant actual HW modification. I called it overlay,
as it is not modifying xSPI block itself, but it is rather build around
it. As I don't have better word for it now, I will continue to use it.
With that approach we can still have full functionality of xSPI block
(like memory transfers), and additional features(like SPI full-duplex
operations).
Regarding "internal SoC structure" - I meant physical parameters of silicon=
,
Signal propagation times inside block etc. That won't be changed if we have
Two different SoC, bud made in same technology.=20

>=20
> Confusing wording aside, using the same generic compatible for different
> SoCs is what I trying to avoid. I don't mind there being a fallback
> compatible that's generic, but I want to see specific compatibles here fo=
r
> the individual SoCs.
>=20
> If you did actually mean that only the packaging is different between the
> devices, then I don't think you need specific compatibles for each
> different package, but you should have one for the SoC itself IMO.

We can have SoC A, B with common xSPI block, and both of them can share
Same dtb node with compatible property "marvell,cn10k,xspi-nor" for
example. I don't think it will be beneficial to have different compatible
name for each different SoC, for example "marvell,t98,xspi-nor", if all
other parts will be the same. Or am I not correct?

>=20
> Cheers,
> Conor.

Regards
Witek

