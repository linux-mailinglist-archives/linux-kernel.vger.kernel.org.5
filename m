Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B229A7FFDDD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376986AbjK3Vt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjK3VtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:49:23 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F47198E;
        Thu, 30 Nov 2023 13:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfPlFno7sk2eCfkaHGfH4ZNDlvU0dCplOLmRs2C6CDWMvbnXKohrnL+gV0lfz1/6JRfvh883R9oCN+suGjm/6GtQ5boQHkvP6eS7IE5v1+EKhfNWpV151eCtDDRxujlCrP+eY8fjEoGav0QzAIuUgLWiMkgwRdNkhv8vqeVfeqdLS4oMuIH5gqaQKALwbNYCXAXgMaoc/ctqhhNLuPnRwlvp/0TL0OYikNdZwMWH80xKohi2bxyRd0U3IlJPpCofhZs6buwhZS8rwJvDRdeJBtbLp76nvouGrThKkCPmVG0yCELnQFbz7Et4HxVTSAAaCV+stdwn9Ntbrl/uEWKE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2axCpfEpUw/lFBX37+lqcZ+XwWsj1GhOI3zXdhsSKZw=;
 b=Eg0Zz+4FYPEROcQO5wM8FbBuXk0t9wEqF3qcHO9k+8i3wiQ75yVS+hoNmYGX33rt9SGqwPYZEjwf6Mbk/0nitkjQ+Iq8/d8Lwpx8u+tRkrjZNLHu7pnZ+pgasxvQsFU9nIQkcKcRRVTCFq3yUOOsVoBFgqxudDXPDRoctONdb+jd05X818yvF0o6RaKKy2QwsBtCTECXw/TcJDnOWrAO9yY8b5EULRQ2M4BfwsO6HWRSNUHZ8ZRGaq16wkAkvotSRsMlO5ulHEk8w15mBDdOZTf1YutypnZENhju9a0XNFuMK37cVdpFyJhu0mFct3gImGV6MWxpxCtmAtDLwXjVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2axCpfEpUw/lFBX37+lqcZ+XwWsj1GhOI3zXdhsSKZw=;
 b=hou5UaMKmbvZiMLjfyZSYqMlngsFCwrwTYndMzBtChxf/y9otMIesefTJUz399G1bRK/GSbx+UykxQzYqnf5GRdzamiFYuMHsBEHXPe3oCZXTrbNCbzoyGjJWVfM86fN1vsACGdsGgIr2Ak2O06vg/itN2W3+F7UK/TzPelauwCKzt/lVsoSVdtfaZfxYjrWNKxEbbuuWF3rNeFLEbJnsb5yldDBxW8a5DGSucSzHqkbR7gO4fVoTEZkAGvXORbhAbzUdO6OciH+waGQJQt4K3tQNi81zK7LEVkKlKuYxXIpbBPoCoXerO0Ec3LjfrstATf8/QPxr+DWEZsxNVLlOQ==
Received: from BL0PR02CA0126.namprd02.prod.outlook.com (2603:10b6:208:35::31)
 by DM6PR08MB6284.namprd08.prod.outlook.com (2603:10b6:5:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 21:49:12 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::ec) by BL0PR02CA0126.outlook.office365.com
 (2603:10b6:208:35::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Thu, 30 Nov 2023 21:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 21:49:11 +0000
Received: from BOW17EX19A.micron.com (137.201.21.218) by BOW36EX19B.micron.com
 (137.201.85.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Thu, 30 Nov
 2023 14:49:10 -0700
Received: from micron.com (10.3.67.194) by RestrictedRelay17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27 via Frontend
 Transport; Thu, 30 Nov 2023 14:49:03 -0700
From:   <sthanneeru.opensrc@micron.com>
To:     <aneesh.kumar@linux.ibm.com>, <hannes@cmpxchg.org>,
        <hasanalmaruf@fb.com>, <haowang3@fb.com>, <ying.huang@intel.com>,
        <gregory.price@memverge.com>, <dan.j.williams@intel.com>,
        <mhocko@suse.com>, <tj@kernel.org>, <hezhongkun.hzk@bytedance.com>,
        <fvdl@google.com>, <john@jagalactic.com>, <mirakhur@micron.com>,
        <vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
        <Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>
CC:     Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: [RFC PATCH 0/2] Node migration between memory tiers
Date:   Fri, 1 Dec 2023 03:18:56 +0530
Message-ID: <20231130214858.1887-1-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DM6PR08MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e81982-f278-4918-1683-08dbf1ee304e
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SI61F38wre6TCG5R3s1ckP/FWGvhPL3mY5tRaieF0UkqBrfXVfvb93LeDHAuCyKLuURsnX7fDg547oSGwQ6EWcHunFbuEvlUgNTdiqrf3z+piQHFBRTC3dqTP3MR3qjGd0aErFgEMWca82dvSFUuT+kVdqlB+rIyEONTSd2ZUQ6yjLD8op0pQSlPiL+HzFan7JFkP6brwr7QxlL+BxLHUigc89qZ+JBo7PkNFetquonBFWM/0rh7HNGPKqZ4AjFJWDhE+gjCGpNtJoZh5LSD55KqYOkOIPHJO4YXKYcmKL7zljFIH8nLTNlMQVycr6SNe3YYqycvALDvd/FY1SzxEvoZ6Hf9mTev2IKyBlFbTaZFHdzy6KIa4qccq/HZelcbnO26JFKaJjCvwOquvMOAgHIFATxlHRDxda5AtrysXEe6jZbCjmfnw4V1pCag9Z8iw6RLHHcWwwS7XoPNxkWu7F9vnTE5kWFF42njIF/YjK6Pir3mXWtBHgJ3R+nlD5g/yKp5yqi2rTBhKusRAVHEes/kOhFNNcQoEGki+Ojk2cSBA6gkmcgoXwJIQ7KsHZrei1pVo5ODafbvd7GPKStdS7w6IB8SEnyCSedD90oczYstcAFckjQvrgqVJcjwBQiz5MCyHSr3eB7gnxBLPEDrfs4uJzOW2PzqaAZyv2FQMWSsxuGMQrMksxqvlHRjcqgPGVU1wTE2UEgPyMgiKj4wjvwIRPTD/lVoaNBYanOJx6R1fTttgkTPDXEZP33+jWK6CoDSpI4LsqdtXDZOum6AvkxYNItPhJ0gdgSUkK2qsdo5MVs5YjHVkCOIkfKC6N3i
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(46966006)(36840700001)(107886003)(1076003)(921008)(40480700001)(47076005)(55016003)(7636003)(356005)(83380400001)(82740400003)(26005)(6286002)(41300700001)(36756003)(36860700001)(426003)(336012)(2616005)(6666004)(2876002)(40460700003)(2906002)(5660300002)(7416002)(478600001)(316002)(7696005)(70586007)(110136005)(70206006)(8936002)(86362001)(8676002)(4326008)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 21:49:11.6585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e81982-f278-4918-1683-08dbf1ee304e
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB6284
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

The memory tiers feature allows nodes with similar memory types
or performance characteristics to be grouped together in a
memory tier. However, there is currently no provision for
moving a node from one tier to another on demand.

This patch series aims to support node migration between tiers
on demand by sysadmin/root user using the provided sysfs for
node migration. Each tier has a start abstract distance(adistance)
and range.

To migrate a node to a tier, the corresponding node’s sysfs
adistance_offset is written with a value corresponding to
the tier’s adistance.

Example: Move node2 to memory tier5 from its default tier(i.e 4)

1. Check default values:
$cat /sys/devices/virtual/memory_tiering/memory_tier4/nodelist
0-2

$cat /sys/devices/system/node/node0/adistance_offset
0
$cat /sys/devices/system/node/node1/adistance_offset
0
$cat /sys/devices/system/node/node2/adistance_offset
0

2. Move node2 to  tier5:

To move node2 from emory_tier4 (adistance=512) to
emory_tier5 (abstract=640), set the `adistance_offset` of
node 2 to 128 (i.e., 512 + 128 = 640).

Tier4 adistance start can be derved from tier-id
(i.e for tier4, 4 << 7 = 512).

$echo 128 > /sys/devices/system/node/node2/adistance_offset
$cat /sys/devices/system/node/node2/adistance_offset
128

3. Verify node2's tier id:

$cat /sys/devices/virtual/memory_tiering/memory_tier5/nodelist
2
$cat /sys/devices/virtual/memory_tiering/memory_tier4/nodelist
0-1

Srinivasulu Thanneeru (2):
  base/node: Add sysfs for adistance_offset
  memory tier: Support node migration between tiers

 drivers/base/node.c          | 51 +++++++++++++++++++++++
 include/linux/memory-tiers.h | 11 +++++
 include/linux/node.h         |  6 +++
 mm/memory-tiers.c            | 79 ++++++++++++++++++++----------------
 4 files changed, 113 insertions(+), 34 deletions(-)

-- 
2.25.1

