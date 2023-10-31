Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8879B7DCD00
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344245AbjJaMX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344165AbjJaMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:23:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C0BA2;
        Tue, 31 Oct 2023 05:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6C1rOafQR8/tJKrNytGcRe4wZTsnp94S3pbtBhAg/5vzI//mL4x5tHNCATMpD4n7Ap3K1aL78asl5ifBEcA+Gc/I+7YbP8JKGlTQbK35p3u0K/sJYVqyPFjIitvRok6a+1+4G/TRt1mxVLf9dD+BFze6D9l+t3RWiZjGKKa/xRqDveHvCY65+jYbWivepqIxXva+FqB1qalUkpq2Zuc59LsS/wGdCzBAcyQSZIqljouau6YYywBffbst9N2fuT4P4fHTF1R49Hc+4xoIvYN5FCebl1WmnZb0jIObkmKzB3sZ6tO5S/x+i5arUivBzV1qcqJo93gHn1iy7PhX8zruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbWuE50dOnZ5CeLlA2h9bekBJeYdoUnPU++PS7067hQ=;
 b=XXJRTKTBVfBKurb3JnKo2CaM4r1sDuiBceaP6XIJka2wWoHyTDAmJ94Xq5V351AhTZEJ/1RWMac21Jm6BNBzEgvtH+pRQK6zE0A/fB8JcIcP8zqetENdqUjaYdQzvsEgS4f9f57CsJo0CYLItLW6hcGA6pb9l3nXWNz1A4Sm1hx3+ASi2vXhi2qBD0FBnRfw3+EK3enxbCo8VPjzGK/UbBmFBturrjs/zIhiUDJVuFwTS6WBkf/zE9dTRMiiCWQgQKle2uB7D6ElAf/J+4hbNyV5CDGdR4ZD8jtJtR0JMznxGzY5C81j3EYBxvE2Db7u8Gk/aPtA2L5/HBWgIZId3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbWuE50dOnZ5CeLlA2h9bekBJeYdoUnPU++PS7067hQ=;
 b=J4t8rD5tuy0NCn4mMpNoufahr/EpnuMU8G5EmAB9oTBfotWKm3sWHKpSMeSyc0lmBBpAqqujf0OFllcUNMva6kuVD2TLju6GdZioHHxpvS4F7/OP3xwW2K0P1aucpOwg0ZVz6cqGEsjMtOy0G/D5DWyMdteBwdz0ZWzvngqoLZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 12:23:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4%4]) with mapi id 15.20.6933.011; Tue, 31 Oct 2023
 12:23:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ranjani.vaidyanathan@nxp.com,
        glen.wienecke@nxp.com, nitin.garg@nxp.com, chuck.cannon@nxp.com,
        Souvik.Chakravarty@arm.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V1] firmware: arm_scmi: clock: support clock denied flags
Date:   Tue, 31 Oct 2023 20:27:34 +0800
Message-Id: <20231031122734.1371524-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: de56d880-22c0-4993-49ca-08dbda0c299f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2ynTEBpt3XkedqHp8llhARtS/d5JnohTU7XwS6X0pnYtwyayOVuOIv18XcREwAxleuQSTj26NWVNtN3zTDnkMuxiwt5IyxUTojW7csTbu0vURh9tql395+kI36KGDooVM0yVH7TXXbnv1qVwcaCKLC0PAGBl+Rsw2qLeh+vt3s7951dXkfHZ0P7NTF9IzkHH/9ZOjNixCjhpPVDe1genPifS19uonuCKNeo+6TD1NUsvda8YnNGZp4Se3Vt8ut4wqWP2vOr31oFmiXasGD/RRbEAXj1SZhi4h7tg4rM8fRertZgw66Yb/f9TZdUkdGITx3hwCs8xidSXVfcSUoD+/GnTvtcUXfPkCNAzEect9JUD/t9RdbPwkew0FyHBTxRPwrY0Y3NTKL97XzpiynJYGjHGB2Dbp29tFsphjzLpPJFblvvUq4ThIy+q/IvfWUGfTqgp1y5+NJ0T5Jxn1YS2Z0cu5GLyCrr58MoRA/zrm53jYD20ETpZlE4PbqjOG/A7kZauYXo+RXHFUiBay7dc8BCb1PtrIgIL+raG8132uP5EKFrmPWDA36yNQ4Yc7ZqJRb1ZdvxBTzylQTjpACxajS/24YsS/SMEfXWfoemaUeF9gKLfX1RAfBV7u5wi9MW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(1076003)(6512007)(26005)(6666004)(52116002)(6486002)(6506007)(66476007)(4326008)(66946007)(478600001)(5660300002)(41300700001)(8936002)(66556008)(2616005)(316002)(38100700002)(8676002)(86362001)(83380400001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5C/gKs+wKhrlpMcxr0Sy02mW0GT2oDi/vpl5yp2RZGJmLjUG1Xb4koEpx15?=
 =?us-ascii?Q?maBZ2bnsmuO7XO3bofvXJdotXxoNGqJx7Y3o0SxpIHXPMSP29896EXJ44C1a?=
 =?us-ascii?Q?6Fn7jUhcIHSIT+LJKIio3pgtREClB8GGJtfS1MbLkuGedDOOpfWbA8KnLqtX?=
 =?us-ascii?Q?AvRM/C2PeGYl2bqOXVWP0b1Z6aEBH/5jpixb7gwePx1mFYYhg9JududkEr3J?=
 =?us-ascii?Q?V+Ocms59c7hnj/OpYOwH6eJFCoJZyOsIJSbPQqVhEUlXu5G3rIeu1SzrQkBR?=
 =?us-ascii?Q?egBMGcDy+/mjq01+limYF7P4tYvR/2rSK5HSDXKi5DHpXFNbPSrZFe16ptsv?=
 =?us-ascii?Q?wEw0yJS685R+tA1jgRO/L5Er/FpON6nen400mG8+8yuScHAr4xJclQTgGShH?=
 =?us-ascii?Q?AeodluZIx25AvmnaaTgWPcWSaPF6SQXGBj+XvbFOwFjpD8X5c767s7JN3xCd?=
 =?us-ascii?Q?KAT3aXrdTib+72iVn+EuYfYIIVumWDk+8+ObL8Ak/AaOM046+HzjKrhTUolA?=
 =?us-ascii?Q?KJXmkOXuIfOb8wZN+WaW9T2dTAgcliTn5J/L2ktzA8jIYh8DGRt4UxyGYf8Y?=
 =?us-ascii?Q?hoc73qFT4WDivC5bOcxcAlzxfGUfwYDvqudBK4hihs9DWmzozFkiBvmH0/ue?=
 =?us-ascii?Q?ko/P2Py0GK0tIqqrDOZeWfwqccPvdYXTjJMxkuV1do2YDRUDYtsW+tt01jP3?=
 =?us-ascii?Q?Vfjb5f0/Jah476DFtOx7KpAO1L4NqP7njlXCRDXgRs+dhSKBI2EuE1HujrdK?=
 =?us-ascii?Q?CIBtsRv1mhXzKTXgH+1im3JtOTubos0eXNFYkUTsm/rBaiV5SWrWgvXcmv/G?=
 =?us-ascii?Q?6GWdyqI2GMu9ZHWnHb6msgAL633o+lgA6YztAjWx2Vi9e4DN9EXmJ/MoZPSA?=
 =?us-ascii?Q?aYV62AH+XYHm7PHVyrK71D2SUCz7LMduujK9aRGTQ+1FxrO49o57rqAasW9M?=
 =?us-ascii?Q?S3wtvL/E4LqAx+cvnnN9iRR2OWigUZpS9ze3POdlxzayghlRlaR4xx0W0TLT?=
 =?us-ascii?Q?K0XyZsDUsiDkCWsmJgJcSGK5jz0h+2qlhbEMcWbeXVqYly8fSnX5zS1xHARD?=
 =?us-ascii?Q?JjAR27D7EUH/D97Duj83COQyGSoLAu6F4HVEUjddTaS3WV5x3WPQEetsPNFO?=
 =?us-ascii?Q?DmkrYzzjlDnXcloUmNZg2vFJhZ2zmnbychMoRePqYykmq9zwgsWt5CxIJGNb?=
 =?us-ascii?Q?o8z7+LSiyoFE0Ih6rkkAyemSXVD9IhH76xPw0Bw/O03rrtHBYd62T4IACGl+?=
 =?us-ascii?Q?4J6EWy1wtRJH7AJ3v4Edo0b5iG0CeO5U7+DIGMpVQgQx74lc8oZU0rUHEljZ?=
 =?us-ascii?Q?RKSZkvf6nEP/ENv3yiR9L3flzTFyZxWTTE1xf2lpepfP4STX6BrlBhQIf66z?=
 =?us-ascii?Q?Ns4IxcLanDGAQnDsfcEU1mA194XS5NmGh4o3AXAVTSuAeVbkxQIb9FK8C4Hx?=
 =?us-ascii?Q?Upm8uAtHDOyF6+VmWqUvKXvHEKuds4XjWs2xTUwIChKR2h6klm/XBoz8qDeI?=
 =?us-ascii?Q?oJVO46QVsykE8B5RlT9Bez2S6gTa1gFOePW/Ep0/fU6NKEAwOI1UuAnRckbH?=
 =?us-ascii?Q?8VyENV9zeW/NensiTarL5aYGKPV1AnCxE77O1yXq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de56d880-22c0-4993-49ca-08dbda0c299f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 12:23:17.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIkfnM9ZbzJC4U5UaZS8FbJm2O3ALg22mKRDvXXzeMlDK/KsMCSfz8z6+/dVx1gL1zf0KkfrgUibxI8EsDT9gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The firmware may export flags to indicate whether the clock
is allowed to set rate, set parent, enable/disable from the Agent.

If Agent is not allowed to enable/disable, directly return success.
If Agent is not allowed to set rate/parent, directly return -EACCES to
avoid SCMI RPC calls.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 drop the changes in clock.c, add an attribute entry in clock info which
 may be easy for extending new flag.

 SPEC still not have such support, this is for discussion

 drivers/firmware/arm_scmi/clock.c | 19 +++++++++++++++++++
 include/linux/scmi_protocol.h     |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 42b81c181d68..fad4329a21fc 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -46,6 +46,9 @@ struct scmi_msg_resp_clock_attributes {
 #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
 #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
 #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
+#define SCMI_CLOCK_SET_ENABLE_DENIED		BIT(15)
+#define SCMI_CLOCK_SET_RATE_DENIED		BIT(14)
+#define SCMI_CLOCK_SET_PARENT_DENIED		BIT(13)
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
 };
@@ -307,6 +310,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 		if (PROTOCOL_REV_MAJOR(version) >= 0x2)
 			latency = le32_to_cpu(attr->clock_enable_latency);
 		clk->enable_latency = latency ? : U32_MAX;
+		clk->attributes = attributes;
 	}
 
 	ph->xops->xfer_put(ph, t);
@@ -499,6 +503,10 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	if (clk->attributes & SCMI_CLOCK_SET_RATE_DENIED)
+		return -EACCES;
 
 	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
 	if (ret)
@@ -585,6 +593,9 @@ scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
 	if (parent_id >= clk->num_parents)
 		return -EINVAL;
 
+	if (clk->attributes & SCMI_CLOCK_SET_PARENT_DENIED)
+		return -EACCES;
+
 	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
 				      sizeof(*cfg), 0, &t);
 	if (ret)
@@ -668,6 +679,10 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			     bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	if (clk->attributes & SCMI_CLOCK_SET_ENABLE_DENIED)
+		return 0;
 
 	return ci->clock_config_set(ph, clk_id, CLK_STATE_ENABLE,
 				    NULL_OEM_TYPE, 0, atomic);
@@ -677,6 +692,10 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	if (clk->attributes & SCMI_CLOCK_SET_ENABLE_DENIED)
+		return 0;
 
 	return ci->clock_config_set(ph, clk_id, CLK_STATE_DISABLE,
 				    NULL_OEM_TYPE, 0, atomic);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f2f05fb42d28..ddf5363c8cfd 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -58,6 +58,7 @@ struct scmi_clock_info {
 			u64 step_size;
 		} range;
 	};
+	u32 attributes;
 	int num_parents;
 	u32 *parents;
 };
-- 
2.37.1

