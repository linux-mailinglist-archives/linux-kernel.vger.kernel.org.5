Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3517985CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjIHKZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIHKZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:25:56 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD051FCC;
        Fri,  8 Sep 2023 03:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhyQkz5XUamlyH0YrFVgIaDXNuxUI+iZSTGyLKNaQA8rRlR2LbJnIOLUvrayf1H2RRnzEcRjixc2VLIXLju6ZSbP3RvpEjQDBcFEqraFbvzEyuCH8vnOmuky3x5VqJ/09vKui82Yu2G1gf5B5QSMr3DHm7bFQN9u/5WqlDTwNFgfgmcwo1EFQD39SYDa79t0JLEmHp6Qw2bgfAAVPn3RzgHjSxpY6eqfVCyUVa7WVCLtDmsAyumkAwVvs/jrDCCi3bKQwCZGNzhBdsy7q7x5ks76IC5iMvFlL6EtWItE5lnX/DOFmvSRTKYitIg8RVSDWIEsEdecxzR/S7KTPH2eBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8wJkl/B8/0BAZqNu7T2OFqreM8vBhZdkclN98SU32U=;
 b=TmvvFF+4Y0PU2VEE152s0mnRP5yWB97Oc4G6x0zv5KUDaCpvNyVtn0MB4Shx8GS0ld3bzVLEOjHCziHYCYdtFYWJCHgle/JuoOfTf/61sSSkAJCkpyB1B1d16wLW7O0UsgeTls3hgX2SjXyvLB0wEGUTKLcy1njFRDEAxDMFUMZa3rjz7ww/mzpN4gvTSWKTlJfRYggw5VAwaNxODILMhMBrzFk17gZeW+iAeUijGBFFtl3q0dlV6HyDCIe3Y4355zSq/I1fs2Tw8Bqcz3RA1+B0qqS5RYIjbokpEjxrd3JCSxnckpn7pQqdrxMd8P1afnTjVUMCX+QB1f7KzcO1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8wJkl/B8/0BAZqNu7T2OFqreM8vBhZdkclN98SU32U=;
 b=Q00EJCqnCT928P9jJJwlVKONUz4TCm9LW+4DxLtWe2dafW9JWJi3Kb8akYm0Q1jvSPWLnWolwZf4HoRgCeiCqvaiWbnlynkLXNuf1Gg41btA6ZDCfZwoe0nBFwOq6NnC6ZEC1pjeeHNE32kg1ns55UU1yriFcbQNlJcg2WC+RP4Vh1/rzgRZBNm8Rhr/qxyNIIREw/EMGL/UfuDMJMMvg2xQQUrSE92FUdA4JRrkF1PJXm+uSHBvGwVr/z2zRcVKaIns/BrJbY6UNurEAgvXLdkWPRZafxmchOTAQf8Nl1uXuXyIek7Xt/hjAlXOGRS33CRqjGK411ycxQt5rw6IfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEYPR06MB5110.apcprd06.prod.outlook.com (2603:1096:101:56::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.38; Fri, 8 Sep
 2023 10:23:27 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 10:23:27 +0000
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
Subject: [PATCH v2 2/3] scsi: ufs: core: Add ufshcd_wb_buf_resize function to enable WB buffer resize
Date:   Fri,  8 Sep 2023 18:20:17 +0800
Message-Id: <20230908102113.547-3-luhongfei@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 204bae92-e45d-4244-3666-08dbb055a405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRCQk+6gpBhmdl3kmMW6dYva0kaS8SMRVR3Xt2GvctJf3F+DHu4Oc5RKmCYr7gofEbJOC8+27BzxpApV04oSO2Yv/Szt4J0lwnwP3h9ZHvqQZIBFQuQ/eZUoELdrbAwsTshE/dYfQhCAy9ndFkFKFOJC8vWUEQOtNwrf0mmNv7XEzaB1LhZ4sRm4CoYUBLDXl4OJ0f0KVwSHdH5yt2SIJTNgduJY1ueEsydmP+OSrOBo/33qCjPyCeVPgcWjn+zSuSFivcx2JNWODJbCQmgkRP9+IK6dv7o4ZnF0g919eh24JkSvEARP3Q5a566VneVdF+V3dgBAmhgdYEk15G1/IWPKcsw+4QI5wPVIp2jkXA3ytA2fmX46U7fabb5WlMgrZX1XMcI24HuiWgWTxrg8j7q80sKVTdtWBfEs7cUxm+nIl5GRGwhqh61o4jnrL95ji2jMQioA1BKZhic54lQKzg5oMR+uz3u4yzYdW/3FA3LuHTMT7w9A8BfhXfKpZZBFMLC0Te8ATsE3TJTCdlquVICSgXyatufXuXEDDtyNGdvflmpvA0Byiy+rX4K5gb1/tnxauqEvMiqZkcLEzl3rCNrIWVn47BR6EPT3v2ZNDLY+6kVbSPNmdZoIYoGVqPuZuUX6NvDtVrybpnDsiQJ6uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199024)(186009)(1800799009)(5660300002)(4326008)(8936002)(6486002)(6506007)(8676002)(66476007)(316002)(66946007)(41300700001)(66556008)(2906002)(478600001)(52116002)(6666004)(110136005)(6512007)(26005)(1076003)(107886003)(2616005)(7416002)(83380400001)(921005)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZKLwxkeffrVuraReU//HcG5MFOxeRH7xD4oa0O9wO6lWdVnJY7F7zVvZynH?=
 =?us-ascii?Q?SEy/FhC+5bKGKu6TjCEUypsarpXQq5spvGpTpsruxvEEva3ywpRPGW9k94Pb?=
 =?us-ascii?Q?Jkn9D7uYkR895P0kxHF8v6cYfJ8cMPDwyRhQc4TRdP1XowVd/svbwHaIk+iF?=
 =?us-ascii?Q?kI5+ZGkdWouaiFcYgYuUD/1xHbww9hfqQhAJBLr67AhDjYklMvjT05yvE0pg?=
 =?us-ascii?Q?yUKp18cz8lAGRT65sX7yjG90GamRyaxHmCckdbEQ3KoOgI3+hqllouRpzvuj?=
 =?us-ascii?Q?H2zIVe5gIIJi5i2CGQGluyTyrlr+Fhf+o8AqHXIK0ii6Gj81C0/JkDtjfeBm?=
 =?us-ascii?Q?4kE4dNmtia0iehEzU5u/i/IY5L3Yn58vIyQhx3LTAsJ4vjnPP5j/nUby2a2p?=
 =?us-ascii?Q?qf7MZiW1Tm4Sr0DEPrC8SZ9SzDXs4Qxztkp/ptGC8eTvOzLKzKRdpYT6+uRw?=
 =?us-ascii?Q?nIks8R04gsYK08BtwlHvI47AujwBH6bWxUi9Bwne9BC0lqSwa+ebp+oLGSiu?=
 =?us-ascii?Q?GFhTwQCkv4JEDQm6Y5O4J6KuynJg+s23By7tfd9ehoOYQC/bnVSy+8t53A2h?=
 =?us-ascii?Q?leW5AX8yaXXiotiI/ANtP2gLlHTY5Ky6cITNCKBx9xMnwBFnAgNRYk8/bKwx?=
 =?us-ascii?Q?Rmig6Kf9NkDM1aWl34fcuPJCWAajX6tkJWBo5+PVuMY+G9HIhz+BP5jWAiqG?=
 =?us-ascii?Q?FDe/NuG+X2NNk+m0JIDkPJi9MwdifPxMTQjbg5pd8FA6D8LFXO1duu4iQsY3?=
 =?us-ascii?Q?1AytvCA03mH4LqT5r+8u7INzTVWdKLJ3A5SII27cJ/ZafigXPl7ZUBsbqYKH?=
 =?us-ascii?Q?FPq2Bj7QHsx162nkMbuLFUji9sSohtPEUlDAKg0nrgn3YgGCkwW1C0mXhhFg?=
 =?us-ascii?Q?rbILzYNQuOQJuESys+jr+Q2mIjCfGTDmKfwI5ABT3Q/cRe+U70o/9L//y94i?=
 =?us-ascii?Q?vPjre/+9VjE6+1waklTU3hnAz3dpcZR6X5j24brJwiQkG1s1/lsAQmhA7wvW?=
 =?us-ascii?Q?V9VYcgTK956w/4ne0fs07o/yQh9txNxB42tuCC71DDr90D0grMPXB1Fg914B?=
 =?us-ascii?Q?VNs55sHHe+fJPKleHsZfLeiVdx09c4hIdDjKyvOLE7FjHa4tCnXw5es0wNPr?=
 =?us-ascii?Q?T3SlURrbtjG0ybDMerFaizzHU765WAbiGHX1ExxMbzb2tQwJmBhPGbWkrWSa?=
 =?us-ascii?Q?AdHx4k2DtVJYIE4pmABIeaQzDLcJNX6rtHBfQLakjT3V+LHL/hir1rwDCV5b?=
 =?us-ascii?Q?bFh4RBHUtvQ1Xm6oJW6QGpzdmrzUvPSRNolOZmURF9NnolAcIMniLUP5823j?=
 =?us-ascii?Q?sO7DhpOnANFH8+wi+AbkOyUY5frS4zKPCzIpW8aRaz+S0SRii4t5HiTa3bUZ?=
 =?us-ascii?Q?vfgF9RudUuoZHbMkUOcFTGy4r8IaR3FAX0iH4eSu/j3sxrXnkw8m5vhvxCEz?=
 =?us-ascii?Q?9lBHPk7SOAygzZBnMCl7CkQyHTUQOUyeFyPeFFrcFYe2XdczU2A58OLEsT4g?=
 =?us-ascii?Q?A8PslzQaO+ENE2Oh6fxOlr3Mbd/7dLMibR8MAkXrpqo7pt5J5tLwtNh/G8Sn?=
 =?us-ascii?Q?19YjS+FGv4swma/hEugCO1nYu3DssuHvSWEwlSZN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204bae92-e45d-4244-3666-08dbb055a405
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:23:27.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYm96bUAJfCZGIxkkMR4R+UU8kImv6AD9dFDaoC627Jmcwg8K3+FV3V0Xvbh4gEXiGrbe7NMYpxHm7dVp+iFog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ufshcd_wb_buf_resize is used to enable WB buffer resize. It first blocks
the upper layer from issuing reqs, then waits for the cmd queue to be
empty, and then issues the command to enable WB buffer resize.

It may be called anywhere, such as ufs-sysfs.c, so it needs to be declared
in the header files.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/ufs/core/ufshcd-priv.h |  1 +
 drivers/ufs/core/ufshcd.c      | 21 +++++++++++++++++++++
 include/ufs/ufshcd.h           |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index f42d99ce5bf1..85caefa421f7 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -98,6 +98,7 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 			     enum query_opcode desc_op);
 
 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
+int ufshcd_wb_buf_resize(struct ufs_hba *hba, u32 resize_op);
 
 /* Wrapper functions for safely calling variant operations */
 static inline const char *ufshcd_get_var_name(struct ufs_hba *hba)
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 93417518c04d..7e4461360cbd 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6045,6 +6045,27 @@ static bool ufshcd_wb_need_flush(struct ufs_hba *hba)
 	return ufshcd_wb_presrv_usrspc_keep_vcc_on(hba, avail_buf);
 }
 
+int ufshcd_wb_buf_resize(struct ufs_hba *hba, u32 resize_op)
+{
+	int ret;
+	u8 index;
+
+	ufshcd_scsi_block_requests(hba);
+	if (ufshcd_wait_for_doorbell_clr(hba, 1 * USEC_PER_SEC))
+		goto out;
+
+	index = ufshcd_wb_get_query_index(hba);
+	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+		QUERY_ATTR_IDN_WB_BUF_RESIZE_EN, index, 0, &resize_op);
+	if (ret)
+		dev_err(hba->dev,
+			"%s: Enable WB buf resize operation failed %d\n",
+			__func__, ret);
+out:
+	ufshcd_scsi_unblock_requests(hba);
+	return ret;
+}
+
 static void ufshcd_rpm_dev_flush_recheck_work(struct work_struct *work)
 {
 	struct ufs_hba *hba = container_of(to_delayed_work(work),
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7d07b256e906..7dd560dc22c6 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1381,6 +1381,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 				     struct ufs_ehs *ehs_rsp, int sg_cnt,
 				     struct scatterlist *sg_list, enum dma_data_direction dir);
 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
+int ufshcd_wb_buf_resize(struct ufs_hba *hba, u32 resize_op);
 int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
 int ufshcd_suspend_prepare(struct device *dev);
 int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);
-- 
2.39.0

