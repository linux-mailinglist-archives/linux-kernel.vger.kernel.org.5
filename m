Return-Path: <linux-kernel+bounces-138150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D689ED55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78DBB22A88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE413D528;
	Wed, 10 Apr 2024 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BAGWs4a6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nw3BfFaH"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784341C0DD9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736802; cv=fail; b=i7E/MfJvt8nTvEhHUbqgAZURqUIckhZ46Ejmjyb/E0MXSrdokxOR/82wtnacKfV4/jvDci/DEDXkQhPHWnImcn956CBFn2vWFgT16D+gpGUNHMwsf4xYoy9Vkj7a2JShwdYWtVjoYL+jZSjRETp7PUApAO2uEvavkXfW9GqLcRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736802; c=relaxed/simple;
	bh=Gai5AhtFp/bF0m+ro1SmzheEk6Zs0WcdSgGt8mCw0ls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ouL2Ai2XWJy2vJooWZq51wfIHYDmkaoyv798Nz3g5ZHkWs+yUiU3Rg1jXhvruVnRFcQWDAG0/FIrniLcTycj8aRi7Qk8ykoCJ+oSOtTlSj6eq48iQv5IMWFM3KtkSNt+2vDENd/EXuSUeW+oAnPzgjcKYdeHdex9gJ9vglWerx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BAGWs4a6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nw3BfFaH; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2e77bceef71211ee935d6952f98a51a9-20240410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Gai5AhtFp/bF0m+ro1SmzheEk6Zs0WcdSgGt8mCw0ls=;
	b=BAGWs4a6YXIfF+oXnocy2EZk/iqEeAgNUG/QkT1aPm4MY/pLKR4/VsfZ1xmLjji7bymDrR8W5rKu7KX52lIA2vGQcqlRC38ppVpCu5zIwgl74cWzYxMxVlcL45BAV0T4279cdlHxNwC83UCCC6itB81oR832ZO1rbYWk8QOJz/o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:496cf821-3eab-4e8c-bc97-200acafc58c3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c938befa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2e77bceef71211ee935d6952f98a51a9-20240410
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1396384645; Wed, 10 Apr 2024 16:13:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Apr 2024 16:13:14 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Apr 2024 16:13:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6EAfe3yP+MBvAzSXHjsUOeo2BqIPZn+LVf+0pkYU6a84BGhu2OL7BEp/dmwLpSwI3x+oAlTiPuHunivE0jh96GyChKPEfoYDplpYfrhugQjatssJLFVtLAKEWBdjg516A4dcqLYLVfflifA7vU2EhWSLcvNlqIzEsfiKQ8/H5DFaUWQOYzcl38bBmaheTPtZWBYk0cXJ9acl8982vMZ6cOXb7KdtFCaRE1/MvHhrHk4I0eL0AQL+jmdzR3bVx26DD7lpL0PrlGRLgsyEpuS3LD7hv04mdhEyQwSm6aq01CyApklVN9nlBvJgKd26sAEjJQx+Jlf/s9FPLkJ7YOCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gai5AhtFp/bF0m+ro1SmzheEk6Zs0WcdSgGt8mCw0ls=;
 b=BE9AVrRkSTl6XUruOzoS/Ukqt7A4Olm/AZoKDSStY/jwPFJhTCxFw91lR9v+SMpQYiolbNrj+Pa65Lt26To/gy7JotRvWg/Il+axAsBKbz/2koJm73N1O/1bVx8BfE7U5v77ALsZ0aSssAA/7xH5GCAgzh3ojoqwbrOvu2HyJo3XLu6Nm5+Qy3NUvAgxblE/AuMBC6Nfi5itLrRd+/DVNMrA8kjvs41kyeWZ0+GqlC59nJ0MF4dLDjA6ni2qhv6QYle/OWNeU4RCZ6Bv466hVcL7kruUUbZGBiRP6VODty7fevy8RhtOEYWcB/SqOcAa3xvgC7tP9aPEPWOjYl390A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gai5AhtFp/bF0m+ro1SmzheEk6Zs0WcdSgGt8mCw0ls=;
 b=nw3BfFaHidYSHWgmoM0YOSFV3YrJqj00KBeMTczziJU1sASqabpelhQD+Zmgj4m0KnXC31wDHw71nrMZukBZU3xZ5cwplYVhuoL0uuBl1ttwIGOaNY1IiHqDABtHQ/RBwancAVjW0hM6C5hrTUqGyOiv7Y3o9PuwFr1FuPjwYW4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7995.apcprd03.prod.outlook.com (2603:1096:400:45b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Wed, 10 Apr
 2024 08:13:12 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 08:13:12 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 01/11] drm/mediatek: aal: drop driver owner initialization
Thread-Topic: [PATCH 01/11] drm/mediatek: aal: drop driver owner
 initialization
Thread-Index: AQHaguMPYzlN7nTIpU2lb32BpYpEIrFSyAwAgA5nywCAAAg+AA==
Date: Wed, 10 Apr 2024 08:13:12 +0000
Message-ID: <b3e579fe2950943bac2790480b95f17499457c9f.camel@mediatek.com>
References: <20240330-b4-module-owner-drm-mediatek-v1-0-fd5c4b8d633e@linaro.org>
	 <20240330-b4-module-owner-drm-mediatek-v1-1-fd5c4b8d633e@linaro.org>
	 <48612f68a7e7b6aab0c6d5cbc77d85b1389f4591.camel@mediatek.com>
	 <c944f949-8907-4d39-9953-82748108ef11@linaro.org>
In-Reply-To: <c944f949-8907-4d39-9953-82748108ef11@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7995:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4QlK/vOwjNM88U9zMb3m4sGPUUe0/Gy4+FfIRrpnU++LSrtsHq2wrfqhmmpOby1XibwJrvimrUtOOGJtp+jllgBJsU6jwsn0Qeu89qHR6xv1tE/0YKPrm/PMpDmXemK4InVRrVfIJMSZEiC/MmLV3+QvfTkZ2D3huQQUFzF6FsPLRQHi9v3VD5z6IhZAEe9LkCnrcxxBKKOOqoMiliGcxtOyCzC2jKiwHFM4bFD7XPfQaCs07IShkAzeb3jqrRaxTdLr4RGDW9mLaXleXW78NkZIANJ3clD3U7hKP3RlIiudL5BHa4rE/7vJpcfWISwz4ra7sJIoc35BQ42QmECn8VqjpgrE9mylyD9/7RLKa/UZM7LNFc+kFGx8JNXdf3O4GBgGdASRs9xwK0qBduTAkWqGyM1MulizxQthK191QrXE4Obdu2Ib+ITLK/h487HNGafcXTOz0Q432QrfDFRfryDR2H8EmXk6Af3IFouVyO9X7wmT2zRTV7hRUEUBf0yxxZA56ASpV/IVLc9oV49OPF1evoVnPidQJRX0bUQpvV7tjaFZFEzYrnPGxqHXsrKMrKsm/hcLqMlGiCDOZTRhWccg726xwNsbtJpCQurHVde9tF5KzTK7O9uW5WdPyuH6WrSRu3SqKiJQXK4ml2gB2V7Iv7I4l/VJUiHABNuRpoQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVMrWnFUMWhsMXBVd3gvcnZDS3BTd29haVhhOFJuWm5iYklCbEFoN1F0eW13?=
 =?utf-8?B?MGJnMW8rditsZE5xNFZJTzNROXpOMGtHQmlMVFcxaFZZTEhsL2w5ZEpaNjVu?=
 =?utf-8?B?TzYvWHEyZXg5YjRLWnZDNmRpdkdTY2lkTU8zaGVYMjN4SXoyN2hJNHoyQXdn?=
 =?utf-8?B?a2h5eGRUK05HM2JEbzNNbEhzVFgrcWJiRXNBOWtBcnozVWkyMkNJYmUvQ2tM?=
 =?utf-8?B?M2J0dHlyczAxa3hSR1kwYnVjZExCWnhSbGRFdVlqY0lzSFI2SVBkcXl1bWJ5?=
 =?utf-8?B?ZHNLOHdlTEpDOHZyOEJnSTB6ZEhoY0ZuMGxIZEVvY2RnK3ZGKzR5ZWxhZmFl?=
 =?utf-8?B?RHJYeTlHSWdxc1lLai9seWtValFNYWdYdW8zTWV4dlM1dDR3NW1KVmVqZGo1?=
 =?utf-8?B?OVlORFJPNEszMXRtWWhsNjJMeFdBMGlKMXVSeWlhQjk5T3ZackYyS0ZrNkcx?=
 =?utf-8?B?QUVJTUlSZlNWa1U2WjBESzJVWjdyVndPWGxpM0lYNXpSeElJZU1qTWdwdzFX?=
 =?utf-8?B?TzV3ak9IeFhlMnlYcXdwZ00rS3lOblVTb0xyRTFNaFZXZWlqeTg2d1BucWpS?=
 =?utf-8?B?TXAyeDV4UkMyc2l6YVhzQ0xXOTd3RExsUFduSCtic041Y1dGS01MakxGa0d1?=
 =?utf-8?B?Z0ZBUmNZcm41N0dZMHpZVzFFK0FUUHMzNXZyUjFMRjlNbUMrdTRFVkpMUkxC?=
 =?utf-8?B?amwzTHlieWVObWZsWHh5QzNJY3JIeXRaZTRnNUFEdnE0T1BzbmhJcjFPaytB?=
 =?utf-8?B?dHhEaE1BQ2xiQ0IxMGt6Vmh4a3RBaGZZSlRhSE1DVFFCc3l4NmlVMEtBcjZN?=
 =?utf-8?B?NVpWVms1V0RtRmpBSjBRZ3NuYW9CSC92VXhZRlZwTmlEMlkwdDBBcUp2ZUgx?=
 =?utf-8?B?ZlJjd2IxVy9lVXNJM0pYdGNlenl4d2hnNWVtU2ZSb2sxQkt2azYwMlYxaDV3?=
 =?utf-8?B?V3FsY3VwOWlML0RINVh5bHZjdHhON0FHSzJOanVHOG84V0dJaE5sd3ZVVjFt?=
 =?utf-8?B?Rm9vaHN2QzNGS0JqYVJ1NFNNQ3U4YzNnVkpzT0dsYllqZkdMRHhkTUhDbGxQ?=
 =?utf-8?B?VG1TcEVOdXBqWTNlRFcra1JvMVJCMDlaMUx2Sml4U1BsT0FQWk5kMG9LeW9H?=
 =?utf-8?B?NWthWWpQMWNLT0ZDSzBiOHJWbWlEY1YwME1SbVRVR25DWWxCNnpNTGw0bU12?=
 =?utf-8?B?aEdsSVZUMVlHWnpVeDZ2dkIrTlBmUmNUb1Qrc1NkS1BuS2o1Z2NWZkFsZkhY?=
 =?utf-8?B?cXdYMFFYUHd4ZXMycEp2cnYrdmhXcFZtVkpoTVhWWE9yc3czdk02dXg3UG1s?=
 =?utf-8?B?bHZKZ3l1RTJZeE5kOHNsVk14QmpLMWVnU0tMS1pXditVUDY3NE1qclA4VkJS?=
 =?utf-8?B?QkU0SXhTb0FJWUVIUmtZczE2d3VCTXRSNnNkeTYxcHNlM1NIdk9EcW1jdktM?=
 =?utf-8?B?STNjK2NUOWtWWXZ3T0oxd2tSNEx2SllxbUtZRndMbG9udWdnTHZ6aDh4R0lD?=
 =?utf-8?B?NVNXSG9hSkc4R3V0c3hIOE5SMGxjVHhzSVdESkZtdUVQUElUeWVDMHEzbWNO?=
 =?utf-8?B?RnZWaURVdXJ2VVhUYkxCbDlwcjlJUHRYOFl5ZE9oanpsWGN3UTNvR21NOHg0?=
 =?utf-8?B?K1ZwdnY4VkE3emc4alFMWmY3NkZwcGhmQkk2Z1hBMTQ1RTNaM0dnejN1R0hi?=
 =?utf-8?B?eEtodmxVQzZlaXl0aUppTFdEbUNXdGtPMHVWUkw5SG5GdUthR21oWHowWkNn?=
 =?utf-8?B?VUZEd1JDWGw1eUdVd203VEtDUllPVmlTTTdzL2pmVUg2U21FQ2hFNjlnMkhQ?=
 =?utf-8?B?ZGJHV2MvczB0VTRIS0R2MWtMY1FZV0xaU21sUE1BUlJ2YUpTTGkrZkt1aDFI?=
 =?utf-8?B?RmZPWnBraW9wQjJQcjcwdEpKc1JnNXlCcFcwR3JiWFQ1b25CNC8rUHVUWW1s?=
 =?utf-8?B?dldjY092ZWJRQk5VTjVET3Q5NFcxNGRteHFpVTl1VkpMZlE5eXg5R1JNQWxG?=
 =?utf-8?B?UXA3d1lFemVndFBYMmxwakhrdjMzUTdlUkx4YWZFdmlwUWRpcGlpaG5sSkxJ?=
 =?utf-8?B?eXhRbitkNGhCK0Vyc1ZhU3dPTzY3bmRIOGhSSWd3NEdtY0lYOHVMbTV6TWI4?=
 =?utf-8?Q?gdq0TGblUFG+X/3WNRQnlWMZ/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9C0E8CC3975C24EB1F15C77510A3E10@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a996197-9c5b-4be0-1714-08dc593610e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 08:13:12.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MegwNkGn5R4Zz1OWVHAmfonrnglwifa5i1j8taMNACEw9qZY2xvkr8R4OcZdqgLQ7hg1cLOWt8VKiQjV5A1OXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7995

SGksIEtyenlzenRvZjoNCg0KT24gV2VkLCAyMDI0LTA0LTEwIGF0IDA5OjQzICswMjAwLCBLcnp5
c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2Ug
ZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUg
dmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIE9uIDAxLzA0LzIwMjQgMDU6
NDQsIENLIEh1ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiA+IEhpLCBLcnp5c3p0b2Y6DQo+ID4gDQo+
ID4gT24gU2F0LCAyMDI0LTAzLTMwIGF0IDIxOjQzICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiA+PiAgIA0KPiA+PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+PiB5b3UgaGF2ZSB2ZXJp
ZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+PiAgQ29yZSBpbiBwbGF0Zm9ybV9k
cml2ZXJfcmVnaXN0ZXIoKSBhbHJlYWR5IHNldHMgdGhlIC5vd25lciwgc28NCj4gPj4gZHJpdmVy
DQo+ID4+IGRvZXMgbm90IG5lZWQgdG8uICBXaGF0ZXZlciBpcyBzZXQgaGVyZSB3aWxsIGJlIGFu
eXdheSBvdmVyd3JpdHRlbg0KPiBieQ0KPiA+PiBtYWluIGRyaXZlciBjYWxsaW5nIHBsYXRmb3Jt
X2RyaXZlcl9yZWdpc3RlcigpLg0KPiA+IA0KPiA+IEZvciB0aGUgd2hvbGUgc2VyaWVzLA0KPiA+
IA0KPiA+IFJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiANCj4gRm9y
IHRoZSB0YWcgdG8gd29yayBvbiBlbnRpcmUgc2VyaWVzLCB5b3UgbmVlZCB0byBwcm92aWRlIGl0
IHRvIHRoZQ0KPiBjb3ZlciBsZXR0ZXIuDQo+IA0KPiBBbnl3YXksIFBoaWxpcHAsDQo+IA0KPiBF
dmVyeXRoaW5nIGdvb2QgaGVyZSBmcm9tIHlvdXIgc2lkZT8gV2lsbCB5b3UgYmUgYWJsZSB0byB0
YWtlDQo+IGV2ZXJ5dGhpbmcNCj4gdG8gbWVkaWF0ZWsvZHJtPyBJIHRoaW5rIGRybSB3aW5kb3cg
aXMgc2xvd2x5IGNsb3NpbmcuDQoNCkkndmUgYXBwbGllZCB0byBtZWRpYXRla19kcm1fbmV4dCBb
MV0sIHRoYW5rcy4NCg0KWzFdIA0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvY2h1bmt1YW5nLmh1L2xpbnV4LmdpdC9sb2cvP2g9bWVkaWF0ZWstZHJtLW5l
eHQNCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+
IA0K

