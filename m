Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3119780C20
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376959AbjHRMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376990AbjHRMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:49:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AFC1988
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:48:59 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RS1qV39wGz1GDV1;
        Fri, 18 Aug 2023 20:47:34 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 20:48:57 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <yuehaibing@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ALSA: asihpi: Remove unused declarations
Date:   Fri, 18 Aug 2023 20:48:52 +0800
Message-ID: <20230818124852.51468-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are not implemented, so can remove them.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 sound/pci/asihpi/hpi.h          | 16 ----------------
 sound/pci/asihpi/hpi_internal.h |  5 -----
 2 files changed, 21 deletions(-)

diff --git a/sound/pci/asihpi/hpi.h b/sound/pci/asihpi/hpi.h
index 3aebec763fb8..04a5cf6572cd 100644
--- a/sound/pci/asihpi/hpi.h
+++ b/sound/pci/asihpi/hpi.h
@@ -1191,19 +1191,6 @@ u16 hpi_adapter_set_mode_ex(u16 adapter_index, u32 adapter_mode,
 
 u16 hpi_adapter_get_mode(u16 adapter_index, u32 *padapter_mode);
 
-u16 hpi_adapter_get_assert2(u16 adapter_index, u16 *p_assert_count,
-	char *psz_assert, u32 *p_param1, u32 *p_param2,
-	u32 *p_dsp_string_addr, u16 *p_processor_id);
-
-u16 hpi_adapter_test_assert(u16 adapter_index, u16 assert_id);
-
-u16 hpi_adapter_enable_capability(u16 adapter_index, u16 capability, u32 key);
-
-u16 hpi_adapter_self_test(u16 adapter_index);
-
-u16 hpi_adapter_debug_read(u16 adapter_index, u32 dsp_address, char *p_bytes,
-	int *count_bytes);
-
 u16 hpi_adapter_set_property(u16 adapter_index, u16 property, u16 paramter1,
 	u16 paramter2);
 
@@ -1488,9 +1475,6 @@ u16 hpi_pad_get_program_type(u32 h_control, u32 *ppTY);
 
 u16 hpi_pad_get_rdsPI(u32 h_control, u32 *ppI);
 
-u16 hpi_pad_get_program_type_string(u32 h_control, const u32 data_type,
-	const u32 pTY, char *psz_string, const u32 string_length);
-
 /****************************/
 /* AES/EBU Receiver control */
 /****************************/
diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index 6859d51389f5..e569e3b33b8e 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -1394,17 +1394,12 @@ u32 hpi_indexes_to_handle(const char c_object, const u16 adapter_index,
 void hpi_send_recv(struct hpi_message *phm, struct hpi_response *phr);
 
 /* used in PnP OS/driver */
-u16 hpi_subsys_create_adapter(const struct hpi_resource *p_resource,
-	u16 *pw_adapter_index);
-
 u16 hpi_outstream_host_buffer_get_info(u32 h_outstream, u8 **pp_buffer,
 	struct hpi_hostbuffer_status **pp_status);
 
 u16 hpi_instream_host_buffer_get_info(u32 h_instream, u8 **pp_buffer,
 	struct hpi_hostbuffer_status **pp_status);
 
-u16 hpi_adapter_restart(u16 adapter_index);
-
 /*
 The following 3 functions were last declared in header files for
 driver 3.10. HPI_ControlQuery() used to be the recommended way
-- 
2.34.1

