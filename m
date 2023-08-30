Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3531578D957
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjH3Scy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242231AbjH3Hbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:31:40 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B05CC9;
        Wed, 30 Aug 2023 00:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eot50immZorKqg+7AlXRKdM5q9OswHZdZGrCSq0qHbUiCgTUjUJDpOrU80hKnx7gu6KwLWh3KO6oqijQChBehn+zFCBHkPYGP/FLk5r8eYIc76TzeqAhe8Tmehqs9BSF1vcWQGxiH1ooRGQKMrOsi8XOJXcLCB4b9TXw8lP/hVkGYqY4FkQqULvrAHXMLYg/3oWiSRS1XAOL9T2yvwbr/vitvO6mr7+PMrqzyiCibyaStkh4cmZF7ha7z1aFLPd0OBbQhEaw/nUz5pS2a34Tm+e3/GYqGSXxHI8Te0RKdGOHTdakdy2kgp0QI7XIXa9mURRUOip83Sepoln82VkQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6Nq/B+QVJWjbGFAp43SYifAxqGi0/9Jge8Aw4VjNXw=;
 b=iN8Ah3qZDlWLIOm4VLwTQVxkc+ui0sHqRAX7JQxOt5IMaD+SkAKIl0wjVVe7gtC3wGZJDvpdX4cO+eL4SmKb14rL0sRzZ4ixeaOCPB47A4j59HnFkZPlo670q548Wwr6KidvBFss04u81doqu6EQkecZXhLTSrLchrD6UjUz3fqqQFomLzRO3Sm1WgpCzNBUW85Gz3WE1DCPhgIDqST5Xa7x1gCGfHuLz6Z3ZWUxCKoajrK/AVISS7pLy+uhJmB7G2tEfruQ3MyHUgIo6smlFbO73K+PmXKc3yCkzhAlMAJ7zk1ke6pTml1zQdtL+VJIx7W56pO/ShBDOXq/T8KU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6Nq/B+QVJWjbGFAp43SYifAxqGi0/9Jge8Aw4VjNXw=;
 b=Ees4uZYMHew29p4EF6HMLOfVDpFK1LlfGhfyuwJmvmel8t+t/ltudnbMF2Rk4Ir6+9mr+OOGr8HHfhznWKxT1K7mgdlkFYT4o04UsRKteNHghs3GaP9HGUHtEwH9z9rKfG1j0i0wJpy6ViyFnFBvR0PNcFP2/jOy8B0ti+ejL0Q=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB9086.eurprd04.prod.outlook.com (2603:10a6:150:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 07:31:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::7fc:79ec:6764:1a39]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::7fc:79ec:6764:1a39%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 07:31:33 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 2/3] dt-bindings: phy: phy-imx8-pcie: Add binding for
 different usecases of i.MX8QM PCIe PHYs
Thread-Topic: [PATCH v1 2/3] dt-bindings: phy: phy-imx8-pcie: Add binding for
 different usecases of i.MX8QM PCIe PHYs
Thread-Index: AQHZ2kloJ0XqFPuxo0Wtr3vmR4EpwLAA5iuAgAGCLnA=
Date:   Wed, 30 Aug 2023 07:31:33 +0000
Message-ID: <AS8PR04MB867644E04B2AE4BBA957D6E48CE6A@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1693291534-32092-1-git-send-email-hongxing.zhu@nxp.com>
 <1693291534-32092-3-git-send-email-hongxing.zhu@nxp.com>
 <6d9423d4-0402-bdf5-b8d1-fed5982a6855@linaro.org>
In-Reply-To: <6d9423d4-0402-bdf5-b8d1-fed5982a6855@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GV1PR04MB9086:EE_
x-ms-office365-filtering-correlation-id: 340f6812-9219-4e88-a42f-08dba92b2284
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xwyVWUBsi4PsLdOlll30fyY4Zy+UJOgvp3S+YtPAOeKUhSyvQuJPTX2X82UgVJFvjHnejYsFN7rSPDqSu9I1YNnleHSRtucYmGWUkYIm/B0yNlXryWz0pofxPLaPEA+HN9OL+g4SRxJ9Bo2ptQAJMoAfzcOy5ac9Kyqd32ZGGN9F4xCCmPK+QOa9FqZf2J+n3ULW8SPoZ7xCCzt32Yea1GWUa9dTk6assqa7ox9Q6tAWfZd1Qua9UaJh20My2cNgetvM7I1DnIftIu1KII4Q4Vbus031yVmYu7vUrT2pefp7agdDFS710AoGougPMlZMd7k81F976qTbcceq2anLNwap3wp1M02QchoWQ4dm2JTyfLXdUned74ZiFg6PGw/dIaGx4/B2hyq+V4jN4uKJQd1h1s5yfU1B0diGFCb97nZXtJomDU0iPsRdTfIob5dviRBJF/kM1aa2o4vhm8rTaEg5E9OAIRdl+7tDFzLXBQSgVrRTvUucmzdQsRkuAODCDS3p7BMbaSKlcucznH1z0oJxp3o8QN548mDROk8WEMX06GNFSWwyxGh1LeWiMMPEgHBJ4dN2sjO6neHzm+grKn5zZ28vgTfil0ZPRpaEEg4CzpvHdxH+4G3ByWNvXc2PUzAYRF4A7ruxu5RRDrX7IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(1800799009)(186009)(451199024)(6506007)(71200400001)(9686003)(7696005)(478600001)(83380400001)(26005)(2906002)(7416002)(316002)(64756008)(54906003)(41300700001)(66476007)(66446008)(76116006)(8936002)(66946007)(52536014)(110136005)(44832011)(5660300002)(4326008)(8676002)(33656002)(53546011)(38100700002)(55016003)(38070700005)(86362001)(122000001)(66556008)(921005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym9OSnVESHBvcysrUTloeitJMnBVbXU2OUlsQTRlLzBLcFBoNERWbzJmTkVK?=
 =?utf-8?B?MlV0Vmo3Y3AvYkdoT1l2V3Eza3VadkN0bERZZzc3YVdhYy9jNWRSVVdIU3RP?=
 =?utf-8?B?YXppblZGMHVSMjgzc1psYUJqKzVPUFIvc2x5K01uQ2w5eHE1VXB4RHZlUVNF?=
 =?utf-8?B?cG9sNVdTWU16dnFzMCtYVGhuazVuVE5NTUVJZDQxYnlvZnV5cFdsdCtrWmZN?=
 =?utf-8?B?QndlQlhYKzlmQTJoaExQVUdTbUd0Z1ZzNmE4Um10SWk5WkdHTTByWW1vT0FK?=
 =?utf-8?B?WFpOM2dqOEhMZW92YllIazdxWHIraU1qRjZRWGhqdXZtZ0VGb0JFSEtTR2p1?=
 =?utf-8?B?bS8wdzRiOElqNWhqaUk2aHZlQ0FKck1oNzBBVU4xV3I4Rk81Z1BMbDlUUlVi?=
 =?utf-8?B?UFJ3cWtIeXhKdmdsOStSWWRDN1FMUjNPMXIydzJMTTFhdHRrYUZUL3JQNHVP?=
 =?utf-8?B?SVMrL3ZwTDZROGU5T3FTb2tmYmkwMEl3STFNa2ljb0hZd2RIYkJuOW1QMllS?=
 =?utf-8?B?RW03bWYwZXpKL05lUm0wQmFCY2t0bE5Ebnhqc1o0RGF5cGgrRnpGZFhRVWVG?=
 =?utf-8?B?NTVCQUFGVm9TWGlhQkNSV1JLaUROM0doSEFJV3k0aHdmNnAwUmtFTTAxclJN?=
 =?utf-8?B?NnJCbzR2ZE5oUThTQWdSNUk1aFhobGlaSlRjTk9pa25ReHI2c216a2JuVEdY?=
 =?utf-8?B?cHc0NDh5a2U0eGQyUVNQNHprS0tYMTRpQWE1RmR4bFRqRGdZclE0SWxCMUI2?=
 =?utf-8?B?TmlFTlFrR0tBOXBPTXJPd3gxVnRwdkpjdW1Kb2NKL2N5Vmp0RkZLMFppVUN2?=
 =?utf-8?B?WUZFeWQ3V3UzRTZLbklRUlZzZlN0U3B4TDZDUGdKYm5YUk5wTFlmbUlWZllx?=
 =?utf-8?B?NzJMU0V6Wldic3ZER2FnM01qVjhMMkdLUkNSanZCMS9jVXMzKyt3TTNMelFz?=
 =?utf-8?B?YVpTUzgvbzI1MXJoeUp4eGoxWTAwUytMaDFvWjlBaDQ0Y0hwZVZIeUVsc1hB?=
 =?utf-8?B?SjVZR0gwVk90ODlLNkR5dEd5ek5OY3Y2ck1zUDNCbWZCWjhoRmFyS3BEK0ls?=
 =?utf-8?B?d1duR1M3K2dvdTFYcUdLbnlLeDZEODJZQWlHZ2Y3cktLU3F2OFhyQjR4bndF?=
 =?utf-8?B?cWg0VXZOTERjdjlUREdkUS8zelpMR1JpaUxIcWdkbXNpVC9SaG80aEpmeXlN?=
 =?utf-8?B?a0ZXWlFFOWJSelZEdDVYbUN5ckVEcFlXRlpGd2pqR1ZHOUdMekd0REE3RTlz?=
 =?utf-8?B?aWZZUUREUFpBS0FkQklQYitzL21sWXFWbG1qZUswSWlhcWlscWNqTHVIeFJE?=
 =?utf-8?B?WnhGa0lkVTdDay9jZFdmM1V2clVrRytaYTFjcWl4czJGUGN1TmMvZFhxS3JX?=
 =?utf-8?B?bVRUb2ZZOXhoZDV3bDlBaE45WHUwYnpmYnplYzhmYTA3VHQrYWVwcU5tVGJv?=
 =?utf-8?B?YmJ6bHhNTDU4U01NVUJZaEJ3cytmcFBCVnV5bGFTb2Mra050VG1uK0FRUTg3?=
 =?utf-8?B?UkhWTDZOVFIvdnVmWmI4VDZJanlXNlNlU1BMZFM2SnJ0MnVvTHZldVJGb1FN?=
 =?utf-8?B?M0Fka3hGSjAvUC9iQ2l4dzFOV1YwczhqbFBGbDVwV2xic0w1VzNIRllSNm5p?=
 =?utf-8?B?L0NYSkV5SmhZUjlreFpKRkVZdnVFRWlqVXpuS3FoZFZ6bnNjejZ0SUlzMVRK?=
 =?utf-8?B?U054WFFoMEp4eWoydmNITTduKzdEUGNHNGlCWTNqK0ZGNE1KM2tSdWJNVTZS?=
 =?utf-8?B?MnNOUjNVbklsVzBua054UlgwNExoQzlqaTF5WEhCZnlrek1mZlErQ3YvWVJk?=
 =?utf-8?B?TjRxT2x3bXhzUWQ5eUNvMG9qVHlCQkNQTXJuTWxrdUlwejY4MldGUkxVZzE1?=
 =?utf-8?B?Nk9SZWpRK1FScVJQdWNYWW9sOW0xbzlDaGZIR1M0UzRBQklUd1ZyZytUK2tp?=
 =?utf-8?B?U1ZQVnJNdlNsV09SdzJTdEUrSnFMdU1QK0RzSWtrT1loZk1SckxIZDdMQnY2?=
 =?utf-8?B?aSt2b0JTSkE1N2pFa2lLN0lSWENuR3ZvNXppTnR0dzBwOGpCRlZRcXJMWFRL?=
 =?utf-8?B?M1RxZlpRbW1jTFh4SzlEam56MWNLRzRVL0FoRUpWd0ZvNDIzNkcyR0JOSXBX?=
 =?utf-8?Q?LFZijZixkzM5G/bNXvbGN5Wl8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340f6812-9219-4e88-a42f-08dba92b2284
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 07:31:33.0659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2It6hzsKK9OVKx2cK88KZPtxeQjK9lMt3egjQQFWhYyroYxM77MDIHwapZdgBBJ37R7ZLOe1VtxWs7fqQTWgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjPlubQ45pyIMjnm
l6UgMTU6NTANCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyB2a291
bEBrZXJuZWwub3JnOw0KPiBraXNob25Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFt
QGdtYWlsLmNvbTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYS5mYXRvdW1AcGVuZ3V0cm9uaXgu
ZGU7DQo+IHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZQ0KPiBDYzogbGludXgtcGh5QGxp
c3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAyLzNdIGR0LWJpbmRpbmdzOiBwaHk6IHBo
eS1pbXg4LXBjaWU6IEFkZCBiaW5kaW5nIGZvcg0KPiBkaWZmZXJlbnQgdXNlY2FzZXMgb2YgaS5N
WDhRTSBQQ0llIFBIWXMNCj4gDQo+IE9uIDI5LzA4LzIwMjMgMDg6NDUsIFJpY2hhcmQgWmh1IHdy
b3RlOg0KPiA+IEFkZCBiaW5kaW5nIGZvciBkaWZmZXJlbnQgdXNlY2FzZXMgb2YgaS5NWDhRTSBQ
Q0llIFBIWXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+IA0KPiBUaGlzIHBhdGNoIGRvZXMgbm90IG1ha2Ugc2Vuc2Ugb24gaXRz
IG93bi4gT3RoZXJ3aXNlIHlvdXIgcHJldmlvdXMgcGF0Y2ggaGFzDQo+IGludmFsaWQgcGF0aC4N
Cj4gDQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUu
aCB8IDcgKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9waHkvcGh5LWlteDgtcGNpZS5o
DQo+ID4gYi9pbmNsdWRlL2R0LWJpbmRpbmdzL3BoeS9waHktaW14OC1wY2llLmgNCj4gPiBpbmRl
eCA4YmJlMmQ2NTM4ZDguLmM4NDI1YzE3MjExOCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2R0
LWJpbmRpbmdzL3BoeS9waHktaW14OC1wY2llLmgNCj4gPiArKysgYi9pbmNsdWRlL2R0LWJpbmRp
bmdzL3BoeS9waHktaW14OC1wY2llLmgNCj4gPiBAQCAtMTEsNCArMTEsMTEgQEANCj4gPiAgI2Rl
ZmluZSBJTVg4X1BDSUVfUkVGQ0xLX1BBRF9JTlBVVAkxDQo+ID4gICNkZWZpbmUgSU1YOF9QQ0lF
X1JFRkNMS19QQURfT1VUUFVUCTINCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBEaWZmZXJlbnQgdXNl
Y2FzZXMgb2YgaS5NWDhRTSBIU0lPKEhpZ2ggU3BlZWQgSU8pIG1vZHVsZS4NCj4gPiArICovDQo+
ID4gKyNkZWZpbmUJUENJRUFYMlNBVEEJCTENCj4gPiArI2RlZmluZQlQQ0lFQVgxUENJRUJYMVNB
VEEJMg0KPiA+ICsjZGVmaW5lCVBDSUVBWDJQQ0lFQlgxCQkzDQo+IA0KPiBEcm9wIGluZGVudGF0
aW9uLiBMb29rIGF0IHRoZSBkZWZpbmUgZmV3IGxpbmVzIGFib3ZlIGFuZCBjb21wYXJlLg0KPiAN
Cj4gQW55d2F5LCB0aGlzIGlzIG5laXRoZXIgZXhwbGFpbmVkIG5vciBsb29raW5nIGxpa2UgaGFy
ZHdhcmUgcHJvcGVydHkuDQo+IE5vdGhpbmcgaW4gdGhlIGNvbW1pdCBtc2cgb3IgaW4gZG9jIGhl
cmUganVzdGlmaWVzIHRoZXNlIGNvbnN0YW50cy4gRHJvcCBhbmQgdXNlDQo+IGV4aXN0aW5nIHBy
b3BlcnRpZXMuDQpUaGlzIHByb3BlcnR5IGlzIHVzZWQgdG8gc3BlY2lmeSB0aGUgd29yayBtb2Rl
IG9mIEhTSU8gc3Vic3lzdGVtLg0KVGhlIEhTSU8gYW5kIHRoZSBQSFlzIGNvbnRhaW5lZCBpbiBp
dCB3b3VsZCBiZSBpbml0aWFsaXplZCB0b2dldGhlciByZWZlciB0bw0KIHRoZSBkaWZmZXJlbnQg
d29yayBtb2Rlcy4gU2VlIHRoZSBkZXRhaWxlZCBkaXNjdXNzaW9uIGluICMxIHBhdGNoLg0KDQpC
ZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCg0K
