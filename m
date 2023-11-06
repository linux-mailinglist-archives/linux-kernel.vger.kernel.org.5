Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1AC7E2895
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjKFPY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjKFPY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:24:56 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4774107;
        Mon,  6 Nov 2023 07:24:52 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=GYH9yqwl1KN2M/LVaO2uLzRS64ulLz9d9YkLyZB3ZzR8jHimBWH0SPoL/vMHG6Qjtf70dcQdKdLatZbhyIZj4kxwvOkkww7fnfJxArtrXhif7U3hxo7YfVvGsxu1u0XphGJt3aw0TkSq0lKXxlxWx5wQDK9NK1wyv79p3aSrumQ5PRLEOP+eSQjtcUEsCS3+mtRqvA46YGJQ+UVPRzdRT5lv3vC7lXlTl+RzccntDTxDbyrnywPzO03G4nfvb1KmFCPhZMoFwRIj7sBTshzShLQF9+4o1joP7kkyc2VB68g+WJbOtdrfrySURYWwpN7QoZrYdZ+HAPneM5ZjJ8asgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSS31mY8PaWHPjEgWzeL96CBmRwbr7366AiZWWs8RvQ=;
 b=RVCXwRKZI+32QDmpbc7Cr1+dSBzHeAdwFTLDycWfAnhcfZfA95Y9rcUa1Hhsno0yc3IVtoJvjhDfB4tiKo40rctfFApX0Wxmk/eQfn0PHJu9Av8A4uVc/YWbtNIVETiV1NmVT9BY9l74F0Df/B5WCgGO8F3xtpMkSHGlQipp99jWlq5cosTUV3mlldyE98urXEOlt6Wo3Mgva1X7oqawwI/TxSnDXwruwzIXm7fGD2Bz+g2/1BHC9LII20pQ24kNNDsvx96cRb+Gake3KQr6GRRq0yUJ+FeU1PFjoHVDvmpV9Pm62RiDHs6P0PBvtkjTU5ih/OmZl50NewQOHHclxg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.83) smtp.rcpttodomain=intel.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSS31mY8PaWHPjEgWzeL96CBmRwbr7366AiZWWs8RvQ=;
 b=JrarzBemgDNnxuwIHzdfEOzyvF/C++4hwTNfdU7i/HZcwC7WJS6+ovUBeY08GvG+18DhYVvaRUrRlP1+AumFKwKLwJc+r6K6Pe6XJPLwN8sYvjjBASj59sq1XbZ3sdvMyhQoTHGXeqp+ghQ3ct5vFyzoGhGpdzqILSP2CUtIwGADkkaQlonInrSHYvhZZf4pWSc0aWKXAnS77F0k4Zt0vth8W1r41/B27oX+dxQvG+Ws5qwn9RO28xI7bZW0IsFvywshVGd3+NC1j+9op6T9RAlE1hY0QkeOsiL3TXa9ghXZQpTk/x+Bpx5n0TYuoQpM7jprESjEcnEDCSNfqxJAJw==
Received: from DUZPR01CA0094.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::20) by AS8PR03MB7448.eurprd03.prod.outlook.com
 (2603:10a6:20b:293::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 15:24:50 +0000
Received: from DB8EUR05FT020.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:4bb:cafe::99) by DUZPR01CA0094.outlook.office365.com
 (2603:10a6:10:4bb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 15:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.83) by
 DB8EUR05FT020.mail.protection.outlook.com (10.233.238.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 15:24:49 +0000
Received: from outmta (unknown [192.168.82.135])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 669D0200813AB;
        Mon,  6 Nov 2023 15:24:49 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.105])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 227FA2008006F;
        Mon,  6 Nov 2023 15:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq0WwuDU+Wm0qKxC19fz+oxcYufBMIrryyeVNT1LusrysW7bFs+yHotd8zI43hD+SZ6oD5K7tBXlC5mVhBo1F/1e1CRdT229e16YGoZ74jtQGoyisQ6toC+U62FH1zK5fQ0MKHYOqyt5FNxgC3rRUZ5x10uUnMjg4kuIxqqQ7MIezm9qSZl9eeE+NyB3QmMTRH6b3T5MgiPvILY3ipFbbDyN0zPadNiHT09liEOxlGy/1sDxX/qoPZz3Oh1UDNiXYLAiBRQY/4X0QdlPofyC01m47Mmj4himlxXzH+ABLxvwSsa2rbpxySrzrRIpY1d6zhm5q3gVs0jKJw5+VHPITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSS31mY8PaWHPjEgWzeL96CBmRwbr7366AiZWWs8RvQ=;
 b=WGzNSKC2TkQzWRLh3Fw1ra6AHX7vAFwGJeA+Duo6EhCRRqDX9KsHRl547AvO2CVxI3kecC+7qH4l+vV845V7mRaFwjnTiOJxVnBPGVK2fvtcNVEF6JCslNIeN+o1W8Y2IvYXDuBmiNlbaNc3P8DvDgE5cN+GomLB7/n+Y7rrcwt+0b/SagY5pp5s06uD5yF1it8QaVfTz3/IFk7ibcv2Qk7GZpbSslNPcdqCyw5FdaEZo34mafiuIsy8KY7+nS6IJSyPnyqVefkKea342cI0gS5Dz9SX2sOcLfniTnAzibt7lYi65Soeq3YxvB8iNfSPYfxx8xK0IzOGqsJrbSrlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSS31mY8PaWHPjEgWzeL96CBmRwbr7366AiZWWs8RvQ=;
 b=JrarzBemgDNnxuwIHzdfEOzyvF/C++4hwTNfdU7i/HZcwC7WJS6+ovUBeY08GvG+18DhYVvaRUrRlP1+AumFKwKLwJc+r6K6Pe6XJPLwN8sYvjjBASj59sq1XbZ3sdvMyhQoTHGXeqp+ghQ3ct5vFyzoGhGpdzqILSP2CUtIwGADkkaQlonInrSHYvhZZf4pWSc0aWKXAnS77F0k4Zt0vth8W1r41/B27oX+dxQvG+Ws5qwn9RO28xI7bZW0IsFvywshVGd3+NC1j+9op6T9RAlE1hY0QkeOsiL3TXa9ghXZQpTk/x+Bpx5n0TYuoQpM7jprESjEcnEDCSNfqxJAJw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS8PR03MB8740.eurprd03.prod.outlook.com (2603:10a6:20b:53b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 15:24:45 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6176:6be7:d620:8a87]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6176:6be7:d620:8a87%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 15:24:45 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>,
        Sean Anderson <sean.anderson@seco.com>,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH] tty: serial: uartlite: Document uartlite_data in kernel-doc style
Date:   Mon,  6 Nov 2023 10:24:28 -0500
Message-Id: <20231106152428.3641883-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:208:238::21) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AS8PR03MB8740:EE_|DB8EUR05FT020:EE_|AS8PR03MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba5f409-d66e-4cc0-5856-08dbdedc8453
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LEi88wDm53QOvPfKiJtNSwrsQRvJizMvpja1Bd2EcSbNgHLmSbRlxJlh81gIFxLEyV1Vac5X0PSmxFA+cZEc/V5kwD51KEu6+ZhvjpV8b23gEaQF3fKLIOWlITk1mVuGGzr0ic6s1j3505lhNv87z+pIuxZVeOxKiu7kB+THVlUltv5t+94m4h23CKZOmqc8dzuTjLdKPZgeU4qcraQ9x3hl9WOWns5a+iMgBjANNw6SNh5nXOafgt4Sh6vFOfBi+yUVbAyOBqtqie+8FuLxdAW3zrDLmBKd7pcj5MF8hcKi+8pykIPyJSUUgGNQJAOKFRCA2hQP0/ZOdRhrTJyitJ1OszhqHdaMF7kb2E72/cqLK+21DPx8NRcU41kNLGVvWxOXSG8jKiiqNofkNWhGCceTJSXPyoeWnRKPJU0Mbkotv8FSWvJv7dj3H9neXNXhclQQwGKG09gHL7vfY0naDWBK4eprt/9jkSIUDb/3rst6a/QEyUNxtb1KFq+4xI4I9IqZ6TuC/nQMZgiliX5Vy5uVkIwO7lgGJ2D5Is2K+C99S3CDS3yf/BImHSieei3IwXxiaYMYdWjnExcCmdWebJj2CRMtzKY9fvln1Khibi0qEqTODcGC7BUN46nU6WeH
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39850400004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(52116002)(83380400001)(1076003)(6512007)(66946007)(110136005)(2616005)(26005)(478600001)(6506007)(8936002)(4326008)(8676002)(6486002)(66556008)(54906003)(66476007)(316002)(44832011)(6666004)(5660300002)(41300700001)(38100700002)(86362001)(2906002)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8740
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT020.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 482edb9a-99dc-47db-797c-08dbdedc8164
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmXlg3mvNbYQ2GU82BNu+jc4bUqd+rnn1W6gIYCU6wzuTl9bMMmAm8zdfjx31OWhVAP7CwYMrNN+v8RqkXDxXIq9aT/sn6nDykXs4mrrpYfsCW5CItmdCRB/pLAq6FMgAMlm5VeXs+p+o3N/XeySnipDibBuZFPbHHh6pmXvTljVAzugMCTCo7qZlDlZm6c01BDUrYaolQsFIs6lQkv/wkjlMiuF5jSBMlMH0OTzi2K1XyrSAQE2oGaq7a7pzoTGlT877qmzgLsRCEUzgvCg84/xVvb7d0rPY0zv4cdwpMz8n4LI6sKSkuCZAoYv91ZdJ8s5Nq1oaXnxxiexfiKYQWD7DasvtbtfcaV253HDR+xPR5kxQeEjjyv4BKzBbxQ1GUUT678iT1L0kcd1gaH1tbXZK5wnIAxEqIXC+75s0I+DWFqIHT1RuncSyxBfGP3o+YaMhVoH2uk7DmH4gFF+FZ2qrffZzxHxIsDimJw8plLe9sykpeV3wCTyIKmi73qbgqvSV47Ty+/WEZiXghrocCzUO39c47x2mLGMc/GnQSIGtg5nyV1aXk0/BQOxl1QmU6LnDFDtU3wd7sZVReK+3P1GNsYj2Tj+uIfdJM35m2RYZK9qbHk89zelJvtuUN/fTpKZTfCCx2B00vbBY13+NoUCz85fhfhXF7UTetU0bYF7IQ7csh4fdtx5j/+IubzPvCJ5J6gUqL5WFmwy4b2nWFNuNvz1PDmHH0ZCLCvcvYJ/YgCwmauUHEipRQA6K7qqOLLz7QvrSwuDh60j3AkESQ==
X-Forefront-Antispam-Report: CIP:20.160.56.83;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(396003)(346002)(376002)(136003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(41300700001)(2906002)(34070700002)(6486002)(6666004)(6512007)(6506007)(2616005)(478600001)(83380400001)(47076005)(336012)(26005)(1076003)(5660300002)(54906003)(110136005)(44832011)(8936002)(4326008)(70586007)(70206006)(8676002)(316002)(36860700001)(36756003)(7636003)(7596003)(82740400003)(356005)(86362001)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 15:24:49.6501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba5f409-d66e-4cc0-5856-08dbdedc8453
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.83];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT020.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7448
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use @ and - to conform with kernel-doc style.

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---
I have no idea what phase of release the kernel is in. If it is too
late/early in the cycle, please just review this at the appropriate
time. This patch is unlikely to need rebasing, and I am unlikely to
remember to send it later.

 drivers/tty/serial/uartlite.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 404c14acafa5..e586d7aeac98 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -62,11 +62,11 @@ static struct uart_port *console_port;
 #endif
 
 /**
- * struct uartlite_data: Driver private data
- * reg_ops: Functions to read/write registers
- * clk: Our parent clock, if present
- * baud: The baud rate configured when this device was synthesized
- * cflags: The cflags for parity and data bits
+ * struct uartlite_data - Driver private data
+ * @reg_ops: Functions to read/write registers
+ * @clk: Our parent clock, if present
+ * @baud: The baud rate configured when this device was synthesized
+ * @cflags: The cflags for parity and data bits
  */
 struct uartlite_data {
 	const struct uartlite_reg_ops *reg_ops;
-- 
2.35.1.1320.gc452695387.dirty

