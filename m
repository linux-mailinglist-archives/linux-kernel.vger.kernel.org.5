Return-Path: <linux-kernel+bounces-69073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53E4858420
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2541F221E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F713247C;
	Fri, 16 Feb 2024 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="aQa59cNn"
Received: from edc2-mailout2.edc.trendmicro.com (edc2vmout02.edc.trendmicro.com [216.104.20.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF1219ED;
	Fri, 16 Feb 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.104.20.207
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104854; cv=fail; b=WZ9kTqfQzQ/9ZZCPTpB8IBQXf+HeUbBuzltq6j/Q2rMH6l6Eivdn++cck/O+6lGZcZR7xvZUme3WgNSuURFShY9lAwNbpDz6d/f8y2/ffGkkNfa1ff5qfXhTN41jBrtRehd1LUyqCxVQWN+U3+BdUotcAc0mM1XJlpv2iwfXJcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104854; c=relaxed/simple;
	bh=iWZ9pXVf9xALGSYztbbem0irY8/Bm+7EFQnSBhzY7Ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NQjiC53QdSRK2V1kBH/Xh+kBVufmy2mebrlExcDCoy6M955E5aEUc78xVvKork6MtGRBnKOzAtQUZtmqqAlbiwqdGiZ5g3DOdScF19ddvAyf0hfzaVY5x3gepscR1kPH7UguOVKX8c2kgQokwGXi0PxkSuWaQgPZJGTGydo8BMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trendmicro.com; spf=pass smtp.mailfrom=trendmicro.com; dkim=pass (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b=aQa59cNn; arc=fail smtp.client-ip=216.104.20.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trendmicro.com
Received: from edc2-mailout2.edc.trendmicro.com (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 8C2EA462896;
	Fri, 16 Feb 2024 17:28:05 +0000 (UTC)
Received: from edc2-mailout2.edc.trendmicro.com (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 773A4461BC8;
	Fri, 16 Feb 2024 17:28:05 +0000 (UTC)
X-TM-AS-ERS: 10.34.72.181-127.5.254.253
X-TM-AS-SMTP: 1.0 RURDMi1FWENIMDEuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
	HRyZW5kbWljcm8uY29t
X-DDEI-TLS-USAGE: Used
Received: from EDC2-EXCH01.eu.trendnet.org (unknown [10.34.72.181])
	by edc2-mailout2.edc.trendmicro.com (Postfix) with ESMTPS;
	Fri, 16 Feb 2024 17:28:05 +0000 (UTC)
Received: from EDC2-EXCH02.eu.trendnet.org (10.34.72.183) by
 EDC2-EXCH01.eu.trendnet.org (10.34.72.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 09:28:02 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 exhybridemea.trendmicro.com (10.34.72.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 09:28:02 -0800
Received: from DM5PR0102MB3477.prod.exchangelabs.com (2603:10b6:4:a1::19) by
 BL1PR01MB7769.prod.exchangelabs.com (2603:10b6:208:398::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.29; Fri, 16 Feb 2024 17:27:57 +0000
Received: from DM5PR0102MB3477.prod.exchangelabs.com
 ([fe80::62f9:a52f:7777:ce4e]) by DM5PR0102MB3477.prod.exchangelabs.com
 ([fe80::62f9:a52f:7777:ce4e%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 17:27:57 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"valentina.manea.m@gmail.com" <valentina.manea.m@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "i@zenithal.me" <i@zenithal.me>
Subject: RE: ZDI-CAN-22273: New Vulnerability Report
Thread-Topic: ZDI-CAN-22273: New Vulnerability Report
Thread-Index: AdoDaZfX1Pq+Y8aLRweLJ8giuYn76QAnSoKAFz2O8lA=
Content-Class:
Date: Fri, 16 Feb 2024 17:27:57 +0000
Message-ID: <DM5PR0102MB3477B594C9D018BC884DF3E4804C2@DM5PR0102MB3477.prod.exchangelabs.com>
References: <DM5PR0102MB347711AF2F5655852AC60BEB80DBA@DM5PR0102MB3477.prod.exchangelabs.com>
 <2023102134-reflux-saddling-c750@gregkh>
In-Reply-To: <2023102134-reflux-saddling-c750@gregkh>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=fb3eff03-709e-46b6-8b92-fa2cabeddd0b;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2024-02-16T17:25:00Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR0102MB3477:EE_|BL1PR01MB7769:EE_
x-ms-office365-filtering-correlation-id: 81fc0470-0ac6-405d-307b-08dc2f149deb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVhuFN2RpzWYfSD6qCrNo6Yyab9bJtBniUvw18LHyhEM6GYMZ3sFaLdwvq70sljNqSffNZM42TQR/j+wNBNm+d5OdQDIMteflCiWoc9Mtlg/9b39nJKY3CD4aDyWhi/RO4w+bXt9y+7WfvDXbaJXrtLP/Z18EFGPIKpDUqxrsqU0wb6WKfDAY0Unchuae4nuwPzeKOs87l6AmzZBiL1ZIBjZbty63wArp9kgkOR9sadUKn/Bs5GxR1Nz+DshuTUr08jsgrjXlAKuP1zJkTFn0RwF1DQMJC1Lk9h3PhPwa+t97k9ZUs76wNZ1z/yjtLP77jwxuozOrTPgAc8L/y2+xIjDMfb7PfacbtNT6Di38sCJYSmB4ib/fSoI5Pl32FmaDUiJeaakA0jSt9lKsqPYcOmvx8Bq9aieclYT0HHW1LJJrc9rqC/zD6wAhy2oVfc6O0cic0OmbM8MQcrtKwZ7JkUNuA1JPv8wkin+Lq7ryUBB9ASrNv3Qh5Hw2nENHt76bNBv52DM32krHmJTo2pvzCtdIkl2HnqTCriuUSqtNajkBbq8cuP8GbuaHsDQkBh/+LQ4dDSt1P76eNFowccJJp3r9Wjq8ClMkThvz++xtUHC68Hn+d+6MIKNTK2EE+aU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3477.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(53546011)(71200400001)(41300700001)(26005)(55016003)(6916009)(4326008)(8676002)(8936002)(2906002)(66446008)(5660300002)(52536014)(64756008)(66556008)(66946007)(66476007)(76116006)(6506007)(478600001)(316002)(54906003)(7696005)(9686003)(86362001)(38070700009)(38100700002)(83380400001)(82960400001)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TobaogOKyKslKXNqgR9MrkBLth3cduzIlmTijKeWJhhTbr/zGBXjfTW6sow+?=
 =?us-ascii?Q?NmuE/4IEJhdp5sc7GQegi6GPRHd2M/w1HQOstZSS/KNFb2i8TZhq/TaOTGOC?=
 =?us-ascii?Q?Zq4qkEUC6zaaHjXAyhEGul2ktxKDXmhvfYGdB7TJuuSWsoAgXtxhtlbmAaDs?=
 =?us-ascii?Q?chXDvOOBti+4j1FK6j66+EmAHwBaf5d8wwkzh6aTCLVuHTWVwBVI7+WPfhpw?=
 =?us-ascii?Q?1Q+2QFx3d8KX0Gf/phGC3tG+52a4BdNQSiwQNAVvVDO+XA99O8MVn3dLcg94?=
 =?us-ascii?Q?14DFT8iyn1v+tvWtbWVumIaHLyIE2L7ZGVHhwVMGiPud9WuKcIZRhneo1Fxa?=
 =?us-ascii?Q?ICPD4GfW4hwyFWT5teDT5Xab+2vVi5aOKK832NtG57T2L5OySFFbw7N0/Yhk?=
 =?us-ascii?Q?MQ5Wagy9IxxxvMQ5Mj/eoEeJLjCaGYvjZV5WgrOeEs/Y+xahAopLAqM0ACIf?=
 =?us-ascii?Q?3slf8G7GLCyhIlus6uEJHf3KPJI5pbu1JLrpLD6q2dUUeoW9t5xfCr2lmWbt?=
 =?us-ascii?Q?M2kFyiDmYjK0yCux4S7cH4WDrg3MxCdZLhovCxKWYUewqzqmhM9fMVbfcInv?=
 =?us-ascii?Q?nMRyg9GVj7V/V6Tj/WgGiUBm5ShkTJHcYaAABZO0fStiLy26F/9qkn7VWL7x?=
 =?us-ascii?Q?vHqPGx3EykehLMR3hHFacNvRafnKXc5VsFpJBSdvXrSBmyWJVjvABUKDdCoc?=
 =?us-ascii?Q?LMQHTFHURhUWJuPPZdtnPyvQw+hTAWlz94qRlbGgRiRbjvTPZfT4MBKOXEnY?=
 =?us-ascii?Q?NxFUNH3LEx0Tu4jMyKqTTS5bSL748jHCDk2FLUzTvXeHzrbw6dLHhOhFYrn/?=
 =?us-ascii?Q?Q/4rH7Q4TmnaFjYFffr5aDSx8i0rezi0DQGGa9Ann61V4rLn9iGTJMQmeb2/?=
 =?us-ascii?Q?X3CjIX0cWEFhFOxm/sfBtJ0hnjFDJVVT353wPzSB7reEy9RVCjoHu/hX3Yd1?=
 =?us-ascii?Q?WHU//aotluBIRDUsZ7jJKPRmfO17FNrL38ZbLHwkRIFM5ueKWbFpGcACpk4x?=
 =?us-ascii?Q?XJr3zFBvkkFgGSqDiSXg++Ugi1/E/ULcOhx9BLpMzqCJs9CHi1SBfJlHBrmB?=
 =?us-ascii?Q?Ex9WUTKsEJCJS479arUVY9zmfqlPagsmyf2oVr3EP9MibYc1ImycdaEan2s1?=
 =?us-ascii?Q?eD6vQ3qJahgyTZtqOyBJt8rdYHlX+aKzljAl6wufRM1narejN0WH8bMSokbF?=
 =?us-ascii?Q?iGj8esrALN7FAIICNirvQ/b6la4NLEvZoa8ZWf7tsel8wnisBSg9/92TehnH?=
 =?us-ascii?Q?EMAWFx0n/0Z+aMHmx9jctaax8maKvYlyJ9CR8n+j3zD4cce+1qLJWo1jcOCM?=
 =?us-ascii?Q?alk/5WgfJt0T2JbzgsMmemZ16I2ZLqb9l9J5/JpwAGYc4WMitukHIFJs4efy?=
 =?us-ascii?Q?N76k5IejOxXfzP5grjZAQT/XFrYy8qlk1KFFvNon3h05ynYFtMWUL7zFsBuC?=
 =?us-ascii?Q?nJeWQ3zZcma4bgX1BcHqIkM+AlTokhG5XYsvjQtAHFWrr2FjxPdkp2x7TRmY?=
 =?us-ascii?Q?JxXTVy7INQhmGIWF/CcfTVGEovYp3j67uBfJUCNbYn9Dsf10Afakw9+wnXNo?=
 =?us-ascii?Q?08F9E8/dPtVH/vVasXFMwryfMgVpl08e5QYdquS0YA9GoRQxbRR5b+pN65R0?=
 =?us-ascii?Q?yQ=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhrgMMjolRGKi2dPtwXKKO3QPOORNbmXRkKkDNWwpbRO/VPYVb23mtgAdq+0BHjBq5pJqWymPsu/+bHK/49hpTSkKdYEV8phGEbv1Sk43qtq6wGEAWEu9Ow1cnhZeOZTFwKwslr0jYEqU7hKw4Ezo/Yy1eelepsZgeepFyMcCS+gqYonKujC4p3uhQHWcsiY9GjgQ/96PvKoFJeka8SeCnEND/V1j1cURGnWRLWZX3PxKVaCDzf95U1BlFkgDAfr2jCPebvuV0OsDKDxPu4DWSSE6ezxWMBrl+N8X6mGm23+bYSJSa+FvOERWflp+vTCgcjquuC6/GJn5viWkIcuyQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBXp8ZgGTCchCEy3aO58qhqD5TJEKWIPwyaYML75maE=;
 b=aUZWgas94IV9bGuRqu4L8uVrZm00NZUxf8WZLl74zzuVgb8a4KAtke//uGN9STUUvrk2/xHpdsUOWbYvX+0RpVb9RN4Nj9Tb+HGxTmxWSapQI1QCGm/a3VWd+O2oghKBP2vyqucmh18NJQJMqyMSXpeBgg5eUbply5CYFnM0jtZ/An1rQwyDfIIKOmPg10bDkQuGyl7ALjlTb6kuf/w7TBckp39Zg7QYSo/ydL76Q2Ei8o49U4J8hERpshunruPcDzWy3PVAr8LXtcR0p+vgkp5LHpQcTvuxUUfAu1P1Alb45waD/+yemIkmk0aUVnGcN1+DFqz7I+rmpri+PvAkgg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DM5PR0102MB3477.prod.exchangelabs.com
x-ms-exchange-crosstenant-network-message-id: 81fc0470-0ac6-405d-307b-08dc2f149deb
x-ms-exchange-crosstenant-originalarrivaltime: 16 Feb 2024 17:27:57.4637 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: PBgANQZb+7RsD77PatxjIIC6NZzAyIfYL+O37ov79dW65b7vT8RShXbaC008xQuQR+ns1ePKm51Q4zy7w7iZNlyVX2w3957SN84XwUxsDMk=
x-ms-exchange-transport-crosstenantheadersstamped: BL1PR01MB7769
x-originatororg: trendmicro.com
x-tm-as-product-ver: SMEX-14.0.0.1158-8.5.1020-23728.005
x-tm-as-result: No-10--31.003000-8.000000
x-tmase-matchedrid: qMvSPq/juvM2eFTDBkQySu5i6weAmSDK7o0W6oHvde594HxmQFPHy6ev
	TQ+oqj1tg1nzb/gKUwTpF8/yJtLqIbsl8Gv1eXkKLTHwnYOikQ303H/AL/kEgC62hjZS0WoYoLG
	IKWGTD7S1HK24Jejm/r8B15Oa0QnZK8hR2zZwSxtWTwNSJxXbxhmyTBaqiJvcZ5yuplze9psXZV
	7+Q3yNydRXOtVQhr4di95kE0hke2wpz7oBrDd6eXTnOygHVQpOuoYFb0nRiqNR8uWm1euoCfh5g
	T8kXkoMIs0LHOrQp7jMWp1rr34S3qh+3Rlbev+J5O5PclyYqqqYf3r4ZCpo6sGQEnQwhjvzlbdk
	ZfDeSvkvsA40ApyM0TP5E9rI8AYK7kEboyvc1ZpnEHm3FVQAJoiuaoNXJrK/qPm/sjj9KBiakVW
	YYDXrTt+RhPMsqBuADFuFwhrWhlRzG4iyygR5BP7E6GNqs6ceudR/NJw2JHfir+qJKiOot1dLzf
	SRG1UjtT4piLWpY7p+3BndfXUhXQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--31.003000-8.000000
x-tmase-version: SMEX-14.0.0.1158-8.5.1020-23728.005
x-tm-snts-smtp: D6484F26039E7B72D3095B431733F5DF5F9C76767A5C1C8444353749805C196B2000:8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-ERS: 10.34.72.181-127.5.254.253
X-TM-AS-SMTP: 1.0 RURDMi1FWENIMDEuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
	HRyZW5kbWljcm8uY29t
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
	s=tmoutbound; t=1708104485;
	bh=iWZ9pXVf9xALGSYztbbem0irY8/Bm+7EFQnSBhzY7Ac=; l=3386;
	h=From:To:Date;
	b=aQa59cNnsssZBdsKzDhG1/aXPCG4yOs5phGW3wWKnGy9Z/3U1kO30/rjktjBAAZlj
	 +O7VW2DKN/XAkTcHAwcwZ8gSPP9YXksNy5C4gEYZdcAHeZorVQkM2+Rk2zu86yk0tf
	 Rz6W9WE+g6Pk+SE7m8Kc/NINAZbuCRbchpKeT4d4=

Hello,
Do you have any updates to share regarding this vulnerability? The 120-day =
deadline for this case was January 31, 2024. We will publish this soon in a=
ccordance with the ZDI 120-day Disclosure policy if there is not an availab=
le fix.

Regards,
The ZDI Team

-----Original Message-----
From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
Sent: Saturday, October 21, 2023 6:10 AM
To: ZDI Disclosures Mailbox <zdi-disclosures@trendmicro.com>
Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; valentina.mane=
a.m@gmail.com; shuah@kernel.org; i@zenithal.me
Subject: Re: ZDI-CAN-22273: New Vulnerability Report

On Fri, Oct 20, 2023 at 03:25:27PM +0000, zdi-disclosures@trendmicro.com wr=
ote:
> ### Analysis
>
> ```
> race condition bug exists in the usb/ip VHCI driver
> it leads to UAF on `struct usb_device`
> thread 1                                                thread 2
> vhci_device_reset()                             vhci_urb_enqueue()
>  usb_put_dev(vdev->udev);
>                                                                  usb_put_=
dev(vdev->udev);               // free
>                                                                  vdev->ud=
ev =3D usb_get_dev(urb->dev);    // UAF
>  vdev->udev =3D NULL;
> ```
>
> here is the patch in order to trigger the bug more easier
> ```
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 37d1fc34e..7242244d7 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -11,7 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> -
> +#include <linux/delay.h>
>  #include "usbip_common.h"
>  #include "vhci.h"
>
> @@ -781,6 +781,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, stru=
ct urb *urb, gfp_t mem_flag
>                                 usbip_dbg_vhci_hc(
>                                         "Not yet?:Get_Descriptor to devic=
e 0 (get max pipe size)\n");
>
> +                       mdelay(200);
>                         usb_put_dev(vdev->udev);
>                         vdev->udev =3D usb_get_dev(urb->dev);
>                         goto out;
> @@ -1075,6 +1076,7 @@ static void vhci_device_reset(struct usbip_device *=
ud)
>         vdev->devid  =3D 0;
>
>         usb_put_dev(vdev->udev);
> +       mdelay(200);
>         vdev->udev =3D NULL;
>
>         if (ud->tcp_socket) {
> ```

So you are resetting a device while it is enumerating?  That's a very
narrow window to handle, and you need a malicious device to do this,
right?

Can you submit a patch to just save off the reference of the device
before the put is called on it to be sure that all is in sync properly?

thanks,

greg k-h
TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>

