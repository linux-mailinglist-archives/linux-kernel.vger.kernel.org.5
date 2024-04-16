Return-Path: <linux-kernel+bounces-146110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CCB8A60D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C021C2104A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B469110A14;
	Tue, 16 Apr 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RDQtA2L3";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fV5YDyf1"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9517A10A0E;
	Tue, 16 Apr 2024 02:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233694; cv=fail; b=N91PiP/bjC4rWcvNDhkcEeQ9BrlwJAhVkAj0LTLs7Gs5WNkE9/bMwbjWn2U7aYWxkFyoFbZLU08/aALY7IdjVgL2pNxkxxjcIfm0y2g15I5fvOSTtSFUZvv71ElXsgVwakixVlJmZC7iQL7DLd0+OGAlcRVu8HSgcn4/fLsQ6ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233694; c=relaxed/simple;
	bh=n0RQYfgoO2VcWDMdlQAx/sHKHIBHWllz6UFD8jhZma4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rwox6l6Mzq+g++hgrRN8W+hnQDRdwZh0A7zRTjkWprl90aJp1LLMVv6F+CuakksMBOo9bw5MVT4gJHTu00xY+lQzPqV+jS+gS25tTtOJxlQAv6iQ3+uAIXO5cy4TVh5X6FsOYm4bF7+1mDfte/b6ubzINMDhFqrSZcOSiOtWdXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RDQtA2L3; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fV5YDyf1; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 18258ba4fb9711ee935d6952f98a51a9-20240416
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=n0RQYfgoO2VcWDMdlQAx/sHKHIBHWllz6UFD8jhZma4=;
	b=RDQtA2L3ncYdll4tAgRpUE/sPA2x7/Aie8bt1HeOmxYU6yETicGPNvD5Fg+k6+iAr4TJZtt2pzTdVJSlyEzhj7LOSE+tZOtNao5wpv1qIHqlKwetxAZF0qJlMEZhXlyIokDDRWhlppegu8r1wz866eDB8wk3eVWsxBLpkJ6Oi8Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:fff43893-0e3b-4cde-80a1-b453bca7074e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:24cb3786-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 18258ba4fb9711ee935d6952f98a51a9-20240416
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2086391201; Tue, 16 Apr 2024 10:14:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Apr 2024 10:14:44 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Apr 2024 10:14:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxrxwujsk5spUvRvko87Zxh5XJhhspUFGDPk/gB+5FeBqqeCfV2I+9+Pct0bxEBk6x/zaPYWRSq318yzkhbuxBfeLU3qRIjoWE7PmU4EejptBz2dn5K4n22uhywj1aDD6TOcPVDGnjC/zKqqdw0cmRxwl1T6ebRSYErGqUsIGrroILwVKoip8fSZ+aC+dWKvlGa612hk93SZBBAZerXUwUsySjS5/OHWhJaHxPS91wRmM2kieNxnk/UNnhc2t2Cjfweor0kNEzW6ONCK7S8OPYinSvEJGgyoHPvbK5I1LS7Nai4PDy2Z5Zl1vEjyVmcskKq7UXVN1KoabAIN7bmqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0RQYfgoO2VcWDMdlQAx/sHKHIBHWllz6UFD8jhZma4=;
 b=YGdQSGFKHumqq/aniJl4Phoya2HQLpxuSndVqqJuMoEWfaZTaQAF2VF6GiDvteKX7cal9mSeOsU4Qt8lwIM8l81EXv+L/wbDYlpJ526UYCy19QtTQUccACn6cXnB5VcmGNjgdZbuQa1F8DcdPNUCy3KoiXWu5P1U8q/gkB2sHyqlqZPVbYdKAP6z7clo1OjkNEBfCIjIb/LcOhTstXVSbxd6Uq60YwenW9G6+Uxaq0gCMP5vTJBaL8dd1YpOfbnaxgsWbX1MTKaF7DDOIY5dHZcG5lmvf5KUWlHwB6bdlXijZt0qkoNQloj6H2PwJs1wtlxrbjTJVflxaFAEv6uY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0RQYfgoO2VcWDMdlQAx/sHKHIBHWllz6UFD8jhZma4=;
 b=fV5YDyf15yltvgEY6w/JmP/N8lAbjGrMupNRcpcqG4j/+3OHNL0wi8En+LteyRT6wBBtAviV01huJeiIGIROWm+VqpWhHO1zeF2AnRTzI2fRl2wEUZEAzUESjtEF7WAkwZ0ID20YtSHyPHBdQ49FgAadHQ+ENBSBre2TWVw3bwM=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TYZPR03MB7710.apcprd03.prod.outlook.com (2603:1096:400:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 16 Apr
 2024 02:14:42 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:14:42 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "maze@google.com" <maze@google.com>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "kuba@kernel.org" <kuba@kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Thread-Topic: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Thread-Index: AQHaj0XOIxnbbRpuOEqwUbC2K0Us3rFpz0sAgABZ6oA=
Date: Tue, 16 Apr 2024 02:14:42 +0000
Message-ID: <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
	 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
In-Reply-To: <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TYZPR03MB7710:EE_
x-ms-office365-filtering-correlation-id: 4de5f29c-8f26-46c7-975f-08dc5dbafa36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?NmxSaWNrTVJ2ODJqWDkvOTlFNUI5M0IyK3Q2VnhxQkdtMVZhK2hmQlNLZURy?=
 =?utf-8?B?TlZEUzhmbFd6cWhjZG02OHhVckVyemFPM3hjZ0JJZDRRRDllQ1J5TmYxdnox?=
 =?utf-8?B?dVpzd0pVbkJGdUxpUUY0ZG1jcjhYcTVaYkR1NHRHcmI1MmI5aG8yYW9RMWlM?=
 =?utf-8?B?VmpuWlFWelBaQXMvbVZmNFZYWDJJUDNiNnhwMWUzSi9pRjI4OW1DZ0RjTUpx?=
 =?utf-8?B?VnFTMW0zeGl2cGpxUW9adkpWL0xlM05TckV1TWgzNUlqQVlhbHJjWUxtOHJW?=
 =?utf-8?B?emgyTUhFUzE2V1kvQWIrSVZIQTNlUWNHVXM3YTVaTEFlR1VlM2JhTG05NUtm?=
 =?utf-8?B?SWxZNGFZWTBqdVYwajdzVUFReGJES2VJdFpKQ1ZWMlRIYXZGWDExNmRKMkJM?=
 =?utf-8?B?dHdiYTB1MHFlLzBQQzh1SFl3TFBwUU1CeVNtUXJ2L0FpTWh4engwMCtXYndF?=
 =?utf-8?B?d3ozVjJUcmhvdk9KdnlVZG43b2hpVlV2b3FpcGwyQzdacXJheGwrSzZ0U0lw?=
 =?utf-8?B?SU1Ed2o2R1dGckZRcERJMGkxZEJEbWdkRy83cGRFbnVjZkJEZEFmZGlBNXFW?=
 =?utf-8?B?Y3VvbzFHcThXNXcwSmQ2NEFRRkxUaUl3RG10dHFTN0UvaG1mL21JUkJXaEls?=
 =?utf-8?B?V1JYWklmYmM2dldpUmZaajhaYmYzV2pFdHY5UXZBMWJtcjFYYkhza2JkZWJj?=
 =?utf-8?B?OHpGckkvQkQ3YWE0NHh4MDRNYXlWU0NVUGZ1Q3F4UGVydVpFNCt1aWc1UFpR?=
 =?utf-8?B?M1pldnFCeUJDWVJMQTlINGZneXg1WVZ4OGJXZytmR2htOGJXL2NlbDlGNTQ2?=
 =?utf-8?B?VXhEVWxwNkh1RTcwMWdrR0x0U1R1VVQ5N0VSZzJ1c081bU5YUldybUx2MzNj?=
 =?utf-8?B?Z3BaRWNKbGtsQUo0cmp2YVM5SE5vcUVpWGlkUkxIUHAvVDZIZEh0R0U5bkRC?=
 =?utf-8?B?WlVIVDNzMUw2N0hOVUZWTVFicGxIRmdpNWJWVlZHWnMxZHk1bEt3NE1ZSFNT?=
 =?utf-8?B?Vkcrb2tKUHJkTkRYS2FXRkJsbW9iTTUrcFRnWE9jZXRLNEJVUElyaFBvVUdD?=
 =?utf-8?B?Y2dQUGFXbkd2UmJSU3RCcEVQK2kydXpOR2RHMXZIY0JCTzcxNFRzTUM2cklv?=
 =?utf-8?B?TVZGaVU5SmZNRWsrY2hvNzIrTzdLOGhqa1NSYlhiQVRUSE1QLzI2c3Bta3kr?=
 =?utf-8?B?S05qK1oyMnVNS0pNMUR1QTJ2a2lyT3FqWS9Bb044QnVWNnc4OFJoU2FLL29V?=
 =?utf-8?B?N21OVlpCczhQczB3SUwwTVhJTXd0dHBiaW1KbktkVHZ4YU9MbXRwbTBJVmF0?=
 =?utf-8?B?L0QyWGlpRFY1QTlSY0xKbXNEQmJuOWNSaW1JeTM2eXVMblMxTGZEZzFPbW81?=
 =?utf-8?B?dVY4dGoyZzlnb3U2Y3A4ZDJlT3liWEowcHZqdUdvVG92T1lMc1ZPcTI3clA4?=
 =?utf-8?B?NDloUjNJY0w0d1BFeHRrT09UazJNaVhTVThBTjVudzdLZ2paQWpsRld6dWlJ?=
 =?utf-8?B?RGxNZGtHTHdFNWR4cHU3MEhqeUxlUzVmbG5BMlN2QVJYc2FERXhKVm1KUit2?=
 =?utf-8?B?eU9JZ3IwdllDekFUMUpkMnRRSi9lNzVRZGl4aU9XUXpEQjZxTjJPQXQvaWxZ?=
 =?utf-8?B?ZXgwcVlmMXZaQ0QvdVdzRk9ZYU9OSlNNKzFJYjJjSE9OTElLT09FUTArQjlS?=
 =?utf-8?B?OVBKQk9LSm9PWitJNllhKzNRVFY3NmVNZE9zbnhxc3dCQ2xmT0cvaisyY2VP?=
 =?utf-8?B?NEllczA5YmFRYmdEWlhCejdtY0FieTNkUUhaRjlqaXVTK3dsL3U0MlJ3WTdC?=
 =?utf-8?B?M2x5UGw5TDZ6bEhpamdJQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWYrTjh0Uzh6ODB3a2RKUkhYb2Flc1NjQ3ZRQnp0dktjTlgzd08vcGsvL3Jr?=
 =?utf-8?B?S0RRdVp5cU1STjMvN05YYW1RUS9jYnNBSEJ3SVFvSldVb1FsNU8rQVNmVHcw?=
 =?utf-8?B?blJ5VWtLdHdCZVdKVU10dHU1YmV3VGpTek1SS2VNT0FNOWU1ZmtOcm81NzRQ?=
 =?utf-8?B?dUtLeXI3TFU2UVBMa0d1R1JlL045cy8wYjE4ZFk0VjlDRVprL3BYMHc0QkF3?=
 =?utf-8?B?NXg4S3pyUks1Y3FMQU03anpQNVBkQ3pXVFFJN1NpVElUbmZ4b3B4TTJFbk1N?=
 =?utf-8?B?QmJTNTdZSnI2ZHhkbUo1ZWZUc2kyaWk2YXdFMFp6alN1VVpZQ1A1TC81cHBk?=
 =?utf-8?B?M2tUWUZJWlJYVW9idnhzVm01aVNlMDlnVlFwcFROR2xmb2RINjJqQ3RFZmw1?=
 =?utf-8?B?WkRuczA2enQxSmFXNFlQcVkwVnJuSjZsQlNPcUpkOS8zSHQ2VVJsMnZyWTNx?=
 =?utf-8?B?OE1KR1NWV2UrVXRSWEV4MzRuZVlFUFZ3QXhZY0pEem1iUVoxOHFtV0JMRmVL?=
 =?utf-8?B?bmZQR2V0ZU93RlJZQlhhMW9FU01pV3BuemtmWjh3dEMwNmtIZG5kbkhQVmdF?=
 =?utf-8?B?ODVPU1pEaUxkS0h1YTdUN1JvTmhTYmxEZ1BLR093MG5RWnoyWHVMS3U5Z2p3?=
 =?utf-8?B?WTYwWVhudUVMdWh5UEZoVzdWN2tVTVdYdTRVVGl4Yjg2bmIrZjh0U2VHbFpM?=
 =?utf-8?B?OExmOHlNS1FjV1NoN2J6UGFCQWc5ejVCbktaS3RQRVV1ZkUyUXpOTEIvc0JR?=
 =?utf-8?B?c0xRUlhtYnJhbllZYThlUGF4aXlWNktrVmtsSUdEanNhY0RQY3lxS2x2U3NK?=
 =?utf-8?B?bm9wV3pvVG9XNndJZGJTZVljRVVJTzduNSttQjBHd2dWWnhzWHl1NFJUZlpO?=
 =?utf-8?B?d0Qwemt3OXFOSElldTVRODFSWCtsYnJOdHhOWGNFZk5jODMvRjM5MzFPSm15?=
 =?utf-8?B?Q2IxVFdrWTVnQnJkQ1IzMnFxSVRzalhkRURXalpvMVZ2T2cvbE1GUW5CTkRP?=
 =?utf-8?B?T2pGb0RSTmV1YXU3VFAvYy9FekJGeVp2bDI2VC96KzVGeHVkSHdSdVJkTVFt?=
 =?utf-8?B?cHlqeHNiMGVLTXR4eXh4S1IxZmMrc3pWck5IVUpmTENORkNxNk1GL2ZMVU9s?=
 =?utf-8?B?NDZ0MDFjSnZzU3dtaElZc0lWZWpGV2JqSWh4Vm5KenMwcnBTeStGWjVWSFU1?=
 =?utf-8?B?YWFIN0p3SDI5eEQzUlR6b1A3bVVxVDlqa1NHNVMvbGttdG8xc1N4M1NGVThq?=
 =?utf-8?B?Q0RtVVhjWWNlRU5oRXNBZldxTXFJYjd6c2VZbHdObG1XaEszTGRucXFDN2Vs?=
 =?utf-8?B?T2FXQ0JISmc5Qmw2S01KQ3Z5dGZBV1JkUGx6elhnM3lzcnlBejh4RUMyTXVD?=
 =?utf-8?B?VzU4U2ZQSm5HMXhQTG1yS2RWVEZFWnQvWWJlcEZLaWRDYjE0MCtwam9SdVl0?=
 =?utf-8?B?Kyt3OGdaRlJTZVRxYmN1UVowdzRCRFY2RkMvTTNoTnZOWWx3V3VaUmRiaGtR?=
 =?utf-8?B?WEh3Smp1citqVmttY2Vwb3VtcHBtakQ1NVRLQktJZzFOWjlVZXBreDh1ais3?=
 =?utf-8?B?L3FjVUd4S3YwbHRhZno2d09YS2xYZ3NWcEhPTHRTVVM1aFVDTDc2V1A1TkJC?=
 =?utf-8?B?TjdmQlBhMHlJckkrZ0Nwa2tvd0lqaFVQT1JlU3ZGL2ZVRU5GWmRybUNLemc1?=
 =?utf-8?B?QlhCd2tRNzJNWkhsUXRoNXJEblFCZkUvYjZCZWVicmF0R2c3K09pTWpkTmtQ?=
 =?utf-8?B?Zkk4R2FwczJhdmhoY3NBblNLTFRTSTJjUWErRVBCdytwYnB2QTVhUkc3RVgr?=
 =?utf-8?B?Z3c1OXFrT0huekhpQ0FXMnlLbFNpWGlpN3dqaFR5Z3RFSnlNNzFNMkYwTjV3?=
 =?utf-8?B?cXBIaXhsdkpZa1p0T0NyTGFQZU02b3BuMXB2Z0I5U21EUmtrYWg0ck9ld3dY?=
 =?utf-8?B?ZnZ6K2tIbis1ZnN6R29MVnp2QWtLMTNSa0NnUXlQQUZqbHVZb2t3aStrWFRT?=
 =?utf-8?B?bThkbVNia1FpZVhEQnpoTEhxU3dxTjNLWE1KcG9EUGlRd3cvMmtFdG56dHlx?=
 =?utf-8?B?cDAvZjlDL21jWWxaMCtmS1RqNnJaekIzWWZ0RzN1Vi9CYjd4bEM4aXhyQjlL?=
 =?utf-8?B?R0Q1d21UQUN1VkZQalhNT0NRY3c1WFhJamxQanFRWlZJQ3d4bkoyN2RCM0t3?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1F7FB36511570418F4E2949F9DF374A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de5f29c-8f26-46c7-975f-08dc5dbafa36
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 02:14:42.2416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTHeKf6eT5RXrHsrnx+gxJ5E2WMF/1AQA2p5MzUTY1Dx7/xomH/NQfdGzZJ4ZmKYw2fGLE9VEI0+gqDuppztkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7710
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--36.708500-8.000000
X-TMASE-MatchedRID: xcONGPdDH5r4OiVTWoD8RCa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2tnJ5tL+LbGON+tO36GYDlssNNczdXNJoiika
	0Ka6FTutgiMdpBVKZAyXquvz3fdpua7CVWvRLrdOjafQQYN4dhOWNJG9IamrcbJknz+3f3aX3AS
	8m+aRStobIcfXNjP3MJgWJyoAmvgTa8dcHlgqVBUhwlOfYeSqxkT7cMJfe6JsGW3hFnC9N1Rl6I
	4BzA6dSPVKsAG3RDYKnsrXil9KGFUVTzfvGG9DGuXBOQEKj7Tjo/OjYPAGsiiBQRBOQhaJimAIy
	Wr6xn5+CDlnKlWvogPMnvNott6lBSNC6BHwvPnAZ9FA+BlOSKkyQ5fRSh265U20Pec0W1lb/LQt
	dGC0+++LzNWBegCW2PZex/kxUIHW3sNbcHjySQa0hbOeGOMG1+gtHj7OwNO0CpgETeT0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--36.708500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D23B6A3E6C9C70D40BAC8105CED5ED03F39568F451279008EB0EB669DA8ED3712000:8

T24gTW9uLCAyMDI0LTA0LTE1IGF0IDE2OjUzIC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIHNoaW1pbmcuY2hlbmdAIHdyb3RlOg0KPiA+IEZyb206IFNoaW1p
bmcgQ2hlbmcgPHNoaW1pbmcuY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEEgR1JPIHBh
Y2tldCB3aXRob3V0IGZyYWdsaXN0IGlzIGNyYXNoZWQgYW5kIGJhY2t0cmFjZSBpcyBhcyBiZWxv
dzoNCj4gPiAgWyAxMTAwLjgxMjIwNV1bICAgIEMzXSBDUFU6IDMgUElEOiAwIENvbW06IHN3YXBw
ZXIvMyBUYWludGVkOg0KPiA+IEcgICAgICAgIFcgIE9FICAgICAgNi42LjE3LWFuZHJvaWQxNS0w
LWczODAzNzFlYTliZjEgIzENCj4gPiAgWyAxMTAwLjgxMjMxN11bICAgIEMzXSAgX191ZHBfZ3Nv
X3NlZ21lbnQrMHgyOTgvMHg0ZDQNCj4gPiAgWyAxMTAwLjgxMjMzNV1bICAgIEMzXSAgX19za2Jf
Z3NvX3NlZ21lbnQrMHhjNC8weDEyMA0KPiA+ICBbIDExMDAuODEyMzM5XVsgICAgQzNdICB1ZHBf
cmN2X3NlZ21lbnQrMHg1MC8weDEzNA0KPiA+ICBbIDExMDAuODEyMzQ0XVsgICAgQzNdICB1ZHBf
cXVldWVfcmN2X3NrYisweDc0LzB4MTE0DQo+ID4gIFsgMTEwMC44MTIzNDhdWyAgICBDM10gIHVk
cF91bmljYXN0X3Jjdl9za2IrMHg5NC8weGFjDQo+ID4gIFsgMTEwMC44MTIzNThdWyAgICBDM10g
IHVkcF9yY3YrMHgyMC8weDMwDQo+ID4gDQo+ID4gVGhlIHJlYXNvbiB0aGF0IHRoZSBwYWNrZXQg
bG9zZXMgaXRzIGZyYWdsaXN0IGlzIHRoYXQgaW4gaW5ncmVzcw0KPiBicGYNCj4gPiBpdCBtYWtl
cyBhIHRlc3QgcHVsbCB3aXRoIHRvIG1ha2Ugc3VyZSBpdCBjYW4gcmVhZCBwYWNrZXQgaGVhZGVy
cw0KPiA+IHZpYSBkaXJlY3QgcGFja2V0IGFjY2VzczogSW4gYnBmX3Byb2dzL29mZmxvYWQuYw0K
PiA+IHRyeV9tYWtlX3dyaXRhYmxlIC0+IGJwZl9za2JfcHVsbF9kYXRhIC0+IHBza2JfbWF5X3B1
bGwgLT4NCj4gPiBfX3Bza2JfcHVsbF90YWlsICBUaGlzIG9wZXJhdGlvbiBwdWxsIHRoZSBkYXRh
IGluIGZyYWdsaXN0IGludG8NCj4gbGluZWFyDQo+ID4gYW5kIHNldCB0aGUgZnJhZ2xpc3QgdG8g
bnVsbC4NCj4gDQo+IFdoYXQgaXMgdGhlIHJpZ2h0IGJlaGF2aW9yIGZyb20gQlBGIHdpdGggcmVn
YXJkIHRvIFNLQl9HU09fRlJBR0xJU1QNCj4gc2ticz8NCj4gDQo+IFNvbWUsIGxpa2UgU0NUUCwg
Y2Fubm90IGJlIGxpbmVhcml6ZWQgZXZlciwgYXMgdGhlIGRvIG5vdCBoYXZlIGENCj4gc2luZ2xl
IGdzb19zaXplLg0KPiANCj4gU2hvdWxkIHRoaXMgQlBGIG9wZXJhdGlvbiBqdXN0IGZhaWw/DQo+
IA0KSW4gbW9zdCBzaXR1YXRpb24gZm9yIGJpZyBnc28gc2l6ZSBwYWNrZXQsIGl0IGluZGVlZCBm
YWlscyBidXQgQlBGDQpkb2Vzbid0IGNoZWNrIHRoZSByZXN1bHQuIEl0IHNlZW1zIHRoZSB1ZHAg
R1JPIHBhY2tldCBjYW4ndCBiZSBwdWxsZWQvDQp0cmltZWQvY29uZGVuc2VkIG9yIGVsc2UgaXQg
Y2FuJ3QgYmUgc2VnbWVudGVkIGNvcnJlY3RseS4NCg0KQXMgdGhlIEJQRiBmdW5jdGlvbiBjb21t
ZW50cyBpdCBkb2Vzbid0IG1hdHRlciBpZiB0aGUgZGF0YSBwdWxsIGZhaWxlZCANCm9yIHB1bGwg
bGVzcy4gSXQganVzdCBkb2VzIGEgYmxpbmQgYmVzdCBlZmZvcnQgcHVsbC4NCg0KQSBwYXRjaCB0
byBtb2RpZnkgYnBmIHB1bGwgbGVuZ3RoIGlzIHVwc3RyZWFtZWQgdG8gR29vZ2xlIGJlZm9yZSBh
bmQNCmJlbG93IGFyZSBwYXJ0IG9mIEdvb2dsZSBCUEYgZXhwZXJ0IG1hemUncyByZXBseToNCm1h
emVAZ29vZ2xlLmNvbTxtYXplQGdvb2dsZS5jb20+ICM1QXByIDEzLCAyMDI0IDAyOjMwQU0NCkkg
KnRoaW5rKiBpZiB0aGF0IHBhdGNoIGZpeGVzIGFueXRoaW5nLCB0aGVuIGl0J3MgcmVhbGx5IHBy
b3ZpbmcgdGhhdA0KdGhlcmUncyBhIGJ1ZyBpbiB0aGUga2VybmVsIHRoYXQgbmVlZHMgdG8gYmUg
Zml4ZWQgaW5zdGVhZC4NCkl0IHNob3VsZCBiZSBsZWdhbCB0byBjYWxsIHRyeV9tYWtlX3dyaXRh
YmxlKHNrYiwgWCkgd2l0aCAqYW55KiB2YWx1ZQ0Kb2YgWC4NCg0KSSBhZGQgbWF6ZSBpbiBsb29w
IGFuZCB3ZSBjb3VsZCBzdGFydCBtb3JlIGRpc2N1c3Npb24gaGVyZS4NCg0KPiA+IA0KPiA+IEJQ
RiBuZWVkcyB0byBtb2RpZnkgYSBwcm9wZXIgbGVuZ3RoIHRvIGRvIHB1bGwgZGF0YS4gSG93ZXZl
ciBrZXJuZWwNCj4gPiBzaG91bGQgYWxzbyBpbXByb3ZlIHRoZSBmbG93IHRvIGF2b2lkIGNyYXNo
IGZyb20gYSBicGYgZnVuY3Rpb24NCj4gY2FsbC4NCj4gPiBBcyB0aGVyZSBpcyBubyBzcGxpdCBm
bG93IGFuZCBhcHAgbWF5IG5vdCBkZWNvZGUgdGhlIG1lcmdlZCBVRFANCj4gcGFja2V0LA0KPiA+
IHdlIHNob3VsZCBkcm9wIHRoZSBwYWNrZXQgd2l0aG91dCBmcmFnbGlzdCBpbiBza2Jfc2VnbWVu
dF9saXN0DQo+IGhlcmUuDQo+ID4gDQo+ID4gRml4ZXM6IDNhMTI5NmEzOGQwYyAoIm5ldDogU3Vw
cG9ydCBHUk8vR1NPIGZyYWdsaXN0IGNoYWluaW5nLiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogU2hp
bWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogTGVuYSBXYW5nIDxsZW5hLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBuZXQv
Y29yZS9za2J1ZmYuYyB8IDMgKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvc2tidWZmLmMgYi9uZXQvY29yZS9z
a2J1ZmYuYw0KPiA+IGluZGV4IGI5OTEyNzcxMmU2Ny4uZjY4ZjI2NzliMDg2IDEwMDY0NA0KPiA+
IC0tLSBhL25ldC9jb3JlL3NrYnVmZi5jDQo+ID4gKysrIGIvbmV0L2NvcmUvc2tidWZmLmMNCj4g
PiBAQCAtNDUwNCw2ICs0NTA0LDkgQEAgc3RydWN0IHNrX2J1ZmYgKnNrYl9zZWdtZW50X2xpc3Qo
c3RydWN0DQo+IHNrX2J1ZmYgKnNrYiwNCj4gPiAgaWYgKGVycikNCj4gPiAgZ290byBlcnJfbGlu
ZWFyaXplOw0KPiA+ICANCj4gPiAraWYgKCFsaXN0X3NrYikNCj4gPiArZ290byBlcnJfbGluZWFy
aXplOw0KPiA+ICsNCj4gPiAgc2tiX3NoaW5mbyhza2IpLT5mcmFnX2xpc3QgPSBOVUxMOw0KPiAN
Cj4gSW4gYWJzZW5zZSBvZiBwbHVnZ2luZyB0aGUgaXNzdWUgaW4gQlBGLCBkcm9wcGluZyBoZXJl
IGlzIHRoZSBiZXN0DQo+IHdlIGNhbiBkbyBpbmRlZWQsIEkgdGhpbmsuDQo+IA0K

