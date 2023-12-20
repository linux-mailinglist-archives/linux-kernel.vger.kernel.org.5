Return-Path: <linux-kernel+bounces-6587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E6819AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477391C2587A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607791DA5D;
	Wed, 20 Dec 2023 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="Np0BcqUQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61161CF91;
	Wed, 20 Dec 2023 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m26vLmmjO7Huo3uAiNz/nLpvybyV1nf+fbf8cfJI1DllQItdT1MgfvEgjBCAu8h73HAz1rhCpFE6E3gKMH7M2xbvlQlHNivT4wWJyv4Vb3yt8227rI/yJD9g3irmO1AugWXlru5wCUm4XKbRHEsp3oXeL4Pz+/2s/rwhWl81/2ZJ1iqEPe7eacN+0iB9onUL+rob1nLnaYecUWOzvk78/4pmvrXA5ejxLuOlAQpm9+VPjofZhkHMd526Or8C6isRI4R2cCoi7taw8yeJY+otR6+6TlnA/FmoGszpijWYGltkSnScIC3A6rBPsOl3pjZvlYmx684anxBImPJGoM7/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD7ZJu/VWFDfV/tF/+vLXNLqckjUgjKidYG16Xk97Cw=;
 b=KeOlONwDzrXG+/N2ctsqYqFLnR957peWugxqenAxK3fpS0Czfmk4ZpF3q+KRrGZi386J4277i6DiHorn2b5bp68rICvb6sUQZ7YKKpKmfJz7xRyFu0SSovcw5aCyDoKq9Tbnc5YWWrg+akvyWgFlzJqwZxN99r7IiSwFhovin3lglqwWm4ujqes+zVB5phA4XMwXNx8sBZZPFKQJBjC7mhmDCyznskHQsM5NcuJH78u2w+neX2UHVDAzBil1q7462FO5pr7onUOZF4F5AbCyLy7gc5IVaBBg0Yd4Wk8mwied0SbrdC2Ught1Y+vTpq83TyO46MfSxCmkoo1C4GeYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD7ZJu/VWFDfV/tF/+vLXNLqckjUgjKidYG16Xk97Cw=;
 b=Np0BcqUQd/iIikalLH9p4JB44tSqXci9/Oac5jvg2TmyN507dA/5g3alCSYItZlrqg3WRQjKfvAQAsiE1FDmbv0QaYgSlzG0Eq7tL57bo10bCflOUDGfYeDtdrDiVBwmthZ/xAt1e6s4Op2aosvUOCdT4uwHbKVGWtj/mWeF5yQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PA4PR08MB6080.eurprd08.prod.outlook.com (2603:10a6:102:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 08:39:51 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 08:39:51 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Wed, 20 Dec 2023 09:39:44 +0100
Subject: [PATCH v6 2/4] Input: touch-overlay - Add touchscreen overlay
 handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v6-2-d8a605975153@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703061588; l=11458;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=tI6v2r0jXUhusYFinMuYKLp27r+Or+RfBkCl79XERDI=;
 b=J+27Au8m2ZoUTNwpg/0fM7Bivw8AJPhjRbptAiVdquHjR2GLyHqmnFlceIEef+HDClOJD/I0c
 XLtsfSWsfHXB+vwA47AsJbhG8YRZgfAUS4ex9q2//ClUcal7xq6pvDd
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0502CA0028.eurprd05.prod.outlook.com
 (2603:10a6:803:1::41) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PA4PR08MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: fd689b33-04d3-4459-847c-08dc01373b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/nZQgTMfqmST01cKjlswdW5Pr4pHFvGg7zJ+0Ooek+uiAKRjkS2H2fmf9Mwr79W9COYRVRhc8ijdinnmUUIgZYIgjAJEuFKkpUKmik5uy6sPcDzaMwX7yoOsy2O0qDB44sVr4o/VbYe1Q7ejI5Jdc+r8mHM7k+SVOWgk2EcryheSfphx56J8lVa4QEEhF0MHLrNlrs6DDrNSRfDz3H+2sUPIeUBnnmNfh03PR+EiPGGZYixwWZHYFVZOISdqluCXp9NpZUE7HvE3KqQ4OQo4SDJFpSADKLNS7dgRspqRuF76S90m8sj4Q84178aXMR9+ycUuH0gkgIT2hOyrcSyTDDDMb5zOI4DB8xWtjLUGzKrVE343uHpROYU1+WoSXufemUMKrmPLRihxEXaLS4XWygQzc5x/oqn4Zbx3asH7clugNkCSxt4qlVVEbqry+nlcmGQ1bf2F0sSRcwnfZ8lONlxH5Ciu5dyX74alznUDz8J/7xFdZ68XwDQmpd2tfSuZt7TYT2JTtCe9xJ+giaI9dSkjWlv7PpxwkdpN3S8jIqcfTZMXkP/oMWL12kRMtfD3TrmTytreyZ7ZcOME9BW3itIAJE9FnFZ53ccaljda/XxvsSlYCRAblV8VArOh33Ez
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(86362001)(6666004)(6506007)(6512007)(52116002)(478600001)(26005)(107886003)(6636002)(316002)(66946007)(66556008)(66476007)(44832011)(6486002)(110136005)(83380400001)(38100700002)(36756003)(2906002)(4326008)(30864003)(5660300002)(8936002)(8676002)(38350700005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG0vTHJvV05Ec2ZucTZnR01kT1l0TDdNUCtnNklMdDBCNHZPZGNTd1htdjhv?=
 =?utf-8?B?Z052L3ZWSzIvUkNMN1FXNWk0TWpNUEFTcFdKU0x1STFWa2E5SXVXSFFJMTFj?=
 =?utf-8?B?L3VaNmtRRHVybStKQjJGd0ExL1ZXNHllT0owY3VLY0IxYXM4dU9MeElMMDJs?=
 =?utf-8?B?T2dGMWxDMEtXU1F5MnpsYVBSVVA5UUpTbFpmdGxPeXgvbWZqNktkR09qcnRk?=
 =?utf-8?B?dFVZSkE2RnFNWi96L2ZiY1JNc0FlZHBXbFd5QVRSNHNtdlp1OFVQaHRNVE4r?=
 =?utf-8?B?TFIvbU5BOS9lNFJZRlNLbEUyU3ZveW9uajZLa3dYUWpvSThOVnRLWDhxd3Ro?=
 =?utf-8?B?NXp4WEJjU0VpRURBQ29Wc0lsVlNlcTFHamF5Ly9PbWlIRFNLSzF5SnZUU1N6?=
 =?utf-8?B?bW0wdnUvVldsZVc4eXpNSGo3ZTBZS3I0NXNNOFE0MEFqVWl5TW5ja1l5QW5S?=
 =?utf-8?B?dEJUeXNOQ3ZHajhmbzlDRXJSSFJyQnZDYzBzc08xYjA5bVRyUHdDT2RiRk45?=
 =?utf-8?B?eFZESzJXRXNkc0ExSVJDZDlUNWtKdkZFR0E4VHFtT0NLWGhjZWcvV0pJdmV6?=
 =?utf-8?B?bFhld1NENzdkalprSnZuRmFhZDkxTWFxdms1WUdEdEFHQVZ0clNBZndCejhQ?=
 =?utf-8?B?N0tlaTdHM29HMTV3SHROcW5xY00rMFBjY0pOZVl3TnFnVmhuQkRvMlZCajVa?=
 =?utf-8?B?UW5WK04yRzAzWmFNKzF4Y2o2Q1g1eC9xbVR0c0dRS0IxZ1RWZFVLVXBVTVZn?=
 =?utf-8?B?ZjNrL3hTWVBrM2Y4MGY2Sks2NW5aQmhXWGp2WUpKUHNRSlR0bTNWeGRQbDdQ?=
 =?utf-8?B?c09WdjBhSUlYd0VsWjg5aGs4b2FqNGY0UWFyNnpDdjZFMjF2U3gzUjc0RHZy?=
 =?utf-8?B?NUVOOGhJbEp2UmpMenVBTjRGaGt0dGd1WDdpSUxBdW1qMXEwUVlVZmFQTlkz?=
 =?utf-8?B?R2JEUlRldU42U3BmSHFCVk1aajRSUVVaSWUzZnJndVkvdk83QkhVTzQ4QkQx?=
 =?utf-8?B?Q3czZjRPNk44S29KblFBSG95eEQ0eXZVU296cSsvM1owUElRbncvT0J2bFpL?=
 =?utf-8?B?WVVIV2M3d2NDVWwzZEEzQjkwdGg3ajVqWjErSm9XekZVenJiTGZxR1JIV3F1?=
 =?utf-8?B?Uk4xVTVzZEp1Mkt0Yy9wTGhNOTRHOHdGUTJSREVldmxiZzJmUlduampsU1I2?=
 =?utf-8?B?SUxOU3NxQ2pMUVQ2TW5GYmFWZDNqV005aXpaaTBJcFpIdEp1SWc5alhoNzJ0?=
 =?utf-8?B?S2N1NGNSc2RtU1NPS0pCUFN1SGczVEE4dHE5MXV5OHFWejQ2T3dlVUtRaFF3?=
 =?utf-8?B?NFk3U1VUODRqOXhETGFSbE5mOURnOGFwb1QrSkU4ZGVmSW1aMHovaW1WbUtV?=
 =?utf-8?B?UjlxUkZRTXY1MXJndng0SnVDL3RpcHJnZ3BmY3g5SWZjSjBtcjFkZXBEYnFy?=
 =?utf-8?B?ODlKdWZsd2JFb083M3dzYk1BZ2NxNWVMQk9YVU9WU2NJdmszek9rMHNjWGhk?=
 =?utf-8?B?YWNUYU85VW94VmZTSmFMZGxVNFdGdmhOb2Jlcjd4Ti9hSllMcGJ5QktwVUJJ?=
 =?utf-8?B?NGE3ZEEwTC92b0xjWmI0NWZ0aGk2R0tHR2lyVkF1bDlpdGJGcnVvV3pVRmpj?=
 =?utf-8?B?TDZFOGYyeVBFdkdNNWdOL0kxVDVGeHFETytubU5qZVBjUU4wNEtkTGtkR1Ns?=
 =?utf-8?B?YXRuRDNwaUcxYzQxeHZGdWtVSTFRN21iaGJhZzdrZmthcFdtRUlyaTE4VHZG?=
 =?utf-8?B?ZVBJam1tVFV0TVdjb2RZVFh2R1pCSnMvK1BBQlhxc0hXeENLK2VaRjVsMzNU?=
 =?utf-8?B?eG1Ma1kwYzNqTnZxNjNaNnJHVzBiMUNyT3h3STkraTh6a25pOVMwbEN6Uiti?=
 =?utf-8?B?YWFBUFdhblhaQ09sOWwvOFBtOTNhVGxJb1NWZlczZkFkeWp6d3NIQzU3VWts?=
 =?utf-8?B?OGdJUG40c2JpM09lYXh2V2hLZHI1dlBXMlVsaUNPYTZjMWVKb1NUN2l4UENV?=
 =?utf-8?B?V0RlTC9UMlJXR05VRXFuN2lRV3MxbGNSaHBnYU85czQvTTdaSmNxelM2Z0Yx?=
 =?utf-8?B?eGh2RzRyVnVqb0dMak54aVNsY3lRT0wzcmNNeVJvZEtad0FyQS9aU2dMOURP?=
 =?utf-8?B?aXFWSGswekxROVBxYk5IdEcyQ29ZUG1mY0FLdUU0clIyV2F1bjN1aHdNL2U3?=
 =?utf-8?Q?uvg/a/aLE7VlLx+0OGNMJ4g=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fd689b33-04d3-4459-847c-08dc01373b5f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 08:39:51.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kx+lg9u1+2eRDjPqb3fh/Q7J6dgfaATuIMABNzH8AeP6PsV4E86sUtKD3mMXaJursPtipvwZsVJb2QtrKZdPtA6YHJPEyA+MhwZ7Y8MJZjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6080

Some touch devices provide mechanical overlays with different objects
like buttons or clipped touchscreen surfaces.

In order to support these objects, add a series of helper functions
to the input subsystem to transform them into overlay objects via
device tree nodes.

These overlay objects consume the raw touch events and report the
expected input events depending on the object properties.

Note that the current implementation allows for multiple definitions
of touchscreen areas (regions that report touch events), but only the
first one will be used for the touchscreen device that the consumers
typically provide.
Should the need for multiple touchscreen areas arise, additional
touchscreen devices would be required at the consumer side.
There is no limitation in the number of touch areas defined as buttons.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 MAINTAINERS                         |   7 +
 drivers/input/Makefile              |   2 +-
 drivers/input/touch-overlay.c       | 283 ++++++++++++++++++++++++++++++++++++
 include/linux/input/touch-overlay.h |  24 +++
 4 files changed, 315 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..3218d8694735 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22031,6 +22031,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/toshiba-wmi.c
 
+TOUCH OVERLAY
+M:	Javier Carrasco <javier.carrasco@wolfvision.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touch-overlay.c
+F:	include/linux/input/touch-overlay.h
+
 TPM DEVICE DRIVER
 M:	Peter Huewe <peterhuewe@gmx.de>
 M:	Jarkko Sakkinen <jarkko@kernel.org>
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index c78753274921..393e9f4d00dc 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -7,7 +7,7 @@
 
 obj-$(CONFIG_INPUT)		+= input-core.o
 input-core-y := input.o input-compat.o input-mt.o input-poller.o ff-core.o
-input-core-y += touchscreen.o
+input-core-y += touchscreen.o touch-overlay.o
 
 obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
 obj-$(CONFIG_INPUT_SPARSEKMAP)	+= sparse-keymap.o
diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
new file mode 100644
index 000000000000..0a0646ceb755
--- /dev/null
+++ b/drivers/input/touch-overlay.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Helper functions for overlay objects on touchscreens
+ *
+ *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touch-overlay.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/property.h>
+
+struct button {
+	u32 key;
+	bool pressed;
+	int slot;
+};
+
+struct touch_overlay_segment {
+	struct list_head list;
+	u32 x_origin;
+	u32 y_origin;
+	u32 x_size;
+	u32 y_size;
+	struct button *btn;
+};
+
+static int touch_overlay_get_segment(struct fwnode_handle *segment_node,
+				     struct touch_overlay_segment *segment,
+				     struct input_dev *keypad,
+				     struct device *dev)
+{
+	int error;
+
+	error = fwnode_property_read_u32(segment_node, "x-origin",
+					 &segment->x_origin);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "y-origin",
+					 &segment->y_origin);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "x-size",
+					 &segment->x_size);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "y-size",
+					 &segment->y_size);
+	if (error)
+		return error;
+
+	if (fwnode_property_present(segment_node, "linux,code")) {
+		segment->btn = devm_kzalloc(dev, sizeof(*segment->btn),
+					    GFP_KERNEL);
+		if (!segment->btn)
+			return -ENOMEM;
+
+		error = fwnode_property_read_u32(segment_node, "linux,code",
+						 &segment->btn->key);
+		if (error)
+			return error;
+
+		input_set_capability(keypad, EV_KEY, segment->btn->key);
+	}
+
+	return 0;
+}
+
+/**
+ * touch_overlay_map - map overlay objects from the device tree and set
+ * key capabilities if buttons are defined.
+ * @list: pointer to the list that will hold the segments
+ * @keypad: pointer to the already allocated input_dev
+ *
+ * Returns 0 on success and error number otherwise.
+ *
+ * If a keypad input device is provided and overlay buttons are defined,
+ * its button capabilities are set accordingly.
+ */
+int touch_overlay_map(struct list_head *list, struct input_dev *keypad)
+{
+	struct fwnode_handle *overlay, *fw_segment;
+	struct device *dev = keypad->dev.parent;
+	struct touch_overlay_segment *segment;
+	int error;
+
+	overlay = device_get_named_child_node(dev, "touch-overlay");
+	if (!overlay)
+		return 0;
+
+	fwnode_for_each_child_node(overlay, fw_segment) {
+		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
+		if (!segment) {
+			error = -ENOMEM;
+			goto put_overlay;
+		}
+		error = touch_overlay_get_segment(fw_segment, segment, keypad,
+						  dev);
+		if (error)
+			goto put_overlay;
+
+		list_add_tail(&segment->list, list);
+	}
+
+put_overlay:
+	fwnode_handle_put(overlay);
+	return error;
+}
+EXPORT_SYMBOL(touch_overlay_map);
+
+/**
+ * touch_overlay_get_touchscreen_abs - get abs size from the touchscreen area.
+ * @list: pointer to the list that holds the segments
+ * @x: horizontal abs
+ * @y: vertical abs
+ */
+void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (!segment->btn) {
+			*x = segment->x_size - 1;
+			*y = segment->y_size - 1;
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL(touch_overlay_get_touchscreen_abs);
+
+static bool touch_overlay_segment_event(struct touch_overlay_segment *seg,
+					u32 x, u32 y)
+{
+	if (!seg)
+		return false;
+
+	if (x >= seg->x_origin && x < (seg->x_origin + seg->x_size) &&
+	    y >= seg->y_origin && y < (seg->y_origin + seg->y_size))
+		return true;
+
+	return false;
+}
+
+/**
+ * touch_overlay_mapped_touchscreen - check if a touchscreen area is mapped
+ * @list: pointer to the list that holds the segments
+ *
+ * Returns true if a touchscreen area is mapped or false otherwise.
+ */
+bool touch_overlay_mapped_touchscreen(struct list_head *list)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (!segment->btn)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(touch_overlay_mapped_touchscreen);
+
+/**
+ * touch_overlay_mapped_buttons - check if overlay buttons are mapped
+ * @list: pointer to the list that holds the segments
+ *
+ * Returns true if overlay buttons mapped or false otherwise.
+ */
+bool touch_overlay_mapped_buttons(struct list_head *list)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (segment->btn)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(touch_overlay_mapped_buttons);
+
+static bool touch_overlay_mt_on_touchscreen(struct list_head *list,
+					    u32 *x, u32 *y)
+{
+	struct touch_overlay_segment *segment;
+	bool contact = x && y;
+	struct list_head *ptr;
+
+	/* Let the caller handle events with no coordinates (release) */
+	if (!contact)
+		return false;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (!segment->btn &&
+		    touch_overlay_segment_event(segment, *x, *y)) {
+			*x -= segment->x_origin;
+			*y -= segment->y_origin;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static bool touch_overlay_button_event(struct input_dev *input,
+				       struct touch_overlay_segment *segment,
+				       const u32 *x, const u32 *y, u32 slot)
+{
+	bool contact = x && y;
+
+	if (!contact && segment->btn->pressed && segment->btn->slot == slot) {
+		segment->btn->pressed = false;
+		input_report_key(input, segment->btn->key, false);
+		input_sync(input);
+		return true;
+	} else if (contact && touch_overlay_segment_event(segment, *x, *y)) {
+		segment->btn->pressed = true;
+		segment->btn->slot = slot;
+		input_report_key(input, segment->btn->key, true);
+		input_sync(input);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * touch_overlay_process_event - process input events according to the overlay
+ * mapping. This function acts as a filter to release the calling driver from
+ * the events that are either related to overlay buttons or out of the overlay
+ * touchscreen area if defined.
+ * @list: pointer to the list that holds the segments
+ * @input: pointer to the input device associated to the event
+ * @x: pointer to the x coordinate (NULL if not available - no contact)
+ * @y: pointer to the y coordinate (NULL if not available - no contact)
+ * @slot: slot associated to the event
+ *
+ * Returns true if the event was processed (reported for valid key events
+ * and dropped for events outside the overlay touchscreen area) or false
+ * if the event must be processed by the caller. In that case this function
+ * shifts the (x,y) coordinates to the overlay touchscreen axis if required.
+ */
+bool touch_overlay_process_event(struct list_head *list,
+				 struct input_dev *input,
+				 u32 *x, u32 *y, u32 slot)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	/*
+	 * buttons must be prioritized over overlay touchscreens to account for
+	 * overlappings e.g. a button inside the touchscreen area.
+	 */
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (segment->btn &&
+		    touch_overlay_button_event(input, segment, x, y, slot)) {
+			return true;
+		}
+	}
+
+	/*
+	 * valid touch events on the overlay touchscreen are left for the client
+	 * to be processed/reported according to its (possibly) unique features.
+	 */
+	return !touch_overlay_mt_on_touchscreen(list, x, y);
+}
+EXPORT_SYMBOL(touch_overlay_process_event);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Helper functions for overlay objects on touch devices");
diff --git a/include/linux/input/touch-overlay.h b/include/linux/input/touch-overlay.h
new file mode 100644
index 000000000000..df974eb46dd4
--- /dev/null
+++ b/include/linux/input/touch-overlay.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#ifndef _TOUCH_OVERLAY
+#define _TOUCH_OVERLAY
+
+#include <linux/types.h>
+
+struct input_dev;
+
+int touch_overlay_map(struct list_head *list, struct input_dev *keypad);
+
+void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y);
+
+bool touch_overlay_mapped_touchscreen(struct list_head *list);
+
+bool touch_overlay_mapped_buttons(struct list_head *list);
+
+bool touch_overlay_process_event(struct list_head *list, struct input_dev *input,
+				 u32 *x, u32 *y, u32 slot);
+
+#endif

-- 
2.39.2


