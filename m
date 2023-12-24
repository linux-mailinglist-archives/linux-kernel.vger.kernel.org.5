Return-Path: <linux-kernel+bounces-10737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CDE81DB17
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715AE1F216D4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D9DF58;
	Sun, 24 Dec 2023 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OiOc/23p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D1EED4;
	Sun, 24 Dec 2023 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoPflTfSURGHyFTUdjlpToZ4nVhCSleAxa9LyICZDot4vN5X5abSIWTfndc6c71Ip3SEoSsOisXHTwzxA+EIp0HPI1nr9aLxqDifsqNzKnYUAVXKcE+3zj5ZaZav6qGKraELOM3sz3p2zHesw0ov7zJ3vVJ0eFvf4kfHCxuWHcfeoK2xGV4/2n0EnaPboRmSxmz3DsSzo7aUOgjWzn2URVzWNP4xX6TrNuF/CR8fCtVeDpQ9n0Dqjw5ajrPoevSxQ1Nok7hUj5q3KoJeJJsAZHARSqJsTAQotfbQypP6YbvKJxmqCqrivmP0FII+TwsqkGn1p2rdkTLwIAw4V5uGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXpaAagGWQhxWjrKD7Fn5u0Z2e0L3PSMrRONa1XQftI=;
 b=FIvkjoGTec5XA4n3ME2mzhV2qMBAx8ks3lZF1MOSicBTdpfyWM58SFwCF/EUPYY2qn9TweAHwACLSu3KhrvDSPlPnZpc3cvbXUP99TWtLRyL4yAcjdddwLuPzJ4gxwF//6FVQ6jB1GjgJq/G4BWWF+GR/N/mLCJqxKK187G9LSfqOI3xdxZUuuP2J8VGMrAQuu4ekzI+I3S6t0XofurtMEreh0fL4H3qGEjXb50WBj9+YYPGYqYjtOeYYyzqaWiPXaUJbVaf/rDmj3bjOhJ4DQffActf8j6aLzGODT/uxkRxQFSNcsdUIY0uNtGMMFlrnDEGY9IkDiDwLDuHmVbfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXpaAagGWQhxWjrKD7Fn5u0Z2e0L3PSMrRONa1XQftI=;
 b=OiOc/23p1335SugnglauWSc08httD8TURRuYCjPqatkUwCAhpMgq+TFz2lflNCAtBhG+YF064u+8ZYUR+KlZgXriSkg+hCOoZ496t4N2Fp9El2LEf29RZQDNgMr7R/p9RsipDKEythSSZdYD7cy4yls+Fub+WsqtY9MCzKDNagk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 15:38:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 15:38:45 +0000
From: Frank Li <Frank.Li@nxp.com>
To: cugyly@163.com
Cc: Frank.Li@nxp.com,
	a-govindraju@ti.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	peter.chen@kernel.org,
	rogerq@kernel.org
Subject: [PATCH v2 4/4] Revert "usb: gadget: f_uvc: change endpoint allocation in uvc_function_bind()"
Date: Sun, 24 Dec 2023 10:38:16 -0500
Message-Id: <20231224153816.1664687-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224153816.1664687-1-Frank.Li@nxp.com>
References: <20231224153816.1664687-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:a03:80::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: f29f1699-46d7-4a6c-5f5e-08dc04966a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LlwfngmD7DMyOLGaZng41dNWX8he15EEXZX/N3YULuQD3janEH+PMrjCdDXzlZJt8FQlkj+n3Q0MLIP2UYT9h1//rOUpV6+hOUnrUR38r/574NYmNQ3ih+DdTwoqWjcJefGTzw1L0TYHSUXaHQcIldUgh8mO3LYyp9kT+y51rcrW08jxYVjySwDM/qeeGbplt08tOGEJsdYtOhCz07g7Em0soyIjipyBafHDOB3aHWAs20iRS1bByidGMj2Ro6DtSnwMgJ536G/3D0MYa27iQFEbiaMYikZu6j10aCM8SXbrdHmMlNbr2TAf4D29mWaCHewB5HZ2b6ddE+u+OtxkbLVIO/7+KimsuJwi4c3ZHWJqhb+GsnoLT6+zqtrYVMgIeatA+JRxL234+jzyvV24+hc7qssDqjm6JRyrROA2v21DirnAQ8dwnQNW2GjLJfG1aDPFz1ZPtS9S7GUpzepcE3yaqiYSg0k9vba0Lr7B1aAvSC/dfL3qtJLsMAoEn1yWZgXenclm2BNGl9bnuGGpUwnz5UEfy9hg8E7p2l3izpdWA+zNknu7DBHfWzl4RLhX4DbhEZF9R9a3jjE9rxfF5KNeMCcj8yWkCgkltPRp3E1heeXqZlVNLpcYBlldxVmoyptlz10xAu+hZnCq2Mvokg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39850400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66556008)(66476007)(66946007)(38100700002)(6916009)(316002)(2616005)(1076003)(26005)(4326008)(8936002)(8676002)(478600001)(6486002)(83380400001)(41300700001)(52116002)(2906002)(6506007)(6666004)(6512007)(36756003)(86362001)(38350700005)(5660300002)(1491003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2bZHOFYsc5VXbvKiyPUaXlV2CeGfgGU+iU4abCTlqYyehKg9yDdJy0v7s92A?=
 =?us-ascii?Q?HvhjIuzeutAfKz4m5MtzgMIbjSogBB0HkG5KBQXdnMjEjZqp7IJMchxiSqVB?=
 =?us-ascii?Q?dnH4vZQ1/uwZoFN6bZ4DwWS5U9C2VuVb4bzX2vcFEe8NVoYfTVB0D040hqki?=
 =?us-ascii?Q?xYx5+U0XTmiSitwJH22Ru7lhW0IITWJuNPAfHnDbitK1nUp2h2d4OMtdhNSv?=
 =?us-ascii?Q?7UQQr0LNq38oaT1OsL8aGu1XbYZLIkC0KInBu7ZU9mcwYgnwZ+QTtWUVL503?=
 =?us-ascii?Q?slFlIi307QmE2Ie8KfvwRrUJuXgSuQ4sgasS6IUhsNaWDSZ0zZxyGy3HUlZI?=
 =?us-ascii?Q?zGWx6VXsNITDq9R4wrXHUrBq/QeS2fb2Lk+Ppj0ecoYGEPnxEIT+aD+AGzur?=
 =?us-ascii?Q?rPiaUKOh3x1ksxlgmavHpWghcFoZiy+Xb+n7TDZWGcRznPHKQbuxq6/8z6th?=
 =?us-ascii?Q?Gjf4yQ5VeTaNElra4mKSepv0BaJk0YUww9ovM1gIaRaGH5O0PjuQJirtHtKK?=
 =?us-ascii?Q?kMNOPh6G0vZKoV4OGcNGuVOPx/o5DaadBQdhwr4LuEkfKLvrmPenLdpHvhTS?=
 =?us-ascii?Q?OKyTOr45jkyqRE7yyXgI0UzvdMY2wDoNBzP0ne2BuDYoieyJ/Z3M30yi7icx?=
 =?us-ascii?Q?DHatVave8ZhwuOLCZ7PJPWSmytbx5zbu5SVUGJ/CgZcvc+LiU/q3LZni5bd0?=
 =?us-ascii?Q?XZP/SfL/d9ukdVb2c4Y1NXLxBj+UiNo9Q6V+jrnM/HCzvMBn/hAk7q9MKjXH?=
 =?us-ascii?Q?esb7lRTKzp2FPmz55hy98maRZLZSle3rgqhz0LXYz+3PqzULg8VBZUmngJyU?=
 =?us-ascii?Q?u8FW1AY1LBglJ4wA0q/5qku8IQ5mh6TzZ2z249jkUBly89DFNIWcEf4ITrG4?=
 =?us-ascii?Q?aRT/r7A7Zst8P6m3mO+hsy4euWozQNh2pwDcB4LbS9fK5gbcFabXSH/xiew5?=
 =?us-ascii?Q?PeUrY3VIbNTm29uB7iEK9dOrlg+G9YkBjDLJbXWNzoASHdDFAWQhSYE1CfWz?=
 =?us-ascii?Q?wZeNtqvrHrXVFaBpSuVKd502JV2t+Dof22OrziDPbNdyQh4EBfsEp3Mlb5Kg?=
 =?us-ascii?Q?8ufvvvQVUYe1n0DfUgMSEq2GJSmzWn8BccxisOG2Lf+oLhJOme4w/lsF3oT5?=
 =?us-ascii?Q?dMo8PiCgu2F9ecU45yZKwaCpaXMrDtW2242eLNjxMzXzZrBXXwrXimOQpPDx?=
 =?us-ascii?Q?cz+9WuhGRodn36Zby94umLCCWNbQ1stQ4RRVVq3zLuUhWZXe+9U9u9E2wqIe?=
 =?us-ascii?Q?e4p1zm+WR9B4qTYNsDxFvwfPomx02xppn+5LjyAsdEB/3wpRLfjMGuJtptrp?=
 =?us-ascii?Q?qy7MBVTLZaSur7vCJ/d8EP9hbjzeQQ2tla6SlzGBzIFD7Nhvg4va/oQVBeXa?=
 =?us-ascii?Q?IaV+qq5lJ/W9FAcZNX+fd+y2SU3o3S+cnjsZPvLX2880SNdRh48c6WiyUe/r?=
 =?us-ascii?Q?gm3KnxwHmR96MOXio1B6wYL6z7iIwixNU+odpTAwOjZXYNwffr7kLjlYGIal?=
 =?us-ascii?Q?sZ98Pyq8xz6Dx/mZE6w4by1hTnvUHDIppGRfs9TJLTTaZ826iMfPqn21v6WU?=
 =?us-ascii?Q?W1OqsK4bugMTXk5VQZc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29f1699-46d7-4a6c-5f5e-08dc04966a1d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 15:38:45.3239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeZZzOsWEhLg27En6EUwRFvH3Z1iByx4hetxlfEMpllhXWu1sDLiy1eEJWBAmUPrxBU/6YOQ6eXvlqeOAwXbJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

This reverts commit 3c5b006f3ee800b4bd9ed37b3a8f271b8560126e.

gadget_is_{super|dual}speed() API check UDC controller capitblity. It
should pass down highest speed endpoint descriptor to UDC controller. So
UDC controller driver can reserve enough resource at check_config(),
especially mult and maxburst. So UDC driver (such as cdns3) can know need
at least (mult + 1) * (maxburst + 1) * wMaxPacketSize internal memory for
this uvc functions.

Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/gadget/function/f_uvc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index faa398109431f..3d5c03e1361e4 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -719,13 +719,29 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 	uvc->enable_interrupt_ep = opts->enable_interrupt_ep;
 
-	ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
+	/*
+	 * gadget_is_{super|dual}speed() API check UDC controller capitblity. It should pass down
+	 * highest speed endpoint descriptor to UDC controller. So UDC controller driver can reserve
+	 * enough resource at check_config(), especially mult and maxburst. So UDC driver (such as
+	 * cdns3) can know need at least (mult + 1) * (maxburst + 1) * wMaxPacketSize internal
+	 * memory for this uvc functions. This is the only straightforward method to resolve the UDC
+	 * resource allocation issue in the current gadget framework.
+	 */
+	if (gadget_is_superspeed(c->cdev->gadget))
+		ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_ss_streaming_ep,
+					  &uvc_ss_streaming_comp);
+	else if (gadget_is_dualspeed(cdev->gadget))
+		ep = usb_ep_autoconfig(cdev->gadget, &uvc_hs_streaming_ep);
+	else
+		ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
+
 	if (!ep) {
 		uvcg_info(f, "Unable to allocate streaming EP\n");
 		goto error;
 	}
 	uvc->video.ep = ep;
 
+	uvc_fs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 
-- 
2.34.1


