Return-Path: <linux-kernel+bounces-51449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDBA848B61
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639481C218B6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F877494;
	Sun,  4 Feb 2024 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WoeHsUIx";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iacbfKCy"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07CB8F47;
	Sun,  4 Feb 2024 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707026618; cv=fail; b=i2NPHVhv6XTVN6vKDzQUKrCErApQaKeRk+gTJoyjiMAHxKFLS9aaEhEaOTUKpK03pii6XkXOG+5IFHeaOEw6X/mi03/3rfois3paWrQvM8umWPGMYV03f73ZudSdYDlIP946IKGCiHZVWx7pwTnk9rq7zS0q2TnoD+MUyZ2NdG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707026618; c=relaxed/simple;
	bh=gYSqLCj5J6woVOYsUOqL6Z6RffECVOCWZY6kFl6LS9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqdmyO8ZqJWWkQMVajcwL2HARt6LvfDmAQM4TlOk9FKi6o5U17yhvIst9LD9BFVobyOAYJozhBg0Lky21mr+QaY7zJBqInCSZaiR/mkMub59uYxlDXatxEQ+PDxW4WyxGzZGUjTA8IC+bMK8LkJCgdHrLhhnf1BzkV7lw/7eKOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WoeHsUIx; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iacbfKCy; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1b9d5d90c32311ee9e680517dc993faa-20240204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gYSqLCj5J6woVOYsUOqL6Z6RffECVOCWZY6kFl6LS9I=;
	b=WoeHsUIxqDEja3l/ZgsWUKP87cwxmCi7kb6M8Kwbtwt/wIszdrHlpfQAl2FbY8zbsn7xacdavwoPzfZxjlq0xAky2viWX1x13YUjT3wpc3VN+ITwdK9r+RbZjslqD40zZNFGIMhC9lbVh/WgfcVmtbO17WXq9fIy/i5ym6ny2yc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:f3930714-2043-411f-ab12-9e77c539c434,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:5ebcfe8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1b9d5d90c32311ee9e680517dc993faa-20240204
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1910705514; Sun, 04 Feb 2024 14:03:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 4 Feb 2024 14:03:23 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 4 Feb 2024 14:03:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5pCJvpQk8nMlNUVY/Yjd2TSSDY7B+ol0IwhkOpBRYKmQ/VNAZASOki4Wa/7P9NFdQK9VzOzmJQQC4t8bTj2XY15hHu0wg7NLijdj8RBAof2VvkIKdHJW/HzPScv2nAvcqj9T43v8Buz01kAR0xG/GTZYBAqb8U9MHB1gR7G5TjO0FKFDPLp3ETc6OJvdO6meAcLyV61lPXlrEI2aJlIdNcC7JRBJOdqCYU4m3N5DQ1KwtPmCWFzhAsVq2E3O+aHuP9YCCtlWJU/kLW7LvIRXKfLK8PelXrUO4lhPuvcmigBCLxgkp91YZRYq2IpzNt3JQBMSLhMoD/Hdgd1jKxNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYSqLCj5J6woVOYsUOqL6Z6RffECVOCWZY6kFl6LS9I=;
 b=YGeiWmJOCc+QRDeH3I+MMjokxIhenOn8iVXDYXG8ByotcZPHeaYdO14UtuQmPMKaYSbS4MXyGvvnhGinAtpJfiVEIi4rV7wykxmG6dv7Perr/gBfcPCubJxYZtvJGG7zikXhhZ4n+ilry8HEoqTstl1MDWA38fLz/YKVQOXUf2+IacXfaw3wuhrflypDrgxebVFWx4j4VKaJJy6f8rK0rw2+86gs2FFuTNmGVREERyefSH9rr//4SNuEGBvrrKsAoIF2/lVRsuZaMSiKdDVFZndhbz20ISDc9Mf2VhU91yH3lW3UUM6aFPdwlN8eNs9rRTwIR7UKUSGgnfrFVpyK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYSqLCj5J6woVOYsUOqL6Z6RffECVOCWZY6kFl6LS9I=;
 b=iacbfKCyOjbjtFxE3A4iBu6CSquGufX7vdI53gz2ouWpjH3oc/NZaQ5p2aF4CA2ya57Fd+kEqzV4BjT2zjHblFRky7BrMAEc7SFgiwY9jhNxf4st+pW6OwC4KgXhk3E7rvq9NVgqbx7u1VzL2NFUHZeDAurjaT5JnTS0Yhof4JI=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by SEZPR03MB7245.apcprd03.prod.outlook.com (2603:1096:101:a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Sun, 4 Feb
 2024 06:03:18 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::8146:6419:98ce:83a2]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::8146:6419:98ce:83a2%6]) with mapi id 15.20.7249.027; Sun, 4 Feb 2024
 06:03:18 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 2/2] usb: mtu3: Add MT8195 MTU3 ip-sleep wakeup support
Thread-Topic: [PATCH v2 2/2] usb: mtu3: Add MT8195 MTU3 ip-sleep wakeup
 support
Thread-Index: AQHaTSTHKySgsdH8UEyCZEa9lE7hgLD5xWYA
Date: Sun, 4 Feb 2024 06:03:18 +0000
Message-ID: <0f96aac2ee16c31808f22853fdf746678f5284e8.camel@mediatek.com>
References: <20240122111809.148546-1-angelogioacchino.delregno@collabora.com>
	 <20240122111809.148546-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240122111809.148546-2-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|SEZPR03MB7245:EE_
x-ms-office365-filtering-correlation-id: e88b3033-b877-41b0-ae19-08dc2546fbb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zs7nSkVWyhsgTf/2DA995Hi1Z978H+Cp6o46Mg3HZmu4NSxOR2C2hzqMuTKvyUA4oCGOHF49BWXx4EpLGoBvk2D44Yosg0WqISm2pFjGGzE/wFMCLTnkgtkSH68pXeqUmWqFBSHvtTLbF8Gr6Hz5Vl/AVaKyRXtsohNe9diLeXqzIQ0TvNue5MAwZBJumwRnY2AvvYynNl4tS4PT80CMqv2FBP+do4NSGfupqDXBxzvfXdqobDuw/OXggTbYaEdSddY/kk5dcwUVVD2/+LSAEHO/w00n39p8x6OVnPVupTgNEeZ4LN6ktJf8HztPdRPq2EeEPqICINEOJ31FMxwWoGhhIV0td1XJhESkK5YNVHJYOculK1ZPdjeAKuzDdCaRGPvd8W1HhW2AkV82L5NDNWJ3Pd+H+R+BGR6sCfajnMNKUL8HDb760C8KnsBfH/ThYwPn4+O+aNOPFvKcZ0sbP+NpWrIl0NZr59Swgt8Bo9dYL3q38ZE5uv5mMqvZgrdQoQVf76EZMhv4G1HKJ0kWxkYWz00Bi1s9y/KPWxt0Y0uYNljfIMzlaouMDnmr5406NcsANaj+oUCYTA8kx/pM4F0EF0hLZT20migW9NtYg2olM6Xw6S47QrV/Hj51th8a42X2S+lOr2IwwMr0UkUNvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(26005)(2616005)(38100700002)(76116006)(6916009)(8936002)(4326008)(8676002)(122000001)(71200400001)(54906003)(66476007)(66946007)(316002)(66446008)(66556008)(64756008)(5660300002)(2906002)(7416002)(6506007)(6486002)(6512007)(478600001)(38070700009)(85182001)(36756003)(86362001)(41300700001)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0ZDaXNNSUhCV0k5bm1EWlZEdGhDbDZtVC9GYVBtVjJ6Q3BGSzVGS0JpYUZF?=
 =?utf-8?B?ZzdabGY0OUZiTjBGYWNFNFpVcGpYc2F5b1htUjVGVHZBc0VQZ28vdmtSNmpO?=
 =?utf-8?B?RUJCNy9ScWRBRWpRYjltL3dDZkk3SS9raDRqQi9EWi9mZlVMYTRnYTlGWDk5?=
 =?utf-8?B?VCtYcDQyeGQ2ZENMenlrNllMeWpqaGx1eExoY2xPL0oyQWE3NFhJQStQWWl3?=
 =?utf-8?B?S25Rc2taVnJNaXkrZWJZbVJNWHVROHBDV0hmbThHZ3FicG9VMHM3WFg0SnFt?=
 =?utf-8?B?U2VJYTNySFhaVm9ycDlRdnlGZWhSSXhaRUI2R3psd0hDSTZxbHBIRHAzV1Y1?=
 =?utf-8?B?bWhoZlpqOEMxSy9Mc1RucStvSkpvb0NJREZNY21ZV2hEVmhYRXdZdVEwQmVm?=
 =?utf-8?B?dWVyS3lMT25GQVBoMXhsekRVWXVnZklaVEdkME1xR0M3NDVPc0pkSjJjUnF6?=
 =?utf-8?B?RWN0MlJjaFYrWjMzRXA3YndIQStkbWl6TGhaY2lwT1I5bjhXUC91c2V5akx3?=
 =?utf-8?B?NVdPUGJEMXg2ejBlTW8zOWNVMllqdCtlU256L0ZDSnFxamJ4YWQ5d2llSFQv?=
 =?utf-8?B?ajJJTk92QTA1UlN6NHFXQ05RRytZRlBDZmYweGljSk1kand6MUVCbjJmWjZ0?=
 =?utf-8?B?ZTJSbEZwMmpRa1F3OWhrSld6OEdwN1VKSkVhdTlZNXgydXBWaDZhVm1SZU9x?=
 =?utf-8?B?b0hnQWRkRHI3N0hDM1R4ZWVySElCSUk2WmxYY0dkTm5NbmhneWU1dEIzUXFZ?=
 =?utf-8?B?SStObmN5VnRnNEkzbHRMT1o1RUNXdTNtbjF2WG9tTWMvWlpJQ0M0Qk1ZbWRL?=
 =?utf-8?B?a08rbGRjRHdqaTk0UmlBNUVFTUIrS0V6SzlHYm1ZSUEyeXlicW8yNEFpbXF6?=
 =?utf-8?B?QnlvY0RrRmhLcFROMXhiMWlIQ2JjV0JmRzBjeWpSeGZUaE9WWk9WaFVIWWMz?=
 =?utf-8?B?RzExeENDTnVnbzRjL25NelB5QndCM0o0NkpZL2J3WmVPcTV5VHQ1Qzd2QXU3?=
 =?utf-8?B?NVNhVSsvMEVBRUVucDdjUUxRelVVNytUZXJkL3JCMDNESmZaRHh2SkdQMjF2?=
 =?utf-8?B?d2tHZW5sM01XYm84QWJYMnRqVlI3LzNjRERHVVlBVFRLc3VvTHlscWlDVlgx?=
 =?utf-8?B?YnRGSVNDbEwvKys0em4rK0F5clE2VDR6WUZ5NElpZC9hekhRNUVWUWVMR2lW?=
 =?utf-8?B?MjF4V0MvYm01UGpUb01TTUg4Y1h0Ky9zdU9oaHE5VDhwVWhLTGhhZzV2aHhD?=
 =?utf-8?B?WCtDaWp2d3A5QXJ2c0xWaVYvdFJTNTNmcXZnRnIvTk5QQVRydTdEVFNId09v?=
 =?utf-8?B?UTJkVDR0V1JmSmRqcFhTdXF6cTEvZWxFZzNRK3c4MkgrSlJ0UzhORHJrQTI5?=
 =?utf-8?B?RTJVVCtNU1U5NGV2NTljcnlzMWhscEY3dWhBR3dBZ2taK0dOTi9SV2VYOGw5?=
 =?utf-8?B?UzhES1dNbnVFMG9sYlFjZVgwUGV2Y3pkbWFiODdTbGJYMUMzSlRpTzU3eTZJ?=
 =?utf-8?B?cW5IRkR2Q2ZSdEp5Y2F6Y3Z6UU5CcDhOQVVUaW14YnYybVI5WkhIVGlIODls?=
 =?utf-8?B?TldnZ0RrcTlIbU1SRFJRSTdYRDRlY3Y2Rmo4eW82K1RCQjlza0NibU90ZVRF?=
 =?utf-8?B?b1dYZEZhS0VCUmk4VVpwcFZnSStyVkp1R2I4b3BaSndsbnRYT1pMakNiRTRZ?=
 =?utf-8?B?YXFUTXM5ZVU5bUMrY1FqV3p5bXkvUW80bWRjVlBJandOV042N21YRjllOWJo?=
 =?utf-8?B?Vkk5bmxhaDc0NWluazd2V1lCR0VQc3dhVDZySnJjQW5zbXpzNkd5N3ZEOXpQ?=
 =?utf-8?B?SjA0cWlkYWJ0dU9RNkRUSHJ0UERiZTc5M0lRRmVSMGRiSXIwRlFncmtGNVJJ?=
 =?utf-8?B?bGIzbm5CUzFwTDFXSHhlYTFlaFZqdDdIalJRVmhMeWhhWUZlOFA5aTBweWFv?=
 =?utf-8?B?OEJYcUVpOVIvVjVPdjQzeG5DVmVRT2JiSEMzbStVbEdROEwvTVZtbXl0Snor?=
 =?utf-8?B?VVNteUpaQi9qWTlMRUNQQlVTQm9EMnlOOVoxaEZ2Vy9hWVJHOUM0SHY1ZStC?=
 =?utf-8?B?ZjZQMXZkUGNYaWtQeEJlSjdBUFZKeEpvTFA0bTVObDNyUnJDcnJhU3REQ1FP?=
 =?utf-8?B?YUx2QkFuWjBVc1g4dldvY2ZHYTZhNnlTMDBDN2lZMzIycVMwSjQ1NzlBcFVu?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17F533986FD799408581ECB78B79E0AC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88b3033-b877-41b0-ae19-08dc2546fbb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 06:03:18.0337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzSmdIQKwS9qZ7gaypHbEJLJOMJds2aUwYJm/PwJrkXmZflXGlbcdn3lPd+2W8vNAzIzpOos6/TmeW12VleJMtmGNDL7H8jAaI/SnM5+M/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7245
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.643100-8.000000
X-TMASE-MatchedRID: Y6GLOewO+JjUL3YCMmnG4t7SWiiWSV/1YefZ7F9kLgsNcckEPxfz2AVM
	9kPsaYx4DSs3+GspeOpg62EFNWAoiEROfDUX+zmlu72KpAktHS/t/okBLaEo+A6QlBHhBZuwYRW
	GTChXyt39W4F6Nyvtfk/SoXfxRM/ULZbtj42l31Huykw7cfAoICseSAhqf1rRyWCL+8tLbvb3dH
	/rswi8nMvpIkRZEXgrx0bGMM22HMGPaFHMfVTC4NIFVVzYGjNKWQy9YC5qGvz6APa9i04WGCq2r
	l3dzGQ1l3+bAt/YFVS8Rw8wY6AowfTNM9UP6q4ea8RrZYjUF9KreyiFjLPy3mgGZNLBHGNe
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.643100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	2D96B9BBC29F7CCA3D2A63FC849B89E58845F8680CCE4C03923D4985B33923922000:8
X-MTK: N

T24gTW9uLCAyMDI0LTAxLTIyIGF0IDEyOjE4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBpcC1zbGVlcCB3YWtldXAgZnVuY3Rp
b25hbGl0eSBvbiB0aGUgdGhyZWUgTVRVMw0KPiBjb250cm9sbGVycyBmb3VuZCBvbiB0aGUgTVQ4
MTk1IFNvQy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4g
DQo+IENoYW5nZXMgaW4gdjI6DQo+ICAtIERyb3BwZWQgdW51c2VkIGRlZmluaXRpb24gZm9yIFdD
MF9JU19FTl9QMV85NQ0KPiANCj4gIGRyaXZlcnMvdXNiL210dTMvbXR1M19ob3N0LmMgfCAzMCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX2hvc3Qu
Yw0KPiBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19ob3N0LmMNCj4gaW5kZXggOWYyYmUyMmFmODQ0
Li43YzY1N2VhMmRhYmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19ob3N0
LmMNCj4gKysrIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2hvc3QuYw0KPiBAQCAtMzQsNiArMzQs
MTggQEANCj4gICNkZWZpbmUgV0MwX1NTVVNCMF9DREVOCQlCSVQoNikNCj4gICNkZWZpbmUgV0Mw
X0lTX1NQTV9FTgkJQklUKDEpDQo+ICANCj4gKy8qIG10ODE5NSAqLw0KPiArI2RlZmluZSBQRVJJ
X1dLX0NUUkwwXzgxOTUJMHgwNA0KPiArI2RlZmluZSBXQzBfSVNfUF85NQkJQklUKDMwKQkvKiBw
b2xhcml0eSAqLw0KPiArI2RlZmluZSBXQzBfSVNfQ185NSh4KQkJKCh1MzIpKCgoeCkgJiAweDcp
IDw8IDI3KSkNCj4gKyNkZWZpbmUgV0MwX0lTX0VOX1AzXzk1CQlCSVQoMjYpDQo+ICsjZGVmaW5l
IFdDMF9JU19FTl9QMl85NQkJQklUKDI1KQ0KPiArDQo+ICsjZGVmaW5lIFBFUklfV0tfQ1RSTDFf
ODE5NQkweDIwDQo+ICsjZGVmaW5lIFdDMV9JU19DXzk1KHgpCQkoKHUzMikoKCh4KSAmIDB4Zikg
PDwgMjgpKQ0KPiArI2RlZmluZSBXQzFfSVNfUF85NQkJQklUKDEyKQ0KPiArI2RlZmluZSBXQzFf
SVNfRU5fUDBfOTUJCUJJVCg2KQ0KPiArDQo+ICAvKiBtdDI3MTIgZXRjICovDQo+ICAjZGVmaW5l
IFBFUklfU1NVU0JfU1BNX0NUUkwJMHgwDQo+ICAjZGVmaW5lIFNTQ19JUF9TTEVFUF9FTglCSVQo
NCkNCj4gQEAgLTQ0LDYgKzU2LDkgQEAgZW51bSBzc3VzYl91d2tfdmVycyB7DQo+ICAJU1NVU0Jf
VVdLX1YyLA0KPiAgCVNTVVNCX1VXS19WMV8xID0gMTAxLAkvKiBzcGVjaWZpYyByZXZpc2lvbiAx
LjAxICovDQo+ICAJU1NVU0JfVVdLX1YxXzIsCQkvKiBzcGVjaWZpYyByZXZpc2lvbiAxLjAyICov
DQo+ICsJU1NVU0JfVVdLX1YxXzMsCQkvKiBtdDgxOTUgSVAwICovDQo+ICsJU1NVU0JfVVdLX1Yx
XzUgPSAxMDUsCS8qIG10ODE5NSBJUDIgKi8NCj4gKwlTU1VTQl9VV0tfVjFfNiwJCS8qIG10ODE5
NSBJUDMgKi8NCj4gIH07DQo+ICANCj4gIC8qDQo+IEBAIC03MCw2ICs4NSwyMSBAQCBzdGF0aWMg
dm9pZCBzc3VzYl93YWtldXBfaXBfc2xlZXBfc2V0KHN0cnVjdA0KPiBzc3VzYl9tdGsgKnNzdXNi
LCBib29sIGVuYWJsZSkNCj4gIAkJbXNrID0gV0MwX1NTVVNCMF9DREVOIHwgV0MwX0lTX1NQTV9F
TjsNCj4gIAkJdmFsID0gZW5hYmxlID8gbXNrIDogMDsNCj4gIAkJYnJlYWs7DQo+ICsJY2FzZSBT
U1VTQl9VV0tfVjFfMzoNCj4gKwkJcmVnID0gc3N1c2ItPnV3a19yZWdfYmFzZSArIFBFUklfV0tf
Q1RSTDFfODE5NTsNCj4gKwkJbXNrID0gV0MxX0lTX0VOX1AwXzk1IHwgV0MxX0lTX0NfOTUoMHhm
KSB8IFdDMV9JU19QXzk1Ow0KPiArCQl2YWwgPSBlbmFibGUgPyAoV0MxX0lTX0VOX1AwXzk1IHwg
V0MxX0lTX0NfOTUoMHgxKSkgOg0KPiAwOw0KPiArCQlicmVhazsNCj4gKwljYXNlIFNTVVNCX1VX
S19WMV81Og0KPiArCQlyZWcgPSBzc3VzYi0+dXdrX3JlZ19iYXNlICsgUEVSSV9XS19DVFJMMF84
MTk1Ow0KPiArCQltc2sgPSBXQzBfSVNfRU5fUDJfOTUgfCBXQzBfSVNfQ185NSgweDcpIHwgV0Mw
X0lTX1BfOTU7DQo+ICsJCXZhbCA9IGVuYWJsZSA/IChXQzBfSVNfRU5fUDJfOTUgfCBXQzBfSVNf
Q185NSgweDEpKSA6DQo+IDA7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgU1NVU0JfVVdLX1YxXzY6
DQo+ICsJCXJlZyA9IHNzdXNiLT51d2tfcmVnX2Jhc2UgKyBQRVJJX1dLX0NUUkwwXzgxOTU7DQo+
ICsJCW1zayA9IFdDMF9JU19FTl9QM185NSB8IFdDMF9JU19DXzk1KDB4NykgfCBXQzBfSVNfUF85
NTsNCj4gKwkJdmFsID0gZW5hYmxlID8gKFdDMF9JU19FTl9QM185NSB8IFdDMF9JU19DXzk1KDB4
MSkpIDoNCj4gMDsNCj4gKwkJYnJlYWs7DQo+ICAJY2FzZSBTU1VTQl9VV0tfVjI6DQo+ICAJCXJl
ZyA9IHNzdXNiLT51d2tfcmVnX2Jhc2UgKyBQRVJJX1NTVVNCX1NQTV9DVFJMOw0KPiAgCQltc2sg
PSBTU0NfSVBfU0xFRVBfRU4gfCBTU0NfU1BNX0lOVF9FTjsNCg0Kd2hpY2ggcHJvamVjdCB3aWxs
IHVzZSBpcC1zbGVlcCB3YWtldXAgZm9yIG10ODE5NT8gb25seSB1c2UgZGV2aWNlDQptb2RlPw0K
DQpBcyBJIGtub3csIHdoZW4gdXNlIHVwc3RyZWFtIGNvZGUgdG8gc3VwcG9ydCBkdWFsLXJvbGUg
bW9kZSBvbiBtdDgxOTUsDQp0aGVyZSBpcyBhIGJ1ZyBjYXVzZWQgYnkgaHcgbGltaXRhdGlvbjsN
Cg0KDQo=

