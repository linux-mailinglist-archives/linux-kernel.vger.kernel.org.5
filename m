Return-Path: <linux-kernel+bounces-126549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD3E89395E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223A91F212DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A44910961;
	Mon,  1 Apr 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="SwCjxZsV"
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11020003.outbound.protection.outlook.com [52.101.154.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6C9D52B;
	Mon,  1 Apr 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963695; cv=fail; b=rdayCTRPu2mE5+j36HtfxpvKMLcOrwqwUK4devOu5Rew5NNNznuLrUvv7HEBTX5pMS9m8SRmD3QbcPP67JC/PxtmQZZ6ZqWuDeueAbG7Bj6nVcdYFi480eOIl9VoDmvbEe67C4zSCpf/DhNII0ziHy/xM68Z45KJ8jUlYW33VQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963695; c=relaxed/simple;
	bh=YnDvLBSUYOT7zv3hRGRZtLvPh4NqiNUcmY3VcQO5IPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u2WpZQv02pYsSXy3Ur+cPa7uvxD1w5HR8J0vlH8k/H4StxFfbp2VnIESPoqfLdfhTfpLeejCaEyRj4F9IsHhROtZ+MDFouN9NiE0QOCWWljdbg+rJqjhl+WDCkj6rgb/XWZdhlyceDLhm2q99tqKlK1YmrH9uf+/sbW3E/yVtvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=SwCjxZsV; arc=fail smtp.client-ip=52.101.154.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a61msLWf4npgaRYZtL7xIeSsWC8WaB3CEFDszdXq6s4lutPrKZv1x8QoGcPAfycVli31A+lhQ2VIQz0QFuQJf2fM51y6R2obxCP9XiIUGuf/YunKKP/QLlgAvwaEtiscyBxUSi3MGs9hqYMB0kBgCZNHmR9awwq3p2kz43dY5ezgy/pHGCJaHUQWcdeVGOK5OC1YqC8mCzqJ5Uo7UlkySe7KUN5/94epi87d6fdabfLMfRADAzRplTFxxgxGlUFPJCHcbcNtsx5dc+M/z8D8ydKhUAia8h4CDct2F9L7Ds2RwRxeRyZe++PX9cCL/wLaZwLb39LPhni3isa/9L6ACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z4Tpsmgr/MBbqXmyZ0PAu2EXYMHeXoyWYNuxIJxGuk=;
 b=gg9RuV6tsol6RpRGKaRx3kyT5V0WTS21ILwqG95Fu2F/nQLFtJSYORd7AZ6MxWn2yXzZk+mt0wH8Mx276OC17l7V4OL0MSlzBaoKrZsl298ZpnuXK2RjRIKXntmQsU86oa5pTh64VRirjqB7QNstRkeIheSOgX0y08RvXco/KRTL+2BynZcWdvD0VaYMnWgAyqEk7+g/4bRGgZySkfkRFcirpcTQ69edtOD6gxv3ygT86hl4MiyXA/X1qrymlc2ovuPqg2LkulPPSlSj+UT41wj6BELZjcG12cnv3I5+WDTOJ5HyryTma/DLDl6DBskYvgoiLdYlTrW3l7EAQ1CDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z4Tpsmgr/MBbqXmyZ0PAu2EXYMHeXoyWYNuxIJxGuk=;
 b=SwCjxZsVxjBYex90S31RVEC4/j8cXqbqPCbMJzuueCqOCNe7A3KNE3jXAQ6SMW/EKdtNPlH4HikObfuY8d/RZ0oM//lVtDmCPONQB8Y2khaibyKRuU/j3/UYF/tWbR8mXDxkKCl62KbKJCHU+SpBjkGGGYGguWKqN95SDTUKao0=
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 PUYP216MB2906.KORP216.PROD.OUTLOOK.COM (2603:1096:301:154::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 1 Apr 2024 09:28:09 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 09:28:09 +0000
From: Nas Chung <nas.chung@chipsnmedia.com>
To: "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, jackson.lee
	<jackson.lee@chipsnmedia.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: RE: RE: [PATCH v2 4/5] media: chips-media: wave5: drop
 "sram-size" DT prop
Thread-Topic: RE: RE: [PATCH v2 4/5] media: chips-media: wave5: drop
 "sram-size" DT prop
Thread-Index: AQHafn94hZZm1U4NUE6FWrHOISEj9rFLXGrQgAAqpQCAAWluEIAAGsYAgAYig1A=
Date: Mon, 1 Apr 2024 09:28:09 +0000
Message-ID:
 <SL2P216MB1246597E5880A5A590CE1DB2FB3F2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
 <20240325064102.9278-5-brnkv.i1@gmail.com>
 <SL2P216MB1246537DD623B813453B28F9FB342@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <5hd7duzqhgdxpmvom3opkhwxkq55dmitk4gwdl4dy46q662in6@xxkmvdj6plqb>
 <SL2P216MB1246499CC9FED9BFB5B11DA3FB3B2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <7lro7ryzjajpzvkjdj5cndkmzmjkqvhts6dmer4pkkt7dluiii@wp7ael4ae7jd>
In-Reply-To: <7lro7ryzjajpzvkjdj5cndkmzmjkqvhts6dmer4pkkt7dluiii@wp7ael4ae7jd>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1246:EE_|PUYP216MB2906:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AOMhxUe6exb0C/SXrQKThgtGHhSPS4nyybZ3xN2j/c65V7f5LSO9ZlAs95UKpR7UsiPiH3ZpG3ErKouTzg6Dstv+r6DP05KayyMC4x7ww0fxnzkk0Uv1hsy3kWWN8c1Ep9evcS3YFSEh6Jvz0aEhVCZvHVm3jb7BhfJh6rx3QFbHW83zeNKCKGNn0CWsnd/cQ/xxTNE2+D2VonyJ/HwFPQcZx2NeIkKwCMJlDnqkROE+/qgV+T1TWmXtkU6WzhY5J6QuC9UdINPeqyq2da1NywRRtV/2PPPMKvFEtagYtx8Awq/x/6NwnZ4SId9fe2+6s79/TyT1pUg632mFPxL1D4uiNMzZzNkJUZbktNgc65DA8KQKKPdPoxI6oAsMeuKYYNvq0ULQxQDTJDn5B6j5ZBYqUuX9eV0LnWgudzUmm37Ql0qEHAkY3PpjcSUyH2+Uhq/WYr0YH1u2z6MSEegKFxZgnzyVIEoc4j3FEPp5GIChC5SoLnskB6qWoZe2cPhuIRYPsaxGYNvisXeKqybvFH6bME5Ent08D7V0Tn0NxWt9V131mIDxZW2Qsn4wd4zeFaPFBMf2ikk+3L5f3IlNtHNl04EjZbV9AJ3/PO+3Urwwe17+nnIW9e8cDCrxUNbQX+iWX5FOEfkGDXUXrHVnbLm8KtFd/UCnL+mxlalb1Qo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pRObIJHN7aJRdavxkyl+LJVo0Vd994ub5BOM+cXXORfFMWNLn1ifyqxBozxv?=
 =?us-ascii?Q?eAOOsoDCznX9srCEq2XjWMGx3zPEqpLWw6Dd5PzUKgOyRcBve0WsHRCS3iLg?=
 =?us-ascii?Q?YtXhKNiVml2Na2y4H6WGZx5y8lGMhQ/aVjfy7AsCudWs9Ykjd0ObpaThGmce?=
 =?us-ascii?Q?LFy7TqyR0F23IektwX+t3sWExLLnkMNCrUPeJ9obywEC6T4izEM4Mbke508I?=
 =?us-ascii?Q?mzbNbh0L0EIgM2vE8bWMuGvQmbYTdQXQ8gFch/Z6Iy7pg98sWesGTMCkb6ew?=
 =?us-ascii?Q?tWLg0oMk2f9Vv8+f6CKJuuL+vbgj0DyKCvsZAFl/vMiCrZyuBTmzvMZoBAok?=
 =?us-ascii?Q?pJ8mj8h/o1gxNYs3oKL8ZAdP4DtoUrytbWVlFVOBySX6R/BrfA6cBlOaseol?=
 =?us-ascii?Q?4FoetZIRcwnRpw0j8X0CCC9WQxz3x6d6JnJ2GVcKPkRny47ZGNfnb6RexnhP?=
 =?us-ascii?Q?98XmcU/zj9xD5+vC/NECgNpoKu/IFt3FGMlZdMqEBPbrnV0fpoT4KWOMEAXM?=
 =?us-ascii?Q?3ETLjiO31Wg8/kjs0Gd4Jp7w9N+2e76aKUZLR0tIvWcoFNS7WZjetoxk8LpP?=
 =?us-ascii?Q?gJltfV6it4LagpKdh5ayMHp+rKHWPO7rAsHUUgrZ1dvPPjLBgZB/3S3QXcHK?=
 =?us-ascii?Q?uWQ2IqdUYnVipX+3oAbQcG+QbVNULnabzPEbkstUVcr0uuNm2pbbL3wlFcvw?=
 =?us-ascii?Q?+p71j3vYNxsdthGpCs/jdwdUa5lz7ZvOdgKcc0LyLIAUbUjGdFVdH8y75cAI?=
 =?us-ascii?Q?remPOFJva6xNjuTT2j/s5pKLMO1H6/IQRVB863h7SlOV+WOmXiVJ4Z+NM5Hy?=
 =?us-ascii?Q?ZzVqaVKSQUEro9t4xrCUXh5DYKjvtoGAr5iNRIhFDThjml5bqZVXkigPM1Hu?=
 =?us-ascii?Q?1mOPiL2q+2qa4O3RYdmpIOgbcK33+JAQVBBttc9gTwDGjm3dJ/gjz5IJrTcB?=
 =?us-ascii?Q?1oNRcYAEAE8EK8JoHIUwGv16eImRZYpxEihNrKN2qs2l8+eYQn+NJG0YV2gj?=
 =?us-ascii?Q?LETAQXBT/Mo8BP1/FPCoNCDUmHtc+SX7odZxvmAUbKyRnpAD+6LSU9DNcO5n?=
 =?us-ascii?Q?n9ShylHa3i3SA0ik2L/uS7GLgsU3ZydVEkFpiqabI62erh9ZGX27qH33BtgV?=
 =?us-ascii?Q?gmsGh2gOwKufngGsW58NRMx0gHTr19JtaY0TSQu8MPSmVVlJ793ZIqTGPRLn?=
 =?us-ascii?Q?PISoaQZb4PQxl+wu1uvmYm5iRHRZcHd8ZJ3drzPoinsFIbCDZ2KfBTC1OrMs?=
 =?us-ascii?Q?bodeBiRjbFDRba6emuyovYloJ0AV45exviwENO5UN2itCmXwpb0FkuXCMYog?=
 =?us-ascii?Q?UJgfU8Kwa2a9PTsjgNCzAoJt6pRZAYUM4YefWwYtiO9OAcpausl2/VXhLhS1?=
 =?us-ascii?Q?L4iSBcOD1Y0nGT5EN9/RtWFFGMP/K9IQfOkG9/OBkE2EcJWHcMblxMG64o/O?=
 =?us-ascii?Q?ey4/2QVIHDcZiyPq2qig9NyKuHW+3lOpxIw2lZrW8QTDma3cpVcusc/JSgmp?=
 =?us-ascii?Q?XLU56oNV+L/LxPTlUOo7RzDgkOppbgIxXd6V4foE83IRKMHEBDzC8GPTL/dg?=
 =?us-ascii?Q?huY32Je93ATnuGeYbvCub4t/tUqP+HqsX1gE3WhP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc120b5-dc7d-4fdb-3020-08dc522e0bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 09:28:09.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUF5dCbY7YkjF9RSCEudiAiav+riy8Wqz1imSsFqCHsouFFRRwfGve4KsifMyjGSZPipkRKOccVmzGCkSK7JhgLgQYehP4xYzZLdIhCXpJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUYP216MB2906

Hi, Sebastian.

>-----Original Message-----
>From: Ivan Bornyakov <brnkv.i1@gmail.com>
>Sent: Thursday, March 28, 2024 8:36 PM
>To: Nas Chung <nas.chung@chipsnmedia.com>
>Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
>jackson.lee <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
><mchehab@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>
>Subject: Re: RE: RE: [PATCH v2 4/5] media: chips-media: wave5: drop
>"sram-size" DT prop
>
>On Thu, Mar 28, 2024 at 10:16:53AM +0000, Nas Chung wrote:
>> Hi, Ivan.
>>
>> >-----Original Message-----
>> >From: Ivan Bornyakov <brnkv.i1@gmail.com>
>> >Sent: Wednesday, March 27, 2024 9:27 PM
>> >To: Nas Chung <nas.chung@chipsnmedia.com>
>> >Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
>> >jackson.lee <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
>> ><mchehab@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>
>> >Subject: Re: RE: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-
>> >size" DT prop
>> >
>> >On Wed, Mar 27, 2024 at 10:27:19AM +0000, Nas Chung wrote:
>> >> Hi, Ivan.
>> >>
>> >> >-----Original Message-----
>> >> >From: Ivan Bornyakov <brnkv.i1@gmail.com>
>> >> >Sent: Monday, March 25, 2024 3:41 PM
>> >> >To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
>> >> ><jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
>> ><mchehab@kernel.org>;
>> >> >Philipp Zabel <p.zabel@pengutronix.de>
>> >> >Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; linux-
>media@vger.kernel.org;
>> >> >linux-kernel@vger.kernel.org
>> >> >Subject: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size"
>DT
>> >> >prop
>> >> >
>> >> >Use all available SRAM memory up to WAVE5_MAX_SRAM_SIZE. Remove
>> >> >excessive "sram-size" device-tree property as genalloc is already
>able
>> >> >to determine available memory.
>> >> >
>> >> >Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
>> >> >---
>> >> > .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++------
>---
>> >> > .../platform/chips-media/wave5/wave5-vpu.c    |  7 -------
>> >> > .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
>> >> > .../chips-media/wave5/wave5-vpuconfig.h       |  2 ++
>> >> > 4 files changed, 13 insertions(+), 18 deletions(-)
>> >> >
>> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> >> >b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> >> >index 3809f70bc0b4..a63fffed55e9 100644
>> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> >> >@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct
>vpu_device
>> >> >*vpu_dev, struct vpu_buf *array,
>> >> > void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
>> >> > {
>> >> > 	struct vpu_buf *vb =3D &vpu_dev->sram_buf;
>> >> >+	dma_addr_t daddr;
>> >> >+	void *vaddr;
>> >> >+	size_t size;
>> >> >
>> >> >-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
>> >> >+	if (!vpu_dev->sram_pool || vb->vaddr)
>> >> > 		return;
>> >> >
>> >> >-	if (!vb->vaddr) {
>> >> >-		vb->size =3D vpu_dev->sram_size;
>> >> >-		vb->vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, vb-
>>size,
>> >> >-					       &vb->daddr);
>> >> >-		if (!vb->vaddr)
>> >> >-			vb->size =3D 0;
>> >> >+	size =3D min_t(size_t, WAVE5_MAX_SRAM_SIZE,
>gen_pool_avail(vpu_dev-
>> >> >>sram_pool));
>> >> >+	vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
>> >> >+	if (vaddr) {
>> >> >+		vb->vaddr =3D vaddr;
>> >> >+		vb->daddr =3D daddr;
>> >> >+		vb->size =3D size;
>> >> > 	}
>> >> >
>> >> > 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu,
>vaddr:
>> >> >0x%p\n",
>> >> >@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device
>> >*vpu_dev)
>> >> > 	if (!vb->size || !vb->vaddr)
>> >> > 		return;
>> >> >
>> >> >-	if (vb->vaddr)
>> >> >-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb-
>>vaddr,
>> >> >-			      vb->size);
>> >> >+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
>vb-
>> >> >>size);
>> >> >
>> >> > 	memset(vb, 0, sizeof(*vb));
>> >> > }
>> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> >> >b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> >> >index 1e631da58e15..2a972cddf4a6 100644
>> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> >> >@@ -177,13 +177,6 @@ static int wave5_vpu_probe(struct
>platform_device
>> >> >*pdev)
>> >> > 		goto err_reset_assert;
>> >> > 	}
>> >> >
>> >> >-	ret =3D of_property_read_u32(pdev->dev.of_node, "sram-size",
>> >> >-				   &dev->sram_size);
>> >> >-	if (ret) {
>> >> >-		dev_warn(&pdev->dev, "sram-size not found\n");
>> >> >-		dev->sram_size =3D 0;
>> >> >-	}
>> >> >-
>> >> > 	dev->sram_pool =3D of_gen_pool_get(pdev->dev.of_node, "sram",
>0);
>> >> > 	if (!dev->sram_pool)
>> >> > 		dev_warn(&pdev->dev, "sram node not found\n");
>> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-
>vpuapi.h
>> >> >b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> >> >index da530fd98964..975d96b22191 100644
>> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> >> >@@ -750,7 +750,6 @@ struct vpu_device {
>> >> > 	struct vpu_attr attr;
>> >> > 	struct vpu_buf common_mem;
>> >> > 	u32 last_performance_cycles;
>> >> >-	u32 sram_size;
>> >> > 	struct gen_pool *sram_pool;
>> >> > 	struct vpu_buf sram_buf;
>> >> > 	void __iomem *vdb_register;
>> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-
>> >vpuconfig.h
>> >> >b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>> >> >index d9751eedb0f9..9d99afb78c89 100644
>> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>> >> >@@ -28,6 +28,8 @@
>> >> > #define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 12=
8K,
>> >AVC
>> >> >40K
>> >> > #define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
>> >> >
>> >> >+#define WAVE5_MAX_SRAM_SIZE		(64 * 1024)
>> >>
>> >> WAVE521 can support 8K stream decoding/encoding.
>> >> So, I suggest the MAX_SRAME_SIZE to 128 * 1024 (128KB).
>> >>
>> >> And, Current driver always enable sec_axi_info option if sram buffer
>is
>> >allocated.
>> >> But, we have to enable/disable the sec_axi_info option after
>checking
>> >the allocated sram size is enough to decode/encode current bitstream
>> >resolution.
>> >
>> >Do we really? As an experiment I tried to provide to Wave515 1KB of
>SRAM
>> >memory and decoded 4k sample file was fine...
>> >
>>
>> You can think It seems like driver works fine.
>> But, This is not the behavior we expect.
>> There is a possibility that unexpected problems may occur.
>>
>
>Ok, then we either
>
> 1) don't try to allocate any availible SRAM memory up to
>    match_data->sram_size, but allocate exact match_data->sram_size
>
>or
>
> 2) allocate any available SRAM memory up to match_data->sram_size, but
>    check for allocated size before writing to registers W5_USE_SEC_AXI
>    and W5_CMD_ENC_PIC_USE_SEC_AXI
>
>With second variant I won't be able to add said check for Wave521, as I
>don't know its memory requirements.
>
>Also would this check be SoC specific or would it be common for any SoC
>with same Wave5xx IP?
>
>> >> Wave5 can enable/disable the sec_axi_info option for each instance.
>> >>
>> >> How about handle sram-size through match_data ?
>> >> I can find some drivers which use match_data to configure the sram
>size.

I proposed using match_data to allocate different sram size for each device=
.
Do you think this is a reasonable approach ?

Thanks.
Nas.

>> >>
>> >> We can use current "ti,k3-j721s2-wave521c" device as a 4K supported
>> >device.
>> >> - .sram_size =3D (64 * 1024);
>> >> Driver just allocate the sram-size for max supported resolution of
>each
>> >device, and we don't need to check the sram-size is enough or not.
>> >>
>> >> Thanks.
>> >> Nas.
>> >>
>> >> >+
>> >> > #define MAX_NUM_INSTANCE                32
>> >> >
>> >> > #define W5_MIN_ENC_PIC_WIDTH            256
>> >> >--
>> >> >2.44.0
>> >>

