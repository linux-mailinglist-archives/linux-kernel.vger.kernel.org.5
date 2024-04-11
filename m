Return-Path: <linux-kernel+bounces-140059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DC18A0AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE0FB24629
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434D2EAE5;
	Thu, 11 Apr 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="MAV2UL0c"
Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazon11020003.outbound.protection.outlook.com [52.101.156.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDB13FD74;
	Thu, 11 Apr 2024 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.156.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823224; cv=fail; b=VuCNizv+u2RJZ/CsdmjlGOoaQdSR/7JtZ4T/O5ZrnK3s9ln4kus37N3najnosan1afUvA9/1Mzo31KJS6AuqvR4kKWpxvDsEkYyQlvo1oW7NQEmZnCevccLdbV7OAKpx/UXA87AsOX8+HOb/G+jGl8s9jooP8c2ZhaXLZ6/DDxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823224; c=relaxed/simple;
	bh=BfHR0lDNxUuU0bYWV0C+7tniHRVFMlUkIBxu7LVuNQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UWwAX26ec2yovXY9bHOuNPzu4tH4IvjVnCMMKJiMlqk/t5gxKVx9JPfbOHEKeagFeiGKydnUi7pGqgMaNaqutVKxhrCoRsZZxh5GNt2UeDaMI3gXfwaMSdYPRX0fXq3qAARDq+ccvd95DoVxSweDhpdqBZre6q4ul4JyQwr4x7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=MAV2UL0c; arc=fail smtp.client-ip=52.101.156.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGm/9wZWcVyQSk6GL3hN0/vxe/ed7E++SBb5br1XapqoX0qlS4oYKbzdeydokStotu+ODJKTls/GzU7IVScqV5XdC37VDinQeHsyuDG3qMt9o8iIhFK7Q08GF0DSEMe9//2vcATJP0l4xZY6kuzFWIadTUP63+jgY8p7IAzwx6gwanbjCfYqPl5A8B/qxtctuWKDnRIF7KXIcrHdp14xoxc2GjZi9Uots4gDbot2YEo0lu4b1Cq4zXR0MLzT/eZAoDKdbYvui2WgYXQ+FwS43WUNlYOfsRk9OxUWfhprnexzywgpsV8mCO81nP0YYQ5FjTIQkAy8W1wV94khhI/BWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxgdZcYupD6ok0+aHsBMUbxrHrnt3SPzFQFi+/Ed+pM=;
 b=achkv5cb2r3DWhak9YCBfk3tsu/WWuF1Vi+Tzf0isz38KZU2VYEVOl1ydnwU5JGpH9s73fEWWQzFZMJCh2bi6Tlyc5dpKs6noOm3Fak0+mYYD7YdFGXn8dBb3ykjLiRCKc+CEIhF1QEo76XLxCYbk940qqZfZCCk10f8y9/cfk1OiXbRk0IHGkgjdfjx7pSTo/63ycpPxqqww0/Q8Ue22VHJ3tCU9/rznvbkfdNKojovQaJDJwul9OA+e3A8ndwA2/j4KlVhFxlLtCd/X+Np6vnbPNv9jQZvpJd+tnCD4wHPm2mLJ/eCI5n/L1IPIF25WLsgJMNMqJCeX1/F1EzRgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxgdZcYupD6ok0+aHsBMUbxrHrnt3SPzFQFi+/Ed+pM=;
 b=MAV2UL0c+BmxURhTYHSprTPGVmBH91sLXW2xoJXf9pI6MvtEmY32jKBi1bL5LinjVTZZi500f93QITy7uEBFLum+3TlrW/vrJdkB6m2knqgCcagJO5B079EqpkCQ3O9NRAQghq1VB4E7vY9HGQ9UmD7owBHNNjHhNLV4fQA2mjU=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SL2P216MB1692.KORP216.PROD.OUTLOOK.COM (2603:1096:101:101::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Thu, 11 Apr 2024 08:13:39 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::4fff:e9f3:e95:3d05]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::4fff:e9f3:e95:3d05%3]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 08:13:39 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>, Nas Chung
	<nas.chung@chipsnmedia.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Fricke
	<sebastian.fricke@collabora.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/5] Wave515 decoder IP support
Thread-Topic: [PATCH v3 0/5] Wave515 decoder IP support
Thread-Index: AQHah3gdQC6P/IVPV0iUT4LRIjlhhbFiwQfQ
Date: Thu, 11 Apr 2024 08:13:39 +0000
Message-ID:
 <SE1P216MB130385EC5A67C80D9CB61522ED052@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240405164112.24571-1-brnkv.i1@gmail.com>
In-Reply-To: <20240405164112.24571-1-brnkv.i1@gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|SL2P216MB1692:EE_
x-ms-office365-filtering-correlation-id: 08e3e6a7-de1e-4516-6a3d-08dc59ff4b71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RHQ9K9fnGoBU2G0bYQ6wQMhxhuUFdFUYgXJGn8hAkEqbd+YC0HEQ7DhbYyBfLHjuc5zp+JiN4uZtDJmG4xZkzZ/JGQ/Cd5O2MAYnfikFJMyIdHfeEXinTlGHsZprQogMhrYH+c3nn4DmEYHKRhW3aqAhZ7auyVpHjel3pN77Tcj+TRGa4bNjJYU9H2Uh2dyVg4p31AwlbjnplPXqu0i72tEaeIegIVsAi+PZVyQLoAQv6+xCrofVQ29rndpNgVCVRHOB3NB28edZJGiexMrDtbltoY9pk0HhJGJolaPBhs4kkpfjTgf1+JIG/aYmxv5IC8/tMgZ4CZTtVQ8eken89Zfo9OQZdA0FmjGkM0QzHJyju1+/ljEBcLBbiSx6xylnvgpgFD6wje7c/pzOnQMdMh7LAhSIR9DpjkEBWflTwZ1Rtbh5pZoK/jXagBc+rU5mGkd3L2s11BC5+SnEFj4nW+r+BFWcsC1XbjcBEo7fPx7ggtt0lCaJQY0U2qdReQURQiEqvbxnqPsDF6zjT8yXTn7r7rp7wt92MoqMkW5LVQzoaRzazrfvuntdv7TnGYofqVW/9S6oWDdpKVsdzZtg3AZZaiN5RoJdjEPMxw8FvRW2VA0vGJ0lcf416hhgfbaV2iJh7NYANVBo1/D9V05kehaKc4arSqntlMldKiHbD52oysv9ZeSrxJRO/cwwXuUAQY583bUAANduBt7JhJdIfw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aUjfZ+oI7lzg5bxe34LXo4A7+x/8e9hQptML95o03sxFxwTQjVN5wY3ExHqQ?=
 =?us-ascii?Q?vPCyOlV+NoGm1Z+MedpC6Tyr4ZwaPvWPYqR1veJjn8dfI4qMO5PBFBKoSpxS?=
 =?us-ascii?Q?PA3oj/ql/QPvkKREQNIKC1vKId8H/tHho+wvAzDbsTbQHe8R7u7avBsSHR9N?=
 =?us-ascii?Q?9oAiOoJuIwbvCngZyr3mC03CpOibsMDA7FdEXndoQw52dXJ2kjBOtTqjtISM?=
 =?us-ascii?Q?YFIq3vbBsixo50GXnD77K9CtZECSBCe76uWtjsVed20Mq2b6Gr6XWtccR458?=
 =?us-ascii?Q?a7YlAt1pEswVE4kCNn+IGVkLe+lzP7ZRSf4FPXRZlqITpgnAiY+YeuSXuk/g?=
 =?us-ascii?Q?XVomH9r8LS6iEzkgPdo5l9t7yJkdl3kSciF1Ndzb0bWId0Mzb2Zwsea3IY9j?=
 =?us-ascii?Q?ykcI9y6EeGVBqiFt6Z74LvDJ0FsGdh8cmm4iI2MsJBJRVAaINGrss6YzzfLQ?=
 =?us-ascii?Q?nBR8/uMKB2U8gcfDxLpNtZ3s0/8CaqxcqCeFUlSdOKpB6rYVqCKpnTxBOgyW?=
 =?us-ascii?Q?ULdpr/Y4jCYTJquQmUJZO5F8aRm5o/EA8hQKngUl7Em0Waw48rTJa/pYDhuu?=
 =?us-ascii?Q?eqM262FaMwQRk860Pt4V7haWybx0SJ1o6ErQlUzhIdJ/LouaUUcqmCMZpBUf?=
 =?us-ascii?Q?1EsYZZInwHRreWzDQFw0XxpJFhkMrSKhPdNHSJBOeB30SsDhC2nRTZw5ESTI?=
 =?us-ascii?Q?gABLZEtoQFOBSM3bLL6Afi5NRIDINLaA084bZVHhAThGK7INMhVDALwtVOGv?=
 =?us-ascii?Q?b+mp9wHjc1OfiTW1a0cGlFgvoKCEKmD7B4J4s4X3fD5vPHHFcKmGNHTLZOst?=
 =?us-ascii?Q?ZJMlrRD0jaHEYIo/cI6FVeo7yTOmYxl6sPjC6BmSImC8KeRdP6NcK9kqrirC?=
 =?us-ascii?Q?fPrMWidJnMCdQOMtbmizMUDmQBwOunMxDS7L9fyaKF1gnXuxXyRyGTYmQoOu?=
 =?us-ascii?Q?ZfhYc3AYc+2D3P78R107o/3H22PbaLg0RAKfbgXDsFLR6yYTeqZ8DO0zZYsU?=
 =?us-ascii?Q?rViin4cwbaAgiBxRb1KsQ1DbLo0XklJ53X7Ssr9TWRBohXFLP+v6KHY5T0mn?=
 =?us-ascii?Q?6yksPsMd0S+7UZHbCKIXgjoFxoH6e1F8n8PXdG+WWTVDhF9KBW95LD7CNLCe?=
 =?us-ascii?Q?0G5tQbA1aOcBUValZX9l/6hCKfypPBIMS1CKbKMbiI9ZBqwDrWDk15iUVOP+?=
 =?us-ascii?Q?xwx/aOsGNwjdeaJ6lympw2VH+tjOy50ecTbjdjbKOiTLA+MnQSoj3K0luBRd?=
 =?us-ascii?Q?77YCc0CJ9jzAusxDVWLCR3eJ3jfOp4apGdgeSA/za3XMvxe5ELTSmh5vCiLU?=
 =?us-ascii?Q?rex1izYxV2PAd7ZK14p/ayHO1RbrYtX3YwSVgXjxx/+QQldlfxQ59YCgyzM9?=
 =?us-ascii?Q?iRgjQizJiETzoXZ9wUlULy2vXCrTUqoJVZGaeJCf/9UD+B/foqfu082tOm1S?=
 =?us-ascii?Q?80pkTXHqUCADXHfkyK/ogV3EcwEllXIkzujMWD20ixSuHdfAch+9j5aVpp3K?=
 =?us-ascii?Q?RgqLA8V9jlXpVL+9ApbjcgmCoKgfAKLW2NZg3GE8jthKN0K7KzYgjVxhWCdm?=
 =?us-ascii?Q?WlT6vDkFvFPm80S4bT7JnOmla1QQRD5uSbq0DnqH395VGtmvkHfXEEi2HiKv?=
 =?us-ascii?Q?Hw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e3e6a7-de1e-4516-6a3d-08dc59ff4b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 08:13:39.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PT8VdJsTL3ez8hVDik/tAGLviq2FeEu6w3MmnmxM8MMvE1SZQAb0cTbUDLwoIekRB5Qb52s5d8SZnduOWt1j9s7Ra2HwiMqLEsctml0jGPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB1692

Hi Ivan

Can you provide a score for testing a fluster tool so that we can verify th=
e change on your HW?

Thanks
Jackson

> -----Original Message-----
> From: Ivan Bornyakov <brnkv.i1@gmail.com>
> Sent: Saturday, April 6, 2024 1:41 AM
> To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
> <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>=
;
> Philipp Zabel <p.zabel@pengutronix.de>; Sebastian Fricke
> <sebastian.fricke@collabora.com>
> Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; linux-media@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v3 0/5] Wave515 decoder IP support
>=20
> Initial support for Wave515 multi-decoder IP among other refinements.
> This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.
>=20
> fluster score for JCT-VC-HEVC_V1 testsuite with
> GStreamer-H.265-V4L2-Gst1.0 decoder is 132/147
>=20
> The issue with Main10 tests is that fluster expects decoded file to be in
> yuv420p10le format while this driver decodes HEVC Main10 into 8-bit
> yuv420p. Though result is looks alright to the naked eye, proper decoding
> into yuv420p10le is to be added.
>=20
> The rest failed fluster tests are common with Wave521.
>=20
> ChangeLog:
>   v1:
> https://lore.kernel.org/linux-media/20240318144225.30835-1-
> brnkv.i1@gmail.com/
>   v2:
> https://lore.kernel.org/linux-media/20240325064102.9278-1-
> brnkv.i1@gmail.com/
>     * drop patch "dt-bindings: media: cnm,wave521c: drop resets
> restriction"
>       The only user of Wave5 in mainline is TI K3 boards, thus there is
>       no real need to alter dt-bindings
>     * in patch "media: chips-media: wave5: support decoding HEVC Main10
> profile"
>       add check for flag "support_hevc10bit_dec"
>     * in patch "media: chips-media: wave5: support reset lines" move
>       reset_control_deassert() out of else branch, add
>       reset_control_assert() to probe error path.
>     * rework patch "media: chips-media: wave5: drop "sram-size" DT prop"
>        - don't move alloc/free form device open/close
>        - intead of exact configuration of reserved SRAM memory in DT and
> 	 allocating all of it, allocate all available SRAM memory up to
> 	 WAVE5_MAX_SRAM_SIZE from whatever pool provided.
>     * adjust patch "media: chips-media: wave5: support Wave515 decoder"
>       according to changes in patches
>       "media: chips-media: wave5: support decoding HEVC Main10 profile" a=
nd
>       "media: chips-media: wave5: drop "sram-size" DT prop"
>   v3:
>     * reword patch "media: chips-media: wave5: separate irq setup routine=
"
>       a bit.
>     * in patch "media: chips-media: wave5: drop "sram-size" DT prop"
>        - move MAX_SRAM_SIZE define into match_data->sram_size
>        - add placeholders for validation that allocated SRAM memory is
> 	 enough to encode/decode bitstream of given resolution before
> 	 setting W5_USE_SEC_AXI and W5_CMD_ENC_PIC_USE_SEC_AXI registers
>        - reword accordingly
>     * in patch "media: chips-media: wave5: support Wave515 decoder"
>        - add comments around SRAM memory allocation/freeing about
> 	 Wave515 specifics
>        - add comments about BSOPTION_RD_PTR_VALID_FLAG bit in
> 	 W5_BS_OPTION register
>        - add W[AVE]521_ prefix to defines, for wich there are W[AVE]515_
> 	 alternatieves
>        - add semi-magic Wave515 specific formulas to estimate SRAM usage
>=20
> Ivan Bornyakov (5):
>   media: chips-media: wave5: support decoding HEVC Main10 profile
>   media: chips-media: wave5: support reset lines
>   media: chips-media: wave5: separate irq setup routine
>   media: chips-media: wave5: drop "sram-size" DT prop
>   media: chips-media: wave5: support Wave515 decoder
>=20
>  .../platform/chips-media/wave5/wave5-helper.c |   8 +-
>  .../platform/chips-media/wave5/wave5-hw.c     | 395 +++++++++++++-----
>  .../chips-media/wave5/wave5-regdefine.h       |   5 +
>  .../platform/chips-media/wave5/wave5-vdi.c    |  27 +-
>  .../chips-media/wave5/wave5-vpu-dec.c         |  51 ++-
>  .../chips-media/wave5/wave5-vpu-enc.c         |   2 +-
>  .../platform/chips-media/wave5/wave5-vpu.c    |  35 +-
>  .../platform/chips-media/wave5/wave5-vpuapi.h |   3 +
>  .../chips-media/wave5/wave5-vpuconfig.h       |  16 +-
>  .../media/platform/chips-media/wave5/wave5.h  |   6 +
>  10 files changed, 407 insertions(+), 141 deletions(-)
>=20
> --
> 2.44.0


