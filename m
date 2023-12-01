Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2890980164D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441877AbjLAW0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441866AbjLAW0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:26:10 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E9010EA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:26:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPNNC790ltESOQ2eLaifteaXDkyeF7bj/B/9hYQ6bFs2cI94K/W+4CQUuEdWBPEXBkPDevHAKH1u1J+D/GxyJhuo+/xuvv1iL1WXQJdRu/9Jjw+Z5bWj0KMHjCIcHLt5U+3Sy9O6ZY8DAEDL5G7xOZAIXTH8/XV59KCV2XmuzfhuyK9NNleoxBO+r59vQSXdVZxNvJ+tMF7u5Y495cUsgYs0Z/I9UaEMx7yi2V1SAZvyCbGJmL6IObWJGFcpcEyjLBT0GbM+oacWTScluO1cqJIW4RKoaRmH0vnek6r4/WrsOiuNF3CkYm2i4FgOmMnZJ/gGtbqwuTIVUP1HOuqldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUJfh4y+uyDpoIRsDDLcoFS7UqmQdjwckiiFGvUdGQM=;
 b=dZRFAtfjUxwTYMR1Wun3fiC3JzdeU9/672PvrlzrsTFz7xy1YmPH0gkHgEa5JMJqOvAgF/FqvZV4/YD0WXrECNh5eFzeEKz5KlCxrxWHbVhq3/FstSPsmCbPo6QiM1Hb4m0n3bj7CvpZ9awXSDJWGFHer8ASFfinn4v4CjUrLvL/oHhfgFzKKUO8ZU1YjvbP7rMMvySjyVD26K3nFGjmizq3gi+7MTV3aCZKswpvShHUtqKjBQooNzg1Kv/aJTZVWuUjS4ggFxjOCqnNdQdE5ZyJ89LtzT6HVxkNaz7E7+ZNJCb6X3eRN03Ls0/zgFX0HKQ08WD4MBGkMv8ZbkZLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUJfh4y+uyDpoIRsDDLcoFS7UqmQdjwckiiFGvUdGQM=;
 b=hue24GSU6ydUoHWoXO58NQo3bWMmxbxSK5oWfUo9N7sDJP9UPzbwKUc6Gv9VsWt9KXG9cIIyoqCBIChhEQyuPnadAjgmktqPsl/yWOGSNdJ+/lnPyCbkPyNjGInDhMTYKTDzT0Iy9KhOnzfT8+BdDVwkHdwMrJZqeYtTxX6Clsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS4PR04MB9573.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Fri, 1 Dec
 2023 22:26:10 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.016; Fri, 1 Dec 2023
 22:26:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: [v5 resend 6/6] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date:   Fri,  1 Dec 2023 17:25:32 -0500
Message-Id: <20231201222532.2431484-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201222532.2431484-1-Frank.Li@nxp.com>
References: <20231201222532.2431484-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS4PR04MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 9749e2b5-c88f-4dc2-d62f-08dbf2bc854e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzKcmsMber+YWmSvxvUaIUCWnpLSOEowKGO1+rtt6uOzvUN7ps9IdOKJhwEcnq8fNxbZfbKC4NgqN7xGk0bQd2e1AfM7uNp1UUoAESy+euP9ALb3s9j0xMtJlsGenrfq9TzW6mUyX6R6U7rNpoCLEvPUrtKuFbmu4PB81latjEeUl6BhXciTM2PeNkQAbtHQDQpwbJ2W3bFZtrHssIybhAHu3j1M9VNJEFqFR/UstSvlwkVDkKafvRqtvQSBjFNF8bajs+bUkk5O3ft+brOTUIvE57gWpm8Y6BuVp/FapNzpgFQN+sYm30RsLDlnLxlR9iqTgJdC6l8WYgvCt7Ym1dZFoRNnNFms+fpzeQIHMoow0Jd4ShsNWt8KxYRXj0ELorPlGo1I9ozy6MMCTgnIjaW4qhNV4J7YE9hKPJmLj03rJhKZVSkAsYHg6a9wudR9/1j0fLeC27Tb3mWGFLcZU48eC2WUoGUjg8C3CG2PCtEcTD9BXEPj4kGdhczp3EPrRdG4RrWwNeAWLy2qpQwgEese6OdrvhKXcSQs1WxW682AtfWj2KBH2K/cD0Bs8YZQ3VAPLmbxFFmaFXbrA84u5ueaLO2A4X2Qa3qIIicrtmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(86362001)(6506007)(26005)(1076003)(6666004)(52116002)(2616005)(6512007)(41300700001)(5660300002)(8936002)(8676002)(6486002)(478600001)(2906002)(966005)(4326008)(316002)(66556008)(6916009)(66476007)(36756003)(38100700002)(66946007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SeKz2SmTZa98kF2FD3jNDQyn+9EsLDed3LNdxGXuHE5XveAgYMazA3ik/eMC?=
 =?us-ascii?Q?yBRlBQBJFABmBOc1EAp3NG5zKCR7jNUu84xt9wxApsmTBX4L44qCMYETznln?=
 =?us-ascii?Q?vtOtIFjK6T5hGltuYNZo9UUHvmM6x/8bCBoxLycLM5YJV+t9ae0qmUUsSskS?=
 =?us-ascii?Q?aYQ8UYsFqxnyJCCp7+U0YwwisVRwEfyNKSgcsUNIAr83V/ID/0ymkkkpuRYv?=
 =?us-ascii?Q?1oxeMTDrgWU9wADyXbwdnVenrxMTDxF6vVfqXr44TorAjEK9hxYiUfh9KUwF?=
 =?us-ascii?Q?L/OKwlNVys90ETvNnno83pTBKNfEBds6YuLYuSc2iCzQykp+8vt69HN4FfKA?=
 =?us-ascii?Q?UX13ZR+Ab+b5/muo3iDpZM5iTRB1cmRWv8gXxoHZb4/kkgBsM2c6U/Doz7ho?=
 =?us-ascii?Q?qrRYHXAqSDb9afr41Ok77SJCFm0QLUA3JxspEvlIrh7DCXn+/YPsv3tePdF1?=
 =?us-ascii?Q?ZoePgrz0qFoLjHXg7Zup7L5yBBs50CN7tKSTX+NTBnGya34iEOcpbj3/ZhrE?=
 =?us-ascii?Q?dISjNYv0Dy3rzbh1ufyndqJkiVUy/fRy06ZkgPvM+kF61oOIeRnAMaWDmKv7?=
 =?us-ascii?Q?An5GIb8Whqnerztm7CnWFfVxjxh3UDgZVvHgOovpPBLfP9pDvYZ/Zc8potNc?=
 =?us-ascii?Q?2p4mddkXGUaRHteBxFZxgKbe1hGr9dHXCyd8TK9uijLCpSa0I4UiGsy/OJX9?=
 =?us-ascii?Q?QWTkMazcWWndYdm00tBfmfGynXdvpXCD2DF1F2KhsMBO+6hSoTrTzXI2gGpJ?=
 =?us-ascii?Q?Gk2AxEuYPaKOSfGWEc/9M9LubgZXimXEN78lC0JF7mO5ijg/WeO51UDuX7oC?=
 =?us-ascii?Q?KZdYScdJZ28vpu3jeKH5OmKsRJ/02AmOL5egO778HTvwGeZaZtwBcHDNFHWx?=
 =?us-ascii?Q?fVEstFmVE3Th0Ne3U9ZW64rQs1jq0TPNRtMvdh0k7KqsOa+j0WnEYgRGfo1R?=
 =?us-ascii?Q?qvPPcjafekgpxfYwFf18PxZ2ESGsRNdYj/8/cibpmSxeL5Jv4/GQk3YbXLWV?=
 =?us-ascii?Q?NWbV4jQP/RmV/MAHwzEBIodpk+f8Vv6GFGrQziA8A1+LtNivB74ymZGhcdP8?=
 =?us-ascii?Q?i72M9Y5I5MXlBoX9qGuN8qd1sKSEDNuw8uGllp64mjcRIy5qHDHNlrSsKEs1?=
 =?us-ascii?Q?cXD9TI4q9wmwML6lJAPVFTl/QjqPIJjcjGaGMPscsjuKX8SBFFLndBaBtiG7?=
 =?us-ascii?Q?P+0eiJ7EvXEVHTvm/LrWCDNSj1aHE3eCshVTkuRTU5YwVC+8mBoga/WoweCI?=
 =?us-ascii?Q?K12nPfSw6YBMfs6vji98fYklQ+EGRbocxn801TpooRlz476yh+7VHu4zDW9n?=
 =?us-ascii?Q?n5MKCXHBPQXhk8w/Mk7oKICDFJ2AUtjxSXS6NNie6q9b9sxqldkMkLp7bAdv?=
 =?us-ascii?Q?SgaR64Ms8sr31XfC9WX4mRTSLFruT7svPNJhKfERmx0o3+PZmIkzeWXcPM5F?=
 =?us-ascii?Q?sJJX3I8tbzloVwH41TJylKbaJClUz4pnJ/5kyZDf5dSDVtY7ry9E+lLGcgXG?=
 =?us-ascii?Q?6y38HwOH9814D80vK1jApnOFU7C2KUjfKl2ai77YxhYPuMkkHw3Gez4kwow4?=
 =?us-ascii?Q?o+bgwxlPIoh+DANvZ9lpp9GiG4DawPGtHyeO/a1W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9749e2b5-c88f-4dc2-d62f-08dbf2bc854e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 22:26:10.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69DL4H7GH6ZiF3kCVeMlpaUJj778oUxq2pY+hGIwbE6A/x+oP+b93bIQO8m23Pi5lhcdYBmBUBM+fwLWidgQFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I3C standard 5.1.9.3.15 Get Device Status (GETSTATUS):
Get request for one I3C Target Device to return its current status.

Add API to fetch it with format1.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    See below patch, which call i3c_dev_gettstatus_format1()
    https://lore.kernel.org/imx/202311070330.5mylauLR-lkp@intel.com/T/#t
    
    Change from v4 to v5
    - none

 drivers/i3c/device.c       | 24 ++++++++++++++++++++++++
 drivers/i3c/internals.h    |  1 +
 drivers/i3c/master.c       | 26 ++++++++++++++++++++++++++
 include/linux/i3c/device.h |  1 +
 4 files changed, 52 insertions(+)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 1a6a8703dbc3a..aa26cf50ab9c6 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -196,6 +196,30 @@ void i3c_device_free_ibi(struct i3c_device *dev)
 }
 EXPORT_SYMBOL_GPL(i3c_device_free_ibi);
 
+/**
+ * i3c_device_getstatus_format1() - Get device status with format 1.
+ * @dev: device for which you want to get status.
+ * @status: I3C status format 1
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status)
+{
+	int ret = -EINVAL;
+
+	if (!status)
+		return -EINVAL;
+
+	i3c_bus_normaluse_lock(dev->bus);
+	if (dev->desc)
+		ret = i3c_dev_getstatus_format1_locked(dev->desc, status);
+
+	i3c_bus_normaluse_unlock(dev->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_getstatus_format1);
+
 /**
  * i3cdev_to_dev() - Returns the device embedded in @i3cdev
  * @i3cdev: I3C device
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 908a807badaf9..976ad26ca79c2 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status);
 #endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index d3b56c9f601e2..81611a3e3585a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2923,6 +2923,32 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
 	dev->ibi = NULL;
 }
 
+int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	struct i3c_ccc_getstatus *format1;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	format1 = i3c_ccc_cmd_dest_init(&dest, dev->info.dyn_addr, sizeof(*format1));
+	if (!format1)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETSTATUS, &dest, 1);
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	*status = be16_to_cpu(format1->status);
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
 static int __init i3c_init(void)
 {
 	int res;
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index ef6217da8253b..5f511bd400f11 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -345,4 +345,5 @@ void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
 
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status);
 #endif /* I3C_DEV_H */
-- 
2.34.1

