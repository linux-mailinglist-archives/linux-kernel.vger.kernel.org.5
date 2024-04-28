Return-Path: <linux-kernel+bounces-161378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C118B4B51
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E421F216FE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D56F56B70;
	Sun, 28 Apr 2024 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="n56eCVCd"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287C56455;
	Sun, 28 Apr 2024 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714301361; cv=fail; b=UoIwDCND0wjKyfJvs9DY7+Yc2mMW11WXU/WJgJacZNwq4BMLEs2P+UA+K2TugXFmeMxTLAfRzKMlZTryrC6PO8wY/6XRXTVak9CNikrXhjj0+r5hALw3bX1I8nczzVD5oPJs5ou2+5dfAJzlJQAG+VgQb82PxKU2/U00+zQUOSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714301361; c=relaxed/simple;
	bh=JXBVTR0HGSsvt130t8Hs3Kp9CNZYFilikjTr7tJO0KY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kycbraEnZ6kUDwG8Q5eC3PhSZ8Ubb35+cWdN0U2S1uuvG4FQtMR0is35O2Z60gN6wXb59qOjuxjxs0An0cKppG4+bTTovs32ehCdoVc9Q1vxXv0y6XWAirGMTmnhdJ3/rIux7FjBVQCuKI6brvv8w7W7ucSzwrbAkjLGSRTPrfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=n56eCVCd; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43SAnBwj009576;
	Sun, 28 Apr 2024 03:49:11 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xrxqnhutu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Apr 2024 03:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2cabtnh9Z0OJE1BPYcHeZyw35bQtBREZvsRY+eHbsSTjG4sJo6Cb6tdGB/Jp7Po+Wq8SSVP6gYkyctMHb+rub9jO08NlY/vxEgw/pH+SFtOZWxXM4PAnIwLlfWOqWDSlX1tiky+fepP/0HSUAQl7fYuEDVJxC7wEjXNqHmYUxlYOLKkn6M2IbEKaGrKWxUa+2ZdLaZQ3wHjbeiDhNwFU+AMp1vl5PWhC1H9gr/a6AX2M/R438/BdGKsNYR2VIrcQWxjMOsaKLJL4PETnTVtcS5tm6Pz4a0GApgcdcWoleWV+oEbi9fgGpmKAjv/KRsOQI8zzNeVprxk1P0q8wy3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7iGowMNxwpBuLPj/FIkD4p5GJv2fc/YPKMW5rgYqtE=;
 b=WPKAbqZZa6ik7BiNeCm0AlXs+cvQiB7T2Agt7Q3byQEZl09ojI2rpMYzGmHubuRq7HlNNMAwD3YIZ70oaojmJMaVexE1wvNLt9n3lpOf1uH7gekPw8yeHEnMTEjgmvI0//m6P0dg5Is1eSpNSV4Aysqn4FjI6IfpHLl1j808xA5uuxuw9EJM132Rngu6VAo0WER1ZvEThp2GczxC3aH0LSGZq9ib96zCRs2Lctk06QIFHMwTy4LBq36hNS+SNM/wgBfIaqnb7HRAuguHY4WUXpUPZBhBYqKjvzI4rZdmFX42FirglQk6uzR2Fe93m3Cp+4yK1658nE2M437aGMYuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7iGowMNxwpBuLPj/FIkD4p5GJv2fc/YPKMW5rgYqtE=;
 b=n56eCVCdPkFTF21ZmiXL4d3ej+l9G+vdh4O+tFQ0kDKy3jap2jDehGePPldAsXQdKHT1woAz6xbCTXbOj2jxlOR+Pd6WKun7AiwXWkwi/4LHI58E5xC37bfI6+Q+WhMSariysy5FIL+iNDjl9q0Lo3M0CdNVvJLQeA2J345flz8=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by LV8PR18MB6047.namprd18.prod.outlook.com (2603:10b6:408:226::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 10:49:07 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 10:49:07 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU
 representors
Thread-Index: 
 AQHalJsFkqfhspWruUiIYa8/IeAzYbF10/0AgAAqKiCAAYPOgIAA57JAgAAprACABPYcEA==
Date: Sun, 28 Apr 2024 10:49:06 +0000
Message-ID: 
 <CH0PR18MB43395A597F79BAF6D06C3049CD142@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240422095401.14245-1-gakula@marvell.com>
 <Ziexkkz8HCtIVRap@nanopsycho>
 <BL1PR18MB434216126F143177DE9A1D9ACD112@BL1PR18MB4342.namprd18.prod.outlook.com>
 <ZikaQQbAb2Manu72@nanopsycho>
 <CH0PR18MB4339CF300EB8D1C50EB60E78CD172@CH0PR18MB4339.namprd18.prod.outlook.com>
 <Zin_kmyhwImG56Hu@nanopsycho>
In-Reply-To: <Zin_kmyhwImG56Hu@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|LV8PR18MB6047:EE_
x-ms-office365-filtering-correlation-id: 2088e339-960d-4806-9709-08dc6770d3f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?r4s+oAxPZZ5T4gztcbEQyuGAwnBxePuvxZ70O6CxUclqWPMROBGys9vOPO69?=
 =?us-ascii?Q?gsxeCBF8A2/4IeBFAaYR4vZX2IvTCjDGKil3GJ9/KGohXDH+3Sqnc32G9kGO?=
 =?us-ascii?Q?3KK4v9lUkyWhsr1PnrsWnMTF1sondv6EUyMCbllJqpxttBGf2dTPVjAtrndR?=
 =?us-ascii?Q?u+UFqXjnEsJGdf36LAUJx4IpOs9aHOYnhjkjBUTh9mMP1tGZrhx/WyNeV2TL?=
 =?us-ascii?Q?WnUN/pYsgyY31O65jb4Sa1Wg+IOA36qGXcwqmR/CBMZQntCksj9Z0qdwVmQh?=
 =?us-ascii?Q?EgK7JUQpTdkwVlpMiyEnG1la+9m7VLdzc01EmN80Y7ZnxhPXd/hS9ucpscFs?=
 =?us-ascii?Q?Xqpc5fHQLvarat92lrIu2BONeVv+BmSxFE7gCdx3LrMpzn7m3P0wEaCUpGLy?=
 =?us-ascii?Q?LlWDwpd5uxYlldXLawjBA/xzu+lNNtADt9VC1NvG3jIC0sOTOaHQp7Ea8//q?=
 =?us-ascii?Q?vKnIdyyPe3G/BDA/wevegZStfxA28tc00vDEpp9tDCvHhAxrEXe4DGk0GhQs?=
 =?us-ascii?Q?95EAm2Fz33AxERKZ6Isk+708yZrMGililuKqT1SKaLl2wYD416lMAx28gXE/?=
 =?us-ascii?Q?D0HcU/jxRhw56xDvTmKdKrHRGeuaGO8L8rnyy1DwMREsMP4B+JrERetfPsKK?=
 =?us-ascii?Q?8eD3+XOGGXQfj6iMStK58nbTNmsUpxev/dPyICjDgPZ2d3NXyWAb0u0nzwum?=
 =?us-ascii?Q?rYWecm+XcjyqvNa01yyp3QYHwhLmMANpg4D+76nehhh+N2b1P8axP3kzv/+0?=
 =?us-ascii?Q?ttoHJn8EnFz1BQZB4x6LhbQjLdbKyLga7PzZ3y+qvkVGLILGqbPQ2Ocsd1d+?=
 =?us-ascii?Q?bRd68XXdgzffQzGnSyLX3KjUycyaGX9inmwT9vqvxFOyKLwbgZSRQzOkIKIZ?=
 =?us-ascii?Q?lkyE+s62A7hUzbfgxsqdLzZCk0hzprG3UzCqbCNCigfUwtoFrAmA8qasqhA6?=
 =?us-ascii?Q?aYoEHE6dXOUBJI0dgDjq6x1Lp/mcxBMvmCAUWAn4y1iBaKBdd7E2S4N3yT3D?=
 =?us-ascii?Q?qC7E8entxH9WrTs5DXZw4t3pHyNl+6edNYEr9uozZLRuDebKMBUQKxdJvyJN?=
 =?us-ascii?Q?eHo8VB2FsFv4NwtVlAvRnKwycbeFndF8ycs+Bj9BPm2uwTdhUUy/THkmwB3V?=
 =?us-ascii?Q?uLr5zansW7pJVSaFpjocIl63Fi1HdW7XUjZic3GdZftxrEAXwC+/zxL6i2oI?=
 =?us-ascii?Q?GlRc6B5rthDHeBkvv49P+u7pVKsEMs1WBcZoOikcjGdW22hcSTMpy+Utz2jX?=
 =?us-ascii?Q?LboxizoqtJsBv/cu+0oex7Ve5twunGZtB6mZB8pLPvb8ZOd9PgU+XWKPxHQn?=
 =?us-ascii?Q?lxgSw6l6QNjF6YEl+jZUfW6S?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?yYKfk/w1yMZHMu6XT3HrWBBmkox6TVvc91w2rXvM3CLZfsbo/gUjnrGpIGlW?=
 =?us-ascii?Q?vr4msLMIpa18maUKg7bhvPkZu1nnHWfdPIwYMF5enT7XqrzPrA3NmCieoHes?=
 =?us-ascii?Q?UFFaJ73wVh16sWxmFMif14DLKm5KH6+wrmP3xGexNL3xCMt0kPCkofzq3r+a?=
 =?us-ascii?Q?xc0wQT6xNFsVzQ4Wd8h5Te+p1Q0bHeZJNz8tuIrOk99jTbPyHGp3/BKVt8wD?=
 =?us-ascii?Q?QLzya4NT5/7lt78iRh8PGWbsayKIhl+YXufvir7nX+NprpnNBK4mODE0sw1q?=
 =?us-ascii?Q?NWfBlEVMwydLox9MMD13LtHukZU1K9aogD8iUu4LGaiPNB64yBc91HiuuUiH?=
 =?us-ascii?Q?cFyUoMINIhckRQ/lzYLETHGEKlzehgfr+NZ2fzhCFQ/+gUFt9YdoFRr90P19?=
 =?us-ascii?Q?mkgY13O2YRc0AeDYqYv9C0FEqwZBMDaKUflOYvupp+dhFw1fcjqvpdno4Yd6?=
 =?us-ascii?Q?azjQz2DIyUgjKJiWH6g0YV2d5blra34IHcpuMciRCkoul98xcqhz8dkNV1f+?=
 =?us-ascii?Q?HEANuM9EcQB/4DejfzXvZ5tSQ3f4W7ibdgqY3yNOPjxyXkBG/57Su8Ta1yM9?=
 =?us-ascii?Q?buIOWTFuPva1yuJUpbs78ksrfXTNf1hPVC2eiEPCXAG6JfZjlq6LX2yS7HLb?=
 =?us-ascii?Q?zfWBJd6yed288DHT8FSaJdlpxxfnX5HTc/ICDADxVPp7sLTULDdi6oXOfnav?=
 =?us-ascii?Q?euf4QpGvQWA2TwlOM045ygelKnmJsUNz5lDneGLriGRA9MDSAPaDs/5I7BDO?=
 =?us-ascii?Q?OvNw2jl0lBTRm7A9Z7kzjaA4U2o4G5lMWTECbHaOGaXH47QfWhWlTPsBMXGs?=
 =?us-ascii?Q?aklX076U3tn3V5whMiiTniq038LuRBzULPiywwIIPiktdpHZ9CzNGNN3s2hg?=
 =?us-ascii?Q?pL7Bf9FpTqPNbBIxLYZK1jUoiLGdvM1K0HkgHmsFlzS8Ya+vxrDTJ9b8XLD1?=
 =?us-ascii?Q?ueOfus4iEA18dHLp/593DvBoCJfcbyuE8eGayWhTDDQK0043ixMT3IUs+fPK?=
 =?us-ascii?Q?ykSyifswoXUmyaaYaa/wQWzYaDZNUkdAG4bU3Xac5pV8/9ojbMnzTE8cPptH?=
 =?us-ascii?Q?H33+9YqdkE+4wX4d9NVWkS9gYDO7r2gwubkEMiGc9mu5ObannyTR+uUN0C4X?=
 =?us-ascii?Q?SzJvPzQAKsu7jVJjsQqrO+1zvQRR2uUsSr9PfpVkuCGYb9tJLwciG/szpent?=
 =?us-ascii?Q?Nbk2mc8PfkwnWxC2+t0KnMzIP9UmwytTnBl06JwMjbs4AzzXkBWZW5xNNSyi?=
 =?us-ascii?Q?k5vyLim0qCh8a6kyd+ps1w4S6kYPWzQJnSL76Kew2fAck7rfiZFXqhi1rD8S?=
 =?us-ascii?Q?aHscFCh4+M4T5ueRsaZzUYCUBEtKgrOgBP5nki/FavLv9XVkuaxNvsrKJkqe?=
 =?us-ascii?Q?jkt6i7UYV2NtWVeBpNAgje+UVEDrMBACFwla3qQv6ZmY7nQeHMv28iX74S3A?=
 =?us-ascii?Q?oTNgoymI6AEqtu5Bb/B0VSbFGdwpYUM/nrnlBvmzAb7MvtAcRdsLgdxlIRgg?=
 =?us-ascii?Q?tgI3xEu/ZisZoGT1VWK1B/LPUqa4ZSBVIhCK4B4Igy9k4fipiv+VTAJYmZOV?=
 =?us-ascii?Q?60QZK6SQMYSNCulBfOY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2088e339-960d-4806-9709-08dc6770d3f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 10:49:06.9065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kXyWZ2zxfbCQridsBMp1PS7JSKix2GOMTi34jBt6BOBHZVqAFZeHoaoMiAF/nsrTXFN7F+wj1S0Qho+FrghBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6047
X-Proofpoint-GUID: SoCZhht2h-U81BzOQE8RmiSmUnJfTEkw
X-Proofpoint-ORIG-GUID: SoCZhht2h-U81BzOQE8RmiSmUnJfTEkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-28_07,2024-04-26_02,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Thursday, April 25, 2024 12:31 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: Re: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU
> representors
>=20
> Thu, Apr 25, 2024 at 07:09:01AM CEST, gakula@marvell.com wrote:
> >
> >
> >> -----Original Message-----
> >> From: Jiri Pirko <jiri@resnulli.us>
> >> Sent: Wednesday, April 24, 2024 8:12 PM
> >> To: Geethasowjanya Akula <gakula@marvell.com>
> >> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
> >> edumazet@google.com; Sunil Kovvuri Goutham
> <sgoutham@marvell.com>;
> >> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
> >> <hkelam@marvell.com>
> >> Subject: Re: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU
> >> representors
> >>
> >> Tue, Apr 23, 2024 at 05:39:15PM CEST, gakula@marvell.com wrote:
> >> >
> >> >
> >> >> -----Original Message-----
> >> >> From: Jiri Pirko <jiri@resnulli.us>
> >> >> Sent: Tuesday, April 23, 2024 6:33 PM
> >> >> To: Geethasowjanya Akula <gakula@marvell.com>
> >> >> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> >> kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
> >> >> edumazet@google.com; Sunil Kovvuri Goutham
> >> <sgoutham@marvell.com>;
> >> >> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
> >> >> <hkelam@marvell.com>
> >> >> Subject: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU
> >> >> representors
> >> >> ------------------------------------------------------------------
> >> >> ---
> >> >> - Mon, Apr 22, 2024 at 11:53:52AM CEST, gakula@marvell.com wrote:
> >> >> >This series adds representor support for each rvu devices.
> >> >> >When switchdev mode is enabled, representor netdev is registered
> >> >> >for each rvu device. In implementation of representor model, one
> >> >> >NIX HW LF with multiple SQ and RQ is reserved, where each RQ and
> >> >> >SQ of the LF are mapped to a representor. A loopback channel is
> >> >> >reserved to support packet path between representors and VFs.
> >> >> >CN10K silicon supports 2 types of MACs, RPM and SDP. This patch
> >> >> >set adds representor support for both RPM and SDP MAC interfaces.
> >> >> >
> >> >> >- Patch 1: Refactors and exports the shared service functions.
> >> >> >- Patch 2: Implements basic representor driver.
> >> >> >- Patch 3: Add devlink support to create representor netdevs that
> >> >> >  can be used to manage VFs.
> >> >> >- Patch 4: Implements basec netdev_ndo_ops.
> >> >> >- Patch 5: Installs tcam rules to route packets between represento=
r and
> >> >> >	   VFs.
> >> >> >- Patch 6: Enables fetching VF stats via representor interface.
> >> >> >- Patch 7: Adds support to sync link state between representors an=
d
> VFs.
> >> >> >- Patch 8: Enables configuring VF MTU via representor netdevs.
> >> >> >- Patch 9: Add representors for sdp MAC.
> >> >>
> >> >>
> >> >> Could you please add some command outputs to the cover letter?
> >> >> Like $ devlink dev $ devlink port
> >> >>
> >> >#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
> >VF representors are created for each VF when switch mode is set
> >switchdev on representor PCI device # devlink dev eswitch set
> >pci/0002:1c:00.0  mode switchdev # ip link show
> >25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
> DEFAULT group default qlen 1000
> >    link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
> >26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
> DEFAULT group default qlen 1000
> >    link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff
> >
> >Sorry if I was not clear before. Hope these answers you question.
>=20
>=20
> Again, please add outputs of:
> devlink dev
> devlink port
~# devlink dev=20
pci/0002:01:00.0
pci/0002:02:00.0
pci/0002:03:00.0
pci/0002:04:00.0
pci/0002:05:00.0
pci/0002:06:00.0
pci/0002:07:00.0
pci/0002:1c:00.0
pci/0002:01:00.1
pci/0002:01:00.2
pci/0002:01:00.3
pci/0002:01:00.4
pci/0002:01:00.5
pci/0002:01:00.6
pci/0002:01:00.7
pci/0002:01:01.0
pci/0002:01:01.1
pci/0002:01:01.2
pci/0002:01:01.3
pci/0002:01:01.4
pci/0002:01:01.5
pci/0002:01:01.6
pci/0002:01:01.7
pci/0002:01:02.0
>=20
> I'm not sure why this was not clear the first time I wrote it.
>=20
> >
> >>
> >> ?
> >>
> >> >> outputs at least.
> >> >>
> >> >>
> >> >> >
> >> >> >-----------
> >> >> >v1-v2:
> >> >> > -Fixed build warnings.
> >> >> > -Address review comments provided by "Kalesh Anakkur Purayil".
> >> >> >
> >> >> >Geetha sowjanya (9):
> >> >> >  octeontx2-pf: Refactoring RVU driver
> >> >> >  octeontx2-pf: RVU representor driver
> >> >> >  octeontx2-pf: Create representor netdev
> >> >> >  octeontx2-pf: Add basic net_device_ops
> >> >> >  octeontx2-af: Add packet path between representor and VF
> >> >> >  octeontx2-pf: Get VF stats via representor
> >> >> >  octeontx2-pf: Add support to sync link state between representor=
 and
> >> >> >    VFs
> >> >> >  octeontx2-pf: Configure VF mtu via representor
> >> >> >  octeontx2-pf: Add representors for sdp MAC
> >> >> >
> >> >> > .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
> >> >> > .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
> >> >> > .../ethernet/marvell/octeontx2/af/common.h    |   2 +
> >> >> > .../net/ethernet/marvell/octeontx2/af/mbox.h  |  73 +++
> >> >> > .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
> >> >> > .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
> >> >> > .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
> >> >> > .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
> >> >> > .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  75 ++-
> >> >> > .../marvell/octeontx2/af/rvu_npc_fs.c         |   4 +
> >> >> > .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 457 +++++++++++++=
+
> >> >> > .../marvell/octeontx2/af/rvu_struct.h         |  26 +
> >> >> > .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
> >> >> > .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
> >> >> > .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
> >> >> > .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
> >> >> > .../marvell/octeontx2/nic/otx2_common.c       |  53 +-
> >> >> > .../marvell/octeontx2/nic/otx2_common.h       |  83 ++-
> >> >> > .../marvell/octeontx2/nic/otx2_devlink.c      |  47 ++
> >> >> > .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 ++++++---
> >> >> > .../ethernet/marvell/octeontx2/nic/otx2_reg.h |   1 +
> >> >> > .../marvell/octeontx2/nic/otx2_txrx.c         |  35 +-
> >> >> > .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
> >> >> > .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  18 +-
> >> >> > .../net/ethernet/marvell/octeontx2/nic/rep.c  | 596
> >> >> > ++++++++++++++++++ .../net/ethernet/marvell/octeontx2/nic/rep.h
> >> >> > ++++++++++++++++++ |
> >> >> > 51 ++
> >> >> > 26 files changed, 1707 insertions(+), 225 deletions(-) create
> >> >> > mode
> >> >> > 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> >> >> > create mode 100644
> >> >> > drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> >> >> > create mode 100644
> >> >> > drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >> >> >
> >> >> >--
> >> >> >2.25.1
> >> >> >
> >> >> >

