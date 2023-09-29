Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252B97B2A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjI2CEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 22:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjI2CEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:04:01 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2050.outbound.protection.outlook.com [40.107.14.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD1E199;
        Thu, 28 Sep 2023 19:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ/thELnAhIfgu33xHLdacTLbsG7Qqfw+fOk4K+h3J0d1JyWSZryWYwzlpRr7/3pP++I0PyzwHZMd7QgJK5EbzobH1YQ5erpK7cnbblw+LfAZE1NmuCoozZZNMnfc4to0eTbXEaSVLq82wAS2OHyyxk/LQPVFSMuHSM1+UX6t+GgN4xrSLrFmZFX5EmhKjhswbTigEeCXBglIgt/+TaMOOO0AZqrvUXqfx0SUaCv8+gT/7AxiYhLgGuR0nukl8+jb7A5Y83wiCT/Op2GUTJ5vR42e1lfiqKr6W2UQ+On0aav5rCQ6iPQPEWNUtNz5k+wezlAPDyZsQYLbzCim7vUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/G++jdIrio2VNi/Xv+ZBcw4ND+UEovHevAuX33Qoyg=;
 b=k8CyDzvI36NZaggdYo/PZDJw4nnC98mFGGp0qgICTI7ou/2raMrk+dxTE1wNOAPPyIMbGYU3asx37P5BZrrClEJOItYNz+U0J6+VVe4iTLkYL77/7kO+QgbMDHtRDvvIqbTDTlBT2lpq4U6XS6aSxc1MuQw2L9qb2t/F8pIo001skH98a44vYaDr6gOA7C6hTp6yy/GXmNZ7M6TLWVw+qMDysX5PSPZu6CX+B8w3z+NYJC7xIqSApbMCcBSb9Q0fmNalMABuvl/hYMCawNOg5KWcvd4Lucmuws1hcMR3D4hkD+xh4OuY4vhegHLLS4z9JlBrtXS1jiDXnlhg2W+Wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/G++jdIrio2VNi/Xv+ZBcw4ND+UEovHevAuX33Qoyg=;
 b=Tmva3+baI76CgeXRTfRhH7lacPvsHns0Z4cyb3ANQ7IKTzmHg6A6NSciUNQ8sq3VZzzbdVBHVd3iJyuhjk2Jh/q/SAhn2ZS5U56mW0OThtNfNgtosg/mPfsh9bzUFltAPlzq3qPL24hTtNXPnTdWOBGb+1wAcZbtQ77ymtSVBnU=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7860.eurprd04.prod.outlook.com (2603:10a6:20b:245::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 02:03:55 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 02:03:55 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
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
Thread-Index: AQHZ8GGrmZBLZQgREEat4sCPmu/sQrAuUiWAgAANvVCAAhY/AIAAma8A
Date:   Fri, 29 Sep 2023 02:03:54 +0000
Message-ID: <AM6PR04MB63414900A8E3838DF43A0F60E7C0A@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
 <2c351ca0-cee4-4c1b-956b-6134ad101a9a@linaro.org>
 <AM6PR04MB63415CF2EDCF0AF33F778774E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <20230928164720.GA816352-robh@kernel.org>
In-Reply-To: <20230928164720.GA816352-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AM8PR04MB7860:EE_
x-ms-office365-filtering-correlation-id: 9976839f-c692-4cc6-9abc-08dbc09055d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CF3vmjff+JiU+Zaw9JQtFnTC7If0kMOhAvf1AXNGCbLmoMP+DYiKV0DhnVCaOvy/sWCIsl1xFYK1fOlrskPf12GRmktAv9JY52mT02uATKm9LzitD5O7l1Wg9kzbekADzOSr9G9zEFPoZDbmat6ohbw/PCsx4M+gCY8bK4cGsG7BpyVe8lGEFkIlnL3q6lgI2cZusAB4uwjJazbGAiVE7LVESbHVuQB0ZNY2eOtdhA7HBXOl7PdLUjdYpQN2hqtsZ8PI/a/DqsJxwwih0iRp1S7QB7neC7/veaOygXimGuqHKcVvQb6uDFyBIpiWkcGjUMKqv/cbyEoYeOXKgs03E83SGBBtqjkNxsApxRONutWuyX/jfk8iuPPv/yJspMMEL/VEh48Fkzas/imZjjZ3mUUvCoFWEquFgjY6LOnDNw+k5v9LTXLV4BHRC5rHyxLFMGGqHr5orzM8YxzPt3jysT7hCahY5Q6qtWsWCjmYEgzFFogbFNiAtfLLnaqyhsp/+aI6vuL6jGJIEfmoUVrHvXPHEapfbYcDz96Kze3apmyiypjUP2kqbWffjpQ3biT5m9AScsb8ZgWHyIELRZd/u6D4qWr1d0RGvbtfbiGYl4UbKd3pY9k6JSvgom1coRe4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(71200400001)(9686003)(7696005)(6506007)(26005)(33656002)(66556008)(66946007)(66476007)(66446008)(64756008)(54906003)(76116006)(86362001)(478600001)(38100700002)(38070700005)(122000001)(83380400001)(2906002)(7416002)(55016003)(4326008)(8676002)(8936002)(41300700001)(6916009)(316002)(52536014)(44832011)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q0d4SDdoaHorcjVvb1N4Z2lxOXlDSy9mRlpncENIWGs5MUhsb0QwR2dKTjkr?=
 =?gb2312?B?V29qVGJ0SDkzbzhBVWxxdHdoZDN1KzlRSGxVNHhBQndrWmlKb2tRb0JMcFc4?=
 =?gb2312?B?Y1RzT2lXbXJnQ0U1WlBKT1RaQXFPUktxUzNRUllzcTJNVVF5T2NKYjNUY2E2?=
 =?gb2312?B?ZTJxT1RPRkhOc1liOVRNLzNQSi9tVDFHeG8yKzhrYlBWa254NVhNTGhpTGww?=
 =?gb2312?B?WmFYNFYzVmRXSC9GWWQ2cDdUNG9HQkN1VzdFYmtLZnBId3N1SmNHNkZSV1VJ?=
 =?gb2312?B?Q2U0azEvMzF2bzBTNC9GeHB6a2sxTWRXSC9SRUl2SUdZRUdpalFCMk1EQXZt?=
 =?gb2312?B?YTc4Yy9TOFFWNWU1ZEhGWDBoWm8vQTJsQzBCUGRDN2U5OHM4VlZDMXN3eTE5?=
 =?gb2312?B?MmQ1aEJvZ0cyUlNVZFA3b0Z0MTFvSE10cWtzM0hyaUR1emdCYWRZR3oyNk9M?=
 =?gb2312?B?RDNydFhjQnp1aXY2NGdkcVJLejR0Zm5iaTMzeWNycWk1c3JIVkVYMzQ0MjdX?=
 =?gb2312?B?dnB0Vmo4M2VOSWJoL01WcmJBTWRybTNlOFNkSmJNd3NDblZmMHdiMG5PRzRC?=
 =?gb2312?B?MDhCTVZvQWVHV2RMUHU1dXlQRFNXd3dMU0dmMDQ5SjFPRFB2Wm85TmhUdDRx?=
 =?gb2312?B?YnJJWGJRMFdxaHF1Mk9HenpPN0M5S0F5V3FETmhwd2hFT1VkK3AxRXpsbnZo?=
 =?gb2312?B?YzA3aGV4dDhmU3djYU4va2t4VGoxdHFTb0VRMWpuVXlXVnU4MDBqTVIvdFRJ?=
 =?gb2312?B?K0t0RGJtRml4NzhKbHF5dXByNTArNXl1Q2IzNnNhZWwyL3JGN3RYNkpMOGcy?=
 =?gb2312?B?azA4WlpmZzBId2pSbWw5SDF0aStOM3BKUGdERStoN1BUdkQwdDZobWNoaGtH?=
 =?gb2312?B?SUY1STVpZ3YweHA2eGFzY3dYS0pXTExKMjFOOVh5RTV3TndUSSsrTVRKZlpF?=
 =?gb2312?B?M3RvS0ErWVdLcGEzSHNIWTZtczhURGZRZnV6ZUcwVUR5aVNuMmgyZ2RBQ2pV?=
 =?gb2312?B?OGlBTjJRWEJsL1lNKzhUZGw5Q2p0eWVuRXJMQm13UjEzUWt3azYrUGJzUnVq?=
 =?gb2312?B?cGQ1dkZrek5aZ2tSSWU0VTVyN3poYUJXVjR3bTF5ckxxRkhWWlJaSGNwVjBS?=
 =?gb2312?B?cFNaMkdFMC9OL05HK25BdllUZElyWVFXT3MvbWlCUXE0VjF0YlhRd21QYTg1?=
 =?gb2312?B?djh6TlhqU1lMVWJOR2Q0Y3B2R2hNYi90VVlmQUgveURIRHNLWFRVSXNKdnJW?=
 =?gb2312?B?OWNjZ2dGcW83UGErUkhOK1JxamFiYWpoY3k3WXBJVlVMMkpuK3piZ3FxaGV5?=
 =?gb2312?B?Z3lPQ1FkT2xVQ2hyUWMxOCtrUVRycXdOWFJ0ZlliN2s5a3ZDOC9aN1FGbGp5?=
 =?gb2312?B?N2FLV01BSkNEQkxoWURuZHZHMW9OTWZFTjFUWFViVUFVL1h5dDI3R1Z1RXlC?=
 =?gb2312?B?YTdrcVhpYkROS0NsbEF6enRvYmU3VE1BTExyVWhkQzltUThVZDhzT2ZhRStZ?=
 =?gb2312?B?dlc3Q215MWF5N0RxN3lGRmdXMXpiaXNlZzJySnZiN1hRYlpGQ3RRaUsyMUc5?=
 =?gb2312?B?dE8vdk1DcU5US25rbVI1V3BHZndtb1FWd2VKOUlhODEwSFJ1VDlKQS9wTVg4?=
 =?gb2312?B?eG5zQUtWR0lTeVRFeUs4MVlOblltalhzWTQwL1lxRTEzOTR0a2VWZHAwVnEz?=
 =?gb2312?B?QmpzUFpVSk1XQnQydnlYNU0rMmh2UE02SU5iMktnNTA3bVZhcDkrOUFQN29u?=
 =?gb2312?B?SlowWHY4YW4yUitreHMrZzJXUVo3RHBsd3NwM3d6azM1aG1WM3ZLcnVtWUlj?=
 =?gb2312?B?amdiRWtBT0VzbUNiUnpjOXIrd1Q4c1lxMnZ5TG9BYjNtVm1LYW1zWUpjeWxM?=
 =?gb2312?B?cDNKNENPamx2N0xrdi9qZXZTMW9NbE5xOFZ1SzR3cStsN2hUVXZCbVhrdm9R?=
 =?gb2312?B?OXdMWUdSRXdORUkyemRCNDNTS2REV0pnRVR0Q0h5ZkFvWEtEV1hNNlVDdnFQ?=
 =?gb2312?B?T1hwWHVicC9jaHlNV1ZpVElXekVtQlNrdVpDaHZ4UnlFblBpWW14N2tkRTJn?=
 =?gb2312?B?dml3blZaQ21QOTRzeFA1Ull3YVhrYytsOGcvek85Q2UvNi8yV3ZRZExuVGJW?=
 =?gb2312?Q?bfcg=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9976839f-c692-4cc6-9abc-08dbc09055d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 02:03:55.0491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XrDRujsuv3dCD4VW9qegwPs66t9Ds8sYPUfF6v+fl9HPXctBETb1COUdnUDSXMBrsEpwWzzwmKE8lGoOlOLUKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7860
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+U2VudDogMjAyM8TqOdTCMjnI
1SAwOjQ3DQo+VG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQo+Q2M6IEtyenlzenRv
ZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz47IE1pcmVsYSBSYWJ1
bGVhIChPU1MpDQo+PG1pcmVsYS5yYWJ1bGVhQG9zcy5ueHAuY29tPjsgc2hhd25ndW9Aa2VybmVs
Lm9yZzsNCj5rcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5l
bC5vcmc7DQo+bWNoZWhhYkBrZXJuZWwub3JnOyBodmVya3VpbC1jaXNjb0B4czRhbGwubmw7IHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBn
bWFpbC5jb207IFguSC4gQmFvDQo+PHhpYWhvbmcuYmFvQG54cC5jb20+OyBFYWdsZSBaaG91IDxl
YWdsZS56aG91QG54cC5jb20+OyBUYW8gSmlhbmcNCj48dGFvLmppYW5nXzJAbnhwLmNvbT47IGRs
LWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPmRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6
IFJlOiBbRVhUXSBSZTogW1BBVENIIHY0IDIvMl0gZHQtYmluZGluZ3M6IG1lZGlhOiBpbXgtanBl
ZzogQXNzaWduIHNsb3QNCj5mb3IgaW14IGpwZWcgZW5jb2Rlci9kZWNvZGVyDQo+DQo+Q2F1dGlv
bjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNr
aW5nIGxpbmtzIG9yDQo+b3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0
IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+dGhpcyBlbWFpbCcgYnV0dG9uDQo+DQo+
DQo+T24gV2VkLCBTZXAgMjcsIDIwMjMgYXQgMDk6MTA6NTJBTSArMDAwMCwgTWluZyBRaWFuIHdy
b3RlOg0KPj4gPkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lA
bGluYXJvLm9yZz4NCj4+ID4NCj4+ID5PbiAyNi8wOS8yMDIzIDEyOjEwLCBNaW5nIFFpYW4gd3Jv
dGU6DQo+PiA+PiBUaGVyZSBhcmUgdG90YWwgNCBzbG90cyBhdmFpbGFibGUgaW4gdGhlIElQLCBh
bmQgd2Ugb25seSBuZWVkIHRvDQo+PiA+PiB1c2Ugb25lIHNsb3QgaW4gb25lIG9zLCBhc3NpZ24g
YSBzaW5nbGUgc2xvdCwgY29uZmlndXJlIGludGVycnVwdA0KPj4gPj4gYW5kIHBvd2VyIGRvbWFp
biBvbmx5IGZvciAxIHNsb3QsIG5vdCBmb3IgdGhlIGFsbCA0IHNsb3RzLg0KPj4gPj4NCj4+ID4+
IFNpZ25lZC1vZmYtYnk6IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQo+PiA+PiAtLS0N
Cj4+ID4+IHY0DQo+PiA+PiAtIGltcHJvdmUgY29tbWl0IG1lc3NhZ2UNCj4+ID4+IC0gZG9uJ3Qg
bWFrZSBhbiBBQkkgYnJlYWsNCj4+ID4+IHYzDQo+PiA+PiAtIGFkZCB2ZW5kZXIgcHJlZml4LCBj
aGFuZ2UgcHJvcGVydHkgc2xvdCB0byBueHAsc2xvdA0KPj4gPj4gLSBhZGQgdHlwZSBmb3IgcHJv
cGVydHkgc2xvdA0KPj4gPj4NCj4+ID4+ICAuLi4vYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtanBl
Zy55YW1sICAgICAgICAgfCA0NSArKysrKysrKystLS0tLS0tLS0tDQo+PiA+PiAgMSBmaWxlIGNo
YW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPj4gPj4NCj4+ID4+IGRp
ZmYgLS1naXQNCj4+ID4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlh
L254cCxpbXg4LWpwZWcueWFtbA0KPj4gPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55YW1sDQo+PiA+PiBpbmRleCAzZDlkMWRiMzcwNDAu
LjRiY2ZjODE1Yzg5NCAxMDA2NDQNCj4+ID4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZWRpYS9ueHAsaW14OC1qcGVnLnlhbWwNCj4+ID4+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9ueHAsaW14OC1qcGVnLnlhbWwNCj4+ID4+
IEBAIC0zMiwxOSArMzIsMjYgQEAgcHJvcGVydGllczoNCj4+ID4+ICAgICAgbWF4SXRlbXM6IDEN
Cj4+ID4+DQo+PiA+PiAgICBpbnRlcnJ1cHRzOg0KPj4gPj4gLSAgICBkZXNjcmlwdGlvbjogfA0K
Pj4gPj4gLSAgICAgIFRoZXJlIGFyZSA0IHNsb3RzIGF2YWlsYWJsZSBpbiB0aGUgSVAsIHdoaWNo
IHRoZSBkcml2ZXIgbWF5IHVzZQ0KPj4gPj4gLSAgICAgIElmIGEgY2VydGFpbiBzbG90IGlzIHVz
ZWQsIGl0IHNob3VsZCBoYXZlIGFuIGFzc29jaWF0ZWQgaW50ZXJydXB0DQo+PiA+PiAtICAgICAg
VGhlIGludGVycnVwdCB3aXRoIGluZGV4IGkgaXMgYXNzdW1lZCB0byBiZSBmb3Igc2xvdCBpDQo+
PiA+PiAtICAgIG1pbkl0ZW1zOiAxICAgICAgICAgICAgICAgIyBBdCBsZWFzdCBvbmUgc2xvdCBp
cyBuZWVkZWQgYnkgdGhlIGRyaXZlcg0KPj4gPj4gLSAgICBtYXhJdGVtczogNCAgICAgICAgICAg
ICAgICMgVGhlIElQIGhhcyA0IHNsb3RzIGF2YWlsYWJsZSBmb3IgdXNlDQo+PiA+PiArICAgIGRl
c2NyaXB0aW9uOg0KPj4gPj4gKyAgICAgIEludGVycnVwdCBudW1iZXIgZm9yIHNsb3QNCj4+ID4+
ICsgICAgbWF4SXRlbXM6IDENCj4+ID4+DQo+PiA+PiAgICBwb3dlci1kb21haW5zOg0KPj4gPj4g
ICAgICBkZXNjcmlwdGlvbjoNCj4+ID4+ICAgICAgICBMaXN0IG9mIHBoYW5kbGUgYW5kIFBNIGRv
bWFpbiBzcGVjaWZpZXIgYXMgZG9jdW1lbnRlZCBpbg0KPj4gPj4gICAgICAgIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9wb3dlcl9kb21haW4udHh0DQo+PiA+PiAtICAg
IG1pbkl0ZW1zOiAyICAgICAgICAgICAgICAgIyBXcmFwcGVyIGFuZCAxIHNsb3QNCj4+ID4+IC0g
ICAgbWF4SXRlbXM6IDUgICAgICAgICAgICAgICAjIFdyYXBwZXIgYW5kIDQgc2xvdHMNCj4+ID4+
ICsgICAgbWluSXRlbXM6IDEgICAgICAgICAgICAgICAjIFZQVU1JWA0KPj4gPj4gKyAgICBtYXhJ
dGVtczogMiAgICAgICAgICAgICAgICMgV3JhcHBlciBhbmQgMSBzbG90DQo+PiA+PiArDQo+PiA+
PiArICBueHAsc2xvdDoNCj4+ID4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVm
aW5pdGlvbnMvdWludDMyDQo+PiA+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gPj4gKyAgICAgIElu
dGVnZXIgbnVtYmVyIG9mIHNsb3QgaW5kZXggdXNlZC4gVGhlcmUgYXJlIDQgc2xvdHMgYXZhaWxh
YmxlIGluIHRoZQ0KPklQLA0KPj4gPj4gKyAgICAgIGFuZCBkcml2ZXIgY2FuIHVzZSBhIGNlcnRh
aW4gc2xvdCwgaXQgc2hvdWxkIGhhdmUgYW4gYXNzb2NpYXRlZA0KPmludGVycnVwdA0KPj4gPj4g
KyAgICAgIGFuZCBwb3dlci1kb21haW4uIEluIHRoZW9yeSwgaXQgc3VwcG9ydHMgNCBvcyBvciB2
bS4gSWYgbm90IHNwZWNpZmllZCwNCj4wDQo+PiA+PiArICAgICAgaXMgdXNlZCBieSBkZWZhdWx0
Lg0KPj4gPj4gKyAgICBtaW5pbXVtOiAwDQo+PiA+PiArICAgIG1heGltdW06IDMNCj4+ID4NCj4+
ID5OQUssIHlvdSBzdGlsbCBkaWQgbm90IGFuc3dlciBjb25jZXJucyB3aHkgdGhpcyBpcyBuZWVk
ZWQgYW5kIGp1c3RpZmllZC4NCj4+ID5JIGtlZXAgYXNraW5nIGFuZCB5b3Uga2VlcCBpZ25vcmlu
Zy4uLg0KPj4gPg0KPj4gPkJlc3QgcmVnYXJkcywNCj4+ID5Lcnp5c3p0b2YNCj4+DQo+PiBIaSBL
cnp5c3p0b2YsDQo+Pg0KPj4gPiBOb3RoaW5nIGV4cGxhaW5zIHdoYXQgaXMgYSBzbG90IGFuZCBu
b3RoaW5nIGV4cGxhaW5zIHdoeSBkbyB5b3UgbmVlZCB0aGlzDQo+cHJvcGVydHkuDQo+Pg0KPj4g
SSB0aG91Z2h0IEkgaGFkIGFuc3dlcmVkIHRoYXQgcXVlc3Rpb24sIGJ1dCBzZWVtcyB5b3UgZG9u
J3QgYWdyZWUgd2l0aCB0aGF0DQo+ZXhwbGFuYXRpb24uDQo+PiBXb3VsZCB0aGUgZm9sbG93aW5n
IGRlc2NyaXB0aW9uIGJlIGFueSBiZXR0ZXI/DQo+Pg0KPj4gVGhlIHNsb3QgaXMgdGhlIElQIHVz
ZWQgdG8gc2hhcmUgdGhlIGpwZWcgZW5naW5lIGFjcm9zcyBtdWx0aXBsZSBWTVMNCj4+IGFuZCBv
cywgdGhlcmUgYXJlIDQgc2xvdHMgYXZhaWxhYmxlIGluIHRoZSBJUC4gV2UgY2FuIHVzZSBvbmUg
c2xvdCBpbg0KPj4gbGludXguIFRoZSBzbG90IGluZGV4IGluZGljYXRlcyB3aGljaCBzbG90IHdl
IGNob29zZS4gSWYgbm90DQo+PiBzcGVjaWZpZWQsIDAgaXMgdXNlZCBieSBkZWZhdWx0Lg0KPg0K
DQpIaSBSb2INCg0KPklmIHlvdSBoYXZlIHRvIG1vZGlmeSB0aGUgRFQgdG8gdXBkYXRlICdueHAs
c2xvdCcsIHRoZW4geW91IGNhbiBtb2RpZnkgdGhlIERUDQo+dG8ganVzdCBleHBvc2UgdGhlIHBh
cnRzIG9mIHRoZSBoL3cgZm9yIHRoZSBhc3NpZ25lZCBzbG90LiBGb3IgZXhhbXBsZSwgb25seSBw
dXQNCj5zbG90IDEncyBwb3dlci1kb21haW5zIGVudHJ5IGluIHRoZSBEVCB3aGVuIHNsb3QgMSBp
cyBhc3NpZ25lZC4NCj4NCg0KVGhhdCdzIHdoYXQgdGhpcyBwYXRjaCBpcyB0cnlpbmcgdG8gZG8u
IA0KV2hhdCBzaG91bGQgSSBkbyBuZXh0Pw0KUHJlcGFyZSB0aGUgbmV4dCB2ZXJzaW9uIHBhdGNo
IGFuZCBtb2RpZnkgdGhlIGNvbW1pdCBtZXNzYWdlIGFmdGVyIHJlYWNoaW5nIGFuIGFncmVlbWVu
dD8NCg0KPkFzIGZhciBhcyBmb3JtYXR0aW5nIHlvdXIgZW1haWxzLCB0YWxrIHRvIHlvdXIgTlhQ
IGNvbGxlYWd1ZXMuIFRoZXkndmUgZmlndXJlZCBpdA0KPm91dC4gSWYgeW91J3ZlIGNvbmZpZ3Vy
ZWQgZ2l0LXNlbmQtZW1haWwgc3VjY2Vzc2Z1bGx5LCB0aGVuIHVzaW5nIG11dHQgc2hvdWxkDQo+
YmUgcG9zc2libGUuIFlvdSBjYW4gdXNlICdiNCcgdG8gZ2V0IHRoZSB0aHJlYWQgbWJveCwgYW5k
IHJlYWQgaXQgaW4gbXV0dC4NCj4NCj5Sb2INCg0KSSdsbCB0YWxrIHdpdGggc29tZW9uZSBpbiBu
eHAsIGFuZCBJJ2xsIHRyeSB0byB1c2UgbXV0dC4NClRoYW5rcyBmb3IgeW91ciBhZHZpY2UuDQoN
CkJlc3QgcmVnYXJkcywNCk1pbmcNCg==
