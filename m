Return-Path: <linux-kernel+bounces-151653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C37D58AB19F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23831B225C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08BB131BD5;
	Fri, 19 Apr 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcqrhD6B"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BD6130A44
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539891; cv=none; b=mO+knWxCi9Nk/ZFDH4Cr/VItrNuJ9952YiodkU3j/mP+agoqUfT98MUonxs4xiGBN15y5/2UhNbgI/eCNOZaVrGdkNSXN0WcV+cz1Iep9Qm0J3fdDixOu2gPKFhPIMKC0v5eaahzHiWewSPE0t05nm41TtUu522JbPvLy4JXpH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539891; c=relaxed/simple;
	bh=oB096HyNcXkj+8OW4Cvuw9utWZDB5OfhuhFopOEo+XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=neTWPzQaNL1A4XN+49Qp4DT7Ydd5sIK0D2dm6EtaivQV591RFpz49+cvIqJSnQhQd589Y+83AQZL9Y1jYCmWtAGIw55TJA9FhYTQoi7jxkt6S4+2cW3V5Kyav81CPLRJ5moJ+vwm5Sw+rFNhcDIeH36Y+vtT2k7L9xOfHVtDb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vcqrhD6B; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7da42137c64so54018539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713539888; x=1714144688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW+xodU0leEhVx50ESvAxH61dvrN0r6GXKBXbX3qcpk=;
        b=vcqrhD6BA9b8Mo1yqcCoBriSKlStkiODJW9Yv7YU5iOrVfSzs2+UgA8DAha7gNCTPG
         9JQJIsnIZ4bDXO8tIfiZiR7hn6ZSFDgYAqxMzmli6KLgacE2kmysiPsmKxfMrWJTWZQz
         0wWJViVjNclzFLS1DFEnwt0gHeZn3Vx0fXsGjfdpfCkSw+876bNI2XYZhgeGykFzv5ZM
         JV4vxpwQmbT2FQagAB2U0aDlEUm26ueB7vJXO4+suXwRP54OKUgd+mujj6/kLnmSJ01H
         hLx+1I7N7+w1+cRHDAeJMg676wgPCL+MqY1wW2VUjx1juskIVfrHx6pymiB422s8MwhB
         WMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539888; x=1714144688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW+xodU0leEhVx50ESvAxH61dvrN0r6GXKBXbX3qcpk=;
        b=Ln6QhDnK9YimfKwRHR/whnlR0V73cQ7UkA/EO4QNAXPOOjWWDOEmSUpmF/au9YCFtn
         Q/397ZE84XRIRmBKiG8uA/tUCoNXHRYR7D5nOwRO12isLHwJknyztx7SHQL/RLFF5hrj
         XbMlzaPdZC8qiESBMmFROLr52EGVW/GBcub1vmeXvPpasmD20yIlRe0d19les4OH+Oag
         CG1UGFYQW9ZLPNGPbI1ov0ujjtcrBlfmfri5bamoV2su5Vk6WT7vpGWMg7XDFPhkIb01
         4NIvk3GBkJV4EvoqEqy3xWPOeLjpHiTrN0wWjgw8ScCiOELUK8vLnOP2HYATDkVvKjFx
         E4Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWdecJCcbAjvrjnagDe99TGI8ArFtG9446Z42nFKRtmL0ze33Ue+JZ24HpEUKvUM4GAO25UZUlsJXIzS6s5PMjcIJc0rkzi4ez1qNH7
X-Gm-Message-State: AOJu0YwyISZWKIDBg763Ix4/ac9+F2vvpns9lVpKjPrxxnUmxlTINRD4
	1gjgGQ8wsnDVF+FpUmmOyy9fjnnWV1mPTseaEqCgYh8M5b1kppndY+jLIzxOfmc=
X-Google-Smtp-Source: AGHT+IG+dQS0s8hDk+7SovzXn0ZCvGbkZQQZ2v0B2TFNw4W36id+MfFXUHuGZlHqxwI/1RglHK6trw==
X-Received: by 2002:a5d:8995:0:b0:7d0:d84d:9e13 with SMTP id m21-20020a5d8995000000b007d0d84d9e13mr2743043iol.19.1713539888393;
        Fri, 19 Apr 2024 08:18:08 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id lc8-20020a056638958800b00484e9c7014bsm116126jab.153.2024.04.19.08.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:18:08 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/8] net: ipa: remove unneeded FILT_ROUT_HASH_EN definitions
Date: Fri, 19 Apr 2024 10:17:56 -0500
Message-Id: <20240419151800.2168903-5-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419151800.2168903-1-elder@linaro.org>
References: <20240419151800.2168903-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FILT_ROUT_HASH_EN register is only used for IPA v4.2.  There,
routing and filter table hashing are not supported, and so the
register must be written to disable the feature.  No other version
uses this register, so its definition can be removed.  If we need to
use these some day (for example, explicitly enable the feature) this
commit can be reverted.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/reg/ipa_reg-v3.1.c   | 14 --------------
 drivers/net/ipa/reg/ipa_reg-v3.5.1.c | 14 --------------
 drivers/net/ipa/reg/ipa_reg-v4.11.c  | 14 --------------
 drivers/net/ipa/reg/ipa_reg-v4.5.c   | 14 --------------
 drivers/net/ipa/reg/ipa_reg-v4.7.c   | 14 --------------
 drivers/net/ipa/reg/ipa_reg-v4.9.c   | 14 --------------
 6 files changed, 84 deletions(-)

diff --git a/drivers/net/ipa/reg/ipa_reg-v3.1.c b/drivers/net/ipa/reg/ipa_reg-v3.1.c
index 63a44dce88353..a891037015836 100644
--- a/drivers/net/ipa/reg/ipa_reg-v3.1.c
+++ b/drivers/net/ipa/reg/ipa_reg-v3.1.c
@@ -78,19 +78,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x000008c);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -405,7 +392,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[IPA_BCR]			= &reg_ipa_bcr,
diff --git a/drivers/net/ipa/reg/ipa_reg-v3.5.1.c b/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
index 4a7b6d92207de..c81c48ec51f90 100644
--- a/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
+++ b/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
@@ -83,19 +83,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x000008c);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -416,7 +403,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[IPA_BCR]			= &reg_ipa_bcr,
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.11.c b/drivers/net/ipa/reg/ipa_reg-v4.11.c
index 257eaff9436e5..18bddc32c9318 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.11.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.11.c
@@ -115,19 +115,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x0000148);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -472,7 +459,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[LOCAL_PKT_PROC_CNTXT]		= &reg_local_pkt_proc_cntxt,
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.5.c b/drivers/net/ipa/reg/ipa_reg-v4.5.c
index dc396344d868a..8494731efdd3b 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.5.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.5.c
@@ -109,19 +109,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x0000148);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -491,7 +478,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[LOCAL_PKT_PROC_CNTXT]		= &reg_local_pkt_proc_cntxt,
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.7.c b/drivers/net/ipa/reg/ipa_reg-v4.7.c
index 37a2e466e4755..2c161cf691935 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.7.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.7.c
@@ -109,19 +109,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x0000148);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -464,7 +451,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[LOCAL_PKT_PROC_CNTXT]		= &reg_local_pkt_proc_cntxt,
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.9.c b/drivers/net/ipa/reg/ipa_reg-v4.9.c
index 09755d700784e..fa6fd312e4867 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.9.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.9.c
@@ -114,19 +114,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x0000148);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -469,7 +456,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[LOCAL_PKT_PROC_CNTXT]		= &reg_local_pkt_proc_cntxt,
-- 
2.40.1


