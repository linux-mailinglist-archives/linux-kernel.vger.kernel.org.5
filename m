Return-Path: <linux-kernel+bounces-152331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A188ABC84
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E341C2122A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361A39AC3;
	Sat, 20 Apr 2024 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="FSj+s0Bx"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2090.outbound.protection.outlook.com [40.107.20.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA506205E36;
	Sat, 20 Apr 2024 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713632186; cv=fail; b=ka0EC6tT6zAcjNHWNW4d4hCi12KTrZ/hkCaWiIt8SSbsiSsW7GCMCEOBsFlbHSMW9D8roaRiREADQfXaepkHztc0t8GtrIPM44HVEkd5tjY/HMAd3Fi5cwVKdI1c98J4qQchm0UO26fq+IXK3gRYLU0LZXUFtmlNe/zWsiFXR4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713632186; c=relaxed/simple;
	bh=9bMNNA4/FxbFk3qZcnSbFWynfbDlzwWrS1SqAzED4MA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ou7xLWxRKnqC9SN0/viGeq0YNRsLy1iMCX2I3fNocF1OJNXiPPLzpfldpLibz7o9+/S7JQPGuN46nFab9QlKAfRGMs8xusFIa+HWT2gMD1Rb43ryqsxLNybK2FWBUK+gAN9t/c87cV3vDjQJQaG3FOBrOLVV1GZg4WmWqLVq3n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=FSj+s0Bx; arc=fail smtp.client-ip=40.107.20.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSlTDI/G2J5IHTYn8WU/AHyFD81YTebmXdanaYqImrOlgiRuID9YRzlIwELxYeDUWYSWFK67E8GJYK+TIOfGL52tR/RTA3NFtI6GZjW0YmZhn8LAL2qe69n7B/5lI4cy8ZRvEND2SjVVpfoEh59YAPtpq3cq0CteiU+3L5hSzDY4qFVV74Kq3G+iDL6T4MOOOHbhJMWMJiakJMiKzuGT4Jps5pfg5yX3XlHderT1Y65zl8rb2JIdv7GjQstTNY/ixy9wTerirw6nmQNqCSAQyd9zgzKdiVVkbI6IYQCXtN9K3Dc4IQeAnaY/gQcrSsMgFo/KWvgbGGqSS1In1djzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bMNNA4/FxbFk3qZcnSbFWynfbDlzwWrS1SqAzED4MA=;
 b=gDwgKIXR5ETp3BxDVTi/aLoUHflq6ewqgTKXHynJAhR6Q/YJpSnFCtLcFbtMaQekI56Pudy4OC84mneYXIDcI3FET4OrQDfMexhKovLkXzWhDpl/jUqyXNpF6Isu5aDWVg/kbEo9R4KQZz7u9H1BTt+Hm1RTCTbY6buHi9KzEW3LdZiiGLy2AgO8y870hatl1EDBoiVtykIOf+CHrnVNT2VhujqwOuXiewD3ppje7bRoR/cw4yAQ8Pt3I5nmSlexyE46txyAyxw8vxfpPv2NY14OQdzxPveP45WT4y8ZnYDUVkKwM8sZK10ovqsI4TGbulXJ769oQmaUPfC5G6s11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bMNNA4/FxbFk3qZcnSbFWynfbDlzwWrS1SqAzED4MA=;
 b=FSj+s0BxosOC1ffeqCsYwP1dTLDuK78tGtxZcpNEoPbvs2zwJbA6reyiExhOUI32T0KWXrvYz5nCKdZkH9i2pg43p9Boi6IwMrOG43jqTP+H6sJ0xYoli1GC/CGUtBZv/mCGyKF7N/A47bV1nlyfcLE9Ns2zcsJfcC8JpOIVTzA=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sat, 20 Apr
 2024 16:56:21 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7472.044; Sat, 20 Apr 2024
 16:56:20 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Michael Hennerich <michael.hennerich@analog.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Alexandru Tachici
	<alexandru.tachici@analog.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Jon Nettleton <jon@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: adin: add property for
 link-status pin polarity
Thread-Topic: [PATCH net-next v2 1/2] dt-bindings: net: adin: add property for
 link-status pin polarity
Thread-Index: AQHakxUeWnJJwEX9+E2iKFCftrM4ArFxVGOAgAAMx4A=
Date: Sat, 20 Apr 2024 16:56:19 +0000
Message-ID: <b3c4301b-afae-44fb-86c5-94f23d363c0a@solid-run.com>
References: <20240420-adin-pin-polarity-v2-0-bf9714da7648@solid-run.com>
 <20240420-adin-pin-polarity-v2-1-bf9714da7648@solid-run.com>
 <41567aec-adf2-422a-867e-9087ef33ef36@lunn.ch>
In-Reply-To: <41567aec-adf2-422a-867e-9087ef33ef36@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM9PR04MB8747:EE_
x-ms-office365-filtering-correlation-id: ef4a911c-434a-4990-cfab-08dc615acd5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2wrbEozU3N5RGZjMUppRG9MUWR0cmhBM0x0TkZvQUI2ZUhnazVpdjFMakdr?=
 =?utf-8?B?Um5IL1BvY1RUSHpWWmVTRDdwSE9tdExybHd6TXhaK05NM01yOVZWeFZaWW1R?=
 =?utf-8?B?ZmRxZHU4SDFwMG43MURNSU9vQmtoOGdtQ1BNUU41aloycXJzMnF3YXFpb05L?=
 =?utf-8?B?Z3E4b3FiK1hWZUZ6U3hXSERLSXZXRWpadzlnOXQ1RnVvdnFHcm1Pcld1cTlK?=
 =?utf-8?B?ZVd2alh5cHBqcCtqMXpqVnlKd1ZLQTEvdkNRREpjVUlpcW1jQWc5Rk5kZXVM?=
 =?utf-8?B?UWowYVQ5SDR5ZjNxWHFpUnFVVmdoYWhwYkxYSE52MnhPQkNrZWxMbFR1R0d6?=
 =?utf-8?B?NUJLeWFWTGkrOUhkelM5cFZWK0VoanFDMFVkYlNqRjZ6aU5UcHlUZXFiUjNi?=
 =?utf-8?B?TERNRUZQVHMrZEZXbnBZcXRLOGhwU1g2Yy94c0xra0g3RlFQWWxneFlTbG9P?=
 =?utf-8?B?R29TL2daYndkWmVrMHdobWdIZ0FQR2FUTVhWRUJnZzZJZXQ2amhJbW1aakRj?=
 =?utf-8?B?REZqRzJPWGFOcm9NT1ROcmJMTzBpOGxHOTRnLyt3Q1Y2cU5Jb3dKbmtBZlBZ?=
 =?utf-8?B?NWphMzZKd1ZqQmhtb3E2eVdLb3ZTNVBDaVl1MU55UUFsVU5RUU9VY1FOWFJH?=
 =?utf-8?B?R2hpKytFMGg4SEl6ak40UkIyM042T0VDek9uNEN6cGhoblJjYWpzVlUzYXlt?=
 =?utf-8?B?R2xCWDBQa0RHLy9RemNmT1F0R1EzdlFTRTZSSURIbnJTditwUy9JK1d5djV4?=
 =?utf-8?B?d1M2c3FlN3dBamFidDNzQ214Wm1Rd21xWXZCSDVWWGorbUN6bllTRC9neWoy?=
 =?utf-8?B?VTBUTWFFYjlNSDlFcSs2ZnhscitBOGpPUzRiVjJFak5HbFdLVHdwQmg0bzVJ?=
 =?utf-8?B?UExRRnNBSzFNZDVjRGlmYnhxb0ZiRnE0YUIwYUFRWEVxMTZWZmlFNVhDQTln?=
 =?utf-8?B?WmdaV2RnZWx1T2ZWT3NuUStsbUF3aFVGNTZGaWh3OU5OWll4SkVDVXY0dUp6?=
 =?utf-8?B?OVJJQzNGendIZzlPZklGaVNkRGVWTVZITWRKSitEbk1qMVorY1phQjJVV1Bh?=
 =?utf-8?B?dHhwd0lkVm05R3U0MnQ1R2JVTjloUzZnMUFPNjNRbkFrakZJTUt4dEEwQjIw?=
 =?utf-8?B?N3R2cnRNV0xyTGhBYTNkSDYydlY3azI5c29lenV5MlJwRE5NbU1Sa2xlczBn?=
 =?utf-8?B?U3ZOOERSYzgvZWxuR0VGZVh6Zk1OWWVUVnZYd01JczJJMEJqZGpsYUNHd090?=
 =?utf-8?B?ZWpXMUs2ZUVmc2VLWDZTZnRBRzZWN2tzVjAvdXF5bG91dHFsZC9NK2dveGdi?=
 =?utf-8?B?cDBXelI3aEtrRE5RaW5wc2ZYRk5EMC80Tk10U3BaMzZ0SGdBaVcxNGppa0xt?=
 =?utf-8?B?SG5DcmpPeGZra05WQmxLS3FFdWVoa3Z4bjhLajhDZitPa2Y3cVBORVQwa0lD?=
 =?utf-8?B?SW9oQXFSOFBPbFBZa3FDQk1Ib2IzWVp5eVRDOEovK3MwMWpJNWJrMHlvcW8z?=
 =?utf-8?B?NHdZclBNaTE3a2VScGlXZGpldGZ6dGRsVml2bk9jYy9mZkFmaFYveHdSQ2ZD?=
 =?utf-8?B?S0RhVmRSTGJES3NpV1dReE1NU1o5bmpoSDdQd0tkczhxclhESExOaUdVdkRu?=
 =?utf-8?B?NG8vTlVXVVBVT05uaXc0ZnhxcU1kYTVpdXdIZUMwY0ZyZXVWZ05OUzM0dzkx?=
 =?utf-8?B?anNBaWVYb0JVRGZjK0UyQWhRVHM4RlhMMnl2VjZaaUhqR0JDdkptTndzUngz?=
 =?utf-8?B?N2ltU1Q2K0FjMXI1c0JpNzV6eFAwVmlrL1p4YUw2TnlwRjFReVpjVXBaYyt1?=
 =?utf-8?B?Q24rTTFDOWxQTlNWckVWZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDFKR0hvNklEL045OFZZVHdoQzZjU1Q4djkxTnpIcWk2UmZ6ZHY4UjNSUkdi?=
 =?utf-8?B?ZEhTcE5xczhNcHNDSWpEb3BWZmk0TEVoVnVKK3ZrY0drVElpZk41UVNTZHR2?=
 =?utf-8?B?NEMzTlV2dTN6bTlOcUtwcFlQTkhQL2Q3cGlYQS9MRzRMbnM2OFR3L1c4eWNm?=
 =?utf-8?B?Wks2cEhORGRCaTBMRnY0NEdHS1FpdlpxTThUZzZaeEp3Z1VaeTVVS3NVdGhE?=
 =?utf-8?B?eFV4dnJYYWFkNXlDUDg2cEMrWURmRlp6ZXlRa1lsZkwyUnkvbGx2S3lQREhN?=
 =?utf-8?B?T2Q0THUybmJJY3BOMjZpenMvTzZVVmZVdklMMFBXZWlFZUZrbmpHRnkycVU5?=
 =?utf-8?B?ZTB0NGF2d3BwdHRGYURPY1NXcitkeEdmS25PZjlrY2kvaTFKcVUyZlZuaFQ3?=
 =?utf-8?B?MTdZQU1mdnhLa0ZuSXIvYXhVQUVJTjliM0N4M2pYemVaa3FqUUpWZ0JxYzgw?=
 =?utf-8?B?aGNHV285eWpEM2RuMmlvWWt1NlNMUERMMURQeXRRSWQvcEFwZC9TQTBXbzEv?=
 =?utf-8?B?aWp1cEtmdXFGU2psb2wwTTNtMUFwVWczWGNzVUsyUnRicHdvbVFraUtwR05s?=
 =?utf-8?B?VFI5d1MrNlFIYjlCcnZHSFpuVnpkLzQ0WnpHdU5zVmt3TUE4ZUwwbDdpTTdB?=
 =?utf-8?B?TXZIM0ZtcWowcGxmMlB2ZHJzazROTll1VG52amxWaG5WTjN1cDJXMEFrTjNO?=
 =?utf-8?B?OXl3ME8rSDNvQlpITDJhYXVqTGFNS3I5dTNvbzF1dVlWc0dqZ1pvcHd2anhM?=
 =?utf-8?B?NTlrcnZWWElsNStDV1JqQkVSWWV2bTZWTzZhYjM1OW5WQ1dKMjZ2U3ZGaHdx?=
 =?utf-8?B?UjhWbGc2Tkp2K3BnZkN1ZisreEtpd0RMM3FNbVdGVld5TUdDRk1PTUh0UlRM?=
 =?utf-8?B?UUNVTituSyt3Qmd6aVhzOTFHNENFWHg0NFdLcGVYQng3UnM3bFEzdjBJVVhX?=
 =?utf-8?B?RjUySGtxWW1TU21KcHhQWFNSQklKMWJYZVJZM25oZTVjTVdRdDJiRndXL3d6?=
 =?utf-8?B?Z0pFUEdUT1lVVWdhNHdjaFNidW1QR1RnTU5ZTzQ1VHZrMmsxU2tDZ0dSNTVS?=
 =?utf-8?B?aE43cXNicEVGcXhZUVhWN25ucDBnMVB4Z1UxQkFYMU5vMC92OEFwT1Z4RkpW?=
 =?utf-8?B?aVdJL3V5dG5JYjBVNkErN01IYm5wSDl4a1c4em5kOFNlN0huRTFLdlVQY3lK?=
 =?utf-8?B?ay9WY3BTNXNJTktJZSs4OElBWXE3dThodHBmRnAwcHluNTBqc3dwYXhXblJC?=
 =?utf-8?B?SHM1akJOWWxMZkhiUFhvcjBKUlY0SEw4b3hpZEs3UFBnOVFiSHQ4UzRGVHhV?=
 =?utf-8?B?YnNnTTc0UGxTRE1sZ01TWWc0b0YxZEwvVU9acldWNlAxTzVkdnl5bi9XZTYy?=
 =?utf-8?B?WVNoUkdyd1FrSTJjQ0h6SWVrcmloL1lnK1RsSTR3L0pURE9Zc0FpNlN2WG15?=
 =?utf-8?B?ZytPM0VIcnlBNzdzb1E0ZDF2L0x3ODNvUkwrcHNpWlZBTDZ0d0EyNXM1SkdE?=
 =?utf-8?B?Vk5UNk81TWtWbllzRVBSTmZWM3JCVVk5UEx6WXU0Y1hqaVFrRHMxSFA3L0R4?=
 =?utf-8?B?RTlmMllUcGJIMDFHZ1kzUlB5YnJvc3BNckdTQnBNMlRhTG1HYUhTUXlFeU9m?=
 =?utf-8?B?dmF3M2ZuYTdlZzcvNzJEamV2VC9JTE1OdmdpNndMOEh1ZkRoK1Izc1daa1VU?=
 =?utf-8?B?ditXREMvV1hJYTFOdVZWMWFGLysvUExHRVdrSTFRS1RNN05rWWVMZThLSFg4?=
 =?utf-8?B?c3RlOFlncjBiMHVFYVpJTFlaZHlUT1RQcEZGMFMwYkc2K1N6eE1oaHYrYm8z?=
 =?utf-8?B?QkZLTkdPaHlXSHBHYUxWYmcvMGV4eGFjZDVHR0pQU2RDSHIxUFdXMTVoMTJr?=
 =?utf-8?B?RUV6Rk1LSkhHS2daRWpOM3NLQWpYTHBSeHc1YlJKWU0xZytqa1JSNmxmdktj?=
 =?utf-8?B?MnJtSlFzUFhQNHhSbUJsM25YbGw0SFE0QU1IRjNsUEdhSmdUK3RaTFF6Q0gz?=
 =?utf-8?B?U1lOV1Y4NUlYVGpjZDdyRFdITUx6eUlyZUZrUWFGcm8rR05CSjdSSWNUMkdD?=
 =?utf-8?B?aERhWEJKOVNkMm9ZR25jaFpPb3RuNUM2dS9GMzV3bmtLWTgxcWJJN1VoQW5h?=
 =?utf-8?Q?/ukQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9480D949B2875546863220961123F1BC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4a911c-434a-4990-cfab-08dc615acd5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2024 16:56:19.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9UKstxZr1EoXx8b4h0BwAJ6C0ud4GpHG08j+6wBN0ddzoapjjLY/E/ituiWIxrwq5MZLGq3HkIabaDScCZkag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8747

QW0gMjAuMDQuMjQgdW0gMTg6MTAgc2NocmllYiBBbmRyZXcgTHVubjoNCj4+ICsgIGFkaSxsaW5r
LXN0LXBvbGFyaXR5Og0KPj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzINCj4+ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAgTElOS19TVCBwaW4g
cG9sYXJpdHkuDQo+PiArICAgIGVudW06DQo+PiArICAgICAgLSAwICMgYWN0aXZlIGhpZ2gNCj4+
ICsgICAgICAtIDEgIyBhY3RpdmUgbG93DQo+PiArICAgIGRlZmF1bHQ6IDANCj4+ICsNCj4gSG93
IGRvZXMgdGhpcyBkaWZmZXIgZnJvbToNCj4NCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2xlZHMvY29tbW9uLnlhbWwNCj4NCj4gKyAgYWN0aXZlLWxvdzoNCj4gKyAgICB0eXBl
OiBib29sZWFuDQo+ICsgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICBNYWtlcyBMRUQgYWN0aXZl
IGxvdy4gVG8gdHVybiB0aGUgTEVEIE9OLCBsaW5lIG5lZWRzIHRvIGJlDQo+ICsgICAgICBzZXQg
dG8gbG93IHZvbHRhZ2UgaW5zdGVhZCBvZiBoaWdoLg0KPg0KPg0KPiBXaHkgZG8gd2UgbmVlZCBh
IHZlbmRvciBwcm9wZXJ0eSB3aGVuIHRoZXJlIGlzIGEgZ2VuZXJpYyBwcm9wZXJ0eT8NCkl0IGRp
ZmZlcnMgaW4gdHJlZSBkZXB0aCBhbmQgbmFtaW5nLg0KVG8gdXNlIGxlZCBiaW5kaW5nIHdlIG5l
ZWQgdG8gYWRkIGEgbGVkcyBub2RlIHdpdGggYSBsZWQgbm9kZSBpbnNpZGUsDQphbmQgZGVjaWRl
IG9uIGFuIGluZGV4IGZvciB0aGlzIG5vdC1hbi1sZWQgcGluLg0KU3VyZSwgY291bGQgYmUgZG9u
ZSBidXTCoCBtYXliZSBzaG91bGQgYmUgZG9jdW1lbnRlZCBzb21ld2hlcmUNCmFzIGl0IGlzIG5v
dCBpbnR1aXRpdmUuDQoNCk1haW4gcmVhc29uIGZvciBoYXZpbmcgYSB2ZW5kb3Itc3BlY2lmaWMg
YW5kIG5vbi1sZWQgcHJvcGVydHkNCmlzIHRoYXQgdGhpcyBwaW4gaXMgbm90IGEgbGVkLCBpdCBp
cyBtZXJlbHkgYSBzaWduYWwuDQpUaGUgUEhZIGNhbsKgIGJlIGNvbmZpZ3VyZWQgdG8gcHJvdmlk
ZSB2aWEgdGhpcyBzaWduYWwgZWl0aGVyOg0KLSBsaW5rLXN0YXR1cw0KLSBjb2xsaXNpb24gZGV0
ZWN0aW9uDQotIGNhcnJpZXIgc2Vuc2UNCi0gdHggcGFja2V0IHN0YXJ0DQotIHJ4IHBhY2tldCBz
dGFydA0KDQpUaGUgcHVycG9zZSBvZiB0aGUgYmluZGluZyBJIHByb3Bvc2UgaXMganVzdCBwb2xh
cml0eSBvZiB0aGlzIHNpZ25hbC4NCkEgbW9yZSBjb21wbGV0ZSBiaW5kaW5nIHdvdWxkIGFsc28g
YWxsb3cgc2VsZWN0aW9uIGZyb20gdGhlDQphYm92ZSBsaXN0ZWQgZnVuY3Rpb25zLg0KVGhpcyBr
aW5kIG9mIGNvbmZpZ3VyYXRpb24gaXMgbXVjaCBtb3JlIGxpa2UgcGluY3RybCB0aGFuIGxlZC4N
Cg0K

