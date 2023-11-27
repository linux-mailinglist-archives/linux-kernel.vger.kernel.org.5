Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897BD7FAA34
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjK0T0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjK0T0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:26:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA29FD5A;
        Mon, 27 Nov 2023 11:26:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWyMUzY0xPR9PzAa3+V5Aoyno+ihudemf5a9Ui03RzsY4AJBF1hsrYGYoFN0hgMhH4jsQkJVjxnO6/28CEvYC20UxX8TdtHrOmpnIuOfpGSZLrxqVOKLnNEVyKB/z+jIZ76LjxakOdM4yT+tECjQmRXoG8gqVEH0QTe/Fa1QvFZ0HkiqWZYCStnzfsQ39GGHuzt1ZfzVNpmP89swpAYHIyTzM50tHpXKT7RuZ5WXZf9nkVJRp6SjuMLrROT4EB1xq7VhWXSusej32WACZrioLt8sw/vKGoVw4j0IYYZQgK5pKXZhlq+HvLE5sshAacvgetA2h6d77RRTI+XudB+hlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XYRjI85l3XoStfjzk+xdJAsFHr3djJ/4PNC0Gp5mbw=;
 b=EA6XvN44D4E7azDSQovHXYPnVYJU348HVloU5kYOsNuoPMR38tzVqdz3rjU/CWOezGv+PZ3fkRT4xexKkqrCtX88AXVSTYxwXyWGFUd61fH9ZNcUc2QSGYPABarHfAQdfMljMUkF/rYC7omYe8BWeNH5NTDgbVB7TCLfFUBZIMn3X0dskP+NKpeyt2YOOOt5zeNy/BK6M1YWLRhoVhTBmLZbZDXnXi0HvWnrYtioImAzfYZtzrEtn9LP0MbEaybe8T0ih4LWR5WA3RDaj+P131Q98H6creQOLnU1G6MBQ/pZccscJ/Ae01Qk1iubhray9w+ABbZzY66RRZ0RPGfDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XYRjI85l3XoStfjzk+xdJAsFHr3djJ/4PNC0Gp5mbw=;
 b=M2XvAoiZNVLhHZHU4XncUSjXjWvG3s5lREuYNmfeXpU6jm7Nfs19MZs0zCxtLzt+RJugmbjmD8JERWzrhEbUXhu+0gqTu+1WqEJb3PvcPGLRO8nQUuhuW6ZIlp1Ddp9LgfTd2yV7eWCpl6P9gFq8AlBDcVnGgx/eipt4l4Sc+wk=
Received: from SJ0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:a03:2c0::22)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 19:26:10 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3d) by SJ0PR13CA0017.outlook.office365.com
 (2603:10b6:a03:2c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19 via Frontend
 Transport; Mon, 27 Nov 2023 19:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 19:26:09 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 13:26:08 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <tobrohl@gmail.com>,
        <aalsing@gmail.com>, <Dhaval.Giani@amd.com>, <xmb8dsv4@gmail.com>,
        <x86@kernel.org>, <dhaval.giani@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/4] Extend time to wait for UIP for some callers
Date:   Mon, 27 Nov 2023 13:25:49 -0600
Message-ID: <20231127192553.9734-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d44020b-7019-4a7d-95ec-08dbef7eb5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHq33kjUXLYnrIfDsVpYf3yFS1hDvaGKp9nxsg2jfaWQtAzxgpjLmhVVSKQnaxjQvJhC10YJLy1qrd3iduJuQMLdN/Zz10BgC36BBgb2jEFtk7Q3yuGgnWyupYflBUauj/sFo8tgZcpnHg2G99G5JaosP1MfOEKPBIOWQRaGrhqjjzB+t8A3QR7JBM+pRF+y3uaHRVhoqgySjwZfDMokEjme8j9oSGmMNZjsVQuMkqJgNWQPPZPMwcnJL+kfi45M4H4/on90uTiU6IxDuAJZfVocPzabUuFDLmqzbTkofGh53yxAH3f7kVXSr05JNojMAHMBLGdP4CQA4ygnM78GZTKLP8V4MMxsd0jxu6Bo5Il1omn+e0zOBr9oqWK+kVG9iNzmWxwHtxSqF7RnJ81prJGweE5BxoVqnwD06p/JWN3te3O3s/O+qhs6aDPGeW+uY0KNcalNrdfZqMAojS7x0mEXdIeq+SxiOkOa3q5LEFWF3S3d3P59kkFFlto2F9s552zGPn3XKnxHOykTIhm+NSypYf+7VRvycuQuvQxLXMUwQ9mGcb+poiq1b3/qNxlJ83MdUcGYRuquO3Ia1T+vb2IriC10VigbJPs/Ev5NIUHCs27le6QLx0xTje/HwI+OxzKSe0C8OHI0VYH/WVvMhWB+/VzxgSmYZFgIA4NE0RvIoZa5D6CfU4ZtAw7NQho/l8QLvRPwIVAyDp/BmwgEd22VHcLdYc0gBuFDHq3rxltD8uHdYJiOsZs2RWlE1ufrTsmL0GRCjU5Wn/KyWPIF4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(2906002)(7416002)(44832011)(54906003)(70206006)(110136005)(316002)(70586007)(6666004)(7696005)(8676002)(8936002)(4326008)(41300700001)(478600001)(5660300002)(2616005)(16526019)(26005)(426003)(66574015)(40480700001)(336012)(83380400001)(1076003)(47076005)(36860700001)(86362001)(40460700003)(81166007)(356005)(82740400003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 19:26:09.7801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d44020b-7019-4a7d-95ec-08dbef7eb5d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of users have reported their system will have a failure reading
the RTC around s2idle entry or exit.

This failure manifests as UIP clear taking longer than 10ms.

By a debugging patch provided by Mateusz Jończyk it is shown that this
has taken upwards of 300ms in some cases.

This series adjusts the UIP timeout to be configurable by the caller and
changes some callers which aren't called in an interrupt context to allow
longer timeouts.

Mario Limonciello (4):
  rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
  rtc: Adjust failure return code for cmos_set_alarm()
  rtc: Add support for configuring the UIP timeout for RTC reads
  rtc: Extend timeout for waiting for UIP to clear to 1s

 arch/alpha/kernel/rtc.c        |  2 +-
 arch/x86/kernel/hpet.c         |  2 +-
 arch/x86/kernel/rtc.c          |  2 +-
 drivers/base/power/trace.c     |  2 +-
 drivers/rtc/rtc-cmos.c         | 10 ++++-----
 drivers/rtc/rtc-mc146818-lib.c | 39 ++++++++++++++++++++++++++--------
 include/linux/mc146818rtc.h    |  3 ++-
 7 files changed, 41 insertions(+), 19 deletions(-)


base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
-- 
2.34.1

