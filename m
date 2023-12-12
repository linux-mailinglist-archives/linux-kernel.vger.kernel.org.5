Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0183C80EA79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjLLLhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:37:39 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9F6DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:37:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikk+4qgHnSE5NFeIRBKWtSA2F3SPqC3DCO4YfQ/RugE+w98RgX98p3zNcglOi0wkIkWGYH7EGxHrFfXOiGbiBIZ0wF8K3MoJJrenf1+aXyHwMQr213dio9tYQDYQ8Dgw5Mu189bJ61sJGN/842Irdm+BxS48k60uGdZYyDIGkAPPFzwJ773I+fKv1TY1mok6PMyeG0DY7uORQsF8CyenIw+FR2btzEZRQDVzJj+J2qme1cDqVFCjukTJeMuYYcKiFjJ5+YDHHgxJNF8uzwdZccaXqHd7VmPiGKvfzJSuaNkmCp5n4yC1/9FNHqIlLqdpQIBxVJHAWT2zYkopI/4Bbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQbPR4++yZ7P9seKiQYz3XRL8Gl8T+wn4M88VUATaMY=;
 b=NloUatD3LbJjULnpph+yKDVo5Mmn+HvZ0TmQaSbrxYq+a/ifmTuEtfUD+tO4/BOJ1VDGVEiPtvDeiwSz9CycaUG3+Yd0czQBI0hZynmpMZCDpwJ0ribCFTmzAjZqjtFKDbkc8R+/6HKjKwoFSQiFPeumn9LUWiOMouaztZndBxEpTp2Aso3BROzCtGS1TVRvDEvv1mDsrRad49AF4YlQqY14tm/7deyZl/ECiDF53bp+dk0sP4UyrwyLuGjIQ7rPyDxhgC6Dfe7haR+x9jnov0EYiFifUDl8uuQsU21mRRjwDYwzJZObSvUx/SO6DwQUXdBroHPOhBNog5rFdm31sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQbPR4++yZ7P9seKiQYz3XRL8Gl8T+wn4M88VUATaMY=;
 b=P4LJliPrmfIyU/O9bWGxlUl6AdETglTD7LsLvOXLfIReoD2RIhs1Jtk9fWPviVi4WJXogN3CFiE4jlPl8TfHFyHGFRF05o4qWHn2XcCtuRhiON0QGoT0zvZTopvJZx+gC02KMeWPZEfJsz+1hX6eVc4SDcrQxWLi18j9Wt843vUe6+gVCIzA1KOIIGhEt8lnx0ENgq6IjPcnUkuKhoBylMKTPt/1QxDRJc2iQpg9brznlbCgPi79FvtSjMqqEurBh+FaLMW369zXx6J7mEny5uQw1ZJMIRj9u5P5EC0G7PnJuT3fvSu9P0cP+Enc74izTCknil84IM5dm7WPVS+M4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PS2PR06MB3432.apcprd06.prod.outlook.com (2603:1096:300:62::16)
 by SG2PR06MB5153.apcprd06.prod.outlook.com (2603:1096:4:1cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 11:37:39 +0000
Received: from PS2PR06MB3432.apcprd06.prod.outlook.com
 ([fe80::4cfd:404c:53bd:16ad]) by PS2PR06MB3432.apcprd06.prod.outlook.com
 ([fe80::4cfd:404c:53bd:16ad%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:37:39 +0000
From:   "xiaowu.ding" <xiaowu.ding@jaguarmicro.com>
To:     viresh.kumar@linaro.org, Tushar.Khandelwal@arm.com,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org
Cc:     xiaowu.ding@jaguarmicro.com
Subject: [PATCH v2] mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt
Date:   Tue, 12 Dec 2023 19:37:22 +0800
Message-Id: <20231212113722.863-1-xiaowu.ding@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To PS2PR06MB3432.apcprd06.prod.outlook.com
 (2603:1096:300:62::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS2PR06MB3432:EE_|SG2PR06MB5153:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2b3a92-2365-4820-0caf-08dbfb06beaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHP6+tNdRu9gykyzUl0jF3PCAY7hcYDjn6Mz9z9Cq1CYfuzrcTTl/AsG4MUxBNCMwk/uWIJ7PetSytxRrIjH8DpX3RjuG7sfj+vERcOHBabduabu060+N/w56xrJfMDUJ/R7GkzstPkEcqwbnnLlH5Auns+tFvx8GKZWVr9fG+uyS2zWbfwsHmRkORfQJMnN3nxK+3GQ0eIpC1wkQny7siXWMrGjph1QPOuUVCyIsl3e/3qomM9Ds3LHjs92wXqbR/TGr1b98WiMTn9IYr32DuWueLlP6OLmcifTs2kPRugJlJsqhdK9S14zrJjBmFXVzTlciS1Za6cgF7p2IZuwepBniyQyhd+HIVtJltWvmwo3D9CQUT0cJTc2iQjXfpJ0a3b3dZCNSzJJpw+qNdk5evYaKXKEgPyOieUrmEi+5TEVJDYPJEg2nAx1QfvdrT52dFAPnj3a6dyLz3/dLCKDXJXlYYY35w3ErjcfaSMfbifGTJxQSwFBGWrDBJWLX1xzYk8gmr8SfFgnixC407pv+6uy2LIvzUquaXJf0W5wfKZbrsk5QQqdZwVySi5LtLJIQAwg04pIv1cUpc85lLl8sfXCC24Xqj6m8VRX1x4oEPgQl7IpsGkqgwhuhrPyRgS0HE30bcLP57c0RlMOGmkDyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3432.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(1076003)(2616005)(26005)(107886003)(6506007)(6512007)(6666004)(52116002)(83380400001)(5660300002)(15650500001)(8676002)(66556008)(41300700001)(4326008)(478600001)(2906002)(6486002)(316002)(8936002)(66946007)(66476007)(86362001)(38100700002)(36756003)(38350700005)(449214003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pLpRB68CdR/iZRphyEoFpj1IehlY+ZTXZkkphfmFiBx11kLCLkTpsnA9uio?=
 =?us-ascii?Q?PiCqY0kGjkztqR7MOtTa6712Wmu1NWb58xUUMoQxEkXOqs0MbYy+QdiXFowB?=
 =?us-ascii?Q?0Be6gM0wq/1bB/Mc4mV1EP6fyfgh4LaLDUfffdGrA4L+oxqsyaSqtOI0Nytd?=
 =?us-ascii?Q?pkr3ZekK58cnG6R6HJs33rR1phLbnt2SnXquXtcg61qUnREAmpfnG3NRYfF9?=
 =?us-ascii?Q?9gjMRODChNvItOdrADUk1xBIE8722I62Pp6I6tnQ2ws3XZjYwO1WNbBjFORc?=
 =?us-ascii?Q?eyPP3HhFbl4aMFeH5xN8aBgKmOVW+dRq6nHYPdC2mEjfW8ozJ6YJMIDOWt+V?=
 =?us-ascii?Q?oq6R0AXCVn70tVATbxrilAovfta3t+UlzN/tQ4x4YItUdS8Ib4jqddRlbKQA?=
 =?us-ascii?Q?/Aa/IE1Ehwgn427gNMOnQBslwbM2tyFq1fki9zmiRHi4IPVRZjmADwM7WrtJ?=
 =?us-ascii?Q?M1ECKRTpHs0Lvh6iI7/iVL/Sfi/kkq4zMThz72XDhjP0orcVQJQvByVNtMJV?=
 =?us-ascii?Q?g85A/jMs/lbiC/XFX0YxgDIEWaja9ftfaAP5VvXgOTuFgVC1BBiM/T2ITEgO?=
 =?us-ascii?Q?KVlRlfNHKBwPYyNIFiIp/vCNJ/yXIp/qcupwBWw9HZSHuE9I89zY+LScoEep?=
 =?us-ascii?Q?d0nBc1PPX0lcFxLS6dkIYfUQ5LKgViC8akqZ4ZJWyERI1UAtumJK9DFs3Sp5?=
 =?us-ascii?Q?Wvx/cjjL/+fTxtYgKY2oIgaC6u2mWT+IiPbETUhsAYwU36KGzZsI9DNSu96p?=
 =?us-ascii?Q?du47TyYRk1FDNSZf6lpyA1tNDZkT0l5xS5iVa5ug1Pxgl1t1lrZ9hPwcstK6?=
 =?us-ascii?Q?QxSeEezobT52hFXaisJSqj/rgXULdpz0ICABW3AqePKGLBpacdpAezC7q+vs?=
 =?us-ascii?Q?BBHQewieyXlOc6UUB+Hbn+24IsT0rT/mrexgqBbZOWUeyQ2n3PKKYgOCELYA?=
 =?us-ascii?Q?ywLEzntiCoxfGmyBrncfF4gUpWeIuFv9TjQih3/gnwn7Zl+lFUYbG1Paneao?=
 =?us-ascii?Q?avgjdDCdMRgi2yUPTrW/amLuGQxVPr4MahqmzTrAQGL4Th8NnUE7hTRV/5Ze?=
 =?us-ascii?Q?2ycs0XR5cdDY+ye6DjeLgfX6fQ7UhuG/7si3pXh4sZ1r0AWcUdnuXW3Y+Ob4?=
 =?us-ascii?Q?I/MT1thuVyagWRDYB+58+d0o/0IZhWtrW/Szyh5gaZS7NI9EAGrWLrc4k9NV?=
 =?us-ascii?Q?rxqb2XOpONgqAzVYc3YVNM584Hv3DgsSrfGsDnddBdVgr1Sqq42dQ23OLXOP?=
 =?us-ascii?Q?ln98GfPYwTh2u1cQdlTkdONaJ7wommv+LQ8CLSPhX1h8/vpRJDJKmbHgHLKR?=
 =?us-ascii?Q?qYbZrpm7+aZNk2o/J21wRfgP9qZluPGtdWUv8LIx06otkNRw9dFOq1T5iRxL?=
 =?us-ascii?Q?Mo1wrvomc2B7w7tzW3BbG0yR2sYNwzA3MzFAcIiCledZ302frbnIGEjAWZR4?=
 =?us-ascii?Q?zA8kVoMe0ms/TZcXTNMqxgE/q0J5BHboKTtvPXdVo6dshIVVqLvrHZMT4O/0?=
 =?us-ascii?Q?/+SJkbRW8GWYR8bZSDma07Fq+i5ArikSQFlzxagqgf4k3VietL9TWiFU0jxQ?=
 =?us-ascii?Q?wnzZm5+AGDnD6508CSjxT9emQOA1APO9UCH9LNZZ+rurgpSQYn927nRMBpdP?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2b3a92-2365-4820-0caf-08dbfb06beaf
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3432.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:37:39.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9oYlI9Doz8Ov75tb9ZMQLHAPWHxv6HGTaZL3aWsFiAMAvMGasctP14hnq/qy6oUQ42OXd9+ddKngX7W8AcYjBPcpj8oWHJjMnTksVqCT+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5153
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Xiaowu.ding" <xiaowu.ding@jaguarmicro.com>

Message Handling Unit version is v2.1.

When arm_mhuv2 working with the data protocol transfer mode.
We have split one mhu into two channels, and every channel
include four channel windows, the two channels share
one gic spi interrupt.

There is a problem with the sending scenario.

The first channel will take up 0-3 channel windows, and the second
channel take up 4-7 channel windows. When the first channel send the
data, and the receiver will clear all the four channels status.
Although we only enabled the interrupt on the last channel window with
register CH_INT_EN,the register CHCOMB_INT_ST0 will be 0xf, not be 0x8.
Currently we just clear the last channel windows int status with the
data proctol mode.So after that,the CHCOMB_INT_ST0 status will be 0x7,
not be the 0x0.

Then the second channel send the data, the receiver read the
data, clear all the four channel windows status, trigger the sender
interrupt. But currently the CHCOMB_INT_ST0 register will be 0xf7,
get_irq_chan_comb function will always return the first channel.

So this patch clear all channel windows int status to avoid this interrupt
confusion.

Signed-off-by: Xiaowu.ding <xiaowu.ding@jaguarmicro.com>
---
 drivers/mailbox/arm_mhuv2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index c1ef5016f..15021c90c 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -553,7 +553,8 @@ static irqreturn_t mhuv2_sender_interrupt(int irq, void *data)
 	priv = chan->con_priv;
 
 	if (!IS_PROTOCOL_DOORBELL(priv)) {
-		writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + priv->windows - 1].int_clr);
+		for (i = 0; i < priv->windows; i++)
+			writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + i].int_clr);
 
 		if (chan->cl) {
 			mbox_chan_txdone(chan, 0);
-- 
2.34.1

