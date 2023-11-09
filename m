Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABC67E6318
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKIFO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKIFO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:14:56 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFD62683;
        Wed,  8 Nov 2023 21:14:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGUPe81qbMInYCDkKfGcg6WMLCOfo/G34xRmDonRIiXxGEy0GzyMfo8I0leFiFYnJ9oLyZeKIzOqCjY/G+9XLZF8sYfHTC/FGsGJYj6pFxtpWqEVCs/X/lebwWTrh5n9pWxi276rvUTVqs9YqUWZ7rn/CU8iAzeUv2k6n+bHigMmGss8l9v3A5/x9BV18Obt6e2WrysRm0omQTzfiUcKRb3q7KG6L1OyQoF/1BBf59aBZ7yGfewqYyai46W6E5dQFjzD15rHqhGIzpIXmgewHGBdbJt/LuNgtvfl8H6wYIExIOLXzP6l0R2521iumXXhnr/cnYnH+EZqJZ72cHciEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nj2tWhABRbAFCcr1uzEsJpvMr/2MFhINkOqvTWnMVYY=;
 b=Q9vyBDcWtHdYEhv0gCNbX0f1vCyfiQNM0JCcVxAetRQYmhzfoKzDOMCdhM+VkaH8nyPu4z0iongddx9gHNqajPDXfM28UFhxS7XKhqhf25ttcHxjzJK1jJu3exNOyYPqIutNkQc5t7PqqQmV14vw0G2kxV06sO2F6piYzQ0fwKHoI6DSXCca1QkJgPHXDCVSqSM7q6UaZc6LNxBCYQ2HFgHHFCj+bZK/s32cji6JKaOrsU7Pyq0IfueScnNxwN3DmJKz73JwWgW9RZzXH0xnvPctmCvZw8rYGr766x72nh9Ce5zOl224Dt7GZEvDFVZJ8IEBSu9/KAHv6nleNltKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj2tWhABRbAFCcr1uzEsJpvMr/2MFhINkOqvTWnMVYY=;
 b=Xe8SwpM64CZTDq2aV9acpWV8cxJA++TAr/xQkqdiU/R4sKXf3jY1G9o6tun10E9Zj3HoKIAM2x3RSkB2MRWs35BNs+36myMQioHJ2RVhi72ovFO3ItX3BVCLvJfIufsV+TzXipme8RLqELpLYUImYmBEkPVU4yPuTSFQ0zQ1utQ=
Received: from CH2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:610:50::28)
 by CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 05:14:50 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::5e) by CH2PR16CA0018.outlook.office365.com
 (2603:10b6:610:50::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 05:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 05:14:50 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 23:14:48 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] hwmon: Add a new macro sensor_sysfs_attr
Date:   Thu, 9 Nov 2023 13:14:29 +0800
Message-ID: <20231109051429.2250774-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CH0PR12MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3467de-73c2-4830-29e2-08dbe0e2ccb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvSm3NkDtYbIuUJ1v7ZlDcELvn3004FnBYIojAwQ6aTrp5sxy5JI7X7ufHpUskqdW6ZF4PrthTijOUiRLVzzk0+GJWD8+KlbKRh5N2oh+TWZ4vwymopM+LGNJVvkuHSOz0wq5WiUYic35VF2Dx4pSTePtVU12f5NYAB9W7i6v/bX8d44uEdpNWDtmaLHSGOhHo2B2UZnLenaKb6PEhORZyDSqeegBkkQdHqX6CaWaHm161r/Bdmu6eMraV+29rxaplFHtE0ZaPaNjvfxp3negCOhk6rqy8kRnqJ3XdJm2XdlL9sH0n07iFXq5NQ8KmGLf48zZuqu0Am5eh+fTT4cw5LyevqQpYJl9GrKTwbzhPt7TviAfF404lWK82SQ7hcxi/hamup8/KRYgrb74cBxEdyDnuP/uwOVgxZK364NCjBwb/634vP3jl6qAT1Dw/ZmN1j9L4KauU42sgKYoXTQHuONCYl9QmVvz83km12p8X8ool7loDF1H7TFivh4iDdMSxzrgxP52Vm7+Rx+7LCI046KyegZ65mhB/ccTmz+SA8Pg1qsMPhz7n0BifcYnEVAV17XrzvZYlCquE/ND4eUagvg0j+3eVFAc8RHVK1G1skucWgtJOHCC3KvJZco0CvjVmZrqYemtPoEAX+BT9uZylvJDtAwC4rtYBoHv8wFGI1z0VsvUAUcRD0zthT4LNQTQ3i1mbG0UuKTZl5fO5EU7UQTJ1e4RtmYutAMFRYjF7D3plw2dYuwKPJpxh6FM1MH+ILyFhM2UD+xcQ6MNHcq1ZJjQpx7W6dh3XDyXfeIxy4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(64100799003)(46966006)(40470700004)(36840700001)(5660300002)(4744005)(2906002)(86362001)(70206006)(8676002)(316002)(8936002)(70586007)(110136005)(4326008)(40460700003)(36756003)(41300700001)(1076003)(82740400003)(26005)(16526019)(2616005)(81166007)(336012)(426003)(7696005)(6666004)(47076005)(356005)(36860700001)(40480700001)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 05:14:50.3931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3467de-73c2-4830-29e2-08dbe0e2ccb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The attribute definiations like &sensor_dev_attr_xx_xx.dev_attr.attr
are widely used in drivers. So add a new macro sensor_sysfs_attr t
to make it easier to understand and use.

For example, user can use the sensor_sysfs_attr(xx_xx) instead of
&sensor_dev_attr_xx_xx.dev_attr.attr

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 include/linux/hwmon-sysfs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
index d896713359cd..7feae637e3b5 100644
--- a/include/linux/hwmon-sysfs.h
+++ b/include/linux/hwmon-sysfs.h
@@ -14,6 +14,10 @@ struct sensor_device_attribute{
 	struct device_attribute dev_attr;
 	int index;
 };
+
+#define to_sensor_sysfs_attr(_name) \
+	(&sensor_dev_attr_##_name.dev_attr.attr)
+
 #define to_sensor_dev_attr(_dev_attr) \
 	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
 
-- 
2.34.1

