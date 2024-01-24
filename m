Return-Path: <linux-kernel+bounces-36979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9691B83A9BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5BC1C21A36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47346312C;
	Wed, 24 Jan 2024 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ABH5kuva"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09BE63126
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099384; cv=none; b=d5JrBSCtPiM3ayYFCuqDxvFFvxnjpMonhHRVTmL+KFQX85amq3wWysXLvVTnVPpbojAqLXyfqnALq7KLlg3IE9rcnqmLc5IlW4Ywbq7X1Od1uJocHFnxg985Vpeg2jgdAgCMwto7TVYQ/agsCAP42oXBCAdB2jsDwvUYpv7I3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099384; c=relaxed/simple;
	bh=zXZzstidznwktnfwkp33qJ95ppoP9GSUCB2MycHr+pY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJkYo2slqOAhqLlaNVDesJOkQVWhtKBBS2QwUVaJNG8hKT5UYhxsEyKEGqXaloZOUDVGQ9U+8DUVU0CgmOv2qd22ECOWjTQMPdnelA1KeR06rLRCMN6c/QiLi23YbYmQT37ZDPh0tEAxBGtjbAsn0sNzpfI99GcF6IdgEVKxCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ABH5kuva; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d730b6943bso16905485ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1706099382; x=1706704182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LiD0rjQFmh/9BQJEz2Ao34wuQ4GFoyU1gClHa9sv83Q=;
        b=ABH5kuva2qfgLW1eE47yv6bMGUBfpiCYo30h90UD0JHImyCDweYnyxzqwS0M/1k5zd
         3ueVg/1oGd2q/uUlr8MwwfHLAXwB7QVvyURE0x/WBzmLkZ9JpqlG10NIMB5c2UkMRw9F
         8/XFZeS8wV+98ZJ8Nlk070ApV6aw5XwHMwgYHgeug1oZTq84/7zOCvk/gSLQZKd72mby
         8FGdIe5TfeMVbXkWoowRWDkkpbJTBH8QQLSSjPcIUBtyry62Xj4fW7aeIhPDZ04bYkfT
         V0p+2d+jLOOVLDlopHEv5wPR4d1OQbakXCgae9/M3zm3O1tS+XWa6i1eR+35pyNSF24i
         fjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099382; x=1706704182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiD0rjQFmh/9BQJEz2Ao34wuQ4GFoyU1gClHa9sv83Q=;
        b=kwEjprIC+l8UUyDC8slGJwVtsR53p3CLka0k3AJoDNKNin7fmEDlzIq7UBxbx6CTWq
         m6MBjTIYuRgcgg0EeFQMF1R8PnCXS7T4zeScbdH8NHSP+JDTSAENzeDe7byIm4x1lJ26
         4KeMjARn6sG0TycyLYufu40iUH3wnNuEIEmoCV2USBBsTbOBinb0x1JAI/Z/cYRkuvbU
         rdYPyy2tCvLnBlpUsQQdFe+7cYLvLncNA1GSWQ8lV6xlN3pqlbyPYmjPJWUXOezKEi8Z
         1/kpIH9ESYzNeYJ6COaDJlIvrLyJmnsrKFOJ1U5xr/LrjP72svxrHfGyOm2bmaYYIS8s
         nSUA==
X-Gm-Message-State: AOJu0YyDKsjq2wG7qZtea73CaRegZJTpL3GtP2WH/2Ilc8Kkf8XuuTzp
	ZPF4hmTcybiKGfXKO7HG91Yf98zuK8qGEGWxdWTtrlOt1VP1f9L3guYjoQ0aL/g=
X-Google-Smtp-Source: AGHT+IFNpOJaMHwui3sOu7Y4nD94Fm2TbGPvpczWao+z56w7IkLdelVIVe37r6D00fB2Bmqs4UmJUw==
X-Received: by 2002:a17:903:2283:b0:1d5:e313:8380 with SMTP id b3-20020a170903228300b001d5e3138380mr618116plh.2.1706099381894;
        Wed, 24 Jan 2024 04:29:41 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902f20300b001d6f8b31ddcsm10414605plc.3.2024.01.24.04.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 04:29:41 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: tglx@linutronix.de
Cc: mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] x86/cpu: Remove unused aperfmperf_get_khz()
Date: Wed, 24 Jan 2024 12:28:17 +0000
Message-Id: <20240124122817.1295451-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aperfmperf_get_khz() isn't used by anyone, remove it to clean up.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 arch/x86/kernel/cpu/cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 885281ae79a5..6bbee333d055 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -81,7 +81,6 @@ extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c);
 
-unsigned int aperfmperf_get_khz(int cpu);
 void cpu_select_mitigations(void);
 
 extern void x86_spec_ctrl_setup_ap(void);
-- 
2.25.1


