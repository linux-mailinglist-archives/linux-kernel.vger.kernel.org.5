Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181C47D61F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjJYG6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:58:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9330FE5;
        Tue, 24 Oct 2023 23:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLvkal3WVzKrCwWs7xyClRjtjF4zkR97o5o+bAJSKWiUJHXyy9zfC4y3252LYk1VjG6icp+vTuq61eG6mbNx81meU8e6OD6KPHyktX+xBovBZcGYqBChofBK39BFulOhHB45mtYaK9NQTOnmWaZQc19Qd1h/70odqMjZxXVTPkAZWqIP/qi0Q8ndJDiuCLila8Aa3KwIeKp6UoTbs7Cx3fYhO6uWmBz0pGdmjmLhSaktm2fysO2KezgTuAJp9reC+Y0eLiI+o3aWZhonBAyp+TtR93oZVzxkvbTnYOgKYvG6TbUP8Lk9erg/eZQ0o4uVnf0xLlGcaZO0IOIjx63kAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6VSEx43tsLm2DjkJWai7kGwwNkfFOLw2pGbFOkRBFs=;
 b=MrxECsPrKgluOH7Tk5YQk+YnsY68jS1hJFeTpq9PVQSWfEWGC/fd6dpherhpxebIf4yn9zTFknJE+YBvb5wFQbUDUxjOfJr3YN4YyoD4yaGkTyeS4cV5ZkbjbtlPabLYh0Sq9CSRDWWFelm6YVUei8wS7DmfcGjC7GpfbHYwBfLUh+PQ0b3QxM1QD/U9BgS84GlcvZvn5oDDKDU6kFXcsOgflqFBHkYfqlICu9YfB8L+7VIIHEVl9gk8oeH1paH/RTX2A4lzH/yoVUtr/zKmLZGr6syOGLIU9qiEWh2eavrA/KnlnlF8mTjHdOj3PB4lTiJSiinJI+7rQu4wQ6P+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6VSEx43tsLm2DjkJWai7kGwwNkfFOLw2pGbFOkRBFs=;
 b=JIfzPAQrtyIu/8ab39U8PvNxnVmeOcNJRX2fUPYD4JpA9ED4EdNKDoPU/bpJ70IIJhlzcqM+kbKTw7sCV6vU59i2Z6UTpyrB+uAejH1vK5l4r3+MVU38vPXhHN6dw2R2O/dprPUxQA5XwOW/fj46R7nS/OOvfWICGo3zThcwKqk=
Received: from PH8PR07CA0030.namprd07.prod.outlook.com (2603:10b6:510:2cf::16)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 06:57:50 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::85) by PH8PR07CA0030.outlook.office365.com
 (2603:10b6:510:2cf::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.36 via Frontend
 Transport; Wed, 25 Oct 2023 06:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 06:57:48 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 01:57:43 -0500
From:   jeshwank <JESHWANTHKUMAR.NK@amd.com>
To:     <thomas.lendacky@amd.com>, <john.allen@amd.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jens.wiklander@linaro.org>, <sumit.garg@linaro.org>,
        <jarkko.nikula@linux.intel.com>, <mario.limonciello@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>
CC:     <Mythri.Pandeshwarakrishna@amd.com>, <Devaraj.Rangasamy@amd.com>,
        <Rijo-john.Thomas@amd.com>, <nimesh.easow@amd.com>,
        <JESHWANTHKUMAR.NK@amd.com>
Subject: [PATCH 0/3] Introduce DMA APIs to allocate and free TEE shared memory
Date:   Wed, 25 Oct 2023 12:26:57 +0530
Message-ID: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ee0fc2-3989-4132-2bfc-08dbd527b2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iajvd1EyTrMxL8bpoA59HgynCHIZyrD3UQYNWC6ZLPkIdsJbOVbxGVANWyf/z+XNu6TeSBixEcA9J547LfTvoKjVor+W8NPwZ9Yunn8vlzsTyP0PtjyrPJuRhiUbiGBRjBb6KrbhiPnxkPPKgdB+KodJEzPzsBiHEmFDDiPhanGpmVR3cd+WMrmjnLi1B6gnLihWew0XtVHkB+yKFbYpZF0dxQRXU3N8SpSHY132Nm9UeJuWBmTg3v0E/mUrqd4XTmPLP5hOO4mmes43Q3kXrxdm36tAdNx2fpcYm899qGeERIybF1arKijZ2Qp6r04Iao0568cy+qhD6fPtrbDVpaCtGnSr0tumeFJ3mZaPKl5sD6jj2t5haKdV1ancJdm9FCowWop+q5pQe5P+b6mw8w6twYCzKTmjhLT4xG0yBhSSYPQjyASf5/kSHjkEFgtzww3dUCxTwk3n0E6UzyeQqmSUouEe4z4Qp3Gp1eUcwrZ0IS2lgCbjPZVgUfh1tqCprIiZ/dIFOM4L8BAvdNHoipKZFMun2juIsXaHXSFu8Cyt9TKDs2rWaSzFSKJN7d1MascsgMSBftpbfN1nJkHHH0vMNyr6aecyLphRSrklBRVdXVCDipi8rDpHoY9Rwgva647S8wlX6Egq1XA1jBFFwzF5Sg1j9KVfPtvr6bWRpC6CE+W+7Nqg3Yj5lOVRfP5yKG9mv7EMMADwZet5NijSUTznHxLT+r7BQhWXBus6nSs6SfWoepg9JZd2O17NOeBqXoRvLct4afI/8Hp940yLu95YhQDmxTlAhnYGnlUpAlZhqrnRJFNGlHAeWNEYWTHj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(40480700001)(7696005)(6666004)(478600001)(1076003)(2616005)(70586007)(70206006)(110136005)(54906003)(36756003)(316002)(86362001)(33656002)(36860700001)(47076005)(426003)(336012)(16526019)(26005)(82740400003)(356005)(81166007)(83380400001)(8676002)(8936002)(4326008)(921008)(5660300002)(2906002)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 06:57:48.2663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ee0fc2-3989-4132-2bfc-08dbd527b2cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeshwanth Kumar N K <JESHWANTHKUMAR.NK@amd.com>

At present, the shared memory for TEE ring buffer, command buffer and
data buffer is allocated using get_free_pages(). The driver shares the
physical address of these buffers with PSP so that it can be mapped by
the Trusted OS.

In this patch series we have replaced get_free_pages() with
dma_alloc_coherent() to allocate shared memory to cleanup the existing
allocation method.

Rijo Thomas (3):
  crypto: ccp - Add function to allocate and free memory using DMA APIs
  crypto: ccp - Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
  tee: amdtee: Use psp_tee_alloc_buffer() and psp_tee_free_buffer()

 drivers/crypto/ccp/psp-dev.c        |   3 +
 drivers/crypto/ccp/tee-dev.c        | 119 ++++++++++++++++++----------
 drivers/crypto/ccp/tee-dev.h        |  11 +--
 drivers/tee/amdtee/amdtee_private.h |  18 ++---
 drivers/tee/amdtee/call.c           |  74 ++++++++---------
 drivers/tee/amdtee/core.c           |  72 ++++++++++-------
 drivers/tee/amdtee/shm_pool.c       |  21 ++---
 include/linux/psp-tee.h             |  47 +++++++++++
 8 files changed, 221 insertions(+), 144 deletions(-)

-- 
2.25.1

