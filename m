Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE97AD3A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjIYIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjIYIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:48:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8C5C0;
        Mon, 25 Sep 2023 01:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqMwMH0B+FWCPIaag0LjkFKzt0W4NzssKPBUR6BXkFAFiYY2LZsu0SQXY5uVbq2yO8TFUfw9viIAxkAc1pf6p0r2kcFOTKyadnRGv5PNFHl315yF2Xo6dVhLq7qr9oUe9FLEgvzn17x4kZ8IoXru2QQZrUmPf8xKxKVUVx9cyWOmYlc/fnajeFhhSzaOunMlOk121fHNAUjjBD/hsyTIe/HRbMsKNT99RuYLeKCe+ewucD3XeGt/SvzqmP6aEfSFJ9hvAwdw8qWvLNyv2dmhI/N6muyMbpi5fDYypefMpbakZPUfwJFJPh+ISxXTNzzxHHhyGvm32zq6X7agub4N8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00IaddUVvzGkbul//AdZ0oFOyuz3CJAyBNZhEpXrNik=;
 b=hmOyBYE8D2FtjHKDS6hfweug92aFJRoRuuvhEA8+3FViE8zfycP4XsIQz8G2lD8xv8qmpn3SfTzYs/hyG6htrcaBFkfPyFDFGIV7LKYG9seU5cAsvGHogtWx8iOGoEaG7uwNIn7kKdLax4c4mTF2Hcf2SEtEJysn0BdtxDgRRuRoeVKul58RgssKsC+izbtKOEQXyuA9LEczMsu9O/ZVScmI5VhccAm5W608j9gY2Rov6koZ45l42HRXy2IdK7VOxTVj3j0glSob8t7J1XJeTrXUCrf4soIN75ZJT7fQ3Uw+r9r5Q7y3I5Wk9KslvQH1TjiI0tSyAfCFMcC402w37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00IaddUVvzGkbul//AdZ0oFOyuz3CJAyBNZhEpXrNik=;
 b=fT3u4iJjQtmTaL8uCN9hxxBUZPrjcX9fzOp9PQ970yW3UZjs6dtfEdfFgdoYQuNZH0MUpXpndE6z+wWTDFkdSXWisRZd7FJvPvt3h+mlAkfqC/7+phuVnFJyEywH1FMRSWL7gWgzBDYjLXvTzGEhjFrmW6BYDBH48rImpCwLXFc=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:48:02 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:48:02 +0000
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
Thread-Index: AQHZ74PEbqAT2ziWZ0ufS4Z9Kh2CJrArLgAAgAAA7LCAAAFigIAAAItAgAAAtQCAAADVgIAABH0AgAAAhhA=
Date:   Mon, 25 Sep 2023 08:48:01 +0000
Message-ID: <AM6PR04MB6341D59E9BBB433F6045D367E7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230925074131.10133-1-ming.qian@nxp.com>
 <20230925074131.10133-2-ming.qian@nxp.com>
 <bbc8dd05-8589-44ec-87dd-f2d7b4368245@linaro.org>
 <AM6PR04MB63418AE18D3D0ED98CCC1A0FE7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <751a552e-5209-4d5e-9292-23339a06f8a9@linaro.org>
 <AM6PR04MB63410BEA725DDBF1D1B7814FE7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <10c50df3-9a99-4552-9b25-0844b87e28f5@linaro.org>
 <AM6PR04MB6341C8E7553F66695467C398E7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <df86ea4b-d389-4060-bd3b-830bacabde1c@linaro.org>
In-Reply-To: <df86ea4b-d389-4060-bd3b-830bacabde1c@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AM9PR04MB8485:EE_
x-ms-office365-filtering-correlation-id: 7d816586-be5f-4db6-a02c-08dbbda42071
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eBPdFaqTk+68rlC/oS280qiVVKsed1FCVKnmb1px2lgj5HaIVnLdkQcLbghf6HT+f1+twjJgJpFFSkrDtLisl38efcnNtA2/i+Z1YwpKQAELKjRJOZ7NTXBfu0OBGvshZHHQcU5sgqcLONp46PrhHv47m/QFLQi8v8pj5pWXbvD+VcJDZumAvY3x2opcryjHgbf8fx23TbdiBLtDlpidF5q7BQzxeF2TUsTZJ3/ydQ7/G+kBYTEI4oLFpeWxRhwlZTcAily6ST2mNQ3CqHctNu+kbL7u0oDXECLL+l34f5rD3TO56172qUnFGychSMiHpVjDyXXR011s1jBuorQz5jIbDE0beOelReCM2oEB7U5DiBsNYYw2gK1hMDsDouYpb2Iv8FHMpPUGcux6lree1gbK5DN4fA5Ujcc+5NehSnxmkeS6kuW31gU2VJy8EVvTOlpl28e3dwinrRNd3Vxqxl0TM6/kwZYeCANPgKKBvj5MZjx8TfDfHq/6vAtaSalzh33aLA4ap9WJ+b7Vvb+pb1og+EctJrVUcSGGwkOP/osxnubDJBmk13tzSYOFTIAKlQhNMmEMXChCc5fyucvwGiRqJRFqI8Igw89SOdqV2dij2QrBuN7oAUcH7WAs9HLF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(9686003)(53546011)(7696005)(6506007)(71200400001)(83380400001)(122000001)(86362001)(33656002)(38100700002)(38070700005)(55016003)(26005)(52536014)(2906002)(41300700001)(316002)(7416002)(64756008)(44832011)(66446008)(54906003)(66946007)(66476007)(478600001)(76116006)(4326008)(8936002)(8676002)(5660300002)(66556008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmlrU0Z1VGd6VnBZY1RRYStvWDZDelBCUTNkcFd2djAyUldpTGtiSWxFb3A2?=
 =?utf-8?B?TThFYmdyVHFQVGs4NVVYQjkrZHo4WVE2T2YxWUVrVEFiTksxN0NIMVJ5S0RB?=
 =?utf-8?B?eVFwY0ZjRy90bjgxcWNLb0Q1Y3BaNW0wOEg1di9qWXg5L2VPTzBpNEtPangz?=
 =?utf-8?B?LzY3VzYwNnJ0M0dHeGdKRE56cVovRnN5cFpJSWpkT1RwVzhhV0tubkxxckhU?=
 =?utf-8?B?d3pPTmY1ZWIrTEVtcmNybTRMVnNoTGxkaVJRbjdpNkVTVUJhUytBUlhMYmdJ?=
 =?utf-8?B?ZWE0SDhqTy9KVk56M3lCcFp1dmphbXRaSy9Uc0NCMUdZM3ZXZjRFaGJyK2ZW?=
 =?utf-8?B?VXVIbHlrcHZIVVhYb2lvYUdqVW1iNUxLTDNodHZpcUpNeFllMTY5WnQrK0lX?=
 =?utf-8?B?Y3E5bE9RYmpRbWZQczBHdFUvVGE3QUVzL0RDWnBpck5jM0o4QkM0Q0FpdU1v?=
 =?utf-8?B?UEFDLzB4QWNGcHJYUldvc3U5aWZ1RnhQMnRRZ1RDVmZ1ZGV2T2hia25BZElK?=
 =?utf-8?B?MTlEZy9BREo1YS8zOXFkSkVkRFgrS3R0eGZOdjkzdlZseFVFQ1kxYjdJd29k?=
 =?utf-8?B?ZG85MnkwbU94NjhGMnFHb3I4S05FOGp5Y3NFMHNDZ1VNL3ZsQlNaczlYd0x3?=
 =?utf-8?B?ZmdMZEFtYkViRElPYUI4dmNHK0ZHaDJpQ0pDdzdGc2wyZUI4YTkzUzFVV3pI?=
 =?utf-8?B?UE10MEU3SFlUdzRFaUpmdHM4TmFGcmFqZjAwam5XeDRXUStoOHNSUnBtb2s1?=
 =?utf-8?B?UURuWTF2MjdaditLQ3ZNWXRyMVdzSzlwL1dLVU9LaXc1V3FnM3lwQ3M3cXor?=
 =?utf-8?B?bkdsSXo1TElFaDUramVWY2xBRmRGVFhPcTA1ampWZHJ4NmQrazgrT1dHTkxL?=
 =?utf-8?B?c0RYcmRyL0pHTFh1MDBXRzQ1Z0JsVTFERXNHZS9hMjQrUk1Ga3hibkJpci9Z?=
 =?utf-8?B?LzY2NGlWRnhCWnIyTDNzRnRHa2FsSldDRGhjZXQyV0I1UFV6dUxyR1hMUm5k?=
 =?utf-8?B?RktJRXcvZHRiUEhsLzhhTXBEbWZRVXR3S2dGdWRoZ1VsOVlHdnJQNllDWmRt?=
 =?utf-8?B?OER2dzMzbzIwbU4xSEhnSlF0ZHp1c0kxMk13Qi84dUJqRkVsalZhMWFsQ05M?=
 =?utf-8?B?S0c0Nno3ZVNXc2Y5RVpYM0VDMTFrcFFETUl0MVFjWnAvYVF5b2kxYVB0Rmcx?=
 =?utf-8?B?QnNmdjZZR2orTUVZUU9CdmJHUkRJU3Bod0k4WUxRSnk0ck5PTmlMbGRsUTRO?=
 =?utf-8?B?SkxQTE1Yc3pwR1d1RUZqZ3J5UXJleWgveUdFY3NjdWsyTXMzUzZOUmtzcTgx?=
 =?utf-8?B?VnZFUS9UZFdFNyt3R2l6V1EwSFJaOUplcGdQeEJUKyttTXBscG1TRXhBM2Y3?=
 =?utf-8?B?NFdIaXRlYzRTcFMyM0wxNW9HVGVhMVRqRGVWaTlkRXdGWHYzdzR1Tnd6Y29n?=
 =?utf-8?B?ajRtbURYYVhQZVMwNFFOb1JGQ2FLK2pYd1JBMkMzVGNVZEVPbEtSRFQ0Um9J?=
 =?utf-8?B?bkRPREFqNk1RQit1OE1NME5TUnNZWW84Z3lmWmpHV29BYlcxRkFUdXhnektS?=
 =?utf-8?B?WG1mWGZFVEhhV3BpWUR4Y2lIS3duZEVMS29DVjU1OUxDSDY2cVI0bE9ZcFpk?=
 =?utf-8?B?QVhHeXV4enBYWC84cmd1a1RYUDBpTkl3K2tqRU9pQ2IrQWYwaVZBelRJS0pm?=
 =?utf-8?B?VXVaNTFmMzhKWVNSZitRM1FieThTdUhwY1k4c21qYXY1VXBzSkhMQ001Yi9N?=
 =?utf-8?B?ekFrU29Ud3Y2UmIxeDJzMXRzTEp4S3BCNFFBOFhIZ1UwVCtHL1AvZnFwMFRn?=
 =?utf-8?B?OGdDaUR4SCtDVFVqbHkwbzZBNkJHTmNYaTFSZXpuYXBpRGhoNFV3eGcybmZj?=
 =?utf-8?B?ZkpiNC9YWXNzV0JUSnN5Z216TkNLRmpoZmF5bHVCeUFOR2ZJR0U2VndoWmVy?=
 =?utf-8?B?OFZlcmg4eWsvQ0lnUzhzbk9pd3pzbHloTkthMk1RalFZelQxNE02REx5cytQ?=
 =?utf-8?B?aFBSSXFlNGNNTUVDNzN4VDdDMms3bUszc0JZR1lBWW53K2ZLMDV1M2hwL01Q?=
 =?utf-8?B?Tkp2Q3VSQ0Y4ak9taklIc2JyL0huRXVHT1RYaHY3YkdPNVhVanVNUWxQTERH?=
 =?utf-8?Q?oIa4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d816586-be5f-4db6-a02c-08dbbda42071
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 08:48:01.9515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yz4UvlYC3Xx4m1B6sYIKx+fqy99aKgwbjiryNtVWK0rjjf84cenmPOWvWNVe+VMtsXU3egk+JOUviJQ0WFqFcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485
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
Zz4NCj5TZW50OiAyMDIz5bm0OeaciDI15pelIDE2OjMzDQo+VG86IE1pbmcgUWlhbiA8bWluZy5x
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
MDkvMjAyMyAxMDoyMCwgTWluZyBRaWFuIHdyb3RlOg0KPj4+IEZyb206IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4+PiBTZW50OiAyMDIz5bm0
OeaciDI15pelIDE2OjE0DQo+Pj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBN
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
ZW1haWwnIGJ1dHRvbg0KPj4+DQo+Pj4NCj4+PiBPbiAyNS8wOS8yMDIzIDEwOjEzLCBNaW5nIFFp
YW4gd3JvdGU6DQo+Pj4+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296
bG93c2tpQGxpbmFyby5vcmc+DQo+Pj4+PiBTZW50OiAyMDIz5bm0OeaciDI15pelIDE2OjEwDQo+
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
PiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2MyAyLzJdIGR0LWJpbmRpbmdzOiBtZWRp
YTogaW14LWpwZWc6DQo+Pj4+PiBBc3NpZ24gc2xvdCBmb3IgaW14IGpwZWcgZW5jb2Rlci9kZWNv
ZGVyDQo+Pj4+Pg0KPj4+Pj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxl
YXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nDQo+Pj4+PiBsaW5rcyBvciBvcGVuaW5nIGF0dGFj
aG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UNCj4+Pj4+IHVzaW5nIHRo
ZSAnUmVwb3J0IHRoaXMgZW1haWwnIGJ1dHRvbg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+PiBPbiAyNS8w
OS8yMDIzIDEwOjA3LCBNaW5nIFFpYW4gd3JvdGU6DQo+Pj4+Pj4+IEZyb206IEtyenlzenRvZiBL
b3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4+Pj4+Pj4gU2VudDog
MjAyM+W5tDnmnIgyNeaXpSAxNjowMg0KPj4+Pj4+PiBUbzogTWluZyBRaWFuIDxtaW5nLnFpYW5A
bnhwLmNvbT47IE1pcmVsYSBSYWJ1bGVhIChPU1MpDQo+Pj4+Pj4+IDxtaXJlbGEucmFidWxlYUBv
c3MubnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4+Pj4+IHNoYXduZ3VvQGtlcm5lbC5v
cmcNCj4+Pj4+Pj4gQ2M6IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3Ir
ZHRAa2VybmVsLm9yZzsNCj4+Pj4+Pj4gbWNoZWhhYkBrZXJuZWwub3JnOyBodmVya3VpbC1jaXNj
b0B4czRhbGwubmw7DQo+Pj4+Pj4+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsNCj4+Pj4+Pj4gZmVzdGV2YW1AZ21haWwuY29tOyBYLkguIEJhbyA8eGlhaG9u
Zy5iYW9AbnhwLmNvbT47IEVhZ2xlIFpob3UNCj4+Pj4+Pj4gPGVhZ2xlLnpob3VAbnhwLmNvbT47
IFRhbyBKaWFuZyA8dGFvLmppYW5nXzJAbnhwLmNvbT47DQo+Pj4+Pj4+IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4+Pj4+Pj4g
bGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC0ga2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4+Pj4+Pj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+Pj4+Pj4+
IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMi8yXSBkdC1iaW5kaW5nczogbWVkaWE6IGlt
eC1qcGVnOg0KPj4+Pj4+PiBBc3NpZ24gc2xvdCBmb3IgaW14IGpwZWcgZW5jb2Rlci9kZWNvZGVy
DQo+Pj4+Pj4+DQo+Pj4+Pj4+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBs
ZWFzZSB0YWtlIGNhcmUgd2hlbg0KPj4+Pj4+PiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0
dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlDQo+Pj4+Pj4+IG1lc3NhZ2UgdXNp
bmcgdGhlICdSZXBvcnQgdGhpcyBlbWFpbCcgYnV0dG9uDQo+Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+
Pj4+IE9uIDI1LzA5LzIwMjMgMDk6NDEsIE1pbmcgUWlhbiB3cm90ZToNCj4+Pj4+Pj4+IFRoZXJl
IGFyZSB0b3RhbCA0IHNsb3RzIGF2YWlsYWJsZSBpbiB0aGUgSVAsIGFuZCB3ZSBvbmx5IG5lZWQg
dG8NCj4+Pj4+Pj4+IHVzZSBvbmUgc2xvdCBpbiBvbmUgb3MsIGFzc2lnbiBhIHNpbmdsZSBzbG90
LCBjb25maWd1cmUNCj4+Pj4+Pj4+IGludGVycnVwdCBhbmQgcG93ZXIgZG9tYWluIG9ubHkgZm9y
IDEgc2xvdCwgbm90IGZvciB0aGUgYWxsIDQgc2xvdHMuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IE5vIGNo
YW5nZWxvZyBhbmQgSSBkbyBub3Qgc2VlIG11Y2ggb2YgaW1wcm92ZW1lbnRzLiBEbyBub3QgaWdu
b3JlDQo+Pj4+Pj4+IHRoZSBmZWVkYmFjayBidXQgcmVzcG9uZCB0byBpdCBvciBmaXggdGhlIHBh
dGNoLiBSZWFsbHksIHdoYXQNCj4+Pj4+Pj4gaGFwcGVuZWQNCj4+PiBoZXJlPw0KPj4+Pj4+Pg0K
Pj4+Pj4+DQo+Pj4+Pj4gSGkgS3J6eXN6dG9mLA0KPj4+Pj4+ICAgIFdoYXQgZG8geW91IG1lYW4g
d3JhcCBjb21taXQgbWVzc2FnZT8gRG8geW91IG1lYW4gbGluZQ0KPndyYXBwZWQNCj4+PiBhdA0K
Pj4+Pj4gNzUgY29sdW1ucz8NCj4+Pj4+Pg0KPj4+Pj4+ICAgLSBUaGUgYm9keSBvZiB0aGUgZXhw
bGFuYXRpb24sIGxpbmUgd3JhcHBlZCBhdCA3NSBjb2x1bW5zLCB3aGljaCB3aWxsDQo+Pj4+Pj4g
ICAgIGJlIGNvcGllZCB0byB0aGUgcGVybWFuZW50IGNoYW5nZWxvZyB0byBkZXNjcmliZSB0aGlz
IHBhdGNoLg0KPj4+Pj4NCj4+Pj4+IEkgZ2F2ZSB5b3UgY2xlYXIgbGluayB0byB0aGUgZG9jIGV4
cGxhaW5pbmcgdGhpcy4gV2hhdCBpcyB1bmNsZWFyIHRoZXJlPw0KPj4+Pj4NCj4+Pj4+IEFuZCB5
b3UgZGVjaWRlIHRvIGlnbm9yZSBhbGwgdGhlIHJlc3Qgb2YgdGhlIGNvbW1lbnRzIGhlcmUgYXMg
d2VsbD8NCj4+Pg0KPj4+IFNvIHRoaXMgaXMgc3RpbGwgaWdub3JlZD8gQ2FuIHlvdSByZXNwb25k
IHRvIGFsbCBteSBjb21tZW50cz8NCj4+Pg0KPj4+Pj4NCj4+Pj4+IEJlc3QgcmVnYXJkcywNCj4+
Pj4+IEtyenlzenRvZg0KPj4+Pg0KPj4+PiBUaGUgbGluayBjb250ZW50IGlzIGFzIGJlbG93Og0K
Pj4+Pg0KPj4+PiAgIC0gVGhlIGJvZHkgb2YgdGhlIGV4cGxhbmF0aW9uLCBsaW5lIHdyYXBwZWQg
YXQgNzUgY29sdW1ucywgd2hpY2ggd2lsbA0KPj4+PiAgICAgYmUgY29waWVkIHRvIHRoZSBwZXJt
YW5lbnQgY2hhbmdlbG9nIHRvIGRlc2NyaWJlIHRoaXMgcGF0Y2guDQo+Pj4+DQo+Pj4+IEknbSBz
b3JyeSB0aGF0IEkgZGlkbuKAmXQgZ2V0IHlvdXIgcG9pbnQuDQo+Pj4NCj4+PiBXcmFwDQo+Pj4g
eW91cg0KPj4+IGNvbW1pdA0KPj4+IGFjY29yZGluZw0KPj4+IHRvDQo+Pj4gY29kaW5nDQo+Pj4g
c3R5bGUuDQo+Pj4NCj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4gS3J6eXN6dG9mDQo+Pg0KPj4gSGkg
S3J6eXN6dG9mLA0KPj4gICAgIEkgb3BlbmVkIHlvdXIgbGluayBhYm91dCB0aGUgTGludXggY29k
aW5nIHN0eWxlIC8gc3VibWlzc2lvbiBwcm9jZXNzLCBidXQgSQ0KPm9ubHkgZmluZCB0aGUgZm9s
bG93aW5nIG1lc3NhZ2U6DQo+Pg0KPj4gICAtIFRoZSBib2R5IG9mIHRoZSBleHBsYW5hdGlvbiwg
bGluZSB3cmFwcGVkIGF0IDc1IGNvbHVtbnMsIHdoaWNoIHdpbGwNCj4+ICAgICBiZSBjb3BpZWQg
dG8gdGhlIHBlcm1hbmVudCBjaGFuZ2Vsb2cgdG8gZGVzY3JpYmUgdGhpcyBwYXRjaC4NCj4+DQo+
PiAgICAgIFNvIEkgZG9uJ3Qga25vdyB3aGF0IGRvIHlvdSBtZWFuIHRoZSBjb2Rpbmcgc3R5bGUu
DQo+DQo+DQo+TGlua2VkIGRvY3VtZW50IGV4cGxhaW5zIHdoYXQgaXMgYSBwYXRjaCwgaG93IGl0
IGlzIGZvcm1hdHRlZC4gSnVzdCByZWFkDQo+ZW50aXJlIGRvYywgbm90IG9uZSBzZW50ZW5jZS4N
Cj4NCj5Zb3Uga2VlcCBpZ25vcmluZyBteSBvdGhlciBjb21tZW50cyBhbGwgdGhlIHRpbWUsIHNv
IEkgd2lsbCBzdG9wIGFza2luZyB5b3UgdG8NCj5yZXNwb25kIHRvIHRoZW0uIEluc3RlYWQgSSB3
aWxsIGJlIE5BSy1pbmcgeW91ciBwYXRjaGVzIHRpbGwgeW91IGRlY2lkZSB0bw0KPnJlc3BvbmQu
DQo+DQo+QmVzdCByZWdhcmRzLA0KPktyenlzenRvZg0KDQpIaSBLcnp5c3p0b2YsDQogICAgSSdt
IHNvcnJ5IHRoYXQgSSBtYWtlIHlvdSB1bmhhcHB5LCBhcyBJIGRpZG4ndCBrbm93IGhvdyB0byBp
bXByb3ZlIHRoZSBjb21taXQgbWVzc2FnZS4NCkFuZCB5b3VyIG90aGVyIGNvbW1lbnRzIGFib3V0
IHRoZSBjaGFuZ2UsIEkgZ2V0IHlvdXIgcG9pbnQsIGFuZCBwcmVwYXJlIHRvIGltcHJvdmUgaW4g
dGhlIG5leHQgdmVyc2lvbi4NCg0KU29ycnkgYWdhaW4gdGhhdCBJIGRpZG4ndCByZXNwb25zZSB5
b3VyIGV2ZXJ5IGNvbW1lbnRzLCBJIHdpbGwgYXZvaWQgZG9pbmcgaXQgYWdhaW4uDQoNCkFuZCBj
YW4geW91IGdpdmUgYSBleGFtcGxlIGhvdyB0byBpbXByb3ZlIHRoZSBjb21taXQgbWVzc2FnZS4N
Cg0KTWluZw0KDQo=
