Return-Path: <linux-kernel+bounces-25764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96782D56B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD792817B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA977C8EC;
	Mon, 15 Jan 2024 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="lZr1hdGV"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2049.outbound.protection.outlook.com [40.107.113.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FDBE74
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB3AmpTSQMhp99sOSDcizcRZajqSVT8yGKtT9YbW+4af+/XDnF/31jvxW6qIse6+2DA6VuhBtFu9F4vPoFu1jzz91Sq4+7HfTxtj7EDJAWuWOeWB7uzNlFDI7t9uurh6vBajDRZHI4NPmJk3BLziBlG74y1GNcKDiI4yiWNSBzcA9K/JJ7wIt9rrkf2Qc30TxDSx24sDZaJlF1fCiGpnl/ALEQzFW9Y/6E7ykQfQAyr8qFrTQOm5SP6cZKm5tL7A49vf11kxK+IVKiWYHMUSVUH6i9beeDYGou8CYS6rhCQBxbniRnBiwqU9S4kSq8Ql5WElJnAk3YTcIgWkTQ59dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gfd3tb3MHJm1QZloPaleRRQUBcZ+caHeEImd7L+Z99Y=;
 b=KzBxL4LSh2A8hIV9J1PpPxX28u5RFy2xcoorYTa2QfZtffihGwFPWOJAQy7yYM0Mr4W3uag2X670zXdZmeztuMpOkKFk2zIPTWzvuXFHXCumH7huiPET3CL/nzp4qtivUsavtCVgKL5MK7FuMEe7LNEoZfc5viq8PNPkQ3yblMLwNQa62BeNavG8/LKWuA9e2bkDPsoujMsyiBMwSZqlIXuOyRv8W1hdIwdjeG7fhE0oHEXCKkLF7YtP9Puz9JV/hcjWnFFdgOl/E8g0w6EJuHriNca/CRffXR9cQtjQVuCfmiWtE2yabWa+XhjITYX6yR+lptwNGbXs85pCa6RTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gfd3tb3MHJm1QZloPaleRRQUBcZ+caHeEImd7L+Z99Y=;
 b=lZr1hdGVFCIB8o6+v1544SbbAi4PPHfcRbFYnUh18RiBk3pSLP3ZGBJDkifczT605Ec4v598XH1RTjcg+MsmTBAMamV8vaLRvSsdJKU/cK9bPdmJXp/Jo/VDr8n3UdgF5FT2LskfpIORx4gw2NwxKW8tYknWAspVxMxXvi7/kmtp/B4hmPE3lmksl7vTYs2x8159McpzEcY742VcwzUIol23y8L6vyVQO6LTkiDMe7EDdl/f1Khm10303xfL/fkObbpgQWIsCHxF+TWJ1RdsRiiBHoG1lkMonpUP6P0nYyhcz2UKJ0tO8TSwMz+/BHR8VWvIMX0bLarLZop6uluoyQ==
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com (2603:1096:400:15f::5)
 by TY3PR01MB9825.jpnprd01.prod.outlook.com (2603:1096:400:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.15; Mon, 15 Jan
 2024 08:57:45 +0000
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::97b4:ef67:3174:a230]) by TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::97b4:ef67:3174:a230%3]) with mapi id 15.20.7202.015; Mon, 15 Jan 2024
 08:57:45 +0000
From: =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?=
	<junichi.nomura@nec.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"david@redhat.com" <david@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "debarbos@redhat.com"
	<debarbos@redhat.com>, "jlelli@redhat.com" <jlelli@redhat.com>,
	"lgoncalv@redhat.com" <lgoncalv@redhat.com>, "dzickus@redhat.com"
	<dzickus@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] x86/boot: Add a message about ignored early NMIs
Thread-Topic: [PATCH v2] x86/boot: Add a message about ignored early NMIs
Thread-Index: AQHaR5Dobycx3oYC4EWPlFRq2PJefg==
Date: Mon, 15 Jan 2024 08:57:45 +0000
Message-ID: <ZaTziftQSSg/v5Np@jeru.linux.bs1.fc.nec.co.jp>
References: <ZaEe8FC767f+sxRQ@jeru.linux.bs1.fc.nec.co.jp>
 <20240112120616.5zjojjmjeqg5egb7@box>
In-Reply-To: <20240112120616.5zjojjmjeqg5egb7@box>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8389:EE_|TY3PR01MB9825:EE_
x-ms-office365-filtering-correlation-id: 756fb568-fa2f-434f-f6e8-08dc15a80aaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RtTHnYoOH+u+Jy8oK/zbRH9Vb6HfJ8Cdn2cd7mM/C3EK6otKQ/R/GLZCX3r1jLJD7rUA53vK+qyw6tYk1R1xFvC/QVn7T9qsq4OrkYVHWiK4xMu/T3QMmwX9Ex7dSfOvxBJKapZJD6p2ck4eoyvdHkkC/SUwEPbcuTzcZUQo/GjK3RYovj8AaAV0jiZ2yDkZXM2ddw058Xg8jhCO2fKXTXP/iNUYW8O8cB3YBtGoOSDvgVuhJenrZlgeIi4f9zGZ0xLvIxNoSxMk4DhtABIB2vAdY5AvcojmQIvA2OgBV9pZ8ByaoR5kyFRMCBuoWk2Ybx93t4vYDjK9o1vb8h6R4q75zoV5wgT84u27mom4n8bztNIk4fxLmOxVLc7PeFn40B5SrRjKgZ19OSswuqI0RY9VDwp+TQCuS2+Pw2VerhIMpw/BAOh+iNGQd2N3y+J0Jevg+lvW6oRh7rAcNefUTPxr86/J+8WdINy3EnfB+ZU+bE30QqxgG5mJWgIpy3QTwrwQAPs4wB6zwDKNM4DPgECsGdG7vtMEMCxlouoJJKNwIgiJl/I/n748LF7ktHM4urbb3x2L7QOUQDtL5HVDpyBmqdThps9b7P/ng89g3/I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(71200400001)(38100700002)(966005)(6486002)(478600001)(82960400001)(122000001)(6506007)(15650500001)(83380400001)(9686003)(6512007)(2906002)(7416002)(316002)(5660300002)(86362001)(8676002)(8936002)(85182001)(4326008)(26005)(64756008)(38070700009)(66946007)(66446008)(54906003)(76116006)(66556008)(110136005)(66476007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?dDl1TG1hNlRpVmU0QjhpdVpQdjllQzJnMFM5dkxzTDdXQUhLZ05vNE1w?=
 =?iso-2022-jp?B?NG9kdUNDSmVzMGFPdmQyV1hqMWFlbWxScnRiQXFnSWNGWU5XU0dNNEZa?=
 =?iso-2022-jp?B?YXJjbkpEN0pvUWtZNzlubHJ1UERJSnBUL3dVeXhNTUpDa3hqTnRENFR0?=
 =?iso-2022-jp?B?YnU1OHdUcUlaRlZ5eGVDdjZRNnVoaVVoRG5sMStYb0hQSWJXQXY2Q1pt?=
 =?iso-2022-jp?B?elZuTmdtM0IyYlNNM2JKeUxpSzRVM3l0M3ZKQUxwVG54S2ROeHhLaGwv?=
 =?iso-2022-jp?B?emNyODBoRkVZYS81ZXYzeEtBUFpYNDUyR2s2Z2NZMk9ZWERXVzlVZGpQ?=
 =?iso-2022-jp?B?cVIvV0tIQXBCSkVibEY5YnYrQU11RHBqNThJMGVSQ2R6TjJDZXFyVU5s?=
 =?iso-2022-jp?B?OTFDblNLV3N4Yy9KMVhVQ2JxTjMrN2dsblViNUV5S2UvTHpaeTJsaFhT?=
 =?iso-2022-jp?B?cUZtdGM4K3FLb29kT0pIMVk4WUFPYlRZb2xJQTRTNTNQSUwzazRxV1J0?=
 =?iso-2022-jp?B?U0dHOG9EdjQ2dkFEZ3hmVWx4TlRxN2hOVWlHeUxnQzlJamJXbXgwem9Y?=
 =?iso-2022-jp?B?MlBBWTIydlpidWxqbnFyRk56Ry82TENCRjhRcElOOVhGNGpscHZINytz?=
 =?iso-2022-jp?B?YVpMOTlscU9YcVhIdElFbFMvYkNPRHE4bGlVOVVsdU1hLzRZZWhZZkRt?=
 =?iso-2022-jp?B?dVNFNVY5a0IzZlRxN2JsMGZSRzVxYThlc1pRbUZXZ1FuNUhDT2F4T3Ev?=
 =?iso-2022-jp?B?dnZIeWhYUWN6TGxwY1h0VFdxZkVsYy9FNytYQW4vT3FTeWNnNk1qQk9K?=
 =?iso-2022-jp?B?L3hBWWtnOGltRWZ2SnJiVmFOUHl3OUZuVTNOOHUzU3J3QlRCRW5CLzNV?=
 =?iso-2022-jp?B?QnRjZDJlL3FISUM5QjJ5dVNHdDhwQ0dyTDlXaEtaeU1aK0JybXp5Z3J0?=
 =?iso-2022-jp?B?VVB3dytYNDNlRC9QTHVFalpkWkx0RUlPOUlHMitnOU9lRXhwRVNQWlhp?=
 =?iso-2022-jp?B?amJFZ2kwZHd6cTdFT1VoV1VONWFSelBqRlNaUXROTEJrZWNkQ2hmMFR1?=
 =?iso-2022-jp?B?d0hxY05NdlpGVUdxNXc0Q2ZJcU04V2FNa3NYSEFyZXMzYncxdCtPclVJ?=
 =?iso-2022-jp?B?TGdvU3VqOWtJTStTRVhZamZudTBhSmNoZVQ1YStDZEVJTllRdnh5ZHh4?=
 =?iso-2022-jp?B?eCtyVitCeEloZEViUkxSNmFCdW14YTZxR1RMQitHaG1Cc3MxL0RwZGNa?=
 =?iso-2022-jp?B?dEVoejM0UHN5RzJra2dqRitsaG5LNjNGek9qWVVoVEx3WEN2M2dXTmxq?=
 =?iso-2022-jp?B?YzlZYXR4T1I0NEFKZUo1eFRIdkVpMWFXQy92Ny9tWStuOVNsci8wS0Fy?=
 =?iso-2022-jp?B?MXVJQzJRS3JGanJ6NnJBOGF0U1JUUkZHaUMwMm1rZHFFSlVhNXptVStF?=
 =?iso-2022-jp?B?WElWNWczNjRja1JUTldITStZajAzMU13bTNoSEhyTk9VRFIzWkFOaVNI?=
 =?iso-2022-jp?B?ZFhlamo0WUdjYVhTNHU2V09RaDJRM2s5Tm9oM1pPaldUejdTNE84d20x?=
 =?iso-2022-jp?B?T3RMMi9rUlZKRlhZeldUa1QxS2ZlWGxSYjNjRUFiM0U0YzM0TmpjamEv?=
 =?iso-2022-jp?B?a2RDa3I1ekpoVkFZNGRwbXlSTVJsKzFxK1NCNm9kWEthTTNZU3B6dFJw?=
 =?iso-2022-jp?B?TElITU1DMTdpT2dJam1PcDJqL3NkTkNRODNsT2NhVEx3YUZNY085T001?=
 =?iso-2022-jp?B?OUQxOFN6OURLaDFwTUFJMFc2NnlpOUpXSUpwTXVGUldJdmFiTkJXUlJh?=
 =?iso-2022-jp?B?eGtNTFh1NWNndHF3SkJpcStuQW5zc3Q2N05ha2dtQ2UvY3FlRUNnRE11?=
 =?iso-2022-jp?B?bjRkaWFEK3IxdzBwS3kzUGhPWDVmdUYvRk1TdDczMGt2VjBRYXJLWXhp?=
 =?iso-2022-jp?B?ZEd2SjhrQ0lsNERpTHl1ckUvd3lWRFlJSkpUUkVBZ1QxSzA4a1I3WnFr?=
 =?iso-2022-jp?B?R1JGTHdBNjVSRitXbm8wN29IVGRJaWFQZGVtWDBTUHVhcFRXTVloS3Rm?=
 =?iso-2022-jp?B?ODJ5TTQrUU5zRFdtMzBhU2h6YWU3T2VGRXlNTkhyWUJmcmxIR1lwUGFw?=
 =?iso-2022-jp?B?QUNtejIwSnc3eXZJZXQ3bEVOQW9aQzBjRmlIVWEzYldKZUp2aW4zRFFI?=
 =?iso-2022-jp?B?SDkzcEJ5NHoyalFGUGlGWWZCcDBNNElaMzRhVktqNjJhZGxhb2ZuVVVY?=
 =?iso-2022-jp?B?ZXp6QnV2NVZPVjdNQjVINDlHRlNlMHQwSkxzSGZFTmdKWjBIa1F2V21m?=
 =?iso-2022-jp?B?WHd1cmkva084bFBkRWwxaVAxQWJFaExsQkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <A263990B1F0AA340A33305BB220CD1D8@jpnprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 756fb568-fa2f-434f-f6e8-08dc15a80aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 08:57:45.6933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sd8H26Pv2AM9tTMMVdBVtlKLnttnd5ROPsDsDtberAzq1I3Ox+gdwoGeoQXDgZFHl8y1K9hiGDFCDZh7ghwDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9825

Commit 78a509fba9c9 ("x86/boot: Ignore NMIs during very early boot") added
empty handler in early boot stage to avoid boot failure by spurious NMIs.

Add a diagnostic message in case we need to know whether early NMIs have
occurred and/or what happened to them.

Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Link: https://lore.kernel.org/lkml/20231130103339.GCZWhlA196uRklTMNF@fat_cr=
ate.local/
--
v2
  * Moved variable declaration and definition to the right place
    based on comments from Kirill.
    No functional changes.

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compre=
ssed/ident_map_64.c
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -390,4 +390,5 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned =
long error_code)
 void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
 {
 	/* Empty handler to ignore NMI during early boot */
+	spurious_nmi_count++;
 }
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/mis=
c.c
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -52,6 +52,7 @@ struct port_io_ops pio_ops;
=20
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
+int spurious_nmi_count;
=20
 static char *vidmem;
 static int vidport;
@@ -493,6 +494,12 @@ asmlinkage __visible void *extract_kernel(void *rmode,=
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
=20
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/mis=
c.h
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -59,6 +59,7 @@ extern char _head[], _end[];
 /* misc.c */
 extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
+extern int spurious_nmi_count;
 void *malloc(int size);
 void free(void *where);
 void __putstr(const char *s);=

