Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3862B797C3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344327AbjIGStg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbjIGSte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:49:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4384991;
        Thu,  7 Sep 2023 11:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzwNX6aDthdcI0BSRHJkT4hSUYsp169wRDLLe3IPJb1x27TBqqYhvE+y/dFy5jGadaEVthZCQrF50tBqol+YjsGfxRMJ2SUljRmDpoFvX0ftdwfxZgTO3Ad56Uq5mGAM0jOo9iqW8LEMdI0pme9TD2x8FglHTNm92VyU1w8XDKd/7j6908XlPiRagzZPJwbSBlRWhhKl8R5C23J15sFm2vyROYEkv8MqQ7J9Ltb3qbqxl9E75WXGeNmToKbDh9EBh6TJePviD1CqpmifAleLdO44MEuVM70AXC4QieQJEuKxeVIJ1GfgM1SIbNZJQ0b5j/iRFjHY9p8dpOBi1baiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+3eafzTX+jYLMO0FJA9M+KTWV41vsSWNFd+1leLcLE=;
 b=drRM1VMGuznlqFAZMeKTnDLw2DFDgX/6qKlxtkNZYyvpYwRxIXMdCdocmnvi559lIkk+nUnXcX3uW2hdYdLm0HHUfEO6+qFmSGXpVYwpFjMOM5YlgDkYw5CFiWRnoTWTqlJ08q6MLoOOnQIXA2K3QeKFHlF5ddDyi72NKfj4DNj587gmvs1YvY0/zzVFkIziQmEi4oDf27uKXSqSLzQy2ym2HXxMwrHG5sDboRcVY/bX6TS+BE4TJ6SNjN/D6+BJAR5aYq1VKTzCW0cQQ226IClBL54ITBOprxW7T+/5sXmtpp3rUv9mnB9kUb2W3Ewf+DycyYgwNFIIVVZBnOw7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+3eafzTX+jYLMO0FJA9M+KTWV41vsSWNFd+1leLcLE=;
 b=KEc0q33O/P5vUPJn6DXLQarE2WkpKkH28gzJYgZR2pd7HXJOUsFrQMuZggBRA7jBa14YhoMS+n3mtJmZGmZQXDGvWw/YvF4fPnTRhmGPaf/xQ1uKY33fzO3XD3rLPrnQWEFAb+twOJsV5+9C/IOE+748+rJYqbFUT799tDcBreY=
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 18:49:28 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::e6) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 18:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 18:49:26 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 13:49:17 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <thomas.lendacky@amd.com>, <john.allen@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Rijo-john.Thomas@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/5] Add new platform support for DBC
Date:   Thu, 7 Sep 2023 13:48:41 -0500
Message-ID: <20230907184846.47598-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 45951ae9-13be-43b8-1b0c-08dbafd328ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqpryEzeMsx8fv6i2vbbnWRIBcxJMtsU2GbhonotIV0uNcYHbyTzf9ts9sAD6goBL6kkinaTesbHz+vZAjoHfMD9LkDI2QiCQcP/MS9F1eWC9H78+tSYc4Dgm2bMX73Se6kZ+4diUpXIKJpyDhlLF02PpEZXS3b5vRmdJerV7oo0ePrL5iWIY5xJqpn3wJzQNurPdCOvxQPxqCDiNRcqWZ50TfYXJU3dD1cRCrF62/3v3vDFaSdwJbo6LIZ7N1aJZsj8bUiTgEb2fClMBrL6rUgb/OqwPctts0wIzbLkDzdWN62FW9QngZFz9zGefWgPCbXYgwzLC3uFcGvfnHZ4wUi1jeF06S8t7/YK49xAHUDqNLfao74UxPuHvavG9IbAeqDf49lZJlFbyF5t+C+iwsyg5xYt0i6ZJtK47kegbsQuHa4CKe5eosxhAuJ/JxMWkUbMjH9gOGM7kTum8TJ0hP09lbK6qy1DMFtFnuHB5rNRSFnwgiYunl0PDxGtq+MA3Gg1nPYSJhTKYZs9pTz/GRxg+pwUSV5Ss86W3NEG6od6kcFDhyXM/6jn9mFmDkiEyoAgAFJAS47Ki4X02qGfdXdSwqfTyvDi/UBrIJN1foysPR34cJN6T653OKh4CbF+tkz8YLXafmY5FrQpLuGm2E7UAm6sHBsUxAH01ZhwIfKMpBGmKAIxPkGqc4kevJwa9TpDo8RvMhrIu+qcOzUr9o/dO5UYlrdNUHG59ykZuUAHZAu/ru05iRzCyLqj3o0y
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(44832011)(5660300002)(8676002)(7696005)(8936002)(4326008)(54906003)(316002)(70586007)(70206006)(41300700001)(966005)(2906002)(6666004)(110136005)(26005)(2616005)(1076003)(426003)(336012)(16526019)(478600001)(47076005)(36860700001)(83380400001)(81166007)(356005)(82740400003)(40460700003)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:49:26.1798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45951ae9-13be-43b8-1b0c-08dbafd328ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms that support dynamic boost control (DBC) support it via
a different mailbox than the platform access mailbox.

This series adds support for those platforms.

It is tested on top of the fixes series. The prerequisite patches refer
to that series.
Link: https://lore.kernel.org/linux-crypto/20230829150759.156126-1-mario.limonciello@amd.com/T/#m47782729377f6fe5d62130cc701dae7f15306726

Mario Limonciello (4):
  crypto: ccp: Add support for extended PSP mailbox commands
  crypto: ccp: Add a communication path abstraction for DBC
  crypto: ccp: Add a macro to check capabilities register
  crypto: ccp: Add support for DBC over PSP mailbox

Tom Lendacky (1):
  crypto: ccp: Move direct access to some PSP registers out of TEE

 drivers/crypto/ccp/dbc.c     |  72 ++++++++++++++-------
 drivers/crypto/ccp/dbc.h     |  29 +++------
 drivers/crypto/ccp/psp-dev.c | 122 ++++++++++++++++++++++++++++-------
 drivers/crypto/ccp/psp-dev.h |  55 ++++++++++++++++
 drivers/crypto/ccp/sp-dev.h  |   4 ++
 drivers/crypto/ccp/sp-pci.c  |  22 ++++---
 drivers/crypto/ccp/tee-dev.c |  48 +++-----------
 drivers/crypto/ccp/tee-dev.h |  15 +----
 8 files changed, 241 insertions(+), 126 deletions(-)


base-commit: 7ba2090ca64ea1aa435744884124387db1fac70f
prerequisite-patch-id: 4bcf7f3ea21472e4e28c2457cc9827f6023ec6ca
prerequisite-patch-id: 903be53a20306f0188e52015dbfe5196738bb2eb
prerequisite-patch-id: af396bafb6acaa9c203c1a2c5f4665171cb45e4f
prerequisite-patch-id: abe450d4bf1de4a5664a41dbf84e72b1d4bfdae7
prerequisite-patch-id: b0b9cf55fcb73a11de6f3da73412fb090562857a
-- 
2.34.1

