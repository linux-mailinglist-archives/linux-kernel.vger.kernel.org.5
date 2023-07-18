Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284B2757315
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGRFTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGRFTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:19:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2047.outbound.protection.outlook.com [40.107.215.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167E2199;
        Mon, 17 Jul 2023 22:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPJK7/45Er9NwMnueUX/A5jSc0+dInkLR/qdDAY+s6x2ZfO/pxyCai8jZ7COxMgf5EfWuLGz7YUE8PasRp+NAEoZB9DkWU+ZnJJ+XDNfUnxMBS2EeEUW25zejs1hkwxZ8C07vMl7hEKdKY2b7HdSZZF2Z7ziVshKbS4nO7/fUksS44UBorpR7WbVG69vRwNoZfdO8EweZpjB+EURdXNBYqIxFBuOehS69T3v5hp4iFNyuiotZ+MdH7hDit1pAVY/3bCghrJw8xOqNSWFKGBl4y2xKlyJXz3byG14wpasLHe7w4Efjpvm42vnl6hr9IzzBhK04rUw3YtjWYA/BiSp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtmwA4CibYPr1aqkU5Y9tr49aFuSZIlpXnywhm3cFsY=;
 b=TdHMfUgvjudAKB2bIcDo1w1npTyXQF+JVzU8FFFJ6S2OvbZ03KUtyyl1hBCrWJkh9ZHX5qZp+2zhgtZSf4+o8NYHatEYjK8qoxhGxHrPKlx7PpybwKYiyl4nydwFBBykbfXfUwPgoeCteH/fnRNGaGWYsTQqgX0m5n+UfpgqCg4PboIZjC8TwWzMfxTMW4wy9l9lwy81PGW9gmEZCm97nF7eLxXjpsZNwHsMlcImqFlyZWWTNn/UHAyn3PC7HLUn7YQp7cSp/xO6HbnO2CsyGQENXqCOfHTIJvGB19vQ6jk7cd8vQhO6IEleKM/g8G0uq794PjsG82mnU33ri/z8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtmwA4CibYPr1aqkU5Y9tr49aFuSZIlpXnywhm3cFsY=;
 b=Pz1ENSh1CnDzhfuCunUOOed8/nkwS2c26Spe/NVE2RbRXtUc3m89KdFBAzo76gcvu0dZcPoLeHVHPcPhK1JzWMiiy40cEFI8rQwl8jMRNNe+izLy/qN1tKHKDZiYMKGzssWzGDU1BZtInZarhmh4utxr87LTef2/Jc5LlL91RMG/Es8QYdmc4i1DPjbULbbJu9AwE49DLWttZTITSP8+yJzAvbaw7duvAqqzxrmFcByJWhmwyCEPt8RPPXGV2BBT1ErsuBBKCRp585RkFoe7a2xp3DVw0IrSMZ1flq/uNEFieJaRYQKObSaftfhrIjYxnAd6UedmbY9Co43pi8h5NQ==
Received: from PS2PR04MB3592.apcprd04.prod.outlook.com (2603:1096:300:61::21)
 by KL1PR04MB7134.apcprd04.prod.outlook.com (2603:1096:820:fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 05:19:41 +0000
Received: from PS2PR04MB3592.apcprd04.prod.outlook.com
 ([fe80::c49b:a607:6c17:a90f]) by PS2PR04MB3592.apcprd04.prod.outlook.com
 ([fe80::c49b:a607:6c17:a90f%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 05:19:40 +0000
From:   Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
 Yosemite V4 BMC
Thread-Topic: [PATCH v2 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
 Yosemite V4 BMC
Thread-Index: AQHZtfvbsLPhRavEI0WpXdZKuK1E1a+4pxCAgASQ63A=
Date:   Tue, 18 Jul 2023 05:19:40 +0000
Message-ID: <PS2PR04MB3592631E9B38B642A3E38B38B738A@PS2PR04MB3592.apcprd04.prod.outlook.com>
References: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
 <20230714023502.3225096-1-Delphine_CC_Chiu@wiwynn.com>
 <20230714023502.3225096-3-Delphine_CC_Chiu@wiwynn.com>
 <0e6e32db-40e1-aa9f-fc05-20f2c5bf544d@linaro.org>
In-Reply-To: <0e6e32db-40e1-aa9f-fc05-20f2c5bf544d@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR04MB3592:EE_|KL1PR04MB7134:EE_
x-ms-office365-filtering-correlation-id: 3224ae80-7068-4358-b62b-08db874e96c0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yhE4Iprkz/a/tTv6PsYPA468lyUQLzuYFuAoaBzNlam2OSNRVbs+5I2YX1StvWgfnoAISjWHZmFEH3hFM6u7DkpfQcOiv5M9MOIcdz+YoA8Ag5ery9TT8NWdJHdpJDzVRJpVr/n4fLaogJkqkOglJHRnGvIDPDqRTG6dFU3eqTa6PdYzjG4eM+8N9B2pOlb3qgcvZwsWb+QncX1Y+m9tBZKwAgUiDNToxubwvunTlcF59pY2ZxDmzI3rMu7KeWnxeLLC90i5kHQUG6FIEYy2F3UE1ZnwNbAWUXQFpZC9wzSq88EuCkHHrFzKVEAh5hxpRtbtgtAVr9pCMPCl3iItOBPAevfBBoWnUNMsVNenVw/SD5PbY7iwOcc0vQv99/Qf2s3inplEXLrSW2Temqe1qnt9e6XUhk60rMiPJ+QUWZQnISImosJrI3KcMN/OlKQmuVnv45dqd7qYjSVMJWNDAugR3jpTukBQMLksq4PPgH+hSGK0Ohz7Kru2pcFxZ3fe76ALmYJ8nBU8cKHZStJNbaIo8LC1etAMKmRGoHnJC8dy2p4mUi4LJ8wsrOl/9Mk21dvWQsfmdFYqQnq3HkpZWww7eRcIK3IPigz0RPTubVxC5A6lMhT7EL4eb3r8ZEvgg4ZdWlHisq0T2ak6qxCJmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR04MB3592.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(47680400002)(451199021)(76116006)(7416002)(86362001)(2906002)(33656002)(38070700005)(55016003)(83380400001)(186003)(6506007)(9686003)(26005)(53546011)(921005)(7696005)(38100700002)(54906003)(110136005)(122000001)(66446008)(4326008)(66946007)(66476007)(64756008)(66556008)(71200400001)(5660300002)(478600001)(316002)(52536014)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFNnQUdXWUE3bTJUTlo1V3NQKzArY1dtQmN3eW1tMWdvRkYxekp3Z3pGVjBM?=
 =?utf-8?B?b2tzTHdFb2F5Yk1ucHMzOFVNSndyY3ZkdTAwQzVvZDNjRy9icXFYTUpHNmJr?=
 =?utf-8?B?eFhJd2RWUmE3UDFsY1NUR0l4K0xDNVZoa0hlbTk2blduaDBSNUlSU3d6TGYr?=
 =?utf-8?B?TWRiMWozMmt3dWxFZkFNamVOeFgrUmtaWC9Jd1I1T0hrdWNmd2NrVVlZSGRQ?=
 =?utf-8?B?WDVQWFM4MmhOa284UmJtVmw5Y09qOWhpTjFBUTl4blRrOHlvMTFVVFB3UmVK?=
 =?utf-8?B?alZoaHdpb3ZNdjdSTTQwV1hTTGgzdUpQNkJsVnBGVUo0K2lubXBqUVBpdW9U?=
 =?utf-8?B?L3krZWJQemdSZ3pCa21WQ0ZMMDBlOXFDZEtQRGRmTDRLendpbzFiYmtNcFZN?=
 =?utf-8?B?dFZHa0dxalU3TWw1U1Zkcmp3clpEZmFEc3FTZmJhMlVpTGxGU2lvcjBuaE5O?=
 =?utf-8?B?SjZJb08yNUlnaTFFZExrLzlrVUhQZVdwODh0cmZSUy9ZMWhVOUorQ1F5MHNY?=
 =?utf-8?B?V29yWFpwNXp5bEZKMGhNdUF5SzNDWDMybDhzOGNOK3YzVVZ1Z2lyS0J5aDcr?=
 =?utf-8?B?NG50SE9OcWNLbEhsM25ldjdXV0tPdm9Rc2pJMks0TTlpTFJwNlpRUzc1MWIz?=
 =?utf-8?B?VlZRN3ZLdFZMZlpKNlR1eG5iejdXM044c0ZyM3NlcmpUQ0VWUjJYRkpab0JD?=
 =?utf-8?B?dTc2WDhHdlYwZThHaXpnOUZhWjJiUzFLaHBMQjAxdSswWEt6MURyZndSRjcz?=
 =?utf-8?B?K3JMbzdiSWdsU0JLamNkSytVZmlnbkk2VGJjQ0M1QnJiWUtxNEZwSktrYTl0?=
 =?utf-8?B?K0xBb0N6cnZGRVRudmVTYnN5b1hYK2VpZC9IRUdYZWlNUFFKTHNVblk3aDdX?=
 =?utf-8?B?MjJjMWNORTRDQ05tNnRmSmxSZHpyVEp1SlZLQXRtVmhGYzR5M1M5MlNySHdC?=
 =?utf-8?B?b213ODlodGJDKzQ2QjRGR3NwUnBZT0loNXk1bjd2SC9HSy94d1V1L3ZWOTc2?=
 =?utf-8?B?Z0pyNVBlUnlWZmc1a0tVQTB3Q2hrZ1ZvSnFxaWVPc01MV3lJK1hiUUl3Ty81?=
 =?utf-8?B?RUs0OHZrTExFSUo5QUNaczI0dEFHVkl6SzExMUdHSGhPeHRBbVJ4Z0FqY08y?=
 =?utf-8?B?c1BlNUVkd3lDc2wrTTM5c0MyRDBFdElBakZBSXdmOEZFYkV3M2RiUGdRM3la?=
 =?utf-8?B?WXc1c2RURktialdxdXpvblhLQVc0NWFyeWd5dlZ4cWJuR3BYSHVJc1o0YXlB?=
 =?utf-8?B?MVk2UlhrTDVaT3YrR1ZwUW44ZzBoUU9qNm51Vjk1TTd1bGRzUDJyL3drSjlN?=
 =?utf-8?B?bVdBWjFWaHJRaURjRVZ6M1BGWlMzV0ZMUFp0VWpXWCtlREVFSzVTMFVpUThO?=
 =?utf-8?B?ODBSWCtQTjR4UDVzbWhaN2tUeWlTaCs5Y2piV1VMTmEzYmlZRDhVRGVnMVpt?=
 =?utf-8?B?Y3VkWkdJWndEZWVqdmxCUkxkUWFmbUdFYWdJUGVvYUU1SWtRbmhMNHFxS29r?=
 =?utf-8?B?bkVpOXhvM2lRQzltMFdQeWpiMmY5c2dLMTVyR2N5QlM0T0tSZ3BLRVJGbmh5?=
 =?utf-8?B?Vk5oRytVY1B5WDhpYm1LSGVja2JDakZaRGJTUUdrek8wWGlzYnNLZHlUWkNX?=
 =?utf-8?B?NXgzVWh5TmlkZ0oyblBXMFhrTVcwT2taSHhpdjhVQ2hxc3Y5ZThwMDlTMWpZ?=
 =?utf-8?B?cW9WWEE1SFRYcjkxaUkzZEh6MWlCZWtSM1RSNzc1VmFsemxmQS9YZlB6bFRs?=
 =?utf-8?B?SUF1QTlBWGlka1BydmkrYk8zcS9WSk5INlJPMU5DeHg0NTBhaitHQVdaTlE5?=
 =?utf-8?B?UmFydTRtVVBsTHF2czZrdFBTdk10OW5QVFBrTDI0Nng1elArMk9jMko4Z09I?=
 =?utf-8?B?M1d0N1YwekdoeklkalBTZUpNRGJIaWZBQ1RVNGRuVnVES0llZjhUQzg5b3Zw?=
 =?utf-8?B?emhjWmZYQ0oxTWRvM2lJL2R4alJTa091cms1cFV0bEZaSmczeldpUWxpbE9w?=
 =?utf-8?B?eUZqUmlsMXQxQ2FnT3d0WEhnbWlqSHBCSjFmOWN3U21LbTFtWkdGN1JIaGli?=
 =?utf-8?B?ZzNmZ1J5dS9zTUxsazlXNGptOTExNVVKTU5PdUpxa0Nld0kyVHpRcFBPVkZn?=
 =?utf-8?Q?uRIU1DIduy0pxReUBoGEoZVTL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR04MB3592.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3224ae80-7068-4358-b62b-08db874e96c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 05:19:40.9237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ve910NsuOtujws9mgn1sh99bGYmQDc4eFWK99NVzJFlxwVpO0MT2L67fZi5qjAFSTkb8PHZ4YZNNiZj4aH0n9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1
bHkgMTQsIDIwMjMgMTI6MTMgUE0NCj4gVG86IERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4g
PERlbHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNvbT47DQo+IHBhdHJpY2tAc3R3Y3gueHl6OyBBcm5k
IEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgT2xvZiBKb2hhbnNzb24NCj4gPG9sb2ZAbGl4b20u
bmV0Pjsgc29jQGtlcm5lbC5vcmc7IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Ow0K
PiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+
OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5sZXkgPGpv
ZWxAam1zLmlkLmF1PjsgQW5kcmV3IEplZmZlcnkNCj4gPGFuZHJld0Bhai5pZC5hdT4NCj4gQ2M6
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSBBUk06IGR0czog
YXNwZWVkOiB5b3NlbWl0ZXY0OiBhZGQgRmFjZWJvb2sNCj4gWW9zZW1pdGUgVjQgQk1DDQo+IA0K
PiAgIFNlY3VyaXR5IFJlbWluZGVyOiBQbGVhc2UgYmUgYXdhcmUgdGhhdCB0aGlzIGVtYWlsIGlz
IHNlbnQgYnkgYW4gZXh0ZXJuYWwNCj4gc2VuZGVyLg0KPiANCj4gT24gMTQvMDcvMjAyMyAwNDoz
NSwgRGVscGhpbmUgQ0MgQ2hpdSB3cm90ZToNCj4gPiBBZGQgbGludXggZGV2aWNlIHRyZWUgZW50
cnkgcmVsYXRlZCB0byBZb3NlbWl0ZSBWNCBzcGVjaWZpYyBkZXZpY2VzDQo+ID4gY29ubmVjdGVk
IHRvIEJNQyBTb0MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEZWxwaGluZSBDQyBDaGl1IDxE
ZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3Qv
ZHRzL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIC4uLi9kdHMvYXNw
ZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0ZXY0LmR0cyAgICB8IDU3Nw0KPiArKysrKysrKysrKysr
KysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1NzggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVh
dGUgbW9kZSAxMDA2NDQNCj4gPiBhcmNoL2FybS9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29r
LXlvc2VtaXRldjQuZHRzDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
TWFrZWZpbGUgYi9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQ0KPiA+IGluZGV4IDU5ODI5ZmM5
MDMxNS4uODcxZTZkMjcxMjYyIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL01h
a2VmaWxlDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4gPiBAQCAtMTYz
MSw2ICsxNjMxLDcgQEAgZHRiLSQoQ09ORklHX0FSQ0hfQVNQRUVEKSArPSBcDQo+ID4gICAgICAg
YXNwZWVkLWJtYy1mYWNlYm9vay1nYWxheHkxMDAuZHRiIFwNCj4gPiAgICAgICBhc3BlZWQtYm1j
LWZhY2Vib29rLWdyZWF0bGFrZXMuZHRiIFwNCj4gPiAgICAgICBhc3BlZWQtYm1jLWZhY2Vib29r
LW1pbmlwYWNrLmR0YiBcDQo+ID4gKyAgICAgYXNwZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0ZXY0
LmR0YiBcDQo+ID4gICAgICAgYXNwZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRiIFwNCj4g
PiAgICAgICBhc3BlZWQtYm1jLWZhY2Vib29rLXdlZGdlNDAuZHRiIFwNCj4gPiAgICAgICBhc3Bl
ZWQtYm1jLWZhY2Vib29rLXdlZGdlMTAwLmR0YiBcIGRpZmYgLS1naXQNCj4gPiBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGV2NC5kdHMNCj4gPiBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGV2NC5kdHMNCj4gPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uY2ZlNDgzOGZhZTVhDQo+
ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMt
ZmFjZWJvb2steW9zZW1pdGV2NC5kdHMNCj4gPiBAQCAtMCwwICsxLDU3NyBAQA0KPiA+ICsvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAvLyBDb3B5cmlnaHQgMjAy
Mg0KPiA+ICtGYWNlYm9vayBJbmMuDQo+ID4gKw0KPiA+ICsvZHRzLXYxLzsNCj4gPiArI2luY2x1
ZGUgImFzcGVlZC1nNi5kdHNpIg0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9hc3Bl
ZWQtZ3Bpby5oPiAjaW5jbHVkZQ0KPiA+ICs8ZHQtYmluZGluZ3MvbGVkcy9sZWRzLXBjYTk1NXgu
aD4NCj4gPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2kyYy9pMmMuaD4NCj4gPiArDQo+ID4gKy8g
ew0KPiA+ICsgICAgIG1vZGVsID0gIkZhY2Vib29rIFlvc2VtaXRlIFY0IEJNQyI7DQo+ID4gKyAg
ICAgY29tcGF0aWJsZSA9ICJmYWNlYm9vayx5b3NlbWl0ZXY0LWJtYyIsICJhc3BlZWQsYXN0MjYw
MCI7DQo+ID4gKw0KPiA+ICsgICAgIGFsaWFzZXMgew0KPiA+ICsgICAgICAgICAgICAgc2VyaWFs
NCA9ICZ1YXJ0NTsNCj4gPiArICAgICAgICAgICAgIHNlcmlhbDUgPSAmdWFydDY7DQo+ID4gKyAg
ICAgICAgICAgICBzZXJpYWw2ID0gJnVhcnQ3Ow0KPiA+ICsgICAgICAgICAgICAgc2VyaWFsNyA9
ICZ1YXJ0ODsNCj4gPiArICAgICAgICAgICAgIHNlcmlhbDggPSAmdWFydDk7DQo+ID4gKyAgICAg
fTsNCj4gPiArDQo+ID4gKyAgICAgY2hvc2VuIHsNCj4gPiArICAgICAgICAgICAgIGJvb3Rhcmdz
ID0gImNvbnNvbGU9dHR5UzQsNTc2MDBuOCI7DQo+IA0KPiBOb3RoaW5nIGltcHJvdmVkLCBzbyB5
b3UganVzdCBpZ25vcmVkIGVudGlyZSBmZWVkYmFjayBhbmQgcmVzZW50IHRoZSBzYW1lLg0KSSBs
b3N0IHN0ZG91dC1wYXRoIGZlZWRiYWNrLCBzbyBJJ2xsIHJldmlzZSB0byBmb2xsb3dpbmcgZm9y
bWF0IGluIG5leHQgdmVyc2lvbiBjb250cmlidXRlOg0KY2hvc2VuIHsNCiAgICAgICAgICAgICAg
IHN0ZG91dC1wYXRoID0gInNlcmlhbDQ6NTc2MDBuOCI7DQogICAgICB9Ow0KDQpBcyBmb3JtZXIg
ZmVlZGJhY2sgbWVudGlvbmVkLCBJIGFsc28gcmV2aXNlIHRoZSBpMmMgZGV2aWNlIG5vZGUgbmFt
ZXMgYnkgcmVmZXJlbmNpbmcgRFQgc3BlY2lmaWNhdGlvbi4NClRoZSBvbmx5IG5vZGUgbmFtZSBJ
IHVzZWQgdGhhdCBub3Qgb24gdGhlIGxpc3QgaXMgInBvd2VyLXNlbnNvciIsDQp3aGljaCBpcyBm
b2xsb3dpbmcgdGhlIGV4YW1wbGUgdW5kZXIgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzLg0KDQpNb3N0IG9mIHRoZSBvdGhlciBwYXJ0aXRpb24gaW4gRFRTIGlzIHNhbWUgYXMgdGhl
IHJlY2VudC1jb250cmlidXRlZCBwcm9qZWN0Lg0KV291bGQgeW91IHBsZWFzZSB0byB0ZWxsIGlm
IHRoZXJlJ3Mgc3RpbGwgc29tZSBvbWlzc2lvbnMgSSBtYWRlLg0KVGhhbmsgeW91IGZvciByZXZp
ZXdpbmcuDQo+IA0KPiBTb3JyeSwgdGhhdCdzIG5vdCBob3cgcmVzcG9uZGluZyB0byBmZWVkYmFj
ayB3b3Jrcy4NCj4gDQo+IE5BSw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
