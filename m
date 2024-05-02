Return-Path: <linux-kernel+bounces-166060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E278B9561
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3691F223E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667B225A2;
	Thu,  2 May 2024 07:38:19 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2095.outbound.protection.partner.outlook.cn [139.219.146.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FAF1D531
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635499; cv=fail; b=AcQpsaDtvg7zpFX5AngbwK7IJHrtnvDfgDErRNqlbEflKmBqbgd+VezFvSuUNfrgu3B9pp1NRoiyAT/hZAMCcSlnwJq9Qp27GCNDYdNvo1tL3tkPB90xSVbDzHRdFwqnxwgJju5n58didGNWbeyqXzJ6i+D6Fnq8EWedyjpy8Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635499; c=relaxed/simple;
	bh=xxbFnJLsgRXCxNGS6JvQYSydhdpSpHaWsuE7JdzmGfY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c26X/SMjfKm9nWkw+UdBz5QNsA6k7q2NJs//HwpLDDI/17tgXqEeXTuzeK+GO1+6cPvSreTBXmnNw64YfnZXxl0Y6F4MnhGBDON9suOkPXhnxMd81OKZ0gsUDZNNLr6rqQY2mEof4GstDaHXZKr638gwVtA9LpxZRtW4SrSUUT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwnj0oc8QC1sTuH0pFPfl9dIX0WSKoJ9dY7of9otOlXXw/JdONXV44VnK6vUZKAl9kR4I6qNnu9NWzp8l0VYx9qxC5YninwChjQIfJTScenqdcp+mrq+436kjBQcH/eAdmZ8uEKfdXYsxJCGfr2Bggq/fy3YKjV1eKGFO/e6AqpgNIesBJz1tKE7gFpPb8u2r47/ilgeL/ZrarhswLr9XTPvqKS/3ZQuYTUOR3oIm6ZUY8iZ9nThOpFM+Ml2d1VTJPHnGurQV3MZWQBEEY/q/ZVaIy5YXn1+6IoMCJH0UihYgy8UpUw54aMSJ2gxHnKI9es0aJimWyZWfPmexN4Qeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuTlWwi81pHFeVK3IuwwlQThbgfc4vp2pRGYl9Ui4B4=;
 b=oIU3XviZoiaXwGKkZ8bmdE8wO7rsKWUS0czm248u6ZUQ56MzNvtmQ8pWaM5MPSz0jAiXHjWfTWIZ1ltPDXzmGdpmug10DEwAjj/5Vw3mTJl1oVHQu/nK7wUAz9cHhIKv2ncYCICIDT9JtxiPLJHs3lq+B7XjrNgFGBun7MdA2enSKC5Bjy4yL5K9XeGSD849esjPQoPDY6IOZz1Q6V4M+ACzKktu9ngoQS1248lOKM50RU/s5TQj/asv0yT3L/YRqmzPFIBTqpIW/WbFEw5CamuzUM+C93d1lI+YX6dpGMdm/MvSZGPNtvLFKGH3tRy4JNOernPUDmFZx07kyYBPkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1294.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 2 May
 2024 07:38:02 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::e604:661e:e939:4c87]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::e604:661e:e939:4c87%4])
 with mapi id 15.20.7472.044; Thu, 2 May 2024 07:38:02 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: rafael.j.wysocki@intel.com,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	sunilvl@ventanamicro.com,
	jeeheng.sia@starfivetech.com,
	aou@eecs.berkeley.edu,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: [PATCH v2 0/1] Enable SPCR table for console output on RISC-V
Date: Thu,  2 May 2024 00:37:50 -0700
Message-Id: <20240502073751.102093-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::16) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1294:EE_
X-MS-Office365-Filtering-Correlation-Id: 199109fa-0abb-43e4-de1e-08dc6a7acc2c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6efoeUH4gU9kDRqaE5fkjGYAFzngf2bDOKX3iWin5anL5pjOoQVwzZmqvVYPzkO13AtawcAfUtobtJkdxPJ5qMT0Sua2eNlQcZVS8V93OZ0H4m9KM1wAO/nh3AMbDasT1YXzQtnDh80sjYQHuADVAihT+f89+prbpXsR5yA2f2RDpv07iOpzdpAtp3hcMXu6wXrSovjjvSuHYn0H271UdAUUDfrEn9LuLhzk3LTgXtCal6wAkIBImddoKSCopiWzfFTzPAynZZMoITskQSqZfengm4iyD+XV1eY3i8k2kyPoOoc3iDZceU/1NbBiAjFXzOMKao5Jqp4OP5+VjLVDE/y8ViFm5q5jxghakH9jPAFOHVFpa3dfNxBxUNyRTh1V+nXR1AId2sNcftK50ZcSg3P4Nb/fGDIqKIuk5IjUHRZ+i0OtONLUENKpdALS3NiPeOKWJys0X3LSHfRELXQ4N2mTTxqG/yxpsZcSFwkfGKQiIA5YrPucTX2Q/3wO4CpYOtvSlCmDHFRdLELCCmSwOR1xnhxwnxu6qxqGWtYgbWZZdCGcs9ke6NiekhOq7cmGbX8VPH4ms7r/z5fm9syVTWLS/6Kbe2LRTQQBgANUwXq8n4fsBg1AYhqGRIMDNnAw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gcU6q3NxuSzyCLZNT5Nmykj83qfb8HfLMQ7k+FGJlBfMCdfFW1cDaixZpQS8?=
 =?us-ascii?Q?WbOh4jNSFznWwCObMc8du3LUVOiX7tWwyCB+9caF/a2uB1pdK1Jj+g/16MTX?=
 =?us-ascii?Q?dKG479ZK3b4VkAc+F9BXo/d7gaEuonEP3dmNnc9TUa8ieqTuJBGMwhzfQwwy?=
 =?us-ascii?Q?BOhC6X+O/Jx211VRQ0h3eAewtIVA7UfMiaXXL95zQ87+//DeCo5xZHfnCcUD?=
 =?us-ascii?Q?gbLVb9eAYJuHbzJkM9SIjG7bcLtvwFjeWFuz0KYQtnGnN7fh9d933JKJH2IN?=
 =?us-ascii?Q?DuELiWEaxoPfD9Y6cB1sJxIDbQ7JpStIFW73mf8u0e6QA2MUK6gViLPzmL5b?=
 =?us-ascii?Q?GRuump8ubOUQAuKaFzHJrje4NZ1o+cxX4sKwfaEbc12ZutiWZRDf2zswIIQH?=
 =?us-ascii?Q?55kFcnSKzI6dxxGs1Z24IT3DTqBI6F2OvnmAZo5eZQ7xDL14mg445K0XHXMn?=
 =?us-ascii?Q?P1k4WRHY5pmGyrErHCdjymyA39lQhi62Lm+UG7T8MIWpyykQEPhc2bvpgcpw?=
 =?us-ascii?Q?hThHTtd10BKLRXsi+L05a4AgKfmHnUzhnU9RT7hWLGDxekDcgIZfop2/IX4y?=
 =?us-ascii?Q?v5wIEECW325tdQlVjTCFpo9wcRKYyjaH01CiKYZoWYrK0qcEI1LDRe03mgqz?=
 =?us-ascii?Q?eoaxUZdMNe9XGdQkx90hpmbW0AE1I5UrIGO9P86dYajQkmwJNOv3EWSqE3CJ?=
 =?us-ascii?Q?VS/zpMeQR7BAiVREx8rD/IayrxBmNAPVrFFE13ejm/H9aqgEFT9U4vv/i712?=
 =?us-ascii?Q?ziVrAJKlG5FWlHygoAl/eHWSypbCFhyleNS8wpg64Uqvb/ecZAvTS2ChrJ7f?=
 =?us-ascii?Q?bwtJ2UN6lw6U8EK8La9HgtYqpQEeU+wCPx1QdMe7jZWgvK1uKcEo5uT0FP0e?=
 =?us-ascii?Q?Z+zgdqSNFWoQUPBgM6aX1rgdNWDEROZK3kOBqN9pMAm3EAEoK5sxJ+8dHADA?=
 =?us-ascii?Q?wEhhuVyzJSLA3KfC8QbEkv7tjWU5zdMfaw9TGExKr1Kb1lFegjG9csKoeDB1?=
 =?us-ascii?Q?MxRx5rED49VbT1PRueCKnL8s7Gzv1r0R1eZzxBpC4UOxU9fV1XFcddZHirFk?=
 =?us-ascii?Q?aSkU3iy5jHcGyd3I4epreQSX3/oNHBhqgsj80yTr+kw9zzrm5IqXrPCWS6Ue?=
 =?us-ascii?Q?y9W/ak+n4Sen/bkFG19K8ES6488co2wAg7fdN/ZXqhaHQLUe5TWG4VKjOrG/?=
 =?us-ascii?Q?6t1ST/No36kHXDbiLMksiwwMBDIISTMWLoFoq3SD9h1jzKwjxQVI7GbvYcdO?=
 =?us-ascii?Q?Cp09k0HYmOXwhcja5SS76SyzZKbJZD3xxHWk7fCJpgbscU13GHfrTF+KfMqQ?=
 =?us-ascii?Q?ieZyKZ5au9WWcaMYNrqcTPleUCyzh2Uh3pIeTE9JloBtdHmx6gQLZf7598sJ?=
 =?us-ascii?Q?q1ucGcvFNryudDapzSkjv5B2wh/Hh1dKcfpHFbLz95K2VjJU97igHCjvA8yt?=
 =?us-ascii?Q?X+C9BLJB9ya93Bmk5zXapfHFSUXCQijhb7RBGA30Du5DERADf/J9y6EQBo3T?=
 =?us-ascii?Q?0zlrJVXVRhUboIyjmyA8O1IrMMP9EEq0A06DKzhb5c+3WxsDn6ga/KXlQqHD?=
 =?us-ascii?Q?6Zhc1zghcUHaGl1dg+Oemi+i+cpx3FJAd1O+p4AuzXAmGLR2OkY40ts9DxSy?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199109fa-0abb-43e4-de1e-08dc6a7acc2c
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 07:38:02.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7PDO+PFR/I1bB2PjWX7/tGM7MMNESjmWjmwZBECf1tb/sfVJ/8R2JXd88n90aCDp72hvNjzPQpLofOSblhjmQ+7kwkrz6HKFBMTeQkPaB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1294

The ACPI SPCR code has been used to enable console output for ARM64 and
X86. The same code can be reused for RISC-V. Furthermore, SPCR table is
mandated for headless system as outlined in the RISC-V BRS
Specification, chapter 6.

Changes in v2:
- Added code to handle early_init_dt_scan_chosen_stdout().

Sia Jee Heng (1):
  RISC-V: ACPI: Enable SPCR table for console output on RISC-V

 arch/riscv/Kconfig       |  1 +
 arch/riscv/kernel/acpi.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)


base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
-- 
2.34.1


