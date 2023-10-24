Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B482F7D5266
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbjJXNrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343519AbjJXNrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:47:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A6D7A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Siimagl+Qz1qREwb2d2XQCWy9OgGVtG99QijFbA/Le1KlP10K0FRPDyhW23mFVhc9qmTZqFZ/hqewDVn9Idxfn8SlmUODEa98Tzk7/SfWZRMc0j4Dfho+lMCst9i1BQ4EDK2KnrfiyFOoOQOcbXUkl3oj8ZP2TTfsIij80VjfXcu0PxRWZZZbdg5hnf6Be6irAeHn47J/eCut+xoNo3y469SAp6Ek/mqse4axCddE5soHYM2QJtMC2oc6mBe95g915Y4ZrE38yx8vXq6325coHYJ6iHrVxnxuL5OdsoP+cTLS8EgBS5DbRylsohwXqpRSXvicbkEEDkp/B2RRTxt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UIi/8kvd581H0PNm/atxVLYY5KCIom6hSiVa1iRd5o=;
 b=hrOcEt+8fXDft98okRc3B/uVvfU1pwD0GN1JWDLk1o0S/6owa1YQ1h4RQRFmwEVuWxr27+R7CVMTNn9Z5rxJdZVcDZIZorfAp1t7ycVBTWeYykaYkSP2XtGBgaKJhADIJoD3+O8SLNrPtTr/GluaE5NFn95ZNQh+4+u7eobCSrVGXq/dt8g8UAQANuZToHEUyyOPaltsxiRCi1HT7CZwdLI4LN2W3pINty2tmrtYgs/3INQuK+lGZvhoAeydrxulxEZ+O2IixP+onZx/QbyuNQiTDUwBupn6tVBuYWEZdYld9VSxeMzvn2JMdiwiWS7Dr4NMC6UWDkJ95OX8dh3q7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UIi/8kvd581H0PNm/atxVLYY5KCIom6hSiVa1iRd5o=;
 b=1GvQsmjhSOXp5LLWNzwCiZEDhdvteb9WpoRxVhmpyKn5d/RE0js2FUnbz1jEr+LHqbTQE8B1Yhmju6ps4/tbecM0UzhYhQ13mSNYRytXb+yxKGVziYcRSqkRTeoEWtViSUoA2vswADDRDcBVrqucQqgUJCrWIWnw8yXoeB+SCiE=
Received: from DM5PR08CA0060.namprd08.prod.outlook.com (2603:10b6:4:60::49) by
 DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Tue, 24 Oct 2023 13:46:53 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::4e) by DM5PR08CA0060.outlook.office365.com
 (2603:10b6:4:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Tue, 24 Oct 2023 13:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Tue, 24 Oct 2023 13:46:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 08:46:51 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@xilinx.com>,
        Raju Kumar Pothuraju <rajukumar.pothuraju@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/3] microblaze: Defconfig updates
Date:   Tue, 24 Oct 2023 15:46:45 +0200
Message-ID: <cover.1698155190.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=596; i=michal.simek@amd.com; h=from:subject:message-id; bh=7nUHR6sM695ZTQDlHgUGD4mJLwHXUq+DRiZ8OCkcuOc=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTzUzueZc3p3OIkKb3C89gNhd4H3FNvKT+cYK+zPm6tx /ct5gt6OmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE2FoZ5hmw/PXM9jGXf5ss 8y7kjNC7y/f/1jAsaGp+/EfsYJ59v9RKsYiMgn12+6PdAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0c55c0-d0fb-4542-4455-08dbd497aeb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hPYiB3LEDJr4romCTJI/ynzBinagM1Oy16an1S0IYe+QRGg0jP6Qfm47x4C52U7DrrMFvmfwWY1nqu1cODR+ZZcwWXfEzCTNHDRj7INn6KtfB7+VQY/sWAK3MIu7rprVWQBwZt4TinLgsYYuhXkO4CFnmc0X9sUQtpbeAhWgIbFPpmElS1f2lDfksE7y6z/8phQmL8tQlFx54bmvz6DYIWby6pKBQkzEtQAM6E6sZz3Od39Uy6hHldnUIlwIWDMknscS5wzkrEuZtWGz+oQ0aOiBqDxxjbuLJatW3NAG9d6E6Sy6zd3JhyUds9eAU0EIlhTUI3/X8sdNS8Qot51d4pfiWb5UjYEfcG+ddgj2+f3FbL1EvpWzY/xSwqKqUM9LwORk6FMv+IMysVLxoZT3IW/b1J/WglU4sThmggW29rYM5L7pXoXAOT0SvtVE0epKVNZGfpqItz1veUsEEc/3L7Z138oV4KsVDmC3aegY5DmAn86b/+0yHJq29Y68UbzJeiHNjnSJHlWPKVWaNRSmushLQ4wX08xnD1/spZrTV8tHVM1ytw1xJttnSammgNj7DqYQdRe7VmH4O1h4uZcSsvfrS577zHAoFXgaitJ0uoHHFAHLYvLcjxq58qKql9ZPjvRYtDMwmspxpgMJGBsykgz9FM8emM321mxXpWE3N5iUIJY4WU6BX2RZgDYB4EbDJUyuTtj4f4bNurhXVIQYo3AOUVN57MeMhMW2FtChzewWBTQIuKMIbXY0uZsfZyKtZFepqTFLkW7PW1Iiw63Fw7GJ6j2YilWXkQvNisgkjo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799009)(82310400011)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(40480700001)(36756003)(8676002)(110136005)(54906003)(316002)(70206006)(6666004)(36860700001)(8936002)(478600001)(5660300002)(47076005)(70586007)(41300700001)(2906002)(4326008)(4744005)(7416002)(82740400003)(44832011)(336012)(16526019)(2616005)(83380400001)(426003)(81166007)(356005)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 13:46:53.8344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0c55c0-d0fb-4542-4455-08dbd497aeb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have put together small series based on patches I found in Xilinx/AMD
Linux tree which will be good to send out.
The first patch is just synchronization to match the latest Kconfig layout.

Thanks,
Michal


Michal Simek (1):
  microblaze: Align defconfig with latest Kconfig layout

Radhey Shyam Pandey (1):
  microblaze: defconfig: Enable the Marvell phy driver

Raju Kumar Pothuraju (1):
  microblaze: Enable options to mount a rootfs via NFS

 arch/microblaze/configs/mmu_defconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.36.1

