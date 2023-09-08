Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31527985C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbjIHKZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242628AbjIHKZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:25:04 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2101.outbound.protection.outlook.com [40.107.215.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C532108;
        Fri,  8 Sep 2023 03:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUzRPtPEoGpCiwn+qdtK9GogPJctvqPbDqiye06up61MaoGXzWKF6Lwd6OlDuQc4y6syaOQzFyLyv4TQe1MxQaWBm4e0xNfor9Hj3lHsYlGrW070VTOzG0kq3NcUXTW1SkBVSm4JTMRBVlktc2mz1wAQjZkugkCxCB7GOYAqGRSM6DNUclY1w21FmVIvVlY6RuymYYJbp0pFgWDBju+oIAOcqaiDIe0Az3PI8vYO2592XzBOqssXvTxvSCPU3/sEnlXFLNKlu5gTkwkl77OJG4kQKjqv5Mu1fPQc8RtoJKMkBnQisOdmnBaCcduSrqj0I8uKvDY6qz7pbjGs3VacZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hKLMc5Znzg9iN1UL4p/j3XS0pY/BiB45SxpH2s3Q8g=;
 b=Yq9CXxWfZO4ww36S31QQ88KMJP+vOFl/JGQji0NJT1PAqvJfAbu5H3qjAgbn7qM3E6UokjMC9nQ0kquqstPSRVE7SjQKE+EFltv0ylbfGzwgtoPHS1+28pt85JXGQFNfHxCE6gfO6nUD4G0hnvmvm1lfdEOxzwGhyUgk8wr/u7cXiygFVAbUjACk3l9OJA++4BOlkW/ChkMjCBKBRJPTcWHkVJg4H8XHZFtB01Y55uMySn64vnbZJDnWLqyBSRgkrgAycMKZ+8jhsftrwW8JCEgQGnP/np8tMpuz1Crdu4DnhokwHWHyJQr0abodcJfKUnUfcIyXumyskqOsnci/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hKLMc5Znzg9iN1UL4p/j3XS0pY/BiB45SxpH2s3Q8g=;
 b=J1WlZx+xaOg9pLxSVOT/CM3LCii+/tA7b6S03Q3n1+31PWYtgL4qSnJdnsD4Gyi6cbGkskxSgzXPkhyKtTqGZR2ubgEP+bd8LEicgMzznsk/Z62TU2uz8rc65m0fPybkK/gmlOkSnpyLR/xMXiCxWzA+NA0VYi3rGwKtFQ6G6ODn1dB/Y2tF6f9JAiX+2dGiao/TYRNH2WOgRa2rqGI+cfBQMCliNoQcewrShik0A0osVpmMQCyY5JwNa0N2EPjMOdjWpEQZv14lpx6zUZ4seZs3FUVN3l7wEkvozbzDdK30HQyuCwXrbif/eTkqd4WeyHFyOpPYbRZF6Aszv3PweQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEYPR06MB5110.apcprd06.prod.outlook.com (2603:1096:101:56::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.38; Fri, 8 Sep
 2023 10:24:26 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 10:24:26 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        zhanghui <zhanghui31@xiaomi.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2 3/3] scsi: ufs: core: Add sysfs attributes to control WB buffer resize function
Date:   Fri,  8 Sep 2023 18:20:18 +0800
Message-Id: <20230908102113.547-4-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20230908102113.547-1-luhongfei@vivo.com>
References: <20230908102113.547-1-luhongfei@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEYPR06MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e42a0a-51de-4dc5-87b2-08dbb055c759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTSlny69Qr0MY8uGpa03RWgnWk7d9RbYibYcvKO3T3k8r6tDSq8y1RHNVAmXjDhuhdcZ2n/Ex5p3ZR7apke+e/F3ZO/ex68fndFGAbhSGqnnAl6mQ8PYOPGcuEjZX7QrotDiR5buv+M7lvA/OQgiWsxrdOvu/8oQg8n+2hXYMxax9iz+Cee19g2qIvvptOC5RDjOT/p6gFkOypFsTsF29h3vWpS1E/n/NzKrn7mNJUQ2rdUXbUGnMJTTAG8ambF14pF69c5klcaZqWG1FUQrn4sXWaTovB5sbjo8BzCpLkNeTBA7oT3WsAXHVChgyKNbhyy5oilCbLNMpi10dFN3qUOgd1sBxnsPDmBcCjs6BYKqaulMFpQUHpRVdWojxvYKR68ypl+iFziRHuwR8s8HDw4XnkVdcy+g8Klxi2mrSHRS7ya5I0Qy7t95KayxXL1ChBfwUuaV2KgtVkNKCri7F6stYJK+Sz3BaeM3cTgDelutpGvfDyd37PWLjHKAfKv+pJWz/caQCXRln6VxSufe24IVgogUWerRqhqP9gbHypkikq8AkcQQCsWaEQbNMJB/lApV1GHPi47taVJxkNjANAZQEpiS2IdCmxappY/7ZfxsWlvtpdh991j/PIJzttiDd+zTACrFDM8F04rF11AAiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199024)(186009)(1800799009)(5660300002)(4326008)(8936002)(6486002)(6506007)(8676002)(66476007)(316002)(66946007)(41300700001)(66556008)(2906002)(478600001)(52116002)(6666004)(110136005)(6512007)(26005)(1076003)(107886003)(2616005)(7416002)(83380400001)(921005)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YC43SchpM4mz09k4U64Ohsnack5AfaI4YiMdrSk7N/TbflRx7DzS7tp5ZoRO?=
 =?us-ascii?Q?LNKS7iyV4jm9lhxsd1tEAs9lRCq9wrvIjtO+aynda9hUF6jLZ+c5SjbodK0q?=
 =?us-ascii?Q?BsbKh5V8z1gDg6Yw5GT/bTtAFKReReEQy9CbUtBfD20ERH2M3wslxNMkzW+m?=
 =?us-ascii?Q?8M5hiAZLHRR6xZOMByYDoQiUCtTNqfoanTdqXo3/T53H+a8rAYqWeu5/GLY2?=
 =?us-ascii?Q?rkHeesghmtvF+9s7g4BarPoZdE1ma48mkxsfsM/nRYjpsh+PFgJVW5BQCPWq?=
 =?us-ascii?Q?vNUYnZvsWlsaL7mRFxhl0aJjC2nck0sm0PKZwpzsvexpvPL+WhO7Y0M22lqE?=
 =?us-ascii?Q?f5tDKu9GtnNzC4KLIlOYnvpqPyZ+2Ad4cN0xqlMM9DXRX6pfHaRbuGIxhRlh?=
 =?us-ascii?Q?3+KCdI2mwk6geuCq6UfQeLIZ+F+UAoFfFUZK3usqMVXxTJ4Olc54ttDAcbOj?=
 =?us-ascii?Q?N0Q2jh5cP3rKdaD5PfczRlRekrenpbCEY9MaVFaSKKEy2vR5KQ26UAgih8IT?=
 =?us-ascii?Q?Iq763hqkgS+916HNUUbhl5UbcfZ0CvzMqAH1nfG7doK+WyjjAN/1mXSXTuEI?=
 =?us-ascii?Q?rssUw80x78hzdjS53T81D9zmfb/rkm50h1MknR/4NcgBiSiL5MwQXzautiYL?=
 =?us-ascii?Q?/NQtEX3HeCHHmW/PIfMD/KzujSugQ481uubZh9xZQBciEXpwHhEZ5atdc7+H?=
 =?us-ascii?Q?rL/CYW+b7yP6hVwRBFGT9+/gR6Ca0caFJw1GehdjkJvyOMl/SRUkKa82Sr8p?=
 =?us-ascii?Q?SphlfPFDTIbXBcbLQ7Rl6y0uFBUYCL7hfnmnUoKQt0eDRtzaBYAlGKy2i3CT?=
 =?us-ascii?Q?6yohy0nzybv7TkD7FlDOnG53GqtckjyGpizPO6P7RXkBSdOMI53Wff0dWhg9?=
 =?us-ascii?Q?ook5zJdaTktegEzyN9PA8+a2KjS+C8eHnIQexg9JLfXvwIO5efptl4V6XSb6?=
 =?us-ascii?Q?QiqMcsHXUyGUTz+hANb9NZglG87jMnmOBDvq+8JVt1YTfx7WfvUOMsifcJaF?=
 =?us-ascii?Q?gIgYR3HD+5nXeTjOkzEn2xxT14j6hkL9wYGNJBhTHwQRvZyBFU4gLhhGKHB/?=
 =?us-ascii?Q?XWBeR37FLt5CGQxjCJyD1kX5BTgFYt6f1Ne1IDPB2EBH1Vs9ely94K2usFOL?=
 =?us-ascii?Q?hZR7NYWGEutB2yBGx6ZjFQUITw8iOPJe9JgdFxInQp8tEDnpLTYFHWTwdO4Z?=
 =?us-ascii?Q?y5WGjyNdA7HUqoRKfvCRvFYw2pEKoC5V3dAFjViXU6poRUx3JW2TZ/OnFwkl?=
 =?us-ascii?Q?QUb1whFZ3zWy7+5VvULlkxrH8DWmLrIUhZRkZ5slcXvd5w1ctcYcXj4Pv7MG?=
 =?us-ascii?Q?f+U4gxrvBsFoUEdhm8IRDY/bx8A83pNsh25U3Agh2g6Xc7qxFEG5qmO2/GnI?=
 =?us-ascii?Q?NCTyfYdewmEEyNfAVAW1PmkxZQXpAK0k/l/Kh1OIr08/q7JFJv/mHAVTM5Ar?=
 =?us-ascii?Q?JIPaLWnN93QJTGaWHUjyM6MaA8ZH/gnW1odLV0VlVs0/XrNosgqMe4Hq4L+K?=
 =?us-ascii?Q?UvleFFRL+sFb11eqLoSPbDaxHl7ZG9E5ugQbyP3Ge3LIcU+cKCZ0P1etEMK8?=
 =?us-ascii?Q?nJTrDTqp8JdIi0GxZmLtOebds93OYgg9EU1+oPKG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e42a0a-51de-4dc5-87b2-08dbb055c759
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:24:26.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y24Tj1JcUsNyK9U4v4oRWXS5112gtniOcxF8eZMv1SM7NfH26j/KAh94V8xnThq7m62quk0KEF9tNmhMMRlaRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host can control the WB buffer resize through sysfs. To achieve this
goal, three sysfs nodes have been added:
    1. wb_buf_resize_hint
    2. enable_wb_buf_resize
    3. wb_buf_resize_status

The host can read wb_buf_resize_hint, obtain the hint information about
which type of resize for wb buffer, and write enable_wb_buf_resize to
enable wb buffer resize based on the hint information. Considering that
this process may take a long time, the host can confirm the resize status
by reading wb_buf_resize_status.

The detailed definition of the three nodes can be found in the sysfs
documentation.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 52 ++++++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 71 ++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 0c7efaf62de0..6e0ecf3a025d 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1437,6 +1437,58 @@ Description:
 		If avail_wb_buff < wb_flush_threshold, it indicates that WriteBooster buffer needs to
 		be flushed, otherwise it is not necessary.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/wb_buf_resize_hint
+What:		/sys/bus/platform/devices/*.ufs/wb_buf_resize_hint
+Date:		Sept 2023
+Contact:	Lu Hongfei <luhongfei@vivo.com>
+Description:
+		wb_buf_resize_hint indicates hint information about which type of resize for
+		WriteBooster Buffer is recommended by the device.
+
+		======  ======================================
+		   00h  Recommend keep the buffer size
+		   01h  Recommend to decrease the buffer size
+		   02h  Recommend to increase the buffer size
+		Others: Reserved
+		======  ======================================
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/enable_wb_buf_resize
+What:		/sys/bus/platform/devices/*.ufs/enable_wb_buf_resize
+Date:		Sept 2023
+Contact:	Lu Hongfei <luhongfei@vivo.com>
+Description:
+		The host can decrease or increase the WriteBooster Buffer size by setting
+		this file.
+
+		======  ======================================
+		   00h  Idle (There is no resize operation)
+		   01h  Decrease WriteBooster Buffer Size
+		   02h  Increase WriteBooster Buffer Size
+		Others  Reserved
+		======  ======================================
+
+		The file is write only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/wb_buf_resize_status
+What:		/sys/bus/platform/devices/*.ufs/wb_buf_resize_status
+Date:		Sept 2023
+Contact:	Lu Hongfei <luhongfei@vivo.com>
+Description:
+		The host can check the Resize operation status of the WriteBooster Buffer
+		by reading this file.
+
+		======  ========================================
+		   00h  Idle (resize operation is not issued)
+		   01h  Resize operation in progress
+		   02h  Resize operation completed successfully
+		   03h  Resize operation general failure
+		Others  Reserved
+		======  ========================================
+
+		The file is read only.
+
 Contact:	Daniil Lunev <dlunev@chromium.org>
 What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/
 What:		/sys/bus/platform/devices/*.ufs/capabilities/
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index c95906443d5f..2ecb1e08a5b8 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -329,6 +329,71 @@ static ssize_t wb_flush_threshold_store(struct device *dev,
 	return count;
 }
 
+static ssize_t wb_buf_resize_hint_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u32 value;
+	u8 index = ufshcd_wb_get_query_index(hba);
+
+	if (ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			QUERY_ATTR_IDN_WB_BUF_RESIZE_HINT, index, 0, &value)) {
+		dev_err(hba->dev, "Read WB Buffer Resize Hint info failed\n");
+		return  -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", value);
+}
+
+static ssize_t enable_wb_buf_resize_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	unsigned int wb_buf_resize_op;
+
+	if (!ufshcd_is_wb_allowed(hba) || !hba->dev_info.wb_enabled) {
+		dev_err(dev, "The WB is not allowed or disabled!\n");
+		return -EINVAL;
+	}
+
+	if (hba->dev_info.wspecversion < 0x410 ||
+	    !hba->dev_info.b_presrv_uspc_en) {
+		dev_err(dev, "The WB buf resize is not allowed!\n");
+		return -EINVAL;
+	}
+
+	if (kstrtouint(buf, 0, &wb_buf_resize_op))
+		return -EINVAL;
+
+	if (wb_buf_resize_op != 0x01 && wb_buf_resize_op != 0x02) {
+		dev_err(dev, "The operation %u is invalid!\n", wb_buf_resize_op);
+		return -EINVAL;
+	}
+
+	ufshcd_wb_buf_resize(hba, wb_buf_resize_op);
+
+	return count;
+}
+
+static ssize_t wb_buf_resize_status_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u32 value;
+	u8 index = ufshcd_wb_get_query_index(hba);
+
+	if (ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			QUERY_ATTR_IDN_WB_BUF_RESIZE_STATUS, index, 0, &value)) {
+		dev_err(hba->dev, "Read WB Buffer Resize Status info failed\n");
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", value);
+}
+
 static DEVICE_ATTR_RW(rpm_lvl);
 static DEVICE_ATTR_RO(rpm_target_dev_state);
 static DEVICE_ATTR_RO(rpm_target_link_state);
@@ -339,6 +404,9 @@ static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
 static DEVICE_ATTR_RW(enable_wb_buf_flush);
 static DEVICE_ATTR_RW(wb_flush_threshold);
+static DEVICE_ATTR_RO(wb_buf_resize_hint);
+static DEVICE_ATTR_WO(enable_wb_buf_resize);
+static DEVICE_ATTR_RO(wb_buf_resize_status);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -351,6 +419,9 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_wb_on.attr,
 	&dev_attr_enable_wb_buf_flush.attr,
 	&dev_attr_wb_flush_threshold.attr,
+	&dev_attr_wb_buf_resize_hint.attr,
+	&dev_attr_enable_wb_buf_resize.attr,
+	&dev_attr_wb_buf_resize_status.attr,
 	NULL
 };
 
-- 
2.39.0

