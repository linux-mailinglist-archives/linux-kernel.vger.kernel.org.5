Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E07A7AA3B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjIUVyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjIUVxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:53:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4392610D9;
        Thu, 21 Sep 2023 14:49:42 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LKGLW7015079;
        Thu, 21 Sep 2023 21:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SG9o3eOQsGYWtNJxelFkBEOj4dc84BORgsU3tNFO0jo=;
 b=AvsiZwZvIzy8mDGgu+2b7lXAp1BrJDj3OFeKpNqs4IPn3RLuYfo9HVIjEqMbr8hcxzs3
 gZYtKMNlpCnKyPLNDes15pUZFmZsOklst+HuTMlFnGE1wXzOVxn6246kiaWlquWSnCLk
 rVVFO6LIcDDxAwCgl5xislUl8sgcayIraK1r+N9TODBNjkqXryB1tuv7dIEVDG6eJcYC
 EqjCB9qkKKzGImejHTUPQdsItPL9pxEniMv7AW5+s9gediczHpj2kJ9Ng+cUqRfh3FHu
 nvO790w7NpcquBFvKtN71DkLBCJoejT7QiUcfBYtGdVvC4g4cw+XfihiylO6zovnyW9P ow== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u5n0bq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:49:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LLmwFV032695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:48:58 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 21 Sep 2023 14:48:57 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v7 17/33] ALSA: usb-audio: qcom: Add USB QMI definitions
Date:   Thu, 21 Sep 2023 14:48:27 -0700
Message-ID: <20230921214843.18450-18-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921214843.18450-1-quic_wcheng@quicinc.com>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D3ObaRTlykKNmcDfqZM51GKq5THCCqML
X-Proofpoint-GUID: D3ObaRTlykKNmcDfqZM51GKq5THCCqML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm USB audio offload driver utilizes the QMI protocol to
communicate with the audio DSP.  Add the necessary QMI header and field
definitions, so the QMI interface driver is able to route the QMI packet
received to the USB audio offload driver.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/qcom/usb_audio_qmi_v01.c | 892 +++++++++++++++++++++++++++++
 sound/usb/qcom/usb_audio_qmi_v01.h | 162 ++++++
 2 files changed, 1054 insertions(+)
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.c
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.h

diff --git a/sound/usb/qcom/usb_audio_qmi_v01.c b/sound/usb/qcom/usb_audio_qmi_v01.c
new file mode 100644
index 000000000000..bdfd67d980eb
--- /dev/null
+++ b/sound/usb/qcom/usb_audio_qmi_v01.c
@@ -0,0 +1,892 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/soc/qcom/qmi.h>
+
+#include "usb_audio_qmi_v01.h"
+
+static struct qmi_elem_info mem_info_v01_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_8_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u64),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct mem_info_v01, va),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_8_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u64),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct mem_info_v01, pa),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct mem_info_v01, size),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static struct qmi_elem_info apps_mem_info_v01_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct apps_mem_info_v01, evt_ring),
+		.ei_array	= mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct apps_mem_info_v01, tr_data),
+		.ei_array	= mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct apps_mem_info_v01, tr_sync),
+		.ei_array	= mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct apps_mem_info_v01, xfer_buff),
+		.ei_array	= mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct apps_mem_info_v01, dcba),
+		.ei_array	= mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static struct qmi_elem_info usb_endpoint_descriptor_v01_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bLength),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bDescriptorType),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bEndpointAddress),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bmAttributes),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_2_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u16),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						wMaxPacketSize),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bInterval),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bRefresh),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_endpoint_descriptor_v01,
+						bSynchAddress),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static struct qmi_elem_info usb_interface_descriptor_v01_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bLength),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bDescriptorType),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bInterfaceNumber),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bAlternateSetting),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bNumEndpoints),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bInterfaceClass),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bInterfaceSubClass),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						bInterfaceProtocol),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct usb_interface_descriptor_v01,
+						iInterface),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info qmi_uaudio_stream_req_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x01,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						enable),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						usb_token),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						audio_format_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						audio_format),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						number_of_ch_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						number_of_ch),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						bit_rate_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						bit_rate),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						xfer_buff_size_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						xfer_buff_size),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						service_interval_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(struct qmi_uaudio_stream_req_msg_v01,
+						service_interval),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info qmi_uaudio_stream_resp_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct qmi_response_type_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					resp),
+		.ei_array	= qmi_response_type_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					status_valid),
+	},
+	{
+		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
+		.elem_len	= 1,
+		.elem_size	= sizeof(enum usb_qmi_audio_stream_status_enum_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					status),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					internal_status_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					internal_status),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					slot_id_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					slot_id),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_token_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_token),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_opr_intf_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_interface_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_opr_intf_desc),
+		.ei_array	= usb_interface_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x15,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_data_ep_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_endpoint_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x15,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_data_ep_desc),
+		.ei_array	= usb_endpoint_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x16,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_sync_ep_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_endpoint_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x16,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					std_as_sync_ep_desc),
+		.ei_array	= usb_endpoint_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_audio_spec_revision_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_2_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u16),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_audio_spec_revision),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x18,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					data_path_delay_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x18,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					data_path_delay),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x19,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_audio_subslot_size_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x19,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					usb_audio_subslot_size),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1A,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					xhci_mem_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct apps_mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1A,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					xhci_mem_info),
+		.ei_array	= apps_mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1B,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					interrupter_num_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1B,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					interrupter_num),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1C,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					speed_info_valid),
+	},
+	{
+		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
+		.elem_len	= 1,
+		.elem_size	= sizeof(enum usb_qmi_audio_device_speed_enum_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1C,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					speed_info),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1D,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					controller_num_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x1D,
+		.offset		= offsetof(
+					struct qmi_uaudio_stream_resp_msg_v01,
+					controller_num),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info qmi_uaudio_stream_ind_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
+		.elem_len	= 1,
+		.elem_size	= sizeof(
+				enum usb_qmi_audio_device_indication_enum_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x01,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						dev_event),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						slot_id),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_token_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_token),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_opr_intf_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_interface_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_opr_intf_desc),
+		.ei_array	= usb_interface_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_data_ep_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_endpoint_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_data_ep_desc),
+		.ei_array	= usb_endpoint_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_sync_ep_desc_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct usb_endpoint_descriptor_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						std_as_sync_ep_desc),
+		.ei_array	= usb_endpoint_descriptor_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_audio_spec_revision_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_2_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u16),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x14,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_audio_spec_revision),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x15,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						data_path_delay_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x15,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						data_path_delay),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x16,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_audio_subslot_size_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x16,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						usb_audio_subslot_size),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						xhci_mem_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct apps_mem_info_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						xhci_mem_info),
+		.ei_array	= apps_mem_info_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x18,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						interrupter_num_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x18,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						interrupter_num),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x19,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						controller_num_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x19,
+		.offset		= offsetof(struct qmi_uaudio_stream_ind_msg_v01,
+						controller_num),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
diff --git a/sound/usb/qcom/usb_audio_qmi_v01.h b/sound/usb/qcom/usb_audio_qmi_v01.h
new file mode 100644
index 000000000000..68e3842affc5
--- /dev/null
+++ b/sound/usb/qcom/usb_audio_qmi_v01.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef USB_QMI_V01_H
+#define USB_QMI_V01_H
+
+#define UAUDIO_STREAM_SERVICE_ID_V01 0x41D
+#define UAUDIO_STREAM_SERVICE_VERS_V01 0x01
+
+#define QMI_UAUDIO_STREAM_RESP_V01 0x0001
+#define QMI_UAUDIO_STREAM_REQ_V01 0x0001
+#define QMI_UAUDIO_STREAM_IND_V01 0x0001
+
+
+struct mem_info_v01 {
+	u64 va;
+	u64 pa;
+	u32 size;
+};
+
+struct apps_mem_info_v01 {
+	struct mem_info_v01 evt_ring;
+	struct mem_info_v01 tr_data;
+	struct mem_info_v01 tr_sync;
+	struct mem_info_v01 xfer_buff;
+	struct mem_info_v01 dcba;
+};
+
+struct usb_endpoint_descriptor_v01 {
+	u8 bLength;
+	u8 bDescriptorType;
+	u8 bEndpointAddress;
+	u8 bmAttributes;
+	u16 wMaxPacketSize;
+	u8 bInterval;
+	u8 bRefresh;
+	u8 bSynchAddress;
+};
+
+struct usb_interface_descriptor_v01 {
+	u8 bLength;
+	u8 bDescriptorType;
+	u8 bInterfaceNumber;
+	u8 bAlternateSetting;
+	u8 bNumEndpoints;
+	u8 bInterfaceClass;
+	u8 bInterfaceSubClass;
+	u8 bInterfaceProtocol;
+	u8 iInterface;
+};
+
+enum usb_qmi_audio_stream_status_enum_v01 {
+	USB_QMI_STREAM_STATUS_ENUM_MIN_VAL_V01 = INT_MIN,
+	USB_QMI_STREAM_REQ_SUCCESS_V01 = 0,
+	USB_QMI_STREAM_REQ_FAILURE_V01 = 1,
+	USB_QMI_STREAM_REQ_FAILURE_NOT_FOUND_V01 = 2,
+	USB_QMI_STREAM_REQ_FAILURE_INVALID_PARAM_V01 = 3,
+	USB_QMI_STREAM_REQ_FAILURE_MEMALLOC_V01 = 4,
+	USB_QMI_STREAM_STATUS_ENUM_MAX_VAL_V01 = INT_MAX,
+};
+
+enum usb_qmi_audio_device_indication_enum_v01 {
+	USB_QMI_DEVICE_INDICATION_ENUM_MIN_VAL_V01 = INT_MIN,
+	USB_QMI_DEV_CONNECT_V01 = 0,
+	USB_QMI_DEV_DISCONNECT_V01 = 1,
+	USB_QMI_DEV_SUSPEND_V01 = 2,
+	USB_QMI_DEV_RESUME_V01 = 3,
+	USB_QMI_DEVICE_INDICATION_ENUM_MAX_VAL_V01 = INT_MAX,
+};
+
+enum usb_qmi_audio_device_speed_enum_v01 {
+	USB_QMI_DEVICE_SPEED_ENUM_MIN_VAL_V01 = INT_MIN,
+	USB_QMI_DEVICE_SPEED_INVALID_V01 = 0,
+	USB_QMI_DEVICE_SPEED_LOW_V01 = 1,
+	USB_QMI_DEVICE_SPEED_FULL_V01 = 2,
+	USB_QMI_DEVICE_SPEED_HIGH_V01 = 3,
+	USB_QMI_DEVICE_SPEED_SUPER_V01 = 4,
+	USB_QMI_DEVICE_SPEED_SUPER_PLUS_V01 = 5,
+	USB_QMI_DEVICE_SPEED_ENUM_MAX_VAL_V01 = INT_MAX,
+};
+
+struct qmi_uaudio_stream_req_msg_v01 {
+	u8 enable;
+	u32 usb_token;
+	u8 audio_format_valid;
+	u32 audio_format;
+	u8 number_of_ch_valid;
+	u32 number_of_ch;
+	u8 bit_rate_valid;
+	u32 bit_rate;
+	u8 xfer_buff_size_valid;
+	u32 xfer_buff_size;
+	u8 service_interval_valid;
+	u32 service_interval;
+};
+#define QMI_UAUDIO_STREAM_REQ_MSG_V01_MAX_MSG_LEN 46
+extern struct qmi_elem_info qmi_uaudio_stream_req_msg_v01_ei[];
+
+struct qmi_uaudio_stream_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+	u8 status_valid;
+	enum usb_qmi_audio_stream_status_enum_v01 status;
+	u8 internal_status_valid;
+	u32 internal_status;
+	u8 slot_id_valid;
+	u32 slot_id;
+	u8 usb_token_valid;
+	u32 usb_token;
+	u8 std_as_opr_intf_desc_valid;
+	struct usb_interface_descriptor_v01 std_as_opr_intf_desc;
+	u8 std_as_data_ep_desc_valid;
+	struct usb_endpoint_descriptor_v01 std_as_data_ep_desc;
+	u8 std_as_sync_ep_desc_valid;
+	struct usb_endpoint_descriptor_v01 std_as_sync_ep_desc;
+	u8 usb_audio_spec_revision_valid;
+	u16 usb_audio_spec_revision;
+	u8 data_path_delay_valid;
+	u8 data_path_delay;
+	u8 usb_audio_subslot_size_valid;
+	u8 usb_audio_subslot_size;
+	u8 xhci_mem_info_valid;
+	struct apps_mem_info_v01 xhci_mem_info;
+	u8 interrupter_num_valid;
+	u8 interrupter_num;
+	u8 speed_info_valid;
+	enum usb_qmi_audio_device_speed_enum_v01 speed_info;
+	u8 controller_num_valid;
+	u8 controller_num;
+};
+#define QMI_UAUDIO_STREAM_RESP_MSG_V01_MAX_MSG_LEN 202
+extern struct qmi_elem_info qmi_uaudio_stream_resp_msg_v01_ei[];
+
+struct qmi_uaudio_stream_ind_msg_v01 {
+	enum usb_qmi_audio_device_indication_enum_v01 dev_event;
+	u32 slot_id;
+	u8 usb_token_valid;
+	u32 usb_token;
+	u8 std_as_opr_intf_desc_valid;
+	struct usb_interface_descriptor_v01 std_as_opr_intf_desc;
+	u8 std_as_data_ep_desc_valid;
+	struct usb_endpoint_descriptor_v01 std_as_data_ep_desc;
+	u8 std_as_sync_ep_desc_valid;
+	struct usb_endpoint_descriptor_v01 std_as_sync_ep_desc;
+	u8 usb_audio_spec_revision_valid;
+	u16 usb_audio_spec_revision;
+	u8 data_path_delay_valid;
+	u8 data_path_delay;
+	u8 usb_audio_subslot_size_valid;
+	u8 usb_audio_subslot_size;
+	u8 xhci_mem_info_valid;
+	struct apps_mem_info_v01 xhci_mem_info;
+	u8 interrupter_num_valid;
+	u8 interrupter_num;
+	u8 controller_num_valid;
+	u8 controller_num;
+};
+#define QMI_UAUDIO_STREAM_IND_MSG_V01_MAX_MSG_LEN 181
+extern struct qmi_elem_info qmi_uaudio_stream_ind_msg_v01_ei[];
+
+#endif
