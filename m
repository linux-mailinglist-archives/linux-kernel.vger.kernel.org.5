Return-Path: <linux-kernel+bounces-12836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C55681FAB8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE51C215F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DA411CAF;
	Thu, 28 Dec 2023 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bCEzFUWX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B561172D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d98ce84e18so4441847b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 11:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703791489; x=1704396289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URCKkJoKCMfAOcVEbLjYyjFNVVuofUdDlVicUTKD0p4=;
        b=bCEzFUWXXXWNnYdZJ488zu3Y9EDVvFRbQYqBVJs5Y7SRCEcZv2rVn6MMGfN0aZTl/Z
         dUsd23+vszlHxK6mWFQKpJ+tZbPBU9xqi+LkrfWkbpbcTuzphxadzqD7RyNbWJObNy8X
         wYyxCM4EOewcD/U8UKINpFYiKHsojxaVucoAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703791489; x=1704396289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URCKkJoKCMfAOcVEbLjYyjFNVVuofUdDlVicUTKD0p4=;
        b=EyIk7dzYc4NuHKA1Df4onw//lN+U4lgF8EljDQkI2XMT7i6nl4vYwDXDSkIw7epGUI
         QpQ84Yz/2gnUPpM3WjMeLrK4MVmw/fquTv3xeiGWraDGPfhkTGMSsuznGbVpKafwca5F
         LBsF018mn+dFj2oy1KEXkzAPRhl9OK0sBKODvvFQ9Z+4K4J+/9uBDZhsasRlXfRAoZYZ
         77vCGZZw8QaGQEu4gs7FIWgCIjEL01LyQ5p/39iXWMpyuAyupglrk8FtHArM54plAHbW
         H0KERZ/ogVbZK2rgscGIIdWtq8B8z0Df8mgm2o4PF6rq7B6cOwYTk9EUD3X+jyE1Tw+B
         Ao4w==
X-Gm-Message-State: AOJu0YwenfOz0Vr8UraQW10tjeREmgdoYnMrLlRhjZ70DWVNpoyW219r
	cgDYB9tupnsEvRUbEr6X2nuIIZVOoEMLa/3XYfxE7BE4fpT7/a9Vlje6M2vwPRjlPOTLO0FbtPR
	7C5/eefZtqJrmWY2n2ICyaV8Kl6+BTR1oLqr9kRTCApgr7hs/HzVt1Hw1z3kAY63HQ+TAO8BMDX
	3eIZa/Pjn23+a4uuZTtsSZQ+I=
X-Google-Smtp-Source: AGHT+IEpgVP5cIdwObb1883lycGc8Y414AyfzSipxSEgOBbLARNoyiFn8uUdYvl2dVNQiomEOKrmrQ==
X-Received: by 2002:a05:6a21:1f20:b0:186:ff2d:f964 with SMTP id ry32-20020a056a211f2000b00186ff2df964mr9941895pzb.36.1703791489163;
        Thu, 28 Dec 2023 11:24:49 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id k16-20020aa79990000000b006d9aa04574csm9522987pfh.52.2023.12.28.11.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 11:24:48 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v4 5/6] drm/vmwgfx: Use VMware hypercall API
Date: Thu, 28 Dec 2023 11:24:20 -0800
Message-Id: <20231228192421.29894-6-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231228192421.29894-1-alexey.makhalov@broadcom.com>
References: <20231228192421.29894-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Makhalov <amakhalov@vmware.com>

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code.

drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h: implement arm64 variant
of vmware_hypercall. And keep it here until introduction of ARM64
VMWare hypervisor interface.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Zack Rusin <zackr@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 +++++++------------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 197 +++++++++++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 --------------------
 3 files changed, 197 insertions(+), 358 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 2651fe0ef518..1f15990d3934 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -48,8 +48,6 @@
 
 #define RETRIES                 3
 
-#define VMW_HYPERVISOR_MAGIC    0x564D5868
-
 #define VMW_PORT_CMD_MSG        30
 #define VMW_PORT_CMD_HB_MSG     0
 #define VMW_PORT_CMD_OPEN_CHANNEL  (MSG_TYPE_OPEN << 16 | VMW_PORT_CMD_MSG)
@@ -104,20 +102,18 @@ static const char* const mksstat_kern_name_desc[MKSSTAT_KERN_COUNT][2] =
  */
 static int vmw_open_channel(struct rpc_channel *channel, unsigned int protocol)
 {
-	unsigned long eax, ebx, ecx, edx, si = 0, di = 0;
+	u32 ecx, edx, esi, edi;
 
-	VMW_PORT(VMW_PORT_CMD_OPEN_CHANNEL,
-		(protocol | GUESTMSG_FLAG_COOKIE), si, di,
-		0,
-		VMW_HYPERVISOR_MAGIC,
-		eax, ebx, ecx, edx, si, di);
+	vmware_hypercall6(VMW_PORT_CMD_OPEN_CHANNEL,
+			  (protocol | GUESTMSG_FLAG_COOKIE), 0,
+			  &ecx, &edx, &esi, &edi);
 
 	if ((HIGH_WORD(ecx) & MESSAGE_STATUS_SUCCESS) == 0)
 		return -EINVAL;
 
 	channel->channel_id  = HIGH_WORD(edx);
-	channel->cookie_high = si;
-	channel->cookie_low  = di;
+	channel->cookie_high = esi;
+	channel->cookie_low  = edi;
 
 	return 0;
 }
@@ -133,17 +129,13 @@ static int vmw_open_channel(struct rpc_channel *channel, unsigned int protocol)
  */
 static int vmw_close_channel(struct rpc_channel *channel)
 {
-	unsigned long eax, ebx, ecx, edx, si, di;
-
-	/* Set up additional parameters */
-	si  = channel->cookie_high;
-	di  = channel->cookie_low;
+	u32 ecx;
 
-	VMW_PORT(VMW_PORT_CMD_CLOSE_CHANNEL,
-		0, si, di,
-		channel->channel_id << 16,
-		VMW_HYPERVISOR_MAGIC,
-		eax, ebx, ecx, edx, si, di);
+	vmware_hypercall5(VMW_PORT_CMD_CLOSE_CHANNEL,
+			  0, channel->channel_id << 16,
+			  channel->cookie_high,
+			  channel->cookie_low,
+			  &ecx);
 
 	if ((HIGH_WORD(ecx) & MESSAGE_STATUS_SUCCESS) == 0)
 		return -EINVAL;
@@ -163,24 +155,18 @@ static int vmw_close_channel(struct rpc_channel *channel)
 static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 				     const char *msg, bool hb)
 {
-	unsigned long si, di, eax, ebx, ecx, edx;
+	u32 ebx, ecx;
 	unsigned long msg_len = strlen(msg);
 
 	/* HB port can't access encrypted memory. */
 	if (hb && !cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
-		unsigned long bp = channel->cookie_high;
-		u32 channel_id = (channel->channel_id << 16);
-
-		si = (uintptr_t) msg;
-		di = channel->cookie_low;
-
-		VMW_PORT_HB_OUT(
+		vmware_hypercall_hb_out(
 			(MESSAGE_STATUS_SUCCESS << 16) | VMW_PORT_CMD_HB_MSG,
-			msg_len, si, di,
-			VMWARE_HYPERVISOR_HB | channel_id |
-			VMWARE_HYPERVISOR_OUT,
-			VMW_HYPERVISOR_MAGIC, bp,
-			eax, ebx, ecx, edx, si, di);
+			msg_len,
+			channel->channel_id << 16,
+			(uintptr_t) msg, channel->cookie_low,
+			channel->cookie_high,
+			&ebx);
 
 		return ebx;
 	}
@@ -194,14 +180,13 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 		memcpy(&word, msg, bytes);
 		msg_len -= bytes;
 		msg += bytes;
-		si = channel->cookie_high;
-		di = channel->cookie_low;
-
-		VMW_PORT(VMW_PORT_CMD_MSG | (MSG_TYPE_SENDPAYLOAD << 16),
-			 word, si, di,
-			 channel->channel_id << 16,
-			 VMW_HYPERVISOR_MAGIC,
-			 eax, ebx, ecx, edx, si, di);
+
+		vmware_hypercall5(VMW_PORT_CMD_MSG |
+				  (MSG_TYPE_SENDPAYLOAD << 16),
+				  word, channel->channel_id << 16,
+				  channel->cookie_high,
+				  channel->cookie_low,
+				  &ecx);
 	}
 
 	return ecx;
@@ -220,22 +205,17 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
 				    unsigned long reply_len, bool hb)
 {
-	unsigned long si, di, eax, ebx, ecx, edx;
+	u32 ebx, ecx, edx;
 
 	/* HB port can't access encrypted memory */
 	if (hb && !cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
-		unsigned long bp = channel->cookie_low;
-		u32 channel_id = (channel->channel_id << 16);
-
-		si = channel->cookie_high;
-		di = (uintptr_t) reply;
-
-		VMW_PORT_HB_IN(
+		vmware_hypercall_hb_in(
 			(MESSAGE_STATUS_SUCCESS << 16) | VMW_PORT_CMD_HB_MSG,
-			reply_len, si, di,
-			VMWARE_HYPERVISOR_HB | channel_id,
-			VMW_HYPERVISOR_MAGIC, bp,
-			eax, ebx, ecx, edx, si, di);
+			reply_len,
+			channel->channel_id << 16,
+			channel->cookie_high,
+			(uintptr_t) reply, channel->cookie_low,
+			&ebx);
 
 		return ebx;
 	}
@@ -245,14 +225,13 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
 	while (reply_len) {
 		unsigned int bytes = min_t(unsigned long, reply_len, 4);
 
-		si = channel->cookie_high;
-		di = channel->cookie_low;
-
-		VMW_PORT(VMW_PORT_CMD_MSG | (MSG_TYPE_RECVPAYLOAD << 16),
-			 MESSAGE_STATUS_SUCCESS, si, di,
-			 channel->channel_id << 16,
-			 VMW_HYPERVISOR_MAGIC,
-			 eax, ebx, ecx, edx, si, di);
+		vmware_hypercall7(VMW_PORT_CMD_MSG |
+				  (MSG_TYPE_RECVPAYLOAD << 16),
+				  MESSAGE_STATUS_SUCCESS,
+				  channel->channel_id << 16,
+				  channel->cookie_high,
+				  channel->cookie_low,
+				  &ebx, &ecx, &edx);
 
 		if ((HIGH_WORD(ecx) & MESSAGE_STATUS_SUCCESS) == 0)
 			break;
@@ -276,22 +255,18 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
  */
 static int vmw_send_msg(struct rpc_channel *channel, const char *msg)
 {
-	unsigned long eax, ebx, ecx, edx, si, di;
+	u32 ebx, ecx;
 	size_t msg_len = strlen(msg);
 	int retries = 0;
 
 	while (retries < RETRIES) {
 		retries++;
 
-		/* Set up additional parameters */
-		si  = channel->cookie_high;
-		di  = channel->cookie_low;
-
-		VMW_PORT(VMW_PORT_CMD_SENDSIZE,
-			msg_len, si, di,
-			channel->channel_id << 16,
-			VMW_HYPERVISOR_MAGIC,
-			eax, ebx, ecx, edx, si, di);
+		vmware_hypercall5(VMW_PORT_CMD_SENDSIZE,
+				  msg_len, channel->channel_id << 16,
+				  channel->cookie_high,
+				  channel->cookie_low,
+				  &ecx);
 
 		if ((HIGH_WORD(ecx) & MESSAGE_STATUS_SUCCESS) == 0) {
 			/* Expected success. Give up. */
@@ -329,7 +304,7 @@ STACK_FRAME_NON_STANDARD(vmw_send_msg);
 static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 			size_t *msg_len)
 {
-	unsigned long eax, ebx, ecx, edx, si, di;
+	u32 ebx, ecx, edx;
 	char *reply;
 	size_t reply_len;
 	int retries = 0;
@@ -341,15 +316,11 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 	while (retries < RETRIES) {
 		retries++;
 
-		/* Set up additional parameters */
-		si  = channel->cookie_high;
-		di  = channel->cookie_low;
-
-		VMW_PORT(VMW_PORT_CMD_RECVSIZE,
-			0, si, di,
-			channel->channel_id << 16,
-			VMW_HYPERVISOR_MAGIC,
-			eax, ebx, ecx, edx, si, di);
+		vmware_hypercall7(VMW_PORT_CMD_RECVSIZE,
+				  0, channel->channel_id << 16,
+				  channel->cookie_high,
+				  channel->cookie_low,
+				  &ebx, &ecx, &edx);
 
 		if ((HIGH_WORD(ecx) & MESSAGE_STATUS_SUCCESS) == 0) {
 			DRM_ERROR("Failed to get reply size for host message.\n");
@@ -384,16 +355,12 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 
 		reply[reply_len] = '\0';
 
-
-		/* Ack buffer */
-		si  = channel->cookie_high;
-		di  = channel->cookie_low;
-
-		VMW_PORT(VMW_PORT_CMD_RECVSTATUS,
-			MESSAGE_STATUS_SUCCESS, si, di,
-			channel->channel_id << 16,
-			VMW_HYPERVISOR_MAGIC,
-			eax, ebx, ecx, edx, si, di);
+		vmware_hypercall5(VMW_PORT_CMD_RECVSTATUS,
+				  MESSAGE_STATUS_SUCCESS,
+				  channel->channel_id << 16,
+				  channel->cookie_high,
+				  channel->cookie_low,
+				  &ecx);
 
 		if ((HIGH_WORD(ecx) & MESSAGE_STATUS_SUCCESS) == 0) {
 			kfree(reply);
@@ -652,13 +619,7 @@ static inline void reset_ppn_array(PPN64 *arr, size_t size)
  */
 static inline void hypervisor_ppn_reset_all(void)
 {
-	unsigned long eax, ebx, ecx, edx, si = 0, di = 0;
-
-	VMW_PORT(VMW_PORT_CMD_MKSGS_RESET,
-		0, si, di,
-		0,
-		VMW_HYPERVISOR_MAGIC,
-		eax, ebx, ecx, edx, si, di);
+	vmware_hypercall1(VMW_PORT_CMD_MKSGS_RESET, 0);
 }
 
 /**
@@ -669,13 +630,7 @@ static inline void hypervisor_ppn_reset_all(void)
  */
 static inline void hypervisor_ppn_add(PPN64 pfn)
 {
-	unsigned long eax, ebx, ecx, edx, si = 0, di = 0;
-
-	VMW_PORT(VMW_PORT_CMD_MKSGS_ADD_PPN,
-		(unsigned long)pfn, si, di,
-		0,
-		VMW_HYPERVISOR_MAGIC,
-		eax, ebx, ecx, edx, si, di);
+	vmware_hypercall1(VMW_PORT_CMD_MKSGS_ADD_PPN, (unsigned long)pfn);
 }
 
 /**
@@ -686,13 +641,7 @@ static inline void hypervisor_ppn_add(PPN64 pfn)
  */
 static inline void hypervisor_ppn_remove(PPN64 pfn)
 {
-	unsigned long eax, ebx, ecx, edx, si = 0, di = 0;
-
-	VMW_PORT(VMW_PORT_CMD_MKSGS_REMOVE_PPN,
-		(unsigned long)pfn, si, di,
-		0,
-		VMW_HYPERVISOR_MAGIC,
-		eax, ebx, ecx, edx, si, di);
+	vmware_hypercall1(VMW_PORT_CMD_MKSGS_REMOVE_PPN, (unsigned long)pfn);
 }
 
 #if IS_ENABLED(CONFIG_DRM_VMWGFX_MKSSTATS)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h
index 4f40167ad61f..29bd0af83038 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h
@@ -34,6 +34,8 @@
 #define VMWARE_HYPERVISOR_HB  BIT(0)
 #define VMWARE_HYPERVISOR_OUT BIT(1)
 
+#define VMWARE_HYPERVISOR_MAGIC	0x564D5868
+
 #define X86_IO_MAGIC 0x86
 
 #define X86_IO_W7_SIZE_SHIFT 0
@@ -45,86 +47,159 @@
 #define X86_IO_W7_IMM_SHIFT  5
 #define X86_IO_W7_IMM_MASK  (0xff << X86_IO_W7_IMM_SHIFT)
 
-static inline void vmw_port(unsigned long cmd, unsigned long in_ebx,
-			    unsigned long in_si, unsigned long in_di,
-			    unsigned long flags, unsigned long magic,
-			    unsigned long *eax, unsigned long *ebx,
-			    unsigned long *ecx, unsigned long *edx,
-			    unsigned long *si, unsigned long *di)
+static inline
+unsigned long vmware_hypercall1(unsigned long cmd, unsigned long in1)
 {
-	register u64 x0 asm("x0") = magic;
-	register u64 x1 asm("x1") = in_ebx;
+	register u64 x0 asm("x0") = VMWARE_HYPERVISOR_MAGIC;
+	register u64 x1 asm("x1") = in1;
 	register u64 x2 asm("x2") = cmd;
-	register u64 x3 asm("x3") = flags | VMWARE_HYPERVISOR_PORT;
-	register u64 x4 asm("x4") = in_si;
-	register u64 x5 asm("x5") = in_di;
+	register u64 x3 asm("x3") = VMWARE_HYPERVISOR_PORT;
+	register u64 x7 asm("x7") = ((u64)X86_IO_MAGIC << 32) |
+				    X86_IO_W7_WITH |
+				    X86_IO_W7_DIR |
+				    (2 << X86_IO_W7_SIZE_SHIFT);
 
+	asm_inline volatile (
+		"mrs xzr, mdccsr_el0; "
+		: "+r" (x0)
+		: "r" (x1), "r" (x2), "r" (x3), "r" (x7)
+		: "memory");
+
+	return x0;
+}
+
+static inline
+unsigned long vmware_hypercall5(unsigned long cmd, unsigned long in1,
+				unsigned long in3, unsigned long in4,
+				unsigned long in5, uint32_t *out2)
+{
+	register u64 x0 asm("x0") = VMWARE_HYPERVISOR_MAGIC;
+	register u64 x1 asm("x1") = in1;
+	register u64 x2 asm("x2") = cmd;
+	register u64 x3 asm("x3") = in3 | VMWARE_HYPERVISOR_PORT;
+	register u64 x4 asm("x4") = in4;
+	register u64 x5 asm("x5") = in5;
 	register u64 x7 asm("x7") = ((u64)X86_IO_MAGIC << 32) |
 				    X86_IO_W7_WITH |
 				    X86_IO_W7_DIR |
 				    (2 << X86_IO_W7_SIZE_SHIFT);
 
-	asm volatile("mrs xzr, mdccsr_el0 \n\t"
-		     : "+r"(x0), "+r"(x1), "+r"(x2),
-		       "+r"(x3), "+r"(x4), "+r"(x5)
-		     : "r"(x7)
-		     :);
-	*eax = x0;
-	*ebx = x1;
-	*ecx = x2;
-	*edx = x3;
-	*si = x4;
-	*di = x5;
+	asm_inline volatile (
+		"mrs xzr, mdccsr_el0; "
+		: "+r" (x0), "+r" (x2)
+		: "r" (x1), "r" (x3), "r" (x4), "r" (x5), "r" (x7)
+		: "memory");
+
+	*out2 = x2;
+	return x0;
 }
 
-static inline void vmw_port_hb(unsigned long cmd, unsigned long in_ecx,
-			       unsigned long in_si, unsigned long in_di,
-			       unsigned long flags, unsigned long magic,
-			       unsigned long bp, u32 w7dir,
-			       unsigned long *eax, unsigned long *ebx,
-			       unsigned long *ecx, unsigned long *edx,
-			       unsigned long *si, unsigned long *di)
+static inline
+unsigned long vmware_hypercall6(unsigned long cmd, unsigned long in1,
+				unsigned long in3, uint32_t *out2,
+				uint32_t *out3, uint32_t *out4,
+				uint32_t *out5)
 {
-	register u64 x0 asm("x0") = magic;
+	register u64 x0 asm("x0") = VMWARE_HYPERVISOR_MAGIC;
+	register u64 x1 asm("x1") = in1;
+	register u64 x2 asm("x2") = cmd;
+	register u64 x3 asm("x3") = in3 | VMWARE_HYPERVISOR_PORT;
+	register u64 x4 asm("x4");
+	register u64 x5 asm("x5");
+	register u64 x7 asm("x7") = ((u64)X86_IO_MAGIC << 32) |
+				    X86_IO_W7_WITH |
+				    X86_IO_W7_DIR |
+				    (2 << X86_IO_W7_SIZE_SHIFT);
+
+	asm_inline volatile (
+		"mrs xzr, mdccsr_el0; "
+		: "+r" (x0), "+r" (x2), "+r" (x3), "=r" (x4), "=r" (x5)
+		: "r" (x1), "r" (x7)
+		: "memory");
+
+	*out2 = x2;
+	*out3 = x3;
+	*out4 = x4;
+	*out5 = x5;
+	return x0;
+}
+
+static inline
+unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
+				unsigned long in3, unsigned long in4,
+				unsigned long in5, uint32_t *out1,
+				uint32_t *out2, uint32_t *out3)
+{
+	register u64 x0 asm("x0") = VMWARE_HYPERVISOR_MAGIC;
+	register u64 x1 asm("x1") = in1;
+	register u64 x2 asm("x2") = cmd;
+	register u64 x3 asm("x3") = in3 | VMWARE_HYPERVISOR_PORT;
+	register u64 x4 asm("x4") = in4;
+	register u64 x5 asm("x5") = in5;
+	register u64 x7 asm("x7") = ((u64)X86_IO_MAGIC << 32) |
+				    X86_IO_W7_WITH |
+				    X86_IO_W7_DIR |
+				    (2 << X86_IO_W7_SIZE_SHIFT);
+
+	asm_inline volatile (
+		"mrs xzr, mdccsr_el0; "
+		: "+r" (x0), "+r" (x1), "+r" (x2), "+r" (x3)
+		: "r" (x4), "r" (x5), "r" (x7)
+		: "memory");
+
+	*out1 = x1;
+	*out2 = x2;
+	*out3 = x3;
+	return x0;
+}
+
+static inline
+unsigned long vmware_hypercall_hb(unsigned long cmd, unsigned long in2,
+				  unsigned long in3, unsigned long in4,
+				  unsigned long in5, unsigned long in6,
+				  uint32_t *out1, int dir)
+{
+	register u64 x0 asm("x0") = VMWARE_HYPERVISOR_MAGIC;
 	register u64 x1 asm("x1") = cmd;
-	register u64 x2 asm("x2") = in_ecx;
-	register u64 x3 asm("x3") = flags | VMWARE_HYPERVISOR_PORT_HB;
-	register u64 x4 asm("x4") = in_si;
-	register u64 x5 asm("x5") = in_di;
-	register u64 x6 asm("x6") = bp;
+	register u64 x2 asm("x2") = in2;
+	register u64 x3 asm("x3") = in3 | VMWARE_HYPERVISOR_PORT_HB;
+	register u64 x4 asm("x4") = in4;
+	register u64 x5 asm("x5") = in5;
+	register u64 x6 asm("x6") = in6;
 	register u64 x7 asm("x7") = ((u64)X86_IO_MAGIC << 32) |
 				    X86_IO_W7_STR |
 				    X86_IO_W7_WITH |
-				    w7dir;
-
-	asm volatile("mrs xzr, mdccsr_el0 \n\t"
-		     : "+r"(x0), "+r"(x1), "+r"(x2),
-		       "+r"(x3), "+r"(x4), "+r"(x5)
-		     : "r"(x6), "r"(x7)
-		     :);
-	*eax = x0;
-	*ebx = x1;
-	*ecx = x2;
-	*edx = x3;
-	*si  = x4;
-	*di  = x5;
-}
+				    dir;
 
-#define VMW_PORT(cmd, in_ebx, in_si, in_di, flags, magic, eax, ebx, ecx, edx,  \
-		 si, di)                                                       \
-	vmw_port(cmd, in_ebx, in_si, in_di, flags, magic, &eax, &ebx, &ecx,    \
-		 &edx, &si, &di)
+	asm_inline volatile (
+		"mrs xzr, mdccsr_el0; "
+		: "+r" (x0), "+r" (x1)
+		: "r" (x2), "r" (x3), "r" (x4), "r" (x5),
+		  "r" (x6), "r" (x7)
+		: "memory");
 
-#define VMW_PORT_HB_OUT(cmd, in_ecx, in_si, in_di, flags, magic, bp, eax, ebx, \
-		        ecx, edx, si, di)                                      \
-	vmw_port_hb(cmd, in_ecx, in_si, in_di, flags, magic, bp,               \
-                    0, &eax, &ebx, &ecx, &edx, &si, &di)
+	*out1 = x1;
+	return x0;
+}
 
-#define VMW_PORT_HB_IN(cmd, in_ecx, in_si, in_di, flags, magic, bp, eax, ebx,  \
-		       ecx, edx, si, di)                                       \
-	vmw_port_hb(cmd, in_ecx, in_si, in_di, flags, magic, bp,               \
-		    X86_IO_W7_DIR, &eax, &ebx, &ecx, &edx, &si, &di)
+static inline
+unsigned long vmware_hypercall_hb_out(unsigned long cmd, unsigned long in2,
+				      unsigned long in3, unsigned long in4,
+				      unsigned long in5, unsigned long in6,
+				      uint32_t *out1)
+{
+	return vmware_hypercall_hb(cmd, in2, in3, in4, in5, in6, out1, 0);
+}
 
+static inline
+unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
+				     unsigned long in3, unsigned long in4,
+				     unsigned long in5, unsigned long in6,
+				     uint32_t *out1)
+{
+	return vmware_hypercall_hb(cmd, in2, in3, in4, in5, in6,  out1,
+				   X86_IO_W7_DIR);
+}
 #endif
 
 #endif /* _VMWGFX_MSG_ARM64_H */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
index 23899d743a90..13304d34cc6e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
@@ -37,191 +37,6 @@
 
 #include <asm/vmware.h>
 
-/**
- * Hypervisor-specific bi-directional communication channel.  Should never
- * execute on bare metal hardware.  The caller must make sure to check for
- * supported hypervisor before using these macros.
- *
- * The last two parameters are both input and output and must be initialized.
- *
- * @cmd: [IN] Message Cmd
- * @in_ebx: [IN] Message Len, through EBX
- * @in_si: [IN] Input argument through SI, set to 0 if not used
- * @in_di: [IN] Input argument through DI, set ot 0 if not used
- * @flags: [IN] hypercall flags + [channel id]
- * @magic: [IN] hypervisor magic value
- * @eax: [OUT] value of EAX register
- * @ebx: [OUT] e.g. status from an HB message status command
- * @ecx: [OUT] e.g. status from a non-HB message status command
- * @edx: [OUT] e.g. channel id
- * @si:  [OUT]
- * @di:  [OUT]
- */
-#define VMW_PORT(cmd, in_ebx, in_si, in_di,	\
-                 flags, magic,		\
-                 eax, ebx, ecx, edx, si, di)	\
-({						\
-        asm volatile (VMWARE_HYPERCALL :	\
-                "=a"(eax),			\
-                "=b"(ebx),			\
-                "=c"(ecx),			\
-                "=d"(edx),			\
-                "=S"(si),			\
-                "=D"(di) :			\
-                "a"(magic),			\
-                "b"(in_ebx),			\
-                "c"(cmd),			\
-                "d"(flags),			\
-                "S"(in_si),			\
-                "D"(in_di) :			\
-                "memory");			\
-})
-
-
-/**
- * Hypervisor-specific bi-directional communication channel.  Should never
- * execute on bare metal hardware.  The caller must make sure to check for
- * supported hypervisor before using these macros.
- *
- * The last 3 parameters are both input and output and must be initialized.
- *
- * @cmd: [IN] Message Cmd
- * @in_ecx: [IN] Message Len, through ECX
- * @in_si: [IN] Input argument through SI, set to 0 if not used
- * @in_di: [IN] Input argument through DI, set to 0 if not used
- * @flags: [IN] hypercall flags + [channel id]
- * @magic: [IN] hypervisor magic value
- * @bp:  [IN]
- * @eax: [OUT] value of EAX register
- * @ebx: [OUT] e.g. status from an HB message status command
- * @ecx: [OUT] e.g. status from a non-HB message status command
- * @edx: [OUT] e.g. channel id
- * @si:  [OUT]
- * @di:  [OUT]
- */
-#ifdef __x86_64__
-
-#define VMW_PORT_HB_OUT(cmd, in_ecx, in_si, in_di,	\
-                        flags, magic, bp,		\
-                        eax, ebx, ecx, edx, si, di)	\
-({							\
-        asm volatile (					\
-		UNWIND_HINT_SAVE			\
-		"push %%rbp;"				\
-		UNWIND_HINT_UNDEFINED			\
-                "mov %12, %%rbp;"			\
-                VMWARE_HYPERCALL_HB_OUT			\
-                "pop %%rbp;"				\
-		UNWIND_HINT_RESTORE :			\
-                "=a"(eax),				\
-                "=b"(ebx),				\
-                "=c"(ecx),				\
-                "=d"(edx),				\
-                "=S"(si),				\
-                "=D"(di) :				\
-                "a"(magic),				\
-                "b"(cmd),				\
-                "c"(in_ecx),				\
-                "d"(flags),				\
-                "S"(in_si),				\
-                "D"(in_di),				\
-                "r"(bp) :				\
-                "memory", "cc");			\
-})
-
-
-#define VMW_PORT_HB_IN(cmd, in_ecx, in_si, in_di,	\
-                       flags, magic, bp,		\
-                       eax, ebx, ecx, edx, si, di)	\
-({							\
-        asm volatile (					\
-		UNWIND_HINT_SAVE			\
-		"push %%rbp;"				\
-		UNWIND_HINT_UNDEFINED			\
-                "mov %12, %%rbp;"			\
-                VMWARE_HYPERCALL_HB_IN			\
-                "pop %%rbp;"				\
-		UNWIND_HINT_RESTORE :			\
-                "=a"(eax),				\
-                "=b"(ebx),				\
-                "=c"(ecx),				\
-                "=d"(edx),				\
-                "=S"(si),				\
-                "=D"(di) :				\
-                "a"(magic),				\
-                "b"(cmd),				\
-                "c"(in_ecx),				\
-                "d"(flags),				\
-                "S"(in_si),				\
-                "D"(in_di),				\
-                "r"(bp) :				\
-                "memory", "cc");			\
-})
-
-#elif defined(__i386__)
-
-/*
- * In the 32-bit version of this macro, we store bp in a memory location
- * because we've ran out of registers.
- * Now we can't reference that memory location while we've modified
- * %esp or %ebp, so we first push it on the stack, just before we push
- * %ebp, and then when we need it we read it from the stack where we
- * just pushed it.
- */
-#define VMW_PORT_HB_OUT(cmd, in_ecx, in_si, in_di,	\
-                        flags, magic, bp,		\
-                        eax, ebx, ecx, edx, si, di)	\
-({							\
-        asm volatile ("push %12;"			\
-                "push %%ebp;"				\
-                "mov 0x04(%%esp), %%ebp;"		\
-                VMWARE_HYPERCALL_HB_OUT			\
-                "pop %%ebp;"				\
-                "add $0x04, %%esp;" :			\
-                "=a"(eax),				\
-                "=b"(ebx),				\
-                "=c"(ecx),				\
-                "=d"(edx),				\
-                "=S"(si),				\
-                "=D"(di) :				\
-                "a"(magic),				\
-                "b"(cmd),				\
-                "c"(in_ecx),				\
-                "d"(flags),				\
-                "S"(in_si),				\
-                "D"(in_di),				\
-                "m"(bp) :				\
-                "memory", "cc");			\
-})
-
-
-#define VMW_PORT_HB_IN(cmd, in_ecx, in_si, in_di,	\
-                       flags, magic, bp,		\
-                       eax, ebx, ecx, edx, si, di)	\
-({							\
-        asm volatile ("push %12;"			\
-                "push %%ebp;"				\
-                "mov 0x04(%%esp), %%ebp;"		\
-                VMWARE_HYPERCALL_HB_IN			\
-                "pop %%ebp;"				\
-                "add $0x04, %%esp;" :			\
-                "=a"(eax),				\
-                "=b"(ebx),				\
-                "=c"(ecx),				\
-                "=d"(edx),				\
-                "=S"(si),				\
-                "=D"(di) :				\
-                "a"(magic),				\
-                "b"(cmd),				\
-                "c"(in_ecx),				\
-                "d"(flags),				\
-                "S"(in_si),				\
-                "D"(in_di),				\
-                "m"(bp) :				\
-                "memory", "cc");			\
-})
-#endif /* defined(__i386__) */
-
 #endif /* defined(__i386__) || defined(__x86_64__) */
 
 #endif /* _VMWGFX_MSG_X86_H */
-- 
2.39.0


