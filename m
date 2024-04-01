Return-Path: <linux-kernel+bounces-127143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D47B894769
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BB81F21EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E1956451;
	Mon,  1 Apr 2024 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHJlddwK"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987E8F6F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011420; cv=none; b=gxk8r4x07fz+lMRcLabYyBSDME5UFC2yeXv/Rqin6o6SiM8g5ES7KPq8nFLIvfmK9S6qusIVYh54wGETAOndBIUeOuXd3d6yxTsKn8UMzqwR/R5WwYVsWuXqL/QF+ML/BNOwLCsx0A4ccGMjHliI4urC459byd3WvCd3xiINVeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011420; c=relaxed/simple;
	bh=lr1IHaxUT/+xljHG0Uu+wLFVu3/KFPs/V0ibGT2BuSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6s2r3J/fjVDWE6Rpwj60YmV5gGaOdIxNrxi7Y5fSGiNjaVc7mf/Gdo+gMZEPqf19jA7R/ssEkKNHs+00RWwNquj9bN3I7TlhsY9MzrTEGsS39cTnAx9cz3HLAzRPs9+znYzVuDHPFsx+rStYEFp/DHDKhE7R9LUr5P3Mse8oeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHJlddwK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4e7e2a257cso88748266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 15:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712011417; x=1712616217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qcik2ZKpGkaSDWlkrFdRKbIB9C35lYhPbyGch8RiDYE=;
        b=BHJlddwKeLkgXxCXE76zLnZBvKsDdIx6c2+DJ4j1yqLEfS5/Z5XNtxWdzFFr1dnIqJ
         QgpA7XChLnbdx4EnmtM7aqlKC9ZNCMBqGaPw2TjAfI97R0gg0Pdu9Rqa0P0Mt8L6Rj6s
         JQPFuinlR3JTVAoK3m7oyXMEWPdP7ASLiUtP4UdZr/hGCga+tBiwVvt65dVsMVGTNxSv
         +nsP352ulB/MuZuw9evsaibraE3LLuDtQMuyhzDBfkrvSzXQeN6uPH9zO2eccJYpan1j
         uD6wJ59lqkTrJX9zfr3xKlZpYWWIn9gFtNaye+UH/LAZ5uxjQAzhvC90mA3b9HzbtHkt
         kg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712011417; x=1712616217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qcik2ZKpGkaSDWlkrFdRKbIB9C35lYhPbyGch8RiDYE=;
        b=W7UiPAeJGfmGsmQukIzSlrpx81gEIxOMRBKs++UMgMISNxrOB381pZhxCF6iGvoZj4
         yJ/8vFxvf0BqrYma60dSZVT2LGEP1ZwvfkfvSFEHgYGoB7A+mmWi1Q3ZEoZ9o6/rV+xR
         Zz25y6ZvubrQcEABSYJuVcVRGDCZYR38e6NW+0Ca+pSe6XYZ9ssslKOM0MlFtQaax8yI
         bF5uHrOmDc6HUyVJAqDh/iLhqUwWcErwXB8vNK2lTvlQ+x1ymp2mJGLNUJXRYkUuukxH
         Xgu7z1PKrfsYeTVoBz0qcAXiQYisE8V4owJJfRiVUchx+lSJUnSiE71KFK44iiQ3/IHx
         5Kxw==
X-Forwarded-Encrypted: i=1; AJvYcCVm1BjcsiPQwTkjXge46yahM1KjIo7Lxd6FvbWGteB1079/tkvHZSrpf7ODyJ6cf2oK2EAL3GeZxEtadrP2eHDIIBuEPwtzUhIFtG2E
X-Gm-Message-State: AOJu0Yx/Np2O3gVVL52kr+fqz9Av5PZCmN4ln2fhUyrMX9D9CT5UlmN/
	L8dbGjhb8baU6nTZpQq7OQvapHMlQsKgXgD7t0I1a2E+KFkHUOZZ
X-Google-Smtp-Source: AGHT+IFCq9xTRzVKnUogJcMxAWnpUfEpfgOajgprHKVs1djxX9T4SpkK3k/wCGnJbNBww8lu687rQQ==
X-Received: by 2002:a17:906:4a01:b0:a4e:2ac2:bb27 with SMTP id w1-20020a1709064a0100b00a4e2ac2bb27mr6448520eju.9.1712011416859;
        Mon, 01 Apr 2024 15:43:36 -0700 (PDT)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id c3-20020a170906340300b00a4739efd7cesm5796808ejb.60.2024.04.01.15.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 15:43:36 -0700 (PDT)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	anarsoul@gmail.com,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH 0/2] drm/lima: two driver cleanups
Date: Tue,  2 Apr 2024 00:43:27 +0200
Message-ID: <20240401224329.1228468-1-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is a fix for a crash which triggers on removing the module on
kernels with CONFIG_DEBUG_SHIRQ enabled, such as the Fedora kernel.

Patch 2 is a fix to this warning:
  drivers/gpu/drm/lima/lima_drv.c:387:13: error: cast to smaller integer
  type 'enum lima_gpu_id' from 'const void *'
  [-Werror,-Wvoid-pointer-to-enum-cast]
which we have received as a repeated report from the kernel test bot to
the lima mailing list.
The warning only reproduces with recent clang on aarch64, but the patch
does get rid of it and there seem to be no more warnings for W=1.

Erico Nunes (2):
  drm/lima: fix shared irq handling on driver remove
  drm/lima: fix void pointer to enum lima_gpu_id cast warning

 drivers/gpu/drm/lima/lima_drv.c | 21 ++++++++++++++++++---
 drivers/gpu/drm/lima/lima_drv.h |  5 +++++
 drivers/gpu/drm/lima/lima_gp.c  |  2 ++
 drivers/gpu/drm/lima/lima_mmu.c |  5 +++++
 drivers/gpu/drm/lima/lima_pp.c  |  4 ++++
 5 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.44.0


