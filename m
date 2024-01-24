Return-Path: <linux-kernel+bounces-36564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA483A31E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B141F25646
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2817C71;
	Wed, 24 Jan 2024 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lUOhZKf6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nYpYHmJh"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65D617BCD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081852; cv=fail; b=skfmYaMsKy7xvYY+vRKfVYaC3cR7qsmv1lTOYBb3qhDdtw20a2ciaHb9BS+YgdYjeI/NQ4GCDO1ZDDx+f3hlKVWx1t47uWg11PWnkFSXCcRpRaD7qtYKHYh9O8feSbma721piaJXZY8wEbpdaEzawHxonUX0vqVK8llZ+71HWUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081852; c=relaxed/simple;
	bh=dbk1F9mSG0ZoBryvcnj36BwKWvpkm3z3wMTs65R91qw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhhJp4v3t1yrsqmxLMZbgZvGAZmt35675vQa4bAlcpEppdVnetsv7BB/Weow5COnsPLNiJ9jvX8yb38dkc2epVaAbTGaCf3cVqlcZeE+ix9TBMj/OhsRspgjqjhesJWdc6BUlHPSZhYcXzpy+a5aoGCcjdrN+j2cuCM26N/hvhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lUOhZKf6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nYpYHmJh; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6ac27de2ba8b11eea2298b7352fd921d-20240124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dbk1F9mSG0ZoBryvcnj36BwKWvpkm3z3wMTs65R91qw=;
	b=lUOhZKf6HRvF6Oehx4snEjttAnoHJRbQVUmzJb9EswIJN/wYAoUCFS+s6Y1TG3GbZhaxZA8LwkhHvDRScxoa/m0c37XwToHcFdmVU9nqsx598isKmUKbvfUMZiaaX56G0nheLD29pcKhcND1BiklkQErAtD5GNz3X74jNT4341w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:906a2347-5804-40df-9398-0d07b25b067b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:06a617fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6ac27de2ba8b11eea2298b7352fd921d-20240124
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <haiqiang.gong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 274624913; Wed, 24 Jan 2024 15:37:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Jan 2024 15:37:23 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Jan 2024 15:37:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaBAfDie+FvZTIa40fFN+SnAYw1HHmy49/Wan2tsyGBScpnEw/UPKfoiI/QXS8iqbafyeslA/PJ/xfrUzkzV5mxRF3uDVYcndBuDDDLeHPzE5/rHxzR8rNrN7Yrhw8xFaYFxhVctuXz/OIhuty8jdWHL/MJaYbm1lKOltW2s2zeFSaqy4K176WHUrwXV35gTtJ2Ti0zZAaZBQPd20nITeYtv5zb48635Jq+ZOAfICZuj+PgthKEkRH7abqZqLq4j0NngOhNnOtX0lZBIFFqRNG2x3NwYaqXaPAuiIp5qybrgeJAUzSlkcE/+ZMQpdBaYZID+vkPylfbLQYOyJ6z6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbk1F9mSG0ZoBryvcnj36BwKWvpkm3z3wMTs65R91qw=;
 b=iPN79kuITH9Sq0ok3JIMyigmFDYOps61zZokMg1lDpnZ8ROarP0iP+zgZWAtfFbllNSxAcZLlimlkUH3FBBVirsjf++zv2IVOERFVO1pFKAOZYFEORKeFCQX9nLKFTy2OQpumiyBNyz8TbwTPvT1024P8WBLi7+fQvi/NbzANOQQk/WyJ+pJ000VrGx41ueDOAKvzU/Kcu7zT2TP1Hh2T+7B1oaroDJiScRDIC2gDaQ7p3Bl/kbCScdun7YgCDdfjMBRBfBIVpTLM8d5FMGVoUhKX7EgfYGcwaU0G6zAfSwEb+92sgkKlOeC1dAoO8yl7Axc8PYjJFYDQpQwMW8jfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbk1F9mSG0ZoBryvcnj36BwKWvpkm3z3wMTs65R91qw=;
 b=nYpYHmJhK7IVZEXkwgspdyTfrrNqit8eDy/inr6MnvL/uw5V6M2iCj7KG2eQEgpL45QmnsI0qY0ccX+P7uS94upLMKE2nEoaqWtz3dJT47fe4U2yaoA+46lrtSdp4KKlregAMDRHxsZy4fw2vUi0HXoQwTEVJbIxq24sDjrIP9A=
Received: from JH0PR03MB8809.apcprd03.prod.outlook.com (2603:1096:990:a1::10)
 by KL1PR03MB6238.apcprd03.prod.outlook.com (2603:1096:820:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:37:20 +0000
Received: from JH0PR03MB8809.apcprd03.prod.outlook.com
 ([fe80::e7fa:4f8d:2a6c:57cb]) by JH0PR03MB8809.apcprd03.prod.outlook.com
 ([fe80::e7fa:4f8d:2a6c:57cb%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 07:37:20 +0000
From: =?utf-8?B?SGFpcWlhbmcgR29uZyAo6b6a5rW35by6KQ==?=
	<Haiqiang.Gong@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?TWlrZSBaaGFuZyAo5byg5Lyf5LyfKQ==?= <Mike.Zhang@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mm/compaction: add check mechanism to avoid cma alloc
 fail
Thread-Topic: [PATCH] mm/compaction: add check mechanism to avoid cma alloc
 fail
Thread-Index: AQHaTNn7A5RvAL1alUa4iZhYRPGYZrDlZ1cAgAMvRQA=
Date: Wed, 24 Jan 2024 07:37:20 +0000
Message-ID: <94200583c59ce26e5fb16c9d00a4549509951a54.camel@mediatek.com>
References: <20240122022317.30091-1-Haiqiang.Gong@mediatek.com>
	 <8583a965-82ae-42fe-b22a-e84ddda11ae5@linux.alibaba.com>
In-Reply-To: <8583a965-82ae-42fe-b22a-e84ddda11ae5@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB8809:EE_|KL1PR03MB6238:EE_
x-ms-office365-filtering-correlation-id: 0a335448-eed0-4a08-98f3-08dc1caf4c12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IJpCVEbwm5lKr+zE047V+yqJ6QxhgCbDyR/Pnxob7iM6TxiJEkHnJ05bcuQ8Q8lsN41VMvmQFv58KcJapJ1uBFKeFWuGIP7aSzEgEFPFXX15P96Zb1QPo5uXJbFP71n29JI1p8e0pKwStpkm0JF/CUPAYvYkpbYHz3ByO9hMpRSfYde+vyYBV+DhSR6wGNbAs7YijQPAKK+22PpYAvjcCRSHENS/CH5xUYDYa9OI2Kpw1mm8xUV336Oyim9QjRLMGSbbDKHxw5CLDOw4l8OL5TsKIkqaXvAPwYxKG31B2T7DMtWmLasyfMtPG/VY3N0TT6ZigZ7nE7D/sIoj/Y7F9nIf6tySo1o5xdYBRWLAGhPlHxNohmSeLDsq1ca84IAhmLfxdm/s42f048yPhHa81VE5lzl0xS/B8R99r5mA00owZU0JngE7YJxk/rYM0ncXzzmXOBcxlhEswaajDKzyzXS/UTWHn+FK9b3/A+iOfu1e5kT5MxhOXrAp4/X1Sr+A0GzbuGt9gWHROIXYa4PpyMj+iO2AhhmN6VScbAILtOkbz6+BXIh6YgVlrincG3G3NEitJnVCCuK6iUYSm1SJ5jyitui1RzRwCBYTmUzWAf13Niq1+zZg8FJT/K1gr2yuvR10RQe5RzeLwZiIky2IgWo7QV44dsRw/m5yIMI2uzs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB8809.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6506007)(6512007)(53546011)(76116006)(66946007)(316002)(66556008)(71200400001)(110136005)(38100700002)(4326008)(8936002)(6486002)(8676002)(478600001)(2906002)(5660300002)(64756008)(66476007)(66446008)(54906003)(26005)(2616005)(83380400001)(122000001)(36756003)(38070700009)(41300700001)(86362001)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFc3UkNneEgwNlZFZFZLeS9wWkx2VG54ODhBbmh0dE9RS1JvMzdmMU5zRDh4?=
 =?utf-8?B?MVJqYnYyMDMxV2FFcXVRdnVFa1REVHNNVHhDYjBOWkZKQmpBc0cxaGE0ZHZa?=
 =?utf-8?B?TWRBdlFVMSt5T1QxbUZmc2ZGQ09PUkV2eldBYWNuZ3FpRjNRaXFhV1BJcGFI?=
 =?utf-8?B?VUpZbUNYS3VleVVXTUYvM1pmcFovWG4ySS90YUlpSHp4YkpGM0xjZzJhTURh?=
 =?utf-8?B?Q3FmMnNOc3crSk9yWkUrell4NjJibEI0VmRCWjdUZHIwNnpaTmxyRmIrQ0xH?=
 =?utf-8?B?Q0RaZlorMlJLbVdPVjlHYkZpQldwZURNZER3QnZjOWdRaFpYdkxxdEVFNUlI?=
 =?utf-8?B?eTNHSnYzci9iR1UxK21iRXVXL2xiRzRJQTBZckJXY1lUZGdwU1NXMkU4UThV?=
 =?utf-8?B?ZWlzdEh5dHdVRDZVbkdhUktXL1BzckJNVWRFRUxYQmdhcVUvRVVyZWpYNHJ6?=
 =?utf-8?B?dFFpcW9naHlKM3VJWDR6cGgraGROQjJwWWFnOVFNOGJmMUtkMmZMZjJyNzVT?=
 =?utf-8?B?RFlSamtjTFI5VWU3ZTlDSGplMGJDeHNEeTlLMVprbnZHTkREYWJJN2c2WVNF?=
 =?utf-8?B?VEY0d0xucmlUNU80WXE2bzJleFVYYVhURkVaSmVOYzhXVmMyVHhja25qRTRl?=
 =?utf-8?B?MVVPTi8xeWRwQ0gySjQydHVTK2tpeld1YmdGNHRPcnRUNFliY0I2cTF2N3c3?=
 =?utf-8?B?UzJNeGl4TUEyZjZKdW5aTjU0TG94Wll5TTBuTER5WS80WnZQQlJCa1lwd0Jz?=
 =?utf-8?B?cDhtOE5KSkNzd1RKWllrbFZyM3c2eTVONFJESzNFU3kzSm5Ka2hLa0NBZUZ4?=
 =?utf-8?B?VVRJeVJmNW9iYWs2NWZKUjRlY3NzbjhKVUUvRHR4T1JFT1FXckYxY1FiTkoy?=
 =?utf-8?B?WTVGVWdkM0tyQUxySnB3VWFvak84djM1aUNqeXRmZE1oUSs0eDdmQ0c0MzNs?=
 =?utf-8?B?ZkZ0UnNLais4L3E0bVhSN1VTWmpCNHhpenEwMnQzVlFMODBiSXdHblJtSEcz?=
 =?utf-8?B?eUExZWpka3YxL1Z6ZnEzaytEczVxYTV6Mk1mVHZPOENLT0ZUT1o4cURMZXYr?=
 =?utf-8?B?OXp4Wml0Y2Ftak50T08xQ0tpeTEvMitrR0hwZE5hUXM4MlVXRDBjZi9Udnhr?=
 =?utf-8?B?QnlVYXRXTkd3ZHc5VHJPc0FYZ0tYOXRQdldBSDNuUFZ1YjJRaGxlbjVQTDRr?=
 =?utf-8?B?SHVoK1k5QStzQlg1d3JQNFMwV0JMT0Y4ZTZlOTF3RzdUQ2R4U2piSjN4WFJY?=
 =?utf-8?B?eDVlMTZLOHF2ZnlTcjhpV1hmTmFncWhreFhuUDNUSkk5TkliL3NpZVc5Q2Fk?=
 =?utf-8?B?U0FlRC9TdG1zc0hVN0tFMm1STFFrK1RuU3hEU3Rxak1hV0YvRVZYSWV2NGhF?=
 =?utf-8?B?czZ3Z1BJcXFSK2ZkWGFpd3RoamE5V2djTHM0NDd4RWgzTyt6TGxuSThxbWVr?=
 =?utf-8?B?T0lWTHFORjNqUTUxbE9qd2M0NTF2eklQL0RhNU1jQ2xKQ3d3UjFNWUQrVyt1?=
 =?utf-8?B?azREdFR4SG1LT1RPWFdhcllwV21IdFUwbE1NSmlnVHpKK0gxdWNUUTNpNENF?=
 =?utf-8?B?MjNOVTVhaEQzYTRGZyt1U0MvekM2RTVzU1hCZ1k3OGlRd1piTGh0OGp1NTJI?=
 =?utf-8?B?UXhHYWFJNmFEbWxaY2l3NEExbVZiOS9GRFY3Uk5pL2xDNmRTNkM4WUlISjE0?=
 =?utf-8?B?SWY1bzVRYnYzTDZSeUxxYm9mUUZpOUdyTEdIYWZreFRKU2R1bVRLdUY5YjZF?=
 =?utf-8?B?cWlEV0VEeGVYdlVhcmR1M2R4UWhUWkw1Ry9PUmZOVmgxVnBRSGp5ZElSb0FT?=
 =?utf-8?B?NVFQSjRiVFpBVUZEMmtwa3czSENQbEJpVy9pQ0NUa1QzWEYvcHl5WDF4ay9w?=
 =?utf-8?B?Tm5tem1mdDl5QXBtR2xHS2U2T1JuaHk1V0R2ZlZmbnRSRUVydUVmSERoZjU2?=
 =?utf-8?B?Mnk1MVNORGFZWTVha2taVHRLd2Vac00yUVM3R2VyQkVxRDNjQ1FWQzVpSmdO?=
 =?utf-8?B?V21reGY5M3luSmZsTHowQTQrTUNxekFBbW5lSmdBUlBkNEQ5VUpRN3VFVi84?=
 =?utf-8?B?MlNpT3ZJQ1RJSVNjb2xhNHkzenhQekhkblo5WkN3NmF2ekJKd0J2OFV4ZXhI?=
 =?utf-8?B?TU5TU2VtWVRIM3JjRzdBV2tINldHYkxQYUt0KzlDMjN2c3BueUVsbFkxYnZ6?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <207CA64CDB064A49AB22D89ADAC7555E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB8809.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a335448-eed0-4a08-98f3-08dc1caf4c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 07:37:20.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0luYcjo8dOCvKjJup2lyxYkSkxrNF0LSQAtk6sv84m+Kf7QLGTra1CwP4iaHy6DKyQrgirBLSLMFIls80zfevGdIBH4Bp54Qat0C6leX0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6238

PiBXaHkgdGhlIENNQSBtZW1vcnkgY2FuIG5vdCBiZSBtaWdyYXRlZD8gQ291bGQgeW91IGRlc2Ny
aWJlIGluIG1vcmUgDQo+IGRldGFpbCB0aGUgcmVhc29ucyBmb3IgdGhlIENNQSBtZW1vcnkgbWln
cmF0aW9uIGZhaWx1cmU/DQpXaGVuIGFsbG9jYXRlIGZvciBjbWEgbWVtb3J5IGJ5IG1vZHVsZSwg
dGhlIG1lbW9yeSB1c2VkIGJ5IHN5c3RlbSBpbg0KdGhlIGNtYSBidWZmZXIgd2lsbCBiZSBtaWdy
YXRlIG91dHNpZGUgdGhlIGNtYSBidWZmZXIuIElmIHRoZSByZWZjb3VudA0Kb2YgdGhlIGN1cnJl
bnQgcGFnZSBpbiBjbWEgYnVmZmVyIGlzIGdyZWF0ZXIgdGhhbiB0aGUgbWFwY291bnQsIHRoZQ0K
bWlncmF0ZSB3aWxsIGZhaWwuDQpUaGUgcGFnZSB0aGF0IGZhaWxlZCB0byBiZSBtaWdyYXRlIHdh
cyBub3Qgb3JpZ2luYWxseSBpbiB0aGUgY21hDQpidWZmZXIsIGJ1dCB3YXMgbWlncmF0ZSBpbiBj
bWEgYnVmZmVyIGFmdGVyIHRoZSBrZXJuZWwgY29tcGFjdGlvbi4NCkFmdGVyIHRoaXMgbWVtb3J5
IGlzIGtjb21wYWN0ZWQgYW5kIHBsYWNlZCBpbiB0aGUgY21hIGJ1ZmZlciwgdW5kZXIgDQpjZXJ0
YWluIHNwZWNpYWwgY29uZGl0aW9ucywgdGhlIHJlZmNvdW50IG1heSBiZSBncmVhdGVyIHRoYW4g
dGhlDQptYXBjb3VudChleDp0aGUgY3VycmVudCBwYWdlIGlzIGJlaW5nIHVzZWQgYnkgZnMpLCBh
bmQgdGhlbiBtaWdyYXRlDQp3aWxsIGZhaWwuDQoNCg0KT24gTW9uLCAyMDI0LTAxLTIyIGF0IDE0
OjU5ICswODAwLCBCYW9saW4gV2FuZyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDog
UGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlv
dSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICANCj4gDQo+IE9u
IDEvMjIvMjAyNCAxMDoyMyBBTSwgSGFpcWlhbmcgR29uZyB3cm90ZToNCj4gPiBjbWEgYWxsb2Mg
bWF5IGZhaWwgd2hlbiB3ZSBkb2luZyBjbWEgYWxsb2MvZnJlZSB0ZXN0IG9uIGtlcm5lbA0KPiA1
LjEwLzUuMTUuDQo+IA0KPiBEbyB5b3UgaGF2ZSBhIHJlYWwgdXNlIGNhc2UgZm9yIHRoZSBjbWEg
YWxsb2MgaXNzdWU/IEFuZCBoYXZlIHlvdQ0KPiB0cmllZCANCj4gaXQgb24gdGhlIG5ldyBrZXJu
ZWw/DQo+IA0KPiA+IFdlIGZvdW5kIHRoYXQgdGhlIG5leHQgbWVtb3J5IGNhbm5vdCBiZSBtaWdy
YXRlZCBiZWNhdXNlIG9mIHRoZQ0KPiBhbGxvYyBvZg0KPiA+IGZzIGFzIG5leHQgYmFja3RyYWNl
Og0KPiA+IF9fYWxsb2NfcGFnZXNfbm9kZW1hc2sNCj4gPiBwYWdlY2FjaGVfZ2V0X3BhZ2UNCj4g
PiBncm93X2Rldl9wYWdlDQo+ID4gX19nZXRibGtfZ2ZwDQo+ID4gZXh0NF9zYl9icmVhZGFoZWFk
X3VubW92YWJsZQ0KPiA+IF9fZXh0NF9nZXRfaW5vZGVfbG9jDQo+ID4gX19leHQ0X2lnZXQNCj4g
PiBleHQ0X2xvb2t1cA0KPiA+IF9fbG9va3VwX3Nsb3cNCj4gPiB3YWxrX2NvbXBvbmVudA0KPiA+
IHBhdGhfbG9va3VwYXQNCj4gPiBmaWxlbmFtZV9sb29rdXANCj4gPiB2ZnNfc3RhdHgNCj4gPiBU
aGlzIGtpbmQgb2YgdW5tb3ZhYmxlIG1lbW9yeSBpcyBub3QgcGxhY2VkIGluIHRoZSBjbWEgYnVm
ZmVyIHdoZW4NCj4ga2VybmVsDQo+ID4gbWVtb3J5IGFsbG9jIGJ1dCBpcyBtaWdyYXRlZCBpbiBi
eSBrY29tcGFjdGQgd2hlbiB0aGUga2VybmVsDQo+IG1pZ3JhdGlvbi4NCj4gPiBJdCB3aWxsIGNh
dXNlIG1lbW9yeSBjYW4ndCBiZSBtaWdyYXRlIHdoZW4gY21hIGFsbG9jLg0KPiANCj4gV2h5IHRo
ZSBDTUEgbWVtb3J5IGNhbiBub3QgYmUgbWlncmF0ZWQ/IENvdWxkIHlvdSBkZXNjcmliZSBpbiBt
b3JlIA0KPiBkZXRhaWwgdGhlIHJlYXNvbnMgZm9yIHRoZSBDTUEgbWVtb3J5IG1pZ3JhdGlvbiBm
YWlsdXJlPw0KPiANCj4gPiBBZGQgY2hlY2sgbWVjaGFuaXNtIGluIHRoZSBjb21wYWN0aW9uX2Fs
bG9jKCkgd2hlcmUga2NvbXBhY2VkIGFsbG9jDQo+IGZvcg0KPiA+IG1lbW9yeS4gV2lsbCByZXR1
cm4gTlVMTCBhbmQgZ2l2ZSB1cCB0aGlzIG1lbW9yeSBtaWdyYXRpb24gaWYgdGhlDQo+ID4gYWxs
b2NhdGVkIG1lbW9yeSBpcyBpbiB0aGUgY21hIGJ1ZmZlciBhbmQgdGhlIG1lbW9yeSBpcyB1bm1v
dmFibGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpcWlhbmcgR29uZyA8SGFpcWlhbmcu
R29uZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBtbS9jb21wYWN0aW9uLmMgfCAzOCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDM4IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vY29tcGFjdGlv
bi5jIGIvbW0vY29tcGFjdGlvbi5jDQo+ID4gaW5kZXggMjdhZGE0MjkyNGQ1Li4yOWMwNjYxYWRj
MjIgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vY29tcGFjdGlvbi5jDQo+ID4gKysrIGIvbW0vY29tcGFj
dGlvbi5jDQo+ID4gQEAgLTI1LDYgKzI1LDExIEBADQo+ID4gICAjaW5jbHVkZSA8bGludXgvcHNp
Lmg+DQo+ID4gICAjaW5jbHVkZSAiaW50ZXJuYWwuaCINCj4gPiAgIA0KPiA+ICsjaWZkZWYgQ09O
RklHX0NNQQ0KPiA+ICsjaW5jbHVkZSA8bGludXgvY21hLmg+DQo+ID4gKyNpbmNsdWRlICJjbWEu
aCINCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+ICAgI2lmZGVmIENPTkZJR19DT01QQUNUSU9ODQo+
ID4gICAvKg0KPiA+ICAgICogRnJhZ21lbnRhdGlvbiBzY29yZSBjaGVjayBpbnRlcnZhbCBmb3Ig
cHJvYWN0aXZlIGNvbXBhY3Rpb24NCj4gcHVycG9zZXMuDQo+ID4gQEAgLTE3NTgsNiArMTc2Mywz
MyBAQCBzdGF0aWMgdm9pZCBpc29sYXRlX2ZyZWVwYWdlcyhzdHJ1Y3QNCj4gY29tcGFjdF9jb250
cm9sICpjYykNCj4gPiAgIHNwbGl0X21hcF9wYWdlcyhmcmVlbGlzdCk7DQo+ID4gICB9DQo+ID4g
ICANCj4gPiArI2lmZGVmIENPTkZJR19DTUENCj4gPiArc3RhdGljIGJvb2wgaXNfaW5fY21hX3Jh
bmdlKHN0cnVjdCBmb2xpbyAqZm9saW8pDQo+ID4gK3sNCj4gPiAraW50IGk7DQo+ID4gK3Vuc2ln
bmVkIGxvbmcgcGZuID0gMDsNCj4gPiArc3RydWN0IHBhZ2UgKnBhZ2UgPSBmb2xpb19wYWdlKGZv
bGlvLCAwKTsNCj4gPiArDQo+ID4gK3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2UpOw0KPiA+ICtmb3Ig
KGkgPSAwOyBpIDwgY21hX2FyZWFfY291bnQ7IGkrKykgew0KPiA+ICtzdHJ1Y3QgY21hICpjbWEg
PSAmY21hX2FyZWFzW2ldOw0KPiA+ICsNCj4gPiAraWYgKGNtYS0+YmFzZV9wZm4gPD0gcGZuICYm
IChjbWEtPmJhc2VfcGZuICsgY21hLT5jb3VudCkgPiBwZm4pDQo+ID4gK3JldHVybiB0cnVlOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtyZXR1cm4gZmFsc2U7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0
YXRpYyBib29sIGZvcmJpZF9tb3ZlX3RvX2NtYV9yYW5nZShzdHJ1Y3QgZm9saW8gKnNyYywgc3Ry
dWN0DQo+IGZvbGlvICpkc3QpDQo+ID4gK3sNCj4gPiAraWYgKGZvbGlvX21hcHBpbmcoc3JjKSAm
JiBpc19pbl9jbWFfcmFuZ2UoZHN0KSkNCj4gPiArcmV0dXJuIHRydWU7DQo+ID4gKw0KPiA+ICty
ZXR1cm4gZmFsc2U7DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+ICAgLyoNCj4gPiAg
ICAqIFRoaXMgaXMgYSBtaWdyYXRlLWNhbGxiYWNrIHRoYXQgImFsbG9jYXRlcyIgZnJlZXBhZ2Vz
IGJ5DQo+IHRha2luZyBwYWdlcw0KPiA+ICAgICogZnJvbSB0aGUgaXNvbGF0ZWQgZnJlZWxpc3Rz
IGluIHRoZSBibG9jayB3ZSBhcmUgbWlncmF0aW5nIHRvLg0KPiA+IEBAIC0xNzc1LDYgKzE4MDcs
MTIgQEAgc3RhdGljIHN0cnVjdCBmb2xpbyAqY29tcGFjdGlvbl9hbGxvYyhzdHJ1Y3QNCj4gZm9s
aW8gKnNyYywgdW5zaWduZWQgbG9uZyBkYXRhKQ0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gICBkc3Qg
PSBsaXN0X2VudHJ5KGNjLT5mcmVlcGFnZXMubmV4dCwgc3RydWN0IGZvbGlvLCBscnUpOw0KPiA+
ICsjaWZkZWYgQ09ORklHX0NNQQ0KPiA+ICtpZiAoZm9yYmlkX21vdmVfdG9fY21hX3JhbmdlKHNy
YywgZHN0KSkgew0KPiA+ICtwcl9ub3RpY2UoImtjb21wYWN0ZDogY291bGQgbm90IG1vdmUgbm9u
LWNtYSBtZW1vcnkgdG8gY21hDQo+IGJ1ZmZlclxuIik7DQo+ID4gK3JldHVybiBOVUxMOw0KPiA+
ICt9DQo+ID4gKyNlbmRpZg0KPiA+ICAgbGlzdF9kZWwoJmRzdC0+bHJ1KTsNCj4gPiAgIGNjLT5u
cl9mcmVlcGFnZXMtLTsNCj4gPiAgIA0K

