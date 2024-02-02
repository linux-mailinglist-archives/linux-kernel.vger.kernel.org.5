Return-Path: <linux-kernel+bounces-49528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB334846B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828C2290211
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827B77F06;
	Fri,  2 Feb 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SKFgKUKf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gmT0rL3D"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E365FDBE;
	Fri,  2 Feb 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864616; cv=fail; b=aOxWMgPhFGdXwKn2izncK2o/UqvqjK8ENRPf8LS+YDYJ6OoYKlCNNepN5ZwGtgNvMv7/MoVs2U1o71jSwN4kzt1tio5IfHx4lAW8M18XGRbRkz/cvYC4WKMu5/fZd1YQR0bTU3aMfcgGMSoE0dZ2TSV/Mesb4ZtzpO2eQOxgwxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864616; c=relaxed/simple;
	bh=M69mn8nZ58P0wDAU9RYJXQINOc5Bn9NH4DZoZcxPNd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YnPe9vyLYf6aR/x4lSAEjd1+LCX6cQmG9m1kia14Xc+AqRAnR0QWo0jPUnz5E6PmpufyhYPrDquS4qzxipNYFHbDtSNwNTg197y/2VeoykYfbenaJA7p3z6fzmGvtPTYazls2xYpYvMiwQvZMXEY0gpom34btUf5r4f9KdKSgJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SKFgKUKf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gmT0rL3D; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ed813dd4c1a911ee9e680517dc993faa-20240202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=M69mn8nZ58P0wDAU9RYJXQINOc5Bn9NH4DZoZcxPNd8=;
	b=SKFgKUKfgMNun23YDPK9UpWv24+zENq1f5ykNpZTED0FVyEWIb0hQBheXC6BV13Pc4i3/gLFi1QBlaSdmvDHvtW2MDxedNYPr8jsEfia7LHA9Tv5GW/S+u+P4G0zNzfHK5z93wY6WzaJx/toVW7Oxj8ekhPJLnGyEIXqj3s2k1E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:c628993a-be8e-4c0b-ab15-964c9fbb794e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6e16cf4,CLOUDID:e02d71fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ed813dd4c1a911ee9e680517dc993faa-20240202
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1399240330; Fri, 02 Feb 2024 17:03:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 2 Feb 2024 17:03:27 +0800
Received: from SG2PR03CU006.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 2 Feb 2024 17:03:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFyysjGkQwMv8G0mEtogBmZKz8BVPYhHgF639+Gh+QGdyp4T09nB7NHOrxByFh+eA2gBkq9s27gYh3JqNcshzTWyJm+YsQ+khWY6QL+/6UkayJm8+zoFJ3IeGWN8xMUQEN1Cf7FhH6/Mi5WzF5ixkTm2qsxGz2JvA3na1KsivfHP6ozQ/XRCkM2+8bbCK7BIJW2ouLe8gWUGoHIPRtbatHzIiu18qw97o/zYtLvMMc6KxuHVsgAye94oV1croQbI18oIn3DT/gCU4FdKaz8/+S9s6f9uciNDM7L2RzaqjhpYjaXlIJIXk3pgB8rq72joLQ58ojv1DL+iCoy38dYJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M69mn8nZ58P0wDAU9RYJXQINOc5Bn9NH4DZoZcxPNd8=;
 b=OpRyjpIeSWQcrS92KFTblKcvcFXfYwo0yl6xrO/P0XLpTTOLASpzPUR/He0Hog4jlC3muGZpQxwTj/uU1OpbTgfHCR9/IoayCJ96xcbPretqNgzsvATYuJCmgkTLoqsqeICEpDn9mI2uhAuf8YKhKjsO/2osmGwi1FFPnUBazdVDX+SRWayNxkb2U9tLRXLssMHL032eK2eBMlmxvzQBn2ZEy30LUtCBN/Xr3A70xBqB3WwUaC0bsdKbvXFUANXSkqk99E5FPnnME7rfLXTY+ymxAu0QQC5bcqSg3fEdVe2XMpr3U8QuIZm75X4UfetdTXDFV8gPzDuO8WJjGh7SwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M69mn8nZ58P0wDAU9RYJXQINOc5Bn9NH4DZoZcxPNd8=;
 b=gmT0rL3DSuSl0GWAVIvJrUdK+Lk2zDG+lBn5Yebp+D3yxAyOz/6ph3XctB0nRD+NzRkyhI7kI7ttU1FUp7jy79xdcpzaPVeoG5CBcsT0457j6V/vnIWoOh0bzCkONbIQF8uqv/YnfiX0SeSS7gPI7EabuMPFMl3UIxw2NXSTuDE=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB6845.apcprd03.prod.outlook.com (2603:1096:400:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 09:03:24 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b%6]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 09:03:24 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "wenst@chromium.org" <wenst@chromium.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "sean@poorly.run" <sean@poorly.run>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "fshao@chromium.org"
	<fshao@chromium.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 00/17] Support IGT in display driver
Thread-Topic: [PATCH v4 00/17] Support IGT in display driver
Thread-Index: AQHaVPfPv1Gpo5yi7ka6REiqnSxjgbD2w2mA
Date: Fri, 2 Feb 2024 09:03:24 +0000
Message-ID: <16b2d96543e900741aa03864d671ed9cce3d0e4e.camel@mediatek.com>
References: <20231212121957.19231-1-shawn.sung@mediatek.com>
	 <488c6f38-02c6-4e62-b90b-d2ac112541ae@collabora.com>
In-Reply-To: <488c6f38-02c6-4e62-b90b-d2ac112541ae@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB6845:EE_
x-ms-office365-filtering-correlation-id: 6b11e519-70ae-49ad-51da-08dc23cdd035
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: blqs7jwVmFOdVO98L8GI2uCfr8B2fxUwheuYXUa2nFiEljg+TWd5I3EZHXUjrJK1F6TRr+JHieRculd3rL2LPAORu6lLp85Ffnc0Y24RmfrXCD9E2vtgZms09ZGRscaFQHbPoU97VsBOkbx/GCqNQrjtf4N6Kt3Wv2OzKgdV8rh4uvNq6T9r3y5+6LmiVY9/pFVSyZk2JJwUmKc0d4W9qk69qRtTMiUubtLAAxnjrkLjSblBZRv5nrYFW1yGVIZnbGBfQxpkI502rEtl1/kVk8gqIMeTk0SoXenN+GPzat2Bah/OyuELrMOUCI4dgItHxhGtbWykHTf6rm+KLkyJjHUgba+gKS2Q/gCIm6/oeV+VTJ/qo8cP+89v9VkJ67B4KZtLTkJuLzYpmyKrhvUUB71kWRCcfeLLwW9WTX6O2I07U6piP8P7cQJnrxip3pgQxuwtC1RMtE5OzT4gD3zIckQHnyXa09nqKi71r/kE3xq/1jFU1ngo16QS3nP8d0uYF8DonGj1zXIXLJJQxISQm0/KjxJbNfU2mYHIfZ/Hcq4hVjLPJB6QUJpd7yiD6N6QXtarZcMRAXL0MQlwinEUFmhpRWDpauiMaidbHHZWFgAzVB5v+PHCGQy58rZhj9pd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(64756008)(2906002)(5660300002)(7416002)(41300700001)(86362001)(85182001)(36756003)(478600001)(6486002)(38100700002)(38070700009)(6506007)(83380400001)(2616005)(6512007)(26005)(122000001)(71200400001)(8936002)(316002)(8676002)(66946007)(4326008)(54906003)(76116006)(66446008)(110136005)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFIzWUtMUENxUGJvVFV3YjNzVHdLdHBmNDh5bVVQT1I3b0NKTkxYeG16eEVW?=
 =?utf-8?B?MHVyeEtYcjVPYSt3SHZLQWI1MWcrMFMyKy9SRUpXd1IxOFRGT1huTjM4Y2hx?=
 =?utf-8?B?YU5ySGpuSEhIR1FXbzdweHpzdVVlSnNYZWR2Rk1sUmQrVXNVYmFla0dpc2hw?=
 =?utf-8?B?QlVFRVhZY0xQSWYvWThXdHBSRWg4RVJwUEhYOWowS0NRbXdYalpiMi9MMmMx?=
 =?utf-8?B?T2xiNXBIeUtwZU5hN3c3UUZEbWFIMWhyeXpiRG5sTS95aHN6aFJJdElMWkxm?=
 =?utf-8?B?TFZXUEQvenRINlp3dzUrNWovMnVlT2VxUWNxVjQ2QjI4OHJPUXB6U0YrUGIr?=
 =?utf-8?B?aDRwNXpONGx1K3VzeHpCeFlRRmpzSS8weUFBYVJUVkdkWE5MYTBOWitpSEFT?=
 =?utf-8?B?bnRrZnRTRFBEZnNsMHVvVjRLVXpJa1Q2UjgzejNIdjNWdnBHamh1MWhQUnZO?=
 =?utf-8?B?elVMNFBVK1FoVmJ4dndJMlpQaXJCUTY1QVJnd0plaENDZnY3K055cHJzUWk0?=
 =?utf-8?B?NG1JdDdncjJGWU5tR3RMVzB0YzJjc2tJekJsRHgyRmNCa3owOWdHejkxY1Z0?=
 =?utf-8?B?UzVJbWljTTdRMWtxczJodnVTNW90R3d4OXlEOXV1VDc2RHhkd0FxSTl2Vy9j?=
 =?utf-8?B?RzZwbVRvbVlvNFJvcmVtM0cwWG9TK2d1SjREeXZHbjlBN3pkVTBzZEkwUEpV?=
 =?utf-8?B?bnIxaytmVFI5SkxIMzNrTjdyM2lhN1RTMFJHWUNWcU5zUzVJY1RMWm14NVZZ?=
 =?utf-8?B?OExmbDg3Y1I4TGgxZytRQm1jdXZ1VC9WVlU0RFlqVURRUkZiSzBWTE5kUkkx?=
 =?utf-8?B?VVRKY1VjZGdFSDNLNDJGQWpMTkxxRUJ2YmJuY1lVN3JXTHZsRVZ2STJUTisz?=
 =?utf-8?B?QSs1R3FWajF2K05BWWZ1bG4xL0dsalRQa0VGZFp5SVE1VWdQOWVGTGJ6L3VH?=
 =?utf-8?B?QnZPa01waGRjVFNGNW5JOWlhd1dFUmRtZDhta0hGVTIxdXZXWG1YS0NiM21Q?=
 =?utf-8?B?SkUrSUFZeVZwMUxnQi9qQWxYNUZ0MXNWS2hNRlA3blFtR1JHY2M1b0ZPcXNS?=
 =?utf-8?B?KzNDb3JBSjBEa3laOSsrL1lqK0tZSmJtKy93MWx2UEd5NlNCRHRydlVhVFVx?=
 =?utf-8?B?R3FzcXR6SDl5MCtxcC9IM1hNMjZtU0dxVlZldyt6QnZUMFJuajExSXJGQTRw?=
 =?utf-8?B?Tldmbm80NHVIaHBqZ1hqVS82UUswaEZmZ2ZYTjdvUmdSeitEUVI3bTlhMVNB?=
 =?utf-8?B?UmIrMHNpaXRZTUZvTTVuZm1Eckk2SjN5N0wxVCtnUENGSHoxYjlnTFJoeVkr?=
 =?utf-8?B?UUlObEk5MnFxbzJQdVZxY0d0WndWU01ORU1QaFNSNXpHd3FvUWJyOXpySmlN?=
 =?utf-8?B?bVU2Nkd6MG9qS3dEOWRFT05CY1ppNjlCVnFmVzNaYXpLZDBDWHdLTGxPNnJP?=
 =?utf-8?B?K3llU2IxZ1RQZ2VucDhNaTQ4ZUV1ejZ4RndGU1ROUmtpL1pZcEVQTDZTYVMy?=
 =?utf-8?B?NU1LUnRKa0IrMERRSVFPdENmUEZDamlJM1RpSHlkcW9ya1JlL2M1elBKSGJG?=
 =?utf-8?B?bFdRNFJndWQ1aUxob1Rqb2JIZlRqQWxwTFVCOUoxRG80VnJ5REhyVnBmN2VK?=
 =?utf-8?B?dG1uL0EyNVdoQUp1K0hBU215TnQzNXFMZW92S2Yrc2tPUmxGcDVrd2Y5ZXV5?=
 =?utf-8?B?Q2dXallHMjJpUFhVUm1nM0FDSi9KQURnbFE1SzJVY3BaLzZQdXpHRmRHT0Rm?=
 =?utf-8?B?OG9NMGZYRVUrSGZOZ1kvQ09HQ1pYUEEzRTNWUHcyMlFZUFpXdGZqWmFQZTBo?=
 =?utf-8?B?ZXByRXR6bUIrNFROYmhFSkVmT2hmYmxid0FRSjJWUEpiK1AwblV1OWpSNmJx?=
 =?utf-8?B?bTdGSHh1Qk5jNlBtOE9ZdnQzZ0pnVUZHaE5mSXcrS3pzTVpoMnFCRnNMUnZo?=
 =?utf-8?B?bUNKMlVMZmU5eWR6Z1h0eno2OFRMU1dQUk56clVVc1VpNlYxWUx6V3NIVFk3?=
 =?utf-8?B?RThFNjJySUFhaEYwbjAyVzY5YW1QaWZkMmlQRnJlNUtPdkIyM0NJUU5QbDNP?=
 =?utf-8?B?NGZvSmt4L0lBRkh3ZnB6VmYweVNWNm5OUjhCWTEyRVZoWFFoUm9vL1ZjYVEy?=
 =?utf-8?B?STNqYjhlYUhiYitYQVR2QkZBcTNDZWV1RWNrejVxYVNmS09yeVZHV0lHcnlx?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AEFA92CEA301A49B7BFAD800529D629@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b11e519-70ae-49ad-51da-08dc23cdd035
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 09:03:24.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4S7vsaKH5LMwXPZDacCbnEThGB22mFwgyJtpe8Up+siJhOxlujd6LcwfjrP9sGaqXG9yZt2FITnF77eqNIthg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6845
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--27.724100-8.000000
X-TMASE-MatchedRID: cnNFLnOjrwrUL3YCMmnG4uYAh37ZsBDCiEwiOzRB3tmyrCkM9r1bWskU
	hKWc+gwPGW+KqRvmaRIAgSjIo695vnYIQoHEix+qQ4srjeRbxTaISipZVWCNK3XeJBXr7CDUxxE
	lGvP0lfhfcTZ8crFLkgBBzkZim72jjO057fOvdiTFC8wQUwBwJUCrr/LkAQ46theGvryNtj5Y/2
	uYvI7ywkGLVpsvBXjrNfE/lF/5Ogt8tzbYIxQT63BRIrj8R47FWjWsWQUWzVpEv26FkhjLXdQp1
	3WV31nKDhvMbmjzyBCEY18t0aOvew+/n/431GMSl84YvuxrULJ3Bf9JIqsoeNchlMhSt6Fev8rX
	lDJgQdHEtdK7zJNQmv6xqC/N1Cizz7wL+9mPXSWXZ9FWlXKjpEyQ5fRSh265Ri9INZ1ZpGFdpMS
	iKlvaL+LzNWBegCW2PZex/kxUIHWNo+PRbWqfRJBlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--27.724100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1606DE9CADF64450E07709360664B5CD308CE6D1B11BC914E403BA2DEA38FC372000:8

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZW1pbmRlci4NClRoZSBuZXh0IHZlcnNpb24g
aXMgZXhwZWN0ZWQgdG8gYmUgcmVsZWFzZWQgbmV4dCB3ZWVrLg0KDQpSZWdhcmRzLA0KU2hhd24N
Cg0KVGhlIG5leHQgdmVyc2lvbiB3aWxsIA0KT24gVGh1LCAyMDI0LTAyLTAxIGF0IDExOjE2ICsw
MTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMTIvMTIvMjMgMTM6
MTksIEhzaWFvIENoaWVuIFN1bmcgaGEgc2NyaXR0bzoNCj4gPiBUaGlzIHNlcmllcyBpcyBiYXNl
ZCBvbiBtZWRpYXRlay1kcm0tbmV4dC4NCj4gPiANCj4gPiBUaGlzIHNlcmllcyBhZGRzIHN1cHBv
cnQgZm9yIHJ1bm5pbmcgSUdUIChJbnRlbCBHUFUgVG9vbCkgdGVzdHMNCj4gPiB3aXRoIE1lZGlh
VGVrIGRpc3BsYXkgZHJpdmVyLiBUaGUgZm9sbG93aW5nIGNoYW5nZXMgd2lsbCBiZQ0KPiA+IGFw
cGxpZWQ6DQo+ID4gDQo+ID4gMS4gQWRkIGEgbmV3IEFQSSBmb3IgY3JlYXRpbmcgR0NFIHRocmVh
ZCBsb29wIHRvIHJldHJpZXZlIENSQ3MNCj4gPiAgICAgZnJvbSB0aGUgaGFyZHdhcmUgY29tcG9u
ZW50DQo+ID4gMi4gU3VwcG9ydCBoYXJkd2FyZSBDUkMgY2FsY3VsYXRpb24gaW4gYm90aCBWRE9T
WVMwIGFuZCBWRE9TWVMxDQo+ID4gMy4gU3VwcG9ydCBhbHBoYSBibGVuZGluZyBpbiBib3RoIFZE
T1NZUzAgYW5kIFZET1NZUzENCj4gPiANCj4gDQo+IEhlbGxvLA0KPiBpcyB0aGVyZSBzdGlsbCBp
bnRlcmVzdCBpbiB1cHN0cmVhbWluZyB0aGlzPw0KPiANCj4gV2UncmUgaW50ZXJlc3RlZCBpbiBl
bmFibGluZyBtb3JlIGNvbXByZWhlbnNpdmUgSUdUIHRlc3RzIG9uIE1lZGlhVGVrDQo+IFNvQ3MN
Cj4gYW5kIHRoaXMgc2VyaWVzIGlzIGRlZmluaXRlbHkgdXNlZnVsLg0KPiANCj4gUmVnYXJkcywN
Cj4gQW5nZWxvDQo+IA0KPiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gLSBTZXBlcmF0ZSB0aGUgcGF0
Y2ggaW50byBzbWFsbGVyIG9uZXMNCj4gPiAtIENoYW5nZSB0aGUgdGl0bGUgb2Ygc29tZSBwYXRj
aGVzDQo+ID4gLSBSZXZlcnQgdGhlIGNoYW5nZXMgdGhhdCBhcmUgbm90IHJlbGF0ZWQgdG8gdGhl
IHNlcmllcw0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gLSBNb2RpZnkgdGhlIGR0LWJp
bmRpbmcgZG9jdW1lbnQgb2YgTWVkaWF0ZWsgT1ZMDQo+ID4gLSBTZXQgRFJNIG1vZGUgY29uZmln
cyBhY2Nyb2RpbmcgdG8gdGhlIGhhcmR3YXJlIGNhcGFiaWxpdGllcw0KPiA+IC0gUmVwbGFjZSBj
bWRxX3BrdF9qdW1wX2Fic29sdXRlKCkgd2l0aCBjbWRxX3BrdF9qdW1wKCkNCj4gPiANCj4gPiBD
aGFuZ2VzIGluIHYyOg0KPiA+IC0gU2ltcGxpZnkgQ01EUSBieSBhZGRpbmcgY29tbWFuZHMgdGhh
dCBhcmUgY3VycmVudGx5IHVzZWQgb25seQ0KPiA+IC0gSW50ZWdyYXRlIENSQyByZWxhdGVkIGNv
ZGVzIGludG8gbmV3IEFQSXMgZm9yIE1peGVyIGFuZCBPVkwgdG8NCj4gPiByZXVzZQ0KPiA+IC0g
QWRkIENQVSB2ZXJzaW9uIENSQyByZXRyaWV2YWwgd2hlbiBDTURRIGlzIGRpc2FibGVkDQo+ID4g
DQo+ID4gSHNpYW8gQ2hpZW4gU3VuZyAoMTcpOg0KPiA+ICAgIHNvYzogbWVkaWF0ZWs6IEFkZCBy
ZWdpc3RlciBkZWZpbml0aW9ucyBmb3IgR0NFDQo+ID4gICAgc29jOiBtZWRpYXRlazogRGlzYWJs
ZSA5LWJpdCBhbHBoYSBpbiBFVEhEUg0KPiA+ICAgIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBtZWRp
YXRlazogb3ZsOiBNb2RpZnkgcnVsZXMgZm9yDQo+ID4gTVQ4MTk1L01UODE4OA0KPiA+ICAgIGRy
bS9tZWRpYXRlazogQWRkIE9WTCBjb21wYXRpYmxlIG5hbWUgZm9yIE1UODE5NQ0KPiA+ICAgIGRy
bS9tZWRpYXRlazogU2V0IERSTSBtb2RlIGNvbmZpZ3MgYWNjb3JkaW5nbHkNCj4gPiAgICBkcm0v
bWVkaWF0ZWs6IFN1cHBvcnQgYWxwaGEgYmxlbmRpbmcgaW4gT1ZMDQo+ID4gICAgZHJtL21lZGlh
dGVrOiBTdXBwb3J0IGFscGhhIGJsZW5kaW5nIGluIE1peGVyDQo+ID4gICAgZHJtL21lZGlhdGVr
OiBTdXBwb3J0IGFscGhhIGJsZW5kaW5nIGluIGRpc3BsYXkgZHJpdmVyDQo+ID4gICAgZHJtL21l
ZGlhdGVrOiBTdXBwb3J0IENTQyBpbiBPVkwNCj4gPiAgICBkcm0vbWVkaWF0ZWs6IFN1cHBvcnQg
bW9yZSBjb2xvciBmb3JtYXRzIGluIE9WTA0KPiA+ICAgIGRybS9tZWRpYXRlazogVHVybiBvZmYg
dGhlIGxheWVycyB3aXRoIHplcm8gd2lkdGggb3IgaGVpZ2h0DQo+ID4gICAgZHJtL21lZGlhdGVr
OiBTdXBwb3J0IENSQyBpbiBkaXNwbGF5IGRyaXZlcg0KPiA+ICAgIGRybS9tZWRpYXRlazogU3Vw
cG9ydCBDUkMgaW4gT1ZMDQo+ID4gICAgZHJtL21lZGlhdGVrOiBTdXBwb3J0IENSQyBpbiBPVkwg
YWRhcHRvcg0KPiA+ICAgIGRybS9tZWRpYXRlazogQWRkIG1pc3NpbmcgcGxhbmUgc2V0dGluZ3Mg
d2hlbiBhc3luYyB1cGRhdGUNCj4gPiAgICBkcm0vbWVkaWF0ZWs6IEZpeCBlcnJvcnMgd2hlbiBy
ZXBvcnRpbmcgcm90YXRpb24gY2FwYWJpbGl0eQ0KPiA+ICAgIGRybS9tZWRpYXRlazogQWRkIGNv
bW1lbnRzIGZvciB0aGUgc3RydWN0dXJlcw0KPiA+IA0KPiA+ICAgLi4uL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssb3ZsLnlhbWwgICAgICAgIHwgIDEyICstDQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgfCAgIDcgKw0KPiA+ICAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jICAgICAgIHwgMzI2DQo+ID4gKysrKysrKysr
KysrKysrLS0tDQo+ID4gICAuLi4vZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRv
ci5jICAgfCAgMzIgKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Ny
dGMuYyAgICAgICB8IDI2MQ0KPiA+ICsrKysrKysrKysrKystDQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmggICAgICAgfCAgMzkgKysrDQo+ID4gICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jICAgfCAgIDcgKw0KPiA+ICAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCAgIHwgIDM1ICsrDQo+ID4g
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAgICAgfCAgMzAgKy0N
Cj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oICAgICAgICB8ICAx
NiArDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jICAgICAg
fCAgMTUgKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYyAgICAg
ICAgICB8IDEwNiArKysrKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRo
ZHIuaCAgICAgICAgICB8ICAgNSArDQo+ID4gICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstbW1z
eXMuYyAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaCAgICAgICAgIHwgIDEwICsNCj4gPiAgIDE1IGZpbGVzIGNoYW5nZWQsIDgz
NCBpbnNlcnRpb25zKCspLCA2OCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiAtLQ0KPiA+IDIuMTgu
MA0KPiA+IA0KPiANCj4gDQo=

