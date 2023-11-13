Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069BA7EA1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjKMRfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjKMRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:35:34 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43AD10E5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:35:23 -0800 (PST)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADFhaA6023357;
        Mon, 13 Nov 2023 17:35:14 GMT
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02lp2041.outbound.protection.outlook.com [104.47.11.41])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ubpk98fw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 17:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah3HkxcEToNoneCuziNDnwbuTMcgqGUdcSXzvGKLcTNpIffVyo5KZAkHnWZfJN8A8tUYqn+BHRdtp2KV7A+mKnY/WkyQQtLcJgkF7f+vL2/qDmCjIgFOXSiMs17SguICEFVtxnDDBP1ZudSoJhQW+hfcoHvc3waI+rwo5Z50+ZD7bScuS8TJDZ/LhS/Oe05+RVdu9hk9M8Vsba4Nv4gUo/2D1oAwufvkHpwtF3cV/pkEAHQYKKyR4yZKcojkVmKA0BuX31eEoOJxLDDYj1bZXEkEcLKAUliBL8hSRhoaBbkqusbSY7TNHN0GX22i9ADR6TNTEBv5W6J7t7yCxGaBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU1ZBET48SFJ5Db+KERuoW8LzvKxMjzZ5Erc4wFI+RY=;
 b=Puy5RkpwNed1CivZi4JVlw4ZQfSccnulGg63E/eQuWM/+CA3T29MWZwyzksnMJJVjDW26f24nTK3KKOyHcBLhGqJNDjBUv6VKdfGyMLZPErVtjh7xP7Yae+QZOzP95yd1AbxamHBIjuUMTRhzrU561WY+oepMoIY3wWv14oWEXbVWc+IvLNq6fbwU+bV+S0uUK7wXaLPCt+tp4Jl+P/3s/7pqcEW1Y8VbuUuKMKhmQzy4M/2VSE8fBEnVxV1ozTXj8oG1g1GAxt+BKWPi749Xgw9GMOKa904GT7+9PRSqD85gGnqqLx4Dt/PDyrGt9onaiOu8AKt/OrTRrcxI4DGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU1ZBET48SFJ5Db+KERuoW8LzvKxMjzZ5Erc4wFI+RY=;
 b=c4IMAcjUtc/Mww0v+WVuDHN+Hybywk6svimQ/9L6ifl06fsL8PrYR5ebx+V5LvUVa3A07uPnaAqFUaVpY7ZTs5g1VbKxSUM3xSd3HF5mMxJZ2OY2ti9d0P0TRLU+MoPcvCRC8o360xin0iFTZ8I06TxC6uZ69MbWNr3DH4WKbxZu0ey6zBkVoxheiRVDqrylUFRF1fl7hPcPt3PeaJOxE8NHItJv57T+9iyhpojeRTacl62opmjnjdCeQtUpK6Jh1JaKSnhFV6QGtNl+zgorYcAs/R7uoXbB8lXta3NyaY7KoxkxL5t+vbHHPNTnUev+YMv9whfrawxUbhnQy1WbHw==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AS8PR03MB7158.eurprd03.prod.outlook.com (2603:10a6:20b:2e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 17:35:09 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:35:09 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 4/7] xen/events: remove some simple helpers from
 events_base.c
Thread-Topic: [PATCH 4/7] xen/events: remove some simple helpers from
 events_base.c
Thread-Index: AQHZ//oOreX4qMNCvEGaw1AG2hRTp7B4r4qA
Date:   Mon, 13 Nov 2023 17:35:09 +0000
Message-ID: <b7b705e6-584b-4655-b005-521be3f23c1e@epam.com>
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-5-jgross@suse.com>
In-Reply-To: <20231016062831.20630-5-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AS8PR03MB7158:EE_
x-ms-office365-filtering-correlation-id: e013b2bf-45e7-41f1-e6be-08dbe46ee25f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owJeuCHkoSWd1mqtIpbfL6Elv3kqS+o5v1qXMEYowkh/ceOdBlcN5LJ4/yQ7zi7OR7vE4DAFZyCg5pV3XGIfHqMCKuwy4lfe6rj4QibSV/WCWUwcV1pD89BTlEBttcXSvvDmj6wmOkx6nTGpJaTaT8cwdz+OleceJymf7z6waKHqtKKGRYsoAxAzT+nqZpiZ2IgwL7U8zT24ZQWLaCeanTSx13g96et5/CMXv956O8GNFutdpD/q3Um4ExfE4v+A16Mxnun4DLGXib0ukvmSoLqls30CvedZW1O20h4k+UFW3zgPnu6go3MUd5pMtWANvEi/XHI93Lz089YW2Cbk3pN2H2fWOGTzIg0xFRd/7c2pKkiZDeLXT82b6ZhcQ0wQrtkjmf8ARTZSUID+hb2q3EKYtciYc8xhXSsDVCpcShGbINLXwxn1HF4Rxv9XKNg6XXAXBg6T0GYq+D80YAYtUjqNEZGGtKd64iyRRN9EpuMngA/85s+u718pAOv7Jx0qeEwQfKkKwo9C1jObL+C4OiMRyxtIfPyqUel18AZsniiK2JgFplpXvDGHYMpv4o2RJro0wMy43Prk0HMjenhzT1Y+2ZOnZXOg8YCKYEpUh9lLVzo53F6Z1N7dJKMnZ1tvs9X/Wimc9Lw3cFEOYp0+fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(71200400001)(6506007)(55236004)(478600001)(86362001)(31696002)(26005)(2616005)(6512007)(64756008)(54906003)(66446008)(316002)(66946007)(66476007)(76116006)(6486002)(122000001)(53546011)(38100700002)(83380400001)(5660300002)(38070700009)(8936002)(36756003)(8676002)(4326008)(66556008)(41300700001)(110136005)(91956017)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVRzVWZvUDNXWFh5ZGVLeDE5Q3lXd1FhRkdxY0J5T3k1Y3JnYkJ2aVM1VTZT?=
 =?utf-8?B?MFJ2WkVkOHN4U2VteVFsMXNVS3hDVW1yejBoak5QYlFLc1ZaZENNZFNXMDh4?=
 =?utf-8?B?RTh3VzZrMk90N2NBT1RDZ0FCaGpJQ2s4cFRWdzk0YUsrMWYweWhoeUs2aFlX?=
 =?utf-8?B?K3VxNnJQKy9NWGQrZ2FlckpmREV4Unh6ZkNSRWFyVk1aWklhZkJSOGVTQUEv?=
 =?utf-8?B?R2ZZL0hwYkhHZWZWZ3dRVUw4RWlCZjFESmlWN1YvRXdPRVZvWFA5aGVDQjZL?=
 =?utf-8?B?MnJDeGtnQjlhSlY2eU1oMERVcmMwTGgrWVFZV3E5QndUdW1rK0g0cXNVTWU2?=
 =?utf-8?B?RlFtcDd5YUtpSHpjYUNKaE15TWwvbmRzNEFDVlhZOUlzYTRDbmVoOEJDdHd6?=
 =?utf-8?B?M1QrWTVKc0RiOVlOMkVibnlyRUhkci9OVkxwYjZuUlJNeVlSNit5UHpzaG5o?=
 =?utf-8?B?U1dNcExrS1d1YkFjL3FqZStERXJaeEh3eDZkblpodEdUa2s3Y0t6RDNkWkhU?=
 =?utf-8?B?WWRiYitRRjFiZGNvUlYyYzZLbDRxU2FVMXdKaHh6WkkyejJGRUdKTE41d1Qx?=
 =?utf-8?B?L21kRWFkVjA5dmN6VUlsOVlLdmo5WG91Zjc0M0Q1dkZybEZUVXV1UGhkY0o1?=
 =?utf-8?B?RFdMMG85aFJXOXE0bWNnYWwzYXQ1Qm5PYS9KQkVaVitsTkxkcktCQzk0VEpU?=
 =?utf-8?B?WjFFUzM5THh6UWNWcE12N3U0VFVxM3ZPbWViVWd5Q0NjSnJyRDBZeHhUclNo?=
 =?utf-8?B?R0JkZUdvNm4wb0FyL1MwMGM5NU0yQlNseXVFMEtKTWNBS3lFelpIakRheDVx?=
 =?utf-8?B?ZGUrQTNHYURKVXg3NmRRaStDSHpDQnZRdWNyQWtPd1M0TytxT2pPMzBzOW84?=
 =?utf-8?B?SHcweWplbU1nWXFSMkVrdW1TV00xQWhUTW1jMk5UZnBob3E1V2ZNblExaFhj?=
 =?utf-8?B?d3RiYzVCcy9hODdnQUc4RWtrVFFOYW9XQTFmRDYySkxvMU5qVDFvRFIzSUxD?=
 =?utf-8?B?azczOU1qWGRMU3l0S0M2UWVUR0ZHa0pobFZDL2M1Q0xSQVJnaE1hSk96SWVW?=
 =?utf-8?B?LzdOeWlZejg3cEhIWSs1dzFvb05Qc1oydTFEcTVRZ1h4SmpYYjZSenNsUjEr?=
 =?utf-8?B?WVBsQ1l1NUI5UDJrd0g0VTJGVGx5SmxOUFVQNXRkcEdjTDdjdGlaMkhLT1lN?=
 =?utf-8?B?UGxzdG9VQnFubTVzUTNWcTAwUkJFSVNkdER3YzQ5Ri8vVld0aW1ubFZFVnla?=
 =?utf-8?B?Z0hQbkNGelVBZ2dwVlRvWGtPWUVUT1FEOGt2U05maW1xZTE5NW5XYVplTnVN?=
 =?utf-8?B?UjFvakhSMVZVOUh5bDFuclcvOUxNUlNqdWFGczdJK3RaNzVkUHNPemRXSHVN?=
 =?utf-8?B?NEVJeWlJY1RmVkRGUjgrWGV5SSt1aFlYRzQ0K3BpWlVsTFUyV3h0dFRsR3pu?=
 =?utf-8?B?YWJrYjJMUmh1elRUcHg4MU5PVko1SXdZNXp5aklRUXFlZW9lajBzVUdnMEc0?=
 =?utf-8?B?TUJ0N2hKcWxjZitiOHRsaXZPUGtETUtTV2dRN0RlU3BiM0doYzJ6Tm1EVGdD?=
 =?utf-8?B?SEM1NVpkZFlWZGt1WjJRZmZDYXRTbERUemJkemRybkgrQTF1L3hkR3BqeG0v?=
 =?utf-8?B?Y3NBdTNMQnZQQ2MyQTkxVmRZU0l0dVBJUUNxLzA4SGp1WjhaNmJaQnVWVFZw?=
 =?utf-8?B?dmpudU42UjdMTlA1K25KOXpkdTVWM0lXa0NPY0syYkdOcW1jUncyMXdqQ2Qv?=
 =?utf-8?B?Q2RuQjU1VjhVZW1UVWNSdlhHZU1xNUdIMHF2NlZPQzBtWFVXdk9ucWxWV3BO?=
 =?utf-8?B?WVhTZmp6NHVENFhrc2ZMcmxYRThmQ2pXWmxET2xxTDBrcURPUTFBaFJvanVh?=
 =?utf-8?B?RmlEVzBsbHpnN0M4SnJGazhSSU9MN2xCN3pneFhhd3BGWUxYUWpRaVZ6UmFu?=
 =?utf-8?B?Um1pMDZES1lXdDdxNlJnUS9yVkVZZGEvVG1QOTV2YWMyLzl3cFJkY1QxTkkz?=
 =?utf-8?B?dFJaemd3akJGNmJmNW9KSE44NmZXNVdzOXdVMERZS1puRkJGNVVjc3ZVNFZm?=
 =?utf-8?B?WmpwZDdrR2Vyd0pOQ1lDcVo1NDBEZUJQYjZmYys0d0Y0V0hHL0hUNjJyUlJV?=
 =?utf-8?B?OWpqV2Y3RHFzcnoyYkFzV2ZRU2Q4dlB5WGdhYWNJU0RGYWkyaTZUcjl2QjNK?=
 =?utf-8?Q?HZBLUxB4zPY6ZmxnfKOMuB8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02E67458139905438076719A159031E5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e013b2bf-45e7-41f1-e6be-08dbe46ee25f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 17:35:09.8389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzziA3S2tzRaeG6Nzzj4J0m9Tw1CKYwSsPpqLSuNEQq3w26ijwAxZ1kcCwkxsPuvXeSihPLacdSazoUj1KKqOihUe98cRlrGwu5TmH+feVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7158
X-Proofpoint-GUID: a0-sGOMgxNEpvUUQrCcTCK4an-qkbWDU
X-Proofpoint-ORIG-GUID: a0-sGOMgxNEpvUUQrCcTCK4an-qkbWDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_07,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=706 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE2LjEwLjIzIDA5OjI4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQoNCkhlbGxvIEp1
ZXJnZW4uDQoNCg0KPiBUaGUgaGVscGVyIGZ1bmN0aW9ucyB0eXBlX2Zyb21faXJxKCkgYW5kIGNw
dV9mcm9tX2lycSgpIGFyZSBqdXN0IG9uZQ0KPiBsaW5lIGZ1bmN0aW9ucyB1c2VkIG9ubHkgaW50
ZXJuYWxseS4NCj4gDQo+IE9wZW4gY29kZSB0aGVtIHdoZXJlIG5lZWRlZC4gQXQgdGhlIHNhbWUg
dGltZSBtb2RpZnkgYW5kIHJlbmFtZQ0KPiBnZXRfZXZ0Y2huX3RvX2lycSgpIHRvIHJldHVybiBh
IHN0cnVjdCBpcnFfaW5mbyBpbnN0ZWFkIG9mIHRoZSBJUlENCj4gbnVtYmVyLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCg0KW3NuaXBd
DQoNCg0KDQo+IA0KPiBAQCAtMTE4MSwxNSArMTE3MiwxNiBAQCBzdGF0aWMgaW50IGJpbmRfZXZ0
Y2huX3RvX2lycV9jaGlwKGV2dGNobl9wb3J0X3QgZXZ0Y2huLCBzdHJ1Y3QgaXJxX2NoaXAgKmNo
aXAsDQo+ICAgew0KPiAgIAlpbnQgaXJxOw0KPiAgIAlpbnQgcmV0Ow0KPiArCXN0cnVjdCBpcnFf
aW5mbyAqaW5mbzsNCj4gICANCj4gICAJaWYgKGV2dGNobiA+PSB4ZW5fZXZ0Y2huX21heF9jaGFu
bmVscygpKQ0KPiAgIAkJcmV0dXJuIC1FTk9NRU07DQoNCg0KSSBhc3N1bWUgdGhpcyBjaGVjayBp
cyBjYWxsZWQgaGVyZSAoKmJlZm9yZSogaG9sZGluZyBhIGxvY2spIGJ5IA0KaW50ZW50aW9uLCBh
cyBldnRjaG5fdG9faW5mbygpIGJlbG93IGNvbnRhaW5zIHRoZSBzYW1lIGNoZWNrLg0KDQo+ICAg
DQo+ICAgCW11dGV4X2xvY2soJmlycV9tYXBwaW5nX3VwZGF0ZV9sb2NrKTsNCj4gICANCj4gLQlp
cnEgPSBnZXRfZXZ0Y2huX3RvX2lycShldnRjaG4pOw0KPiArCWluZm8gPSBldnRjaG5fdG9faW5m
byhldnRjaG4pID4NCj4gLQlpZiAoaXJxID09IC0xKSB7DQo+ICsJaWYgKCFpbmZvKSB7DQo+ICAg
CQlpcnEgPSB4ZW5fYWxsb2NhdGVfaXJxX2R5bmFtaWMoKTsNCj4gICAJCWlmIChpcnEgPCAwKQ0K
PiAgIAkJCWdvdG8gb3V0Ow0KPiBAQCAtMTIxMiw4ICsxMjA0LDggQEAgc3RhdGljIGludCBiaW5k
X2V2dGNobl90b19pcnFfY2hpcChldnRjaG5fcG9ydF90IGV2dGNobiwgc3RydWN0IGlycV9jaGlw
ICpjaGlwLA0KPiAgIAkJICovDQo+ICAgCQliaW5kX2V2dGNobl90b19jcHUoZXZ0Y2huLCAwLCBm
YWxzZSk7DQo+ICAgCX0gZWxzZSB7DQo+IC0JCXN0cnVjdCBpcnFfaW5mbyAqaW5mbyA9IGluZm9f
Zm9yX2lycShpcnEpOw0KPiAtCQlXQVJOX09OKGluZm8gPT0gTlVMTCB8fCBpbmZvLT50eXBlICE9
IElSUVRfRVZUQ0hOKTsNCj4gKwkJV0FSTl9PTihpbmZvLT50eXBlICE9IElSUVRfRVZUQ0hOKTsN
Cj4gKwkJaXJxID0gaW5mby0+aXJxOw0KPiAgIAl9DQoNCg0KVGhpcyBodW5rIGRvZXNuJ3QgYXBw
bHkgY2xlYXJseSB0byB0aGUgbGF0ZXN0IHN0YXRlLCBiZWNhdXNlIG9mIA0KIjllOTBlNThjMTFi
NyB4ZW46IGV2dGNobjogQWxsb3cgc2hhcmVkIHJlZ2lzdHJhdGlvbiBvZiBJUlEgaGFuZGVycyIg
DQp3ZW50IGluLiBQbGVhc2UgcmViYXNlLg0KDQoNCldpdGggdGhhdDoNClJldmlld2VkLWJ5OiBP
bGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+DQoNCg0K
QWxzbyBjaGVja3BhdGNoLnBsIHdhcm5zIGFib3V0IEJVR19PTiB1c2FnZSBpbiBzZXZlcmFsIHBs
YWNlcywgYnV0IGFnYWluIA0KeW91IGRpZG4ndCBpbnRyb2R1Y2UgdGhlbSBpbiBjdXJyZW50IHBh
dGNoLCBqdXN0IHRvdWNoZWQgdGhlaXIgYXJncy4NCg0KDQpbc25pcF0=
