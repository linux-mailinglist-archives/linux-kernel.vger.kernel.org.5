Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1493580BF44
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjLKChj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKChi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:37:38 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A008E;
        Sun, 10 Dec 2023 18:37:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGTFSkX9+SIQS8UwPlHBW6a8U/O8wa093CpBsCZ+gQkp64R4vmmyI/b4TY5auLKGp0pk80Um4LXyIGDBQlyIelf8ZD7PdRfqYr4Rc0bLltG1syTN2KZZl4QZ4LUaq+cuyzOy9g1Njp2oxnNY25ETuue1pAo/4irIVNDFvh+iP6YI6o59hkEpqTnIZ91owiU/sQ5zyQGg/WRPb70J0Mlbid4v954XsBGK+RtI3zTzlg3SKgd0r4WshSpvtSlOyDLDL4F7b/T2cG23M3XOsE8LyNB0FBCuo9d6ML+6odpfmi/Oe5yvsWrD1EiAM9SEHkrwazbxKrKW47zx/MZaoudmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU1rWq3aznOMzWfueolaB4aEfr0Xqu6GOv+M/SiZpnE=;
 b=A0kVY2XghbvnjAtCXekA/V+artf58LX0KiIe+1YqclhzHiER4yEQD5WVxQWlSNWSg+TK0YRW2LjMItL74DYmNCbb7bx+tKDqtFmsNvQOkipI5eHA6/SJVqc52OZWtnM0YIZTJI4sEr7U0h9bMq23UQU/To+U7CchXfmKS80rPM0dsw5lW+cD+pEAiZzFUEh/EY5/7xCmv/wSp1K8P8e0kvgmaq8BpUeXGLHdXvA9QEH3cj0xIiyrgaOC72dIhscHdikp5vYPIVolt/Lg8bJA6kqwTHjAuWkRHqKrCnYb9kvm7ujAQ/2anwF1V3cIjlHofQ4AA5kPbqsmJt7cq4K0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU1rWq3aznOMzWfueolaB4aEfr0Xqu6GOv+M/SiZpnE=;
 b=jY4ITf5w/ZhyI+HJ0xWJyOMqR9+Ur1JxnGWw9fJkrVgBd3/oiI0VumefI5ABJmn+sbEeHyIIabTYEZjG9oHBfw1to8waYGFMO754g0CwUWym5xcRKnNsit/DQneEokN/hZUbtHfcYUJ761RfOJi6VyRY/PDuLBLRXn9+FBQ38Lk=
Received: from SA0PR11CA0204.namprd11.prod.outlook.com (2603:10b6:806:1bc::29)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 02:37:38 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::a1) by SA0PR11CA0204.outlook.office365.com
 (2603:10b6:806:1bc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 02:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 02:37:37 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 10 Dec 2023 20:37:36 -0600
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH 0/4] Spanish translations and corrections
Date:   Sun, 10 Dec 2023 20:37:26 -0600
Message-ID: <20231211023730.2026204-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb85a58-9b59-4b95-25f3-08dbf9f2236a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrUsSQiJfMyAxf5xlBZK5TEVllhlO8uHQLju3EJnI2o5AAqKLNfikw14K+ZTXEO1kA9adWVmdcRPJSlNEtwXF0HBcu90WA1s7C+Bdh5Kwqn5eSwHu9GXJSKBGbiFyd85w3xOgMlbTKqmOqeWR5tT8k/LpB3HzJXPl+be4Pq9+rjNCd6+Gf71GORA60P6TgX0D2Wf11uh8C1Zm5+2Q3bOiKr71Sa8QES8nL/Cd69BpMIzfG6bfJqqA3d1BFXhWrZNTztBVH9TaA6fox9CS1wKynCNE+f6jvIXXHqG8JfzSnF4eHAtwPuWm4WBjaZw/HQIh4ALrzxIcoz93zxXgrWnoa4p0kExX7bAmqTvkrxKgE+PlstrpMkmmyV3RCK6Npi3v/qa+lrKOmtKdIBhtLzlMnZ5lZ3nq2qSfbHKwUFEEsLrabo2TFZ25ID2d8dl3k1QJduvuPpX9TdjbDxfcnKsM7Uc+t3ixknyT9lTuYmWCuBJBv5n3NyYdEFz2jHju5bknjngTlk42u2LzExI5donVMj3BhM1+jm0GN8dxuKPJ1GYB1LKIv4arvMWA/NMBa2AKfdcdicw4Bu0gOBZ55fGMLo5121Lz9tDfSLrLK8YGJ2CP7ennckBMx+28FaqA/tfvhBVgBGaXiatSAR6W2s+Mq4vBuAhaxNTr0Uf7CC50GlDfIm/ldk87MqDk/Gkv4DbRS+Fof8RfNpYe6Od9nELScw7vg2z46kEyOEYH4A89JxCRtwsy7cadatvZBN/FEF3hAHq9xtvzFrXHPxNWeTA5TvG/VUCjTIYhHexi3NZl/hBP//3HpirHi5nC1WebXwt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230473577357003)(230373577357003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(5660300002)(1076003)(47076005)(336012)(26005)(2616005)(16526019)(44832011)(36756003)(426003)(70586007)(70206006)(6916009)(54906003)(966005)(40480700001)(2906002)(83380400001)(82740400003)(81166007)(41300700001)(356005)(478600001)(7696005)(86362001)(8676002)(8936002)(4326008)(316002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 02:37:37.3993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb85a58-9b59-4b95-25f3-08dbf9f2236a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset translates two documents into Spanish and also warns of or
fixes existing inconsistencies.

The first patch translates process/management-style into Spanish.

The second patch translates process/submit-checklist into Spanish

The third patch warns of some links in Spanish translation pointing to
English documentation.

The fourth patch moves howto.rst file into the process directory for
Spanish translation per the original English documentation.

NOTE:
The first patch in this set has previously been sent out as a standalone
patch. Review Link:

https://lore.kernel.org/all/20231122003343.931394-1-avadhut.naik@amd.com/

However, since no response was received on the patch and since patches 2
and 4 have a dependency on it, have incorporated it in this patchset.

Kindly ignore the previous review raised for the patch.

Avadhut Naik (4):
  docs/sp_SP: Add translation of process/management-style
  docs/sp_SP: Add translation of process/submit-checklist
  docs/sp_SP: Warn of links pointing to documentation in English
  docs/sp_SP: Move howto.rst into /sp_SP/process/

 .../translations/sp_SP/disclaimer-sp.rst      |   3 +
 Documentation/translations/sp_SP/index.rst    |   1 -
 .../sp_SP/{ => process}/howto.rst             |   2 +-
 .../translations/sp_SP/process/index.rst      |   3 +
 .../sp_SP/process/management-style.rst        | 299 ++++++++++++++++++
 .../sp_SP/process/submit-checklist.rst        | 133 ++++++++
 6 files changed, 439 insertions(+), 2 deletions(-)
 rename Documentation/translations/sp_SP/{ => process}/howto.rst (99%)
 create mode 100644 Documentation/translations/sp_SP/process/management-style.rst
 create mode 100644 Documentation/translations/sp_SP/process/submit-checklist.rst


base-commit: bc63de6e6ba0b16652c5fb4b9c9916b9e7ca1f23
-- 
2.34.1

