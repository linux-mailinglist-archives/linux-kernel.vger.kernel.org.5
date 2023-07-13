Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7607B7517D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjGMFEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGMFED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:04:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888EE198A;
        Wed, 12 Jul 2023 22:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KN3kqW25gQd+93SBO1ZX76kQHx1XoiUQ5Xprj7dHZ/7kt9Kw7ssknYAG0HqJ/A4eNWF+aZXMdJmb3SsLbWcLBiItD1qXMYn140AbeCfwSP1tj/AbIQoLyiPShvdP66ttNijeQRORihVjEC9+NJgA1KXmdjQqkqsXIvpcqipK9Bnr+MPDQvC4c3EV+BLeMEx8IYsPAH+nMrNzJy2873Z4fJSh+H1wKVBwNuYfiWbaZfw1sNTsFGktyNM2+G+qiQaQ+J3hSLTjEOv3HITlfL/q5fnF4W36+DIu6y7J19hOTvnV++FrDJLvtDJ19Ap17KQ2NpzX5CmKhnPh6jxE6+i6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhMH3LanOS0z/3Y+4cwZ71pR4RNRJj01gVr1mzHZ22w=;
 b=HIkfGHQz6v/LpwJt/lU9TUEzrKxOPYKAXZcTHPSdaDAriJ2yaY8sCRBzq4TYK/OMph5Qdu/rIrQlf3fuy12YeV1OXel1U80nYRz4W4j97HWBJU3VdX4layF6yCVS6G2xblCWroRmrcexUYXG8AIAOBKQLIVVq2HPTZDQLUc+HuDAr6tMz2MbYrynb0iGVK3a5srOs29qewRuy9/2fOFnSr6jwGpFyr3hGfuFqJ57h/LDb92L4ICfgS2E/+82G/DDgR0MpuIsScYa2eA4c8Qe5orU4DD70IIA9cJes+CvdijrDQWuJVKUGsOJXIkc35wpBZgB4qnw/8M1LXxrW0GgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhMH3LanOS0z/3Y+4cwZ71pR4RNRJj01gVr1mzHZ22w=;
 b=c9oFWrvKvplS/GIhCqjG4ebYdNPyMCTCASaUAdc7E4nvdmw57n1jvm2Wyqs8d6GQIlbAlKYZ82oVWHy+8MqTHbLMpouVAVPvCceipEMMdPZqu+QDIppQOber2v7mqidxmY7v8mQ+SMZUk8gwndn0KXi2ucl/EYXnW2Pd46oHjtJtT2g39MLCSSyV9ZEJVwErxW9DXIOZ5Ajlmkz4Nt67vwKOjBEKbP6CiKpbY6pWHvjcmaRYMxrGcdKctEEtWyP46HDkSY5ksnOiJzvHU98uikqgRTIQZkIQI8254YaJUjaKzBTmqPd0iL5tKxZ2aJbZ+E+kz3sgZnyx5cxTsaENsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEYPR06MB5791.apcprd06.prod.outlook.com (2603:1096:101:b3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Thu, 13 Jul 2023 05:03:51 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 05:03:51 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com (open list:LSILOGIC MPT FUSION DRIVERS
        (FC/SAS/SPI)),
        linux-scsi@vger.kernel.org (open list:LSILOGIC MPT FUSION DRIVERS
        (FC/SAS/SPI)), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers/scsi: mpt3sas: fix parameter check in two functions
Date:   Thu, 13 Jul 2023 13:03:41 +0800
Message-Id: <20230713050341.3736-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEYPR06MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 69589471-90cc-4398-0649-08db835e8c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esfIJfemsYeKgpJA4SIY+zQCEts0OSBjbrbDrCs1OhxUNDBRVlyfBsmvviQk2nw9sSRL90cfQP7Tc5OYR098Z/mYU/Yi96pIVKZifVAHvmRo2ta+vFGmdRIIZKVHPGipieb33tazXL9T8sIrJzRQuLxncnQyqOXyeC29x/HULuxG6U++m44hjjWPg6FVMKl3V16pUFZd/jbXt2vPLkYj4wTIgZ8kF1It1frHwccU9tDH1KOoXpzzmOFqFjoF2QE/o0Upb5OkdBT3QMVHJZFlzJMorb9LlTULaLC8wWAAFe/qAuJ+5lgaxIIYL3um/j88S+oXvDGAo4coSseg00rY+imWhM1SfNuxDirSRTHJT7TdPs7xPEBPZJ0iWjDRjs9p3W+FgtFO8fb2+NDcerCScLZ+QKP4JhEu/cWdAdO4mtzDqrCZEQWCCRXLyY3JETtXJ/+wriAE5212eDpaBJF7YWIHksSb8vngPQziAxJ0yBaTINfoqf+dU2tg3VmB+2sFfMM/XyRYDp3DkMi12PGc6/VgazKrRYvR+9dYNMeDn25TPAvtC8/5CMzQ0EXp5VyAmkeXoZb1lQ58f8fBb1TcveHgpxOuBJY1DouGtFOZ2ZL9XdXU+i2n0cEi/7KexRAeLEXY6+s3QUw92dhVFTmXfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(2906002)(110136005)(8676002)(52116002)(6486002)(6666004)(478600001)(8936002)(36756003)(66556008)(41300700001)(66946007)(4326008)(66476007)(316002)(83380400001)(38350700002)(107886003)(6512007)(38100700002)(86362001)(5660300002)(6506007)(2616005)(1076003)(186003)(26005)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?16uoqtFKNByV4hFEpCqupTFkWUoPCi0xLa9BpQPv/H4IT7BQxd6Hqk2xZeLW?=
 =?us-ascii?Q?FjkTILtuy+eiTM38NpnR7Q23EfEC4evnP2AyoeODwIj4SuXJGEkcOzZW9q0U?=
 =?us-ascii?Q?ZB65pO2Lz0GMgYVCiCAQDdMxTEgQ1NOlv9XZo8X+kdB4346c2Ei5sDg3GKc+?=
 =?us-ascii?Q?ytm/Jy90ANKi2yOFdqXqKk9QdEx//DvMDSoJzS9gN34liKhxUp6p4L4B96Zv?=
 =?us-ascii?Q?zmoB+XNOiIyV615y8X32GBDChmNO2OBTeo8T9YrgaMk6AwsyUFbLOTucIfKf?=
 =?us-ascii?Q?yvl7cjza1mCxuMACZYR1Vgmz5EqZsB6MasDepUB5PJdJiwOQMg4Wfpp+olqj?=
 =?us-ascii?Q?QYdKscDl5KVEJ6R7ZfExlQ4H9M9iD94pyc59T5l0xgFryJ5P3wgibnFva+m9?=
 =?us-ascii?Q?XWSA7j/dwZYgphqvz1pCs1c199/Gh7lgAAwzw+ft/tdc/RQYTW1PDGB57HNQ?=
 =?us-ascii?Q?LfoJhZC80cIszfacQbFLZry9DAi7731shmZixbFzglXxapVfVjgKm0zp9xcy?=
 =?us-ascii?Q?sqA7rQS8fO1RNDwc+ymO+F+n1bVKyT3KjswhtgFx4KI153ttLOr6HvaTJBMf?=
 =?us-ascii?Q?vCST/DJgyOVe6T9XmKPb70dE9hodqVfSZ6Nd/8xzaPZZ2gs4BH1I/v/cQCp6?=
 =?us-ascii?Q?GudrnH7XmGFG3a4m4aAhWnuGLnQmU1ThqzjBCiDVmj4vc+czi1Zzgq6qKgrd?=
 =?us-ascii?Q?OIL52JKsGx9nIzhsdrnolO6qBNJgGOy2RQTTi5+nTchN2PyW6gnv39v8Hwh/?=
 =?us-ascii?Q?b/5gFI+b9ncbTeEBZY4T/3xbDoqDhBDgxOBYBnPwUx1JPSqsONTyngN1J0ui?=
 =?us-ascii?Q?vXHGXijdYJa1nySLxW4DNRPh8GQ7YZ8BdTGhzSreK6orYISZuO+zKtr08qJP?=
 =?us-ascii?Q?FLZkY2OxpmxYKxEmcaonaJTtUnQjVZYSIkUUQzFlcVGApT2BJxgUzqyE4U4k?=
 =?us-ascii?Q?P1aOK2goMCarDiYJZrbgBn1fAvbijDjw0gRozpfFb3n9n7jOuEXPWBPPtnuK?=
 =?us-ascii?Q?jRJmEkVnKrFHnfXLgztrT3CufESv7Gnha67Aw8lkgiTMwlwEDfn0R/pwaCbY?=
 =?us-ascii?Q?qtWBZ4aq6jSt9i7P5IBNIjmO252WA6GxS/snALtZ56tD2lkoJ911jq5mNWWA?=
 =?us-ascii?Q?5uzglUuPGdB7YFQONH/2mFyiF/jWSz6hi0Qjap+tMv5ZtEOn1uXUTowIyGCL?=
 =?us-ascii?Q?wa07TzytWKh5AqfqXJRaTy1yQIWSUfdl/C9tLCOyImJWTPez8amYGPgKJzRM?=
 =?us-ascii?Q?va8Y6tbN3/mCpkJBjWZmkl+WPvQR2OxehJXjeuQwsLL9mWopDfbVdlsZYqqE?=
 =?us-ascii?Q?mnnC26XMo1bMhpmdJyBo+s3Gq/H4So7R9CneTH37Ef+YHTn3qyC1MFQx2Rpl?=
 =?us-ascii?Q?Ckf5gVZCfGfr45fiEEJsNHttz0wlsd9k38qFJOkyO1FSVv/588I8gHzV2pD0?=
 =?us-ascii?Q?IDjndBgm1DedV8mWwj6d9KL9j/6VeSh1ftfcwLC0xD20cLOBbQXrNVodwqYn?=
 =?us-ascii?Q?q1n/KO3wG5j5guHQAk4UVWjWf3yvSngH+SAcCNv6u3OF7Cu2n0EKUwYNWwQl?=
 =?us-ascii?Q?tzT6UZLIWv813TXyDOXbNlcuG5af6r3vlwFNT8C6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69589471-90cc-4398-0649-08db835e8c5d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 05:03:51.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0H8ATM9TTqiZl+0mLK5ok1s+oitFIbVb0mVRi6XXihniP45VuBwtrHYXUKyCGNg0P169RC07UhIl/CpG2ydqyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() and debugfs_create_file()
 function return in mpt3sas_init_debugfs() and mpt3sas_setup_debugfs().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/scsi/mpt3sas/mpt3sas_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
index a6ab1db81..88fc10ad0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
@@ -99,7 +99,7 @@ static const struct file_operations mpt3sas_debugfs_iocdump_fops = {
 void mpt3sas_init_debugfs(void)
 {
 	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
-	if (!mpt3sas_debugfs_root)
+	if (IS_ERR(mpt3sas_debugfs_root))
 		pr_info("mpt3sas: Cannot create debugfs root\n");
 }
 
@@ -124,7 +124,7 @@ mpt3sas_setup_debugfs(struct MPT3SAS_ADAPTER *ioc)
 	if (!ioc->debugfs_root) {
 		ioc->debugfs_root =
 		    debugfs_create_dir(name, mpt3sas_debugfs_root);
-		if (!ioc->debugfs_root) {
+		if (IS_ERR(ioc->debugfs_root)) {
 			dev_err(&ioc->pdev->dev,
 			    "Cannot create per adapter debugfs directory\n");
 			return;
@@ -134,7 +134,7 @@ mpt3sas_setup_debugfs(struct MPT3SAS_ADAPTER *ioc)
 	snprintf(name, sizeof(name), "ioc_dump");
 	ioc->ioc_dump =	debugfs_create_file(name, 0444,
 	    ioc->debugfs_root, ioc, &mpt3sas_debugfs_iocdump_fops);
-	if (!ioc->ioc_dump) {
+	if (IS_ERR(ioc->ioc_dump)) {
 		dev_err(&ioc->pdev->dev,
 		    "Cannot create ioc_dump debugfs file\n");
 		debugfs_remove(ioc->debugfs_root);
-- 
2.39.0

