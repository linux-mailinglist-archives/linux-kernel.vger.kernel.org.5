Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F4B7672E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbjG1RHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjG1RHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:07:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267BBB5;
        Fri, 28 Jul 2023 10:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kfn9C2wYX5vprDHLalt/JcVa2fqn64VU0tKXlJkwyW1kxxXAI80gy6eY0SSZYGrJ1FE4q0M53YbVh7fXuJfNgLB2NqHvIztcgm8G0TQLFAon+wvfCEEWUX0ghwLbSqI2+SA9vWaCNG5qRJtdl+beMhkQnaDB+jydXcuEG/un3+LW03PdE7FmNHqIroi9GlhbHMEDDDPlkmuIBX376206Ho7zEZKE9TMnEWDJHKWni5q94oRY4wyq4CiVaZlZHPTi8R25jiK+1iTgk/vDaCTtaXqv9+7fPIv8mshDmP9AG/jmKRsMTs+a2WN2QVSA67gaVuS3PyFP+KjCL52Wm9eAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb8fk3c6owXtbs0RJr9UCcTG6YiCOgLA8W5ZtA7S1NI=;
 b=We/XeERDNM8dWEdNo1pF8TO74rnPAZ87J0aYelAGWC+NwXjAHTDJPVi0opWX3a8+IXsWlYkrEOUvnWAm7Oe1PcNP31i/crhW/qnAGNGoJHDossXTFK8j9VmbK3h/pwYi+cd4RDKRwVaEQcDAcvSGIGdE7r3pk6pWU9Dl0UHDjiXGxT9dz/EazZFgMRUKtJZY/jn8G0D+8rDj3/bvl7b4grbMI7QnNOyhOpvYmJkM8QdgZUjIk9q27LBhaZXx9EOS9bNDef1VWYpUL/Z0Fif2gDnKQDItvC+BOzp0WDQffufWN3/+fgYcPODWwh69F1vboi31+w7y6XP0y86Gwi6gMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mb8fk3c6owXtbs0RJr9UCcTG6YiCOgLA8W5ZtA7S1NI=;
 b=gKWJSoQaSchbyyeho+FDfRSzqrF4yteEDKDz9xlfaIaPWCz+aMcLcWfLcJcmDTlqE+9u3wgrzhADpGj+zmOhB94kg0Igmtn8yYKEC+7hRzxExaxaMFiomAw/U8UBQdJyiYiOTQsoxIBQg4MWNMV//MUud5ORhXeL389E2CICGhI=
Received: from BN9PR03CA0437.namprd03.prod.outlook.com (2603:10b6:408:113::22)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:07:04 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::b5) by BN9PR03CA0437.outlook.office365.com
 (2603:10b6:408:113::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 17:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.35 via Frontend Transport; Fri, 28 Jul 2023 17:07:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:01 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 28 Jul 2023 12:07:01 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH V12 1/5] of: dynamic: Add interfaces for creating device node dynamically
Date:   Fri, 28 Jul 2023 10:06:54 -0700
Message-ID: <1690564018-11142-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
References: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 449d302c-5e18-4264-6162-08db8f8d1131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtYO3PNkEcrZqNy2d68cqFrC7yO2OUF+r+d1+AzR1MUWxQWQfzr6SZwCyJmCw92HdSh+IHTAwYkBOdY/ldMnI6+ImFqYp0tKHtFGZIkT+WdSlmiIYGO3eQKPaYDhyFjy7ws5TjeWJx/LDmoY0Sv+9w0LY9+0u7JVCy3puGtxwuMc5HNLmJOa4x9kYIfI4fJGmmY/PnNoIWkf4ZzjCcaKpOhMYu3+x9hwwcqi9oJ6t9aE9JNxTQ+QrEnxAgirRsW44YUdLlpShQ79q8HW5o0KxbfPhFrwVCU505vgBwkCWEywrdovg4vtb6DJj+LftVL+sEucT6J9/tcpGXnFo70lJB25AgAG3Z8ZdOVfgwZ5pY/YAohD5zsTau3XM9vl88/dXIMmXBdl1CX6tIVO/mjdyNa+nwuHs3wySg6tenOlGdXt65crDM5hSpeo4y7ySZd6SvaMfQP04cWUrmWBe/cFLAhw5gp725xFlxzvUYAXjPmAH5aoAw0Fbn0fRrLhNsp3zXhdh/q285iPXn1wdUstgUI/R1S4jWvYcCa8hD8bpAC/MWY9KtnbE44haItyWdMVgtjQXUB0W8VLs5aQpchwLzdv96c4ehmbVdVQROpVZIoOChbGKde9JsT7RpUmGrbgGQGeo1pECHn3tQCxH4gv+kpwhRvq3FYRoEKbCpPKF+/osHwUd/EdvxtLGjuPkuzjrT00nguBkjfh9652eEzE5JTNoiPm9lX9pNwH8p+XAvuBZTf+wNsIlmR7lRQE238UVjnm4KqjyAH5PvE9ltOTSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(2906002)(66574015)(426003)(83380400001)(6666004)(2616005)(36756003)(336012)(186003)(44832011)(5660300002)(86362001)(47076005)(36860700001)(40460700003)(8676002)(41300700001)(316002)(8936002)(26005)(356005)(70586007)(4326008)(70206006)(478600001)(40480700001)(110136005)(54906003)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:07:04.4354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 449d302c-5e18-4264-6162-08db8f8d1131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_changeset_create_node() creates device node dynamically and attaches
the newly created node to a changeset.

Expand of_changeset APIs to handle specific types of properties.
    of_changeset_add_prop_string()
    of_changeset_add_prop_string_array()
    of_changeset_add_prop_u32_array()

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/of/dynamic.c  | 164 ++++++++++++++++++++++++++++++++++++++++++
 drivers/of/unittest.c |  19 ++++-
 include/linux/of.h    |  23 ++++++
 3 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index e311d406b170..9259cebda4d6 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -487,6 +487,38 @@ struct device_node *__of_node_dup(const struct device_node *np,
 	return NULL;
 }
 
+/**
+ * of_changeset_create_node - Dynamically create a device node and attach to
+ * a given changeset.
+ *
+ * @parent: Pointer to parent device node
+ * @full_name: Node full name
+ * @cset: Pointer to changeset
+ *
+ * Return: Pointer to the created device node or NULL in case of an error.
+ */
+struct device_node *of_changeset_create_node(struct device_node *parent,
+					     const char *full_name,
+					     struct of_changeset *cset)
+{
+	struct device_node *np;
+	int ret;
+
+	np = __of_node_dup(NULL, full_name);
+	if (!np)
+		return NULL;
+	np->parent = parent;
+
+	ret = of_changeset_attach_node(cset, np);
+	if (ret) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	return np;
+}
+EXPORT_SYMBOL(of_changeset_create_node);
+
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
 	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
@@ -960,3 +992,135 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_changeset_action);
+
+static int of_changeset_add_prop_helper(struct of_changeset *ocs,
+					struct device_node *np,
+					const struct property *pp)
+{
+	struct property *new_pp;
+	int ret;
+
+	new_pp = __of_prop_dup(pp, GFP_KERNEL);
+	if (!new_pp)
+		return -ENOMEM;
+
+	ret = of_changeset_add_property(ocs, np, new_pp);
+	if (ret) {
+		kfree(new_pp->name);
+		kfree(new_pp->value);
+		kfree(new_pp);
+	}
+
+	return ret;
+}
+
+/**
+ * of_changeset_add_prop_string - Add a string property to a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be added
+ * @str:	pointer to null terminated string
+ *
+ * Create a string property and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_add_prop_string(struct of_changeset *ocs,
+				 struct device_node *np,
+				 const char *prop_name, const char *str)
+{
+	struct property prop;
+
+	prop.name = (char *)prop_name;
+	prop.length = strlen(str) + 1;
+	prop.value = (void *)str;
+
+	return of_changeset_add_prop_helper(ocs, np, &prop);
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_prop_string);
+
+/**
+ * of_changeset_add_prop_string_array - Add a string list property to
+ * a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be added
+ * @str_array:	pointer to an array of null terminated strings
+ * @sz:		number of string array elements
+ *
+ * Create a string list property and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_add_prop_string_array(struct of_changeset *ocs,
+				       struct device_node *np,
+				       const char *prop_name,
+				       const char **str_array, size_t sz)
+{
+	struct property prop;
+	int i, ret;
+	char *vp;
+
+	prop.name = (char *)prop_name;
+
+	prop.length = 0;
+	for (i = 0; i < sz; i++)
+		prop.length += strlen(str_array[i]) + 1;
+
+	prop.value = kmalloc(prop.length, GFP_KERNEL);
+	if (!prop.value)
+		return -ENOMEM;
+
+	vp = prop.value;
+	for (i = 0; i < sz; i++) {
+		vp += snprintf(vp, (char *)prop.value + prop.length - vp, "%s",
+			       str_array[i]) + 1;
+	}
+	ret = of_changeset_add_prop_helper(ocs, np, &prop);
+	kfree(prop.value);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_prop_string_array);
+
+/**
+ * of_changeset_add_prop_u32_array - Add a property of 32 bit integers
+ * property to a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be added
+ * @array:	pointer to an array of 32 bit integers
+ * @sz:		number of array elements
+ *
+ * Create a property of 32 bit integers and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
+				    struct device_node *np,
+				    const char *prop_name,
+				    const u32 *array, size_t sz)
+{
+	struct property prop;
+	__be32 *val;
+	int i, ret;
+
+	val = kcalloc(sz, sizeof(__be32), GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	for (i = 0; i < sz; i++)
+		val[i] = cpu_to_be32(array[i]);
+	prop.name = (char *)prop_name;
+	prop.length = sizeof(u32) * sz;
+	prop.value = (void *)val;
+
+	ret = of_changeset_add_prop_helper(ocs, np, &prop);
+	kfree(val);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_prop_u32_array);
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index a406a12eb208..d2b286d32db0 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -802,7 +802,9 @@ static void __init of_unittest_changeset(void)
 	struct property *ppname_n21, pname_n21 = { .name = "name", .length = 3, .value = "n21" };
 	struct property *ppupdate, pupdate = { .name = "prop-update", .length = 5, .value = "abcd" };
 	struct property *ppremove;
-	struct device_node *n1, *n2, *n21, *nchangeset, *nremove, *parent, *np;
+	struct device_node *n1, *n2, *n21, *n22, *nchangeset, *nremove, *parent, *np;
+	static const char * const str_array[] = { "str1", "str2", "str3" };
+	const u32 u32_array[] = { 1, 2, 3 };
 	struct of_changeset chgset;
 
 	n1 = __of_node_dup(NULL, "n1");
@@ -857,6 +859,17 @@ static void __init of_unittest_changeset(void)
 	unittest(!of_changeset_add_property(&chgset, parent, ppadd), "fail add prop prop-add\n");
 	unittest(!of_changeset_update_property(&chgset, parent, ppupdate), "fail update prop\n");
 	unittest(!of_changeset_remove_property(&chgset, parent, ppremove), "fail remove prop\n");
+	n22 = of_changeset_create_node(n2, "n22", &chgset);
+	unittest(n22, "fail create n22\n");
+	unittest(!of_changeset_add_prop_string(&chgset, n22, "prop-str", "abcd"),
+		 "fail add prop prop-str");
+	unittest(!of_changeset_add_prop_string_array(&chgset, n22, "prop-str-array",
+						     (const char **)str_array,
+						     ARRAY_SIZE(str_array)),
+		 "fail add prop prop-str-array");
+	unittest(!of_changeset_add_prop_u32_array(&chgset, n22, "prop-u32-array",
+						  u32_array, ARRAY_SIZE(u32_array)),
+		 "fail add prop prop-u32-array");
 
 	unittest(!of_changeset_apply(&chgset), "apply failed\n");
 
@@ -866,6 +879,9 @@ static void __init of_unittest_changeset(void)
 	unittest((np = of_find_node_by_path("/testcase-data/changeset/n2/n21")),
 		 "'%pOF' not added\n", n21);
 	of_node_put(np);
+	unittest((np = of_find_node_by_path("/testcase-data/changeset/n2/n22")),
+		 "'%pOF' not added\n", n22);
+	of_node_put(np);
 
 	unittest(!of_changeset_revert(&chgset), "revert failed\n");
 
@@ -874,6 +890,7 @@ static void __init of_unittest_changeset(void)
 	of_node_put(n1);
 	of_node_put(n2);
 	of_node_put(n21);
+	of_node_put(n22);
 #endif
 }
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 6ecde0515677..82d0a476ec75 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1580,6 +1580,29 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
 {
 	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
 }
+
+struct device_node *of_changeset_create_node(struct device_node *parent,
+					     const char *full_name,
+					     struct of_changeset *cset);
+int of_changeset_add_prop_string(struct of_changeset *ocs,
+				 struct device_node *np,
+				 const char *prop_name, const char *str);
+int of_changeset_add_prop_string_array(struct of_changeset *ocs,
+				       struct device_node *np,
+				       const char *prop_name,
+				       const char **str_array, size_t sz);
+int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
+				    struct device_node *np,
+				    const char *prop_name,
+				    const u32 *array, size_t sz);
+static inline int of_changeset_add_prop_u32(struct of_changeset *ocs,
+					    struct device_node *np,
+					    const char *prop_name,
+					    const u32 val)
+{
+	return of_changeset_add_prop_u32_array(ocs, np, prop_name, &val, 1);
+}
+
 #else /* CONFIG_OF_DYNAMIC */
 static inline int of_reconfig_notifier_register(struct notifier_block *nb)
 {
-- 
2.34.1

