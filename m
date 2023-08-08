Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D6E774CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbjHHVVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjHHVVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:21:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2103.outbound.protection.outlook.com [40.107.21.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35204086E;
        Tue,  8 Aug 2023 12:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7K3uh+rSDkP0j8Z7D51GsCRKfBdTtuOU17iOMXvxN3CqMIlRZ1vk8fKWQBY84Dk8JSZVCe06k5bsouprH2hJ8rETzNjjozQGuhrXXLdXL+K9MKRShtHb48WMM7lzjSKm1rXd9xqntG/8M/d1nwcxMBsmvZNU+U58DMXWhttSA1jvtmTvdOkzVHoxfPDgPsgIq7rwhuKDgLGCUpzHZOQBX2fJw1oJ8VDVTqNbxxhJgwtmLt8peNhj7diEAEG/1pc3JZNKpqOEnaI3jLM2PeyjsyKCE3l8xPBLN4136r7Jh4YnViH0SgktBe5A88RMMiuYV4KY56ayFmdOINlGs0szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5PzIMw41x66qfgEp5V5faS3v35RdYcuE8BZsSmIDQc=;
 b=YWExrKLqHt3eqmK3mRaXSvnPAN+ZJoQeEQlzNJGD0l53cen2aBF+rS5c2LWLTd8n76nzJJsyxb2UTWDN2Q3ZfmIDIPqIKJWIafWAe0KY1K2zv8ySJBP/XgWaUKymupzerA0Plw9vCyTroeytOPI0k6H6HnoNupnuAQQQ6YL62bwMdEYxMcrezBr9aCpGjDXsbDPur3ZLUULhV19C49WxGobKtEyqOO/TGkNEXiY+djdkNWHh2o6P2igYu/BiksdnxVzEPWZkCr3ykbdzRufK+r8gceRGBccV1sHD6ZGpx9yBETKv4iZgVFKFIZqbe9l5zGHLx91WnwdFLy+WnLYyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5PzIMw41x66qfgEp5V5faS3v35RdYcuE8BZsSmIDQc=;
 b=nUFAkXzaB3IMHIribnJnZIwP1ifEH+LyMy9jpn2W389xG87jgkBGhjCqoY8wB9xRaJgd5Pz4pd3XsRoDbBwlKj/O0ZPG/6qr3oG8vZ32DX1rM9jO7bBb2at4zZs6IRI4/T+JGwHzRjuPcTvfh2cLDa/MmNIPj4X6IzTWUUs1tR0=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 19:19:43 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6652.022; Tue, 8 Aug 2023
 19:19:43 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Henry Shi <henryshi2018@gmail.com>,
        "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC:     "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver
Thread-Topic: [PATCH] Add Silicom Platform Driver
Thread-Index: AQHZuZEcSTfJXOh+tEO5M8hB8nDqzq/LA4yAgAK8ytCAAYwdgIARmeKg
Date:   Tue, 8 Aug 2023 19:19:43 +0000
Message-ID: <PA4PR04MB922285C2DC1BB0BDBDD602B39A0DA@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <fb62b2e7-7c7c-dc2e-768d-3393f151eb32@wanadoo.fr>
 <PA4PR04MB92225B65A45868A9CBE25B999A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <8686c5c3-81b0-278f-d81b-0c906bac62a8@roeck-us.net>
In-Reply-To: <8686c5c3-81b0-278f-d81b-0c906bac62a8@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|AS4PR04MB9574:EE_
x-ms-office365-filtering-correlation-id: eaacdd1a-115f-4c1a-2c5d-08db98446bbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XzQI/Ngj48crozcHTR7RkGbDNwKjoc2a/hZrIAMJqp2OcVdoidWJtlVPY+ReXNbrCXTDAu6ENSpD4x6sXlx6oawo8IsBi7rUP95U3YdqWAhxyXDw5bnmQtDKxSp0DFOZVZ/F73oOXsqcyNLiMcFb9z//FCLMye/FcArRtcMQvR23EsiNH/uoKNEefAO4Xu4s6znzJMax/U+5+mh+mRxPKSSMr0HDF9+bBllTKE8qKXslX10t+cyrs2Lu2Za3d+KGQAFpt5eP477DH0paAKHIwe5WI32pw9lNER3NzLMOcHDImVX021/5ExpdSz6l/kQpscqDUi1V8dIhDODLcBL/hldxYC1HQIq+20gXC1yIvMYO9l8ohdg1BPVlKTrVQg6EfV/lxHCn/MuIkZgsQ8ThtAGmpOOGBpmJyBR/j9LiAS57ApYBQlUGRFQgtV8ekaoqIzHHQFEnrtCosLlRhqW/2fvnAFeH91RXnYjI50JtpT1+W2LMd/z35KInXBIKXN7/FcVHfKLolW5n5GdjChi8a7U2mQ8N+zCFVLm41he7O1t/PZDUG4sWC7VLdR4X3k0Dul2dBaTW9cRDPuOXfUq95+vomOTthJkpNCel6maLf456w4wSZzaSg1BqbzcfI81zi59ij689NYjGTmDyiQNFQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39850400004)(376002)(346002)(451199021)(186006)(1800799003)(921005)(38100700002)(122000001)(107886003)(86362001)(76116006)(33656002)(55016003)(66446008)(66476007)(38070700005)(4326008)(64756008)(83380400001)(66574015)(5660300002)(6506007)(7696005)(53546011)(9686003)(71200400001)(478600001)(110136005)(45080400002)(54906003)(41300700001)(66946007)(66556008)(316002)(8676002)(8936002)(52536014)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWlhN0NsNFNBdS81bktXa3JsQm1xV3JZME9tdjczSWwybzNaVWY4ajJqVFhN?=
 =?utf-8?B?SlBNMk1hZDdkQVVQeXAzZGl4UGZuTUUwRThza1I2c2JTZzlkWGpxZytkMXdE?=
 =?utf-8?B?MGpUK1BUaFZvNEhBQWh6QVBuY1g0R2JONDM2cGFERlcyMHZSaFVTRjN6Skwx?=
 =?utf-8?B?Y201UythMzh4TEVISFQwQUZib1JaVGU5WG5kcU1QUzJoSk5qMDk2akVNSEp0?=
 =?utf-8?B?WndnZkgyYnhrbGZSWjl5b3ZwYXJScTBSQStDSmtya2RsVVlnRVQ5UXZRVW5M?=
 =?utf-8?B?SW5IQ3BYWG5tZ2VwZ25vKzJYWkFmK2tLRUJDaVl6WUVjQTZNNHBvWDJNTTZi?=
 =?utf-8?B?YzVqQWx2TVIwT1J3L1NNSDA5eEp3YUdZOHlobjRrN0pkZWtWL1ZPSXUrN0tP?=
 =?utf-8?B?bFVpbW1DYmFxYUtWcmtBbnlMNnYwVVVTUytobS9xUkcyL1E1VWxuZkVjeVNG?=
 =?utf-8?B?UGJ0YmdudDRaR3J3TENDVGZqYVNZQ0RJQXhYc2xMazQrYm53a0FMQjh6UUl0?=
 =?utf-8?B?TGNFeTNVQXpuSFFhZFIvZWlOVlNxSzNIZXA0REJQMFNGYzRJV1llczJKdm91?=
 =?utf-8?B?eWRLQnNpakVqWTlxY1RFWXcxdWVMUzBJb3ludGFXeEhzUEpZWHZRNzNYOFpp?=
 =?utf-8?B?VEdRcGYrTTNqa1NxMjkzWmFLcmhBTXg2WERjd3lzT3k1bUlOWE5nZk5jMi9a?=
 =?utf-8?B?TnJDaVkvSi82UTVuWVp1Mk0va25NcnU0MjgwSmVHaHVzNGkwampuVlNCdEY3?=
 =?utf-8?B?UUR4M05iZzlLbVIxUW56cFpkMHRKV05TOGRDRHZybEZJamp0S2dsVjczT2Nr?=
 =?utf-8?B?RVE5aXprTU9wVkkwcFpnU2owUld3K2JPQzZFUVliNmdQZ2NXcmFjM0U2RGhh?=
 =?utf-8?B?ckJvTlVvMjdsUGcvamtSWUk0OWhrb0Vsci9XWVE5V3U4M1EwR2VYZkFDZEVO?=
 =?utf-8?B?T0JQeldCM1dGT3hFVUczRkJjSzRxVWwvM3FqRzRNR3dyQzFQVEdnQWU4UjA0?=
 =?utf-8?B?MHBiT0x3UDcvaDR0RTJFa3VTcDlRU1lrWC9OUVF5eTNjWGRocnhLNi8vWmtC?=
 =?utf-8?B?QUx0L1Ntd2tMdzNwTDMvVkRWaGNRQ3NPWnlMbThTN2MwMDNyMTliQzBSbzJm?=
 =?utf-8?B?VHhOemZLQWRBMTNNZ0VzT0sxekxNSzVHOHBvYVJTUUovLytYc2cybTRFVUZp?=
 =?utf-8?B?M3JhS01FQ0JINVQ3YUFvQnZEWlZjeHM1QjBVREVXZXV1cnpnajEzU3BvZGtK?=
 =?utf-8?B?SUVOaCtUN2RIanp0YXZNZWY3Q1owWjE2eEY2WnFLUU56QlV6bjlZTzdXU2xr?=
 =?utf-8?B?ejgwM3RRbktkbjlzTkhhVlRaMG5PVmE2aUhsUVZPaXYzVkdJOVVtRFdhYWdM?=
 =?utf-8?B?ZXdiSFc5TGpFbmE2Q0Nrbndzamd2c21UcXBlSFV6NWl2eGJOekhQc2JQaDhP?=
 =?utf-8?B?YXJtOHpVdTVOdUErZ1Y4NTI1VmJROXl6b0V2blhBUk9pTUlWRCtQb1pzT3B3?=
 =?utf-8?B?QUlWYmp5SEFXLzRNc2FJcTBuY2RpRUsxY1ZsT1ZTaFRnYW9GMTdub0o3T2hT?=
 =?utf-8?B?bVlTL2paNTg4Z3ZwOHhIb0RmcVNheDhaeWlyNjAwVHRvaDFXc3ZnRThsdUpP?=
 =?utf-8?B?RkVDbVVIRVlIVEhkSEV0UTZrNTdWMVVJZjR0ak5YSmFhdjNvTTFmVmFuVWJv?=
 =?utf-8?B?MVJWYWhaTVB4N2JIWlpYSmpmbCtobEJNMW80aXhMNENDVEQ0ektZSHJ3dzJO?=
 =?utf-8?B?cjdCWlVOaVZiYXhmc0t1YmVGT1k1N2lIM05lUzBDSnpoeGFsSURtcVFlNzZx?=
 =?utf-8?B?ZFFYMnd1b3p4V0R4eG1oMU9tbHN3RFY2UTYxMEtBZTBacE9WdDRXVVZlOGV2?=
 =?utf-8?B?eEpVQmhWRVowUmtvSkNhay9VcGMzMkdKS0tlTnhCN054djAzdE0vUmRKZDhV?=
 =?utf-8?B?UDFiUEdlSC9rbVV6T2w2K29aTldpOVhSVkp4TFNNMWw1cmRIWUNqdjIwb3Bh?=
 =?utf-8?B?UUs5SzBRNUcyQTlHNS8vVzNxK1c3TCtMQ2Radm1wM29mZXdIdmNwdHBKUUxN?=
 =?utf-8?B?c1gzMGlvbGFhU1NVd2padTFSRGUzMGlEV1NLRDdGYnBDeHFGZitvK2RqYlBP?=
 =?utf-8?B?eFFrQjNvRkZHN2dPS1M3ZTJXT3dDNFlMN2ovMGlha3RBS1puNEhMaWpkNFk1?=
 =?utf-8?Q?ylBUiyEFC7x5RUJO47t0QzH8QWtErO0HARflOJ6Gfcbt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaacdd1a-115f-4c1a-2c5d-08db98446bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 19:19:43.5625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsRFEGhfhVcZLZcAQmWtZfmPP0Uc3wqVjIrSJFcl7d3usQ+L6R1yhYjbUEBx7ppn//4EfdwOffi1EINNt84uCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R3VlbnRlciwNCg0KSGVyZSBpcyB0aGUgaW1wbGVtZW50YXRpb24gb2YgIGRldm1fa21lbWR1cCgp
LCAqc3JjIGlzIHRoZSBleHRyYSBhcmd1bWVudA0KDQp2b2lkICpkZXZtX2ttZW1kdXAoc3RydWN0
IGRldmljZSAqZGV2LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBsZW4sIGdmcF90IGdmcCkNCnsN
Cgl2b2lkICpwOw0KDQoJcCA9IGRldm1fa21hbGxvYyhkZXYsIGxlbiwgZ2ZwKTsNCglpZiAocCkN
CgkJbWVtY3B5KHAsIHNyYywgbGVuKTsNCg0KCXJldHVybiBwOw0KfQ0KDQpIZW5yeQ0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEd1ZW50ZXIgUm9lY2sgPGdyb2VjazdAZ21haWwu
Y29tPiBPbiBCZWhhbGYgT2YgR3VlbnRlciBSb2Vjaw0KU2VudDogRnJpZGF5LCBKdWx5IDI4LCAy
MDIzIDEwOjI5IEFNDQpUbzogSHVpYmluIFNoaSA8aGVucnlzQHNpbGljb20tdXNhLmNvbT47IENo
cmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+OyBIZW5yeSBT
aGkgPGhlbnJ5c2hpMjAxOEBnbWFpbC5jb20+OyBoYnNoaTY5QGhvdG1haWwuY29tOyB0Z2x4QGxp
bnV0cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207IGJwQGFsaWVuOC5kZTsgZGF2ZS5oYW5zZW5A
bGludXguaW50ZWwuY29tOyB4ODZAa2VybmVsLm9yZzsgaHBhQHp5dG9yLmNvbTsgaGRlZ29lZGVA
cmVkaGF0LmNvbTsgbWFya2dyb3NzQGtlcm5lbC5vcmc7IGpkZWx2YXJlQHN1c2UuY29tOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVs
Lm9yZzsgbGludXgtaHdtb25Admdlci5rZXJuZWwub3JnDQpDYzogaGJfc2hpMjAwM0B5YWhvby5j
b207IFdlbiBXYW5nIDx3ZW53QHNpbGljb20tdXNhLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hd
IEFkZCBTaWxpY29tIFBsYXRmb3JtIERyaXZlcg0KDQpDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVy
bmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3Blbmlu
ZyBhdHRhY2htZW50cy4NCg0KDQpPbiA3LzI4LzIzIDA1OjU5LCBIdWliaW4gU2hpIHdyb3RlOg0K
PiBDaHJpc3RvcGhlLA0KPg0KPiBUaGFua3MgZm9yIHRoZSBjb21tZW50cy4gU2VlIG15IGNvbW1l
bnRzIGJlbG93Lg0KPg0KPiBVcGRhdGVkIHBhdGNoIHdpbGwgYmUgc2VudCBvdXQgbGF0ZXIgYWZ0
ZXIgcmV2aWV3IGNvbW1lbnRzIGZyb20gb3RoZXIgcmV2aWV3ZXJzIGFyZSBhZGRyZXNzZWQuDQo+
DQo+IEhlbnJ5DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzdG9w
aGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+DQo+IFNlbnQ6IFR1ZXNk
YXksIEp1bHkgMjUsIDIwMjMgNTowMyBQTQ0KPiBUbzogSGVucnkgU2hpIDxoZW5yeXNoaTIwMThA
Z21haWwuY29tPjsgaGJzaGk2OUBob3RtYWlsLmNvbTsgDQo+IHRnbHhAbGludXRyb25peC5kZTsg
bWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRlOyANCj4gZGF2ZS5oYW5zZW5AbGludXguaW50
ZWwuY29tOyB4ODZAa2VybmVsLm9yZzsgaHBhQHp5dG9yLmNvbTsgDQo+IGhkZWdvZWRlQHJlZGhh
dC5jb207IG1hcmtncm9zc0BrZXJuZWwub3JnOyBqZGVsdmFyZUBzdXNlLmNvbTsgDQo+IGxpbnV4
QHJvZWNrLXVzLm5ldDsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgDQo+IHBsYXRmb3Jt
LWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1od21vbkB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IGhiX3NoaTIwMDNAeWFob28uY29tOyBIdWliaW4gU2hpIDxoZW5yeXNAc2lsaWNvbS11
c2EuY29tPjsgV2VuIA0KPiBXYW5nIDx3ZW53QHNpbGljb20tdXNhLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gQWRkIFNpbGljb20gUGxhdGZvcm0gRHJpdmVyDQo+DQo+IENhdXRpb246IFRo
aXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBs
aW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLg0KPg0KPg0KPiBMZSAxOC8wNy8yMDIzIMOgIDE4
OjAxLCBIZW5yeSBTaGkgYSDDqWNyaXQgOg0KPj4gVGhlIFNpbGljb20gcGxhdGZvcm0gKHNpbGlj
b20tcGxhdGZvcm0pIExpbnV4IGRyaXZlciBmb3IgU3dpc3Njb20gDQo+PiBCdXNpbmVzcyBCb3gg
KFN3aXNzY29tIEJCKSBhcyB3ZWxsIGFzIENvcmRvYmEgZmFtaWx5IHByb2R1Y3RzIGlzIGEgDQo+
PiBzb2Z0d2FyZSBzb2x1dGlvbiBkZXNpZ25lZCB0byBmYWNpbGl0YXRlIHRoZSBlZmZpY2llbnQg
bWFuYWdlbWVudCBhbmQgDQo+PiBjb250cm9sIG9mIGRldmljZXMgdGhyb3VnaCB0aGUgaW50ZWdy
YXRpb24gb2YgdmFyaW91cyBMaW51eCANCj4+IGZyYW1ld29ya3MuIFRoaXMgcGxhdGZvcm0gZHJp
dmVyIHByb3ZpZGVzIHNlYW1sZXNzIHN1cHBvcnQgZm9yIGRldmljZSANCj4+IG1hbmFnZW1lbnQg
dmlhIHRoZSBMaW51eCBMRUQgZnJhbWV3b3JrLCBHUElPIGZyYW1ld29yaywgSGFyZHdhcmUgDQo+
PiBNb25pdG9yaW5nIChIV01PTiksIGFuZCBkZXZpY2UgYXR0cmlidXRlcy4gVGhlIFNpbGljb20g
cGxhdGZvcm0gDQo+PiBkcml2ZXIncyBjb21wYXRpYmlsaXR5IHdpdGggdGhlc2UgTGludXggZnJh
bWV3b3JrcyBhbGxvd3MgDQo+PiBhcHBsaWNhdGlvbnMgdG8gYWNjZXNzIGFuZCBjb250cm9sIENv
cmRvYmEgZmFtaWx5IGRldmljZXMgdXNpbmcgDQo+PiBleGlzdGluZyBzb2Z0d2FyZSB0aGF0IGlz
IGNvbXBhdGlibGUgd2l0aCB0aGVzZSBmcmFtZXdvcmtzLiBUaGlzIA0KPj4gY29tcGF0aWJpbGl0
eSBzaW1wbGlmaWVzIHRoZSBkZXZlbG9wbWVudCBwcm9jZXNzLCByZWR1Y2VzIA0KPj4gZGVwZW5k
ZW5jaWVzIG9uIHByb3ByaWV0YXJ5IHNvbHV0aW9ucywgYW5kIHByb21vdGVzIGludGVyb3BlcmFi
aWxpdHkgDQo+PiB3aXRoIG90aGVyIExpbnV4LWJhc2VkIHN5c3RlbXMgYW5kIHNvZnR3YXJlLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IEhlbnJ5IFNoaSA8aGVucnlzaGkyMDE4QGdtYWlsLmNvbT4N
Cj4+IC0tLQ0KPg0KPiBbLi4uXQ0KPg0KPj4gK3N0YXRpYyBpbnQgX19pbml0IHNpbGljb21fbWNf
bGVkc19yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBsZWRfY2xhc3NkZXZfbWMNCj4+ICsq
bWNfbGVkcykgew0KPj4gKyAgICAgc3RydWN0IGxlZF9jbGFzc2Rldl9tYyAqbGVkOw0KPj4gKyAg
ICAgaW50IGksIGVycjsNCj4+ICsNCj4+ICsgICAgIGZvciAoaSA9IDA7IG1jX2xlZHNbaV0ubGVk
X2NkZXYubmFtZTsgaSsrKSB7DQo+PiArICAgICAgICAgICAgIC8qIGFsbG9jYXRlIGFuZCBjb3B5
IGRhdGEgZnJvbSB0aGUgaW5pdCBjb25zdGFuc3RzICovDQo+PiArICAgICAgICAgICAgIGxlZCA9
IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZihzdHJ1Y3QgbGVkX2NsYXNzZGV2X21jKSwgDQo+PiAr
IEdGUF9LRVJORUwpOw0KPg0KPiBzaXplb2YoKmxlZCkgaXMgc2hvcnRlci4NCj4gTW9zdGx5IGEg
bWF0dGVyIG9mIHRhc3RlLg0KPg0KPiBNYXliZSBldmVuIGRldm1fa21lbWR1cCgpPw0KPg0KPiBI
ZW5yeTogdGhhbmtzLiBEZXZtX2ttZW1kdXAoKSBBUEkgcmVxdWlyZXMgYWRkaXRpb25hbCBhcmd1
bWVudCB0aGF0IGlzIG5vdCBuZWNlc3Nhcnkgb2YgdGhpcyBkcml2ZXIuIEkgcHJlZmVyIGRldm1f
a3phbGxvYyBmb3Igbm93Lg0KPg0KDQpJIGFtIGN1cmlvdXM6IFdoYXQgd291bGQgdGhhdCBhZGRp
dGlvbmFsIGFyZ3VtZW50IGJlID8NCg0KR3VlbnRlcg0KDQo=
