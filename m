Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F8076355D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjGZLlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjGZLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:40:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20712.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607E330D8;
        Wed, 26 Jul 2023 04:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKNymhwuqu0bhN4cE813Zzpi7mp0UKGXTY4uzxoHtoPZKGdF8hXE1MS6ve6mx0VnLW6AJTWpFxeV+hyJAu1Y6+3NQaQZdTaRiX/MA8xVpYCu8NJWC9/PZ7WF2DRUbROTVmhtxhqJOFWvXRPTqjQLSeeyxhFLQBK1CZNWrqTxK7PNSd+/rk5lGOt//HYQ7ZF0kRI7lc9s6FG7TatPU3jn94PYtkzfBZwbRbzU4ezaTx2x9ktNwN5DnpX2NrEXjUe29qPGo8a80uXzJz+BPsPQ3VN9dBo+/uTA4M0icnfheGgaE84QzLC+u9EWwSF+JkyhHvK6N70G95fBCJdWxmB4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fDPDzzC8SZ2ADXiURdNmfzV87FuT/nfV9b9dllITpM=;
 b=oEBcAm84okWh8ih035UHTWwkisQobNYbuyaA2fLgPy5ucu9XAWCARKhXphCv6qhgsFav6liQdhIAUIFXkxiPGGLLEhYo2twyw6u35lOPCCmkcBmR6A0DSwgSWclnIBP3jFRBNjVyGvh8AoFRQ77+g/8A45Hh9jmGxELeAgpfnHYbfYnM3A2eeB0EpalwxbZBa84RuN0l/8/T99N/WGpGv1eYDK5SSCbwPWJ5HSTzjsIYIcJUL7vL2zzejAV6R9kQVmhN5AzAT++xd6S9OpPQsFDzfL0Ri0PoENuMczWEa22YBacePdgL/nJ+2iNiuyu/2uD8GgyX2nCLx8f5z3ZBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fDPDzzC8SZ2ADXiURdNmfzV87FuT/nfV9b9dllITpM=;
 b=Tjyw535Qmd8y1rASI1xeVuqMU5PQIuEk+1ScmDyQMEgl5zI87u8uOTdWUQEy+B6b2dReFJhrmcUQU8f2qg3jAd8P5SBjiQ/eSmPnsLivXO4Ld/nJC5UfW6JDam8eF+dWk7881+iEn0PUPkTmZqyaCaFOefXbjJ4amPdjE1x9qbUKCsFac+RNmgXWlMS+IiKS1/gdJ4n1IFlgU/e90jHOFI6zJK/Y8H+eYKaE/0UDJxx59TIXmFZ7vWxyc5JCQwajAEk99nKIDq9G5C+wZoS0l0StlqiDazrOHd/Q0/2BoU+TIcSYKs3tzVR5BawdOxa5lNiir7zklfKZLU1GawXfGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:39:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:39:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/30] usb: oxu210hp-hcd: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:08 +0800
Message-Id: <20230726113816.888-22-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 16855644-1e97-461b-5eaa-08db8dcce78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzXGaoxuFUzBcssTpEz/eC7IZln8ofTHIYpFd8N0V1wUk6j4i4XDQCCEWdWIwI3NOBNvQx7/l+w6VAjNgvjO1rCPb/8mE0pYqiXRnfO5d/xi+N5IwtpXILgovY94DIzjYTblnW5t70oJHFC5bTGnWGuARoszqRBRABbKoD1e3i1PBD+Mjd4fZGxjJTnpVthj0zQh7pJ0NwkB2bjJzqLiHPdzaO8/1vj1O3W+9BZca6QFjSAS+B8UhniPHLDDhc/hmCgH2Oj59Zp7Z5P//LtRyX2CUuJVVgjRnqh4mqxcbymrDkagHFQQ3uJHzloQDOpwHuXwQgHCqWJfl1Z7SxWUJzH04MCgS55PT7M9p9rHAJTzD2dcJH6pCakC9P3i4O1endLXoj6Dm4iSEXvpzeyDf9rTDbdgt7cOsz89ZnrFPQhSfpPa/y3iyhFKro3FitWEaNibzDkBLN5lSPnBH/SewfSxUiPqJvIlSgvVTG6CIayZWRr2OUtYyXULTDWK0c25mx4vX/fI/mF7z8D+j6g9kcTVgqVONuoB+l/prMg+V7kS88f4V+iEZv8GiOSdwVoupoxB4vz+YkHXYAQiAlFWGcVZkdmPuVJ5BSycRT6+Di4WwQQmI46It7h2LmPW1fmo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(6916009)(6512007)(8936002)(5660300002)(8676002)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tNOr+6q+Ew+HjllzsVHT/BGDyRiTDmb6MGyDqfIDzLsc4hI26S6uekyk9wZt?=
 =?us-ascii?Q?6vU5nooMrvzwPhokfXEFD+1Zf/GmvHuzOVdI4y185Xk1N+rA+89zRXrAGCtQ?=
 =?us-ascii?Q?zbcQiZF8voAgxauz1IyoNIkcslPF52fRAQ0BhN35MqJ9yQ733oDRMXnF4b3N?=
 =?us-ascii?Q?siDcmeMRMq2jJcJGy7PW1LcRzJpCVMzAUXWTLY5GJ4nuEpGEWZaIXP0mfncq?=
 =?us-ascii?Q?OA/NP4k3iMNc/0xoeHG4Fthw+XzmRbHyn18FPxzhmNXNoxyVPlTIil7mu78E?=
 =?us-ascii?Q?XPGH6ooPU17qCEbr2LLGsFzeZ/EPy87xphPg5Nl4aKfX+SxMit98h5ocy54n?=
 =?us-ascii?Q?sWenML/JnVjR6wLbvUBB8usIJIK9H0W44HWDxJGMsw+R3IztYYRp4JoJIM2O?=
 =?us-ascii?Q?hlpzWF4oERYmDIu8+9BUgQ7sAVF0v6dXMcH8Ij/MEtvQP6g87sgRAnei77pi?=
 =?us-ascii?Q?PgDDvjPZ1YSdOk1EyQOS/YDPsuMvR8D2TN9FZCCeNs5/mTfI+dGaeBVUrVZn?=
 =?us-ascii?Q?j0r4f94BfKwqeATwrrZtAGu0wjXOc4JqCIoVpJua/BIa3Ix1HK7z7+xmQuFx?=
 =?us-ascii?Q?8RSqc7mSl6h/X6KR9MLqao5HnnMpTx8AaUWthXd11/+nm6AQO/qMNV8kgaS3?=
 =?us-ascii?Q?8YpTrrxQbBfEEhUOfDjI9qrOaZfOUUThMJwB4wJF6UfxI4Wltk671bFsD2vL?=
 =?us-ascii?Q?f6buq7Zm+LMEVxBGp8Ny+jV5MVcY4EWWzMS+CXKBJukmCEikBJtKKvbzc2hf?=
 =?us-ascii?Q?LTMDro3x1+2/7KU9WXdAwQbBKpQD+TWJfF/9G/Dls/Du6OovJ3hnOVpozFVQ?=
 =?us-ascii?Q?4d02Zh6Bxk8l2pcu3aVtH3Pb5kxCciwfE2QAjJItbAeNbZj+kyfomlZEbNGJ?=
 =?us-ascii?Q?B5+qXzJpfcbRUGiLe9ZvkUB9QPHQkYWXmbanfvMZKL9ajU2sXGG0d6DHkzw+?=
 =?us-ascii?Q?7W1gNwbawHkLZctmge70BY7Z1CEYeTiT74YkYXGvO7G1L7JW+53tpil0F9nr?=
 =?us-ascii?Q?vxVkalcz10JgGwksxzXKMY3Tluy3zKRo4bGa4pleWT8ZgBmJfOJaaSIrRNye?=
 =?us-ascii?Q?H/1kSbv1Kspot3S9OuJX67SapvGtHAxphteqs7w9vazdpWdNIKX6+3bbPCit?=
 =?us-ascii?Q?S4x6lfPliTtGFsJFUHg3nQHMBemn8YRY6z0DpE95v50A73DiKinOORCFOa8Z?=
 =?us-ascii?Q?DkaLLQSpsl1/c1v4TJF6nR3BpKqjLy5JWQji+1xju6/oEw+xTBmom+l3jzFC?=
 =?us-ascii?Q?Mc4L2nG3zWKuUCk830mNaA/Rlp1uCLWbSzRikJECQjV53sFOnhSaB8dlZuvf?=
 =?us-ascii?Q?Cp5RhZhu6STEbgyUegp4j525UVKG4yI480z6yg7ozqXjH8FFUoUvPwEeeMnA?=
 =?us-ascii?Q?6PmBCFBGjK6s8cF1X20cs2473SEKCfOD01xKntL7s8bo6N307s+uy2InmtRA?=
 =?us-ascii?Q?ZtTQHPBxVbF/2VOQ4fBAPSLZWxqa32sbon5Qy3TVL7ZFvf3K1pismzqVOn5G?=
 =?us-ascii?Q?Q85fHcvS+NZXSVe+pVvhV4kHSQkhxexltDoTQQo1n4HmzQf92AGmLR4QpmSS?=
 =?us-ascii?Q?GcDi9DOFS/KSWMgFwwUGSlFN3WzT4RnV09hnTkRh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16855644-1e97-461b-5eaa-08db8dcce78c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:39:00.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s25/aav65xEgAFIsI7tznh9s+QFsqq2enGuM4eiXDEy8EikBE7l3MO01XjMb5lY6/eplKizDQedBSop2it+Fiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/host/oxu210hp-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index 50c1ccabb0f5..d467472f9d3c 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -4230,8 +4230,7 @@ static int oxu_drv_probe(struct platform_device *pdev)
 		return irq;
 	dev_dbg(&pdev->dev, "IRQ resource %d\n", irq);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base)) {
 		ret = PTR_ERR(base);
 		goto error;
-- 
2.39.0

