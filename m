Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90E37B2D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjI2Hp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI2Hp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:45:26 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577A619F;
        Fri, 29 Sep 2023 00:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKILoyHEMUPWaWYqO0HhAIl8b2IInq2C2oziXNDqq0+i67XjK85URR5jSjX0xyE7L+eHmlsE/vzOUl42XRv/EelsI68MhcALoWGRrgE8wlkF/iqpb+sQlrSNr5gVwuX0kgXSaSZ9HCk8fg43V97MQ/AqaKRNZvxEb0i099/+3uU0rHLYYvsTDHIBBf1b5yKbZezQoQfARFDxmdoQOeBZj/zkTaPb2yBlWj+MCPKmWwh98uSKe5D/IQx5FM+3hkVc6HDOQc5lqwzbw54NTkosBcGuZ0xEm+AMLMfVu5IZ5AXz/nJt1wejBCmXf9uLfmCLv1EV/OXsUqveXzY1VSDKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXmCE1rvBgOuvT6SILRRApmDtghw4ohALvndSCtUpIw=;
 b=R02oV+hSA4ajkkeNQV5jHmQSg7LlwFq4NZI2uwK3hmIqRbTAg5FncKLFaM6VsjuhvXH3ePJFS8No1bksjf5Eykf/bt5wJfA2grjxMSg5zrCFcesuuhQvGkQ+Wccbk31JoyxBh6v+CphZN7en9is3bVc1d7w00r0ze9KdlX2v6RTR2dSs+2OR/ZoPQqNvRTQTW1RYXZUJ6KWqTQhAg2zqTCTi6d/D+9NDTzLg+9MHgwXup/Q+BKv8d1WwVNyE6C1Wf6D5wnwKuk98s8STg4+c9wvtx8jcFw6z/I7cZHguseTYmRdQVJFaslDdJ+JGVBla8dhYpjEoROJUGIpFOS4UKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXmCE1rvBgOuvT6SILRRApmDtghw4ohALvndSCtUpIw=;
 b=hnKONzW7aIfW2mkPMfLRHOv0atV+SR81JKOlXZPDPjWu2oAktlBEnAo7mhNrOhRi6KCF0Ex2vWSTkXw8ySk7PwJ/BZrZKDU+LEO8zQNNQ7x0jfZAONvBYNHxvyOJjhIA8OInN3Z0Sb9pbhQ5FS160mpqsOr1aHM/7f+Qqfz26UE=
Received: from AM6P192CA0081.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::22)
 by AS8PR02MB9162.eurprd02.prod.outlook.com (2603:10a6:20b:5b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 07:45:22 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:209:8d:cafe::26) by AM6P192CA0081.outlook.office365.com
 (2603:10a6:209:8d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 07:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 07:45:22 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 29 Sep
 2023 09:45:18 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 29 Sep
 2023 09:45:18 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 29 Sep 2023 09:45:18 +0200
Received: from pc45945-2140.se.axis.com (pc45945-2140.se.axis.com [10.88.125.80])
        by se-intmail02x.se.axis.com (Postfix) with ESMTP id 5E68C67A;
        Fri, 29 Sep 2023 09:45:18 +0200 (CEST)
Received: by pc45945-2140.se.axis.com (Postfix, from userid 10564)
        id 5A33B74D9C9F; Fri, 29 Sep 2023 09:45:18 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 0/2] mmc: Allow speed modes to be adjusted dynamically
Date:   Fri, 29 Sep 2023 09:45:07 +0200
Message-ID: <20230929-mmc-caps-v2-0-11a4c2d94f15@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOAFmUC/zXMQQ6CMBBA0auQWTukDmLBlfcwLuo42Fm0kBaRh
 HB3GxOXL/n5G2RJKhku1QZJFs06xgI6VMDexZegPouBDDWmpw5DYGQ3ZSRmyw317YMclHxKMuj
 6W93uxUMaA84+ifsPyJzLpDPG9PXR2ra1JzziopElzvXH68z+ndhf3aq55jHAvn8BHqDNkqEAA
 AA=
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|AS8PR02MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b868da0-a155-4a7d-47e8-08dbc0c00907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTNquJxSKW21qYIK4nXfpDLWF7AvntoKccKQCJ+I/xrlgly3C7JI+exDJo4ZGPdCw5VLFWRWufTx6PB6LSSE9RaV6JujXfNjVbdKu5q5NhUqOsQYkYWONDQBZvqx0NazHeh0GkuipUIus/NTinxohQpjloKKjTjWxxxNPnH3Cpct1Y8asV+rvfYjiMUyndWCsie3ZCB3YCSiYWogBd6tksU67DsEJka35+xvJpB0Z1peGHMqLKZngw0XgWqCaDpqen1XLXl6yqsgREy68fiY5Cw4MfgB9mWwAHpgM21tFh1YpFSXKjmaquwh95j8p+iocJ9hABecdL22cv6FuLOY20UZu39btLTIH7eDE9DTIn5DR5PErQMGOI7/wetaduO1JnueMmqTMCZsjKSUeDEdIj6b7zzmXXcqebk/7a4OJ1tJn/SFmRZXvKdgQ/Iin1/iBSqyC5WueWF+ITsx+8GLpEf6UUtXRcvxFrgdYA5Pk4mcPulLyzb/melo6tGS8dHhcOJcaBgOeWbA6J8A+omniGhS/GalMcIvk/oMOXDX2blcktAknroZ3HJgLI/nBZ7PRrLTGvtrBkzs2HYrUKnue/b88MBowyHX7iDiNDG+fHJS1FmiqnAQeG5fKIQ9OcNI9oIdY8h9154TqqQBJxbibExxB52szEHhJRQsxeu1UlEbaZTbv/DEWrD2nWHA9uOfmSu4+RsV69hVLhNcTIpjJjCQiZdP5wb+TsqYvVinEARuTIbyQXDzA7fll8yzIASpsIs4Hcmwegl7PVGkFZLY6g==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(36840700001)(40470700004)(46966006)(966005)(40480700001)(5660300002)(82740400003)(47076005)(356005)(40460700003)(6666004)(4744005)(83380400001)(316002)(81166007)(36860700001)(54906003)(70206006)(70586007)(2616005)(44832011)(26005)(42186006)(107886003)(426003)(336012)(41300700001)(4326008)(8936002)(6916009)(478600001)(6266002)(8676002)(86362001)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 07:45:22.0470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b868da0-a155-4a7d-47e8-08dbc0c00907
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9162
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During board verification, there is a need to test the various supported
eMMC/SD speed modes.  However, since the framework chooses the best mode
supported by the card and the host controller's caps, this currently
necessitates changing the devicetree for every iteration.  This series
provides a way to adjust speed modes dynamically via debugfs.

--
Changes in v2:
- Replace module parameter with a debugfs file.
- Add patch to move mmc_select_card_type().
- Link to v1: https://lore.kernel.org/r/20220623080009.1775574-1-vincent.whitchurch@axis.com/

---
Vincent Whitchurch (2):
      mmc: core: Always reselect card type
      mmc: debugfs: Allow host caps to be modified

 drivers/mmc/core/debugfs.c | 51 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/core/mmc.c     |  7 ++++++-
 2 files changed, 55 insertions(+), 3 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230928-mmc-caps-2cc7c3295b2a

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

