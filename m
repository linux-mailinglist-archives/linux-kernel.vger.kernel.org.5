Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2440076FE1E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjHDKHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjHDKGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:06:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072.outbound.protection.outlook.com [40.107.215.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8121C4EDD;
        Fri,  4 Aug 2023 03:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXmwP0otyt/Wkj7C9vbsBq9QmS59SM8T+ebx8dD1W+oFj7IWpfE8J1O37BaRV7eP6he7951C71Oe3tQy06OgLnVsk68vTx0RjY18sLvN2sT33oV6o/ELl5bkQ0FfqXwguNfYNGeU+xDZzot2hUEPktoG2OH/PcLhn5wrjqk+Z4m9W03xeVVGBRb+CkjEdpKBOuS5HdNLLrStZYSWQ6G9uqY5CxVE9rOZJg75rYZZQXkIERHM5DjoeCq580NNhCprxGv9B8ND5E4XLvB6k6T50sEM5WTb8tA11/40bEq2d3rplBmaLCGJ5iwgnx9iD4RvjChmuMNWlGSsVgzX3UpsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QE91eFotxsDMpY1gIbcn2ZhTaUz2EreQA7dMoY1yEw=;
 b=WyxO6vbBBSuUDEpLY0eQy3XpkDYbL91N031N7DZUEwM/Gn8P+UKLqVM0rFQsUXc2kHspaL4SiRKlo3Sm/0A/6MiP2VGOViMv/jY4cCWdhFg8XC2lUbZvXMMmLFoanLm8Xdnd5kFkKoUxClZvTH2KIrQVYUkKsj+fCRH0rjiSF3TO1sbn47Oo2fbEk/lnZVrTjdApyVNa8dOUOp9VgTHv9Bs9u2kBM67sCa/i+FlLFyctkdTexTTqo4L6rpsOBubSMcdIzbnz2cAfu/qhmjADwfek3bcrS5V0sp7H1M5ab6RVdtSWWvQo712o9ON2m1kq+buN7FkXpvJ9C4+fu5mr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QE91eFotxsDMpY1gIbcn2ZhTaUz2EreQA7dMoY1yEw=;
 b=OufVkg2TfhKibFTavfgs1cotH/zZKU60evRU+SR1zYCB5giM0I2gwXicmzOrOiBKoAfCDW/f/V4sjkHu6VJQzeujIWkN7if28ZIZ22SaaLq6INnbWTB8W3kKq0Ex3MF2Rn230u8PbD7JCrfpqExT6Qv/u2xhNxpEjaSf4wuO4SfE0v5VHXKZXTUaC87rsDAlrtCPP5GVshAEHLc3bn3Po3Qud+iaF7B7MSDKkld0BulNrP4k9ZgaPG/0ElYHj9qIEtFzk/Cbjv9fEHcaP4S/mVyyeed9S1pgcHmodApu7J5svceYvQtdNz53WZbC/2Qos2QqHaaiFksTWwO91zO+xA==
Received: from PS2PR04MB3592.apcprd04.prod.outlook.com (2603:1096:300:61::21)
 by TYUPR04MB6672.apcprd04.prod.outlook.com (2603:1096:400:35d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 10:06:33 +0000
Received: from PS2PR04MB3592.apcprd04.prod.outlook.com
 ([fe80::60cf:9db2:83b5:dae]) by PS2PR04MB3592.apcprd04.prod.outlook.com
 ([fe80::60cf:9db2:83b5:dae%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 10:06:33 +0000
From:   Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite V4
 board
Thread-Topic: [PATCH 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite V4
 board
Thread-Index: AQHZwDvz7mf7a/3GTUmfLqehWY+O4a/NLF2AgAkkwmCAAiWmgIABe0Dw
Date:   Fri, 4 Aug 2023 10:06:33 +0000
Message-ID: <PS2PR04MB3592CBAB0B248418D80C67ECB709A@PS2PR04MB3592.apcprd04.prod.outlook.com>
References: <20230727033926.1904529-1-Delphine_CC_Chiu@wiwynn.com>
 <c9062d5c-b536-f89c-b380-8a0c9b858526@linaro.org>
 <PS2PR04MB35928B386F03C987061433D2B70BA@PS2PR04MB3592.apcprd04.prod.outlook.com>
 <9654ac64-11c6-9fae-0e8d-feb6440dd45c@linaro.org>
In-Reply-To: <9654ac64-11c6-9fae-0e8d-feb6440dd45c@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR04MB3592:EE_|TYUPR04MB6672:EE_
x-ms-office365-filtering-correlation-id: f228bcc8-79bf-4feb-b4ad-08db94d27b29
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +iCFDAtUCWEXxgJ3JBLpO6vAH/puda+NJ8r/472DJOkZv5wwzBs3z4fURAAxqgrUtMwYpp+qMH0LhSpIyj+AfOSwb4CGKlzhzSvjVitWC6elZs+NRA0Ec59PHcFMQqgt2/Sv2DXAKAuWTHHHep/ewYSouM5KXqhyGlBQv0MxkicAylnEbZaqG2gwRm272xZysnKAopvDYB9iQ6Nl53cboQKUD0M2NMyD/3elTRNDTFa0870NaGg7Szgi8dgEBUyglOhvBkJeJH+nsToJQGBHWJbpyprVc8BgxsljD2nI1n4CXvIHRaMeDPRX8mgNt6vNxGq5T+soJSLUyOvEcsG4dplj0jEBQgdqgo28tV0sYD0mQzKtiFzjlVwwY3qwDFOsyiehZFf6ol5CMuuG3/t4syoT1Ibp2YKEmNP/0zhmJb6Bpk4FYu2my0+GErrvjyQtg5melyfozhDF+wsJSZpGHwxJye0aqlt+OkqPoorpBKsdc8iCm2umPJYWxdIXPV8EIzOAdDDYYeYXQt0ur5nEv0VSYU67dRs530bSYZHvyDfwOuTNdP3HiRYt8fYIY8+e9vWY1ql7rSy3vggJlb+goKJrrIoMM1xMiDNCEdkbWrgvah/BBggT+fuClMiP1b2F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR04MB3592.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(47680400002)(451199021)(1800799003)(186006)(66446008)(66556008)(41300700001)(316002)(2906002)(76116006)(66946007)(64756008)(4326008)(66476007)(52536014)(8936002)(8676002)(5660300002)(122000001)(33656002)(26005)(38070700005)(6506007)(53546011)(83380400001)(86362001)(38100700002)(7696005)(478600001)(9686003)(54906003)(71200400001)(110136005)(55016003)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1drVWpXSmVJcVlvZk9TdTZwdFZhVGEzclVod015Q09FL3QxYjhLTnVIM0sv?=
 =?utf-8?B?YWtUcGFxeW1OMDA0UHBNaE5saGJqeVlVdTM5OXFwZFQ0WGppQUptK3l3dTVj?=
 =?utf-8?B?dkFkODNZa2tKSm9ndHRGeXFmZEtja0FRT2dENjk1VHZZRDFzeU9mb1NDdUJT?=
 =?utf-8?B?R1J4REtRcWNBZFUrZ0J4YlByL2QrVGMraDF1dm14akxxckNyNHhNSmFHOGJX?=
 =?utf-8?B?NEpoTFROcnozUGsva0RJeXhvU2U4QkVXaTlwWlF4TEhRVm5sK0tEczBHZk5l?=
 =?utf-8?B?aUhDVDlyWGxzSzNGc3BHUzhwUVJnWThwTmhZR29MSWdnMzY1bGFpd25VMElY?=
 =?utf-8?B?N3A5OVAxN1lLb0tuTm15Yy8wMjRpc216Ny80dC81RXY1SUs1WmFtdFV4VUlo?=
 =?utf-8?B?aFlhcjdqMDA2blh4Rk9KbUJhWVB6c0FUUFlvQ2JjYms4WUd1MUJHUDhiWTRC?=
 =?utf-8?B?emhkcnorZTNPaHRrMDZYdnBjYmFjOC9Ca3UyYjcwYkZrUkJhUytVSFZJSHFU?=
 =?utf-8?B?T1N6WjdYVjlkeE9iV00wMlJGa0ZGLzVtWUEyajZHTWRHTXVCaEhBYTZ2NTBt?=
 =?utf-8?B?SUEzSVlieGNSVEV3alBMelhWOEV5TkVxaXZIOFhTUlppVnF0WkMxTjVLRldK?=
 =?utf-8?B?UktjU1VGL3ZvcXp6eFdRdGFXcFFDQWpna2wySzFYWk9hREdESXU2ZCtXUFBH?=
 =?utf-8?B?T3AvOVVaUGhWa0ZOd3M0b25oZkFnNVpoVmdmNnBDemViNDNUL1FzVytiN1Bw?=
 =?utf-8?B?dzRsVGZGRDNyYTVrQXJ5UmlRWW1hcEtnaXROMUE3OTZObDVHMFdCSVUxV1Uv?=
 =?utf-8?B?STFYUjdHaEg3alBEUkI4aVNaZVlKYU1ZV3A0ckRjL1BmSnphazBNVWVCR0dL?=
 =?utf-8?B?clJldVpmNk0xT1dPS1VJV1hhVWw1dVpkRmVtUVVIRzIvT25saUtVZUxzSlZV?=
 =?utf-8?B?cE91bHEyRXFoK3p4K3daVGxwTUk4Y2N5TVNrTlBzM3NHbzBUWk5EdXAxUG1q?=
 =?utf-8?B?QWRNTE1JUTE2MmxjT3VqUGQrbmZYdUZLaElMdEc0cW9lVnlIVEZYWlp6TjB6?=
 =?utf-8?B?QTJUNkZpMkp6bm5ReE0xUDZzTlFyRlJqVmVIclNCZ2JxYlhybk9KU042Wkla?=
 =?utf-8?B?WTlhZjQvTmNCK1hQYnFIeU16SHcwdkxUQ3paNUI1OCtKTEkydDZYZE5zcjBa?=
 =?utf-8?B?anMzMEZzQThtVEtpQlkrSEdOZVVLRFQ5dUhIQ3NrRlRyUzB6REpsbjlkZ01k?=
 =?utf-8?B?NkpLZERSdTl6a3ppSUI0TGZnbUxCY0xSUDBkSTB5QU4zSHlDa01xMmpjNDBT?=
 =?utf-8?B?NkxpalpMNjJjV3VveXIxK1ZYd2JRMXIrL1NuQjRCQko5VXFxNHAxRVZpRnYz?=
 =?utf-8?B?OFBQZ295ZlR3dUFSbXc0OE5xNkgrc002ak56eThORlVnRjdyVjNVUUxsanFQ?=
 =?utf-8?B?U0JjN2kwcmhGSkVyZisrMkwraGlLeGdudTJHbUhvUU1nMHJ6TnlEOUY5Y2tz?=
 =?utf-8?B?VVNOZ2RkUVFLSTNjaWdKRURzMUhlYStCbGI1dlh2U3VzUDBTaU40MExab0ZX?=
 =?utf-8?B?aGQ3eDZKTWpPaUo0WTNXLzFySzgvTGNTNEE1L3RwMFVGaXBwZmFTU0dTYStB?=
 =?utf-8?B?ZytaS2t6QU1pZ0ZWZ0txeVpaWFVENWlyWmJXL1RQVUNEVHlyNXp4R2dMVGpU?=
 =?utf-8?B?YlhjY0tmL1JPQWRIVUVvRXRuTE1OTkRpcFBKUE5SK1pwUlh3c3R0dW44WnZs?=
 =?utf-8?B?Kytqa0hMeXcyY29VVzJoTFV3cFRVbXU2Nk1jaHR3dG9LTEhFOElmanNtMUFs?=
 =?utf-8?B?MnBQNVdLVUZDeUJKbVZna0VvY0lzZ3RpMkdpNlB4NzhkUzdDaFVUMnVtT1Bh?=
 =?utf-8?B?NExYeitoeTVUZ09EdDRyeFFrV2tHQW5IWDUxOHBaZ2J3TkJ3ZFovbFE2STls?=
 =?utf-8?B?WDJCa2txc2xrM3g3NnhzTHArVVNYSW1CbzJjMW41NmN2Qk1aL0ZPOFVlNU9h?=
 =?utf-8?B?ZHZKOVBVUDJwTFhudFlDdE8zZzNuMzR2Z3ovTWpaOHV3QzNHQXBmY1dWbENv?=
 =?utf-8?B?SDhLUG5leUd5V0hKWFVHYThkNkdWZ2N4OGIyVUVZZmdlakl4cTJMNHVxSDFu?=
 =?utf-8?Q?24EXEdvIStVBOg549+QNyy7ub?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR04MB3592.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f228bcc8-79bf-4feb-b4ad-08db94d27b29
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 10:06:33.3090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHgGatt+aqs1G1HFUfgqcYD9tULUZVKi6XBK6SuPBPuu5jMWx5ZM6bC2qGx3aAH16AZmnGg5frCVNeyvfkLInw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
QXVndXN0IDMsIDIwMjMgNzoxNCBQTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lu
biA8RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJv
YiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0
QGtlcm5lbC5vcmc+Ow0KPiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgQW5kcmV3IEpl
ZmZlcnkgPGFuZHJld0Bhai5pZC5hdT4NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWFzcGVlZEBs
aXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8yXSBkdC1iaW5kaW5nczogYXJtOiBhc3BlZWQ6IGFkZCBGYWNlYm9vayBZ
b3NlbWl0ZQ0KPiBWNCBib2FyZA0KPiANCj4gICBTZWN1cml0eSBSZW1pbmRlcjogUGxlYXNlIGJl
IGF3YXJlIHRoYXQgdGhpcyBlbWFpbCBpcyBzZW50IGJ5IGFuIGV4dGVybmFsDQo+IHNlbmRlci4N
Cj4gDQo+IE9uIDAyLzA4LzIwMjMgMDQ6MzQsIERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4g
d3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+
DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI3LCAyMDIzIDI6NDkgUE0NCj4gPj4gVG86IERl
bHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4NCj4gPERlbHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNv
bT47DQo+ID4+IHBhdHJpY2tAc3R3Y3gueHl6OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwu
b3JnPjsgS3J6eXN6dG9mDQo+ID4+IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBs
aW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5DQo+ID4+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgSm9l
bCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFuZHJldyBKZWZmZXJ5DQo+ID4+IDxhbmRyZXdA
YWouaWQuYXU+DQo+ID4+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+PiBsaW51eC1hc3BlZWRAbGlzdHMub3ps
YWJzLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTog
W1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IGFybTogYXNwZWVkOiBhZGQgRmFjZWJvb2sNCj4gPj4g
WW9zZW1pdGUgVjQgYm9hcmQNCj4gPj4NCj4gPj4gICBTZWN1cml0eSBSZW1pbmRlcjogUGxlYXNl
IGJlIGF3YXJlIHRoYXQgdGhpcyBlbWFpbCBpcyBzZW50IGJ5IGFuDQo+ID4+IGV4dGVybmFsIHNl
bmRlci4NCj4gPj4NCj4gPj4gT24gMjcvMDcvMjAyMyAwNTozOSwgRGVscGhpbmUgQ0MgQ2hpdSB3
cm90ZToNCj4gPj4+IERvY3VtZW50IHRoZSBuZXcgY29tcGF0aWJsZXMgdXNlZCBvbiBGYWNlYm9v
ayBZb3NlbWl0ZSBWNC4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBEZWxwaGluZSBDQyBD
aGl1IDxEZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FzcGVlZC9hc3BlZWQueWFtbCB8IDEg
Kw0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+Pg0KPiA+PiBJIGdv
dCB0aGUgc2FtZSBwYXRjaCBmb3VyIHRpbWVzLi4uDQo+ID4gSXQgd2FzIG15IG92ZXJzaWdodCB0
byBzZW5kIHRoZSBzYW1lIHBhdGNoIG11bHRpcGxlIHRpbWVzLg0KPiA+IFdvdWxkIHlvdSBwbGVh
c2UgdG8gdGVsbCB0aGF0IHNob3VsZCBJIHJlc2VuZCBhIG5ldyB2ZXJzaW9uLCBvciB0aGVzZQ0K
PiBwYXRjaGVzIGhhcyBiZWVuIGFscmVhZHkgdW5kZXIgcmV2aWV3ZWQuDQo+ID4gVGhhbmsgeW91
Lg0KPiANCj4gSSBkb24ndCBzZWUgdmVyc2lvbmluZywgbm8gY2hhbmdlbG9nLiBUaHVzIGlmIHlv
dSBzZW5kIHRoZSBzYW1lIHBhdGNoZXMgYWxsDQo+IHRoZSB0aW1lLCB0aGVuIGFuc3dlciBpcyAt
IHBsZWFzZSB2ZXJzaW9uIHlvdXIgcGF0Y2hlcywgaW1wbGVtZW50IHRoZQ0KPiBmZWVkYmFjayBh
bmQgZXhwbGFpbiBpbiBjaGFuZ2Vsb2cgd2hhdCBjaGFuZ2VkLg0KSXQgc2VlbXMgdGhhdCB2ZXJz
aW9uaW5nIGRpZG4ndCBhZGRlZCBzdWNjZXNzZnVsbHkgaW4gZHVwbGljYXRlZCBwYXRjaGVzLg0K
DQpJIHdpbGwgdXBkYXRlIHY1IHBhdGNoZXMgZm9yIHZlcnNpb25pbmcsIGNoYW5nZWxvZ3MgYW5k
IGFsbCBmZWVkYmFjaydzIGltcGxlbWVudGF0aW9uLCB3aXRob3V0IGR1cGxpY2F0aW5nIHNlbmRp
bmcuDQpQbGVhc2UgaGVscCB0byB0ZWxsIGlmIHRoZXJlJ3MgYW55IGZlZWRiYWNrIEkgbG9zdCwg
dGhhbmsgeW91Lg0KPiANCj4gT3RoZXJ3aXNlIGl0IHdpbGwgbm90IGdldCByZXZpZXdlZCwgc28g
SSBhc3N1bWUgdGhpcyB3YXMgbm90IHJldmlld2VkIGFuZCBpdA0KPiBpcyB3YWl0aW5nIGZvciBw
cm9wZXIgc3VibWlzc2lvbi4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
