Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C423B7BE857
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377529AbjJIRjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjJIRjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:39:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DF19D;
        Mon,  9 Oct 2023 10:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfAcBUdV8SUFfD2OH/IH8MNIdATm+HLsMOM2xiFkKLSHoExpipmIJ58/BVvylhZkyIAYgzA2ACQYkCkLc6Swcmq8nOjzXbOPTYt/xUxeAQ22egZRoJNpddmtni2HF1rtvJCqUfWtvAXKa33ly0Z1xSh3SDmgdXsc1pE4JllnRClQP7xYXvxdgvnLtKL0ehwR1NxbQ+BCMcjCkLMQ3v1MW5ZPUEIxTmUde4ovnLMVgkpi8VWZrxmz+tn5DsUYKKouHP1qSj5UiJxPoU9573E1E/7PhueNPNp8T/KPxIWtc8+gnHoPsGVzoUtwz1VT1Z2us0VlLojHMEfBND2IEGMMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u17kllQ3UAVyTraHOXkAy6rf7tWQjbQvc8Tr7HXiXP8=;
 b=aB4Y6sJLO7DnAWljH1ZXBUOuYd+lEiTUAaFUnqe//fV6XzCEsMoIKhqr0zy2UZmbPsbOIV5y2dR0Akv6SFCqnEKCb/ermsxrcVBqmd5O8uBASfD1rmp3TsnjOiMGKBmcnIRSwxgElTV+1i8JUp0St5ECj35/goQ4AFlEE40FB8dygmUxzKVup8LDqacjVlmvQAwPYI8zVQMWsfUKm7hxZsoILl9abSwLrfTfNMGB6ez2Zkq8z4yPFC9iN0pjDReK3XTlTyMSJsfUT6s3stDLEk90uKHQ3EfMLEFQ/uWIUo3sezzWSlH5MFu9ZDXjfUyLEGMaJ2t42581JlzLJrHbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u17kllQ3UAVyTraHOXkAy6rf7tWQjbQvc8Tr7HXiXP8=;
 b=pVIqGZUEaXieZaf0I6fJ2Y4eui4uTYV6bDRujqZOdi2JE2kZ1QjN9AoRb7yjcFBQKOkKiEtP4gUezIrqhI8UUm3qOOrdZ+js2gEdl/0HBn0lOYqD3+gUi1NueixqE1NbHo82wCXalySOQXc1WB9yOxqI+pCT9JYzVwqRYcoSl+0H+FeYve0PfMkTKzyZjYYdgszYN4tVZj8qe3Q3H2TJp3VDggQIZ5vg3IOJQj0kA4X8sqCqAqXpxNCK8ahYXVDun03a7nuBYojTBuYG9TXek9NniD3VqO/WmoJt+tQVSAV5QG6VqUxDbANNzDnx8HVeKk3RRgt8Muhqs149my8mQw==
Received: from CYZPR20CA0021.namprd20.prod.outlook.com (2603:10b6:930:a2::16)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Mon, 9 Oct
 2023 17:39:12 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::1a) by CYZPR20CA0021.outlook.office365.com
 (2603:10b6:930:a2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Mon, 9 Oct 2023 17:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.15 via Frontend Transport; Mon, 9 Oct 2023 17:39:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 10:39:01 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 9 Oct 2023 10:39:01 -0700
Received: from 717d7c0-lcedt.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 9 Oct 2023 10:39:01 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <andy@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH 1/1] gpio: tegra186: Set fwnode of the GPIO chip
Date:   Mon, 9 Oct 2023 10:38:58 -0700
Message-ID: <20231009173858.723686-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a701d62-346d-4056-1e70-08dbc8eea675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AgvdBafg/7KLlH0eYMI3T58/F0oos9Q9wBHV7nfPam4b83RzaB5XVq0m/8yMy8ULk6kPWXkv9F9tQPdymTl5s+cbqgzR8CKDkUFwKLrh95NhEwYXkk1kXVG5RobCzSZWKgTA+izw/TRHdScy3GtxImwSsdHcLxsEzAixDClqiLWfzTtnbvITkSkm9F6rJf4ZrEFktfbQ26MgOrj1eTeiqMgAUgNNL4/DnuJzbipi6mItxw5FqYwQ3pXXm13UvN4HYDQLKJJWK1OpVIaNLyHwanoaMMJLe47h27tuhNYIZuk8YKFRcRLp20adzSbe1IhT3EfTz5Hx1msybTN3K2JG7tOhe5WzvC+8+uvZ1tfABBjBvVvMVNbii/wJo1z7fm6sFiK3qgO0jzO2PHozop6GYDCtKDIlRhv0qEOKpROsGgz6VoItcs7WO1fXjV0ZXn/GjX9Ne7PkUUSEJMCR5cCGAeOPiACv+P8tt350QBfGyeX1kjM2cA7sUKW8u9uEttgWj6JM2bEJldmvcUuVQRN0tpO8YxqZQok2wjvFFVFLN6q2moo611PdtGKkPf3hbURgU5NgWmA2lHouenL9sx8l5DoW11D/izG8bfxhblEzaNly/sHdpwcJ8v1SREbmeWS9SSFkUyWQaUEVXL4K0U6715e5NvmDIh4hTBZzdPGrmGptz/3OtatIBGlWptk7juNm8yNtsyVm/yeAnKNZsmtbKLMlNN/q1i3qgBB8b9ePUKn/STNIXiGlf2tJWpqc9yySEqK2x0LFXp7sqeLQqJ0CkL42ODmmgZe++Ea1uA5EaI=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(426003)(966005)(70206006)(478600001)(336012)(2616005)(86362001)(6666004)(110136005)(1076003)(107886003)(41300700001)(4326008)(316002)(2906002)(8936002)(26005)(5660300002)(7636003)(36860700001)(82740400003)(356005)(47076005)(40480700001)(8676002)(36756003)(70586007)(7696005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 17:39:12.2584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a701d62-346d-4056-1e70-08dbc8eea675
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any driver that depends on the GPIO match function to locate the GPIO
controller, it has to use the fwnode from the gpio_chip structure. But
with [1], it is GPIO providers job to set any members of the gpio_chip
structure. This patch addresses that.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git/patch/drivers/gpio/gpiolib.c?id=daecca4b8433d47f0db4933bcc0f283d530ba22e

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index d87dd06db40d..86ad34e07841 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -989,6 +989,12 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 		offset += port->pins;
 	}
 
+	/*
+	 * This is needed for driver using gpio device matching where it
+	 * has to use gpio_chip fwnode to match the gpio controller.
+	 */
+	gpio->gpio.fwnode = of_node_to_fwnode(pdev->dev.of_node);
+
 	return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
 }
 
-- 
2.25.1

