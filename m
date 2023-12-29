Return-Path: <linux-kernel+bounces-12900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D1881FC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED2C2856AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A91717EF;
	Fri, 29 Dec 2023 01:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="K1ekeHPm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B215A3;
	Fri, 29 Dec 2023 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Whxty1tIeVL0jrUPPPXuuowpKy2zZLsTI/VA6GIJ9d0JK3B92Oi3ty+TfKyh5iIampF1DTbmMN8joVmXfDaVZ7ED288psKisyWIguapfVRvWTrlTTwZse7WBEvrUNqYpOJaMMMKSvZOJ9nOv8aAJ4xGBhF9s3fY0YKXg20m+qu6QLZuBezO2Aoe6o591bDAfEvB7FknW8aGG2rcY8f6tzj1oGLEyKgrIVWPq2VDLMgtS/tt1KV88Fj7UdhZZ3pMBLVozwevp7+45yVI5M1cHLRwIM3/rw9RtWUUXKQaiQmRuETWcNQd7L+Af233pJOgko6PAr2Uxpiii3r5ZarS9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK2ZnpN5j2umLuHVKefC2u/Tdshv7CiX5RJeEKgR6wk=;
 b=Tr2EcxBi0QHyOdWndmKh5ScguX8CM94cQxxjAniaV8RJWAKnRXqLFVbMRG54+v79GgghpvMCP5oAzjHdKgYRd2J7XvOmbsM/yZ1XNT3rNG0xELqSD21Au3RNDrtOtrjHzSuKRo/htBtdX0gX8S2OTbKYKkdhFLSwihx1IIu/zomaS0sI+c+Qj/jqZrnCKDDh3ntOSGCIb0IJlpuLgcODHUc2Jj/mE3LQUsN5vkVZ2/r9e7fP9m88NYkC7FniQ74fcs4D+HY83MnXuFczLEJ7h11Yus34wpHr8Q1voww26Z1tS2ML1xtE3YA7B3/55XqIjbd7C1iBMl+pojPspCqCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK2ZnpN5j2umLuHVKefC2u/Tdshv7CiX5RJeEKgR6wk=;
 b=K1ekeHPm9yJCopi2iCYDJ/uy3NHvlqQsX6L7I9fNjXuqG7c8R5tjKcEaDryMGk6C4FZ6SqyB8EV232h7KD/zX0yQ1wh9xr6gEckwW0D2WZwIAX6ZwPL8E4I3Tl2/ZK3M8H96Cy2D0ZDA2e9EOCSQOV4Iy74SkKN1u2jG/QPJ5Y4=
Received: from AS4P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::20)
 by DBAPR02MB6117.eurprd02.prod.outlook.com (2603:10a6:10:182::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Fri, 29 Dec
 2023 01:37:14 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::3f) by AS4P190CA0030.outlook.office365.com
 (2603:10a6:20b:5d0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Fri, 29 Dec 2023 01:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Fri, 29 Dec 2023 01:37:14 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 29 Dec
 2023 02:37:09 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 29 Dec 2023 02:37:09 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id A407510F4C;
	Fri, 29 Dec 2023 02:37:08 +0100 (CET)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
	by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Debian-2) with ESMTP id 3BT1b7sR692624;
	Fri, 29 Dec 2023 09:37:07 +0800
Received: (from chenhuiz@localhost)
	by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Submit) id 3BT1b7Ef692623;
	Fri, 29 Dec 2023 09:37:07 +0800
From: Hermes Zhang <Hermes.Zhang@axis.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
	<linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Input: gpio-keys - filter gpio_keys -EPROBE_DEFER error messages
Date: Fri, 29 Dec 2023 09:36:57 +0800
Message-ID: <20231229013657.692600-1-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|DBAPR02MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 923d7470-e2c5-4274-3ed8-08dc080eaf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GHVRUb9VdijZME1lvFpvC/k6xmOVWI9JecdFMFADRHUvmJsPJEYq4eO5gnFJkiF1lq78U5219kWPsSz+xV6+vmufEZeHUya6fxn7sONaxjZ1dTzROgxjaojeRuuOWNDIuz+rwJqRoantng4/NJ1Evr7iDuZC3I0k1LgUK+HbvZxUngC5XggArYPRIcfWXKFeiE2sVfU9ltMBztp4KUOofaflLFQv+gLgQ4dXukaaWC1CpSPS7ROHqpaNsCq819+laDyaBs5pPzvthslBFLGGb8Msw96/YkAn3h9F1hxgKz6K9XoFD8yCKdsJGURcv8pSEW/V/BYuM4Sqs4qR4JxYT8kdhBTaKzxbtjKA/ZY35UUOxM6mpwNQhMCaZrqkrcdgMv0N8+OYCKkXYaw9Mwy8J9f3EwBBQ0pWRh+PT7+DyezO138a8sL18CoSbFwUWg43WlC7Y7c0HygzodWmhSoTiwdnjqgPIXx11NN0QnsPzTluWAaSpC7+ixxg6/rKFC9F18oNmcB86H7fqzhbRB9jqnZgGSr0hyf06QxTHFhWh0GNyOyLYzHOpwoCwhH9SbHNuCIyEmMd53oPAXPT14jlCJ+zH0MECVKecZwsu9EcN2VNVTt1oaoAtauWlPtiqo/oTBrxqmDmE1IITlaDuQGvNUZ3aiQTco6XaOv6Pr9f9oJd7bTikSs+zxcXI3DS9b6/V7mVb0Q3il97I6jQ5Xxi6HM9dBkA8DzBPJF5F/Vl/90oZ/rQA6w0k/yYGR8S2QhLF9NL9HhhwxKvj6M1rfl7RQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39850400004)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(26005)(41300700001)(2616005)(1076003)(47076005)(426003)(82740400003)(336012)(81166007)(356005)(316002)(36860700001)(8676002)(42186006)(54906003)(8936002)(5660300002)(15650500001)(2906002)(4326008)(478600001)(6916009)(70206006)(70586007)(6666004)(86362001)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 01:37:14.4602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 923d7470-e2c5-4274-3ed8-08dc080eaf64
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6117

From: Hermes Zhang <chenhuiz@axis.com>

commit ae42f9288846 ("gpio: Return EPROBE_DEFER if gc->to_irq is NULL")
make gpiod_to_irq() possible to return -EPROBE_DEFER when the racing
happens. This causes the following error message to be printed:

    gpio-keys gpio_keys: Unable to get irq number for GPIO 0, error -517

Fix that by changing dev_err() to dev_err_probe()

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 drivers/input/keyboard/gpio_keys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 2e7c2c046e67..193856599669 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -581,9 +581,9 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 			irq = gpiod_to_irq(bdata->gpiod);
 			if (irq < 0) {
 				error = irq;
-				dev_err(dev,
-					"Unable to get irq number for GPIO %d, error %d\n",
-					button->gpio, error);
+				dev_err_probe(dev, error,
+					      "Unable to get irq number for GPIO %d\n",
+					      button->gpio);
 				return error;
 			}
 			bdata->irq = irq;
-- 
2.39.2


