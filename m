Return-Path: <linux-kernel+bounces-23573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D467982AE8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BDE1F28249
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1815AC9;
	Thu, 11 Jan 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="qqrCY5Ba"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2058.outbound.protection.outlook.com [40.107.114.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6468F156EF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILcCZI/hNd8V//WXiOUK6pbZ0JeaQDVInjjh9aWVfoo4L3FGaiFSlK/2NlwfO+7RhN6UB97GuB17GVmU/nazfQ7AfPZov+Qf6gBZppNTP9MMCES8X1OKGqFIYDITbNOgnnK/yq3q6puqsN3NT3NPJ1YjDcZeqhvCwF5IbXGfwVS853G4tt5tyPxIPa7DFKOEZGXR25rKr/rFALul9ZlPHpwkyyGDpMouyLhUfO+Q6BEy9mqqoFHP2dOFRHRWpMGmv4svWpQLMdCPGCLkIFf9XZ7sNg6L3ASEh1z/oDz84Bw/MYx0OiQbDR49q9FZxY/hHeikXlWMGF3CT3A7tWITxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nq9vTua3hhQFtgQumwCXiMvJOdCI/YjeX8+jXDvj7s=;
 b=bePyu0r3EWBgQ7IpZz4i324pMsyJFdyosdoF6e0ZY4xXet6+hCYvdNOYcKeSIrrKwKWuE0Vliv34OsqBv5EnQyihS8o5ZkTRoQ9gWLWizQ05EhTyQJGWbsYCC9pCxFT4TxyIMiyJTiyWxmBYZLrX4GY6ng1lg2uJJ/MUZPR2dl+craGAHewZok0x2FnS8GNNwxeG0PadVgaKiCaYrvxWXQHn6I1mFKsHMfiD+b3fw92x2jRAw7cX6H7763DiZB/vGYBsJtVZtldNbsTlQKWc+YtsSbAVXwP/DBpF2v0nXEFlJO8uPA+1ZzIXRqYHvutRaFLtWkGDszAAXbwDS7e9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nq9vTua3hhQFtgQumwCXiMvJOdCI/YjeX8+jXDvj7s=;
 b=qqrCY5BabyyPjeAfWgJVAc405XOuaS4BoPiQ2AHEVUzgQLgkhfQWrExOxLTsZLa+9wxR1fsPV3GE/e1O43QeQvgZw2OWfRKWjhW/uNcX/KaXZDpHYkV2T0J0Qhj7nYxeTTA9hDD77nBVvTiHQ1SziumV7OqFvhZnUwQpCPhBMVQOHhCgv40sBN+VI64H5/1ICbqMNvKGN5ROCHVK36EZqxKwqazJ31FBcru62CSPJQ7ZdWGE/7X1Razfdy5NDKjGHgS4PJXoGj6nsRR6+h55JiShbRIhFMzsHXZC8Y0utHljQrwzw4rTS90T/VgwiN4qjeMH6q39GXHYfjDMS1+05w==
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com (2603:1096:400:15f::5)
 by TY3PR01MB10468.jpnprd01.prod.outlook.com (2603:1096:400:310::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.13; Thu, 11 Jan
 2024 12:18:58 +0000
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::97b4:ef67:3174:a230]) by TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::97b4:ef67:3174:a230%3]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 12:18:58 +0000
From: =?utf-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2R44CA5rez5LiAKQ==?=
	<junichi.nomura@nec.com>
To: "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: =?utf-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2R44CA5rez5LiAKQ==?=
	<junichi.nomura@nec.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"ardb@kernel.org" <ardb@kernel.org>, "david@redhat.com" <david@redhat.com>,
	"nikunj@amd.com" <nikunj@amd.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "debarbos@redhat.com" <debarbos@redhat.com>,
	"jlelli@redhat.com" <jlelli@redhat.com>, "lgoncalv@redhat.com"
	<lgoncalv@redhat.com>, "dzickus@redhat.com" <dzickus@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/boot: Add a message about ignored early NMIs
Thread-Topic: [PATCH] x86/boot: Add a message about ignored early NMIs
Thread-Index: AQHaRIhafVlQIpM4zE+vUjXyVtJi6Q==
Date: Thu, 11 Jan 2024 12:18:58 +0000
Message-ID: <cb2652ba-5957-87da-7d13-814d9ec1a65e@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8389:EE_|TY3PR01MB10468:EE_
x-ms-office365-filtering-correlation-id: 85e96c35-9c59-476f-aee0-08dc129f7d0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oS9QSHeCkEx15HW+/CMaxLPt9YL5Nw8Z3uA4wsW3atHh6jLVTA67taSOLV2Zp0TAMo2CDyiD4iYLN8KSPVsZARYqJfiV94l0+Ax7uF5FB0jKle94s5vz5X+3kVRveX06RkyWQl/iXX/ba74W19mKJoLgXeM1CC9IJz6H3X+QzK+mxbP5V7ZnnlcW164MgCLrKL1VbRWqs/o2zPRBd7c5hZDtd1gioBVOy3Ab+rXZdZv0Ifh9y4x9aDXJQF89GPw3EXAcqim0rx5ySwRGBhlOHc8jH24mArnrgVlP7ijqCQBAtWcjyuWNDcBBlH8juGYHkNLtqQ44pw6fU0vq8Z40YORkyiA7THWJUBra6gVprM4o+LruR5+6v/8qs+VimOkysP2oz/JMuk3JK+X7s9gIPuPNiq6cYM263jg04g5dgE0HbKJ52c/4f0xL3gxCmMGlWxBoBZgrKRv1T5HCBQ/yHZu549BBFU4wDC3txQdwKe0RGvPNiKg9KceeC3esNJZXqBq6DBbSDNE6ZC0+fYpyfLRy8afqQJnpYocHIJweMkh7D9j6FGogsayiMuPNZCg2vM6CHVwZ8QgeYB1GQXPk3x0OYojZGsgkW4VYZC/3svS9ReyeEMyfj/PDk55/FL0Pm/Q0hGNwhEMij8hp2Vv8qA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(4326008)(8676002)(8936002)(7416002)(2906002)(31686004)(76116006)(66946007)(54906003)(66556008)(64756008)(66476007)(66446008)(15650500001)(110136005)(316002)(6512007)(6506007)(966005)(6486002)(478600001)(41300700001)(71200400001)(85182001)(36756003)(26005)(2616005)(38100700002)(31696002)(83380400001)(86362001)(38070700009)(82960400001)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlMwM1dOcmJJNTZWYXBGU1owLzFSeEtJZWQzQitWTHVRbDlKSXNGbU45elgw?=
 =?utf-8?B?cDA2YWUwOUJ5REJyNFhMNS9Cc0k2Z1BtR2E0SXlLTVZzSnNnNXJGS09KU0pX?=
 =?utf-8?B?bDcxbGhOYU9DQXlqaVlEMWpFZFJDbWNvZUppWS9vRDdWMFYxaXZOMEFBb1NJ?=
 =?utf-8?B?bFJHd2tjU3d2K0o4SWJKeFh0RzFnT3lKOE80U1NNdTZnd0x1R3BjU2tMcGpU?=
 =?utf-8?B?UVZiWkVKOVY0bzUwTW5lcFcwQmg0TlRacG1yOXJaNklyQ3pGSjhxQ2d3bXYx?=
 =?utf-8?B?Q2thNlZPcjhvbktTRTJZa09aMlo2bmdqWnMvV3VqUUc1OWJ5VU1CblcyekF3?=
 =?utf-8?B?bG9xVWRYSFNvWHdzcWkvNlRUNWxZTVN2QytQQzNRQWVoYkVFYU5lQ2xHWmtR?=
 =?utf-8?B?Q3FVZDNUSFNlVHAvQkdrM3JrSk1aNjY3OFFtSTRsTm00YlczQnlCczA5bHJF?=
 =?utf-8?B?VW0wS3hwdHJtR2R4QmVBV0FKVHFNd0p5YjRvOEFnWjlkQmlwMXVWdUdpRmo0?=
 =?utf-8?B?V2NmYTU0bkZjaHZWaWdROXJhVHdXV1JkYjRqRGd6ajd1SHFVekNsTktxWm1I?=
 =?utf-8?B?Y2ZaYVFUVTY3NXVIU1hQaFNSNVJLRW93SnF6RlRlV2E5anFIZlVyNnZtZ0k0?=
 =?utf-8?B?Y2FhcnRpM2xhL0ZLaXliOVN0YzlsdVo4WDIxb1pJL3p6cFpHOEpGZ1plenRs?=
 =?utf-8?B?N2kxZDBUUlRmZHJnc3Y5d3RLeGtTV3d6Z01aTXd1d3UreFVMVXBRcmtjWEhs?=
 =?utf-8?B?dkd1bS81UWVNTm5SUDkvOVBOdFNQbmwxYnVmN0I2SmtnWGRHa2ZGKzlYQ2w1?=
 =?utf-8?B?R0JvTVc2ZFFQWG5RMDdwYVBKNzBZWlJrOTdvOXh3amVIbnZxTkV5QUNnSk43?=
 =?utf-8?B?V3hFZlFXU21oNXBvZFFBTFE4OEcxbElQMjNxOEZMM0owLytVOW9yeVUraXNW?=
 =?utf-8?B?ejF0R3NMQU5MNGdjWlIxSEdldGdHNE5hM0Z5VXdGSWdzNzJ0YWVTSVMxa2tv?=
 =?utf-8?B?NU0vOVpudjFENGxUSk1LV3dZVGhsb3BFSEx0RlZiWWUyYmluSjVPMzdzUHNr?=
 =?utf-8?B?QkdNQ3l2ZzZZb1U5TVVvTGsrbXdOekJMTDdsbHV2QitwdmlMeFFOczdiMHdH?=
 =?utf-8?B?ejhtZG5TSDRCQzZYYWhUT1FxRkpkYmtnTDNJYUw1Z1U5M0RKZ2VERjJGaGlu?=
 =?utf-8?B?aUFnejZ3R010R2tPWUhha1hYMTBqTmxkUHF5RVJpTmxXWHp0bkIvQWVKVHcv?=
 =?utf-8?B?QVdXZ1JCYkNsNFBZTGRxYjlYMVZGOW1tRk1rdDZxTUNRSHBUZGpTWUVtcXYy?=
 =?utf-8?B?YVZMOHJKalh0RUNHSDBBVm5nTWg0RUdYc1pra1NuUy9EdFNyM0Y4TkoyU3Mz?=
 =?utf-8?B?K2ZNLzd5cmY4bVZqTjk2K21FOGpLVmVFcjJrVmdwNmd1NHZ0b1luMndpcExz?=
 =?utf-8?B?UGorODFFTnFRVjh4RVhQOStQZkpTTjhKR2trSkhMU29TWjUwSml2NnluV1Bk?=
 =?utf-8?B?UW5Kc3Zuem1kZWdJcnpNcHdIdTFrVDZYTXF4K0puaWJLRXV2ZmlpWFN5ZW1t?=
 =?utf-8?B?dWNxc0ViN2xVL0ordDJvN1JYTkFsRDVadHA4U1krL0EzSk1GVDc1eDg5bnBj?=
 =?utf-8?B?azJldzl2Y2lvaDEyNUNyNEFYQkZQWENmS2J5WUpIdXpHeTZiUUl3c0h5RHhh?=
 =?utf-8?B?d2twTjN3TnJ6bE52VkNva1BtQ1VEb3hHakszVGU5aFlGVVJKSUxDTlNiSWpE?=
 =?utf-8?B?S2xaQjNLbnZpdVVCa2dZUlRsdG8wZmh0WWNYaXFUYzlCU0NtNXcxUExpUk1V?=
 =?utf-8?B?QUdid2xGbjJJTnUycklJNk8zTXB2eUVYSlViY3dxTm9EWGM5VVJQM2FLMHph?=
 =?utf-8?B?N3ZiSnl4bkhWU3phVGFvbGdSMHA4dlAvSFpDQmJEK3RZeHVqeE1sZkg4NUtQ?=
 =?utf-8?B?UHd5NTlNUGlFZUNOeTRPTGowNHZLa01aNEpqT1ZlZmI2cjE0Nlc2NWdiME1k?=
 =?utf-8?B?Rm51b3ZGU2oxRkZwV0QvSm5paFdkL1E5RXJEbGozUXdPZ1BGZDVFWW9RTzds?=
 =?utf-8?B?TnVBVDl4c0ErNW1ScTdkQjE4bVlFK3N6WlhYbW9XZ3p1amJTK0ducDYyN3BR?=
 =?utf-8?B?UDZiNkhrZ3JHcFNsRW9WbGNsNHJNdzNTK0ZhZXIvSTRueG9tdnYrWXVyYjVP?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D4681D0DE147A42AB7E022A2B11B8BB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e96c35-9c59-476f-aee0-08dc129f7d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 12:18:58.6726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxBId7p/tAK1MigZBWev/QNNSP6Lxg8xdAuuxPGPQqngCxkH+i/d29w3VVMNc/96jHw6p2w5GBNrN6rcF4Yyew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10468

Q29tbWl0IDc4YTUwOWZiYTljOSAoIng4Ni9ib290OiBJZ25vcmUgTk1JcyBkdXJpbmcgdmVyeSBl
YXJseSBib290IikgYWRkZWQNCmVtcHR5IGhhbmRsZXIgaW4gZWFybHkgYm9vdCBzdGFnZSB0byBh
dm9pZCBib290IGZhaWx1cmUgYnkgc3B1cmlvdXMgTk1Jcy4NCg0KQWRkIGEgZGlhZ25vc3RpYyBt
ZXNzYWdlIGluIGNhc2Ugd2UgbmVlZCB0byBrbm93IHdoZXRoZXIgZWFybHkgTk1JcyBoYXZlDQpv
Y2N1cnJlZCBhbmQvb3Igd2hhdCBoYXBwZW5lZCB0byB0aGVtLg0KDQpTaWduZWQtb2ZmLWJ5OiBK
dW4naWNoaSBOb211cmEgPGp1bmljaGkubm9tdXJhQG5lYy5jb20+DQpTdWdnZXN0ZWQtYnk6IEJv
cmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KU3VnZ2VzdGVkLWJ5OiBILiBQZXRlciBBbnZp
biA8aHBhQHp5dG9yLmNvbT4NCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
MzExMzAxMDMzMzkuR0NaV2hsQTE5NnVSa2xUTU5GQGZhdF9jcmF0ZS5sb2NhbC8NCg0KZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9pZGVudF9tYXBfNjQuYyBiL2FyY2gveDg2
L2Jvb3QvY29tcHJlc3NlZC9pZGVudF9tYXBfNjQuYw0KLS0tIGEvYXJjaC94ODYvYm9vdC9jb21w
cmVzc2VkL2lkZW50X21hcF82NC5jDQorKysgYi9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvaWRl
bnRfbWFwXzY0LmMNCkBAIC0zODcsNyArMzg3LDEwIEBAIHZvaWQgZG9fYm9vdF9wYWdlX2ZhdWx0
KHN0cnVjdCBwdF9yZWdzICpyZWdzLCB1bnNpZ25lZCBsb25nIGVycm9yX2NvZGUpDQogICAgICAg
ICBrZXJuZWxfYWRkX2lkZW50aXR5X21hcChhZGRyZXNzLCBlbmQpOw0KICB9DQoNCitleHRlcm4g
aW50IHNwdXJpb3VzX25taV9jb3VudDsNCisNCiAgdm9pZCBkb19ib290X25taV90cmFwKHN0cnVj
dCBwdF9yZWdzICpyZWdzLCB1bnNpZ25lZCBsb25nIGVycm9yX2NvZGUpDQogIHsNCiAgICAgICAg
IC8qIEVtcHR5IGhhbmRsZXIgdG8gaWdub3JlIE5NSSBkdXJpbmcgZWFybHkgYm9vdCAqLw0KKyAg
ICAgICBzcHVyaW91c19ubWlfY291bnQrKzsNCiAgfQ0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jv
b3QvY29tcHJlc3NlZC9taXNjLmMgYi9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvbWlzYy5jDQot
LS0gYS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvbWlzYy5jDQorKysgYi9hcmNoL3g4Ni9ib290
L2NvbXByZXNzZWQvbWlzYy5jDQpAQCAtMzU3LDYgKzM1Nyw4IEBAIHVuc2lnbmVkIGxvbmcgZGVj
b21wcmVzc19rZXJuZWwodW5zaWduZWQgY2hhciAqb3V0YnVmLCB1bnNpZ25lZCBsb25nIHZpcnRf
YWRkciwNCiAgICAgICAgIHJldHVybiBlbnRyeTsNCiAgfQ0KDQoraW50IHNwdXJpb3VzX25taV9j
b3VudDsNCisNCiAgLyoNCiAgICogVGhlIGNvbXByZXNzZWQga2VybmVsIGltYWdlIChaTyksIGhh
cyBiZWVuIG1vdmVkIHNvIHRoYXQgaXRzIHBvc2l0aW9uDQogICAqIGlzIGFnYWluc3QgdGhlIGVu
ZCBvZiB0aGUgYnVmZmVyIHVzZWQgdG8gaG9sZCB0aGUgdW5jb21wcmVzc2VkIGtlcm5lbA0KQEAg
LTQ5Myw2ICs0OTUsMTIgQEAgYXNtbGlua2FnZSBfX3Zpc2libGUgdm9pZCAqZXh0cmFjdF9rZXJu
ZWwodm9pZCAqcm1vZGUsIHVuc2lnbmVkIGNoYXIgKm91dHB1dCkNCiAgICAgICAgIC8qIERpc2Fi
bGUgZXhjZXB0aW9uIGhhbmRsaW5nIGJlZm9yZSBib290aW5nIHRoZSBrZXJuZWwgKi8NCiAgICAg
ICAgIGNsZWFudXBfZXhjZXB0aW9uX2hhbmRsaW5nKCk7DQoNCisgICAgICAgaWYgKHNwdXJpb3Vz
X25taV9jb3VudCkgew0KKyAgICAgICAgICAgICAgIGVycm9yX3B1dHN0cigiU3B1cmlvdXMgZWFy
bHkgTk1JIGlnbm9yZWQuIE51bWJlciBvZiBOTUlzOiAweCIpOw0KKyAgICAgICAgICAgICAgIGVy
cm9yX3B1dGhleChzcHVyaW91c19ubWlfY291bnQpOw0KKyAgICAgICAgICAgICAgIGVycm9yX3B1
dHN0cigiXG4iKTsNCisgICAgICAgfQ0KKw0KICAgICAgICAgcmV0dXJuIG91dHB1dCArIGVudHJ5
X29mZnNldDsNCiAgfQ0K

