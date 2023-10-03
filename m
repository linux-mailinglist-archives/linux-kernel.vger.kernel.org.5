Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0937B6B69
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbjJCOZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbjJCOZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:25:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3EEA3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5l1qg69O+JO0PKgR/rU0LmnKO66ZuGcPijDt/YrIW+OMBP0YTXnowwAElHG9RWQwrIbkBP6fVQ5x1khXQBXark67MHkfT3UHIlveIOx7PGVgiuGpnbmvvELacNPFOWz3EmuJEAsIm1AOrvF+z0vh53cpv41WLStoCdHFg3HBc9Ggr5si6+2q+xyqVgQ9Fp3mvcj66NejJ6HCr9xiHx4dsCCOEU7Nq66N283XnznRk7edAVpCbyXPH4K32Q9VlmabpiBam31Q8M+Is5tiOfyPT8Tm6uX/+sujiAmcK1ijhThwXcW+LEVln4Ow8sIqanEefI145WpB0+IKlFt+7sW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEIddT3DE1CnlRRHb52e8dOQqb77tH9rp+AFVrYnw4E=;
 b=VsRNq7INHMsyiI4smRAikgDKN+VMMQodXaCvPSzyesuV6OIFWeCP3lDHd5TtxJd4L40mDE0QHMo1fnjbVooRVBtHZuYbDPpWeyIGm5RHrjqO43GnJ6jiJri0bsR46KHcus+KTcyeMuhwaxauj72ZMWh6MSGK0Mz4Q2bajrOHC1ffVR2BGBnuB/7oToqcaaoLfW1SYOAfbcBQ74n4mLE198XF8iW0C3v/UoVVGU/KzJxgsuf5pNccGZFKGJL7Mf7q7IS6v+zMgLNNN8twQ6Mi5GFXl819HaSotGeGDdVF36P53oyAn4Tbmnjav0gmi4tGOH4G0lSLAhl71AC+STrfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=imag.fr smtp.mailfrom=axis.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEIddT3DE1CnlRRHb52e8dOQqb77tH9rp+AFVrYnw4E=;
 b=aYoIOBPsP6McV2jj+Q0AKsostcVfbo0VzLISHm6qYspjJW1WHaRFZnZfEfeeX4O5aQUM2DX+DB1Y7KHLmulq8umh9HtE72xoJ7VVValpNNZJMVnX3g320N4ua8PPOgdfvONNY5dAz1hORys6GacKhwEtlQAdbf0O7EvjptA8gd0=
Received: from AM6P192CA0052.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::29)
 by DB9PR02MB6618.eurprd02.prod.outlook.com (2603:10a6:10:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 14:25:26 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:209:82:cafe::30) by AM6P192CA0052.outlook.office365.com
 (2603:10a6:209:82::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 14:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 14:25:26 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 16:25:25 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 16:25:25 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 16:25:25 +0200
Received: from pc46047-2141.se.axis.com (pc46047-2141.se.axis.com [10.88.90.3])
        by se-intmail02x.se.axis.com (Postfix) with ESMTP id 752682B8E;
        Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
Received: by pc46047-2141.se.axis.com (Postfix, from userid 10867)
        id 71B7647A708D; Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
From:   Anton Eliasson <anton.eliasson@axis.com>
Date:   Tue, 3 Oct 2023 16:25:15 +0200
Subject: [PATCH 2/2] scripts: coccicheck: Separate spatch stdout and stderr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
In-Reply-To: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
CC:     <cocci@inria.fr>, <linux-kernel@vger.kernel.org>,
        Anton Eliasson <anton.eliasson@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|DB9PR02MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afa44d5-5b73-4d3b-a640-08dbc41c9628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eetiQ5IzrZLURNzSo5G0Kr2iX5+G263rUnTCLldQCaNRLUovi19I9yK5TI8D3/xd3r8uev6bQHEwvbDEfOpDXBYDvheLvSx2pWAM3PTX0TaxheuwYUUIRBWX9mweKsCkO1BBEpUcaiJLc5dPiJ+m+9B7NB/xgpjcmQfY0lDRuPl9ch8ywAAD59Sf0gfvUSxEAU2sMQMF0fK9PyZ6oL9vZ8Hdk0Eq+3vZ4H46fab7ggKF4/trH1Qj2Kc9a49F56FtqlGpQcU8AcDnMlD6iHLtdktH3Nzjk6ShqkajvZHWRGjsyb8TqY2eaMtAXNpCxGtW4WnuLJB93HlCVBACobIzR0xsUQdgHxJxY4LC0GMvB31pE/dRu7LbVIkc95TKyB3JrOhNyifJPs1wSLhbDBOr22XQFqkn3ltoGxOxVmb0C4eJDYnVJFRAywthiLM20JRDmt85hogQnoWxJZx+rehAWXPCSUH2IdFogFn/8eMCp/9UjiPKU5keCoE/qcEOY6JvBn6lvVbZ2e0TpQJc5EIgmHcqCfmp6KOaeOoklGjh8Rle2aREffMPtS1PlpnIMth6M182SIsbAAKsOfcB3RpAsftIDf/Sffri4TGDS5eapPZBOOvFUaEQ+j9uJeOwxyKRUwpG3EmIP9Uzw6GSL3dJS28g0JdKjn15FiYj2XcKo7KAuXuANY03mwCWNVdhTn6sc//oKbn8J9y/2+RQG89v4bYgJ+pMmkIy1NbDROassB33SCmm9L9cUhHsqFFfIzBuhqAPSpIowT6kAoNpVHytrQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(36756003)(2906002)(86362001)(4744005)(82740400003)(40460700003)(6266002)(356005)(47076005)(40480700001)(83380400001)(6666004)(478600001)(81166007)(107886003)(41300700001)(8936002)(8676002)(2616005)(4326008)(5660300002)(426003)(44832011)(26005)(42186006)(54906003)(70586007)(336012)(110136005)(70206006)(316002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:25:26.0119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afa44d5-5b73-4d3b-a640-08dbc41c9628
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6618
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps automating coccicheck runs by discarding stderr and only
looking at the output of stdout. In report mode the only remaining
output on stdout is the initial "Please check for false positives"
message followed by each spatch warning found.

Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
---
 scripts/coccicheck | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 95a312730e98..7e7c44125f47 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -146,8 +146,8 @@ run_cmd_parmap() {
                 echo $@>>$DEBUG_FILE
                 $@ 2>>$DEBUG_FILE
         else
-                echo $@
-                $@ 2>&1
+                echo $@ >&2
+                $@
 	fi
 
 	err=$?

-- 
2.30.2

