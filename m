Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A815E779334
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbjHKPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbjHKPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:33:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7024D30D4;
        Fri, 11 Aug 2023 08:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJ/r1Tz28ZtSVnDzkwlKvZk0U/jd/3sQMVN0UFGElzdhLHqF4rEq+mz8AoOmYFhenjU+eiKmiRtUJz6ogLpeUth9Zvz3+j2naKZOMzjrEZp+1lx82EEtjL/SUMuI57RjbbW9vDuoSJMu4S3tH1n9xvnt6qlxBc7qfNqI41pAhCKiZku7FC6iuvmYODJGyZveqK6PD8ECb3VLk0lMqS/WjsewiksWEImE0G5jTJDT+7ZAPw8djU0Aqdgif6/xKnhshefamvhFdIjiqMkZmidRSEJm/Vu+xPM2pZZcOtQvkXEffaIkzGeEL8cCSz/UXJOt+ywj26FrfP+lW4nx9imGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PisJhXcoGjJx8OyCB0NiiyT05+2wYhkGGJik6iUv78=;
 b=PgfrMyFzQ+XMbs5ffjgERpE0N141IaDoRhMMVDlw4pTVmsWVW3rOaKN5/7XSMcV199Hdruvp/OShlJOjc0UzGBmffUcTzO0Y1FELGVnJW81j4DLdKt5SyABBySIQ+dKxFOwx2Rr7vHvE2se61d/RLaMQJpeNWOW1J1fWw8vlXnt4cI1ux9QqegWcoe/t7OQX/m6EwsbEq+gG/tN0DVGRyO9ARK0BaJkdIyMloy0yL7hHsMc4CXwhmlL1bZnMc8x0/7YqT6OIfXyg3W85S3sj4f5GHlcfYzvaCii/V9yB+W7njr0ZMojXMNSqC+RdZyAdlnNXSzcfCw+jrLywRdx83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PisJhXcoGjJx8OyCB0NiiyT05+2wYhkGGJik6iUv78=;
 b=YXszV8/aOKCPgSQ60BiKJpcBXIOvyQMHhWaVN6o34xHDFCdmm8kj9nD2e+b7aWli+7Wx1DcvJsTE2RaLjrfjd1PuYxhtSRZqcJfJ59W/wC4KX2meIgCcWYV+t+wvI3v15IGvHsjzN583toxOCnxXJ38Rs4rjbm2ifdiEW3nQmkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:33:43 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:33:43 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v1 1/5] net: macsec: declare macsec_pn_wrapped shim
Date:   Fri, 11 Aug 2023 18:32:45 +0300
Message-Id: <20230811153249.283984-2-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::11) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PR3PR04MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca6bc26-0eff-4398-26c0-08db9a80588a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zz/WCplpijS+v8YcTeeIIwxyf5PwhPpfGUyzgF4rWBctpkVaUYudyKTVrgGh0N/9YSXqfAe6xCKt4fFcsWIAzuSBZLD8eK7ItBbIsOp+170YZjwHYjzC10bKT5Ga9ygzol13CdQHYGJ95sSJbPi8ss7/1lWv74vNSxYp8MEsmkk4XqRbcIUXxOqImTCk/WMKktWbOXTuCuyvwJyp94fo4XQX5y3j+lTHNVDVX4KKT+XBgR37CNk1wYrsdQVZ5RrKk0RYcvShWQPc6QqDXvYWMh8xa1f77rJ0qF3i0yaL7Daz/VzWm7JUuK/nic8fDkzKhoQbS7nfEFmCOoJ/BSBk+Z0V1THXlz4rgJFsS4sAqXlEzOmmL7HklVwCZNd3sOHzPEuqSY3CPZ/4rLSgQheFo8endaIUeeEUDymO03mK3o34N4UJZ7Aep7l9OoMqTLXuep0X/v9XEyZTBYTgQqVbBcBehatWgkTNjyKc2XnTrNCS4hz6fdXhwYa+gdu147b8K0u8GE3gk8oq9QKxc606upZFg7ds0c9Bq8gTnyDbfB8Q8TzDdMk/jZ1vgus1QHSHCXzHgteVP/SGKj8ISs2uGYbXwstZmzHmm8DHfWlWCxES/r63ZxOvsDQk9xcc7Uuy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(186006)(451199021)(1800799006)(2906002)(6486002)(52116002)(38100700002)(2616005)(6512007)(26005)(1076003)(38350700002)(6506007)(478600001)(316002)(4326008)(66946007)(41300700001)(8676002)(8936002)(5660300002)(66556008)(4744005)(66476007)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ANzooI2K6kB7ypb8RrNxVp+uuTM5Jm8iw9wlT9f+Qjsx/yb3JgdKl9PqxQSN?=
 =?us-ascii?Q?pvmNhcPbYPYjQh3e3A4+3eRf9+MAzdPotx8eW26cLfrc9VqPxVuS0nid3AU6?=
 =?us-ascii?Q?WK6GDdAUcgv874wSn5CmRMBWMNbMR3eUgwcZRXtRisZXZ3Woa5w509t09X8n?=
 =?us-ascii?Q?akFFOhXebXB25jkI0w070/Imene2J8oPR78gBRC+o9v5GOkGjDPQx2RtLeMV?=
 =?us-ascii?Q?pwRHtPBrNROQTcnWRNsRX+Er5uZJrLLeBG1Rmxvjc7kHktEtoYjnzX5d9f60?=
 =?us-ascii?Q?tzY2XF7hdNip5BB5+p/WGgNbXX33Pd7zsglzmsf4ehUqDWlFkoz+w3bNZQmq?=
 =?us-ascii?Q?s/6+idu/9xsIH1FII3d9y9zcJD0ZYt0WZUEm7Ys7DaQ6rHRhIvxxTOEjBhMf?=
 =?us-ascii?Q?wBqb7m0gv+htYED/Ra0lggq2C1yQq3+0OKHi/sdfTIn/PK4T2SorlQXsVXa8?=
 =?us-ascii?Q?T3bMKg5Mc1pRExmoWYNTsj+pJ3aQy8No10xcMIoDgA5Wy8wF+WtUqPPjl8CB?=
 =?us-ascii?Q?pkA+amfckSNg7yUKsNgi0o8GBcTq4YxBKGPlp5pFPVlRG3cHul7Yqp27BIKf?=
 =?us-ascii?Q?pdb6EGii3zCWxhvl5hjMJyADldxRHbDZPuClkR6sWaNofUlAmDr5QX9zbXdF?=
 =?us-ascii?Q?zCzkZsaHtkIZ4BM0dKZ21wnyWZJ9Y1ia1w3txyGCqugxqQEKP3aDiBURoxcs?=
 =?us-ascii?Q?LQum0vjcvp+gwvmZH96JSYSFXdnbr+KK2sQ9vzb1cpWl+/Yfbg6kuILAyd8P?=
 =?us-ascii?Q?fRS9821vYsljQ6wwO6NDNfiIqpPWQ6PCOL4tC2FOVcVwFMxZkWCnlXy/nWwc?=
 =?us-ascii?Q?A8SENKp0Wiwyt/XndI7Osdsh1BD6WAeJwoRlMuQJpJUnOSV4l+ZKTmYCyU9w?=
 =?us-ascii?Q?lCytjNc8fvgj+YWDm1Djbv0/4j0NB52khf1C5j0zTj33T2sB8hKAyMpaoWHj?=
 =?us-ascii?Q?CeSCW+ZvmvtviFfVcgb8Twa2QTlJ6O02/bcXom2lC188BKCf8/w3d7QEtcJe?=
 =?us-ascii?Q?oIng4QMomVwv9XZc54WUX2usGS8Yw2P8+mVXHRWSJWvarspCTNw3EPVNG/x5?=
 =?us-ascii?Q?QMZkPdlqB953wAQrnDG8K+YSQrpzGFF08Iy4PImupTIKNuKN/e8T3NETZFbf?=
 =?us-ascii?Q?fISnIDbbyrPFL0Bt6zqjxgAd5b5joUeWwxpjuDPYGXERb92ffdVYKDgX/GZ9?=
 =?us-ascii?Q?OknZs6hJJJwiJPLeLfRhKwhKF4v7svSBxlnbOtVpVOs/HlkXjQWPGwQD5Ctu?=
 =?us-ascii?Q?TVVzsEZO7CSx4tgvuffiM5N3nWlklvnRQ1b5ZNKqiRk0mfqcNBgxuUW8jgD1?=
 =?us-ascii?Q?L+57k0cto0mLcR1N+cRCD4IT31XRhuaPYz4Zl44LX3qdSfZYCWFtphe31/7L?=
 =?us-ascii?Q?U1O68BYOXEWjehsiOpkeJVr63i0ERl2BdCB/Rg+W/Vuv6/ai1oPzpNRKqk3K?=
 =?us-ascii?Q?Dm96yesk8ZeejdT3C96JY6pvmCFSRfBjy2AmfVhK4egiaQ63x4xl2q8KsXrw?=
 =?us-ascii?Q?b2XUO2ndlFIJgiP8SxeWE8Mib31mZ8uxsU7IuJ5Hy0NNoB/xUKIrS47BRjss?=
 =?us-ascii?Q?f0GyM7XBmW+Yhbiyyv//G8zae/igTCsRGARA0Lk0wHKuK0NJtzG+HYBUKknP?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca6bc26-0eff-4398-26c0-08db9a80588a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:33:43.6806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DwQCG6bUApFOf2bVwBSnqClHaQVxtpo2z45suKIc5Je7+mQDJ21MzrlDB/rQ7BzV7F0fi8f6+slojvcn5+uGy9QifpRFfuQboAxOgIJmzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare macsec_pn_wrapped shim if CONFIG_MACSEC=N to allow the drivers
to build the macsec support.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 include/net/macsec.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index 441ed8fd4b5f..33dc7f2aa42e 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -304,7 +304,14 @@ struct macsec_ops {
 	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
 };
 
+#if IS_ENABLED(CONFIG_MACSEC)
 void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
+#else
+static inline void macsec_pn_wrapped(struct macsec_secy *secy,
+				     struct macsec_tx_sa *tx_sa)
+{
+}
+#endif
 static inline bool macsec_send_sci(const struct macsec_secy *secy)
 {
 	const struct macsec_tx_sc *tx_sc = &secy->tx_sc;
-- 
2.34.1

