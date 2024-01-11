Return-Path: <linux-kernel+bounces-23172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E9F82A898
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6545028839F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0151DDB6;
	Thu, 11 Jan 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m2qMZ9WY"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACECFDDA6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=CtQllylb5rBy8xA4pm
	EMdjJuK4Xkx/RYOeVF0Un8bi0=; b=m2qMZ9WYQ8y6fIYNLa6VLyMFQzYCv7a1JA
	M5R28m+zOSwNChTRuDX4zFhOxLguxNytXtYDsquX5j2tDfCznoRYucaNjbiqudDj
	cR1zPgGMCxUGUz2lybSoBWfeEWrFBAKEkIEPIcCqxohEIOPWNCMwlGJnyyL8LCT3
	0GuXKLiIs=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDH9wPAn59lXj0QAA--.3875S2;
	Thu, 11 Jan 2024 15:58:56 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/radeon: Clean up errors in smu7_discrete.h
Date: Thu, 11 Jan 2024 07:58:54 +0000
Message-Id: <20240111075854.11116-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDH9wPAn59lXj0QAA--.3875S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw4fur17XrWfKr17Zr13urg_yoW7CryUpF
	WUKw4IgFZ5Ar13W345AwsYvr4agry5tr1UGr9ruw4Fqw42yrW2kF12ka1UCrWaqws3C393
	JFsxtF12grWxAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UwFxUUUUUU=
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEBRi1mVOBk7vVQABso
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/smu7_discrete.h | 51 +++++++++-----------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/radeon/smu7_discrete.h b/drivers/gpu/drm/radeon/smu7_discrete.h
index 0b0b404ff091..1f63cbbd6515 100644
--- a/drivers/gpu/drm/radeon/smu7_discrete.h
+++ b/drivers/gpu/drm/radeon/smu7_discrete.h
@@ -35,8 +35,7 @@
 #define SMU7_NUM_GPU_TES 1
 #define SMU7_NUM_NON_TES 2
 
-struct SMU7_SoftRegisters
-{
+struct SMU7_SoftRegisters {
     uint32_t        RefClockFrequency;
     uint32_t        PmTimerP;
     uint32_t        FeatureEnables;
@@ -89,8 +88,7 @@ struct SMU7_SoftRegisters
 
 typedef struct SMU7_SoftRegisters SMU7_SoftRegisters;
 
-struct SMU7_Discrete_VoltageLevel
-{
+struct SMU7_Discrete_VoltageLevel {
     uint16_t    Voltage;
     uint16_t    StdVoltageHiSidd;
     uint16_t    StdVoltageLoSidd;
@@ -100,8 +98,7 @@ struct SMU7_Discrete_VoltageLevel
 
 typedef struct SMU7_Discrete_VoltageLevel SMU7_Discrete_VoltageLevel;
 
-struct SMU7_Discrete_GraphicsLevel
-{
+struct SMU7_Discrete_GraphicsLevel {
     uint32_t    Flags;
     uint32_t    MinVddc;
     uint32_t    MinVddcPhases;
@@ -131,8 +128,7 @@ struct SMU7_Discrete_GraphicsLevel
 
 typedef struct SMU7_Discrete_GraphicsLevel SMU7_Discrete_GraphicsLevel;
 
-struct SMU7_Discrete_ACPILevel
-{
+struct SMU7_Discrete_ACPILevel {
     uint32_t    Flags;
     uint32_t    MinVddc;
     uint32_t    MinVddcPhases;
@@ -153,8 +149,7 @@ struct SMU7_Discrete_ACPILevel
 
 typedef struct SMU7_Discrete_ACPILevel SMU7_Discrete_ACPILevel;
 
-struct SMU7_Discrete_Ulv
-{
+struct SMU7_Discrete_Ulv {
     uint32_t    CcPwrDynRm;
     uint32_t    CcPwrDynRm1;
     uint16_t    VddcOffset;
@@ -165,8 +160,7 @@ struct SMU7_Discrete_Ulv
 
 typedef struct SMU7_Discrete_Ulv SMU7_Discrete_Ulv;
 
-struct SMU7_Discrete_MemoryLevel
-{
+struct SMU7_Discrete_MemoryLevel {
     uint32_t    MinVddc;
     uint32_t    MinVddcPhases;
     uint32_t    MinVddci;
@@ -206,8 +200,7 @@ struct SMU7_Discrete_MemoryLevel
 
 typedef struct SMU7_Discrete_MemoryLevel SMU7_Discrete_MemoryLevel;
 
-struct SMU7_Discrete_LinkLevel
-{
+struct SMU7_Discrete_LinkLevel {
     uint8_t     PcieGenSpeed;
     uint8_t     PcieLaneCount;
     uint8_t     EnabledForActivity;
@@ -220,8 +213,7 @@ struct SMU7_Discrete_LinkLevel
 typedef struct SMU7_Discrete_LinkLevel SMU7_Discrete_LinkLevel;
 
 
-struct SMU7_Discrete_MCArbDramTimingTableEntry
-{
+struct SMU7_Discrete_MCArbDramTimingTableEntry {
     uint32_t McArbDramTiming;
     uint32_t McArbDramTiming2;
     uint8_t  McArbBurstTime;
@@ -230,15 +222,13 @@ struct SMU7_Discrete_MCArbDramTimingTableEntry
 
 typedef struct SMU7_Discrete_MCArbDramTimingTableEntry SMU7_Discrete_MCArbDramTimingTableEntry;
 
-struct SMU7_Discrete_MCArbDramTimingTable
-{
+struct SMU7_Discrete_MCArbDramTimingTable {
     SMU7_Discrete_MCArbDramTimingTableEntry entries[SMU__NUM_SCLK_DPM_STATE][SMU__NUM_MCLK_DPM_LEVELS];
 };
 
 typedef struct SMU7_Discrete_MCArbDramTimingTable SMU7_Discrete_MCArbDramTimingTable;
 
-struct SMU7_Discrete_UvdLevel
-{
+struct SMU7_Discrete_UvdLevel {
     uint32_t VclkFrequency;
     uint32_t DclkFrequency;
     uint16_t MinVddc;
@@ -250,8 +240,7 @@ struct SMU7_Discrete_UvdLevel
 
 typedef struct SMU7_Discrete_UvdLevel SMU7_Discrete_UvdLevel;
 
-struct SMU7_Discrete_ExtClkLevel
-{
+struct SMU7_Discrete_ExtClkLevel {
     uint32_t Frequency;
     uint16_t MinVoltage;
     uint8_t  MinPhases;
@@ -260,8 +249,7 @@ struct SMU7_Discrete_ExtClkLevel
 
 typedef struct SMU7_Discrete_ExtClkLevel SMU7_Discrete_ExtClkLevel;
 
-struct SMU7_Discrete_StateInfo
-{
+struct SMU7_Discrete_StateInfo {
     uint32_t SclkFrequency;
     uint32_t MclkFrequency;
     uint32_t VclkFrequency;
@@ -285,8 +273,7 @@ struct SMU7_Discrete_StateInfo
 typedef struct SMU7_Discrete_StateInfo SMU7_Discrete_StateInfo;
 
 
-struct SMU7_Discrete_DpmTable
-{
+struct SMU7_Discrete_DpmTable {
     SMU7_PIDController                  GraphicsPIDController;
     SMU7_PIDController                  MemoryPIDController;
     SMU7_PIDController                  LinkPIDController;
@@ -406,23 +393,20 @@ typedef struct SMU7_Discrete_DpmTable SMU7_Discrete_DpmTable;
 #define SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE 16
 #define SMU7_DISCRETE_MC_REGISTER_ARRAY_SET_COUNT SMU7_MAX_LEVELS_MEMORY
 
-struct SMU7_Discrete_MCRegisterAddress
-{
+struct SMU7_Discrete_MCRegisterAddress {
     uint16_t s0;
     uint16_t s1;
 };
 
 typedef struct SMU7_Discrete_MCRegisterAddress SMU7_Discrete_MCRegisterAddress;
 
-struct SMU7_Discrete_MCRegisterSet
-{
+struct SMU7_Discrete_MCRegisterSet {
     uint32_t value[SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE];
 };
 
 typedef struct SMU7_Discrete_MCRegisterSet SMU7_Discrete_MCRegisterSet;
 
-struct SMU7_Discrete_MCRegisters
-{
+struct SMU7_Discrete_MCRegisters {
     uint8_t                             last;
     uint8_t                             reserved[3];
     SMU7_Discrete_MCRegisterAddress     address[SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE];
@@ -431,8 +415,7 @@ struct SMU7_Discrete_MCRegisters
 
 typedef struct SMU7_Discrete_MCRegisters SMU7_Discrete_MCRegisters;
 
-struct SMU7_Discrete_FanTable
-{
+struct SMU7_Discrete_FanTable {
 	uint16_t FdoMode;
 	int16_t  TempMin;
 	int16_t  TempMed;
-- 
2.17.1


