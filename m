Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12DF7B4A88
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 03:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjJBBXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 21:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjJBBXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 21:23:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297B0B7;
        Sun,  1 Oct 2023 18:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8nXJxSj9eIU2clt2z8+lEef6PX3naV3ie8x0Yrw2rYD4AiOtSkDmUkEt0JwXdiGQtWg2l8MBa39zs6J+4AWPag2he+gSM1eQaevtTn6xHbfLOfM+I7YS7ua+3Pw/IOms9V38vWGxY9O4fFWchoBcVhBvWE6jRIwfXqi+cn9c377zjLpeRcuJoulNF/QvyVb5QuJ0w9DOlemYrByjLOj52sjl/9orQ6g+ipkR7iNnKsRSgAT+6i2btILO6Tj9JylGULGBylIvx48iPcNNIyOe3ksB8Q1EbNw9LBSzoqH9QbiHgYgrywcnUqPTg3NOdyMuoVavEg6hoxNkUnhrnP78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsKT/VIGL81q85PlMk7JiVaYU7Wlg2iPC5NXE25WLRg=;
 b=l0gGsCJm4Mo1ET5KYepgyX6hIHXvEO91v6a/NaZS8R6hgHnvXdiyTcGQ9iwr2688b/FIcCePXAgST9ffcD7sHg34YtB5qR/AuRS0uuqQUeo1uV07BOchDHrztVJbIKT8LBFkRlVKnVDjdqS09BIfXCbU+aebdtTUOj++iBCj0Lakmap/FB4MsqF2y0Lu8asXIks2OcVhbIu2UCxnWWLxjbPH1O/RxB19i0BtP22B8ZSEbKpHbAiL4eeeCmcA2wy3EqFVYPByOPfsKEy12suLnVgCatn3vQiHJIXsP3b4NIq0oIvLhKQwhZB4EGGkEcx6TV6b5eZQ0AL3OJWN56IUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsKT/VIGL81q85PlMk7JiVaYU7Wlg2iPC5NXE25WLRg=;
 b=jU3uzWP2f5i8lLItt35BDho2tP1PBKQSNMzg8hjQe+oqqGCs/fOR063GyuoKjSsyynpgItFyuKjNg5sRmBUAE+n5/pa2pbbwnAqlzypP6Z4Qn88oAnufU8Ga3wFDh5aXi0/xHFuSCCYmSe3swiaUo5aeLnGS9gRZZLmm8fR95oc=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 01:23:37 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 01:23:37 +0000
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
Subject: RE: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Index: AQHZ8GGrmZBLZQgREEat4sCPmu/sQrAuUiWAgAANvVCAAVJ5AIAAR0kggAN9mgCAAkOR4A==
Date:   Mon, 2 Oct 2023 01:23:37 +0000
Message-ID: <AM6PR04MB634169ABB70DE725489F903EE7C5A@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
 <2c351ca0-cee4-4c1b-956b-6134ad101a9a@linaro.org>
 <AM6PR04MB63415CF2EDCF0AF33F778774E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <45abc9ec-1f7a-469c-bc0f-2a065499b0b4@linaro.org>
 <AM6PR04MB63412A27FDC244D1A8FB7CA0E7C1A@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <80106a0b-87a6-47e2-93ed-5e19ac76ef45@linaro.org>
In-Reply-To: <80106a0b-87a6-47e2-93ed-5e19ac76ef45@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AS8PR04MB7688:EE_
x-ms-office365-filtering-correlation-id: a90e7988-817b-4d71-3e82-08dbc2e633eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LY0XdTX+Nw5NH3QRpcqlcAwnyqyf7eFiHpFAhNMC0SOL0w3ByZ4eu6aGVJ5y498u9tTzebZXTLhMCWlAVNuD8n4CLDA5OxgBtk0QMS6UkEpvk3vUCN4pM29+6nxKLRli0ENA2OpUYJF2Mee0QtgfL/c0HrfWdYJ9P69hII0pFhjDgOnP30Pvg7L/zLE+acI4Jm+wcorgrXzpPVODTTtRQVnapr1EiJR28ZsQNvV/S7WiU/okU58/dyM661qHUsanwQtr8jlcwxGRPAWp6tmHgQJ44HxnPmQeGuly2HzYDwW5y+4IZ1zQ/7zGMre/8W1EOeHJ+lk0Lrbqb1IHZQ6EMdvJLMCe0b5gWuudDEv0V2QJID33t1D7c9FyGKdC7CrGT0GbRh4GYVKwACS3wQofBs+pcU9hXhHSjK0/f+c0/z5Z5AUoe0eGNzeGxDNxXelMnUPwXRCy4J+AtfBFWgTr5yKqCt5oWd2kccJwTALtQt5h75ZD5JivC9pyaguesBUP3Chggf/NcGZBIHFVjhkbdRt99KRL8vcn8vc7rkYbaJv+AZ9bhgt7nDXmqPCxgGbJsQdnlnj18jXf2t3JVjHM4uQXWaCmjw/KnfzI51XxEoKNVgqddUpSIAD4FUg7hxsZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(26005)(38100700002)(38070700005)(122000001)(33656002)(86362001)(83380400001)(54906003)(316002)(4326008)(44832011)(52536014)(8936002)(5660300002)(41300700001)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2906002)(66946007)(110136005)(6506007)(7696005)(7416002)(53546011)(71200400001)(9686003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTltZ2hVYW8yNzk0VzhWY3FBWEE0TTJXblROaE1NYWpyc05pOHVGdGxCRXlR?=
 =?utf-8?B?dThaWG5WUVB5dGF4NFF3THpySjNaVzdYbGpaL0xNd0ZueXBmYytJUjVGKys0?=
 =?utf-8?B?NnN2UGswdCtpSkM0UHZKVTJpazkzTk1HNjNYcVgzVmhIZEp5TEJjdWV5WUxY?=
 =?utf-8?B?NHVvRE5jUXN3UTRWUEY2SnZ4K3YvMTJRMjRyQUNucEJyNFlndkZmd09Rdmoy?=
 =?utf-8?B?cU8yUTNrS1NxY082M0JkRFJCcVI5ZlRnT2VKVTFqeHJWeTZNazJQM2hVbWZo?=
 =?utf-8?B?SUpwUGRHYzJGR1lNR0t5eml4Qm9iOWlBenRzR3hZWGN0OStNOFRoMFh4R01l?=
 =?utf-8?B?M0M1SDdZU1l1QmRoVkx1bGpNY24rY1BpN0lhelIrVnhJdHl4aXU0cnBrd2dx?=
 =?utf-8?B?S3VHUEtTdytSTWpFVjNzMU9TOS9IZ2tLT0hCY3JJYldzSkVReGVwL1VVYng1?=
 =?utf-8?B?czd2TVRjSHlPcTJqRHF4WVZUcmR5OGU5Y1IwYkRxOGhUM0g0RlI3TVk1WUdG?=
 =?utf-8?B?c2Nhc3k0WnJJZFR2NlRaUGw0VUFHN2t2UmVaZFRjUFpBVHFYc1QwSVBZT3NW?=
 =?utf-8?B?aGRiQVFrS214bWEvMjJHdFlkOThHNWg1b2pKdWk1R2I3VDBBcHk2T3hjMjFY?=
 =?utf-8?B?Y3JrdkVWUWdpMk5jdW8zSWxYZkJSNitxUzVLSVk0TzMwbmRodlJmY3ZPT3Rl?=
 =?utf-8?B?cGQ5eW9rUGFsWUN2bk5DT3c5c2pSbUFHcVR5TkVxYTgwNXF0elgxeTJ2OHY4?=
 =?utf-8?B?ZDNoNC9TR2NvbGtDZVlUeFRhalNTZW51emZqRXFOb3cxOCs4UXFWTTVWQ1Ft?=
 =?utf-8?B?ZHMxUGp5ZmhyVkd1bkFMMFdMVGI5M3Y4WExoYU5PU3NOV3ZlRHE2cUhtaDR0?=
 =?utf-8?B?RjU0bU55UEc3c1lJWlpJZ01yOXUwZExLUTVVdUExNlZ5cXlJNGVqZWpCZ1Av?=
 =?utf-8?B?OGVDc21vZitOdGxSeFJ6K2h1bkZVUUFyZkFVM24yaGJFTjdpT1h0NEZ2YmYy?=
 =?utf-8?B?SFdmL2dudzQ2NUc3SGwrUjhOdFRDMHh1bjFLSkdlMGI0ajh4TFdScmtSS1BM?=
 =?utf-8?B?YW1YZGJSWUsvWmhRN01CRFl6Q21EeGUrSUFMOHN5YXhpbjVNRjR2bXIzQzlM?=
 =?utf-8?B?MEU0RXlNdGV3ZXpkckRyZmxheG9HckVFOXdYaHBnM2Z6THg3SzQvcnp4S0hl?=
 =?utf-8?B?QWN3YldlQ2NCcFFYTUkyNFRkK2l5TUtkdGFJWmFuOU5vKzQ4MTBqZ0k5ckRH?=
 =?utf-8?B?RExRMVJGZTZvSngraklIQWpwRURjRVZWaTYxMlhPSCtzayt5OU9hM1VwSmxi?=
 =?utf-8?B?N05SZ2t6OTVuMkdaUUhZaWcvYkZlRFFXYjFjdHd6MXB4Z3MxQllMaHhIRzAx?=
 =?utf-8?B?ODBWMlJ2ejRoSkFJcDE3NklzUGZ4MlN0RmZTK0VvVnRwd3ppTXZFNXphRldk?=
 =?utf-8?B?QWtzRE9uSzloNUwxLzlqM2lURk9pK1pEQkIvUDh1NHFDbEk1RGxrRDhMU1hr?=
 =?utf-8?B?VzN3VGNoUDhSd2JyT3ZCMVJZcmJvU1BNN0hRa2pSUmxQeHM2S1piWVNjWVV1?=
 =?utf-8?B?NUlFT0Iwd3dHb2NSZWJ4ZnNNQ1ZQRkg2blZYajZHY2Nkd21hSDlrSkJOR042?=
 =?utf-8?B?VElWZWJQcGNQY1FCcFJCbDdBbVhxUHlxdHNRVk5rSnV2enB1S2RmeFNFSlBa?=
 =?utf-8?B?bTJ5ak9mK3pLdDJOQ2c4ejBRNjliNEVRczdnNThnRUJwdFJVQ2VTRENDODd0?=
 =?utf-8?B?NWVBWjZZMGNvb0NIelNyK2g5b3A0ODlTNXI0SUI1UmVWeGNaRnRteUwrbDlv?=
 =?utf-8?B?RnJWengvT25NM0ZpUHR1Umg3d0E4SnkxV0huV0E1VVlTNUNrRVltZEY5anhS?=
 =?utf-8?B?Y0FtUDR4UEtLdy9pUDhvcXB4SVdKa3RXbXZZS2NmOEJ4MmFKQXJHR0poZVQx?=
 =?utf-8?B?MllEb2hYTTVsV0xyQTROMlN2SnRmUWIrOGVwTjZmaHJlNFdsUFBObllpUzZo?=
 =?utf-8?B?TWl4bytUVi9BQjZZUGxnTXo0N1NnaWZCUjFjR0NGTmFIWnNPYllaK3FoZ3BJ?=
 =?utf-8?B?Qk55cjdTdm9wQWdxL01tbUJHMGZvbWZWOVNYY0tJNU4ybnJQYk15VHM5akFV?=
 =?utf-8?Q?qCwU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90e7988-817b-4d71-3e82-08dbc2e633eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 01:23:37.1934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekcQC6ioU+GG9JETCG9/2oiUIp6EotNWftFuE/4oCEu9szQwSRk4jb7d/b7SbxZo6MP1iiel4AEGAa3Dm8zj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4NCj5TZW50OiAyMDIz5bm0OeaciDMw5pelIDIyOjQwDQo+VG86IE1pbmcgUWlhbiA8bWluZy5x
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
XSBSZTogW1BBVENIIHY0IDIvMl0gZHQtYmluZGluZ3M6IG1lZGlhOiBpbXgtanBlZzogQXNzaWdu
IHNsb3QNCj5mb3IgaW14IGpwZWcgZW5jb2Rlci9kZWNvZGVyDQo+DQo+Q2F1dGlvbjogVGhpcyBp
cyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtz
IG9yDQo+b3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNz
YWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+dGhpcyBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+T24gMjgv
MDkvMjAyMyAxMTo0MiwgTWluZyBRaWFuIHdyb3RlOg0KPj4+IEZyb206IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4+PiBTZW50OiAyMDIz5bm0
OeaciDI45pelIDEzOjA3DQo+Pj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBN
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
amVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjQgMi8yXSBkdC1iaW5kaW5nczogbWVkaWE6IGlt
eC1qcGVnOg0KPj4+IEFzc2lnbiBzbG90IGZvciBpbXgganBlZyBlbmNvZGVyL2RlY29kZXINCj4+
Pg0KPj4+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNh
cmUgd2hlbiBjbGlja2luZw0KPj4+IGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4g
aW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZw0KPj4+IHRoZSAnUmVwb3J0IHRoaXMg
ZW1haWwnIGJ1dHRvbg0KPj4+DQo+Pj4NCj4+PiBPbiAyNy8wOS8yMDIzIDExOjEwLCBNaW5nIFFp
YW4gd3JvdGU6DQo+Pj4+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296
bG93c2tpQGxpbmFyby5vcmc+DQo+Pj4+PiBTZW50OiAyMDIz5bm0OeaciDI35pelIDE2OjA2DQo+
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
PiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY0IDIvMl0gZHQtYmluZGluZ3M6IG1lZGlhOiBp
bXgtanBlZzoNCj4+Pj4+IEFzc2lnbiBzbG90IGZvciBpbXgganBlZyBlbmNvZGVyL2RlY29kZXIN
Cj4+Pj4+DQo+Pj4+PiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2Ug
dGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcNCj4+Pj4+IGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVu
dHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZQ0KPj4+Pj4gdXNpbmcgdGhlICdS
ZXBvcnQgdGhpcyBlbWFpbCcgYnV0dG9uDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IE9uIDI2LzA5LzIw
MjMgMTI6MTAsIE1pbmcgUWlhbiB3cm90ZToNCj4+Pj4+PiBUaGVyZSBhcmUgdG90YWwgNCBzbG90
cyBhdmFpbGFibGUgaW4gdGhlIElQLCBhbmQgd2Ugb25seSBuZWVkIHRvDQo+Pj4+Pj4gdXNlIG9u
ZSBzbG90IGluIG9uZSBvcywgYXNzaWduIGEgc2luZ2xlIHNsb3QsIGNvbmZpZ3VyZSBpbnRlcnJ1
cHQNCj4+Pj4+PiBhbmQgcG93ZXIgZG9tYWluIG9ubHkgZm9yIDEgc2xvdCwgbm90IGZvciB0aGUg
YWxsIDQgc2xvdHMuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1p
bmcucWlhbkBueHAuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+IHY0DQo+Pj4+Pj4gLSBpbXByb3Zl
IGNvbW1pdCBtZXNzYWdlDQo+Pj4+Pj4gLSBkb24ndCBtYWtlIGFuIEFCSSBicmVhaw0KPj4+Pj4+
IHYzDQo+Pj4+Pj4gLSBhZGQgdmVuZGVyIHByZWZpeCwgY2hhbmdlIHByb3BlcnR5IHNsb3QgdG8g
bnhwLHNsb3QNCj4+Pj4+PiAtIGFkZCB0eXBlIGZvciBwcm9wZXJ0eSBzbG90DQo+Pj4+Pj4NCj4+
Pj4+PiAgLi4uL2JpbmRpbmdzL21lZGlhL254cCxpbXg4LWpwZWcueWFtbCAgICAgICAgIHwgNDUg
KysrKysrKysrLS0tLS0tLS0tLQ0KPj4+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9u
cygrKSwgMjQgZGVsZXRpb25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0DQo+Pj4+Pj4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55
YW1sDQo+Pj4+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbnhw
LGlteDgtanBlZy55YW1sDQo+Pj4+Pj4gaW5kZXggM2Q5ZDFkYjM3MDQwLi40YmNmYzgxNWM4OTQg
MTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21l
ZGlhL254cCxpbXg4LWpwZWcueWFtbA0KPj4+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZWRpYS9ueHAsaW14OC1qcGVnLnlhbWwNCj4+Pj4+PiBAQCAtMzIsMTkg
KzMyLDI2IEBAIHByb3BlcnRpZXM6DQo+Pj4+Pj4gICAgICBtYXhJdGVtczogMQ0KPj4+Pj4+DQo+
Pj4+Pj4gICAgaW50ZXJydXB0czoNCj4+Pj4+PiAtICAgIGRlc2NyaXB0aW9uOiB8DQo+Pj4+Pj4g
LSAgICAgIFRoZXJlIGFyZSA0IHNsb3RzIGF2YWlsYWJsZSBpbiB0aGUgSVAsIHdoaWNoIHRoZSBk
cml2ZXIgbWF5IHVzZQ0KPj4+Pj4+IC0gICAgICBJZiBhIGNlcnRhaW4gc2xvdCBpcyB1c2VkLCBp
dCBzaG91bGQgaGF2ZSBhbiBhc3NvY2lhdGVkIGludGVycnVwdA0KPj4+Pj4+IC0gICAgICBUaGUg
aW50ZXJydXB0IHdpdGggaW5kZXggaSBpcyBhc3N1bWVkIHRvIGJlIGZvciBzbG90IGkNCj4+Pj4+
PiAtICAgIG1pbkl0ZW1zOiAxICAgICAgICAgICAgICAgIyBBdCBsZWFzdCBvbmUgc2xvdCBpcyBu
ZWVkZWQgYnkgdGhlIGRyaXZlcg0KPj4+Pj4+IC0gICAgbWF4SXRlbXM6IDQgICAgICAgICAgICAg
ICAjIFRoZSBJUCBoYXMgNCBzbG90cyBhdmFpbGFibGUgZm9yIHVzZQ0KPj4+Pj4+ICsgICAgZGVz
Y3JpcHRpb246DQo+Pj4+Pj4gKyAgICAgIEludGVycnVwdCBudW1iZXIgZm9yIHNsb3QNCj4+Pj4+
PiArICAgIG1heEl0ZW1zOiAxDQo+Pj4+Pj4NCj4+Pj4+PiAgICBwb3dlci1kb21haW5zOg0KPj4+
Pj4+ICAgICAgZGVzY3JpcHRpb246DQo+Pj4+Pj4gICAgICAgIExpc3Qgb2YgcGhhbmRsZSBhbmQg
UE0gZG9tYWluIHNwZWNpZmllciBhcyBkb2N1bWVudGVkIGluDQo+Pj4+Pj4gICAgICAgIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9wb3dlcl9kb21haW4udHh0DQo+Pj4+
Pj4gLSAgICBtaW5JdGVtczogMiAgICAgICAgICAgICAgICMgV3JhcHBlciBhbmQgMSBzbG90DQo+
Pj4+Pj4gLSAgICBtYXhJdGVtczogNSAgICAgICAgICAgICAgICMgV3JhcHBlciBhbmQgNCBzbG90
cw0KPj4+Pj4+ICsgICAgbWluSXRlbXM6IDEgICAgICAgICAgICAgICAjIFZQVU1JWA0KPj4+Pj4+
ICsgICAgbWF4SXRlbXM6IDIgICAgICAgICAgICAgICAjIFdyYXBwZXIgYW5kIDEgc2xvdA0KPj4+
Pj4+ICsNCj4+Pj4+PiArICBueHAsc2xvdDoNCj4+Pj4+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5
cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPj4+Pj4+ICsgICAgZGVzY3JpcHRpb246DQo+
Pj4+Pj4gKyAgICAgIEludGVnZXIgbnVtYmVyIG9mIHNsb3QgaW5kZXggdXNlZC4gVGhlcmUgYXJl
IDQgc2xvdHMgYXZhaWxhYmxlIGluIHRoZQ0KPklQLA0KPj4+Pj4+ICsgICAgICBhbmQgZHJpdmVy
IGNhbiB1c2UgYSBjZXJ0YWluIHNsb3QsIGl0IHNob3VsZCBoYXZlIGFuDQo+Pj4+Pj4gKyBhc3Nv
Y2lhdGVkDQo+Pj4gaW50ZXJydXB0DQo+Pj4+Pj4gKyAgICAgIGFuZCBwb3dlci1kb21haW4uIElu
IHRoZW9yeSwgaXQgc3VwcG9ydHMgNCBvcyBvciB2bS4gSWYgbm90DQo+Pj4+Pj4gKyBzcGVjaWZp
ZWQsDQo+Pj4gMA0KPj4+Pj4+ICsgICAgICBpcyB1c2VkIGJ5IGRlZmF1bHQuDQo+Pj4+Pj4gKyAg
ICBtaW5pbXVtOiAwDQo+Pj4+Pj4gKyAgICBtYXhpbXVtOiAzDQo+Pj4+Pg0KPj4+Pj4gTkFLLCB5
b3Ugc3RpbGwgZGlkIG5vdCBhbnN3ZXIgY29uY2VybnMgd2h5IHRoaXMgaXMgbmVlZGVkIGFuZCBq
dXN0aWZpZWQuDQo+Pj4+PiBJIGtlZXAgYXNraW5nIGFuZCB5b3Uga2VlcCBpZ25vcmluZy4uLg0K
Pj4+Pj4NCj4+Pj4+IEJlc3QgcmVnYXJkcywNCj4+Pj4+IEtyenlzenRvZg0KPj4+Pg0KPj4+PiBI
aSBLcnp5c3p0b2YsDQo+Pj4+DQo+Pj4+PiBOb3RoaW5nIGV4cGxhaW5zIHdoYXQgaXMgYSBzbG90
IGFuZCBub3RoaW5nIGV4cGxhaW5zIHdoeSBkbyB5b3UNCj4+Pj4+IG5lZWQgdGhpcw0KPj4+IHBy
b3BlcnR5Lg0KPj4+Pg0KPj4+PiBJIHRob3VnaHQgSSBoYWQgYW5zd2VyZWQgdGhhdCBxdWVzdGlv
biwgYnV0IHNlZW1zIHlvdSBkb24ndCBhZ3JlZQ0KPj4+PiB3aXRoIHRoYXQNCj4+PiBleHBsYW5h
dGlvbi4NCj4+Pj4gV291bGQgdGhlIGZvbGxvd2luZyBkZXNjcmlwdGlvbiBiZSBhbnkgYmV0dGVy
Pw0KPj4+DQo+Pj4gTm8sIHlvdSBkaWRuJ3QuIEkgZG9uJ3Qgc2VlIGFueSBleHBsYW5hdGlvbiBp
biB0aGUgY29tbWl0IG1zZy4gWW91DQo+Pj4ganVzdCBzYXkgeW91IGhhdmUgIjQgc2xvdHMiLg0K
Pj4+DQo+Pj4gQmVzdCByZWdhcmRzLA0KPj4+IEtyenlzenRvZg0KPj4NCj4+IEhpIEtyenlzenRv
ZiwNCj4+DQo+PiBJIGNoZWNrIHRoZSBvdXIgZG9jdW1lbnQgYWdhaW4sIGl0IGRvZXMgbm90IGdp
dmUgYSBzdGFuZGFyZCBkZWZpbml0aW9uIHRvby4gSSdsbA0KPmV4cGxhaW4gaXQgYXMgSSB1bmRl
cnN0YW5kIGl0LiBUaGlzIElQIGluY2x1ZGVzIGEganBlZyB3cmFwcGVyLCB0aGUgd3JhcHBlciBp
cw0KPndvcmtpbmcgb24gZGVzY3JpcHRvciBiYXNlZCBtYW5uZXIuIEl0IHN1cHBvcnQgdXAgdG8g
NCBzbG90cywgZWFjaCBzbG90cyBjYW4NCj5oYXZlIGl0cyBvd24gY2hhaW5lZCBkZXNjcmlwdG9y
cy4gVGhlIHB1cnBvc2UgaXMgdG8gc2hhcmUgdGhlIGpwZWcgZW5naW5lDQo+YWNyb3NzIG11bHRp
cGxlIFZNUyBhbmQgb3MsIEl0J3MgYSBiaXQgbGlrZSB2bSBwYXJ0aXRpb25pbmcuIFdlIGp1c3Qg
d2FudCB0bw0KPmFzc2lnbiAxIHNsb3QgdG8gbGludXgsIFRoZW4sIHRoZW9yZXRpY2FsbHksIGl0
IGNhbiBzdXBwb3J0IHVwIHRvIDMgVk1TLg0KPj4gVGhlIHNsb3QgaW5kZXggaW5kaWNhdGVzIHdo
aWNoIHNsb3Qgd2UgY2hvb3NlLCBkcml2ZXIgd2lsbCB1c2UgdGhlIHNsb3QgaW5kZXgNCj50byBj
b25maWd1cmUuIElmIG5vdCBzcGVjaWZpZWQsIDAgaXMgdXNlZCBieSBkZWZhdWx0Lg0KPj4gQ3Vy
cmVudGx5IGRyaXZlciBvbmx5IHVzZSB0aGUgc2xvdCAwIGJ5IGRlZmF1bHQsIGJ1dCBpdCBlbmFi
bGUgdGhlIHBvd2VyLQ0KPmRvbWFpbiBhbmQgcmVxdWVzdCBpcnEgdG8gYWxsIHRoZSA0IHNsb3Rz
LiAgdGhlcmUgaGFzIGJlZW4gbm8gcmVhbCBuZWdhdGl2ZQ0KPmltcGFjdCwgYXMgd2UgaGF2ZSBu
byBwcmFjdGljYWwgYXBwbGljYXRpb24gdG8gdXNlIG90aGVyIHNsb3RzIHlldC4gQnV0IGl0IGRv
ZXMNCj5jYXVzZSB0cm91YmxlIHdoZW4gd2Ugd2FudCB0byB1c2UgYW5vdGhlciBzbG90IGluIGEg
dm0uDQo+DQo+V2hpY2ggcGFydHMgb2YgaGFyZHdhcmUgYXJlIGNvbW1vbiBhbmQgd2hpY2ggYXJl
IHNoYXJlZD8NCj4NCj5CZXN0IHJlZ2FyZHMsDQo+S3J6eXN6dG9mDQoNCkhpIEtyenlzenRvZiwN
CiAgICBUaGUganBlZyBjb2RlYyBlbmdpbmUgYXJlIHNoYXJlZCwgYnV0IHdlIGRvbid0IGNvbmZp
Z3VyZSB0aGUgZW5naW5lIGRpcmVjdGx5Lg0KV2UgY2FuIGZpbGwgc29tZSBkZXNjcmlwdG9ycyB0
byBlbmNvZGUgb3IgZGVjb2RlIG9uZSBqcGVnIGZyYW1lLiBUaGVuIGNvbmZpZ3VyZSB0aGUgZGVz
Y3JpcHRvcnMgdG8gY2VydGFpbiBzbG90IHJlZ2lzdGVyLg0KVGhlIGpwZWcgd3JhcHBlciB3aWxs
IHNjaGVkdWxlIGJldHdlZW4gZGlmZmVyZW50IHNsb3RzLiBXaGVuIHNvbWUgc2xvdCBpcyBmaW5p
c2hlZCwgdGhlIHNsb3QgaW50ZXJydXB0IHdpbGwgYmUgdHJpZ2dlcmVkLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpNSW5nDQo=
