Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1391A7FB40B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbjK1I0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjK1I0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:26:45 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0295391;
        Tue, 28 Nov 2023 00:26:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bu4EAMEuhQ38wqWNZ/WJyCEBFqM0CVnmlVzdwKAkNKwje5mkCEfp8Uo2J1ZMKxhYlTsSW1lWUym2B18Pqgd+kLkDOTHE63133byWIu9hPQHGcsjLVWTlBb148rNpu5G/Fol4cJLXzL4rrwvjZ3x8q7/uMKisp+B9pdgJB5/A3qavZPvSCcZukycOEWJzkapgExIhXNVpW9SztWf0lcDZWV2M/G4/iwOBBcgJ3zEY8hELakPniW0nNX/3xfJ0NKPnDFVAZjMXLLkUkWtq1XC57jgzH1iMeUAKvvtXR8oMe6cHp8DymHZFJ2YBgNbasOeuDFzP0N3+f/fWI1LrJxnt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTJlh2esIs0J3zdwZT62A3siivnz7gZnEojPswGLlvk=;
 b=LeWTHjlpLgLJcAQBhd6W0n2xxAvEqP3yE1aP8N4ok7FCcXBxcSw/B+Z4MTIf/PgCeMkP8sDNkYOaNFowSHzgLXHoW1+WSiZ3wmPuJwr8nWVRQCVR055nNWbv+S1WI5+npS4OmUtsi2aOsJQ1h6B1s/CYVrG+B3ibm9o6vFAYNnlkudWOrceQUsFOxbx5J8hAy9hQu2bffWUJGUrp3WQxR1pofl/OGJqKLcqH+CROcqDm7WRyH3HJ4pKXptaCrj7gxZ0JhPru+nsag0U4T6bjmDMBGTESbIP6DEM148i8qOFKRnQPMjgUQd4YXpv8cJmgdhjDXzx6+gCgwOfkyl7TEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTJlh2esIs0J3zdwZT62A3siivnz7gZnEojPswGLlvk=;
 b=Dq8fdjEHrpN8TaVkPEPt8pkzhAZB24pKOQ4KBT6prMmwL7Svj92nvGjciAsullkSNn/snqYd1A1XxnmA4xEQDFzUk2inG2cq10Q0h4q/kRwaWodaK/wgyKO1OVIE7uqE7Pm873Z9NxwhFTx1oCbT+PZyfeTEhxkelOQFwul5lNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 08:26:47 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:26:47 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH] wifi: mwifiex: added extra delay for firmware ready.
Date:   Tue, 28 Nov 2023 16:25:44 +0800
Message-Id: <20231128082544.613179-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:404:14::16) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: e43a317b-4b2c-4654-659a-08dbefebc2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3yFcHA2xnIi/ZVI65ZBi9Dp8tE5Y/4OJckVvpfoR9VqwP9Jw+r6peizFz9VOCJIr8HgIUQ+pp3ro1DPdKwwlTTUzc54HDxiSwW40CkkPUvCI33AXB3p+cOBZOkQcrbPfN0LNAjuBQOZrCZH+zFt7KIyhPWAi6hLxRPDSCn2r5nsik7p8rgc1UmyfX0GMxsTlHRUpsqf7OAcdnz8xUd6SVytNXe4LHrRcGdC3IcX9M+cjf9HIxxci7drnTxXMPZNqnXsCol0oJET/tCm2jP2mkzOmO6U69BXBkWXc56mnU7KBhDtGw9+hBHYtPXsFOkj6A6xMRwN4Ju6+6M5uppT/1RHzdGJoe+4028bHivFoxX7fo0sxAmpZGrZUtQOiHEIn5yBZWodoXhYcF9jxLnSarBRrdqOSD886GOvfA/+3lMYzW5B7YtWIqwR5Y1p3li7UQi05zOlAV7Q/+YPhD8PXj/rKIp/Rr9eMdc69ki2FIA7r1Rw3Zrc2I4Nd1wVN391PMEijXCSqK7Fw1j0gzIy8Hp07Vp0J+sIiPdve4IzpuEloy2dOpdTFuygWEKqIxij
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(38100700002)(4744005)(2906002)(36756003)(41300700001)(86362001)(316002)(6916009)(66476007)(6666004)(66556008)(66946007)(52116002)(6486002)(6512007)(478600001)(1076003)(2616005)(6506007)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pfpJbVgXLHM7YejGv+l969IZAhnFy/dqlfc6p0+IqPAYr+nXEsPqT3yFXye1?=
 =?us-ascii?Q?Oh/vqgeK4IcoVD6VNHZl4leBdHHZfwRud5yvuisYZWarPhAQpG/yY9ALKxUC?=
 =?us-ascii?Q?R5/XMYPD0+t9MV9YEbGLwepS1jinUoWCdiaRMcV2Q7DxWrwh1gKmTPyiplyo?=
 =?us-ascii?Q?hcIeDYZZLzVaasb87fn0yS1Sx/iARBAHRwxkCMgz6KR57eEvCjWWc+cUfZLb?=
 =?us-ascii?Q?DNe4TKUGqCu/iEQGZ5Q4t/5KkN37sFUVgvIytm+8kElcOQvK88a7MyxYRJSw?=
 =?us-ascii?Q?A8ulZH9a+joHgdV7apOOM0sNiCt7gh0nziCsNJoTv14ZjF9mOk/MyqVAf9a2?=
 =?us-ascii?Q?d7tpGboOpBQSCHdK0m8SQhe4M4sVK0yaIxYwzt3hjNxvp4yyxhY95Yi0hzeY?=
 =?us-ascii?Q?wmz8vh89P4hj7S4BXztGxiDtdwWlwWfhiAI68pvi4aWwagGZ/d0kphLQ2kfj?=
 =?us-ascii?Q?KKLVOpcmhagHFqMzIoBhxQIj3XX3UXk8rwCOcRwTGMcpWwV8ywvPdc6ZCyhb?=
 =?us-ascii?Q?yg6762DUxJV2K6eDG2ROl0pbQ146lvzoDZ/G1GLxUa+uoLnfK198QUdYcoIw?=
 =?us-ascii?Q?8qsVTDDYA4p6G3mw6FF5AttMusqM0JiRXGCfhVM9+41YeejgdrUCOxROrGlh?=
 =?us-ascii?Q?m3A+7rmMoLJfnH8H+oEu5LWzQ3KA/PTqeDO5EmoQktmPbatUqCvaqZ+7hDn6?=
 =?us-ascii?Q?hm+u4vb1XkYm5evWhYkG5QMW5Hyuf/pN/yXF47Ji1El0voTqGsrXA67tP76G?=
 =?us-ascii?Q?iVQKwP3uawOzBwRwSNxk1W9j6TUJFFRDZrWe7RC8H2VfOPsAQU1wHauOTlWd?=
 =?us-ascii?Q?0+Ao5i3YDaTBuDi+KaXDoA007izha6eUwg9HQu21T2sYh+k1q5Ys2IrSXeLr?=
 =?us-ascii?Q?ghQtBWSf2TwmAttvKur8Rsk0KlSyq7xYW1utawIWijlw2SrAnRuTprUuv5Nh?=
 =?us-ascii?Q?IYoAhEfRcHduVGuL3AsqF2U3anZmXQnWLZRFJnHLjEBJt3mumjLGMncuxpEC?=
 =?us-ascii?Q?feGWZS1JTAuz4ZldpoMiU7uBksh0iuLD62fr2qvZv7hMc8PGU7++xNaZ5yjS?=
 =?us-ascii?Q?5fqz7OOlxuapSoAig9Z9ae7VZQiAkENgYFGY8BxtiQoOjbmJfWb2PQi311ot?=
 =?us-ascii?Q?/XXxnWlnKqumPLyPxvGTVRrxnyv8GgbBfedo5PCCV53f3dT8AnL5rsHv5z2n?=
 =?us-ascii?Q?1WEOYGwWkulYpRt2kYUzVOMtRk7vF/MLjQ1FGc1FFQmC3wNnSpqG0OXNJCqS?=
 =?us-ascii?Q?Cam/6EWheeQGuDH9k5iLruBN6pzhF3NUWsM/guiugmvG/6oSzv/8FMZD1//h?=
 =?us-ascii?Q?tC+UInmZXmeaWG2bnMWcQuo3niWcUuekp7BXbEa8qyvr2L4Vujs5L/4rMbyN?=
 =?us-ascii?Q?laWUjxHba37UutVTmtyJYmk6E9ICnn19thj06x7YEpHGzzXGcpKXkdblxA94?=
 =?us-ascii?Q?9+fgBmwfN0y8iTTVfWxijpKIdVvcFHfPWtmHTUKtmT6StdPVx6cyIETwCq6I?=
 =?us-ascii?Q?jDNswN7LCoAY5b1A1OUB48t4mUfMrXk+fXeiG2fsgazrHu8vYCS+HevmW8pF?=
 =?us-ascii?Q?OGcZrZEBoS3tYIYi3A+YqqzBcsLx4RfUQDR4x/IWk7I8BI81+atfvgixk8+f?=
 =?us-ascii?Q?temCMrCU8A1uOawStcT+UO2uM+bsBhLaj6qdELhMKY9g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43a317b-4b2c-4654-659a-08dbefebc2da
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:26:47.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+Rz+52l2mqxYo8thzIBWuo3O4Q7y2Vql2JJ203ZzGKilqcJH1QPoou2HQcptPl0cuzQSG2HGIIuJxZtgysz4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SDIO IW416, in a corner case FW may return ready before complete full
initialization.
Command timeout may occur at driver load after reboot.
Workaround by adding 100ms delay at checking FW status.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 6462a0ffe698..744e9403430a 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -783,6 +783,9 @@ static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
 		ret = -1;
 	}
 
+	if (!ret)
+		msleep(100);
+
 	return ret;
 }
 

base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
-- 
2.25.1

