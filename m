Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C744A7534BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjGNIJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjGNIJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:09:04 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421143ABD;
        Fri, 14 Jul 2023 01:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGGfURbNU1t7V8A86NyBj4BS+/El9bcDntrr4Hg4CZQfsmNy7HPsPNzyAxF1DcAeF314H5MFZ3gRb08IfiHXntcw/AwsZR02YiV9Y0Qd+JMKBuft14If9pQB85xHq2nGFuN9xwGCSFMB9rNgGNLBthvlbv2DIBWblqQL3ozA9cm1sr2ACmasyV3ge9VNAFUsFFWL4E85xuDmUXQCJfGpbObAZFWSpUOAN/h6cYsE4aTzk7Uyj7FAckY485xrd45qpTmgEl4KM+WiA1EmOysT3GP2lAmJr5wbyoJx1yhUuL8ur/WFj7abkmRuuV2Nth8kqkEUjjrY1yaJuna/Uj2XIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9re4Q/gFRNAj1/PcQBh25BKohWB/YpuBuRQVOHii2Jg=;
 b=dAW9h74EiVKxl1+YAjdgJj3jKt4EoO4gVxbLE0TTexSxSF5v0VrVKrE3JtweFpwN24v8xkw3y3I3O9wfaPhDvkz+J+rTu2EGEzuqA1urX/vj+WW/6pnLC7+ERz5p9ZG8sa25H9dvizxY9q3hAnZA9d5eWUAoQxooYraGikNy7Mk3Yqip4sq7eRS88RwyAiUNMIK4hDCbNpTDXDsUONvVLZ01OYc1DG/dC8z4NQhCWA0M5B0syfHFjF/m45zsKERWlNg2yJTwWi39d7sPkQFA5qmxooR8ajYKH9LXFKkviYklnKEvJkXWadjY6H4E+dEBM7J9NpswYQuLDIBT1r4MsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9re4Q/gFRNAj1/PcQBh25BKohWB/YpuBuRQVOHii2Jg=;
 b=EjX5b6a+SNEYIxFaKFO35Zqgundj7Nnnm/JkRvTSoZVM+SCiDCszQ2V9V+hmmluCT+5RCjHf1dC7XkRzavyzYgh9wOvr9ub+om06Bt4UjiDCK4ZueDfIN7AfoqDyet8amcyicmhAejfI9a4WKWC5SQjA7+y0nX/qIK6q11Xc2HFPF6otIkxa/OkQkQy5hAcWK8lhBENOHeKmVMRBjlGQBbmsA3rh9JSlB3UouZwBwSEwPpS7h3AqcrsYyhN0neT76hlCX3qYwyN9Cuy58VZYMnVHn5Pe9W7lJhTlc0BgoYd5XWMtG5eT3df313l8RRl2EX7O/COb7xaBqlneQ7iJyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4059.apcprd06.prod.outlook.com (2603:1096:4:f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:06:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 08:06:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] Input: qt2160 - convert to use devm_* api
Date:   Fri, 14 Jul 2023 16:06:10 +0800
Message-Id: <20230714080611.81302-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230714080611.81302-1-frank.li@vivo.com>
References: <20230714080611.81302-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0108.jpnprd01.prod.outlook.com
 (2603:1096:405:4::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fe677b-081c-44d4-db32-08db84413a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xITJtHK0mdxG8AJuUA+ACoYUH8DjnYML8bOK77yCgHFZkuiowFl/2l6X1+EQzrnX1G5LwEGhDn3l7GPJiSY7prbQ643WNxkq6qW+MVtBP8rwbc4PeqettTrGw1U+G+Gl+WxNPap/L7sU6kYRHd0GkTdQ1XpEdugHK0go1+GHIh4Skl8jqEDf4Ge1vzCeQexquU5FA05g9MEK93L3Mg98P6XbHONQMetjH3lgdZ+/ZSz2pzav1Y8aaZr0Kt3MXj9xm0rb96b84WOHDvGGMGAQ9qgX1/qmsoGtTtOt+5jJrTnyZ8i7h7itv5fKYejN/RdmRhQPU5GGZGOUC97tgl0fyQ4bAPf3b8XPVxF2JjbKf5oFSyzxtYdAXnrJ3M2yQFF7m6wdYv75sElyzmuKmIgX/yPFCFsES7Isyqzorawwa3H9fzWQJ03gnM7ngz4AsmJB7hhSwveBUi3k3GgGEG7VziYZtp5Rvf8UYg4ab9486HcBscK8vq/Z5ChsX1mdKZsQgSuXp0IqbNBCMO1IYk1LUDDu6+MizYE7QeaEN2mKoA+O/BJNqRbD1Yi+Tq/W4sk1FlnBMqif1xqR5pJGYwFB7KZ2ZdHLpH6u0XmiJIvpcEKMPrJQWXZDFIuhcupZm3wQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(52116002)(6486002)(6666004)(478600001)(2616005)(83380400001)(36756003)(86362001)(2906002)(26005)(186003)(1076003)(6506007)(6512007)(316002)(38100700002)(38350700002)(66556008)(66476007)(6916009)(4326008)(66946007)(41300700001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i0pMh7e7Nh6qAnY5GtwgFM7bgbnzE0UCaUA78G8nLXFXdl8OVd4Ugj1Eiagj?=
 =?us-ascii?Q?GRhQi3iHf7jh7yRvskr540mM+NJawPVTSN3WdrngM7gpLcfpQxNfUHHtvt2R?=
 =?us-ascii?Q?R2IIm0eU/UksogDNFSbdTo5DXAfr0xPnvcOZ9yb2+pFLx+I0uzqN73pH7LrW?=
 =?us-ascii?Q?WvTgM9ZF/y+SMu/lK0APhtEI4nv2P/oGe8SLRkePaWwp9FnzCN6zkLqiRWUS?=
 =?us-ascii?Q?mC7ZQhrV2EqZuhEavnqt6pf49fcaxBPPZ3eOE1mfsDG41aMk+XtP2QvBLaqO?=
 =?us-ascii?Q?6JB+6BHnkJl6IwHYJGbAebSYpxl0zeqyxObI349Qh7IDk3rwg3GB0ovvwH0v?=
 =?us-ascii?Q?r4gvJh6Ic/dP2T1E9dzvTZGBh3JfSeT563kd9t2KIrfUeHa2EfizPvv/wy/d?=
 =?us-ascii?Q?Qt7xai4EkCvyqFU/xUyKfPVLlERF4m514KkF3OgZM1em+XC2oQ1i120l57wt?=
 =?us-ascii?Q?fJsAKTc74id4rbCytGu+8Av3JoocTZeMO+hYU8DPCxEhNmRfDmjFy5kJvxln?=
 =?us-ascii?Q?6kEi8PY0cItHLCBMiNYFTWBmCB3CSCrbYo6xJs9zf0DH9fE3WhthpEOV++0b?=
 =?us-ascii?Q?ypEm46hIx+0uh0Yp71PYKYFtHvJfXa7Vhxgf6zmcu6NtVBR+Y69u+KD5Yum3?=
 =?us-ascii?Q?tefzYX66johQheOZFJWwr4XiI4XQz6XDMogWs5E3Y7YelYPd5/jg9YOxH/79?=
 =?us-ascii?Q?N9KPPVLJcYbKGIw4AVL1svurG/etZznoiJRFDGjt0laZg1RNRE/lRkHSvdAb?=
 =?us-ascii?Q?RdyM+yICJsMHf2VDJ4bxH/ENJq/Gp6vOt5cZOuqyVhUaHj1Ox2HJHKVPIDhU?=
 =?us-ascii?Q?JgknQLifKEujqe5CWYxbypv2yUAZ2/65W0P8n7ZGaDVpq/q3C6/EDdFGJtXG?=
 =?us-ascii?Q?Q6ifB/CAOUsU4AvkFg535wiz7xzG333zR+dJRlk5iM8ClEdnt4lxDTcciRN6?=
 =?us-ascii?Q?pgnTNiW+d03YnRzGgNYnHalBB5P8MPKJ2Xy4LTzJY+Nd+bP0tJdEzQxl+CG4?=
 =?us-ascii?Q?QxkY20LfHoU/bo+CZv6wQgL3ofApvi4jlO3CJ00NvvWdK2hotPRKYIkRgxAC?=
 =?us-ascii?Q?xA2uWBFreQlsiWxbpNvZ/yeNhZxBeB9tziK8N6RuYw65RDr2pxWo14ZWIoIi?=
 =?us-ascii?Q?QXWgImOSA3MwFW7ZstB7CzLOV5tLvJ/IKake1at+H35Eb31xuc15b4fGJpze?=
 =?us-ascii?Q?Lj6YAH1rBex9p8DUGTnjyQOj2EUTQRXnNJml+In//93fdYfdGYJylLfJRLcZ?=
 =?us-ascii?Q?NVrE/tPCZUxGBkGaTzmRG4WwxXg5+0CxFKs/l+dMRn/TLfsirZ8vsKjhrlQs?=
 =?us-ascii?Q?uRLmjlbY6/nEVnBNOtekb7JPUGbnmymEELp/6LBLlwFONx++JwQXe1lQTSl/?=
 =?us-ascii?Q?7ZHSqjV7V2iOAmKIoOGEyU3COQY8JjPK35GFka3ROqBo4DWKIa+yGW3hSoJv?=
 =?us-ascii?Q?sg+0776u5EUHy2iYc7bY4D+n8g4AkZlD4dCYzXppGflKJHSzweuZ4KjTgaE+?=
 =?us-ascii?Q?Lc86Y9x7JZ1GjWTGJot2NKqx3JN0vlz+ve/QTSt8Kk2SJ6S2MXUgKEjLys6U?=
 =?us-ascii?Q?6AhXTJnDdjf2s/S6dTusigUSdqHtD+n4F0WPYoUB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fe677b-081c-44d4-db32-08db84413a4b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:06:29.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9yYkJikc4tEcfYvUO/OvRyLBTDLymFbYz025RBaaR9kdJDm0YuVbXq0RZm7lnpIHLzaRpuwZRGxTM+3sJFW1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_* api to simplify code, this makes it unnecessary to explicitly
release resources.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/input/keyboard/qt2160.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 599ea85cfd30..218ef92b8c2b 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -340,6 +340,7 @@ static bool qt2160_identify(struct i2c_client *client)
 
 static int qt2160_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct qt2160_data *qt2160;
 	struct input_dev *input;
 	int i;
@@ -358,12 +359,11 @@ static int qt2160_probe(struct i2c_client *client)
 		return -ENODEV;
 
 	/* Chip is valid and active. Allocate structure */
-	qt2160 = kzalloc(sizeof(struct qt2160_data), GFP_KERNEL);
-	input = input_allocate_device();
+	qt2160 = devm_kzalloc(dev, sizeof(struct qt2160_data), GFP_KERNEL);
+	input = devm_input_allocate_device(dev);
 	if (!qt2160 || !input) {
 		dev_err(&client->dev, "insufficient memory\n");
-		error = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	qt2160->client = client;
@@ -389,23 +389,23 @@ static int qt2160_probe(struct i2c_client *client)
 	error = qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
 	if (error) {
 		dev_err(&client->dev, "failed to calibrate device\n");
-		goto err_free_mem;
+		return error;
 	}
 
 	if (client->irq) {
-		error = request_irq(client->irq, qt2160_irq,
-				    IRQF_TRIGGER_FALLING, "qt2160", qt2160);
+		error = devm_request_irq(dev, client->irq, qt2160_irq,
+					 IRQF_TRIGGER_FALLING, "qt2160", qt2160);
 		if (error) {
 			dev_err(&client->dev,
 				"failed to allocate irq %d\n", client->irq);
-			goto err_free_mem;
+			return error;
 		}
 	}
 
 	error = qt2160_register_leds(qt2160);
 	if (error) {
 		dev_err(&client->dev, "Failed to register leds\n");
-		goto err_free_irq;
+		return error;
 	}
 
 	error = input_register_device(qt2160->input);
@@ -422,29 +422,21 @@ static int qt2160_probe(struct i2c_client *client)
 
 err_unregister_leds:
 	qt2160_unregister_leds(qt2160);
-err_free_irq:
-	if (client->irq)
-		free_irq(client->irq, qt2160);
-err_free_mem:
-	input_free_device(input);
-	kfree(qt2160);
 	return error;
 }
 
 static void qt2160_remove(struct i2c_client *client)
 {
 	struct qt2160_data *qt2160 = i2c_get_clientdata(client);
+	struct device *dev = &client->dev;
 
 	qt2160_unregister_leds(qt2160);
 
 	/* Release IRQ so no queue will be scheduled */
 	if (client->irq)
-		free_irq(client->irq, qt2160);
+		devm_free_irq(dev, client->irq, qt2160);
 
 	cancel_delayed_work_sync(&qt2160->dwork);
-
-	input_unregister_device(qt2160->input);
-	kfree(qt2160);
 }
 
 static const struct i2c_device_id qt2160_idtable[] = {
-- 
2.39.0

