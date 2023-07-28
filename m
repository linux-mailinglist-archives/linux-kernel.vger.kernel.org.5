Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BBF766F73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbjG1O2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbjG1O2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:28:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4423A95;
        Fri, 28 Jul 2023 07:27:59 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S6ckg4012494;
        Fri, 28 Jul 2023 13:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7E6kElnq6c3Yp/nIQlsBCyWrx67x40jTdIWWziqzz7Y=;
 b=Z+SfZ51enjD7WCDBRqzC7HMNpZH7q+z92AwyohUaIOe6UsXsjVuwYLITfNSO1eTOiy8l
 qy1gPwj6F+clJcfdpXHNVYYHRwTgsGZITHRXohOAeUp2HJj4xI6KVyrPpUD5t/UE+D7c
 2vFEb9eYZQcoS/F5G75mNKW99/OC+oUvmF0uVLOQBZ1N1XE2i4I6jyvSvTMA7Z2HkFQI
 wdBOjb9dJ6jZxR7YdzjLy0JaepXEXHEEp9KE8bEDKaJ0cmqvkHKSXUZLXHRbtRD2So6b
 8HlY9W90kgoN0EJgXP/qSuF6Z98RSgC+8ad/Ih9BmVWOTkZBgrf/zebHPrC/54bw4oYb iQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s447kh7vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:27:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDR4nF015169
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:27:04 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:27:00 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 33/33] iris: enable building of iris video driver
Date:   Fri, 28 Jul 2023 18:53:44 +0530
Message-ID: <1690550624-14642-34-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kmev0UsJhFeeKN2MADZqcsMNuHnixTqU
X-Proofpoint-GUID: kmev0UsJhFeeKN2MADZqcsMNuHnixTqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=973
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

This adds iris driver Makefile and Kconfig, also changes
v4l2 platform/qcom Makefile/Kconfig in order to
enable compilation of the driver.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/Kconfig       |  1 +
 drivers/media/platform/qcom/Makefile      |  1 +
 drivers/media/platform/qcom/iris/Kconfig  | 15 ++++++++++
 drivers/media/platform/qcom/iris/Makefile | 46 +++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/Kconfig
 create mode 100644 drivers/media/platform/qcom/iris/Makefile

diff --git a/drivers/media/platform/qcom/Kconfig b/drivers/media/platform/qcom/Kconfig
index cc5799b..b86bebd 100644
--- a/drivers/media/platform/qcom/Kconfig
+++ b/drivers/media/platform/qcom/Kconfig
@@ -4,3 +4,4 @@ comment "Qualcomm media platform drivers"
 
 source "drivers/media/platform/qcom/camss/Kconfig"
 source "drivers/media/platform/qcom/venus/Kconfig"
+source "drivers/media/platform/qcom/iris/Kconfig"
diff --git a/drivers/media/platform/qcom/Makefile b/drivers/media/platform/qcom/Makefile
index 4f055c3..83eea29 100644
--- a/drivers/media/platform/qcom/Makefile
+++ b/drivers/media/platform/qcom/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += camss/
 obj-y += venus/
+obj-y += iris/
diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
new file mode 100644
index 0000000..d434c31
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/Kconfig
@@ -0,0 +1,15 @@
+config VIDEO_QCOM_IRIS
+	tristate "Qualcomm Iris V4L2 encoder/decoder driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && QCOM_SMEM
+	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
+	select QCOM_MDT_LOADER if ARCH_QCOM
+	select QCOM_SCM
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	select DMABUF_HEAPS
+	help
+	  This is a V4L2 driver for Qualcomm Iris video accelerator
+	  hardware. It accelerates encoding and decoding operations
+	  on various Qualcomm SoCs.
+	  To compile this driver as a module choose m here.
diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
new file mode 100644
index 0000000..e681c4f
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/Makefile
@@ -0,0 +1,46 @@
+KBUILD_OPTIONS+= VIDEO_ROOT=$(KERNEL_SRC)/$(M)
+
+VIDEO_COMPILE_TIME = $(shell date)
+VIDEO_COMPILE_BY = $(shell whoami | sed 's/\\/\\\\/')
+VIDEO_COMPILE_HOST = $(shell uname -n)
+VIDEO_GEN_PATH = $(srctree)/$(src)/vidc/inc/video_generated_h
+
+$(shell echo '#define VIDEO_COMPILE_TIME "$(VIDEO_COMPILE_TIME)"' > $(VIDEO_GEN_PATH))
+$(shell echo '#define VIDEO_COMPILE_BY "$(VIDEO_COMPILE_BY)"' >> $(VIDEO_GEN_PATH))
+$(shell echo '#define VIDEO_COMPILE_HOST "$(VIDEO_COMPILE_HOST)"' >> $(VIDEO_GEN_PATH))
+
+iris-objs += vidc/src/msm_vidc_v4l2.o \
+                  vidc/src/msm_vidc_vb2.o \
+                  vidc/src/msm_vidc.o \
+                  vidc/src/msm_vdec.o \
+                  vidc/src/msm_venc.o \
+                  vidc/src/msm_vidc_driver.o \
+                  vidc/src/msm_vidc_control.o \
+                  vidc/src/msm_vidc_buffer.o \
+                  vidc/src/msm_vidc_power.o \
+                  vidc/src/msm_vidc_probe.o \
+                  vidc/src/resources.o \
+                  vidc/src/firmware.o \
+                  vidc/src/msm_vidc_debug.o \
+                  vidc/src/msm_vidc_memory.o \
+                  vidc/src/venus_hfi.o \
+                  vidc/src/venus_hfi_queue.o \
+                  vidc/src/hfi_packet.o \
+                  vidc/src/venus_hfi_response.o \
+                  vidc/src/msm_vidc_state.o \
+                  platform/common/src/msm_vidc_platform.o \
+                  platform/sm8550/src/msm_vidc_sm8550.o \
+                  variant/common/src/msm_vidc_variant.o \
+                  variant/iris3/src/msm_vidc_buffer_iris3.o \
+                  variant/iris3/src/msm_vidc_iris3.o \
+                  variant/iris3/src/msm_vidc_power_iris3.o \
+                  variant/iris3/src/msm_vidc_bus_iris3.o \
+                  variant/iris3/src/msm_vidc_clock_iris3.o
+
+obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
+
+ccflags-y += -I$(srctree)/$(src)/vidc/inc
+ccflags-y += -I$(srctree)/$(src)/platform/common/inc
+ccflags-y += -I$(srctree)/$(src)/platform/sm8550/inc
+ccflags-y += -I$(srctree)/$(src)/variant/common/inc
+ccflags-y += -I$(srctree)/$(src)/variant/iris3/inc
-- 
2.7.4

