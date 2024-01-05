Return-Path: <linux-kernel+bounces-17468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E808824DA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696381C21A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACCC5243;
	Fri,  5 Jan 2024 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="bCS6/nIF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38F5220
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 04:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4054LSpu018967;
	Fri, 5 Jan 2024 04:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=wLsm9z9Yu/g4LY0k8R
	x3kuYCT+4SiQADpfbKLbcwt04=; b=bCS6/nIFlvSQBtwOkC37aQCvWw5JChXI//
	580Ljc5ALML9FBAjO/NiwE2AyAspeMLiYndG2C98sjoux4lh0XhaEJIwsJiD8+nX
	Tf/Il/otfaTemabGctHGVkvRrjE4LYgdMNB5r9h9y8Mbpxa7oiA1g4sg93+tX7DX
	oC0nUgJz7/FVMz63C7ue7X0ix8CxkJC8ha3F0t5iHqfElvdkLeF/ciJC+J8Ke3YJ
	PGfXFmb1jFfgiN9OdTrn74XUJxHhqR4gR2na98V6cM64fX0uia+Tl8tpDQ6sH2A/
	VygBpmB2Iac+S45X/LnvDr46ZArYNbVD/Hn3rK9gFdvShxYiwdUg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ve1gu8fyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 04:28:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h51oZKdRAOkoWvAuWgsGMO0GMaDSq2RFqgVEJITnIJhPZ00z6b8fIv6bSZM1FNpv68gdwQe0wfXLcAk7wbyibAibemsSL6QDtGerRcLexBNPX7ZATXtesuwdLc/7SatnoQT2FRXWPWuxvP7XWeLP184+8/poTMb4sph13SWYjWjxTDVwMZPK7MaX5pvRogem88MsdpKgRgkP/mS3aSGZ1cshxQjFtv9ganryD2w/e4cMuqgL0n93BEEBuMej/5zG4qATTatsXL0I+Vlus3vIC+Lbo5sqsb9JbHeh9Sko8ClgHuAqk7F1vOGPR9gSRHP1VQfMiQq6jPdHAw79hQTLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLsm9z9Yu/g4LY0k8Rx3kuYCT+4SiQADpfbKLbcwt04=;
 b=oSHppSqHHQBWRsreFXP59tDnOna7XhliNeXvDbTW/TnaaguFMUscpwWKZjF7v4QAuSzq8xSFDXNgEq2E9alLAH5GHZCJw9SLpTGhIzU7uumHsMu+KS/PKrHMS42W4VgvqaFkvD4geO023xtegUebuG3tjeOEepf3E7WH8UHo1FP/VSm/RmPhO5p3oiYNwqc57C4KqpxwDRf8hWoTJgFfXz6h3HAUytCe1TbIBSfMEVzR1mjVFKDtfCEgoimhcshNbkBPBG7bwOrToHih5nR6PCXwMemFHc8wO3RU0F6GhFyVreZc3Jl7brw23WEw3En/7ELwhRUGTBSIPig2mQMMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB5959.namprd11.prod.outlook.com (2603:10b6:510:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 04:28:49 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6147:120e:d511:3ece]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6147:120e:d511:3ece%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 04:28:49 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, peng.fan@nxp.com,
        aisheng.dong@nxp.com, arnd@arndb.de, alexander.stein@ew.tq-group.com,
        robh@kernel.org, xiaolei.wang@windriver.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] firmware: imx: scu: ensure wakeup procedure calls pm_system_wakeup()
Date: Fri,  5 Jan 2024 12:28:28 +0800
Message-Id: <20240105042828.3614576-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH7PR11MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: b2aabc94-61c1-45d0-c11c-08dc0da6d04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eG7z6GSc29HGOjltwCYT9vjpwHigze0tAWPDzM6sozvuH0bEJ6eMTj+AFyqiPdRf2d53nBquC2c/Dz8pWFdyeqNVxY1lEshe+IiuSiy5GVGWJv++4hU7eob49pWCsA3urbQgWxEJEfzHCxJGlrFLzRJDPHsVkNaNwnZLwl/fdrKAQqwUiLIfvL6teqU0zE16QuCKqVE4kHD8igurHnFYii5lh32+d1whbOt43EmM02gn72w5gywqa1oOf4bzHafrlfcA7PoBTycZPZtDGvpiEza9XZtUgMj0MntpSYYnUauXM9JZy+MQnP0oQh7zbyQdyTxkBDlVHkgaO3eaS8xh/Nu6eEx9j+DQNuhJM3jn7H5bZBasnj0xAInmjdiH8GRbgJ684Nf+JBOfQHWm4lWr5gtoGu3xLGHSvPR8RWICbWhg/Mib1z9VgBMz9FBlFN21qxrY1tew7byX0D+wxuIDlixqeDq8p1l3PkJR5R7ZQoIN7U4/25Wy95odSkaoK4E0hWfoN8kMNeIsq3oo1WkcssWBc/G0KAfu/2QQ0lPI9qj+djzGmBnSd3T9DMtnO/Bj+n4x1tJt5WLj22AzAA3ThOuaechsDVANTXwYEgqz3HFTf0JgC4WxZSPLLMOxV0PGWR/RaL6PH10Qod8IJbG6WIjl658fefuKCBkdS7D3HlrWpsf2EuIkSQPje6Jk/vWx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39850400004)(346002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(52116002)(36756003)(86362001)(921011)(38350700005)(6506007)(6486002)(478600001)(6666004)(6512007)(66556008)(66946007)(66476007)(26005)(1076003)(44832011)(2616005)(7416002)(2906002)(5660300002)(8676002)(316002)(8936002)(4326008)(38100700002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Dlr6TIcdQcQMGTwjpz5Cs9kFUd8VOwUemctJKhSRM33ykXZ3tmQAdrD3oyV8?=
 =?us-ascii?Q?jf5h0XGHObE/RfTqFE+a0YZ1MAtAbwvL+qO7Vz/wab+lO+OcSSwmqq10oVuw?=
 =?us-ascii?Q?HoLAz1TZ8k4i6qNAoMrm6WiT0l5TgIPW25kHrWSnfeDHpUjWXQZVt4p1waNP?=
 =?us-ascii?Q?76P4HzDYujAWuW4xxoYdRE/d687XR4DH0a9+Z43EE7FbS5Eb+11vyD16JrMn?=
 =?us-ascii?Q?75yU2Wl5k5DbiBt4brovMRpH9yH38a5VkZA5jW2TKpt6ALGlot0mcFqIxYuF?=
 =?us-ascii?Q?u0P/zbxMTKmKcZulu4B50GAsLh0A1UVZY6IVSnUcseDvu89fqIgO2s7yfQrD?=
 =?us-ascii?Q?whluof0CzohaXJbdP+aliWnIXaK9vxsrZrH1cRnVvoL2tKybxzS2xVidAosk?=
 =?us-ascii?Q?b+VMu9vSm2KZFpVo+joGONw6/tnFY+YotOqTBSiqGx8ewOPOPR2CH/fsyA6r?=
 =?us-ascii?Q?J4ow6px0bLBAMqZeB6ulEaGVevuXoUFH83i6UFmfE4/5aFNFd4L+xActP6BQ?=
 =?us-ascii?Q?YXSISLWqqD5GLTGZksbamYnKvPnMODqlFg0y6Ps3sY5p2EEnYdBlTSQS5cjF?=
 =?us-ascii?Q?a1Y5bzPa+aARScl7LHdgUAhMwkGnINAuzbg2ocfvniuhXkOadx9QLaMa+7c+?=
 =?us-ascii?Q?6a1iaYC0ElJBI8QAmunHXSUxh5Wyr7t8og67pm2PyvbqM0liRqFJrpzDDppg?=
 =?us-ascii?Q?n6dpHtRoJ4J4m8nwt6nebeRACA+R6Nh7vCM0+QgmNVe4MN2mczNFn4xDF5ni?=
 =?us-ascii?Q?0HJi/3WE+bz99q1VWKLZIZJZn5342KsHYLlGBAgrHNi7lO9avx7fTgUMQilS?=
 =?us-ascii?Q?v/p9TiE6pBtE3Znh8Tj0NNjUNiU6GcrSRiEwDMWUq9FHV3uwb5nRdGIImJRu?=
 =?us-ascii?Q?QdsmQ+Pufq68c+z2eNMMizZSA+lwKnz7ek2whQz41EEEzMVRkUtCkXSqZcP9?=
 =?us-ascii?Q?t1L7x6Ctz/JjwmENX5qwoV+5DLsQlwMfJIgn4QGul5ehdU9bY3AhgBlt+sr7?=
 =?us-ascii?Q?anG6o1OJZ5kIqsQFWLIos5jCltMv4dtC811JOlX1hyLTkR9ng3J6SvwTuPMt?=
 =?us-ascii?Q?5xJMVPHbr7GT4Xh6mr6uFmq17cT/QalN4sH2Oto3lqhHWr7N9T0/57cYkJwd?=
 =?us-ascii?Q?yRXvkt4eoAcnIa2duiOZihANoDKAT6y6SJmVgtEePuIAVnIxUn3UUir/jl6v?=
 =?us-ascii?Q?48XAesFgv9ZyFgOL6JbJZokPNMVgc9fgS7tH+VzetIvJ1MOnNPb/ezHS/sw+?=
 =?us-ascii?Q?ayhbKIe25GDW3s5Hp/FPAIcCPE+EC8/yRNcO/oUJq6kdcuH1IUzMD5I7lJRQ?=
 =?us-ascii?Q?cK1qE28UA2/nZojUHcyKpmhV/RN1W29o60nO59mOkChdrpH3hzYvSNNBKTD3?=
 =?us-ascii?Q?pXZdO15O1Sn6wQgJoQzNO1FWLikDOIrW/+7KkgOB93qFXyrDq8bOrv0Lg+PZ?=
 =?us-ascii?Q?UQsFk2ZLv7DAcLtfYwSttehgnOZKbDn4TL1n5juzHX9l6msgdkJPU3rsIkbH?=
 =?us-ascii?Q?c5elxG3UXh3dBE/5tD2HDb5wpJIch1HV3aS9ZFE8nRoVGUthTJW9jGqBAtz3?=
 =?us-ascii?Q?M033Hvs4OBMVJJfyuqB6GOEU9XZiNXmHz6sT0gx8NSW58/14nTGxa1yuP8Fd?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aabc94-61c1-45d0-c11c-08dc0da6d04e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 04:28:49.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tm9cXhL0Nv5T0NLuOQsX8F5lJxsDqOpBXU2wj+M4JkVNiQvUJNyuOhbQ4hpXoHOFsD26CYp3Qhd18cz7f50JW4KM9OEfuK23qp/sHax4WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5959
X-Proofpoint-GUID: 5VA8JOGs3ixp5g_ilblg4momI_n7SWV3
X-Proofpoint-ORIG-GUID: 5VA8JOGs3ixp5g_ilblg4momI_n7SWV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=857 impostorscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401050035

There will still be mu irq in the suspend stage, for
example, in imx8. When the system enters the suspend
state, the GPIO enters the pad wakeup state. Calling
pm_system_wakeup() at this time will cause the system
suspend to terminate, so when it is set to wakeup, call
pm_system_wakeup(), through rtcwake -s 10 -v -m freeze
verification.

mxc_gpio_noirq_suspend
     mxc_gpio_set_pad_wakeup
         mbox_send_message
              imx_mu_isr
                 imx_mu_generic_rxdb

Fixes: 0caf847975b2 ("firmware: imx: make sure MU irq can wake up system from suspend mode")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---

Changes in v2:
- Fix warning: 'imx_scu_pm_ops' defined but not used [-Wunused-const-variable=] and etested it

 drivers/firmware/imx/imx-scu-irq.c |  4 +++-
 drivers/firmware/imx/imx-scu.c     | 21 +++++++++++++++++++++
 include/linux/firmware/imx/sci.h   |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 6125cccc9ba7..099a1f50d995 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -20,6 +20,7 @@
 #define IMX_SC_IRQ_NUM_GROUP	9
 
 static u32 mu_resource_id;
+int scu_suspend;
 
 struct imx_sc_msg_irq_get_status {
 	struct imx_sc_rpc_msg hdr;
@@ -109,7 +110,8 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
 			scu_irq_wakeup[i].wakeup_src = irq_status;
 		}
 
-		pm_system_wakeup();
+		if (scu_suspend)
+			pm_system_wakeup();
 		imx_scu_irq_notifier_call_chain(irq_status, &i);
 	}
 }
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 1dd4362ef9a3..aae430b70fd5 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -342,15 +342,36 @@ static int imx_scu_probe(struct platform_device *pdev)
 	return devm_of_platform_populate(dev);
 }
 
+
+
 static const struct of_device_id imx_scu_match[] = {
 	{ .compatible = "fsl,imx-scu", },
 	{ /* Sentinel */ }
 };
+static int __maybe_unused imx_scu_suspend_noirq(struct device *dev)
+{
+	scu_suspend = true;
+
+	return 0;
+}
+
+static int __maybe_unused imx_scu_resume_noirq(struct device *dev)
+{
+	scu_suspend = false;
+
+	return 0;
+};
+
+static const struct dev_pm_ops imx_scu_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_scu_suspend_noirq,
+				      imx_scu_resume_noirq)
+};
 
 static struct platform_driver imx_scu_driver = {
 	.driver = {
 		.name = "imx-scu",
 		.of_match_table = imx_scu_match,
+		.pm = &imx_scu_pm_ops,
 	},
 	.probe = imx_scu_probe,
 };
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index df17196df5ff..244df9c7629d 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -17,6 +17,7 @@
 #include <linux/firmware/imx/svc/rm.h>
 
 #if IS_ENABLED(CONFIG_IMX_SCU)
+extern int scu_suspend;
 int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
-- 
2.25.1


