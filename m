Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10637C6837
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378176AbjJLIA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347130AbjJLIAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:00:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C69ACF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:00:52 -0700 (PDT)
X-UUID: 724b533e68d511ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VgD3HGCiERswddVcYoCpCx8/lLOgDuYE8Z2tQsbm7R8=;
        b=tbYRHFgHSMJXdaJ8tECSQW2W/Sj2KZuLU9DA+HuH3UjPxqHNiHfQzkD6ATj7QK2NvMZy4i6INWaU3vahaAomR4AonoRWWO50mLlYmbtLQ/M8v1RBufch2TOZpnJVC5V5obAVoVxi9zdV2O+oaUhhjvB2gaBX+5LF8Is8hAOHlpo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e1501e3b-2732-464f-9c15-69483fb0a486,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:4c5fd8bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 724b533e68d511ee8051498923ad61e6-20231012
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1346163665; Thu, 12 Oct 2023 16:00:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 16:00:43 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 16:00:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE4uXmENIWBv1Wt+1bDxgW3XcTlUTHW1iTdqDiFGjzJn98SCNBrZt7DVWSfBfCABKV/I5dTxOiMD/NoUCbZ+8l2ct6mQJe6zLS5NqyWRdbc6tSZDhQJOZwW1xN3I8jTz7LsngFC/qFFKieuMvGnvPooubHOq9nYnqlbvIZ8B0pOLVZc5ncA1XGkIt8720RgoNoQbi3Xoe6WowGoxFPhPkMfN3/zO3EW/zw+uzmZ1XwDOZdSBJsBDKRrDQKUxzUO0fey3uAA6FWZ6y803fbbZrdEQi0dINPrx2YiT4aarvzhmbD1Z4LYsiGzH6PmQ1LLo/F082t9QcY4QZvcPOPkJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgD3HGCiERswddVcYoCpCx8/lLOgDuYE8Z2tQsbm7R8=;
 b=g4nHmD50wJBDLRLhjssvJ4Mr7BCtYgDLOb81QR8cNq5Hfp6z0+hDczYks+PS7xzAEl6JREHNFgltN0txnyTRpkrx4Lvdk7kVGVPyeL/jsRVCRnOE0lu0XfJWQnEHd6jWnDufJVshzXGvqBO9eTe8unPzmqt2jVlZwSIBtWS14BZ/3KP1SO3GvsxIc7RHzWnK13GukODv4KlxvzuGZQOYwrrAJaRZKNQNPpFzVJowu1FK6U3BKkG6qdGz8fJfDeVo7NbMrl0nTt0HMbmtgNnK3s8Kcn+CILFAc35ke31Cyv12ebECTOak3IRDI794qYAYM/MuUVivLqDugYMqGbQnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgD3HGCiERswddVcYoCpCx8/lLOgDuYE8Z2tQsbm7R8=;
 b=mdobzUzNDvK5nkMI3RjdhtNsAWZDNYWUJK5ydOtMXPjZfve2XN9UJLfjCyB3WOuCoX1SnBQ8SFateZAc/LU59DJK85DPeKw+WK3JeeyYN17uyjQA+0XSaFaDq3QM2l6dL10WZAAh4Cls5Is6DVlxRj5CArRfAyRs6yzh0+muUOA=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB5311.apcprd03.prod.outlook.com (2603:1096:400:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 08:00:40 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 08:00:39 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH] mailbox: mtk-cmdq-mailbox: Implement Runtime PM with
 autosuspend
Thread-Topic: [PATCH] mailbox: mtk-cmdq-mailbox: Implement Runtime PM with
 autosuspend
Thread-Index: AQHZ/DKqS+K8cf06yk+hsFpE4I+hCLBFy/oA
Date:   Thu, 12 Oct 2023 08:00:39 +0000
Message-ID: <33104b25f0430aba4be9fe1060a02f94e1c9d3d7.camel@mediatek.com>
References: <20231011110309.164657-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231011110309.164657-1-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB5311:EE_
x-ms-office365-filtering-correlation-id: ca21e687-7725-47fc-3ee4-08dbcaf9532f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 20fIiy1qCWa453AAPpH4K/s2L1V6xQS7DVAQQH5jUDnxfW25seXfuHA7uxxI7X3xq9EdsgsVfOyMtjWY3rhMtUBVt60j6HwTGJh6lx/ou3IzJR0HDjNE/iDJpeHMCS8JWDUIR7oghtYT/Pfc05LnlduceVfO1luLdeVNf9jrb29jw8XckKc4/J+k0FM6dtIUGE3CM5j/8R4psi3cORaeOpXdsZYWSG9XgYCzg7dEMTEXM/mJ++9NXaQrzLgPE4aPHayGopOLtV1/pgUeRvKH5rQQbk5Tx9nLiSIKiL1L/Dqcm3iRVT+RqDuTSTOtlMLSht6PHvM/R18/sUU/2hvwxFQmRzZxOyjJsSYr3Iud5sZO1Ppkq3vXiR/IOzk+642DLAm8uJhvTKadYdtim2ZuF0Tw5MdwUSYKsq65Xl/shS34Qo5AYl2VsUIeodKob7YNQ3lnLsS8MrZSqm90CnEvABd0f/+3UzyPBWYf37KYKUVzE2DNfTiZ/WADTt0QuKb2l5D6wfolMKmSTIFr+dBC+FyeVqSpJSM7ABrqML5FkGI0btxif7VOss9rW+DDrNTNAu4DGp9K2Go0lp9ORX1yd4/VIgm16VPEYSl2CVZSx+3AkEx+tkCtEN5pDjCHm0W9unbulm6tt4oUUzQ7rtsJS6yJZNaa2AAsZFETqKVV7ZM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6486002)(36756003)(38100700002)(85182001)(83380400001)(64756008)(6512007)(38070700005)(26005)(6506007)(2906002)(76116006)(66476007)(66946007)(316002)(66556008)(66446008)(478600001)(54906003)(2616005)(110136005)(91956017)(71200400001)(4001150100001)(15650500001)(5660300002)(122000001)(86362001)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1NoK1FDMU9BbkY1NnN0aGpBVW5EakpKUlRiNU1QTnBSS1V6RFNpdnVFbW8x?=
 =?utf-8?B?SHJRR0FXb0VXQkZtL0pjaE8vSzJ6dXpLT2ZMdGthMmdIaS9MSk9BTVNsOTVT?=
 =?utf-8?B?VzNZYmlNQXllUGNTdGhsTlZoZ0lmZnEyclEvMXFkM2dwWHZVMmVMcUFYK3V5?=
 =?utf-8?B?bXZIUDBYd0xhYVQwVzIvVTZRWHBsZ0JSUm53bDd0Y0xRYTFPYXlXOU5KVUtv?=
 =?utf-8?B?NWY5Q05SQTgxb3I3KzdIUStubG5Jc0VaZHUrK3licWFDRVE2SjQ1TXlDNEEr?=
 =?utf-8?B?MThueDVKclpzeW1mV3VWYUcxY21sSFdIV0tFbGIwdFhaaEdzTCswV2syZ1Jz?=
 =?utf-8?B?Y0NOWkRCaWx5VmpOSXVhNmxUTjJKbyt3aHprVHNEcXRrQXFMaTZieWlrVkRT?=
 =?utf-8?B?UG00SXlyT2ttUUphdThiVlcxNzRVRWd5VlhuWVNwajhCaExXbjJZTktVQ1VV?=
 =?utf-8?B?ZVdvOXVpZ01aNDVqc041Mk02NG12NmVmcVdKRVpwRTlNclh0bEUydEt2YllV?=
 =?utf-8?B?RWRUUlR1TUZDOWFXbUZXcWE4ZlFodVllWUZuMVFsTkt2SGx1V2tDTFdvcisv?=
 =?utf-8?B?OE5jRG15VmhmTmlaNjB0TDhieUI5VjU2YkEwMzRvM1krOCtaWE5RMVk2M2Y0?=
 =?utf-8?B?Y2k2OEpybUFZVGZWRjE3MnphYVRhZ1dZb2craG1ZOUpxMzJ3cjlERHU5NmN3?=
 =?utf-8?B?T0dVZTJwWWtTQjZ2Wmc4ZVRXRG9XQnpSOXJxbXdpV21yVGtjbjQ1eEF1eEhv?=
 =?utf-8?B?NG9sWjVEeWlkR0hHSUk4azRMR0lLa1BScnJ3Zkh6ZWQyRnd0enlRTld6WEZG?=
 =?utf-8?B?VVZicTlneHZuNzdDeFpRb2pwWE1RN0NqZ1BsTEQ5WDY1cU9VaUV4NHBZMGRl?=
 =?utf-8?B?aFdaTEJ1SEl4clhXeHcvMWtTYTVVR2RtMWpCdnVDcjlaZDYzZzZUTmZXVWhq?=
 =?utf-8?B?Zm5neXZqS0paWGh0azhtMkI1L21GWnovTWpMcWNxS2Q2SFhyam5WaHZ3dGxG?=
 =?utf-8?B?VllVOFJZWk5Hakl0Y2gwak5odVh4OUdFcHBNRG1uN3dsRXkvVDNyVnBqOCsz?=
 =?utf-8?B?bnJKazcrWFhBRDByQmw0aVZ0SlJ1czh1ZWcrV1pOYTZ5NFBQWTdVQ1k4Rlh6?=
 =?utf-8?B?T2I4ZkJtT1dCMnA4VDBKOVVwRHVHUVdEOW92RW4xM2FxRng2Q2ZRUWh3empQ?=
 =?utf-8?B?NkV0NVg2TTl5RkhRZ1ZjU0hTYkZQVE0rK1VwZTZBZ0w4d2FoL1gwZkZ1Mjla?=
 =?utf-8?B?Ykc2VUFNeHNsd2RZeDVtLzkzQmRldTVwK0ZuSGR0b3dTQU1HQyt5T2ZQQjBF?=
 =?utf-8?B?QURRQk9hOXdOc0ViTVNqOXVteGdITHZlZW9sMlIzOGFpcHF5UXpadWtUMGMx?=
 =?utf-8?B?R0xjcE11Tm10Rkx0U0VpNDVoeldEcDBIS016Yjg5bW1UWkdJZGxLRGkrKzY5?=
 =?utf-8?B?MEhLb1pvMzI1aEttVkxSL0JOczRTN2FDSXNnWlFuRVZlVW0rOWhCV1hnV3kr?=
 =?utf-8?B?bnFoSWtmRUI2eWlZNnc1eDFTZjdMOC9wRkxUTGRuVlpOQmU5R3o5SG1kQjBI?=
 =?utf-8?B?V25xcEFJaFpPY3Y5bVM4R05LSTBZODZWUTVpM00zWUtsczJXUmRmR3d0cDU3?=
 =?utf-8?B?bjVDZzlHQ0RjMGtIRCs1TkhYWE02V1QwdnA0U1VCM1hUcjNXTVpsUlhUbGw4?=
 =?utf-8?B?aVdWSHdlWjIweDZNTllFZGlXdkIzbHdRQjBQLyttMTRjd2d0SzhRcjlOSHg3?=
 =?utf-8?B?TXlWbGFmNS9YbkZ0U2pzdDRSdk1oZnhOVlJQczljN01tTVJVdkpJV0VuKzdZ?=
 =?utf-8?B?OWFqQlEyUmplKzF3Ui84Y3pjZGcySk5vYnhsTzVzTnFITStpUmQ5eTlHaXhD?=
 =?utf-8?B?QVVCclVrenBjaGJlbFBuZWdzWmRPSmx6Q0JNVnhlaUxpVUE1alkzb3NXdEJh?=
 =?utf-8?B?d0lXZUs4TVUrRlVXUXhKWUtzSStDMFovUEM0YldpbG9HdDArMmFyeWVkeWZM?=
 =?utf-8?B?MnR6MGw1OFlpSHdkK3FmWW1USkgvdW9GSmU5VFNpbnR2L0NJanRSRlQ4U1pM?=
 =?utf-8?B?M3hKaXdCdko3ZkNkenYzdURMUlU3YURoeHg1dWw5cVJYZ1ozR0xqUlVRWm92?=
 =?utf-8?B?VDZERjFydGFRbkFYd0Y4QjMrZ1VLdllncVhqeE9HRUpReHJmNjFmeHRjUnlM?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEB8548C4C4E6842B928E71D8506C8F4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca21e687-7725-47fc-3ee4-08dbcaf9532f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 08:00:39.4000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dr6l/5q5q39AmwHxByZhd9kg+cifm+uSaH1/FlahEu6VRLEreWbbHINnajNvmg03O0wiONYt4QflYihUjnl37qCL//O8pPahqKy1sRaSOIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5311
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIgaGVscCENCg0KT24gV2VkLCAyMDIzLTEwLTEx
IGF0IDEzOjAzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTWVk
aWFUZWsgZm91bmQgYW4gaXNzdWUgd2l0aCBkaXNwbGF5IEhXIHJlZ2lzdGVycyBjb25maWd1cmF0
aW9uLCBhbmQNCj4gbG9jYXRlZCB0aGUgcmVhc29uIGluIHRoZSBDTURRIE1haWxib3ggZHJpdmVy
OyByZXBvcnRpbmcgdGhlIG9yaWdpbmFsDQo+IGNvbW1lbnQgd2l0aCB0aGUgYW5hbHlzaXMgb2Yg
dGhpcyBwcm9ibGVtIGJ5IEphc29uLUpIIExpbjoNCj4gDQo+ICAgR0NFIHNob3VsZCBjb25maWcg
SFcgaW4gZXZlcnkgdmJsYW5raW5nIGR1cmF0aW9uLg0KPiAgIFRoZSBzdHJlYW0gZG9uZSBldmVu
dCBpcyB0aGUgc3RhcnQgc2lnbmFsIG9mIHZibGFua2luZy4NCj4gDQo+ICAgSWYgc3RyZWFtIGRv
bmUgZXZlbnQgaXMgc2VudCBiZXR3ZWVuIEdDRSBjbGtfZGlzYWJsZQ0KPiAgIGFuZCBjbGtfZW5h
YmxlLiBBZnRlciBHQ0UgY2xrX2VuYWJsZSB0aGUgc3RyZWFtIGRvbmUgZXZlbnQNCj4gICBtYXkg
bm90IGFwcGVhciBpbW1lZGlhdGVseSBhbmQgaGF2ZSBhYm91dCAzdXMgZGVsYXkuDQo+IA0KPiAg
IE5vcm1hbCBjYXNlOg0KPiAgIGNsa19kaXNhYmxlIC0+IGdldCBFdmVudEEgLT4gY2xrX2VuYWJs
ZSAtPiBjbGVhciBFdmVudEENCj4gICAtPiB3YWl0IEV2ZW50QiAtPiBnZXQgRXZlbnRCIC0+IGNv
bmZpZyBIVw0KPiANCj4gICBBYm5vcm1hbCBjYXNlOg0KPiAgIGNsa19kaXNhYmxlIC0+IGdldCBF
dmVudEEgLT4gY2xrX2VuYWJsZSAtPiBFdmVudEEgZGVsYXkgYXBwZWFyDQo+ICAgLT4gY2xlYXIg
RXZlbnRBIGZhaWwgLT4gd2FpdCBFdmVudEIgYnV0IGdldCBFdmVudEEgLT4gY29uZmlnIEhXDQoN
ClBsZWFzZSBhbHNvIGhlbHAgdG8gYWRkIHRoaXMgY29tbWVudCBoZXJlOg0KVGhpcyBhYm5vcm1h
bCBjYXNlIG1heSBjb25maWd1cmUgZGlzcGxheSBIVyBpbiB0aGUgdmFjdGl2ZSBvciBub24tdmJs
YW5raW5nIGR1cmF0aW9uLiANCg0KPiANCj4gRnJvbSBoaXMgYW5hbHlzaXMgd2UgZ2V0IHRoYXQg
dGhlIEdDRSBtYXkgZmluaXNoIGl0cyBldmVudCBwcm9jZXNzaW5nDQo+IGFmdGVyIHNvbWUgYW1v
dW50IG9mIHRpbWUgKGFuZCBub3QgaW1tZWRpYXRlbHkgYWZ0ZXIgc2VuZGluZyBjb21tYW5kcw0K
PiB0byBpdCk7IHNpbmNlIHRoZSBHQ0UgaXMgdXNlZCBmb3IgbW9yZSB0aGFuIGp1c3QgZGlzcGxh
eSwgYW5kIGl0IGdldHMNCj4gdXNlZCBmcmVxdWVudGx5LCBzb2x2ZSB0aGlzIGlzc3VlIGJ5IGlt
cGxlbWVudGluZyBSdW50aW1lIFBNIGhhbmRsZXJzDQo+IHdpdGggYXV0b3N1c3BlbmQ6IHRoaXMg
YWxsb3dzIHVzIHRvIG92ZXJjb21lIHRvIHRoZSByZW1vdGUgcHJvY2Vzc29yDQo+IGRlbGF5IGlz
c3VlcyBhbmQgcmVkdWNlIHRoZSBjbG9jayBlbmFibGUoKS9kaXNhYmxlKCkgY2FsbHMsIHdoaWxl
DQo+IGFsc28NCj4gc3RpbGwgbWFuYWdpbmcgdG8gc2F2ZSBzb21lIHBvd2VyLCB3aGljaCBpcyBz
b21ldGhpbmcgdGhhdCB3ZQ0KPiB3b3VsZG4ndA0KPiBiZSBhYmxlIHRvIGRvIGlmIHdlIGp1c3Qg
ZW5hYmxlIHRoZSBHQ0UgY2xvY2tzIGF0IHByb2JlLg0KPiANCj4gU3BlYWtpbmcgb2Ygd2hpY2g6
IGlmIFJ1bnRpbWUgUE0gaXMgbm90IGF2YWlsYWJsZSB0aGVyZSB3aWxsDQo+IG9idmlvdXNseQ0K
PiBiZSBubyB3YXkgdG8gZ2V0IHRoaXMgcG93ZXIgc2F2aW5nIGFjdGlvbiBzbywgaW4gdGhpcyBj
YXNlLCB0aGUNCj4gY2xvY2tzDQo+IHdpbGwgYmUgZW5hYmxlZCBhdCBwcm9iZSgpIHRpbWUsIGtl
cHQgZW5hYmxlZCBmb3IgdGhlIGVudGlyZSBkcml2ZXIncw0KPiBsaWZlIGFuZCBkaXNhYmxlZCBh
dCByZW1vdmUoKS4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxp
bkBtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0N
Cj4gDQo+IFRoZSAxMDBtcyBhdXRvc3VzcGVuZCBkZWxheSB3YXMgZXN0aW1hdGVkIGluIGEgd29y
c3QtY2FzZSBzY2VuYXJpbw0KPiBhbmQNCj4gd2FzIHRlc3RlZCBvbiBNVDgxOTIgYW5kIE1UODE5
NSBDaHJvbWVib29rcywgd2l0aCBpbnRlcm5hbCBkaXNwbGF5DQo+IGFuZA0KPiBleHRlcm5hbCBk
aXNwbGF5IHJ1bm5pbmcgdG8gbWF4aW1pemUgdGhlIG51bWJlciBvZiBDTURRIG1lc3NhZ2VzDQo+
IGJlaW5nDQo+IHNlbnQgdGhyb3VnaC4NCj4gVGhhdCB2YWx1ZSBjYW4gcHJvYmFibHkgYmUgZGVj
cmVhc2VkIHRvIGhhbGYgb2Ygd2hhdCBJJ3ZlIHNldCwgYnV0IG9uDQo+IHRoYXQgSSBwcmVmZXIg
YmVpbmcgY2F1dGlvdXMgYW5kIGtlZXAgaXQgYXQgMTAwbXMuDQo+IA0KPiBQLlMuOiBUaGlzIGFs
c28gc29sdmVzIG1pY3Jvc3R1dHRlcmluZyBpc3N1ZXMgdGhhdCBJJ3ZlIHJhbmRvbWx5IHNlZW4N
Cj4gb24gYWxsIE1lZGlhVGVrIENocm9tZWJvb2tzLg0KPiANCj4gIGRyaXZlcnMvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmMgfCA4MCArKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+IC0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBi
L2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gaW5kZXggNGQ2MmIwN2MxNDEx
Li5kZTg2MmU5MTM3ZDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmMNCj4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBA
QCAtMTMsMTAgKzEzLDEzIEBADQo+ICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNl
Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L21haWxib3hfY29udHJvbGxlci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ICANCj4gKyNkZWZpbmUg
Q01EUV9NQk9YX0FVVE9TVVNQRU5EX0RFTEFZX01TCTEwMA0KPiArDQo+ICAjZGVmaW5lIENNRFFf
T1BfQ09ERV9NQVNLCQkoMHhmZiA8PCBDTURRX09QX0NPREVfU0hJRlQpDQo+ICAjZGVmaW5lIENN
RFFfTlVNX0NNRCh0KQkJCSh0LT5jbWRfYnVmX3NpemUgLw0KPiBDTURRX0lOU1RfU0laRSkNCj4g
ICNkZWZpbmUgQ01EUV9HQ0VfTlVNX01BWAkJKDIpDQo+IEBAIC0yODMsMTAgKzI4Niw4IEBAIHN0
YXRpYyB2b2lkIGNtZHFfdGhyZWFkX2lycV9oYW5kbGVyKHN0cnVjdCBjbWRxDQo+ICpjbWRxLA0K
PiAgCQkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFz
a19idXN5X2xpc3QpKSB7DQo+ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xp
c3QpKQ0KPiAgCQljbWRxX3RocmVhZF9kaXNhYmxlKGNtZHEsIHRocmVhZCk7DQo+IC0JCWNsa19i
dWxrX2Rpc2FibGUoY21kcS0+cGRhdGEtPmdjZV9udW0sIGNtZHEtPmNsb2Nrcyk7DQo+IC0JfQ0K
PiAgfQ0KPiAgDQo+ICBzdGF0aWMgaXJxcmV0dXJuX3QgY21kcV9pcnFfaGFuZGxlcihpbnQgaXJx
LCB2b2lkICpkZXYpDQo+IEBAIC0zMDcsOSArMzA4LDI2IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBj
bWRxX2lycV9oYW5kbGVyKGludCBpcnEsDQo+IHZvaWQgKmRldikNCj4gIAkJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ICAJfQ0KPiAgDQo+ICsJ
cG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeShjbWRxLT5tYm94LmRldik7DQoNClNob3VsZCB3ZSBh
ZGQgdGhpcyBwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChjbWRxLT5tYm94LmRldik7IGhlcmU/
DQoNCj4gKw0KPiAgCXJldHVybiBJUlFfSEFORExFRDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGlu
dCBjbWRxX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1
Y3QgY21kcSAqY21kcSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJcmV0dXJuIGNs
a19idWxrX2VuYWJsZShjbWRxLT5wZGF0YS0+Z2NlX251bSwgY21kcS0+Y2xvY2tzKTsNCj4gK30N
Cj4gKw0KPiArc3RhdGljIGludCBjbWRxX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQo+ICt7DQo+ICsJc3RydWN0IGNtZHEgKmNtZHEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsN
Cj4gKw0KPiArCWNsa19idWxrX2Rpc2FibGUoY21kcS0+cGRhdGEtPmdjZV9udW0sIGNtZHEtPmNs
b2Nrcyk7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCg0KV2UgY2FuIHVzZSB0aGVtIHRvIHJl
cGxhY2UgdGhlIGNsa19idWxrX2VuYWJsZSgpIGFuZCBjbGtfYnVsa19kaXNhYmxlKCkNCmluIGNt
ZHFfaW5pdCgpLg0KDQpUaGFua3MgZm9yIHlvdXIgaW1wcm92ZW1lbnQgcGF0Y2ggYWdhaW4hDQoN
CmFuZA0KDQpUZXN0ZWQtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNv
bT4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQoNCg==
