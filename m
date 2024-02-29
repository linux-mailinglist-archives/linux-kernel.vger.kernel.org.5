Return-Path: <linux-kernel+bounces-86850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5A86CBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7951C20E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C8137751;
	Thu, 29 Feb 2024 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dhTat/3/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QdmJxtSr"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657B47F79;
	Thu, 29 Feb 2024 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217511; cv=fail; b=cOREUqYtAdy25S6ssg90dmbls5jrPGLQG+6ne6d3B1t4dyh5iyCIEXhQgu28sBNwj8cP+YuNkxN+f+TSCxsve1E5u7AGnm/zs62E+BEAh/wD7V63/XJeVJTmEUQPQcQF3gB1XUtrbs1NcSpTJ5BEKNuEo19K8lK/kdM4N6cb3s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217511; c=relaxed/simple;
	bh=KlM/C4EBblM/ynGdr6+EzWFTrziGhZOO8nPLLzR4MyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fD1N5Rff8IUb+8mjkeoCdMJne6oc23DTIhFpjNj88J1VrGVuFrYmlMskYY3+pC5SnosWYQ14kMlVUE2jJDEs6G5JtpV4uwS6X9R8oZ/TtlV6fhFw8Oz2iZCQFhKG3zcuqX7c06qD0gCEOPfSSNXBQTFuOZ6FeiWnYQbQNSecGAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dhTat/3/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QdmJxtSr; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2f747c94d71011eeb8927bc1f75efef4-20240229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KlM/C4EBblM/ynGdr6+EzWFTrziGhZOO8nPLLzR4MyE=;
	b=dhTat/3/0VrVn8lpMEc9qqSKqAL/g69boVXWv+KLYs4J4s97akfNfbZmeVsvgJVaraJVt+oALGnOByxd9oTjiKYFAe9tFuyWKAYIjSCSg3LymOqdp6Xv+2tEDR3UIjvJLBUj3v+r8s8NLdE8/qqhKCwGbOJkOehJKrw6ZZ2nX1Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e79eb597-6a70-4997-ad7e-d4c01fcc92f3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:b6f959ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2f747c94d71011eeb8927bc1f75efef4-20240229
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 72929498; Thu, 29 Feb 2024 22:38:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Feb 2024 22:38:19 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Feb 2024 22:38:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hq68dgCGsy8F59ysa3+gnTsY/Og9dm9ahgLilxLPsdL6mPUVLCW8xsKKyGEXoyjUm3XWidpR/7gAKuUWIxEOYNcvTUM0iN81UnS4uKBmjBGUYGQg6hh+RfiSoa0zOol5nqIISegmZ1GayTilQKIGbnl2fFc/zpArNJYadBgT4z9G2e2BA2VtHQaM0/RXYsjUbcDj/ckM25JW/rAZ9uV64baGZe9pzDbIXsLT3KeuezB/zwXxKggHHueJG8ILoONeWa+CLa1UaS87kAUMopXgEHxdfeddiLlo5Gdc/EZDdDhmaVdaI1Th2V96SG8leBtn312TgsIHOvHBElpgq1rmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlM/C4EBblM/ynGdr6+EzWFTrziGhZOO8nPLLzR4MyE=;
 b=obgP85UJro21dmWxkLX2HUTBU68NruiZ5kDzLUlP/+axESPLS8BPHVqiWm/BHwokB9gPTdi7FdfundG6469gWRppmP4Lb+8Lcsy6Tck4aBBrsBQ57CpPCgLh7KwaJJWUaNh8HNiiqOJABeWvDHpKSBcy9OUyQbN7BYffkRnF4pD9cVYt+8pkXLdNHqBH8JTVBb2hLr+oZitUnK0LeVgFCpxGyHvAMZVzl3jSMJzPPfykM3jL70ksXUSQaYEfMjxaTlbjIgmpQrgPqWnhiqxkX1A5xF1cp3xf7KQSQoWMDdrIPU2zBOc8kk4jIhwGYSHu8rD/SEw5TpFRt4IgeBIEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlM/C4EBblM/ynGdr6+EzWFTrziGhZOO8nPLLzR4MyE=;
 b=QdmJxtSrb8xMUrFfHg2Qv/fXOjo7t1tC4ytjYqmlciChWDvKkeGPi+wgk7oSIA0yLZH70r3MVLjDZGy+hBJCdDyDA0DyH4+VdzX/n7WrJ0QHs/125VjM6c5rCVx+icuCspwOt4e2E9uJs+Lt2HHIJrd+9MZT64hGTorlMk+8SvA=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TY0PR03MB6476.apcprd03.prod.outlook.com (2603:1096:400:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 14:38:16 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%5]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 14:38:15 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "fshao@chromium.org"
	<fshao@chromium.org>
Subject: Re: [PATCH 1/3] dt-bindings: display: mediatek: gamma: Change MT8195
 to single enum group
Thread-Topic: [PATCH 1/3] dt-bindings: display: mediatek: gamma: Change MT8195
 to single enum group
Thread-Index: AQHaargErVlcCum9EUy7lchSFI1QPrEhAnUAgABh9AA=
Date: Thu, 29 Feb 2024 14:38:15 +0000
Message-ID: <30e7d78a5ea266c39865d78ff6eb7eede2a01f3f.camel@mediatek.com>
References: <20240229023522.15870-1-jason-jh.lin@mediatek.com>
	 <20240229023522.15870-2-jason-jh.lin@mediatek.com>
	 <a717b209-ec31-4a43-a93c-47d65a464c80@collabora.com>
In-Reply-To: <a717b209-ec31-4a43-a93c-47d65a464c80@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TY0PR03MB6476:EE_
x-ms-office365-filtering-correlation-id: 835c3767-775b-4468-46d3-08dc3934107d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 89UymKXJsbJsRJCYAd/KXaT9XWQrzrFaw3h6vb/cPPxIMSeTuOuXQwudYC11z21HvPrxN+hWbxa3s58kUqMzxqsY3vAA0g9ftlRTioPlZTSyP9pBcG/uO+YyUFwQCR0bWu7+BoPRf1tT33hpYpvubQ1OO4nlbioNRcn5F/wGTJB5Woz+DrCIG1W0eGb7iUgDbQc9O0UDhYGXzmHn0MdNuVMgsY5Dp7W/mxhaXijL3TOHtvylbGTVxGVn8NEO11PFzPW0cIeNMuOLopeuBL65WJolvBsXLWtyx5G/VnAIihq+xvQooWshoCQoqCMu3T6RgC7KVzFTrB9OvzUqpD+U/qrsOvxZak0ZZ4y84QfD2zzWI/c84DbNZXJLc5/aWy6WSveOb4g6qxNW0erpIQL9ML/peeblZ/eULoak+pILVOQk/Go7N8ks2aEPwO0Aog/kU/2nu+Mb17y9bVXsS65t7IZgl9K/IltmD7CxLvZS39T8IqN2r3MTmJDBUUUXpR2wJ1egRTRhnjXcmm0bxXWwviS3JbV07F6ycZgCt4+bodYVD6DITj0eoOcZjyl67CnC7wCG9cM2niJ5Ja5oxqKmiWgB6W6++z9q4T4gLAxG7l4giPHvyDOSSbjopm44mfoL2qkLxD40AE2qK5dJmsZF/ExTAJQRQj6g7/hgHgip2zb9rV5UzSFnes8cabwd3ePbIS2/4Y8zcLQrSfCWRGxhudX9sbD8XEJun7GcIYYfPvI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVYxSnd0N3drRHdlRVpEelUxaGNBRkRUVkxmdHVVajlXODAyRVZXQ0E0clg0?=
 =?utf-8?B?VUtKdVpPdzZFR21VWkI1R0tjdDNlOXdyY2ZJdlZzdjFudmtrYTZJcUwraHZy?=
 =?utf-8?B?UDZkc1hJR3lORTZNNXFHaGthbzkyUVYzOEhFdFZzckpRWGtDeFBxVlVVUFdv?=
 =?utf-8?B?bEVmOGVRQ1oyMW9Sc3EzVDQ4S3JHakVmK2tTdU53UHM4MlF4bHF6Z0xPeW43?=
 =?utf-8?B?MmJlU3M3ajVXY0lEQWM0MTBtS29qWGlMTy9vWXUrbXEzUzh4TytIZXVVTElj?=
 =?utf-8?B?aDJacmxNL01kN2RMZVpia1A1TXQwaHdDZXR1VC8vanZOMnJoSlg5QlV6NXNO?=
 =?utf-8?B?SHEyc0Z0YVZ2d1QvY0JIQjc5Rm1ackl0aG9mNGRuQkY0WGNUY2pkVVRLWW9B?=
 =?utf-8?B?LzJ2SWVOb1NDbWh0RzZSTTNOOFBxZU0ybnVMT3JBWHh3eXByZFd0WTYrdXdu?=
 =?utf-8?B?ZjQ5cmlCOTh6WUt6V3Y0TStucytYMXdycy8wUXpCMWhnSGtJTGREWDJhNVpS?=
 =?utf-8?B?Zm1ZTGNaa1p5SXA5elFRRmdOOUxBRCtON0hyUk1KWUxIOEE3K3AwWFdGd0NT?=
 =?utf-8?B?TjhZOXZNYUY2eHlhT2hQMmw3SktGRlc5NWZkTzNxMCt6RzNQclB4TFphNmVC?=
 =?utf-8?B?cEp0bVl4OVdINXkyaHViZTVoRXV0RSsxSjhSTm5CNzNnT2cxdVVCNm5GbWVQ?=
 =?utf-8?B?UWFySVFkSERFeFRhVEtmTW5kY2RRdFVDZWNwUzIwMU5keE5GL0Nhd1NQQ2h1?=
 =?utf-8?B?eVdvSDUyekYyVGlraGRxS3ZVSURKOEJJRmhnenZVTUZzWjZTb0xsQnA2aGxw?=
 =?utf-8?B?eGQyTHh4bVdKc1V4WHZlYUhuTnE1NkJKc0pLNGVMdnN2T3FIaFJMcUg1Q0wr?=
 =?utf-8?B?bUt4Znk3R2l6eEFDOWNsM3kwVG9RU051NGEvRlVSaTIyZmRoWm9DdWNrWFBk?=
 =?utf-8?B?bWJGaC9LakF1OXV2M1lPL0cva0JhdkZIemFDK0NlMzRwNHptV0JtbHNVSmht?=
 =?utf-8?B?MWZZR2N6MWRDL002L094RXZjYXMvMXBvZ1Y1c2hWN1R0MEgzVUZNMlFNQ1R0?=
 =?utf-8?B?MFFEejlITWxkZm5VR0t1MnBIOWxZL2R0cGhpeW4vNDZLNTlwQjczQ2EwNzc1?=
 =?utf-8?B?MzhqcmJteExncHEySDZFenowdEk1OXFLVzh6VWpNOUZnWDlybXVtTVJsbHBP?=
 =?utf-8?B?NkhRaDl2OWVyL2RYdU80ZlFmTUdDTWFJNHRkTTRReVFlVW1tYTMrQitGR1cv?=
 =?utf-8?B?Z25BVWtRUzdGZmoxYWtGZ04rK1czRS9rUzdjaTZHUUkvK1JQenhQUjV3L2hF?=
 =?utf-8?B?NGNWV3d5VlllazIrT0J4eThvQjNHZ002S2hnMStFM3JaSjJFWm5UcDVtdmdx?=
 =?utf-8?B?WXp6TGdZV3lwdUVydHdtME9FVmQvMEZ1RG1MTCtNTmVNZi95UjJRN0RDUjA1?=
 =?utf-8?B?ZFRGbS9QS3ZWY1haOU5jOVBIei9uRHFXZ3dtTSszc2hrMklGM2RjZXpSNHZB?=
 =?utf-8?B?L0ljdE9qcDZpZnRBWW9qVDFyQXhUSXJwb0E4dUU2WTdQeGZvOE9zbjFraTdY?=
 =?utf-8?B?T3N5b0VvY21PQUt4TTh6Zzdub2Fxc2dyazJWS2RvS0ZoSFp2SGs3NWRCNERW?=
 =?utf-8?B?bjN0czNYcE44QUpKeXVERDBOWDRLcFZKU24yL1F4d3pUZG9kSkFZZG1NdUpV?=
 =?utf-8?B?enhkdnJOUmQ5TFlVaU9RRklob3dIMUFYOHlTeGRZdHh2eUVPRCtwRlZMWnEv?=
 =?utf-8?B?aDcwbmZJZGQ0NUtQTGlSUkcvRk5jZHBzQ2h3VUxyVktGb2UzV2R0UDJ4YlNY?=
 =?utf-8?B?M28rVmpGbXVzV2FNNU42UHpUcTNna29RSWMvKzVOeGZ6R1Z5TCt3THIwYkQr?=
 =?utf-8?B?ZFZIc1N0U2tXbDhHVjFWK1RFVy82a3ZjQ3oyak0wcllRNjhTaEhwQTFQcno1?=
 =?utf-8?B?NUV6U2pJZy83eElxSXpVN2lEWnl4cjhydXpHZGNtME94eHBTTmxOUVFPcWFq?=
 =?utf-8?B?S1dHTXR0QmRpT0pBRlFrVjBiSFg3RVZ1cEs1S0M2UXZidERjTnBxeTZYKzNE?=
 =?utf-8?B?RWYwcU5uNGVScTMycWVuRG5DL3h3WllpNWVsZnVmRGZEQm5rN2dMN21pR0Vs?=
 =?utf-8?B?b3p3cVU1VHozS0QwRm9XZEswcjlFdUI4SzQzbTlseGt3b0pkOUMrdTU1U2Ew?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CFA61717F13A24AA0F8E01CB92C6E15@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835c3767-775b-4468-46d3-08dc3934107d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 14:38:15.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLLo5u479wVMHf6EVn35durC7zwGVI1XyJoSvhz2F/X3AQoBnBuMaxvKudBN6DW+crGxuma+cBYS97EnWvROnPZZsdZuebg885v/xQOErco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6476
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.915300-8.000000
X-TMASE-MatchedRID: HXSqh3WYKfunykMun0J1wmjZ8q/Oc1nAYefZ7F9kLgsNcckEPxfz2OLB
	DcjMHcx7UmsNbSHn8eDiHh4sec4woGcjqh/h55+5A9lly13c/gHDx2NobQWtmwKzHKFHzLsJQ4j
	rKjBCIJIcJMmbFxRNaS+cjfRWggxq8ZTibkDR5X2XXOyNnX/prDoSfZud5+GgtRXhV8npIHSJ1e
	BSom+0i90mpA1Khc2MK4IbpqZ0H5k5pL1TtnjZ/p4CIKY/Hg3AwWulRtvvYxTUHQeTVDUrItRnE
	QCUU+jz9xS3mVzWUuCgZHIBpyeFpvp5x9rcb42hK4jc7k5li/mr5pdwZ8LIMrDev5FvCSXhftwZ
	3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.915300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B032E3F7F3909C380FF4D5938C391EF72556D601D843EEE2EC1FD905EEEB71BC2000:8

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBUaHUsIDIwMjQtMDIt
MjkgYXQgMDk6NDcgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAyOS8wMi8yNCAwMzozNSwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gU2luY2UgTVQ4
MTk1IGdhbW1hIGhhcyBtdWx0aXBsZSBiYW5rIGZvciAxMiBiaXRzIExVVCBhbmQgaXQgaXMNCj4g
PiBkaWZmZXJlbnQgZnJvbSBhbnkgb3RoZXIgU29DIExVVCBzZXR0aW5nLg0KPiA+IA0KPiA+IFNv
IHdlIG1vdmUgTVQ4MTk1IGNvbXBhdGlibGUgZnJvbSB0aGUgb25lIG9mIGl0ZW1zIHRvIHRoZQ0K
PiA+IHNpbmdsZSBlbnVtIGdyb3VwLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpI
LkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZ2FtbWEueWFtbCAgICB8
DQo+ID4gMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZ2FtbWENCj4gPiAueWFtbA0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsv
bWVkaWF0ZWssZ2FtbWENCj4gPiAueWFtbA0KPiA+IGluZGV4IGM2NjQxYWNkNzVkNi4uM2U2Y2I4
ZjQ4YmNjIDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZ2FtbWENCj4gPiAueWFtbA0KPiA+ICsr
Kw0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssZ2FtbWENCj4gPiAueWFtbA0KPiA+IEBAIC0yNCw2ICsyNCw3IEBAIHByb3Bl
cnRpZXM6DQo+ID4gICAgICAgICAtIGVudW06DQo+ID4gICAgICAgICAgICAgLSBtZWRpYXRlayxt
dDgxNzMtZGlzcC1nYW1tYQ0KPiA+ICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTgzLWRpc3At
Z2FtbWENCj4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LWRpc3AtZ2FtbWENCj4gPiAg
ICAgICAgIC0gaXRlbXM6DQo+ID4gICAgICAgICAgICAgLSBlbnVtOg0KPiA+ICAgICAgICAgICAg
ICAgICAtIG1lZGlhdGVrLG10Njc5NS1kaXNwLWdhbW1hDQo+ID4gQEAgLTMzLDcgKzM0LDYgQEAg
cHJvcGVydGllczoNCj4gPiAgICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODYtZGlzcC1n
YW1tYQ0KPiA+ICAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1kaXNwLWdhbW1hDQo+
ID4gICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLWRpc3AtZ2FtbWENCj4gPiAtICAg
ICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS1kaXNwLWdhbW1hDQo+IA0KPiBXaGlsZSBJIGFn
cmVlIG9uIGFsbG93aW5nIG10ODE5NS1kaXNwLWdhbW1hIHRvIGhhdmUgaXRzIG93biBzZXBhcmF0
ZWQNCj4gY29tcGF0aWJsZQ0KPiBhcyB0aGUgSVAgaXMgYWN0dWFsbHkgZGlmZmVyZW50IGZyb20g
dGhlIG9uZSBpbiBNVDgxODMsIHlvdSBjYW4ndCBkbw0KPiBpdCBsaWtlIHRoYXQsDQo+IG9yIGR0
YnNfY2hlY2sgd2lsbCBmYWlsIHZhbGlkYXRpb24gZm9yIHRoZSBtdDgxOTUgZGV2aWNldHJlZS4N
Cj4gDQpPSywgSSdsbCBrZWVwIG10ODE5NSBoZXJlIHRvIGZpeCB0aGUgdmFsaWRhdGlvbi4NCg0K
PiBUaGF0IG9uZSBkZWNsYXJlcy4uLg0KPiANCj4gZ2FtbWEwOiBnYW1tYUAxYzAwNjAwMCB7DQo+
IAljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1kaXNwLWdhbW1hIiwgIm1lZGlhdGVrLG10
ODE4My0NCj4gZGlzcC1nYW1tYSI7DQo+IA0KPiAuLi5QbGVhc2UgYWx3YXlzIHJ1biBkdGJzX2No
ZWNrIHdoZW4gcGVyZm9ybWluZyBiaW5kaW5ncw0KPiBtb2RpZmljYXRpb25zLg0KPiANCkknbSBz
b3JyeSBhYm91dCB0aGF0Lg0KSSBmb3VuZCB0aGF0IEkgaGF2ZSBuZXZlciBydW4gZHRic19jaGVj
ayBzdWNjZXNzZnVsbHkgYmVjYXVzZQ0KdGhlIGR0YnNfY2hlY2sgZGlkIG5vdCBhcHBlYXIgaW4g
bXkgZW52aXJvbm1lbnQgYWZ0ZXIgSSByYW4NCmR0X2JpbmRpbmdfY2hlY2suLi4NCg0KRmluYWxs
eSwgSSBmb3VuZCB0aGF0IHVzaW5nICJtYWtlIGR0X2JpbmRpbmdfY2hlY2sgZHRic19jaGVjayIg
aW4gdGhlDQpzYW1lIGNtZCBsaW5lIHdvcmtzIQ0KU28gSSdsbCBhbHdheXMgZG8gdGhpcyBiZWZv
cmUgc2VuZGluZyBiaW5kaW5ncyBtb2RpZmljYXRpb24uDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5M
aW4NCg0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KPiANCj4gPiAgICAgICAgICAgICAtIGNvbnN0OiBt
ZWRpYXRlayxtdDgxODMtZGlzcC1nYW1tYQ0KPiA+ICAgDQo+ID4gICAgIHJlZzoNCj4gDQo+IA0K

