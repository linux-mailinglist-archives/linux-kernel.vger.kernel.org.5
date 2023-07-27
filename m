Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1E76588A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjG0QWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjG0QWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:22:49 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFBA1984;
        Thu, 27 Jul 2023 09:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvmSQXwtOFRj0uxiLtT0U0zEqnv3u+q8p4vEVqjb8yuVtTbSdiFGkc7oFP6lz8DQFrASREnzVCgZ8wn+6kPk3kKe5Wn47+KCCT/8KqP8FtvG18pJuW31yAeU9pmIHfjq7lJ47e8eSb5+xy8BAp4HryFvbhFY5Gkp+zmFsk8HagAJ/JoR7EwUfy1FbD/pz/sOHtlx8QZoIIlZTTRpeuHT9HkcI7Iiq6Ma54kXvZKbm/p5jU4ev2dD0+waaIiQJFZoeWsH5HTc771+MDNdtbvuQ/UKTX20OimhVxzLMPYs+QTupP0XBIJXthmIDPsMu4ELoW4oQBHYib8AQG0CU60e9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOwvML5RTFNmFXFjCDBDvHt8TmESfzTFxj9zYvtwsXs=;
 b=UV+7OWAZGtoNwc6J5vERmmO8l69fDnBxDVxAUxO4EzP0JpIrzqNpAVrqX1ovhunuvLF6DL6nThHFm9RpWUhVSEL3XcHHqRoVkl+X+wmofT6/uBMTUWzWf6yVVHr8Cc/YDI2WRnH0YiS/BgocI7Ouwn2N8v88JwTHK0I/wtIu8VNrkHX4X4EOqX9YHVWjnOlYDeYhwLwvDpzcIpmjPAua/SOZ342SL2Q2diZROX0gkSybp/gv7+S8qaY377p2ORR/NHz221iwjJSpGed7iUPRUnVFv47j366OhD7pPWbQPbocVtvZAl3aEXYHstEGXIFjaYNtx07ltrOR339SV6WnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOwvML5RTFNmFXFjCDBDvHt8TmESfzTFxj9zYvtwsXs=;
 b=Jp6F0DzBc7+vcwffYscxVufu3WUPh898t0LdufSVpXW70wwdHEO/epIGMT3Jy8oSjAvfQZ4Y8GVJ7+xBTMxMtnGag66Amwc5St01sbpxa8wctHYdVVHYSVsVzXdHpfKf4AYAd75dFQcrHv+JxUu2ByQH/3IPpVXkXmE1CSmwBGs=
Received: from MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::20)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:22:45 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::43) by MW4P221CA0015.outlook.office365.com
 (2603:10b6:303:8b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:22:44 +0000
Received: from amd-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 11:22:43 -0500
From:   Baskaran Kannan <Baski.Kannan@amd.com>
To:     <babu.moger@amd.com>, <Mario.Limonciello@amd.com>,
        <baski.kannan@amd.com>, <clemens@ladisch.de>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Baskaran Kannan <Baski.Kannan@amd.com>
Subject: [PATCH v4] hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature
Date:   Thu, 27 Jul 2023 11:21:59 -0500
Message-ID: <20230727162159.1056136-1-Baski.Kannan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: a65a9f85-ed20-45cf-9e7f-08db8ebdb587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjI/6ZnqzDJxvyYEdq0FT8Z2RHhV30pmzxKPSNnJ8GsVczyHfKuTpu6yI25z3hMkCA6VLWjmmNec+IwclseYKkFMESy0y1r8Q3yFm7J8DWyOIMVdBvn0iVoWPPqvWXPsWQ2fdSS/QKXCAlq/0O4vawhdIL0BlJ9cXRnjnrC0bnIJc1m8sjL2t4vbendpzFJHFLveJXltEHJscOetC6VVOEEkPmUnkyHd3RPQWLu3+9xVPqALBueF17vcxBAeGB3cUXzyaJ2rYRqpZLWtox60TitwOcQ7qSjnx+tLdhwV93B6ELZFUn1sf/LRExClmlBEhUWqqZUffwvtebGlHi4Tlr3GTw7J0Oa+32LxyJrUdlyx/dh/43THlWvu45xpN+WKqELgwQPdNoX8BCF/SFFr9p+C4rkQdHttVzY9HKH0sgP6sn2Ws/OCZCHRRdxcW5qxUknoJLf8J1mr+yCIXrjMK3VZblwqtFCKKjyXDyfQW6KEnoxb3EN7BBROvtTzzQVxne+QdiFKe2f/6DqAuvHgPg0UK3B7pI9OrEjBCK0Tvt5lYdgsCKRu2FSkWVNfVBeZQWPy3OIld7r+p0LYrG9aVk+X5tHGqp7Miy9aFQ1lBneKK9wfbSMsIPm1K3+sInQmlK8qnGLXieh6lYEVNRynI6TkvtUcxVc1r4QfKbSSEEtt+Xcn9/v9osrlE//qb+aAu0yhxmvhhmGKdTHqnjllhjUlBBEOdjSKyWKloqV41NwZX47esmKuL4MdkqOoT0cl0fofd2VI6B+qqjmPUWBJ5JuExej/jM1/k2V4v4TgPzc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40460700003)(110136005)(6666004)(7696005)(81166007)(356005)(36756003)(2906002)(478600001)(82740400003)(316002)(8936002)(8676002)(5660300002)(41300700001)(40480700001)(70206006)(70586007)(4326008)(26005)(36860700001)(86362001)(1076003)(426003)(83380400001)(2616005)(47076005)(186003)(16526019)(336012)(966005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:22:44.7178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65a9f85-ed20-45cf-9e7f-08db8ebdb587
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Industrial processor i3255 supports temperatures -40 deg celcius
to 105 deg Celcius. The current implementation of k10temp_read_temp
rounds off any negative temperatures to '0'. To fix this,
the following changes have been made.

A flag 'disp_negative' is added to struct k10temp_data to support
AMD i3255 processors. Flag 'disp_negative' is set if 3255 processor
is found during k10temp_probe.  Flag 'disp_negative' is used to
determine whether to round off negative temperatures to '0' in
k10temp_read_temp.

Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
---
V4: Changed probe from model number to model id.
V3: https://lore.kernel.org/all/20230619165413.806450-1-Baski.Kannan@amd.com/

 drivers/hwmon/k10temp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 7b177b9fbb09..18c4deae82ba 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -77,6 +77,12 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
 #define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
 
+/* AMD's Industrial processor 3255 supports temperature from -40 deg to 105 deg Celsius.
+ * Use the model name to identify 3255 CPUs and set a flag to display negative temperature.
+ * Do not round off to zero for negative Tctl or Tdie values if the flag is set
+ */
+#define AMD_I3255_STR				"3255"
+
 struct k10temp_data {
 	struct pci_dev *pdev;
 	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
@@ -86,6 +92,7 @@ struct k10temp_data {
 	u32 show_temp;
 	bool is_zen;
 	u32 ccd_offset;
+	bool disp_negative;
 };
 
 #define TCTL_BIT	0
@@ -204,12 +211,12 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 		switch (channel) {
 		case 0:		/* Tctl */
 			*val = get_raw_temp(data);
-			if (*val < 0)
+			if (*val < 0 && !data->disp_negative)
 				*val = 0;
 			break;
 		case 1:		/* Tdie */
 			*val = get_raw_temp(data) - data->temp_offset;
-			if (*val < 0)
+			if (*val < 0 && !data->disp_negative)
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
@@ -405,6 +412,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	data->pdev = pdev;
 	data->show_temp |= BIT(TCTL_BIT);	/* Always show Tctl */
 
+	if (boot_cpu_data.x86 == 0x17 &&
+	    strstr(boot_cpu_data.x86_model_id, AMD_I3255_STR)) {
+		data->disp_negative = true;
+	}
+
 	if (boot_cpu_data.x86 == 0x15 &&
 	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
 	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
-- 
2.25.1

