Return-Path: <linux-kernel+bounces-74389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B8885D354
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FE0288C47
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D045F3D3BB;
	Wed, 21 Feb 2024 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="FUbyyw9A"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02C53D39A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507278; cv=none; b=bo6IwVtzTO/EKwB9zRoA/E7fxaelwoQ5a64Z0mvvdAScLUE6N/8711VnbYdDJdpR3Spqn8ZYGtqIV5jx1aOLSoWvarMk8X7xVhMSLgtMLg6XJIIb0RuMkRzRa5+PmdEXJauQB38txnWDefXWFIDgzqj7RvnV/sxjNEmKrMHtlxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507278; c=relaxed/simple;
	bh=yQ82H//CaYGudMjFV9jxUaacAngpVsSR55e0XGCXnUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GeGoOzyXzjcIwPWOWfYzqadHdUWbV+V25sRnyBBlujLhvUWU7SO/c2kw4qsaztOaFkbrVYHeBjgxwrob+rLR1Xlp+m4kNkcmVclAMIs7xcRbuY+/LHKLAGgCnh2EiQtIax2PeH39vU4aH8dHus2l/JPz1f9SicltdSY4S9yhrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=FUbyyw9A; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2906bcae4feso3173818a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1708507276; x=1709112076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcZlaDLpQ3JSX73i5r1SJY/GlRpzb/keZ3S18YWssmQ=;
        b=FUbyyw9AkhVUnWt/ARgy+j7gV+WqrDmnX+PyBtf2YXtoU6LMmm5dlPRTgco/z1Xt19
         VWct5BUjy924oZFPpU0S1C22VVmqxIvAGDQ+FIn/0YnxTS+ibwj16m/MgmpCY9ouMh9h
         C1FpoT4VOfR1eSLCOWceI5NMF2dh3akb9jI3RmSJ4RgVvo/7QBM9fnUEn+azxuNbl/Dd
         wls3dN9xAY64tlCnP2RFU7T1fDN1omRSc6ekVMn4xng++CccLDfRC5CAchwhDiJRzVjL
         qACnMfubFBhE2zqPwj+7QC4girkd98kE9eEmZtG7kL25roUZI4WcBC0vfC8l1O7pVROg
         aKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507276; x=1709112076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcZlaDLpQ3JSX73i5r1SJY/GlRpzb/keZ3S18YWssmQ=;
        b=aayB6wYS47ZzqXe607y6xXqsiGVXkjri0ZtuXi+pujYH97A7//Hn4AKCgyT5ho5iSQ
         ExOB/jLW0jvM4Gs9Fm6niYHj5Q5lHAmKEx53VSb7bQPpQTGjKM9Mztl/HQDCLJata8A8
         rMcLehK7LK06Lcnce8uX4AORLn4eCScp6egKPqWzD6UQ45Qx6LfGV+qBUjW6+7JNba6s
         xvZSbxzAe+mmZ0gVNttN+opPzPZAN0tk9eUZ/Z3s5dA35JWr1gJy0X0Eceibi1kLOZze
         f88hKb2BtpEgIHJ4MT3KVNDwyA1FppYj7UHWFhxapnslBccBDxQ5KfeO7nhyI7htMK2b
         AAcw==
X-Forwarded-Encrypted: i=1; AJvYcCWzgU8pkNiLZrihtYHeOjRYjUhZ9XxBaFUhuKatBls/9w4YRYMbg60tZswzcDunSKqHl1w5WtYjyvkpjYrbC5ZVwlnXSc7RZ4W4pY57
X-Gm-Message-State: AOJu0Yylz1vBASEJHI4mO1F4d2r6stXqkMJJTk0hAopvjGBd4EzrGA4i
	tO+OV2kH6nAQgcuUHHFXuidZwTkiGSyNuEB6RxVHjrTFYEyqfaLMyPPBpp4a0BDSRBWOxWLeoqT
	els0=
X-Google-Smtp-Source: AGHT+IGAFYzw+fr0nN5b3MmepnWESYu7WLz8N9RKqu1XM9FBYRsE8MdtuaDzUChpX6mfJ07p1EnS2A==
X-Received: by 2002:a17:90b:4ace:b0:299:3efe:8209 with SMTP id mh14-20020a17090b4ace00b002993efe8209mr9461983pjb.4.1708507276025;
        Wed, 21 Feb 2024 01:21:16 -0800 (PST)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b002995babd9b0sm8461290pjt.10.2024.02.21.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:21:15 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2 0/2] Track llc_occpuancy of RMIDs in limbo list
Date: Wed, 21 Feb 2024 09:20:59 +0000
Message-Id: <20240221092101.90740-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After removing a monitor group, its RMID may not be freed immediately
unless its llc_occupancy is less than the re-allocation threshold. If
turning up the threshold, the RMID can be reused. In order to know how
much the threshold should be, it's necessary to acquire the llc_occupancy.

The patch series provides a new tracepoint to track the llc_occupancy.

Changes since v1:
- Rename pseudo_lock_event.h instead of creating a new header file.
- Modify names used in the new tracepoint
- Update changelog

Haifeng Xu (2):
  x86/resctrl: Rename pseudo_lock_event.h to trace.h
  x86/resctrl: Add tracepoint for llc_occupancy tracking

 arch/x86/kernel/cpu/resctrl/monitor.c         |  2 ++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  2 +-
 .../resctrl/{pseudo_lock_event.h => trace.h}  | 21 +++++++++++++++----
 3 files changed, 20 insertions(+), 5 deletions(-)
 rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (64%)

-- 
2.25.1


