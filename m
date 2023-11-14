Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996E77EAD15
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjKNJd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:33:26 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F06C18E;
        Tue, 14 Nov 2023 01:33:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtnurtYMvvhcH2JxCZQLSa9IR86uI9rfGNwQ6F2XdEeAD1m37+ol6vbQk/ypdGe/HwZ+8FmFT5yYBN9SesBsrNnPh9PT7SBSfoQ8XFLhhUMkO7/S0CqfBW7yL4w/4DQVthnE5oBeNg/jCgtH2syui33PRCA+ekS7JdBI2nRYiTbb+SBXhfKCsPX53F6IdS7WoL7ukYYEjtp5sIjlqsTJAy1ddlGebky76JVak+lBIbaHcC8kZHeyE46dwCz1pV6wkZH+K/OIkc1ooGGt6gMKrj+jL8BAgrymeNteIFyQD8EP1ecp9+y3Srfr9dNxkLNSvkZq77lvK6dBI0Qh/qOezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU2UdixBYC1V4/ihTcQg9EwkUP1FYKnlEJpoFLlB1co=;
 b=hQLYYVRJhIdajF+CcqRk64OIWi8XpBwxzhvFV1Dr/e4ieE4ldX9O+YvXfYaB/LTxOpHeFm9/1Z9NA6Wd+yvl2OHERJqns87AA9MUXQzqbVYlm2YNeOJ//1UJ3xNzDZQgM+y5cA/dvCbNIJ5anb6k+sXlRWyBqH4KmJuHiAZhA1H8+WEJoXV2gKb4fDJeBSP6ohfq9ScY04FpdzH7hYDdUnBMRO1z+p8mEEeu4UraGby9clkUQkng3p5K6MQJQzt5SKmQdLT3ETlV0QdiftEh8PMsV+vCVQv+pqeszhvcCG4N9BIqbTmu48q6Y6blPLKY6jZjZSX7FWGHZyTk24oXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sunsite.dk smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU2UdixBYC1V4/ihTcQg9EwkUP1FYKnlEJpoFLlB1co=;
 b=sVc2IjRB/fhdS8BMKiRavjoFK8h0d0O/j3f/k/Hpr/piYOhUg6nmlmmgFODsIKo9HaKyf62Z2Wjq+SFtH90ubQpvYTknB7Tn6crjqWC9o6Aal2O/bQd0qQOeuk6buY9WY7WLCFUoxoaWoZcLPs3b6JTLvIGbwMA1ZHmpM6PuBmY=
Received: from CY8PR12CA0003.namprd12.prod.outlook.com (2603:10b6:930:4e::8)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 09:33:20 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::d1) by CY8PR12CA0003.outlook.office365.com
 (2603:10b6:930:4e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Tue, 14 Nov 2023 09:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.15 via Frontend Transport; Tue, 14 Nov 2023 09:33:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 03:33:18 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 14 Nov 2023 03:33:14 -0600
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <git@amd.com>, <michal.simek@amd.com>, <jacmet@sunsite.dk>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <christophe.leroy@csgroup.eu>,
        <rdunlap@infradead.org>, <airlied@redhat.com>,
        <ogabbay@kernel.org>, <linux-doc@vger.kernel.org>
CC:     <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V2 0/2] Use dynamic allocation for major number when uart ports > 4
Date:   Tue, 14 Nov 2023 15:03:01 +0530
Message-ID: <20231114093303.2718141-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 7842c581-d277-40cb-126b-08dbe4f4bcdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6m4sly3mzO9WTamlOblAU74wOGpZ9A0kB9XW632D2FFbaXdRcWVP8pKhatoKZBbGXnrTvfbo3cQW1wopXzSx2co34LMgETgJhVe6EzkoT/Inf4RtyMMXzUQdsKQHy9x+EBER+1Dt7jAcWQoyZZQl+eYEsU78lMSxliYl8pa/Oizuxq6B9I37XFYkAWixWIlNhzKNWbwYJefcjQvHVy0xvdl05SyI+kv0mpOtTjocUiaKemfkjI7IbUHn+zLjXMu3BPaUGNe9ENbWQRH7tBDfFcwyXh5EY7iyV1lanuSG8GAiArmxVtBghWlM60t2Jss+fvZuDKXaBoQaIo2oGPn6O6G+7KkIut85oM5fgGl1B6Yk+wUMw+9ytyYbhKrTczfHpFTpBSH2cj47gq1TJiNo5PaP/+PA1L6wmRDnNmHG/BD+X1SyNaVc6o5eKnJ6KnJa5q50AjQzG/Rmsl0G+xam+3VQ/q3pTiZE4zE2qtDvoPG69G9hUOjfYdOswplatl1Sf9AhFlKGR41huUQNZmgurQYwPH5wbToQuoMaJM6eqEDsM8xF6rHHm9a2XL5ETDhaC6nX04FXBQ/TrQCtaXar5geZb3N4eyeB/1/l0mhiT6UG3dVhZnrnUW0nih1AN1w5iALvNpU1zdCDvoU5hKIf7N7FTPOd9XX0aEPlizUsCRgrI7IB7NhZoDTmN7v2Ql7e+Z0I4OU9XKDEOEf9cmynIEYTVh33V8C2Q7twtB630S6Ox9vDTkgB8FSor/jXynDURfzGv9M3zJ/qKZn/anLYYjAL4ioXkhJdJjo37Nyrl+WMbWX9owvBF93ZDbGLZ7YI0w9hfCuyX0kB06uJQEK1kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(82740400003)(356005)(81166007)(6666004)(36860700001)(40480700001)(83380400001)(47076005)(426003)(336012)(40460700003)(2616005)(2906002)(4744005)(86362001)(7416002)(8936002)(41300700001)(5660300002)(4326008)(36756003)(8676002)(44832011)(921008)(54906003)(110136005)(70586007)(70206006)(316002)(26005)(1076003)(478600001)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 09:33:19.3121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7842c581-d277-40cb-126b-08dbe4f4bcdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ttyUL major number allocation details in documentation.
Use dynamic allocation for major number when uart ports > 4.
---
Changes for V2:
Introduce 1/2 patch.
Update driver to use either static or dynamic major allocation.
Update commit description.
Update description of SERIAL_UARTLITE_NR_UARTS in Kconfig.

Manikanta Guntupalli (2):
  Documentation: devices.txt: Update ttyUL major number allocation
    details
  serial: uartlite: Use dynamic allocation for major number when uart
    ports > 4

 Documentation/admin-guide/devices.txt | 4 ++++
 drivers/tty/serial/Kconfig            | 2 ++
 drivers/tty/serial/uartlite.c         | 5 +++++
 3 files changed, 11 insertions(+)

-- 
2.25.1

