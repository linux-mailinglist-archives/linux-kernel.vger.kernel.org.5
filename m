Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9427D09DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376454AbjJTH4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376433AbjJTH4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:56:21 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E53106
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
        t=1697788576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pVNtGO/lXd5rfunRP/0VMgQKPmmkjApIWHnL3DCd8+0=;
        b=SKZBrt3+p3+6d2G/4UX44/MVDzYUzsZHqqnq/PbuzqTQsezHbz+UU49VhIW45o7o3UaXr3
        6DHhmgPtjhbVVzpVJuvo9VO9xQafwFUzZLtiA2KxV4Xt+1Tw3gTIBcrFmRjGpmIlRmKJ7x
        EzeTShk5ZDF5VS9xPe2OzqoWoHccq8k=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-lD_c-7Q6PS20Xr0cYgiccQ-1; Fri, 20 Oct 2023 09:56:14 +0200
X-MC-Unique: lD_c-7Q6PS20Xr0cYgiccQ-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0858.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:56::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Fri, 20 Oct 2023 07:56:12 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622%5]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 07:56:12 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
CC:     "sherry.sun@nxp.com" <sherry.sun@nxp.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "amitkumar.karwar@nxp.com" <amitkumar.karwar@nxp.com>,
        "neeraj.sanjaykale@nxp.com" <neeraj.sanjaykale@nxp.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Topic: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Index: AQHaAdM3VYxdJRU0oUK11G0+P2hl0rBRU0kAgAD+04A=
Date:   Fri, 20 Oct 2023 07:56:12 +0000
Message-ID: <caefad296d06503c69a095376acf3f65070604fa.camel@toradex.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
         <20231018145540.34014-3-marcel@ziswiler.com>
         <153890ae-2aba-461a-a0a2-0745047c9303@molgen.mpg.de>
In-Reply-To: <153890ae-2aba-461a-a0a2-0745047c9303@molgen.mpg.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0858:EE_
x-ms-office365-filtering-correlation-id: dca31294-f275-430f-a5a8-08dbd1420755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: KCyMm5wFzHHyW5nVm+TA/YghgP5rTuMlAlXn0o7Q3y0wbJymoEvBhPLv059Qn1lcdx0poCx0jLW9gqyZeqNuKUQPRnENjyGu94UbQ0VMvRi+GwNl9Mb/uIsoUOPLhRnbyT+4x2sq47FRKD/LteEaldPxJMjOI38ETvnj22Nps4VQd8GOUxbXP2j0V1mX+vyFa1sUy1tvpoYxlYYXt+TSfpjuNeUQTxY4c52HYIdqcoaH0JIEbKd86Xe6PqDTnVDVaCV8DJX8Fns1FCSFVxfaP8vdyZtI2zINxDjXzn7eXTYVlsOTRwRNDyw/5GVlM7JoLmd79viYnkj+u8mZQ82QEzJaLD8VBnMoUX1KgctYhxIseTGu4lKb+jZJysGhEkA+9LdZYNO0ZeGuktLJOoFe1UX1Iz0X5zPNy91hLlwGbJ9WjAKO7uTufByE38qYve6f+qQ6+z5jvS5rQSxBXZkqggLx+f4VoYuSlrT+vtQvuSdmLPpZvNfThHdnfgMvejVXLcMNqhBeAffzHi4DAzJorQBLY4fqZuJnympEZYyrws2/0JpiCC/vyB9vwgZCdKMAP5+9rswr00FVjiz5FtX+UqOGbmyGEQsVaKbcc8Ph3/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39850400004)(396003)(346002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(7416002)(71200400001)(2906002)(5660300002)(478600001)(966005)(6486002)(8936002)(8676002)(4326008)(44832011)(91956017)(64756008)(6506007)(76116006)(41300700001)(66946007)(66446008)(316002)(6916009)(66476007)(66556008)(54906003)(38100700002)(83380400001)(26005)(38070700009)(6512007)(36756003)(2616005)(86362001)(122000001)(4001150100001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk02Wnh2bE5qUzhmc1ZTL3RnVzhmTTlQeFRwT24wSk11OFpGajExUEZhaU9i?=
 =?utf-8?B?MGs3ZVVZMVVIdEFiMUUrM29CZS82NURvN1NzK0ZrN3VZMW5KY3pUeVhnRVlB?=
 =?utf-8?B?eVRBYzRoeFpqWkRicktIZDBiQjZ1NnVRUmJnZjNJMkJJN1VWTFBOVDFuVFVM?=
 =?utf-8?B?S2thRlJMZmdTV3JXbnlXOFp6V25kdXBmTnY5KzNBT0creEY2Q0dGN3dzWndE?=
 =?utf-8?B?U3pDN0Z4bTV0M0dSOVVnNW5tZ2J1WmY2UXdScmZOTm9JSzVFVGQ3U2I0azl1?=
 =?utf-8?B?anAzMXp2a2YzNDQwWk9UTmJtTVdTek03K3diNUFiQU5iZnlJVHBRMzRNcWVQ?=
 =?utf-8?B?WkwyQ1BiRWdNWHhlQWdxRVQ5dUNaSWduTkkzdVFpS2w3Tjd6dkVYay9pTWZO?=
 =?utf-8?B?R29sT1h2WkNwRi9PakJoVGMwK29aWU51UnlpRUtnVktNU2lTNSs4ZnZYUm1k?=
 =?utf-8?B?WTcvQm9pYW41cjBIejVvWlgwNWRROE8wd295VFhQY1VtU3VZRytqTHBZcjVk?=
 =?utf-8?B?LzV4TkhVZTZuemVuN2ozK0xITUtZNzdLMm0wK2pmZFdHS1BtdGVlUk8vSTJv?=
 =?utf-8?B?bEpiZUp6SXA2alNXUXU4YTNhUGMxa3VKMGdFN2gzaEpNUlc1aGdvNThncWd3?=
 =?utf-8?B?aUdBWUJXZTgxcmYrTTVKNXI2SEMzbDlVdWJpZmhPdGlmWWdKc1VzYnZucTVE?=
 =?utf-8?B?MXMyTCtoSlJPQm1wY3FMaXJzZVZLRkJuSzJBR0dOUjV6WXduVVRNdUNYbHpP?=
 =?utf-8?B?bWVsYVd2Vi9lbWJXM3ZyZk1qZWVzN0NEdFZwNWpmdDViYm41d1N2SCt3TUVC?=
 =?utf-8?B?S3UwUm5hZndWL0RQbXJNSi8yNERtZzZVbkFZVzUvNTAvdkY3N1dFK1o5dVly?=
 =?utf-8?B?VkkxcGY3c3plYVg2MENpL1ppZ2NpazZ5S0ZmQ2twd01JbGpMVE9UQWZGMm9z?=
 =?utf-8?B?anJQOG1PTTZyTGpsQngwRmNBYnJzMG5MUHNaMTFYWTQ4WFg2U2xaWVR1Yms4?=
 =?utf-8?B?L0FGMko1dlhsNVo3SWlpRWU0emxDS21MdkI3T0lLU1hzRnA1SGZIdko4aWxT?=
 =?utf-8?B?NFg2dXNJb3BjeXFMUEMwVEdiN0VjQzgwRmZ3YnNvTnJWeUZXeHRTRzc0ZjFS?=
 =?utf-8?B?VjFLWjA5cUFHWUlMSDJUaWNpRjBtbC8rU2FMY3cxU1ZlTEZsNEkvMWI3eG01?=
 =?utf-8?B?YlZxY0lUT3E0RENCSU9aRFlNSzc4Slp4UzQ0cjF1WGVtaGg4QlU2TDVqOUpX?=
 =?utf-8?B?bE5KYlRZM3htZHhuRVVJRXNhaTdwc3ArcmR4RU84bzNWN1I1T1QwNzhyNUV2?=
 =?utf-8?B?ZjhWVVFyeXNJcHJacHRITlhEVkhzUGlGdEVnZnVJQzFMN3o2Ym43TlVmbUdk?=
 =?utf-8?B?c3Ftem9XMS92aVRxcjQvcnZOa1FpZFVPWmtNdlk3aUpvTno2QVpHaFZ3Z0dn?=
 =?utf-8?B?V1lRZ01LeC93cDBjdThQT2RvZlJ4V29aZVhGaFYvYUUvREovbzAxRWx3UW9z?=
 =?utf-8?B?TW02NHFycytKOUpseVhVZWtVVTJteHRMc1FuZ0t6dWRScGpRMWE0cW5uOE10?=
 =?utf-8?B?M1JCMWpJOW9VMUM4bjJ6VCtUYkFNd01xMzAzZ2ZSSW5NTTJmNGNBZUZ5bzJs?=
 =?utf-8?B?MFE5UEo4WE5rUXhZYk1VYmNIRnlDOEV6bFo2ZHhXc0F0dzBKTTJ6OG9IUnR4?=
 =?utf-8?B?WTZWVUQyWDhpcjlvL21BTVJqVUpOSUhBRk1mOVVlQlRzYll4UGtFZ05RQmZY?=
 =?utf-8?B?Q01CcFpXZjdoUDluZi9WYWlXTVdaRGZkd2daa09rWUJmTnd4VUs2QlBkUFV2?=
 =?utf-8?B?ZU0rVEhDaWt3V0VtQ0lzNlVWa3dGTDE4TDZIVVFsSjRLdWNVWGxJbUl2SnY2?=
 =?utf-8?B?VFdTeDVsRGF3V0g2WWxrVWN2RTlpVXhlTVNQTDAvanJUQUxmTzBxZC9CUmR1?=
 =?utf-8?B?ZnB4d0g5WVZ2V1dYMEtLcGxKVDNObUpDVlBwbHdHTS96ZmRIaWk1Q0NDWm8r?=
 =?utf-8?B?NGpFUGRMMGRqQ0YyRWVWWGJCOVBkeXVhQzNHQ00veWZ2UjdndVFLdTZCUGVN?=
 =?utf-8?B?RVJkdFpCM21sOHNqVHA4S3ZWdzNSWnZyWnVjTS9LQWNsOS92ZzV0YTV2QkVn?=
 =?utf-8?B?L3BUQ1R1c0YxUkR0UTlSSVNIVkVvODZEaUNydnllbnZxK3BpVWxBUzE2a0JV?=
 =?utf-8?B?NUE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dca31294-f275-430f-a5a8-08dbd1420755
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 07:56:12.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDyzZk+k15C4KmtXIdhimMnUk/91hEnZ55ZSnOyKXVcDTOwNqrXQCq1gFHVdve55XYCI1DnvP5QrjicDQc2wG/5nEqPgZo9beywDBaoieCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0858
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <E9A393B300C1AD409025142819981136@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF1bA0KDQpPbiBUaHUsIDIwMjMtMTAtMTkgYXQgMTg6NDQgKzAyMDAsIFBhdWwgTWVuemVs
IHdyb3RlOg0KPiBEZWFyIE1hcmNlbCwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0
Y2guDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4NCg0KPiBBbSAxOC4xMC4yMyB1bSAxNjo1
NSBzY2hyaWViIE1hcmNlbCBaaXN3aWxlcjoNCj4gPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1h
cmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gDQo+IOKAnEZpeCBueHBfc2V0dXDigJ0gaXMg
cmVhbGx5IGdlbmVyaWMuIEEgbW9yZSBzcGVjaWZpYyBtZXNzYWdlIHdvdWxkIGJlIA0KPiBncmVh
dC4gTWF5YmU6IFdhaXQgdXAgdG8gMTAgcyBmb3IgZmlybXdhcmUuDQoNCk9rYXksIEkgY2FuIGRv
IHRoYXQuDQoNCkkgYWRtaXQsIEkgaGFkIGEgaGFyZCB0aW1lIGZpbmRpbmcgYSByZWFsIGdvb2Qg
ZGVzY3JpcHRpb24gYXMgdGhlIHdob2xlIHRoaW5nIGlzIHJhdGhlciBjb21wbGV0ZWx5IGZsYXdl
ZC4NCg0KPiA+IFVuZm9ydHVuYXRlbHksIG54cF9zZXR1cCgpIG1heSBpbmFkdmVydGVudGx5IGFz
c3VtZSB0aGF0IHRoZQ0KPiA+IGZpcm13YXJlIGlzIGFscmVhZHkgcnVubmluZyB3aGlsZSB0aGUg
bW9kdWxlIGlzIG5vdCBldmVuIHBvd2VyZWQgeWV0Lg0KPiA+IEZpeCB0aGlzIGJ5IHdhaXRpbmcg
dXAgdG8gMTAgc2Vjb25kcyBmb3IgdGhlIENUUyB0byBnbyB1cCBhcyB0aGUgY29tYm8NCj4gPiBm
aXJtd2FyZSBtaWdodCBiZSBsb2FkZWQgYnkgdGhlIFdpLUZpIGRyaXZlciBvdmVyIFNESU8gKG13
aWZpZXhfc2RpbykuDQo+ID4gDQo+ID4gRml4ZXM6IDY4OWNhMTZlNTIzMiAoIkJsdWV0b290aDog
TlhQOiBBZGQgcHJvdG9jb2wgc3VwcG9ydCBmb3IgTlhQIEJsdWV0b290aCBjaGlwc2V0cyIpDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJA
dG9yYWRleC5jb20+DQo+ID4gDQo+ID4gLS0tDQo+ID4gVGhpcyBpcyB3aGF0IG1heSBoYXBwZW4g
d2l0aG91dCB0aGlzIGZpeDoNCj4gPiBbwqAgMjg0LjU4ODE3N10gQmx1ZXRvb3RoOiBoY2kwOiBP
cGNvZGUgMHgwYzAzIGZhaWxlZDogLTExMA0KPiA+IFvCoCAyODYuNjM2MTY3XSBCbHVldG9vdGg6
IGhjaTA6IFNldHRpbmcgd2FrZS11cCBtZXRob2QgZmFpbGVkICgtMTEwKQ0KPiA+IFVuZm9ydHVu
YXRlbHksIGV2ZW4gcmUtbG9hZGluZyB0aGUgYnRueHB1YXJ0IGtlcm5lbCBtb2R1bGUgd291bGQg
bm90DQo+ID4gcmVjb3ZlciBmcm9tIHRoaXMgY29uZGl0aW9uLg0KPiANCj4gSeKAmWQgYWRkIHRo
YXQgaW5mb3JtYXRpb24gdG8gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpPa2F5LCB3aWxsIGRvLg0K
DQo+ID4gwqAgZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMgfCAxMCArKysrKysrKysrDQo+
ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMgYi9kcml2ZXJzL2JsdWV0b290aC9i
dG54cHVhcnQuYw0KPiA+IGluZGV4IDljYjc1MjllZWYwOS4uNGI4M2EwYWEzNDU5IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVy
cy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gPiBAQCAtMTAyMSw2ICsxMDIxLDE2IEBAIHN0YXRp
YyBpbnQgbnhwX3NldHVwKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQ0KPiA+IMKgwqAJCWlmIChlcnIg
PCAwKQ0KPiA+IMKgwqAJCQlyZXR1cm4gZXJyOw0KPiA+IMKgwqAJfSBlbHNlIHsNCj4gPiArCQkv
KiBUaGUgY29tYm8gZmlybXdhcmUgbWlnaHQgYmUgbG9hZGVkIGJ5IHRoZSBXaS1GaSBkcml2ZXIg
b3ZlciBTRElPIChtd2lmaWV4X3NkaW8pLg0KPiA+ICsJCSAqIFdlIHdhaXQgdXAgdG8gMTBzIGZv
ciB0aGUgQ1RTIHRvIGdvIHVwLiBBZnRlcndhcmRzLCB3ZSBrbm93IHRoYXQgdGhlIGZpcm13YXJl
IGlzDQo+ID4gKwkJICogcmVhbGx5IHJlYWR5Lg0KPiA+ICsJCSAqLw0KPiA+ICsJCWVyciA9IHNl
cmRldl9kZXZpY2Vfd2FpdF9mb3JfY3RzKG54cGRldi0+c2VyZGV2LCB0cnVlLCAxMDAwMCk7DQo+
ID4gKwkJaWYgKGVycikgew0KPiA+ICsJCQlidF9kZXZfZXJyKG54cGRldi0+aGRldiwgIldhaXQg
Zm9yIENUUyBmYWlsZWQgd2l0aCAlZCIsIGVycik7DQo+ID4gKwkJCXJldHVybiBlcnI7DQo+ID4g
KwkJfQ0KPiA+ICsNCj4gPiDCoMKgCQlidF9kZXZfZGJnKGhkZXYsICJGVyBhbHJlYWR5IHJ1bm5p
bmcuIik7DQo+ID4gwqDCoAkJY2xlYXJfYml0KEJUTlhQVUFSVF9GV19ET1dOTE9BRElORywgJm54
cGRldi0+dHhfc3RhdGUpOw0KPiA+IMKgwqAJfQ0KPiANCj4gSXNu4oCZdCB0aGVyZSBhbm90aGVy
IHdheSB0byBmaW5kIG91dCwgaWYgdGhlIGZpcm13YXJlIGlzIHRoZXJlPyBBZGRpbmcgYW4gDQo+
IGFyYml0cmFyeSB0aW1lb3V0IG9mIHRlbiBzZWNvbmRzIHNvdW5kcyBsaWtlIGEgZnVuZGFtZW50
YWwgZmxhdyBpbiB0aGUgDQo+IGRyaXZlcj8NCg0KWWVzLCBleGFjdGx5LiBZb3UgbWlnaHQgaGF2
ZSByZWFkIG15IHByZXZpb3VzIG1lc3NhZ2UgWzFdLiBUaGUgd2hvbGUgZHJpdmVyL2Zpcm13YXJl
LCB3ZWxsIHRoZSBlbnRpcmUgdGhpbmcgaXMNCmJhc2ljYWxseSByYXRoZXIgZmxhd2VkLiBCdXQg
dGhlbiBJIGFtIGp1c3QgdHJ5aW5nIHRvIGluY3JlbWVudGFsbHkgbWFrZSBpdCBhdCBsZWFzdCBo
YWxmLXdheSB1c2FibGUgZm9yIG91cg0KdXNlIGNhc2UgYXMgd2VsbC4NCg0KWzFdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC9kY2E4YmM3ZmVjNWY1MjdjYWMyZTI4MGNkOGVkNGVkYWUxZjQ3
M2VhLmNhbWVsQHRvcmFkZXguY29tDQoNCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0KDQpD
aGVlcnMNCg0KTWFyY2VsDQo=

