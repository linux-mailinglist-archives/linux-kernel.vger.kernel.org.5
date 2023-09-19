Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA51B7A6C24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjISUMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjISUMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:12:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC062BE;
        Tue, 19 Sep 2023 13:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNvMEgIMP9exqcNIucGxuRcW59puZ8w+tP/Vzz0ftGRDxsrlpfmCoYKegZ50fm2etp2pF096FhceXHHUhVxvqzd5+vpVDH1GXYemCrLm7fqLNyAdfhK45iiJtIKr01aSSSHngyw94H12Fudc/Azzg6/+ekPJKfRUf29CvGnZV016caBujHnrazsSzupGrg3hSyfRfbves49j/ijjgVT6Y7Bbf9abwRfFzIa8kE0+z/NVca1q/y79/eljdyPO2xOv4KI49+L6l7hAGNwxuMEqBb+EL/TcC23UAGhfrwGsYrSFTi/NEdWE1R5b1xpuf+qDSXgKG7eg05yr6noDjdkpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/nP1bLuHaVGMY1eyVk+VefilRMpgbXoYk1S2USd8t0=;
 b=fDSP+iqup4mRoI41n+5DcjHbegF3O1weR2/Sn35nZ6p6xn+dSMAYrYqK+3ni+2cZRdg92LpFaZxClF4GcfafVMr2tbYW9jwU/uqzby0nQkbmjuNj46NV2d+9vH5k0nkQwo4XU+eUb0Hf+kj8BDzkCaAnVLDepm0t0aIc5rxRuSbNiUBowirMK98RqM1IThZ5mjEcH2XfkSxceqomqwTyCLkOAYycDrPV9ggJ/f7V0gGNieRu/GrvaT12vAxNzwhvKAj2ekWPsvM5CdKySG6Qqcs5rSpeJ/NEMazI75oV+Su4f32nHXMbPCYlX+cXhldhCZGXa41eTr2Q7ZMHOzP8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipt.br; dmarc=pass action=none header.from=ipt.br; dkim=pass
 header.d=ipt.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipt.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/nP1bLuHaVGMY1eyVk+VefilRMpgbXoYk1S2USd8t0=;
 b=oan3j40wTYNtD+eMrRYl1ZuwA8XbT/YnBZCoih969XiCQXNVxE6a6/tnXSizbzC4zzFJjSL5HfPzFtlTxNgp6xDdJew94n9aSYf4WojNGRm3nSb+IIAIvFDBZlYbbJ5KBSyjEgpvoo133HbRJy/4K6h5F7OiG9DOsmXRe+9GbUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipt.br;
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1a4::6)
 by SCYP152MB5704.LAMP152.PROD.OUTLOOK.COM (2603:10d6:300:45::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 20:12:00 +0000
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::d973:8d11:70bb:7900]) by CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::d973:8d11:70bb:7900%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 20:12:00 +0000
From:   Fernando Eckhardt Valle <fevalle@ipt.br>
To:     hdegoede@redhat.com, mpearson-lenovo@squebb.ca, corbet@lwn.net,
        hmh@hmh.eng.br, markgross@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Date:   Tue, 19 Sep 2023 17:11:36 -0300
Message-Id: <20230919201136.63736-1-fevalle@ipt.br>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP3P284CA0062.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:6e::7) To CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:103:1a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPVP152MB5053:EE_|SCYP152MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 1222552e-bd09-4ff1-2228-08dbb94caee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SF/DGXwdh67CSailEnzjdm5gQLjoB0V/XWzv0eQkcIKAdGo991dItVbUBvvjGgWXnxPFrZs0hjSE5OQB8JTBXkZ86/NOjPDb4bSsJ/Y66XlA4/dCyWdRKLfxNCEtKsGava1tl1ALHQoSsyKWCJIVrIShPOrO2lxsigCUkrjNrj4lQp/GngwfVX2ewrKoRbJl7n5TZapAp8y95AbPYXfoI8J88w5mxb3hgdwjOEd24PZrUX8vsn1cnEn55FlLRJxUgA3Eks7gf5BYyuiuCtOFw7Yxr4T8z1ITlw9BpaZIJd8nnIyD/EPturkX2bKBFw2bpUHzwsiLOz0MC3FVH/yz1iqUPbHB5LzrZyEQ6cwQFmywRMrkEzrplJt2zkAAvbhQuQU+ajPs7GmCMv/fhgpEC7tj3HYz0kciuq58rQvhPLaKGZq8utibvbP4QkGJyNvj8yRIijHfng8psADeQdCy0ZkXs3VjL5CDFkoXCW3Uz+9JsIdOakFmM3/I8Vk9yF1Q1HnK0/BGeQQ0htnKqQxUh+YpLCkeouXLp5eWOtJKh9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39850400004)(451199024)(186009)(1800799009)(41320700001)(1076003)(2616005)(83380400001)(66946007)(5660300002)(66476007)(66556008)(8676002)(8936002)(41300700001)(2906002)(86362001)(38100700002)(966005)(478600001)(316002)(36756003)(6506007)(6486002)(786003)(6512007)(52116002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E07gb8AdvCJIOsDxVYUMwccMELIXWImL9GS8mMixJCGs9hXfxWnaGdMIcaMu?=
 =?us-ascii?Q?oOd7uhm9rMV4JGgAzpRMUtabLvFIcZSDVGPZAlMOqnT6JS5K4xGnaCK5lXnq?=
 =?us-ascii?Q?LFB89ROPElWasak4LkyI9BTBIxlEnGk/hlLXVIgDV/Ip27VTLV7JmD5GwKsJ?=
 =?us-ascii?Q?M6Rh1638n7e8v5Rvuw947shiMPVdZ+6RiPIrERhuyYF576jMpoKZTmBF/K4E?=
 =?us-ascii?Q?EHhu/Gr1B61rw+FV4nvmae6z3QpvTu6YajqV+vzJh4O5a+gW4gNeIgwQqm02?=
 =?us-ascii?Q?JtVPgteyFXrKXF0AK4yVA7jjD8qpL0HJuXMTZrjeqjrXOYlxLblHh2J8HnXW?=
 =?us-ascii?Q?bKM0jiAB1uL56CoFjnlpszcxzyRZBUor3AgO/JrwpyE2vE10/UnFl6DwvAtx?=
 =?us-ascii?Q?BqtvOefMFllyU+RAaZ93cgiGHKw2N6dQcNiyrcENPNiL/UgpuMeZ/idHg9iC?=
 =?us-ascii?Q?aK5PWIPKYyypFDyMya6VbBcqNk24+spVnC+2jywQwWzDS6MVU7UtUrlxQ4PB?=
 =?us-ascii?Q?VYBtxZ2QjCmfWcKg8DNj4XMFQ0cLWEOFeeP+a4ZJJODPWI9V6+liipmlSOz8?=
 =?us-ascii?Q?pD7K1Zoxybn3jnJ+L26qH2y4FwPGDt6QVg2q4oWSJS2YM6T21XOwvXhRjkLs?=
 =?us-ascii?Q?bkmtP/qgiFyEjwUpG2VRk0ZB2c/hB8+N7JIA1NWi8zY5pq0SjRPCCzB+Unq0?=
 =?us-ascii?Q?AeoSO1vwstPrEMqKgbCP6NpEPD9LmWS3YbYoaTpqt2Pk/oqWjezrsD/vSRH8?=
 =?us-ascii?Q?VS0rkZ6gszjNEL8K+9KgEfZfrim/3RP+pqqyJHaJMdf/Pjt81pKa+ue5lniL?=
 =?us-ascii?Q?uB6xLhxbz9gRVWt7Qqh1H3BSMkmEFOWMwtTADyNBQOvw3XYtOqa5/JLyzZy8?=
 =?us-ascii?Q?zaAmJgdrRVvJrm2k5Tlb4TFwjG61Hhq898rPFX7oDJ4wZSQoyc+5UjVoMpKE?=
 =?us-ascii?Q?6Ph/Pf9UEcTcpNaePY+JwdWCaMwlxzzbq5W0PH7yG4tf1TF2YO13w+S9oHtd?=
 =?us-ascii?Q?kEajWEZrkelmMC76RDRC0pSB4Kei9rp9AO/rdBkdSxBwueCGIYLR2803+SWo?=
 =?us-ascii?Q?3owDLh77RN2DsqCdlrN/dhT9v6pUyf6YL9GSE8YpZ2M+JpsR8G7zXpKk0672?=
 =?us-ascii?Q?cFjxS+spz84vDRwnUu18K42QulMh39yRTO3KmRELrMoTTRzzM+4u7TSOaGex?=
 =?us-ascii?Q?USYK9Bv/xzsapbqmb2cxfiOPBJtYKEQSN8bauNUn2GDaDLIQDnsayIBlnHmo?=
 =?us-ascii?Q?TLD3VWYaSXZGmFqDSeQo45OolFyKngO2Hg/paln5dWKm6xovttMn2dOl4xZV?=
 =?us-ascii?Q?/NLlQBvKHVHreH0r92Gw5LQ4oIuqCnJCnJ8Yt0+KYDDRwTqfy8+lJ8vV/W80?=
 =?us-ascii?Q?yevnB8B5eJbiXrhUFj/PPJaKQ2JMNiG9/wl+CzW9PZWoFjVXOaBwnYGMgDQl?=
 =?us-ascii?Q?LOVqzLf0qOQjfItKFeML/aa7/YwWEOjjOIlWAvK6yMqIOD7rgAg/DLtrA5kM?=
 =?us-ascii?Q?dFc1/Cx/SksPQ4cNf26eEzkgUQatJUXTPSt2ewZktydmdhUaODi5lLJda55S?=
 =?us-ascii?Q?VRquRbfcso3jCmYQ4PD76OgtOBJ0rokN4PL/tvbpWXQRN4pnJHThIImb0WyE?=
 =?us-ascii?Q?Jd8tl5Ki30/dN/4jFxKGay7qP+5ZxfEUZtXqSCvg7IMA?=
X-OriginatorOrg: ipt.br
X-MS-Exchange-CrossTenant-Network-Message-Id: 1222552e-bd09-4ff1-2228-08dbb94caee1
X-MS-Exchange-CrossTenant-AuthSource: CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 20:12:00.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aab57f47-5b85-4924-8047-691190100bd7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZ/qLrzm8XG5c0L2BLvskjbk2//KDr54EofL9auIi0NWcOcBYsmgqVxH3E8dZ0Sc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SCYP152MB5704
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Thinkpads have a feature called MAC Address Pass-through.
This patch provides a sysfs interface that userspace can use
to get this auxiliary mac address.

Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
---
Changes in v3:
- Added null terminator to auxmac string when copying auxiliary
mac address value.
Changes in v2:
- Added documentation
- All handling of the auxmac value is done in the _init function.
---
 .../admin-guide/laptops/thinkpad-acpi.rst     | 20 +++++
 drivers/platform/x86/thinkpad_acpi.c          | 81 +++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
index e27a1c3f6..98d304010 100644
--- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
+++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
@@ -53,6 +53,7 @@ detailed description):
 	- Lap mode sensor
 	- Setting keyboard language
 	- WWAN Antenna type
+	- Auxmac
 
 A compatibility table by model and feature is maintained on the web
 site, http://ibm-acpi.sf.net/. I appreciate any success or failure
@@ -1511,6 +1512,25 @@ Currently 2 antenna types are supported as mentioned below:
 The property is read-only. If the platform doesn't have support the sysfs
 class is not created.
 
+Auxmac
+------
+
+sysfs: auxmac
+
+Some newer Thinkpads have a feature called MAC Address Pass-through. This
+feature is implemented by the system firmware to provide a system unique MAC,
+that can override a dock or USB ethernet dongle MAC, when connected to a
+network. This property enables user-space to easily determine the MAC address
+if the feature is enabled.
+
+The values of this auxiliary MAC are:
+
+        cat /sys/devices/platform/thinkpad_acpi/auxmac
+
+If the feature is disabled, the value will be 'disabled'.
+
+This property is read-only.
+
 Adaptive keyboard
 -----------------
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d70c89d32..ccb4969ac 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10785,6 +10785,82 @@ static struct ibm_struct dprc_driver_data = {
 	.name = "dprc",
 };
 
+/*
+ * Auxmac
+ *
+ * This auxiliary mac address is enabled in the bios through the
+ * MAC Address Pass-through feature. In most cases, there are three
+ * possibilities: Internal Mac, Second Mac, and disabled.
+ *
+ */
+
+#define AUXMAC_LEN 12
+#define AUXMAC_START 9
+#define AUXMAC_STRLEN 22
+#define AUXMAC_BEGIN_MARKER 8
+#define AUXMAC_END_MARKER 21
+static char auxmac[AUXMAC_LEN + 1];
+
+static int auxmac_init(struct ibm_init_struct *iibm)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+
+	status = acpi_evaluate_object(NULL, "\\MACA", NULL, &buffer);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	obj = (union acpi_object *)buffer.pointer;
+
+	if (obj->type != ACPI_TYPE_STRING || obj->string.length != AUXMAC_STRLEN) {
+		pr_info("Invalid buffer for MAC address pass-through.\n");
+		goto auxmacinvalid;
+	}
+
+	if (obj->string.pointer[AUXMAC_BEGIN_MARKER] != '#' ||
+	    obj->string.pointer[AUXMAC_END_MARKER] != '#') {
+		pr_info("Invalid header for MAC address pass-through.\n");
+		goto auxmacinvalid;
+	}
+
+	if (strncmp(obj->string.pointer + AUXMAC_START, "XXXXXXXXXXXX", AUXMAC_LEN) != 0) {
+		memcpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_LEN);
+		auxmac[AUXMAC_LEN] = '\0';
+	} else
+		strcpy(auxmac, "disabled");
+
+	kfree(obj);
+	return 0;
+
+auxmacinvalid:
+	kfree(obj);
+	strcpy(auxmac, "unavailable");
+	return 0;
+}
+
+static struct ibm_struct auxmac_data = {
+	.name = "auxmac",
+};
+
+static ssize_t auxmac_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return sysfs_emit(buf, "%s\n", auxmac);
+}
+static DEVICE_ATTR_RO(auxmac);
+
+static struct attribute *auxmac_attributes[] = {
+	&dev_attr_auxmac.attr,
+	NULL
+};
+
+static const struct attribute_group auxmac_attr_group = {
+	.attrs = auxmac_attributes,
+};
+
 /* --------------------------------------------------------------------- */
 
 static struct attribute *tpacpi_driver_attributes[] = {
@@ -10843,6 +10919,7 @@ static const struct attribute_group *tpacpi_groups[] = {
 	&proxsensor_attr_group,
 	&kbdlang_attr_group,
 	&dprc_attr_group,
+	&auxmac_attr_group,
 	NULL,
 };
 
@@ -11414,6 +11491,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.init = tpacpi_dprc_init,
 		.data = &dprc_driver_data,
 	},
+	{
+		.init = auxmac_init,
+		.data = &auxmac_data,
+	},
 };
 
 static int __init set_ibm_param(const char *val, const struct kernel_param *kp)
-- 
2.25.1

