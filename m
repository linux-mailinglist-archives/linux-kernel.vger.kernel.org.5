Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8217E5093
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjKHG42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjKHG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:56:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BA01BB;
        Tue,  7 Nov 2023 22:56:23 -0800 (PST)
X-UUID: e97502d27e0311eea33bb35ae8d461a2-20231108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cvpZcf/dF6jp4QEQEfUjMqm8/1zPHnGhOPtwQqLizGQ=;
        b=j/BtTljA65VBNmR6ifynf7PJbob05VK2LNfbzXcQX0xDyPB/hb6C88om2KIDTH+xqF7Eo4g2+8gPneKz2AibvSMupfScn2D2hcdlHZzXa//kzIG0LK6zGnQzEGSaA9B5aUEeYB1sgWLzlO8xREZpBNUz8TQK4S8qScfYb76iJ8k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:48130d9e-96a5-4aa4-b2ce-2341d20ca2c9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:86bad05f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: e97502d27e0311eea33bb35ae8d461a2-20231108
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yu-chang.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1492688284; Wed, 08 Nov 2023 14:56:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 8 Nov 2023 14:56:15 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 8 Nov 2023 14:56:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYtN8CDQx1KFwhtModsQ5jAYCICNqSpxwPFYcW6SWwbRk7GUzL2Lb9nFHIVef26EaEf2FwGa6kTX/kzC5BbjQQhU+cB0UenNzkW7DvG/luKvdrxp+ONNRnHc+YMsYEIWxxu/IZmOa0nataFY2yi3+M4vuLTbyrXLslM6lcnJ7ZS4c58eCFxB5JQpOUILOveQ3LBnGqngRsQo3oTxy+K3gj770StldnnDxQiTBYkmhZA9ETQwEtO6d/Vx+qh6/vT87ihWmM6Mha5PixAkQ9+ph5VZNwWjmcGcK7hcAbLWyp/NQZ/SM97VgqfbFbTpWpaj0STjuJsoWLqx/1VThr1EeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvpZcf/dF6jp4QEQEfUjMqm8/1zPHnGhOPtwQqLizGQ=;
 b=f1wfMB3CaUAL4VMtWRB8BS0pEX4xyZ19moXU7Qgoq2A5WRtQLEmsOl97CSqtsDoAefRP2gevFHuptoN0/qihBH7hUk88Z978ORt6ssM54zafNj2B5AH9QikhLr5nai8CFVkXyXCRQsxUSZtxhrTI571o/KsAM8C5jBpFxWhBrwDWI8R5nafnb1kPDk0eMenVICElq2Y0+np7cG4BcsXLjyiX6dGKwaF1K3n7U102WRWrTEX6Pblo2HmGVDMuxc6ZUIk5aEqBvJM+TJHdAiIJ7ytYKmZNbmwrJd+aG86uvkV2azJJP6H3kaTLYejRJJMt/1rhHuSmE2YBcFYnSWQF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvpZcf/dF6jp4QEQEfUjMqm8/1zPHnGhOPtwQqLizGQ=;
 b=uukIhQwzXHZMT1fRz9IhSkmy1tPhhJrt1APrWUHEgEpNI8sLUQAF+0tA5oVK2feoQiWvMc3Cbjyd/WLInTWaxgSgLYXPx69+iAfqtonMD5FXwA+ZIpAhSPyf6U2lecCfVnRwJEoSqNQ7lGANiDfIDbuzBEtQhnXxD02/O3OfasI=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by SEZPR03MB8064.apcprd03.prod.outlook.com (2603:1096:101:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 06:56:08 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::1bd1:4be7:8749:79ea]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::1bd1:4be7:8749:79ea%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 06:56:08 +0000
From:   =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Add I2C arbiter clocks to
 i2c 1/2/5
Thread-Topic: [PATCH] arm64: dts: mediatek: mt8186: Add I2C arbiter clocks to
 i2c 1/2/5
Thread-Index: AQHaEg1im4SiK2nFtUaYzFDs9iOE8bBv/TCA
Date:   Wed, 8 Nov 2023 06:56:08 +0000
Message-ID: <8414e0ccdb5f456877df06d4e5c6befff5463991.camel@mediatek.com>
References: <20231020075540.15191-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231020075540.15191-1-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|SEZPR03MB8064:EE_
x-ms-office365-filtering-correlation-id: e9aabe37-236d-4189-a56c-08dbe027c932
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6+dRw7RaCiotmFikGf0W074wKDA2j9tvm6KxR+5pR4zsg5roGZnDlJBMDhcD+I4ceTMGPUi4agn43e0H8/V0+J8JX56Gb8VaI1BMpJnONjo3JSgI5+UI08b5ES3EkdLsXDA2NHGELlnMujqwYXfTaPqYfhDkPjuxAIBbOAEsq17QTZYHZV0RS5+OhKPXuMaTg+ck+OPNzLFDqEWYmHu+WaEy3T9jTHw7chz/fTFwPf8w3iyJ1I8j487vVsAXTEvs7w0/Wxs7rHxE9UQqWm+CK97dLK34viqOqDjh1adSH5uy4+QT2bmeAkG+p2bIP+Co1qk2AvelyEQ9XfSaYI2QYbExZsWlGQmHb+F/gfYIr74Iyztwnv1SVKgYajI4dpD0jLSIm/lrFxT3AJrQg9hQcwYHbSuwLucUVXHioPW3nbEDuHgSbxS+4a3HpgalPO8M0VrsU2yzWyCBMGo4xWgKOK0tSdDuofr97NfQg8SEUM5T4KrK02EOx2wwxALtiQoSKMXtpNMQL2FvIX5Jc4vSUhhfFBcKi5Y8EQKSRpoe+nqqpiYk6g/Kxm0vqti+Csi+B4nGEQ8lNS5RGKP4pJdBrtNmtpGAWPdKZPvhqRGp3BX+AeK4lai9psAxdMoaYMQ5KYTa+icYGdQGmVEzNMP41Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(8676002)(4326008)(8936002)(83380400001)(7416002)(86362001)(38100700002)(5660300002)(4001150100001)(41300700001)(122000001)(6512007)(2616005)(316002)(91956017)(6506007)(66446008)(66556008)(54906003)(66476007)(85182001)(66946007)(76116006)(64756008)(71200400001)(38070700009)(6486002)(26005)(966005)(110136005)(36756003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajNZc1hnZk1kajZCSTNBT29YM2EzWG4xamkxZU5nVVhselpJZzhKMHgvaWZs?=
 =?utf-8?B?aUZ1QTdhSGh6Si9zVE8yMm5reEpWNThVdW0zR1FPSmdjNE82YWphMmtJbEdq?=
 =?utf-8?B?QTNsYXpFaXB5UW5PS3R6eTFDb21mbWhNeXg2MkdnMi8vN05hcDdVQ3V1bks1?=
 =?utf-8?B?Y0IyZk10dGZPaDNuRkFoNTJla1VYaDhNdGhVclVxU3o0aXhiSHlXSGNLc0lE?=
 =?utf-8?B?TUJWSVcxclg0UnJPd3dmRDFBSWFLelA5U3lGMzcvTGkwRzJ5WEVha1lXUXlR?=
 =?utf-8?B?ek5aM2VXbjdyd2VhWUFEemZ5WW9POFVWS2I1SWVGL3cwbE5iSWdTUVQzdDJs?=
 =?utf-8?B?bmRQMjMwQnBhSmlDZ1o3NEpxZlJXaHpsQlJublFKcEZWSzRIb0N0NU5PazE1?=
 =?utf-8?B?dHY2a2hJUzVWd28wVytQYVFyQWdJNmQzZDRtSzlZZG1aK3dpYVp6RVgyeTRH?=
 =?utf-8?B?aXZ4REY3OWF1OFpUMFB5UU1wVWVHMkczUmFNS3JldXQxNC9KM1M3T0FlUzgr?=
 =?utf-8?B?SzhENXVsS1M1WlVSRnZVM3pnMGhRYVl5Q0lmZWd4NzlVakZmZjkzTHV5WjlF?=
 =?utf-8?B?S3JhcHZiN1ptdUFHZFJUZTRick5oNldoVFJUa2JCNkFXVU9LYXR5SkRDYll0?=
 =?utf-8?B?RE41clpsb0ZqYWg3S0dyRVZlUU5WUWJkdXVVdDhxOEVBeUZtOXBnSm1VNGpx?=
 =?utf-8?B?ZEVmV0Q3d0hVWEYvZlYxNzIrbGpxNUVXRjc3YmZWNEFCZnVDNEkzRndJWlcz?=
 =?utf-8?B?UWZDdTdFbkl6K0hUbzg4R08zREVFdTNTZUtJdzRjbjN4a2hkR3g0YVd5MVlh?=
 =?utf-8?B?R29KK01RdWhwdUlZLzVjK1RvejhGNTZWSm02VzNZZGg1NzhJVWU4TERTRi9W?=
 =?utf-8?B?T1BRMGlrVGhxWFZqMmRLUUllbHNLMmtpakw2dnVQaGRkZXl2USs3bkV0dHhq?=
 =?utf-8?B?ekJzblZ3NmoyYlBVc3gvOWZFa0h5RG9wZkU0a1lJTDRKZjFmSnlTYy9TMFpE?=
 =?utf-8?B?aWVON1ZSeFZ4eHdiTEVTUUI5L1dQZXpCVVl1TWMxRGJCTE4vbGp1S0tXQ1hk?=
 =?utf-8?B?ek84Q1R5S3NGbkF1cEl1dW5DWlpmbFZaZEpxRG9DeGZEa2hoL0ptaHdkOTZ2?=
 =?utf-8?B?MXdKT1d0bFNxbWlUV0tpKzZCSVNweDQvTzJ3Yi9SUmNLdWVTY0g2OWZKUFpI?=
 =?utf-8?B?S0F6QThnMjVpQjE3dXBkazlnVlpCUUw5NUpJVGRmdDRUaUQ1dFZkSjhaTlFZ?=
 =?utf-8?B?bDh1TS83UHEyR1dDcnJndlZCalZhQXIyaE03WXVvdGxYZXRPVjB0MDlxd3ox?=
 =?utf-8?B?T0Z0MSsrR1pFNGR0empFUEtyK09PZ0lTdWtZKzdxMHVMZWg1OGxpNTRpMm9S?=
 =?utf-8?B?dE50a0x0UVZhWU5mQkYrS3B2cEFiSEk5bzlOUXdWd1cxenpTQ2RPVENQZkVr?=
 =?utf-8?B?b3JQcnh1VnJqTFdsVVpaSG9UWVIwdm5EV0RHa3cvbTJ2bzVHektMM3VZNVJS?=
 =?utf-8?B?V20wSXZNRmR4UkozMm9xVi9xVEsrazBaaFRtS2xBQjVQeEVka1g1UngxM3lU?=
 =?utf-8?B?cVp1L092WG5DT1crMmR5WHVYZFMvblRxVmpvNE1ZSVVCbS9nekZCWEFlWEZ4?=
 =?utf-8?B?cVUyUUl4OStlbmRYZnNnYWZuWHdFZXR4MWFENDZ3VXJ5aXQzQnRHRE51NWt5?=
 =?utf-8?B?MlY4a0JWUXlBOHM3d0JFSTFVbjVyekRCZ3FzZ25SWUg3eDEyeFM2dnBlTnU5?=
 =?utf-8?B?WGljWnUxTWRoRXVMY0EyK3pEb1RmRlZ6Y01FY29tcm1PTUlHSXFRZG1xSkJL?=
 =?utf-8?B?Qk5jWWs4QmxBRVNzMFpPeG9NekgzMXZEdlVLTy9seFVyNFVYYkk2SnBIaXpP?=
 =?utf-8?B?WXhvRkcraXJ5aU5MV0picjQrd0hJVEhuajMwczJKY2c3LzZRYjNtY3hRL21p?=
 =?utf-8?B?aDJURVZ0TnZPQS9DSjBkTjVXZk44aXByS0txUm5CMThhV2I4Nys5Slo5SzdP?=
 =?utf-8?B?VCtrM294TVltWG5JWlJaZGRxbjNnQTdtbXZQL2xsTVN5ZlAwcG5tNWZzNXB2?=
 =?utf-8?B?RkJ1ekNwVTQzb3NRb1lrWGxLeFVaemw2cVN0U2E1WkhDczFLNFM1WmRJQmlh?=
 =?utf-8?B?NXNsMEZOSFBFMU9meXpIL2Z2LytBaWk2VFlITWREdE9VS3E3UHI5QU05VU9G?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80DA0B3122D99A42988187FBB6C7AB18@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aabe37-236d-4189-a56c-08dbe027c932
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 06:56:08.6902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8ep/icGoWXsObwf6RXNPvTX0qpy/sX+NHiiIqnsDkREksy6tpB9fixG4Jt8ol/evqE708HHcd0L3vrUuxJIdwJtFjuKyU244Vy1n+g+cfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTIwIGF0IDA5OjU1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gVGhlIEkyQyBidXNzZXMgMSwgMiBhbmQgNSBoYXZlIGdvdCBhIHNlcGFy
YXRlZCBhcmJpdGVyIGNsb2NrOiBhZGQgaXQNCj4gdG8gdGhlaXIgcmVzcGVjdGl2ZSBub2Rlcy4N
Cj4gDQo+IEZpeGVzOiAyZTc4NjIwYjEzNTAgKCJhcm02NDogZHRzOiBBZGQgTWVkaWFUZWsgTVQ4
MTg2IGR0cyBhbmQNCj4gZXZhbHVhdGlvbiBib2FyZCBhbmQgTWFrZWZpbGUiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8u
ZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE4Ni5kdHNpIHwgMTUgKysrKysrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTg2LmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL210ODE4Ni5kdHNpDQo+IGluZGV4IGYwNGFlNzBjNDcwYS4uYWY2ZjY2
ODdkZTM1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4
Ni5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTg2LmR0c2kN
Cj4gQEAgLTEyMjQsOCArMTIyNCw5IEBAIGkyYzE6IGkyY0AxMTAwODAwMCB7DQo+ICAJCQkgICAg
ICA8MCAweDEwMjAwMjAwIDAgMHgxMDA+Ow0KPiAgCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEw
NiBJUlFfVFlQRV9MRVZFTF9ISUdIDQo+IDA+Ow0KPiAgCQkJY2xvY2tzID0gPCZpbXBfaWljX3dy
YXANCj4gQ0xLX0lNUF9JSUNfV1JBUF9BUF9DTE9DS19JMkMxPiwNCj4gLQkJCQkgPCZpbmZyYWNm
Z19hbyBDTEtfSU5GUkFfQU9fQVBfRE1BPjsNCj4gLQkJCWNsb2NrLW5hbWVzID0gIm1haW4iLCAi
ZG1hIjsNCj4gKwkJCQkgPCZpbmZyYWNmZ19hbyBDTEtfSU5GUkFfQU9fQVBfRE1BPiwNCj4gKwkJ
CQkgPCZpbmZyYWNmZ19hbw0KPiBDTEtfSU5GUkFfQU9fSTJDMV9BUkJJVEVSPjsNCj4gKwkJCWNs
b2NrLW5hbWVzID0gIm1haW4iLCAiZG1hIiwgImFyYiI7DQo+ICAJCQljbG9jay1kaXYgPSA8MT47
DQo+ICAJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJCSNzaXplLWNlbGxzID0gPDA+Ow0K
PiBAQCAtMTIzOCw4ICsxMjM5LDkgQEAgaTJjMjogaTJjQDExMDA5MDAwIHsNCj4gIAkJCSAgICAg
IDwwIDB4MTAyMDAzMDAgMCAweDE4MD47DQo+ICAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTA3
IElSUV9UWVBFX0xFVkVMX0hJR0gNCj4gMD47DQo+ICAJCQljbG9ja3MgPSA8JmltcF9paWNfd3Jh
cA0KPiBDTEtfSU1QX0lJQ19XUkFQX0FQX0NMT0NLX0kyQzI+LA0KPiAtCQkJCSA8JmluZnJhY2Zn
X2FvIENMS19JTkZSQV9BT19BUF9ETUE+Ow0KPiAtCQkJY2xvY2stbmFtZXMgPSAibWFpbiIsICJk
bWEiOw0KPiArCQkJCSA8JmluZnJhY2ZnX2FvIENMS19JTkZSQV9BT19BUF9ETUE+LA0KPiArCQkJ
CSA8JmluZnJhY2ZnX2FvDQo+IENMS19JTkZSQV9BT19JMkMyX0FSQklURVI+Ow0KPiArCQkJY2xv
Y2stbmFtZXMgPSAibWFpbiIsICJkbWEiLCAiYXJiIjsNCj4gIAkJCWNsb2NrLWRpdiA9IDwxPjsN
Cj4gIAkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAgCQkJI3NpemUtY2VsbHMgPSA8MD47DQo+
IEBAIC0xMjgwLDggKzEyODIsOSBAQCBpMmM1OiBpMmNAMTEwMTYwMDAgew0KPiAgCQkJICAgICAg
PDAgMHgxMDIwMDcwMCAwIDB4MTAwPjsNCj4gIAkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAzNTQg
SVJRX1RZUEVfTEVWRUxfSElHSA0KPiAwPjsNCj4gIAkJCWNsb2NrcyA9IDwmaW1wX2lpY193cmFw
DQo+IENMS19JTVBfSUlDX1dSQVBfQVBfQ0xPQ0tfSTJDNT4sDQo+IC0JCQkJIDwmaW5mcmFjZmdf
YW8gQ0xLX0lORlJBX0FPX0FQX0RNQT47DQo+IC0JCQljbG9jay1uYW1lcyA9ICJtYWluIiwgImRt
YSI7DQo+ICsJCQkJIDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0FPX0FQX0RNQT4sDQo+ICsJCQkJ
IDwmaW5mcmFjZmdfYW8NCj4gQ0xLX0lORlJBX0FPX0kyQzVfQVJCSVRFUj47DQo+ICsJCQljbG9j
ay1uYW1lcyA9ICJtYWluIiwgImRtYSIsICJhcmIiOw0KPiAgCQkJY2xvY2stZGl2ID0gPDE+Ow0K
PiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICAJCQkjc2l6ZS1jZWxscyA9IDwwPjsNCg0K
SW4gcHJldmlvdXMgZGlzY3Vzc2lvblsxXSwgaWYgdGhlIGFyYml0ZXIgY2xvY2sgaXMgbm90IGFk
ZGVkIGludG8gZHRzDQpub2RlIGRvZXMgdHJhY2twYWQgbG9zdCBpdHMgZnVuY3Rpb25hbGl0eSBi
ZWZvcmUgc3lzdGVtIHN1c3BlbmQvcmVzdW1lPw0KQW5kIGlzIHRoaXMgcGF0Y2ggbWVhbnQgdG8g
c29sdmUgdGhlIHNhbWUgaXNzdWUgaW4gWzFdPw0KDQpSZXBseSBvbiBiZWhhbGYgb2Ygb3VyIGky
YyBQSUMuDQoNClNvcnJ5IGZvciBsYXRlIHJlcGx5DQpCZXN0IFJlZ2FyZHMsDQpZdUNoYW5nDQpb
MV06IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzMyZDUxZTQwLTVkOWMtNDdkZC1iYjYy
LTJjY2M4MTFhYzZkY0Bjb2xsYWJvcmEuY29tLw0KDQo=
