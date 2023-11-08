Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AB97E5BAB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjKHQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHQqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:46:02 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DB01FEA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:46:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InXG2wojYqLyrQrPGF67T5baa38fVJpIyz3cHNPi5OC0yf06YG8qMjzDtfnpkLAH2T0HcH0s3tS8pPGG7SgSZeN2QUjcctuJF0fFRpaAMHgT+MGUl10veagNpHYq4t1qKgif9DqV/MBm5UWX9gfYWM6m7WSp+cdk2lawJMzPfaF15MH6DgVT3XcY1krtuivRkzJSEbdfwYQ1YWBGce2MGj0c1jZNGrR1WP7R3SOmxWb1SvKex9EBp4J9hbIvhvJlOtkCHJ7WCZEnmz7lQ3kJmobCBLl/ektSjKHxEixMWVZkJW0hmGOvdJCycIHBhR/G/3saPwZaMg4WI/SYiouLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MawegcjF4UNZnwLD38e1y8oaAgZATjEYyM+2Pd+0dg=;
 b=GXQpuzCpscmHOLgTuafQF5GDm7S1gbuizL5ondP26+06CrxbxA+Wy1Y3estJaOKiNUJD1xycpX3DLp53Ee2O/+u5HlIVRyfynDPru3O1fdUgcXqqOkaZapOGL5bsyRqMikhUZ7W6wG9DxDmX5MaJ3SjIgJKeLasVLvkbkTMZYmyWBGLJnp6v6lQHyIZZQY1i3HvLZHJL27nsd+R4HVVri3SnTDllpYGl2UAVZ8588QLbuXsUtYukm55q/dULdOa5i1OfxdaGNA4sAHKxIPbfaXK4KPCm/kqtC8fDiN/LJtEB6g8H/21j25nzcinc17+/WOjTggKyS48TmP+wnI0URg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MawegcjF4UNZnwLD38e1y8oaAgZATjEYyM+2Pd+0dg=;
 b=Oa7SS7EgBhpw9a7FMKdRA9dpKPez7iWHhbysfBNknbi9pB8GROGW+lhObC6cz62TaqC1pvJvoFGBTDv27xCNs5qGvH6sZdF1QaNalnrcwN+O5p7xJ5STudDfsnwKHxjV5Dj2rIF/G9Zd3yNFeigSZc5Q3vo7lgO2wjfTtEv2zLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB8055.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Wed, 8 Nov
 2023 16:45:57 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 16:45:57 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     stuyoder@gmail.com, laurentiu.tudor@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] bus: fsl-mc: fix double-free on mc_dev
Date:   Wed,  8 Nov 2023 18:45:46 +0200
Message-Id: <20231108164546.2699574-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::14) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 87051f5f-ae76-473f-dce0-08dbe07a2e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/q6mMQKm0SMy++m/MJqX5xtu+uwbGjC2Llnsu8mzMWyWDSwzg1C14WOtH6REStfDk/qUGtqSSpDTABB3yG7UutouNeSMWB2L9EUl3aWMay0qrZ78U9SAha3MqMWkL0XV78K+d257XAaxwSCdGV4uJbacs5tANatXnPvhbIbd3lzc46NSdRuTN+lh/QlJpSHAhIw6FBHduiIpGhvAIBuwtGJ77QbLvhxDnshhj2muONu7qqfBMXYhdvwP3ya+cR9f4uac5i8yaLpCAOKGhLE4aJAcvUiEIRsPW+zA4+cgS1SwPU51DzjaPuEDUie2vpDenvTtvU/DJJfN/K1pahVQ57WXWbWXHtrIzb8vhwIgShP1k3iH1PwK5ENlQzgqQDTMasymaYNb6PdyHLuLu5jw25nKMgIRzHFf5D6NQWXyGUEwiX/jle9FzYhm/OwjCJVBEgJXSzswvSFhx1tyKIDE3w5CY1H6S/R9Xtx+lgp4bvHujBujc8wfzW8xg2CATehea724cuj8m1h20FX3PjulfeX1Yfic1osky3//wmNMc5w8CK5PWd+sNDIkUSzSSkAFAu/wYYeeEa8+wfxE4BE7sYjADiXHaAj5AbB6Mf80NGiq/WQHoj5bD7BwQ9vgfai
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799009)(38100700002)(6666004)(6506007)(83380400001)(6512007)(1076003)(66899024)(2616005)(66556008)(86362001)(41300700001)(8936002)(5660300002)(8676002)(36756003)(4326008)(44832011)(2906002)(66946007)(66476007)(316002)(26005)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j01mzmHzLf+PKOOuIxerOHw3lZ2c+dL2U+s1EM+o7zV6BVFR2r5VFZjgKp0F?=
 =?us-ascii?Q?sjvBepxvrxAZXnwLmqcIJbdtJm7K2AnXviJyi39vm7VA/w0JN+BvdDkuf9kk?=
 =?us-ascii?Q?1A5uk5xu2EfBAjURPR1FEFuqA3Ziwj0flxSV4R/+1TqCVNCgn35DJn0G8WqR?=
 =?us-ascii?Q?zi05d43YFpHFNuEh/GNUbRfs3k8SBAzea5od/aTRiRO9X1aZAY6GnPB03bu7?=
 =?us-ascii?Q?v/EDwFFiA6+Mu7hZCCfKA3EHoDMvYlkA1d9fERhhq24udFb1F6kb3xQ2WbRA?=
 =?us-ascii?Q?121/TAPXIwdbLF4gsuHKl+xcklzO44p62oE+S0owMR8+E7OBWSuFG10tvkK7?=
 =?us-ascii?Q?0ymW1ssv6QR8GRbuHFy6cGsJ+MtutlFINrRsMGx0EPF83q9vGS3zIO+pfbc9?=
 =?us-ascii?Q?s6/xEvCUZccSISn3M+l92pa3WcdK74aFHC/Gt8JcPJ6r5Kv3c2ynRHvcaNCX?=
 =?us-ascii?Q?6Io1zlOHtS3iV+YX/+e85JG/KpwCE//PKQyDp8w50/jsGbZF4hr3OpvsJK40?=
 =?us-ascii?Q?IdhOZYmPVF/6z9P5XZ8hLIEL3SX5IX76imsoV21vSR+AeRlbxycQUyABoRj5?=
 =?us-ascii?Q?0A5AfBGRnJDuMpXGkG9By6Gg08f7mUpV6FrXppNP/ru2e4OINs57PITTcatD?=
 =?us-ascii?Q?/NjvTTpKO6gDu2Bi53YVo859Sz9kmKq8C7TFgMnXptzvdOGK6Oly+W9WV0Uq?=
 =?us-ascii?Q?ZXPJh6dPynu+sDhmIKXLWXVtuNJufcpc1m/WwR5HWUFV8G9BrFBKLBHAXbZV?=
 =?us-ascii?Q?ZqEIihXJ2nkgLE7cmiDhzh/52RejxK60hSeNuIO1KoJkxt2U63jPSRLQn7Xm?=
 =?us-ascii?Q?bsdTOTimz+warQaQJ+ygOoVm7hkPofBfl4PwkM47iPke4mqB/789U4s9e2mE?=
 =?us-ascii?Q?9vPekIpq/SnQtldh5+HHmgaBwDlE4AYqi45bnK6krBJoJ3gi3RGQUbmuOzPr?=
 =?us-ascii?Q?JmQb/5uV+Z+EnWxO2aiN6laBpWNEoHHIiUc+eFCQ03U7I7VGDZoWPkXgxb5x?=
 =?us-ascii?Q?wZP14BStOKqJmyO+f9mdT1JYomtb0wqRsM6XfMyPhY/0Cjfla7XoilDyqEhP?=
 =?us-ascii?Q?xXAWOHxxBUXu6iMyrExJy8f8Flyj+RtK249pzXWNwp9IxGpVRb0lh9OcXDX0?=
 =?us-ascii?Q?I6ZJ6Ih0U9PuyGNPam5SckZISmwDNzVO84xJrn/qcTGRWZaotIHYIrPbzNL0?=
 =?us-ascii?Q?MlfLaBNRNL1VP9BJj9H67011/y2Wf99TBGSkpP3QS6xmULkDYkXe0TMyX75N?=
 =?us-ascii?Q?2PmSStu7vOMrrPLKrvCaNnI2VU+5q4XOa2bUALvA6yq8hso0QlQk8ZhkmOAd?=
 =?us-ascii?Q?KxE0l/EDJphr2WyOynlzoglcJm9jvSImtuCBv80mzSO1Lzu724L6KfGhncpp?=
 =?us-ascii?Q?RicUnrVha1NAnAU+iMN4OsKssxHF6+jAnwSaOdMCULkow1R4S+zK4KYgQe/S?=
 =?us-ascii?Q?L8n2Da3j3x+eEAhRc4a5tX88W8YPmNfArGS+Kjn7iwCdBGfuF9vjjritYHpO?=
 =?us-ascii?Q?qFbQkrk9I4AZnw3ie9zEFShSoSsBhC+h17zKDUexUTxOwf0biqHQlGgR+Hwl?=
 =?us-ascii?Q?E6Ej8cAiyduEbRGge3baVR0yj3LH4dAU19TFMHmu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87051f5f-ae76-473f-dce0-08dbe07a2e9d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 16:45:57.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diqBWHNNfU4wNs61Bcwj8qOYB9LxFgcrvuk9ba5Wf09tAXu4/r2bVUTJ4Mug/fFTghgeK1UMOe92VhKAKP4vlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blamed commit tried to simplify how the deallocations are done but,
in the process, introduced a double-free on the mc_dev variable.

In case the MC device is a DPRC, a new mc_bus is allocated and the
mc_dev variable is just a reference to one of its fields. In this
circumstance, on the error path only the mc_bus should be freed.

This commit introduces back the following checkpatch warning which is a
false-positive.

WARNING: kfree(NULL) is safe and this check is probably not required
+       if (mc_bus)
+               kfree(mc_bus);

Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 2f6d5002e43d..b405ee330af1 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -905,8 +905,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 error_cleanup_dev:
 	kfree(mc_dev->regions);
-	kfree(mc_bus);
-	kfree(mc_dev);
+	if (mc_bus)
+		kfree(mc_bus);
+	else
+		kfree(mc_dev);
 
 	return error;
 }
-- 
2.25.1

