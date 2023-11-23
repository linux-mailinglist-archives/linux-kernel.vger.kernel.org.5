Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D637F6809
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 21:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjKWUEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 15:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWUEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 15:04:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71491D41;
        Thu, 23 Nov 2023 12:04:47 -0800 (PST)
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F02E36607395;
        Thu, 23 Nov 2023 20:04:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700769886;
        bh=T6+917J9Qs7knbMWHzedmplc/6vwAhEWd9+bjLgToGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbEdxNiNPnVQoGvLx6x2+aSJwvsPluajQd3pvSTnY4MXPY0JzbVzdlkX2yCj9NqHg
         G7aRzbAvFm2q3iuI5bG4z5JApriUa1s1zIXPEe7x8yvHdc12jxULE6I5UfGawdXTQb
         hWAA6bgtm3fNscQic/nBhB4+IWHP07lM2bOoVPjrMZj6l9myRfuYCyfbneoNOq8ym1
         kIJFnaUVunYuq/n+EdCo1zUm15bYaOJJ2oCS4BhwWr2scM80gYc4KVDdEDNI7SB+SW
         hO3MuMsjRtk9C86hu0LYvDfHUq2Yv2nUwsaAO1m8FcG/Y0aerbSgxFBsvlNtJpFgG3
         luhY43nxpF+Zw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 1/4] media: visl,vidtv: Set parameters permissions to 0444
Date:   Thu, 23 Nov 2023 14:57:44 -0500
Message-ID: <20231123200451.148097-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123200451.148097-1-detlev.casanova@collabora.com>
References: <20231123200451.148097-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids confusion with default values and lets userspace
programs get the modules parameters values at run time.

This can be useful when setting up a test suite.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../media/test-drivers/vidtv/vidtv_bridge.c   | 20 +++++++++----------
 drivers/media/test-drivers/visl/visl-core.c   | 10 +++++-----
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index 8b04e12af286..5dd7b1b4f7f1 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -45,21 +45,21 @@
 #define LNB_HIGH_FREQ		10600000	/* transition frequency */
 
 static unsigned int drop_tslock_prob_on_low_snr;
-module_param(drop_tslock_prob_on_low_snr, uint, 0);
+module_param(drop_tslock_prob_on_low_snr, uint, 0444);
 MODULE_PARM_DESC(drop_tslock_prob_on_low_snr,
 		 "Probability of losing the TS lock if the signal quality is bad");
 
 static unsigned int recover_tslock_prob_on_good_snr;
-module_param(recover_tslock_prob_on_good_snr, uint, 0);
+module_param(recover_tslock_prob_on_good_snr, uint, 0444);
 MODULE_PARM_DESC(recover_tslock_prob_on_good_snr,
 		 "Probability recovering the TS lock when the signal improves");
 
 static unsigned int mock_power_up_delay_msec;
-module_param(mock_power_up_delay_msec, uint, 0);
+module_param(mock_power_up_delay_msec, uint, 0444);
 MODULE_PARM_DESC(mock_power_up_delay_msec, "Simulate a power up delay");
 
 static unsigned int mock_tune_delay_msec;
-module_param(mock_tune_delay_msec, uint, 0);
+module_param(mock_tune_delay_msec, uint, 0444);
 MODULE_PARM_DESC(mock_tune_delay_msec, "Simulate a tune delay");
 
 static unsigned int vidtv_valid_dvb_t_freqs[NUM_VALID_TUNER_FREQS] = {
@@ -86,7 +86,7 @@ MODULE_PARM_DESC(vidtv_valid_dvb_s_freqs,
 		 "Valid DVB-S/S2 frequencies to simulate at Ku-Band, in kHz");
 
 static unsigned int max_frequency_shift_hz;
-module_param(max_frequency_shift_hz, uint, 0);
+module_param(max_frequency_shift_hz, uint, 0444);
 MODULE_PARM_DESC(max_frequency_shift_hz,
 		 "Maximum shift in HZ allowed when tuning in a channel");
 
@@ -96,24 +96,24 @@ DVB_DEFINE_MOD_OPT_ADAPTER_NR(adapter_nums);
  * Influences the signal acquisition time. See ISO/IEC 13818-1 : 2000. p. 113.
  */
 static unsigned int si_period_msec = 40;
-module_param(si_period_msec, uint, 0);
+module_param(si_period_msec, uint, 0444);
 MODULE_PARM_DESC(si_period_msec, "How often to send SI packets. Default: 40ms");
 
 static unsigned int pcr_period_msec = 40;
-module_param(pcr_period_msec, uint, 0);
+module_param(pcr_period_msec, uint, 0444);
 MODULE_PARM_DESC(pcr_period_msec,
 		 "How often to send PCR packets. Default: 40ms");
 
 static unsigned int mux_rate_kbytes_sec = 4096;
-module_param(mux_rate_kbytes_sec, uint, 0);
+module_param(mux_rate_kbytes_sec, uint, 0444);
 MODULE_PARM_DESC(mux_rate_kbytes_sec, "Mux rate: will pad stream if below");
 
 static unsigned int pcr_pid = 0x200;
-module_param(pcr_pid, uint, 0);
+module_param(pcr_pid, uint, 0444);
 MODULE_PARM_DESC(pcr_pid, "PCR PID for all channels: defaults to 0x200");
 
 static unsigned int mux_buf_sz_pkts;
-module_param(mux_buf_sz_pkts, uint, 0);
+module_param(mux_buf_sz_pkts, uint, 0444);
 MODULE_PARM_DESC(mux_buf_sz_pkts,
 		 "Size for the internal mux buffer in multiples of 188 bytes");
 
diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
index 9970dc739ca5..ef89eead6671 100644
--- a/drivers/media/test-drivers/visl/visl-core.c
+++ b/drivers/media/test-drivers/visl/visl-core.c
@@ -64,27 +64,27 @@ MODULE_PARM_DESC(visl_transtime_ms, " simulated process time in milliseconds.");
  * particular number of frames
  */
 int visl_dprintk_frame_start = -1;
-module_param(visl_dprintk_frame_start, int, 0);
+module_param(visl_dprintk_frame_start, int, 0444);
 MODULE_PARM_DESC(visl_dprintk_frame_start,
 		 " a frame number to start tracing with dprintk");
 
 unsigned int visl_dprintk_nframes;
-module_param(visl_dprintk_nframes, uint, 0);
+module_param(visl_dprintk_nframes, uint, 0444);
 MODULE_PARM_DESC(visl_dprintk_nframes,
 		 " the number of frames to trace with dprintk");
 
 bool keep_bitstream_buffers;
-module_param(keep_bitstream_buffers, bool, false);
+module_param(keep_bitstream_buffers, bool, 0444);
 MODULE_PARM_DESC(keep_bitstream_buffers,
 		 " keep bitstream buffers in debugfs after streaming is stopped");
 
 int bitstream_trace_frame_start = -1;
-module_param(bitstream_trace_frame_start, int, 0);
+module_param(bitstream_trace_frame_start, int, 0444);
 MODULE_PARM_DESC(bitstream_trace_frame_start,
 		 " a frame number to start dumping the bitstream through debugfs");
 
 unsigned int bitstream_trace_nframes;
-module_param(bitstream_trace_nframes, uint, 0);
+module_param(bitstream_trace_nframes, uint, 0444);
 MODULE_PARM_DESC(bitstream_trace_nframes,
 		 " the number of frames to dump the bitstream through debugfs");
 
-- 
2.41.0

