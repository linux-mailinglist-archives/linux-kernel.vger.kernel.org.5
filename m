Return-Path: <linux-kernel+bounces-17817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF6825321
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F6E1F2195D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DEE2D610;
	Fri,  5 Jan 2024 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="iKOzfGqu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4082D601;
	Fri,  5 Jan 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCcQ0uXhYxQ+naes3nxatP1467Nq3bBtsTUmeT++FY7zu/7DNeYIURPl2UqccPrGNF2paVFonUzkiEJ+BTpJOJ6RsvXqRSIDJczXK+tHx+vFXYha9hzJPujYTx1UhCUOp6sAfUUewbKNDI+HiAx/ZeJ/qlZYiMcyZ0u7Q2KlKioI3v0AvpICWARN0fo2SsGGht/HiaopBdHBLNvmIbswKX6cn6df37+mlxO63/taDbMiyOt4o7Qitqpkrmfk3DNFMqUxveNIKmIF+1FKrmMeQm5Gy1MI30ZYwsw3D3d7a5YYpvP9cWd7YSL4CQAG+dvNykmrqgRWUFGNuj76iox4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNXNaRVb0moaAFMdD8RxmAK8lvRkL/oF57z7r0FZP/I=;
 b=V/mqf5EkuP5uiRFBHiyxq/m85VqYMMJMQCXAXZj1imqfTO7TakBNwkyGgIyuM/9Aef0Ly8J2slN4SQYVn7ifo982505kfFFZsoHBUgssDIiJM2ytmUwYVVtrvAnLoOvt9vjnbt0o4PEHbtuXDtwlROKVRVv55i5UQ6ltZDr0DPYKJOGP9cdDOpkKzvQRCgHtMzTr9FBYBeub8NaodvCn4iwkREROY2Xw7pDBtJsHIm6ub9jkBnhuWkVwv59ltx9Rs1KOVXaUklVXI93Sv8fW9JiZ9gB+r7kI7rEYx8hcDQiuWGg8PqHJ8zs4cjslCstUP0MGobv0QGDabJVbtH0hag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNXNaRVb0moaAFMdD8RxmAK8lvRkL/oF57z7r0FZP/I=;
 b=iKOzfGquUhuvXrGdxvv7b541bGkWC2RQslU1M+A+BE4IG40dGFoDzprrDqSasrQNX6Dc3gnRCojBIrS+mHzlD64IZduSSCETXvR9VAJPfmi/zRVX1d26xEleQR9c7SAWlhGOBl4FdmIN2ARJ5Ms/qsk760dOl2spQ3MebriGgJT+K36GXZlg63ZEpLwbE28Oy+ZHLqBTIKvctxAc8Vz/Qnfyd2uoiE38S+gIap/kaZGucAYIkIDrJFaQuCp89BMnFFpFNLG7mo0u3ILHcGwBh6Hh4YypEvMK+58VLHoDC8Pw4bvue/hQTGK2ztwCchb/BqZK1nI5VgxNftIQxlpSkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by DB8PR06MB6490.eurprd06.prod.outlook.com (2603:10a6:10:124::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 11:50:39 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::820:f7b6:7f2b:324b]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::820:f7b6:7f2b:324b%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 11:50:39 +0000
From: niko.mauno@vaisala.com
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vesa.jaaskelainen@vaisala.com,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH v2 2/2] usb: core: Make default authorization mode configurable
Date: Fri,  5 Jan 2024 13:49:56 +0200
Message-Id: <20240105114956.30714-2-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105114956.30714-1-niko.mauno@vaisala.com>
References: <20240105114956.30714-1-niko.mauno@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BAD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:7) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|DB8PR06MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e797143-9dfb-4dab-b478-08dc0de489a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9uPbkcB8C6ioT6WlI8KQy3W3HvGUDna6Q4c2n+o8Dm4/sd1UaRKpr0x7ZOuC2sZaifjX4lylQpYNvyjQEJQcm6RJl6qiR+ogDj/f6I9hpcjbwmiDKrQvqkBL8EiglkUDJ2zK8EikrtcqqI53Q3BRf1ci6qTfTfcRG5k2oY/w9ukSZSLA8y4gf5nwQmKIntfT4rfK9vvy+OTXpYXFc22h5EHnnRwYMthcSFN3Vs6QXG6hjJoL9HvWGS/VUt2AEJrn8kMMHUbx6oZoLSLV7WpfclkanKy/ez5PHeyPI9nbxGhwDsdKTbqDfc7ehE8WdqDO0VjEnVh3XcleUyKteXgZ26ngfRqYL8OhLQtUjPI1tcyXCan7Z11AqlJy8PT7/2KjrnDzUb3xpks9HpXPCr1oAHXLoreDHpxRqx9LopvU7hm8RSG48wg43HiU0My/YhCFHwZT0psSN+p22lhfXte3sPNSaw2hMHvLWFTa6imej2NmAnehks/0lNZDJ0YWPXpCls0qxzMQ+CynFjmtqKKCBTqVoxhTVkUNPENMQA+BqCRPEtd+uJ6BMC3hH9isOeCHu2cBc/idQVcUyqC/XCj2obp9lV/6jOLkDMf5Dg67yhbeV2TQGh/gwds9bk4hq0KT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39850400004)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(2616005)(9686003)(1076003)(478600001)(52116002)(6486002)(6666004)(6512007)(6506007)(107886003)(83380400001)(41300700001)(2906002)(66946007)(6916009)(66556008)(8676002)(8936002)(4326008)(5660300002)(66476007)(316002)(36756003)(38100700002)(38350700005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CieqGXmA1jjp9wWlmAjkNXooUpjRzujLfVJcW25aX/q6YSLw+lM+/4sCfZh1?=
 =?us-ascii?Q?xARrayAglgbZzdh5ZVpLrWdYCyXI5MUxZ23pnCv0e6rzmgo/ciHlum8Gyyx0?=
 =?us-ascii?Q?ySX88rzZwh80sukIV9qA6wFwc5cZr8NKIRtXxM5+76Y09sXEdB/wIZKque4e?=
 =?us-ascii?Q?FOsXilGQkDd3DXGVrQ5Az2gdazobNtm767iPK4OGPkBqaPGo/qWPvxrMrcYY?=
 =?us-ascii?Q?GGvShkaj9ASGYoxc7QKmB5yhUmeR8SSolNX81Q4wg51M0tEBf4z7H0gDT6Vm?=
 =?us-ascii?Q?tVEzfAzKMUT1uCQdXrKMfyn4uKwnaLxtq3PjCsH9uxd6KTbSB+5l3yXkmQhl?=
 =?us-ascii?Q?CFMkKpULIfeLGU65JTLekSjXkB8ctzhn6UEg9TcPfbtf/YNPyswK7UJZcuN3?=
 =?us-ascii?Q?w0vBv6E72NOLePwUcwSCMbX1HvVHe6FrpO6KK3rXgztpvthtyjcoV9AT1IYw?=
 =?us-ascii?Q?hCF11oimpBjVetKgsTfYKhyOoOeDsHSj46epARMrfAeBdiUeGp5rImmX6LOI?=
 =?us-ascii?Q?WNc0TaT0n4x1AYTL5NPj4hcd3O1Y44tVDhSlzlI4t9HvT9Wvjv3KAgk3HQMV?=
 =?us-ascii?Q?fwqwUEGi5IZTlOYMRdXXDgnjDgaHrhJ0PHR8ftQQmpFBjfeJe4x8/oG03vrT?=
 =?us-ascii?Q?joexogN7VozSRHxNQLdLAU2HVB7KrcWpxfGzpEOo4uqFzJBTu7taBTmxxqbq?=
 =?us-ascii?Q?8cB3OS1T8O+0RQ0p1DS8MWyfgG+9k/HEtpRnEwJ8UItTZUpSP0VIYlUUZNc7?=
 =?us-ascii?Q?itXYpY3z1wyC/rJzbG7wVyjwCHBrw6sqKR8NPvTUlwuXCr/Lyr7Fx28rWau1?=
 =?us-ascii?Q?7wLID4sKAK3/Pazl+YKtGCiYS1L3gHENwNI7G0amz1sDNfFtzkejy+y4aWQ/?=
 =?us-ascii?Q?jlYg81xzCO6wJomXsG2eDaDTe4qBeUbvYyp59ZvgcTPEaZGo0nK6CK4cstYt?=
 =?us-ascii?Q?beS5RI3yKoBajy2OnPaWHY+FhzpDUUz8wRZX8EMFPOTTG1nQhOEXFrYUjLeH?=
 =?us-ascii?Q?WxF2X3oyzVq+Rfw1dt616/jVxm7Htba0nl/FrcW15teiq4NjAh8ChX0Ogo7r?=
 =?us-ascii?Q?mC38shsu/W5ovJ3VA97bX/a5vw3j5WvJJ5VuQNsIRz4C/97doDQQ+NKJqmzz?=
 =?us-ascii?Q?16fiZLvIs3yeQ/mWAA5mguW+Vr7Tq43hcZCsWt9NCDgtn267ycWbZFLNjCNV?=
 =?us-ascii?Q?UUKvNs1S4FPPtUiuFIeolOZKDmQAq1gxhKcWZ8qKlUdGlGiVMRIJGu2/7nbH?=
 =?us-ascii?Q?egCCKj8At0AqRm0B4ctHNDHMj1wzdWD/a3wbhGYd5s8WRuzigoH8LYkn60IE?=
 =?us-ascii?Q?c1/vQFQDgcnjZvoDwqKrY9zQRhHN05l6VkggayKUELnTb+9VI1w1pFQSTpJl?=
 =?us-ascii?Q?hZQQa4LTZso1OiZofiSwXU3gH1fRYQB5lKFC6bAmor28B4zGF1UxPoqFTQHJ?=
 =?us-ascii?Q?srpgn0wiozCMZryUVY/wMyoE7hssvplSwJsTRTRwxgmBWOEuWjnTT/87cAWj?=
 =?us-ascii?Q?fdE/kfFbICfEcnL38eVeGD24KpMtPMT/yGZwp9FMuBKeZiWA6t7S4E1X4+lL?=
 =?us-ascii?Q?P6z/LFOjV1k9yXWeeBvSAyfUV1Km2lc1uFr+7APri+um1jWWnQkgrK83EUuu?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e797143-9dfb-4dab-b478-08dc0de489a8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 11:50:39.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQvJtENzXDV75sK0ksoy4Dg82duuVwr4PdDQQjuK5ojQwcFkiAbzGA0IJWl52UK5Iri5fSAd0Mr9RX7Dp/rYCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6490

From: Niko Mauno <niko.mauno@vaisala.com>

Make the default USB device authorization mode configurable at build
time. This is useful for systems that require a mode that is stricter
than the standard setting, as it avoids relying on the kernel command
line being properly set.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/usb/core/Kconfig | 17 +++++++++++++++++
 drivers/usb/core/hcd.c   |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index 351ede4b5de2..f337aaea7604 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -116,3 +116,20 @@ config USB_AUTOSUSPEND_DELAY
 	  The default value Linux has always had is 2 seconds.  Change
 	  this value if you want a different delay and cannot modify
 	  the command line or module parameter.
+
+config USB_DEFAULT_AUTHORIZATION_MODE
+	int "Default authorization mode for USB devices"
+	range 0 2
+	default 1
+	depends on USB
+	help
+	  Select the default USB device authorization mode. Can be overridden
+	  with usbcore.authorized_default command line or module parameter.
+
+	  The available values have the following meanings:
+		0 is unauthorized for all devices
+		1 is authorized for all devices (default)
+		2 is authorized for internal devices
+
+	  If the default value is too permissive but you are unsure which mode
+	  to use, say 2.
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 9aa5e6bf9b9d..d56597dc7d42 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -357,7 +357,7 @@ static const u8 ss_rh_config_descriptor[] = {
 #define USB_AUTHORIZE_ALL	1
 #define USB_AUTHORIZE_INTERNAL	2
 
-static int authorized_default = USB_AUTHORIZE_ALL;
+static int authorized_default = CONFIG_USB_DEFAULT_AUTHORIZATION_MODE;
 module_param(authorized_default, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(authorized_default,
 		"Default USB device authorization: 0 is not authorized, 1 is authorized (default), 2 is authorized for internal devices, -1 is authorized (same as 1)");
-- 
2.39.2


