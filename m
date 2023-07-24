Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A79675F7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGXNBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjGXNAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:00:44 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910E246A2;
        Mon, 24 Jul 2023 05:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Adr9zd+7Y6EwnAy9NtQQQg9ytx6y6ZM8lUV4rLMDTaCgPCbg5jMVQdOKE5d1gknpoPGakpsEpRrgBVqFNBwE7bNRpvJQYP1LkQ/rEWuF/k5wkKSbhjtnj6o56qGcFKjQsLRtqu2sM3RATkEISliYPUmYxn3x8TF19xqWAFhrbkMAHHLbFOSWtog2YBayL6jkib9RaLh5MfvwuSfhsSVLr4IApf1oL9S2+kJ92CjNAmcNlaHCMEm+XOIaBlkuaMS5ogo0BZGtV8k7MxSHkR3kQYF1OgtVZAQgQJfgnbQjWNYeTeYkoQp1pZZYzw3rJ/lDaIHPF1KhBZxADlxofppENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+Bn8zopKi7EG1Ij0StNIAPcLz4l+wMsnr/Ewf84u/8=;
 b=Lm7rs9TTfrtg/6Aw5m/AUvTHFDaQMx3PMRgs8F8XSoG9Q5EnN3p5pi2Au6XhJSrh+PqOBQFLLwKaPuAr80ALd+WMJTpZbPoSvWP1NaDkIazWIGPxTRBCkLWCrrs7lvCPuVbG4xK24td8giS0Kx/iT8vColhZsolZR29ZNH4xYgB7bs1PlmxCsoSJU6NZd7jdjEW0q73B5KqbcAjcqfIam7M8hU4dreJZhnFkI5rDXpchqzTgLncWQDbqA/97DRA6wus02Xcree4NvSxoW0PamUVlUHWkci+62sinwHohKi2AdplYTVk7ru5FYWv7uXh2gNyFIyzZY9dPZ4jqBwInKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+Bn8zopKi7EG1Ij0StNIAPcLz4l+wMsnr/Ewf84u/8=;
 b=r4TSVC5nPIWVqHMONxrwX3ysyZZcXUmGERSaiQxTa35HuSFRghCMCX1NqG/iimS14NFicXpGERjVMMTmzxEQpxBcL6cJDqvkU7YwOvLjfKxQgRWTJBGeoQ2qv+zqrUARnNdp+3PPFkHfbKvPAoGit1I49xqyuNHqslY25dSl3BY=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DU2PR04MB9082.eurprd04.prod.outlook.com (2603:10a6:10:2f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 12:57:46 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 12:57:46 +0000
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
Thread-Index: AQHZtLpCt80XNe94BE2xAgWYFY4Zrq+2fsMAgBJou8A=
Date:   Mon, 24 Jul 2023 12:57:46 +0000
Message-ID: <DU2PR04MB8630E70773BD645687022DEE9502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-5-pankaj.gupta@nxp.com>
 <29cb4426-a15e-7186-1713-427f749bc187@linaro.org>
In-Reply-To: <29cb4426-a15e-7186-1713-427f749bc187@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|DU2PR04MB9082:EE_
x-ms-office365-filtering-correlation-id: a1ad156b-2137-4d44-2c8a-08db8c4593e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6eZ8zhBmXVgT3VoxjrNJ8yu3IEdOF/OKErygIXpwhligkfPMsubY1TljwUNpbUBbi1KzZz0dY6v+SdMMQ+zSi5sxmbefJo+6A2ANEkh2BkKxyvG2bRtWW/f537x5c3Y/tSWYGxrOUAEtAmT9Bhq77lKH4eWj/SRL+hRlChGbkhbhAUa2RDbcMhiU6GEsFkWSKLtxwF7iDskasFGcoG+jpiO/Xg0Co8ZIRQyhj28+BVZSAQ8KX6FmuHexl9+bbYbBOcMNS/xWHnOiO06TyIMJAXc2NutlxST7BXdQEk3GFnKRr+PyTnxpmcx8CMEtpQSzg12HgEz+A0c92pi8mtYNmWi/H019ju5wEyB1V/ijFFGUZF7x6KRwz7XMykpLQj1HscjlwTnbAcsLo4p+Y0QpiTDkz+urpligOfoDie/3aLVzv00OX7LhiRMDYGUHcns45b4gTCBA5gWRQvs/n0NYKXOxEohIFk4IFl9GMOaONN9p5Pxc4MLPYNbr3NY4ZhN7Oc+W/kTW53kU7iTp8s+mu/1rOIlWGxKlCJaqvFN3ca6RyUpnrT15TEVJ+47gSiW2M9lxxKy2nKRXL+h9ZdGjJ2XoGdyreBrAvZVN7g2UYrCUNclKOXrRLXEVQKRfkxgfixISkQCIfYN6mCtLDVXNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(38100700002)(921005)(122000001)(66556008)(55016003)(53546011)(83380400001)(7416002)(8676002)(8936002)(5660300002)(44832011)(52536014)(110136005)(478600001)(66476007)(66446008)(64756008)(6636002)(316002)(66946007)(76116006)(41300700001)(186003)(26005)(6506007)(71200400001)(9686003)(7696005)(2906002)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGhOaXFwRkpQaG9aUEUzSkIxVmJxejdlRU9KMUlWSTNzQXQ5SFp4NzRENW1r?=
 =?utf-8?B?cHZlaHFqZVBIWHNEN0VpWUNkdXVSY2c2S0RhR1F5aW16NENvd2JFSjd4MGFD?=
 =?utf-8?B?L1ZmRGtoYU45Sm9NbG52ZjEyV0IxckRabkw2dGVnbk52NElyeEtHQk5ETW5l?=
 =?utf-8?B?aHVaNUhyeEpjTk9UbGRyaS84c2s1Nlp5R2Jzd1g2Y29lZWxjNjVibFpZK2Q5?=
 =?utf-8?B?MXBJK01aVVB2a094a01scnpNK1U2TUFqbWlPQzlBdkkvZE94NUVOV1hpd09s?=
 =?utf-8?B?YUxNMElnWkJlWlpaeU9SVnJEbktQRmF3ekpwc1A4WS8zNUovR3pWcGkzajhr?=
 =?utf-8?B?MEdaV0xGbDB5VjlGUWM3NHpkZ0hYN1dhcC9ib0Nvc1ZxSUdDZXBXUjdKUXRl?=
 =?utf-8?B?VWRHRjFKWm9udmJ6Q3J4ZjF6UERBTTJBMnRGYklscmk1RlgwRk5vU29ZdnhJ?=
 =?utf-8?B?MzVSa0FwaW92THNjMjB2Tmtvbml2WEpiTjdaaHl4T0MxclBESmZYakhhRnBY?=
 =?utf-8?B?WFJhaWlhUDYremd6MFgrV2JucDhxUzlqU2IyZk9oS3FTZmR0aXhSZDBoeldH?=
 =?utf-8?B?Rm1MRzEvQ056NUVtMnZCdlNmaFFGWE83Y3VYWXhLL04zd2lmeFFLTVBKOW5o?=
 =?utf-8?B?ZXdwbEZxckN2NzBkZ2JtOGFXM3V4NTdmdmdHdEVnYzBIZFpOcTM4T3FzNDlU?=
 =?utf-8?B?L2pNa0FLSmg3bVF6cEJpZDdWRVU0U2x0cjZOQllOUk8vdmxQZGFnYWpkR2dy?=
 =?utf-8?B?UitZT29UZVNmeU52R2ZyREpKWXZ0dFZnWkpyLzRwTUdoWEdzWU1Ha1NJem5R?=
 =?utf-8?B?Y2RMRUJYZzRxcVBuWHFHQytCUXorbUI2VSs3c2hiUHNRWjg3K3ZmbGgwckJ2?=
 =?utf-8?B?UFhhQTdIQ1dkVzMxRlJpVDRoTVR2UXQ3RnE2cUJQQlhCUHdycGF4Y0pEWWZ0?=
 =?utf-8?B?c0E5MEhHSnFMcDFUSTc3NTcxdlRNMzVNUFBwdUo5SjYxVWt6SDRvVytaeXRt?=
 =?utf-8?B?UGhyejVReEFqZ1NjcW9uQTIxQlZEcTBpNytwbU1LM0JnZ1RtNDVSeU03TVZK?=
 =?utf-8?B?Q0VlNGNMTnpsaTdvQzFWVWJZMjB6RnZOdjR5ZG5QV1VZYk4vcEdVSzByMENT?=
 =?utf-8?B?b2djajFZNWJEdkNad0NzalprSHVhZjZ4QVZFVE9LTEMyUDlUdHRHVkplNHMv?=
 =?utf-8?B?WHFMSzJsVVFwVjNWb1JWUHovd204TXduejhJZncva0pYeFZDeExBSHVHckhm?=
 =?utf-8?B?WW1PTGlyNXJFUURjWGhmMW9zZEFBeW5vNmFCSFdxVERmWmoveEZSZTgrdUZ5?=
 =?utf-8?B?YnZxRTA3R1k5bGhsdFJ6R28renNhVGZGQkgzOStlUmJQQ0JxNFpDSnBtdFY3?=
 =?utf-8?B?WTNtcnVjZmhkUHJBb0k0K0VRaDdsVFkzVVlwVkNTZnozNWNjZ2hVYXJNc1Ro?=
 =?utf-8?B?U0VBalZnWG5jOHFobTQ1SjdlZ0JONUoyQXhuRnNrWktJd2YyeWZrNkN4RHNM?=
 =?utf-8?B?cFFPRVZQclUyVTVra0F5c1RxWHlyM29QY3ZBWG1yeEVmNEZpN1NwR21Ya3FB?=
 =?utf-8?B?T0Exa2NaRG0xcHgvT1lxUXJxUFR1aW8veGE0RTZuaFNYdnZIWnNJUzhQTGVI?=
 =?utf-8?B?QkdXcXpubmp3Zy9RdkZoN1p5SGRQYmY3azhIMjBRVkJWL0hITzRQaUNCcU4v?=
 =?utf-8?B?dWxubG9JbDlIaURDVHlIY1k3UXpjU3lxS1dBYm5pTWdzK21VM3Z1WlJ0Mjdh?=
 =?utf-8?B?QVVtcllaWVZUOGhCZXlzSEhNMDc3dU5iWVJtanFlYjg0OGhjNXQwL3Q1Zlg2?=
 =?utf-8?B?a0ZuZzJ1NVBHczNPcWxyUHdxcW1BcUQxZit6QXBsVUg0ZjRlQmlUU1Uxai9N?=
 =?utf-8?B?V2xvRzhVdThlV1U0bHpoaXZmZng2aW9ObXc3dmxRdnNCTHlUbWV5SUJRR3ZK?=
 =?utf-8?B?ek41MmE3RE45WlBsbWx2VC9uYjlPYmI3YTVjL1gxUzZWcmJmQnEzQmRVMThz?=
 =?utf-8?B?QmRsbXpTbm5xY0gvMS9zZVJtc1hEekZ0bjNBU3cxb1RNOWcxYzI0V2czOWx2?=
 =?utf-8?B?cks5TSt4Smt0MjVFSUVlNjkzTy9KQWNXL0hrcm5hSkFBaFh1alRlOGdOandO?=
 =?utf-8?Q?hJnAZHyRuKjolQq5xaTCexUMK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ad156b-2137-4d44-2c8a-08db8c4593e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 12:57:46.4799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8C3Wwz4DgtUkwLyJWml2M28bJWAOZUZwTogyggYeTsAH8mo62d9EMubY4ymt8ajp+sQ/z958AuSoxTETK/BBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
SnVseSAxMywgMjAyMyAxMjozOCBBTQ0KPiBUbzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFA
bnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgY2xpbkBzdXNlLmNvbTsNCj4gY29ub3IrZHRAa2VybmVs
Lm9yZzsgcGllcnJlLmdvbmRvaXNAYXJtLmNvbTsgSmFja3kgQmFpDQo+IDxwaW5nLmJhaUBueHAu
Y29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgV2VpIEZhbmcNCj4gPHdl
aS5mYW5nQG54cC5jb20+OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IEJvdWdoIENoZW4N
Cj4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14
IDxsaW51eC0NCj4gaW14QG54cC5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0OyByb2JoK2R0QGtl
cm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgR2F1cmF2IEphaW4NCj4gPGdhdXJhdi5q
YWluQG54cC5jb20+OyBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOyBTYWhpbCBNYWxo
b3RyYQ0KPiA8c2FoaWwubWFsaG90cmFAbnhwLmNvbT47IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5k
b25nQG54cC5jb20+OyBWYXJ1bg0KPiBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0KPiBTdWJqZWN0
OiBbRVhUXSBSZTogW1BBVENIIHY0IDQvN10gYXJtNjQ6IGR0czogaW14OTMtMTF4MTEtZXZrOiBh
ZGRlZCBueHANCj4gc2VjdXJlIGVuY2xhdmUgZncNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4g
ZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0K
PiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2Ug
dXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMTIv
MDcvMjAyMyAxNDoxMiwgUGFua2FqIEd1cHRhIHdyb3RlOg0KPiA+IEFkZGVkIHN1cHBvcnQgZm9y
IE5YUCBzZWN1cmUgZW5jbGF2ZSBjYWxsZWQgRWRnZUxvY2sgRW5jbGF2ZSBmaXJtd2FyZQ0KPiA+
IChzZS1mdykgZm9yIGlteDkzLTExeDExLWV2ay4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBh
bmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kgfCAxMSArKysrKysrKysrLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kNCj4g
PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kNCj4gPiBpbmRleCA4
NjQzNjEyYWNlOGMuLjJiMGY5MDFkMjcwOSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OTMuZHRzaQ0KPiA+IEBAIC0xLDYgKzEsNiBAQA0KPiA+ICAvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjArIE9SIE1JVCkNCj4gPiAgLyoNCj4gPiAtICog
Q29weXJpZ2h0IDIwMjIgTlhQDQo+ID4gKyAqIENvcHlyaWdodCAyMDIyLTIwMjMgTlhQDQo+ID4g
ICAqLw0KPiA+DQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9pbXg5My1jbG9jay5o
PiBAQCAtODYzLDUgKzg2MywxNCBAQA0KPiA+IGRkci1wbXVANGUzMDBkYzAgew0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MHg0ZTMwMGRjMCAweDIwMD47DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA5MCBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCj4gPiAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgZWxlX2Z3
OiBzZS1mdyB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlt
eDkzLWVsZSI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIG1ib3hlcyA9IDwmczRtdWFwIDAg
MCAmczRtdWFwIDEgMD47DQo+IA0KPiBUaGlzIHNob3VsZCBiZSB0d28gZW50cmllcy4NCj4gDQpb
QWNjZXB0ZWRdIFdpbGwgY29ycmVjdCBpbiB0aGUgVjUuDQoNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgbWJveC1uYW1lcyA9ICJ0eCIsICJyeCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IGZzbCxtdS1kaWQgPSA8Mz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGZzbCxtdS1pZCA9
IDwyPjsNCj4gDQo+IERyb3AgYm90aC4gU2luY2UgeW91IHB1dCBpdCBpbnRvIHRoZSBEVFNJLCBp
dCBtZWFucyBpdCBpcyBjb21wYXRpYmxlIHNwZWNpZmljLg0KPiANCltBY2NlcHRlZF0gV2lsbCBj
b3JyZWN0IGl0IGluIFY1LiBBbHNvIHJlbW92ZSB0aGVzZSBlbnRyaWVzIGZyb20gLnlhbWwgZmls
ZS4NCg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+IA0KPiBE
cm9wLg0KW0FjY2VwdGVkXSB3aWxsIGRyb3AgdGhpcyBpbiBWNS4NCg0KPiANCj4gDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
