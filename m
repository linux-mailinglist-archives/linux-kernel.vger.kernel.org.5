Return-Path: <linux-kernel+bounces-108697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DFF880EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD6C28668A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423A13BB29;
	Wed, 20 Mar 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i3GOZ/fc";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BWZOJwa3"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1E3A8C1;
	Wed, 20 Mar 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927427; cv=fail; b=cJeCaQsoHOkvOqSiMSy5PusPGXs3p/TKzX+y0+lIhRmFudS1Qy7PyIHAzQnYu4qZZoLsGX6ibw4hSx+QaeGVZmkA1s7RNxI/27YYdATezRs3UfsZfEv5O+Ko8+gLGcWm2PmXXgxWri14mxa0SjCQok1j9qcSvlxbrGV1oPH9kdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927427; c=relaxed/simple;
	bh=iFPtXJz397zOE84Rw+tTbduecflvFBwkK5QBoi2GavY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m903KWn37oCtcCks5BNWwRewri5i/8DKFLNbvGQyfXc4QCkf9rQfLoqXqgQinu/dNjha9uWsS/k4Sdx90tD+bfUQ1hu9Ic5Ncc1PuoIyHqf4Z2DN1YyvoiWjk9Vp/6wcd3Rwp5hrX1E4SgiKpfYc9irQr2kW+yx2dCsD6KuOmy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=i3GOZ/fc; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BWZOJwa3; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 655875a8e69d11eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iFPtXJz397zOE84Rw+tTbduecflvFBwkK5QBoi2GavY=;
	b=i3GOZ/fcpzaKng+Ja+pZnrlVJECrR9qUbIt28o9kjyLJ/rKDGfBMZBuVWZEs3PEDO4+GRcoRwwuZ7x0d83dAA7VNzY3hmlMvi183li2Crk0wb+HSb/MnHN0OCpq/ULUvvVUZZCSNSlMByAW0ZF/g2ssXFF9eAT9iP1UJcTQHpWk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3ca57ffe-fdf9-4a3a-8954-42e7e97bfa38,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:31369f90-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 655875a8e69d11eeb8927bc1f75efef4-20240320
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 924690485; Wed, 20 Mar 2024 17:36:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 17:36:56 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 17:36:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp4SA5MgUTOPPGXRLWDaa9QpV8GqPnblV1kJsVWOgV+GZj/NdIqGgn4fLMOPaL8TgwdNjAVOm8L0nJOdf7rp3Ivtt7NrSZQ9dKJ6UR2iJmMI32wZkPoY6Phm5tsXB/nmtef4vIaq2xE8vIIcfjU899dnUTqS0ROArK1RdD08TttG28o6QPAO38fQppnpZP2blNeaGZYm/JZv8zkHtYW/40JUgbXSx4+jch/sA3tOE/BMSSlxJPgUnWQnlUTTUjWzD6Anfts2GKREIbwJ1guH8dHEgKlutCBIRatXoMghgbz2D7cQozvW7ES96tbjyEnKnBJrJaT89sWaWCZx9im4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFPtXJz397zOE84Rw+tTbduecflvFBwkK5QBoi2GavY=;
 b=HLWWq/kd3sM0vW2S33fqVe5YD4Olk7KfKQW9s6grszjf5lLT8etXmuOAHQwnvoMpnldNYaMVuX0sHRTxy6ISyPPjS5rdyxGrC0AUmRYDv6B8oPtqGzQVA8aihkz0GatfhI9uLYvyFZ9sigVNC/4iLcPCg0NJZaJ2PPtdsOMDNYd0v4qtEgJxkwI9RYE+W4SdHq4UzA4J9OWWKoVtKOXr8oqe58VYwJl9vPPtSnCB/DkSwI6lioxKNh1O54/7jxuV0wC+Vwpm5DJPJSaS3eBfnP6fpzNrUH8FlUn8bCdNGNeZlRu9pS3fi9MlESUwiv3NhCaQabrwg5Qc2RviP9Mzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFPtXJz397zOE84Rw+tTbduecflvFBwkK5QBoi2GavY=;
 b=BWZOJwa39Va4T7xY3NCbu6Qm8BlOg8a3PL8MS13NE21hIKgjBKHN/zX3tSrJHQXW7O8yXRPfqgUYsNyKXzt8EoMhfchpWgR5mylQnlu3Mr2nlCQlOXjII4AzQqyOrKJSg5Gbrd9CIL/PF70KSMKW+J7QGA8O9erGqXazTLFwXVQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6773.apcprd03.prod.outlook.com (2603:1096:400:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 09:36:54 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 09:36:54 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jstephan@baylibre.com" <jstephan@baylibre.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "paul.elder@ideasonboard.com"
	<paul.elder@ideasonboard.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?QW5keSBIc2llaCAo6Kyd5pm655qTKQ==?= <Andy.Hsieh@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, =?utf-8?B?TG91aXMgS3VvICjpg63lvrflr6cp?=
	<louis.kuo@mediatek.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "fsylvestre@baylibre.com"
	<fsylvestre@baylibre.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "pnguyen@baylibre.com"
	<pnguyen@baylibre.com>
Subject: Re: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Topic: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Index: AQHaQ8+pgBL6pTKEqkml+zYix0rfyLFAzKiA
Date: Wed, 20 Mar 2024 09:36:54 +0000
Message-ID: <cc2881ddb0985310c9d666282e3e7f93b5586f64.camel@mediatek.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
	 <20240110141443.364655-5-jstephan@baylibre.com>
In-Reply-To: <20240110141443.364655-5-jstephan@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6773:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3m2rVhN2aL8FpHqfw1IJyeSlvQxLtm6u8x5yRJmun5MyAWqGZkriRlnaOsRlbhDNN35HasyRGITF6sQtwmxTxEfhApHAMwc6nGyrKQuqdDx7xe2OMrnkMbAc4bjlpOdd4aItf5scbUcTQKG2uMo0bhnNiTu6E3BRfFllq/tMmLTL/3yJl+DhRYsf8q2JMj/0/dFg3yp9Rj+SkUG71jkNeOfhQ5e7yWcXedbY6fVEQ2tSTO7Z7tXGaeld8hNJ8SRhX+AvJmfIsceM5FmET05yECprR/9McoiJHvfl9aCa4j66GxQaQINWwhxD9yRRYyhH2/HFQkhjQvs2We0l0jdaM016rPDuYpeUYjd2lVTVKry4ZX6UMQE/lRFM1dU/ppKggM8pZ8JHuTamqjKOf/ZQx8wCSK+MAOXqFETGO4i3r4aVaId+tyoAL2YNZlBPvNVHsXyKjsEfCOnTqgz3b4o+10rUBOZG6ztbtKwdjCf3X9KuylV2Y/MaCIs2THPpiZLl3LCHJe/uYSU+pb9nqLob0uN2JHfVOKz8QzTxE1hiaCw/nMfQKoK0cBVhGzZfAjovsTqQ8NVoPVozK5g/9SYXlA4bjI8Ygi5Odb/xJPo+w1ajfpHzKIw2myHGHaO2SYom47e66XDY22JE7HCJK2m1eJllboDMcEHlkaZ/rOGeIs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmtQRjBMWUp2QkJlNjZwdVZQTUc2aEVvOGZZaSt5T05Sd1lmUXppcFVTeVZU?=
 =?utf-8?B?L2sxOG1yWUNIN3NnNGJUc3NVMWVYbGV6MGVEVzRQVWhRY3BhWkZhTGJNVHJZ?=
 =?utf-8?B?RVpJR1NwK3d3QzU1Y0wrb1RMZ3I2TzBVVXpRTFRlQkd1MURwRXExWjd6RWx1?=
 =?utf-8?B?Ull3c243VzY3Qk1mczFJcHlIZU4veXYwUW5IWVYxRlVkNlZ4MFBqbFptRE9Y?=
 =?utf-8?B?OTFlYVFXZlovRGNGRWRoaU10Sksyd1lCYlFDeDdxYVpjSUQwcWR6ZzVWUjRM?=
 =?utf-8?B?YWtTclIvY1BEa1pPNEFxUDJ6YXRlNWM1NW5HR2lMUlVNQ1IrVjk0Q0dzb2d2?=
 =?utf-8?B?aWtrUWQzdGJyb3RxT3BqRVdZcUdqVE9EbmZFYzFxVGdvVmtWTGRVbGJrTGhm?=
 =?utf-8?B?M241b015L1BWcTQzbEthN3hMMWozd000QzRqRkNLUXpRUW1Jc1pvMk4wVVpU?=
 =?utf-8?B?OGVZYlh1K3RHNFdmVUVaaFl3b1ZuMXhlVGk3ZHFwekRIRjRrYzVxVmpaWHNm?=
 =?utf-8?B?K1dvSGFDd0lNSHpYMlIwa0llMDNKWkRGMi93WmpkYlowdXdCS1pwWGxLSlVt?=
 =?utf-8?B?OTUzdTRSVVlpaFFMbjlRYU9xY3ZaS1pyNUFGV1gzeldmNEM3bnNIQzYrZVZW?=
 =?utf-8?B?eDd0OUJuTW5wMGo0OG1ibGNBSzRCVHZjcUpIa3RCTWdqVTMyQ0RyanZ0ckZP?=
 =?utf-8?B?M2tsUzFia2MxTmtERVRVWDlQNStwL1dLUmdZcE51K1RpQ1BTMUVPRlJwemJ2?=
 =?utf-8?B?eE9GVDFHUVNGVGxTYWlZREtBSUk5NHU2Ulo3cFYrcExLdXJMSHJyTER0eHRI?=
 =?utf-8?B?cC9Mb1JYQ3I0dHk3cEY1OUQwMUNSNjE0WDlDUTRXZ1pCeVpEQnVDV2FrRUov?=
 =?utf-8?B?L2V6UUw5aWo5dFk3N2hGU2FzWHZrazRXdzh2cGU0ZGxDTTVYZFU3RENOMk8x?=
 =?utf-8?B?UTNvbmVhOGtvaUx4Vmg4YWkxWDVzb0g1YnlaZ2xQcml0d3pZWmZ4S0tDKzBX?=
 =?utf-8?B?dnU1WjM5eXBuVmlNbWt5ZDQzSURMTnFDS0Z1L3JFdDczMXF4amxPVUhNdTdm?=
 =?utf-8?B?SWtnRnNCTmlsSkFLbkZ4SGV0VzBBQWZtdkJnanA5YlB4Y3hQSHFpYmZpRmRz?=
 =?utf-8?B?ZTZpdUE1L2s4NGFXaEV3bGdscVZVaTI4TTdGRSt5cE1rd1BwdDRQQ0dHWkFZ?=
 =?utf-8?B?QlFGRXZYcTJJNHdGUDhNYmNLOWl2SW1zU0pCR3N4VHNoL2pQcU5Hb1JLRDcv?=
 =?utf-8?B?NXVPVDJiRzZvSDBNdVlZOTlrd0NnUmMrWk0xWEViVXBCdlNrQWp1YStYemlw?=
 =?utf-8?B?ZitlUG1EZ1pHQXRnaFRMSUJ2QXk0OFYwcXh6TDM3OU9QdUJyNmJ2MXZPYUZU?=
 =?utf-8?B?bHljTUNWSWczWk51cXF4Ry9wdkoxWWRsWDVIWFA0TGMwR01Vb2J5YS9zdGlQ?=
 =?utf-8?B?WXB2VmF2WWR5cHRGWXdmRjJtSk9Nb0gwK2d2STlVcUxjaFN5dHNRcHZlT3ov?=
 =?utf-8?B?MWRJUGtya3ZVM0hYS2JqeDhZQWx3cUtCMFBWMnBRaUQzdXM3eU9uekcwOXJ6?=
 =?utf-8?B?YktCWnhHOU9PSnpWNks1M3BaK2xZS3FtYURLSmZhSmRtSE1mMFhZNzdRQXFt?=
 =?utf-8?B?RW44S0g3bzkvMnFHN3hYdmJxbW1DK1p1cFdDOGZzR1dnM2l4bmF1anJmSE53?=
 =?utf-8?B?TXRYYno1VzljdlRqM0RGZWtMUGYwSmpRYklEUXJEOVJJQmw5NXprRjdxWHky?=
 =?utf-8?B?R0cyaDVqUldBbU9JWlRhb0l0cGs0cW1POTNDQ1EwYW8rTGNoZmJVeHMxVnNx?=
 =?utf-8?B?emc0QmhZNkUvQyt1NlpvUUl3S1l6RFZSaWUweXN0eDEwRVZoK3o1RzR4SHBC?=
 =?utf-8?B?REJKMkdoakpBa2JYcnV3b3I5bTVqV29UWnZOeGUzSDJOTVFxNlI1M256cHdt?=
 =?utf-8?B?SUZyaWprb2RPOCtVWVdVM2djVUErNHdpdHQrcWpoSDhaNzBQU1h6bmJJb3Fs?=
 =?utf-8?B?bkNRVTNJakZmQ3BQS2N6SE5PY3B4Wm53YXNha2xWamtNL1B3Z3VCdmpvRUkv?=
 =?utf-8?B?SFBlM1V1UnJGaEhwNkpxRmx5dFFLTHlQcldqQmNYMFMxK3RoR2NCU3diNHI0?=
 =?utf-8?Q?/6EprArGE0nvVv35wv2cQaMHz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68050FD41A8F4D438FDB1517D9739461@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b433d82-965f-4a62-de23-08dc48c1474b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 09:36:54.1657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZIZAa0rOFSepadfOFFipJ1rCAC+LhHx/Fm8Ss5vgysKQv7ldz5dPUuiQS/qdhnwSuj1OlnqtZfNmi5lAaV32w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6773
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.824300-8.000000
X-TMASE-MatchedRID: HXSqh3WYKfsOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0r/XD0CNJ3fxO4dcT3ZaTocyYHhs0mgDoxyETzgIO4sasaQTVtPXXNM8ha
	W4U9IrFq4+90dmk+ZowOam7Qa4hbBLZbtj42l31HLtNJZxvPj1ov8pidhVYOU33Nl3elSfsr8+W
	FAD4qdrHGrfwDuqgHGJKAbDfejtraGeTbGWdRz1kZakoam9+aefS0Ip2eEHnylPA9G9KhcvbLn+
	0Vm71Lcq7rFUcuGp/G8QIu4z6HhEH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.824300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B09E03837AC4FCC8B440F4D4976AAE6D78FA9CD08ABA63211711D9D051D00D2A2000:8

SGksIEp1bGllbjoNCg0KT24gV2VkLCAyMDI0LTAxLTEwIGF0IDE1OjE0ICswMTAwLCBKdWxpZW4g
U3RlcGhhbiB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBGcm9tOiBQaGktYmFuZyBOZ3V5ZW4gPHBu
Z3V5ZW5AYmF5bGlicmUuY29tPg0KPiANCj4gVGhpcyBkcml2ZXIgcHJvdmlkZXMgYSBwYXRoIHRv
IGJ5cGFzcyB0aGUgU29DIElTUCBzbyB0aGF0IGltYWdlIGRhdGENCj4gY29taW5nIGZyb20gdGhl
IFNFTklORiBjYW4gZ28gZGlyZWN0bHkgaW50byBtZW1vcnkgd2l0aG91dCBhbnkgaW1hZ2UNCj4g
cHJvY2Vzc2luZy4gVGhpcyBhbGxvd3MgdGhlIHVzZSBvZiBhbiBleHRlcm5hbCBJU1AuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQaGktYmFuZyBOZ3V5ZW4gPHBuZ3V5ZW5AYmF5bGlicmUuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIFN5bHZlc3RyZSA8ZnN5bHZlc3RyZUBiYXlsaWJyZS5j
b20+DQo+IFtQYXVsIEVsZGVyIGZpeCBpcnEgbG9ja2luZ10NCj4gU2lnbmVkLW9mZi1ieTogUGF1
bCBFbGRlciA8cGF1bC5lbGRlckBpZGVhc29uYm9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6
IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29u
Ym9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArDQo+ICtzdGF0aWMgaW50IG10a19j
YW1fdmIyX3F1ZXVlX3NldHVwKHN0cnVjdCB2YjJfcXVldWUgKnZxLA0KPiArCQkJCSAgIHVuc2ln
bmVkIGludCAqbnVtX2J1ZmZlcnMsDQo+ICsJCQkJICAgdW5zaWduZWQgaW50ICpudW1fcGxhbmVz
LA0KPiArCQkJCSAgIHVuc2lnbmVkIGludCBzaXplc1tdLA0KPiArCQkJCSAgIHN0cnVjdCBkZXZp
Y2UgKmFsbG9jX2RldnNbXSkNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2NhbV92aWRlb19kZXZpY2Ug
KnZkZXYgPQ0KPiArCQl2YjJfcXVldWVfdG9fbXRrX2NhbV92aWRlb19kZXZpY2UodnEpOw0KPiAr
CXVuc2lnbmVkIGludCBtYXhfYnVmZmVyX2NvdW50ID0gdmRldi0+ZGVzYy0+bWF4X2J1Zl9jb3Vu
dDsNCj4gKwljb25zdCBzdHJ1Y3QgdjRsMl9waXhfZm9ybWF0X21wbGFuZSAqZm10ID0gJnZkZXYt
PmZvcm1hdDsNCj4gKwl1bnNpZ25lZCBpbnQgc2l6ZTsNCj4gKwl1bnNpZ25lZCBpbnQgbnBfY29u
ZjsNCj4gKwl1bnNpZ25lZCBpbnQgaTsNCj4gKw0KPiArCS8qIENoZWNrIHRoZSBsaW1pdGF0aW9u
IG9mIGJ1ZmZlciBzaXplICovDQo+ICsJaWYgKG1heF9idWZmZXJfY291bnQpDQoNCm1heF9idWZm
ZXJfY291bnQgaXMgYWx3YXlzIHplcm8sIHNvIHRoaXMgY2hlY2tpbmcgaXMgcmVkdW5kYW50Lg0K
DQpSZWdhcmRzLA0KQ0sNCg0KPiArCQkqbnVtX2J1ZmZlcnMgPSBjbGFtcF92YWwoKm51bV9idWZm
ZXJzLCAxLA0KPiBtYXhfYnVmZmVyX2NvdW50KTsNCj4gKw0KPiArCXNpemUgPSBmbXQtPnBsYW5l
X2ZtdFswXS5zaXplaW1hZ2U7DQo+ICsJLyogQWRkIGZvciBxLmNyZWF0ZV9idWZzIHdpdGggZm10
Lmdfc2l6ZWltYWdlKHApIC8gMiB0ZXN0ICovDQo+ICsNCj4gKwlucF9jb25mID0gMTsNCj4gKw0K
PiArCWlmICgqbnVtX3BsYW5lcyA9PSAwKSB7DQo+ICsJCSpudW1fcGxhbmVzID0gbnBfY29uZjsN
Cj4gKwkJZm9yIChpID0gMDsgaSA8ICpudW1fcGxhbmVzOyArK2kpDQo+ICsJCQlzaXplc1tpXSA9
IHNpemU7DQo+ICsJfSBlbHNlIGlmICgqbnVtX3BsYW5lcyAhPSBucF9jb25mIHx8IHNpemVzWzBd
IDwgc2l6ZSkgew0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4g
MDsNCj4gK30NCj4gKw0K

