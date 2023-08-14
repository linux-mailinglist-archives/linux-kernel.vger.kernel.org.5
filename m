Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A12C77B970
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjHNNJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjHNNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:09:19 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2096.outbound.protection.outlook.com [40.107.104.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03114E7D;
        Mon, 14 Aug 2023 06:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMGcDqissmIOYDC/lfVJHBwOoEqH2c+P9BLe9Ba6IIZb4SFjO35zd5zmMDTPYfk9LIzfHdUWaXx8PVSa9GOmiOyEmqw2P08D3v2gj6NqKYcCKYj+OJeoni2fpr3/HpAGsZMiDTrEAJpVYcp3Uaai90muRZdRUmKUyLtXW/Rsu2Qafn7g7XaNbAanm1ctdBkKv+1hEGoPxx3Ex3eL3Fy7pGmxDYG2R2rK5JLnYvDn1TM1nuLnCULPwKBg3KnSmjlfhimhxMDryDGl6938IhWW41b79FHijLmtC+ZKfoxtJggUk1cwle/nkzOrR+Gf7ZSDAhUzXszXuNvQQebj+EukMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NxznUZRQi1LMvnUT3jnGdCOVkEdLMDxgARh7gDjASs=;
 b=l/KWYmA92in9s2ordZM229P4wgmbh12LOk0QaE/QbST1Gqqn0L4hCOBc6xRgdV1mOz5gd4N8cIerZNAxYvmlCj3NqauHBdHsUGB+3h30gD2w95p2XH80F0PjvIJC/qEnuM+ikk8MlShYWv2whHq7BuYFJG59vX2XPvQRJDQdejo4dpeES7U602xPtXl++vbS7z6mGhObJ0ZyVPeFHNT37MJP8lAzCzsNSyAQIonkwKAhXOAE3atTWQrIu6ja0B91hmySowB4XhARSjOT1XJVosE6FGcfd14sLMwyxTVhFTXKaAFUNrwzKokz1tjtGBMFxQwDAhUlhv7pHGo1vk++Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NxznUZRQi1LMvnUT3jnGdCOVkEdLMDxgARh7gDjASs=;
 b=DTsBNjQXQeM9GppmlVDhPvmxu5cTnAuV2vL/XnKG0Y/bdYtT2qc1u3Ay6NVAyjNjEnezafC++bhCpsrNEDM7mJkGMXC5glLYjz/bKrnpvxwbx1/fm/rzBDqiI+3FNkYcS4VObho9TTKCOzSVOTcok3g/xF0QVeza8j+QAXwXjVo=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by VE1PR04MB7406.eurprd04.prod.outlook.com (2603:10a6:800:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 13:09:15 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 13:09:15 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver
Thread-Topic: [PATCH] Add Silicom Platform Driver
Thread-Index: AQHZuZEcSTfJXOh+tEO5M8hB8nDqzq/BAaYAgAhCLzCAD07vAIAIVRGwgAMOaICABfdeoA==
Date:   Mon, 14 Aug 2023 13:09:15 +0000
Message-ID: <PA4PR04MB9222151A822D664B7064BE3C9A17A@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <94cbb7d-68a-765-8bdf-5c8f8e41891@linux.intel.com>
 <PA4PR04MB922224D96319862CF987FE459A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <58da791d-866c-ce2f-94bb-1feff8506c2@linux.intel.com>
 <PA4PR04MB922238E924D10FE9A5B2625D9A13A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <2322cf5f-66e2-cba1-a95a-83bceb3aa2c8@roeck-us.net>
In-Reply-To: <2322cf5f-66e2-cba1-a95a-83bceb3aa2c8@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|VE1PR04MB7406:EE_
x-ms-office365-filtering-correlation-id: 5af95f83-5e9a-4eb1-0060-08db9cc7a8fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOx9i8XfxhTuMvl9qxtsVmShVFTy6FGBpgKy8ocst1wQnMrWChfDmCAxnmRqpXQNZSEcUMrCK78dAj4NcP9PjI1lLtBfCBiUQWgqwMSjACdEl39H+dZYDKD+0UnhX9Eyr2bSLyBsnBILcIDD+H06wvo7KkUw4C9Zeb71fYFWwfZLva0IDe3xA3KEjAQI5XJnikGcPjLfxmJioGrZC76PeKNDvZRn1Oz8fALi3wwYOjgdb4yH02iW/jLIDQV0Ea7DQoUPv3e18Iwaqd+M6/oE/pYAVoblHlj7WNA2qv90Ri7I2fcSLNmII6DCFMtZnlHYMpO6e9g6HjOA7CODE3kRq3X2DCT10U/877JYBgUUj5tmlo01/MExWFoOVA5QDfk3jrx1X7rTDwrWukBuLgI4HFLYFHwhMzRSXKXtWWVFVIITuzlCPg/RuNm6Zd7PNqzPXvYLCyL9z+ZYO/QW4ur4VQ/yNXtvbd37c7dFTosGKFMU0ORd6X7S1YzbMavthtRiiMqKxlaRIiDprTXxUwIAvAgJoHMKmFtHVsBBe7BGdA/6yr3aFZ/87/iKI9cVCOdoXeJxdsFQFPCwSAkWnwCk2CaBHO7e/q3xT8hy86cymk5h5nSDa6I1tpE+DIzDHyqf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(366004)(346002)(396003)(376002)(136003)(451199021)(1800799006)(186006)(71200400001)(45080400002)(76116006)(110136005)(6506007)(7696005)(478600001)(66574015)(33656002)(86362001)(83380400001)(7416002)(55016003)(107886003)(66946007)(53546011)(2906002)(9686003)(38070700005)(38100700002)(122000001)(316002)(52536014)(4326008)(66556008)(64756008)(66476007)(8676002)(54906003)(66446008)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTJGVDJGaW9SZ2E0UVl3NlRXOE9la1oyT3MxZUdBelY4ZzZtRnZES3lJcWE3?=
 =?utf-8?B?ZGZOSkQzOURQODBuSzIrSWdNTGlxN2hLTktQM3hBQUdqRWpDSi9oOU9YS3hu?=
 =?utf-8?B?d1NoMEdJRWJmVXFGc0hJVGV3WTM0RDFyaEd2MU9tajVEZ3dKemFTM256Sklq?=
 =?utf-8?B?ZllibXNsS0I3SUd3UU9ta09jYjJ6a3dWSytHTVIxK0U1cW12aG0rS1JRZWU0?=
 =?utf-8?B?cXJuM2puSTFkTUcwdDVsYU05aEEzMDg1N2VmSS9iQmZlNGpZMnJFQUlFcDRF?=
 =?utf-8?B?UUxvYnIvbW50OW90VnhQV0QxSTBFUjVBQ2xFcFlnSG5GVzY3WDM4elpsSDBn?=
 =?utf-8?B?UkpRZzlyWXA3NUF0cmhpbGVjeGplaG45U21WblY0VGVza0taTVlmaG5BVWd6?=
 =?utf-8?B?MTdvbjU2bGVMeDZtYWdZejFpRDRFLzlxK2JmV3FpcVFvMTdremVoTHl4cmtt?=
 =?utf-8?B?cUpxTENZZ0JvNjM2eldIQ2ZlUzVWVmhBSlE2UlVHaTlMbjRWOHdyTGRCcUoz?=
 =?utf-8?B?OHN5SUl3b2NFeEJQNkJSUmJlelVkckJ2QlJ0MVdFamE3MXN4MWR0Q01haUhs?=
 =?utf-8?B?ZXN5Qy93MGdqRVNZMU9USlh2Mk5MSFVxd05ObHF5WHQxelF1NDQzVW40cmRw?=
 =?utf-8?B?VitwelpTUlNac0RZSW9QOTBJeTV1UG5ncmNkZERSN3ZDZldHQUtSdDg3VU8v?=
 =?utf-8?B?VkVMeCtsNFByOEtpYTRaS3AwQS83K0NFa2dzZTVhU0kvdzMxdVpERDBjRFR6?=
 =?utf-8?B?SHk1VXNWbHBkcWtYc05GUUhNKzlYOGNKK1NsT0QxdFZWc0sxdzJvY0FWc1ZH?=
 =?utf-8?B?dE9xUGFOYnRyTFRvVDRENVFpdFh0ZzNzRnVVa2RPcSttaTBkUEJETlZuTUg3?=
 =?utf-8?B?SEgzWmxzd2p1OTZ1cWVEM3RTdmJnVWxkOHMybWFXZ2ZFOWloTHJYdExIcURI?=
 =?utf-8?B?ZUhOY1hkeEtLTE1oNmdNQ3lCVHdMeC8wZzJhM0JpWkhVeWdEd25PT092eGdj?=
 =?utf-8?B?MTNtWndvSk1ZbDdYbUwrc2pyQ05wL1VRWGFIamlBVEl0Mzh6U01LWU1jUlpr?=
 =?utf-8?B?Tm5NdVpIeGdJYkhtV2xwQWtvZHJHcGc4YjJqK3Y4OFU0aEJMYWRNUUVlajNt?=
 =?utf-8?B?ZTVzbXJNN3ZrdGVqai94OGFmMW9LZmxUYk1IcG5JcEZ0T1MxZEprSko4L3B2?=
 =?utf-8?B?TVpFMThNRkEraUkySTU5ZU9TYzljMEJBeFR0WXR2L3g0MjNHTEtLUUZ1L3FN?=
 =?utf-8?B?Q2dLQkxPcnRSRm5oUEJqaXVUQmI0U0ZIUmo2d0wyaU1NOWdvWXJaYXhKY2hu?=
 =?utf-8?B?TkxmUytXcWpRUWdaUlRGWjJPeHNNTmFzZ0pSRmdwckpYbXFDc0NSdzQwMnRp?=
 =?utf-8?B?Z0FOVGlKa1EyV2x0RHNxVk1zSHlxSDNNekY4dVZrWEp4SncxNG82VE85eHRk?=
 =?utf-8?B?UHJzOWNDY2VoSXV4MDVkdmM2a3FJWHg3TjB6Ymd3d2hnTXlqWGV1cTRaU2xQ?=
 =?utf-8?B?MjJ0MWdVS3BTMWdxRldqZVlKS0JJb3ZFUzRocjVrQUpFVWtEdzVwQWZTVHpy?=
 =?utf-8?B?bFIzVTJaZHZmQktCSnI0dW5oT0M4cjNKa3dsbll0dWZJTXliYklnTzV3ekNn?=
 =?utf-8?B?d24yRXBvak5pWm1WeGZHREw5T0RFaDYvN3FkRlFMemllS25UcTVvbk9pcHNm?=
 =?utf-8?B?VEZLaEtGZFVITlMyRjBwdkx3ZmQ5NUJnMTZDVERsSW1qRThUQ3d4eGI4LzBi?=
 =?utf-8?B?K2FraHpzUWtYTHUxMXR0THFzZDl1OWpsZE5kS29aeURJazcxMGtBRCtTNkc1?=
 =?utf-8?B?eU1jQU83S2xFU2psUVVOOFRZYTdZemQvOGNXNThIbUVsaDRvNnE4cGZNeTBO?=
 =?utf-8?B?SUFYWmFkYStFeFF2eFBzc29FQXpHV09zZU1hWlBzcXJ6Ly9vbXZoVDI5NTJK?=
 =?utf-8?B?c3N5QVBLK2ZKS083OElQNUVSTXltNW5EYnZuNGVBVFJMcDI0TFoyRkpIcit5?=
 =?utf-8?B?MUNLdnVtTWdnMkJvQUw4VFRjbEZtMEtEeCtqRG9DblBNMkxEbVFyYjFhSk5G?=
 =?utf-8?B?Q2ZSZTYzdUEvcUFwT28zMFdFVnoyV3VxcTlBeXVMTkhvRys1U3RaTUUvR2l0?=
 =?utf-8?B?N01MSVRXb1dNOXJkSWkyU2ZneXBmaXVvM0hKL0FtTHlMM2VDa3ZBYTZ0eFFG?=
 =?utf-8?Q?D2A18mdExqk3xgc5zDuBlQjZYv5P1uxaBh6FF3wflVj9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af95f83-5e9a-4eb1-0060-08db9cc7a8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 13:09:15.0222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PB6eSsibc8IPNtv9gQ2kP6iI0/GamW434LGmrzJeX4pONa1752anu0HvU8KTL2zzvJmZS3UW+6SATDc0qBcZOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7406
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBHdWVudGVyIFJvZWNrIDxncm9l
Y2s3QGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIEd1ZW50ZXIgUm9lY2sNClNlbnQ6IFRodXJzZGF5
LCBBdWd1c3QgMTAsIDIwMjMgMjowMSBQTQ0KVG86IEh1aWJpbiBTaGkgPGhlbnJ5c0BzaWxpY29t
LXVzYS5jb20+OyBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+
DQpDYzogdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGU7
IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmc7IGhwYUB6eXRvci5j
b207IGhkZWdvZWRlQHJlZGhhdC5jb207IG1hcmtncm9zc0BrZXJuZWwub3JnOyBqZGVsdmFyZUBz
dXNlLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgcGxhdGZvcm0tZHJpdmVyLXg4
NkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZzsgaGJfc2hpMjAw
M0B5YWhvby5jb207IFdlbiBXYW5nIDx3ZW53QHNpbGljb20tdXNhLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0hdIEFkZCBTaWxpY29tIFBsYXRmb3JtIERyaXZlcg0KDQpDYXV0aW9uOiBUaGlzIGlz
IGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mg
b3Igb3BlbmluZyBhdHRhY2htZW50cy4NCg0KDQpPbiA4LzEwLzIzIDEwOjQ4LCBIdWliaW4gU2hp
IHdyb3RlOg0KPiBJbHBvLA0KPg0KPiBTZWUgbXkgY29tbWVudHMgYmVsb3cuDQo+DQo+IFRoYW5r
cy4NCj4gSGVucnkNCj4gLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbHBvIErD
pHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5
LCBBdWd1c3QgMywgMjAyMyA4OjA3IEFNDQo+IFRvOiBIdWliaW4gU2hpIDxoZW5yeXNAc2lsaWNv
bS11c2EuY29tPg0KPiBDYzogdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBi
cEBhbGllbjguZGU7IA0KPiBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IHg4NkBrZXJuZWwu
b3JnOyBocGFAenl0b3IuY29tOyANCj4gaGRlZ29lZGVAcmVkaGF0LmNvbTsgbWFya2dyb3NzQGtl
cm5lbC5vcmc7IGpkZWx2YXJlQHN1c2UuY29tOyANCj4gbGludXhAcm9lY2stdXMubmV0OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyANCj4gcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZzsgDQo+IGhiX3NoaTIwMDNAeWFo
b28uY29tOyBXZW4gV2FuZyA8d2Vud0BzaWxpY29tLXVzYS5jb20+DQo+IFN1YmplY3Q6IFJFOiBb
UEFUQ0hdIEFkZCBTaWxpY29tIFBsYXRmb3JtIERyaXZlcg0KPg0KPiBDYXV0aW9uOiBUaGlzIGlz
IGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mg
b3Igb3BlbmluZyBhdHRhY2htZW50cy4NCj4NCj4NCj4gT24gRnJpLCAyOCBKdWwgMjAyMywgSHVp
YmluIFNoaSB3cm90ZToNCj4NCj4+IElscG8sDQo+Pg0KPj4gVGhhbmtzIGZvciB0aGUgY29tbWVu
dHMuIFNlZSBteSBjb21tZW50cyBiZWxvdy4NCj4+DQo+PiBVcGRhdGVkIHBhdGNoIHdpbGwgYmUg
c2VudCBvdXQgbGF0ZXIgYWZ0ZXIgcmV2aWV3IGNvbW1lbnRzIGZyb20gb3RoZXIgcmV2aWV3ZXIg
YXJlIGFkZHJlc3NlZC4NCj4+DQo+PiBIZW5yeQ0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNv
bT4NCj4+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxOSwgMjAyMyA4OjEzIEFNDQo+PiBUbzogSGVu
cnkgU2hpIDxoZW5yeXNoaTIwMThAZ21haWwuY29tPg0KPj4gQ2M6IGhic2hpNjlAaG90bWFpbC5j
b207IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgDQo+PiBicEBhbGllbjgu
ZGU7IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmc7IA0KPj4gaHBh
QHp5dG9yLmNvbTsgaGRlZ29lZGVAcmVkaGF0LmNvbTsgbWFya2dyb3NzQGtlcm5lbC5vcmc7IA0K
Pj4gamRlbHZhcmVAc3VzZS5jb207IGxpbnV4QHJvZWNrLXVzLm5ldDsgTEtNTCANCj4+IDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5l
bC5vcmc7DQo+PiBsaW51eC1od21vbkB2Z2VyLmtlcm5lbC5vcmc7IGhiX3NoaTIwMDNAeWFob28u
Y29tOyBIdWliaW4gU2hpIA0KPj4gPGhlbnJ5c0BzaWxpY29tLXVzYS5jb20+OyBXZW4gV2FuZyA8
d2Vud0BzaWxpY29tLXVzYS5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBBZGQgU2lsaWNv
bSBQbGF0Zm9ybSBEcml2ZXINCj4+DQo+PiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVt
YWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRh
Y2htZW50cy4NCj4+DQo+Pg0KPj4gT24gVHVlLCAxOCBKdWwgMjAyMywgSGVucnkgU2hpIHdyb3Rl
Og0KPj4NCj4+PiBUaGUgU2lsaWNvbSBwbGF0Zm9ybSAoc2lsaWNvbS1wbGF0Zm9ybSkgTGludXgg
ZHJpdmVyIGZvciBTd2lzc2NvbSANCj4+PiBCdXNpbmVzcyBCb3ggKFN3aXNzY29tIEJCKSBhcyB3
ZWxsIGFzIENvcmRvYmEgZmFtaWx5IHByb2R1Y3RzIGlzIGEgDQo+Pj4gc29mdHdhcmUgc29sdXRp
b24gZGVzaWduZWQgdG8gZmFjaWxpdGF0ZSB0aGUgZWZmaWNpZW50IG1hbmFnZW1lbnQgDQo+Pj4g
YW5kIGNvbnRyb2wgb2YgZGV2aWNlcyB0aHJvdWdoIHRoZSBpbnRlZ3JhdGlvbiBvZiB2YXJpb3Vz
IExpbnV4IA0KPj4+IGZyYW1ld29ya3MuIFRoaXMgcGxhdGZvcm0gZHJpdmVyIHByb3ZpZGVzIHNl
YW1sZXNzIHN1cHBvcnQgZm9yIA0KPj4+IGRldmljZSBtYW5hZ2VtZW50IHZpYSB0aGUgTGludXgg
TEVEIGZyYW1ld29yaywgR1BJTyBmcmFtZXdvcmssIA0KPj4+IEhhcmR3YXJlIE1vbml0b3Jpbmcg
KEhXTU9OKSwgYW5kIGRldmljZSBhdHRyaWJ1dGVzLiBUaGUgU2lsaWNvbSANCj4+PiBwbGF0Zm9y
bSBkcml2ZXIncyBjb21wYXRpYmlsaXR5IHdpdGggdGhlc2UgTGludXggZnJhbWV3b3JrcyBhbGxv
d3MgDQo+Pj4gYXBwbGljYXRpb25zIHRvIGFjY2VzcyBhbmQgY29udHJvbCBDb3Jkb2JhIGZhbWls
eSBkZXZpY2VzIHVzaW5nIA0KPj4+IGV4aXN0aW5nIHNvZnR3YXJlIHRoYXQgaXMgY29tcGF0aWJs
ZSB3aXRoIHRoZXNlIGZyYW1ld29ya3MuIFRoaXMgDQo+Pj4gY29tcGF0aWJpbGl0eSBzaW1wbGlm
aWVzIHRoZSBkZXZlbG9wbWVudCBwcm9jZXNzLCByZWR1Y2VzIA0KPj4+IGRlcGVuZGVuY2llcyBv
biBwcm9wcmlldGFyeSBzb2x1dGlvbnMsIGFuZCBwcm9tb3RlcyBpbnRlcm9wZXJhYmlsaXR5IA0K
Pj4+IHdpdGggb3RoZXIgTGludXgtYmFzZWQgc3lzdGVtcyBhbmQgc29mdHdhcmUuDQo+Pj4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBIZW5yeSBTaGkgPGhlbnJ5c2hpMjAxOEBnbWFpbC5jb20+DQo+Pj4g
LS0tDQo+Pj4gICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnICAgICAgICAgICAgfCAgIDEy
ICsNCj4+PiAgIGRyaXZlcnMvcGxhdGZvcm0veDg2L01ha2VmaWxlICAgICAgICAgICB8ICAgIDEg
Kw0KPj4+ICAgZHJpdmVycy9wbGF0Zm9ybS94ODYvc2lsaWNvbS1wbGF0Zm9ybS5jIHwgMTEyMw0K
Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDExMzYg
aW5zZXJ0aW9ucygrKSAgY3JlYXRlIG1vZGUgMTAwNjQ0IA0KPj4+IGRyaXZlcnMvcGxhdGZvcm0v
eDg2L3NpbGljb20tcGxhdGZvcm0uYw0KPj4+DQo+DQo+Pj4gK3ZvaWQgbG9ja19pb19tb2R1bGVz
KHZvaWQpDQo+Pj4gK3sNCj4+PiArICAgICBtdXRleF9sb2NrKCZtZWNfaW9fbXV0ZXgpOw0KPj4+
ICt9DQo+Pj4gK0VYUE9SVF9TWU1CT0wobG9ja19pb19tb2R1bGVzKTsNCj4+PiArDQo+Pj4gK3Zv
aWQgdW5sb2NrX2lvX21vZHVsZXModm9pZCkNCj4+PiArew0KPj4+ICsgICAgIG11dGV4X3VubG9j
aygmbWVjX2lvX211dGV4KTsNCj4+PiArfQ0KPj4+ICtFWFBPUlRfU1lNQk9MKHVubG9ja19pb19t
b2R1bGVzKTsNCj4NCj4gVGhlc2UgYXJlIHVudXNlZC4NCj4NCj4gSGVucnk6IFRoaXMgd2lsbCBi
ZSB1c2VkIGJ5IGFub3RoZXIgU2lsaWNvbSBkcml2ZXIsIHdoaWNoIHNvdXJjZSBjb2RlIGlzIG5v
dCBwdXNoZWQgdG8ga2VybmVsIHJlcG9zaXRvcnkuDQo+DQoNCkJlc2lkZXMsIHRob3NlIGZ1bmN0
aW9uIG5hbWVzIGFyZSBfd2F5XyB0b28gZ2VuZXJpYyBmb3IgcHVibGljIHN5bWJvbHMsIGFuZCBl
dmVuIG1vcmUgc28gZm9yIGV4cG9ydHMuDQoNCkhlbnJ5OiBHb29kIHBvaW50LCB3aWxsIGNoYW5n
ZSB0aGUgZnVuY3Rpb24gbmFtZSB0byBzb21lIHNwZWNpYWwgbmFtZXMgd2hlbiBFWFBPUlQgdGhl
bS4gDQoNCkd1ZW50ZXINCg0K
