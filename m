Return-Path: <linux-kernel+bounces-13339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529998203BA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 06:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227CEB21EAE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292762567;
	Sat, 30 Dec 2023 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="pIH3J45a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8A23A5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BU5b6qh011291;
	Sat, 30 Dec 2023 05:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=9uKmLtWj5kDB1TkJHM
	Q7UhDwrDJFm4pQC0R+MI4CovM=; b=pIH3J45a9Pl3ODM1wxNLQOM58sisO6f43i
	meVmQ5V0BBZytMfUHa+sABAP+Ecyc1y08MCPa4dlmqEcPEXapuiLP1p/9cBbdscL
	LCo6VmAIKWeJoLMuPnHfhwP7kpN0L/fhgkRpOPo1bxZdMyNPkG6R+q1eivo5FrFF
	OqsBWpqK2DmLDx+LrFc/w4IxAqSfJrvOk7LG0pwH0dbHCFJ5vXBGje/JNDhQS/vx
	JridFtmnb62W97kKQrgRsot5yp9bAoz+ml+90qsFDsDnMY11Ng+acDbVZePD5YGx
	glryKJoL5s384fJHHXTVQXDPjSaiXJOIEg+Nb2QsLRuETUbOEDcQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vaa6603gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Dec 2023 05:39:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ7w66kiFvgtkl1eqq+fHJiMfWZcHf2FDHXoFWIEcxBlN/3VepIbjrRoH0aMBbBimR+B41HDDU19onjUQk3sBXdZucTwZ9dp9zjSlWfXu1cunijG2wSR8FYOHkEkPb5vW/48k3aIecoX2QP5iZKXI9NY8gPrTn7iWltgQ0nhHzuYOKjcgG+BJL5+RRxdvR2xOfZITmESuyZ0xlj2TG7B0fO0J7g1Gj/nE/27QIWKi96gEFlRpX2ZCAxWBP4mOQDQJE4UiH4y9xD4VU6AzehukTYnttdMyppW1NVuNvz1O8n96amP5tiBlr8mLTc8Fry4YiUYMC6XgWTY7/1rD+cY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uKmLtWj5kDB1TkJHMQ7UhDwrDJFm4pQC0R+MI4CovM=;
 b=htEYgU5uJb7rTjMSAiVeLPOAarYpBvpEcjYgVF286eq5hD3pT9FwJEetb7erKUjN5n19femb+xfO/G+92Ai79gEO3Ma3kC1L0Am210w6l0s/hdrKuF93NEEFNYVJielgCwbc/hbRjPV600IKtpUWG0XEPJ9AGXP2eqvl0U8cYfMGQr0LWEcmjBHq0jPcKTo7IZ11Aq754ZpYQP1bbBsu2WV1zgRtkqQjLkQHpbXA6ppJRSRSD1JDuvyHzU1nkyUE+nujvqK9TgjEeNUSdlcBnHJEKvYme7+UyZbycHoJGkoGPYjoFxON05kimpJRqtQJwybeLB7YI0cT8DekIDB1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Sat, 30 Dec
 2023 05:39:03 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6147:120e:d511:3ece]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6147:120e:d511:3ece%3]) with mapi id 15.20.7135.019; Sat, 30 Dec 2023
 05:39:02 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, peng.fan@nxp.com,
        treding@nvidia.com, yibin.gong@nxp.com, robh@kernel.org,
        ranjani.vaidyanathan@nxp.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: imx: scu: ensure wakeup procedure calls pm_system_wakeup()
Date: Sat, 30 Dec 2023 13:38:31 +0800
Message-Id: <20231230053831.67661-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA2PR11MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad09dbe-5a8e-465a-f039-08dc08f9a146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	T7VUqv4iVBOqizQKRqDFIgNA0N7geTXfUbl0yH075fuzP4jpL8CG340tVDnznR8QDmigPgLgqslR6jkSz0k+HreFOcGh8xMWbIl3yCqLK36pv3Fhk87cb1NxFjczTVzSj7DNz3bX/+DWwM9P8CJMzXTGAZLK1oyfD8cwsLOi/5hkKh1v05VK5ZAAxtd3pUrc5pDx71dtfcjDF1XyVi/INghHTaaJ9lGae3FWp4X3stULN4rUcspY0pIofhHrcKIL0XW6MLPSO1hW3BJiS7hntcH9QUE4mJF/ZeRIsPuAPlvNvlVoMovCBBpRATFPLgBy52Hw5d0RBobME2gT1KqTpQ4X8VWnY9rzYDz/ffR/1qoe4ozEIpzRb5mqOvdRJczknPYlp9PCOQx7qB40WrW0XDEjbjEWcHWjPbPTsxYbpsCuTNkIAqJftrzs9UMko2Mxpd+PWidduUONRtqeYwGVq+9CPz7hEdCJdghrmmy9Muh2lkmdADashqR2uNbpE8oBTv9RIs1OOPZXEfO7ap7Qq/s4yfRgs0a2w2YC20L/Z3d+AwJbuHsqcfME+8lLNiVj6KfSnT8weER7LMwIujudkTp3VKnvxeGQna8cgTARAIud3O25o1zY9qxwKTfecDDa1mIJMfhCRKGc00K/m/krfw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39840400004)(136003)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6512007)(52116002)(6506007)(921011)(478600001)(66556008)(86362001)(66476007)(6486002)(36756003)(6666004)(316002)(66946007)(26005)(1076003)(83380400001)(8936002)(4326008)(8676002)(44832011)(38350700005)(7416002)(5660300002)(2906002)(41300700001)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EENN6yyKxGsGrnp0NBpqtm2KuGppNsjsGlOW5uQxIRU3YVmVxnu1eaf3dQH/?=
 =?us-ascii?Q?cr32pIXtf1DDNFXYD1hg4zsIAN5KBOMFqLjUn9YkJF9IRldilM9tTBA1vdyQ?=
 =?us-ascii?Q?AKwHvYeRzHmiS87/WGJqfQkGvW66dFspm6mPm+HAkvAjvVq0ElcTuUOrV/go?=
 =?us-ascii?Q?En8kD+ipC8Hsi7tKIkIAaXQWNO8AfBHCp53XFiD+//OyGzpD8ZakXpAXp5JI?=
 =?us-ascii?Q?olpV7cdsrPKsR8VXvtR1MPnFfRBtbbNHQTsieI2XnWP+jlrtTBtopSVMpcQZ?=
 =?us-ascii?Q?uvQwUKLFTX+2bLrAGkYfBMhy8dfb0h3s8V7/vNIDdkNGMO9e6p6V7SsDCsSx?=
 =?us-ascii?Q?J2sO/PPEwiVgfMr+WJQM6NiSnDZEW4yx5Jx9646TNNk8YOBflAvSE/yLQrt1?=
 =?us-ascii?Q?dSqV0J+/x6kwmQFURzVOkeIpqNkwEAKoJmp3zcDfE7OzdoUFSOkVFvQbZTKK?=
 =?us-ascii?Q?xfdXkaa6D8luJl1H1zz5wIKCqrXStek/NON/xyVYmyf3xB2lrVc3zWmKxXGt?=
 =?us-ascii?Q?y+MnKMtSxmN9u59ZwJjGRb+ttS5Q+BhJVK8URrVhc0A8qgMM7NnShK25U3mf?=
 =?us-ascii?Q?eMEEkPfHeaC6AkHVUZ8DKS2nmmePnDdCIubvMlcG1I2ql8+bgY/2Fb872Rum?=
 =?us-ascii?Q?5ZkHpkWQUh+Eccc7vlheCwdy77qq8Ocp7dqvCup4m3KxaV5nj2XhBe+T6UFB?=
 =?us-ascii?Q?/I1sTlc0qgHrRv4Q1UAXV30Ce7gCHx4W/g+10TfeTPECzkvep+x3gYJd1UmH?=
 =?us-ascii?Q?0xKrzn8qPLBEC6rAUlalo1jM4DA6zOYh8K3YPzlr2aowlYzMq63ulqrkGZPk?=
 =?us-ascii?Q?HBvjgORtPS+UlYQbgR8RhUKSuKdL5l3+voaB045B9qjwGd3OrTPfb5m0Eu98?=
 =?us-ascii?Q?FEOfYIYPAWqY8i1inTFcPzVEojg7tHjM2OTSdUd272bhkbMuN4t4OhqdYwUU?=
 =?us-ascii?Q?L9wfhFjFpI6SJX4sGccAdPZ+CyOn4LMePg8Da1JZhYtoCevIt2v10q3cPyIs?=
 =?us-ascii?Q?1yskQhxvoOrwaiGh5XbvzQC6kXXdB8JNRiYEsOMnY/MoSvku+Jhq+LjFz9m0?=
 =?us-ascii?Q?L5hLAfqq6qjQqFXiq590jjwLvwdb/8ATiU/88vQLpOoxNrJcUIoWocrSt40T?=
 =?us-ascii?Q?bGZyuClSQs2GtarcQG6HifyW7AOVSpywXKmTpMEFtCx2gqrtvM+G5jJFcuo7?=
 =?us-ascii?Q?C6R6MHw3PM5vQby6F/RLz7u5Z9T4/qX+e1Dyd0BJh3noHxTZly445gnSWd6c?=
 =?us-ascii?Q?tME/kHX1r48t6Llb6bVxmwDnaoPMprlnvJc8ubKzS609FC1HL1kU10QkVArn?=
 =?us-ascii?Q?7xMr7Lu2dZDFHDEN6tlKLB4/RoimanHlbx9mh72OU8VGVjJIQnh1UQ+w0J5Q?=
 =?us-ascii?Q?WxGRSjl5F6ujeZ6wxi6N1b7ehso77ugZd9CYkQq874OPV5D/ijIAiGg1KlBa?=
 =?us-ascii?Q?94XTxc79DQ4ZbvqDwwuuFWEgTIS23jyBZuCUK5tBiu/c9P7GOT1/DbKP5ao6?=
 =?us-ascii?Q?VL9XvE8WalhLTiDH00hVuWcrNYS0Dtz1Zdnk2RQiK8tmNmZKzA9c+9JF6jE2?=
 =?us-ascii?Q?IggffK6TNSV6MxefVlICn04X3hyjhgd4CeHfHt1YVnHGDkDAnsspwd9O2B5S?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad09dbe-5a8e-465a-f039-08dc08f9a146
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 05:39:02.7619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2t36BJ1XFG3SMxQ5FWRkZeL2CHO5ZIReY3P4V4w9HVJyUKDPZetGaqc3yilITBY3jQ8E+r+mBft55d4OPtjVHF0DXeqXJEu1q39RE64kq1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4844
X-Proofpoint-GUID: G-O6v2zjy_hJC8u-t4QEspCEdPlpREui
X-Proofpoint-ORIG-GUID: G-O6v2zjy_hJC8u-t4QEspCEdPlpREui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 suspectscore=0 mlxlogscore=818
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312300045

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
 drivers/firmware/imx/imx-scu-irq.c |  4 +++-
 drivers/firmware/imx/imx-scu.c     | 20 ++++++++++++++++++++
 include/linux/firmware/imx/sci.h   |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

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
index 1dd4362ef9a3..b9f5c5eb4581 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -342,10 +342,30 @@ static int imx_scu_probe(struct platform_device *pdev)
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


