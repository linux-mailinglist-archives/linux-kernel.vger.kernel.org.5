Return-Path: <linux-kernel+bounces-106753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D83587F31F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7611C216C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5225A4C9;
	Mon, 18 Mar 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Af2qwNAf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hAPVRlKd"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102EF58211
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801222; cv=fail; b=hHRq03w86E9xtGvzmdJOZAcqXDBJwh8U41rvr8pf8yAqZYoEtgPkAlxEd094w02pXMycB4XNiNq+4Xf1+bLGATMY3QfR6RiGNpanOPBl8vtLdfsHVKSd5dMBw1A5R9Jp0YoeeZH7o0ZofZAQ281sr9EpcqF7GMZ1lJOUltItH5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801222; c=relaxed/simple;
	bh=dk1CuHjo7qZ/fgsajmP62cRYLq20eEIj5ZVgV5X2Byc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZiCSWfjFrGGOnJVlLgSHDWGjehcws69pTc5Voa5OnLLTM0pPAuRFP16FdBCV6+kxh9qqWRT7z4mtfAwVbrYcaxdL6ZDM9Rda4G6GCsZS4rTA1MQ6MMQpQoJVD2kAokq3fmA4MmlIkGcPRv5Htukhi+NhfDWdXfTS97QIUvY2Ork=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Af2qwNAf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hAPVRlKd; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710801220; x=1742337220;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dk1CuHjo7qZ/fgsajmP62cRYLq20eEIj5ZVgV5X2Byc=;
  b=Af2qwNAfgfgN6H/1jmXRP/f8vimPT8FJ60cmgbAHFV+Q+2AWQj3GjKNJ
   8qCKbO6UfbLcXEaHDWWZvHIzJkIlT6AxjNwxhJs4Mttw8iRPLXOZ6PSAz
   ihDwR27+IaJMlEQ+2gTXfVllg/61cszBK3g+ISGMmWUnlzclIVPXQ8YWl
   LYzROxBT/2/UizbPZrybcb9WZtORjARcLikCURjJgpv3Pv3yzEUa4czq6
   E7rn9KrHLZNsLKmoEaPiSKCabVW7EzjOWsR/CmQNgzoNm7TBcHkyRJfkn
   fPqQrded6sKSYVOLYHOHng3wl9g7XDEl+3K4lCOY86Ak60L+DuJnSWZgl
   w==;
X-CSE-ConnectionGUID: ZVZqlmr1SkKxs3ycXT17Kg==
X-CSE-MsgGUID: g+nCcpeDQf2cCtWyACW3fA==
X-IronPort-AV: E=Sophos;i="6.07,135,1708358400"; 
   d="scan'208";a="11892678"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2024 06:33:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK4PJD6H1N3n9I4sW73pnU3jQ/GkkAh+TNT9D3I2RaiVsLX6qf8sPVoO+x+m+NoWPvGoa162B+uZgCeILnfs3iI1m57WU1CeayTYFXDrudbtmynEFIVrb8mLFou9fOUKgm3giA0MdvOw3MJKumQM9SZzhd/xSMAxGf2a6xfeHb1oN183aI0+BxfvCvqGzO/29665pid/ZFDuP90KYIuhzNs6ssQ1OfG5ID1ZjClgPcv/ZLezK4/6/kNsRUaEypXTgt2HD3BzYUVZ/BlWYt9lN1ambAPUupiadZVqWZKTPFVd5xGPIKld01vgZELJjtFydtVhynh0CC1aBOAPgsdtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk1CuHjo7qZ/fgsajmP62cRYLq20eEIj5ZVgV5X2Byc=;
 b=dgHKvHqRj0LwLQB9dXXWcwe85sLVeHvDgj6dIQsAUyGhvoV+EI/wc7AZLlVkUdgOXFJ29UAZvpd4eTq8aV25s2X9znJqWFylBRkPa3BojfmBxjWucFyPMvtEMle4aB/vcMnYTQtb8NarWDHt8HUWxx2zJKiRwEole0wxCvq6e/ZnRPSx/JFH4vLhwscPOjrbu3MnXGYdEqf9uQ85ZfnoUHkaKFMzDKVRC88epca0YgzhtJPA3ITOuLSNGv7VvV/1b2xnZea0Vp54Pn08geATdAovAjfvyx+Lteylnu0V5a7orm0xrbEePtAb3STPSj5PQxTWOF51sOiBqp582nyx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk1CuHjo7qZ/fgsajmP62cRYLq20eEIj5ZVgV5X2Byc=;
 b=hAPVRlKdPzx7fzOFmMiZ7Ai0ItVYNLETJsGqScqKOLhkCBmlK5yUWVqnPQx36Ojjz6R7ZW5z/0RPlaMrXBDCNb2qoZC+ZlSkmWBnQlPmiAI9xYNbQKhDBOWpe1XO6SoYLndgRt1lh+RCKP0ureQwobwtWbzVKC+08qkKxOH+cVs=
Received: from BYAPR04MB4151.namprd04.prod.outlook.com (2603:10b6:a02:ef::28)
 by SJ2PR04MB8560.namprd04.prod.outlook.com (2603:10b6:a03:4fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 22:33:30 +0000
Received: from BYAPR04MB4151.namprd04.prod.outlook.com
 ([fe80::3fff:8c2f:81ff:c80]) by BYAPR04MB4151.namprd04.prod.outlook.com
 ([fe80::3fff:8c2f:81ff:c80%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 22:33:30 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: WQ_UNBOUND workqueue warnings from multiple drivers
Thread-Topic: WQ_UNBOUND workqueue warnings from multiple drivers
Thread-Index: AQHaeXhd/UIUk2VZGEG0Qh+3CF4eQA==
Date: Mon, 18 Mar 2024 22:33:30 +0000
Message-ID:
 <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB4151:EE_|SJ2PR04MB8560:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GlfznXczxyp+w26QsRmkcn2Woc35TWtVPNnyhCWkWyR6oTpH/gH2ir75Wh32rlA3eNfLaLNv+yxMdnfUWCxB9NuGMZyF8/pkUC5wpGD9HnVYCO/b68Yse26Cbi/jiTojebKhnsCyuYSMzPbvLYHkqhBtJihyuHr0TvHDO/2zrPXYi6WwDEgrLSAuSHGm+cOfRkoGrsauo1GrRwU2qbo2e4kkkS6mPdsDU1eQPzWhaLBmHw/eNM51upC/ReDxDro3hk8IbNCkp2lmQSVupBOhGCXlUDZ/dYUCQJlOxypFy3tExW666jYxVZZ1+Se/V6n40S2Kks/G5Cd7DUcBDQeG1MiOJ9YSZCjA0boXcooExDaanNWvgwMHFXRzms27Q3Kth6HxK8/OyGhVxVfkL+ubM0wLhwk2WW4UV2YIxGxFcVFh0jJdsi5pLmxu2MjX13+qTKo6VMnAqpYtO+NK+KvMSjme+gOjw1Nd4tWs4uPjtwz0QOO3PY2zgpKSUsm6Znk9jI33VDbrmfYdtz+plMuGfXTjnrZuRTvuhi+zFqn8KL5alTirPtKeGPdi3gx0ZOCb4Xu8DVQlN3kz5NUXDygkC9BlQR/RVM+S9caAoi33gtA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SlthbKfdYqc9gTXsLjW9oiuffrdn2A3Dk70fDy2eBgKlt8mpiZWGGGYB6H?=
 =?iso-8859-1?Q?iJcaa8nnJromVAh7iLCEU5XmqknBrddvimEBy/XgjWjLQxf5ZWwupg2smQ?=
 =?iso-8859-1?Q?2/Owq1/kBlU+evvTLBD6kDH6Qe8eDJyKe1dLj96ZYx7y72OjOZvb3kSx2I?=
 =?iso-8859-1?Q?NO4qQR0kcBwHtv7t92ALNMaAwBaGnbfaj4tueuGe6F6BeBQNvdKVLD7OD8?=
 =?iso-8859-1?Q?9PaqCt6EEVHeqqzEZ3RlavTx/4aHwPKauF4VeXpE/7fq+Q1q+cLhIO5m/y?=
 =?iso-8859-1?Q?TRDWy9CAiVj57G3uY2aWYaDQ0a0azdz8hnxw92YCZJPMolvzNhRdIXAvgp?=
 =?iso-8859-1?Q?vmsyrbiQysYcF2KnXmVqms3NXXU5VeNhGO/LSyfQuDNB8BIxVSwh3AIx5O?=
 =?iso-8859-1?Q?hio5k5QrBwpbgoD54o+1ZJvIrcEOx56qcwUABcMWM+7c1Ccy0z5qbW9mw1?=
 =?iso-8859-1?Q?nn+jiBRr95RqbJ1laF+hOW4nhV26fF0QAUYBP3LM5Fm1LONyxivIYLrmeQ?=
 =?iso-8859-1?Q?AjrX4t/Wti2k/XocAl1rV5/A4TAGfer050uoi470Uzkke1ShpdmigMHW2z?=
 =?iso-8859-1?Q?lPp8NqJpCw1VcPJP6O7h3SPkxI+EDgkpJI3gVYU3v6Jfr95+nzQrzAYOPC?=
 =?iso-8859-1?Q?6TotvKgL5iGDyAgWvafthRir8H18anhIJLunJnlxn1O21KxyffHaZMrFMI?=
 =?iso-8859-1?Q?eRuXs20PJOyrUmw8w4AQQIPAaR/Y5IJ4NGQGhDpn+hUIhdD1Kkqlbhc4Hu?=
 =?iso-8859-1?Q?WVxDzok0iB30JRgnWSlx3zp426g65WxWTeyh3cFXDY0rGXpC2MfdMgNtRY?=
 =?iso-8859-1?Q?9sXjS0Y8RCWi1BD+NafLLoaupHqySWhAFdJJgOWYtwOOH/cyrwlGdjTznt?=
 =?iso-8859-1?Q?tEPDmI7aFEa3BQfJDbaHGxkAY/sM1FejrjrekU4EoMdgUBMiPkYE7rWksR?=
 =?iso-8859-1?Q?AMg7JnDxRfHUwUrg3OoKcpAQDK+WcPx1YxM076DThkD6EILZxWLzPV8HTa?=
 =?iso-8859-1?Q?FUtxeRnBcw9JId9IH+RtInW/EQU9wsEXyXIyhGaFaJF/i3jJoU07hXvGLb?=
 =?iso-8859-1?Q?pohWqXGhcB+iT0RjQ/6MoSa/S7Dr/7nPzjOL6zitV3v37dhU+BTmYYlECf?=
 =?iso-8859-1?Q?0X3Cvv3o8dvbzLgj/Bl1JJMytCWC2zqNR35R4DkllqGQIK5f0maNTCOFy+?=
 =?iso-8859-1?Q?nH/dynqwrb6eJBhAvMrXSRpdDqUpOqA9lQLfNE67SH9cpbWSIrvb0cH8z+?=
 =?iso-8859-1?Q?yb6WkI9nrRT0tyMJErkACzjJFxIZtCGc6Wk7KE4ykH2vnqkJ/jSAY/TwTu?=
 =?iso-8859-1?Q?QkwRYG4Fo8OCvEd5e6FSE6ZeaFc3SMPnD8ey6HmBvJrygyHaqRbVqcfEPr?=
 =?iso-8859-1?Q?uA9oCp+G/PqUu1ycK0QkvX/mqUMzx2cLM52SaXr1aG4q0OQ/8vxURuN4VQ?=
 =?iso-8859-1?Q?HdNpO4THr6KaAfZOj9qNGphh0IIPq59zJI3UJpnuTeQ16OLlIfjjT8twTH?=
 =?iso-8859-1?Q?mkSr2Eggxhwh7eezsxrM/54dhU6Qf4x0256FsGm0Sk5dcLFHWAKfZTrfg1?=
 =?iso-8859-1?Q?ngDw+2cm0q215DralztPpIkO7SWJ/xU4KLBRmZmCaloOzoCj+NrJtgJPab?=
 =?iso-8859-1?Q?LweIx1pa9hHOD3zSkpcTJYQodF/OI/R2XD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YWsK1Q2IHfERadq2ksOMMONvYeFtXU/fpiIcXLhyGV2uoGgJwtoR94a08KZE3JReSi6dTxBLgxmboXyKrMlOxEjxEJZh/FojJxAg3ZQkK1ww4MTYrNuUKCBst07kHWab8dikY5H6pR1vvGQhLpH/IZssl1fyTSRB2nNizwqZbQhSS+q8LoVXXWmkcgOJGpfyZf4xiPKJOuI/f9VMFm2h2hIzbU91bKkPpN+lvQxLA5Dm4i0fKBVWd3uQYhImSugEI8+ACRHdI9PsG+qJbMaEhthgiXdmf7dmCc00Kq5dv7wzN0fcgcEwZm+0yzdZ+CdPaTf68AuoM8PGTO57v+nIhli1UuMgkygUeKeb2kLek7T8nGCLuv/J59VFlYzesoLib3RoHUW3O4zrohSEXkP8YzuNWRmLlCKcQE9OO8HzcngwIAa/fGx0xW+5FHe1Qq7d/KLjlvHZ7ZTiIp/UPLDLdzZDbKHTgtVoNGQmwYSs2ubA53pXCV+alkcp5QzUIXoFXc9PC1NW/k9dTSUC+7G/JhkpQpA773j6qkmczwVR0KkxfyqAmLnCC0gLPRgZK6+4iJPX680P1Y1tUqC5DxWKlCcE5oNSJgeBejO61bz5a3Ni0qhO20tqFocehIw7+KOt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e56b2ce-aec8-4506-b9cc-08dc479b6fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 22:33:30.1070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cs+rFmDZu3Fs1CXfFKH7vxWh+X063zg+gZQSDUq7b5s4sjUN3zQsLwtczuOZfG1J43kLJfGb/XRF3v09fPJ8TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8560

Hello,=0A=
=0A=
After switching from Kernel v6.6.2 to v6.6.21 we're now seeing these workqu=
eue =0A=
warnings. I found a discussion thread about the the Intel drm driver here =
=0A=
https://lore.kernel.org/lkml/ZO-BkaGuVCgdr3wc@slm.duckdns.org/T/=0A=
=0A=
and this related bug report https://gitlab.freedesktop.org/drm/intel/-/issu=
es/9245=0A=
but that that drm fix isn't merged into v6.6.21. It appears that we may nee=
d the same =0A=
WQ_UNBOUND change to the nvme host tcp driver among others.=0A=
=A0=0A=
[Fri Mar 15 22:30:06 2024] workqueue: nvme_tcp_io_work [nvme_tcp] hogged CP=
U for >10000us 4 times, consider switching to WQ_UNBOUND=0A=
[Fri Mar 15 23:44:58 2024] workqueue: drain_vmap_area_work=A0hogged CPU for=
 >10000us 4 times, consider switching to WQ_UNBOUND=0A=
[Sat Mar 16 09:55:27 2024] workqueue: drain_vmap_area_work=A0hogged CPU for=
 >10000us 8 times, consider switching to WQ_UNBOUND=0A=
[Sat Mar 16 17:51:18 2024] workqueue: nvme_tcp_io_work=A0[nvme_tcp] hogged =
CPU for >10000us 8 times, consider switching to WQ_UNBOUND=0A=
[Sat Mar 16 23:04:14 2024] workqueue: nvme_tcp_io_work=A0[nvme_tcp] hogged =
CPU for >10000us 16 times, consider switching to WQ_UNBOUND=0A=
[Sun Mar 17 21:35:46 2024] perf: interrupt took too long (2707 > 2500), low=
ering kernel.perf_event_max_sample_rate=A0to 73750=0A=
[Sun Mar 17 21:49:34 2024] workqueue: drain_vmap_area_work=A0hogged CPU for=
 >10000us 16 times, consider switching to WQ_UNBOUND=0A=
..=0A=
workqueue: drm_fb_helper_damage_work [drm_kms_helper] hogged CPU for >10000=
us 32 times, consider switching to WQ_UNBOUND=0A=
=A0=0A=
=A0=0A=
Thanks,=0A=
Kamaljit Singh=

