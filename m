Return-Path: <linux-kernel+bounces-591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287C2814354
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1C41C225B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3EC17734;
	Fri, 15 Dec 2023 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrukgY4W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801B9168B7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b844357f7cso360803b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702627792; x=1703232592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JzWG/4o64FumP+WxSPc2A7cmnMu0/YsLnKZOkOhpCVs=;
        b=ZrukgY4WTq4U2Au4w1rIYKnnJKR5ZlB94nbpEfzf076i4F7izXN5R799hrR8Y5qZuq
         geXEcRPYOYy7BL4fBB/lqGzZxu0SCDkBC7Ju1DP83A1wpxIE9k/1jExGBEvmfJ/sVPyO
         rSC+47fBGxe2wvgson+piGPnZVIW0yWV6Rj3hMB6MYCxZJ/4Cy54rRD4aXs9YGy0jdnO
         FohNDgTVWDm/Sehh6fTQCBje97MZl/pIes/0yN6Fb0CTFWWlIPzjXfe6PwcUuVCQuzUW
         UQle4oMhxiv4nkms+BElGLaPuVXWUoTpsay/CAKzSBBuY5QyHqBD5btjzTSEOGDyvtQJ
         zqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702627792; x=1703232592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzWG/4o64FumP+WxSPc2A7cmnMu0/YsLnKZOkOhpCVs=;
        b=GaMQnMQZrnhgIQoVwLAN0dK0yGp4h+AgB2HwWQjoUluBUfAnGX0ejM/fOohdu5k9lt
         f45H7BiHENDKbXoXAP903orMM13bnyvt8jnaPdh8w0khXLXZugKYbjUecEvBz8oQJJtR
         HE/40iKJ3sg61irlWe2X02GTVzvAO2lY5TyhjOhbpXaKWVE1/xUfQVKafgNhvGM/Rb43
         inrNj+YY3/w8h67yPwPTj/D2zVIjBSnztuT7tFT3JkVcSkig47BwgCLtw6ctLOAoXGMA
         frZ0qh1OI5F9yO/IDmMvjcdU3f5/VZgRUYKnRKhh2Kp70MCdQKuHmFSCKMSsT3556Ikv
         6Tdw==
X-Gm-Message-State: AOJu0YxPiWVXKT7muY+57mYF83F3ffv8OfuuPFSq61RA6m1aHhPj+Bht
	evMTxNv0TLyg7vXLrcpCSnbJmKoXU5o=
X-Google-Smtp-Source: AGHT+IGE16L21W9Z8Yghq0+NK6xWNe+I8Jqlktd8OWrpaTQXHjURACmAmFHMQwBOREtClGZ6QFw/PQ==
X-Received: by 2002:a05:6808:14c9:b0:3b8:b063:6ba5 with SMTP id f9-20020a05680814c900b003b8b0636ba5mr14884916oiw.84.1702627792007;
        Fri, 15 Dec 2023 00:09:52 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b006cee656cb35sm11783792pfl.156.2023.12.15.00.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:09:51 -0800 (PST)
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
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 0/3] Some bug fixes and cleanups related to kexec
Date: Fri, 15 Dec 2023 16:09:07 +0800
Message-ID: <20231215080910.173338-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes some bug fixes and cleanups for kexec.

Yuntao Wang (3):
  kexec_file: fix incorrect end value passed to
    kimage_is_destination_range()
  kexec_file: fix incorrect temp_start value in
    locate_mem_hole_top_down()
  x86/kexec: use pr_err() instead of pr_debug() when an error occurs

 arch/x86/kernel/kexec-bzimage64.c |  2 +-
 kernel/kexec_file.c               | 11 +++++------
 mm/highmem.c                      |  2 --
 3 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.43.0


