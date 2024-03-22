Return-Path: <linux-kernel+bounces-111219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B134D88694D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BAC28A859
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEEB20B3D;
	Fri, 22 Mar 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="muJeLPIC";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="lU0/JNZK"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8782208D6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099945; cv=fail; b=FHDpMJ/5vDihXPtsCZJW+bmt5T7LwrCJCGUg+tQUQrpz6crXhFqZZU6xusXwRrd89HIfaWRlbj72DVz4e2GYEFTr8hG/QDwXZpsqwcEua4orw4wMvpF+gn2Pwqtsv8HO6bj2x8qyksAhOH3VD7PQHL71vvOamjfp3vbwwf7tr7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099945; c=relaxed/simple;
	bh=gNttkLrrNKOu2wQ5/rjQFTz17cxs+R4Kx0+EcL/j3wg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dVrOStDM2hXV5lhqbwnpGF6Atnye0j8lsUrN0ie3VMMyAct5DW9f9Cu4lEhaNJSSV8iV7ai8cxGHHU1OwHnKdk0ZULXiKD6FsQfSefZwEf4XtyBWN7V5fIu2OilvKg+NtMJcnn7DdUeM8BRom6q7weeKI1+8NeFDlB3FG2sYMwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=muJeLPIC; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=lU0/JNZK; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 13676c20e82f11eeb8927bc1f75efef4-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gNttkLrrNKOu2wQ5/rjQFTz17cxs+R4Kx0+EcL/j3wg=;
	b=muJeLPICLpFuzwIgg+0CLGm8sbHCXmP/mItPOm/Ze8L8Hn9eXOzZ+KKyVgHYNvM4+LN8GilAduc70ayATAvAvzDTrSPULEJ+y9ZN+BTPxrYwpgmqjP1TKS6vXNdRsd1fH9CN6nuyApZ8rAYuaTqxnUkU7s+CmkhN3dpL/KvW0k4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:87b36072-ab76-4645-b769-37b90a0db376,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ec54cf81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 13676c20e82f11eeb8927bc1f75efef4-20240322
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1505652392; Fri, 22 Mar 2024 17:32:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 17:32:16 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 17:32:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQHVT8FPi76i5UE/aVNcbHS8NwxWdCGgzyIQ1Bmx/dsHvmF5mPkLU9iCA7t3D9M9+hEQwdRwPtK5R7TcHRSJvwG96tRFcaCFb+8AVX8siiorTJYDGPsbuo6V/dyDvYSHub+6BzTmFdZd2XrzZlrNc6Js3/BCM2o+p5/5ztETgkfMOAOzGCVnDsevb+/BsvIuEoAHv8CjgGsxCMHqrbuDBXkNmBvMct/mupiLMtiqQhwmP8eAY5YcJeOVgYH+ZAIMNUaknmwuXP+5cc+PqLVcdDDWZw/WCYmXtRlwkuK+Y9VfY6agHTfIRvAYlp2O1PeEefCVY7s+p7/9Zje0aaEZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNttkLrrNKOu2wQ5/rjQFTz17cxs+R4Kx0+EcL/j3wg=;
 b=kAJNBikbEr6Ef8YhPT1DOKxbEOxfXfjcQmD1kBpYRpT+aApwj+hqyYwMBoqgIzhkxD9bm4X0z13xiFEbhECXtQGbRzBNjJOGxuHosPbrz6r3DK4dJ7gieBxczoQVIjLOW8WRRyJsv52nptTlaVt+GmLmNx3EPrkA896IWVU5q8gWZP8LkXwJV/nf6mVL0IVJr8hf7ISEeoAbTzp8oBAEqx4oJg74Y7VpBN2qmXwGcPSvqMjtSqWNSTU9Fyh4nHmICN6f5Aj3XhNKHXD6cmV1UBiWYKpATc4nMJ81bwo7Vqd02UDWeuhFuhqMOQGnnTobHPcRtqZMT/gyE8y5744Lxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNttkLrrNKOu2wQ5/rjQFTz17cxs+R4Kx0+EcL/j3wg=;
 b=lU0/JNZKZ2WJufQ0e3bwUaX73tHw0sDNZ9ZftG7iHG+FeNz/qOFyOOm7L913R89YWiUsaefT0HSOKwDab4HkpsSNK3jsE7bsuISVCDmdDo5YyoDssgQoAFFYka+0q+l1DBHOSiIKUk2zoj5qihOakMSDCxJUD/7WdfCvLzEJHic=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6916.apcprd03.prod.outlook.com (2603:1096:101:a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 09:32:12 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 09:32:12 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 10/14] drm/mediatek: Support "None" alpha blending in
 OVL
Thread-Topic: [PATCH v6 10/14] drm/mediatek: Support "None" alpha blending in
 OVL
Thread-Index: AQHafBnwOC6lvDyCyEuD+Ookmhlan7FDf28A
Date: Fri, 22 Mar 2024 09:32:12 +0000
Message-ID: <306cc3a44aa94d9948e16216c337c5332b98fcb0.camel@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
	 <20240322052829.9893-11-shawn.sung@mediatek.com>
In-Reply-To: <20240322052829.9893-11-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6916:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDImwK0VWAsrCL5YN5v8VpSL5Bs2S9Cc3WesBbqtDs7/1tmlSGA9QrNIRzssPXEEa2SgiPYXqDDVcX46Ebwfsnh4zWeW9u+Jj6wiPc5EzA7EDjsU+2LCEesTIcgOThL41XG1Z4lqVWgjcKjaHODtiPd1DO0CDmY+9YmHIhT21lXnHuMGJ+702LMNyWfbmRr0akM9ETjqDEdHUq9YnWa3h51QH4vZkH6xwpkPhX1Vfj1A6xdU52bbDmBu1LUz7KHEZ6SZNiQdg8OzJEfs1aFM65xcE5eN1S1cSn2zYdpbc+9Uh86iNqMpYtz1kdtBwYKIw8zp+daYf2kOqrDxgNnqGLgMqLuBZAO9zeCvR86/Wu5OHZ+9TfVNZbevycXHmHvyTm+QuUDy3z+RZhsSO/CCfLSR92sFHk/n+eFDYn6y63gJqzQlpg7SmU8L0/OQDp6zeSAjIhatIUmes5WBfxA7v+KsaRqvGXnpxf60R2mAKpfD0xjLgytOk2W/du8tL44JBmbhR4zhRKJMfSoKKbWtmCzfnErYLY+NQGisnZpa2bILrwcmMS0AcGge2bzkIbqw8fxTRgBT/zXu46XYHEHptXc2mXSlP/nMrgonGQoeF0F+rYMvNcl4/PMYyLXDluitkqiQ/Qz49e/gFojGW/zH/0vBF4VuU5diJaHqtf+5kBo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVBmRi9zRkV1MVpQMVpqczBOek80WklaSm1sVmtTQ0YxRzVIZWYzSzBBUUk4?=
 =?utf-8?B?YXNtcTFGTmMxaGZHQ2F3TFVBVDYvelNBRCtoN2dPMGF4WXhkVjd2cVBVK2tC?=
 =?utf-8?B?dnE4R3pKTFZKUjA2RDB2cWlwWXp6bE1yYVo3eFRyQ1VBS0ladW55bXBIekx3?=
 =?utf-8?B?ZC81OTZzTlJ4Z0g3NWN6bGQwVjJiNlVaMGVJMnl3MGFzcG9pbXhROGNKNEN3?=
 =?utf-8?B?b1FGVWNGd1VLUURXSU9STkwycFE4QjJRSjdQb0hmbDFQVFJyd1d5WGMxbGsx?=
 =?utf-8?B?ejhmKzN4K25jdEd1bnV1TlI3VDF4dTNzQnRRMit1cUlSNERHVm9wUTZOc245?=
 =?utf-8?B?aEx2K0lOZkliQzVYLzBoWmZQZlZqbVlNdXMwNzd0bVBZcmZkRG44VnQwSUhu?=
 =?utf-8?B?ck4vR1hiS0UyU2draW0wQU5DTFVmeFB1YmQzVzBrbXJRLzVoY2U5VnJMZzVl?=
 =?utf-8?B?QmYwb25YMTV1UURibi9KUi8xV2ZSN0Zob2hlVFZLcHNZRFRFZmhpNGZpb0M3?=
 =?utf-8?B?dll6Qm9DVzJkei8zTWNlOUpNeUhsS0VudmtZOHQ0TlJqOEVXYTVvK2djYm9u?=
 =?utf-8?B?bE9sZnp3Z0FHazJyemE1UnRGZHNPMU13Z2VKaVdOK0tIZ2NIRXdEeSt6dnRL?=
 =?utf-8?B?ZEc3ek1RVkMzWkVIN0diZUQ5VG1Ec0UrMXFzUnZWVXpBY1dWak0rbFlVUUR4?=
 =?utf-8?B?RjVUQVlHWEpEUEhxaXdOa0VwamVGZVIrRUxMU1BUdHA0S25SQW13bUJ4UTlU?=
 =?utf-8?B?Yy9TQitjVUFINnRlMkFOK1hNSGtiem9XNTBkNHpsM1Z6OHVUQWw2SURMSzZT?=
 =?utf-8?B?WUk3SnZ1WGpxUUQ0NTFFbG9WSXI4Umg0NlNsSnNyWGVGYnJ6NDZaK3pwK0pD?=
 =?utf-8?B?VU1iZ0JwU0VlbmtDNU04VmNrVkRFeHZUOVIyVHhxeE1OSkR0OXhUWTVMblQr?=
 =?utf-8?B?THFGSjJJWlJWeVJrN1FJdWRTako1QzNEaVVVM2RrOEcxVENGVkxMaEQrQ04w?=
 =?utf-8?B?Y0xYKzhYYmRQa1RKYXJWVWFEK09QNFdGSzFQelJFMnVCenFibFl5clhvQUJt?=
 =?utf-8?B?OWhzZTZkQ25XTTNZMm04bmxHeUhQMnMxeW1Hem53WUVnQnJWcHB0YmxvakFB?=
 =?utf-8?B?b0hmTVJUNFRTNWYxcld5LzFtdTM2WnAyRi95aHFGa3hyRWdXZmtIcEYvd0VV?=
 =?utf-8?B?YlRuTVdNSjYvaE5hdTBWbTBaTVB5cnlIb00wbHg5SUIyZEFsdEhPakcrTkNz?=
 =?utf-8?B?ZzBYa29HZHFuWmJJVWNBRy9NRmlROU9HUkNYdkIrWWh0K1orTkQzaEpGeXAz?=
 =?utf-8?B?dXdPNFVwbzR4VHZiUlFyMGY4Wnk5STF5MElodFhFMEdNMEp6L29vRWVKWXFJ?=
 =?utf-8?B?R0tqeEkvOWdYUXQ2N3U4VVFKQ1E3TlNSSXRtM3o2ZzhFSDV0V09SMkdDTW9j?=
 =?utf-8?B?U3plZVFDT2lIRFB5OHdyNmZ4L2pyM3VxVnR3L0YrT3RkdlJRcG44YnFMODlP?=
 =?utf-8?B?cVhQQXZHeldQWU9FakV1L01Vb2tPS0hwelBxQVVIZ3A0SFExWnNKZUdtcm9s?=
 =?utf-8?B?bFRod1k3Y1ZKZVlyVDNjcWxFdW55cENyUGtnVzM3Q3ExQzVTcWZ0WlB5L1hi?=
 =?utf-8?B?dXpmVThWQ1VqQzIzWGxCaHhKN3NUdDBST0QzWUdrTGR0MkRHTi9GVXVldXM4?=
 =?utf-8?B?cEJyRXdvdnVrN1ZCRkttR2wyTTVCWm9QaFhCakRuMGdheG1iaE5nK2lNeGN3?=
 =?utf-8?B?RS9TY1JWS0k3ZjROUjJ1UFdRT3hkclVISGZZenFsdXlidlVaNDBkWmNXWVg1?=
 =?utf-8?B?eFRmRkxZZmRLK2dPbWlpMXVYeWllZmgrS2Y0eEJETjZmQTA4TFVlL3BYTTBL?=
 =?utf-8?B?UG1kZVBkY2FjZzBXNHRBTWU2OWJkSWVrbmp0d2dhVzByb3VEY0hsaHBXSEtS?=
 =?utf-8?B?a1ZSeWpmSXAxM29pa3N3M09PR05XN2VUczhkZWF0T0dmR1l0MjJWU04zeElZ?=
 =?utf-8?B?em9waUxaMGlCc0pHaFRaYjE2SlkwZ1J4SXN4dmRmbXhSLyt4b2N4TmdjNFpE?=
 =?utf-8?B?RDgrd003VmZMcWdub0tBdEtuUWtpd3dSblhsdENqbG9tNmY1ZytXWkI2Ym9v?=
 =?utf-8?Q?gxspywriCcYpbiCqMYSjP/rb/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96098E374A355749BC7123C211004531@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e21c9c-95bb-4705-25ba-08dc4a52f478
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:32:12.8435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPKH19I8SHG4h1snKGwU4WmsU589xka71bMFaCvCJQ5yvRmwDCLuU6D3Tv5DcSNlOBw4Nwb1Qc8vB/PXDDsFEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6916
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.091800-8.000000
X-TMASE-MatchedRID: O/y65JfDwwsOwH4pD14DsPHkpkyUphL9X4GSJGyYc34J5zM3dzkaQbJn
	Ph8w+R5oxpWxmut0txol6rr8933abhAq4jU0QZlBY1bQMCMvmn6eEP0DdJrullxTR00Ss4P62ft
	v/5jXki/BEdhLue3lb8yG02AZrBdlPz62uxDLhUyeAiCmPx4NwMFrpUbb72MU1B0Hk1Q1KyLUZx
	EAlFPo846HM5rqDwqts3cWCfjxMjTqV5+A/rjswtBN0o0lAQ6Zz29lc3OpRAvsfUQoig0gFg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.091800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	60A243C6684DE132BD94048AAE052062549B2077BD83DFFF6F077E23B83C5B822000:8

SGksIFNoYXduOg0KDQpPbiBGcmksIDIwMjQtMDMtMjIgYXQgMTM6MjggKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiTm9uZSIgYmxlbmQgbW9kZSBvbiBNZWRpYVRlaydzIGNoaXBz
Lg0KPiANCj4gUGxlYXNlIHJlZmVyIHRvIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgY29tbWl0DQo+
ICJkcm0vbWVkaWF0ZWs6IFN1cHBvcnQgYWxwaGEgYmxlbmRpbmcgaW4gZGlzcGxheSBkcml2ZXIi
DQo+IGZvciBtb3JlIGluZm9ybWF0aW9uLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1l
ZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hh
d24uc3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX292bC5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3ZsLmMNCj4gaW5kZXggYjFlNWQ0NTMzMTZjYy4uYTkzNmYzMzhhYjc5ZCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBAQCAtNDg0LDcgKzQ4NCw4
IEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNp
Z25lZCBpbnQgaWR4LA0KPiAgCQljb24gfD0gc3RhdGUtPmJhc2UuYWxwaGEgJiBPVkxfQ09OX0FM
UEhBOw0KPiAgCX0NCj4gIA0KPiAtCWlmIChzdGF0ZS0+YmFzZS5mYiAmJiAhc3RhdGUtPmJhc2Uu
ZmItPmZvcm1hdC0+aGFzX2FscGhhKQ0KPiArCWlmIChibGVuZF9tb2RlID09IERSTV9NT0RFX0JM
RU5EX1BJWEVMX05PTkUgfHwNCj4gKwkgICAgKHN0YXRlLT5iYXNlLmZiICYmICFzdGF0ZS0+YmFz
ZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpKQ0KPiAgCQlpZ25vcmVfcGl4ZWxfYWxwaGEgPSBPVkxf
Q09OU1RfQkxFTkQ7DQo+ICANCj4gIAlpZiAocGVuZGluZy0+cm90YXRpb24gJiBEUk1fTU9ERV9S
RUZMRUNUX1kpIHsNCg==

