Return-Path: <linux-kernel+bounces-35215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A2838DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9B6283DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64855D8F7;
	Tue, 23 Jan 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="XBrMLrdB"
Received: from outbound.mail.protection.outlook.com (mail-pr2fra01on2072.outbound.protection.outlook.com [40.107.12.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B75C908;
	Tue, 23 Jan 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010529; cv=fail; b=tnUSCLxDbhJrLAQ9uyIVRwHWVxy9WLme0LWEGk+rXqf47REr1rSY5NYqBWMQztRiZVIB1gbU2K86k+8I8M3giwb9EYHFGbfIFDfGpZOizU4H65qt9XY1b9g28AGHThxx0ZY5+Zffu54Giu6shhC2yjtCv+ONFSTAGQXK/yjX4Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010529; c=relaxed/simple;
	bh=pSGG5bByL2rhyIVQ/yfMaC8zRd4ZbLjKYLybOEJ9zig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MwDKSMUeqS+MW0xd+wHX9V6GRYRYhGPcf/oMXSc98PAftyFDx5EUydRGmJmA2EAWxZR63L6RpzmAVZwsHCjrh6Ju5F5Ram1zT/yDFHAsC3bxkEA0KpJ4wH7VPvfZSVQM8BZZT+X6prvEYXeKkSFbgwYrNW7fg5HSKWL5Cga7wI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=XBrMLrdB; arc=fail smtp.client-ip=40.107.12.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvc2hXsfhJYHJEC9J0MZqLuI7s0G46UwDqhjH+tohnRGFDCQGWqFHjAIzHuC9zFPHMj7Wq/PBHcYYnswDsXgnC1D80Y3tKIMBNVWKVrMGHaaDZoNPkTVkP1MY8h3dWpra+ndMD6A/w6KMC4hRfPk5uTCCc4gbwsj5x4tqgt+gyXcEh1zUS6mRtF7Wg1bXiOeDz9kytbZAsHgqlNmoAmlEYbz/yttvxzrGD4DBz58PE+MadJSjKszjMHMHKN5+GIOcJz6AANAHSKlXfBXEp0Vvo60hBFdMaLOqovttQHpMffUyWVFPrqActEHQZUSpUEqPlE6ZbpftnDCfYFkqm2jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSGG5bByL2rhyIVQ/yfMaC8zRd4ZbLjKYLybOEJ9zig=;
 b=g6sRqqVecqAYtnnQTKe+tEr4yGmeLDwfeF2pPiNeJIOiDR1qfADtppvpK482SgoRFBY7e/nFyo4rD4J29N7SMiBdrgX2s+xvDpWmkgJf8/bIPtQCosb7I+tCyXs+L9szM+kLeT0Y8kCRNmLCuOBxv8X1qrgPL5tp558Upwyp4e/gm/tqbnOkotCMFJjGgEu30ffNFSvoxchMcSZpN44kEMUnCRQH5stnqeO5U3kf35Y6vxc+97FuAowJj+/yrT8bQgAE4vjqJk8oO9GBlKPZq9aUi1eqnjoPFmtYkej1+5RXds3jA5TUzGUM5aRAqYKLVLd80yLzdiCi53yF+ou+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSGG5bByL2rhyIVQ/yfMaC8zRd4ZbLjKYLybOEJ9zig=;
 b=XBrMLrdBPdHge1W9FtV+2Mrr0gCI/CDT0g5B0fQXxuXwvwelQqNyTYErmxj0Tiv9UtOGrZZxEWCeVi4FJfUj7i366FgnJyrTST0bjqkQGCpmxdheQrIFRrdXhspmAqY09sVsmdyGBDj5o7lTuRDj6MXbTIPY61p/WDDeXNTwwoepElk0Db1ILWrXvcRNfDFg8w4bVrfU9hOlAr6YXrYaQKZuCqZfKIkC90W+XeBe2rsxoxW8E6N4wEFgXmauY2a8la526vTdvILb9v9s8eTK+NKR9Vw88zJ0VmTsVO8aNE3NgoeEh06/lBaojIAKO3TzPJEfUYQ5XD/ESsb1P7gFqw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2539.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 11:48:43 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 11:48:43 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Russell
 King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>
Subject: Re: [PATCH v1 01/11] arm/pgtable: define PFN_PTE_SHIFT on arm and
 arm64
Thread-Topic: [PATCH v1 01/11] arm/pgtable: define PFN_PTE_SHIFT on arm and
 arm64
Thread-Index:
 AQHaTWsgqyRS0TfRAU20Q9lz/3ZqNbDnNJ2AgAAD9YCAAAWZgIAAAlKAgAAEJ4CAAAHlAIAAAtoA
Date: Tue, 23 Jan 2024 11:48:43 +0000
Message-ID: <11a7232c-8623-4c2c-b980-a13645f3fe89@csgroup.eu>
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-2-david@redhat.com>
 <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>
 <46080ac1-7789-499b-b7f3-0231d7bd6de7@redhat.com>
 <6703b648-10ab-4fea-b7f1-75421319465b@arm.com>
 <ae3d826f-758f-4738-b72a-e99f098bb2b3@csgroup.eu>
 <3a970289-a72f-418e-b43c-89f67f0d5283@redhat.com>
 <e0d9caab-39c7-446a-aeef-5d914d321c72@arm.com>
In-Reply-To: <e0d9caab-39c7-446a-aeef-5d914d321c72@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2539:EE_
x-ms-office365-filtering-correlation-id: 7087f5e4-356a-4af9-4667-08dc1c09401e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6K8uFnWH04emw9wTWUgaYfTgAA80M/xbyNPe1IYDYM+CLdDKTOPT7Ak2lZgy5sWwfq/jRP+CePpbu8dGEjbRVxT9lj8g/7dzJRA4gqcFrLutqP9ZQm9ObS0gY+IbIrJSo4+eXyte6nA42m3d5KsRnzTlOK+H/gYn2k8ZtjDGsSvrjST6Fak0oEZrBHpec+3fgGxIV49zInALKvqNkuyJfFa4Kf+mQ7x8JsqIvsNvSKxfuheYeobhui8t94+t+g5lzfatu8RKAsHohUJlhsVRksVO+8jvfDX5YKph0ND3o2IEYwKy5cBsFSUDm9L2tm6YalURdJxSz9mXGJdY3ZKC+mII/eh4CR1VadEdV10Tf7jgAFSOt8rygVpS6x8oV6hZMV5gwhUhq9+q1Tw76VOon7PLCslMFaWfiqQqaeIlWRB3YqkoCPpWzDAFrf7XAZCoQilfPbobfLBds7lS55XKRWZK7KvR8VdK3t6xx40aolEFgUBWwTY29h2mAeeJJ+l/rgNsQ/v1LxQQTpLTEvj3r2+O5F264EEeGVyRLLguZgFn1Gm4p3u95qKc5VmjDHLdUqem+wFynAB9vS6G7qAF5KHJYEtizyc21xL8ME9yBV6RD4WWb/E930XzaG3eGGXddIvV+Pw2oGWdlPYaXG/o4jCYpwO46cJ0kn+Riarb1TA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(366004)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(66574015)(83380400001)(91956017)(36756003)(31696002)(86362001)(38070700009)(38100700002)(122000001)(2616005)(41300700001)(6512007)(26005)(6486002)(966005)(6506007)(66476007)(2906002)(76116006)(4326008)(478600001)(110136005)(66946007)(316002)(54906003)(53546011)(66446008)(71200400001)(66556008)(64756008)(44832011)(8676002)(5660300002)(7416002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1crai9ERlpjSnJCWkhqelRZN08zU0tWVmVKM3ZJMm5aUW5FNTE5OC9leW5y?=
 =?utf-8?B?My85UEhCSXB2bU5tMU5SSWcwRlNyWTd1UkhXVTdFTUUvUklrTER5WjExczIz?=
 =?utf-8?B?RytQT1A4UjNZNGNZSGhsb2ZsUFlQcjlqek8vV2FyZTV6Zy9KeDRzOXorMzlW?=
 =?utf-8?B?V0UvRXNTaFJzZU5UcnJuekhlNkd5b1IzVmlpODhxMnJHUFJ3MytjNktEaENR?=
 =?utf-8?B?YzNWSzhRUmJDTjNITTU4c0F3ak1rcXVPQmN0VFo5WldBajF3Z3Rhc3FUY0hV?=
 =?utf-8?B?b0R2NERuaTdwcTlvV1BrVUJrdkRJaEF6TEwwcVdLbWZXbm8wUGpEQ3BFNXRl?=
 =?utf-8?B?V2t0V3FHamxUK0t1amtJbnhwVngzZG1OVEJ3N3FmNyswNFczcklSOE1LSkJ0?=
 =?utf-8?B?dnlUQlIwcThwZ1ZobFVOM2dZN1pGT2hXdkY0RGFUUmNlbkdsb0pwcHJDM250?=
 =?utf-8?B?ZElGejlrdU45NEpMMi9EN21PL2lMR2FlbDM0cldRdHhmMDRpMnZDbGFFZTJR?=
 =?utf-8?B?bFJLb1RnUkovSUVIYjJMV1lycTY1eUU0ajM5azE4ZkJjSlFxL2d5T1lhU2Uz?=
 =?utf-8?B?U0FoZkI5OFVKYWxUZjA4ZVBOc1RYMGYwU2I5bUtZTjRweVFXZzFETHhHYTlN?=
 =?utf-8?B?S1VzVlgyZEtzS2FVdURYdTB1eCsxWmtzR3I5SXV0UEhhci9oUldvVTFyalFM?=
 =?utf-8?B?d1JUSUUrbW9jR25MUXZIYWtDMVBFT0NoanFkZ0I5akJaMlVUeHplR2VEMHF5?=
 =?utf-8?B?VTlHQlB1L3VHNXY2Y1NEam16dTQ1UkllRzBEVWpQTWVBM0tTdmI2NWFpQ0hj?=
 =?utf-8?B?MTY0NWpycUZxZnpEZG5UTnZ3NVIwYnlzNGgxMXVuZlFrcmtESENVc0hoZVZx?=
 =?utf-8?B?U0hKbUlVTEU2Y285YmxpSUhjb0lqd2swbVdVZ3U0VWFFUnFMM1dENXIrQ3Rq?=
 =?utf-8?B?WHBiZ2pBVDZ1Q1kzQmI5aEhNYTduTTVodGNhS2Y5SU8wdTRKTzZEdU9qd2Ra?=
 =?utf-8?B?RlovdlU5WUtvYXJzVVl4ZlBVTWViWVBWT3NHWUJwQkovVzN3ajRZVDl6dStE?=
 =?utf-8?B?VUQrUG1lSHNXYW1ybHNVOHk0ZGpJZ3BoNjlhaExuc09yT2QrTmN6SjhyRjNF?=
 =?utf-8?B?RWcwS0w4Y1RVV0hqNTFCR1ErWVZtRXdPM2IrSjkyb2FIUEJKOGNRRnZ4dnYr?=
 =?utf-8?B?a3dzZkJxQkdtY2pVTXhvOVZIWVppN1RiNGtNbGl5SDcyYkxTenFtcjFJV2Z2?=
 =?utf-8?B?N2t5M3JOTTdqM3RsUEM0dGJWY0M4ZTlINkc5SE9hMk1WVEhReW8veTJWUjdJ?=
 =?utf-8?B?cUxJbjlGVzVmZnFHc2Z0MlRqVmNYdEdGMGZKRGU5M29STHl0ZjJnUlk1VlRC?=
 =?utf-8?B?ZCtBTUgrYm05Vm1oOXR1R0IrOVRid2UrQUpSUEh5WVpFQ0xLN1A1UXBZTlo3?=
 =?utf-8?B?NkE3d1R2VFozZVhvbjZCc213ekpPblFtdWY1OGo4aVI4VzZrTWo3OUxSbVBD?=
 =?utf-8?B?VGdqTmc1Q0duRVg5dk1PdkJHM0c5UDd2M1kydUdHbDMySm16S1p4M1ZoUzV1?=
 =?utf-8?B?b29zcVowRHgvRFNJelE3di9XUWx3OEI0Smg5OTN5YmRVOFlwTmttY0F3a0gw?=
 =?utf-8?B?Ui8rR0NzekZEd3gyRmI1SFJUUHJhRnJFQ1RJWTRnY2hFRHBxM1RqNnNrZWpu?=
 =?utf-8?B?c3B4QWswWFdFdSs0R2szdERJVmF6dmRVYVdzcGZtOFpZRjV0aDFEZkJ5Sk9r?=
 =?utf-8?B?bUVwUVNVVWhjQWNHY3hPUmhwQzUwR3ZYS3ptUXpjZUtmZllMWWZWWXRCc005?=
 =?utf-8?B?dzl6OCtITnpmVmx5MlV5N2FETlZCeWR6KzFoK2IzdXZwSlZ2UDRxMXZnMS9K?=
 =?utf-8?B?bGg3L2lXaDB4NWZiRVJiOCtOYWxZWFQzV0I5eXAvcGxXU0UzZmNZaVFjSHNy?=
 =?utf-8?B?TUhBZHpDNGM2dFFEdU9HZ29zUW5aMUZ3cThNQjNIbUM2VnN4aG9oZVQxT1VR?=
 =?utf-8?B?VVhYM1Q3cUpPWWlCVUpUcHgvVHBJNHlsSkdoWlVpS3NnOXh5eERJdUEyLzlJ?=
 =?utf-8?B?WGxaSzBKeGR0dWNJN2duaVdwMVBtVHVCMkFCOUtuNmFCL3VyMmpFTlJHa1Bx?=
 =?utf-8?B?T1FKSk0zRDI4elJOWFF3T25wWStuNStUSFZxbWRGOG81K0hpKzVBd2xmUFNF?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33657EDE2316894A9BAF701D0B84101A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7087f5e4-356a-4af9-4667-08dc1c09401e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 11:48:43.5694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1kdvqylh0bLeXfyNZdEiVxGLPDO/vKe/RpxQJStizpE8vzHeO2HY9I5uRd3rGELcjA6sdXzsemKJyeY7FLQna3RwqLfMgOEpRnyOPX8FMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2539

DQoNCkxlIDIzLzAxLzIwMjQgw6AgMTI6MzgsIFJ5YW4gUm9iZXJ0cyBhIMOpY3JpdMKgOg0KPiBP
biAyMy8wMS8yMDI0IDExOjMxLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4+Pj4NCj4+Pj4+
IElmIGhpZ2ggYml0cyBhcmUgdXNlZCBmb3INCj4+Pj4+IHNvbWV0aGluZyBlbHNlLCB0aGVuIHdl
IG1pZ2h0IHByb2R1Y2UgYSBnYXJiYWdlIFBURSBvbiBvdmVyZmxvdywgYnV0IHRoYXQNCj4+Pj4+
IHNob3VsZG4ndCByZWFsbHkgbWF0dGVyIEkgY29uY2x1ZGVkIGZvciBmb2xpb19wdGVfYmF0Y2go
KSBwdXJwb3Nlcywgd2UnZCBub3QNCj4+Pj4+IGRldGVjdCAiYmVsb25ncyB0byB0aGlzIGZvbGlv
IGJhdGNoIiBlaXRoZXIgd2F5Lg0KPj4+Pg0KPj4+PiBFeGFjdGx5Lg0KPj4+Pg0KPj4+Pj4NCj4+
Pj4+IE1heWJlIGl0J3MgbGlrZWx5IGNsZWFuZXIgdG8gYWxzbyBoYXZlIGEgY3VzdG9tIHB0ZV9u
ZXh0X3BmbigpIG9uIHBwYywgSSBqdXN0DQo+Pj4+PiBob3BlIHRoYXQgd2UgZG9uJ3QgbG9zZSBh
bnkgb3RoZXIgYXJiaXRyYXJ5IFBURSBiaXRzIGJ5IGRvaW5nIHRoZSBwdGVfcGdwcm90KCkuDQo+
Pj4+DQo+Pj4+IEkgZG9uJ3Qgc2VlIHRoZSBuZWVkIGZvciBwcGMgdG8gaW1wbGVtZW50IHB0ZV9u
ZXh0X3BmbigpLg0KPj4+DQo+Pj4gQWdyZWVkLg0KPj4NCj4+IFNvIGxpa2VseSB3ZSBzaG91bGQg
dGhlbiBkbyBvbiB0b3AgZm9yIHBvd2VycGMgKHdoaXRlc3BhY2UgZGFtYWdlKToNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL21tL3BndGFibGUuYyBiL2FyY2gvcG93ZXJwYy9tbS9w
Z3RhYmxlLmMNCj4+IGluZGV4IGEwNGFlNDQ0OWEwMjUuLjU0OWE0NDBlZDdmNjUgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL3Bvd2VycGMvbW0vcGd0YWJsZS5jDQo+PiArKysgYi9hcmNoL3Bvd2VycGMv
bW0vcGd0YWJsZS5jDQo+PiBAQCAtMjIwLDEwICsyMjAsNyBAQCB2b2lkIHNldF9wdGVzKHN0cnVj
dCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25nIGFkZHIsDQo+PiBwdGVfdCAqcHRlcCwNCj4+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0K
Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwdGVwKys7DQo+PiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZHIgKz0gUEFHRV9TSVpFOw0KPj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLyoNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KiBpbmNyZW1lbnQgdGhlIHBmbi4NCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ki8NCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB0ZSA9IHBmbl9wdGUocHRlX3Bm
bihwdGUpICsgMSwgcHRlX3BncHJvdCgocHRlKSkpOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcHRlID0gcHRlX25leHRfcGZuKHB0ZSk7DQo+PiAgwqDCoMKgwqDCoMKgwqAgfQ0K
Pj4gIMKgfQ0KPiANCj4gTG9va3MgbGlrZSBjb21taXQgNDdiOGRlZjkzNThjICgicG93ZXJwYy9t
bTogQXZvaWQgY2FsbGluZw0KPiBhcmNoX2VudGVyL2xlYXZlX2xhenlfbW11KCkgaW4gc2V0X3B0
ZXMiKSBjaGFuZ2VkIGZyb20gZG9pbmcgdGhlIHNpbXBsZQ0KPiBpbmNyZW1lbnQgdG8gdGhpcyBt
b3JlIGNvbXBsZXggYXBwcm9hY2gsIGJ1dCB0aGUgbG9nIGRvZXNuJ3Qgc2F5IHdoeS4NCg0KUmln
aHQuIFRoZXJlIHdhcyBhIGRpc2N1c3Npb24gYWJvdXQgaXQgd2l0aG91dCBhbnkgY29uY2x1c2lv
bjogDQpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXhwcGMtZGV2L3Bh
dGNoLzIwMjMxMDI0MTQzNjA0LjE2NzQ5LTEtYW5lZXNoLmt1bWFyQGxpbnV4LmlibS5jb20vDQoN
CkFzIGZhciBhcyB1bmRlcnN0YW5kIHRoZSBzaW1wbGUgaW5jcmVtZW50IGlzIGJldHRlciBvbiBw
cGMvMzIgYnV0IHdvcnNlIA0KaW4gcHBjLzY0Lg0KDQpDaHJpc3RvcGhlDQo=

