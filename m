Return-Path: <linux-kernel+bounces-105305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5D87DBFF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CFB281B56
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 23:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0995A43ABE;
	Sat, 16 Mar 2024 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddns7PQ8"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975E1CAAA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710631277; cv=none; b=C4R1ZuhBJvxQ3DgjFm4q7JKJ1bZsQoGRxc345lPv7ofYVK/5V5wp11vvwxwxDwsr3Ly8YaAHD1E1wyFTCFrp2vCQa0U9kbCqeOAWeDKx7dvCSaqkQttEWhvLKrsoOts83Ce08y6NhRurE9p2SV9HYZaJiAIVCPY1+oq3ymlGLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710631277; c=relaxed/simple;
	bh=sMWZ8gwC6b4q/IlyOLqAExi//RIEkYeEOlRu42CrpKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tiAA7RiJYY5GHNpIZ92zXUFZTwjUMJV+cODSKS5EZUTlAeofT+DOV846/fiKeywhgz7wsVpRXUBrodyPIlZPjISDn0YKGP+1ZbLGv/5+X9KDBtZtgwmSrFH6zQtEHGLt5XerFuioUBLAJsIVFnb9681jl61iuCKj4DHkDRGueKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddns7PQ8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41409c8d7a4so3813055e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 16:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710631273; x=1711236073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u9RemNCbJK07Y6CWgTnC8EJ/F3+o5RaU3BSPTubYEeY=;
        b=ddns7PQ8Dx53zGzqOiV4s10Ssn8MA3YaPPY6AjGHDULkVFZ6QoTbzoOldzrHWKIJ5A
         LhisbinZy3wpke1hLAJHwAnk11XBpTK+EY74dcLl1Hfht0v2Yyfes9KmGW6XSlw5Oa4D
         2afA/YnPtLEIrF4b2C5Jq6i9ONtj9uW3QqZL8SunwUkJ5a6JPARoEFYSwL2VcRUTaTNt
         vQcoI1U2H8iRku/gG9zVC3/lu6Tobl/SSNNW61yT8hmVru46h4ErCguWaUydEZxPqKin
         gg7vouINI1WItr9unwhKAPC6RNANJcq4mguW2hLfkM9MRK35MfpQMDGiYGKvjs2UQ1Bu
         /IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710631273; x=1711236073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9RemNCbJK07Y6CWgTnC8EJ/F3+o5RaU3BSPTubYEeY=;
        b=qpE1bV3E5FByrepOPqbfdnqpikRb/G0SYNzp9vsq+JlGsyDAaPq8t4FjoUJMXjt57v
         JgJ90SeOgNRzYSBX2y7mTk8vdcC602MvTfWdZK9tgB4Uyqwg91nwBRnUOVH8qzHvAfU3
         Dmh8tFHlYm5L6Laiz83+J24cJeMu0vShvR0Ho0YsrTqORitizjZs7veJCkaKSlNeEYTX
         cFVavEfN2aZvYF+RgtLF7fM9fhM60poK11tP/Zc4XSAGWKY0r9iD/0mHOE1boXFegaZ2
         jnvpATbu6F3z6SohCBz2oku1F7barSdY2/DSFkto6JObCZ2ZTTWCPLKjZOJCd3EXPkgu
         /6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUxm3VvO3WEKBcROIrJHdsldSbe28qYWkStFCnPbgSFnXeaBUPS7Z7Qh07jRvCnGS3KwwFJO672yAqcj14Q8Pbosd9DERkd05bPO0I8
X-Gm-Message-State: AOJu0YzbtEPvKrL/jOj4s1Ebc/TSwZdc7paAqfSeChV5AWP3Z/uzqJt8
	JhUq2de/3lyjGDXTJQ6LlHFGRDE6ecY33i0DbNIWuKNxAhwQfc9IKDlP7iD5fGE=
X-Google-Smtp-Source: AGHT+IEt57bHezMEUn4TbJY54M4hPwjcFgphT2UZhpr52wTx4STd4UaV7R+Xiv01e5NyxFPquZwJJw==
X-Received: by 2002:a05:600c:468d:b0:413:1d88:f85c with SMTP id p13-20020a05600c468d00b004131d88f85cmr6602731wmo.33.1710631273318;
        Sat, 16 Mar 2024 16:21:13 -0700 (PDT)
Received: from solport.. (82.red-83-42-63.dynamicip.rima-tde.net. [83.42.63.82])
        by smtp.gmail.com with ESMTPSA id fm13-20020a05600c0c0d00b004140a13f998sm1597028wmb.11.2024.03.16.16.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 16:21:12 -0700 (PDT)
From: =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	=?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
Subject: [PATCH 0/2] x86/bpf: Fixes for the BPF JIT with retbleed=stuff
Date: Sat, 16 Mar 2024 23:21:02 +0000
Message-ID: <20240316232104.368561-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixes two issues that cause kernels panic when using the BPF JIT with
the call depth tracking / stuffing mitigation for Skylake processors
(`retbleed=stuff`). Both issues can be triggered by running simple
BPF programs (e.g. running the test suite should trigger both).

The first (resubmit) fixes a trivial issue related to calculating the
destination IP for call instructions with call depth tracking.

The second is related to using the correct IP for relocations, related
to the recently introduced %rip-relative addressing for PER_CPU_VAR.

Joan Bruguera Micó (2):
  x86/bpf: Fix IP after emitting call depth accounting
  x86/bpf: Fix IP for relocating call depth accounting

 arch/x86/include/asm/alternative.h |  4 ++--
 arch/x86/kernel/callthunks.c       |  4 ++--
 arch/x86/net/bpf_jit_comp.c        | 22 ++++++++++------------
 3 files changed, 14 insertions(+), 16 deletions(-)

-- 
2.44.0


