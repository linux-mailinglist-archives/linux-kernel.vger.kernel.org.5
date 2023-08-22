Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7550783B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjHVIQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjHVIQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:16:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20450CE8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BR39JIKQsVTUmntv0lJaR4gr1w8UiMCm6mXialkK2VLISH4RjyYrXH06MRmFJt2uX6EOVcKfRSt6Gh8biekAvVkWk0HZ9iWJgPQ3tf/dqCTyzDbh/RRrweH9Fi5nJv1a0ThMVeE7Xxb88ZA659DxKi0g5Ko4znN6aEPCGoK/SJHeG89sj5swsOHLI15+YjfL1UhJy8bS/Kw6KpHCJxl53JYNO3wzb62SC6nvzdPnVn4GE1bNMep8SRGb4HBjAnSyf3Fd06Pi+xqiWQcFfpTuIkvIOyCtoH86X+qC32uphVaFYCh9mVF/iLenVVPifzQG8XxJIOjCFbzOSdn8OpxhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Embfb9mi/wtIQmLYCCBKHAYIddSqlubeXtRg4Zgo34=;
 b=YBAXSpOqs7jP2wJSUzLunANcyu2iYCPJhV1d+NbuVtwRtdsltSPbjT4YJc/EuBR4sV+JbTDvBORXipaW0xicy5SA+Iif9egLFEbNjoFV8wxIxeK8W4C3cWKMJGuxgMP2weEjeCSbrm3Wr/WWBX5ZryTYMKKTOKZ83S9CbMzadWeaDSaPD8slbVD/mTW8fOR83y8JlxpK08Th07bXHirkn+lFl9QvH8qCEnEiYZ2zgRtRKgqz5SJqw09fwKEVjgj+kcCrh9+JlSQ1tZEdM/XkOAPoRNa+74XX8BHxAThLhkH8TeQ3xN2/6+zIup3Av2w05DrWO3eufnaFGz/n7cdQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Embfb9mi/wtIQmLYCCBKHAYIddSqlubeXtRg4Zgo34=;
 b=Q7HjJcHu4JUR3NLUi3+1bekXKoOpUnAqd/gjHQuQcvKd/wqnz7kDt5H08K4BEZ0kID8YNOkyKkNZl7qoXfxosIgZ5BzxjuNw4+BsNZm5T/s8guiE7C9ZJc3bDheyg8i82re05+3Bymsu02uN4xGx/SgFC6xZhhAaWZZFQx1I0tQ=
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS1PR04MB9656.eurprd04.prod.outlook.com (2603:10a6:20b:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 08:16:03 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::9018:e395:332c:e24b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::9018:e395:332c:e24b%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 08:16:03 +0000
From:   Ying Liu <victor.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp CSR
 compatible strings
Thread-Topic: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp
 CSR compatible strings
Thread-Index: AQHZMJduwMs7W/1nikKbI/u+8ZEX066u1xEAgAEq4gCAAKT5AIAEau6AgAAruACAAPpWgIFBBoZA
Date:   Tue, 22 Aug 2023 08:16:02 +0000
Message-ID: <AM7PR04MB7046C6055BBA398FF767D58B981FA@AM7PR04MB7046.eurprd04.prod.outlook.com>
References: <20230125083248.1305270-1-victor.liu@nxp.com>
         <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
         <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
         <eea19462-8dfa-8e10-2638-70f6f1ecc193@linaro.org>
         <2d06468ab1274af3c84e61dbca8d172b9d64cd68.camel@nxp.com>
         <f551d663-f7b6-5ae3-89a9-af1ae0d6216e@linaro.org>
 <22399c301156a2a15c53a647ea2ec4c871860080.camel@nxp.com>
In-Reply-To: <22399c301156a2a15c53a647ea2ec4c871860080.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB7046:EE_|AS1PR04MB9656:EE_
x-ms-office365-filtering-correlation-id: ebe07f59-2a01-4c0a-22bc-08dba2e806a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: heGjKRS7fHriswLZ4lTYGSrKxMggaJu2mG4IShsjQ32lvFLGvkbNW5bHqqRXsgvBz+asv3GS4Oa7t3M6ubKemN/7YJcDKN9WRasf1kduD/Xcu/k78Q5tN+UcRRy+d+bBS9iOMZ8V6M/iggMi50NGpEGc5Atag2An+nBr0pWVQqjd0gy4GmADaPrL9dlRavYDQZ/GeMorCUT6fHn+66I0jYmDFhD/kp2/UNjbWwc1biU96OSPdIx9dyFjF5vl8hm3ek3sQDZq+fgBBIzPck9W7GFE/2Jv2PBq/n40QCkXW7KAqWib1oSPwaBgfHqIuCPN6lGVI4+1tnTvNRJE16dOizZa/KWNue0j/1Fm03vpZpVRTXRU3CLAgQo/kQTPH4VScWQDcAnaLoOKaUrTMi7iQDDx1YsBcUBpinhq9sEV/WG7YXprw/FGr2n0i4IdltOjrLRji/lKRQ3kyt3QHv8SqK0XvA+XPrhX92GbjNpmaBBFOREjbobXd5lxI0OZZi/iyVyOxuDCj2ykA+vUNuUzvQpGv5VmIJ75BSi91vIs+xGBSkuVqcCsvJqal91aGzNw2YQo0HqPkuO1YLeftlwh8Wi9Lxn5CMVzqOx4GGbsTCc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(1800799009)(186009)(2906002)(53546011)(38070700005)(38100700002)(45080400002)(6506007)(83380400001)(5660300002)(52536014)(33656002)(26005)(7696005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(64756008)(66446008)(54906003)(76116006)(66556008)(66476007)(110136005)(966005)(478600001)(122000001)(71200400001)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjhUVmxnQ1A5dHd5MktGWEVLdm5qK3ZnRFFYYWpHR1JwTWNXRks4MFlRS0Er?=
 =?utf-8?B?d1VYYi9FK2tuWitQeW50bVBQWW5JZzczQWhmSU8rbTRBMkFjSTBPOEFCOVZE?=
 =?utf-8?B?djVwK3RjcDFqaEZ5SEVaSU5iVFhpVHluSUtVODd0Z0pKRzN1ME9qZGt4NzlV?=
 =?utf-8?B?dWFJZ05FRzhUREE1Rk1mMUhEYi91QmVjaTlYdzRSNGZzY1pPemVYb1Eybldv?=
 =?utf-8?B?bmxtRlFwZG5LS3dVME0vMGg5a3V2UGdIaGxEL1I4Ukp1UDVseDhrb1FVejQx?=
 =?utf-8?B?TlUzVXJ3ZW1tcDZmMDJodWlqNFA1ZVRlRTVaclA2dGlyVHR5Rm4wbEUzeXhB?=
 =?utf-8?B?bmNvSnlqQ2ZIS3A1WUdjaTRIb0o5OHc5Mmt0MzluUFg3ck9Wbk5BVEo0NnJr?=
 =?utf-8?B?TzBRRm9NOHdDWVJrVVVSd0RuT05DTWpBU2o0U0FjMHpTTC8rYTNkTXJoVkJo?=
 =?utf-8?B?bEFBQ2dXbDJwLzA5aVdDUUlHYS9JenkzRnM0UlNQQlVRWkd4WkN5d1FLYXV2?=
 =?utf-8?B?Q1loUDFQK2dNejQ4U2JEQi9NakVuallZaDYzWFVhNHp2WUZJaGdKa3o2OWlw?=
 =?utf-8?B?R2FBRzZYR1JSK2pPQ0VIWFZ1OEhsTWpzV2FsekNaMkNWR0krdkVhZTg3ZG1t?=
 =?utf-8?B?a2l4eGdyckdNcU43V2FBOTFHMStLUk0xZFcxS1Q4OGJSbGRRRkk2QkFweTlu?=
 =?utf-8?B?bDVVSnJ6YVFxTjd1MHpFOFNEeklUM3FyT2R0VU12WlNrZ2Q2Tno0cUJ6S3RO?=
 =?utf-8?B?eGY2TGhsSCt4ZGg0Y2xxZ3R1NjlxdCtVeFdsTVlsTU9nTTRia2ZqQjRhVnFi?=
 =?utf-8?B?RG5HSWQzTXYxeXYzd050b0xnNXlmRktaR09VSDZtYjlTZ01RSVRaeEFEWHdx?=
 =?utf-8?B?SWRMTHhqSlBvQ2NjQ1VWUmlqVSsrWW0rZGhKT08yc2ZZeFdjUTdubW1LRWlt?=
 =?utf-8?B?aURSd0QxS3AwWUh5SEtDYUxYL3BXTE9qbGdSM1cwMDhnVXpKVmh2ak5GQWpl?=
 =?utf-8?B?eWtvOG9JQjhmakF5OGpIdTQxa3R5Z09OM3k4aVNKOGx1OTVUUTdVbmdOcmRM?=
 =?utf-8?B?UUNITkhrRVkrK1Z6T1crRFlnT0x4TWxUaS9WYTl0N2labllLbVY1UDlMQmpB?=
 =?utf-8?B?d3FQK3kwa2ZtdGJDVXVXak5OMkdkTDBWV1lQd0dpd1VQbXo4cEVxRVU0V2FV?=
 =?utf-8?B?TWlTZlJmRjNNemIxdm9DVkhxSDZHeUFmdWhOeElGcWVlZUh1dEx0Vk9QSHRn?=
 =?utf-8?B?alErMEVOZTJvMDdmZUJlOVYvckQzOUVpSWhBRGIzK3JUMHo3ZFVFbVZJWDkx?=
 =?utf-8?B?ZDJ1MjJRYzczYUtWWlcvN1E2M2FUUFB2UVJwRmg4Wmx4ZFUyTnkxcHJ1aG10?=
 =?utf-8?B?M05Odmk0TWRJQjhRZDl3V0NOcW1IbytMSzgrN2VFd2d1TnFmVzVuWklTckox?=
 =?utf-8?B?OW9obHlFWjBBSW5ma1FXbVJlNGpCcFcvN28rWDN6U051cTBNNHY3N1pibjlt?=
 =?utf-8?B?d0FSUmxubjJuUHJjTkxDSHN5NHd0ZnBXempvR2tIZXBVVUtVS0NEaGtESDlR?=
 =?utf-8?B?TklGUENWVTJ1aEtGKzg4QlAwRk9pL0dOYklKWkdRam80bVpNYUNHdGR2YUFQ?=
 =?utf-8?B?V21vQW8wRysrMkwva1ZkMGVRRit3Z2xrUC9FTjZmWEV2TFhESEVKQjE1R2s5?=
 =?utf-8?B?NFhtTTdkMGZIc3lpN1k3NEd5dXhXdU8vREk1MUpvYk9odFFrRjJaMC92V1VH?=
 =?utf-8?B?dzdHaldOTEJKOFplSEJlbmxwQkl5UEdDS3VyY2N1MkdwbjA2WlNFVmhFckVr?=
 =?utf-8?B?ZlF1S1BRZFpDK1ZKaFdxTTljSWJMMEdEeDlvS3VWNlAva296YUdUaDl5SEo0?=
 =?utf-8?B?T096dFZPZS9TRVRRZkk2UEZuUTl1TmdwbFZUT0xyNndHMGp4dXpQNmhCbHRQ?=
 =?utf-8?B?eGYwaDY5dXkvU0hBZW1LUDBvSTF4NU1VZmsyR1VabmM3K0lNc3Q5c3dmaklh?=
 =?utf-8?B?SVZaZFZHNHErN0Y1ZnNMeW9nT0hTbjMrTVZRZ2JRTXd2SWhhbHh6QWJwZHFx?=
 =?utf-8?B?OVorSlBvalVLbFFQVEJRRmxtaUNBMmdXSE94WmJjeERtanlaTmJ5Y2VFRTND?=
 =?utf-8?Q?5eak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe07f59-2a01-4c0a-22bc-08dba2e806a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 08:16:03.0117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNcu3qcFc3FJCbqnxX6FlUP/ezgwEDOYyBU3o+KF/eUXdqsR5RY2yOLs/kXw2suRHMdczJ8w4xjFIn+LKNfzyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9656
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsIEtyeXN6dG9mLCBhbGwsDQoNCk9uIE1vbmRheSwgSmFudWFyeSAzMCwgMjAyMyA5
OjQ2IEFNIFlpbmcgTGl1IHdyb3RlOg0KPiANCj4gT24gU3VuLCAyMDIzLTAxLTI5IGF0IDExOjQ5
ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+IE9uIDI5LzAxLzIwMjMgMDk6
MTMsIExpdSBZaW5nIHdyb3RlOg0KPiA+ID4gT24gVGh1LCAyMDIzLTAxLTI2IGF0IDEzOjQ1ICsw
MTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+ID4gPiBPbiAyNi8wMS8yMDIzIDAz
OjU0LCBMaXUgWWluZyB3cm90ZToNCj4gPiA+ID4gPiBPbiBXZWQsIDIwMjMtMDEtMjUgYXQgMTA6
MDUgKzAxMDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4gPiA+ID4gPiA+IEhpIExpdSwN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IEhpIEdlZXJ0LA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gT24gV2VkLCBKYW4gMjUsIDIwMjMgYXQgOTozMSBBTSBMaXUgWWluZyA8dmlj
dG9yLmxpdUBueHAuY29tPg0KPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEZyZWVz
Y2FsZSBpLk1YOHFtL3F4cCBDU1IgbW9kdWxlIG1hdGNoZXMgd2l0aCB3aGF0IHRoZQ0KPiA+ID4g
PiA+ID4gPiBzaW1wbGUNCj4gPiA+ID4gPiA+ID4gcG93ZXINCj4gPiA+ID4gPiA+ID4gbWFuYWdl
ZCBidXMgZHJpdmVyIGRvZXMsIGNvbnNpZGVyaW5nIGl0IG5lZWRzIGFuIElQRyBjbG9jaw0KPiA+
ID4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+ID4gPiBiZQ0KPiA+ID4gPiA+ID4gPiBlbmFibGVkIGJl
Zm9yZSBhY2Nlc3NpbmcgaXQncyBjaGlsZCBkZXZpY2VzLCB0aGUgY2hpbGQNCj4gPiA+ID4gPiA+
ID4gZGV2aWNlcw0KPiA+ID4gPiA+ID4gPiBuZWVkDQo+ID4gPiA+ID4gPiA+IHRvIGJlIHBvcHVs
YXRlZCBieSB0aGUgQ1NSIG1vZHVsZSBhbmQgdGhlIGNoaWxkIGRldmljZXMnDQo+ID4gPiA+ID4g
PiA+IHBvd2VyDQo+ID4gPiA+ID4gPiA+IG1hbmFnZW1lbnQgb3BlcmF0aW9ucyBuZWVkIHRvIGJl
IHByb3BhZ2F0ZWQgdG8gdGhlaXIgcGFyZW50DQo+ID4gPiA+ID4gPiA+IGRldmljZXMuDQo+ID4g
PiA+ID4gPiA+IEFkZCB0aGUgQ1NSIG1vZHVsZSdzIGNvbXBhdGlibGUgc3RyaW5ncyB0bw0KPiA+
ID4gPiA+ID4gPiBzaW1wbGVfcG1fYnVzX29mX21hdGNoW10NCj4gPiA+ID4gPiA+ID4gdGFibGUg
dG8gc3VwcG9ydCB0aGUgQ1NSIG1vZHVsZS4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
U3VnZ2VzdGVkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+ID4gPiA+ID4g
PiBTdWdnZXN0ZWQtYnk6IExlZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+DQo+ID4gPiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IExpdSBZaW5nIDx2aWN0b3IubGl1QG54cC5jb20+DQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gVGhhbmtzIGZvciB5b3VyIHJldmlldyENCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+IFRoZSBDU1IgbW9kdWxlJ3MgZHQtYmluZGluZyBk
b2N1bWVudGF0aW9uIGNhbiBiZSBmb3VuZCBhdA0KPiA+ID4gPiA+ID4gPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2ZzbCxpbXg4cXhwLWNzci55YW1sLg0KPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiBTdWdnZXN0ZWQgYnkgUm9iIGFuZCBMZWUgaW4gdGhpcyB0aHJl
YWQ6DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4NCj4gPiA+DQo+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRnBhdGNoDQo+IHdvcmsua2VybmVsLm9yZyUyRnByb2plY3QlMkZsaW51eC1hcm0t
DQo+IGtlcm5lbCUyRnBhdGNoJTJGMjAyMjEwMTcwNzU3MDIuNDE4Mjg0Ni0xLQ0KPiB2aWN0b3Iu
bGl1JTQwbnhwLmNvbSUyRiZkYXRhPTA1JTdDMDElN0N2aWN0b3IubGl1JTQwbnhwLmNvbSU3QzU4
YWYNCj4gOGE4NmYwMTM0YjZiZGUzNDA4ZGIwMWU2ODUyMiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJj
ZDk5YzVjMzAxNjM1DQo+ICU3QzAlN0MwJTdDNjM4MTA1ODYxODEzMTQ3MDYzJTdDVW5rbm93biU3
Q1RXRnBiR1pzYjNkOGV5SldJDQo+IGpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzDQo+IDAwMCU3QyU3QyU3QyZzZGF0YT1tSHYl
MkJUQUhNQVI4Y294RG1YdWNvTWJ4diUyQnVNRWRIV0gNCj4gVHlMejE2T1VZNTAlM0QmcmVzZXJ2
ZWQ9MA0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAgZHJpdmVycy9idXMvc2ltcGxlLXBt
LWJ1cy5jIHwgMiArKw0KPiA+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
dXMvc2ltcGxlLXBtLWJ1cy5jDQo+ID4gPiA+ID4gPiA+IGIvZHJpdmVycy9idXMvc2ltcGxlLQ0K
PiA+ID4gPiA+ID4gPiBwbS0NCj4gPiA+ID4gPiA+ID4gYnVzLmMNCj4gPiA+ID4gPiA+ID4gaW5k
ZXggN2FmZTE5NDdlMWMwLi40YTc1NzVhZmU2YzYgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+IC0tLSBh
L2RyaXZlcnMvYnVzL3NpbXBsZS1wbS1idXMuYw0KPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJz
L2J1cy9zaW1wbGUtcG0tYnVzLmMNCj4gPiA+ID4gPiA+ID4gQEAgLTEyMCw2ICsxMjAsOCBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiA+ID4gPiA+ID4gPiBzaW1wbGVfcG1f
YnVzX29mX21hdGNoW10gPSB7DQo+ID4gPiA+ID4gPiA+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9
ICJzaW1wbGUtbWZkIiwgICAuZGF0YSA9IE9OTFlfQlVTIH0sDQo+ID4gPiA+ID4gPiA+ICAgICAg
ICAgeyAuY29tcGF0aWJsZSA9ICJpc2EiLCAgICAgICAgICAuZGF0YSA9IE9OTFlfQlVTIH0sDQo+
ID4gPiA+ID4gPiA+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJhcm0sYW1iYS1idXMiLCAuZGF0
YSA9IE9OTFlfQlVTIH0sDQo+ID4gPiA+ID4gPiA+ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJm
c2wsaW14OHFtLWx2ZHMtY3NyIiwgfSwNCj4gPiA+ID4gPiA+ID4gKyAgICAgICB7IC5jb21wYXRp
YmxlID0gImZzbCxpbXg4cXhwLW1pcGktbHZkcy1jc3IiLCB9LA0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IEkgZGlkIHJlYWQgdGhlIHRocmVhZCBsaW5rZWQgYWJvdmUsIGFuZCBJIHN0aWxsIHRo
aW5rIHlvdQ0KPiA+ID4gPiA+ID4gc2hvdWxkDQo+ID4gPiA+ID4gPiBqdXN0DQo+ID4gPiA+ID4g
PiBhZGQgInNpbXBsZS1wbS1idXMiIHRvIHRoZSBjb21wYXRpYmxlIHZhbHVlIGluIERUUywgc28g
bm8NCj4gPiA+ID4gPiA+IGRyaXZlcg0KPiA+ID4gPiA+ID4gY2hhbmdlDQo+ID4gPiA+ID4gPiBp
cyBuZWVkZWQsIGNmci4NCj4gPiA+ID4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9idXMvcmVuZXNhcyxic2MueWFtbC4NCj4gPiA+ID4NCj4gPiA+ID4gSSBkb24ndCB0aGlu
ayB3ZSB3YW50IHRvIHN0YXJ0IHB1dHRpbmcgc3BlY2lmaWMgY29tcGF0aWJsZXMgaGVyZS4NCj4g
PiA+ID4gV2UNCj4gPiA+ID4gZG9uJ3QgZG8gaXQgZm9yIHNpbXBsZS1tZmQsIHN5c2NvbiBhbmQg
c2ltcGxlLWJ1cywgc28gbmVpdGhlcg0KPiA+ID4gPiBzaG91bGQNCj4gPiA+ID4gd2UNCj4gPiA+
ID4gZG8gaXQgaGVyZS4NCj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoaXMgbWVhbnMg
dGhhdCBpLk1YOHFtL3F4cCBDU1IgbW9kdWxlIGR0LWJpbmRpbmcgZG9jdW1lbnRhdGlvbg0KPiA+
ID4gPiA+IG5lZWRzDQo+ID4gPiA+ID4gdG8gYmUgY2hhbmdlZC4gIEknZCBsaWtlIHRvIGtub3cg
aG93IFJvYiBhbmQgS3J6eXN6dG9mIHRoaW5rDQo+ID4gPiA+ID4gYWJvdXQNCj4gPiA+ID4gPiB0
aGF0Lg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgZnNsLGlteDhxeHAtY3NyLnlhbWwgYmluZGluZ3Mg
YXJlIGJyb2tlbiBhbnl3YXkuLi4gWW91IGhhdmUNCj4gPiA+ID4gZGV2aWNlDQo+ID4gPiA+IHNw
ZWNpZmljIGJpbmRpbmdzIGZvciBub24tc2ltcGxlIGRldmljZSBidXQgdXNlIHNpbXBsZS1tZmQu
IFlvdQ0KPiA+ID4gPiBjYW5ub3QuDQo+ID4gPiA+IHNpbXBsZS1tZmQgbWVhbnMgaXQgaXMgc2lt
cGxlIGFuZCBub25lIG9mIHRoZSByZXNvdXJjZXMgYXJlDQo+ID4gPiA+IG5lZWRlZA0KPiA+ID4g
PiBmb3INCj4gPiA+ID4gY2hpbGRyZW4sIGJ1dCB0aGF0IGJpbmRpbmcgY29udHJhZGljdHMgaXQu
DQo+ID4gPiA+DQo+ID4gPiA+IE5vdyB5b3Uga2luZCBvZiB0cnkgdG8gZXh0ZW5kIGl0IGV2ZW4g
bW9yZSBtYWtlIGl0IG1vcmUgYW5kIG1vcmUNCj4gPiA+ID4gYnJva2VuLg0KPiA+ID4gPg0KPiA+
ID4gPiBSZXdvcmsgdGhlIGJpbmRpbmdzIGtlZXBpbmcgdGhlbSBiYWNrd2FyZHMgY29tcGF0aWJs
ZS4gVGhlDQo+ID4gPiA+IGNvbWJpbmF0aW9uDQo+ID4gPiA+IHdpdGggc2ltcGxlLW1mZCBzaG91
bGQgYmUgZGVwcmVjYXRlZCBhbmQgeW91IGNhbiBhZGQgd2hhdGV2ZXIgaXMNCj4gPiA+ID4gbmVl
ZGVkDQo+ID4gPiA+IGZvciBhIHByb3BlciBzZXR1cC4NCj4gPiA+DQo+ID4gPiBJIGRpZCB0cnkg
dG8gcmV3b3JrIHRoZSBiaW5kaW5ncyBhbmQgbWFrZSB0aGUgY29tYmluYXRpb24gd2l0aA0KPiA+
ID4gc2ltcGxlLQ0KPiA+ID4gbWZkIGRlcHJlY2F0ZWQuIEhvd2V2ZXIsIGl0IHJlbWluZHMgbWUg
dGhlIHByb2JsZW0gdGhhdCAic2ltcGxlLXBtLQ0KPiA+ID4gYnVzIg0KPiA+ID4gYW5kICJzeXNj
b24iIGNhbiBub3QgYmUgaW4gY29tcGF0aWJsZSBzdHJpbmcgYXQgdGhlIHNhbWUgdGltZSwNCj4g
PiA+IG90aGVyd2lzZSwgbm9kZW5hbWUgc2hvdWxkIG1hdGNoICdec3lzY29uQFswLTlhLWZdKyQn
IGFuZCAnXmJ1c0BbMC0NCj4gPiA+IDlhLQ0KPiA+ID4gZl0rJCcgYXQgdGhlIHNhbWUgdGltZS4g
SSBtZW50aW9uZWQgdGhlIHByb2JsZW0gaW4gdGhlIHNhbWUNCj4gPiA+IHRocmVhZFsxXQ0KPiA+
ID4gd2hlcmUgUm9iIGFuZCBMZWUgc3VnZ2VzdCB0byBnbyB3aXRoIHRoaXMgcGF0Y2guICJzeXNj
b24iIGlzIG5lZWRlZA0KPiA+ID4gc2luY2UgaS5NWDhxeHAgTUlQSSBEU0kvTFZEUyBjb21ibyBQ
SFkgbm9kZSByZWZlcmVuY2VzIHRoZSBDU1INCj4gPiA+IG1vZHVsZQ0KPiA+ID4gdGhyb3VnaCBh
IHBoYW5kbGUsIHNvIGRyb3BwaW5nL2RlcHJlY2F0aW5nICJzeXNjb24iIGlzIGEgbm8tZ28uDQo+
ID4gPg0KPiA+ID4gQWxzbywgYXMgUm9iIG1lbnRpb25lZCBpbiBbMV0gImlmIHJlZ2lzdGVyIHNw
YWNlIGlzIGFsbCBtaXhlZA0KPiA+ID4gdG9nZXRoZXIsDQo+ID4gPiB0aGVuIGl0IGlzIHRoZSBm
b3JtZXIgYW5kIGFuIE1GRCIsIEkgdGhpbmsgdGhlIENTUiBtb2R1bGUgc2hvdWxkDQo+ID4gPiBm
YWxsDQo+ID4gPiBpbnRvIHRoZSBzaW1wbGUtbWZkIGNhdGVnb3J5Lg0KPiA+DQo+ID4gWW91IGFy
ZSBub3cgbWl4aW5nIE1GRCB3aXRoIHNpbXBsZS1tZmQuIElmIHlvdSBoYXZlIGNsb2NrcyB0aGVy
ZSBvcg0KPiA+IGFueQ0KPiA+IG90aGVyIHJlc291cmNlcywgaXQncyBub3Qgc2ltcGxlLW1mZCBh
bnltb3JlLg0KPiANCj4gSSBtYXkgdHJ5IHRvIG1ha2UgdGhlIGNvbWJpbmF0aW9uIHdpdGggc2lt
cGxlLW1mZCBkZXByZWNhdGVkIGFuZCBhZGQNCj4gYW5vdGhlciBjb21iaW5hdGlvbiB3aXRoIGku
TVg4cW0vcXhwIENTUiBjb21wYXRpYmxlIHN0cmluZ3MgYW5kIHN5c2Nvbg0KPiBvbmx5LiBUaGVu
LCBpdCB3aWxsIGJlIGEgTUZELCBub3Qgc2ltcGxlLW1mZC4NCj4gDQo+ID4NCj4gPiA+IFRha2Ug
aS5NWDhxeHAgTUlQSSBEU0kvTFZEUyBDU1IgbW9kdWxlIGFzDQo+ID4gPiBhbiBleGFtcGxlLCBj
aGlsZCBkZXZpY2UgcHhsMmRwaSByZWdpc3RlciBvZmZzZXQgaXMgMHg0MCwgd2hpbGUNCj4gPiA+
IGNoaWxkDQo+ID4gPiBkZXZpY2UgbGRiIHJlZ2lzdGVyIG9mZnNldHMgYXJlIDB4MjAgYW5kIDB4
ZTAuDQo+ID4gPg0KPiA+ID4gR2VlcnQsIEtyenlzenRvZiwgY2FuIHlvdSBwbGVhc2UgY29uc2lk
ZXIgdG8ga2VlcCB0aGlzIHBhdGNoIGFzLWlzLA0KPiA+ID4gc2luY2UgaXQgc2VlbXMgdGhhdCB0
aGVyZSBpcyBubyBvdGhlciBvcHRpb24/DQo+ID4NCj4gPiBUaGVyZSBhcmUgb3RoZXIgb3B0aW9u
cywgd2h5IGRvIHlvdSBzYXkgdGhlcmUgaXMgbm8/IE1ha2luZyBpdCBwcm9wZXINCj4gPiBiaW5k
aW5nL2RyaXZlciBmb3IgaXRzIGNoaWxkcmVuIHdpdGhvdXQgYWJ1c2luZyBzaW1wbGUgYmluZGlu
Z3MuDQo+IA0KPiBJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgeW91ciBjb21tZW50IGhlcmUsIHNv
cnJ5LiBIZXJlIGFyZSB0aGUgMw0KPiBvcHRpb25zIEkga25vdzoNCj4gDQo+IDEpIEFkZCBhIG5l
dyBNRkQgZHJpdmVyIGZvciB0aGUgQ1NSIG1vZHVsZQ0KPiBJIHNlbnQgb3V0IGEgTUZEIGRyaXZl
clsxXSBmb3IgdGhlIENTUiBtb2R1bGUgZm9yIHJldmlldywgYnV0IFJvYiBhbmQNCj4gTGVlIHBy
b3ZpZGVkIGNvbW1lbnRzIHRoZXJlIGFuZCBzdWdnZXN0ZWQgdG8gdXNlIHRoaXMgcGF0Y2guDQo+
IA0KPiAyKSBVc2UgInNpbXBsZS1wbS1idXMiIGNvbXBhdGlibGUgc3RyaW5nIGluIHRoZSBDU1Ig
bW9kdWxlJ3MgY29tcGF0YmlsZQ0KPiBwcm9wZXJ0eQ0KPiBBcyBtZW50aW9uZWQgYmVmb3JlLCAi
c2ltcGxlLXBtLWJ1cyIgY29udHJhZGljdHMgd2l0aCAic3lzY29uIi4NCj4gDQo+IDMpIEFkZCB0
aGUgQ1NSIG1vZHVsZSdzIHNwZWNpZmljIGNvbXBhdGlibGUgc3RyaW5ncyBpbg0KPiBzaW1wbGVf
cG1fYnVzX29mX21hdGNoW10NCj4gVGhpcyBpcyB3aGF0IHRoaXMgcGF0Y2ggZG9lcyBhbmQgc3Vn
Z2VzdGVkIGJ5IFJvYiBhbmQgTGVlLg0KPiANCj4gTG9va3MgbGlrZSAzKSBpcyB0aGUgb25seSBm
ZWFzaWJsZSBvcHRpb24uDQo+IA0KPiBHZWVydCwgS3J6eXN6dG9mLCBhbnkgb2JqZWN0aW9ucyB0
byBrZWVwIHRoaXMgcGF0Y2ggYXMtaXM/DQoNClNvcnJ5IGZvciBicmluZyB0aGlzIHVwIGFnYWlu
LCBidXQgb3B0aW9uIDMpIGlzIHN0aWxsIHRoZSBvbmx5IGZlYXNpYmxlDQpvcHRpb24gc3VnZ2Vz
dGVkIGJ5IFJvYiBhbmQgTGVlLCBqdXN0IGFzIHRoaXMgcGF0Y2ggZG9lcy4NCg0KQ2FuIHlvdSBj
b25zaWRlciB0byBoYXZlIGl0IGxhbmRlZD8NCg0KUmVnYXJkcywNCkxpdSBZaW5nDQoNCj4gDQo+
IFsxXQ0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtYXJtLQ0K
PiBrZXJuZWwvcGF0Y2gvMjAyMjEwMTcwNzU3MDIuNDE4Mjg0Ni0xLXZpY3Rvci5saXVAbnhwLmNv
bS8NCj4gDQo+IA0KPiBSZWdhcmRzLA0KPiBMaXUgWWluZw0KPiANCj4gDQo+ID4gU2ltcGxlDQo+
ID4gYmluZGluZ3MgYXJlIGZvciBzaW1wbGUgY2FzZXMgYW5kIHRoaXMgdHVybnMgb3V0IG5vdCB0
aGUgc2ltcGxlIGNhc2UuDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gS3J6eXN6dG9mDQo+
ID4NCg0K
