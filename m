Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270ED76EC71
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbjHCOYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbjHCOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:24:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4171723;
        Thu,  3 Aug 2023 07:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go/pe3A2eOSw89Vyr9rznUjTVqnND0bA1br9eYyzQnVj9Nu6SASsx0rw5ZYrVf2mCTgOd0eMUeLBxNEvNTlcO+d1fclBMp3pm1nj5688+IK2S2GDVSrMNFnY+F0kqjPFytQlWqVmLzddPuRggVA3OVmzchKM8+EGbV8DsgXUjVVA3ODW/1PQt6DfptPCeWMr37G4YjVdn6jcEW3Ru1Wh0HtkID8LO7ZRkzrPtRF4dDoFfUWw/UoPIi4Sk7AV5x8jZ4ThVszrDR5FjDkXDvrWB8yEeZnxuOarWBVI5s+ifTZdAqmh7eOefUW3YLCcBKU1G9bSHpMTkERGrmbcdiydew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYUKjycrOZA1oK6RGVKNIWtENv6fhHV/hwmmpJ+ojUI=;
 b=gV8mIUE+raNhndl24VjJ+CdSuryIq4uvYIv59dFwH3yMV/YYM65nCHYlClgIrJaOwRZGUIegRvKyTXjbbKcRfZs2LxNDdYiYR3y4hvczSt8nYYpGCbl4EMGlhMVjgIufzwSt2FB85dl7YbASNXyNucLCNjqBaLgHOuZN+S7XqzOSq/fcH7KvzY7ludNldP0d06IFH0dnCzm7rGcrFqyHdkkA5rnrCs3wHeSnN6llOjmfUxWi1K4mQ6ybk538HHzvn7WGfPGiXE7nrxbQatanK04RPgGs5SPqJGnAKxkwdjeHE6OGs7KkdSq2vRjXDNhP9YHdC3B2ExBzZ87Rc4nTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYUKjycrOZA1oK6RGVKNIWtENv6fhHV/hwmmpJ+ojUI=;
 b=zQWDluwYHPhhI7XWNqWxYGaE5SGK5wSUpcNKGJcBn/7FsaFR9JRhF74jh+uGtJZGGtwQkPoeD1c2plPU3PFNEqbYNe1VFGdO9xkd81NEOFw1/jM7QbWZTa1YHBWKmjobXvzV625MIs8/i5uA9+hrSmNCfptp9b8TcekefzXhLBo=
Received: from CY5PR22CA0017.namprd22.prod.outlook.com (2603:10b6:930:16::18)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 14:24:24 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::53) by CY5PR22CA0017.outlook.office365.com
 (2603:10b6:930:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 14:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 14:24:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 09:24:23 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 3 Aug 2023 09:24:23 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] docs: Add book to process/kernel-docs.rst
Date:   Thu, 3 Aug 2023 09:24:17 -0500
Message-ID: <20230803142417.965313-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 247518a2-e826-459a-5303-08db942d5613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uWEX5JxR0ZVQAqtUDgEECl+KYsiOnpkDbQbtGrNZZ91Bcta7PnmSuVFEFt+CRqfYmLcoOtfSOrloPjV7w4WSqRjF/VeYSiDk8DIpS9pFBJHJhKGEWlTDuxqJZ8y6NgvCWX1xxuw6aHQC92Uz7uVIvyJcUCSTVSo5/HUXUgusbCTYQSNVkm8GMq+GC0x2wExsc61M4OXsnDy6utd+xL09z/7blE0rEWSH8LJk6ha0J0as1CHR9iipWT0LYzSuSZupmiTs7pGGEueBBJj4t9hVPc82dW+ED6t7JDQ8Z1DvvmY0NeoeWOjsb46CNhG/0nYogEH31rw3NPx82iUr+qCcU1kYISOiEQuu0bXpdbvl3CVHIrnnkzsLN1MU8f4Cv4GTE6hK94ZxHv3KgaExREaNkikcBxTtQo3HXg7Wh294BBLdAwiKAd9juiOXTImXqHGs8Xw4WIz8UPpiwC2S1I5MgLyOdtrF7+gGAplo7qDD5zrgUCqtV1UDGc6VMW76XHuYJjqGL5i5NzARoBo+mq6orm2X53ONlXXfLOZ4lkdcCFsyLGqSaL48jPC9+wA0ENkH30SfBO/zmBxYwBGQuDiWS7bRxwF1ov+gxI3AHlm665kfCFqDpJmdNLSjewVz3FhX6FW+5YLkdbIGujQYKlQ5A8fygvcxTgImt4W/tI84BCPMLR4Vx/6o2wVIXSvZhyHRtu1pG7z0KnDGaf+rhN0yQmi4peItkP2NV0NAUD3ZyP4+8DEUh607UornoCfq+mTJ6DM92fhVgfq9YGZtdTxFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(2906002)(4744005)(70586007)(70206006)(44832011)(5660300002)(8676002)(47076005)(36860700001)(83380400001)(41300700001)(40460700003)(8936002)(316002)(6916009)(4326008)(36756003)(54906003)(478600001)(40480700001)(6666004)(7696005)(86362001)(2616005)(426003)(356005)(81166007)(336012)(186003)(26005)(1076003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 14:24:24.0665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247518a2-e826-459a-5303-08db942d5613
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include to process/kernel-docs.rst a book on Linux system administration
published in May, 2023 (with ISBN 978-1098109035).

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/process/kernel-docs.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 46f927aae6eb..26ead9d31c01 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -118,6 +118,15 @@ Published books
       :ISBN: 978-0672329463
       :Notes: Foundational book
 
+    * Title: **Practical Linux System Administration: A Guide to Installation, Configuration, and Management, 1st Edition**
+
+      :Author: Kenneth Hess
+      :Publisher: O'Reilly Media
+      :Date: May, 2023
+      :Pages: 246
+      :ISBN: 978-1098109035
+      :Notes: System administration
+
 .. _ldd3_published:
 
     * Title: **Linux Device Drivers, 3rd Edition**
-- 
2.34.1

