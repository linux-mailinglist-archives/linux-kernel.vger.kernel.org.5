Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73167788294
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbjHYIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244012AbjHYIof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:44:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C00E2111;
        Fri, 25 Aug 2023 01:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsZbYxHhS8/GDXve8qxn5mdAUI96Zhoo3L3kAUHLcRdgmfx4GGt+ObxivIyiP4+CReqGgg5Se4GtvaQNA1wbAisYOxht9CJb6bLyGYxRPsEGg8Zf8GOkuiLWGUKLzRfO+UJVipP4UvE4LgXazGcOa3V1ZfQUf+hCksy+1wR3LUfoJGY0ZarQfcA3sFk6Micf/a4w0mOThLVZe5SLljYYFWbYhoOJpksj/bUZDY+QWk3FdxJ5GQPNu3yRmUXXPP9OKTQfSrMy5mVVhQGuGb1LCLxZMbqZ8rOe1p/XIzdviRP2YfRHfLjKfNVIZX+T+Ous6g3rwFfH1Q8lCILVDb8duA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mozBB8lV8VjPjnlXJeGvwrGU4ilqT+0WFvm/9HM8ogo=;
 b=aRsfxuwbE9DeP83NeukRim2z/xx5yYKjWStDomRzD0V2mvHMYC1VADpIU1wnXHL7OojiFjoVCX7irMvl480TMIdKqZUvEYxA3X9hQq1LtAExGEP0vVljB1vfc24Ehy0AFJNYioE6tb6H104I+j3l1U4uAldJXw/JUOSM5paYZFjpK5Mxjv3UsKhvT1iIqvic7jTlccKFOxDtcQz6BDBGwMuOA7gnrtL7J4QNmEAVx5r7jpiPl0yvXaBHYFrmAdFLOM4sjvUwdrKuH7siTdAcgbAEtPTKgjQiHu9UDZ2beHZHqvtnV/OiF2C3MQCsuPdnklg7k8/QNHjcGAeztMumbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mozBB8lV8VjPjnlXJeGvwrGU4ilqT+0WFvm/9HM8ogo=;
 b=TmHS/XIA3iKx3zSam2C+lLFAMoUl6Xr6vjVbe73SoY+vixT52TaUASROgYy+8FjBDcMBzvtHucr85tllLPpYzYboNN1kuqYvqyqRMJ1o8w/2CzIAfcJajAKwySiXnzkqI7oQD50F7m+Jyuys9MfTnzX3+c5rJwMTqGQcxrD7Bjc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9580.eurprd04.prod.outlook.com (2603:10a6:10:307::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 08:43:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 08:43:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "oleksii_moisieiev@epam.com" <oleksii_moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [RFC] scmi: pinctrl: support i.MX9
Thread-Topic: [RFC] scmi: pinctrl: support i.MX9
Thread-Index: AQHZ1ljQGymVJC/R70ObhTQ99JrC7K/5IV8AgABBfyCAAUzIgIAAARsg
Date:   Fri, 25 Aug 2023 08:43:38 +0000
Message-ID: <DU0PR04MB94178923DFC8E71287E560E888E3A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230824070611.3335107-1-peng.fan@oss.nxp.com>
 <CACRpkdYU7MRXRV3Uw1w300sdxv=9XT=P1vFFarHfpSM6BT20Hg@mail.gmail.com>
 <DU0PR04MB9417B3CB9638F936DF19C523881DA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CACRpkdZKMsC1Wyi+nOf7idAWMTUe8w2XbtpWnbDKrCLD75ND1g@mail.gmail.com>
In-Reply-To: <CACRpkdZKMsC1Wyi+nOf7idAWMTUe8w2XbtpWnbDKrCLD75ND1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9580:EE_
x-ms-office365-filtering-correlation-id: eb46d737-8c60-487e-6579-08dba54760c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GboWkMZJYfXFO58+7Ui3J9OL9bnSdesUPuLSCwOdgX6tXbm90V4LFqdlHPT6q3SO2Ke5xCNQsvm2vyGJgOpkKaursfiPlpMel6hlQTMTVAIKuiW+8WgU7xasGywLQI3cVAvIpPat1Vu1pjaLzXuth1TionjruH3CWfuB3i6PxAq9BZN/d29x0sDKEJRHdwc4H2Y/ZbzbQNuNmINTiCN+e/TNwz5zDgx/PQV97JNRSXekDGj2SF7r5XSbEz5ln9syePg8A0QWRoxO2cEQU026oToNOaziYmJEIhAPTa4bG6UEYiRzJAjvbbH8g8mh2mxgusCRVGHm242aywg6+xuBKaypc8oOuoWzwaU4nFHfcM1wPsNGFAwyDagOmiyA94rebsJHs+UP2FK1pe6Wg9bbL2/EYLOqvSztA7PTex6uFnNdujpvavGveFNEv090hFCvAzYTcPVYQcZ3AOZepwCEgN62lZun6rAbBmv4lyFHJ/GaXFFFL/xFZmLgn1pIFrLWR4o7ckStn302C2E1XR7LdvdmGCxpV7wIx7a/nncM076jFYKpEGyb4ECFeir4ifuTEhQzhUg5CxVvntz07NFH4Edt7XY9YROeSZv8SRoPJu05M+KQUB5vPghJbOnd7ZPc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(1800799009)(451199024)(186009)(44832011)(7416002)(83380400001)(9686003)(26005)(478600001)(55016003)(5660300002)(52536014)(2906002)(8676002)(8936002)(4326008)(38070700005)(38100700002)(122000001)(66476007)(66556008)(66946007)(76116006)(6916009)(86362001)(71200400001)(41300700001)(64756008)(54906003)(6506007)(53546011)(7696005)(66446008)(33656002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVhRVzBrdmE4eE5pVU03Q1FHelQyNHFzalNUVHVpTVYzd2RBd28xTmdhZmVN?=
 =?utf-8?B?c0xBekZLNC9DMG1Ybi9JNU4yTXVUbURrem52T3JIdEJ2Nk5FVUUzT0dFK2Vh?=
 =?utf-8?B?TERtMGlUZnhGV0dtZkp1SnhOUnovT2puWUNOdXY5ZzBXUllrS1ZLaWxzb3JH?=
 =?utf-8?B?eFVMVjNFaHEweC9jMTJac2I1QlAxUFZ1SFVDTnZ5UzJVcW1yVzd1Z011dklv?=
 =?utf-8?B?QTJXMWFiKzRMQ0hwd0t4ZDU1bEN6T2tVM0FvWlNyYjNWYkJDbXZwL1JVMHdP?=
 =?utf-8?B?TnJZMGo5ZGtIdU16dUhDVkJuZE04SlBuSCtmQm1qZ1F6TUNXd3I5Y2phd2Q5?=
 =?utf-8?B?OGVReDlta2xEQWtra3l3eTN3R3dGeWo2MnlJYmtFbnZabHlBb3FoWnhDcUpQ?=
 =?utf-8?B?N2Y0UkF2b0ttL0ZTTUprYVBGTTR4a05FVGEwd3YwNEErMG41dnlUZ3Q0TGM5?=
 =?utf-8?B?OWZOK0w4U0JMdGUrakRoTzFZcFBPZXB2S3pZMlJkdFZFeThNWkVEaHkrTURl?=
 =?utf-8?B?K0JRdDVUSDAvdWYydVZMTXhqUEFydjhLaFVhbkxHdTZVbDBBL0JjQmVTdk96?=
 =?utf-8?B?dHppYjBCcUh4RStZRVF0N1FncG5WQ3ZrWUgxVnluVDBnUzlDVTNxY1l1U2sv?=
 =?utf-8?B?WXJUMzA4anliZ1VuTGFoa0NNdHQvQVVyWG5iK3Z2K3NselkvVEdYVFpBc2Fz?=
 =?utf-8?B?VzBtajhIczd0d1JEQjFwWDZWZXN2UXBZQ1FQSFFFdUdPVmo0OU5WS2lYOVZ1?=
 =?utf-8?B?eUVoUHg4QzM3bzhSdXkrTVlzNzl3WDNzTWJWU1NBa0hVTk1GcmJNTlN0b3R1?=
 =?utf-8?B?ZFg5b3N5T0Erek1ObElESUN4TUVUNUlpQ3hLd0VaOTNma3lIaHRMbTBHQng5?=
 =?utf-8?B?eU0yY3dWYWJqNVMxVjVLcWs3WXBIY08wMVR2Q3E2T0lEdFBoUDJ4aTNGVHFQ?=
 =?utf-8?B?bjY1UGVJYU5xRExsbUg1Z1Zpb3NFVzRKenBodCtBRm94SmZPM2Jic291Ym0w?=
 =?utf-8?B?NkJSVEZiQ0VEQXV5andaTFh3NGlBTE1zdDZBcnNOMCtjWTZ0UXJnZjRsOU9a?=
 =?utf-8?B?ZE0zeHlHbGZLSUcvb0dxajVoNnpXczFkUVpvc21ya1N2VjFhM3pVL3I4MDJw?=
 =?utf-8?B?ZzE3cW04U1dYaUhNVG5vVVVqM3lrN3d4cmdja0lzZFprdllTOFlSUHNWSmxG?=
 =?utf-8?B?YXdlVmFWbm1mTU9SMlo2TzUxV01UZDNKSVJ2UURBT29zMjdmMkc1Q1ltUmtp?=
 =?utf-8?B?VlQ5VUc2ejZGZXJFVTh2SGpSWVNtZHdxcTJoY09MeUxwVUorZkRQUEpJQjFp?=
 =?utf-8?B?amtlTmJ5b2hGVVRXZFU4NCtGWHY2b2FXd1A0TGMyVit1Mk04OWMyNFloS2l6?=
 =?utf-8?B?YXE0NFpNVHVNMVFOSVNiMFBVc2gzMWtEUmtkbmtSWllNSzZjaklQd2tFZFJX?=
 =?utf-8?B?TStQYmwxUyt6cjdsVlMzVWVwaVYyenlkS2RJanFIWXFXNjFUSWZhYmZ0TlFv?=
 =?utf-8?B?dS9lOHcvL0E3NHA1SUo1bSszMmx3Y05yc1BIR250QWM1VSsrcnZFNDhOU3A2?=
 =?utf-8?B?RmlZOXNMMStMakJyTjFMVzZnSWhKaVl1c0licy9OR0lSVlNoaCt2VkhOOWcx?=
 =?utf-8?B?MTFYUW0zcEV6aDhnRmd5YUluQmVCWWVxSkJMS3BzQ0RkWVlxeE4reWk0dW9r?=
 =?utf-8?B?RmZ5ajNZbXBDeWUzTStsZ3cxb2gzNTNTakVtVFZMMUNzaDJ3cTJ3NmEzS2JN?=
 =?utf-8?B?SE5NSVRVNmNvWHFpQ3FqM1lNUkV4b3JqaUgvYWR0WjlSc0xmQ05nYTVyeDNS?=
 =?utf-8?B?cGdpOCtYOC9SVlJFS2h5ZndGRjRTTUNkSnZsSFlIOHptaDVNVmVSNHpmQkRI?=
 =?utf-8?B?d1JhSTQ0bEdPMi9jMFNWemJvNUNuMkFWclpGOVlaaTR4TlpibC9mRTg2VnJK?=
 =?utf-8?B?cjdYTWJLeGxjYUdZK0RuUXNreS9JZVJkLzZTbWRpY1Zyb2N2R3FmcW5SZTZJ?=
 =?utf-8?B?TzF6cXNwN0JUNDVRb3QrOFpvK3FROXZFb0pwem9nV2hJUmFIZFl4Q3B0LzZi?=
 =?utf-8?B?RVZmZ3RNTEJwYllZR1BIMXJ0ZWlaSGtVeE1HazEyeDhOZ3orQUVweHNNV0l4?=
 =?utf-8?Q?2RZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb46d737-8c60-487e-6579-08dba54760c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 08:43:38.7114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjHaGLBUFIR/EWF7mLr0BjTB41Tpz03Vs/bp1oltGCjuoXSCeGORc61VFz7gtrbOf9bg5iJK1jCW5+TtPX84wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1JGQ10gc2NtaTogcGluY3RybDogc3VwcG9ydCBpLk1YOQ0KPiANCj4g
T24gVGh1LCBBdWcgMjQsIDIwMjMgYXQgMjo0N+KAr1BNIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPiB3cm90ZToNCj4gPiBNZToNCj4gDQo+ID4+IGl0IGlzIG1lcmVseSBtYWtpbmcgdGhpbmdz
IG1vcmUgY29tcGxleCBhbmQgYWxzbyBzbG93ZXINCj4gPiA+IGJ5bWFraW5nIHRoZSByZWdpc3Rl
cnMgb25seSBhY2Nlc3NpYmxlIGZyb20gdGhpcyBTQ01JIGxpbmsuDQo+ID4NCj4gPiBUaGlzIGlz
IGZvciBzYWZldHkgcmVhc29uLCB0aGUgcGluY3RybCBoYXJkd2FyZSBtdXN0IGJlIGhhbmRsZWQg
YnkgYQ0KPiA+IHN5c3RlbSBtYW5hZ2VyIGVudGl0eS4gU28gbW1pbyBkaXJlY3QgYWNjZXNzIG5v
dCBhbGxvd2VkIGZyb20gQ29ydGV4LUENCj4gPiBzaWRlLg0KPiANCj4gWWVhaCBJIHVuZGVyc3Rv
b2QgYXMgbXVjaC4gQnV0IEkgZG9uJ3QgdGhpbmsgdGhhdCB0aGUgZmlybXdhcmUgaXMgcmVhbGx5
DQo+IGZpbHRlcmluZyBhbnkgb2YgdGhlIGFjY2VzcywgaXQgd2lsbCBqdXN0IHBva2UgaW50byBh
bnkgcGluY3RybCByZWdpc3RlciBhcw0KPiBpbnN0cnVjdGVkIGFueXdheSBzbyB3aGF0J3MgdGhl
IHBvaW50LiBKdXN0IGxvb2tzIGxpa2UgYSBsYXllciBvZiBpbmRpcmVjdGlvbi4NCg0KTm8sIHRo
ZSBmaXJtd2FyZSBoYXMgYSBjaGVjayBvbiB3aGV0aGVyIGEgcGluIGlzIGFsbG93ZWQgdG8gYmUg
Y29uZmlndXJlZA0KYnkgdGhlIGFnZW50IHRoYXQgd2FubmEgdG8gY29uZmlndXJlIHRoZSBwaW4u
IA0KDQo+IEJ1dCBJJ20gbm90IHlvdXIgc3lzdGVtIG1hbmFnZXIsIHNvIGl0J3Mgbm90IG15IGRl
Y2lzaW9uLg0KPiANCj4gPiBUaGUgU0NNSSBmaXJtd2FyZSBpcyB2ZXJ5IHN0cmFpZ2h0Zm9yd2Fy
ZCwgdGhlcmUgaXMgbm8gZ3JvdXAgb3INCj4gPiBmdW5jdGlvbi4NCj4gPg0KPiA+IEl0IGp1c3Qg
YWNjZXB0cyB0aGUgZm9ybWF0IGFzIHRoaXM6DQo+ID4gTVVYX1RZUEUsIE1VWCBWQUxVRSwgQ09O
Rl9UWVBFLCBDT05GX1ZBTCwgREFJU1lfVFlQRSwgREFJU1kgSUQsDQo+ID4gREFJU1lfQ0ZHLCBE
QUlTWV9WQUxVRS4NCj4gPg0KPiA+IFNpbWlsYXIgYXMgbGludXggTU1JTyBmb3JtYXQuDQo+ID4N
Cj4gPiBPdXIgaS5NWDk1IHBsYXRmb3JtIHdpbGwgc3VwcG9ydCB0d28gc2V0dGluZ3MsIG9uZSB3
aXRoIFNDTUkgZmlybXdhcmUsDQo+ID4gb25lIHdpdGhvdXQgU0NNSS4gVGhlc2UgdHdvIHNldHRp
bmdzIHdpbGwgc2hhcmUgdGhlIHNhbWUgcGluY3RybA0KPiA+IGhlYWRlciBmaWxlLg0KPiA+DQo+
ID4gQW5kIHRvIHNpbXBsaWZ5IHRoZSBzY21pIGZpcm13YXJlIGRlc2lnbihhbnl3YXkgSSBhbSBu
b3Qgb3duZXIgb2YgdGhlDQo+ID4gZmlybXdhcmUpLCB0byBtYWtlIHBpbmN0cmwgaGVhZGVyIHNo
YXJlZCB3L28gc2NtaSwgd2UgdGFrZSB0aGUgY3VycmVudA0KPiA+IGluLXVwc3RyZWFtIGZyZWVz
Y2FsZSBpbXggYmluZGluZyBmb3JtYXQuDQo+IA0KPiBUaGUgU0NNSSBwZW9wbGUgd2lsbCBoYXZl
IHRvIHN0YXRlIHRoZWlyIHBvc2l0aW9uIG9uIHRoaXMuDQo+IExpa2Ugd2hhdCB0aGV5IGNvbnNp
ZGVyIGNvbmZvcm1hbmNlIGFuZCB3aGF0IGV4dGVuc2lvbnMgYXJlIGFsbG93ZWQuIFRoaXMNCj4g
aXMgbW9yZSBhIHN0YW5kYXJkaXphdGlvbiBxdWVzdGlvbiB0aGFuIGFuIGltcGxlbWVudGF0aW9u
IHF1ZXN0aW9uIHNvIGl0J3MNCj4gbm90IHJlYWxseSBteSB0dXJmLg0KDQpUaGUgaS5NWDk1IFND
TUkgZmlybXdhcmUgdXNlcyBPRU0gZXh0ZW5zaW9uIHR5cGUuIFNvIEkganVzdCBmb2xsb3cNCndo
YXQgdGhlIGZpcm13YXJlIGRpZCBhbmQgc3VwcG9ydCBpdCBpbiBsaW51eC4gQW55d2F5IGxldCdz
DQp3YWl0IFN1ZGVlcCdzIHJlcGx5Lg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBJIHdhcyB1
bmRlciB0aGUgaW1wcmVzc2lvbiB0aGF0IHRoZSBhbWJpdGlvbiB3aXRoIFNDTUkgZmlybXdhcmUg
d2FzIHRvDQo+IGFic3RyYWN0IGF3YXkgYW5kIGhpZGUgYXNwZWN0cyBvZiB0aGUgaGFyZHdhcmUg
YmVoaW5kIGEgY29uc2lzdGVudCBBUEkuDQo+IFRoaXMgYXBwcm9hY2ggZHJpdmVzIGEgdHJ1Y2sg
dGhyb3VnaCB0aGF0IGlkZWEuDQo+IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K
