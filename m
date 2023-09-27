Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5BC7AF842
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjI0Cme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjI0Ckc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:40:32 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD194C26;
        Tue, 26 Sep 2023 19:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZLsmyHbsABLYSenuQvMvnWP8v8RNzbLwks1CsoO+6XBStzqpXAel0O++ZQoFOXgmF6EUShGdAmpx6cQm+78CrqDNSUFMrkW1nSp/RfCaX9F/mN25jfyeuSBzwym1AH9z+MQphTxr1vG4PqrwVty6f/vNunIx2vXuZS3kVPy0Aoryp+qiiN/EnZpwCi/pU10wckuRYvqisiFjo6kfzIk2AEYNnSyKf2uUYw31vd8n7POj8aQRFr5q+dvWuEqpOeps9vPjlHxuYv0o5e0Ngz893+ac40bg+A3ukWzTtPhUAJOkjkbIurPBTKucCouNqdiqOZd8I++PFYdyFY4dfrFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUmjkpQyfaDTCzDjpm0sLNg9xLqdKDP80Qzo67y3iz0=;
 b=nHyxON23d9RyhZgAKzhvGQk/Un43zbGKjkN4fYWKNWJEyxIm18bvhQxVGKEfDeY9JauzpWRkkjvd/eisZRFOU448Dc5YZpsNd31D9FWmwLVC85M6a0CeV5rTOKdi+8jEivUPi1igh06MLRXLk1b5IeE4H/Foqa62v38YsA/ARwNuR/C9TDFUF+8q+benqVtF1aF6reG/1A8QIsyuNAOCw/h68LfTE58hWg+iCvBmJvwgm8mymssSJdPh3yT2L9hKcpv5pmbS44ZeSv1WsX6j+znFVdDOAdi6h5QRyg3PftRcK1IaVL30W7b4PrgB312EyRnilDyZYgFBTvkO8GUERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUmjkpQyfaDTCzDjpm0sLNg9xLqdKDP80Qzo67y3iz0=;
 b=BU5uwxZChjAE9gULLGGHyNYjo0F/0cRvzsVZ/DFel/yvuONCYdX9Gpm2Jrlk6Ou8Jyl8Y52aMq9hXV60bA88Ihgi22SPQjxKxMDqxlo8GXxuIPXlp7aKdTaCA3gLH8rxTczeGNk5I8YKXO4rqF9fSX1CWFZxlUclFnGhe37OQcQ=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6905.eurprd04.prod.outlook.com (2603:10a6:10:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 02:10:12 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 02:10:11 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Conor Dooley <conor@kernel.org>
CC:     "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Index: AQHZ8GGrmZBLZQgREEat4sCPmu/sQrAtGSWAgADFGZA=
Date:   Wed, 27 Sep 2023 02:10:11 +0000
Message-ID: <AM6PR04MB6341B0D9EC8146149CF8ADB0E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
 <20230926-slackness-target-b74e33ab1031@spud>
In-Reply-To: <20230926-slackness-target-b74e33ab1031@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DB8PR04MB6905:EE_
x-ms-office365-filtering-correlation-id: 543f6b49-6cf6-47e6-5ac7-08dbbefee171
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zAbBIfyPALVxR5oikw9KRjPjQofmZHHTk05jGObBK1NoIvkgonEzM7W5TAQRrrBKeBiRxmm9iu7ljL3rXgidMlTz6L5FOgLhOc1c2NGOnrhI2k/0JmZ5SCNSx7TANJhAcUW/otNrNkFad4ZDQJ5BvH4X6c1oXOxaVt88dcyHobvZo2lQ1N+SXoDZiC9Y8N+ini4TrJs8ITACsymIyhrNTej0jrYKnvJmiE/XENwdzzV1yYkVpI9x+ZGnx3ybX5y1H5WDXV83QYxcpBhU0gYjnL8U+OHUVGg16Aza/XIkjW5yG9U1/2fr+7tgSkKDpsw3gg/DQlVTgNRUVkcwgKych0NfsuS5VQmtwW/DfXyxrV5qmbmBVLZvMRp272eS8cU50S51mekzjucyc8cBfaiLjNYBN6Vq/XwVRAm9sMOg2Ya2hibCo7eNFkcFXxcObR2l1VjUz0uxaghaaj8heqIQIMfyBJHo61acPZYcczOU6/lw8lz6uLtPr3Hs1meibXV+VkE7EQrlbIxOeCOoUiTMzQ+zYwSz6Uao1Q7pf+YvQaghCpp416l8mljaryFbRAf8TLINvqVUXo8r23dd4/c2DpQ7lqe8MvcJ46qkZX9OHjo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(41300700001)(8676002)(55016003)(4326008)(8936002)(6916009)(7416002)(66476007)(66556008)(54906003)(66446008)(66946007)(64756008)(316002)(26005)(52536014)(44832011)(76116006)(86362001)(966005)(2906002)(122000001)(478600001)(33656002)(9686003)(38070700005)(38100700002)(71200400001)(83380400001)(6506007)(7696005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?T05DcDN6ZDBsN3BFK0tWNnlDaURaOFpscXB4OEJMSmplUExubXEzckszRmcr?=
 =?gb2312?B?dzB1VW5IbWRNdnoyUEpObGM4YkdtdWJXbTlWdEZ2cllRcHdJVG9DRWszeHl6?=
 =?gb2312?B?cERhdU5aSjRPZkptMm11a1FuZ1FiTGR1LzlOMHdTYzhLY0I2MVJuWWk3RVRY?=
 =?gb2312?B?WmVqVEVvY2s4RXBUazQzbmU5UUxYbWluUmNBV1l0dWNydnNPUll5VzZKOEs4?=
 =?gb2312?B?QTJPcnpkZUt1eGtWdVlEREg2S3UxYjEvQlBsM3NxTjQyS0JLMnlHU2NNQWxU?=
 =?gb2312?B?UitMYTVMWjh3TFlCNVh6SGlzUHlVYk9sTXF1UHpTUU1TYk8wWlExMS9CSzRI?=
 =?gb2312?B?WWZGcm1BanlzVkVZaTBpNEUrNmhZa1ZKMUp1YVlLSjBrSUdCWnRlQ1F4Zkwx?=
 =?gb2312?B?azhEanNVRmVmY0FvdVFFcEZDbndpdVhrVVdsUVZ0TzF4NWlaMER5T0NhR2tC?=
 =?gb2312?B?UG40L0ZvR2FNOWpNbWVlZi91TWRuWVlaUDVIYk9KbklHdDVHUUFpQ2RjdjVh?=
 =?gb2312?B?NkpDelVqNGNYb3cxakNlOG1HcWErQ0l6a2RHMGxwR3hFQlhNV2lNbHRwNkpQ?=
 =?gb2312?B?bjdtR09tbVRQWGJzNnA1ZHo5Z2lRTXhQaE4rcTJpMTI5MjZaSUN2N3ZLYnhn?=
 =?gb2312?B?bDgyei9PTUMxUU9NV0hqRkgvejQ3bUV4V1ZPMnVoZHBjT1htWFUvak95blN3?=
 =?gb2312?B?MXlNa2dSZXJsWkowTlpwQjR1RC9UMXNvZ0xtemhRaUpjUnJqeGU0TGwzRHBL?=
 =?gb2312?B?M01qaHVWVlZ2TUVWb0U1TkM1bEJOc2tOTUFzYkRXM1VETExWV0ZkU1oxanBu?=
 =?gb2312?B?TDFwVEZ5U0I5d2VBaE5TYmU2QmMzclF4aG41YkVQL25qN3NMdEVwWHZwY2M0?=
 =?gb2312?B?VGVIYkJ6VG1McHlVMHBLc3FHeU8venBuNmFLSEJEMDFVcGppSFhuZURtMHZH?=
 =?gb2312?B?Y2pDSHdjbEhTK2pVL3krbGdCT2dTSElBbEJmd0hibmMwdEl5SnFPVWc3WmZ4?=
 =?gb2312?B?eVZ6SGdQZUJvQW5GYktDalZoZFRNcXRramU5QSs4YzNMbUdBSUNUdGxPYVd4?=
 =?gb2312?B?NXg2VVJDaW1GSzdMRk51M2lLRkNNSFlPSDg0NTd6eFFsNXpKVEI4UzJlUk1V?=
 =?gb2312?B?WHEvV1VicmVKdmx6OFN4VkJxVFd5dFVmenlRSkx1dStPTWtVOXY1dDFxUVFh?=
 =?gb2312?B?UDcyUHhRQ0t4SW5uNzRxVndFMXd2T0daelFvV2hwZ3k0Qloza0o1NlA3MlNB?=
 =?gb2312?B?endwR1l6NDFIR3dFbkgrWm1LOE1Wb3JYcnRPWHlydm9XUCtHczhhQ2xUa2ly?=
 =?gb2312?B?ZjVyTGpTRHpQRTlKemtGQlhsSkE1NkUyaGYvVmxWaHRubmdMazJZQWlrSzRr?=
 =?gb2312?B?SHVuL2xpWDRSWExEK1FVdCtpL2cvUGRxcmMyd1pRSFk0aWRtR1RPaFA3K001?=
 =?gb2312?B?bUw5TklTeHM2a2lOZ1lxVUlaNlNZRTQvK09scVYyQzlPeG16ZXFpV1ZQRnZH?=
 =?gb2312?B?QTBFMFg0R21UcmdscEtDYUVEb1l1eHFKL1RUNmZHSnNLd2YyRFZ3ZFFWRUEr?=
 =?gb2312?B?N243blllc2FwcjBiczNWWVpOQnR2amZvWERTUHU1a0dEOS83aDBRU25SMnVR?=
 =?gb2312?B?Nk1taE5hczlzWFJKaDlJU1ppdnlla2lGNE9uTnRzM0RNeTBKNmFMVTFYYUtX?=
 =?gb2312?B?amlBQkpGdjM3ekxVQWc2aVk3OWpUdTk2WWVNbG45OUhDV1duenZkTTNYQ3Iw?=
 =?gb2312?B?dFZTZ3A1ekYxVU04elVybFd4RGVFcU4rOEJkRmMyeGoxNXd6RmQ1Y1dKaDlO?=
 =?gb2312?B?a2VrNVR6SUlrOVZJelhxYy94ZE1WbS95b1pLaGc4Q0htL282MThHcFNBajZj?=
 =?gb2312?B?ZUQyMDdzemI3WVJQQXJLVXFoTldkdXhPcWNlM0lWV1hnSG85b1FWbkp6MllN?=
 =?gb2312?B?djhrdmwyNFFNVUVpSnc1OGFzMmpGWnNaSmlJMEpuN09wRDdZejI3Tkprajhv?=
 =?gb2312?B?Tm5OczNnWFRDcXU5U0JpWnNzWTBKNEtYN0tLTjRYdlpBc3hOc1ozYnpFMEt4?=
 =?gb2312?B?Rll1UnB2VFN6ZjRPTVZTZHRyOWNIZEVnMlRkS2crWDI2WGRVeEs1Tnd6ajdn?=
 =?gb2312?Q?W//w=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543f6b49-6cf6-47e6-5ac7-08dbbefee171
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 02:10:11.6188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggT1w8NfvEAsSwx6eHSScK9OqEKOPI7xFu+qjFzl9TYY623yS5a0eBAqPxemqjWN/fE8+wZVbfiM1B8ZC0gf7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6905
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IENvbm9yIERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz4NCj5TZW50OiAyMDIzxOo51MIy
NsjVIDIxOjI2DQo+VG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQo+Q2M6IE1pcmVs
YSBSYWJ1bGVhIChPU1MpIDxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT47DQo+cm9iaCtkdEBr
ZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPmtyenlzenRvZi5rb3psb3dza2krZHRA
bGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj5tY2hlaGFiQGtlcm5lbC5vcmc7IGh2
ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubDsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj5rZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgWC5ILiBCYW8NCj48eGlhaG9uZy5i
YW9AbnhwLmNvbT47IEVhZ2xlIFpob3UgPGVhZ2xlLnpob3VAbnhwLmNvbT47IFRhbyBKaWFuZw0K
Pjx0YW8uamlhbmdfMkBueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
DQo+ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+U3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2NCAyLzJdIGR0LWJp
bmRpbmdzOiBtZWRpYTogaW14LWpwZWc6IEFzc2lnbiBzbG90IGZvcg0KPmlteCBqcGVnIGVuY29k
ZXIvZGVjb2Rlcg0KPg0KPkhpLA0KPg0KPk9uIFR1ZSwgU2VwIDI2LCAyMDIzIGF0IDA2OjEwOjAw
UE0gKzA4MDAsIE1pbmcgUWlhbiB3cm90ZToNCj4+IFRoZXJlIGFyZSB0b3RhbCA0IHNsb3RzIGF2
YWlsYWJsZSBpbiB0aGUgSVAsIGFuZCB3ZSBvbmx5IG5lZWQgdG8gdXNlDQo+PiBvbmUgc2xvdCBp
biBvbmUgb3MsIGFzc2lnbiBhIHNpbmdsZSBzbG90LCBjb25maWd1cmUgaW50ZXJydXB0IGFuZA0K
Pj4gcG93ZXIgZG9tYWluIG9ubHkgZm9yIDEgc2xvdCwgbm90IGZvciB0aGUgYWxsIDQgc2xvdHMu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4+
IC0tLQ0KPj4gdjQNCj4+IC0gaW1wcm92ZSBjb21taXQgbWVzc2FnZQ0KPg0KPj4gLSBkb24ndCBt
YWtlIGFuIEFCSSBicmVhaw0KPg0KPldoYXQgZG9lcyB0aGlzIG1lYW4/IENhbiB5b3UgcGxlYXNl
IHRyeSB0byBleHBsYWluIHRoaW5ncyBhIGJpdCBtb3JlIGNsZWFybHkNCj5pbiB5b3VyIGNoYW5n
ZWxvZ3M/DQo+DQo+QWxzbywgd2hlcmUgaXMgdGhlIGNvZGUgdGhhdCBhY3R1YWxseSBtYWtlcyB1
c2Ugb2YgdGhlc2UgcHJvcGVydGllcz8NCg0KSW4gdjMgcGF0Y2gsIEkgbWFrZSB0aGlzIHByb3Bl
cnR5IHJlcXVpcmVkLCBtYWtlIGl0IGFuIEFCSSBicmVhaywgc28gaW4gdjQsIEkgcmVtb3ZlIGl0
IGZyb20gcmVxdWlyZWQsIGFuZCBkZWZhdWx0IHRvIHRoZSBwcmV2aW91cyBiZWhhdmlvciBpZiBp
dCBpcyBtaXNzaW5nLg0KDQpUaGUgY29kZSBwYXRjaCBpcyBzZW50IGJlZm9yZSwgYnV0IHRoZSBk
dHMgY2hhbmdlIGlzIG5vdCBhcHBsaWNhYmxlLCBzbyBJIHNlbmQgaXQgc2VwYXJhdGVseS4gVGhl
IGNvZGUgcGF0Y2ggbGluayBpcyBhcyBiZWxvdzoNCmh0dHBzOi8vcGF0Y2h3b3JrLmxpbnV4dHYu
b3JnL3Byb2plY3QvbGludXgtbWVkaWEvcGF0Y2gvY2RhZGI0YTIzNjk3ZmRjOTdkZWY5NThjNjli
MTJjZDAwZjU0NzIxMi4xNjg1NDMwODQxLmdpdC5taW5nLnFpYW5AbnhwLmNvbS8NCg0KQnV0IGlu
IHRoZSBwYXRjaCwgdGhlIHByb3BlcnR5IG5hbWUgaXMgInNsb3QiLCBub3QgIm54cCxzbG90Iiwg
SSB3aWxsIG1ha2UgYW5vdGhlciBwYXRjaCB0byBmaXggdGhlIHByb3BlcnR5IG5hbWUgYWZ0ZXIg
dGhpcyBwYXRjaCBpcyByZXZpZXdlZC4NCg0KPg0KPj4gdjMNCj4+IC0gYWRkIHZlbmRlciBwcmVm
aXgsIGNoYW5nZSBwcm9wZXJ0eSBzbG90IHRvIG54cCxzbG90DQo+PiAtIGFkZCB0eXBlIGZvciBw
cm9wZXJ0eSBzbG90DQo+Pg0KPj4gIC4uLi9iaW5kaW5ncy9tZWRpYS9ueHAsaW14OC1qcGVnLnlh
bWwgICAgICAgICB8IDQ1ICsrKysrKysrKy0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwg
MjEgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdA0KPj4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55
YW1sDQo+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9ueHAsaW14
OC1qcGVnLnlhbWwNCj4+IGluZGV4IDNkOWQxZGIzNzA0MC4uNGJjZmM4MTVjODk0IDEwMDY0NA0K
Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL254cCxpbXg4
LWpwZWcueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21l
ZGlhL254cCxpbXg4LWpwZWcueWFtbA0KPj4gQEAgLTMyLDE5ICszMiwyNiBAQCBwcm9wZXJ0aWVz
Og0KPj4gICAgICBtYXhJdGVtczogMQ0KPj4NCj4+ICAgIGludGVycnVwdHM6DQo+PiAtICAgIGRl
c2NyaXB0aW9uOiB8DQo+PiAtICAgICAgVGhlcmUgYXJlIDQgc2xvdHMgYXZhaWxhYmxlIGluIHRo
ZSBJUCwgd2hpY2ggdGhlIGRyaXZlciBtYXkgdXNlDQo+PiAtICAgICAgSWYgYSBjZXJ0YWluIHNs
b3QgaXMgdXNlZCwgaXQgc2hvdWxkIGhhdmUgYW4gYXNzb2NpYXRlZCBpbnRlcnJ1cHQNCj4+IC0g
ICAgICBUaGUgaW50ZXJydXB0IHdpdGggaW5kZXggaSBpcyBhc3N1bWVkIHRvIGJlIGZvciBzbG90
IGkNCj4+IC0gICAgbWluSXRlbXM6IDEgICAgICAgICAgICAgICAjIEF0IGxlYXN0IG9uZSBzbG90
IGlzIG5lZWRlZCBieSB0aGUgZHJpdmVyDQo+PiAtICAgIG1heEl0ZW1zOiA0ICAgICAgICAgICAg
ICAgIyBUaGUgSVAgaGFzIDQgc2xvdHMgYXZhaWxhYmxlIGZvciB1c2UNCj4+ICsgICAgZGVzY3Jp
cHRpb246DQo+PiArICAgICAgSW50ZXJydXB0IG51bWJlciBmb3Igc2xvdA0KPj4gKyAgICBtYXhJ
dGVtczogMQ0KPg0KPlNvLCB3aGF0IGhhcHBlbnMgdG8gdXNlcnMgdGhhdCBhbHJlYWR5IGV4aXN0
IHRoYXQgaGF2ZSAyLCAzIG9yIDQgaW50ZXJydXB0cz8NCj5Zb3VyIGNvbW1pdCBtZXNzYWdlIHNh
eXM6DQoNCkFuZCBjdXJyZW50bHkgdGhlIGFuc3dlciBpcyB0aGF0IGlzIGluYXBwcm9wcmlhdGUg
YmVoYXZpb3IsICBidXQgdGhlcmUgaGFzIGJlZW4gbm8gcmVhbCBuZWdhdGl2ZSBpbXBhY3QuIEFz
IHdlIG5vdyBoYXZlIG5vIHByYWN0aWNhbCBhcHBsaWNhdGlvbiB0byB1c2Ugb3RoZXIgc2xvdHMs
IG5vdyB3ZSBqdXN0IHdhbnQgdG8gbWFrZSBhbGwgdGhlIDQgc2xvdHMgY29uZmlndXJhYmxlIGFu
ZCB3b3JrYWJsZS4NCg0KPj4gVGhlcmUgYXJlIHRvdGFsIDQgc2xvdHMgYXZhaWxhYmxlIGluIHRo
ZSBJUCwgYW5kIHdlIG9ubHkgbmVlZCB0byB1c2UNCj4+IG9uZSBzbG90IGluIG9uZSBvcywgYXNz
aWduIGEgc2luZ2xlIHNsb3QsIGNvbmZpZ3VyZSBpbnRlcnJ1cHQgYW5kDQo+PiBwb3dlciBkb21h
aW4gb25seSBmb3IgMSBzbG90LCBub3QgZm9yIHRoZSBhbGwgNCBzbG90cy4NCj4NCj5Ob3RlIHRo
YXQgIm9ubHkgbmVlZCB0byB1c2Ugb25lIiBkb2Vzbid0IG1lYW4gdGhhdCBhIHVzZXIgbWlnaHQg
bm90IHdhbnQgdG8NCj51c2UgbW9yZSB0aGFuIG9uZS4gSXMgaXQgcG9zc2libGUgdG8gdXNlIG1v
cmUgdGhhbiBvbmUgc2xvdD8NCj4NCj5BbHNvLCBpZiB0aGUgaW50ZXJydXB0IG51bWJlcnMgbWFw
IDE6MSB0byBzbG90cywgYXMgdGhlIHByZXZpb3VzIGJpbmRpbmcgc3RhdGVzLA0KPndoeSBkbyB5
b3UgZXZlbiBuZWVkIHRoaXMgbmV3ICJueHAsc2xvdCIgcHJvcGVydHk/DQo+DQo+VGhhbmtzLA0K
PkNvbm9yLg0KPg0KDQpUaGUgcHVycG9zZSBvZiA0IHNsb3RzIGlzIHRvIHN1cHBvcnQgbXVsdGkg
dm0gb3Igb3MsIE11bHRpcGxlIHNsb3RzIGFyZSB0aW1lLXNoYXJpbmcgdGhlIHNhbWUganBlZyBl
bmdpbmUsIHRoZXJlIGlzIG5vIGJlbmVmaXQgdG8gZW5hYmxpbmcgbXVsdGlwbGUgc2xvdHMgaW4g
b25lIG9zLCBpdCB3b24ndCBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSwgYnV0IGl0IGp1c3QgYWRk
cyBjb21wbGV4aXR5IHRvIHRoZSBjb2RlLg0KU28gd2UnZCBsaWtlIHRvIG9ubHkgdXNlIDEgc2xv
dCBpbiBsaW51eCwgVGhlbiwgdGhlb3JldGljYWxseSwgd2UgY2FuIHN1cHBvcnQgdXAgdG8gMyBW
TVMuDQoNCkluIHByZXZpb3VzIGltcGxlbWVudGF0aW9uLCB0aGUgZHRzIGNvbmZpZ3VyZWQgYWxs
IHRoZSBpbnRlcnJ1cHRzIGFuZCBwb3dlci1kb21haW5zIGZvciA0IHNsb3RzLCBidXQgaW4gZHJp
dmVyIGNvZGUsIG9ubHkgc2xvdCAwIGlzIHVzZWQsIHRoZSByZXN1bHQgaXMgdGhlIHNsb3QgMSwy
LDMgYXJlIG5vdCB1c2FibGUsIG90aGVyd2lzZSBpdCB3aWxsIGNhdXNlIGNvbmZsaWN0DQoNCklm
IHNvbWVvbmUgaGFzIHRvIGVuYWJsZSAyIHNsb3RzIGluIGxpbnV4LCBoZSBjYW4gZGVmaW5lIDIg
ZGV2aWNlIG5vZGUgd2l0aCBkaWZmZXJlbnQgc2xvdCBpbmRleCBpbiBkdHMuICBCdXQgdGhpcyBp
cyBub3Qgd2hhdCB3ZSBleHBlY3QuDQoNClRoaXMgSVAgZGVmaW5lZCBzZXBhcmF0ZSBpbnRlcnJ1
cHQgbnVtYmVyIGZvciBlYWNoIHNsb3QsIGJ1dCBpdCBkb2Vzbid0IGRlZmluZSBzZXBhcmF0ZSBy
ZWdpc3RlciByZWdpb24gZm9yIGVhY2ggc2xvdC4gSXQgc2ltcGx5IGRlZmluZXMgYSBzZXQgb2Yg
cmVnaXN0ZXJzIGZvciBzbG90cywgc28gZHJpdmVyIG5lZWQgdGhlIHNsb3QgaW5kZXggdG8gY29u
ZmlndXJlIHJlZ2lzdGVyIGNvcnJlY3RseS4NClRoaXMgSVAgaXMgcmV1c2VkIG9uIG91ciBvdGhl
ciBwbGF0Zm9ybSwgc28gdGhlIGludGVycnVwdCBudW1iZXIgaXMgbm90IGEgZml4ZWQgdmFsdWUg
Zm9yIGEgY2VydGFpbiBzbG90LiBTbyBJIHRoaW5rIGl0J3Mgbm90IGEgZ29vZCB3YXkgdG8gY29u
dmVydCB0aGUgaW50ZXJydXB0IG51bWJlciB0byBzbG90IGluZGV4Lg0KDQpCZXN0IHJlZ2FyZHMs
DQpNaW5nDQoNCg0KPj4NCj4+ICAgIHBvd2VyLWRvbWFpbnM6DQo+PiAgICAgIGRlc2NyaXB0aW9u
Og0KPj4gICAgICAgIExpc3Qgb2YgcGhhbmRsZSBhbmQgUE0gZG9tYWluIHNwZWNpZmllciBhcyBk
b2N1bWVudGVkIGluDQo+PiAgICAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3Bvd2VyL3Bvd2VyX2RvbWFpbi50eHQNCj4+IC0gICAgbWluSXRlbXM6IDIgICAgICAgICAgICAg
ICAjIFdyYXBwZXIgYW5kIDEgc2xvdA0KPj4gLSAgICBtYXhJdGVtczogNSAgICAgICAgICAgICAg
ICMgV3JhcHBlciBhbmQgNCBzbG90cw0KPj4gKyAgICBtaW5JdGVtczogMSAgICAgICAgICAgICAg
ICMgVlBVTUlYDQo+PiArICAgIG1heEl0ZW1zOiAyICAgICAgICAgICAgICAgIyBXcmFwcGVyIGFu
ZCAxIHNsb3QNCj4+ICsNCj4+ICsgIG54cCxzbG90Og0KPj4gKyAgICAkcmVmOiAvc2NoZW1hcy90
eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4+ICsgICAgZGVzY3JpcHRpb246DQo+PiAr
ICAgICAgSW50ZWdlciBudW1iZXIgb2Ygc2xvdCBpbmRleCB1c2VkLiBUaGVyZSBhcmUgNCBzbG90
cyBhdmFpbGFibGUgaW4gdGhlIElQLA0KPj4gKyAgICAgIGFuZCBkcml2ZXIgY2FuIHVzZSBhIGNl
cnRhaW4gc2xvdCwgaXQgc2hvdWxkIGhhdmUgYW4gYXNzb2NpYXRlZCBpbnRlcnJ1cHQNCj4+ICsg
ICAgICBhbmQgcG93ZXItZG9tYWluLiBJbiB0aGVvcnksIGl0IHN1cHBvcnRzIDQgb3Mgb3Igdm0u
IElmIG5vdCBzcGVjaWZpZWQsIDANCj4+ICsgICAgICBpcyB1c2VkIGJ5IGRlZmF1bHQuDQo+PiAr
ICAgIG1pbmltdW06IDANCj4+ICsgICAgbWF4aW11bTogMw0KPj4NCj4+ICByZXF1aXJlZDoNCj4+
ICAgIC0gY29tcGF0aWJsZQ0KPj4gQEAgLTYyLDI4ICs2OSwxOCBAQCBleGFtcGxlczoNCj4+ICAg
ICAganBlZ2RlYzoganBlZ2RlY0A1ODQwMDAwMCB7DQo+PiAgICAgICAgICBjb21wYXRpYmxlID0g
Im54cCxpbXg4cXhwLWpwZ2RlYyI7DQo+PiAgICAgICAgICByZWcgPSA8MHg1ODQwMDAwMCAweDAw
MDUwMDAwID47DQo+PiAtICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzA5IElSUV9UWVBF
X0xFVkVMX0hJR0g+LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDMxMCBJUlFf
VFlQRV9MRVZFTF9ISUdIPiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSAzMTEg
SVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+PiAtICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkg
MzEyIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNf
U1BJIDMwOSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+ICAgICAgICAgIHBvd2VyLWRvbWFpbnMg
PSA8JnBkIElNWF9TQ19SX01KUEVHX0RFQ19NUD4sDQo+PiAtICAgICAgICAgICAgICAgICAgICAg
ICAgPCZwZCBJTVhfU0NfUl9NSlBFR19ERUNfUzA+LA0KPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgIDwmcGQgSU1YX1NDX1JfTUpQRUdfREVDX1MxPiwNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICA8JnBkIElNWF9TQ19SX01KUEVHX0RFQ19TMj4sDQo+PiAtICAgICAgICAgICAgICAgICAg
ICAgICAgPCZwZCBJTVhfU0NfUl9NSlBFR19ERUNfUzM+Ow0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgIDwmcGQgSU1YX1NDX1JfTUpQRUdfREVDX1MwPjsNCj4+ICsgICAgICAgIG54cCxzbG90
ID0gPDA+Ow0KPj4gICAgICB9Ow0KPj4NCj4+ICAgICAganBlZ2VuYzoganBlZ2VuY0A1ODQ1MDAw
MCB7DQo+PiAgICAgICAgICBjb21wYXRpYmxlID0gIm54cCxpbXg4cW0tanBnZW5jIiwgIm54cCxp
bXg4cXhwLWpwZ2VuYyI7DQo+PiAgICAgICAgICByZWcgPSA8MHg1ODQ1MDAwMCAweDAwMDUwMDAw
ID47DQo+PiAtICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzA1IElSUV9UWVBFX0xFVkVM
X0hJR0g+LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDMwNiBJUlFfVFlQRV9M
RVZFTF9ISUdIPiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSAzMDcgSVJRX1RZ
UEVfTEVWRUxfSElHSD4sDQo+PiAtICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkgMzA4IElS
UV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDMw
NSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+ICAgICAgICAgIHBvd2VyLWRvbWFpbnMgPSA8JnBk
IElNWF9TQ19SX01KUEVHX0VOQ19NUD4sDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgPCZw
ZCBJTVhfU0NfUl9NSlBFR19FTkNfUzA+LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgIDwm
cGQgSU1YX1NDX1JfTUpQRUdfRU5DX1MxPiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICA8
JnBkIElNWF9TQ19SX01KUEVHX0VOQ19TMj4sDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
PCZwZCBJTVhfU0NfUl9NSlBFR19FTkNfUzM+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
IDwmcGQgSU1YX1NDX1JfTUpQRUdfRU5DX1MwPjsNCj4+ICsgICAgICAgIG54cCxzbG90ID0gPDA+
Ow0KPj4gICAgICB9Ow0KPj4gIC4uLg0KPj4gLS0NCj4+IDIuMzguMQ0KPj4NCg==
