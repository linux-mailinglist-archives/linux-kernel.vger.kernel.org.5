Return-Path: <linux-kernel+bounces-35722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3E9839595
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFB0286946
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150A8823D1;
	Tue, 23 Jan 2024 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ihzPikPR"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2042.outbound.protection.outlook.com [40.92.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B62823BD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028868; cv=fail; b=U1VHOcow1rJtmxvO4tPDjXdAH0unDJZjaEZ6f98fbDYeRlZ2HbGfx4jiOdI33TlkfYY1sJcqy/CxO9jHJzfzqVRh40wlcfvTR7JrXYWAUsaTv2Mamr7snoNmyeRY/yMZGksVvsl5CH1XrdWlbrxkSDWO1Q6P1P8dpUiJNOuBruw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028868; c=relaxed/simple;
	bh=HSR/DDqbA6FUC7rF+PNQr60sb+OprJkTOODuMHMxw5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DbiMd5UqKLrGkshxIbqlRo5BydlcEt1aEE3QL4A4grfymUA9u7NB1j1UFuE2Qz22FEczR2qzkcnaGWQFQjK9SZ2RsO3ZaBMNZ4gwfuffYCc2F6jDGEObrLjHY3E6okFJ4aIoUdX8UKaYr43oa6Y0xvsRfMf89QT5DZOBBawwtnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ihzPikPR; arc=fail smtp.client-ip=40.92.48.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBbA04WjFDIznZX8StsfTPgUljtuquGkw3JZuvI/X1zXGC2xSpYy3TfpbB8B8CJvujPmkBuoZdgnBmCRuq+GXT+f2GO7eHoEtxJ2D3GW2YdvCYLERKNqvgHSFXmprWFt4Eud04q91M+8rPQ/Trdbi04ZYs4o6DFVJEpPtoEhI3ZDoVsyEKzSZNbKl4lJqKw5owly0Fn/wRx50ysVZkV9XIw7wxuDQV8+0mX5EQdZ0AbUEwgQRGj9jCgaQgJ+6m9gQ8BtVwYGcJOXyX975zU6JDe4gzy+QNJULs9cF6agRhlBOZJSD7mxaj5/mCNuYTdll62llNEDuG73hF+c40AdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSR/DDqbA6FUC7rF+PNQr60sb+OprJkTOODuMHMxw5A=;
 b=NryJdQoueYz3D5bq8wwD75SATlXVg9xNd2JwVCGWxn/UZK7YI43YSVBu9Dx5aIdSPbT4E15bXtqGw053opQA2TbSeUTOWjD2+I2I+qSKJkVfn2mBuOf1PN6UxrnG2RDnBWFLnrtQz0lKvDmYwOS4kA5tB+gVAUkJIPvaV/1qXFNbxNTdVD059GA6eNf3cgj4P2kwr4HtCZXDDGJvVOeYI7N4A83a94k6MO9GIXNjXQH4KMcLF1BdWucKFRYlsHgvZDccwCvsJVCFmsvifYbodklsw+PowYzS3fPRx+s4A9D7AnHd/+iIdF00vznABDBXpRcHNyY9T9yYeJ2kAfPOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSR/DDqbA6FUC7rF+PNQr60sb+OprJkTOODuMHMxw5A=;
 b=ihzPikPR2uJi5znzdZRNi31aYnuxxIRIAdHhkDmx14SK6rqRox84A2kKYIxXJL44Xr1W4Hl9KV5Clbep3YJ7t5nm8937qVJnxitNWnHPH0E9n6xlLB/sqAorX2jNlncjqKxNptUt+vr02nSF2OMPSNLNv39+hoF4MPfTnM/Yr4+XBqStHBuPD0cYBnBiaSzc/jQzWiJubB+lbT9OOxQx2EYTgtqx+L47ugUEeD4hUktP0+6e6TlNhouv86hJknPHqwDoMhETRWWQ8+PWJ9EdmWfgKHRN2Jqzmo60I7EQSJzjjqbSpNRHJtFGglQ7BEnzFh3vkwEG+KPh+7Bo8ttPOA==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by GV1PR02MB10912.eurprd02.prod.outlook.com
 (2603:10a6:150:16e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 16:54:22 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::57aa:f54d:15c1:e96a]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::57aa:f54d:15c1:e96a%4]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 16:54:22 +0000
From: David Binderman <dcb314@hotmail.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm: Simplify redundant overlap calculation
Thread-Topic: [PATCH] x86/mm: Simplify redundant overlap calculation
Thread-Index: AQHaThpRQXWiCILEUUGxft7nq6gEYrDnm9gL
Date: Tue, 23 Jan 2024 16:54:22 +0000
Message-ID:
 <AS8PR02MB10217E3448DF6D70285CA3D1D9C742@AS8PR02MB10217.eurprd02.prod.outlook.com>
References: <20240123163623.1342917-1-dave.hansen@linux.intel.com>
In-Reply-To: <20240123163623.1342917-1-dave.hansen@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [OSpDlOl7VZhcWGYn9SZhyK7c/oNuL09w]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|GV1PR02MB10912:EE_
x-ms-office365-filtering-correlation-id: b036ed89-929f-461a-3942-08dc1c33f332
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 i8YJWSd7DYynIoKWtSbTRKRg7L1QWibEyDfNlqy+vPXmqAEidIH/sgXve4C3gA8pJ/m7PZGRkjJw15Z+4ANkdTDZS2Fgc3PdwI1VdpC3Nkq1/8jMNgNTxsqgUrGZECKC6wNWRLSBYsVyuvzvbzmZ3UHHVpWXK1Xlrjc0YDBwulTe5ghiAaXK9Y2Kjs1mhQqVUB118wbfiQbFLoxyp3K+grD31PEHQqGMgMWXAc6ic+Q32YM0RjMGEJWR5sFqaEZEx/khNsMlMQVgsvDHBSvXx9vM5lyvnsUJZm2tG1B7JRfhSaXLshWMiQGJbk00pCDGi30z4RCaz8niaNuDyJpUHCCDtZ6Z3CSa1YqwUIVPx5QHK+MkfBcZqHDG3FeOBmQqc4Ps6J54f06kbyOzNsDTqoma5zoCGTKDMbh/txkpZsKkK6gSglOSa9HA0RTUKZ0iYn5bgEhE9EB1rXHWrXgjrWq4xodo82YuCdBwXDysI1iQw6JIbM/ZOao1oYwCc5x9BCPh2ITQsQL47SNYY84PnQglba0ODOsK8wK6h0QghDtCAHMHFn1tREiC52/u3rjg
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?80j/c+mLAxkAi7puz0jGT9sdpBy447fVC2LUpqDS5YFs2Qq+46q5xFb3sl?=
 =?iso-8859-1?Q?nBFINBiMxgySirtBbSvfnNVUhDMgf++suICXE0UQqkpHtXTH+brQNxbSYS?=
 =?iso-8859-1?Q?t8suVcrvEjJQ9jP5HHHg1mgR9T/OLML4UkAc0uJzZ1sKeUbG1PNuT7QO7X?=
 =?iso-8859-1?Q?hGBXVRAFHZ99jgokbAX6seewfdw2tHvNPCuKHyE3yY8NlfDQM2YiyELv5x?=
 =?iso-8859-1?Q?KYSVVnnHbQgFmlF0DFCLveySrRNgiPsJmwhYSeSk2fw6b+NEL9Wdkxrewa?=
 =?iso-8859-1?Q?urpCOOz93+KLn63UbePZfele025GKOISCaVsM/LhkOpJFZM9Kmb4SQOCW8?=
 =?iso-8859-1?Q?LMQQ1ZpW7DW9J8EqDufpqtOXL3/uZuVcmVXxUxM30Er5fvIF2rA3sdXY5N?=
 =?iso-8859-1?Q?x8afJ2uHLoQH53fMNmyYNlsh0da40tr/4sy06fa3gBuE9rNupF42as9vAu?=
 =?iso-8859-1?Q?6VYF9lNdgtsntPJtN1ZxcjqibGN5DgVgPowfwj/YjLNka1xL4lv8p5wIi9?=
 =?iso-8859-1?Q?aUwj8HoPSDbn6XYJeby3e3mZoj+anXGz5BZWy/K+fq0p96hDmcX0zqcDrm?=
 =?iso-8859-1?Q?JB1N1Dn9XSqpmjsZZug5XTO09lKDuMRvOc2vYCPOg96pkgKmMm6Et6mk2C?=
 =?iso-8859-1?Q?kmUL6mhmDCDDUfOMC+mMeBEKWvdqjwuBWuqfujmxGQgCX+YZlnGDQuX0EH?=
 =?iso-8859-1?Q?LPA9V3mqueyh38pdcNodMXQ/edQKY0qjznh28pVgEaHXKbp+nRBVa5m8Pz?=
 =?iso-8859-1?Q?8Z1tjNpJ+WH078P/IhEkF/+NUvSoAjFyvIGx5cqFDgk9JO/lrqN0vno1k+?=
 =?iso-8859-1?Q?eIFx1s1LZ9w5RC1M8myo4pHn3JtbkzlumpeVEOGXsslTtsZ/489NJuoyo+?=
 =?iso-8859-1?Q?rnkiicmWyPoDm8pwe0BEYfTdb/Zji5tpUBI3yifTdLzRdST4YEKCcn+5PA?=
 =?iso-8859-1?Q?TRVykz/+HUJLvYDvOr2cgI6pJnKZJlZxNUsokaNHFE4Lomd1rYgJK4vV5z?=
 =?iso-8859-1?Q?7b7LVXP7ddLp8z0w/GBzYxd/j7ZMH7DhPkEIVtH+nmdbCXBTi69HlvwX/W?=
 =?iso-8859-1?Q?K3hajleeG7uydf+/z55KpRIdS0snCp39wCAL3JCZpVslxsp0vzVBvgKV4K?=
 =?iso-8859-1?Q?9/cT6Yb3p1JXrKipS6udmwgVnisGMDEyevxXzp53R7egs2lZzSujI5K2HW?=
 =?iso-8859-1?Q?cL1KAUgzcbVzzS2Ol3c/29FQ00sKO+wmF6WhUMKseBcHMUPF4anvZaTm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b036ed89-929f-461a-3942-08dc1c33f332
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 16:54:22.8437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10912

=0A=
Hello there,=0A=
=0A=
>Remove the second condition.=A0 It is exactly the same as the first.=0A=
=0A=
I don't think the first condition is sufficient. I suspect something like=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0 return (r2_start <=3D r1_start && r1_start <=3D r2_end) =
||=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (r2_start <=3D r1_end && r1_end =
<=3D r2_end);=0A=
=0A=
Given the range [r2_start .. r2_end], then if r1_start or r1_end=0A=
are in that range, you have overlap.=0A=
=0A=
Unless you know different.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=
=0A=
=0A=
Fixes: 91ee8f5c1f50 ("x86/mm/cpa: Allow range check for static protections"=
)=0A=
Reported-by: David Binderman <dcb314@hotmail.com>=0A=
Cc: Andy Lutomirski <luto@kernel.org>=0A=
Cc: Peter Zijlstra <peterz@infradead.org>=0A=
Cc: Thomas Gleixner <tglx@linutronix.de>=0A=
Cc: Ingo Molnar <mingo@redhat.com>=0A=
Cc: Borislav Petkov <bp@alien8.de>=0A=
Cc: x86@kernel.org=0A=
---=0A=
=A0arch/x86/mm/pat/set_memory.c | 3 +--=0A=
=A01 file changed, 1 insertion(+), 2 deletions(-)=0A=
=0A=
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c=0A=
index e9b448d1b1b70..fdc00516c0b54 100644=0A=
--- a/arch/x86/mm/pat/set_memory.c=0A=
+++ b/arch/x86/mm/pat/set_memory.c=0A=
@@ -435,8 +435,7 @@ static void cpa_flush(struct cpa_data *data, int cache)=
=0A=
=A0static bool overlaps(unsigned long r1_start, unsigned long r1_end,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned lo=
ng r2_start, unsigned long r2_end)=0A=
=A0{=0A=
-=A0=A0=A0=A0=A0=A0 return (r1_start <=3D r2_end && r1_end >=3D r2_start) |=
|=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (r2_start <=3D r1_end && r2_end=
 >=3D r1_start);=0A=
+=A0=A0=A0=A0=A0=A0 return (r1_start <=3D r2_end && r1_end >=3D r2_start);=
=0A=
=A0}=0A=
=A0=0A=
=A0#ifdef CONFIG_PCI_BIOS=0A=
--=0A=
2.34.1=0A=

