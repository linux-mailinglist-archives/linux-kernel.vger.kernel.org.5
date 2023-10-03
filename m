Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B8E7B6B68
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbjJCOZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjJCOZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:25:35 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE65AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQs2u2n5dKUIIzWML6Yoo4hP1sc+lfg45hsNKrwZ1/xcZLYusGRxpnKK8z5XueBcx4lNQTaNPOTx+slPtYEDvjjmSD1iY7G1wHxGucCUw3XBzwHXy/sltJKETOOwgOa1/1U/Qj/FshvAvoLqLWYUB58/4TXHZUhVlPIhZDghvXP0R/QzAKlsKM3LEvyAf8hcngX0VzfgrjhPGVGl8zqRNU+xY3RpnwLaklque6YgEEs22k8pjGpQn1FXgqX2T81VA8dmo+whVafPVGDxJR57TcuGQmRgN7c6+T+8mrJfh5OXqYymWHjWtCPiq2S2EdUtXj6dfntHrNppIVRUukBlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zTCmGGyr1h/g16CixRFqpMl0ejUnIac9z6XyfTFKh8=;
 b=a3d/bYrGPkRpBvVWiJdYaWet2b3KuA88plzFxlmClLf3dj6yz0RzxQ3B2keeEBsXk/Tgf50nlC4gy/fnVZJHLVfFGAItpCr9vLGcrzA3ix5KnPhi7V+UeA3vf3W6ADKSe46pNvwc+Wukt+el42UYlPNCdNjCBK29mAqweL2kEUhqU6aiFphBf6hrhYA95druOp7SbM8og8VfG382hMM1DA/pb8npX1YkL9RVtwtlGJnYsZ8KgRK6ovee3bgUYXM+2KoA2A+tHYmYukRwPzGxId9FBlpM03BqPpFzugZLZFja6PY42EI78jH19E5sMse3gC9XxG6/N3HWVmDhU/kMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=imag.fr smtp.mailfrom=axis.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zTCmGGyr1h/g16CixRFqpMl0ejUnIac9z6XyfTFKh8=;
 b=JB0AUPsK7iUSMji+wFJXfIszAv+FzXF6fpUM/uMRGM6hFXhppZ+KqkdoRKBg8nuHFw3QFkECU9SFlUO7qsgeHuHr8IGEvPy609Lp44rr9JLz70bwD1HGvLmLWNbyRGwQJnFmwEWlI2OOIkMrmTi1Sp3TYFo6gl4FyQLU98441Do=
Received: from AS9P194CA0012.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::31)
 by VI1PR02MB6381.eurprd02.prod.outlook.com (2603:10a6:800:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 14:25:26 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:46d:cafe::e5) by AS9P194CA0012.outlook.office365.com
 (2603:10a6:20b:46d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 14:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 14:25:25 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 16:25:25 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 16:25:25 +0200
Received: from pc46047-2141.se.axis.com (pc46047-2141.se.axis.com [10.88.90.3])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 750342884;
        Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
Received: by pc46047-2141.se.axis.com (Postfix, from userid 10867)
        id 6FADE47A708B; Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
From:   Anton Eliasson <anton.eliasson@axis.com>
Date:   Tue, 3 Oct 2023 16:25:14 +0200
Subject: [PATCH 1/2] scripts: coccicheck: Return error from run_cmd_parmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231003-coccicheck-v1-1-07d2d900a52a@axis.com>
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
In-Reply-To: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
CC:     <cocci@inria.fr>, <linux-kernel@vger.kernel.org>,
        Anton Eliasson <anton.eliasson@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000043:EE_|VI1PR02MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: e91fec47-13b0-4bb5-bc56-08dbc41c9611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSYgUphrw0M3UdlnEtYzurZqGBgNVdDrQL2mFevrfVFpLMRx+nJp5vEn+EBJKmsW9xo5WFMR+Rn8P1aKdcqXxZO4mCfa4C/qhip/OkZvjUyNSOinOxJSzbeLIQME0VGQhBObn1jxYJ7qMNAQT2mzrniwHnpRpOH6sMjmnY4en8vUTza0TPJT+DLFanvny3jd6n3u9UEdu2NBmU6W4OObC8A5kRjlS/vQd1Xq45zny9khR9rsLoHIspcFynC7qwRUspMv8KVE1sjBS1tfi/jlKn/mRSJQjqESxBY/hW/s8Qz9G75K3ktsUt6dy3tMdsiIqZsR3RdDABDE0gEUDPXq7jPr+g+QKuV5MVlld3CbycDBsZQ21ExK7FTINbIlTi7HLrRpOyMG/jcwpUQLBO5CqCqIeSR2hWI/fonGdPfcpUgK3ihONPldBjQVMw7SfVl26Vf7b4LdLtC9zNjhUxG7NoRwe18VasSbuOq+7pDsoYF+Dg975I/yzE+kjGflUKK78U+oz82vDwK2SMQxOqYZLZZgCorVbhdj4sWYJ4IhMySnD9LOgyDAt7K25wOJiZPq8xSH7fKG2Zu6bD7TcQ/M28WRnCDKJgIfHNaoFS9v2IBlBJVi2oJlKYwGQmJ8FMHgRFI5DHtjjwQeRkDJm5eJPQo+VbB4+ujkoMUljMh/bI2H4ACqI0vu8LYgiCNI0EZUJf2d1xgwxncKWGTy2V5xnEsxyTGNF7QpX70oeOcj/UffrY4g63kJAymWcJgSP46jc+9j2d1+qG4zETp4RZjnTQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39850400004)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(41300700001)(107886003)(110136005)(2616005)(316002)(70206006)(54906003)(42186006)(70586007)(44832011)(8676002)(4326008)(26005)(5660300002)(8936002)(6666004)(478600001)(336012)(6266002)(426003)(40460700003)(4744005)(2906002)(83380400001)(47076005)(40480700001)(36756003)(81166007)(356005)(36860700001)(82740400003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:25:25.8617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91fec47-13b0-4bb5-bc56-08dbc41c9611
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6381
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exiting on error breaks the chain mode. Return the error instead in
order for the caller to propagate it or in the case of chain, try the
next mode.

Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e52cb43fede6..95a312730e98 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -153,7 +153,7 @@ run_cmd_parmap() {
 	err=$?
 	if [[ $err -ne 0 ]]; then
 		echo "coccicheck failed"
-		exit $err
+		return $err
 	fi
 }
 

-- 
2.30.2

