Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C936F763585
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjGZLnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjGZLmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:42:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20716.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::716])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A563C11;
        Wed, 26 Jul 2023 04:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4x4o2zhzWY7VKNkTZrJpRo5Ck+XNujkE1mydyJNngbgv3r63TRZm6EdTq7MqwkXImR4489RStlCyLZ5ddrG8kivW1saE3hnpleB7IX1TqBKb3pAiKhtQTKSxFUAnwpoVZbzJpIK5+7XNpHLvCfUDy4b3DnkCgW3myX/mCn+NYsDg9tR51M/J+yDMo/e/MH5d5OxQKwk7jT3aDLFkIuqNuoEdExxAbP+vtplRTEj+2ZIDu4H60tpeoasJIPaDmfijKSXqH5ZMkmVqaxci0rGqF9C6ygLkM3O4Y2sD+QRDrAnKh6MO41iRdkxJQzPFN3MZhQ3QzfO1lQx3yiq0DNT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEqzs2GKdCd+SK/+Yms51pn4ypilUZrB+lQOwH33kLQ=;
 b=Kf5JaDv99xWEJbf/BTC9r3mWUido78DPuT3mV/UNBEYMDBv1lHI8nH7UM43AI+xAeKCHdyBQCEuDf0zCATclfRxXyk+nFliQYOmstXaazAWH0siYwUBGy/RBeWdYUh6/OLY40AF4+6rjNk7iy4VmhTGlgRV/F1oUZOLs9KfFBMBiXB3uFbI2O9xsGR0QrWZPPTUTKZ8IEzHKds6ikss8ef2N7LsVooGImrvwk8afrGsfs4POXYFq4LSnt88gBTmzcgD7g4kjVYjR73nzE4xgdKZuGKqsVOSqWv6x39ty36jzz/RLLsJSFPYoOckm7cep8lbMILgzppqxMHeaT8UBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEqzs2GKdCd+SK/+Yms51pn4ypilUZrB+lQOwH33kLQ=;
 b=b4FTzwyPSPb9NfOPMpES35W8E7qnW3qSVs9xblW9rGcDxPxCKQ4NmDFDgypTd84q6IP6GBSwAxlECglUwPhNHaLo51XntnLhA4r5wBJToL7xCVDVe3r/ELp9JBrQbXdhe8KM39UXHPH5zN3QuIsYVrMkZifN25dEcfYcPrNK2HzRsqX5DHlaJcUG5wQ705m9lnS8/vfUX761SA6uOY1qePnhZ92u3YRZBNl8U1Q/XAfMMV74dYR4bAYf/K+b86223n0q5Uh4XZAezQWSLKcNckDDWq/6IskKohXOCv0kax657QMivZUJ4L1xVdoh4id8RBUDbs4Kc/gfZiDwu6dfNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by TYZPR06MB4552.apcprd06.prod.outlook.com
 (2603:1096:400:123::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 11:40:48 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:40:48 +0000
From:   Wang Ming <machel@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2] slimbus: Use dev_err_probe instead of dev_err
Date:   Wed, 26 Jul 2023 19:38:48 +0800
Message-Id: <20230726113859.4497-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|TYZPR06MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f79337-2097-460c-396a-08db8dcd2827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdZ6oVhYIMSwJ5R5qiYk+Q/+oqPYyNQmJaY7yLU1jkaslbIWjFrm8ezdOkJXSYDnaRb+0HMlJCLCm6D127Q0TZmFxxsjuiMSVMeeTx+fExOU+36/dqPhOmXdPN9JfM7+gpEiRcNECyzkFkCBpUnGgv3rKqLBoNUu9aKpqvMBlumNKrB5Nqzi3Ik9os7r922I3u0sna1EmX06ZAZo3ybzqq2lS5ixlkVzYh9LPjJIlwoG6ObvYaC8UthoZH14VKN+AWX0wjtFhhRh86wxoge4naJs6RqQQKoJPxp8ZG+OC04u+NBXrigEU1lH/w31BS7xSz2fMM30u7d+NilOXoSOHHl3r8WYCeA05QtpORop7UB8tfeD3AOaLVJOH/FfJTbMIJiBa+h4gLKsWrzKZ4GSAm3bUgQKr7tMv5xYIwMwjSV+9DDxk1RzHJIkS9AuV+hfjf2p7aJybHnWDZ+pODWztktiFIjlntPv3KadDHJ2cHSVZa3A+P8tNgVLCRuLAHEFtGJaUHV9EuqQpQOa0B+k7LqNrAEHFUt9ka16w8Q8IGdiVifskPqVSC7xIDn33xCBXbRhIgNZqWEBONUt4M+9yFGUhTJ7hxys0u+WuG6umONEZgxQ9kKMXz/KkFbmudJM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(86362001)(36756003)(110136005)(52116002)(2906002)(478600001)(38100700002)(38350700002)(2616005)(1076003)(186003)(107886003)(6506007)(26005)(41300700001)(5660300002)(8676002)(6512007)(8936002)(6486002)(66476007)(66556008)(83380400001)(66946007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?456dSlB/QZ0xUqb38N07Cwn8A14uppDJVYZg2ru3ekMyp5cBs5VnCwny1rum?=
 =?us-ascii?Q?fFh9CCRXI0O935mrJUU3GUG/vYjbhNDmmIy//50oTKUn7PKtLF9hUw8TAifE?=
 =?us-ascii?Q?ebUJWP8mdiXLACELFTN+pC1ZAzmKqwtusHUPfsNEtqD3UNvj+ge1YPS5+jVh?=
 =?us-ascii?Q?DzpjpJgAEGbzoEiQQHlILMeG1Auuq5qJziwV6FGELbRVP9OlG+R+Q9jQMtm/?=
 =?us-ascii?Q?0mZU7JQwL4gsOKvbmnuz75k4YLbqxLtlJUR4ScTQP43R4dxlkImY4ZQp24yw?=
 =?us-ascii?Q?/H1nYmYnFtUwv3OZHgYtw0M3kNLKmHksavaMZLP5Da09yLIrvU72MgtvJkDh?=
 =?us-ascii?Q?gHEDOPqIJFzFUxhpf7BtIZYggqCL9m6RZbQfsWV87j1HupRTHzKSqPDJqovz?=
 =?us-ascii?Q?mQf4xMPMM0IkUGbG79vOoCNkkg5/LrPXNVfvC4PafldvG1xXKp7tqyMUovB0?=
 =?us-ascii?Q?gVPNFOWmKvAySMW25eMlxz1EWtGp5+v4cfKDAFrcI0XnlNsLVNgbrpYYp4Q6?=
 =?us-ascii?Q?ZGdM2QOJSHZdIC26hxn1F9WzweBlI9gmd1ihr8dbtOhj9DpHxAsV0ygZi1kJ?=
 =?us-ascii?Q?cytDwfAecQbCUhFWuosJs9PzOmCaOVhDERy9S/AcuX2s4wBmPcMmAOlCBmpc?=
 =?us-ascii?Q?xDBAsTE9P6iFSJEoLsN73OiPj7viz3ylhw8S4wVHQsuP7GzCJLU4pm2ZjX3N?=
 =?us-ascii?Q?cpvNh5T+vQgMmq0nkDLb7vK5gFDDfe+RXBQdk6F4bgwZ99CrFb1+Bl4rIq3x?=
 =?us-ascii?Q?/B53xMV82MfyslSd6OFRKMFvjCc/fuivqy/vuZDG2T6GN/T1wlnX1XD0BsXo?=
 =?us-ascii?Q?Wr9rZjRUv3kIW0IL7aTyK3khiCXYfAMvBGIeRB8+pFrKwCAoP14vcpD3JV6F?=
 =?us-ascii?Q?f7MARRMBASxOB38y3myi7ageAFopOwPGbzVqoKHgzzkRd4wuSFduYivlC6bS?=
 =?us-ascii?Q?wwY1bfHUxYgEFbUj9I9SHnwUY8CVEBG1y0nu7uPE4SZsEWgSXgqA14gZAno6?=
 =?us-ascii?Q?TWPZ2gqwazNeJSjT3+Gu9tUa27d20sgUCXg2BQibYmmuaVtRcFCnRQthLXSi?=
 =?us-ascii?Q?xPxGbovvxPzSCB9nXTZV50icsi7ShZOMzyNJ5Jz3tclMQ7idUpgmX/X4BOZ1?=
 =?us-ascii?Q?nFaOCc0A7QoTOgTgbIgnNHed6UXLsvLwbTGqu6NQdP5b0bjHCsGynknuVOhj?=
 =?us-ascii?Q?GIYBTw5ABcxXCT7+821n9yoJkitNRhHAWKTROAbdSgGkzP2j/p3ibdl8RyUy?=
 =?us-ascii?Q?S4TTqJhnMa31HNlUOMk9JLbFYqTqwFk4qMzh1fQN5UaztTvWOXki70krl3p+?=
 =?us-ascii?Q?3LARY7iCm6ubbw3PEIQ+PEMdaZPZwO1InvTSnYwh5QIw99PamR8a45sYBu1i?=
 =?us-ascii?Q?E+Ffkgp0w59rId0TZ3dBsEKMoKhqwKVl/Cef4dRWBaBRJJpKx9XujegTK43v?=
 =?us-ascii?Q?F11LWqJGPxG/e27iAiROr1RHIjxLx3+LUbjtNifrLORFX1mMoSCQXtugFH4Z?=
 =?us-ascii?Q?WSaaGox12RNYAF5Q5Okru/oxAAGWTV5ICew/gAGqy0PUk1/ey4i148QIXOpf?=
 =?us-ascii?Q?i6mazQrmmzalFALf+jCxIEErxs2mOQmFEBwkVx3m?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f79337-2097-460c-396a-08db8dcd2827
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:40:48.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X64nPiRG0HMIzTtt2f9CV9sZ9J9GaJ0T8WtDEvalZ9ALoonlmjq48Uy/g2BhcTHOJ98ZteGwHt4f/t6CslopAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that dma_request_chan will return EPROBE_DEFER,
which means that dev is not ready yet. In this case,
dev_err(dev), there will be no output. This patch fixes the bug.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 77aa6d26476c..d5c2a732f63f 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -679,8 +679,8 @@ static int qcom_slim_ngd_init_rx_msgq(struct qcom_slim_ngd_ctrl *ctrl)
 
 	ctrl->dma_rx_channel = dma_request_chan(dev, "rx");
 	if (IS_ERR(ctrl->dma_rx_channel)) {
-		dev_err(dev, "Failed to request RX dma channel");
-		ret = PTR_ERR(ctrl->dma_rx_channel);
+		ret = dev_err_probe(dev, PTR_ERR(ctrl->dma_rx_channel),
+			"Failed to request RX dma channel");
 		ctrl->dma_rx_channel = NULL;
 		return ret;
 	}
@@ -717,8 +717,8 @@ static int qcom_slim_ngd_init_tx_msgq(struct qcom_slim_ngd_ctrl *ctrl)
 
 	ctrl->dma_tx_channel = dma_request_chan(dev, "tx");
 	if (IS_ERR(ctrl->dma_tx_channel)) {
-		dev_err(dev, "Failed to request TX dma channel");
-		ret = PTR_ERR(ctrl->dma_tx_channel);
+		ret = dev_err_probe(dev, PTR_ERR(ctrl->dma_tx_channel),
+			"Failed to request TX dma channel");
 		ctrl->dma_tx_channel = NULL;
 		return ret;
 	}
-- 
2.25.1

