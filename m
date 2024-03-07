Return-Path: <linux-kernel+bounces-95160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA063874A15
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F8A1F24F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513B82C9C;
	Thu,  7 Mar 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WYI9UWUT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fdzwNBiq"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC982D74
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801228; cv=fail; b=WjKLw8zKkljrIpMNSPUrDkafcDRL5Utjp/RbXPEnTr3Ll6W5aaY/oxXsuwT83E5UvcX0BNAToYjct7wYHeP4Vd9cFLFuo6B8PowJ3uO2PpIowGjrKcaSvUjedBjvayZ6em7h4SmDG/0AyrNObGVZyR/VGPJ1BWYxyTklDVYuBC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801228; c=relaxed/simple;
	bh=ZfDq6LU8XWgS6OEH30SctqJ1cZIq6FEcruE6LrbNhYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CW5KLl3/cQ8QKjiujaCRRHxMsgyhD5QCjznFjtxb9Hwqk05W6XSJMx2GUXbcxCEXdxm+SdrkReq8kTsbwplvWS0i5eYJsv5JRyjwgBjMGv+Yf51NAwwhl7vjJGflvH3CQ3qZIMYVZ9jYFH/d0icP6OgYx6TVRSDqS4i87q+P7i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WYI9UWUT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fdzwNBiq; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 40199c38dc5f11eeb8927bc1f75efef4-20240307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZfDq6LU8XWgS6OEH30SctqJ1cZIq6FEcruE6LrbNhYE=;
	b=WYI9UWUTsOpfJVZ54iM/8D0Cm0o1wQiIetS4htmLMsJuTiNj9eO8vBgU8OUcLdiYYRhEslitn9YJBqHIEtpJdFQFw72nFRE8dHOYmdgO/DmTaF/5PEV6LjQTccdzuCyK/gmNwxCC9pPn5IkyUrqcrMCSJUIEWX+etvMG/SWyrNs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:7eae10cf-3762-4615-b3dd-eadc1a81eddb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:18572090-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 40199c38dc5f11eeb8927bc1f75efef4-20240307
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chunhui.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2096826398; Thu, 07 Mar 2024 16:46:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Mar 2024 16:46:53 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Mar 2024 16:46:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exIehf+2AqArSRhG4NPR18O9dUVUTYi07mZJjrwp0vqDqgwoB6hyUM/9+LhhK0FB50YRf74e4bke+sJtdhbjOVMdEug/9J4hJOKPH7TrTk6W/6WNLiKGJiG/nDWXyb8k6mYQNm7Wly48uQdPeYedQUx5N87LgL29EUkw5hinqtPqT6HWEasIb/rPb/9m7g8vkz/89BBgP3uzzu7jnOUx+N12TQrM8NuSQgOwR/FxgvreP2rtefz2tB3jArwhpAqEXHuMb9QmhiJ9kwfXHPom6of0BhsYtKNuOvjm7nOffJAHgctIJBpsAABXh9JgQ8Nmf3rcXDqIBMfP/m+YzPBRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfDq6LU8XWgS6OEH30SctqJ1cZIq6FEcruE6LrbNhYE=;
 b=bAXAjXLpvxvd2ZU/lrQN9ln+BbjxAnGyOwApFRyMKrMZeIbIL3GuiYP4czM6DNL6Jko01gqVEIUD1hcTEQXHXgm7YuXQvsEYvhEduGnvU5ZXX55KpV4PJLDGcVlRlJ+1+h2+2iIYovy2JlMYl/416GN91brRPms0n1mfXCaf6dSUNizdfXb1t/4DkmWYY4MvOvhE9u4o3jODPAAiBtqi0DxT6VIO6sbEUWXEairxg8SOlPPvUe0IblbNt2qLs/1wFXCVkpxB/kziXRBrIpEsNBn5QU4PP6HQD83lZ6Kk3Nq0AESrHqCGOL0qSDSNOJbx1XG4v9WRhVLQKnT2PNeFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfDq6LU8XWgS6OEH30SctqJ1cZIq6FEcruE6LrbNhYE=;
 b=fdzwNBiqOojx/uzQ35jDs1zNysp/d2kDqI63xs7SfsegUYAXzPARQzC7YX4BFvIA+6ljb0BM77bb993oVFANfGCycb0Bm051690ffu2YQ5XIp4xPdHHsn4t54BdC1JZX2rixAXKn0w9Ec4EI/cE5RTMkuKfGknEsdT+58L7CxqE=
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com (2603:1096:301:4f::5)
 by TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 08:46:12 +0000
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::decb:a937:5a6b:736c]) by PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::decb:a937:5a6b:736c%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 08:46:12 +0000
From: =?utf-8?B?Q2h1bmh1aSBMaSAo5p2O5pil6L6JKQ==?= <chunhui.li@mediatek.com>
To: "nathan@kernel.org" <nathan@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, wsd_upstream
	<wsd_upstream@mediatek.com>, "pmladek@suse.com" <pmladek@suse.com>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "john.ogness@linutronix.de"
	<john.ogness@linutronix.de>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] printk: fix _entry_ptr build warning
Thread-Topic: [PATCH] printk: fix _entry_ptr build warning
Thread-Index: AQHab6pSUlPCvt9soEON1RsnKXXn87ErHOoAgADXwYA=
Date: Thu, 7 Mar 2024 08:46:12 +0000
Message-ID: <8ec174d7352459206c03192b12dec0d491da890f.camel@mediatek.com>
References: <20240306092647.16010-1-chunhui.li@mediatek.com>
	 <20240306194020.GA3711543@dev-arch.thelio-3990X>
In-Reply-To: <20240306194020.GA3711543@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5528:EE_|TYZPR03MB7867:EE_
x-ms-office365-filtering-correlation-id: c9d999aa-669e-420a-9faa-08dc3e830af5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvdSgfJ5lvObQoSsO09PYwr6fWswsDPDNXE/ysbnHr+JBDkMnkDmHxUzgR1BArhdJIHS3FTI38Xfa8QLshH/kwbTHqEN+rX0dvDl9OpjTWZeKmKEoQNmOzikld3LKjfVfmoJeK3/xSwMI2vVA0CJeYQgCLnwhYvPO17TgAucWaKa0XTp9AZKvAF/sBjaIWDOY2ukY+1eBrz5CrvlaX6jg4Xan/ZmWQ7HJ2dOf8geuO8Et2a2ObnARW6STbAnRMwwieViQoy0z2hkmS4tk2iYUrGvEBeQynxUXQ8x/3qcQIjLhAJ/8L+tgWHnrAsTD890ljIHbiuk2smS+U82qHznXm/fD8xoMJtmSQIWKOvTATgXTh4T6dVEP9fG59aofW+S/T4oDYGP9tEqeKB6fYmYkGftpqYs/Tyq71oowE9zhbICRIKDbKq0cUOeFcaLogw9qZlwEVHPdp4plCEHylWrU+zWJ8sNWzzuvoxXrvm0/VtfozvvhpWuwBwNh/X7MoCwwVlrM6o6Bf+ml36btZ1pXgN8ZApBAmvaqtgIrugHqVq6Np4bKeQhDfC+YMYjmMdDXDZpMs8kqXCUzp5ZZfHbjXSLRWGoUz6znBp5yynXzWRSmOR9oh3iDkJQtNMVRQMCVE1ZPyNx765m1uVcSHXq74gOv4Rg0gu2l2E/+7fpl3pfHUjF2f9ncanMHoDg/gGs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5528.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amNQdFNEQkdyRVhvVkx4bzZLM0tQQ0hsT3oxcGNQbk1kN3JGaHVxcUt4WFVD?=
 =?utf-8?B?SlZYb0pudW1UbTVsd1ROT1Nyb2pwc0N3cUQwSTdVcmREaHNLMHRESnI3V3o5?=
 =?utf-8?B?NFF1c0hOMDkySkR3MDc5WU15TTlGS2lzSFJLNWxucmhraFAzZVNZTmY4WjV3?=
 =?utf-8?B?MlprbGdOQ1NHZ0NHeS96QkZkUVFhRUhyR1M3SW8wNTd3ZWJORllLbDJkNmR3?=
 =?utf-8?B?L25mSXpBNW9LSnltMDFBWHh3S1NCaklyZi84WjJkUlZ2M1lWVmh4dTc2V1Nv?=
 =?utf-8?B?NTRPRzF0MUt6UHU2b2ZiMDk0em92QnFGTndsWXBVcUY4YU4yQ3VrTVdWVlFD?=
 =?utf-8?B?TGM2cTNmN1MrOHl6RGEvUlhZWTNjZWVLZTZCdlNaaUttMTRkYnNFRHllTGJW?=
 =?utf-8?B?cnJ5ZXpMOEQwSTM4TzhHWDgyYmNFQU9BdjUvczRoeTU0a3hQU1p6cWw0UGgv?=
 =?utf-8?B?Rk9melFqVUJsRW5hbHhmVXRRSUx5MGM1eHM4M2FZWTZJT2lQUDZTZ2R4UkVa?=
 =?utf-8?B?Ty9oS1NITUpDdnQwTGs1T1A2TkM2STczaUJOWTZzTjBmTlE0eVFreEt1ZUlp?=
 =?utf-8?B?dmx1QTBKejkra0xpanpPMXYxeElZc3pvSHErdXhrbnRJZlNGSFV6TTVpOW1Q?=
 =?utf-8?B?bTRqZUtWOTVqc1RsR2Q1WFUvM2E1MlpEZ1YzeTdBL0VhdGRCUEtEKzd6TThR?=
 =?utf-8?B?N09NQjNmcEhWTDM2Z0dzUDVEWDFkeU4ranNMdVA4N1AwYmd3VEhUTGk2dW5o?=
 =?utf-8?B?RnEyUzFhVlExdWFQYWJla3lzeU9pRjI2SHJXbkQwSlBta1dXdTVwVTh4ZGRQ?=
 =?utf-8?B?UUVmSnpTcTI1a1RUUmxvOEVxQWVFNUlPYzBUSTdCMHBTa1FKTTNiOU5wTi9P?=
 =?utf-8?B?V3pndlRYQnBXaG9mMmNuUTd1Zk1wZ1NaeFFOR0RndHVmbkY4N3BZR1pqOGZt?=
 =?utf-8?B?Sko3UmJWQk91dmJNczdsMmpnbUlVV1IvZHovem9sOG96WmFLSkFkSlltRVo4?=
 =?utf-8?B?UFZ2ZlJmcC92YmY2Y3lkT0xCSCthejF4UlU5aXBlbXgwTk03cklpT1VwMkNP?=
 =?utf-8?B?SEdaTjJiU2Q3bTEzM3gzNnkzSUFKZkpPaTB5T29iT0RvRFdTcHlUMllrU3Jo?=
 =?utf-8?B?VzdRVXJJZ0JxTGlvN0ZhbWVNellaYlZXWGJjTHQ1RWE4Mmt1R01IblhPWjhY?=
 =?utf-8?B?RzBTdm9tSllJK3RndUV5OUUvVUI4amtOVDc0N2dXeWVLUGE1em5zMWdpelJK?=
 =?utf-8?B?OHRYMWxacXBpQWdmalRSVUZRdEYrb2FhUzhCRzRXQi82UUF1bm5oVGFDUWNX?=
 =?utf-8?B?WnN0c1VrZFFKU3g5WUMwaFFsRnpHY0lucWYzTjJ2NGJ0eXNrc2prZi96bGRn?=
 =?utf-8?B?OWdiK0gxa3U1RERYUUxNZDJKdGVzZkVvU1p4VGJIU2g2alJ4UG91MGJ6Q09Q?=
 =?utf-8?B?akZHejFTWHBlc0c4T0RwbGl0VHQxZ3NrMnRhQWZkWmo3emxLK011aWNac1FQ?=
 =?utf-8?B?NHcrcElITDJXNjVhNCtEeW82MW9ydDVSeVVKbGhJaWgvcHh3TCs3ZEJMeHhk?=
 =?utf-8?B?ODJ4bkhXcGpYT1lWVzkrMG9rT0NaZ1VWQjhhaDY4Si92QXlnbW41NVJQTis5?=
 =?utf-8?B?cVpEek44ekFncEIwcFZheVd6TW9rRXlTS3N0SW9POVdxQ21LMzlNWHRsUWU3?=
 =?utf-8?B?V3hROU1BYWRRbWVlZTRJT0tDeTVWdlVZUEFtNGtLK0NYREpHUkZzRmdXSzA3?=
 =?utf-8?B?ZmNWYnFoQm1TL3RnWFZvRkpxMGdiTmpuaFNmaXgxVkZNck5BT0krb24zWlEz?=
 =?utf-8?B?ZmYzS2ZScUhZMmNrYmFOQ2VnSlZmSzBtMHdCSTU4TmdkTTVLMm4wU3MrNWhE?=
 =?utf-8?B?RGF4Nnhid2F5Z3NzNWJEeTJjdzlyckJ3RTdLQmtJdGMwcEdYZDdUYWNiVzB0?=
 =?utf-8?B?N2k4WkhlRkFMQ0prbXF6dzNMTW1oS0hUNWhqTXc5SUZsV3VJeVl4UGZocDRH?=
 =?utf-8?B?cTlyMUpwdTR6anhCblBwajJTdlJtVjlOZUNLNEJUcjdPVWx5K1BkK2M2YU85?=
 =?utf-8?B?OTRrYUg0eGduaCtMS0FRS0hJdUMrdTQ3dEVDaVhMcWg1T0Njc2htRTl6OEtG?=
 =?utf-8?B?T1BrUHdzdGt5NlNuUzJmRWM0Z2t1RWpYWU1XY3BaVXNUVTdPZ2NoTlFmL3ox?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1023C246FF109842AD2E50863A4A264D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5528.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d999aa-669e-420a-9faa-08dc3e830af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 08:46:12.5179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OxWqlMZTDXKlzlbKzgHgwU8iaraJTIvRsKQzlHGyNa5lhqvk1/AyR0b6Wb4hlYTqkC5g28Mra5qA95Z4wHhfFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7867

WWVzLCB0aGUgYnVpbGQgd2FybmluZyBzdWZmZXIgYWZ0ZXIgQ2xhbmcgdXBncmFkZWQgdG8gMTgu
MC4wIGluIGJlbG93DQpiZWxsb3cgcGF0Y2guIFdlIHdpbGwgZGlzY3VzcyB3aXRoIEdvb2dsZSBh
Ym91dCBDbGFuZy4NCg0KQU5EUk9JRDogS2xlYWY6IFN3aXRjaCB0byBDbGFuZyAxOC4wLjAgKHI1
MTA5MjgpDQpodHRwczovL2FuZHJvaWQuZ29vZ2xlc291cmNlLmNvbS9rZXJuZWwvY29tbW9uLyts
b2cvZmY5ZmM3MDJiOGMzDQoNClRoYW5rcyBmb3IgeW91ciB2YWx1YWJsZSBpbmZvcm1hdGlvbiAN
CkNodW5odWkuTGkNCg0KT24gV2VkLCAyMDI0LTAzLTA2IGF0IDEyOjQwIC0wNzAwLCBOYXRoYW4g
Q2hhbmNlbGxvciB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlm
aWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBPbiBXZWQsIE1hciAwNiwgMjAyNCBh
dCAwNToyNjo0N1BNICswODAwLCBDaHVuaHVpIExpIHdyb3RlOg0KPiA+IFdlIGJ1aWxkIHdpdGgg
V2Vycm9yIGFuZCBzdWZmZXIgYnVpbGQgZXJyb3Igd2hlbg0KPiA+IGVuYWJsZSBDT05GSUdfUFJJ
TlRLX0lOREVYLCBzdWNoIGFzDQo+ID4gZ2ZwLmg6MjIzOjI6IGVycm9yOiB1bnVzZWQgdmFyaWFi
bGUgJ19lbnRyeV9wdHInDQo+ID4gcmF0ZWxpbWl0Lmg6MzE6MzogZXJyb3I6IHVudXNlZCB2YXJp
YWJsZSAnX2VudHJ5X3B0cicNCj4gPiBrYWxsc3ltcy5oOjE3MjoyOiBlcnJvcjogdW51c2VkIHZh
cmlhYmxlICdfZW50cnlfcHRyJw0KPiA+IFstV2Vycm9yLC1XdW51c2VkLXZhcmlhYmxlXQ0KPiA+
IA0KPiA+IEZpeCB0aGUgd2FybmluZyBieSBhcHBlbmRpbmcgX19hdHRyaWJ1dGVfXygodW51c2Vk
KSkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmh1aSBMaSA8Y2h1bmh1aS5saUBtZWRp
YXRlay5jb20+DQo+IA0KPiBBcmUgdGhlc2Ugd2FybmluZ3MgYmVpbmcgZW1pdHRlZCBmcm9tIGFu
IEFuZHJvaWQgdmVyc2lvbiBvZiBjbGFuZywNCj4gc3BlY2lmaWNhbGx5IDE4LjAuMCB3aXRoIHRo
ZSBidWlsZCBJRCBvZiAxMTIwOTA0MSAoeW91IHNob3VsZCBiZSBhYmxlDQo+IHRvDQo+IHRlbGwg
dGhpcyBmcm9tIHRoZSAiYmlkIiBmaWVsZCBpbiB0aGUgQlVJTERfSU5GTyBmaWxlIGluIHRoZSBj
bGFuZw0KPiB0b29sY2hhaW4gZm9sZGVyKT8gVGhpcyBzZWVtcyByZW1hcmthYmx5IHNpbWlsYXIg
dG8NCj4gaHR0cHM6Ly9naXRodWIuY29tL0NsYW5nQnVpbHRMaW51eC9saW51eC9pc3N1ZXMvMTk3
Nywgd2hpY2ggd2FzIGENCj4gcmVwb3J0DQo+IHVzaW5nIHRoYXQgdmVyc2lvbiBvZiBBbmRyb2lk
IGNsYW5nLg0KPiANCj4gVWx0aW1hdGVseSwgdGhpcyB3YXJuaW5nIGlzIGEgYnVnIGluIGEgY2xh
bmcgY2hhbmdlIHRoYXQgd2FzIHF1aWNrbHkNCj4gZm91bmQgYW5kIHJldmVydGVkIHVwc3RyZWFt
DQo+IA0KPiAgIA0KPiBodHRwczovL2dpdGh1Yi5jb20vbGx2bS9sbHZtLXByb2plY3QvY29tbWl0
L2YwZjM5NWUwMGUyZWMzZjFmMjBjYTkwMjFkMTU1NGZkZTczZDU2YzkNCj4gICANCj4gaHR0cHM6
Ly9naXRodWIuY29tL2xsdm0vbGx2bS1wcm9qZWN0L2NvbW1pdC9jZmE1NzhjZGUwMzE0OTM1YzZl
YjVkN2ZhMTllYzI2MzkwZDQzMWRkDQo+IA0KPiBidXQgdW5mb3J0dW5hdGVseSwgQW5kcm9pZCBw
aWNrZWQgYSByZXZpc2lvbiBmb3IgdGhlIDExMjA5MDQxIGJ1aWxkDQo+IHRoYXQNCj4gd2FzIGJl
dHdlZW4gdGhlIGxhbmRpbmcgb2YgdGhlIGJyb2tlbiBjb21taXQgYW5kIGl0cyByZXZlcnQuIEl0
IHdhcw0KPiBxdWlja2x5IGZpeGVkIHdpdGggdGhlIDExMzY4MzA4IGJ1aWxkDQo+IA0KPiAgIA0K
PiBodHRwczovL2FuZHJvaWQuZ29vZ2xlc291cmNlLmNvbS9wbGF0Zm9ybS9wcmVidWlsdHMvY2xh
bmcvaG9zdC9saW51eC14ODYvKy80MmQxMDBiMDI1ZWI1ZjRhNDE3ODEzNDgwMTZjMTQ4ZTllOTEy
Y2Y5DQo+IA0KPiBzbyB5b3Ugc2hvdWxkIGp1c3QgYmUgYWJsZSB0byB1cGRhdGUgdG8gdGhhdCB2
ZXJzaW9uIHRvIHJlc29sdmUgdGhpcy4NCj4gDQo+IENoZWVycywNCj4gTmF0aGFuDQo+IA0KPiA+
IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3ByaW50ay5oIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9wcmludGsuaCBiL2luY2x1ZGUvbGludXgvcHJpbnRrLmgNCj4gPiBp
bmRleCA4ZWY0OTlhYjNjMWUuLjc0OWMxYzQyNTdmMSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L3ByaW50ay5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9wcmludGsuaA0KPiA+IEBA
IC0zOTIsNyArMzkyLDcgQEAgc3RydWN0IHBpX2VudHJ5IHsNCj4gPiAgLmxldmVsID0gX19idWls
dGluX2NvbnN0YW50X3AoX2xldmVsKSA/IChfbGV2ZWwpIDogTlVMTCwgXA0KPiA+ICAuc3Vic3lz
X2ZtdF9wcmVmaXggPSBfc3Vic3lzX2ZtdF9wcmVmaXgsXA0KPiA+ICB9O1wNCj4gPiAtc3RhdGlj
IGNvbnN0IHN0cnVjdCBwaV9lbnRyeSAqX2VudHJ5X3B0clwNCj4gPiArc3RhdGljIGNvbnN0IHN0
cnVjdCBwaV9lbnRyeSAqX2VudHJ5X3B0ciBfX2F0dHJpYnV0ZV9fKCh1bnVzZWQpKSBcDQo+ID4g
IF9fdXNlZCBfX3NlY3Rpb24oIi5wcmludGtfaW5kZXgiKSA9ICZfZW50cnk7XA0KPiA+ICB9XA0K
PiA+ICB9IHdoaWxlICgwKQ0KPiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+IA0KPiA+IA0KPiA+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcNCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwNCg==

