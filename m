Return-Path: <linux-kernel+bounces-72722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F11585B7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B949CB222A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09D167C7D;
	Tue, 20 Feb 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="zPLna+m8"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2110.outbound.protection.outlook.com [40.107.7.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663D567A0E;
	Tue, 20 Feb 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422031; cv=fail; b=OxztmvBOrHV5VE9Zq9tyPOA2tTanKrENQ2wVPd1l3e8Qt4lXbPnH0oUtvWd5pdbb8JLUqfjccTmUFvJCN8FgtyRwA5R4ntFZajG/0WaekQ9ATg9cT6maZJehugNEGOXpmGzsuhwaAQtpCy2MJijNqMKJKUHlk34xeR519ZtWFfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422031; c=relaxed/simple;
	bh=P9Qxsw9kjyeE5rbxicA+k/0vkgilDJms8XWxah2XXTE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r0YyvrTpXfPKDWdcdp29g4UFTefc46b5x6B7HIH7T7wrPSjlUr95uUtW4MV8SvnEuSV9dl6HnI6xgNKaWvHUPn5KAYF5l105fvQ/UJh0gduaAmMXuA+BebPQ6ZtyaTMYLHRsrXEesnW/CrneJNXxK685f4S8Wzkbyh0IVdaXyTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=zPLna+m8; arc=fail smtp.client-ip=40.107.7.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro07HGmIRACpjYnQVCKpNfKFfcDFLJMYTQpP0y1itk7/oXpbfbAsPFaLgPvOwqgMndZZ8Pdgm2RTvfLBRpamsZbQYdlyb1tDWi5DUOIFnX5lqxYBigNzuHbbsVdGpTIpqhnQJC+NnJkiO4LA4k550UO5NUATQ6/pgZxKwpm6RAE9AgAvxeOTlyq/mQ6nOfSJ3TAfK7tGMzRYzrzTbZAfkBpsL3xGkA2SKyb/q+7KphjExGA9mKNIQEg9NWr6hyKijaAEhyiWLL6TjM494k4bpL0ggfX+kLdMlLsuE6fzgnpq42B81Fx9XIL1FcO6F8tMqrtH8Ndg518rK7C7MYJOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qfr+Qy7s3fqAc7HhNtMhVOBc72tDs9HdCFnwzWlVIo=;
 b=hEwnL10364e3IG8ydvgHNxm9RVT0ZXpaoDdfsIwJ4+OgHYQVueCSsfE+QbgjvJpy+SM8A3nIoWAunVCusAK4N8o+JxBJZH7FbP9xbkK+LGIInpsdiqdpA71TO1/kqdufleIy+Beqoi0QZw1l50lMoeTDQga9A+lmo1DdR4tGMzgVVM4rnwdRM+dvVKafX9Rvar+cQ/pMgQun7c9ZOnln64MW6C1OadO1Q+2RvXWNQRI1FLIRaLSfDN8kZHqx/hf6ErdA/L0G6VirhvQbaINBPl2xMA0KcDnO6g4QuwqDm4As8oNyRgcWeCNfa+JWV1r4sZMdQ0aATlIEcaDTdJ2lTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qfr+Qy7s3fqAc7HhNtMhVOBc72tDs9HdCFnwzWlVIo=;
 b=zPLna+m8YTm7dm+EwBDidriWN91AT2T47ZuIlhhkPPsVYbW5YAfLW7FYL/ztbjFOZlYNZF14fJzYyTxv7E/d8HrgqQbX8V35Q+Q0ufUuB5uZxhmHNWKNs4IzJQSwNQ2NGyVZYgeaexuGHodoS/FbeKMA6fur2TRX1/lZcmCxaN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GV1PR08MB7681.eurprd08.prod.outlook.com (2603:10a6:150:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Tue, 20 Feb
 2024 09:40:22 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4%6]) with mapi id 15.20.7270.043; Tue, 20 Feb 2024
 09:40:22 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Date: Tue, 20 Feb 2024 10:39:23 +0100
Subject: [PATCH 13/14] media: rockchip: cif: add support for rk3568 vicap
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-v6-8-topic-rk3568-vicap-v1-13-2680a1fa640b@wolfvision.net>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
In-Reply-To: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
To: Mehdi Djait <mehdi.djait.k@gmail.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708421995; l=10682;
 i=michael.riesch@wolfvision.net; s=20230803; h=from:subject:message-id;
 bh=P9Qxsw9kjyeE5rbxicA+k/0vkgilDJms8XWxah2XXTE=;
 b=AdirQIj9JolCGpJ3i/cVeTkZRxGso9vf0xUn8Q+zjsuocZy/Fu0BOCXFy3Wtedfi+kye5grBs
 Jq66aqW0oeDDUBmolBvR6oJconbVU25f+EkswsYTAmOA3ilWVm5LQKf
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=9ral3sulLe95bLcbaiNXTgUTRiBayRBEFZ5OVIEHp+0=
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GV1PR08MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5f7d57-60ad-4390-f70c-08dc31f7f55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N+Vgm2EOxCYGT0zLYarKoqGeWqi09v0GRPvMBaL3ZIag6b5YZqwNcf57OfFFEx8NTPzNz0Gl1AwA11NrlP20WcP/mvtunlXToqQ977PX07iuxEDXw2mfEYGaTuuT4UV5xDBYS+GdSI/DRbBkGK38wk5P5d+I8vP7j02dKgKOIOUea2Ipee3FhaWRtWOReTwAltPKZgcYQi5MFME2QFm+cZ629MrAUv+dqScA/tj3BXV3QIvcb0PL3DFUTmVdiD6GSPlk8BTEj2X5yTQR3Jnx3m1p8EuWWVy+/mCy7or3qD+IonJkDoLp9wEvWSK5OZ/b8/OesC2PqvrDfw8+p0H2yBEooLYB81Mq1kEF8BD5uz9IzUxXMulRoXMFHurAJj/fGsKJ7knBZTCdv4l7WV3IUFSxDENEEKrzbi4ZGW3UJc+ybApH1xZ4nBX6CMSSXcSzdqNH8P/l/ozEPXQZGvvqMzT2SQ0+cTdFsysjrGTLFDoKd8r/MEd/fhMIdtpqL5U8FsK2xkiscx/GkFE3RGgucgAQgnQyyNyJtyExuQDkj6j7HxyYL0b8C2VmnzXSEK336IxhDdzxcbMjk1aSvBi8Yj7iPzZR2qYpVp5uM9QsMnrF228tB/J/l06RLnZ2fhyEFtceQXE+ya/41a0npUTiCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm9PeVkrWGNhK0diYjlBc0FrbVEzWDY5VTNTTFkwN29OaDNEWldmVmdJQ05v?=
 =?utf-8?B?WVBMbTMzZEdNSkdReE1BSXFaNmlKS0tDZW12bm5IVzgxOUZKT0djM1RPNjcv?=
 =?utf-8?B?TWhFbEJVeDZtMnNlUnF1L1YzSW5zZHY1TllXQTRaNndweVh3TklVcTZsN0xr?=
 =?utf-8?B?cGhSTnhsb2RJNUtPbjRGbzhnQWRDU2Fpc1R0QkkxM0J6OExHL1g4WFd2cnor?=
 =?utf-8?B?REdxQ2ZLd3VFVWtsa042R3BBNTU1OFRVbFhRRUtkUWF3OGpYQzQ3OFVSZUF6?=
 =?utf-8?B?UEM3WTh6ZENrZU5JeVZuNjNGQ3lFN3NvSUhSWjYzVGlZSUppRlFQa21sdUxL?=
 =?utf-8?B?VUZiZGQvNWkwWGVUaGxja0YvRXpyNUE0ZTd2eENDUTB6dXMwSS9lWWxYeExQ?=
 =?utf-8?B?M1VmQkZDd1oxUVZGdEU4TzRQTllGM2dRSnEwT1Rqb1BxTHVpRVFmeHlRbDhP?=
 =?utf-8?B?U2FZRE54dTVQWjBvR1VNLzlhVTFSc0lKRmZJNm93R0lod0NWVldsNGU4aWtI?=
 =?utf-8?B?QTA2MEpVSHJOaXpLNE92a1dxVGgrbXUrRG45WVlRNEZ6amxWYUNmNW9zcUdF?=
 =?utf-8?B?bGFwYTdJTGRud3gyRkhpVWVMdHM5ZW1TMXFaV1BMc0lxUHZnVUVjUDhoc3VF?=
 =?utf-8?B?REZwcTlPTG15V05WaG03Q3dObmlsSU80OUtTVGlYVWF1dXF3amlvNGV2dE9R?=
 =?utf-8?B?dTZoZjNjaDVNOG0yUTc5QzQzOFNPK2g5Y2VNc2I0SlBJYkZWM3hZRnNWVmNr?=
 =?utf-8?B?UU5WQ0hOQzZiQjRrTHVTSUwwTzNZRzdJMWw0NlZPY01yNjNMeUdieFNZSU9H?=
 =?utf-8?B?NytQNGkrUmpzYzkrRDRoZkthdmhVb2E3aXZPZUhvSGVtdVRtOENtTUYyN0Mv?=
 =?utf-8?B?SDVwc2dZZXBCSG1MSUhRVWhGVlNTRXFoSFNFc0Q4dk9EdDNoOTBtMkJBcVZ1?=
 =?utf-8?B?bkQzZ2U0L3RxV3UrRGFubzVWOEx6QklQQTZTZkhlWUZDcTBNNldrWmRjZm5Z?=
 =?utf-8?B?MC9wY1podXlEd2Jab29EWnBDSktZM1BtQWE2RXFrbVBTSk50UkQ2K0x2YWlq?=
 =?utf-8?B?UEQxL0p5aU5WL2xrR2NRU3NvSTFZODhnOWtmSVBmSWRFMHpoOTZ4ZlZ2aCt5?=
 =?utf-8?B?ckptS1N4a0Jkb1JNMzZsbzZxU1dZMys3Q2t4NmttY0U5bTJRVnpPS0pyYlJi?=
 =?utf-8?B?NmtPR0NrYXR1Z0tMdlVSaW90Q0RRVUljWHlLWFM1UmtkRW9RV0l1YmEvU0xz?=
 =?utf-8?B?WFM3NmpZeVd6UXE1WVU3cDBMNFFNSTlWR2o4VEFZYXJXMFVSUDQyTlBGRmxu?=
 =?utf-8?B?cTJiT0t1bVhJbnJsTEVCZ3BqWCtub0h5VFJXdmc0aUVrbVdUdTBweWlLNlps?=
 =?utf-8?B?MnlNSlZEb2ZNZllVYVBVdExnRFRGbHJNL29vUC9aTHpoN3o4cnNsM0xrZFUz?=
 =?utf-8?B?cmFxeGZhY3hyM2VEcGpURG85Y0luU1ovdU4wdnNxaVdxSkxVWHZQbEVzN3dp?=
 =?utf-8?B?ZGVrLzkyU1R3STRLYm54Ti9Ic2doK3FxSmpjQ0x4b2ZqSFYxVFNpdUZ3MTJL?=
 =?utf-8?B?RFk2YTd4alhISFBpZXA3SHY1amJLbHBvdmN2dmljN3JOMXlCc1ByaW5KQXlZ?=
 =?utf-8?B?UHlRclFkVnNlaUZraFpqVmNSaWpWSm1rVFdVeEh4VVNzREZvK1l4SHZRRXky?=
 =?utf-8?B?QUxyRHJmTEFYcE14ZkloMTV6K1lGYjBSdThwNDBWeWN3T0JkK1lCZERPRytY?=
 =?utf-8?B?RUhVN2xtS3BYZHFsczBPRmpJbXZmcjZXQmdybmZHdy9sdkxzQUZMc0pGZmFY?=
 =?utf-8?B?VEpZcHJJZTJRY0ZXcHdmcTl4aWIwaXg2cmtEVm5LbzZuTEt1cFJXNzhzcDRY?=
 =?utf-8?B?K0g3NXh4cEJIQWtnelFVdmljSnE0Y1o4RFgySm9tSjhRbEpuWDlpR3lJbWhR?=
 =?utf-8?B?MGUrUDFYczhiZGs1WEtMRVkrM2pQSEFtSDJnWnJLSjlES05QMHIrTXlQekVT?=
 =?utf-8?B?Mjk2VTNMbHUxb3ZTaExreDF5dzg0NUtMOWFjMFpQalpSM3psakFicHhvVzFU?=
 =?utf-8?B?WUk0M3pCYU1sMUlWYWFaN0tIeUMyWG80amw1WlFobW8rWjRUZUVHU2dUMlFG?=
 =?utf-8?B?TjNpWHRrU2Nsb2lxUCtSaUJIZ3E1NlpXRlRYSTRLN09GOXFsOHhXUUEvY2Q3?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5f7d57-60ad-4390-f70c-08dc31f7f55b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:40:22.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHrLfHlV9CNgV9LPTEcx5Baj9LiA3U3syKCSn6PyMH88L8WgzC2JIU752qI+PTVLqg75bmEhLqEF4/AvwGEjkIRz3Qy4KURSoYXnxWJGUOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7681

Add support for the Rockchip RK3568 video capture (VICAP) block.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 drivers/media/platform/rockchip/cif/cif-capture.c |   6 +
 drivers/media/platform/rockchip/cif/cif-dev.c     | 247 ++++++++++++++++++++++
 drivers/media/platform/rockchip/cif/cif-regs.h    |   9 +
 3 files changed, 262 insertions(+)

diff --git a/drivers/media/platform/rockchip/cif/cif-capture.c b/drivers/media/platform/rockchip/cif/cif-capture.c
index dd5c45f28cdd..d0e8f3b49d38 100644
--- a/drivers/media/platform/rockchip/cif/cif-capture.c
+++ b/drivers/media/platform/rockchip/cif/cif-capture.c
@@ -340,6 +340,7 @@ static int cif_stream_start(struct cif_stream *stream)
 	u32 val, fmt_type, xfer_mode = 0;
 	struct cif_device *cif_dev = stream->cifdev;
 	struct cif_remote *remote_info = &cif_dev->remote;
+	struct v4l2_mbus_config_parallel *parallel;
 	int ret;
 	u32 input_mode;
 
@@ -351,6 +352,11 @@ static int cif_stream_start(struct cif_stream *stream)
 		      CIF_FORMAT_INPUT_MODE_NTSC :
 		      CIF_FORMAT_INPUT_MODE_PAL;
 
+	parallel = &cif_dev->vep.bus.parallel;
+	if ((parallel->bus_width == 16) &&
+	    (parallel->flags & V4L2_MBUS_PCLK_SAMPLE_DUALEDGE))
+		xfer_mode |= CIF_FORMAT_BT1120_CLOCK_DOUBLE_EDGES;
+
 	val = input_mode | stream->cif_fmt_out->fmt_val |
 	      stream->cif_fmt_in->dvp_fmt_val | xfer_mode;
 	cif_write(cif_dev, CIF_FOR, val);
diff --git a/drivers/media/platform/rockchip/cif/cif-dev.c b/drivers/media/platform/rockchip/cif/cif-dev.c
index 929ea39dd832..3b895b496c45 100644
--- a/drivers/media/platform/rockchip/cif/cif-dev.c
+++ b/drivers/media/platform/rockchip/cif/cif-dev.c
@@ -302,11 +302,258 @@ static const struct cif_match_data px30_cif_match_data = {
 	},
 };
 
+static const struct cif_input_fmt rk3568_in_fmts[] = {
+	{
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_1X16,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV |
+				  CIF_FORMAT_INPUT_MODE_BT1120 |
+				  CIF_FORMAT_BT1120_TRANSMIT_PROGRESS,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_1X16,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV |
+				  CIF_FORMAT_INPUT_MODE_BT1120,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_1X16,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU |
+				  CIF_FORMAT_INPUT_MODE_BT1120 |
+				  CIF_FORMAT_BT1120_TRANSMIT_PROGRESS,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_1X16,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU |
+				  CIF_FORMAT_INPUT_MODE_BT1120,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_1X16,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV |
+				  CIF_FORMAT_INPUT_MODE_BT1120 |
+				  CIF_FORMAT_BT1120_YC_SWAP |
+				  CIF_FORMAT_BT1120_TRANSMIT_PROGRESS,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_1X16,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV |
+				  CIF_FORMAT_BT1120_YC_SWAP |
+				  CIF_FORMAT_INPUT_MODE_BT1120,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_1X16,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU |
+				  CIF_FORMAT_INPUT_MODE_BT1120 |
+				  CIF_FORMAT_BT1120_YC_SWAP |
+				  CIF_FORMAT_BT1120_TRANSMIT_PROGRESS,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_1X16,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU |
+				  CIF_FORMAT_BT1120_YC_SWAP |
+				  CIF_FORMAT_INPUT_MODE_BT1120,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_RGB888_1X24,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	},
+};
+
+static struct clk_bulk_data rk3568_cif_clks[] = {
+	{ .id = "aclk", },
+	{ .id = "hclk", },
+	{ .id = "dclk", },
+	{ .id = "iclk", },
+};
+
+static void rk3568_grf_dvp_setup(struct cif_device *cif_dev)
+{
+	u32 con1 = RK3568_GRF_WRITE_ENABLE(RK3568_GRF_VI_CON1_CIF_DATAPATH);
+
+	if (cif_dev->vep.bus.parallel.flags & V4L2_MBUS_PCLK_SAMPLE_DUALEDGE)
+		con1 |= RK3568_GRF_VI_CON1_CIF_DATAPATH;
+
+	regmap_write(cif_dev->grf, RK3568_GRF_VI_CON1, con1);
+}
+
+static const struct cif_match_data rk3568_cif_match_data = {
+	.clks = rk3568_cif_clks,
+	.clks_num = ARRAY_SIZE(rk3568_cif_clks),
+	.grf_dvp_setup = rk3568_grf_dvp_setup,
+	.in_fmts = rk3568_in_fmts,
+	.in_fmts_num = ARRAY_SIZE(rk3568_in_fmts),
+	.has_scaler = false,
+	.regs = {
+		[CIF_CTRL] = 0x00,
+		[CIF_INTEN] = 0x04,
+		[CIF_INTSTAT] = 0x08,
+		[CIF_FOR] = 0x0c,
+		[CIF_LINE_NUM_ADDR] = 0x2c,
+		[CIF_FRM0_ADDR_Y] = 0x14,
+		[CIF_FRM0_ADDR_UV] = 0x18,
+		[CIF_FRM1_ADDR_Y] = 0x1c,
+		[CIF_FRM1_ADDR_UV] = 0x20,
+		[CIF_VIR_LINE_WIDTH] = 0x24,
+		[CIF_SET_SIZE] = 0x28,
+		[CIF_FRAME_STATUS] = 0x3c,
+		[CIF_LAST_LINE] = 0x44,
+		[CIF_LAST_PIX] = 0x48,
+	},
+};
+
 static const struct of_device_id cif_plat_of_match[] = {
 	{
 		.compatible = "rockchip,px30-vip",
 		.data = &px30_cif_match_data,
 	},
+	{
+		.compatible = "rockchip,rk3568-vicap",
+		.data = &rk3568_cif_match_data,
+	},
 	{},
 };
 
diff --git a/drivers/media/platform/rockchip/cif/cif-regs.h b/drivers/media/platform/rockchip/cif/cif-regs.h
index 2ce756fde204..261bc71240f2 100644
--- a/drivers/media/platform/rockchip/cif/cif-regs.h
+++ b/drivers/media/platform/rockchip/cif/cif-regs.h
@@ -117,4 +117,13 @@ enum cif_register {
 #define CIF_CROP_Y_SHIFT			16
 #define CIF_CROP_X_SHIFT			0
 
+/* GRF register offsets */
+#define RK3568_GRF_VI_CON0			0x340
+#define RK3568_GRF_VI_CON1			0x344
+#define RK3568_GRF_VI_STATUS0			0x348
+
+#define RK3568_GRF_VI_CON1_CIF_DATAPATH		BIT(9)
+
+#define RK3568_GRF_WRITE_ENABLE(x)		((x) << 16)
+
 #endif

-- 
2.30.2


