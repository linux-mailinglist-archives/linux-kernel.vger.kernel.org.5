Return-Path: <linux-kernel+bounces-14137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2859821842
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3278C1F21FD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED04612B;
	Tue,  2 Jan 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="oO1gQTxO";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="oO1gQTxO";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="oO1gQTxO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2133.outbound.protection.outlook.com [40.107.24.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336F4429;
	Tue,  2 Jan 2024 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=NmsLbemWcUgHWiKtQ2yaMz/nyOgkftB3B7h1ts8z9J2+ISh/K6bvDzUBjawSlBq+htUyS0MBtqQ+IHqJWQcrTmSI+OYDIoEkzuztDmSf3NElyO2r27ZzSEppSNUq6CFtwzhWOSLLEnOagHlWt+ZlLjVZWNKeokHa2Nro4bMKOPRShox7cGGKiEllr43uAk+fhWZ4X1UDAh6fxLARmcLz7Kyb2fw9zaTDHZaU30BS3EineufCheu4TNTAieVsfwkg4eVnB818YH2hP6QHtD2T9J0/LuclFQI95Kp5oFaUlZuVcJ2HuDQA+gMEZlGx7jY1J2ARRQdSko3NbaW4sVJEhg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ref9fjKrCe7IeUF1z5HgrvDK4xp0wtnh9HRTb2jhpVg=;
 b=AWaIRPmi0LgTv0pMZQp+vJO0H4HT3x/F614+xDlynd5ItvemnPe7jwuf41IpCXzR9eiUvPkDC/uour/8zlSoTL2wPfEOjGitqDZNPOu/peij+kAfnE1mybi7+IRpyocVEKY0IAB71vNxTcuyMO0XaNKPHUGOgy5J1xQMluv5M6LwRvxQ+XoYiyuop7isqtEEuXBYE1EJqGBDlZNu2r+8E76dh6k3IMC0rwGcuedBd761Y5jQKAnZ2goVVToQLuAHJoEBIC9I6QO9dx8P6B9yqM8TY0nER1P8pZ77Jmrq95W0JvxX7yeWU+6Y/d5wvh3N2+9c8UgVw+5UC+frV+W6Ig==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 194.38.86.34) smtp.rcpttodomain=davemloft.net smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; dkim=pass (signature
 was verified) header.d=duagon.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,2,smtp.mailfrom=duagon.com] dkim=[1,2,header.d=duagon.com]
 dmarc=[1,2,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ref9fjKrCe7IeUF1z5HgrvDK4xp0wtnh9HRTb2jhpVg=;
 b=oO1gQTxOAA8yUxg04JpfhT98VYnrEWy6I6rHh3/kV35ZZATspkrnNDOfZSUnky8jJM5q4P/oruBfUfW41jYBZJwSRaKmoHCOi+uhnJy2F66oGx8V0ufzi2s9sUnvn9RNga2AyPGydm/WnGUz85bASNpkxD3FleJkJfk8RuT6YCg=
Received: from AM5PR04CA0034.eurprd04.prod.outlook.com (2603:10a6:206:1::47)
 by GVAP278MB0152.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:19:20 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:206:1:cafe::e4) by AM5PR04CA0034.outlook.office365.com
 (2603:10a6:206:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 08:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 08:19:19 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4T45Nl061XzxpF;
	Tue,  2 Jan 2024 09:19:19 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Tue,  2 Jan 2024 09:19:18 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=n6nNa/lTy2j70mrVMEhOK/+Kx2duRUkqMyMohbA+5AdOLLa6Cdo+iHGygPD+hDM1mFAheILNJxzTNeakoSardXABWzhdQu2+Mu2aR5wHg2eSjduvCQ9HT4tv/+MBlUVL9B/VR89/Bazq2kTvSziwvKS10lfPL/8SxpCLXm5J8RFAJ0CeVefpG8+6VaqoquB42bAjT6tia23G+ItY+ShMv+h+KMTXPIloysLO72QKRmJWSzuXAFZPcFh6pXPeKnh0wP5O/ADSp99yT/4SXbcztQYmG+cCGyQ/uLyES8bE6OhdgIovcm7hxuz9iIQP1yRdnRhAIeViT0CANq1lqQxfFg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ref9fjKrCe7IeUF1z5HgrvDK4xp0wtnh9HRTb2jhpVg=;
 b=PGqr6cUIZkmA3F/yJaUsZh51yik9HAqNmTHCCo7Sllsb4vRTRQW4LfSIlp+sr6Fq07RhFGAAPKFjHx87uZTn/AoPRdPnSnFFJGJBRDqiFhC0PJlbzNlk1pBm94yxJr4t3VWPVv8YDbbjvwBplrTZA7RMaacsoHYDAtk+OMQz03OvKcDzzAt4abTNKWPm6vdv5s3QLUSYSvEW+aunzCPxkNYXtbQr/clJXvOT9VKRizLTGEDExaqhwo99Z2K6ObyVS7v41u5ytXwm4FZcFGeNOUxL9AHzLt1+bttAXtGBrzUpi5NY12xN6+ivHnA2aaX1y2JWjI9t990mo8IuVPYpgg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=davemloft.net smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ref9fjKrCe7IeUF1z5HgrvDK4xp0wtnh9HRTb2jhpVg=;
 b=oO1gQTxOAA8yUxg04JpfhT98VYnrEWy6I6rHh3/kV35ZZATspkrnNDOfZSUnky8jJM5q4P/oruBfUfW41jYBZJwSRaKmoHCOi+uhnJy2F66oGx8V0ufzi2s9sUnvn9RNga2AyPGydm/WnGUz85bASNpkxD3FleJkJfk8RuT6YCg=
Received: from DUZPR01CA0245.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::25) by ZR2P278MB1036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:5e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:19:15 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::33) by DUZPR01CA0245.outlook.office365.com
 (2603:10a6:10:4b5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 08:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 08:19:14 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.41) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 02 Jan 2024 08:19:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMpn55NyA2XHaJzEi14/xuAsOntZ9gEfvYEt+g1HpQfCw0NSjaOU2hs5pGg2HHZBW1Fdaquc2h/cEqTdwLhW7hhaxa8QsxhWs2lMQu32suG02FiOuBxzTHx+vVJwnqVzZdL4pRSbphkVB5wMV4RY41ydUf++T1aN8nF6lg1cl19R7CzHFzLf3bwNMxuqDP4cRf+7pN+azkkvLRqzaheDbGbI5HTlb3lAV7UzVG1bsJzlMwGamwt86nVYuowN/SMsjMq1Iqzc+PkmKgVtOq8kKkvpdMVYTD3aDfOqgiQNJPJJYH2xJfSpZ062Is7u0vsE1wFtYRU2JkHOaYPLqI8ieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ref9fjKrCe7IeUF1z5HgrvDK4xp0wtnh9HRTb2jhpVg=;
 b=Y58gwhkCSuGwDZfxNEo3QSl4XucYiKtv7ryQ+x4T66Q0VtyCXKI0/X53PemyyXIW8TmwdDVc9Z34HItV7lskiZI4PhBry3/wetH0uarpFEkVhnyFFmMMcSFuxFWvfRFPr1qD1v6Nz13341zeaCm7F8t8F1hTwPHUshZBbGixv7GZG8kwH023qoOocnYN29+cUvtD0UMxk/b7UUkHQ1StHCmWG2hjaNRvBQI8gNUse28vyNC4MTkHfBBLoAsUll0XxVZ7+kI21BEBoYurkN/MAqgOcZFQziN5GuhLNVIStgGVZEa+RD8b3fe2HbXbL/06kE5gkJRuYbNA/MP2YznHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ref9fjKrCe7IeUF1z5HgrvDK4xp0wtnh9HRTb2jhpVg=;
 b=oO1gQTxOAA8yUxg04JpfhT98VYnrEWy6I6rHh3/kV35ZZATspkrnNDOfZSUnky8jJM5q4P/oruBfUfW41jYBZJwSRaKmoHCOi+uhnJy2F66oGx8V0ufzi2s9sUnvn9RNga2AyPGydm/WnGUz85bASNpkxD3FleJkJfk8RuT6YCg=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GV0P278MB1093.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:19:10 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:19:10 +0000
From: =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?=
	<Jorge.SanjuanGarcia@duagon.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "grygorii.strashko@ti.com"
	<grygorii.strashko@ti.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?=
	<Jorge.SanjuanGarcia@duagon.com>
Subject: [PATCH 1/3] net: ethernet: ti: am65-cpsw: Fix max mtu to fit ethernet
 frames
Thread-Topic: [PATCH 1/3] net: ethernet: ti: am65-cpsw: Fix max mtu to fit
 ethernet frames
Thread-Index: AQHaPVRcTSxTlg48FUWrMA1QztI+Tw==
Date: Tue, 2 Jan 2024 08:19:10 +0000
Message-ID: <20240102081825.14635-2-jorge.sanjuangarcia@duagon.com>
References: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
In-Reply-To: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|GV0P278MB1093:EE_|DU6PEPF00009523:EE_|ZR2P278MB1036:EE_|AMS1EPF00000044:EE_|GVAP278MB0152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7e38b1-f649-4ce8-0399-08dc0b6b84b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 T7YEZ5VLz23UesPqd6VLzxBnH15rj2jOmkhmTFII9mvRi7mgDUiynGYp99+LyM6cpaY9Atvk4BWjl7l1Vf61nDHugPxXm9AwkTb9tCVU9ZX2MTaya5UN1FbQbqLxV/wsFLac20pAVdaQoslIe4d55NIRf2zdLzBLtBLgYxpPByU8mRUFCZM2lQtppNS1ZsOvR4Zb8wPy8zJhqzjooEE6InP9+U9mCVThm8tJRf6L1gNqSA6Uxm87MCeRkH3FcMiqmK0eEVWigICeN5HSjL1lTemlgFv+PLAQsX8MBEVFbuiG7DiBQT65OLW99mXI9YqTRHY5USAC3wfij+tn/otxfeXIKohpNbtdvKpY6WNs9WaBrYDDhtd4tPjrj3J9qxUp0GDY5TT3PfV0L0Asp526d6eq9CZo0xYINSJzkJ60xySvcrsIDgzw8U/yZfTlupm6gh49eprcrYMq8M2TNt1lzoLad1KzpO+54SD5EpXfZO5XsigPYrnMAsbox9BFKeeuVmhiY9KgvEmLoFEIg9s0Lu/R5IETFKRfQSnts2TTdJoJsK1eZozqpIxqgG9m8uIBMTeIgg6EIFXw0GrzWICqmxoLiK5pN+9Z2njJ3eoW4my1k5htNC5NMkPGZU8EFEa5
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(83380400001)(107886003)(26005)(1076003)(38100700002)(122000001)(41300700001)(8936002)(8676002)(54906003)(316002)(110136005)(4326008)(5660300002)(2906002)(478600001)(71200400001)(6506007)(6512007)(66446008)(76116006)(66556008)(66946007)(64756008)(91956017)(6486002)(66476007)(38070700009)(86362001)(36756003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1093
X-CodeTwo-MessageID: 5a2a20c5-676e-4856-9a57-ef57d2a5542c.20240102081911@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 be270afc-8b86-4b46-dd95-08dc0b6b7f24
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 wHJ7kjEd2kZv76bDceAwzF3U5NqVyXgjUfJAJTa9rXMSK9LkH5Oqo97RMqqKvJ+hAk4LYAEoqhBrmPvHO/BJyRGHwUpOenFVHnps09e/sYrQALXnOmWzzq/uSfKEycBsv6Qeevluf61Q60Zh0yJ5y3nUr43bjMF72q6MdeKBfUA40e5tt43xiMS8eLYYy1A/D8i5bFIN+HVNT9KvnyKBlqa8i0ZEsyWcwmKMfLTApZUzvrEqK+2A8Usv/MN9mRyxPZXlD7PuGNyQ6IbkrVeAronq7V9LrpUdXth9DqtvyRv6es1Dek4wQpuiFC4tGI2yItQN/BedD1uVAUTAWR6NyEqZOF+iyoStsUn//Lb60JnGajy35Hmpu6ks1wZReVD3ojiJRabuRRBKb1aGHE4uA7ODuX5WZa3mM9ENCFpN1rgEM9mp4USyL0KmsRey85+W6to5NSNbwABQ8Jib3kGBuDM891yzHB9IXkoaAVkfOKHl7yUTXNBm9xLsaHEkZfzLNhm8KoSsGcrGn6aJkfklIDdg1SN7yRSyD34SECtfcI6CO/AH/z42P/EnXEyDLeNOmfdDc+wX4HOgTQmch/gHNwFHCM/1QwkpnUMeyuPUX1oJJxVESPZOTS+HFBora0CJJonbDp8lzxOv5tWgs7KlDDBB2tacsrp/xbxGhx/DMmThv1oRS/MfFhhgE7RBEJWw+8i+/TMYYVGgQESxYYRB0Q==
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(396003)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(36840700001)(2616005)(83380400001)(47076005)(107886003)(26005)(1076003)(7636003)(336012)(356005)(7596003)(41300700001)(8936002)(8676002)(54906003)(316002)(110136005)(4326008)(5660300002)(2906002)(36860700001)(478600001)(6506007)(6512007)(70206006)(70586007)(6486002)(86362001)(36756003)(40480700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1036
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3515b160-471b-47e3-1f93-08dc0b6b8208
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DUXjnVKm7AYTp871E+Q3/DzwiddMUnv0H6+h92FvA6+mBZbX96V7BKYtKz/BqdHOsYs1jsWpCh3UrIa0smC+Pun+7ujqlWT/JYKC24LU/rG4MPyqrTp/X6WFPYtDCfwtvUIKovoLpQBIEwtDNc8MHDshq9+L+wLluxMEG/4DaU0l5Uj180Inco496oEIop2DqFLnVJajrG1MP3I7PBSKq3lNXCBLnBZ7IbNHbLaFjpe23mWLUPASm8x61xN+2cQclCJ1SONnuCzTuBMZM3IWQ1s9YF8lY27f9eCFKQU0hBiI5D63T2S3/kwlepoIOo+BI3tv5qCjmF3sV7eQljaYgHzhEazQwCoXCMD+H1dXoVDU2J4NcmlCDVBxBYGvebjITgnoKrsXHqkVRw98uDAcnlIeEwwOl9DoBTZF4lRBeVzJFjX6SptXBYqUOMCowqZ/JsLjLbzEvqdd5bik/s7VgvkRRw46NLcZzUEw530/asPBzAX1J//uk4SFfWtyueNQ4CB7F7GHAGDJLIpINmy9ayy+jBimYoIP5hJp9xtHI09lBeZGpYBAjOMxuvU6z0zMmgKusL8Gkwws/J+fKRb4k3LCIvk4Fhyyo8J4vQlE/sP1JuhOZmWfE1FPYKxRfc+lewsGtcZcfy6VdnoCiE6OhCw89Gl+13kiLQi+k0MbswpWkt3ZAStfzGWiSRmmA16dMJZK2uBH0rTLeVb/4zVuaLKD1laBXTsy745cnpwFlsGJZu31SRch+Mu/Ze+qZ6wE
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(396003)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(36840700001)(2616005)(83380400001)(47076005)(107886003)(26005)(1076003)(336012)(81166007)(41300700001)(8936002)(8676002)(54906003)(316002)(110136005)(4326008)(5660300002)(2906002)(36860700001)(478600001)(6506007)(6512007)(70206006)(70586007)(6486002)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 08:19:19.3154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7e38b1-f649-4ce8-0399-08dc0b6b84b3
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0152

The value of AM65_CPSW_MAX_PACKET_SIZE represents the maximum length
of a received frame. This value is written to the register
AM65_CPSW_PORT_REG_RX_MAXLEN.

The maximum MTU configured on the network device should then leave
some room for the ethernet headers and frame check. Otherwise, if
the network interface is configured to its maximum mtu possible,
the frames will be larger than AM65_CPSW_MAX_PACKET_SIZE and will
get dropped as oversized.

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth =
subsystem driver")
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/etherne=
t/ti/am65-cpsw-nuss.c
index 7651f90f51f2..378d69b8cb14 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2196,7 +2196,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common=
 *common, u32 port_idx)
 	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
=20
 	port->ndev->min_mtu =3D AM65_CPSW_MIN_PACKET_SIZE;
-	port->ndev->max_mtu =3D AM65_CPSW_MAX_PACKET_SIZE;
+	port->ndev->max_mtu =3D AM65_CPSW_MAX_PACKET_SIZE -
+			      (VLAN_ETH_HLEN + ETH_FCS_LEN);
 	port->ndev->hw_features =3D NETIF_F_SG |
 				  NETIF_F_RXCSUM |
 				  NETIF_F_HW_CSUM |
--=20
2.34.1

