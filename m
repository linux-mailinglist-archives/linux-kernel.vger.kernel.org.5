Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03AE7660D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjG1AnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjG1AnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:43:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B5187;
        Thu, 27 Jul 2023 17:43:06 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S0AHXm013560;
        Fri, 28 Jul 2023 00:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=5JI1oAtrtqHD9v444USIfO1qH7EuTp1K7XQD/pQ4yP4=;
 b=OAvs42dpoHPuBdLd716iZHz6QYVZ1K3bXX22+hUPgHOetwjxWiw5P4mgxue6sEY8FZ+/
 1WXtrlKfJDPM61M2lljmAjeaBdeAM92Q7/nPhrekSGApL2R0yqz+ZM2pctAvkudlwtC/
 TLa19G4Y8pgQ8DBQ3XV/5Dr4whV6OHDilfDfnOa1XRDW0waOmV2Nxgd/bTs+ImZfXrxJ
 8i6n4lis2j0EwoE+baQUTaIbloE96gFZzV8F7YHz4D0HopGy49jojRoG+fqmFVXaQ5zi
 WNVoTM+9A51sU+SKRSZBI2QIsWZMrgleeeHA4iyPsk65DskdQEiSi0ee1IKgzZwbCVpv GA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3b0g3497-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 00:42:56 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S0gtB7005616
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 00:42:55 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 17:42:55 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 1/2] firmware: qcom_scm: Convert all symbols to EXPORT_SYMBOL_GPL
Date:   Thu, 27 Jul 2023 17:42:48 -0700
Message-ID: <19d9ac0bf79f957574ef9b3b73246ea0113cc0fd.1690503893.git.quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qE__wD6tb0AH4K14-CQIP2HXV2kkgqvZ
X-Proofpoint-ORIG-GUID: qE__wD6tb0AH4K14-CQIP2HXV2kkgqvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280003
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `qcom_scm` module is GPL v2-licenced and so there is no reason why
the APIs it exports should not be, too.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 drivers/firmware/qcom_scm.c | 66 ++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index fde33acd46b7..9ffecf460086 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -351,7 +351,7 @@ int qcom_scm_set_warm_boot_addr(void *entry)
 		return qcom_scm_set_boot_addr(entry, qcom_scm_cpu_warm_bits);
 	return 0;
 }
-EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
+EXPORT_SYMBOL_GPL(qcom_scm_set_warm_boot_addr);
 
 /**
  * qcom_scm_set_cold_boot_addr() - Set the cold boot address for all cpus
@@ -364,7 +364,7 @@ int qcom_scm_set_cold_boot_addr(void *entry)
 		return qcom_scm_set_boot_addr(entry, qcom_scm_cpu_cold_bits);
 	return 0;
 }
-EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
+EXPORT_SYMBOL_GPL(qcom_scm_set_cold_boot_addr);
 
 /**
  * qcom_scm_cpu_power_down() - Power down the cpu
@@ -386,7 +386,7 @@ void qcom_scm_cpu_power_down(u32 flags)
 
 	qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
 }
-EXPORT_SYMBOL(qcom_scm_cpu_power_down);
+EXPORT_SYMBOL_GPL(qcom_scm_cpu_power_down);
 
 int qcom_scm_set_remote_state(u32 state, u32 id)
 {
@@ -405,7 +405,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
 
 	return ret ? : res.result[0];
 }
-EXPORT_SYMBOL(qcom_scm_set_remote_state);
+EXPORT_SYMBOL_GPL(qcom_scm_set_remote_state);
 
 static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 {
@@ -515,7 +515,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 
 	return ret ? : res.result[0];
 }
-EXPORT_SYMBOL(qcom_scm_pas_init_image);
+EXPORT_SYMBOL_GPL(qcom_scm_pas_init_image);
 
 /**
  * qcom_scm_pas_metadata_release() - release metadata context
@@ -532,7 +532,7 @@ void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
 	ctx->phys = 0;
 	ctx->size = 0;
 }
-EXPORT_SYMBOL(qcom_scm_pas_metadata_release);
+EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
 
 /**
  * qcom_scm_pas_mem_setup() - Prepare the memory related to a given peripheral
@@ -571,7 +571,7 @@ int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
 
 	return ret ? : res.result[0];
 }
-EXPORT_SYMBOL(qcom_scm_pas_mem_setup);
+EXPORT_SYMBOL_GPL(qcom_scm_pas_mem_setup);
 
 /**
  * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware
@@ -606,7 +606,7 @@ int qcom_scm_pas_auth_and_reset(u32 peripheral)
 
 	return ret ? : res.result[0];
 }
-EXPORT_SYMBOL(qcom_scm_pas_auth_and_reset);
+EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
 
 /**
  * qcom_scm_pas_shutdown() - Shut down the remote processor
@@ -641,7 +641,7 @@ int qcom_scm_pas_shutdown(u32 peripheral)
 
 	return ret ? : res.result[0];
 }
-EXPORT_SYMBOL(qcom_scm_pas_shutdown);
+EXPORT_SYMBOL_GPL(qcom_scm_pas_shutdown);
 
 /**
  * qcom_scm_pas_supported() - Check if the peripheral authentication service is
@@ -670,7 +670,7 @@ bool qcom_scm_pas_supported(u32 peripheral)
 
 	return ret ? false : !!res.result[0];
 }
-EXPORT_SYMBOL(qcom_scm_pas_supported);
+EXPORT_SYMBOL_GPL(qcom_scm_pas_supported);
 
 static int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 {
@@ -732,7 +732,7 @@ int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val)
 
 	return ret < 0 ? ret : 0;
 }
-EXPORT_SYMBOL(qcom_scm_io_readl);
+EXPORT_SYMBOL_GPL(qcom_scm_io_readl);
 
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val)
 {
@@ -747,7 +747,7 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val)
 
 	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
 }
-EXPORT_SYMBOL(qcom_scm_io_writel);
+EXPORT_SYMBOL_GPL(qcom_scm_io_writel);
 
 /**
  * qcom_scm_restore_sec_cfg_available() - Check if secure environment
@@ -760,7 +760,7 @@ bool qcom_scm_restore_sec_cfg_available(void)
 	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_MP,
 					    QCOM_SCM_MP_RESTORE_SEC_CFG);
 }
-EXPORT_SYMBOL(qcom_scm_restore_sec_cfg_available);
+EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg_available);
 
 int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
 {
@@ -779,7 +779,7 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
 
 	return ret ? : res.result[0];
 }
-EXPORT_SYMBOL(qcom_scm_restore_sec_cfg);
+EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg);
 
 int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
 {
@@ -800,7 +800,7 @@ int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
 
 	return ret ? : res.result[1];
 }
-EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_size);
+EXPORT_SYMBOL_GPL(qcom_scm_iommu_secure_ptbl_size);
 
 int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
 {
@@ -824,7 +824,7 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
 
 	return ret;
 }
-EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_init);
+EXPORT_SYMBOL_GPL(qcom_scm_iommu_secure_ptbl_init);
 
 int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size)
 {
@@ -839,7 +839,7 @@ int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size)
 
 	return qcom_scm_call(__scm->dev, &desc, NULL);
 }
-EXPORT_SYMBOL(qcom_scm_iommu_set_cp_pool_size);
+EXPORT_SYMBOL_GPL(qcom_scm_iommu_set_cp_pool_size);
 
 int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
 				   u32 cp_nonpixel_start,
@@ -863,7 +863,7 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
 
 	return ret ? : res.result[0];
 }
-EXPORT_SYMBOL(qcom_scm_mem_protect_video_var);
+EXPORT_SYMBOL_GPL(qcom_scm_mem_protect_video_var);
 
 static int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
 				 size_t mem_sz, phys_addr_t src, size_t src_sz,
@@ -972,7 +972,7 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 	*srcvm = next_vm;
 	return 0;
 }
-EXPORT_SYMBOL(qcom_scm_assign_mem);
+EXPORT_SYMBOL_GPL(qcom_scm_assign_mem);
 
 /**
  * qcom_scm_ocmem_lock_available() - is OCMEM lock/unlock interface available
@@ -982,7 +982,7 @@ bool qcom_scm_ocmem_lock_available(void)
 	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_OCMEM,
 					    QCOM_SCM_OCMEM_LOCK_CMD);
 }
-EXPORT_SYMBOL(qcom_scm_ocmem_lock_available);
+EXPORT_SYMBOL_GPL(qcom_scm_ocmem_lock_available);
 
 /**
  * qcom_scm_ocmem_lock() - call OCMEM lock interface to assign an OCMEM
@@ -1008,7 +1008,7 @@ int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset, u32 size,
 
 	return qcom_scm_call(__scm->dev, &desc, NULL);
 }
-EXPORT_SYMBOL(qcom_scm_ocmem_lock);
+EXPORT_SYMBOL_GPL(qcom_scm_ocmem_lock);
 
 /**
  * qcom_scm_ocmem_unlock() - call OCMEM unlock interface to release an OCMEM
@@ -1031,7 +1031,7 @@ int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset, u32 size)
 
 	return qcom_scm_call(__scm->dev, &desc, NULL);
 }
-EXPORT_SYMBOL(qcom_scm_ocmem_unlock);
+EXPORT_SYMBOL_GPL(qcom_scm_ocmem_unlock);
 
 /**
  * qcom_scm_ice_available() - Is the ICE key programming interface available?
@@ -1046,7 +1046,7 @@ bool qcom_scm_ice_available(void)
 		__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_ES,
 					     QCOM_SCM_ES_CONFIG_SET_ICE_KEY);
 }
-EXPORT_SYMBOL(qcom_scm_ice_available);
+EXPORT_SYMBOL_GPL(qcom_scm_ice_available);
 
 /**
  * qcom_scm_ice_invalidate_key() - Invalidate an inline encryption key
@@ -1072,7 +1072,7 @@ int qcom_scm_ice_invalidate_key(u32 index)
 
 	return qcom_scm_call(__scm->dev, &desc, NULL);
 }
-EXPORT_SYMBOL(qcom_scm_ice_invalidate_key);
+EXPORT_SYMBOL_GPL(qcom_scm_ice_invalidate_key);
 
 /**
  * qcom_scm_ice_set_key() - Set an inline encryption key
@@ -1138,7 +1138,7 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 	dma_free_coherent(__scm->dev, key_size, keybuf, key_phys);
 	return ret;
 }
-EXPORT_SYMBOL(qcom_scm_ice_set_key);
+EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
 
 /**
  * qcom_scm_hdcp_available() - Check if secure environment supports HDCP.
@@ -1160,7 +1160,7 @@ bool qcom_scm_hdcp_available(void)
 
 	return avail;
 }
-EXPORT_SYMBOL(qcom_scm_hdcp_available);
+EXPORT_SYMBOL_GPL(qcom_scm_hdcp_available);
 
 /**
  * qcom_scm_hdcp_req() - Send HDCP request.
@@ -1207,7 +1207,7 @@ int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
 
 	return ret;
 }
-EXPORT_SYMBOL(qcom_scm_hdcp_req);
+EXPORT_SYMBOL_GPL(qcom_scm_hdcp_req);
 
 int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt)
 {
@@ -1223,7 +1223,7 @@ int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt)
 
 	return qcom_scm_call(__scm->dev, &desc, NULL);
 }
-EXPORT_SYMBOL(qcom_scm_iommu_set_pt_format);
+EXPORT_SYMBOL_GPL(qcom_scm_iommu_set_pt_format);
 
 int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
 {
@@ -1239,13 +1239,13 @@ int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
 
 	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
 }
-EXPORT_SYMBOL(qcom_scm_qsmmu500_wait_safe_toggle);
+EXPORT_SYMBOL_GPL(qcom_scm_qsmmu500_wait_safe_toggle);
 
 bool qcom_scm_lmh_dcvsh_available(void)
 {
 	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_LMH, QCOM_SCM_LMH_LIMIT_DCVSH);
 }
-EXPORT_SYMBOL(qcom_scm_lmh_dcvsh_available);
+EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
 
 int qcom_scm_lmh_profile_change(u32 profile_id)
 {
@@ -1259,7 +1259,7 @@ int qcom_scm_lmh_profile_change(u32 profile_id)
 
 	return qcom_scm_call(__scm->dev, &desc, NULL);
 }
-EXPORT_SYMBOL(qcom_scm_lmh_profile_change);
+EXPORT_SYMBOL_GPL(qcom_scm_lmh_profile_change);
 
 int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		       u64 limit_node, u32 node_id, u64 version)
@@ -1297,7 +1297,7 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
 	return ret;
 }
-EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);
+EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh);
 
 static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
 {
@@ -1332,7 +1332,7 @@ bool qcom_scm_is_available(void)
 {
 	return !!__scm;
 }
-EXPORT_SYMBOL(qcom_scm_is_available);
+EXPORT_SYMBOL_GPL(qcom_scm_is_available);
 
 static int qcom_scm_assert_valid_wq_ctx(u32 wq_ctx)
 {

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.40.0

