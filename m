Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6938B77D79C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbjHPBWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbjHPBVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:21:52 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6701F1FFB;
        Tue, 15 Aug 2023 18:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiJ5ulxTDWqhgdv0veyYQajsTNPZMrETqCZETcZA174fFghdBOBrn4MiOgDLr/e+XN2A43hQt9Kc6f8Xk+1W1u4mMn2Z6NOV0vc+kstjFahv5RA52OU4EXbAmjQtIf0rUWHn7UPdAVSBGtGLl04J7HkfhyutKwtoxitVivk8r45xJHhEElVMaA24FPUZMXhP/MYSWlxhhMFrBn3xxoYrCIi7apOtHDj3RAjWDbZlEyQgUbGU66vlRh0V9IvsuHnpQoi2YxiBQLiHN/1Zy2VS3oXc6v9ngamchZ1ezCqeCA7A7afVhZJozgbl7Snryd7IYa1k9476mNb+C+trWq4Mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWcgkN7sN1Lbe7DPXvvba5m/OE95WpSxLSUBmjLkoos=;
 b=icN52kwI7H9D/GL0ZZXZLTuv6U7VeTB6avGS8sZWBW/QPDefCkNuw0k/CudhBA0AI2oL5Bz7DQRxwTBujOqKzqJe9ef56Kl52izrh9jUvvRFZPZiTIdl18MK6uUmFRWUn0Sjk5VAlbA6jr6w6lAHTBV2/s0+Bvx5EIDEJ7cY22dA7OgefqA+30Afv5YgoBqJjNh95X0WGXIbY3pfJtx5iJi4sQlYc3V9TwZDbyZhFr9LOaLzKNHOXe95w9MwHuDmqAvU38wr8jcJxqpMAWt14O3AkcbByEtSD+x1dPbdcK/oA6mS7f13i3h6CnTv59r+58g9jgOaQDXoAiXYG+1wGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWcgkN7sN1Lbe7DPXvvba5m/OE95WpSxLSUBmjLkoos=;
 b=pB5wvEFVFUm7ZNhCTLyvus05OdsZ5Eu0r4scuAkRqkHa/j+bITHhdhv2+05giYXPntU6mBLp/qMADKUJAznp3dJfJKCaaVsPqYBiSLcb6gkrpXYKbQ5WlUqnInAlTLHPC75Hj4nvUdAvH4fYCpfiCyoZMVRnSALzmwnZOg0s3UM=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 GV1PR04MB9199.eurprd04.prod.outlook.com (2603:10a6:150:2a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Wed, 16 Aug 2023 01:21:45 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 01:21:45 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450
Thread-Index: AQHZzJ2phBTe2S3H506WY/mLMexVyq/rSP8AgADdK4A=
Date:   Wed, 16 Aug 2023 01:21:45 +0000
Message-ID: <DB7PR04MB4010D16CDF2AF90003A8381D9015A@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230811214853.8623-1-giulio.benetti@benettiengineering.com>
 <e921526c-0664-0312-1cdc-e53a27d7d9ce@intel.com>
In-Reply-To: <e921526c-0664-0312-1cdc-e53a27d7d9ce@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|GV1PR04MB9199:EE_
x-ms-office365-filtering-correlation-id: a61b3e1f-45d3-42f5-d694-08db9df727b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fSHJS9r9QCEKNiez32p0/BP3lXMUehHf9IEF4ZQVjQxtDHoQKSP6rqsM/i3l25ekMAWQVycOEfLdLYEUpNm1gvAAwtS/+tyyK3x9/MqymFKAr2kVrHxyxGd6iJJy1MdD07akq9/Pv9DR6TxjlnT4qD4m9bUAV3hgGfsbEnQq69Aqdjubi7faKTqKk1ydj6oLCfxe1WGnmqij4T0MCw8QyeYSIYsK+hvOo2M/OVS5ca3rGbpK81K3nkAPIPU1j002U66EcwcUoPRLD5UjO7DJpxisB6ZrAiFrjQizy7S87AS5+tivMfdhMufVpXmegFBXIjRneqgQCy50FQ3HEWebUHMKilSr8bFRyfxhWIEjv+x4WoEsN8JJCiQQR9wqBtlNHrxlJykOsDCun8YqE4IlfboFWtYs+Jtv0vo0Lx7S0psdJcZ0LuDzCGl/yJfaOJoc/QriWg3QwMAu9j/neGkVP7BmB0nKWrNte6+ZTEUoGRHfvgvs0rQbsQ3d7FOsYFjNQndj7Y/T/G6lfjdpGhw9jwwmUotZmckAkmJ4M78UUoH6Ue7VKTZzwPKvW3AofOxuO/XLLG4LqCRBF20n4b5Qt1V5vIG/SJ29ArFvlrQ2iTwC9k6kDWz4J8wh+GiJNgjQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(26005)(9686003)(122000001)(38070700005)(38100700002)(7696005)(53546011)(66446008)(71200400001)(6506007)(54906003)(55016003)(86362001)(316002)(66946007)(5660300002)(478600001)(33656002)(52536014)(76116006)(8936002)(4326008)(8676002)(83380400001)(7416002)(6636002)(41300700001)(66476007)(64756008)(2906002)(66556008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTZqZ3hCcG95Y3FtQk4wVVVxajVpS25GOXo1RE1OakE0NVFmN0JhVlQ2bmZJ?=
 =?utf-8?B?Um5HNEJselh4SEl6Nms0WVpxUXE5MGU3elRmY1pKK3dtT0ZqOFVnOFBZMUFB?=
 =?utf-8?B?eHByWTJqbzdhZktsZzNYa29XcVY4N3crUnRWQS8rV09aUHY0clpXNnBoU1li?=
 =?utf-8?B?L1RwVlA1cUhxMFhyYzB0TzVDRzVrV0t1bXRaamhjOHREbDg1TXZtZmFnWTVl?=
 =?utf-8?B?NEJiRnFBMnJ2VGpoTEhsVk9RYU1iU2kvblowQno0dVJaRE5TNzArY1Fnb3lR?=
 =?utf-8?B?VEVQRU9PTXVjcXNMek9BbjJrSC9QZFgrbU9xTG56YlBLbC9QRDg2bTgxZjI4?=
 =?utf-8?B?Y3dsUzBkanlVZzFZUmNPanhjVTU1S1RFdlJya25GeEJEOVNTNUdkVjZBQnYz?=
 =?utf-8?B?eUxiRGRLMVZFM28xWWJOdnAwK0s1M3lEM3NwUGoydVhjeUNHOGhxUndIT2Ja?=
 =?utf-8?B?YTY5Qmd6YVlJeXJUZXlJckNzaXlPb3hHZDhIaUJkZ0dEb2FCaDJoS3R6RHBK?=
 =?utf-8?B?ekk0c2tlNlFPQnpob1VNK1JFNWNtdFlGZFBuc0VmNzh0RUFGcHJpNTRpYVF3?=
 =?utf-8?B?ZVRQdWVTZXRSUG1KSDVLWjlzMmpiemRnZGM0dy84RGh5OFFDS3JtMnlsUG01?=
 =?utf-8?B?YjE4L2VDRWRpUDFtMURlbUdHeERsNVVyc2lYR1RFOHdoVkkyL2ViNmQ0dy9O?=
 =?utf-8?B?eVhqQ3RkaFBJUXc2T0dPekNHamcwT25vdUpVcytUbkVXd3d0b2lYa1d1a3lG?=
 =?utf-8?B?QlNRdGFYWkdtckI0Y2hoY3NRTlk2Q3hjb1pXNzZkY05KZUZweGNGZXNLbW94?=
 =?utf-8?B?OGYxc0paTVZVNTU0dHZDZ2ZySGdJWkFzdDBzekFXM3NRMDR3THlHT3VTSGkv?=
 =?utf-8?B?RWRLVU5aUHA0eDNtcDcwVXpCTE9CYk1nRGhhVnNlUUIrNmVTUGlQRVFPOHZw?=
 =?utf-8?B?VTJkL0FGQ2RMczQ3MEJJWm9jUEZPRkRMQ1FSYVFvRjliTTkyRGFYZnVlektX?=
 =?utf-8?B?Q3NoYXp3RUZmUVhrOW1GSGZzb2MwcGNNeEdRWjJsVStTT2doMkV1TFJZajMw?=
 =?utf-8?B?Ky9KTStKSzRobC9QVVhNTW1wV05FN2xLZmlINHlCc0pLclc4WDljdXd4MUhJ?=
 =?utf-8?B?dGFhUXl6cVYzOWRhbzNHTkZsTy84SUZ2cjZOelpvalZEaUNha2NtZUZ2WVVI?=
 =?utf-8?B?Z1hid013S0VOVG5waUQ3RklyREFLZGJlUGlSRWw4WGtFQWx2Nk4zK3lkYVEx?=
 =?utf-8?B?SWZ0RDc1c3BWVExlRlM3VEhiT1E2eEowQmlIa3VUd0tTTmpOdHJWREZwTC92?=
 =?utf-8?B?M255TklGaGRNblNuTFRKeTVUeUJhSFY2OGZvZUpNYlphN1NvK0ltaFQ2akx6?=
 =?utf-8?B?VitOSkJmdTB6ZjNSRC9HejNtcDdBVHVCVUJDSm5kMDg1ejF4djJTblI2US9a?=
 =?utf-8?B?T0x4KzRDaklJUmNxQTZZWUUzRzNob1BieThyVWM0eWhKUjM1VmFqeFN5Rmtm?=
 =?utf-8?B?bFp3OWZuY3dKaW1RZUIya1R3VXpSVlplOE5BQnBIQTgyblZ3ZWZGRFFYSi9n?=
 =?utf-8?B?eDdkckllNjNxbzgrRXNDOEtWRExiYk53dy92Vmtob3FrOFl3emcxdVJmNldJ?=
 =?utf-8?B?L3JNLzcyWndzbzh3YWNiY0JhNGNFK0RnZ2FQQmVvT2Fnd1luSGRyNmI4T216?=
 =?utf-8?B?L3BXd1Fzd2tRZE5iVlAzZzM1R2hId1RiMHEvTVpwZHErbW1nNkd6bGlHdkR3?=
 =?utf-8?B?NzhSM3dYSTN3SXdiWVFZWW0yenQ3K01UUzF4RHpoNG54dGEvTVAvV012eVg1?=
 =?utf-8?B?UGNXa1BiQmdwN0thVE5uTnVXWXRVVmJoZVdvN2YyZXIwdlhMU2VMRmVPRWV0?=
 =?utf-8?B?cktPNU92UGR4WjZ6UHpLVVpXYnFDVlBsNC80SCtPUFRORFBmSGdlRzF0aUNS?=
 =?utf-8?B?dzlmUHArZW11TmVnb2tJMEgyVVFPTm9nWGhoTWNiUCtSaXZzdFZZZ1I3UGdL?=
 =?utf-8?B?SnR3MkhuUnJPYXBsRXpDVUUyYUsvWkxzdGJSOHBpVnorSERUajRBVVlCWEpu?=
 =?utf-8?B?MGNCMkhsMDZHTUNLYUNpZm9kc3RJZ1Z6d0U5WVhJQXdGUGJ4b3p0SHN1cEh3?=
 =?utf-8?Q?TJlI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61b3e1f-45d3-42f5-d694-08db9df727b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 01:21:45.1159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ljtr6ameNItZcDBCZp1nnuIKvyTIYGmBBtb1CVBc1XQcJuTIsMUeRBkYVYz5k/2d7u0p1q/Ckm2/Uo77YxPt3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJp
YW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2VudDogMjAyM+W5tDjmnIgxNeaXpSAyMDowOA0KPiBU
bzogR2l1bGlvIEJlbmV0dGkgPGdpdWxpby5iZW5ldHRpQGJlbmV0dGllbmdpbmVlcmluZy5jb20+
OyBCb3VnaCBDaGVuDQo+IDxoYWliby5jaGVuQG54cC5jb20+OyBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNh
c2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IEZhYmlvDQo+IEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT47IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IENj
OiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gbGlu
dXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKaW0gUmVpbmhhcnQgPGppbXJA
dGVrdm94LmNvbT47IEphbWVzIEF1dHJ5DQo+IDxqYXV0cnlAdGVrdm94LmNvbT47IE1hdHRoZXcg
TWFyb24gPG1hdHRoZXdtQHRla3ZveC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzog
c2RoY2ktZXNkaGMtaW14OiBpbXByb3ZlIEVTREhDX0ZMQUdfRVJSMDEwNDUwDQo+IA0KPiBPbiAx
Mi8wOC8yMyAwMDo0OCwgR2l1bGlvIEJlbmV0dGkgd3JvdGU6DQo+ID4gRXJyYXRhIEVSUjAxMDQ1
MCBvbmx5IHNob3dzIHVwIGlmIHZvbHRhZ2UgaXMgMS44ViwgYnV0IGlmIHRoZSBkZXZpY2UNCj4g
PiBpcyBzdXBwbGllZCBieSAzdjMgdGhlIGVycmF0YSBjYW4gYmUgaWdub3JlZC4gU28gbGV0J3Mg
Y2hlY2sgZm9yIGlmDQo+ID4gcXVpcmsgU0RIQ0lfUVVJUksyX05PXzFfOF9WIGlzIGRlZmluZWQg
b3Igbm90IGJlZm9yZSBsaW1pdGluZyB0aGUNCj4gZnJlcXVlbmN5Lg0KPiA+DQo+ID4gU3BvbnNv
cmVkIGJ5OiBUZWt2b3ggSW5jLg0KPiA+IENjOiBKaW0gUmVpbmhhcnQgPGppbXJAdGVrdm94LmNv
bT4NCj4gPiBDYzogSmFtZXMgQXV0cnkgPGphdXRyeUB0ZWt2b3guY29tPg0KPiA+IENjOiBNYXR0
aGV3IE1hcm9uIDxtYXR0aGV3bUB0ZWt2b3guY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEdpdWxp
byBCZW5ldHRpIDxnaXVsaW8uYmVuZXR0aUBiZW5ldHRpZW5naW5lZXJpbmcuY29tPg0KPiANCj4g
SGFpYm8gQ2hlbiwgY2FuIHdlIGdldCBhbiBBY2tlZC1ieSBmcm9tIHlvdT8NCg0KU29ycnkgZm9y
IHRoZSBkZWxheSwgSSBqdXN0IGZvcmdldCB0aGlzIG1haWwuDQoNCkkganVzdCBkb3VibGUgY2hl
Y2sgdGhlIEVycmF0YSBkb2MsIHllcywgdGhlIGxpbWl0YXRpb24gaXMgb25seSBmb3IgMS44diBJ
L08gdGltaW5nLg0KU28NCkFja2VkLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+
DQoNClRoYW5rcw0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuLg0KPiANCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDcgKysrKy0tLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBiL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBpbmRleCBlZWJmOTQ2MDRhN2YuLmNk
ZGVjYzFlMWFjMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhj
LWlteC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+
IEBAIC0xNzEsOCArMTcxLDggQEANCj4gPiAgI2RlZmluZSBFU0RIQ19GTEFHX0hTNDAwCQlCSVQo
OSkNCj4gPiAgLyoNCj4gPiAgICogVGhlIElQIGhhcyBlcnJhdGEgRVJSMDEwNDUwDQo+ID4gLSAq
IHVTREhDOiBEdWUgdG8gdGhlIEkvTyB0aW1pbmcgbGltaXQsIGZvciBTRFIgbW9kZSwgU0QgY2Fy
ZCBjbG9jaw0KPiA+IGNhbid0DQo+ID4gLSAqIGV4Y2VlZCAxNTBNSHosIGZvciBERFIgbW9kZSwg
U0QgY2FyZCBjbG9jayBjYW4ndCBleGNlZWQgNDVNSHouDQo+ID4gKyAqIHVTREhDOiBBdCAxLjhW
IGR1ZSB0byB0aGUgSS9PIHRpbWluZyBsaW1pdCwgZm9yIFNEUiBtb2RlLCBTRCBjYXJkDQo+ID4g
KyAqIGNsb2NrIGNhbid0IGV4Y2VlZCAxNTBNSHosIGZvciBERFIgbW9kZSwgU0QgY2FyZCBjbG9j
ayBjYW4ndCBleGNlZWQNCj4gNDVNSHouDQo+ID4gICAqLw0KPiA+ICAjZGVmaW5lIEVTREhDX0ZM
QUdfRVJSMDEwNDUwCQlCSVQoMTApDQo+ID4gIC8qIFRoZSBJUCBzdXBwb3J0cyBIUzQwMEVTIG1v
ZGUgKi8NCj4gPiBAQCAtOTYxLDcgKzk2MSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBlc2RoY19w
bHRmbV9zZXRfY2xvY2soc3RydWN0DQo+IHNkaGNpX2hvc3QgKmhvc3QsDQo+ID4gIAkJfCBFU0RI
Q19DTE9DS19NQVNLKTsNCj4gPiAgCXNkaGNpX3dyaXRlbChob3N0LCB0ZW1wLCBFU0RIQ19TWVNU
RU1fQ09OVFJPTCk7DQo+ID4NCj4gPiAtCWlmIChpbXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBF
U0RIQ19GTEFHX0VSUjAxMDQ1MCkgew0KPiA+ICsJaWYgKChpbXhfZGF0YS0+c29jZGF0YS0+Zmxh
Z3MgJiBFU0RIQ19GTEFHX0VSUjAxMDQ1MCkgJiYNCj4gPiArCSAgICAoIShob3N0LT5xdWlya3My
ICYgU0RIQ0lfUVVJUksyX05PXzFfOF9WKSkpIHsNCj4gPiAgCQl1bnNpZ25lZCBpbnQgbWF4X2Ns
b2NrOw0KPiA+DQo+ID4gIAkJbWF4X2Nsb2NrID0gaW14X2RhdGEtPmlzX2RkciA/IDQ1MDAwMDAw
IDogMTUwMDAwMDAwOw0KDQo=
