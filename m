Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A37519FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGMHec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGMHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:34:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBAE2102;
        Thu, 13 Jul 2023 00:34:22 -0700 (PDT)
X-UUID: ac8a8376214f11ee9cb5633481061a41-20230713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=J8Y791zY3vO0ZQD4QdyuA5O6S4XlLfjNukpyuK2hBTo=;
        b=UkRe49JIYua77g3feLuJwi95y0/SigNNoFTMyOx0NElQ07s46pztXsL/jWG9Cb6Bm4WLQk4P1sa4rDkx5LJnl4WajXD9/6wUTWP6AcMmYyBSrSHDJEqMAmW9RngspGqEMRlIumXLOmJ4IFSzIAV+RqKrMpLeP9wAreb7PzEugPg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:8930db25-a667-4dd0-ab10-cab830117365,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.28,REQID:8930db25-a667-4dd0-ab10-cab830117365,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:176cd25,CLOUDID:8793e30d-26a8-467f-b838-f99719a9c083,B
        ulkID:230713153415H68L1NPQ,BulkQuantity:1,Recheck:0,SF:28|17|19|48|29|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: ac8a8376214f11ee9cb5633481061a41-20230713
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 863648287; Thu, 13 Jul 2023 15:34:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jul 2023 15:34:12 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 13 Jul 2023 15:34:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqInOeW8jc6/hEZLFRaWLrP9S3m6wI4B9Qb3A04fIcKZVKIXvkwHwlH8SHNvZXyeUwUMNackOD7IPvK4jbc1qCfhciAi4O6wqJI8dpe7sKF3sJZm6sL7ozWkRO/eZM59g7XIQmbVQ4vIAxOtdnw5Bv2y6fZ7EnyfhvNaCfqnoadhuLoLojjwpSWWIcV7kQZcpX5qqkvfrU26eeMHUmy7a/fde1K86Pm0wykig/+8bwx+UbJckBBNE9m96UatneNHXLHp2CzVSP0Zbs+IsZV7p1V4C75aUqUuUu15kr/TNJmEHmL1SgPvCyHIxcwBNYQvBAOw3i0Uqi7oF5a0gMQmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8Y791zY3vO0ZQD4QdyuA5O6S4XlLfjNukpyuK2hBTo=;
 b=cfMkQ7roZismKXLVGKwaWVZiz2bqT2Yyn8KgDchmeMiupIOTQoY+AvwBe3mKaI/A/bwiJpivYAHWq7LZpZespyYoN1WTONBUMzBJQqowwZUQp9+IqwYNB4FLVMmmNDjp8UA8rfUIhGcy3HkGKgf/+FKxz6HUZPMO5Ndre7lY38+1ohR3aLJrYOi8PHNRDTQRzj3FU1ALo2aydB64SgzZqwWofqG56zYiwa6rMTvyFrtDjdgiL0o1mwnR0IZwUBd7+c3CkLh0ciUpKJrre1Bm8iUi3njr5av1yfIgoBtYLMxZlVfUuCxVx00uIqCLOpmuLI3Tj6mrMwNdMTce4tYRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8Y791zY3vO0ZQD4QdyuA5O6S4XlLfjNukpyuK2hBTo=;
 b=ReTHB/fdsQO0aQ31uz8pNnYqxFpPSt4mWZAoTIT8D4HUSWqT7mcI2C7cn+/NNKsUJOk2xy6A/Mt9TKU9QTuewIBh/H69F7vLMU7A1STy2V8XKS5deyb+8dga3fpyGJzC7lc85E8PohDT3ffrcUX51e6hz2xxymn1vOoi+G0lIE8=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by SEYPR03MB7950.apcprd03.prod.outlook.com (2603:1096:101:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 07:34:09 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::308:e3ed:1ec8:f918]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::308:e3ed:1ec8:f918%3]) with mapi id 15.20.6588.022; Thu, 13 Jul 2023
 07:34:09 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v14 07/12] remoteproc: mediatek: Remove dependency of
 MT8195 SCP L2TCM power control on dual-core SCP
Thread-Topic: [PATCH v14 07/12] remoteproc: mediatek: Remove dependency of
 MT8195 SCP L2TCM power control on dual-core SCP
Thread-Index: AQHZsJO3lAlinBBl8E2mWUSOotwCEK+03xWAgAJ4k4A=
Date:   Thu, 13 Jul 2023 07:34:08 +0000
Message-ID: <80c5a207beb41259b075d43552839c277b294a6e.camel@mediatek.com>
References: <20230707052612.27521-1-tinghan.shen@mediatek.com>
         <20230707052612.27521-8-tinghan.shen@mediatek.com> <ZK2WS+cldx/8+VGA@p14s>
In-Reply-To: <ZK2WS+cldx/8+VGA@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|SEYPR03MB7950:EE_
x-ms-office365-filtering-correlation-id: 1aef0ef2-3017-4244-100e-08db83738b89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jNnkt4EgYyAUllnYENEX+3rIhbNvQyY6Pbr4YR9azr+cWyBGEpZX9V03DStdHHWiUeorlamuz+JnWp3/3pRSdsQIRHpI351l36g7x9L5RWCYqSpmXkp9xOkeCy91LGO21csTq0g/udWhANhcXif250s1aOySV3NBpxp0lQ4YerA/Zm/jjHVmyQkkXIjbq1aaIc4Pc6+AGWVBq9eWqPAzFc75gHZJ7VJjE4WAVoVoepg9mTDDgdzx0d/jphMXXnI37J2EC6wHzFzRSx7X04SRNuFozYEc/jkCjHaSN2KtEPkrgsAUfjZnEwVEGLX3Xek7Zqot54gJ+Z2hHpNkKjhm3bq3W3P88TuUvhbyhFZs4pDTudgmQi5FXAbLNjskrkaybaCA+V05m6WJHgXI/GzrFu7I4a62JSgVHyCWXbQZJNDWKhEGoobMHRFZKOHYmi/uWs9pE4HYngVDbDdC8rbOG6OwSLEHn8AS4MRBxm6IsWSWHlfGx3O2YShhLWsRt80rOxooD/pb4BblpfgYSYbZKzSde1pzT2xpN9hLXHyRNfO9p5pjMnIeMO/vOLbYomljmmWRPl5tOCVv8BRMgJoS6bqNHFiFYtEWJsFXgj8EtIHscwMyIaYT41k2rl3Dl773gjJzpf12g10FPb4WSYSQJsrijBI9nCmsDtnBVLxKFTs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(66446008)(41300700001)(4326008)(7416002)(2906002)(6916009)(66946007)(64756008)(66556008)(66476007)(91956017)(5660300002)(71200400001)(478600001)(316002)(76116006)(86362001)(38100700002)(8936002)(8676002)(6486002)(6512007)(85182001)(36756003)(26005)(83380400001)(6506007)(38070700005)(186003)(122000001)(54906003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE5MQ0hBdDlRVEQySTlsQklLOXkrTk1WbFR0Ly8wSFVOTWdPNnllUk9ZNGV3?=
 =?utf-8?B?R3Rvd1Z1YzJxcm9ENnQ1QlJJZWtONVFMaVQ2R3BCMTZuc1FJMFMzNjN2cWxh?=
 =?utf-8?B?VnQ3b3EyMUdqUWdqUVBzd1F3NmRCOFZOaHdmTVozbW90bU5yVDBUZUxmTEZi?=
 =?utf-8?B?cnNjbGg5NW5jNFI0TGxlYUZRZDI3bVRyVVNZbXhiWDhnQ2plL0VON0xST1B4?=
 =?utf-8?B?dnRXdU5MQTFDTmMyY0M2UDdaSUxGZG1rRkkzVDZrbVF1VEVZdkFFQjlsb0Ju?=
 =?utf-8?B?TjR6V0JKU0lRZ2Y1NFgxTXRkM0MzZkl6OHBIdWNqVXRUeGo2UGk0RFlJblNR?=
 =?utf-8?B?OXFSdnlYTGp5aDVGY2dOajlUM1IwL1BLaFhNQ1lteGRDbGRvbVd1VmNjWWtJ?=
 =?utf-8?B?M3B4Vm1IbXZIaWNrT0J6Znl6MzlHb3JCeFhuTlJmNXR0alFtQ1JabE8yelVL?=
 =?utf-8?B?UTZQNnowblJSSjg3OEF5a2JlVElpU0EvVXQ3V3Flb1QrOXRnb1kwbk91eENU?=
 =?utf-8?B?bnMzLzkrUW9WK05zYmJOWG5jdER0T1FxSXZmUTJuZUp1MjUzZ281ZmpFZ1k5?=
 =?utf-8?B?N3prcloxNEtkUUhURnArTDlyYnVwRjg2RVlGT1FxVTJYaGNYa3F0K3E5NXJX?=
 =?utf-8?B?RytTbVRvSzdXaUJsTzF0TU1TbCtoVWcxbkNpUERXeGQyYko4eE9NalJJYmdU?=
 =?utf-8?B?cmJFLzh2NzhjYzU1ZnVWR1BpYjBPUDg4RVJFL2tmVnNrSDlqZ2RXNUwzRktE?=
 =?utf-8?B?WmFTUHNpNkI5YmpUMVdubjhpMHFJcnhjTU5uR3JSQzQyYlgxWGlseHRYS3FF?=
 =?utf-8?B?RDl4Vk5RZVV4bkpjRjhZZEYySDlKd0RTL3pwMVV1eWhUeS9QSnpQWWhRcVBJ?=
 =?utf-8?B?T3JhMFd6UFZVaENNOUFCYzVvR01aQ201by9SNGVKRWtVODZvUUtMRTlpcnRB?=
 =?utf-8?B?aG9UeGx5aGxEaWh4YktaRGVJUGF1WnA5R3F6VHZFaG9tQTFEakFzNGRRTmFJ?=
 =?utf-8?B?UTdERmxFNTRyUXI5dXIyRGhXR2M1cU4rdWhXMDhiSDN0Q1pxZGhONWxXamlo?=
 =?utf-8?B?bys4aTF3UkRudHBLbTdDYlJUbXU3VmYwTzdieUg5UkFmd2xHbXRxUndHUWZO?=
 =?utf-8?B?VVEzQ2V2NlJwa0krNkFNeFBNdk9yOWg3TXJlZ2kzVGZWeEkrak1KaEwzcjBJ?=
 =?utf-8?B?RTh6TzNMcjFTZzFZdnNpamRKZ09pblo1WXVQWE05eVAwY00vaThzRm5OeFNu?=
 =?utf-8?B?OWFVV1dtN2lmSW5iWXE3STVmZUVRYVhNSDJ4NmxXcUUyV09xWVdLc0hLemJu?=
 =?utf-8?B?ajhEeFhxczdqQldTYkxvSFgvNUpnU3lXZDQzZ09JWVJNazJTTnM1bEN2NFNT?=
 =?utf-8?B?V3dFUm1qMDdlanJudjBaREprZDNUbTczeFRTQzM3U3FSVm9VL25UNEhhWUZU?=
 =?utf-8?B?WHBWNFR1aVo4MXNjSDNORXFsdzBCa0pteHhSMlY4di9RYXJVUUlxSDJJZDlE?=
 =?utf-8?B?YUNrQkFGd2p4NFU1VEFoaXh3b2t4V2t0KzFxS2I0YUZRK3Z4TlhNQU0vdG1J?=
 =?utf-8?B?NGI0VWdiZkcxZ2xCcG1kcW5XdlYwb3p5a3M1SFNXYU1uRERsblFGM21BVEhz?=
 =?utf-8?B?MkwrTkxPRld4UTFOdmZGY2tpOFZjanpmWEt4M2tOTG1JalRNeURqNXptVGxm?=
 =?utf-8?B?SStsdWVhZVVCTVNQRlhwblFWSTh0VFN6cVFHMENJK3N0TW9vWVlFWkhYTGRl?=
 =?utf-8?B?am5yR3lHV3h2R3lhSGNMYS9tYkVzZXRZaEdMRXE0bzZDR3NrS016eFhzbFJO?=
 =?utf-8?B?ZWViMlY1U2xHUXFGMFhCUG5oTmtGeUZ3bDVZSXltSXlKY1VSNGQxemtpcFdL?=
 =?utf-8?B?elMxcjgrUU1qOXhjYW43OURtaFZud3B0T3hMajdTYlc2MWpMakMvN25LQmJq?=
 =?utf-8?B?N2huTGcwZzFhRUFGcWF6WExJbktTOC9jUDVucTdnOU5vdlJLQm9oSW5zaWM1?=
 =?utf-8?B?UmhVcWhpazBvOWQvYWp4VmFJMjhiL0c3b21meG5wSXFET2VuTWNrcmpzeUZv?=
 =?utf-8?B?S2dRUWhqa1JRMnAvbnh4ODJ0UWtMbnB2cVFrUHlQdWxiY1p5R3ErcmNzZVBD?=
 =?utf-8?B?eS9Lbmgwc1gxck96aDhSVHY1UC8xdlFEM0VrRzJqNXQ1VTMvbU5WK2o1QVdh?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F66BE27A8D0D2F4FBCB59E6C806B2EF2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aef0ef2-3017-4244-100e-08db83738b89
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 07:34:08.8491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKiJjGGQ/Yjud2JoXibi6HfnMU5dBX1jULeYRhT6kojVUi+TpYu1k18VTCYSDL+0M1UZyS6kdc2Ngk+gv2f02yBkRSCwplqIs/nF4MuJEzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7950
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldSwNCg0KT24gVHVlLCAyMDIzLTA3LTExIGF0IDExOjUwIC0wNjAwLCBNYXRoaWV1
IFBvaXJpZXIgd3JvdGU6DQo+IE9uIEZyaSwgSnVsIDA3LCAyMDIzIGF0IDAxOjI2OjA3UE0gKzA4
MDAsIFRpbmdoYW4gU2hlbiB3cm90ZToNCj4gPiBQcmV2aW91c2x5LCBTQ1AgY29yZSAwIGNvbnRy
b2xsZWQgdGhlIHBvd2VyIG9mIEwyVENNIGFuZCBkaWN0YXRlZCB0aGF0DQo+ID4gU0NQIGNvcmUg
MSBjb3VsZCBvbmx5IGJvb3QgYWZ0ZXIgU0NQIGNvcmUgMC4gVG8gYWRkcmVzcyB0aGlzIGNvbnN0
cmFpbnQsDQo+ID4gZXh0cmFjdGVkIHRoZSBwb3dlciBjb250cm9sIGZsb3cgb2YgTDJUQ00gYW5k
IG1hZGUgaXQgc2hhcmVkDQo+ID4gYmV0d2VlbiBib3RoIGNvcmVzLCBlbmFibGluZyBzdXBwb3J0
IG9mIGFyYml0cmFyeSBib290IG9yZGVyLg0KPiANCj4gRGVmaW5pdGVseSBhbiBpbXByb3ZlbWVu
dC4NCj4gDQo+ID4gDQo+ID4gVGhlIGZsb3cgZm9yIGNvbnRyb2xsaW5nIEwyVENNIHBvd2VyIGhh
cyBiZWVuIGluY29ycG9yYXRlZCBpbnRvIHRoZQ0KPiA+IG10ODE5NV9zY3BfYmVmb3JlX2xvYWQo
KSBhbmQgbXQ4MTk1X3NjcF9zdG9wKCkgQVBJcywgd2hpY2ggYXJlDQo+ID4gcmVzcGVjdGl2ZWx5
IGludm9rZWQgZHVyaW5nIHRoZSBycHJvYy0+b3BzLT5zdGFydCgpIGFuZA0KPiA+IHJwcm9jLT5v
cHMtPnN0b3AoKSBvcGVyYXRpb25zLiBUaGVzZSBBUElzIGVmZmVjdGl2ZWx5IHNlcnZlIHRoZSBz
YW1lDQo+ID4gcHVycG9zZSBhcyB0aGUgcnByb2MgcHJlcGFyZSgpL3VucHJlcGFyZSgpIEFQSXMu
Ig0KPiANCj4gSSdtIG5vdCBmb25kIG9mIHRoYXQgY3VzdG9tIEFQSSBidXQgaXQgaXMgc28gd2lk
ZXNwcmVhZCBpbiB0aGlzIGRyaXZlciB0aGF0IEkNCj4gd2lsbCBnbyB3aXRoIGl0Lg0KPiANCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaW5naGFuIFNoZW4gPHRpbmdoYW4uc2hlbkBtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcmVtb3RlcHJvYy9tdGtfY29tbW9uLmggfCAg
MSArDQo+ID4gIGRyaXZlcnMvcmVtb3RlcHJvYy9tdGtfc2NwLmMgICAgfCA4MCArKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRp
b25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9y
ZW1vdGVwcm9jL210a19jb21tb24uaCBiL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfY29tbW9uLmgN
Cj4gPiBpbmRleCA1NjM5NWU4NjY0Y2IuLjQxZTFiNDczMmI3NSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3JlbW90ZXByb2MvbXRrX2NvbW1vbi5oDQo+ID4gKysrIGIvZHJpdmVycy9yZW1vdGVw
cm9jL210a19jb21tb24uaA0KPiA+IEBAIC0xMzAsNiArMTMwLDcgQEAgc3RydWN0IG10a19zY3Ag
ew0KPiA+ICAJc3RydWN0IHJwcm9jX3N1YmRldiAqcnBtc2dfc3ViZGV2Ow0KPiA+ICANCj4gPiAg
CXN0cnVjdCBsaXN0X2hlYWQgZWxlbTsNCj4gPiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmNs
dXN0ZXJfcGRldjsNCj4gDQo+IFRoaXMgaXNuJ3QgbmVlZGVkLiAgcnByb2MtPmRldi5wYXJlbnQg
aXMgcGRldi0+ZGV2LiAgVXNlIGNvbnRhaW5lcl9vZigpIHRvDQo+IGdldCB0byB0aGUgcGxhdGZv
cm0gZGV2aWNlLiANCg0KT2ssIEknbGwgdXBkYXRlIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoN
Cj4gDQo+IA0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgLyoqDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcmVtb3RlcHJvYy9tdGtfc2NwLmMgYi9kcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jDQo+
ID4gaW5kZXggMzM0OTQ4OGU1ZjIxLi45NDYwMjI3MmMwNWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9yZW1vdGVwcm9jL210a19zY3AuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9t
dGtfc2NwLmMNCj4gPiBAQCAtMjksNiArMjksMTAgQEAgc3RydWN0IG10a19zY3Bfb2ZfY2x1c3Rl
ciB7DQo+ID4gIAlzaXplX3QgbDF0Y21fc2l6ZTsNCj4gPiAgCXBoeXNfYWRkcl90IGwxdGNtX3Bo
eXM7DQo+ID4gIAlzdHJ1Y3QgbGlzdF9oZWFkIG10a19zY3BfbGlzdDsNCj4gPiArDQo+ID4gKwkv
KiBQcmV2ZW50IGNvbmN1cnJlbnQgb3BlcmF0aW9ucyBvZiBMMlRDTSBwb3dlciBjb250cm9sLiAq
Lw0KPiA+ICsJc3RydWN0IG11dGV4IGwydGNtX2xvY2s7DQo+ID4gKwl1MzIgbDJ0Y21fcmVmY250
Ow0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgLyoqDQo+ID4gQEAgLTQ0OSw3ICs0NTMsNyBAQCBzdGF0
aWMgaW50IG10ODE5Ml9zY3BfYmVmb3JlX2xvYWQoc3RydWN0IG10a19zY3AgKnNjcCkNCj4gPiAg
DQo+ID4gIAl3cml0ZWwoMSwgc2NwLT5yZWdfYmFzZSArIE1UODE5Ml9DT1JFMF9TV19SU1ROX1NF
VCk7DQo+ID4gIA0KPiA+IC0JLyogZW5hYmxlIFNSQU0gY2xvY2sgKi8NCj4gPiArCS8qIGVuYWJs
ZSBTUkFNIHBvd2VyICovDQo+ID4gIAlzY3Bfc3JhbV9wb3dlcl9vbihzY3AtPnJlZ19iYXNlICsg
TVQ4MTkyX0wyVENNX1NSQU1fUERfMCwgMCk7DQo+ID4gIAlzY3Bfc3JhbV9wb3dlcl9vbihzY3At
PnJlZ19iYXNlICsgTVQ4MTkyX0wyVENNX1NSQU1fUERfMSwgMCk7DQo+ID4gIAlzY3Bfc3JhbV9w
b3dlcl9vbihzY3AtPnJlZ19iYXNlICsgTVQ4MTkyX0wyVENNX1NSQU1fUERfMiwgMCk7DQo+ID4g
QEAgLTQ2MiwxOSArNDY2LDM4IEBAIHN0YXRpYyBpbnQgbXQ4MTkyX3NjcF9iZWZvcmVfbG9hZChz
dHJ1Y3QgbXRrX3NjcCAqc2NwKQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4g
LXN0YXRpYyBpbnQgbXQ4MTk1X3NjcF9iZWZvcmVfbG9hZChzdHJ1Y3QgbXRrX3NjcCAqc2NwKQ0K
PiA+ICtzdGF0aWMgaW50IG10ODE5NV9zY3BfbDJ0Y21fb24oc3RydWN0IG10a19zY3AgKnNjcCkN
Cj4gPiAgew0KPiA+IC0JLyogY2xlYXIgU1BNIGludGVycnVwdCwgU0NQMlNQTV9JUENfQ0xSICov
DQo+ID4gLQl3cml0ZWwoMHhmZiwgc2NwLT5yZWdfYmFzZSArIE1UODE5Ml9TQ1AyU1BNX0lQQ19D
TFIpOw0KPiA+ICsJc3RydWN0IG10a19zY3Bfb2ZfY2x1c3RlciAqc2NwX2NsdXN0ZXIgPSBwbGF0
Zm9ybV9nZXRfZHJ2ZGF0YShzY3AtPmNsdXN0ZXJfcGRldik7DQo+ID4gKw0KPiA+ICsJbXV0ZXhf
bG9jaygmc2NwX2NsdXN0ZXItPmwydGNtX2xvY2spOw0KPiA+ICsNCj4gPiArCWlmIChzY3BfY2x1
c3Rlci0+bDJ0Y21fcmVmY250ID09IDApIHsNCj4gPiArCQkvKiBjbGVhciBTUE0gaW50ZXJydXB0
LCBTQ1AyU1BNX0lQQ19DTFIgKi8NCj4gPiArCQl3cml0ZWwoMHhmZiwgc2NwLT5yZWdfYmFzZSAr
IE1UODE5Ml9TQ1AyU1BNX0lQQ19DTFIpOw0KPiA+ICsNCj4gPiArCQkvKiBQb3dlciBvbiBMMlRD
TSAqLw0KPiA+ICsJCXNjcF9zcmFtX3Bvd2VyX29uKHNjcC0+cmVnX2Jhc2UgKyBNVDgxOTJfTDJU
Q01fU1JBTV9QRF8wLCAwKTsNCj4gPiArCQlzY3Bfc3JhbV9wb3dlcl9vbihzY3AtPnJlZ19iYXNl
ICsgTVQ4MTkyX0wyVENNX1NSQU1fUERfMSwgMCk7DQo+ID4gKwkJc2NwX3NyYW1fcG93ZXJfb24o
c2NwLT5yZWdfYmFzZSArIE1UODE5Ml9MMlRDTV9TUkFNX1BEXzIsIDApOw0KPiA+ICsJCXNjcF9z
cmFtX3Bvd2VyX29uKHNjcC0+cmVnX2Jhc2UgKyBNVDgxOTJfTDFUQ01fU1JBTV9QRE4sDQo+ID4g
KwkJCQkgIE1UODE5NV9MMVRDTV9TUkFNX1BETl9SRVNFUlZFRF9SU0lfQklUUyk7DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICsJc2NwX2NsdXN0ZXItPmwydGNtX3JlZmNudCArPSAxOw0KPiA+ICANCj4g
PiArCW11dGV4X3VubG9jaygmc2NwX2NsdXN0ZXItPmwydGNtX2xvY2spOw0KPiA+ICsNCj4gPiAr
CXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10ODE5NV9zY3BfYmVm
b3JlX2xvYWQoc3RydWN0IG10a19zY3AgKnNjcCkNCj4gPiArew0KPiA+ICAJd3JpdGVsKDEsIHNj
cC0+cmVnX2Jhc2UgKyBNVDgxOTJfQ09SRTBfU1dfUlNUTl9TRVQpOw0KPiA+ICANCj4gPiArCW10
ODE5NV9zY3BfbDJ0Y21fb24oc2NwKTsNCj4gPiArDQo+ID4gIAkvKiBlbmFibGUgU1JBTSBjbG9j
ayAqLw0KPiA+IC0Jc2NwX3NyYW1fcG93ZXJfb24oc2NwLT5yZWdfYmFzZSArIE1UODE5Ml9MMlRD
TV9TUkFNX1BEXzAsIDApOw0KPiA+IC0Jc2NwX3NyYW1fcG93ZXJfb24oc2NwLT5yZWdfYmFzZSAr
IE1UODE5Ml9MMlRDTV9TUkFNX1BEXzEsIDApOw0KPiA+IC0Jc2NwX3NyYW1fcG93ZXJfb24oc2Nw
LT5yZWdfYmFzZSArIE1UODE5Ml9MMlRDTV9TUkFNX1BEXzIsIDApOw0KPiA+IC0Jc2NwX3NyYW1f
cG93ZXJfb24oc2NwLT5yZWdfYmFzZSArIE1UODE5Ml9MMVRDTV9TUkFNX1BETiwNCj4gPiAtCQkJ
ICBNVDgxOTVfTDFUQ01fU1JBTV9QRE5fUkVTRVJWRURfUlNJX0JJVFMpOw0KPiA+ICAJc2NwX3Ny
YW1fcG93ZXJfb24oc2NwLT5yZWdfYmFzZSArIE1UODE5Ml9DUFUwX1NSQU1fUEQsIDApOw0KPiA+
ICANCj4gPiAgCS8qIGVuYWJsZSBNUFUgZm9yIGFsbCBtZW1vcnkgcmVnaW9ucyAqLw0KPiA+IEBA
IC00ODcsNiArNTEwLDggQEAgc3RhdGljIGludCBtdDgxOTVfc2NwX2MxX2JlZm9yZV9sb2FkKHN0
cnVjdCBtdGtfc2NwICpzY3ApDQo+ID4gIHsNCj4gPiAgCXNjcC0+ZGF0YS0+c2NwX3Jlc2V0X2Fz
c2VydChzY3ApOw0KPiA+ICANCj4gPiArCW10ODE5NV9zY3BfbDJ0Y21fb24oc2NwKTsNCj4gPiAr
DQo+ID4gIAlzY3Bfc3JhbV9wb3dlcl9vbihzY3AtPnJlZ19iYXNlICsgTVQ4MTk1X0NQVTFfU1JB
TV9QRCwgMCk7DQo+ID4gIA0KPiA+ICAJLyogZW5hYmxlIE1QVSBmb3IgYWxsIG1lbW9yeSByZWdp
b25zICovDQo+ID4gQEAgLTY1MywxNCArNjc4LDMwIEBAIHN0YXRpYyB2b2lkIG10ODE5Ml9zY3Bf
c3RvcChzdHJ1Y3QgbXRrX3NjcCAqc2NwKQ0KPiA+ICAJd3JpdGVsKDAsIHNjcC0+cmVnX2Jhc2Ug
KyBNVDgxOTJfQ09SRTBfV0RUX0NGRyk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3N0YXRpYyB2b2lk
IG10ODE5NV9zY3BfbDJ0Y21fb2ZmKHN0cnVjdCBtdGtfc2NwICpzY3ApDQo+ID4gK3sNCj4gPiAr
CXN0cnVjdCBtdGtfc2NwX29mX2NsdXN0ZXIgKnNjcF9jbHVzdGVyID0gcGxhdGZvcm1fZ2V0X2Ry
dmRhdGEoc2NwLT5jbHVzdGVyX3BkZXYpOw0KPiA+ICsNCj4gPiArCW11dGV4X2xvY2soJnNjcF9j
bHVzdGVyLT5sMnRjbV9sb2NrKTsNCj4gPiArDQo+IA0KPiBXaGF0IGhhcHBlbnMgaWYgLT5sMnRj
bV9yZWZjbnQgaXMgMCBhbmQgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQ/DQoNClRoYW5rcywgSSds
bCBjaGVjayB0aGlzIGNvbmRpdGlvbiBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQoNCkJlc3QgcmVn
YXJkcywNClRpbmdIYW4uDQoNCj4gDQo+IA0KPiA+ICsJc2NwX2NsdXN0ZXItPmwydGNtX3JlZmNu
dCAtPSAxOw0KPiA+ICsNCj4gPiArCWlmIChzY3BfY2x1c3Rlci0+bDJ0Y21fcmVmY250ID09IDAp
IHsNCj4gPiArCQkvKiBQb3dlciBvZmYgTDJUQ00gKi8NCj4gPiArCQlzY3Bfc3JhbV9wb3dlcl9v
ZmYoc2NwLT5yZWdfYmFzZSArIE1UODE5Ml9MMlRDTV9TUkFNX1BEXzAsIDApOw0KPiA+ICsJCXNj
cF9zcmFtX3Bvd2VyX29mZihzY3AtPnJlZ19iYXNlICsgTVQ4MTkyX0wyVENNX1NSQU1fUERfMSwg
MCk7DQo+ID4gKwkJc2NwX3NyYW1fcG93ZXJfb2ZmKHNjcC0+cmVnX2Jhc2UgKyBNVDgxOTJfTDJU
Q01fU1JBTV9QRF8yLCAwKTsNCj4gPiArCQlzY3Bfc3JhbV9wb3dlcl9vZmYoc2NwLT5yZWdfYmFz
ZSArIE1UODE5Ml9MMVRDTV9TUkFNX1BETiwgMCk7DQo+ID4gKwkJc2NwX3NyYW1fcG93ZXJfb2Zm
KHNjcC0+cmVnX2Jhc2UgKyBNVDgxOTJfQ1BVMF9TUkFNX1BELCAwKTsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwltdXRleF91bmxvY2soJnNjcF9jbHVzdGVyLT5sMnRjbV9sb2NrKTsNCj4gPiArfQ0K
PiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgbXQ4MTk1X3NjcF9zdG9wKHN0cnVjdCBtdGtfc2NwICpz
Y3ApDQo+ID4gIHsNCj4gPiAtCS8qIERpc2FibGUgU1JBTSBjbG9jayAqLw0KPiA+IC0Jc2NwX3Ny
YW1fcG93ZXJfb2ZmKHNjcC0+cmVnX2Jhc2UgKyBNVDgxOTJfTDJUQ01fU1JBTV9QRF8wLCAwKTsN
Cj4gPiAtCXNjcF9zcmFtX3Bvd2VyX29mZihzY3AtPnJlZ19iYXNlICsgTVQ4MTkyX0wyVENNX1NS
QU1fUERfMSwgMCk7DQo+ID4gLQlzY3Bfc3JhbV9wb3dlcl9vZmYoc2NwLT5yZWdfYmFzZSArIE1U
ODE5Ml9MMlRDTV9TUkFNX1BEXzIsIDApOw0KPiA+IC0Jc2NwX3NyYW1fcG93ZXJfb2ZmKHNjcC0+
cmVnX2Jhc2UgKyBNVDgxOTJfTDFUQ01fU1JBTV9QRE4sDQo+ID4gLQkJCSAgIE1UODE5NV9MMVRD
TV9TUkFNX1BETl9SRVNFUlZFRF9SU0lfQklUUyk7DQo+ID4gKwltdDgxOTVfc2NwX2wydGNtX29m
ZihzY3ApOw0KPiA+ICsNCj4gPiAgCXNjcF9zcmFtX3Bvd2VyX29mZihzY3AtPnJlZ19iYXNlICsg
TVQ4MTkyX0NQVTBfU1JBTV9QRCwgMCk7DQo+ID4gIA0KPiA+ICAJLyogRGlzYWJsZSBTQ1Agd2F0
Y2hkb2cgKi8NCj4gPiBAQCAtNjY5LDYgKzcxMCw4IEBAIHN0YXRpYyB2b2lkIG10ODE5NV9zY3Bf
c3RvcChzdHJ1Y3QgbXRrX3NjcCAqc2NwKQ0KPiA+ICANCj4gPiAgc3RhdGljIHZvaWQgbXQ4MTk1
X3NjcF9jMV9zdG9wKHN0cnVjdCBtdGtfc2NwICpzY3ApDQo+ID4gIHsNCj4gPiArCW10ODE5NV9z
Y3BfbDJ0Y21fb2ZmKHNjcCk7DQo+ID4gKw0KPiA+ICAJLyogUG93ZXIgb2ZmIENQVSBTUkFNICov
DQo+ID4gIAlzY3Bfc3JhbV9wb3dlcl9vZmYoc2NwLT5yZWdfYmFzZSArIE1UODE5NV9DUFUxX1NS
QU1fUEQsIDApOw0KPiA+ICANCj4gPiBAQCAtOTc2LDYgKzEwMTksOCBAQCBzdGF0aWMgaW50IHNj
cF9hZGRfc2luZ2xlX2NvcmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCWlm
IChJU19FUlIoc2NwKSkNCj4gPiAgCQlyZXR1cm4gUFRSX0VSUihzY3ApOw0KPiA+ICANCj4gPiAr
CXNjcC0+Y2x1c3Rlcl9wZGV2ID0gcGRldjsNCj4gPiArDQo+ID4gIAlyZXQgPSBycHJvY19hZGQo
c2NwLT5ycHJvYyk7DQo+ID4gIAlpZiAocmV0KSB7DQo+ID4gIAkJZGV2X2VycihkZXYsICJGYWls
ZWQgdG8gYWRkIHJwcm9jXG4iKTsNCj4gPiBAQCAtMTAyOCw2ICsxMDczLDggQEAgc3RhdGljIGlu
dCBzY3BfYWRkX211bHRpX2NvcmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAg
CQkJZ290byBpbml0X2ZhaWw7DQo+ID4gIAkJfQ0KPiA+ICANCj4gPiArCQlzY3AtPmNsdXN0ZXJf
cGRldiA9IHBkZXY7DQo+ID4gKw0KPiA+ICAJCXJldCA9IHJwcm9jX2FkZChzY3AtPnJwcm9jKTsN
Cj4gPiAgCQlpZiAocmV0KSB7DQo+ID4gIAkJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFkZCBy
cHJvYyBvZiBjb3JlICVkXG4iLCBjb3JlX2lkKTsNCj4gPiBAQCAtMTExNCw2ICsxMTYxLDcgQEAg
c3RhdGljIGludCBzY3BfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAg
CX0NCj4gPiAgDQo+ID4gIAlJTklUX0xJU1RfSEVBRCgmc2NwX2NsdXN0ZXItPm10a19zY3BfbGlz
dCk7DQo+ID4gKwltdXRleF9pbml0KCZzY3BfY2x1c3Rlci0+bDJ0Y21fbG9jayk7DQo+ID4gIAlw
bGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBzY3BfY2x1c3Rlcik7DQo+ID4gIA0KPiA+ICAJcmV0
ID0gZGV2bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZShkZXYpOw0KPiA+IEBAIC0xMTM3LDYgKzExODUs
OCBAQCBzdGF0aWMgdm9pZCBzY3BfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4gIAkJcnByb2NfZGVsKHNjcC0+cnByb2MpOw0KPiA+ICAJCXNjcF9mcmVlKHNjcCk7DQo+
ID4gIAl9DQo+ID4gKw0KPiA+ICsJbXV0ZXhfZGVzdHJveSgmc2NwX2NsdXN0ZXItPmwydGNtX2xv
Y2spOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zY3Bfb2Zf
ZGF0YSBtdDgxODNfb2ZfZGF0YSA9IHsNCj4gPiAtLSANCj4gPiAyLjE4LjANCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpUaW5nSGFuDQo=
