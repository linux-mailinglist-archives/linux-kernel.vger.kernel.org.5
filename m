Return-Path: <linux-kernel+bounces-134729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1189B613
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F801F215E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779555231;
	Mon,  8 Apr 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nLkzPMI+"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCA4C63
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712544028; cv=none; b=U0IYa86zHhfCWyY8OBZy7YRMUZrRjoSaU27rxjsznRApo7hDBO/5bKEtyeo282D6bSOWfK88I6MBq/gOJNRdBT6his+/MFgXE9zgJkxMqWVFDHfJjS3FzWp31tx25H6HVUc4ueo+euEvCTFJbYB5mO8rhJ0V1e0idUxRPKOVf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712544028; c=relaxed/simple;
	bh=/BRAjY9/6yewB1iOzKNzbbqWGap3KS1AkW3aaNzkZLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=YroDjJzyrQZ6RHoHRGPCkjhhbXyua8ovh8iwlO3IW7PW4oQw7jn7rVxH4WPF9rYYRpXWjD4JcWh8J7KWkWcTg+fZcPTCl5MRU5rwD0faIdC9pA1yVkQlhlnkfnMC0QKtbBbpIDjO64IsjGB//b8Etya6b99dpAvAoizS+I7xcIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nLkzPMI+; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240408024023epoutp0250c08b3489101102a3cdf41014cc4fd4~ELbc562Fy1495914959epoutp02I
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:40:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240408024023epoutp0250c08b3489101102a3cdf41014cc4fd4~ELbc562Fy1495914959epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712544023;
	bh=C5261me8MrAIYLY0onhTloYMbg1gCQTiqRzkfe454KI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=nLkzPMI+uTvtvePrO+VsrkYa5UNRtBSU/lR3MjZ2EeVIIOi8TjDkIXVxAVhygBDYE
	 ZbDtoh9MyFqTB05eb86BeE9g7d5iWWvq3c6ZuQoVJFP/xqIgB3lHcfG266jtCZrH8I
	 tv/WtyxiggDC5F4IYfsEFhfa9cfQNq1oVTlHje+4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240408024022epcas1p43692955f9798e903a656f78c54891e78~ELbcTuGfq0316803168epcas1p4A;
	Mon,  8 Apr 2024 02:40:22 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.243]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VCYGt3w9pz4x9Q3; Mon,  8 Apr
	2024 02:40:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.8E.10158.61953166; Mon,  8 Apr 2024 11:40:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240408024022epcas1p176f9509f6f85fd8dbfa2dd17067a8aee~ELbbyLxud0453104531epcas1p1Y;
	Mon,  8 Apr 2024 02:40:22 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240408024022epsmtrp125bbdb2cd751bbbc175797a8dd0d59d8~ELbbxZ93m0455604556epsmtrp1P;
	Mon,  8 Apr 2024 02:40:22 +0000 (GMT)
X-AuditID: b6c32a38-8e1ff700000027ae-77-66135916ec5f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.08.07541.51953166; Mon,  8 Apr 2024 11:40:21 +0900 (KST)
Received: from parkseongsu-desktop.. (unknown [10.252.69.73]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240408024021epsmtip286d2fc1b43e70cfbcc8d723c5a522ebd~ELbblSCu70750907509epsmtip2i;
	Mon,  8 Apr 2024 02:40:21 +0000 (GMT)
From: Seongsu Park <sgsu.park@samsung.com>
To: will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sgsu.park@samsung.com, Leem ChaeHoon <infinite.run@gmail.com>, Gyeonggeon
	Choi <gychoi@student.42seoul.kr>, Soomin Cho <to.soomin@gmail.com>, DaeRo
	Lee <skseofh@gmail.com>, kmasta <kmasta.study@gmail.com>
Subject: [PATCH v3] arm64: Cleanup __cpu_set_tcr_t0sz()
Date: Mon,  8 Apr 2024 11:40:16 +0900
Message-Id: <20240408024016.490516-1-sgsu.park@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTX1csUjjNYNUOKYv3y3oYLTa13We0
	+LNxN5PFl79LmS02Pb7GanF51xw2i6XXLzJZvG/oYrWY9GMLo0X75xesFi13TB24PdbMW8Po
	sXPWXXaPTas62Tw2L6n36NuyitHj0NkFrB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfH
	O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAnaikUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
	sVVKLUjJKTAr0CtOzC0uzUvXy0stsTI0MDAyBSpMyM64MeUEW8EXoYpVU9awNDD2CXQxcnJI
	CJhI/Gq9wN7FyMUhJLCDUeLzg4+MEM4nRonmt7NZIZxvjBK7LsxlhGmZO/8OM0RiL6PEphtz
	WBBaLl5gBaliE9CSWP2vlx3EFhFwkth/agkbSBGzwCwmiQVH97KAJIQFzCU+z30J1sAioCox
	6+RCJhCbV8BaYt2LlawQ6+Ql9h88ywwRF5Q4OfMJWC8zULx562ywMyQE/rJLHL+wlhmiwUXi
	/PU9LBC2sMSr41vYIWwpiZf9bVB2scS+L2ug6mskHszbA2XbS3Q8awPq5QBaoCmxfpc+xC4+
	iXdfe1hBwhICvBIdbUIQprLEua2OEKakxJ8FehAzPCQ+bl8KdryQQKzElC0/2Ccwys1Ccv8s
	JPfPQli1gJF5FaNYakFxbnpqsWGBCTwik/NzNzGCU6aWxQ7GuW8/6B1iZOJgPMQowcGsJMIb
	bCqYJsSbklhZlVqUH19UmpNafIjRFBiiE5mlRJPzgUk7ryTe0MTSwMTMyMTC2NLYTEmc98yV
	slQhgfTEktTs1NSC1CKYPiYOTqkGpl6d2VaCkiq+z959OGTA6m1bkhMi9KD2indqZoOsu9Ht
	9wnej1YfiJdeFpHxydR8fZieW9327e+XbO+ZF2h9R7Y69PiG6lvNe75H/TTuPv2/J+ibBKNC
	uo1Dy5GS6r/fks1k7zo76+6cX7GgLfB5gIhZ97p1fzZnPWeUKWZ03RmQnymuUSQ+4/vT4x0x
	azcx6T++s6ohluXevpg9ykubtLQVJiquuOdWp++wxeXtP9VP7fs4tvHKXz7DMz9u39L7yuo+
	d+VCC04XPWhUivTJvHS4OrU9NqyP1eP/y6mNGVtvstQqFTKeMnlkndnDOi/NRzDCrVTj4Zrs
	9vxzji5SMtXMwkYM507NdjHh2qrEUpyRaKjFXFScCAB/ZonRIgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvK5opHCawa8N1hbvl/UwWmxqu89o
	8WfjbiaLL3+XMltsenyN1eLyrjlsFkuvX2SyeN/QxWox6ccWRov2zy9YLVrumDpwe6yZt4bR
	Y+esu+wem1Z1snlsXlLv0bdlFaPHobMLWD0+b5ILYI/isklJzcksSy3St0vgyrgx5QRbwReh
	ilVT1rA0MPYJdDFyckgImEjMnX+HGcQWEtjNKLFuqjtEXFKi/d1lli5GDiBbWOLw4eIuRi6g
	kg+MEsf+P2MHqWET0JJY/a8XzBYRcJM4ufUcC0gRs8AiJokvaxvBhgoLmEt8nvuSFcRmEVCV
	mHVyIROIzStgLbHuxUpWiGXyEvsPnmWGiAtKnJz5hAXEZgaKN2+dzTyBkW8WktQsJKkFjEyr
	GCVTC4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGCg1tLYwfjvfn/9A4xMnEwHmKU4GBWEuEN
	NhVME+JNSaysSi3Kjy8qzUktPsQozcGiJM5rOGN2ipBAemJJanZqakFqEUyWiYNTqoHJcar5
	2cde0pJyN7OffikQk78wbZUYxz6xPW9ZWS+XyfxKsTTTv81hyCnt9XbhqkPxqZ+L9FXcYh4y
	/Zjww19N9ez9w2qBPH+P7Fu97ams7ZU/BSHPGhySJ8WyP/aytl7645DaWa2IpJ5SQdsaz5V+
	4eeTg5z6Ktqn6y8SYoyT6n3S0JU4n/ln4N8EprD0U1X5p5jCvty3jmZgCmY/usNJRFd8evvV
	p4tXC125orZG+XafyOMcbm7XtUsN1N+pbmoU1e+YLP5PsHSDfavOzGff9eOUdMX2soQc25Ba
	e2rhKT135cXzViwT4P/UzqD1WuTHWgcrszPTNGZL7eHdoFmzVPz0A/7DNmILV2/PblBiKc5I
	NNRiLipOBACAVscw3QIAAA==
X-CMS-MailID: 20240408024022epcas1p176f9509f6f85fd8dbfa2dd17067a8aee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240408024022epcas1p176f9509f6f85fd8dbfa2dd17067a8aee
References: <CGME20240408024022epcas1p176f9509f6f85fd8dbfa2dd17067a8aee@epcas1p1.samsung.com>

In cpu_set_default_tcr_t0sz(), it is an error to shift TCR_T0SZ_OFFSET
twice form TCR_T0SZ() and __cpu_set_tcr_t0sz().
Since TCR_T0SZ_OFFSET is 0, no error occurred.
We need to clarify whether the parameter of __cpu_set_tcr_t0sz is a
shifted value or an unshifted value.

We have already shifted the value of t0sz in TCR_T0SZ by TCR_T0SZ_OFFSET.
This is necessary for consistency with TCR_T1SZ.
Therefore, the parameter of __cpu_set_tcr_t0sz is clarified as a shifted
value.

Co-developed-by: Leem ChaeHoon <infinite.run@gmail.com>
Signed-off-by: Leem ChaeHoon <infinite.run@gmail.com>
Co-developed-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
Signed-off-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
Co-developed-by: Soomin Cho <to.soomin@gmail.com>
Signed-off-by: Soomin Cho <to.soomin@gmail.com>
Co-developed-by: DaeRo Lee <skseofh@gmail.com>
Signed-off-by: DaeRo Lee <skseofh@gmail.com>
Co-developed-by: kmasta <kmasta.study@gmail.com>
Signed-off-by: kmasta <kmasta.study@gmail.com>
Signed-off-by: Seongsu Park <sgsu.park@samsung.com>
---

v2:
 - Condition is updated
v3:
 - Commit message is updated
 - cpu_set_tcr_t0sz macro is added

---
 arch/arm64/include/asm/mmu_context.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c768d16b81a4..fb603ec7f61f 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -72,15 +72,16 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 {
 	unsigned long tcr = read_sysreg(tcr_el1);
 
-	if ((tcr & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET == t0sz)
+	if ((tcr & TCR_T0SZ_MASK) == t0sz)
 		return;
 
 	tcr &= ~TCR_T0SZ_MASK;
-	tcr |= t0sz << TCR_T0SZ_OFFSET;
+	tcr |= t0sz;
 	write_sysreg(tcr, tcr_el1);
 	isb();
 }
 
+#define cpu_set_tcr_t0sz(t0sz)		__cpu_set_tcr_t0sz(TCR_T0SZ(t0sz))
 #define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(vabits_actual))
 #define cpu_set_idmap_tcr_t0sz()	__cpu_set_tcr_t0sz(idmap_t0sz)
 
@@ -134,7 +135,7 @@ static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
 {
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
-	__cpu_set_tcr_t0sz(t0sz);
+	cpu_set_tcr_t0sz(t0sz);
 
 	/* avoid cpu_switch_mm() and its SW-PAN and CNP interactions */
 	write_sysreg(ttbr0, ttbr0_el1);
-- 
2.34.1


