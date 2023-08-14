Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599D777B7C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjHNLqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjHNLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:46:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24539EA;
        Mon, 14 Aug 2023 04:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ysl5QiuhB/RCEVsvBe9aA1BF/uRzZpM09h7Hvoqz7piHcN3NUU2dnb7fLfRHyyt9eg4C3gZYN2fgpYw5pMQ8poX1L0MbxrQaNELm9ylsBrkFrLqwczuuFcEPQ6RjgLBjXfWlmdH9gqN2o2nORM8jv3l2f8BsssfKcF+pv1NC52nmg/n6BVw20+a8/lEtAZPZchlshjlEedSoO6LHdOVzDBMUQRpObqGPWxisZYy6q6W9wY8ZSZ6G4u3A1XKpCoHNBZymd0u8RjfKVXwJroY57I+trv0GX5UQzPtIYgP3Z7Rjmzkgj+OKJvBtABtPKkIbh6LZLT3CUQ0jRlfmOOMbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNKUf9guAtedLxo08HsxIzxNuxU1jXy4r5mjYDMC7pM=;
 b=l2VQKJTLaEmep5cgCUVyyQsJQ/1qIS3Q8XEqW+W2emhnVmiGns+1mvOl0/19glP1Hbocb0jsfGoHPCyBQFOCqnFEkb4B0x/ezUaJK65VBr6ShLV2KW/0R8r607DO8ScSz9lvrpqb00HyaSIZmXqMwezaFX0iWqBO6R9BJgpwzU1aGvkz/z3sffWj7zgwODpWrzlqN/8nTVjEmNp8eocZxe0dARD2fFxA3YlAIIqdE/B7clrXKacMXQfYxYyNxdPj0Z8+bEcquBvuB2bfzP39Cka/zlj+ShSY9tRvSlMLmi0zlyBeooS2tpo7HUs0NQCzubmJltLUBcs0yKRkbjSQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNKUf9guAtedLxo08HsxIzxNuxU1jXy4r5mjYDMC7pM=;
 b=MvK6J8JRXXEbt/ugo70DjgxcFjJ1WkX8cFN2YeuCdivJ8Pm9tPkc4qaJ8vJRVydGEPPdUqOwSxE3qgzOarZAoyw4AoQup1v2jL8cxm+lGqxPl8qRWkYp24F/5MqqUGzSvHFHBNpXCvuRfPgfvrD5rDKFhfptMucAY2U4iKsJ1qQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 11:46:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:46:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH V4 0/8] genpd: imx: relocate scu-pd and misc update
Thread-Topic: [PATCH V4 0/8] genpd: imx: relocate scu-pd and misc update
Thread-Index: AQHZzps748udueOOo0GX07/m7Jetoq/pp3+AgAAEhXA=
Date:   Mon, 14 Aug 2023 11:46:07 +0000
Message-ID: <DU0PR04MB9417C7E1BBD75E90D8755F518817A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230814104127.1929-1-peng.fan@oss.nxp.com>
 <CAPDyKFowxz_Ndy5uFmXaTmQoY1SUNNg7-R04JUUXX0n=5FH_fA@mail.gmail.com>
In-Reply-To: <CAPDyKFowxz_Ndy5uFmXaTmQoY1SUNNg7-R04JUUXX0n=5FH_fA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS5PR04MB10000:EE_
x-ms-office365-filtering-correlation-id: 261a57cc-7d08-4984-b7ec-08db9cbc0c07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aFNkvW/9a68cAywtzP18KvV6Z7nfVkOq8tsw2ZBfaFNwjRa8b2p43Wv4Z9ighLchuRJuZgV38qyecxohwV4gIJGr6V5qXnQbiuU/M9CELUtQZNScyP587kRjUxJ06BKRqCcunUc87Nq/hcWXT6B9ZVGmK0xjGk3ddxO5KqZJwe3kK69c0cWvSZaezP5o75z/0+tLhgVhsmYnuedtbSccjCE7TeYLJzAoIHMKzdVpIW7K7cXzpIh1lyu0P0Lc7qdHxlKBNbyRSd/W2MViSZRUmEusZbHeIvivMtNJdBas2eYPchtl0W/RHsBXHezMEKZRe8VowVKbftOj/99Yl+UXygvMKQtcFFwCzTBN60C4/dU/H2tST7Snxym275yNfVWbWAi2N5Z+HrZzVhHPhC6rdLr8pvTbtxmaJ3vkCPxRWo7bH/Jul0RQQ4aw60TCiBDnrpiwm+if31HSaJB0VRZOEA31x5W3n14yH02ub19xQqQuETPz62Aa3zFuUMTMSY31rfB73pe6yb60NYdcV1pTn2QrkKPpKamY9kRJgt9kESnvGFm3OgltOPcGaoOnangfxFxwm38ZkGo0fGv8xr59hTKKlmgJn/ubLe/KMjsW6+5HVoOWtNOqxoTJahKNGUmr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(186006)(1800799006)(38100700002)(55016003)(110136005)(54906003)(7696005)(71200400001)(478600001)(122000001)(38070700005)(52536014)(5660300002)(2906002)(15650500001)(33656002)(86362001)(44832011)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(8936002)(8676002)(316002)(83380400001)(26005)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2dIV1dyTnRzM0dBcjU1Sjg1dDVEaDFrRHorSXVteHcxMXVSNVE0Ykx6d3gr?=
 =?utf-8?B?QXZnNHFPc2k5NFUvVzlwNGtsUGd2amVQVExsTklOY3JUVzVDRzZFbTZLeUFB?=
 =?utf-8?B?dVozUjYxMElzay9TdUpzMlphKzdxdHpqSGtJQ1dybm93dHhnYkpKNkdSYUlH?=
 =?utf-8?B?V2lDQzlsSUNVYWpwNDgxeWE1T25zMFFDbTVOSEJHT0ZPdDBKY0JMNUlDU0R6?=
 =?utf-8?B?M251eExTcFV3Kys0bFZUcUYrZVJUQlducy9Uem8vcXdpOTNzY2FNV1pOVG84?=
 =?utf-8?B?bDFpdTk5NjdwKzlyZm1sUXVGR1Q1REd5eUxjZ2I1Y3F1TFFHK0wxUStaUHJO?=
 =?utf-8?B?aFNBVndhd0Zod3BCYlNNZzVYWURkdmdCcnlxT0tWY3RVLzZkVHYwdnpvRFRQ?=
 =?utf-8?B?S2xXcDV0bzVselQydXlUbi9TaUZMQVZiMTcrQXQxTGxacjE3TnpDVmFHL0Fq?=
 =?utf-8?B?WHM5c3Q3NHBrK1dGRGIzZlkvanJrN3RDTzFTazRVSDVUdWg0M3ord1NaR1BQ?=
 =?utf-8?B?RFpUQi9ybisvUGpqVnJ4cXQ3QjdaY1E2VXpKcnFlUUZqak14OVNtS3kwN3Ex?=
 =?utf-8?B?TTFZN2lrYlJXR01tZkNiK1k1WlZ2VHZ1Y3RFSU11OTNjUkdTcUdpTUtRWjVy?=
 =?utf-8?B?TnNhb0hKM0tiby9BQW9ObHVLd3hlSjZMZEpoY203Skd5SEVONVoyeWN4SXdu?=
 =?utf-8?B?YlRwdjAwUVZyeWVlWUVwM0tKcnRkdjN0d3llYWNibzFnKzdKUkx6S0J3bkpp?=
 =?utf-8?B?WXN6YzlYN2gwb2FWRlFTcjd4VUR2dHI2VTRyYkMyY3pqWHJTMnFlT2p2V3d3?=
 =?utf-8?B?QWc0UnZYL2lmRUFwOXBFYTJwWWJjLzdKeUdTNjRXM3N3V2lUemhRUFQzaEIw?=
 =?utf-8?B?VTZiZHk4UE9FZjdDUGFkd1FjQzY3NGF4cjRmZ0JnL2t6TWpVSE9JNWFSSlJW?=
 =?utf-8?B?MjRISXJ5WXpvQWdSSmtoRW1SMFdmRmRDaFovekttY2tZbHJnWU10dEdMSlFh?=
 =?utf-8?B?b1dwd3dGSDhPS2J0YU5zdld3TnI2bnYyK1Q3Wm1McVV3N2w5ZHJPUXhFWWdx?=
 =?utf-8?B?d3E4TVVIR05FdnM1cE1TRUtzVFdXRmgrbXVxbWNDRGl5Q0VUbXdGRXpkQTJ5?=
 =?utf-8?B?UWR6T1FLZUNwZ0QyR0tyS0RwWlEvRVZiaWR0MkhUeE03Z0Y4a1IrLzViMjRE?=
 =?utf-8?B?MDl1c1YyOGl1WGJMNEpvc3FFSDFDVXF4NnZGeVBEMXBiMGJGVTd2TkhFam1H?=
 =?utf-8?B?Tk80Um1PN1JxVWpUQSt4dXZTYmJIbU0wWVBCS1I1Y0dhU2xzcFpsbHhXT2hx?=
 =?utf-8?B?S3dVQkIrWFVyNlNhNzVtMGRWMlFWYUQvUUxBMmdlczVmOVpVWkpRdXZWY3NI?=
 =?utf-8?B?aldnTzJIaUoyNVMxbGVUMm5BRDJPRVQvVTBkN3RGSzVhaTNxUC96WW5RNUY5?=
 =?utf-8?B?MzBwYjA2aU1FYkVGTEhQTlRpWDFvOHJVWXQ2dHlGMVNvV1Z5NkJwdm5HVXJM?=
 =?utf-8?B?SytBem84U2ZuTFB6bWhYQ0pkNmpmTXF0RTI5SlZRWmFjdjlad3ZkaE1SWG1v?=
 =?utf-8?B?SmZlZnFrN3R1eGxLbERWZU9WVDIxU0RKOXlkK21HQlJiZU9kM2grOW1NekYx?=
 =?utf-8?B?RFQzdWxFc0VNN0NIaDdZQ2l6czB0c2ZYOVVPaUVLZGZOWUNYdDN2aVdBTFA2?=
 =?utf-8?B?bExXVVJJbmVKd2VmQ1NZS2VvRFRndkJva2lyMXBiakFtWlZDcmk5eVQ2L1V6?=
 =?utf-8?B?NDFiQ2JMMmE5Qmkzd0xmdnlPelVqSzljTW81VWR2Y1BhUnQ2UHc2RHB1VVIz?=
 =?utf-8?B?ckpTYzVZc2JqMTRWaXdOalRuRW96KzVoWDJoUndZT2p6am1meFlaYVdUQTlz?=
 =?utf-8?B?Vnowanh4SmlqOWdaZGhPd0d4OXdhanp0U1JleG9hQ3BDR0hrQmI1MTBOYldB?=
 =?utf-8?B?bVZrQTVnS3Y1K3hkRHdkNlFqYmJ0cTI0UHg3cXFpRHNZbXBwdDA0dUFmZVJP?=
 =?utf-8?B?WktTUWpQU205bzNqSHhqTzk2dFQrKzJEK2k3T2lHRkgzSHg1V3JHSEFxeFdh?=
 =?utf-8?B?SFliKzdVaHpEMkR5Q0ZGUThmbEROMm1pUkt5NWtYOFVGU01lSGtmdWNONnEv?=
 =?utf-8?Q?zXs8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261a57cc-7d08-4984-b7ec-08db9cbc0c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 11:46:07.2227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKGQpoA/mBG1drjScglAt91zXi3xNmSs+ggwVAfkCq6k1u7RdNutJrUTC2y/mlzIjFpN9gVvL+tH4IcNAMNjDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDAvOF0gZ2VucGQ6IGlteDogcmVsb2NhdGUgc2N1LXBk
IGFuZCBtaXNjIHVwZGF0ZQ0KPiANCj4gT24gTW9uLCAxNCBBdWcgMjAyMyBhdCAxMjozNiwgUGVu
ZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEZy
b206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVjQ6DQo+ID4gIFVwZGF0
ZSBjb21taXQgbWVzc2FnZSBpbiBwYXRjaCA0DQo+ID4NCj4gPiBWMzoNCj4gPiAgcmV0dXJuIC1F
QlVTWSBpbnN0ZWFkIG9mIHJldHVybiAwIGluIHBhdGNoIDQNCj4gPg0KPiA+IFYyOg0KPiA+IE1v
dmUgZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMgdG8gZHJpdmVycy9nZW5wZC9pbXgNCj4g
Pg0KPiA+IFRoaXMgcGF0Y2hzZXQgaXMgdG8gdXBzdHJlYW0gTlhQIGRvd25zdHJlYW0gc2N1LXBk
IGRyaXZlciBwYXRjaGVzLg0KPiA+IHBhdGNoIGlzIHRvIHJlbG9jYXRlIHNjdS1wZCB0byBnZW5w
ZA0KPiA+IHBhdGNoIDIsMyBpcyB0byBzdXBwb3J0IG1vcmUgUERzDQo+ID4gcGF0Y2ggNCBpcyB0
byBub3QgcG93ZXIgb2ZmIGNvbnNvbGUgd2hlbiBubyBjb25zb2xlIHN1c3BlbmQgcGF0Y2ggNSBp
cw0KPiA+IHRvIHN1cHByZXNzIGJpbmQgcGF0Y2ggNiBpcyB0byBtYWtlIGdlbnBkIGFsaWduIHdp
dGggSFcgc3RhdGUgcGF0Y2ggNw0KPiA+IGlzIHRvIHN1cHBvcnQgTFAgbW9kZSBpbiBydW50aW1l
IHN1c3BlbmQsIE9GRiBtb2RlIGluIHN5c3RlbSBzdXNwZW5kLg0KPiA+IHBhdGNoIDggaXMgdG8g
Y2hhbmdlIGluaXQgbGV2ZWwgdG8gYXZvaWQgdW5lY2Nlc3NhcnkgZGVmZXIgcHJvYmUNCj4gPg0K
PiA+IFYxOg0KPiA+IFRoaXMgcGF0Y2hzZXQgaXMgdG8gdXBzdHJlYW0gTlhQIGRvd25zdHJlYW0g
c2N1LXBkIGRyaXZlciBwYXRjaGVzLg0KPiA+IHBhdGNoIDEsMiBpcyB0byBzdXBwb3J0IG1vcmUg
UERzDQo+ID4gcGF0Y2ggMyBpcyB0byBub3QgcG93ZXIgb2ZmIGNvbnNvbGUgd2hlbiBubyBjb25z
b2xlIHN1c3BlbmQgcGF0Y2ggNCBpcw0KPiA+IHRvIHN1cHByZXNzIGJpbmQgcGF0Y2ggNSBpcyB0
byBtYWtlIGdlbnBkIGFsaWduIHdpdGggSFcgc3RhdGUgcGF0Y2ggNg0KPiA+IGlzIHRvIHN1cHBv
cnQgTFAgbW9kZSBpbiBydW50aW1lIHN1c3BlbmQsIE9GRiBtb2RlIGluIHN5c3RlbSBzdXNwZW5k
Lg0KPiA+IHBhdGNoIDcgaXMgdG8gY2hhbmdlIGluaXQgbGV2ZWwgdG8gYXZvaWQgdW5lY2Nlc3Nh
cnkgZGVmZXIgcHJvYmUNCj4gPg0KPiA+DQo+ID4gRG9uZyBBaXNoZW5nICgxKToNCj4gPiAgIGdl
bnBkOiBpbXg6IHNjdS1wZDogY2hhbmdlIGluaXQgbGV2ZWwgdG8gc3Vic3lzX2luaXRjYWxsDQo+
ID4NCj4gPiBQZW5nIEZhbiAoNyk6DQo+ID4gICBnZW5wZDogaW14OiByZWxvY2F0ZSBzY3UtcGQg
dW5kZXIgZ2VucGQNCj4gPiAgIGdlbnBkOiBpbXg6IHNjdS1wZDogZW5sYXJnZSBQRCByYW5nZQ0K
PiA+ICAgZ2VucGQ6IGlteDogc2N1LXBkOiBhZGQgbW9yZSBQRHMNCj4gPiAgIGdlbnBkOiBpbXg6
IHNjdS1wZDogZG8gbm90IHBvd2VyIG9mZiBjb25zb2xlIGlmIG5vX2NvbnNvbGVfc3VzcGVuZA0K
PiA+ICAgZ2VucGQ6IGlteDogc2N1LXBkOiBTdXBwcmVzcyBiaW5kIGF0dHJzDQo+ID4gICBnZW5w
ZDogaW14OiBzY3UtcGQ6IGluaXRpYWxpemUgaXNfb2ZmIGFjY29yZGluZyB0byBIVyBzdGF0ZQ0K
PiA+ICAgZ2VucGQ6IGlteDogc2N1LXBkOiBhZGQgbXVsdGkgc3RhdGVzIHN1cHBvcnQNCj4gPg0K
PiA+ICBkcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZSAgICAgICAgICAgIHwgICAxIC0NCj4g
PiAgZHJpdmVycy9nZW5wZC9pbXgvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4g
IGRyaXZlcnMve2Zpcm13YXJlID0+IGdlbnBkfS9pbXgvc2N1LXBkLmMgfCAxOTMNCj4gPiArKysr
KysrKysrKysrKysrKysrKystLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE4MyBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkgIHJlbmFtZQ0KPiA+IGRyaXZlcnMve2Zpcm13YXJlID0+IGdl
bnBkfS9pbXgvc2N1LXBkLmMgKDcwJSkNCj4gPg0KPiANCj4gSSBhbSBmaW5lIHRvIHBpY2sgdXAg
cGF0Y2ggMSAtPiBwYXRjaCA2LCB0byBsZXQgdGhlbSBnbyBpbiBmb3IgdjYuNi4NCj4gU2hvdWxk
IHdlIGRvIHRoYXQgb3IgZGVmZXIgdW50aWwgdGhlIGNvbXBsZXRlIHNlcmllcyBpcyByZWFkeT8N
Cg0KUGxlYXNlIHRha2UgcGF0Y2ggMS02IGZpcnN0LiBJIGNvdWxkIGhhbmRsZSBwYXRjaCA3IGlz
c3VlIGluIGEgc2VwYXJhdGUNCnBhdGNoLCBzaW5jZSBwYXRjaCA3IGlzIG9ydGhvZ29uYWwgdG8g
b3RoZXIgcGF0Y2hlcy4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gS2luZCByZWdhcmRzDQo+
IFVmZmUNCg==
