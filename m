Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D20478945A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjHZHgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 03:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjHZHfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 03:35:43 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE80213D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 00:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
        t=1693035339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LSevLjCWcEme6BFPbfhsj0U9XIecserYg/YLG3hwfg=;
        b=N/MORFBrrjUUtoeGtLZfRXKkg6zvjlPA50hurjj62RUN1OHjE+j0Lt2/lbXBRVK2ZHF301
        6DDKQL9Jfx4dLxTRw0i38TjzBYkU4+SlF2xXpYDLTFAiluN62e+J+P0MTqgNoBJ/6OIu/+
        jXRPBrzManf7zpArMGyNy4boP0ZecTc=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-iSFv7X4nNMO0_4YiKcHrLg-1; Sat, 26 Aug 2023 09:34:31 +0200
X-MC-Unique: iSFv7X4nNMO0_4YiKcHrLg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB1093.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Sat, 26 Aug 2023 07:34:29 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984%6]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 07:34:29 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "xiaoning.wang@nxp.com" <xiaoning.wang@nxp.com>,
        "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v1] firmware: imx: scu-pd: Add missed PCIEA SATA0 and
 SERDES0 power domains
Thread-Topic: [PATCH v1] firmware: imx: scu-pd: Add missed PCIEA SATA0 and
 SERDES0 power domains
Thread-Index: AQHZ1y62aNb4OGMwx02sMGZSE2GSxa/8MR6A
Date:   Sat, 26 Aug 2023 07:34:28 +0000
Message-ID: <eda5944e3d36d1daf25e5b8613f6f781d5fafc18.camel@toradex.com>
References: <1692949635-27223-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1692949635-27223-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB1093:EE_
x-ms-office365-filtering-correlation-id: f42bfa75-3fe3-47b0-36c4-08dba606e1bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Vcv52ryAows2qN0dYzOfMfIIUQQsON5FlD//KvOj74oQ79XJhb8slCIhMqrI/WnB3SJ6E/cqC5bq11XyWSiJmn7yIgbx22BnjN27xBZVlYGquM8/sA3SvVzYsg6g5pb5EXpaaouAngQadOiAs3rvGJ0xzy1DgTqIH40b8hibg4NGbb3JP1WaFBiX0bYTPQiq8eHqm72/zBs4fuyE0YXCPUTV+dJLwrgMP3Q9horZxcV4tvYNJ8fheMSL553PhDbNs1sZSjBnYhgj3zMst65nimPtPmWDJPKDlQT2Q6tCDt6obpQR4bMwfuiX8Ul/RbL0/DKwqQyoynBCqejLMfNYg3SUegibfIb5xaf023bQ3tDsGe9aUcl4OtVPUjh5ZUuClSYFGNzrk9soNxuXq3QP9ts4ea79CYKIUMOD0cFTH/gkTSZOyfWUC2g0H7LyBipPngQjG/Lmen4OSXrP9+Q0t1kmVijIOqUa3VBdgc5y1GAJ69d9xgqf5HdEsXi0EQAmBJKmSlxJwN6u0URQ1v587zFskemAmkK71fng8i1tyxn74lhquFGn2Ey6eEH4iX+Kfh4d3Mm578kvU6yV7oB/dMCv7V4TWieJ/tbNT6/XEHUoODrUQEQ8Scz42iACW4IU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39840400004)(366004)(396003)(1800799009)(451199024)(186009)(8676002)(4326008)(64756008)(66446008)(91956017)(66556008)(26005)(6506007)(66946007)(76116006)(66476007)(71200400001)(122000001)(41300700001)(6512007)(316002)(5660300002)(8936002)(478600001)(7416002)(44832011)(6486002)(54906003)(110136005)(2616005)(2906002)(4744005)(86362001)(38070700005)(36756003)(38100700002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnQ2QkEwRjJpbmgyY0NOR3dNeU9kSkhZVE5HQkY5aEUrc0RNS3YvRENEVElQ?=
 =?utf-8?B?VkVxTkNiTlhMQ2RGNGl6a1Iyc3dCRWpDeE1sSy9jR0UzdU5xQ3VXTGgybVZX?=
 =?utf-8?B?Zk5BNlZUcFhPc01STVozOXZtWENURlV2N05LczVGejhwT0RyMXNxSGowUTJi?=
 =?utf-8?B?TldiMDNncGRyLy9TRE5hcnVqSzh1d200Y0hoMEdsVkZBVGZpekFVbVZzU0pm?=
 =?utf-8?B?N0hoZ0FVenE3NjRxcWdDejhMbWVDUVZwL21Ka2RRNUxpSzRqU1A1TXIwVllC?=
 =?utf-8?B?Zk9BNWpXa2xaeUl2aC9DbFdvcmNKMTF4UHZIMnp0Vy9obkt0VzRaTzg4ZDVn?=
 =?utf-8?B?TGUzeXo5T3ZGUGo4S0U5Vk1RRjJJMWlRR2J4cDJ0ampMaVhORm1Fak1zYVFw?=
 =?utf-8?B?S3g3YWFMZTNKOVRCSnN4NEJ3bVlCUlQvZTlKcUlTcjNvaldPRmZ5WTFyUi9I?=
 =?utf-8?B?QzhTWHhZNzROM3orajV5c3d3Ukhpa1ZrM2ZXQncxWk01QXlMSnRzbWFlTVVn?=
 =?utf-8?B?U3RybDRmT2ppWWx2TzdWN2R3NHczTDIwZjRoMEx4ZWxZS1paaEpla3I0Z043?=
 =?utf-8?B?eUF5VE92dGt4aEx0bFZKWHl2am5KMFNNNzcvMWtQOTNCWnh4Qk9vWnBSZ1E3?=
 =?utf-8?B?YTlBQldJUG9BQUVIcVVvQm1meHFaeVYxZEtZSHRjVmhLRER2aDIzcEVudlE4?=
 =?utf-8?B?R3YvZUVFSTYvd0tQVzdCbWpvNHc3STNhWHFaOTZZQ2dEdmJnYzBCRXdMRDdO?=
 =?utf-8?B?WnJxT3ROSnBWUkh1cUFJQzhsMnRyMDJWZW9EQnFmSTJDajRSZ0lmZXRGOS9y?=
 =?utf-8?B?ZWF6MDU0TXFMU3U3WmlJV0x2dEc0S1VPV0E0cEs0Um9OTXhkSnpoQTRab2Ix?=
 =?utf-8?B?enVwWDYybVAwbHJ5R0RtK3oxNXk4TWExTm5LdjV4UTlvYXhmaHpxYnBtSHE5?=
 =?utf-8?B?SVNSQzhtTHJhNXV5bXArSDdjeG1hc3U3SXEyTFA0TEJkUU9zQkY5WkluRnRs?=
 =?utf-8?B?SXI1TFRueFBvSWc1ZVIyWGh6SnRjYmxNWWVyZnR2L21zbnV0dzV0clpEQUgv?=
 =?utf-8?B?bWJjVDF0cVp1VzArdTVzYXROczh6UEpDVHBNdjNuRDBxaDV5UEl3ZndJbkhZ?=
 =?utf-8?B?SXZHQXlNVzE0aDgzVnB6SEdNRkw3STB0Y1ZsNWNHOW40K29Mdmh6SHh5RGtl?=
 =?utf-8?B?SjlyK1VKVE1aeVlSUGZyTUthQzFYaHQyV0wwWnJZNHJrTEU0dXBrREhrWEc5?=
 =?utf-8?B?Rnh3TDhKVFlFNHFZa2trbXdkb2JJdGFacGt2QWJkSktxTndTa3NodThSNGlG?=
 =?utf-8?B?YklkdFpWZjRERC9PQkh0WUQ4SmJzTHhwTHNCblF5SjE5VGRBR3dRT3puU21Q?=
 =?utf-8?B?UThlUC9aenZTdHV2TTNOZU1xODJGb0lVeW1rY2ZZcVQva0tTN0NjdmlJdEp2?=
 =?utf-8?B?S1FpVjBVL3draTI3NjQxcDFnNjZMVTErbytYK0l4RjRZR3dheStMMGR2bk52?=
 =?utf-8?B?bzFzN3NEczZBSHBSVVV1a1NNaE1qSDNNM0ZmOW54Vlh6aVZhSEphaWplUTlH?=
 =?utf-8?B?M2ZvNkplbkV0RFliRDZsbnVQdWQ1bnNkUURqWlNtOGpNOXp2NmhrRFpWUDJQ?=
 =?utf-8?B?TjBTVG9pRkhXYzNoZjFudEhKenBLdDk1Yko3eXcwTTBQZlAxRFRHTVliQmVh?=
 =?utf-8?B?V2x3Vk1VZjQ5empGOW9UMmE2ZHkvb3FLV25iMFRDV0dqcFBOeFZpazd5WDg5?=
 =?utf-8?B?M0ptSjZXWmt1elljN3RFL2NzUVFVNEFicDdCS29wRTd4c2J3cnZsYkNCSjRm?=
 =?utf-8?B?Sk1zb01hQlhKRjNJcnZXUDUraWxIaENSNWZlOFRvK0xMUFdtTWZmSXpIcWJS?=
 =?utf-8?B?V1UybzdsQ2crQjhyT2hiNnNOLzVuanp2MU9seGdqNXNhRHlITmc3WlRpdVI5?=
 =?utf-8?B?bWVTdmpKUWdYT0UwaE1tRHh2MHhVQ2hZL0l6RjN6YWtOQUNtTkxZaFVUM2x0?=
 =?utf-8?B?TlluVGxyOTU0R1lPY0RLQ2tQbmNoV2hKUXVKNHF1WlNCRks3eXFUVDJNd3g2?=
 =?utf-8?B?QWY5aUIvSEFGbk1PR1Q3ckNmeFBzalluRlNtbjd5czlLTjVJdHFXWkpHOFpz?=
 =?utf-8?B?ZXMvREE4OGFGVWRjQ25WWnI4VWo2TGlhaVZwL1lKL0dpemxTVGFVSmtUNVNH?=
 =?utf-8?Q?iBD2B5fP5tsSxr4ZnYpB5jk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f42bfa75-3fe3-47b0-36c4-08dba606e1bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2023 07:34:29.0020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /95Kq8b9HjgG8N8uCNDHnxr7FqKJTtxIYV02avVWYBbGQKXi2q83BbC4V/aJvTPQs6y2c6OI6gMdBFN6nInBYKqtcYcqGivLPY1pFn4gYPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1093
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <01BB069E75F8D944B330CC423A126BFD@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmljaGFyZCBaaHUNCg0KVGhhbmtzIQ0KDQpIb3cgYWJvdXQgdGhlIGRjMSBhbmQgZ3B1MSBv
bmVzPw0KDQpPbiBGcmksIDIwMjMtMDgtMjUgYXQgMTU6NDcgKzA4MDAsIFJpY2hhcmQgWmh1IHdy
b3RlOg0KPiBBZGQgbWlzc2VkIFBDSUVBLCBTQVRBMCBhbmQgU0VSREVTMCBwb3dlciBkb21haW5z
IGZvciBIU0lPIFNTLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5n
LnpodUBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlz
d2lsZXJAdG9yYWRleC5jb20+DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1
LXBkLmMgfCAzICsrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9zY3UtcGQuYyBiL2RyaXZlcnMvZmly
bXdhcmUvaW14L3NjdS1wZC5jDQo+IGluZGV4IDg0YjY3MzQyNzA3My4uN2I4YzI2ODliNDljIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9zY3UtcGQuYw0KPiArKysgYi9kcml2
ZXJzL2Zpcm13YXJlL2lteC9zY3UtcGQuYw0KPiBAQCAtMTY1LDcgKzE2NSwxMCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGlteF9zY19wZF9yYW5nZSBpbXg4cXhwX3NjdV9wZF9yYW5nZXNbXSA9IHsN
Cj4gwqDCoMKgwqDCoMKgwqDCoHsgImdwdTAtcGlkIiwgSU1YX1NDX1JfR1BVXzBfUElEMCwgNCwg
dHJ1ZSwgMCB9LA0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgLyogSFNJTyBTUyAqLw0KPiArwqDC
oMKgwqDCoMKgwqB7ICJwY2llLWEiLCBJTVhfU0NfUl9QQ0lFX0EsIDEsIGZhbHNlLCAwIH0sDQo+
IMKgwqDCoMKgwqDCoMKgwqB7ICJwY2llLWIiLCBJTVhfU0NfUl9QQ0lFX0IsIDEsIGZhbHNlLCAw
IH0sDQo+ICvCoMKgwqDCoMKgwqDCoHsgInNhdGEtMCIsIElNWF9TQ19SX1NBVEFfMCwgMSwgZmFs
c2UsIDAgfSwNCj4gK8KgwqDCoMKgwqDCoMKgeyAic2VyZGVzLTAiLCBJTVhfU0NfUl9TRVJERVNf
MCwgMSwgZmFsc2UsIDAgfSwNCj4gwqDCoMKgwqDCoMKgwqDCoHsgInNlcmRlcy0xIiwgSU1YX1ND
X1JfU0VSREVTXzEsIDEsIGZhbHNlLCAwIH0sDQo+IMKgwqDCoMKgwqDCoMKgwqB7ICJoc2lvLWdw
aW8iLCBJTVhfU0NfUl9IU0lPX0dQSU8sIDEsIGZhbHNlLCAwIH0sDQoNCkNoZWVycw0KDQpNYXJj
ZWwNCg==

