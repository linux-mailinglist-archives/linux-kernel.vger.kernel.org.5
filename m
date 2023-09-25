Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84BB7AD334
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjIYIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjIYIVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:21:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55DD109;
        Mon, 25 Sep 2023 01:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elsNIPJJfuJ+zQK6xxxo4dIWYvsW3BJCEhGwfQ/7iTrPmn1PoMZcHQnQ5z6BN3+N4ygzAAypl7GpoovtcORo6u9vAREsTF0bwu7lHSox0SW6EXBkQfZnBYyw3sgykbOgyeP3sGq6WK4eKbpqLFhfOZwBIoVRSLZc5bzAAEybev5fXyssbwWyxUhNJV5qhExH4CvwjiwVui+Nvi5dSpJASE11gk7TA3oiVrzkQq6sAYr5Bs08RrXN4QhctZpXlG5q+Jhmh3vlD8S6Nlu/PVfBI/NKlmdygm/slLUyskktdUsF6EntejEOg2ijx8D7b98lOfMfv+Z29zCwcwRAVm+/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOzJQhwNvKbJ3Q9vIOfdYXHiQseisR6cw04n1aOrOf0=;
 b=m/bddPxstw/9Ekx2azbvQgkYFBcnxBrk6d7MfADMz20grWgvnytuEljCZPCWRK6sjAtejts2OFHjvOalAFw2kdkEJlGI+NgufO36BKgVMswCfFs4kumeONqhcaozhbNmTTHhSTzeVIbuZduQ4PCNyNeChycBjLRoJb/LVuiyLJBUgu1BNvAZmeMWDOcz3e3DVgtlgWYA5xygnuvjPJBFJCumi8ZjaWc5j7E8kn2qLHE75OAaw/CGwYvJfyFRkk5jvssfZq3Y7Iudb73Kix4VA7chFmAmKfehOHFdNBcGZHEPAiqJP/3isdeBxBbyPsYwhx/H0jL7R/lx3I7Kh3Ucuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOzJQhwNvKbJ3Q9vIOfdYXHiQseisR6cw04n1aOrOf0=;
 b=rYxnQxmzPs5DcKvfZUMxdpM8sMYwSCXoYZMfKq7z0rM8nU8QRdCM+FG/sSs56uyyunsRUes/5+pLX+JuMa1X8HarAWkvLhZuYEVOsYRNtSHFhJVA0Hg/trSWfh7kmBFfctxFxUqFvNwKPl/JRCyBjiFFx+U3Q0gxSnBi3feZEAs=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB7067.eurprd04.prod.outlook.com (2603:10a6:10:12a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:20:59 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:20:59 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
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
Subject: RE: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Index: AQHZ74PEbqAT2ziWZ0ufS4Z9Kh2CJrArLgAAgAAA7LCAAAFigIAAAItAgAAAtQCAAADVgA==
Date:   Mon, 25 Sep 2023 08:20:59 +0000
Message-ID: <AM6PR04MB6341C8E7553F66695467C398E7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230925074131.10133-1-ming.qian@nxp.com>
 <20230925074131.10133-2-ming.qian@nxp.com>
 <bbc8dd05-8589-44ec-87dd-f2d7b4368245@linaro.org>
 <AM6PR04MB63418AE18D3D0ED98CCC1A0FE7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <751a552e-5209-4d5e-9292-23339a06f8a9@linaro.org>
 <AM6PR04MB63410BEA725DDBF1D1B7814FE7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <10c50df3-9a99-4552-9b25-0844b87e28f5@linaro.org>
In-Reply-To: <10c50df3-9a99-4552-9b25-0844b87e28f5@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DB8PR04MB7067:EE_
x-ms-office365-filtering-correlation-id: 8d79a8ca-4b5f-487b-8047-08dbbda05921
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rzi9ltBbZ2UuNR443rDbgc7F2UZoen9/ZeAbJKKnKwJ9daA9bsmASHkEM073xT97IvSCw6L4YLrzSvqseX9PGbfW8iNsx9aUGA0/CRXxzRlawr9NDPjQ466nj+c5U8k4hgZoA3MuiQ7YVDnwyG45mp7nCcC4oYrkUk+DUIUfg36lORTYmXiBdFVKBPR3uuG17YMyW8gkRuHwrufpPeznY80gPbUIyykNNIFxeIdN5xzIY5Bp1fSRy65y4Oj7NJ1yO3Fkztfh/MvE9nfSsshyE3VE/I+3KE1ZJSwpoFrS0T0oFTEXH8iluaS73/mUdwMRBRcF87yzBknCcnYpb/xDjgV+gOOZXKNVZQsdk4TGoSAyYWB3cts0QlACu27dSO++5aMUshO+yoYQYpTdqTr2P3yKLOmdgWrDJBRMvYwg1V6+a8q9RiJNEXEk1wh50jKVSGs9VZttRT9v98mG5naavBLgHTT8QImQE1Fhx87oufgvBJRuguBPIo+pDrlyMnYtNp0SCv3D/riPVBRspUhtlEw81sAhuxprXV8R3q+LgTaXiOh87xNA4Yz2Bbic4HNFi+PkEr1ZGzG4gl0a0t4unC6DJnPhKIIyt1wLGXtwxcCynkNNS1LIJoTZIw9C7uxC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(186009)(9686003)(7696005)(6506007)(53546011)(86362001)(122000001)(55016003)(38100700002)(38070700005)(33656002)(26005)(7416002)(2906002)(478600001)(71200400001)(83380400001)(8936002)(8676002)(4326008)(5660300002)(52536014)(41300700001)(66446008)(44832011)(66476007)(66556008)(66946007)(110136005)(76116006)(64756008)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmJVQVRjbWtNcHhzMkNUeHB5c2t3dnlIY2tjUW1Ca21aZ0xlMzFPRERqQTZq?=
 =?utf-8?B?aStjT3hxb3VrRlJxY2ZsTU9oSDd6b2hjUG1QbWkrb05mZ3lRWVg2dWZlQzdO?=
 =?utf-8?B?endzTHp6ODlSZjNYcnFvYTliVHAzZXdRUy8xUFN6elVQZDdZQVR4dVdIbmVQ?=
 =?utf-8?B?YXRJM2tUU01VR3FtQkRrczREUVFzWjFWRHBkWHg1Qk16b2JMU0xML0ovYzBL?=
 =?utf-8?B?eWVRQ2JRV0IwRnZyVGNTNDZsOG1wNjlMZFk2WmlNaTBHYkJhc2hjRWdpd2xY?=
 =?utf-8?B?VlNoYTlhQVVSV0QrYndqUTNIU1BpMkJPd2RxRjlSdnZVblkrQzJoQjViSEpu?=
 =?utf-8?B?emx1WCt6a0JqZVNvM0dENkxVNzJkNmxsTS9rZFJWWHliYUtRaVUyMG9xTm1r?=
 =?utf-8?B?TFdFZjVaZEIvKzRnVjFCZncwLzZnN1VVOVViVm91VmlXbjFjcmpKcjlWeFRm?=
 =?utf-8?B?T0FHdXpjdDlFUllrMTFuNU8vMHFpWEdSTlNGZUxWaWEwTHR6anNvb3dvci9m?=
 =?utf-8?B?Um4vdk9tc1d1bk9talBZS3AxZGF4cHgvS1pDbDNjRmlVSUJLZ0RFTVM1U205?=
 =?utf-8?B?aDdWSDNneVk4c3dEVzhCUW41RkI4UFNzdEp4L1Q4UE5GWXJybUxqZUxKMFNo?=
 =?utf-8?B?Q1VXcXlKeDFXR0g1NGdzOGNVQ0JzZWlONzJZcWU3clBDcXBzVnJ1Z25HbVBm?=
 =?utf-8?B?NExOT3hBaUF0N091K0ROeHdrM2lFYXVSMHBlWnJqZ2dGdkpTL0wrejZEdUFF?=
 =?utf-8?B?MGh2cFpHc0lmTTBxKzdOZFVraHVEZEt1MXN0SmVzVWdRdGlRa0V0T3k4RzM4?=
 =?utf-8?B?VGtCSkZRZHVMQU0rNVFrY1NXNDZQRXBQTWxzM1NUQ3FxRGNraE14TzJ4ekhP?=
 =?utf-8?B?TzE2MXF6ZHc3Q3ppNkpFRkd2WjM0eVdyRFBUWFFsYmN5NFQ4QUtuQzVyQ21h?=
 =?utf-8?B?S0U1ZkQrOE9UcUZiVCt2RmJ1K3lPbCtCbWVCOFpkeTlURllxbGx0RUJ5L09K?=
 =?utf-8?B?V2ZaWjc5a2ZOblBOajdpWUdYTkQ1WlVybXVTMklsV0lNSGsvUTY1dU1GUGlk?=
 =?utf-8?B?UCtIeGoyL1BudUMvVTBrNS9uTFNOM2ZRS1JZUUNlenlXRVdzZW1KVDVFek9q?=
 =?utf-8?B?OHZRdW1VNjNwZG4yYTg2UUtaR2JFSDBSWjNSR1dzYjNTNGRaSU5HZ3pYeTI3?=
 =?utf-8?B?c2RGTGllUlptMllvcm9UWndxV1RhNXJKbnF0Mmt1L2t6Y3FOSW9QajhjWHFo?=
 =?utf-8?B?NkNkVVZsRXcwM2VmRmh2dzM2MjlVWTlQbTl4VHNVckQ0R1l5QmhUclRmcUc0?=
 =?utf-8?B?OVRGYnhITG5UTUFLVWpJdXczTW82WVNRQmNhNWRvTzY3c1pVRUFmQnhaQVBD?=
 =?utf-8?B?bkUvT2Z6RDZMbnlCVUx5STFndnM4dnQwMEhjNjlrNmlHdk5Pa3FmWm1hdSsr?=
 =?utf-8?B?QTdiV216N3QyUG15TGRWTVJnbzZUNDV0MU4yTlRkSklGRzVhM01mS1RMU0Jx?=
 =?utf-8?B?ODVWT0dUcmUwa0puZCtHaGFYZkpOMXV1UjllNEtkZS9HZGJpR2NsbnZ1emlI?=
 =?utf-8?B?UzZqS0twbUFaekdEMjRIMEgvODdTVHhTYVhOYWtaYnVMTFk0Q2J4U2NlSWFr?=
 =?utf-8?B?SUxGeGlEaUx6cTYzVkh0R2xrVmRHSDFBeXFmTkhOdkpyQnpjSXN1TVNwZWp6?=
 =?utf-8?B?V3hOWDJVWkxSYjdRT3JTeTgyRDRxQVdPZ3h6SzRvNkY2YWh2aFhQSDVJNHhv?=
 =?utf-8?B?UDlLb3BlWHZoSjdDVjhQNkwzR3VLcFpCY0tPY2dsVHZLdU5YZGJCNVBTVWVQ?=
 =?utf-8?B?Yi9ObTRDSWRHVmVXVlpCaUxwcTRpUE9Ta2tmQm85VjFiaTh0ZWEvNTdLRzJV?=
 =?utf-8?B?Uk9KeGJZbFZ3Zmx5dFQ4dGtYM1RVanFVYTBHNTRKVElBSTJoWG0yZjFLVzNs?=
 =?utf-8?B?d1pYdU0rcENyOEROMzB6Vk1LUm5UaTY2VHZDNG5LSFdVS0NHZEJsNitGVVpC?=
 =?utf-8?B?VEFPdkxob1U3THY1SlFkQjl5VEFhMkJJazArODQzYjVXSXpiZWpOMzZURmxF?=
 =?utf-8?B?bmJxRnVsQlBJQU5vOHJVcXBScjFKeXB0SERWdWlkbnA0NmlnMkVMeTQ0M1ZZ?=
 =?utf-8?Q?VWkM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d79a8ca-4b5f-487b-8047-08dbbda05921
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 08:20:59.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EgaBe1zfmv6xIR72DX9kNCAhU5qHiFHZUkHMTtoMAZp2jap2xuG+pR+QOnN6WsF886V0VY9YRWn2z5rw9Uh0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4NCj5TZW50OiAyMDIz5bm0OeaciDI15pelIDE2OjE0DQo+VG86IE1pbmcgUWlhbiA8bWluZy5x
aWFuQG54cC5jb20+OyBNaXJlbGEgUmFidWxlYSAoT1NTKQ0KPjxtaXJlbGEucmFidWxlYUBvc3Mu
bnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPkNjOiBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+
bWNoZWhhYkBrZXJuZWwub3JnOyBodmVya3VpbC1jaXNjb0B4czRhbGwubmw7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7DQo+a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207
IFguSC4gQmFvDQo+PHhpYWhvbmcuYmFvQG54cC5jb20+OyBFYWdsZSBaaG91IDxlYWdsZS56aG91
QG54cC5jb20+OyBUYW8gSmlhbmcNCj48dGFvLmppYW5nXzJAbnhwLmNvbT47IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+Ow0KPmRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6IFJlOiBbRVhU
XSBSZTogW1BBVENIIHYzIDIvMl0gZHQtYmluZGluZ3M6IG1lZGlhOiBpbXgtanBlZzogQXNzaWdu
IHNsb3QNCj5mb3IgaW14IGpwZWcgZW5jb2Rlci9kZWNvZGVyDQo+DQo+Q2F1dGlvbjogVGhpcyBp
cyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtz
IG9yDQo+b3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNz
YWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+dGhpcyBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+T24gMjUv
MDkvMjAyMyAxMDoxMywgTWluZyBRaWFuIHdyb3RlOg0KPj4+IEZyb206IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4+PiBTZW50OiAyMDIz5bm0
OeaciDI15pelIDE2OjEwDQo+Pj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBN
aXJlbGEgUmFidWxlYSAoT1NTKQ0KPj4+IDxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT47IHJv
YmgrZHRAa2VybmVsLm9yZzsNCj5zaGF3bmd1b0BrZXJuZWwub3JnDQo+Pj4gQ2M6IGtyenlzenRv
Zi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4+PiBtY2hl
aGFiQGtlcm5lbC5vcmc7IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubDsgcy5oYXVlckBwZW5ndXRy
b25peC5kZTsNCj4+PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsg
WC5ILiBCYW8NCj4+PiA8eGlhaG9uZy5iYW9AbnhwLmNvbT47IEVhZ2xlIFpob3UgPGVhZ2xlLnpo
b3VAbnhwLmNvbT47IFRhbyBKaWFuZw0KPj4+IDx0YW8uamlhbmdfMkBueHAuY29tPjsgZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+Pj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+Pj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+Pj4gU3Vi
amVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMi8yXSBkdC1iaW5kaW5nczogbWVkaWE6IGlt
eC1qcGVnOg0KPj4+IEFzc2lnbiBzbG90IGZvciBpbXgganBlZyBlbmNvZGVyL2RlY29kZXINCj4+
Pg0KPj4+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNh
cmUgd2hlbiBjbGlja2luZw0KPj4+IGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4g
aW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZw0KPj4+IHRoZSAnUmVwb3J0IHRoaXMg
ZW1haWwnIGJ1dHRvbg0KPj4+DQo+Pj4NCj4+PiBPbiAyNS8wOS8yMDIzIDEwOjA3LCBNaW5nIFFp
YW4gd3JvdGU6DQo+Pj4+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296
bG93c2tpQGxpbmFyby5vcmc+DQo+Pj4+PiBTZW50OiAyMDIz5bm0OeaciDI15pelIDE2OjAyDQo+
Pj4+PiBUbzogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT47IE1pcmVsYSBSYWJ1bGVhIChP
U1MpDQo+Pj4+PiA8bWlyZWxhLnJhYnVsZWFAb3NzLm54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5v
cmc7DQo+Pj4gc2hhd25ndW9Aa2VybmVsLm9yZw0KPj4+Pj4gQ2M6IGtyenlzenRvZi5rb3psb3dz
a2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4+Pj4+IG1jaGVoYWJAa2Vy
bmVsLm9yZzsgaHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sOw0KPj4+Pj4gcy5oYXVlckBwZW5ndXRy
b25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+Pj4+
PiBYLkguIEJhbyA8eGlhaG9uZy5iYW9AbnhwLmNvbT47IEVhZ2xlIFpob3UgPGVhZ2xlLnpob3VA
bnhwLmNvbT47DQo+Pj4+PiBUYW8gSmlhbmcgPHRhby5qaWFuZ18yQG54cC5jb20+OyBkbC1saW51
eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4+Pj4+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPj4+Pj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+Pj4+
PiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYzIDIvMl0gZHQtYmluZGluZ3M6IG1lZGlhOiBp
bXgtanBlZzoNCj4+Pj4+IEFzc2lnbiBzbG90IGZvciBpbXgganBlZyBlbmNvZGVyL2RlY29kZXIN
Cj4+Pj4+DQo+Pj4+PiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2Ug
dGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcNCj4+Pj4+IGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVu
dHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZQ0KPj4+Pj4gdXNpbmcgdGhlICdS
ZXBvcnQgdGhpcyBlbWFpbCcgYnV0dG9uDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IE9uIDI1LzA5LzIw
MjMgMDk6NDEsIE1pbmcgUWlhbiB3cm90ZToNCj4+Pj4+PiBUaGVyZSBhcmUgdG90YWwgNCBzbG90
cyBhdmFpbGFibGUgaW4gdGhlIElQLCBhbmQgd2Ugb25seSBuZWVkIHRvDQo+Pj4+Pj4gdXNlIG9u
ZSBzbG90IGluIG9uZSBvcywgYXNzaWduIGEgc2luZ2xlIHNsb3QsIGNvbmZpZ3VyZSBpbnRlcnJ1
cHQNCj4+Pj4+PiBhbmQgcG93ZXIgZG9tYWluIG9ubHkgZm9yIDEgc2xvdCwgbm90IGZvciB0aGUg
YWxsIDQgc2xvdHMuDQo+Pj4+Pg0KPj4+Pj4gTm8gY2hhbmdlbG9nIGFuZCBJIGRvIG5vdCBzZWUg
bXVjaCBvZiBpbXByb3ZlbWVudHMuIERvIG5vdCBpZ25vcmUNCj4+Pj4+IHRoZSBmZWVkYmFjayBi
dXQgcmVzcG9uZCB0byBpdCBvciBmaXggdGhlIHBhdGNoLiBSZWFsbHksIHdoYXQgaGFwcGVuZWQN
Cj5oZXJlPw0KPj4+Pj4NCj4+Pj4NCj4+Pj4gSGkgS3J6eXN6dG9mLA0KPj4+PiAgICBXaGF0IGRv
IHlvdSBtZWFuIHdyYXAgY29tbWl0IG1lc3NhZ2U/IERvIHlvdSBtZWFuIGxpbmUgd3JhcHBlZA0K
PmF0DQo+Pj4gNzUgY29sdW1ucz8NCj4+Pj4NCj4+Pj4gICAtIFRoZSBib2R5IG9mIHRoZSBleHBs
YW5hdGlvbiwgbGluZSB3cmFwcGVkIGF0IDc1IGNvbHVtbnMsIHdoaWNoIHdpbGwNCj4+Pj4gICAg
IGJlIGNvcGllZCB0byB0aGUgcGVybWFuZW50IGNoYW5nZWxvZyB0byBkZXNjcmliZSB0aGlzIHBh
dGNoLg0KPj4+DQo+Pj4gSSBnYXZlIHlvdSBjbGVhciBsaW5rIHRvIHRoZSBkb2MgZXhwbGFpbmlu
ZyB0aGlzLiBXaGF0IGlzIHVuY2xlYXIgdGhlcmU/DQo+Pj4NCj4+PiBBbmQgeW91IGRlY2lkZSB0
byBpZ25vcmUgYWxsIHRoZSByZXN0IG9mIHRoZSBjb21tZW50cyBoZXJlIGFzIHdlbGw/DQo+DQo+
U28gdGhpcyBpcyBzdGlsbCBpZ25vcmVkPyBDYW4geW91IHJlc3BvbmQgdG8gYWxsIG15IGNvbW1l
bnRzPw0KPg0KPj4+DQo+Pj4gQmVzdCByZWdhcmRzLA0KPj4+IEtyenlzenRvZg0KPj4NCj4+IFRo
ZSBsaW5rIGNvbnRlbnQgaXMgYXMgYmVsb3c6DQo+Pg0KPj4gICAtIFRoZSBib2R5IG9mIHRoZSBl
eHBsYW5hdGlvbiwgbGluZSB3cmFwcGVkIGF0IDc1IGNvbHVtbnMsIHdoaWNoIHdpbGwNCj4+ICAg
ICBiZSBjb3BpZWQgdG8gdGhlIHBlcm1hbmVudCBjaGFuZ2Vsb2cgdG8gZGVzY3JpYmUgdGhpcyBw
YXRjaC4NCj4+DQo+PiBJJ20gc29ycnkgdGhhdCBJIGRpZG7igJl0IGdldCB5b3VyIHBvaW50Lg0K
Pg0KPldyYXANCj55b3VyDQo+Y29tbWl0DQo+YWNjb3JkaW5nDQo+dG8NCj5jb2RpbmcNCj5zdHls
ZS4NCj4NCj5CZXN0IHJlZ2FyZHMsDQo+S3J6eXN6dG9mDQoNCkhpIEtyenlzenRvZiwNCiAgICBJ
IG9wZW5lZCB5b3VyIGxpbmsgYWJvdXQgdGhlIExpbnV4IGNvZGluZyBzdHlsZSAvIHN1Ym1pc3Np
b24gcHJvY2VzcywgYnV0IEkgb25seSBmaW5kIHRoZSBmb2xsb3dpbmcgbWVzc2FnZToNCg0KICAt
IFRoZSBib2R5IG9mIHRoZSBleHBsYW5hdGlvbiwgbGluZSB3cmFwcGVkIGF0IDc1IGNvbHVtbnMs
IHdoaWNoIHdpbGwNCiAgICBiZSBjb3BpZWQgdG8gdGhlIHBlcm1hbmVudCBjaGFuZ2Vsb2cgdG8g
ZGVzY3JpYmUgdGhpcyBwYXRjaC4NCg0KICAgICBTbyBJIGRvbid0IGtub3cgd2hhdCBkbyB5b3Ug
bWVhbiB0aGUgY29kaW5nIHN0eWxlLg0KDQo=
