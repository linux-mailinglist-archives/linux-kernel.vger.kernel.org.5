Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07117D81C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbjJZLXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344710AbjJZLXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:23:14 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2059.outbound.protection.outlook.com [40.107.247.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6441B1;
        Thu, 26 Oct 2023 04:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyqmZ/13gBTKAgsXG5Ikqxw0Vmd8FQT3Z7J4XuJu/klKD/qQx8TihO6MtR9FjLgKMoaoiGTeACdAy6SpYMOvFf2He3/V4L6k6a2zr3w1T67YcBiS052Uyr5oufWPXjk8PlHGIYmNbwqglsvSYIPP76n1Gt0U2b75PhHWAYoKqZuyd6XvT6DGM858Fp5N6uTMN1LWXu7yMZcB2uTw5KCDVsP5RSEt9EdfHD6C1wVkwm2JEwJ7fB3Gkwy+AwYnXXuk1cFNrY0uMzC2GKSODvTT0BavKw4uUff/7alj0k8FoOg3CgNhqGtBJLfZEYRM5uaL7TUZ/V+AxBws4SDBXdgSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kmZe2FRi1dQQo0itECzppztyyBpe8xzhdAdWVBbFE0=;
 b=Rak2jPQ8CP0/PPzv6+WW7ST+UQra9OXo3tDOhIgIrrz9nxJc/ku24brmQUxBL79SP5dTcFRuVh9Fw/31xS9nUtV+pNAmTTBJ1wqj7MOvp4ROvkfE82n2XB3tu5XRTBHP3BAKq2jVkOC44KCecoNF3TywY+AzvC6RCQCrZz9ehszb7TuSDwpf4W33MdmX4sXzwkihQZ4MlaLrpeaRGSwcv15mdFWMbk0G3JZCjL/TrtxR+iPM/ST37cyb2XC+Hgjqf4PKj1fcYZpilSGJq94SLumXcqH2BGiECeN18xijPPEoS5xuw+rkDKGpnxiz0adi/O9B8fos/2R55tsBVXwr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kmZe2FRi1dQQo0itECzppztyyBpe8xzhdAdWVBbFE0=;
 b=U4Kj7N7gyxA6XyfoVN7qyk+F4OygYs2S2L4PorVseirj+OgIFP6V+aX7k1EWmABh45XpIB9HScgSrWFXe5poLwjwVJrkKjPItyPLs7cO2jXPbAfRx0Dj9PqDYx0JDagqfGT8+tCt/3X8V4tfS1K7E924ak6k61z98yTifqgikss=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM7PR04MB6837.eurprd04.prod.outlook.com (2603:10a6:20b:10b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Thu, 26 Oct
 2023 11:23:08 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351%4]) with mapi id 15.20.6954.008; Thu, 26 Oct 2023
 11:23:08 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH v6 02/11] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v6 02/11] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHZ8T3cp/FWHmHt10GsVHBXrCASpLAwlzyAgAdf5cCAAUCXgIAi4faw
Date:   Thu, 26 Oct 2023 11:23:08 +0000
Message-ID: <DU2PR04MB863004DCF8AEC09BCB809BD495DDA@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
 <20230927175401.1962733-3-pankaj.gupta@nxp.com>
 <20230928185159.GA1035361-robh@kernel.org>
 <DU2PR04MB8630FF5994D65A5404E8B9B095CBA@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <95ce1ef5-dad6-4014-8aec-44adec5b6435@linaro.org>
In-Reply-To: <95ce1ef5-dad6-4014-8aec-44adec5b6435@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AM7PR04MB6837:EE_
x-ms-office365-filtering-correlation-id: 71b0c8fb-91e5-46ee-6559-08dbd615ee50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p7K/tg+/JmvSZJV2laIDZxJOhUyo85m42BlHxOGQlrfpj9C6ei/7nASL1svJ2wySjXKDr+WI07C/vCMZuC2gg3pr5pAfUAHST/IoQa+9tGuN3yXE5OuDXd+LGlsynyDMLRvqo/8OMKSB1U+tful9rK2Tw5QHHROwKMkcsbtk5m/lYDFUQaF8SXrt4DZGfIlGZLcDlFgPbkDpa+rqQFLi6bRKPXQMpnaAq+O0kkUjdUsQiWKbPIzMjvR5gKepwqc7FndukFkeJ1XR9oFO4VyI1aMW7Q5PALHUVMIq6esKbz6+1ccSVXhvHyWxYL+zgBNCMZBqJu549mchq8kf34j/I6Awet/iH2P+6YDQsm3eHh1hx2eBBNfAwfcCTB16YcPHcnkJzoUlw805wBM3FTlK+WrXqaPNN8LKPkIrD4a5oW80vSjXAT0FPJSaF+Zro6VBptqMagXjWhCy5DpWIcRYgCP5cFPRGr2k+y+e7bQeRao97TA/rlfScZGljMXcEtv4KVR5zEhClnBrh8Dj1UWBj5VSpFiCU9cGk+/ygv7W7pgzFeHvmvyNShq3EMnXYLdwX8lhFA7AjmVQqvvvhGWbKxAmRDMz+zEecNK98OGn1Zn1NbmfrJe5v0Nxk9s6xOnV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(55016003)(83380400001)(8676002)(7416002)(54906003)(5660300002)(7696005)(66946007)(41300700001)(110136005)(76116006)(86362001)(66446008)(66556008)(66476007)(478600001)(9686003)(6506007)(64756008)(316002)(71200400001)(33656002)(122000001)(44832011)(8936002)(4326008)(52536014)(2906002)(26005)(38100700002)(53546011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1hVYms1ZGxlSld3Y0g4VERrc0hMSG9vOU41UnJPUmp6YjlTUXN5emJPVStF?=
 =?utf-8?B?ZWw3VWVZQUhTQ1BsMjJQWXFJVzF0aTNQS01pTDg1TVFPcXFlUkF2YjRLMHBx?=
 =?utf-8?B?cmx5aSsxWGhQZ25pNDJiRnR5RFpFei9GcEhUQlcvbjcvK1duRDJYRVh2Uzc4?=
 =?utf-8?B?MGhUbkRKR1BwYjhtNUhEZTB4YUdtZFNmTm1sSktLelo3SjFkWkRxOWV0U2ph?=
 =?utf-8?B?eUFDU0o4dGRVM21wV2d1WlVvWjJPR1NreVpiMXZxZVVubGdLTFNLQmxydXRo?=
 =?utf-8?B?V2NnRmJSbzFDZkxMMXl3Vi9pOG9CUzlWWitacDI2VTFWSEVlbmNoOVZ1VEp1?=
 =?utf-8?B?aERwRWJlaGlNdzJyK05uNmcvT3MzNkNKM0VHSW9mNFJEb0dEeEVoVHdSMEVO?=
 =?utf-8?B?ZHVULzlNWkdaZ05BblJCQTlGa2MyR2lyS2lSc2J5UHVnQmRaeEVlNlZTNzZN?=
 =?utf-8?B?MFhpNzdIRlNjT3lyeUFMMUl6cnNqTXEyR0lEVVc5UVBmYkxDQUE1UVlTcGxm?=
 =?utf-8?B?cHBaWk0yUHk3SlVLandvM0NvRnRDcjFWdWhac3FudkkwRmpNU005VmxycVpR?=
 =?utf-8?B?QmlqdFFiaGVkbmNSTkdEcWZ5U0RXdy94cWcyWmVhNnhUdHl6MjI0R3A0RWRO?=
 =?utf-8?B?TCtiSlluL0dUVHBQaU1ZVW4vTjE0eVY4RjloSXdjSFBQaDVaWVB1UVkwZlRK?=
 =?utf-8?B?dkRjdUhOQUNmUVFwYi9TTjZhY2dLME5RSUZqM3pKS2JTbElyZ09PaWdGTG45?=
 =?utf-8?B?VkJMcld4MUtPRG81aWlaQjQ4WG55eDBIY0UxQ2NMTnJmOXVCenJsK082dFFM?=
 =?utf-8?B?Zk1JK2ZieXlrQzAzNy9VblpmR1BIN1RpUnpVbjZlY2Zvd0dLR1AydFJXelBU?=
 =?utf-8?B?NVlGQ2l3WnZSTUNJMFdVck5CRkVOdkdTQXo2Tzl1bXhNdWVKZ2lUQXJLVk5h?=
 =?utf-8?B?SXpXUU5VcGluMDNmTVpmUE1SMkRrc1BGSHFuajVQMWFLWWZKQXE4UmxYdTRD?=
 =?utf-8?B?aGxnVTl4SmduY1BXTlJGa0QxcmlaWnBzNWVTVDYrMWlrZ2ZwQm1QUndKVnQ2?=
 =?utf-8?B?YkZRNVFiaE1pNFhZSjBMNHl0d21HRTloQ0YzRG9tTGNKdTRKYTBQSjdwaVRQ?=
 =?utf-8?B?UVlHZGNxNHZJQlBTL1N6NGU1WnVJQ01IUVUyRGllQmpjTzAvbFpmY2Vjbytk?=
 =?utf-8?B?WWV5b0JtYkRMZHhDREl6QzdjQTkraDlEUm1kRUVVM3hQRnhlaVZkeVc0YXFm?=
 =?utf-8?B?Sm45ZGxLOEhCaG8yckV1VnJQRHNYT0FiZWt3MjZhdTlNQ3c0cC9ad2RySWFs?=
 =?utf-8?B?UFl3SStLUVRRNlBQdGY4a1dqaW1JUW8waUFGWTUvcXBueW9Mb0hRMnJRYkl3?=
 =?utf-8?B?OHhwNW1IRFo2S2xodFJZZG0xR0MvM3g5cVhQUnNVYjQyTC85N0RBbFhOT1Ft?=
 =?utf-8?B?ai9iR0xnUlZzZ0JrdWgzT0xFVVJxOEQzUXB6cTJ5Q1ZoSkZqd2NXRHplTy9z?=
 =?utf-8?B?amM2QUFBbjVpMGRUcFFiZWF0NTExdTNiRUhJSDBXSE5OT3IyNUNmNEkyWVh6?=
 =?utf-8?B?Z1NreGtGWEpFYnRRbnI5U1J4QkpFNXNTNHdNMkJyZXg1eUtLMFl1RkNtbFhk?=
 =?utf-8?B?Q3VzSWlwZ3FBaHNnZlZydlkybUFwU0xHemw2QU1NSVRBZzB1b3IyUDM4cWo5?=
 =?utf-8?B?SHVRWXE4L0I5QzM3SHA4bmo3M3JGZXNzZHkwTHZmbkxaWC84dFZoRXZiK01O?=
 =?utf-8?B?bmZzQlNYc1pOMyt4U29wN0JRbzZxMGI1VXkyeWo5eUlvZEZwMDU1T0EwM2Q2?=
 =?utf-8?B?MEE2NXUxZStKeEhHdU1qUGpTWE93QWg0M21JcVB0dlR0QUdEQjFpZjFtYWdY?=
 =?utf-8?B?THAyQ25OR05SbFU0ckRGckpLZTVHc1M2ZUFXT2FUczBlRm9rZmVQeUR1M1ZZ?=
 =?utf-8?B?RlBqanUxSUZHZFJpUVB3ZVdneVIzR0pNMXlkUlRyM3Fzb0FWRGNxb1N0cHlL?=
 =?utf-8?B?REVTREFyUi8xOXpEQklIRHFMem9Qc1hnUW5CdEJ3dTBOMFEyRzd5M1VjMXJV?=
 =?utf-8?B?SjBlNXZobWxmYUJZSk8yMnZOU2JYK0FrK0hoQStPRzVXeExPS2pTZGpMb0sz?=
 =?utf-8?Q?VmTDHMkNDd+oEpold94PUcslH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b0c8fb-91e5-46ee-6559-08dbd615ee50
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 11:23:08.3594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjAQkv6DSF3dZnTwMIb0AzZ+mKUaDm+BjLYKvZLI+6X1+JFDtUFjrsO5i3mW+CJYiMAiSMwGCsNZqT5VTVlWIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6837
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE9jdG9iZXIgNCwgMjAyMyAxMjowNiBQTQ0KPiBUbzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3Vw
dGFAbnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IENjOiBzaGF3bmd1
b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7IGNsaW5Ac3VzZS5jb207IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IHBpZXJyZS5nb25k
b2lzQGFybS5jb207IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC0NCj4g
aW14QG54cC5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0OyBrcnp5c3p0b2Yua296bG93c2tpK2R0
QGxpbmFyby5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBHYXVyYXYgSmFpbiA8Z2F1cmF2LmphaW5AbnhwLmNvbT47DQo+IGFsZXhhbmRlci5zdGVpbkBl
dy50cS1ncm91cC5jb207IFZhcnVuIFNldGhpIDxWLlNldGhpQG54cC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbRVhUXSBSZTogW1BBVENIIHY2IDAyLzExXSBkdC1iaW5kaW5nczogYXJtOiBmc2w6IGFk
ZCBpbXgtc2UtZncNCj4gYmluZGluZyBkb2MNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0
ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBv
cGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNp
bmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMDQvMTAv
MjAyMyAwNjoxMCwgUGFua2FqIEd1cHRhIHdyb3RlOg0KPiANCj4gPj4NCj4gPj4+ICsgICAgJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0KPiA+Pj4g
Kw0KPiA+Pj4gK3JlcXVpcmVkOg0KPiA+Pj4gKyAgLSBjb21wYXRpYmxlDQo+ID4+PiArICAtIG1i
b3hlcw0KPiA+Pj4gKyAgLSBtYm94LW5hbWVzDQo+ID4+PiArICAtIGZzbCxtdS1pZA0KPiA+Pg0K
PiA+PiBIb3cgaXMgbWVtb3J5LXJlZ2lvbiBvcHRpb25hbD8NCj4gPiBEZXBlbmRpbmcgb24gdGhl
IHR5cGUgb2YgZW5jbGF2ZSBJUCBhbmQgdGhlIEZXLCBtZW1vcnktcmVnaW9uIGlzDQo+IGNvbmZp
Z3VyZWQgb3B0aW9uYWxseS4NCj4gPiBGb3IgaS5NWDhVTFAgYW5kIGkuTVg5MywgaXQgaXMgcmVx
dWlyZWQuIEZvciBpLk1YOERYTCwgaXQgaXMgbm90IHJlcXVpcmVkLg0KPiANCj4gVGhlbiB3cml0
ZSBpdCBpbiB0aGUgYmluZGluZ3MgaW4gYWxsT2Y6aWY6dGhlbjouDQpBY2NlcHRlZC4NCg0KPiAN
Cj4gPj4NCj4gPj4+ICsNCj4gPj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPj4+
ICsNCj4gPj4+ICtleGFtcGxlczoNCj4gPj4+ICsgIC0gfA0KPiA+Pj4gKyAgICBlbGVfZnc6IHNl
LWZ3IHsNCj4gPj4NCj4gPj4gRHJvcCB1bnVzZWQgbGFiZWxzLg0KPiA+IEkgYW0gc29ycnksIGlm
IEkgYW0gbm90IGFibGUgdG8gdW5kZXJzdGFuZCB5b3VyIHBvaW50IGhlcmUuDQo+ID4gQnV0LCBh
bGwgdGhlIGJlbG93IGxhYmVscyBhcmUgZ2V0dGluZyB1c2VkLg0KPiA+IEkgY2FuIHJlbW92ZSB0
aGUgZnNsLG11LWlkLiBXaWxsIGRvIGl0IGluIFY3Lg0KPiANCj4gQ29tbWVudCB3YXMgYWJvdXQg
bGFiZWxzLCBub3QgcHJvcGVydGllcy4NClRoZSBsYWJlbCAiZWxlX2Z3IiwgaXMgbmVlZGVkIHRv
IGJlIHBsYWNlZCBpbiBkaWZmZXJlbnQgRFRTSSBmaWxlLg0KDQpGb3IgaW5zdGFuY2UsIG5vZGUg
aXMgYWRkZWQgaW4gaS5teDkzLmR0c2kuDQpVc2luZyBsYWJlbCwgdGhlIG1lbW9yeS1yZWdpb24g
cHJvcGVydHkgZGVwZW5kZW50IG9uIHNpemUgb2YgRERSIG9uIHRoZSBwbGF0Zm9ybSwgaXMgcGxh
Y2VkIGluOg0KDQotIGlteDkzLTExeDExLWV2ay5kdHMNCiANCg0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCg0K
