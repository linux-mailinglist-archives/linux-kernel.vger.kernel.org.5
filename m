Return-Path: <linux-kernel+bounces-13961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C44821607
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 01:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E04F281AC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 00:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FD0EBC;
	Tue,  2 Jan 2024 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b="JJEnUKnu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2110.outbound.protection.outlook.com [40.107.104.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86811650;
	Tue,  2 Jan 2024 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dektech.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKWM7NIskJeXtGFHw7XPoYmioJT7yzG1RVauNmKp0U9LS9sViNY7lUx5SzQjx7m9we76+3HURq5q9pqJtXpPs7I1tcyZVZQVMO3cxEhjfGQb+WPfIm3kfClmZaz+lvcWM6ybPaoYRAEdo+xDGcc6iqV5xFr0L/69mG6HFAhm6tLzJAR/EpMRWq2wndG0ErXb3qwpRHk286wSxrJC19EYkoD9/QCdZi/if0sguOmub43i9mNevNZdKcZqjCX6s+xuIYOSjGr9K6hZlvGnMrkHex4yJYOMwL93ZdaIFVU4H4rgd52TOUiDimrTwRWKew7H9oAPTQatCthAYm+JCfaNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhSQMTQ3nX3uKh5gVZiJIIPV8j3tjfhDGnS6lpmuj0M=;
 b=MlINltLEd/0qQbZ6sPBEZHX3sj6T16WmBNQmxk35qbHzqJ3YGe5pnjtIp0Ibj4B/iGwnINa4wQCb90oLZltztnLikhVU2crvNxMgmECsfKsMHh/pUu+fUwJl8Kzcl7hEY7K7kA67DuuI250cWIbFhFooaN7h/q15VcgdNJPh0huNM3b0F0AAH+19CDk74QzJ+5qw6gAxz+eI0KkZZl/+uxKtrmHaaUq/zW29cshPke9fotUKTIa99WgntJ2VfYZftaVarbhTZSt5u5pJ0qNDljrnkTk/UGQkyC8WKoibFBt1OdEZTYh/CXxlu3tSZ3/+ZKfG8f3Bvphz/McHdSlEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhSQMTQ3nX3uKh5gVZiJIIPV8j3tjfhDGnS6lpmuj0M=;
 b=JJEnUKnuYxQEnJ0SgU2dG0PXKUlOPXQ5p5A4IgB2DG5w9UhEGTaiDIb+nLlZVD+8rNxAen628Od7mhKRDBLKcFRsExC21bpCkA9O5iSHyrj5RCBSldDTOLI5X6YDU3iZC5ZeKyvQngoYiUkg1Ce+bBHGJk16h22sWOTB/ZrloR6/YVxEsRPj6LMmOeOsaQ0Ykpkdh+Nee5Oq/O8rXiqjmlUQQ7gm9KTQ4W9CUF/RRQAgBlVeNnCpWxSnU9ueS1Lt5TWLh/309n7/0FTdnC7jB7GByYSQAvcwZsmN4ECKixtcT49pOsvPbMfLSrSUqFjcbeoxPUjtCRk1ZOyaYQkVuw==
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com (2603:10a6:20b:4ce::15)
 by AM9PR05MB8648.eurprd05.prod.outlook.com (2603:10a6:20b:417::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 00:28:02 +0000
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::2d3d:dc33:a72a:4965]) by AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::2d3d:dc33:a72a:4965%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 00:28:01 +0000
From: Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To: Markus Elfring <Markus.Elfring@web.de>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jon
 Maloy <jmaloy@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ying Xue
	<ying.xue@windriver.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tipc: Improve exception handling in tipc_bcast_init()
Thread-Topic: [PATCH] tipc: Improve exception handling in tipc_bcast_init()
Thread-Index: AQHaO9zk5SqfXgYu3ky6g/dZNAXxBbDFrD8Q
Date: Tue, 2 Jan 2024 00:28:01 +0000
Message-ID:
 <AS4PR05MB9647A320CA0474724147F99C8861A@AS4PR05MB9647.eurprd05.prod.outlook.com>
References: <b9646b4a-61a2-41fb-8fea-ba63e08996f3@web.de>
In-Reply-To: <b9646b4a-61a2-41fb-8fea-ba63e08996f3@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR05MB9647:EE_|AM9PR05MB8648:EE_
x-ms-office365-filtering-correlation-id: ab3428cc-2dc7-4540-360e-08dc0b29add4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 613FPlqGl0XXBknAVL1RE8yOIhSuLmVGd4TPkzjriU33HTmpenUoHC/7XQkUv2xXvAIyjoHovGNw/T+6X9s0HXoUMaBcV2bU1k2OKlyWarGfYnTh5Jh5Nc5fXG5XHoutkpZXgzrNXF/ZyXCFijiW52FjTMSQR4d9Muohrrm0jrHoKvY5lQAzvwqXfeM610WYSOm/4sqZNvgLKiUiOwYPlHy60lZBBQnxumf8mYjSIWYDixdEv354rtSNbcGY8Mg/hkb9bgULFCxHSE4Nv8iFhHIBkCDJ/jj+FXoNGZQlCxeJNTPIxnvkLT2YiO2FCDnyeRVR8gWOLSi7IFbpI4f/PjsRpV4hqnpRHT6cbo5bZFQG61HPMyN4lUbdefqjWGrXMsnphMCiLkEhPtwYD3rwsd+xohKSbyQ5xMhmZPmyxXtEk3EaVU28RPYDifEgAH+f/4vAWcuZpySAp7LIMLtzwFSo16QovUmZPk/6ko2QoThjbv0ZlW+2iatrzcXWJ+fzBv03xnWd97hX8XpKEJtSmWALtsJBBxPQ/bAA7EwA7FbxpGDd47Hl/aKDDqM2SXlzSsHNP7Hki93r1VfEOVuK2UPKhlWJfzvzJ+RTzRnhTj8g2T/RkO3SmmqzBdd2iXHbOSvccJbz0nLh0S+1lyYGXQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR05MB9647.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39840400004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(76116006)(64756008)(66446008)(66476007)(66556008)(4326008)(52536014)(66946007)(316002)(110136005)(8936002)(8676002)(83380400001)(478600001)(71200400001)(9686003)(6506007)(7696005)(5660300002)(4744005)(7416002)(2906002)(41300700001)(33656002)(38070700009)(921011)(122000001)(38100700002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHZJS0VsME1xRkNPODJqdUVnUmJlNEIzZUxkdEVTa2Q4ZCtBUm5yYjVHeGRh?=
 =?utf-8?B?N1ZXQkRJSVdkT280d3d3dTFjNVNxL0R5a2FNTzZsVUtxZzlGbStmcjh1NTVp?=
 =?utf-8?B?Z1l1WEI2QWY5bXhYK0RUTUUrTXA5MlVyZkFkL0J1dWgrY2ZURkpxakZlV3ZV?=
 =?utf-8?B?UVAzRHpUaTBSbHpZa3BhUEY4WXljZGpTbmZlUWhDdzc4ZXBFTVJ2clA5d1Ix?=
 =?utf-8?B?VnZBT0lXUVhyT0tTU29LNDBvMmxCVmFrMk0zSUQwK0Jub3ZYdU1jZEhuTlRq?=
 =?utf-8?B?TnZLeGc5Skh0bGdVY3ZlVDdTQ255ZWtLTU9aaDRxblFrTjVxMzhNa1oveElV?=
 =?utf-8?B?eXR6bURwMm9GYmlEeXlXWVY2N2JHd3dLVmhFWk52bzdHRnlZRHNtZkhzSUE2?=
 =?utf-8?B?Z05oZFVKaFhHZzF6QTVIcGVpck5hcnlRc09MMWgzS01YUXE4MDd5LzJqNS81?=
 =?utf-8?B?ZzBJQWpad09ibjE0YUI3SVJsdFZzOGliOWFPZGF0K2xrVmpBTmJRYk5QSzNZ?=
 =?utf-8?B?ZEVydVJvYjZKVmxYZDJLWkVPcERackJnNXQ2Ni8rOXNTWmpBYWpKVm1UZ2Ri?=
 =?utf-8?B?Q1o1SGxiSjZjMGtWN0oxdEplQ0ZBN05IK0JaWUdiTE14K0ZXMFdXdVBOQ2Mr?=
 =?utf-8?B?TnBZdllkZFJkZExqMTJQY05DRWZwMTBMZG1CQlpyZldwbm9PeVFpNHpFMmZR?=
 =?utf-8?B?T0lCQ3dkLzNZUzZwSE95WlhXUTR1T1JtaEJYU3NtQjFTUkNGbDhpM2w4Ym1z?=
 =?utf-8?B?TXQvbmEzdFRRNnVEK2dsT0xPV3JxWnFWRTZMQmNGOEU2eHFmTmVGeEhuelVY?=
 =?utf-8?B?aVdEZmkyQnNJWUlpcnRITTZLc0tXb090dk5aSWcxUjV2UnhkOWNhRUZ4RDAw?=
 =?utf-8?B?Y1hyUXhDL2FyN3dvTjNKbWYrZGxQc25ZbEoybDRqZVgzZjJnRkdMKys2ZjlR?=
 =?utf-8?B?S0JiQWJWbWI3cHBpR0R5bkJYeXVVUm84amIyRXRhRUlnYUhiT0Z6YXJXTXRO?=
 =?utf-8?B?ek1YbDU3VVo0RndYS3FNMFZ4K0dtZkduWjJteThhcmxtbEtFejE1UFlKMGRo?=
 =?utf-8?B?aUppK0N6UDRtMHpaSklQT1lTeDRvRy9MdnpJSURNVHVBaDltMUNNTkdNZzNE?=
 =?utf-8?B?ME9UdDhaZUZjL0h6TVVyME5lbUM1WkpMNldkdjNtQ0g5K1AyMWtIRi96YlB4?=
 =?utf-8?B?REUyVmYyWkdLREVIMFBvUnM3MUE5OFVXM3VHRkk3Sy9qV1YzdHNuRkNFdDRw?=
 =?utf-8?B?SUhJMXYzRlV5VlNYUWpZcGV6Y3l1YVZJSHA0Nlg4bHdPMC82QjF1RjBpc25D?=
 =?utf-8?B?N21HL0lKNlVOVWZjZXMvbENGNTc1THNoR1FxMTJ4SVV1Nm16VWhTanFHZTZp?=
 =?utf-8?B?cjJubnVKZUdoaUlKeCtNbExsa2FwU252TnZod2JTOGRLRXdIQUNnSlBoa3JJ?=
 =?utf-8?B?dkU0aDc4aE1FQ3dyR2tUZUE2VHNjZEp1Zm0vcUZHMng2WkdHRmFaUEd5SFBq?=
 =?utf-8?B?TlJaeTA4TExzZUFXKzNJVVM4M1IwQitOUS9zclMzbmY0UjltY2VuNkhjYXZW?=
 =?utf-8?B?ZFZDaUMzZWpSbXVocFkyN0p6S29ONTBSRS91R3MxYk5sVFBUQ245Nnp3cUI5?=
 =?utf-8?B?VVlEeTlUc2ltRUJIN3BXV0diWkhRNnNHaVg5VUJtVVcxZ1NHL3g1NnNpRTBR?=
 =?utf-8?B?ODVsLyttTzRDcjdJak0wZWdUMWt5Z2VRWXdwVG9sTDR1Z2tHR0RMTk1SaHhp?=
 =?utf-8?B?b2FNQUViTDdIeEtwSVIxeEpSM1dLUVc5WG10NlNsMmxXcVhHa2hRZ2ozcHlu?=
 =?utf-8?B?aU11QVR5RVNLSlhJRVhrNnZKSGRWWC9ZUW9nNTJOUStxVmJzMUJRSmtpRUdh?=
 =?utf-8?B?eHJGNWJ6dlVIVldObGJoeHJ1RDd6QjVHb1ZaMUFmc0dtaUgzVCttcXhxWXNI?=
 =?utf-8?B?YUtaamRsRWRnbElLWUlYOEdIckNRVG9OWFViVVEzOEJjUjh4NlBoUHdWckJj?=
 =?utf-8?B?ZW8wV2xaaWxrZ3RiV2FyZFhtUTZZWmhqMFBLNThCc1NtWFVaMVdCVG9Qd3pk?=
 =?utf-8?B?M2x5SytOTUxHTWJ6NUpFNGt5RFkvelp6amlmMlVyU21wazVTOEZEbmw2dERk?=
 =?utf-8?B?U3FvckpwR3RSdGR1eFp4UlpQcE9NU2dHS2dEZ0U3enRTS21mMy8yK2xsSGRo?=
 =?utf-8?B?TFMzVndROHp3RmRHcm5Bbis3YUZvYmJyUkhpRHhOVS80YUFHeUNDR1hPU1hu?=
 =?utf-8?B?UFhZbXUvalRkSkwrY2VyTmhtbHpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR05MB9647.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3428cc-2dc7-4540-360e-08dc0b29add4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 00:28:01.7526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0Lo3O0fZ1nyeFP7rzt4YAUGyZ5TDi5gy4zSrrdOnW+FbdFY598LFezYE/1WucjWdpx7UXTG/XGLNAI2GAmr4da5sfEu90yAv0jG9rQZ0Ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB8648

PlN1YmplY3Q6IFtQQVRDSF0gdGlwYzogSW1wcm92ZSBleGNlcHRpb24gaGFuZGxpbmcgaW4gdGlw
Y19iY2FzdF9pbml0KCkNCj4NCj5Gcm9tOiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5z
b3VyY2Vmb3JnZS5uZXQ+DQo+RGF0ZTogU3VuLCAzMSBEZWMgMjAyMyAxMjoyMDowNiArMDEwMA0K
Pg0KPlRoZSBrZnJlZSgpIGZ1bmN0aW9uIHdhcyBjYWxsZWQgaW4gdHdvIGNhc2VzIGJ5IHRoZSB0
aXBjX2JjYXN0X2luaXQoKSBmdW5jdGlvbiBkdXJpbmcgZXJyb3IgaGFuZGxpbmcgZXZlbiBpZiB0
aGUgcGFzc2VkIHZhcmlhYmxlDQo+Y29udGFpbmVkIGEgbnVsbCBwb2ludGVyLg0KPlRoaXMgaXNz
dWUgd2FzIGRldGVjdGVkIGJ5IHVzaW5nIHRoZSBDb2NjaW5lbGxlIHNvZnR3YXJlLg0Ka2ZyZWUo
KSB2YWxpZGF0ZXMgdGhlIHBvaW50ZXIgYmVmb3JlIGRvaW5nIGFjdHVhbCBtZW1vcnkgZnJlZS4g
WW91ciBwYXRjaCBpcyBub3QgbmVjZXNzYXJ5Lg0K

