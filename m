Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30B812707
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443194AbjLNFmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443161AbjLNFms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:42:48 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7EFAC;
        Wed, 13 Dec 2023 21:42:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6uVhy1SwLRaAAVSA4WvteneNL4PAqDvgrtcPf/cBnNTojFl1dYehomRJqR9eQ72IjOEdi0Dpb21T5SDpM5lAixWLIIRR22OBLFLDfde6FgMXlL8eU670dJ3vOSkK7UlW9kwWb1xJLUE9i71wFFc2HpFYcQMLqeCAkSwPG+TGXZkUE5brxdIeKIsugIsVY3jGtu458+xil0cMgccZ0kiRDBEfnV/LaKmllabnMabfZtiAQIxuH0E9aQ3pBFdd6eH4LLV6doUkYbMRsCCVnUJoPbolO6pRhCg99GyySpxcDGT9N3t4gG4YtwXn2SPhjrrVACrspa2lgUJ+k4Rylwylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gj5pEEgk5S3P7mE+kIxyOPU5qWo1yamX0KjEiK6J1H8=;
 b=EnrdusTfai6mPoAkA9ceaB7sxta0i5HfiGjm5uMIqRUDOTUVNZqShDRzpXPs85jae78lPbdRGtpMaUAaCXxo5ooHVas6PFFxhEBZpcoD5YjnSiNLMftTfHoi8Fqysxmq3mLIcRh5hDf+2PWc6NXDr+ZY7SC64fRJgxVTZ9/wM8bZb4Y6YeMJPKWDscntuEv1KHSdkbuGcyh7hEpDSvRBW/w40HpoMdQtFiQw7CvFuUChJfdixzU7yUzL9ZdBEhxgdoqBy8jGbsgIP5qF9L2L1VOrVuNqhrSdIzx3F0cOyxFhoMChQXfPnS3fxjKxKyBbB0NRDZh+uoUu617HgRuw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gj5pEEgk5S3P7mE+kIxyOPU5qWo1yamX0KjEiK6J1H8=;
 b=312Oj7M3tArhNCDA34Ggs9ruI5GTY12KpD3uqlLL5aYsBEtuCzt9YJ6xz6h/PvjDFdlqKYNQG/7d37e25K1vILGe+XT5T8xdARB/VLCI9GNRH7gj2hz+Cwv5kVel/4pSgMv2xlqDK+GyU/5vIEQ7OEz+AKacbQs4v99kqte2vDQ=
Received: from DS7PR06CA0021.namprd06.prod.outlook.com (2603:10b6:8:2a::23) by
 BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 05:42:52 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::66) by DS7PR06CA0021.outlook.office365.com
 (2603:10b6:8:2a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 05:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 05:42:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 23:42:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 13 Dec
 2023 21:42:51 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 23:42:50 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>,
        <shubhrajyoti.datta@xilinx.com>
CC:     <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ben.levinsky@amd.com>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v3 0/2] Add Versal IPI bindings 
Date:   Wed, 13 Dec 2023 21:42:23 -0800
Message-ID: <20231214054224.957336-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ee6e7f-63a7-4303-f162-08dbfc67839c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChctWVqgmeGPNiQVOroavaiKkCec5kwdLtTe3p8Zctox7AR1T1nFwVUi61oKX5UK3jVCjYKklGj5SdaJkYm9KLGrvo9pGjeCnVs2icDGEj5kFhsBvz5mK75a2wkwbyj0oKXgTA0xeD4xl82ZID80yZWGnnpeQon6NcbOOXnushYiYLjp6Ka/z4obsnXfuLbrI/Cl8vj8sT1P5EqV/1z3864wSu+45jjVIK9u7cfp0s5aGZFsZvZASMKYH5EWE0jiCbVDtZriQh7DWmNUOtXjlOStG82IQW2KxHk/DUFd3XsZem0VwPRaRvn85yMHIOhgcilqw+O7eXFY/k4hYcbSxxIwHBsqhGoay6XYGZTqR00S2AjXsPFqnM7cjXYqlfRL6pzuiuliSezgaPa1wNcCWLImSyjy1dP9PNbGYq0RgbS/PXBksC9uj+h28Mw01giSq5hjqGHoH07dE43rOUiKpoBTsHxKAAjTM2jnNoXE/DIxDGAwP7LSNar+WdtAskxihk8fDOjsfl9S3mDf9qw3F5HXt4N4DkDcXfxi5zigDA96/eSzrv5pihyZrmfuQTJZzd7LXHUo99XlupgjI8t81B1byu+17JQPhUAfS3KV1ibuwGQ+VL+a+ERSdn9KsAerYMdzB830PuDtmFwdSEwlM4wR60sC3JQbnx2f87fEizCQ4jv8ZIPYpC7KUlcw7DHGBPzPX2XKc9CIUjxqDErKcQ6QUolKQQacC//QYan+JSSgilOSzw7WFkcFeuMdX3FoVL9X0jurg48wJ4P+a48Exg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(86362001)(356005)(36756003)(81166007)(316002)(54906003)(110136005)(70586007)(70206006)(4743002)(2616005)(26005)(336012)(426003)(1076003)(83380400001)(5660300002)(4326008)(44832011)(8676002)(6666004)(8936002)(478600001)(966005)(36860700001)(41300700001)(2906002)(47076005)(40460700003)(40480700001)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 05:42:52.2207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ee6e7f-63a7-4303-f162-08dbfc67839c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for AMD-Xilinx Versal platform Inter Processor Interrupt
controller. Versal IPI controller contains buffer-less IPI which do not
have buffers for message passing. For such IPI channels message buffers
are not expected and only notification to/from remote agent is expected.

Before adding Versal IPI bindings add fix current bindings by adding
xlnx,ipi-id in required property list.

Changes in v3:
  - disallow parent node "reg" and "reg-names" properties for old device
  - remove cleanup changes for old device and only keep Versal related
    changes
  - replace zynqmp-mailbox node name with mailbox
  - Add blank line before required properties
  - Remove extra blank line

Changes in v2:
  - Add versal bindings to existing bindings doc instead of separate
    file.
  - Sort required list same as properties list
  - Add minimum and maximum range for xlnx,ipi-id vendor property
  - Move vendor property last in the list
  - Fix description of child node reg property for versal bindings
  - Change commit text

depends on: https://lore.kernel.org/linux-arm-kernel/79f65b96-9015-41c4-b4ee-a82526c9eefc@linaro.org/T/#meeacc5c57a9610b19758d313e5b2d17ab470f646

Tanmay Shah (2):
  dt-bindings: mailbox: zynqmp: extend required list
  dt-bindings: mailbox: add Versal IPI bindings

 .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      | 132 ++++++++++++++++--
 1 file changed, 119 insertions(+), 13 deletions(-)


base-commit: 48e8992e33abf054bcc0bb2e77b2d43bb899212e
prerequisite-patch-id: 70017c8eaded5fc85749995b9cf093c6c625fab3
-- 
2.25.1

