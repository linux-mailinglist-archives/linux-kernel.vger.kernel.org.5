Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8E2758B04
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGSBso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSBsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:48:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD841BCD;
        Tue, 18 Jul 2023 18:48:37 -0700 (PDT)
X-UUID: 5db1e70425d611eeb20a276fd37b9834-20230719
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=goNEVbIQ4Q2faUOc6370tf+gcad1GBwffsOx7dk/H7c=;
        b=tTCiK5Wr7XUpOw9kXKWMpZ+k1h6fXkqbJUC49kSdLk15Hvn+6IqtlQgqrm0oSSeylk/NzS3tGjOOGM9N/qFmZZ0S8Y7lxueqJTOzYtVp7LlN0L1DLRgjA26Z9X5eT2AKZhfjcf0jkRnQG9AH5X+0AjYmhro38V0Iu7FityPkmk8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:8659c4d9-5a46-4c29-a180-23b6ed6d6a98,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:441bdd4c-06c1-468b-847d-5b62d44dbb9b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5db1e70425d611eeb20a276fd37b9834-20230719
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 605960152; Wed, 19 Jul 2023 09:48:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 19 Jul 2023 09:48:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 19 Jul 2023 09:48:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcCJsokQpo6WAzXqOqMMBw05+YbKRz1RkSei12M9RasKAVEGhLoQsSuRmkmmKPBrPgLdeCJA3FrCb++smbLCeZBZ2skkM7nyr6iw0Z30N5o/rXEcKfaSkf2bj9hCuhrARIgVQXTbS3kEy/6QbKDKnY0gOimtdyjpkbrdM8ZjPt8T1sJtogKXIncy7pxO2cqpHJgVQNAcvYdFAE2lcnoVCV5wqxFgvOT1GKR4THCfUMJFaXrCzNG6GdwuZCoGA5QAjSEdWBrGG9qZrHpHJGbD/tVdJJK5blv78ho4S7XqIoxvlouHNQ4z6F+D8DPiwZ0re07NXEcRn/rbakqF2Bma3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goNEVbIQ4Q2faUOc6370tf+gcad1GBwffsOx7dk/H7c=;
 b=nKsVQHVhUzNP+htAKF7Vl8krKjJe32Hc2J7S1rPrlcBT75Hqnug4FBXVurkXiVY/y6t+p9S8IhD9PTqFOzKMAm6oCiMak7Y5LDEmrwuUTy0p8ijKwKxkdg6OcGXdWKvolh7lzsfrCIPSJxwpQol2ofmMAnmvV+rOaIgYC0blr3iQXVHL/s52gHwf1yyn6bxjNZ1000fpXU5QFdlw3qscgdWJhOzXAOxax7aSZX9I7Vtqul60XUnBXjYcPEGzKQJ5uH3y00rq5HKvRi0ah1ZD9lrHx8smk1bmOCdHhe8IMYQeMjuqWPOFIR+kx1wOn4c0A/eECcL2S+HfYyAfAGosrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goNEVbIQ4Q2faUOc6370tf+gcad1GBwffsOx7dk/H7c=;
 b=WEmoSr1gTUsOT69AlkseINckfoAhdulUvxk6F9cs1b8XMR40g75QpkfZEVOkgdu9DWPkJHVOdMuZ3OJQgZ/bNd+wptkO24DAK49GWSRWhzdZpHcbw6a+6iRqvZjzQz3Gj9q/tbtiRvMtXFACYSEpCu+ECrU2kA7Xm6vZiv0nBss=
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com (2603:1096:820:73::5)
 by KL1PR03MB5507.apcprd03.prod.outlook.com (2603:1096:820:50::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 01:48:28 +0000
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b]) by KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b%7]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 01:48:28 +0000
From:   =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>
To:     "conor@kernel.org" <conor@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: soc: mediatek: pwrap: Modify
 compatible for MT8188
Thread-Topic: [PATCH v4 3/4] dt-bindings: soc: mediatek: pwrap: Modify
 compatible for MT8188
Thread-Index: Adm54x1Q72nS0Sez6kOz06M7YMVfoA==
Date:   Wed, 19 Jul 2023 01:48:28 +0000
Message-ID: <a4e1a80ebd19896410f50b0297e05dce06fb47cc.camel@mediatek.com>
References: <20230718110947.13426-1-jason-ch.chen@mediatek.com>
         <20230718110947.13426-4-jason-ch.chen@mediatek.com>
         <20230718-sporting-refurbish-85fdfab85d32@spud>
In-Reply-To: <20230718-sporting-refurbish-85fdfab85d32@spud>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5650:EE_|KL1PR03MB5507:EE_
x-ms-office365-filtering-correlation-id: 23d23ad3-a4b6-40e2-80e7-08db87fa3fd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5jgWtsnE07oGIL2t7qAucX3a0VD7u5n/jda2CYUPP+QHH5p9i9lsXu/6MkJtfhoAvHqa9GzYZxHv2MuJTIym+nBg2B5Y8rXwcFjQOytovkToe5q3Kd2VJnOH74zcguJUqaU+nIG7s6UggLl3qzQ3MPEK+aegbpW7zxX4oRXd+WnpJOsBQ8Bd0BPjsCFx54VvTfwuy2usJ+A7Y0buBJ/MnTge6oPtnDNgmCYoC6S34ntCd4JmlLIuACzxLF2wXYZHxJpaleGJD1H8Ogi+LHeQ9MwSF6CHEUly3A6MWEa+8YLD/aLnWOprGbHDuK7RCdHmrRkPiZnhKO9AYh7bwCrA32lOGji5Zpo4jR7iOS1Cmie+e9s9eJ0cHDavkdbSjQA71JS64Nol8ZAbRu2aO6bhk8dQIycjnE82+TaV7L+g7sDCyir9ExK4a9O1tZrM8dMuCXyS5tFcfdDYVzAEuCQwYNky7qyGxUH4h91y9g/8EN6A4EkinY+ht8kajAqtSywmNli33a1BRobFXkERMyYQFVuIo7etyLWZSW5+/5ycm78g6436td8d9curqhBmtwjXc6EUBhx9ijICaGFNbQz1geccHPTieFvdelPplbk3/tBfJ3p3h5S2/C6tFvePwXKTO+j8VfSYitsizkr1Kw9LmAABx537gNOjuI9Tw7HJ4t0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5650.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(6486002)(54906003)(91956017)(71200400001)(478600001)(2616005)(83380400001)(38070700005)(85182001)(86362001)(2906002)(76116006)(6506007)(186003)(6512007)(26005)(38100700002)(122000001)(66476007)(64756008)(66946007)(66446008)(41300700001)(66556008)(4326008)(316002)(6916009)(36756003)(8676002)(5660300002)(8936002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVBKL1hGanV5ZU5hNGlYa3NVNitYbGtJcVdxMTZFZ1h0TVlYTWdpcUlrZUIx?=
 =?utf-8?B?RWZQMENNc3hlRnNzY3BkZ0MyQi9iMGRMVnpZdEM1L3ZXN1Q4ektPK2lEZzRD?=
 =?utf-8?B?WndlS2pWQkQ5Q0srSnQ1UE9DR1pBbDhOQ3VJM3E2S1JOQmM0OXd4Nk5tZC9S?=
 =?utf-8?B?ci9WU2ZaYlM2elU4SzFnVXU5ZlZkU3REYjdzRGtoT1VBYW5hUGMvbzlyOExy?=
 =?utf-8?B?Z3lSKy9Lb1Q2V3l2a1JjWXJXcGVPZ0oxSTBpQjZhZ2lCTWNaUW1wTDF2QW11?=
 =?utf-8?B?V05HVmljREk2R1czUU1qTDNaTlhnNkMvZXNJTGRMTDVKZjRlZzBpLzBOeDVJ?=
 =?utf-8?B?bGU5YUJMWUxuczU0d2JXUEEwazBOZWpkRTkwazd2aTlGUkE0TUdZQ1RSVkdL?=
 =?utf-8?B?RUxYcXVHK0RJRTVVVGliMVQzVCtJcEJOQlZyUzdZZXRndS9tdVRpbi9zZzFX?=
 =?utf-8?B?a21ORWRtd2NsZ0M5czhqSWYwRE13a0tNUmoyekhHSDI4MDJoRkI1OEtTSW1V?=
 =?utf-8?B?K3dvbXZPNjJraS9lckJEYStjNmFCL3hkZUp1MDlFeHhvcDRPMGhKdlZGUlRu?=
 =?utf-8?B?dWdHcTNXS2NtMEl2NlFUZC9mamg0cGR1RlpyTzREWnNBaG1meUdVMVBXQ1Ja?=
 =?utf-8?B?d3Z0MVFkYVpxYi9qanVVNDFycE8rOFBxWjgyaWg0bG5BYnJVVGlvRjI3V1hV?=
 =?utf-8?B?Zlk2NGhJbTNWOEh1NDMwZjVIeDF5Um5Kd2ZwT2xuT3c5WGQyY0RWNEF0ZVZy?=
 =?utf-8?B?TVp0NUFkaDFONnViK1M2YzM2SmVNVGFMS2l5SlF6Qm5uQmhxaTJsM3dGMzB1?=
 =?utf-8?B?RkY0TE9qbTd5bnhORHpqbWN4ZGJ3Mmp1eEpLTjBBcUhXR21zcFFQdW5XYUFh?=
 =?utf-8?B?Qk9MOGl0amVYWUlpSmt3akExaDVsSGRJTStJK0hHVEtYT0xnWnpBRkJTQjJj?=
 =?utf-8?B?eUIwRTJuSmhUUld4NEpNZDJEN1F6T3RhRTcxRmtXM2pUamZzdHZpek9zWFdL?=
 =?utf-8?B?L21Qa1NwT0o5OVFQMVRPUnBZUkE5UGI2TVUvRnFvbDJ0cHdieUh3dy9uMlh6?=
 =?utf-8?B?ZHpFeHhleUxBZWlzdnJHcy93a1FDVGpPY3E2aXB5NEsya2hBUkx2YkJEaDJs?=
 =?utf-8?B?Uzk5WWhuTUhXQ1RBM2NPcFNYdHlCOGhvLzlTWWFocG5MMUZhZzB6UmxMVWpM?=
 =?utf-8?B?UThYanVvM2ZxQ1A3M2ptakVPaXFVOWZQa2RoZTY1WTdkRUpmT2Y5aUh6UnVM?=
 =?utf-8?B?cXJpYVN6TjJmOTNuaXdzSHllWUxRbngxM3YwUCthelk2TFU2aXEvS0EwTmx1?=
 =?utf-8?B?QzduRUZZMkQzZ2dHdG1Zd1h6OHhoZTNEZktMRUYvWnFZeGNud0pwTlhnUm96?=
 =?utf-8?B?OW5xU2xMWDMrcWF5T1BrY3pPWTdEWENTbjV6UC9CNVF1QjU0RGdrRkJUbWMr?=
 =?utf-8?B?aTVwRFlDdHpsUHVuTHYrTy9zZUNycnBxV2hmdktHOXpyV3pkODlNVjZHdE1J?=
 =?utf-8?B?cjI3NE1pQUtyWHVGQjFrZzYwNFg5TThpV0dlNzgxV1pTMjdMUHZYOVF3Z1pP?=
 =?utf-8?B?cEJxa2lSUitxblh2MHU0VkVIblJWR1JUN01CalErREM0ejYvQU1oK1NPMnNz?=
 =?utf-8?B?bzdEYkhFMmNBaTZoeVBOelFwRHJNNC8rU3llOGt4bGRpemFVd1ltY2o5QVpj?=
 =?utf-8?B?UDMzWDMrM3EwNzNLNUpSaW1VQWp3NmR6OXZZamxPNXRMbk5rRG1xWENubU5N?=
 =?utf-8?B?K29JRUtuWXpjRHBlTi8zcmY4TWFBbzBjSzcxazRPa0dXY2JLUm9uVHdJazFN?=
 =?utf-8?B?VFRVeU1UWW52WGZiTEkyYlNwNTBhaWQ5ZW5GMENtak1VYm9jcVQ4VFlSdWtX?=
 =?utf-8?B?dGlKdzJFMSt0UEJKMTdSYjBSQzlzaTJiMklJRmF4L3lEMDE2K1ViRmFQMDJO?=
 =?utf-8?B?VnBXbXU2Zmw2N0UvMDREUDdUWVBlUlhNVWFzbnd5TmZLS2NwK3VyR293djQy?=
 =?utf-8?B?TkFGRHZBZjFTcEJNeVYxbFRGN0dPRzVnQ0JKdEEyVUFrTWdrY3hRM0hVZk80?=
 =?utf-8?B?NHBHNkp2Ym1ydnVqY09EbVh4Q042WkdVcmwvYWJhV09KeUJBSnpDczJtd0FC?=
 =?utf-8?B?SGcvZnFXTWN1NlBGUWhkdStuVnFQSUJ1eURNV1F5LzVITGl3ZFBjbVBFK2RJ?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91D46E8C1AC9004E9A5A218299D30D25@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5650.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d23ad3-a4b6-40e2-80e7-08db87fa3fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 01:48:28.4922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zt47XJMmCtkJgJ478ZUdfYwBLNxGjDAQV+0d99sI1LxfJ2M7e5mnDoRH5NyB1FyPyxiTOcxYZZwd3kPuhThOc4bMCrJehOGccyJIQVfL130=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5507
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29ub3IsDQoNCk9uIFR1ZSwgMjAyMy0wNy0xOCBhdCAxNjoxMyArMDEwMCwgQ29ub3IgRG9v
bGV5IHdyb3RlOg0KPiBPbiBUdWUsIEp1bCAxOCwgMjAyMyBhdCAwNzowOTo0NlBNICswODAwLCBK
YXNvbi1jaCBDaGVuIHdyb3RlOg0KPiA+IEZyb206IGphc29uLWNoIGNoZW4gPEphc29uLWNoLkNo
ZW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IFRoZSByZWFzb24gZm9yIGNoYW5naW5nIHRoZSBw
YXRjaCB3YXMgdGhhdCB3aGlsZSBNVDgxODggdXNlcyB0aGUNCj4gPiBzYW1lDQo+ID4gcHdyYXAg
YXMgTVQ4MTk1LA0KPiA+IHRoZSBvcmlnaW5hbCBjb2RlIHdhcyBvbmx5IGFwcGxpY2FibGUgdG8g
J2NvbXBhdGlibGUgPQ0KPiA+ICJtZWRpYXRlayxtdDgxODgtcHdyYXAiJy4NCj4gDQo+IEkgZG9u
J3QgcmVhbGx5IHVuZGVyc3RhbmQgd2hhdCB0aGlzIG1lYW5zLiBEaWQgeW91IG1lYW4sICJ0aGUN
Cj4gb3JpZ2luYWwNCj4gYmluZGluZyBvbmx5IGFsbG93ZWQuLi4iPyBJZiBzbywNCj4gQWNrZWQt
Ynk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KDQpUaGFu
ayB5b3UgZm9yIHlvdXIgcmVwbHkuDQpUaGUgYWN0dWFsIHRlc3QgcmVzdWx0cyBjb25maXJtIHRo
YXQgdGhlIG9yaWdpbmFsIGJpbmRpbmcgaXMgb25seQ0KYWxsb3dlZCB0byAnY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxODgtcHdyYXAiJy4NCg0KPiBUaGFua3MsDQo+IENvbm9yLg0KPiANCj4g
PiBUbyByZXNvbHZlIHRoZSBEVEJTIGNoZWNrIHdhcm5pbmcgdGhhdA0KPiA+ICdbJ21lZGlhdGVr
LG10ODE4OC1wd3JhcCcsICdtZWRpYXRlayxtdDgxOTUtcHdyYXAnLCAnc3lzY29uJ10gaXMNCj4g
PiB0b28NCj4gPiBsb25nJywgaXQgaXMgbmVjZXNzYXJ5IHRvIG1vZGlmeSB0aGUgY29kZS4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBqYXNvbi1jaCBjaGVuIDxKYXNvbi1jaC5DaGVuQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlh
dGVrL21lZGlhdGVrLHB3cmFwLnlhbWwgICAgfCA2DQo+ID4gKysrKystDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVr
L21lZGlhdGVrLHB3cmFwLnlhbQ0KPiA+IGwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvbWVkaWF0ZWsscHdyYXAueWFtDQo+ID4gbA0KPiA+IGlu
ZGV4IGEwNmFjMjE3NzQ0NC4uNDczN2U1ZjQ1ZDU0IDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9tZWRpYXRlayxwd3Jh
cC55YW0NCj4gPiBsDQo+ID4gKysrDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL21lZGlhdGVrLHB3cmFwLnlhbQ0KPiA+IGwNCj4gPiBAQCAtNDEs
NyArNDEsNiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4
MTczLXB3cmFwDQo+ID4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODMtcHdyYXANCj4g
PiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4Ni1wd3JhcA0KPiA+IC0gICAgICAgICAg
ICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXB3cmFwDQo+ID4gICAgICAgICAgICAgICAgLSBtZWRpYXRl
ayxtdDgxOTUtcHdyYXANCj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODM2NS1wd3Jh
cA0KPiA+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4NTE2LXB3cmFwDQo+ID4gQEAgLTUw
LDYgKzQ5LDExIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxt
dDgxODYtcHdyYXANCj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS1wd3JhcA0K
PiA+ICAgICAgICAgICAgLSBjb25zdDogc3lzY29uDQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4g
KyAgICAgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgt
cHdyYXANCj4gPiArICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE5NS1wd3JhcA0KPiA+
ICsgICAgICAgICAgLSBjb25zdDogc3lzY29uDQo+ID4gIA0KPiA+ICAgIHJlZzoNCj4gPiAgICAg
IG1pbkl0ZW1zOiAxDQo+ID4gLS0gDQo+ID4gMi4xOC4wDQoNClJlZ2FyZHMsDQpKYXNvbg0KDQo=
