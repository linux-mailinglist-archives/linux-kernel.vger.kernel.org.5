Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F239A77CD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbjHONTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237430AbjHONTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:19:20 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB87199A;
        Tue, 15 Aug 2023 06:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gn61LYKbm2RyJ10ijiqP4ElDcHJGRHwE7L4Arx47GzBxjSkMUBphjDq6Of+XHWNuhefT6CxYlnudYttNOOP/4fMTYJxuFmuKapsE1WduffmgSz8XwX1xAI95f/y/6g96xQsPU5ElCdWUuJxpMDCyyBQS0M7qdLmNER+RbWaUix5eaIAujwzbzwyiI9bZCil6mj+bw6f6CWZFRuxR+JyLhzZPStP8gu7ttvvVvdtL6CpdtoM/SHRRooOvq2fIGhPvJVMS9kIf8/bSAIx/8Q8PH3otTElSNa/m76ERTq5rwv/DJMV45MJg23U4r8OSgxBsZgBK7zDXZDeD03kdt17nAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lM1Zfh865boqL3oPP1gGAW0QY4xVNb1ephKYF/d8Nw=;
 b=I3lw5w3Yxoc3hAfeWycwEfm4F+RDDX+KqiUutl2CO/gr4uhJ6kGvADp0jsXc69hKHTVntQh1NiZglXJzXPaf46E3HaK1UQpjxVQbq/a6xSzYOX0+JH3xs8vSjyP1wz4kCTHhCI3TccEJDIS/fBS1rtyfgCZ/HWjMeGSyf8T0RiK1pQhRULbkHwn6hk0A1TF9tikH+X8T+2OXDYXgqi/1nNcA9LL9qeDp6ZEUPI2vXC49+++i98OsDMia2gRRsOXvPqxpCSD7dI0EQLAwOGMIisWxVfL5SMlS3sNnSiNs9/cElmhs3cC2oqQ7SrF15CHT3Me8YY92v1V4tROim+j2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lM1Zfh865boqL3oPP1gGAW0QY4xVNb1ephKYF/d8Nw=;
 b=lIp1K7+owg9DLhXjYLOIwrHPPKu++Oy7FB0yH+RNxp+YMkJiAzVrL5A27BpBgmSEFQZBTsYAzlSmAjZcwMjd+itaR+vtEq5GVz32to8VrhQqFfdHzXfC1zIfkJOmkDfJQUANf+86jfeK5G1Ywjts2O6pWSUauGi3c37GLSfCMEs=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DU2PR04MB8711.eurprd04.prod.outlook.com (2603:10a6:10:2de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 13:19:14 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 13:19:14 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH v4 4/7] arm64: dts: imx93-11x11-evk: added nxp
 secure enclave fw
Thread-Topic: [EXT] Re: [PATCH v4 4/7] arm64: dts: imx93-11x11-evk: added nxp
 secure enclave fw
Thread-Index: AQHZtLpCt80XNe94BE2xAgWYFY4Zrq+2fsMAgCnvgrCAAAJHYIAANdAAgAriF5A=
Date:   Tue, 15 Aug 2023 13:19:14 +0000
Message-ID: <DU2PR04MB8630D5EA12E9D920BEA6007B9514A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-5-pankaj.gupta@nxp.com>
 <29cb4426-a15e-7186-1713-427f749bc187@linaro.org>
 <DU2PR04MB863043CFB54E4CF2C5F34B65950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <DU2PR04MB8630F001B107D331F9F5DE1E950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <65a57225-43d5-fdfa-c12d-3f33f8e535be@linaro.org>
In-Reply-To: <65a57225-43d5-fdfa-c12d-3f33f8e535be@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|DU2PR04MB8711:EE_
x-ms-office365-filtering-correlation-id: 57387aa5-93eb-43e0-af04-08db9d92388f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Jdg31jWKRaCesFsse685gZ4B9ZxivmqNi0C/k6dpExNCvbNLZUBi+1LUg4o8rsV2OuUlrxTIvdNNNGreWGfCg5wLja7LY9VQ9/ezp8GJHATyqUrubpjFlAsSAGFvOS094kAARkflPq8AvTac9d3kt0ySZamb0lhGXcn+pAMa3+FirOfAT7o5jhuCjJtj1BIGWxSCvbZP+GTrFiu5XI6BCYRc6X0kUE1R9f++HPPyCkTI26c5MKrMhYUIIv/FzR0mmx8zxVDIii3jNdI2wJ55H3U6UrniyZXrB69R8HN26uSCybyu85kLvj9pYP4WLDNl3c+ob+JclX95LpaHlIag/A2CvVrP1jsbJnriBx6Cbedcg6wUqSOxbtM3a/c5MgVTYh1baC/y8JuO27WdzaFFh+3tDBCip00m9eqeDnx7ZQCXLjQqtNnzccQj/PpiwFPY9Frb2OYWpP/8MZt/0mBUxAek12nNtTiSKgVT9YjsP1JyZK8ACE2uVBdCQpsk/w1aHbYB7iEGVIceAEsBegr5qrOMC5oNR5SgwTgykViP1R+T28939SL8tjUCon17Ud4tmn49EayVlh04XMn31gLcUdZj2R+PQdd0Ibj7pOzY5y4xjJ+taE0BJexlt3WBuA1a8iyGLzL7H2MdqqW3kyJdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(478600001)(71200400001)(38100700002)(86362001)(76116006)(55016003)(38070700005)(921005)(6506007)(66476007)(66556008)(6636002)(66946007)(316002)(5660300002)(41300700001)(26005)(53546011)(9686003)(122000001)(33656002)(110136005)(83380400001)(64756008)(7696005)(66446008)(2906002)(8676002)(44832011)(7416002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDUweHhRZ2JiQjU5QTNpTGwrbWhqZGVqc3BhM1N3aWNsMk95K1ByTzVPU1F6?=
 =?utf-8?B?NnBDS0J4NU44cDh1b3ljTTgwUk5oeHFhVlhlV3hRZ0JhQmVFSm9aVlNmanlM?=
 =?utf-8?B?K3NUS3NTbjNIdEhBL05SOWwyaVFlZXNYRFJoaTJSVWNlRXYraWZIeVhOVVdV?=
 =?utf-8?B?TVYwc2Zoa2w3RGh1NUNOK1dlU0lzRjFJY2tBSHFOV3pIcG5mSWdtTlpKb0g0?=
 =?utf-8?B?ekp5UU00OEZrMXFSQ2E4Z0VTeFNRdGVZOXZYdTRYajBaTGxCV0ZJTDl1R1Ey?=
 =?utf-8?B?WWtLMUhmMmZHS1BSM0l5VW5uM2l0WW1vSFFqSisyYjZYa29NL2pKZnJSdjA3?=
 =?utf-8?B?QmEvTWhMTjFSaUxQQURMZVdGTDE1MUdkNi9FcFNxWUhXNjR1cXdpdnYrcDVQ?=
 =?utf-8?B?RVh3ZWZBeVpoVy9JdjJIOU5jTWdmSXJBckE2cHA1QXpabkIwZzJNOUxzaHNJ?=
 =?utf-8?B?ZjRIVlZBVENOSTlNR1JaQnFVL2taU3RIQjJkalk4V0s1M2ZVOTJ5MGRBcVNu?=
 =?utf-8?B?Y0ZBUDhTbFgzLzM5dDFsNE1hbjk3bUFMcW1teU1kdFBNTlZhQmRxZlJtS0lO?=
 =?utf-8?B?ZGU0cEYrUkUvQnJkNS9aRDlLbEpLUXZyVHZHMExqQW1wMStaVER3UEhIK3pF?=
 =?utf-8?B?d0RPUnFGRG9VbnUrQzZrVUJueFZwbWloSk80c1EyRGdqZXprMWRPRkZZTzFl?=
 =?utf-8?B?Z1pXVjdLbFQxUEdKZThxd1pMRk9MUmR3WmUva2UrcUQvQ1lweGhDa3lweDN1?=
 =?utf-8?B?bms5MXNlbkRuaFRVN3VnNUpLblJsNjJBVkEzbEI5c0pFbjhGZTVxTjdJWXlD?=
 =?utf-8?B?VnhoRGdqU1Y3eEQwNmVmU3hvK3V3cG1DRzlrNUlIWU1oRFk4ZjJkSWR2a3lp?=
 =?utf-8?B?TDYzN082MStSSGpLNVVKakMwWUQ3NjhWTHp4dmxGL29ELyt3ZGQxQXpnMUxh?=
 =?utf-8?B?Z1FuRThXeVhNRmJkUUcxVGFYUG14cFBnZUYzbk5Wc1JIQlRIT0ZGdFB2UGQy?=
 =?utf-8?B?RE0reUx0STViQ3dyWXRwSHRHc29aOEh3SnVpeU1OTTlTZmdvYjdwQzA2SlF1?=
 =?utf-8?B?VWYrdlQyaEoyeldKTGdXTlJLNWxXYW5kQW1TSW5ybldieThkWENQbmZlb1Ft?=
 =?utf-8?B?UFlmc01LQjhUWW1zRGhHa2J0bThxMnhZQTBGQk9sVFhtSFY4cHpMNmpEaHZm?=
 =?utf-8?B?OUQwa3lYZEtJWDJzSDZJQWpEQUVsYVJkMndsNjk5WFdUa3BZRmRjMEJVRHdn?=
 =?utf-8?B?cWM0M2NZNnNaV3pxa3I1MGJJN1ZUWUIyRmkwNnJRa3RjOHJmUU9DZDIvaksw?=
 =?utf-8?B?YXU0RFRKUC9qY1lySmZId1U1VElCNXNidXE4YTBnUFAxcWFlOTgzWTRmZHJM?=
 =?utf-8?B?WWRwSVhqNE5yQUFYQ1hjODZZeS8wUzFNa0tSTDF0eDNkNFVlc1VMOTkwTjF0?=
 =?utf-8?B?eVQzMG8yU2VtMUVKSms0dUxHNGY0K0RPUm5mVS9ySHNnUFZEQUIzNWtsWTY2?=
 =?utf-8?B?amlCa05OU09tbUhodm5ZajljdmhhWnhQK0NSZlBSRzVyK0UrYWFMVUdqZE9Q?=
 =?utf-8?B?VFU1eC90bGdTS002ZWpiYjdlcG1YcWZraFFXc3IwR1R3WHdvcU1uSDJWWWpn?=
 =?utf-8?B?SVhSbVdzZ2RHUDNncXJsa05GaVhxOHRuNlVvOGo5bTNNWndEN0ZyQkk2bmgz?=
 =?utf-8?B?ZlVlU3kyTWJDU3RicUhDNVhNczZ4MkVYK2hwR1pmcGdDVVF1ZnU5Znl0T1pS?=
 =?utf-8?B?WkJUbTI4VlVlb3dJL05QenlKdTRBeGJDam1ZMGMxbEpoNU82bE4zNkR3bTV1?=
 =?utf-8?B?aDQwSFNPNGlLOFdPUlp2QlVmdHdBNmVZeC9lNFlVb1JTbmVyODFzRFdjUWdO?=
 =?utf-8?B?dEZ1V1FNYVZ1WDMrUTBCY2k5a2NYamw4bXNNVE9CYWdQT01zeEUwUGRDY1Zm?=
 =?utf-8?B?RFF4R0ZyUUloSjFMQkJrL21RaUw1Z25jdFNJVGtCWWFmbUlLdkFENVV1cTEw?=
 =?utf-8?B?U2ovV25EUlREUnp6WnVJTjVubWVNLzRKRjNHOG5PSmtIQ1lCV3NuZ2tGM3hm?=
 =?utf-8?B?MHprSklLazNKa2hDeWd4bFNxeFYzVFVnQ2VGMExrUTR2UUJPam9hZ2pzK2NF?=
 =?utf-8?Q?lBTFkpyqp2Wu1shsbKzyBVWFu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57387aa5-93eb-43e0-af04-08db9d92388f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 13:19:14.2404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwPTpkFstzQWGDWWap53W6qLRMyns2wfWfqrvlZUVapA4Eaxb3mrPmQsNjqljC8vuaBw94iLYawaqZNbx/UzXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8711
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBB
dWd1c3QgOCwgMjAyMyA4OjIyIFBNDQo+IFRvOiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBu
eHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsg
a2VybmVsQHBlbmd1dHJvbml4LmRlOyBjbGluQHN1c2UuY29tOw0KPiBjb25vcitkdEBrZXJuZWwu
b3JnOyBwaWVycmUuZ29uZG9pc0Bhcm0uY29tOyBKYWNreSBCYWkNCj4gPHBpbmcuYmFpQG54cC5j
b20+OyBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBXZWkgRmFuZw0KPiA8d2Vp
LmZhbmdAbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsgQm91Z2ggQ2hlbg0K
PiA8aGFpYm8uY2hlbkBueHAuY29tPjsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXgg
PGxpbnV4LQ0KPiBpbXhAbnhwLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IHJvYmgrZHRAa2Vy
bmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHYXVyYXYgSmFpbg0KPiA8Z2F1cmF2Lmph
aW5AbnhwLmNvbT47IGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb207IFNhaGlsIE1hbGhv
dHJhDQo+IDxzYWhpbC5tYWxob3RyYUBueHAuY29tPjsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRv
bmdAbnhwLmNvbT47DQo+IFZhcnVuIFNldGhpIDxWLlNldGhpQG54cC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbRVhUXSBSZTogW1BBVENIIHY0IDQvN10gYXJtNjQ6IGR0czogaW14OTMtMTF4MTEtZXZr
OiBhZGRlZA0KPiBueHAgc2VjdXJlIGVuY2xhdmUgZncNCj4gDQo+IENhdXRpb246IFRoaXMgaXMg
YW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBv
cg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3Nh
Z2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24g
MDgvMDgvMjAyMyAxMzo0OSwgUGFua2FqIEd1cHRhIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogUGFua2FqIEd1cHRhDQo+ID4+IFNl
bnQ6IFR1ZXNkYXksIEF1Z3VzdCA4LCAyMDIzIDU6MDQgUE0NCj4gPj4gVG86IEtyenlzenRvZiBL
b3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz47DQo+ID4+IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsNCj4gPj4gY2xpbkBzdXNlLmNvbTsgY29ub3IrZHRAa2VybmVsLm9yZzsgcGllcnJlLmdv
bmRvaXNAYXJtLmNvbTsgSmFja3kNCj4gQmFpDQo+ID4+IDxwaW5nLmJhaUBueHAuY29tPjsgQ2xh
cmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgV2VpIEZhbmcNCj4gPj4gPHdlaS5mYW5n
QG54cC5jb20+OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IEJvdWdoIENoZW4NCj4gPj4g
PGhhaWJvLmNoZW5AbnhwLmNvbT47IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxs
aW51eC0NCj4gPj4gaW14QG54cC5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0OyByb2JoK2R0QGtl
cm5lbC5vcmc7DQo+ID4+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gPj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+PiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgR2F1cmF2IEphaW4N
Cj4gPj4gPGdhdXJhdi5qYWluQG54cC5jb20+OyBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAu
Y29tOyBTYWhpbA0KPiA+PiBNYWxob3RyYSA8c2FoaWwubWFsaG90cmFAbnhwLmNvbT47IEFpc2hl
bmcgRG9uZw0KPiA+PiA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBWYXJ1biBTZXRoaSA8Vi5TZXRo
aUBueHAuY29tPg0KPiA+PiBTdWJqZWN0OiBSRTogW0VYVF0gUmU6IFtQQVRDSCB2NCA0LzddIGFy
bTY0OiBkdHM6IGlteDkzLTExeDExLWV2azoNCj4gPj4gYWRkZWQgbnhwIHNlY3VyZSBlbmNsYXZl
IGZ3DQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+Pj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5h
cm8ub3JnPg0KPiA+Pj4gU2VudDogVGh1cnNkYXksIEp1bHkgMTMsIDIwMjMgMTI6MzggQU0NCj4g
Pj4+IFRvOiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBueHAuY29tPjsgc2hhd25ndW9Aa2Vy
bmVsLm9yZzsNCj4gPj4+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgY2xpbkBzdXNlLmNvbTsNCj4gPj4+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHBpZXJyZS5n
b25kb2lzQGFybS5jb207IEphY2t5IEJhaQ0KPiA+Pj4gPHBpbmcuYmFpQG54cC5jb20+OyBDbGFy
ayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBXZWkNCj4gRmFuZw0KPiA+Pj4gPHdlaS5m
YW5nQG54cC5jb20+OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IEJvdWdoIENoZW4NCj4g
Pj4+IDxoYWliby5jaGVuQG54cC5jb20+OyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlt
eCA8bGludXgtDQo+ID4+PiBpbXhAbnhwLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IHJvYmgr
ZHRAa2VybmVsLm9yZzsNCj4gPj4+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsN
Cj4gPj4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPj4+IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHYXVy
YXYNCj4gPj4+IEphaW4gPGdhdXJhdi5qYWluQG54cC5jb20+OyBhbGV4YW5kZXIuc3RlaW5AZXcu
dHEtZ3JvdXAuY29tOyBTYWhpbA0KPiA+Pj4gTWFsaG90cmEgPHNhaGlsLm1hbGhvdHJhQG54cC5j
b20+OyBBaXNoZW5nIERvbmcNCj4gPj4+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47DQo+ID4+IFZh
cnVuDQo+ID4+PiBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0KPiA+Pj4gU3ViamVjdDogW0VYVF0g
UmU6IFtQQVRDSCB2NCA0LzddIGFybTY0OiBkdHM6IGlteDkzLTExeDExLWV2azogYWRkZWQNCj4g
Pj4+IG54cCBzZWN1cmUgZW5jbGF2ZSBmdw0KPiA+Pj4NCj4gPj4+IENhdXRpb246IFRoaXMgaXMg
YW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZw0KPiA+Pj4g
bGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBt
ZXNzYWdlDQo+ID4+PiB1c2luZyB0aGUgJ1JlcG9ydCB0aGlzIGVtYWlsJyBidXR0b24NCj4gPj4+
DQo+ID4+Pg0KPiA+Pj4gT24gMTIvMDcvMjAyMyAxNDoxMiwgUGFua2FqIEd1cHRhIHdyb3RlOg0K
PiA+Pj4+IEFkZGVkIHN1cHBvcnQgZm9yIE5YUCBzZWN1cmUgZW5jbGF2ZSBjYWxsZWQgRWRnZUxv
Y2sgRW5jbGF2ZQ0KPiA+Pj4+IGZpcm13YXJlDQo+ID4+Pj4gKHNlLWZ3KSBmb3IgaW14OTMtMTF4
MTEtZXZrLg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogUGFua2FqIEd1cHRhIDxwYW5r
YWouZ3VwdGFAbnhwLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OTMuZHRzaSB8IDExICsrKysrKysrKystDQo+ID4+Pj4gIDEgZmlsZSBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pj4NCj4gPj4+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaQ0KPiA+
Pj4+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaQ0KPiA+Pj4+IGlu
ZGV4IDg2NDM2MTJhY2U4Yy4uMmIwZjkwMWQyNzA5IDEwMDY0NA0KPiA+Pj4+IC0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kNCj4gPj4+PiArKysgYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNpDQo+ID4+Pj4gQEAgLTEsNiArMSw2IEBA
DQo+ID4+Pj4gIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCsgT1IgTUlUKQ0K
PiA+Pj4+ICAvKg0KPiA+Pj4+IC0gKiBDb3B5cmlnaHQgMjAyMiBOWFANCj4gPj4+PiArICogQ29w
eXJpZ2h0IDIwMjItMjAyMyBOWFANCj4gPj4+PiAgICovDQo+ID4+Pj4NCj4gPj4+PiAgI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2lteDkzLWNsb2NrLmg+IEBAIC04NjMsNSArODYzLDE0IEBA
DQo+ID4+Pj4gZGRyLXBtdUA0ZTMwMGRjMCB7DQo+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAg
IHJlZyA9IDwweDRlMzAwZGMwIDB4MjAwPjsNCj4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAg
aW50ZXJydXB0cyA9IDxHSUNfU1BJIDkwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+Pj4+ICAg
ICAgICAgICAgICAgfTsNCj4gPj4+PiArDQo+ID4+Pj4gKyAgICAgICAgICAgICBlbGVfZnc6IHNl
LWZ3IHsNCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14
OTMtZWxlIjsNCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgbWJveGVzID0gPCZzNG11YXAg
MCAwICZzNG11YXAgMSAwPjsNCj4gPj4+DQo+ID4+PiBUaGlzIHNob3VsZCBiZSB0d28gZW50cmll
cy4NCj4gPj4+DQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIG1ib3gtbmFtZXMgPSAidHgi
LCAicngiOw0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBmc2wsbXUtZGlkID0gPDM+Ow0K
PiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBmc2wsbXUtaWQgPSA8Mj47DQo+ID4+Pg0KPiA+
Pj4gRHJvcCBib3RoLiBTaW5jZSB5b3UgcHV0IGl0IGludG8gdGhlIERUU0ksIGl0IG1lYW5zIGl0
IGlzIGNvbXBhdGlibGUNCj4gc3BlY2lmaWMuDQo+ID4+IFtQYW5rYWpdIFJlbW92ZWQgdGhlIGFi
b3ZlIHRocmVlIGVudHJpZXMuDQo+ID4NCj4gPg0KPiA+IFtQYW5rYWpdIENvcnJlY3Rpb246DQo+
ID4gSSBtaXNzZWQgdG8gbm90ZSB0aGF0IGluIG91ciB1cC1jb21pbmcgU29DKHMpLCB0aGVyZSB3
aWxsIGJlIG11bHRpcGxlDQo+IE1VKHMpOg0KPiA+IFRob3NlIGNhbiBvbmx5IGJlIGlkZW50aWZp
ZWQgdXNpbmcgbXVfaWQuIEhlbmNlLCBmb2xsb3dpbmcgdHdvIG9ubHksIHdpbGwNCj4gYmUgcmVt
b3ZlZDoNCj4gPiArICAgICAgICAgICAgICAgICAgICAgbWJveC1uYW1lcyA9ICJ0eCIsICJyeCI7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGZzbCxtdS1kaWQgPSA8Mz47DQo+IA0KPiBXaGlj
aCBTb0M/IA0KRXhpc3RpbmcgTlhQIFNvQyBpTVg4RFhMLiBJdHMgZHJpdmVyIHdpbGwgYmUgdXNp
bmcgdGhpcyBhcyBhIGJhc2UgZHJpdmVyLCB3aGljaCBoYXMgbXVsdGlwbGUgTVUocykuDQoNCj4g
SG93IHRoZSBiaW5kaW5ncyBhcmUgZ29pbmcgdG8gbG9vayBsaWtlIGZvciB0aGF0IFNvQz8NClRo
ZXJlIGFyZSA4IE1VKHMpOiAzIGZvciBzZWN1cmUtZW5jbGF2ZSBjYWxsZWQgU0VDTywgYW5kIDUg
Zm9yIFYyWCBiYXNlZCBNVShzKS4NCg0KQmluZGluZ3MgZm9yIHRoYXQgU29DIHdpbGwgYmUgbGlr
ZToNCg0KQS4JRm9yIFNFQ08gYmFzZWQgSFNNOg0KRm9yIG11X2lkID0xOg0KICAgICAgICAgICAg
ICAgIHNlY29fZncxOiBzZS1mdzEgew0KICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJmc2wsaW14OGR4bC1zZS1mdyI7DQogICAgICAgICAgICAgICAgICAgICAgICBtYm94LW5h
bWVzID0gInR4IiwgInJ4IjsNCiAgICAgICAgICAgICAgICAgICAgICAgIG1ib3hlcyA9IDwmc2Vj
b19tdTEgMCAwPiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCYgc2Vjb19tdTEg
MSAwPjsNCiAgICAgICAgICAgICAgICAgICAgICAgIGZzbCxtdS1pZCA9IDwxPjsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIHNyYW0tcG9vbCA9IDwmc3JhbTA+Ow0KICAgICAgICAgICAgICAgIH07
DQoNCkZvciBtdV9pZCA9IDINCiAgICAgICAgICAgICAgICBzZWNvX2Z3Mjogc2UtZncyIHsNCiAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDhkeGwtc2UtZnciOw0K
ICAgICAgICAgICAgICAgICAgICAgICAgbWJveC1uYW1lcyA9ICJ0eCIsICJyeCI7DQogICAgICAg
ICAgICAgICAgICAgICAgICBtYm94ZXMgPSA8JnNlY29fbXUyIDAgMD4sDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDwmc2Vjb19tdTIgMSAwPjsNCiAgICAgICAgICAgICAgICAgICAg
ICAgIGZzbCxtdS1pZCA9IDwyPjsNCiAgICAgICAgICAgICAgICAgICAgICAgIHNyYW0tcG9vbCA9
IDwmc3JhbTA+Ow0KICAgICAgICAgICAgICAgIH07DQoNCkZvciBtdV9pZCA9IDMNCiAgICAgICAg
ICAgICAgICBzZWNvX2Z3Mzogc2UtZnczIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAiZnNsLGlteDhkeGwtc2UtZnciOw0KICAgICAgICAgICAgICAgICAgICAgICAgbWJv
eC1uYW1lcyA9ICJ0eCIsICJyeCI7DQogICAgICAgICAgICAgICAgICAgICAgICBtYm94ZXMgPSA8
JnNlY29fbXUzIDAgMD4sDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmc2Vjb19t
dTMgMSAwPjsNCiAgICAgICAgICAgICAgICAgICAgICAgIGZzbCxtdS1pZCA9IDwzPjsNCiAgICAg
ICAgICAgICAgICB9Ow0KDQpCLglGb3IgVjJYIGJhc2VkIEhTTToNCkZvciBtdV9pZCA9NDoNCiAg
ICAgICAgICAgICAgICB2MnhfZnc0OiBzZS1mdzQgew0KICAgICAgICAgICAgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJmc2wsaW14OGR4bC1zZS1mdyI7DQogICAgICAgICAgICAgICAgICAgICAg
ICBtYm94LW5hbWVzID0gInR4IiwgInJ4IjsNCiAgICAgICAgICAgICAgICAgICAgICAgIG1ib3hl
cyA9IDwmdjJ4X211NCAwIDA+LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnYy
eF9tdTQgMSAwPjsNCiAgICAgICAgICAgICAgICAgICAgICAgIGZzbCxtdS1pZCA9IDw0PjsNCiAg
ICAgICAgICAgICAgICAgICAgICAgIHNyYW0tcG9vbCA9IDwmc3JhbTA+Ow0KICAgICAgICAgICAg
ICAgIH07DQoNCkZvciBtdV9pZCA9IDUNCiAgICAgICAgICAgICAgICB2MnhfZnc1OiBzZS1mdzUg
ew0KICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OGR4bC1zZS1m
dyI7DQogICAgICAgICAgICAgICAgICAgICAgICBtYm94LW5hbWVzID0gInR4IiwgInJ4IjsNCiAg
ICAgICAgICAgICAgICAgICAgICAgIG1ib3hlcyA9IDwmdjJ4X211NSAwIDA+LA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA8JnYyeF9tdTUgMSAwPjsNCiAgICAgICAgICAgICAgICAg
ICAgICAgIGZzbCxtdS1pZCA9IDw1PjsNCiAgICAgICAgICAgICAgICAgICAgICAgIHNyYW0tcG9v
bCA9IDwmc3JhbTA+Ow0KICAgICAgICAgICAgICAgIH07DQoNCkZvciBtdV9pZCA9IDYNCiAgICAg
ICAgICAgICAgICB2MnhfZnc2OiBzZS1mdzYgew0KICAgICAgICAgICAgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJmc2wsaW14OGR4bC1zZS1mdyI7DQogICAgICAgICAgICAgICAgICAgICAgICBt
Ym94LW5hbWVzID0gInR4IiwgInJ4IjsNCiAgICAgICAgICAgICAgICAgICAgICAgIG1ib3hlcyA9
IDwmdjJ4X211NiAwIDA+LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnYyeF9t
dTYgMSAwPjsNCiAgICAgICAgICAgICAgICAgICAgICAgIGZzbCxtdS1pZCA9IDw2PjsNCiAgICAg
ICAgICAgICAgICB9Ow0KRm9yIG11X2lkID0gNzoNCiAgICAgICAgICAgICAgICBlbGVfZnc3OiBz
ZS1mdzcgew0KICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OGR4
bC1zZS1mdyI7DQogICAgICAgICAgICAgICAgICAgICAgICBtYm94LW5hbWVzID0gInR4IiwgInJ4
IjsNCiAgICAgICAgICAgICAgICAgICAgICAgIG1ib3hlcyA9IDwmdjJ4X211NyAwIDA+LA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JiB2MnhfbXU3IDEgMD47DQogICAgICAgICAg
ICAgICAgICAgICAgICBmc2wsbXUtaWQgPSA8Nz47DQogICAgICAgICAgICAgICAgICAgICAgICBz
cmFtLXBvb2wgPSA8JnNyYW0wPjsNCiAgICAgICAgICAgICAgICB9Ow0KDQpGb3IgbXVfaWQgPSA4
DQogICAgICAgICAgICAgICAgdjJ4X2Z3Mjogc2UtZnc4IHsNCiAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDhkeGwtc2UtZnciOw0KICAgICAgICAgICAgICAgICAg
ICAgICAgbWJveC1uYW1lcyA9ICJ0eCIsICJyeCI7DQogICAgICAgICAgICAgICAgICAgICAgICBt
Ym94ZXMgPSA8JnYyeF9tdTggMCAwPiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
PCZ2MnhfbXU4IDEgMD47DQogICAgICAgICAgICAgICAgICAgICAgICBmc2wsbXUtaWQgPSA8OD47
DQogICAgICAgICAgICAgICAgICAgICAgICBzcmFtLXBvb2wgPSA8JnNyYW0wPjsNCiAgICAgICAg
ICAgICAgICB9Ow0KPiBXaGF0IGlzIG11LWRpZCBpbiBzdWNoIGNhc2UgYW5kIGhvdyBkb2VzIGl0
IHJlbGF0ZSB0byBkaWZmZXJlbnQgbWFpbGJveGVzPyBXaHkgaXQNCj4gY2Fubm90IGJlIGluZmVy
cmVkIGZyb20gY29tcGF0aWJsZT8NCg0KDQoibXVfZGlkIiB3aWxsIGJlIHJlbW92ZWQuIEFuZCBp
dCBjYW4gYmUgZGVkdWNlZCBmcm9tIGNvbXBhdGlibGUuDQoNCklmIHlvdSBtZWFuIOKAnG11X2lk
4oCdLCB0aGVuIGl0IGlkZW50aWZpZXMgY29tbXVuaWNhdGlvbiBpbnRlcmZhY2UgZm9yIHRoZSBJ
UCBibG9jay4NCiJtdV9pZCIgY2FuIGJlIG11bHRpcGxlIGZvciBhIFNvQywgd2l0aCBzYW1lIGNv
bXBhdGlibGUuIEFzIHF1b3RlZCBmb3IgaS5NWDhEWEwgYWJvdmUuDQoibXVfaWQiIHdpbGwgaGVs
cCB1cywgaWRlbnRpZnkgdGhlIGNvcnJlY3QgY29tbXVuaWNhdGlvbiBpbnRlcmZhY2UgZWxlX2Z3
PHg+LCB0byBjaG9vc2UgYW1vbmcgbXVsdGlwbGUgbXUocykgLg0KDQo+IA0KPiBCVFcsIHJlc3Bv
bmRpbmcgdGhyZWUgd2Vla3MgYWZ0ZXIgbXkgcmV2aWV3IGRvZXMgbm90IGhlbHAgeW91ciBjYXNl
LiBJDQo+IHRvdGFsbHkgbG9vc2UgdGhlIGNvbnRleHQuIE9mIGNvdXJzZSB5b3UgY2FuIHJlcGx5
IGV2ZW4gYWZ0ZXIgMSB5ZWFyLCBpdCdzIHlvdXINCj4gcmlnaHQsIGJ1dCBpdCBkb2VzIG5vdCBo
ZWxwIHRoZSBkaXNjdXNzaW9uLg0KDQpQb2ludCBub3RlZC4gSSB3aWxsIGJlIHByb21wdCBub3ct
b253YXJkcy4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
