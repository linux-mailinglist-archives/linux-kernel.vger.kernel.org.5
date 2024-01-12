Return-Path: <linux-kernel+bounces-24606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC582BF16
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49ECAB23E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2AE67E6A;
	Fri, 12 Jan 2024 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="oUqnDDJC"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2069.outbound.protection.outlook.com [40.107.114.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548FD67E60
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN8uNpBQUGV2l6ZNo5v0rF5nZ4CGGtp2S46Zh0Ff4meybIs5OtCIgulaMDvy80CMenqF2a6ZVYiOiRz4vR12euBOY+pMUJgJZzkoFE+pD6jTGrQlCKlkzWhKpwTKNPFHjIcR5Hpi4noBy0fhMqvminye5OVMdmCvxcEyADKeVuGW2mxviWj8j0aDti7ezWhuNa3Btp4+klm1HJ1Fmjl9B6OJ8xxcv9cetcfbd10E3x+d8klgVzffQfaDhsSjbv36JqBCblWhzsEsXvRSlmfW1JRd85+2+kTOrHebXc7wNg6PGTiOYNXDpEnQ7Ksf9ZL2Epax3sn50qrpZKLvENObqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se8IQa1LA7gMOrBE/V4zvoFHnQeE8/XXodFUi5fsZ8U=;
 b=g4wdDosZVv0XYi9OUjdwysTshCIxrUeaiV1abwcMJbM2PnN0MJqel8GFebetapNL/ey8nbC2hYuPGpIxha2LxcJbFgD/YXfmyzBwU/hjP6+SLVK+OxYlDEbkfkO8mL/dpmdWqq0gTH7Dk3r1ivgE9J42/7ljKIsYv1gK6rd8suSV0J6+PgwBhOKHttHvQ5eR0ydevka9166LMz9WVE1SCCDDucWgO1vG3WGh9kW7jTPo0aEdl97cZ2ipxSppMvf82NXiUNUpge07dnbYpo8dyxFnXrL5jbrr7zWi/bbyO0uQi+2V5L8HowL07Mhs76116dAa0uxpPzMWspacSOCmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se8IQa1LA7gMOrBE/V4zvoFHnQeE8/XXodFUi5fsZ8U=;
 b=oUqnDDJC48uslqIb81gRdFP0DhHM3CgcmDAhsdAef0wPHPgCZ61BmWa6a0Q8RN6mEAmk2qRZXiS6yzD5s6hGYN4fIaVNwBLWuMuYNC22wi/O6JJCtxGK3Dy21Szs6vQ7ex7Zli688a9bc+W5XizDt/uEXgg3ni8P6WFzUQ7vCR87nNVCPQAGsqUq/xQiN22Lj/Sf5iiiYhcQXKrZqyz8RwSfxhpOVN8s8HTO0DZcHKz7CDyHIPlLEsn3DWKFGiWtQri6pfhO8d+feM7STRkvxWD0wR/Ip3YUmeMY/79mBZtYRU1jlDZZh0ZXIiocJqB1HylDIKcmT5PyOs4WcD0B8g==
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com (2603:1096:400:15f::5)
 by TYWPR01MB8696.jpnprd01.prod.outlook.com (2603:1096:400:17c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14; Fri, 12 Jan
 2024 11:13:53 +0000
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::97b4:ef67:3174:a230]) by TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::97b4:ef67:3174:a230%3]) with mapi id 15.20.7202.014; Fri, 12 Jan 2024
 11:13:53 +0000
From: =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?=
	<junichi.nomura@nec.com>
To: "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"david@redhat.com" <david@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "debarbos@redhat.com"
	<debarbos@redhat.com>, "jlelli@redhat.com" <jlelli@redhat.com>,
	"lgoncalv@redhat.com" <lgoncalv@redhat.com>, "dzickus@redhat.com"
	<dzickus@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH repost] x86/boot: Add a message about ignored early NMIs
Thread-Topic: [PATCH repost] x86/boot: Add a message about ignored early NMIs
Thread-Index: AQHaRUhttMsB94tJmUuDDAl0tLENcQ==
Date: Fri, 12 Jan 2024 11:13:53 +0000
Message-ID: <ZaEe8FC767f+sxRQ@jeru.linux.bs1.fc.nec.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8389:EE_|TYWPR01MB8696:EE_
x-ms-office365-filtering-correlation-id: 37fcad32-6847-4ff9-e3b4-08dc135f8fb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tD4L3sH++MxHY20X7SqKThf6F6k2K1b9r6ShjfuTwmSwPar5yRThQV8KqnQM9+VbT256v8RT23lSHscn/xYbWTaJdKnpCPcJu0Kg5pcW1lnRqxRTF1QFe3G+vOudOzHrugRPkDDu69oXhp8FqC8Dt9FE/s4N2mVxCeGHTyOZ7k1a1rEqLT2mV4Ikn8zN1VAjulOS8ZHJOwEaO28G37WfzGFSMvOcitJegJSuEJXmytnNdiiovJwh/vLyuuSR+Vtn23x6E7OSp8fqBRtRPjTeuLEeiTZlCDvgw8bC0GmP32tSEuTHFrrMBO6OZ2X3qt7jTJiWsPMsrjaAr1wK5gYj4rVr514MYt5Js/Q0foSwJ2AGn4kC2+KmEAqg35grO0BzyZHvdfK+8iYXMVhVe9Zzx9F3uxeSFo21f4BgppfPegBF0anGysjRQFK7w/qXpOJLfI1+g56SM15WvqmV1hRbrE13/V5tacl1XKfs4aAY/kOnUGHNQ+9PLU0vOgtDJRXBcV6+z1skI9xZbVkqB/xWfeQ8RGkwwlD+nfaSH8OtEThye2HB9eE33W9dUWQstWtuQov7wwtIwnx8HQnqNqRK+SN/8UuXpKJ0T38RGfawNt4m9cgCzq9PZ7zHOmTCnK/v
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(966005)(6486002)(6512007)(6506007)(55236004)(71200400001)(26005)(85182001)(83380400001)(38070700009)(38100700002)(86362001)(122000001)(82960400001)(41300700001)(9686003)(478600001)(8936002)(15650500001)(8676002)(4326008)(5660300002)(66946007)(66476007)(66556008)(110136005)(76116006)(316002)(2906002)(66446008)(7416002)(54906003)(64756008)(67856001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?aTNQaFpxdW42U3JiZW9WSFBJbzVHU3dMWlhHKy9wNHlYeUttcUszRmts?=
 =?iso-2022-jp?B?c1l4RkdBV2ZGQ2pzS3Vjd2xxQUhGTEJRUXdTSkYyeXdlanR2RWJTUDVH?=
 =?iso-2022-jp?B?eUNJRHN1K0tIY1FJTjgybFNybUpRelNaWUQzbFFuS3ZRQWFKZWpxWk5Q?=
 =?iso-2022-jp?B?eHJzKzJmOWxoTjJHdGVjOHVrY0wvZDIwOXVmZlBheTJMVUtqQllKKytY?=
 =?iso-2022-jp?B?TStlU1RlR3RZWWtOb2dBeCtwajVwak4vdzhKZW9QS2Q5UUxPWmNSYno2?=
 =?iso-2022-jp?B?T2MwL3BtMzY4QVREWSs4RkhoazRyMDBKK29KK2p0OHdUMjM3RytWbnIv?=
 =?iso-2022-jp?B?QnIydTR2dzFVN3RlTDdFUFpkVkRBL1FUZWFzUm9jWFd6aCtzaFIwUHVJ?=
 =?iso-2022-jp?B?ZSswak04UmlHeTZyYkJmUFBTWGJxVzNnM0l6L3NmL2xiN1NUN3pHSGU3?=
 =?iso-2022-jp?B?SW1NdURzVnh2MG90NkZ2SjNjVHF1UU93V1doSmlFS2ZGT2k4RkVNSHFt?=
 =?iso-2022-jp?B?cTJ3eDV4QVdLbXJ1RHA3Z3lveUpGbXFCLzRSMXNZOFZTNFgzSVcvb25Y?=
 =?iso-2022-jp?B?WGN0c0F3T1VYRG5kVHFPVzlUQVZua1k1UjY1Y2FTeW1VQVdHbFcvVDhG?=
 =?iso-2022-jp?B?UE5zS3RYQ3F1clBYbERhblVmREwraUxNUUthVHhnbkl1NXBqWG02ZENI?=
 =?iso-2022-jp?B?aWZacEZhSTVreTFveStWMTRUaXZEWUJWR2ZKRlY0Y2N4L1NuRER0bGZy?=
 =?iso-2022-jp?B?NGFqVE9Ya0xYM2ZQMEF2U1kzNWRLNUd0NDV0bHRyQWVtVzI1ZEE5VE16?=
 =?iso-2022-jp?B?eFNuNkVzQXZpKy92R1lRMFpBVE5vZXVreEJyRzN6VUM2ZFFZdFBid3Vy?=
 =?iso-2022-jp?B?UVZHVmphdUJZbGxwUWFOZ2drbE9NVGk3OTRNVTlSaWpMN3NKRVNtdU5P?=
 =?iso-2022-jp?B?R0dBREZVblhjOUY2SHJBSlNoTngzRmdSalJHVDdFcDh2Rno0Y3JKS1Jv?=
 =?iso-2022-jp?B?SXlUR3FYYXp5WTczbUF2dlV0NEh4Q3BNQnB5aVFzZTZhc3AyNlJRWGRM?=
 =?iso-2022-jp?B?ZFVrM3RnNWpscVlWT1R3RUtXQktzQjhCVkpyVkY3L3lCTlBUcWVKdUdk?=
 =?iso-2022-jp?B?bzJROW1iT0V1aml6ZEFqcEZuZit4Z0ZIYmpIY0xmU0RKMzFkQUJaVWZo?=
 =?iso-2022-jp?B?ZTVXTnp3SlZaMkNaTzJyVVAvVlBDdHRFUlE4SktJaXRkQnpUZVUycjND?=
 =?iso-2022-jp?B?QmQxbTV4QmhOOUVpVVQ4cGtRM3pnY21oSVZYMlJCUDZiVFp3MXNrOHNR?=
 =?iso-2022-jp?B?TWxHTXhMOHdac2NObVZhaXE5WDJLSndTN2JYYmk4SGJpaWpSeWFmQXZr?=
 =?iso-2022-jp?B?MGtERGNLOFN1V3A3bnptVjluTDZweXovbEJIcHpwZkdZU1JCNlV6anhp?=
 =?iso-2022-jp?B?d0tVYTNTbzB0RFc1QjIwdnlITW9JRjliQVlialovZmYzelhEWTZsbWlG?=
 =?iso-2022-jp?B?ZGlPUFFUMlNmNkpQTnpMc1RMdHlBN29iVFBJLzI1cnl3WDNsd0lPTlla?=
 =?iso-2022-jp?B?emo5ZEpoTExlQzh1ZWd2QmFzcGpVbzMxMGwrQVpnUFluUUwybWJZdlFu?=
 =?iso-2022-jp?B?SkpRWVA0bzVCMTZPcUNaV29rV3JabDhBL2FSTzRSaTlUSkdVM2c4VWM4?=
 =?iso-2022-jp?B?MDRqK2doMW1nL0EvSTVtMy9MM0s5ZzgvVXZOeHlRQ2hMdlZEa1lGakxU?=
 =?iso-2022-jp?B?eGk0ZzRRYXZXUS9HaTdMeHc1NnBIWkNWTVNWU3lHY3c4Z0x0TFROVHFT?=
 =?iso-2022-jp?B?Q3NvalJlUlhEVCtrZnFuZi93aTRHYStUME9KK0NHRHIzTUJXQUlKUTFi?=
 =?iso-2022-jp?B?L3ByU28wc25NdUdnSk04RW9RY2VlN3ROeTVKVFpvaGZtTGk5dFIwS1g3?=
 =?iso-2022-jp?B?N2VrWHFONnZHZGpjYjZDYWV4eEhsMENSZGh1MDFXZFh4WmRTZmFQOEJo?=
 =?iso-2022-jp?B?ZHZ5eDlJT3hsUkJQSVVYVmhJajBFWTFQMkRlVGVsSlRFZ1doVTMvK3V6?=
 =?iso-2022-jp?B?ZTQ0TDYvR2RUY2UrOVB2b3lqMm9JSkRYZTlzQm1HSjJ0QWw3OHZzNmNk?=
 =?iso-2022-jp?B?ejNycGlBaFZOemN3VDJMc29QZ3JTM2pNRW9ET291bUhrYWdicG1IMndj?=
 =?iso-2022-jp?B?cXFvYUdTU29BWXh2VG90bzM0cVdyOWcyc2prQ0huMGNreG5nQkZqRXlq?=
 =?iso-2022-jp?B?U1pOOUs3N3BvekdMT25oVm9DdVRwV0JIaTlaTXJleGZrTmtyMExleGR1?=
 =?iso-2022-jp?B?dCtQSzc3ZlhrUEd5NUZrOU5qaHo5QmhGNFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <B3582B4D0C377F4788E999B4390C1252@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fcad32-6847-4ff9-e3b4-08dc135f8fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 11:13:53.3153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSxWO8Z7c06z8ch4le93BZmGlKBCuWw+vv1qX+LxvGHcQji0jR7lwbnxyccVGRESxVNsQR7DQfkib5Rsz7zUCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8696

Commit 78a509fba9c9 ("x86/boot: Ignore NMIs during very early boot") added
empty handler in early boot stage to avoid boot failure by spurious NMIs.

Add a diagnostic message in case we need to know whether early NMIs have
occurred and/or what happened to them.

Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Link: https://lore.kernel.org/lkml/20231130103339.GCZWhlA196uRklTMNF@fat_cr=
ate.local/

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compre=
ssed/ident_map_64.c
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -387,7 +387,10 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned=
 long error_code)
 	kernel_add_identity_map(address, end);
 }
=20
+extern int spurious_nmi_count;
+
 void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
 {
 	/* Empty handler to ignore NMI during early boot */
+	spurious_nmi_count++;
 }
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/mis=
c.c
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -357,6 +357,8 @@ unsigned long decompress_kernel(unsigned char *outbuf, =
unsigned long virt_addr,
 	return entry;
 }
=20
+int spurious_nmi_count;
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -493,6 +495,12 @@ asmlinkage __visible void *extract_kernel(void *rmode,=
 unsigned char *output)
 	/* Disable exception handling before booting the kernel */
 	cleanup_exception_handling();
=20
+	if (spurious_nmi_count) {
+		error_putstr("Spurious early NMI ignored. Number of NMIs: 0x");
+		error_puthex(spurious_nmi_count);
+		error_putstr("\n");
+	}
+
 	return output + entry_offset;
 }
 =

