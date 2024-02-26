Return-Path: <linux-kernel+bounces-81016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF0866F11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE7E284A36
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113A7FBD8;
	Mon, 26 Feb 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TbSbxgRx";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nLJ2udLp"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D61249F8;
	Mon, 26 Feb 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938740; cv=fail; b=U/hQGRfTcbTRK1CQSYG849WY8Jt/5Rh1jbRidprOURA9qCi0oP+x15TfVAHUk7siEvVstjbWvA8nhc7XikOEPXnafuWeVhBukgdINuM8HCNBjC+NgqLj/eQl4Ga6+l0tXaB7XCMEZc5KyeGkgnDajybjvt9BQs+hrPYsVqDKC34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938740; c=relaxed/simple;
	bh=WBymQs/0NQP1/hLGUvYsMcVyKLedWvB+raujBaQLL+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pVsiSiplIIZkZ08ukSgqfWO4wWu4ZBDCMWoBB3MEzRsdBlAoWkpxviYPf/XQkH3f9DdPpiDzaYcYKIbPtjASjnx/eCo8Ai09LjYKkTP2pGndULpB2rUlurpcV3txjApXo6YLQWl3Ut9U1aA5M/PCYSUROgQOBO/TXk1UMurMRn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TbSbxgRx; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nLJ2udLp; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1fd15edcd48711eea4ad694c3f9da370-20240226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WBymQs/0NQP1/hLGUvYsMcVyKLedWvB+raujBaQLL+w=;
	b=TbSbxgRxunNTXo5O5arJtVaZdhUUucF60HLF75lqDpAC5A83dkTlXmN+0VriOEeg7lFnhBtEpUKIOKG783cv4QeFn769z3daX2yrJeBlpKNzjRmsK+TXqNi0GDn8WY0DUNM/Qv5k7p4VpnQ5vBUVP7KwGBSUL9Mq8s6FBXaT1IM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:cccdf976-569f-455c-8dd5-2c85f6cdb99a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:bf9737ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1fd15edcd48711eea4ad694c3f9da370-20240226
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2109541051; Mon, 26 Feb 2024 17:12:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Feb 2024 17:12:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 26 Feb 2024 17:12:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfEvWIGIX1ICBtr+kqKmjrgJt506APrAiNSHVbcn58pfIQVCUBmN05MVfgtdRmQL8CbF0Z39o4iZjMN5GR5P79cnoVao8MvEoD9yb/+yDwtp9zdwgwS3Sn6nmZrY9S3LAXBVKesGB1mP36oa4NwGhXxrGLwkNh4K1V3QDAvjhoMBuKRMLxxhfn+ZiRm9ADR4jK36xjGtcvB2FeVpkUpIGgETs1W/KKvo8Bu7igIPfRnxhhMHEG4epyeufh2Z8GVNeyNyyptyS0vRUpbYhkKvf/7tahUMzHfk+1AAZkp3IUgovsHqNbVS8PxpsD0mK8V4SeIVm8b9EQzZjI/1G2ycHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBymQs/0NQP1/hLGUvYsMcVyKLedWvB+raujBaQLL+w=;
 b=BbIFRV1LJ/3YEDrfjFXy1dFA/jg0bahZfgNBT8ELnkQ/skoGLu2AMhBc1l8758eoUL15iRqql0RssPsx+3WN6I/5NCaNHvwRT29+lT1mGw254GBqvTgp+3TsnfF6sDKBF7p4e8Pg8Gx62tIrEYF6Dv9xGNvYnlBYmjOWbcqEKhHXN5nZCdsiND4HVEBl8rAztmNJJcaB/7Rp+gr8mfA9hKavbdMdCfPmmQHlmPcCGwEofWnAuoap378vB6FKoiZqIDv3h5ySgfQs8YHO7W47mtlDip0EE8hzFjQJgJVl76OsQl1dqSn0vi8yLiRSY/exOoM1WF5Dq8djPjx6sDePoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBymQs/0NQP1/hLGUvYsMcVyKLedWvB+raujBaQLL+w=;
 b=nLJ2udLp1DWR4/ALFfLVNA8oD06ZD0NyVh5tSMRv0Shfa63pJYuh24QKe73bNQzyXvhRrA8Z0XAjGFclcJtnpeYRWn2cRVF/vrZPJs5BCDl60sKY+H4taKuQac+/DDUq7wVnHc0WfeatdzmzYV2s2eUny/6VMt0fXoZKiaklxrk=
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11)
 by SI2PR03MB6028.apcprd03.prod.outlook.com (2603:1096:4:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 09:12:07 +0000
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::1738:63b:3631:4d52]) by PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::1738:63b:3631:4d52%6]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 09:12:07 +0000
From: =?utf-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?=
	<Chun-Jen.Tseng@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "wenst@chromium.org"
	<wenst@chromium.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: mediatek: mt8186: Increase CCI
 frequency
Thread-Topic: [PATCH v2 1/1] arm64: dts: mediatek: mt8186: Increase CCI
 frequency
Thread-Index: AQHZ5wSUhbsMZ16YIEu+XAqYgTN4rLCRwDuAgEGB1gCAAFsFAIBJvJ0A
Date: Mon, 26 Feb 2024 09:12:06 +0000
Message-ID: <f0403753f64eaa6e62249a1d787dc9153dd8e733.camel@mediatek.com>
References: <20230914121035.17320-1-chun-jen.tseng@mediatek.com>
	 <20230914121035.17320-2-chun-jen.tseng@mediatek.com>
	 <c9881e63-a52a-4d14-895e-9a14d31004e3@collabora.com>
	 <894594bd2adb156fa8f290f4e603edbccdbbcdab.camel@mediatek.com>
	 <679f35f9-3265-4b2f-8de5-df9460881de6@collabora.com>
In-Reply-To: <679f35f9-3265-4b2f-8de5-df9460881de6@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5351:EE_|SI2PR03MB6028:EE_
x-ms-office365-filtering-correlation-id: 80d00764-9f79-41ee-f8a9-08dc36ab015b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTwSTzRPrEUUOU9Xrr7cT1xwvWTcfh7Djk2ClzVHWCeXxwCM575hgem3X0TXtERIzQ5wchlqPlPnf+1IkWY7ud/UU27z3pXJiJZaID24CtJO5pHYVZTI62JMqkXdn4n959qKOno00DDKtZavFGij0xXZpmzNDgdhZ9Bie8tIpNWTXJU/v21x3Mf1Eq77bGbi+ERygtjzV4WhYzx89vyKiyf8feETfgj9kUzmfXYvTJlihYnY83i1hfDBXSu4cj50/pCK6OaCTChgkEY1qQcGhWlikAf555WBlA0FugAEmvbSPTwOcB0cpVkxNQl05rje/yxtYHD61+iDgMsWCKU4FmVyGyMceeVhFfgPHfWwSN+BWKqnCoeFaVhyR5PpNBxWsY5B4agVYr0BvF7+CiwOhcLN/h7vpdAPXVp/rlDjQY5G7BCvTOQmDJIbQLcU2wO/nyEjmsJ5bPeL2O/YmvFwwrm2o7rm2zwi4NRhEiIo8QLByiOLocSBUrWBzoKi5Li2rEb3ptRIxShSP+awrmxpkq12IxABCewqq2pXDBwq4rQIFTLv8b51ssszkAsUWfjHjMJKhuyfut/UMmz/pyiTyCOufaKu7B1bVWZwYrErbp62eAeq0GJaWL41Xobdx00fklXM9lV8OXuz7EuYrnoq+QzlJNIVB0h7/C1luecDSxK5gxSlnVlsKeuSYntDTiR0Do1MmsuM4TFHgwzcGfCEtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5351.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHcxeDVob3FHVU5iM3lsZ3c4ZHN3Z2tXNStST21mL3Vqb0VwVFJsVG9rK0Ry?=
 =?utf-8?B?UXcxUmw1ci91N3pMdWpMbmQ0eTNlcnhhc2hKRHY0bFdQczc3NEE0dnhxdHdp?=
 =?utf-8?B?RFdqVWNMYnM5bTVJbE1pNDNha0ZJMWU2dU50ZGgyWnhDVnRyRXBPMnZFNnJa?=
 =?utf-8?B?d1hjVHRqM0hkMUNnbDNKWjA5SGNocDN0K0d6cmVJNmI5Z1FsYlYwL3dUTWFM?=
 =?utf-8?B?dUlobnNIWDZYb2M3RE4yWDA0cEJrdWR2VXBZcUxyZVpjYnZpQmorQk5hbzVq?=
 =?utf-8?B?VzJnZ0s4RmVmTlEwTGlnZjdrbElzQjBUMkhlelBPWGRyZkU3ODB5RktIdlJ1?=
 =?utf-8?B?alo0ZFU5cVJCdTN4bnU4OGlnQk9SdHdRZU5ZTm5USzBZaDUyUG1RRktzcWZm?=
 =?utf-8?B?NmNtSFFpd1VoeUZVUU1XSnBVOHVQck0vNlBkaVdPZ2k0bnhyMFExN3E4T0VV?=
 =?utf-8?B?NWl2RzdZZlExc0FaaGdFM0UwM1l2SVlTaXJlVi9Ca2U1Skk0Y0dPL3gvaFRq?=
 =?utf-8?B?Mk9kNmsvNG4xbFJhMGdXaGx1ZXdvOHAwNmt1WDNNWmpGSEtUZmV5VnZnZy92?=
 =?utf-8?B?c2ptRzVla1h2elpxQUllaFBEc1c5em1XdDlpRE9lZXFWUTFEc21RK01NSk5w?=
 =?utf-8?B?bUFmL1cwMDFzZ2JFRXgyWWdmNklFS2hmYmhDRmVuU09mODZOK0FMb1JBQmhW?=
 =?utf-8?B?UkNnajdYRWVTY1VUTFl4Uis0TkV1dnQ0Ykk2Z3U5SkRFNGFqT24wYWZhQyt4?=
 =?utf-8?B?V1hkR1E5ZWYwcEsrSU9nM2dQOEFsSTZ4anhqcGpnR1ltSjhQOTlmby8rNWRi?=
 =?utf-8?B?TE5uM1g4dXlCYVRBcExrbFMrR0dJM0pWVHU1QzRTWWU1R3hDMTZ2bVR4MmNU?=
 =?utf-8?B?S1NpRkxCKzBZdG9zMkwveGorVkoyRW15b3paN3NLdWVUK2tBR2FHeWRLL1pS?=
 =?utf-8?B?RHJDTk9SRTlGV0pFOWJSbG43cFBoZnp3djhsemdyVGg1ckF4SG5hRGlqOGk5?=
 =?utf-8?B?ZzZMaFJub3hKTWNJSFZxYXpwR1RBblRXbUVoenpUKzdYMGJjWWwyNlNCckVr?=
 =?utf-8?B?RzJCeUJsc0RYRW9zcndnY1NFaEZhem5saW1tUGE4QUFVTWVhTERlR0xOcWlZ?=
 =?utf-8?B?WHdNVzdOVWdCOWcxQjdoVFFTcnpRVndoTUNLSlc0dFhPRWQvS2xVbmZqQlFI?=
 =?utf-8?B?TVJ5Q3FHSnlYeHhRZlFGcEZzZEVyQngvcS9xelF0dStYZFNCV00yWmZocTVs?=
 =?utf-8?B?NVh5ajlpLzR0Nzg4Rzl0R2lVUTdLVzJQZGowVzZIK1lKamtNak9WazhVdHI1?=
 =?utf-8?B?T1FmK0E0Zk90OGFub3A2d0FUR3pCdlBLaDN3YzUzdjhiSUdINUVSQUFGNERX?=
 =?utf-8?B?dTZnTWM3MFk1M3JidDNqVk5laC9XMkJFUUEyV0E5NitjTzBhSHF4UmJNdjVw?=
 =?utf-8?B?YlVWZkRmWi9CVEgrRWZicmRucnJqcnltcFBhTitrdUpJM0xhNE5tSTd6aW9U?=
 =?utf-8?B?ZHBmWjhYcUpIVjFFU1JpbFRqczBLNmlNYTVLZzdqdGRSSzlWVm1jdzdlZDl4?=
 =?utf-8?B?RU1WLzNKSmloRFdVNU85QWpIejA0ZVVKZ3VKMVpQTmZBcG42ajFHem9JU1JV?=
 =?utf-8?B?aW5GUWd1d1NlcVlOK1Z3SXdEVzJ3ZFQvQW4xSzZwZElqQXJPejF0NEZ5OWd3?=
 =?utf-8?B?a3pXdGMzMEdCWmxhaFpIcXo3cms3ZzgvMXpaKzdGV29wWTcwNm05K2JHdXVu?=
 =?utf-8?B?bzNKekpiTXJsL2lnR1ZWcUY2UTBsdW5PVTRzZjBIWTlFN0dabkt5VTRVYTRk?=
 =?utf-8?B?OXlLa2trQVlKWDZnampmNGVaV015Z2U3Q1ZjNUYzK0hqWUNlT0FkZDdnaEJx?=
 =?utf-8?B?cTJRRTVLWFk2bnkyT0dKckdMdmc4M2FXQ2VHSGswdnRMeU9pNENFUG5mQ3g0?=
 =?utf-8?B?SGFYTWMyVHUzODBkTHRWRWs4OWlXT0FUMUZFV205aVI1U1FWemxILzMzZHZy?=
 =?utf-8?B?RGRYWWNwUlBZOUVqc3NhRlZJcFFKdTA0cXBUUXkwVk5FbzliTEtpTHR5SWZy?=
 =?utf-8?B?d2ZuZWhmaUFKM1J4bzlsRTY0NW5sYndQSEFmUFBYTHFuZXRrMVFlSmtrdmNz?=
 =?utf-8?B?d0ZkcVhwTXBSMWNLUWUxbmtCM095VExhdjVPcXhHVVdPNVFPcGlaUXVxL1Nj?=
 =?utf-8?Q?y+G3uxc3wvo2Wz9sYUpbCW0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <597506B4B5AF824899601CF271970A19@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5351.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d00764-9f79-41ee-f8a9-08dc36ab015b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 09:12:06.9665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnd2OlP0Ybtbbe0EzbMhZrMhG3p51pnKO0b+HxPlNJHbs7SJI9oLadllXbdIOTVsnsCrviN4F+9OySEcL2QGcWLZyG9VsckvCccFRDZDK9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6028

T24gV2VkLCAyMDI0LTAxLTEwIGF0IDEyOjEwICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTAvMDEvMjQgMDY6NDQsIENodW4tSmVuIFRzZW5nICjmm77kv4rk
u4EpIGhhIHNjcml0dG86DQo+ID4gT24gV2VkLCAyMDIzLTExLTI5IGF0IDE0OjIyICswMTAwLCBB
bmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4gSWwgMTQvMDkvMjMg
MTQ6MTAsIE1hcmsgVHNlbmcgaGEgc2NyaXR0bzoNCj4gPiA+ID4gVGhlIG9yaWdpbmFsIENDSSBP
UFAgdGFibGUncyBsb3dlc3QgZnJlcXVlbmN5IDUwMCBNSHogaXMgdG9vDQo+ID4gPiA+IGxvdw0K
PiA+ID4gPiBhbmQgY2F1c2VzDQo+ID4gPiA+IHN5c3RlbSBzdGFsbHMuIEluY3JlYXNlIHRoZSBm
cmVxdWVuY3kgcmFuZ2UgdG8gMS4wNSBHSHogfiAxLjQNCj4gPiA+ID4gR0h6DQo+ID4gPiA+IGFu
ZCBhZGp1c3QNCj4gPiA+ID4gdGhlIE9QUHMgYWNjb3JkaW5nbHkuDQo+ID4gPiA+IA0KPiA+ID4g
PiBGaXhlczogMzJkZmJjMDNmYzI2ICgiYXJtNjQ6IGR0czogbWVkaWF0ZWs6IG10ODE4NjogQWRk
IENDSQ0KPiA+ID4gPiBub2RlDQo+ID4gPiA+IGFuZCBDQ0kgT1BQIHRhYmxlIikNCj4gPiA+ID4g
DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmsgVHNlbmcgPGNodW4tamVuLnRzZW5nQG1lZGlh
dGVrLmNvbT4NCj4gPiA+IA0KPiA+ID4gWW91IGlnbm9yZWQgbXkgY29tbWVudCBbMV0gb24gdGhl
IHYxIG9mIHRoaXMgcGF0Y2guDQo+ID4gPiANCj4gPiA+IEJlc2lkZXMsIEkgdGhpbmsgdGhhdCB5
b3Ugc2hvdWxkIGF0IGxlYXN0IGtlZXAgdGhlIDUwME1Ieg0KPiA+ID4gZnJlcXVlbmN5DQo+ID4g
PiBmb3IgYQ0KPiA+ID4gc2xlZXAtb25seS9pZGxlIE9QUCB0byBzYXZlIHBvd2VyLg0KPiA+ID4g
DQo+ID4gPiBJdCB3b3VsZCBhbHNvIGJlIGhlbHBmdWwgdG8gdW5kZXJzdGFuZCB3aHkgeW91IGNo
b3NlIHRoaXMgbmV3DQo+ID4gPiBmcmVxdWVuY3kgcmFuZ2UsDQo+ID4gPiBzbyBpZiB5b3UgY2Fu
LCBwbGVhc2UgcHV0IHNvbWUgbnVtYmVycyBpbiB0aGUgY29tbWl0IGRlc2NyaXB0aW9uLA0KPiA+
ID4gc2hvd2luZyB0aGUNCj4gPiA+IHN0YWxsIGluIHRlcm1zIG9mIHJlcXVlc3RlZCBCVyB2cyBh
Y3R1YWwgQlcgKGFzIEknZCBpbWFnaW5lIHRoYXQNCj4gPiA+IGEgMngNCj4gPiA+IGluY3JlYXNl
DQo+ID4gPiBpbiBDQ0kgZnJlcXVlbmN5IG1lYW5zIHRoYXQgd2UgbmVlZCAqdHdpY2UqIHRoZSBi
YW5kd2lkdGgNCj4gPiA+IGNvbXBhcmVkIHRvDQo+ID4gPiB3aGF0IHdlDQo+ID4gPiBoYXZlIGZv
ciB0aGUgd29ya2xvYWRzIHRoYXQgYXJlIHN0YWxsaW5nIHRoZSBzeXN0ZW0pLg0KPiA+ID4gDQo+
ID4gDQo+ID4gSGkgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8sDQo+ID4gDQo+ID4gVGhhbmtz
IHlvdXIgcmVtaW5kZXIgdGhpcyBpc3N1ZS4gQWZ0ZXIgYWpkdXN0bWVudCBDQ0kgT1BQLCB3ZSBh
bHNvDQo+ID4gZG8NCj4gPiBwb3dlciB0ZXN0IGJlbmNobWFyayBhbmQgdGhlIHJlc3VsdCBpcyBQ
QVNTLg0KPiA+IA0KPiANCj4gU29ycnkgYnV0IGBQQVNTYCBpcyBub3QgYSBudW1iZXI7IEkgYWN0
dWFsbHkgd2FudGVkIGEgYmVmb3JlIGFuZA0KPiBhZnRlciBwb3dlcg0KPiBjb25zdW1wdGlvbiBt
ZWFzdXJlbWVudCBpbiBtaWNyb3dhdHRzLg0KPiANCj4gPiBUaGUgb3JpZ2luYWwgQ0NJIHRhYmxl
IGhhcyBzdGFsbCBpc3N1ZS4gIFdoZW4gdGhlIEJpZyBDUFUgZnJlcXVlbmN5DQo+ID4gc2V0DQo+
ID4gb24gMi4wNUcgYW5kIENDSSBmcmVxdWVuY3kga2VlcCBvbiA1MDBNSHogdGhlbiBydW4gQ1RT
IE1lZGlhVGVzdA0KPiA+IHdpbGwNCj4gPiBzeXN0ZW0gc3RhbGwgdGhlbiB0cmlnZ2VyIHdhdGNo
ZG9nIHJlc2V0IFNvQy4NCj4gPiANCj4gPiBUaGUgQ1BVIGFuZCBDQ0kgZnJlcXVlbmN5IHNldHRp
bmcgYXJlIG5vdCBpbiB0aGUgc2FtZSBkcml2ZXIuIFNvIGl0DQo+ID4gd2lsbCBoYXZlIHRpbWlu
ZyBpc3N1ZSBjYXVzZSBDUFUgc3RhbGwgc2lkZSBlZmZlY3QuDQo+ID4gDQo+IA0KPiBBcmUgeW91
IHRyeWluZyB0byBmaXggYSBmcmVxdWVuY3kgc2V0dGluZyBkZWxheS9kZXN5bmMgd2l0aCByYWlz
aW5nDQo+IHRoZQ0KPiBmcmVxdWVuY3kgb2YgdGhlIENDST8NCj4gVGhhdCdzIG5vdCB0aGUgcmln
aHQgd2F5IG9mIGRvaW5nIGl0Lg0KPiANCj4gQXNzZXJ0aW5nIHRoYXQgd2UgaGF2ZSBhIHRpbWlu
ZyBpc3N1ZSBiZWNhdXNlIHRoZSB0d28gZnJlcXVlbmN5DQo+IHNldHRpbmdzDQo+IGFyZSBub3Qg
ZG9uZSBieSB0aGUgc2FtZSBkcml2ZXIgaXMgYm9yZGVybGluZSB3cm9uZyAtIGJ1dCBhbnl3YXkg
LSBpZg0KPiB0aGVyZQ0KPiBpcyBhIGZyZXF1ZW5jeSBzZXR0aW5nIHRpbWluZyBpc3N1ZSBiZWNh
dXNlIG9mIHRoZSBpbnRlcmFjdGlvbg0KPiBiZXR3ZWVuIHRoZQ0KPiB0d28gZHJpdmVycyAoY3B1
ZnJlcS9jY2lmcmVxKSwgdGhlIHJpZ2h0IHdheSBvZiBlbGltaW5hdGluZyB0aGUgc3RhbGwNCj4g
aXMgdG8NCj4gYWN0dWFsbHkgc29sdmUgdGhlIHJvb3QgY2F1c2Ugb2YgdGhhdC4NCj4gDQo+IEkn
bSBpbnNpc3Rpbmcgb24gdGhpcyBiZWNhdXNlIGlmIHRoZXJlJ3MgYSAidGltaW5nIGlzc3VlIiB0
aGlzIG1lYW5zDQo+IHRoYXQNCj4gZXZlbiB0aG91Z2ggdGhlICJiYXNlIiBDQ0kgZnJlcXVlbmN5
IGlzIGhpZ2hlciwgZHVyaW5nIGEgc2NhbGluZyB1cA0KPiBvcGVyYXRpb24NCj4gZGVwZW5kaW5n
IG9uIGhvdyBtdWNoIHRoZSBDQ0kgZ2V0cyBmbG9vZGVkLCB5b3UgbWlnaHQgKmVpdGhlcio6DQo+
ICAgLSBIYXZlIHRoaXMgc2FtZSBzdGFsbCBpc3N1ZSBhZ2FpbiwgYW5kL29yDQo+ICAgLSBIYXZl
IHBlcmZvcm1hbmNlIGlzc3Vlcy9kcm9wcyB3aGlsZSB3YWl0aW5nIGZvciB0aGUgQ0NJIHRvIHNj
YWxlDQo+IHVwLg0KPiANCj4gRXZlbiB0aG91Z2ggeW91IG1heSBub3QgKG9yIG1heS4uLikgZ2V0
IGEgc3RhbGwgaXNzdWUgYWdhaW4gd2l0aCB0aGlzDQo+IGNoYW5nZSwNCj4geW91IHdpbGwgc3Vy
ZWx5IGdldCAodmVyeSBzaG9ydCkgdGVtcG9yYXJ5IHBlcmZvcm1hbmNlIGRyb3BzIGR1cmluZw0K
PiBzY2FsaW5nIHVwLg0KPiANCj4gLi4uLmFuZCB0aGlzIGlzIHdoeSB5b3VyIENDSSBmcmVxdWVu
Y3kgaW5jcmVhc2Ugc29sdXRpb24gZG9lcyAqbm90Kg0KPiByZXNvbHZlDQo+IHRoaXMgaXNzdWUs
IGJ1dCBvbmx5IHBhcnRpYWxseSBtaXRpZ2F0ZXMgaXQuDQo+IA0KPiBUaGF0IHNob3VsZCBnZXQg
c29sdmVkLCBub3QgcGFydGlhbGx5IG1pdGlnYXRlZC4NCj4gDQo+IEJlc2lkZXMgdGhhdCwgY2Fu
IHlvdSBwbGVhc2UgdGVsbCBtZSBob3cgdG8gcmVwbGljYXRlIHRoZSBzdGFsbA0KPiBpc3N1ZSwg
bWFraW5nDQo+IG1lIGFibGUgdG8gYmV0dGVyIHVuZGVyc3RhbmQgd2hhdCdzIGdvaW5nIG9uIGhl
cmU/DQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQoNCkhpIEFuZ2VsbywNCg0KVGhhbmtz
IHlvdXIgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KDQpUaGlzIGlzc3VlIGhhcHBlbiBvbiBDVFMg
bWVkaWFUZXN0IGFuZCBXZWJHTCB0ZXN0Lg0KDQpJIGZvdW5kIHRoYXQgaWYgQ0NJIHVuZGVyIDEu
MDUgR0h6LCBpdCB3aWxsIGhhcHBlbmQgcmFuZG9tbHkgc3lzdGVtDQpzdGFsbCBzbyBJIGRvIHdv
cmthcm91bmQgbW9kaWZpY2F0aW9uIG9uIGRldmZyZXEgZHJpdmVyIHRvIGxpbWl0IENDSQ0KbGV2
ZWwgKDEuMDUgR2h6KS4gSXQgbG9vayBzb2x2ZSB0aGlzIGlzc3VlLg0KDQpCUnMsDQoNCk1hcmsg
VHNlbmcNCg0KDQoNCj4gPiBCUnMsDQo+ID4gDQo+ID4gTWFyayBUc2VuZw0KPiA+IA0KPiA+ID4g
WzFdOg0KPiA+ID4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNzk5MzI1ZjUtMjliNS1m
MGMwLTE2ZWEtZDQ3YzA2ODMwZWQzQGNvbGxhYm9yYS5jb20vDQo+ID4gPiANCj4gPiA+IFJlZ2Fy
ZHMsDQo+ID4gPiBBbmdlbG8NCj4gDQo+IA0K

