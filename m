Return-Path: <linux-kernel+bounces-2446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AE6815D4B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7626F1C21379
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913DE110A;
	Sun, 17 Dec 2023 03:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAOc+TID"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1AEA9
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 03:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9e7f4a0d7so1732718b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 19:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702784181; x=1703388981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y332qFsoRQKdpXL92Uln91AUNhn2wyVaOfQwWysNPZU=;
        b=MAOc+TIDbcMk6RyWHM0veuNsFnq11A3TITLLxrNV9VVQOhuN9Q3Y1aXe2tF0GMEuvr
         6Fk1GQK+ZO8IP5y1PHETDOErr9fNUR3WeGR75l2FbNrncAXr1Y0eBC+O9BJspOZJFFUn
         gNYw0jTK9nXGn761aUg1PTN1oLv/iet2zHdpswinr3AxqiBVDegL3qqMo0JoRMAzr8gD
         /a9zPQtxTWYbY4Tdpr8YQb7im1Bg15Bb3c30FTgLy9dRVdjdUf1xDavzZfBYgfFj+Mbt
         s9BQAKTuOWVYgESenAYAfjs/uX7UJs0rm9mjOGkz/mOnWi6XHClY/onRlkwfL59Wg7uw
         Ko8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702784181; x=1703388981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y332qFsoRQKdpXL92Uln91AUNhn2wyVaOfQwWysNPZU=;
        b=FRSE1uWjL8zzGKJ8lqpx+cC+tqnxPe3GT6obeU/Y2QdWM6y/Q8KarJyNGtb6i4zXum
         1ZZgMRTV4Ij5agzQ/nMaDffTnU2gA+xhG4+1euaLrstqYLNgJWBcoAPf5f/fwiFwhTbE
         XNrW0Vev0cgchRGcsQAm/afawMluSXSA4zXrkLKvn69CGI/hkKIqjhpGjXFs6Oo1fCGJ
         J64JolS80JBmygJIBFUKGfn8Dd+9BryzNbkDULDwRRc2KGfUEu85S9M7KHbLdRs8MjyY
         HimhdF2CeR6zhDlnjPcQ864qNWXckh3vcs5yrRcWkdNnuAkHclPWCVgQxAH0ivUS7clg
         Pd3Q==
X-Gm-Message-State: AOJu0Yxall/lwRDBV907ggy8AjFDAsETdGqKspcdNwgQ2Y9hgIkofw1i
	0XpOnT1NdTxbT+sEIuoGW9xY+DjoJPY=
X-Google-Smtp-Source: AGHT+IEjJ8N4V5XA4bRG0VYVvyRzhuKfCCXL3djeU4y8vjw2MXbt49MKL11iX0GlJANcSSrP3LWRyg==
X-Received: by 2002:a05:6808:2f15:b0:3b9:f725:d92 with SMTP id gu21-20020a0568082f1500b003b9f7250d92mr22080726oib.99.1702784181512;
        Sat, 16 Dec 2023 19:36:21 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b006ce48a0b7c6sm15768820pfm.109.2023.12.16.19.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 19:36:21 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v5 0/3] Some bug fixes and cleanups related to kexec
Date: Sun, 17 Dec 2023 11:35:25 +0800
Message-ID: <20231217033528.303333-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes some bug fixes and cleanups for kexec.

This v5 series introduces no changes to any patches. I just reorganize the
patches and repost them.

Yuntao Wang (3):
  kexec: modify the meaning of the end parameter in
    kimage_is_destination_range()
  kexec_file: fix incorrect temp_start value in
    locate_mem_hole_top_down()
  x86/kexec: use pr_err() instead of pr_debug() when an error occurs

 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 kernel/kexec_core.c               | 8 ++++----
 kernel/kexec_file.c               | 4 ++--
 mm/highmem.c                      | 2 --
 4 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.43.0


