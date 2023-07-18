Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFDE757449
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjGRGfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGRGfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:35:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB91100;
        Mon, 17 Jul 2023 23:35:39 -0700 (PDT)
X-UUID: 4c9f9b1a253511ee9cb5633481061a41-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wXXy1pc8YrnOmzZnLHBIGrtAcVdkg6S9F9eOmunrInQ=;
        b=XpbgLYZ0s+nxqCWp6ODVqtHL6qyHUs1FKmTGHig1i/zGI+h4F6wY9dXT5KaIQPaHRG2dExnK/4VCbICxnBSsbuNsxtUSTJHpl2mhVN2rtIBxS5MAg8kfkuL6FRuySZTFrE574q9jZW9S+8c+Hm1+wmOy9B2gMb/3GijFlfYwEd4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:b0240618-644b-470e-aa05-2642182852d3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.28,REQID:b0240618-644b-470e-aa05-2642182852d3,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:176cd25,CLOUDID:6554b8dc-dc79-4898-9235-1134b97257a8,B
        ulkID:23071803552521V4BTUL,BulkQuantity:4,Recheck:0,SF:38|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 4c9f9b1a253511ee9cb5633481061a41-20230718
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1084403172; Tue, 18 Jul 2023 14:35:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 14:35:33 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 14:35:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REiviSihNnJbYT1lGWCadOjIlLsDCX5DNDtwAEniAUaxUwneT6asVVDFT/yKPl5dEJBRnEHFnGCSsPu9AZauRin3zSaGGwUBKf3Dce1u1AvUc8bv0/+Hm2c3mpdao2oeS+0kpiTJBcIGdcFUuaEoouCjPl2R6JpK7H1Pll480dryp7ucmarqlFMZivRdf6MbayUiye++LSKhooO+pXzSnO2Qmz0oJ4a9LWrln2LqYtOk0vuBRF5dB65g8Wh74yMg2IqW1V7aMtHkhTYAduI85wocFRZBO6XDHzCbOp1cOVbcw/ZxUaiIVlU7pt84XDURRxiDeanR1mAqPTrr6hE41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXXy1pc8YrnOmzZnLHBIGrtAcVdkg6S9F9eOmunrInQ=;
 b=F7YHoZxt0OMNAvG2KJ9n++SJqr/RIpQWxFieiBe4GCUvZPLSQjEL6xet1FCfscNzfTbnvLJ+N3Ix/TulD8vjmY4VZscQRaFaLNtBfouMwodsFb77jMGFN8K9X1sUZuUoQ43QkcNQmRVOTw+3vWMPgsHaL8WOKZDACKc9sF18MI7rgMtiJJlqzrmsg87fkPOJQ2km/Q44Dr5i5TKbIKzlmyNFeXW82+5FYDZpmJVNzxXHsxiQLjFbxyyQWjmv0/N0WEYENWBy5y66HF3WRVsMgka9DZA/QHKtwnqNwXEjncgVwb2M8A/u2NqBopb2VkaysSkF49g86ydtSagWpnh4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXXy1pc8YrnOmzZnLHBIGrtAcVdkg6S9F9eOmunrInQ=;
 b=X6NbSGCCLSgiXm5Fw3wHOLu+yS6Wk803wzEV8Oh04+gUPQiIuJS6NMuwuxSVvllYc90tCCxX36mGeRa6HIyvbKr0Ge6DUtMvD6VePwWEduH1ZYmq9bCKmRnU7Y9phvSoEJWTP6FVwOnN/MSxvEFndrINKh97zEG/nTfLvHVViYc=
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com (2603:1096:820:73::5)
 by TYSPR03MB7823.apcprd03.prod.outlook.com (2603:1096:400:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 06:34:28 +0000
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b]) by KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 06:34:28 +0000
From:   =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT8188
Thread-Topic: [PATCH v3 3/4] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT8188
Thread-Index: AQHZuKa+mCNwE2yJYUy0H3wXIybGVa++X+qAgACykoA=
Date:   Tue, 18 Jul 2023 06:34:28 +0000
Message-ID: <054014f207e24e1507199cd9833085346ed8cbd6.camel@mediatek.com>
References: <20230717120300.21388-1-jason-ch.chen@mediatek.com>
         <20230717120300.21388-4-jason-ch.chen@mediatek.com>
         <9e46c996-3e3b-b437-f2c4-2ca86a1c7e6c@linaro.org>
In-Reply-To: <9e46c996-3e3b-b437-f2c4-2ca86a1c7e6c@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5650:EE_|TYSPR03MB7823:EE_
x-ms-office365-filtering-correlation-id: 869f1e05-f43b-46e2-e996-08db87590973
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4V1+GThe9DTWlSZcht3pGsIK57fYCAnm0mGFkXF7NEyEYFSjZv5YjSVOYnGpgak8D/GYq+91hXE0rudYq4BXhRTz2cyYnFJjT4C8ws/vBK/I0EdQb8ZnxQy9s47REKec1eH79qEvbVAibo41uFEZ++yQ9ywgItoXPFc8LOngEwrdUV7zJAaSeITi2uC9uBLiOzE4YunikaOG14CeUt/B+2kwktoxRGo77tiViwdxkpmysOsp/LhHPoAHTRSLQAG1W56q+fjFq6b/wHqyOKgdTgCdeHcOHMEb403khcyqlxPImVepWIccap0rQYmj9EpSu+e3Lh3G4CgWmipEq8vHTLRbeuDxEls0v3nqPTQXQgiKyoHCcPoQdX089sK4SDg5fOioZw6yA7D0YSmeAllNYTKvOACvibtrGrHujlslzARde4eQ8TAe0+hZ4bhOZhw+CVOYjYtnHReVchJU1Ooo5MLwoZdOjhgRubjvXGzGVWQLuJZnos89RjBCt5vD9UGpmrieXRJ91DpylqbP5htkteXZY6d7FP0utHrAOfH3dRnLZVA10OwtucRxmlzZNdnKr580LEqtGRkNnLSHyWVuwTJ4caVP7aCKxJZfAN2E21r8dON8jDCWdXdrqoylfwzTMb7CiUTRNjCGTxXd/irSyR8n8yVfoqcawnMBE+C2gpo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5650.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(316002)(41300700001)(83380400001)(53546011)(6512007)(186003)(2616005)(26005)(6506007)(6486002)(478600001)(110136005)(54906003)(122000001)(71200400001)(4326008)(76116006)(91956017)(66446008)(66946007)(66556008)(66476007)(64756008)(38100700002)(7416002)(86362001)(5660300002)(8676002)(2906002)(85182001)(38070700005)(8936002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkJvVE5oRTc5ZlJtOHFrMXlXeFpNY3FRb3ZiWWd5d05jdFloaUR0ZFF1TGRE?=
 =?utf-8?B?cXphTGE2UzJ0UmdabDhxSXIxdnlGWGlyL1lBUEd3SkRoN2VOODJhOHEvRGtC?=
 =?utf-8?B?b3RGejZ1VGN4eVVkekhncmU4dFg5di92SzlMN0NqaWxrWmFWN0hlZVJXS3pO?=
 =?utf-8?B?emppWEN6azNPbkpvTGdvN2ZJbGR2RndMRThONHRkMHg5ZGpGYjQzMXNmaWFI?=
 =?utf-8?B?U25jQTk2RWllcUFTd2JSVWdPcW9Ca0tXbGJmalgydDBJZVJIM2l2WWl3aVFu?=
 =?utf-8?B?REJBUytuKzJCSFBadkE5WlFsY3pGSWJGMkNoQjRjeVNDMFNEVWEzSkJFRGZJ?=
 =?utf-8?B?RklsUGFUWkxiRWZZeno1Rk5STjlkUmYzS0tIVTMxNXVDQ0YzSUt6MUlTMExp?=
 =?utf-8?B?c2hQU0JaNk9OU2FuUGgvSnNTWFF4REJsQmd4WERlNkFMYk5yWlErVXRXRERm?=
 =?utf-8?B?ZDdtQVVGNmh0SWRRL2ZuOFRiUjVES2JmUXl5Q3REcXoyS2dsaEMzRjhBT1Y0?=
 =?utf-8?B?ZkcyS1F0ckUyWnM5Tmc1bndFSHVHYzNGTFk4MW1tN0ZadTJlRkJDSmNuOW5C?=
 =?utf-8?B?dzJoSi95a0FQbDVaTXBHZnNFaFJFa1RzcGU1NjRMNzZFQWdHbmVva3NMSGNX?=
 =?utf-8?B?RlFhUCs5bEpYc3dNbzErUitqb3BoMXQ2Q3BjdXdnZDd5UzdqMGpJMThOWXJD?=
 =?utf-8?B?bkRsSnBUcG1nUkVMSXh1cEdOSFFMTy9jbDdFVkZEcDhRbzBLYnNpYWxPRWJD?=
 =?utf-8?B?SWsvSml2bEFBSTNhc1pEOFppc2ZuWkJGb1d1NnBncC8rNXhOUE90MG1hYktH?=
 =?utf-8?B?QVZ5TlpwS0pLWnhzMFJ1Mk4xNVB4WVJialNESWhscjh0U1loOEdBZkRvKy9C?=
 =?utf-8?B?dGxVNWRwTWdCRVhnUDVkcE9nL29MeDlzdWhpak5pVWU1OTNqbHBMSEU0Z2ZU?=
 =?utf-8?B?cGlzNW9PREZqc0d6NE1CSEplMW9lUUNHekwyWk9lOTJUWi8zWE10dWs5ZU1o?=
 =?utf-8?B?d0tmME5kUjRlOWFFNVZJSU9xWGgyalZ0QTl3b1JGU2g5UTBSK1NTTDZHVGZE?=
 =?utf-8?B?cUNyOWlaNjNwWkloZHlzN3FkTUdyZ0RFUmJsc0lHd2hzcjMyYUhPelVSUE9y?=
 =?utf-8?B?TDZ5NEsxNTJ6TVdzV251WHZhaU9URTMxK3lXbHJYYzFtSUtXM2c1K1llMVZx?=
 =?utf-8?B?UmhJb0dBN005eVJSSDZMcWU1OUkwUk9RSkRiYXAzVXFhMU8xK0pRZkZOdGor?=
 =?utf-8?B?UUFPT3JWaDF1ZXNQVDl4Q2RzZDFJTW52dzJxNlVDYndXdTlzYlBlbFBFRUlU?=
 =?utf-8?B?SjRBSXdCKzd4Um9lWmVyRE5qNTdpNW9VNmordmpzVkMvSVVCand1a2c2azlt?=
 =?utf-8?B?c05ibFdFd1c1cHBLTUxVcGJ4VEpEaGFHZjhtNnhMVUlac0MzZDU5WGhmb1JN?=
 =?utf-8?B?R25ENVdMR2xJNE5iS1RUQWUxYmVGb2dXK25WcjJsOUkrTUN3aW1XbG9pYmVU?=
 =?utf-8?B?aXBqMWVRTHVSZDhsQnM5QjB0ekkzRlljTTZyYnZTZWZXcWJiRGVqYjdtT1Ay?=
 =?utf-8?B?aHdVelBrZmdqc3VlbHhMV0tVSVpBUW5xam12d2g4NDA2MWFmV1dpcVNPVE9P?=
 =?utf-8?B?YU8wR29SaldTMTZSVEJxZnRyL2hMa3V0Q0c1ZksvOHhCSDVJK3gyZnprK0Rs?=
 =?utf-8?B?RUJuVVZsVEswRU9ZZVM3enIxYjVSTy84RlNqbFZKRmZpcEw3d2ZUVWVvaU4z?=
 =?utf-8?B?Ri9MelFPSUQ3dng5eEh1YTNZajM1c1hqcHBNd3Y0V2psN0d1UXV6NlB5SlJ6?=
 =?utf-8?B?YUhqYlZLaWg5eFQxelg1dC9KQ3RXSktWVEpUNGM2cHBweVpRb1kyWlAvVnE4?=
 =?utf-8?B?eGNTb2tpL29oQkV6U0U1VlovQURkTXBmUGFVK25uL1NXNnZ5SW95S1U4a1p3?=
 =?utf-8?B?R0FVL1JmU25VZFJkWkhSZUEwNjhCZGNMMlA4c0w4alFWWTU3L002dUxZZXo3?=
 =?utf-8?B?Q2VlOUJ4Ykg3a0lkdjRUNlNxMGg1SzJSaE1TMjRtOFRVVlIyVy94ZUFsZlk5?=
 =?utf-8?B?VzhBM1JiTnRlK2d3bndmNWxxNjdqM1BYLzB5b0RwWXpSeVhCZlMxV3dnaWsr?=
 =?utf-8?B?allJVDlBbFg5SXdTSlQrb2I2ZGZrTGtKb0s5SncyOUwrd085MTJJVTh6dlp1?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6A26FCBD566084290237C5499E783B7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5650.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869f1e05-f43b-46e2-e996-08db87590973
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 06:34:28.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0ylF0dnedDUGfUMCKdtq6PIulCfet4yVMjPLlCPu34gMuYwC3jYK5NtdgiIc+Rwc/KL0eke/CdLaurBg5B8f9Zpc0w4Xz2mraoHDiho25w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7823
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBNb24sIDIwMjMtMDctMTcgYXQgMjE6NTUgKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gMTcvMDcvMjAyMyAxNDow
MiwgSmFzb24tY2ggQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBqYXNvbi1jaCBjaGVuIDxKYXNvbi1j
aC5DaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBBZGQgTVQ4MTg4IFBNSUMgV3JhcHBlciBj
b21wYXRpYmxlIHRvIGJpbmRpbmcgZG9jdW1lbnQuDQo+IA0KPiBObyBpbXByb3ZlbWVudHMgaGVy
ZSAtIHRoZSBjb21wYXRpYmxlIGlzIGFscmVhZHkgdGhlcmUuIFN1YmplY3QgaGFzDQo+IHRoZQ0K
PiBzYW1lIGlzc3VlLiBFeHBsYWluIHdoYXQgeW91IGFyZSBkb2luZyBhbmQgd2h5Lg0KDQpUaGUg
cmVhc29uIGZvciBjaGFuZ2luZyB0aGUgcGF0Y2ggd2FzIHRoYXQgd2hpbGUgTVQ4MTg4IHVzZXMg
dGhlIHNhbWUNCnB3cmFwIGFzIE1UODE5NSwgdGhlIG9yaWdpbmFsIGNvZGUgd2FzIGFwcGxpY2Fi
bGUgdG8gJ2NvbXBhdGlibGUgPQ0KIm1lZGlhdGVrLG10ODE4OC1wd3JhcCInLg0KDQpUbyByZXNv
bHZlIHRoZSBEVEJTIGNoZWNrIHdhcm5pbmcgdGhhdCAnWydtZWRpYXRlayxtdDgxODgtcHdyYXAn
LA0KJ21lZGlhdGVrLG10ODE5NS1wd3JhcCcsICdzeXNjb24nXSBpcyB0b28gbG9uZycsIEkgbW9k
aWZpZWQgdGhlIGNvZGUgYXMNCnBlciB0aGUgY3VycmVudCBwYXRjaC4NCg0KPiANCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBqYXNvbi1jaCBjaGVuIDxKYXNvbi1jaC5DaGVuQG1lZGlhdGVrLmNv
bT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL21l
ZGlhdGVrLHB3cmFwLnlhbWwgICAgfCA2DQo+ICsrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvbWVkaWF0ZWss
cHdyYXAueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVk
aWF0ZWsvbWVkaWF0ZWsscHdyYXAueWFtbA0KPiA+IGluZGV4IGEwNmFjMjE3NzQ0NC4uNDczN2U1
ZjQ1ZDU0IDEwMDY0NA0KPiA+IC0tLQ0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zb2MvbWVkaWF0ZWsvbWVkaWF0ZWsscHdyYXAueWFtbA0KPiA+ICsrKw0KPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvbWVkaWF0ZWsscHdyYXAu
eWFtbA0KPiA+IEBAIC00MSw3ICs0MSw2IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAg
ICAgLSBtZWRpYXRlayxtdDgxNzMtcHdyYXANCj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVr
LG10ODE4My1wd3JhcA0KPiA+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg2LXB3cmFw
DQo+ID4gLSAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtcHdyYXANCj4gDQo+IExvb2ss
IGhlcmUgXl5eXg0KPiANCj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS1wd3Jh
cA0KPiA+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MzY1LXB3cmFwDQo+ID4gICAgICAg
ICAgICAgICAgLSBtZWRpYXRlayxtdDg1MTYtcHdyYXANCj4gPiBAQCAtNTAsNiArNDksMTEgQEAg
cHJvcGVydGllczoNCj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4Ni1wd3JhcA0K
PiA+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LXB3cmFwDQo+ID4gICAgICAgICAg
ICAtIGNvbnN0OiBzeXNjb24NCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgIC0g
ZW51bToNCj4gPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1wd3JhcA0KPiANCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClRoYW5rcywNCkphc29uDQo+IA0K
