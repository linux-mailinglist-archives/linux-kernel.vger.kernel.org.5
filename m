Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758E27AA68D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjIVBdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIVBdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:33:10 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41A9CF;
        Thu, 21 Sep 2023 18:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlZsZgQ/6KwFo8lRebyQelphcOJxgG8d+q9TZNmrV4IbvbcAr2Pl4lmhONBfhuPswiznFoYysx32LDfx5qsZ4ObhkYnsXJ8Y2vIBqpoexFTv4CwX1lF151WdaZFl7/twF9+qGVvWxNcivUUkRaamnxdTbVr1JgIkDB7RjpDYAbDR0+4RDcpHXZ63kf4tooMfEy50SvHHta69U81PHdBoholQvXbCHxcQBPYAZrZa7s1C7KKqrQEVvSMeFq3cghV6joepX7kVZwG/7FNg9ERHXjKgGwhxxkj/cn/4D/Dpsss/24OSlD+Qe15neFPoMecmSqgMC6oIx8FvC1iEEF840g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXzXV7F7gbgHzZqn2JygytOgV1/1xy/op2+FRXZQtaA=;
 b=kPxczgjZ7A6qSBEUaONaeVvPyQkWnhzIsaktUqX8ixJOLgYH25UL2qgkqAu49RoOtatC1N6nmsajZ1ETvhgLLZlWgRyNl+y+PryNXZkz7xQIZsftGjlmBwLWeivxIXqTSdAz1/1E7fi2pU36j5JbpDxjG0pp4zO//h1arKF5uTpVV5lZ7Jgy86ysum0F8iIj9SgqoX7ppHwd1XhXviwdZMLv0WRzA4vylj3isgXojQvYkeNKwERsi9FlS1R01Sou1Ks8kFi1c5qDV09mYQN17YRyti758IFSlAYrDPcwgJm8Z5W3n8dGN8adWfo6S3kjwpPghAEW62FidWCJuBCvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXzXV7F7gbgHzZqn2JygytOgV1/1xy/op2+FRXZQtaA=;
 b=MMuGHpKcJbBADFEglEhVwoA/mOoF0t3+o5h/yizxwtsj82A7n604JEbzH0QTToJooVn/2062Br75RS0yClEDqh9eTb8ywQ/esz4FESdItZRGFglvwIB3kGnjGFg/1rnXOxkcbnR9RRJMn/+pc7rh41oAX8d9FflKV7zgqBRAfZ4=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 01:33:01 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 01:33:00 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH v2 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Index: AQHZ7FYBFLD+c9Ls9UudO2P5Fxi4abAlCqQAgAEFZcA=
Date:   Fri, 22 Sep 2023 01:33:00 +0000
Message-ID: <AM6PR04MB634103F226B69ADD41255FCBE7FFA@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230921063620.22962-1-ming.qian@nxp.com>
 <20230921063620.22962-2-ming.qian@nxp.com>
 <19d2bc5c-2662-6ed8-cc3d-7efb82fd1825@kernel.org>
In-Reply-To: <19d2bc5c-2662-6ed8-cc3d-7efb82fd1825@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|PR3PR04MB7340:EE_
x-ms-office365-filtering-correlation-id: 086fda3f-1719-4bec-1c38-08dbbb0bdbc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LbIS2T1fqs9bJGS/fGVClBMZa8X5surcZlJIA8oib0yvgblzzsxC+JkoQbAUeyHQU9onHMKFQbmR+ky8DBitufneqp1tWv2WOoDRIC32JwMLQ0KebZYlkbm1oCmnA92Hq75OD/B8fC3MpigyUoCnuFBbKw8GN1j5lokEeuYSsG0CKCiA12KvwA+UTvZmp//Ia5yibzhufK2LAft5+VuYReqiahjkkpTQVtU7+S8zXORNfNSUNWUClgU/u7LNRArFgVhYedqAurGzRpJOmXQ9DBiybOe89PtwIxRLAcRhgpK4ByAJV2fQxfRRMhII0EmL5NukWp9H8cmXOsm4NdIHJoTzxXjNslPL91FMhwHaaE3RvkJT4eNWlEF8PwnM5yUv8HOcvBynabKJiq9jsK6Up0RrpWv7ZrO78O6Sxt4FzUfoeIKZpBREyWlOubv3RWmfCyKCLgLCF0wy0dVCUMPEJ6nk6PomcDkc9Hwt200d4bJafqKJOaLC+Vfykbt+mIcxUKTxT5NCm4WNo5LaShFYPM0UeeKthem0fDl80Yluzfmcn9RxQzIYeJFsiad2FtKw3j0SAsCUdoV+OcLFW1RwxXlQxGP6IDNyT2biIG4kgCohul7gBpJojPSXQ2whBTc7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(186009)(451199024)(1800799009)(83380400001)(478600001)(6506007)(7696005)(9686003)(71200400001)(2906002)(26005)(66446008)(66556008)(64756008)(54906003)(76116006)(316002)(4326008)(66476007)(66946007)(8676002)(44832011)(7416002)(110136005)(52536014)(41300700001)(5660300002)(8936002)(33656002)(86362001)(38100700002)(55016003)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGY1ZFgzZ3dSOUVQbitOaG9lU05KeTR2eXA3MU40T2FTQVhoZkgzT3FkaTRv?=
 =?utf-8?B?eXNQdWtTZDE0ZFdoVDN3TjdLaHJrYUtlcUdxcUIzM3Q4Z0tiKzRuYlpsN1Na?=
 =?utf-8?B?NkR3M0kzTnRuNHNDd001Z05BaW5DcWM1bERnTWwwV1FoOGdBTDJNRmlTNkto?=
 =?utf-8?B?dFRSUlBRdnFDUVk2bWVvbXlxSFVNUjVvSERYTy9EMU15UnBxSEFMbXVIYk9V?=
 =?utf-8?B?YVVMaUlSTEVHUWFld2twR3o0M0JBWXM4OUxkNW44NGd0T0puekhmQklYazJv?=
 =?utf-8?B?RTBVTnJmRGFub01OR2hrQWVicThLUXVJVmNybDdkN2IvMGZ3T0JrZ1pLU2w3?=
 =?utf-8?B?bzl4R0g5eTVSLzhXSWZqZmo2ajBMZ2hWQnhwb2o5RXN5eU1VRlBpM05DL0lW?=
 =?utf-8?B?WVU1eVVMZFV1ZjZWdmhVNllYRlJGYjN2S1NZS3VyL1duVWdQM3lMeXNPMW93?=
 =?utf-8?B?L2hCOStNU0FIQ3VIbDlvQWhEcWJkem5NZFVTU3BWWTBxRkQyN005czRLWFF4?=
 =?utf-8?B?bUtPOGQ5cENMOUlNUDhFQnd4ZDNnUmp5b1dyNkwzNUFDZ1JhOTRWV2hzdjZI?=
 =?utf-8?B?a0Zvbm5iQmFYSWk3ZERHNjAxT1dRMTJ4UVhRYldBNEVUSWo5OG9RM3ZpNVhB?=
 =?utf-8?B?L0pFSUNUeGdiMmdRbm9iR0w3eml4ckhPSURicDNwelZZZ3Zua1pyS1JqOHpq?=
 =?utf-8?B?WnB5ZmlQTnlZNHMzYkRWTVhySFZYVjRUbDcyUktxWFdMNzBGbFJiNzIzc2JS?=
 =?utf-8?B?ZGRpVlVHQnM2T3ZKZTROVWh0R3JyQWY1ZzN3SE00TE5iUXFScXR1WG53UU41?=
 =?utf-8?B?SjFyOFRaak53ZUVFUy9zeDAwRXhPNmJvdmZmaGhyNXczKzlaQWtIS2k3N1lB?=
 =?utf-8?B?QTN6SHI1a08xL3ZOVkEwUGpjMXpNQUVXeFI4SUloVkFqRFVKMWVoMUxUSzJq?=
 =?utf-8?B?U3JHR0lXRDdwejY1NTBJdEhYZHM5b2FrMWNKbFFHNll6MlQxY2ZNSGhpU2xZ?=
 =?utf-8?B?cm4vbE1aN1hSb0FpT1Y4RFFlRDBBM0xIbThZTXl5QWE0Zi85VklWK2RqMC9x?=
 =?utf-8?B?cnNpWXhkcTBzVW5heDR3MUhtV3g5VCtERnZpY1hFTEVRVHBFTXAwSzRVUTRx?=
 =?utf-8?B?Q1FoZHZvVnlORVdwdUZ2WW9nYlRFeWVvQUhFWmpLeGJ2L3ZDNWdDcVFKVVhE?=
 =?utf-8?B?R3pDS1VvUmlkT2V3N1Q5UWpVVW1Jc3JPZXhiTUlvS09SQW9Yd0czY0k4Sng4?=
 =?utf-8?B?bENqMFhLOWlVWG5HZFVtMTNGbmdzMWJkNlF0dXB3VXJvRmRtdGVTc2hvMldh?=
 =?utf-8?B?Wm5MZzg5dW1qNlRiK1A2Tm8vc3FPWU1tTVltL0hNNmF0TmVsdEVPOUtlb0hr?=
 =?utf-8?B?SFhkY2lzRTJjSUpkNDhsTnpzNDZ0R1g3TVR1MW1qbHY1ZXJHS0ZFNTBPVUx6?=
 =?utf-8?B?TEEvR2Nyem12dnpoajBFTCs0UHdvaThncnFCc3BQN1lyWStuSWo0cDAyaWNv?=
 =?utf-8?B?ZGVPYkJJRlIwQUZNWS9UbFZCWU0zTm9QSDRPWHlPZGpJMFZaTFlGVGkwTVhQ?=
 =?utf-8?B?dUZxRTBEZnQ2NW1zbU1tVW9FemNXanA1cG41RDRSNW4rV0w3WXEzRWxMeVl4?=
 =?utf-8?B?R01saEp3VkJXQ0QwMTc4ZTMrdm91LzFHSkxGd3pReEhnUlVOeGR0Y1laNk1v?=
 =?utf-8?B?YXJ3Nml4TWE5NUtpc2Fkc0l3TXdNYTRwOEJOT1Fab2xqWVV1R1RrOFlQa3Y0?=
 =?utf-8?B?anVqSmJYY3JVNmlMc2xWZXlQR252S05YQ2dKa0NQM3VENEhNelJJQWVFTjR5?=
 =?utf-8?B?c3ROcmd4dDEweFhQQkRPcHVoQjV0REVjRDAzM0FvVk01YzYxQ3RqUzFzbWZW?=
 =?utf-8?B?eU9NRmNIQ3lDTThqQkgxcmM2K2puNmFsWHJ2bTM3MXdlQy8zcHE5b2EwV2c5?=
 =?utf-8?B?eXU5bHJUMFZxdVJGRTYvd1ZtTkY5am1BN2UrcWZJa3pWUGVld2EwTnRFRW9y?=
 =?utf-8?B?SSsrNVByMTAxUFRRSE02M3dIWkxHUnN6RWI5eGRlWXhZcVdmWC9uK3ZUZVJJ?=
 =?utf-8?B?VHRDS29BVWUwME1HV1VSR2FwZmYrcXN0NVZrTnFkbThiWElpc1YraFZRN3FW?=
 =?utf-8?Q?K0nE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086fda3f-1719-4bec-1c38-08dbbb0bdbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 01:33:00.9346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QC+tIfyubDFkvZ50AU32ZT4a6Jh1ca7MBKVE1g2r4YzRkb6TtOhJ6BU9TYuMvz368n1dxPwTANiQMX7bNtjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7340
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj5TZW50OiAyMDIz
5bm0OeaciDIx5pelIDE3OjU1DQo+VG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBN
aXJlbGEgUmFidWxlYSAoT1NTKQ0KPjxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT47IHJvYmgr
ZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPkNjOiBtY2hlaGFiQGtlcm5lbC5v
cmc7IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubDsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj5r
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgWC5ILiBCYW8NCj48eGlh
aG9uZy5iYW9AbnhwLmNvbT47IEVhZ2xlIFpob3UgPGVhZ2xlLnpob3VAbnhwLmNvbT47IFRhbyBK
aWFuZw0KPjx0YW8uamlhbmdfMkBueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT47IGxpbnV4LQ0KPm1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPmtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+U3Vi
amVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MiAyLzJdIGR0LWJpbmRpbmdzOiBtZWRpYTogaW14LWpw
ZWc6IEFzc2lnbiBzbG90IGZvcg0KPmlteCBqcGVnIGVuY29kZXIvZGVjb2Rlcg0KPg0KPkNhdXRp
b246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlj
a2luZyBsaW5rcyBvcg0KPm9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9y
dCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPnRoaXMgZW1haWwnIGJ1dHRvbg0KPg0K
Pg0KPk9uIDIxLzA5LzIwMjMgMDg6MzYsIE1pbmcgUWlhbiB3cm90ZToNCj4+IFRoZXJlIGFyZSB0
b3RhbCA0IHNsb3RzIGF2YWlsYWJsZSBpbiB0aGUgSVAsIGFuZCB3ZSBvbmx5IG5lZWQgdG8gdXNl
DQo+PiBvbmUgc2xvdCBpbiBvbmUgb3MsIGFzc2lnbiBhIHNpbmdsZSBzbG90LCBjb25maWd1cmUg
aW50ZXJydXB0IGFuZA0KPj4gcG93ZXIgZG9tYWluIG9ubHkgZm9yIDEgc2xvdCwgbm90IGZvciB0
aGUgYWxsIDQgc2xvdHMuDQo+DQo+UGxlYXNlIHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5w
bCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2FyeSBwZW9wbGUgYW5kIGxpc3RzDQo+dG8gQ0MuIEl0
IG1pZ2h0IGhhcHBlbiwgdGhhdCBjb21tYW5kIHdoZW4gcnVuIG9uIGFuIG9sZGVyIGtlcm5lbCwg
Z2l2ZXMgeW91DQo+b3V0ZGF0ZWQgZW50cmllcy4gVGhlcmVmb3JlIHBsZWFzZSBiZSBzdXJlIHlv
dSBiYXNlIHlvdXIgcGF0Y2hlcyBvbiByZWNlbnQNCj5MaW51eCBrZXJuZWwuDQo+DQo+WW91IG1p
c3NlZCBhdCBsZWFzdCBkZXZpY2V0cmVlIGxpc3QgKG1heWJlIG1vcmUpLCBzbyB0aGlzIHdvbid0
IGJlIHRlc3RlZCBieQ0KPmF1dG9tYXRlZCB0b29saW5nLiBQZXJmb3JtaW5nIHJldmlldyBvbiB1
bnRlc3RlZCBjb2RlIG1pZ2h0IGJlIGEgd2FzdGUgb2YNCj50aW1lLCB0aHVzIEkgd2lsbCBza2lw
IHRoaXMgcGF0Y2ggZW50aXJlbHkgdGlsbCB5b3UgZm9sbG93IHRoZSBwcm9jZXNzIGFsbG93aW5n
IHRoZQ0KPnBhdGNoIHRvIGJlIHRlc3RlZC4NCj4NCj5QbGVhc2Uga2luZGx5IHJlc2VuZCBhbmQg
aW5jbHVkZSBhbGwgbmVjZXNzYXJ5IFRvL0NjIGVudHJpZXMuDQo+DQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9iaW5k
aW5ncy9tZWRpYS9ueHAsaW14OC1qcGVnLnlhbWwgICAgICAgICB8IDQwICsrKysrKysrLS0tLS0t
LS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdA0KPj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55YW1sDQo+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZWRpYS9ueHAsaW14OC1qcGVnLnlhbWwNCj4+IGluZGV4IDNkOWQxZGIz
NzA0MC4uNWYwZTJmYzFlYTljIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21lZGlhL254cCxpbXg4LWpwZWcueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL254cCxpbXg4LWpwZWcueWFtbA0KPj4gQEAg
LTMyLDI1ICszMiwyNyBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgICBtYXhJdGVtczogMQ0KPj4NCj4+
ICAgIGludGVycnVwdHM6DQo+PiAtICAgIGRlc2NyaXB0aW9uOiB8DQo+PiAtICAgICAgVGhlcmUg
YXJlIDQgc2xvdHMgYXZhaWxhYmxlIGluIHRoZSBJUCwgd2hpY2ggdGhlIGRyaXZlciBtYXkgdXNl
DQo+PiAtICAgICAgSWYgYSBjZXJ0YWluIHNsb3QgaXMgdXNlZCwgaXQgc2hvdWxkIGhhdmUgYW4g
YXNzb2NpYXRlZCBpbnRlcnJ1cHQNCj4+IC0gICAgICBUaGUgaW50ZXJydXB0IHdpdGggaW5kZXgg
aSBpcyBhc3N1bWVkIHRvIGJlIGZvciBzbG90IGkNCj4+IC0gICAgbWluSXRlbXM6IDEgICAgICAg
ICAgICAgICAjIEF0IGxlYXN0IG9uZSBzbG90IGlzIG5lZWRlZCBieSB0aGUgZHJpdmVyDQo+PiAt
ICAgIG1heEl0ZW1zOiA0ICAgICAgICAgICAgICAgIyBUaGUgSVAgaGFzIDQgc2xvdHMgYXZhaWxh
YmxlIGZvciB1c2UNCj4+ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAgSW50ZXJydXB0IG51
bWJlciBmb3Igc2xvdA0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4NCj4+ICAgIHBvd2VyLWRvbWFp
bnM6DQo+PiAgICAgIGRlc2NyaXB0aW9uOg0KPj4gICAgICAgIExpc3Qgb2YgcGhhbmRsZSBhbmQg
UE0gZG9tYWluIHNwZWNpZmllciBhcyBkb2N1bWVudGVkIGluDQo+PiAgICAgICAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Bvd2VyX2RvbWFpbi50eHQNCj4+IC0gICAg
bWluSXRlbXM6IDIgICAgICAgICAgICAgICAjIFdyYXBwZXIgYW5kIDEgc2xvdA0KPj4gLSAgICBt
YXhJdGVtczogNSAgICAgICAgICAgICAgICMgV3JhcHBlciBhbmQgNCBzbG90cw0KPj4gKyAgICBt
aW5JdGVtczogMSAgICAgICAgICAgICAgICMgVlBVTUlYDQo+PiArICAgIG1heEl0ZW1zOiAyICAg
ICAgICAgICAgICAgIyBXcmFwcGVyIGFuZCAxIHNsb3QNCj4+ICsNCj4+ICsgIHNsb3Q6DQo+PiAr
ICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIEludGVnZXIgbnVtYmVyIG9mIHNsb3QgaW5kZXgg
dXNlZC4gdGhlIHZhbHVlIHJhbmdlIGlzIGZyb20gMCB0bw0KPj4gKyAzDQo+DQo+RG9uJ3QgeW91
IGhhdmUgaGVyZSBvYnZpb3VzIGVycm9ycyByZXBvcnRlZCBieSB0ZXN0aW5nPyBEaWQgeW91IHRl
c3QgdGhpcz8NCj4NCj5CZXN0IHJlZ2FyZHMsDQo+S3J6eXN6dG9mDQoNCkhpIEtyenlzenRvZiwN
CiAgICBDYW4geW91IHBvaW50IG91dCB3aGljaCB0ZXN0IGVycm9yPyBJIHJ1biB0aGUgZHRfYmlu
ZGluZ19jaGVjayBhbmQgZGlkbid0IGdldCBhbnkgZXJyb3IuDQoNCm1ha2UgRFRfQ0hFQ0tFUl9G
TEFHUz0tbSBkdF9iaW5kaW5nX2NoZWNrIERUX1NDSEVNQV9GSUxFUz1Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55YW1sDQogIExJTlQgICAgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzDQogIENIS0RUICAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Byb2Nlc3NlZC1zY2hlbWEuanNvbg0KICBTQ0hFTUEgIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wcm9jZXNzZWQtc2NoZW1hLmpzb24NCiAgRFRF
WCAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtanBl
Zy5leGFtcGxlLmR0cw0KICBEVENfQ0hLIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZWRpYS9ueHAsaW14OC1qcGVnLmV4YW1wbGUuZHRiDQoNCg==
