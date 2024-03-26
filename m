Return-Path: <linux-kernel+bounces-118327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA36288B82D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB712E1965
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62311292E1;
	Tue, 26 Mar 2024 03:14:02 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39B182DB;
	Tue, 26 Mar 2024 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422842; cv=fail; b=GMFrfFmu7gMVGQub7VpZtKkW0W2GWSZxG3ZHOn3jURXGftOUxN78i7+QHA+4sxw16znpHQt3At6xzVJBARH4/azVtgSUqMf+NceDpn682R9af+VJD+H1xHtcXhpQmjjbT81lbU5CvciwXJcm6cyXA2wSFZJ9jWGHFnG+nNRZ3qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422842; c=relaxed/simple;
	bh=rmPrkRnZQU4cPehoMlU3iSS/GMlUsG9wSlfkDAYfwUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zcq78T0hbhz92K/IcnfJQAh7K0UcRPAGcIuHGHtryV/7ldhv2oTclExxwtVaLEvb5dJzoD/J29E0a67g19MkaWfyrbF1GDqq5dXqYSze16tZ3qeNZ4iFhyzx+hPldnIpONZRQgb9zUb4cWmRX9czStrO1Gc6wb2n3Cv6U2jM0O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCP+RNxdwNib1O4n6Cuu3l6pFIc67heppM2HCy3iSlN8cErZ3JF/JfXmDH7X+wisnGMyZXYiPTjksZmRG7ntoVUtWsAJ6GsOcAMAvgkUK7zq+/9NwjdQS9i8X36YoavwZlpItoUmFhc6Fg8I3TLufrBxwATwhZkbyKp2oIYVsrcZQjyakuBQqRhD2I/wGXE0kqqOdlBIE/9sS0Sk875drxhUU02QiY6C5kkdnJsXgpFemmLPkAkyWgV9HfXUI+ZpEIw/K8Y5bEUpSLbi5Hw6smggzMTtRQvpx2mMa1tFEEwfcqKw25mM9rnC4BZhlIBn2orx4mJtZ8E2aUWvuVlE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEYC96yQLaKLltjyoSrqhkgRoxEqYfjJs/+DA6nszK8=;
 b=ARXZ83fHYMixmbwSq0rKZivmvHYcga8bTyxG+I0kd8xPb1zN9P4yzRuf8ob5eJT7gW3FCqCcEP6yjaOwmXcmAgiSIgPwp/uonu79mmyCSuWMEr9owzy3WUx646QZ+EZwKccsIDo2zpLHhZ6dxhiTqhDsn4wVA/OGnJCdHKoOTHV7T7miP8snwwIz/U5F1AcziQ0KweQg2dfzsIK+uMUwPJah+H1AyssvehHHHSG9GC8aYJlrZhIhP3SLFylABJf8aPnRVATBq5W5tMaH321l8K60rlNPpcn20WfPW3LI9vHt531OG4AGSeBCqI4DAckaL2XaHsFC6cL4fYhM2fwdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0622.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Tue, 26 Mar
 2024 03:12:51 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Tue, 26 Mar 2024 03:12:51 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jayshri Pawar <jpawar@cadence.com>,
	Jai Luthra <j-luthra@ti.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v1 4/4] staging: media: starfive: Add suspend and resume support
Date: Mon, 25 Mar 2024 20:12:37 -0700
Message-Id: <20240326031237.25331-5-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326031237.25331-1-changhuang.liang@starfivetech.com>
References: <20240326031237.25331-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::15) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0622:EE_
X-MS-Office365-Filtering-Correlation-Id: e548d90d-00da-464f-3a72-08dc4d429f03
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UaFx7r07zx+adb1pftUAAISZJY5JMtYmvwj4Piy1CmREGt41mM6lg1AdfGgCbsY9ua8igwdViHJUEI9LbuNSow6MWRIjTghRujdteQt/70UZasXJXBBEc/5cB+F2DryBABa1MolxlHFspcnzt32ckxUADb7q9qf2rYeHDvE4BC7tNJatwKl161GRwJ9ts/jDB4V7W3Hsvjxe811EQwORL5yYwwnA53VBI6HbbfR1SzyqTL9BeelfoAVPaXWjuXkSTBpEcRarU1D2Vg+sHz/0EeHuAVotgep7AfkDXv1g8caQGLd861+Pu5Gw2CJjjP0z2T10UVv/xE9J0tLN2lmZy/hnkGLuwCAVGDT3ZxX2PBs3pmeWPgqaZ28bjJ6vQepehITXDzAIzVaEaDBv+NuyZ3ouIQelFqqVMRvLv3tbFzSqXQ8xPDOShO8EUSvxNrp36FmufqyDXJ5MYI0twbhmWizqKFHdfFUPjQd/JvcQZWgjg/EoUoejFsNfBDlhHe0t7g1p2N/aKjy1bFJXXpf+rJ6vENPZzOJ+SO+DDTFnSjGV0ncYoTsHDCr15rdYyvG+CGOrh8V5mqfnnTzzu0rkh2USnWnALA49HzucH4RHvujkTG94D7Gt7Y3AFkY1hpPC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(41320700004)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U1lW6tmYTdQlbc530kfM0vQrUY3MYa8R//4joLxRcb2t21WFsNQMYIHi2vyE?=
 =?us-ascii?Q?qmFWulWmA35vjxK/rWqU+8xA5w3MTL84o7h9XggcQtSUrMwXJuDr7dkq7HoL?=
 =?us-ascii?Q?zTkCkpjV/YoDXS6J47JoBBjbvu1vVC5wF3bdyQwzEC1omJQrWhANkguriivd?=
 =?us-ascii?Q?+6DqDJLwXqQ4WMjbRZArRKTqBO9N7kmDTtaOszkUpePGzQ7t0NTdZjhfWi2D?=
 =?us-ascii?Q?15q37h0S4soGYKu6w99qtX0OuH96nE4MGwCrbmGyrNW86FuhjGd8oH7RPn8L?=
 =?us-ascii?Q?2Nz00MGaUNoqVaDWQSUbF+3G+bNN/1a3I/E7eFsLUJJiZ3UMalS3g6abMLRw?=
 =?us-ascii?Q?pAElabraPsZLVE5kJOskcx5fO3C06ibXFTG323Q/C5XdlaC07uFfH73bLVt9?=
 =?us-ascii?Q?hGT90ECPm57gsD5eHEWHVCb9zJaybGbY3RF40rpUaOl9DdiPCGnGiExyHUhx?=
 =?us-ascii?Q?TihITZEi/KU49vkrD+gxUp7J5mwlCQScGjgJXXo2lzISvvHYWZ+8MBjXtey4?=
 =?us-ascii?Q?wCGOhEvK5iHRakvZrk/jkACwPp1bDFAnWKfR3lS56aB5gSn9Fwi0oBVwJapJ?=
 =?us-ascii?Q?3DX6qwNDkwDIE2IZ0i8ViUhuE5Kk+CYCkycgP9HjhGZ0I3UXCorS+gnjdgRK?=
 =?us-ascii?Q?3FGfQhrdpkKleD9Iq3R+CcJak9gsGFJVeP+k8vK3zxJEdqVbdTZ2ecPATU2q?=
 =?us-ascii?Q?DTyu23XQGdkxrqBfEIq1WbP+XNI4IPNX4n8x1K6j46JlIPf40KWJfrNLlphg?=
 =?us-ascii?Q?BQ/nobJIGkuXPazAzUD/Qon8Rmhd6ID24LfrVfTyshA4mGQTWCgoWjOJU3vn?=
 =?us-ascii?Q?pmxO57Hxj2dXLxIDiqrv6SL7D4UoZ3V4Ej6IicYFOsQwMCnCFCMjtI6A5Dr+?=
 =?us-ascii?Q?GfMbSIvFUq0Bxn7bvsB9V/yGZeUwPJGHYItwo29xfUOSepEKipOOxkhmSS/w?=
 =?us-ascii?Q?ahT/fJqzFC595T3aSJzJhMaJBNR7V45KJHEtjGfQtBUOOefsK/dgP1m8caQR?=
 =?us-ascii?Q?6983wC3c4I10aE3AdvatHAQd2LGtBbqCsBP4evoh24cO573OHS5R7xqhEA54?=
 =?us-ascii?Q?mDVUT9B79i0oINDNCra1T4sDmeSzzAHJzKOTX3dULXrafkE5ccJgyM4Ugfrv?=
 =?us-ascii?Q?ZtEei2XH3JA2BKSibOLjP6EvbWFmg22UsP2Up7L1ZCoyvmB8HDOJqtr5US2D?=
 =?us-ascii?Q?Bxcnz3vGqf/Cp2lF5stMGTnSuiTGkqxRZATUaPm5stpTT6EP/q/iuVbyzzdr?=
 =?us-ascii?Q?WOaVy0J+Jufzup87rx0y3HpGDzWts2QBxWJBLMikXcqSR2Sx4YAFGc4RnNYu?=
 =?us-ascii?Q?bwXC5+0KuhjTH8kQ5U88PSlnwOIxkZ9hsUD/bTjw/g+sxGcyq9exZcwaenxz?=
 =?us-ascii?Q?IhtxE54Jf0or3zHGLN7zGMfcp84lFpypLBp+gEcrJz0zAkXIPRAetcATW0jj?=
 =?us-ascii?Q?vhzYafqBYj7WwNDL+HsLEgYUhKZX1SucJ4PINtnZfXM8CiMwNm8+AwNlbbAP?=
 =?us-ascii?Q?LOXFLXhce48kngOY3P7zLhjd/9XjYDyVFTvHDeapNtH9PSEVRuQJ2LtbacFI?=
 =?us-ascii?Q?0rX7ERkKKhfwFiAtfaW3U0HQvINLoTzjjiEthGHMXAEW9d3ilaOEGAwI4bvu?=
 =?us-ascii?Q?zF8dgoYxiszK4ui5u+xt76s=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e548d90d-00da-464f-3a72-08dc4d429f03
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:12:51.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMKipaU6YS4FYXGK/8bPaI1rbWaC18uC6XWiArjYPplLSIWqohA62xt15Ak6fyNBssVrrfDm9eU4JYSSr5lYnljqrx9kvd+6ERVAVC7oMq3hsY2AMliPYfcgiLCYs4pu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0622

This patch implements suspend and resume operation for StarFive Camera
Subsystem. It supports hibernation during streaming and resume streaming
when the system wake-up stage.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-camss.c  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index a587f860101a..9abd8ee405e2 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -412,10 +412,59 @@ static int __maybe_unused stfcamss_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused stfcamss_suspend(struct device *dev)
+{
+	struct stfcamss *stfcamss = dev_get_drvdata(dev);
+	struct stfcamss_video *video;
+	unsigned int i;
+
+	for (i = 0; i < STF_CAPTURE_NUM; ++i) {
+		video = &stfcamss->captures[i].video;
+		if (video->vb2_q.streaming) {
+			video->ops->stop_streaming(video);
+			video->ops->flush_buffers(video, VB2_BUF_STATE_ERROR);
+		}
+	}
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int __maybe_unused stfcamss_resume(struct device *dev)
+{
+	struct stfcamss *stfcamss = dev_get_drvdata(dev);
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+	struct v4l2_subdev_state *sd_state;
+	struct stfcamss_video *video;
+	unsigned int i;
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to resume\n");
+		return ret;
+	}
+
+	sd_state = v4l2_subdev_lock_and_get_active_state(&isp_dev->subdev);
+
+	if (isp_dev->subdev.enabled_streams)
+		stf_isp_stream_on(isp_dev, sd_state);
+
+	v4l2_subdev_unlock_state(sd_state);
+
+	for (i = 0; i < STF_CAPTURE_NUM; ++i) {
+		video = &stfcamss->captures[i].video;
+		if (video->vb2_q.streaming)
+			video->ops->start_streaming(video);
+	}
+
+	return 0;
+}
+
 static const struct dev_pm_ops stfcamss_pm_ops = {
 	SET_RUNTIME_PM_OPS(stfcamss_runtime_suspend,
 			   stfcamss_runtime_resume,
 			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(stfcamss_suspend, stfcamss_resume)
 };
 
 static struct platform_driver stfcamss_driver = {
-- 
2.25.1


