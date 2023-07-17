Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BB9755AED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGQFmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGQFmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:42:11 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBABE72;
        Sun, 16 Jul 2023 22:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcZpVpzbyOnTbgpvnjwFvXABDfvweeMUYye5pzOd7bIMGP7QBFyczEbIm/eQj3VQDfcb7zMCuwCiMXGO+d1aBl+Cc2qDw6pBjs+THUFYfPmSeyxz9dAu2CesQXvNMNf8hVPS7L9Lw/xHTwqX0UkeUDi8SZVmxVWt8os4y893cgYQv4qZ9sLOqcgJQ4jCFO5/WP1JIc+nXC/kPrSpcWrDitZhPlc0PqJ4+ybGExVU7R8WTWP+Lg5aGkMveRQ5X7x7gtNVyAlFGOM86vrvf+IJZmPNfYpNZwjjYKPiN+shrFUYd7Znsx7QiH++Vz2peC7w45PJ+T26wqQ2Wos2DE/o7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwejUMOvIxkLVOSUEnQnvZ4rvP6PP9VUGDfoyt7V2F0=;
 b=DF/qsrDw1rc7yage9JcyLD/Byt1qZuK5THzEEn8Wd5a8/QSH2gsJLgP95K5U38Mvj46Tj6xTxfoi4UfUJuubB8IMncewGPBx4l5wk+wZQsvmHn2dyrgbomQ3l9P7JWWqHFh83RXdg8GtMEEMx+vRuhsqHMHcjElMcCRG59uvxKCdqynCPnJS2jxW3HNTj0Vk4pEvQ0m9W9HS2p5/axwMRfDQFCGlgCd/3RkmkWexQ+/DmdvhTo7raP/HFaTas/4Cp73cJh72OTTCcZGujjtpfFDPxaNZLlw2f9Nmp5EEcyJu3UhT7caMYI4bnxi4NsuavksL57EyHd8QyKTg+ciNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwejUMOvIxkLVOSUEnQnvZ4rvP6PP9VUGDfoyt7V2F0=;
 b=sjoc29zhBhqly5US70Xq/bAYohlIJ3SbJtN81ImHoCTcrGqZWFu2FO7FMTybuL2sD+ThvAwFa/ECTLjW/zsg1uZPJa8zMxMQFPsmy7KXkhv4pCsjh8ZxYNT7WL8SOYVG39OiDtCfEJsBbgfn1wxjZxDk6zS/Gsa9nZm0NNK0/fM=
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com (2603:10a6:803:cb::15)
 by AM8PR04MB7972.eurprd04.prod.outlook.com (2603:10a6:20b:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Mon, 17 Jul
 2023 05:42:02 +0000
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::d375:ff5f:2ab0:d6bf]) by VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::d375:ff5f:2ab0:d6bf%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 05:42:02 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Franck Lenormand <franck.lenormand@nxp.com>
Subject: RE: [PATCH 1/2] crypto: caam - Change structure type representing
 DECO MID
Thread-Topic: [PATCH 1/2] crypto: caam - Change structure type representing
 DECO MID
Thread-Index: AQHZtIcyahzyTwWZFECgx90RE/Or/K+9ebzQ
Date:   Mon, 17 Jul 2023 05:42:01 +0000
Message-ID: <VI1PR04MB6013AAED1583FCEAE4FE6040E73BA@VI1PR04MB6013.eurprd04.prod.outlook.com>
References: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
 <20230712060728.3562376-2-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230712060728.3562376-2-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB6013:EE_|AM8PR04MB7972:EE_
x-ms-office365-filtering-correlation-id: b50331c9-6492-472c-c29d-08db86888ba8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kzrpy1sJlwAYPvcnXwxZVIPMdI85L8dTakv53YoEGGY5xfijx0rvIB2xlB+LKH9DvdfkOATIjPtlHyWTGFNrINYm6OIEZIcGXFaL5IRNxKtvWaCU0Eml9AZmgb6rDwG58lLGRKr8NQhWXsHFwCgJbaBNwSylJv0vIMaJfKttWgFFvUfqLxoTW8ogLD8CwWCITsfrRY4WM/xaQlIKXcCLnIcUTstcLSWQ5PFt3m/2bGXr1O5xjyybr52gSqe4/mAzvfj39vcIIyPFp9F6fGecyCJj1ebUOm6tU6B8m/E6cXbA9jRSvRJxz6/Qw77q+T6q9SC+cpnD2q4b0vbBwayZP0puJYJq5BEN352lEZ7kPx9qnVXcFVDLtlgmZhq2jn7QLMkIF5PE2DpIVPPq50FQ3oqRt2lv9eNtcAeIfLxaOLl+a5dXHiVb672oJc9ocXqLMZYH+hNrRQC0OjXCgbG09Gz/XdJJ88NLqTOwWh09VbWhi7UXV7gMfIpBBPvhIJaP/n3w8fEdjQ2FmS1Z88kKEJ1viqOsNzVpGjgpWt4UO9jykP8p5GNNTx0hqcd+7bWItIdw6pxtal9uwtybMrkrV2h05rHjkyiKoEcTcDB3/+FoKvMBdGyRGcQozf06XYUx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6013.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(186003)(71200400001)(86362001)(122000001)(6506007)(38070700005)(53546011)(41300700001)(9686003)(55016003)(7696005)(44832011)(66476007)(76116006)(66556008)(478600001)(38100700002)(2906002)(110136005)(66946007)(83380400001)(64756008)(66446008)(4326008)(8936002)(316002)(8676002)(5660300002)(52536014)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elNqa0trVUJDMWZoOEcwNEdST0JCUmVqRmZnTDlCMUZzYkZ2cENxWHNiNWpT?=
 =?utf-8?B?V0k3MCtnNEx5ZEkyT1lTVFAvenQ2SXpyRTRwa3hMc3gzWlUyRk9kcnVPY2h2?=
 =?utf-8?B?TGh6eUw5elJHREI0ZTJYb3hBVGRBNG9rWHBCYjluTWUxVGVFZUlSclJ6b3I3?=
 =?utf-8?B?UkR6K0pKc3AzWldZclprYXNXSlN5ZXdhYUlkQ2c0OVpNaUpwOVFScEJjOUlY?=
 =?utf-8?B?QTBZVVZUWG8wdUYrV290aVNvdkhtWThJL1E4TmtzUXRuOFVpR3kwNlhKN1k2?=
 =?utf-8?B?Vm9uSm9IeGxSZTV6RGR4WmIrY2VPKzVyWmVubUY0Q0NnRWxNU1Z4SnRjQ2ZQ?=
 =?utf-8?B?TVJlZHVlT05QOXZUUXhYeVQzT1VHMDRyb3U0NEdpQTUwVkxnUVFqNSt0OE9w?=
 =?utf-8?B?Vi9IdGdydlRVOW1hYVVVdm0wdjZGQytJUXBRb0N6eVFyWFUrRTlwdWU0Tk5Z?=
 =?utf-8?B?aFYxcjFMMCtZUXdXKzduTTIrdzlMd2dpeXBBWWdDcnFyRHgwZXQwWEk4ZWtQ?=
 =?utf-8?B?blBVc0d4emFjdjJLOGt6d2JIVFRFOFhkYVlkRWxLS3ZNalVBMkRTQ1FuYnZ5?=
 =?utf-8?B?bjkwY2JpYVFJZk5sWmlXNHpuM3ArRTg0cG1kLy8xWFhxUkI3MWVhTTMwa1Ba?=
 =?utf-8?B?a3dyZzI2NXNETGlwMDY5L3JnNUVpZmFrL2QvdEFxbVBZMm96V0ZUb3lxaHJq?=
 =?utf-8?B?THZkSlQ0c1R4cVQxakZrbTFiV0cvcDh4RXY4V0F6SlQrSmM1NksrU3Q2bGx2?=
 =?utf-8?B?Z2FwY1l0OC9OVDBVaFBpWVhNNldIWlVPcGV2ZUhSZk42bG1DSSt4YWk2UEdU?=
 =?utf-8?B?S2NIMVlGQ21JekU1VS83clluL0haWVlzZmhPc1YrZHdES0pmSmk0dnJuOGZk?=
 =?utf-8?B?d3RlWE1SMHB1bkkwaWRRamJUWU1PYU1wOTVNN3hOOWJKRWVPWU5SZHlCaEt5?=
 =?utf-8?B?ekh0WGcyUzhFdFo4Y2VqbVhwcVhSL3hjdDJIUDArRTRJK2xGbERkSUU4Mkpu?=
 =?utf-8?B?azlkODRGS1FMUS9aSS9HeW55djJLQlZFcnMwN0x4L1Z1OWxGQTViOUFWY2Vm?=
 =?utf-8?B?cmh0YWJqMS9FYkl0TUQ5N1FjQXpYTkVtQ2lsRE9oWmlrWWpEOGRzdWg1MnRj?=
 =?utf-8?B?YUtQMFJ3YzAycFNIZUNoRVRWQS8vTXNxUUVYb29meHNQeU5yM3Avam1wS090?=
 =?utf-8?B?TVRQZFRlcGpMUHluRXlnUkRzaUdaMEZIZlpZczNwak1WRTREMkNzamdnM0w4?=
 =?utf-8?B?NFNIbE4zQ0ZxcGxZUGRJRmtPRlJOM0hlaUo3MDNWcTFZdXM5d0IrZDJLM200?=
 =?utf-8?B?dTRPYkZFWlJPOFQvR1RvQ29xLzJwTzhreGJBTkxuZmllTVVkZmtJZWJreXFJ?=
 =?utf-8?B?eDRTNHpkODFlU2lNOWpQNmprU0lFL3lXNDU4TEFoWSt1UTduc2hiV0JlSzY0?=
 =?utf-8?B?Y0dVUnI5U2dmT20wNGxYU015aGxVSkJtMC8rN2JxQWNPYmp1ZEJVbGpTVTUr?=
 =?utf-8?B?MnBKNW1Cbm8zbHZsZ0N5bmhVVUM2bU4rR1FHR1ZnSUlCcEdHNnU0L3JhbzFs?=
 =?utf-8?B?OTVmdGg1djlpWWh6N1ptdjJ3R3V2Q2NOcXZKbm5mc25SNHovWnAyZ08xa2pr?=
 =?utf-8?B?VUtTVEhQeWR4WCswV255SWZjeG1qSUV4YmxzQUszckRTTXlFZ2lURytPUC9n?=
 =?utf-8?B?bHBET0hRNXNKNnNvRnNwRlc5Rm93czVYdFJCeHV6am81UlNEQmI3cVNINVRp?=
 =?utf-8?B?cjYwQWdxWDZVNkw4UVBubnZBbWZzV2U1SmVKUzV5cEhXbW5MUFUrKzV6RTR6?=
 =?utf-8?B?MytTY1dJVEdRVmo4MW9BM3VFUnpJbXZpMkl2dkJrSDd1LzIralZpWFR2MzIx?=
 =?utf-8?B?VmpLT3lMZmMwS2RJMktmRFExbFV6bmZ2T2krMkx4ZXE1YzY0SEMzMFBDdWZT?=
 =?utf-8?B?UmdLWlNSV3JGU2lsWlJrRzhPTWJqSE1XZERHWWZWd2hLK3A0bXJTT2hlSmFE?=
 =?utf-8?B?UUpHRFFUQWdaUXF5dkJnWlp5RTlHbFkxMjRJYU41cEhHVWxxeDczd2VoQm0x?=
 =?utf-8?B?QVRjK3l3eW82RmFML1MvWVovOEh0OHlTOWE5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6013.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50331c9-6492-472c-c29d-08db86888ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 05:42:01.9521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNzEjL4HiGULWKHyV7abS/PNCpqxN5l56FqgagF/fo5nTcHeGQAeR45MxupPuRwFgvqRCFpsWva6HJx+aCtu+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7972
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEdhdXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1lZW5ha3NoaSBBZ2dhcndhbCA8bWVlbmFr
c2hpLmFnZ2Fyd2FsQG54cC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxMiwgMjAyMyAx
MTozNyBBTQ0KPiBUbzogSG9yaWEgR2VhbnRhIDxob3JpYS5nZWFudGFAbnhwLmNvbT47IFZhcnVu
IFNldGhpIDxWLlNldGhpQG54cC5jb20+Ow0KPiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBu
eHAuY29tPjsgR2F1cmF2IEphaW4gPGdhdXJhdi5qYWluQG54cC5jb20+Ow0KPiBoZXJiZXJ0QGdv
bmRvci5hcGFuYS5vcmcuYXU7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGxpbnV4LQ0KPiBjcnlwdG9A
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBGcmFu
Y2sgTGVub3JtYW5kIDxmcmFuY2subGVub3JtYW5kQG54cC5jb20+OyBNZWVuYWtzaGkgQWdnYXJ3
YWwNCj4gPG1lZW5ha3NoaS5hZ2dhcndhbEBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBjcnlwdG86IGNhYW0gLSBDaGFuZ2Ugc3RydWN0dXJlIHR5cGUgcmVwcmVzZW50aW5nIERFQ08N
Cj4gTUlEDQo+IA0KPiBGcm9tOiBGcmFuY2sgTEVOT1JNQU5EIDxmcmFuY2subGVub3JtYW5kQG54
cC5jb20+DQo+IA0KPiBUaGUgc3RydWN0dXJlIHBhcnRpZCBpcyBub3Qgc3VpdGFibGUgdG8gcmVw
cmVzZW50IHRoZSBERUNPIE1JRCByZWdpc3Rlci4NCj4gDQo+IFRoaXMgcGF0Y2ggcmVwbGFjZSBw
YXJ0aWQgYnkgbWFzdGVyaWQgd2hpY2ggaXMgbW9yZSBhcHByb3ByaWF0ZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEZyYW5jayBMRU5PUk1BTkQgPGZyYW5jay5sZW5vcm1hbmRAbnhwLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogSG9yaWEgR2VhbnTEgyA8aG9yaWEuZ2VhbnRhQG54cC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IE1lZW5ha3NoaSBBZ2dhcndhbCA8bWVlbmFrc2hpLmFnZ2Fyd2FsQG54cC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9jcnlwdG8vY2FhbS9yZWdzLmggfCA4ICstLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vY2FhbS9yZWdzLmggYi9kcml2ZXJzL2NyeXB0by9j
YWFtL3JlZ3MuaCBpbmRleA0KPiAxODllNzRjMjFmMGMuLjBmODdiZDM2NTU4MiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9jcnlwdG8vY2FhbS9yZWdzLmgNCj4gKysrIGIvZHJpdmVycy9jcnlwdG8v
Y2FhbS9yZWdzLmgNCj4gQEAgLTQ1OSwxMiArNDU5LDYgQEAgc3RydWN0IG1hc3RlcmlkIHsNCj4g
IAl1MzIgbGlvZG5fbHM7CS8qIExJT0ROIGZvciBub24tc2VxdWVuY2UgYW5kIHNlcSBhY2Nlc3Mg
Ki8NCj4gIH07DQo+IA0KPiAtLyogUGFydGl0aW9uIElEIGZvciBETUEgY29uZmlndXJhdGlvbiAq
LyAtc3RydWN0IHBhcnRpZCB7DQo+IC0JdTMyIHJzdmQxOw0KPiAtCXUzMiBwaWRyOwkvKiBwYXJ0
aXRpb24gSUQsIERFQ08gKi8NCj4gLX07DQo+IC0NCj4gIC8qIFJOR0IgdGVzdCBtb2RlIChyZXBs
aWNhdGVkIHR3aWNlIGluIHNvbWUgY29uZmlndXJhdGlvbnMpICovDQo+ICAvKiBQYWRkZWQgb3V0
IHRvIDB4MTAwICovDQo+ICBzdHJ1Y3Qgcm5ndHN0IHsNCj4gQEAgLTU5MCw3ICs1ODQsNyBAQCBz
dHJ1Y3QgY2FhbV9jdHJsIHsNCj4gIAl1MzIgZGVjb19yc3I7CQkJLyogREVDT1JTUiAtIERlY28g
UmVxdWVzdCBTb3VyY2UgKi8NCj4gIAl1MzIgcnN2ZDExOw0KPiAgCXUzMiBkZWNvX3JxOwkJCS8q
IERFQ09SUiAtIERFQ08gUmVxdWVzdCAqLw0KPiAtCXN0cnVjdCBwYXJ0aWQgZGVjb19taWRbNV07
CS8qIERFQ094TElPRE5SIC0gMSBwZXIgREVDTyAqLw0KPiArCXN0cnVjdCBtYXN0ZXJpZCBkZWNv
X21pZFs1XTsJLyogREVDT3hMSU9ETlIgLSAxIHBlciBERUNPICovDQo+ICAJdTMyIHJzdmQ1WzIy
XTsNCj4gDQo+ICAJLyogREVDTyBBdmFpbGFiaWxpdHkvUmVzZXQgU2VjdGlvbgkJCTEyMC0zZmYg
Ki8NCj4gLS0NCj4gMi4yNS4xDQoNCg==
