Return-Path: <linux-kernel+bounces-103524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC05A87C097
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C46B1C21D65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DDD7316A;
	Thu, 14 Mar 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="jZHsmYdv"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2090.outbound.protection.outlook.com [40.107.6.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48471749;
	Thu, 14 Mar 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431149; cv=fail; b=lOszW1WvZPQoL9nibYYcuxz7/5lDfcjdX14/BWRON2s4Ws/ToIeYxmtoyRTjTF8tKFXhxxwcE3xBdRJlCQG4zEcsNPbdoFPmNKe8xL5vsNciBxltEui/DmptMOMCeVob22zR89jaybGmg2iSJzZeIUsq5b1q+32J10Z30wmL4fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431149; c=relaxed/simple;
	bh=bWfaTX4oJ1iTJgw5u8WfT47xbcn0xhZutbiYJMM0ScE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rP4QKd/ubBilqq4gyPNt4Uj1MMyMxC8JBDaeGT4TTnxIddTdCRh7ARqbbSkoCV8NTn5HgrpzC8HEtQzKCLR41GQyxqS4MQ2BjVNcQwmS4m6xYXnI/0hGxnQNysqU/2YSYPCjPiK32DbrhvPN1Uulbd4ioZLpnoc9B/tkK/RKN4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com; spf=pass smtp.mailfrom=tuxera.com; dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b=jZHsmYdv; arc=fail smtp.client-ip=40.107.6.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2IwdvlLVtH5aKAkSyaB6zUesBHOKRlJC5Ql3IcxzDg+fcUG1QqQ/k3PD+7Pi9SkF+tlxTGQuCfUsqidKQCMrgI1ZHqv+aGPVd7ZcDiyQUst8Gjj7ImXnPP8SR5SdgHK0HG6kJpSWtxblkQhR0H1+RWwEadM9+wvAFPaX07sITZLC7jjR5OgV/ixHyTRNnD4Zylj6lHzO5nGiMFyboefxEr2pZi4SFeTB9zke/gvWbK3wEisGn8LL9NzbwuLdF9JQG6dkd/HkiMM5bf7Cg6+Thq6SHKMJ2cmjqLFnOivZsFm2Meu9IDouMzHwvEdRpoS92M4X/UsI0bKDa2Uc6x2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmifIluQTPTxWP+oP3tNT5LaKylXiIysj401izJB2PE=;
 b=DOA5+89Ub112Zg6Wir1UtxicrgmPl9yJCC0Qz3UjvfXmL87u+qk375i69U12zMQmjCSNe+2QfrRdcc8xORlE3coyP4NhPIOxG4CFXhPmYpheR5/T1VTZzhZN4MMSfxQxHKuNO/nz+3nAwJDQ0dTWcsakEDPJoSodhiFCmxwkt09rHqmozzo4lJItYwbKIOa0a/ha3Wcwmkb3bJCUDN2UUDJ9NdoP/kRuPgt0SlzH22E6sp2zeh7nouaOPPUzVB9QexWUqbUvXV0yIlHooy6iA6Efw3Oha7UMIRHqqagMiTPUHMWV5bTrD+QXAft01K0awMpcEaSweoFAE3jtKL+oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmifIluQTPTxWP+oP3tNT5LaKylXiIysj401izJB2PE=;
 b=jZHsmYdvVf5tn0K7G1GrnkFvZLWqJ/DQAZ5nkplswxKasdu/Pyz4khGoyAssAA1Yj6/gyhPfPwNCguif3EdyABnascXxRkVKunOSQkWhLRtmWDSmEDE4i5dy2P8R6xjbVYJ3n8OkuwkMtAq8v8fesEs20H47GyS+liVfgLJqUcndcFDzr7jC7thO1HBmUeEKebjqPYgMmDrojpu+luVkil1VPsnp/nIFBbezsXilOccglpTJHiJWm6zoyUa6rpGh/8Eg5mJ1KtooyXRMBodPs+UZJUyU7q7H+NqHvakLDVkTgLyASYGROFtERCxkas3YtLDhdEXJ5bFNyq7d98kM9w==
Received: from AS8PR06MB7239.eurprd06.prod.outlook.com (2603:10a6:20b:254::18)
 by AS8PR06MB7766.eurprd06.prod.outlook.com (2603:10a6:20b:33a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 15:45:44 +0000
Received: from AS8PR06MB7239.eurprd06.prod.outlook.com
 ([fe80::6306:f08a:57eb:467c]) by AS8PR06MB7239.eurprd06.prod.outlook.com
 ([fe80::6306:f08a:57eb:467c%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 15:45:44 +0000
From: Anton Altaparmakov <anton@tuxera.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Chen Yu
	<yu.c.chen@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Linux Memory Management
	<linux-mm@kvack.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Ingo
 Molnar <mingo@kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/pm: Fix false positive kmemleak report in
 msr_build_context().
Thread-Topic: [PATCH] x86/pm: Fix false positive kmemleak report in
 msr_build_context().
Thread-Index: AQHadiEQrskV1NWHjkSsYR0U0Bb8SLE3YQqA
Date: Thu, 14 Mar 2024 15:45:44 +0000
Message-ID: <653BCAC0-8A79-400F-B496-23A2FA169786@tuxera.com>
References: <20240314142656.17699-1-anton@tuxera.com>
 <70261e2a-b87e-462e-964e-95a51ecde978@intel.com>
In-Reply-To: <70261e2a-b87e-462e-964e-95a51ecde978@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR06MB7239:EE_|AS8PR06MB7766:EE_
x-ms-office365-filtering-correlation-id: ba1b3b2a-4e8d-4de4-552f-08dc443dcf80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Gby/xhYZ0nh+8/BZV6VJg7zwhVywCSCvZls0ewwpWdZL4hgVbjeQgFXe89vnFkahN0Iksyw0FQadL8h6rgRdpbDZlNMPjYN5GMHl2ZYRcGm1NDlQC8xNfLSUzztdboi/Jfv/Zz9B+saKhSh4Fs26uC8GBO4JzS24wzlYQ0hcN4y5Mzi246qI+uTmNKd1jUp+fnMxOPIfTqaHa4+KBlBEmQxBCjsrdbD8rFYgWqc/CQMnnAt6Szej2mweL5Kv89gnd8kWx26/Lvou/Bc5b69JX7PD/Ax0N3sTK4mOiM4g7EqtaCioqh92QutkUHjorQQdxNMfxdpyTjD5SDm+LbfBW+VGYjL6W1n4pE6ctV/UUqeNux79ow7r3GA40Uicw6S6DQrLTMNHHMO1QkWhIJIEzMXTL3BymFW13W539L6VMXu6oA0tlQmcLyAiXLXvziHOvfFRY9xk4ets9e+UoM7Vy8aM6fhlC4q1qqif32m/MKKMLvXaD+tO8yjO4HO+wg9ZbYHmyMetqg9bAUvLVW7PdO3oHVvWzB+HyQBZfanGKe09LoFoPB2oir0QmLdxBqHHAK9zgwcBhwjgNYGzjIgIywdGXBHKZUvm87comrznNDQ5dGEtCxdzTHtEWCcTMrz7rHCSmtPvxuLrqv/CAhtiIfCZfx4Rllkcr2OXlzRl7Gg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB7239.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WiBd/WSYE4WNWpxzJwO2IEwKDABaiGCHFiZPB5l53GjVUmkw2+oM5IuaYo2n?=
 =?us-ascii?Q?uE6JRx5nHoQS9+FlM5i0sDFsbW93Mlp5eX0Zt+CVDrVbe65jECRAOxy1+WfL?=
 =?us-ascii?Q?T4LvDViHr+zdZ75lLt9SIAFujuo7en2D1AJI2kgI3RQ8blF0MMw95v44ZGit?=
 =?us-ascii?Q?+1ZQ/2OdqJl0ZKEtLFebvcZXyLUhE6UDwEsZoxC5aDgi9GvIEeNUKnqOZqXx?=
 =?us-ascii?Q?7vYPjnRoYAADj3NPUdqo20PlVgkHXzNFRY5Qe0xVANrwlH9DnCnPRw2PiB9B?=
 =?us-ascii?Q?EVClTIGBjny1uxND4ZFcvN648mkTTq7MjyhDWGQzZv4GEt3lu/pLuluZmnoP?=
 =?us-ascii?Q?shv/+j9HQI3ZfOq1OAvmcZqS7J2r42apMUN8/Xy5Qnz/wkXZYcZw+TzPA3nq?=
 =?us-ascii?Q?iN8b0cqjPv2SpvwTYUy2ooAAFtO7x4g3X22mH10OGVNaWYcgaxoZN+3jBB2K?=
 =?us-ascii?Q?WnxbpTa8Ia2vAoXGHgyRUav6ULvRZEC0T6j1JN+xi6R8fWM3MYgkub3egpWp?=
 =?us-ascii?Q?rRqiueUJYwrMXyUUq+mc8wYwvELIl/+B+J3OU+agSqYxN627y01s0kT5HdDX?=
 =?us-ascii?Q?AIVKUORi4sSVHGj5ERTq8lhiWjlwS3YRCN6oh56TXT9l+XzY1H4v2UzphEcl?=
 =?us-ascii?Q?+QswbNEk6gkXHgMZJsQrIoPhg5qA1DOtxsp602iiYtB50TE7zP6x+i/o8+4R?=
 =?us-ascii?Q?k/8FO0PWFfvKeDzFxY8IeuwwqbsQj2+CEv/5Am6WLxLgC78L5GPTqDXt6Na7?=
 =?us-ascii?Q?GnoSEj8UGEW21ZUvuQWguQ5QlpkDlmv/ewZpLjZLchYvHWtKNoXaEqwxBvHq?=
 =?us-ascii?Q?5md4OA1kfgVu/DnveWPTktBeLMlX0VpAcaaRjpZe+G7aFo9KBVSjj4CgJJc+?=
 =?us-ascii?Q?Ry5Yt0/DOddmlaLn6MvDMjdUr4RhJURJUmkffb+vLKYLCibDBZ2D08cNjk8F?=
 =?us-ascii?Q?VQNRVvNtzx70ZhG//Cxg0AgjkIWZuTxvvtjhumqtMPsGc3sK+FNBrScpqG0f?=
 =?us-ascii?Q?ZnZvD3IuJlWioZxKBCNlB+CkrrwFpEJSurwpHpm5lcYEUkRP7yl2DefitvCd?=
 =?us-ascii?Q?RYnbxMFfv9hPLGo8l/lZ1XMrdcYAmvpYhQkIcVABmX1Ssa+/AiGl6wTYUnKy?=
 =?us-ascii?Q?/INQHFy5T7hpjTF6I87EmUkRO/aOoACHj71gMZWaRU+tV3WXSmVPs8SLzB9B?=
 =?us-ascii?Q?uQdBG//8GG9HutUinNN+d+ZI1T1+RzR9nSODiQEEe54D9lrGwsJkPl6D0O/Z?=
 =?us-ascii?Q?7Q4iJzMpGDfQOVOHPBkV3SMtkM1XZmwRfwPOcZH4WK5s7eEhz8ZIgGecNs6R?=
 =?us-ascii?Q?IZXhAhC6p/D9FPDZN63xnEMoDRkuR/5hPaDhep5sVD2KihjpwVOZr/UOLCbi?=
 =?us-ascii?Q?gip+Lp2MJ+/J3ov9k6nsS0otoh179Z0vRCA+CJBMBfleEiVwlqPu9CI4K/qv?=
 =?us-ascii?Q?z5XNROgWQJGgGlBpM1GbLgfVYYL3P6TfA6mILtmSUXIWrOPFDSrBt6X2ojhv?=
 =?us-ascii?Q?fKHn+RUUTRwkm8rTxuj6uuU4ooz95Cny8sPxUyV6ZZtqu6u5D7/xZzqH7sFk?=
 =?us-ascii?Q?GTzVKDo7Bs3N5rWm8+YWBt0kZw3QbkEKtV6wcpup?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5EBCB49079CC674890FFC0406646BE57@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR06MB7239.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1b3b2a-4e8d-4de4-552f-08dc443dcf80
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 15:45:44.4159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1yQNlXEZ6PYOUfM3UEAuC637C2laLH83UWxxJB373skPx3XSPnMbZpEkHpvFExSxudjcMVYfEkRq4CtxT2CSEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7766

Hi Dave,

> On 14 Mar 2024, at 15:05, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> On 3/14/24 07:26, Anton Altaparmakov wrote:
>> /* image of the saved processor state */
>> struct saved_context {
>> - /*
>> - * On x86_32, all segment registers except gs are saved at kernel
>> - * entry in pt_regs.
>> - */
>> - u16 gs;
>> unsigned long cr0, cr2, cr3, cr4;
>> u64 misc_enable;
>> struct saved_msrs saved_msrs;
>> @@ -27,6 +22,11 @@ struct saved_context {
>> unsigned long tr;
>> unsigned long safety;
>> unsigned long return_address;
>> + /*
>> + * On x86_32, all segment registers except gs are saved at kernel
>> + * entry in pt_regs.
>> + */
>> + u16 gs;
>> bool misc_enable_saved;
>> } __attribute__((packed));
>=20
> Isn't this just kinda poking at the symptoms?  This seems to be
> basically the exact same bug as b0b592cf08, just with a different source
> of unaligned structure members.

Yes, that is exactly the same bug.  That's how we figured out the solution =
in fact - it is totally the same problem with another struct member...

> There's nothing to keep folks from reintroducing these kinds of issues
> and evidently no way to detect when they happen without lengthy reproduce=
rs.

Correct.  But short of adding asserts / documentation that pointers must be=
 aligned or kmemleak won't work or fixing kmemleak (which I expect is not t=
ractical as it would become a lot slower if nothing else) not sure what els=
e can be done.

Given I cannot see any alternative to fixing the kmemleak failures I think =
it is worth applying this fix.

Unless you have better ideas how to fix this issue?

What I can say is that we run a lot of tests with our CI and applying this =
fix we do not see any kmemleak issues any more whilst without it we see hun=
dreds of the above - from a single, simple test run consisting of 416 indiv=
idual test cases on kernel 5.10 x86 with kmemleak enabled we got 20 failure=
s due to this which is quite a lot.  With this fix applied we get zero kmem=
leak related failures.

Best regards,

Anton
--=20
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/


