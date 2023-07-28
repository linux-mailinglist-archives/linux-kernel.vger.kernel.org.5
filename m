Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865B766E14
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjG1NYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjG1NYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:24:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA446DB;
        Fri, 28 Jul 2023 06:24:49 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S6170J028640;
        Fri, 28 Jul 2023 13:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=37MAkPsjaGX96mlWuIqcGnQpu5z2Xqn8aWxHFzyYNf0=;
 b=g0m2otUrw/GW1Sf1ZVfg7MBGup6eJ87cXtTLROQwKEAsGoPAkgPSHu+4lzeZ+KtMed15
 1LSd6+T4GDxnCuf16D6QgDzSmXWdDpSOlBEBRyr9lv00sWqlr+SVd3anl31+koXkG9UX
 TK8oZexokoLxJ727EDl2CfZU+wPDmuLq8WkWvbO9GsgqN+hP/lee6raUsYJZuJ+tSzGM
 l5wIFMw2bEYuv6TA2Zmi6IOUj19AgyA1uQOMY8Jf5oQ1hx2CHxnnTlwoUBN3tfLxOMhm
 L6CYBrJjt2kMB2n83OqlbHWmYSDFWZK/+CP8FHVmjKkMOdNziT3p5A/rNt7Ud12WTWT5 jw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s416m9f7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:24:37 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDOacS000681
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:24:36 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:24:32 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 00/33] Qualcomm video decoder/encoder driver 
Date:   Fri, 28 Jul 2023 18:53:11 +0530
Message-ID: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9QZNoLJjWGzWoaOmvjyTKD2Hm4m8Kibm
X-Proofpoint-ORIG-GUID: 9QZNoLJjWGzWoaOmvjyTKD2Hm4m8Kibm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces support for Qualcomm new video acceleration
hardware architecture, used for video stream decoding/encoding. This driver
is based on new communication protocol between video hardware and application
processor.

This driver comes with below capabilities:
- V4L2 complaint video driver with M2M and STREAMING capability.
- Supports H264, H265, VP9 decoders.
- Supports H264, H265 encoders.

This driver comes with below features:
- Centralized resource and memory management.
- Centralized management of core and instance states.
- Defines platform specific capabilities and features. As a results, it provides
  a single point of control to enable/disable a given feature depending on 
  specific platform capabilities.
- Handles hardware interdependent configurations. For a given configuration from
  client, the driver checks for hardware dependent configuration/s and updates
  the same.
- Handles multiple complex video scenarios involving state transitions - DRC,
  Drain, Seek, back to back DRC, DRC during Drain sequence, DRC during Seek
  sequence.
- Introduces a flexible way for driver to subscribe for any property with
  hardware. Hardware would inform driver with those subscribed property with any
  change in value.
- Introduces performance (clock and bus) model based on new hardware
  architecture.
- Introduces multi thread safe design to handle communication between client and
  hardware.
- Adapts encoder quality improvements available in new hardware architecture.
- Implements asynchronous communication with hardware to achieve better
  experience in low latency usecases.
- Supports multi stage hardware architecture for encode/decode.
- Output and capture planes are controlled independently. Thereby providing a
  way to reconfigure individual plane.
- Hardware packetization layer supports synchronization between configuration
  packet and data packet.
- Introduces a flexibility to receive a hardware response for a given command
  packet.
- Native hardware support of LAST flag which is mandatory to align with port
  reconfiguration and DRAIN sequence as per V4L guidelines.
- Native hardware support for drain sequence.

I think that the driver is in good shape for mainline kernel, and I hope the
review comments will help to improve it, so please do review, and make comments.

Dikshita Agarwal (17):
  iris: vidc: add core functions
  iris: add vidc wrapper file
  iris: vidc: add vb2 ops
  iris: vidc: add helpers for memory management
  iris: vidc: add helper functions for resource management
  iris: vidc: add helper functions for power management
  iris: add helpers for media format
  iris: vidc: add PIL functionality for video firmware
  iris: platform: add platform files
  iris: platform: sm8550: add capability file for sm8550
  iris: variant: add helper functions for register handling
  iris: variant: iris3: add iris3 specific ops
  iris: variant: iris3: add helpers for buffer size calculations
  iris: variant: iris3: add helper for bus and clock calculation
  iris: variant: iris: implement the logic to compute bus bandwidth
  iris: variant: iris3: implement logic to compute clock frequency
  iris: enable building of iris video driver

Vikash Garodia (16):
  MAINTAINERS: Add Qualcomm Iris video accelerator driver
  iris: vidc: add v4l2 wrapper file
  iris: vidc: define video core and instance context
  iris: iris: add video encoder files
  iris: vidc: add video decoder files
  iris: vidc: add control files
  iris: vidc: add helper functions
  iris: vidc: add helpers for state management
  iris: add vidc buffer files
  iris: vidc: define various structures and enum
  iris: vidc: hfi: add Host Firmware Interface (HFI)
  iris: vidc: hfi: add Host Firmware Interface (HFI) response handling
  iris: vidc: hfi: add helpers for handling shared queues
  iris: vidc: hfi: Add packetization layer
  iris: vidc: hfi: defines HFI properties and enums
  iris: vidc: add debug files

 MAINTAINERS                                        |   10 +
 drivers/media/platform/qcom/Kconfig                |    1 +
 drivers/media/platform/qcom/Makefile               |    1 +
 drivers/media/platform/qcom/iris/Kconfig           |   15 +
 drivers/media/platform/qcom/iris/Makefile          |   46 +
 .../iris/platform/common/inc/msm_vidc_platform.h   |  305 ++
 .../iris/platform/common/src/msm_vidc_platform.c   | 2499 ++++++++++++
 .../iris/platform/sm8550/inc/msm_vidc_sm8550.h     |   14 +
 .../iris/platform/sm8550/src/msm_vidc_sm8550.c     | 1727 ++++++++
 .../iris/variant/common/inc/msm_vidc_variant.h     |   22 +
 .../iris/variant/common/src/msm_vidc_variant.c     |  163 +
 .../qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h | 1481 +++++++
 .../iris/variant/iris3/inc/msm_vidc_buffer_iris3.h |   19 +
 .../qcom/iris/variant/iris3/inc/msm_vidc_iris3.h   |   15 +
 .../iris/variant/iris3/inc/msm_vidc_power_iris3.h  |   17 +
 .../iris/variant/iris3/inc/perf_static_model.h     |  229 ++
 .../iris/variant/iris3/src/msm_vidc_buffer_iris3.c |  595 +++
 .../iris/variant/iris3/src/msm_vidc_bus_iris3.c    |  884 ++++
 .../iris/variant/iris3/src/msm_vidc_clock_iris3.c  |  627 +++
 .../qcom/iris/variant/iris3/src/msm_vidc_iris3.c   |  954 +++++
 .../iris/variant/iris3/src/msm_vidc_power_iris3.c  |  345 ++
 .../media/platform/qcom/iris/vidc/inc/firmware.h   |   18 +
 .../platform/qcom/iris/vidc/inc/hfi_command.h      |  190 +
 .../media/platform/qcom/iris/vidc/inc/hfi_packet.h |   52 +
 .../platform/qcom/iris/vidc/inc/hfi_property.h     |  666 +++
 .../platform/qcom/iris/vidc/inc/msm_media_info.h   |  599 +++
 .../media/platform/qcom/iris/vidc/inc/msm_vdec.h   |   40 +
 .../media/platform/qcom/iris/vidc/inc/msm_venc.h   |   34 +
 .../media/platform/qcom/iris/vidc/inc/msm_vidc.h   |   60 +
 .../platform/qcom/iris/vidc/inc/msm_vidc_buffer.h  |   32 +
 .../platform/qcom/iris/vidc/inc/msm_vidc_control.h |   26 +
 .../platform/qcom/iris/vidc/inc/msm_vidc_core.h    |  165 +
 .../platform/qcom/iris/vidc/inc/msm_vidc_debug.h   |  186 +
 .../platform/qcom/iris/vidc/inc/msm_vidc_driver.h  |  352 ++
 .../platform/qcom/iris/vidc/inc/msm_vidc_inst.h    |  207 +
 .../qcom/iris/vidc/inc/msm_vidc_internal.h         |  787 ++++
 .../platform/qcom/iris/vidc/inc/msm_vidc_memory.h  |   83 +
 .../platform/qcom/iris/vidc/inc/msm_vidc_power.h   |   94 +
 .../platform/qcom/iris/vidc/inc/msm_vidc_state.h   |  102 +
 .../platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h    |   77 +
 .../platform/qcom/iris/vidc/inc/msm_vidc_vb2.h     |   39 +
 .../media/platform/qcom/iris/vidc/inc/resources.h  |  259 ++
 .../media/platform/qcom/iris/vidc/inc/venus_hfi.h  |   66 +
 .../platform/qcom/iris/vidc/inc/venus_hfi_queue.h  |   89 +
 .../qcom/iris/vidc/inc/venus_hfi_response.h        |   26 +
 .../media/platform/qcom/iris/vidc/src/firmware.c   |  294 ++
 .../media/platform/qcom/iris/vidc/src/hfi_packet.c |  657 +++
 .../media/platform/qcom/iris/vidc/src/msm_vdec.c   | 2091 ++++++++++
 .../media/platform/qcom/iris/vidc/src/msm_venc.c   | 1484 +++++++
 .../media/platform/qcom/iris/vidc/src/msm_vidc.c   |  841 ++++
 .../platform/qcom/iris/vidc/src/msm_vidc_buffer.c  |  290 ++
 .../platform/qcom/iris/vidc/src/msm_vidc_control.c |  824 ++++
 .../platform/qcom/iris/vidc/src/msm_vidc_debug.c   |  581 +++
 .../platform/qcom/iris/vidc/src/msm_vidc_driver.c  | 4276 ++++++++++++++++++++
 .../platform/qcom/iris/vidc/src/msm_vidc_memory.c  |  448 ++
 .../platform/qcom/iris/vidc/src/msm_vidc_power.c   |  560 +++
 .../platform/qcom/iris/vidc/src/msm_vidc_probe.c   |  660 +++
 .../platform/qcom/iris/vidc/src/msm_vidc_state.c   | 1607 ++++++++
 .../platform/qcom/iris/vidc/src/msm_vidc_v4l2.c    |  953 +++++
 .../platform/qcom/iris/vidc/src/msm_vidc_vb2.c     |  605 +++
 .../media/platform/qcom/iris/vidc/src/resources.c  | 1321 ++++++
 .../media/platform/qcom/iris/vidc/src/venus_hfi.c  | 1503 +++++++
 .../platform/qcom/iris/vidc/src/venus_hfi_queue.c  |  537 +++
 .../qcom/iris/vidc/src/venus_hfi_response.c        | 1607 ++++++++
 64 files changed, 35357 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/Kconfig
 create mode 100644 drivers/media/platform/qcom/iris/Makefile
 create mode 100644 drivers/media/platform/qcom/iris/platform/common/inc/msm_vidc_platform.h
 create mode 100644 drivers/media/platform/qcom/iris/platform/common/src/msm_vidc_platform.c
 create mode 100644 drivers/media/platform/qcom/iris/platform/sm8550/inc/msm_vidc_sm8550.h
 create mode 100644 drivers/media/platform/qcom/iris/platform/sm8550/src/msm_vidc_sm8550.c
 create mode 100644 drivers/media/platform/qcom/iris/variant/common/inc/msm_vidc_variant.h
 create mode 100644 drivers/media/platform/qcom/iris/variant/common/src/msm_vidc_variant.c
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/msm_vidc_buffer_iris3.h
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/msm_vidc_iris3.h
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/msm_vidc_power_iris3.h
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/perf_static_model.h
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_buffer_iris3.c
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_bus_iris3.c
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_clock_iris3.c
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_iris3.c
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_power_iris3.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/firmware.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/hfi_command.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/hfi_packet.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/hfi_property.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_media_info.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vdec.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_venc.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_buffer.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_control.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_core.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_debug.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_driver.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_inst.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_internal.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_memory.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_power.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_state.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_vb2.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/resources.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hfi.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_response.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/firmware.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/hfi_packet.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vdec.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_venc.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_buffer.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_control.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_debug.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_driver.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_power.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_state.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_vb2.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/resources.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hfi_response.c

-- 
2.7.4

