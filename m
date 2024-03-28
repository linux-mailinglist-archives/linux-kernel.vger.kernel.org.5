Return-Path: <linux-kernel+bounces-122759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA02088FCBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5242C1F2280B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B717C090;
	Thu, 28 Mar 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="b1njhYOw"
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11020002.outbound.protection.outlook.com [52.101.154.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C47C0B5;
	Thu, 28 Mar 2024 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621019; cv=fail; b=Ajq8rBRjr+ZXuX+rESY7A0GFwF9+Eeei6d8bzRaz/4TJvsFazNktBptE1vrnN3kKHhEe5vr+GzgSgT5JONVh1RTq65bO6l4maYWGYPIw+54ZHOkMgXRFMVKNMkRY1zE9DXGwAkHfr5ogY4uDyCw3RgAWZ7dxZDECK2yN/SWM+8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621019; c=relaxed/simple;
	bh=bp7zLxhtTOW9PD+jlcR05WUT06DAvhBEtnVLlBFIQMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TSgp7iJxGdr3PjJRQMrmyLXMHpLyDuUF/KVMs61AojMBzrQpLWj/L1eO3pKKy0K0klnaTj+kjXmT/csizgIecN0eQpktp3PtviFKuNG7pBr4c1nHd6Weu07FxBpSgcyKztNI19pPwCBy4XxV4EkNZP7NkYsJxxrjrW4C9ilN3As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=b1njhYOw; arc=fail smtp.client-ip=52.101.154.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWi7IDEH5bL9T9oy9BHQT3o9CdUDFZ1Lvz54IeoHm/9zkrl0tbF/M5hWQy5sBjuMDHle72IMW7ThVqId7em0QJnAgNn2Jq8DE2ZB23dorR8hBHUIrPIMiWGPLCKuXumwHQIm5UIo5e0AxSOnwSVw7PqciIJI2i5vkkVN2ZW9ZO3H1o2JJ/aY/GkFGLH6TI/w9kxk7lShm3wSJ+TlXGlD4wknbE05iaLw2alPrFNeXLkAHhljFJUza9rSd7bb0gWKpj+898kHK94z/AiM9UeYz5Tv/XXG55TQgIALJ4vcmq9XCuux16wQV4LSakWdapfSMatE+NG5kFsOQz/9wSCdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4jS0Bo7AkRlGe92vb28kwO7Pjp1hQgjCSUlu/A9x7E=;
 b=juuxjiWKtWgpz83Kalc/jjQGECsu1onKyoi3DF1455A88lmMSda2Ojlsq3/PoI3UEarUJmyeHK9yB261pFu2tEa6gvpOAr5mUELsDN5gzULIlTqvqg3q+5S81HUxeNKYXz7NnQTfZJ4da3yUXTRtYPUDA8O44rD10dx0DUATG8GeW+2yxh5GtJ9htyfzAfhZkimBYs+A088rlBxHhzcc72a+kkOFdnxuIp6u20l2WWfO1n3jdZNNoYHQMeMQgM0mjc2AaiMwb9yuUMg5V/i2rBFJeS1OE5JJbSKeiRpyvew9eG0yKV4lEHVfbJd8ES7K1VmvNTLJowXdFdlg6wLmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4jS0Bo7AkRlGe92vb28kwO7Pjp1hQgjCSUlu/A9x7E=;
 b=b1njhYOwn++zh2UYEh4TJiyjEBD3BTZbLEVb0ZFK1sMm7mF0sIFeSL3ObyiX7Px0dKI8P03ewiILuVfz4TalCcSdinMyxzZC3i3hauI4p9c/8gsAgmD81hST9S3XQiU+LyVABG7DCa/q70Vsrdc3WoSK4LpypaYJDkCocemKDe8=
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 PU4P216MB1915.KORP216.PROD.OUTLOOK.COM (2603:1096:301:109::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.36; Thu, 28 Mar 2024 10:16:53 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7386.025; Thu, 28 Mar 2024
 10:16:53 +0000
From: Nas Chung <nas.chung@chipsnmedia.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, jackson.lee
	<jackson.lee@chipsnmedia.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: RE: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size" DT
 prop
Thread-Topic: RE: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size"
 DT prop
Thread-Index: AQHafn94hZZm1U4NUE6FWrHOISEj9rFLXGrQgAAqpQCAAWluEA==
Date: Thu, 28 Mar 2024 10:16:53 +0000
Message-ID:
 <SL2P216MB1246499CC9FED9BFB5B11DA3FB3B2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
 <20240325064102.9278-5-brnkv.i1@gmail.com>
 <SL2P216MB1246537DD623B813453B28F9FB342@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <5hd7duzqhgdxpmvom3opkhwxkq55dmitk4gwdl4dy46q662in6@xxkmvdj6plqb>
In-Reply-To: <5hd7duzqhgdxpmvom3opkhwxkq55dmitk4gwdl4dy46q662in6@xxkmvdj6plqb>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1246:EE_|PU4P216MB1915:EE_
x-ms-office365-filtering-correlation-id: c1f72d6d-239d-480a-43a1-08dc4f10309a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 R29EMh3twhYU465MtQ0PvQmkjieH5/Hb+wumpZQ9qxtD8Q2dHYt1FyCJy5fe8h0JZDQntE/ouoqKq5OAzwYJksEz3n6iPaHmfcHESCtLVpKKyGkfjtT6TEsWiM0tKPkyUqV9vxjZowPXMahoaosQ3NFdEz+RoHD3j4bHS7/hNS7FDEsOlK6PuayO/diuIU1TqHfxBy7h0YthYT4x0gAjmr0N0Q+aQfzlhnwS4vVXiTvW3S3CaZaBKK14IjrvVTfsSzYGkJ6WNcUQtMcImlmkfaAdZ2/KCKEznax55EltddVGAA+BSnzp4w34R89MoXNK2bhYx3outgvoJIXlcbMVnJXVJNAIgK+L67PwRp02SFHqXka+qwCET9E5Ot82XiWRqWk9PSEV7o41NnLMAjwa+PuBTaBvVRzLqfB0NEtsroKpdqr9c5RG40y/a/hnp12XHltsOkDbCl+peta2C1xIsSe2DJRy1V6fvxVVQeSg/65PCHdechyjFPxD2+x3OOSvA+lqgyCZaPv+AGYfzy9FOVthMRV0qmc9kwtgxA84S2oB1UhYHbby08EYQFQwKLEXkJxzalTka7JF+3W/ByAEPmB1zLavVYoTSp3oHrbyx02rOjpJJ18HwrfOxEtM9Hp1Ir7pk9gYcp8O60i719WwODd8J1hmP1YSUEObLf5lsx5Uxt69EjW83nvcm4hjIxMKJU0e8PBzHDahTswYTG3QQ1dDr7x3xki50mn9LU4cijg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OoamVhWpp2Yvu6WKLYhPXV0OIbPYKa91dg09S86lHBCDwvP/yKJtzaOmjrvW?=
 =?us-ascii?Q?WMstP4bXEVWdid5j965bNgyTNywGJBAK8AMRl+tGHcfxtBHYgOtEE0s3a3zJ?=
 =?us-ascii?Q?lkMET+eex5LVnn3aFis7t9IznP92ypishO9I0/mrQ1Q3Ov7rcWScu4kxxonM?=
 =?us-ascii?Q?Kh/XwJudyDeoueufJ3cYe+m5eovsIWO/1LeCTzS5bRBWHCkVAFiDvHPppOU2?=
 =?us-ascii?Q?bida8WWBqQZA5OO41M6devk4QpRV4bMI5PjgroJZYgbTja5A1x0EWzgeK060?=
 =?us-ascii?Q?+hvLJ4G5hbhESSVMfJJguBoz0BaDTzMR8NnAwOZCFJr1TST6xpaLI3KB/Rw4?=
 =?us-ascii?Q?krBMbUUPL3wSP22zOb0N5G0u8I/K4ZkDih5AV5OoeuCeSy5nbFLS7fZZNrgA?=
 =?us-ascii?Q?Dbfq3TjnrRJYfZY+hZmMA8R7W6wV26qeVY3kt6gbLMZFOMyx1aYzkOFESwr6?=
 =?us-ascii?Q?12gmvmvs9Imol27SpPrdTEEo9z7MLLPFnyB42cg4aXDrThrRpVWr2inZohj4?=
 =?us-ascii?Q?wgcdMc3jWHR8UaNZ7ftpxgrqXfxFqpon9a+DwQmdgOly2NpZlb9vu8FZaQ6V?=
 =?us-ascii?Q?b+DJoBA38IzgXM6n+VsVbJRF2IcYu6+0p1PKyl7hha2F5xjpCpvpPY2FG28f?=
 =?us-ascii?Q?guSmTUb4/GKgpTzlO0nCrWJaRDW6cQ08TTU5nwgmjB8PdM97xw1oRj7vOMQv?=
 =?us-ascii?Q?cjOx+0m7lf19vMVrkWN7+M9+R+hhHFRA3jvUnl/LBrsmuWdFgtXkWxHH5sc2?=
 =?us-ascii?Q?1t5KJxGcp0Wj34qcz5oLsx2OjxbNa5hgnbyJjuKS0YmxTbde+dl9P8Wr7fqz?=
 =?us-ascii?Q?bQc1rZ5RMJpCeUxZJVc6/7hD51/uBIG0LCjMBYUYHtx1wKftkwkTrKs1SDuC?=
 =?us-ascii?Q?AJ4sGOLb2hszKYQAs4bm2geUWiR5AV/mF0O/pPpXViszqnqFyNNj0slTlu42?=
 =?us-ascii?Q?fEDQy35Lh7hR7D2eJ//M/bsKySZm1Hf9foB2aA5p0PqxFlixreGHf9R2D47X?=
 =?us-ascii?Q?AZibZvn5SwbL277vSHY6TvRjEP45nko1oR1venJwy8uqFPRk1GHnjGKVXBVG?=
 =?us-ascii?Q?xyt+tlzaJfSijDZGk2XRA78/wk6blouYVYnCRs3S1hzAsaWoPwkeXYuJ8Q2o?=
 =?us-ascii?Q?oGcJDDQLUeg7+/q3dY3BuMjIc1EqDZmMneB4tnRsVLu8/+79U+irKwqjbE2h?=
 =?us-ascii?Q?XoazQC+JUkHcF03m3KsvTz38ogGL1BXoYP+JCLQllYLT4b8mQLqIpNgASHhK?=
 =?us-ascii?Q?n3lIm4bxT9NIuKRU+/c9ewCvqLCgfZelidu+QBXiB5mD7eRBJ6Ca+WRixRZk?=
 =?us-ascii?Q?mazDjQVvHMjqd797am9FLUPolNq+9a9a+uXzWNC6to8fMq0YMp+GC6F88cGm?=
 =?us-ascii?Q?oxYIgqyuUGVT+Nuirh3fglFNjwpoU5DFp7yQQTWRCZ4KL1qRBQy5sed+e6Nl?=
 =?us-ascii?Q?TROw2zssmk/uvaC5JAP3lGGKn8WrUIbiKYzGFqGrPv+OOMCKRBkcz9CFHJLF?=
 =?us-ascii?Q?uhO0rMbH1UFcWC+3z9nO4Hb32nLYZ8JEs8dvHdjDfBls9yIqTREDx0V+I7tQ?=
 =?us-ascii?Q?OwJlk9YQ5L0fSAyLSdAXqgvAD+1XeWRt1J4xi0Jo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f72d6d-239d-480a-43a1-08dc4f10309a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 10:16:53.2716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eu38k9xH+XDb5i183QU0BQ7I+JS4J+3tUxmQaEOOE5iNcbO7hhVHExyOY80/6TMXPG4E5Zs/NmAw5jqtEddOdBHEoCslsbLzg64l89EQEC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1915

Hi, Ivan.

>-----Original Message-----
>From: Ivan Bornyakov <brnkv.i1@gmail.com>
>Sent: Wednesday, March 27, 2024 9:27 PM
>To: Nas Chung <nas.chung@chipsnmedia.com>
>Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
>jackson.lee <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
><mchehab@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>
>Subject: Re: RE: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-
>size" DT prop
>
>On Wed, Mar 27, 2024 at 10:27:19AM +0000, Nas Chung wrote:
>> Hi, Ivan.
>>
>> >-----Original Message-----
>> >From: Ivan Bornyakov <brnkv.i1@gmail.com>
>> >Sent: Monday, March 25, 2024 3:41 PM
>> >To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
>> ><jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
><mchehab@kernel.org>;
>> >Philipp Zabel <p.zabel@pengutronix.de>
>> >Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; linux-media@vger.kernel.org;
>> >linux-kernel@vger.kernel.org
>> >Subject: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size" DT
>> >prop
>> >
>> >Use all available SRAM memory up to WAVE5_MAX_SRAM_SIZE. Remove
>> >excessive "sram-size" device-tree property as genalloc is already able
>> >to determine available memory.
>> >
>> >Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
>> >---
>> > .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++---------
>> > .../platform/chips-media/wave5/wave5-vpu.c    |  7 -------
>> > .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
>> > .../chips-media/wave5/wave5-vpuconfig.h       |  2 ++
>> > 4 files changed, 13 insertions(+), 18 deletions(-)
>> >
>> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> >b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> >index 3809f70bc0b4..a63fffed55e9 100644
>> >--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> >@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
>> >*vpu_dev, struct vpu_buf *array,
>> > void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
>> > {
>> > 	struct vpu_buf *vb =3D &vpu_dev->sram_buf;
>> >+	dma_addr_t daddr;
>> >+	void *vaddr;
>> >+	size_t size;
>> >
>> >-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
>> >+	if (!vpu_dev->sram_pool || vb->vaddr)
>> > 		return;
>> >
>> >-	if (!vb->vaddr) {
>> >-		vb->size =3D vpu_dev->sram_size;
>> >-		vb->vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
>> >-					       &vb->daddr);
>> >-		if (!vb->vaddr)
>> >-			vb->size =3D 0;
>> >+	size =3D min_t(size_t, WAVE5_MAX_SRAM_SIZE, gen_pool_avail(vpu_dev-
>> >>sram_pool));
>> >+	vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
>> >+	if (vaddr) {
>> >+		vb->vaddr =3D vaddr;
>> >+		vb->daddr =3D daddr;
>> >+		vb->size =3D size;
>> > 	}
>> >
>> > 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
>> >0x%p\n",
>> >@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device
>*vpu_dev)
>> > 	if (!vb->size || !vb->vaddr)
>> > 		return;
>> >
>> >-	if (vb->vaddr)
>> >-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
>> >-			      vb->size);
>> >+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
>> >>size);
>> >
>> > 	memset(vb, 0, sizeof(*vb));
>> > }
>> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> >b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> >index 1e631da58e15..2a972cddf4a6 100644
>> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> >@@ -177,13 +177,6 @@ static int wave5_vpu_probe(struct platform_device
>> >*pdev)
>> > 		goto err_reset_assert;
>> > 	}
>> >
>> >-	ret =3D of_property_read_u32(pdev->dev.of_node, "sram-size",
>> >-				   &dev->sram_size);
>> >-	if (ret) {
>> >-		dev_warn(&pdev->dev, "sram-size not found\n");
>> >-		dev->sram_size =3D 0;
>> >-	}
>> >-
>> > 	dev->sram_pool =3D of_gen_pool_get(pdev->dev.of_node, "sram", 0);
>> > 	if (!dev->sram_pool)
>> > 		dev_warn(&pdev->dev, "sram node not found\n");
>> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> >b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> >index da530fd98964..975d96b22191 100644
>> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> >@@ -750,7 +750,6 @@ struct vpu_device {
>> > 	struct vpu_attr attr;
>> > 	struct vpu_buf common_mem;
>> > 	u32 last_performance_cycles;
>> >-	u32 sram_size;
>> > 	struct gen_pool *sram_pool;
>> > 	struct vpu_buf sram_buf;
>> > 	void __iomem *vdb_register;
>> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-
>vpuconfig.h
>> >b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>> >index d9751eedb0f9..9d99afb78c89 100644
>> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>> >@@ -28,6 +28,8 @@
>> > #define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 128K,
>AVC
>> >40K
>> > #define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
>> >
>> >+#define WAVE5_MAX_SRAM_SIZE		(64 * 1024)
>>
>> WAVE521 can support 8K stream decoding/encoding.
>> So, I suggest the MAX_SRAME_SIZE to 128 * 1024 (128KB).
>>
>> And, Current driver always enable sec_axi_info option if sram buffer is
>allocated.
>> But, we have to enable/disable the sec_axi_info option after checking
>the allocated sram size is enough to decode/encode current bitstream
>resolution.
>
>Do we really? As an experiment I tried to provide to Wave515 1KB of SRAM
>memory and decoded 4k sample file was fine...
>

You can think It seems like driver works fine.
But, This is not the behavior we expect.
There is a possibility that unexpected problems may occur.

>> Wave5 can enable/disable the sec_axi_info option for each instance.
>>
>> How about handle sram-size through match_data ?
>> I can find some drivers which use match_data to configure the sram size.
>>
>> We can use current "ti,k3-j721s2-wave521c" device as a 4K supported
>device.
>> - .sram_size =3D (64 * 1024);
>> Driver just allocate the sram-size for max supported resolution of each
>device, and we don't need to check the sram-size is enough or not.
>>
>> Thanks.
>> Nas.
>>
>> >+
>> > #define MAX_NUM_INSTANCE                32
>> >
>> > #define W5_MIN_ENC_PIC_WIDTH            256
>> >--
>> >2.44.0
>>

