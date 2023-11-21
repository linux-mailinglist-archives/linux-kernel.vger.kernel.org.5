Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493E87F2B96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjKULVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:21:07 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFB5CB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:21:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9jRGf7YMB5mIvASHnrBQSVjzmh+Qb+EsBgKBO1zrclzQGuzoGr/9oEcaaYb8DX+v2IpnT5Mch3t7BWWRzserr9bZ+1b+GeAWBdGzTcT7VVq7Ssud/94l1dYI2H42O1fJbOJy6qtMf8AcD5rAfIY+PhdmawXq9zgf6h8S0SoDxpxXfIgucwsqZ8t8AidEM+5YJqdxdkkhHmq9sRtCXm7GN81/5UIqEZNANEBJtUpz8x90G5SD2PYOh708vqlufFp2ORXXQjGI1zbkjoPLk7lexCN6L5lKALG52QTb/Z/pAFyrwq7TprQjw/4smGK56JPpbXXd26AaQqr6fgNVKvpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMsdxhVV3QQfe75+cxV2ddc0yQJiteS7yg1LV7GDSjA=;
 b=Pgws38cNLsyOu/GWZXtsfGFVoOFUq7rCi6E1hRPMpO2h7Pylq1ck6jE2VeTCdu81SUQkI7yD4jgfnPX/ELuwG62qKfpEn71BPAr5CRei9cmzffGu54wY5PCy/IwSrxNP5LtT+j3acjGVMoyu14A1yh7BTyJDUAqyPWD/drC/IZS5LzTi4hFk0vLvDgJekD+He7TpSNa/oczk4GI+XndR0W3fIIn7qDwWTNUpM7Y9bpYKcnc5T+jz1GyFZL4pFYqZfz9lUH0FFr0s3OE9pFbME5MygKveCX2LxRIQk60txrJ0PQUuOb+9Caye1a+22FRiYyEwEAYjLcOXkqPzaDuEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMsdxhVV3QQfe75+cxV2ddc0yQJiteS7yg1LV7GDSjA=;
 b=dLR+21V/KiBjL3WB/5dDLU8SFMYxMkSSDrvc6L3QEgxJWAYBKjXmCRyKHeWtY7DvuD/afOQeVTSyn9MS5mrjocEXVXySRFGnCpGfsr30cbzSs7KJB446HNzcwRJAzzqki9sshfK3YShMl9a2DhBd9jUda3+nFN8FTXcymV85GY4=
Received: from BL1PR13CA0321.namprd13.prod.outlook.com (2603:10b6:208:2c1::26)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 11:21:00 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::d8) by BL1PR13CA0321.outlook.office365.com
 (2603:10b6:208:2c1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13 via Frontend
 Transport; Tue, 21 Nov 2023 11:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 11:21:00 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 05:20:58 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 21 Nov
 2023 03:20:57 -0800
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 21 Nov 2023 05:20:56 -0600
From:   Ronak Jain <ronak.jain@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <sai.krishna.potthuri@amd.com>,
        <tanmay.shah@amd.com>, <ben.levinsky@amd.com>,
        <nava.kishore.manne@amd.com>, <robh@kernel.org>,
        <dhaval.r.shah@amd.com>, <marex@denx.de>,
        <roman.gushchin@linux.dev>, <mathieu.poirier@linaro.org>,
        <shubhrajyoti.datta@amd.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add support for last reset reason 
Date:   Tue, 21 Nov 2023 03:20:54 -0800
Message-ID: <20231121112056.1762641-1-ronak.jain@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: e15dd7bb-9a6e-49fa-58cc-08dbea83f0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ns2ULm4pF2hWNItw5qYyiba9kKKH+vZTpL341Ejc5Vn8AJeXJIqR2QwW/9NGmMmW176xeCXL6fM1VG0lqXj2RzjStfaoHd6RTfyc1wTzZCePrzHJ5AKtK6wn2+N5LVxJ2wbITA7QPHk4ol3owUTPjVQptW61B1mWwa3wO7aY8s0Q58wuWMsAp/OXCKa0N9dpX3qb9xRDAA/qTYGy85yC/YgesRu8N9LD8AXafVYEyx3+uq10HVWemHezWpwkbDlx7KUnywg2ndwFoxBpRXu9cX708SC2xf561nBsl2Xdf/fr09FTzfwPLlB51jS0SmjKen7GSS9SlPOf/BBGKUsY4jFMeHyT2uaNK9bIPPXizlV3u7FcCfxOuCF5TErrxh6uQ8i3/poiqSXImnOj1bSvrromUeIbwvoOZeWlzOyP+/COf3eCCnG4/YdwQW1Eyv9YO+y9HTO08lO6f+WMxvH/dJVtFnIWxMAxxowLEWxuaQRDB0144gyHHt8eMW8IvlhIawHYUh6dR5ONv0FULl8mz+vo71Xi0jORvbmd9jbZjmqt500PJo7+iHJGy8XpfIB/RVyOzJslmi1lqWZBpmiAw6OoqtD40vzpzElHk8XjG6qhuS8m6ME3Sh9dle1twPW5YIlTqLGvt/jKZZyYRmvZaquqJdb+iMLBpUcBVIHhNfzmomJInjpAkOw6uyOET2dftdn6QwJ9b82mi3wrdXk8vslfG/OIWfh2B6UPGERkeIawBneetw5SGorGbnnFyUS4Lj2qf+4W0aOABWiFrVPmwQQTA+DCkRXAZDVyl0Cheg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(2616005)(1076003)(426003)(336012)(82740400003)(26005)(4743002)(356005)(81166007)(70586007)(70206006)(40480700001)(478600001)(110136005)(47076005)(36860700001)(316002)(86362001)(44832011)(5660300002)(4744005)(40460700003)(2906002)(4326008)(8936002)(8676002)(41300700001)(36756003)(921008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 11:21:00.3210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e15dd7bb-9a6e-49fa-58cc-08dbea83f0be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to get the last reset reason using IOCTL API and sysfs
usage. Accordingly, the end user can know the reason behind the last
system reset by querying the IOCTL API or the sysfs interface.

Ronak Jain (2):
  firmware: xilinx: Add support for GET_LAST_RESET_REASON IOCTL
  xilinx: firmware: Add sysfs to get last reset reason

 .../ABI/stable/sysfs-driver-firmware-zynqmp   | 13 ++++++
 drivers/firmware/xilinx/zynqmp.c              | 43 +++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          | 19 ++++++++
 3 files changed, 75 insertions(+)

-- 
2.25.1

