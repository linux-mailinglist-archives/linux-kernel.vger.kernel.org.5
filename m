Return-Path: <linux-kernel+bounces-120664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5688DB35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9C329A0A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72FC4C618;
	Wed, 27 Mar 2024 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="R4VVYVnU"
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11020003.outbound.protection.outlook.com [52.101.154.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DEA364B4;
	Wed, 27 Mar 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535246; cv=fail; b=K0A9lWHIW5rOMiJGRIo1+6KJ1TmC3PA+UwR/tuCSFGJ1kvwIN+efqEpHXCOBnF80MTS6jJI/Seak8K3VWH3zpFseeLGd+y+IqSsCreWYgy02UDkTsXb/yr6J11aLyyeYQHgYRVM4GUk5kgkbHQsh8ddzQtep89b5+M+vJUjZO6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535246; c=relaxed/simple;
	bh=gvsZwl4Agz3we5KYG34XkmAypi+w3fqiM4JWTlk97OA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uuaIEjgSzIWnL4Ji+unrh7lVrPFGmTali4bP/3E413LrRrp7tRmrsGAqQr2vHouVkF9uPcudtZ3khe24qqD7j6is8GK3SjRL9Wb5aBHIDNQDa4O6p8O2Yhv06DhqTCkOh0nzo56kfaXOxKq8XuLjllhInHL6kgXwtTOMseoF9T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=R4VVYVnU; arc=fail smtp.client-ip=52.101.154.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5cYIZ8hcr5kGXLdxyszemSnfjk3BsxzVzEYPkzC/28wiN7Iz8pcRZt16iYGIaibXyY9kbjprgjvfuvhjPHHuM+YANds7nJdPGGPruDCH8Uxm7H9lFB4b36pBpCs0tyHksyqdiUngag2BuwfqQFtbjZH1A9O5A9Dv96H3RZId4O3NvDeXGEI3csJn3OVBYDkP6INGBnaOvfyTlGSL3qRAgeo4tq6mbaWFrBNSUfAgE3sy3/CBjq2Z+FwP/DjCp/T+uXkYwthyBrEQM8nlUjNVJW2xa/nTuXad2zgrFEOxC9WNyhGHaLtf/RiT7HX20+dcJKE37YkC4t0zWWiMU0OIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ypcpq03H3vP+DT4MKt84e/pku1XEb8p3Rn/wVqd8PPA=;
 b=mBPFV8oVfnP4nv4BSTqgxuct63dOLsCZa/2HPqUwEBH85VdDJa+GZ58QtmsK4RvkBg1nAOc7yPdzvYtP/igX7HjFO5ge5QQ4q5OEoeWMv5nZeEZZNFOT1CIocwCgRuxXMnlrwoF62IxMb1XrMjOHUvwmzx1gNEiKc5YAMdFyBlgPgagHS84WHN8U9Fn7ZPBhzzh9w17Bt9I6hZkpfdHCqSolf8evs84awOEb3SnRzebcM/dLr6hx4529ic98VX3qZDRznEL/OOHCrS1fixeJe2Kjlgq0hHkkHHKHs4w5kjC/GIIgf2pNyXHAReALH2jiAz8cXlYrm5vdqinAlegqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ypcpq03H3vP+DT4MKt84e/pku1XEb8p3Rn/wVqd8PPA=;
 b=R4VVYVnUxnrwZH685JaDi5aipJF0vqB7QKTHsC0qiafGh1e7MK6hml85CFEfXK/9UVNcb6qMfsw/vDF6yRxnet6QeXUvtu0wDCIiwK/a8m+ccifObBmiomuYe4auZ2B339hCzsgAtnM5nk97pDcCYq6imGXcB6HBQMPccX5HTw0=
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 SE2P216MB1796.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Wed, 27 Mar 2024 10:27:20 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7386.025; Wed, 27 Mar 2024
 10:27:20 +0000
From: Nas Chung <nas.chung@chipsnmedia.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, jackson.lee
	<jackson.lee@chipsnmedia.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size" DT
 prop
Thread-Topic: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size" DT
 prop
Thread-Index: AQHafn94hZZm1U4NUE6FWrHOISEj9rFLXGrQ
Date: Wed, 27 Mar 2024 10:27:19 +0000
Message-ID:
 <SL2P216MB1246537DD623B813453B28F9FB342@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
 <20240325064102.9278-5-brnkv.i1@gmail.com>
In-Reply-To: <20240325064102.9278-5-brnkv.i1@gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1246:EE_|SE2P216MB1796:EE_
x-ms-office365-filtering-correlation-id: dc07c02d-a41e-4f0b-b33b-08dc4e487bb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qMhj7sFKUJWWf5+BBIPPUPlz+90DYVHoIo7C0SCpctOPzaQSLqakb7KM60w4nNFQWmsZZMnTWZiyaGEaVrCNf6C+Rc4aVtOiXUlURFitlpbRWN+fDCxP+Rqpnt0Z2i8FrgxiPsCQkwSbs5JsQLkI7cjoEln+r+I8bnI+PYjbOyFSt0rkaXnoOW2YMgROHdOJ+wsxRKmVBl7wc7qwDsL+SYOglGeqCfSLKCVkDLgVadT+VdVgTjJPG5WOmeHAWLKzJrhVJZI8h0SHtBUaDbWEQvYPWwcFPaVRiS9oV30RFstmNiVhOkb/JnmsQNKClkdv4I/so8cPy3mUHBPFftbAyveJ2rg+SDPUxtvC/3ssad1q0NcJaKgO9YmkWtpFbkNDH+NfDuGwMmLBfuGYbUX3Uh0nS5HNSk8oFS2tdC0ZByMoWUIDtaJr8SWjCaEsTmqb5HrtsDAe0JqUzPXtv9vkUyAwgOk6h/TkcDEvrCt/7MZ0W+yNR4KnqzFzTTZm1A/UZ7n+np39JW66mO0v/W+lQb+ONaSHiwwp63bNgtFNX0gunrgWjgUs6YRevGtm8J03YfZ6hrIHnkb5VAjxbtNRsKztvD/pzo4klYMDgAL2BGybFw0m/lgdJ/CqSLxusthUzn/UDYVs/zhhzCpqriWnRrDPa7xTNDVOv9GCDNa1fTSAgi+Ntt2AR9tvkBK+gows2d2Fx9hjF84AEJAKGq6Pchsdweqlm97EQlCehMHdiTI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gMNrRvT7CWze0ZeGCkj1dItcM/wu4V6xFTWrQGWHFy91tfeAI7KL4qoOqfGh?=
 =?us-ascii?Q?beyTbsLTNvhtYohS5WANVQYlAHLHMO61D2PhowsbGUrhscJkV6f+OgwWG4Pp?=
 =?us-ascii?Q?7dl8ZtANa1y7uhP+sKIwd7VnaXW4RDJRr80FZ5IaVQqZBoypoY0huieR8I/u?=
 =?us-ascii?Q?cbnI66t76RwLFx0Pk+I463TC87YEm7d1dyXmj9oUfs54re/rMoEerNIe/fIJ?=
 =?us-ascii?Q?3k2h/BWP5q4v0JcSptklq6Txgg0A7cHF03dZbZbHKvfbog0jCLTVxf7fqsMB?=
 =?us-ascii?Q?Ga0WtuQW/pC3KrbFEAF7uYh/opNyksCCQg6z8icjmd3WD1q9D0f07yVpt7e2?=
 =?us-ascii?Q?mfqIc5k9EeBL6ICh/UIXGuU9zgqSce2nGZ36+3yFt4lQYugOMi0gAgrQ0LpH?=
 =?us-ascii?Q?4nmJTkFUnN1qee74xsXS37tr9KZZuUPNZQGeMjsew6X0oSeQraNknDI2OOv/?=
 =?us-ascii?Q?AibsonEAZSmw6iddHCi/LmZspAvV/c/8pZC81VEWpSV4NoPb8kdtZjf7nqmK?=
 =?us-ascii?Q?4q/zrPlK5JE0MzcORvZoSDhqEqSJ7icW6ISEnCsfUc+1coKY/NGjs0tnLjuw?=
 =?us-ascii?Q?5mG7rXpcF1hkY0SOfaLIBIS+QvTp59rHAwkqyR2qVZIa9nSex0m4lyj8EPjA?=
 =?us-ascii?Q?OGksNqOh1Me9nnxRc0Zp1YswDfNcxDQNH9WytpTERorCtd+6k71DpaIEQdLs?=
 =?us-ascii?Q?z69I+ojvtOBizYerIuDMn1JDCfymBlymX2GEwok/At0Wntsfe7FNpNGJi8/Q?=
 =?us-ascii?Q?hiTvF7C6gMZBnj34FQLFakOmO4wxvbzenIAby7stfTIXKd6zLRCeDLMvnYM/?=
 =?us-ascii?Q?XR7BMEwSSLxLiL82hfXhoYkMZlIZicNszxJgZSRHyB1e9aZkWkfIdUC9xR9q?=
 =?us-ascii?Q?5nPNgMqZSXPKUkoDRr7p8Q88uulgzSITYGLzzZUppVC/Zj/pvxAZcXVYEryS?=
 =?us-ascii?Q?JNxRQtskMLRhZH4OOjTinS1fvJmIPcpeugMy20vb9BCIc/b6hOFcSJT45xfS?=
 =?us-ascii?Q?qTNhr/IzPm4Zo482Pa/KymnRH4Q9u0nJkqMzPyfSRdfrkCaDL8nYoqZ45Dn3?=
 =?us-ascii?Q?bkj6WodZT70ZfXaJ4OcDCq/q5K1SsWHgIZLe46s4Wr7r8ZvbR8DGg7Ewy5UE?=
 =?us-ascii?Q?vDmlsmZhhZQP5PqlvNpJqy2GclQ9wSyXRi1HOk2OT8G499XHozjsKHAbWQH0?=
 =?us-ascii?Q?hm50QHwtRC4Jxya4vvV5mMzQq8ahKyvoNHrTQiK2iZ3kVVm3y7oY1RewmDY7?=
 =?us-ascii?Q?vd8kinyRJi2ueFq+T0g7EnKww5DPSfRnSdJGY0ucvjBw766yUO9s5XvluvSs?=
 =?us-ascii?Q?axtS1h8Jee+nkc+axKpVqjbGd3inZGHawcq+LIGexgugWoD227glWQJHk9iS?=
 =?us-ascii?Q?z7zQl4IHl7CfqCzV226gzN0WZWHI/7F7Ljs45He/Vy4QgrxDXAuR6oIuH2DB?=
 =?us-ascii?Q?ja1ONRDyv6td0AoOUMHj+mhD43gCTM+IC5UgAdzv3vveCpOSzIcEcOOtMZtG?=
 =?us-ascii?Q?t7OiPyHdy2PvTLtGZUG6PYZkNOasyfNePJbSACqC85A7b7/MVK86qaJ5L4wV?=
 =?us-ascii?Q?BW4xEgfDXW0G3tYk4D+9ysntC5Dq8IkOUW05Ibsk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dc07c02d-a41e-4f0b-b33b-08dc4e487bb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 10:27:19.9469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jivZ2/8sM/vnmCWkDm3ijE4POk7tiSZB/T5wdD8vdu5S/eoSJ18Mi1DC8QugenFqVHyeV+vT9sFNsIaMs5egPWJovm/zctE4y9mmBlfeJ7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1796

Hi, Ivan.

>-----Original Message-----
>From: Ivan Bornyakov <brnkv.i1@gmail.com>
>Sent: Monday, March 25, 2024 3:41 PM
>To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
><jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>;
>Philipp Zabel <p.zabel@pengutronix.de>
>Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; linux-media@vger.kernel.org;
>linux-kernel@vger.kernel.org
>Subject: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size" DT
>prop
>
>Use all available SRAM memory up to WAVE5_MAX_SRAM_SIZE. Remove
>excessive "sram-size" device-tree property as genalloc is already able
>to determine available memory.
>
>Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
>---
> .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++---------
> .../platform/chips-media/wave5/wave5-vpu.c    |  7 -------
> .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
> .../chips-media/wave5/wave5-vpuconfig.h       |  2 ++
> 4 files changed, 13 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>index 3809f70bc0b4..a63fffed55e9 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
>*vpu_dev, struct vpu_buf *array,
> void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
> {
> 	struct vpu_buf *vb =3D &vpu_dev->sram_buf;
>+	dma_addr_t daddr;
>+	void *vaddr;
>+	size_t size;
>
>-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
>+	if (!vpu_dev->sram_pool || vb->vaddr)
> 		return;
>
>-	if (!vb->vaddr) {
>-		vb->size =3D vpu_dev->sram_size;
>-		vb->vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
>-					       &vb->daddr);
>-		if (!vb->vaddr)
>-			vb->size =3D 0;
>+	size =3D min_t(size_t, WAVE5_MAX_SRAM_SIZE, gen_pool_avail(vpu_dev-
>>sram_pool));
>+	vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
>+	if (vaddr) {
>+		vb->vaddr =3D vaddr;
>+		vb->daddr =3D daddr;
>+		vb->size =3D size;
> 	}
>
> 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
>0x%p\n",
>@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device *vpu_dev)
> 	if (!vb->size || !vb->vaddr)
> 		return;
>
>-	if (vb->vaddr)
>-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
>-			      vb->size);
>+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
>>size);
>
> 	memset(vb, 0, sizeof(*vb));
> }
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>index 1e631da58e15..2a972cddf4a6 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>@@ -177,13 +177,6 @@ static int wave5_vpu_probe(struct platform_device
>*pdev)
> 		goto err_reset_assert;
> 	}
>
>-	ret =3D of_property_read_u32(pdev->dev.of_node, "sram-size",
>-				   &dev->sram_size);
>-	if (ret) {
>-		dev_warn(&pdev->dev, "sram-size not found\n");
>-		dev->sram_size =3D 0;
>-	}
>-
> 	dev->sram_pool =3D of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> 	if (!dev->sram_pool)
> 		dev_warn(&pdev->dev, "sram node not found\n");
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>index da530fd98964..975d96b22191 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>@@ -750,7 +750,6 @@ struct vpu_device {
> 	struct vpu_attr attr;
> 	struct vpu_buf common_mem;
> 	u32 last_performance_cycles;
>-	u32 sram_size;
> 	struct gen_pool *sram_pool;
> 	struct vpu_buf sram_buf;
> 	void __iomem *vdb_register;
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>index d9751eedb0f9..9d99afb78c89 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>@@ -28,6 +28,8 @@
> #define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 128K, AV=
C
>40K
> #define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
>
>+#define WAVE5_MAX_SRAM_SIZE		(64 * 1024)

WAVE521 can support 8K stream decoding/encoding.
So, I suggest the MAX_SRAME_SIZE to 128 * 1024 (128KB).

And, Current driver always enable sec_axi_info option if sram buffer is all=
ocated.
But, we have to enable/disable the sec_axi_info option after checking the a=
llocated sram size is enough to decode/encode current bitstream resolution.
Wave5 can enable/disable the sec_axi_info option for each instance.

How about handle sram-size through match_data ?
I can find some drivers which use match_data to configure the sram size.

We can use current "ti,k3-j721s2-wave521c" device as a 4K supported device.
- .sram_size =3D (64 * 1024);
Driver just allocate the sram-size for max supported resolution of each dev=
ice, and we don't need to check the sram-size is enough or not.

Thanks.
Nas.

>+
> #define MAX_NUM_INSTANCE                32
>
> #define W5_MIN_ENC_PIC_WIDTH            256
>--
>2.44.0


