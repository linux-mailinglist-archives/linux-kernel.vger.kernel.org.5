Return-Path: <linux-kernel+bounces-98824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C1877FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7AA7B21A23
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9883C699;
	Mon, 11 Mar 2024 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8Wal0XN"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4DD3B7AC;
	Mon, 11 Mar 2024 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160051; cv=none; b=re5TdI90+3iR5oavntOD4rlmo75A39+pM+KIFRfHh2D/zfFowkziEUVKY4uIhBeJgcbXTZIE+R+NRii8HxCuyhz30hP3Ruvhe3QltfBwQ4iskZZf1KYa4SU4cWBa0g4/McVfq5tNWBqiAj5s7dpAaO5ls0Exo282FVrX58XsEpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160051; c=relaxed/simple;
	bh=4d32YUyS5pC2XXqAvjLNNgIpQ/4RfSD8MPeKys5HKUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jiEDfp7otPypE6AqNtSX6JYSv15i1W488op5EtWEk1VOSVFA5DCRIz+qVEcCD3BosGPPz6+bzI4bsGeBAaUSMaT1+3vEIlLVIoy6lcEZbKoJBXhBuJeGcjlp1fqObO/ysc5kE1brVlhX8V9Ycxr93P1c9J4pELHlWEsrXOV7iKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8Wal0XN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41312232c7aso21298025e9.0;
        Mon, 11 Mar 2024 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710160048; x=1710764848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHG0vN63j1nffMa2lA7aOaYAPgfMxoLud7R8/byKDNQ=;
        b=V8Wal0XNOz3gqZ8aAjWp/dZVLOvXAzqzYuuEEzHwMoYCdnxZPBRxfBJRFbAKy65b+l
         gt3KAA6KDRa3usQ0lFw2FQ1KlrQ3a1bljKgoKKxh/TTZTU/t4r2QR5t9e5MCvD/GbmJF
         lKkAmu7MkZttyPjgujeng1MWMrtWdd+8l5Scg4/shwnY9R+I3mX3UHFsH4i0YbAuocLd
         MdZGoq1nGbPKeD+PryPqk8UwIbWolELxa1GVsQeYVblukimQpsImS5/p909n+jymwjsG
         nqx4aASE7qW5BNWhu0U0VDWlO6ZtUq3dN2cgsXWcOsZEaRo7baAXSRL26TZ29kqi5pBC
         Z5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710160048; x=1710764848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHG0vN63j1nffMa2lA7aOaYAPgfMxoLud7R8/byKDNQ=;
        b=Bx6Ky9lBvw/DVu2gk9l1qu83oxEI5qUAaihBdEBQcMRIQqog+RfH82mLsKWRoEhYFq
         /krDIph9l8eYqWU2BzYlyhBAXSmwaaarfhwdid4N2VW2tY+rJJeFd9AF2rh2DyWvVBbV
         oM7lJngzXBLBnlalJRpNLgVjYlUfzJblnKVjwq5tzbIHzWPABUEhlnbVg3eZlHaTMq71
         FxgWGmXX7DgbFO4T0GVEKqk3BqvLj5MiXL2QQiwwyYO6WY7fikLWT26nnZXlawlstlAa
         DLlr2lrTdyQhMhHFru9SNVdDDtc69In/q8bL2k9UbxMdPFKXR0Xy6LaN0GwaBlJ1tuQ6
         35fw==
X-Forwarded-Encrypted: i=1; AJvYcCV2m7AC2Jl8cEXHoZc+cPgUTeh0YZ0lTbEssRMgP/+7+w+tVjH9qjvffwnRv0KjkpTZzmnx67CjcKxRRQ9sKiy6VQrcCo6XoZzblXYHewLKEzwdEco40R9DvIKRh/EaQN0O
X-Gm-Message-State: AOJu0Yy+9o/H8DyVc6XvL7GaaxwSNLOjpCOXOdyxvsQbyZFXGrgaMqfY
	CY+X2zNUf7EMNAXbxZB6DyHDkQwLDpqEhXb6jGznstVM1YlfKXGm
X-Google-Smtp-Source: AGHT+IEdyLkbyK+sOHFGN0rS9gs5TceiMReHZGvnhgnU9nQvSAuCcD7Seg5BjK1/g8zzC/VozV9piQ==
X-Received: by 2002:a05:600c:3556:b0:412:f05a:9fb3 with SMTP id i22-20020a05600c355600b00412f05a9fb3mr5888712wmq.9.1710160047780;
        Mon, 11 Mar 2024 05:27:27 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c348d00b004132beb7e03sm2141290wmq.27.2024.03.11.05.27.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2024 05:27:27 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v2] bpf: hardcode BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()
Date: Mon, 11 Mar 2024 12:27:22 +0000
Message-Id: <20240311122722.86232-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some architectures like ARM64, PMD_SIZE can be really large in some
configurations. Like with CONFIG_ARM64_64K_PAGES=y the PMD_SIZE is
512MB.

Use 2MB * num_possible_nodes() as the size for allocations done through
the prog pack allocator. On most architectures, PMD_SIZE will be equal
to 2MB in case of 4KB pages and will be greater than 2MB for bigger page
sizes.

Fixes: ea2babac63d4 ("bpf: Simplify bpf_prog_pack_[size|mask]")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Closes: https://lore.kernel.org/all/7e216c88-77ee-47b8-becc-a0f780868d3c@sirena.org.uk/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403092219.dhgcuz2G-lkp@intel.com/
Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 kernel/bpf/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 134b7979f537..a8007f7f706d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -893,7 +893,12 @@ static LIST_HEAD(pack_list);
  * CONFIG_MMU=n. Use PAGE_SIZE in these cases.
  */
 #ifdef PMD_SIZE
-#define BPF_PROG_PACK_SIZE (PMD_SIZE * num_possible_nodes())
+/* PMD_SIZE is really big for some archs. It doesn't make sense to
+ * reserve too much memory in one allocation. Hardcode BPF_PROG_PACK_SIZE to
+ * 2MiB * num_possible_nodes(). On most architectures PMD_SIZE will be
+ * greater than or equal to 2MB.
+ */
+#define BPF_PROG_PACK_SIZE (SZ_2M * num_possible_nodes())
 #else
 #define BPF_PROG_PACK_SIZE PAGE_SIZE
 #endif
-- 
2.40.1


