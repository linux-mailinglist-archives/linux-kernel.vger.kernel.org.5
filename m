Return-Path: <linux-kernel+bounces-16938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09AB824648
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35571C222FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF81250EE;
	Thu,  4 Jan 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="YpvNiNih"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350624B31;
	Thu,  4 Jan 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7a++qb+WUdqhXQwHJby74npaLHwMJ8wi48arsb9HkKsnAUdHxsmI/MqExQODuhOpQdow9GNkIPYrjbKPCxJ68q02RtgbBp60shgh4UY/IJ7CqP7d9yT5XZuJU3AlzjiuAMHoD3vIdZUomwj/ALDAFBSRLM2quSvCBwvXNtJuJC5uSt1u5VUJreOug2QoSzpdCizaePBGoR7nq462zhDmfTVrigPo6xO0abjUm9JHTbc45x3UaxJfWaGW3YIiK9I2OuTy1ThAlY7ZoymVjTCf+K4QwV0usYcRVqbu8tJWkp0Lu5UVT5lfWLqQtHyizKIUA93yiH6T0SdEweMnCDrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6j/PXSSjd7Il1d46P+Q91bGxsgI2QsEh6mSukI9DPo=;
 b=nHKKkY803PAZa2g68VvmrbX1vHu49WrVcjRalgyxPjCrJ31RnYoWoidR/MEOqgcMpUYHmzeKLe04mv1+eZbPyRPBUx25t+dxngrEcII3XPsfAIIsvmsH4Qu/zId5clciPhn2U2RbOE2dNzJHFSGSlWgY9QrFVJEelsHHR+qjoxfNG+jdnHbwTVzjxO+fgVqRSQ4WyNiRa9J9+hnorQTGPyuv5PqrAmOfyfR16zs9R9ul18LqtZSFbw72NaxHan20uKkX22kdGirVQbY/0KFzzB/i9xmWDpn/KLui7QR9+Z3piJSxYY7vWN2Rcurf1Qkc/Bw7q2gX4xtuYcwd8E5osg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6j/PXSSjd7Il1d46P+Q91bGxsgI2QsEh6mSukI9DPo=;
 b=YpvNiNih9IuExiIgHrMQCkTSTOTmYSoXM5l4etokxSJ82kZbdi0wpn0H00d5Q+eYELFP/LIBdyf1e6UWcFfHRu8X0/2srrfmwKgmba4LHJtJY6ZPObtHh4kewIVutaeUFY7FIxBTuDYgl5BTIQZZOpOcfCsfR0UdejGpHxY7jk9p/uGJhagD0QY5s5I62qHqYcAcnpXolFK7jz0AyohhCmdyONfpv9e/oKTTlCCrBn++pcAYshzzk9csk2NJEUxxoP4UcQivNxwSeRx1+xKHxLt+w0EpsALizpkQcZlkSR97hWhJQ2Fv8+vYQ2JaziJRYNdYAKQFWlkJzwjpiGFCLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by AM0PR06MB6497.eurprd06.prod.outlook.com (2603:10a6:208:1a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 16:32:21 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::820:f7b6:7f2b:324b]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::820:f7b6:7f2b:324b%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 16:32:21 +0000
From: niko.mauno@vaisala.com
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH] usb: core: Make default authorization mode configurable
Date: Thu,  4 Jan 2024 18:32:03 +0200
Message-Id: <20240104163203.7381-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::17) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|AM0PR06MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b831cd-099d-49bd-2acd-08dc0d42b95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z53eydDK4tiNRlDoCRR8tMQDLyCiIQU9UU5oPeqVFzuuSqKdJi7rubkDp5HNIIP1PiDtNYSm1YUJt1imkVy90AmWZf/G6y+B7rOkz4HgdZrNctupODTrRMKnlNNlQM5j19lmTN19MrxqZ8elU83+J4HMiD8BQUFMfLuuplMZRWOL4QJemFouJjsbhGz49mfEeUC3ozL0UqcuTsRFHAa8qCtzq4CQPnOYP0pfpKgAp18p1H7zhKIqzVON9T202r3sARlnL7SYatrjNhdGtJOYnDMt9hJ1SxgVZEeQPUzDfpEqg0uJswxwP4XyAs/q02iVFF3T7cyzhSGu7GCc2/HXYUvJ93PzufIvoVm+qNDCGE4NPlwEdJtio1BrieZ/NvSuuO/ZhuvTYJZVsf3mcdVzvPt3JBv1KLSmRNt/cijeQpM2NBVcX+L62lf2GgjOMF8QQh7+is++u/B4mw3oxt9BmcuJePMcOCiXBOwrsEBTnxLgXRZ2gkjbApTO6fn7CF405rOaLWnz1+vfcM+l+DX2AwIGO8RX/QW5UgQAxmJqhIoo7BepanSqoIkWa6kawSScSB8ZpfulWkbmide5/3yHTBgjPYusDXI7I0AC3S9QsH2qLWRmP593lkDB9VCRDZ5b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(376002)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6666004)(9686003)(6512007)(38100700002)(478600001)(6486002)(41300700001)(2616005)(6916009)(107886003)(26005)(1076003)(52116002)(6506007)(66476007)(66556008)(66946007)(316002)(36756003)(8676002)(8936002)(86362001)(4326008)(83380400001)(38350700005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tpvbz/P4Jl7EGdbKQN+ItCu7grkvjYmb4wY6c62OXJl0oSBcJfjmwlFNFD69?=
 =?us-ascii?Q?bnJxnCh6tgIfkO8GnmMEDLqlvob6M66czjwpwZSudNcOpo0QtExwsX5Iv1zm?=
 =?us-ascii?Q?99RDVE0NubVsqWrRwcPUB/1CBojpGCKE1x61t4DVZ8GSdu5/kvElQXT4PxTA?=
 =?us-ascii?Q?mJtWraIjc2qHMXrrT7+0bnW2vo7idq6HdhRaVQ6iZMOXDgARE6CzvwsbcKMJ?=
 =?us-ascii?Q?VYM6Y+lC+37ybnwYs8mIGqdW1jb2CyxIKPw+eQNsLrUwCxjVff6iOdgocXEC?=
 =?us-ascii?Q?bHkyYqk29wWTWeTBKZH85DGkqQIvfih3IMEqvWHbkCSlHCXnse/lEGqYI3E7?=
 =?us-ascii?Q?isj7FHeOVzUCimILGnDlVIFlH9UIsA8VwrdeQNgP6iOU/NBQqPdtl17Z2cVj?=
 =?us-ascii?Q?btbbO/Xjp7nTjLr2rr+wHDX51iONC8xusCuKC1NbEhChp8DdgaHEe1I2UqMX?=
 =?us-ascii?Q?OamT4ivuc+iOrS9BoXHGWau+8NXqImZX/K9jfu9J1G7mkKcOftJW+FKTIRFw?=
 =?us-ascii?Q?QUK3LGJp0HR1QDmBlArqEcBkCEKtY3Cc2vDW3dtHbN9F5ekmHMGBk9NYqsjx?=
 =?us-ascii?Q?FeP5pSi2NyJBPrDQNMIQfQbecDdyppkbxOVA3AIvbPYmVq7KfK2lRUp51VU/?=
 =?us-ascii?Q?lfjQ0Qd6IdVasikVm5kanMm3XC72YjdY/ImTwSUAGsmzBEceHxi40SoxK5PQ?=
 =?us-ascii?Q?onSD7p37ffOls0lpSTEDRe/G/mGWfn88qxAV9K3MbeXyhh2WDhMbFmVOlZxI?=
 =?us-ascii?Q?LYFjhLNNK9S6B+UGhzR7oLuna44ww+rG83EGZBVR3aeGf/8VuNgmyskLlr/T?=
 =?us-ascii?Q?n+s0qI3EE9fJDSu8r2n9pG2+CjTGPGxU8Rsx48E07M4aILyWWvLxJ4Wv10FZ?=
 =?us-ascii?Q?Uriu3U/6IZBMAhfTVE+0yJ9zlzhx7k2dpEciEDL+sk7QwhdkF2udieH3kccR?=
 =?us-ascii?Q?hDJAFsbG60E4gFJFDEforelnxoks/yjx+bOLy4V3NKbm0UhBxJxdXf10PsRx?=
 =?us-ascii?Q?LNdxO619vEEAPVqlrFd+3EnYYdgOFoVL9l2VjOJ+i9YkUG3/HMhCf0fMflJq?=
 =?us-ascii?Q?0Ru0vKOiE0lIVF+JrkKOpa8dIjg3U3DV9BbIZPRYZRswEG6Ir4WZ3t719Dlt?=
 =?us-ascii?Q?lC4Tn29zkfD2JUhiDHWxnRZuxW6gWhmcm0j85HZRvc56POWG6sxN8MBT1RTA?=
 =?us-ascii?Q?A2pqDRDOQuvVSIoxeHcusLOPPVkXhlPjrtA6KaIVKNjK46WglxncoBkG+Xwe?=
 =?us-ascii?Q?CkfBeVNEXTN05+XFn1MhUh+Wl9s/9sPdrGxqZsK5If+RXGxJ4oZiIqzlX1p+?=
 =?us-ascii?Q?+riemRB0bD9ea1JmZdfQfuwTllewywUc8Tw47whVSZpiHy/N6yXYWj+zetVJ?=
 =?us-ascii?Q?sATpJvg/zc7GIZOhM6kMKMkau9sUNcF9tlss0NyH5vyxX9K3UYjjWPHvrKid?=
 =?us-ascii?Q?w9m3oVhDot6FXQGXUsLenCtN7CHiAZDeb3ISf98Qmg+ukg5NUyOhMSFxJywv?=
 =?us-ascii?Q?/+K7SyPq6tcaL+8f8pDg0/kBDmuS9zp05But+jESjRk6op9T2MfgJSSVVufB?=
 =?us-ascii?Q?gKS2xz8fr5XPYqJWnU/byMnOH/8psfmfR06BTjOL5nhKWn1g9lCYmIPg4HEJ?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b831cd-099d-49bd-2acd-08dc0d42b95d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:32:20.9787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUnmL8GR+u4qrhP1N7rZZP1tkM37y9sz1YZx6e9ktH0FGnE0NWz4VHuPaO5UE/UqdbLFyC6xaEzWK9YdOevXDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6497

From: Niko Mauno <niko.mauno@vaisala.com>

Make the default USB device authorization mode configurable at build
time. This is useful for systems that require a mode that is stricter
than the standard setting, as it avoids relying on the kernel command
line being properly set.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/usb/core/Kconfig | 15 +++++++++++++++
 drivers/usb/core/hcd.c   |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index 351ede4b5de2..10ad320cc2f3 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -116,3 +116,18 @@ config USB_AUTOSUSPEND_DELAY
 	  The default value Linux has always had is 2 seconds.  Change
 	  this value if you want a different delay and cannot modify
 	  the command line or module parameter.
+
+config USB_DEFAULT_AUTHORIZATION_MODE
+	int "Default authorization mode for USB devices"
+	range -1 2
+	default -1
+	depends on USB
+	help
+	  Select the default USB device authorization mode. Can be overridden
+	  with usbcore.authorized_default command line or module parameter.
+
+	  The available values have the following meanings:
+		-1 is authorized for all devices (leftover from wireless USB)
+		0 is unauthorized for all devices
+		1 is authorized for all devices
+		2 is authorized for internal devices
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 12b6dfeaf658..f39170c46be7 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -357,7 +357,7 @@ static const u8 ss_rh_config_descriptor[] = {
 #define USB_AUTHORIZE_ALL	1
 #define USB_AUTHORIZE_INTERNAL	2
 
-static int authorized_default = USB_AUTHORIZE_WIRED;
+static int authorized_default = CONFIG_USB_DEFAULT_AUTHORIZATION_MODE;
 module_param(authorized_default, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(authorized_default,
 		"Default USB device authorization: 0 is not authorized, 1 is "
-- 
2.39.2


