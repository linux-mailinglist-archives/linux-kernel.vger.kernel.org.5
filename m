Return-Path: <linux-kernel+bounces-96974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32D8763FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BB0B21B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F965675B;
	Fri,  8 Mar 2024 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cgv0mAg3"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA656444;
	Fri,  8 Mar 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899651; cv=none; b=Dl/ijSDxityaQrwJYc644h/gr5YVHhNE0PTuJEL6l345ASzB53KpJPkhCuxd8e0JRl3E2DyGhAaO9+YuB4OZCwIWz4Z+PGaMw8tUX4DKHQ0L+F7QZUi18mkPzNiK4+4UnPZrU2XUSsLb7Zmd0ezYPO/a90fSGQVhmOoeXz1c4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899651; c=relaxed/simple;
	bh=xpgMoZKks9BX+yecW9htcqCKyTMNBB0o2ne0EdbkE/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O13bVdE+tmkpR+cQDYOrlJxmVkC+4EN4SrysTzggrAN1ptFF4e6Pfb99tJuCHEmLvrQz3VrnDbDNCKmV4TPkNl4czrnOzaDIXx/MdJ4ENGAmW4ikkBroQ8Cpf6J7o28sg0IoW83sSyTWoHBYyyQDK0zSEmlW5Kv7i0nMA0lamlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cgv0mAg3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33e2248948bso1285658f8f.0;
        Fri, 08 Mar 2024 04:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709899648; x=1710504448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJ1KNA3ECIGK6xtavH6nbPGIymjpc0HF4am1jvZwZlA=;
        b=Cgv0mAg3MJeTFRGnDVaJewgI//5c0j44A9JS9B5taTmEC1Uu0iNFQgx25UO+FS7qfe
         UKRrzfVXOoKHmT/erWzrR5GVceaPV1BJwr4L86TInU43ZwtKswaK05naC4WB1jOvmLPW
         tDoB29ArlNmYJopAvS2W7Q0RsEiPFLWvFMqPhFSXAf+cihw12m7Jfnqs7pSuA9Nyd2NH
         zspERffsMTgY2VHRBzjWZ7EqPPdYAVlsAnqF/auRBce3v7RLPj3UcpqBNLm26MqI/cRb
         on9Hbn3KoXCX4joLIQAtE2CCE16Gaie/2OsMdtNQApcep6qBxFotrMu1ba8gDMeqEIYr
         k+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709899648; x=1710504448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJ1KNA3ECIGK6xtavH6nbPGIymjpc0HF4am1jvZwZlA=;
        b=Z6CU8GM331ry6i31reldYjRfoDAbHh3ul3ccNxpmlO8LRsRkeBQ+SgqrX8bxgsY7E/
         PkU7gmkpv+a59rNJ/qkrnQeQbMICsJFcYsXJlU4l1SUlC5FTV2L2B+sqjssIE1R6jOA5
         XyIcKKrN7ydDiFTZJZbMVYETlvY2xuG1E3gZuDTo+HS4Pb7c/PfG5fZ2awLgREwv9dGM
         YWitCMolUw7VOBvghf5+jyF/YIKFai6YJrtDHqKckvYVWmt0T26UvFlIuYum7LE+XSgY
         L9pGvrUJ2hQ23C4Ff06gZVBj/RkWNf7XhA/9q7kv2oUW7dUxONe8nbde8j58vyxV5nPt
         zcHA==
X-Forwarded-Encrypted: i=1; AJvYcCVDu8WZSNlxhkVzg5uJN6O9UwSdML7XXRaTTniApbvX86XJpw5B+faaX+0oN0BVXFibPbCI1XdghtL+wehZ4x2GOjJau0f6Kqzctf2nmiJjYunRIL31KFPeLmiqRM5VnxU3
X-Gm-Message-State: AOJu0YyArWxppgDnKw4ubL9Yi1Yeqw7P/qanu0pDNe2pWbDCDccFYGSW
	r+eBJ5D+6zOe7Xux/nKcQssijLpexpblZYId1skM7CB65mF50kk7
X-Google-Smtp-Source: AGHT+IEYmiZPNYb4tb5aFQEwdgg7/WvYPJsIJNgKu5Iem/TEUBVrAivU1wZ85SOt2jPziDMQcIyaxg==
X-Received: by 2002:adf:da48:0:b0:33e:1f94:7aa5 with SMTP id r8-20020adfda48000000b0033e1f947aa5mr15921901wrl.54.1709899647638;
        Fri, 08 Mar 2024 04:07:27 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id bs3-20020a056000070300b0033d4c3b0beesm23297364wrb.19.2024.03.08.04.07.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2024 04:07:26 -0800 (PST)
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
Subject: [PATCH bpf-next] bpf: cap BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()
Date: Fri,  8 Mar 2024 12:07:12 +0000
Message-Id: <20240308120712.88122-1-puranjay12@gmail.com>
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

Use 2MB * num_possible_nodes() as the upper limit for allocations done
through the prog pack allocator.

Fixes: ea2babac63d4 ("bpf: Simplify bpf_prog_pack_[size|mask]")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Closes: https://lore.kernel.org/all/7e216c88-77ee-47b8-becc-a0f780868d3c@sirena.org.uk/
Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 kernel/bpf/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 134b7979f537..83a3b6964e54 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -893,8 +893,17 @@ static LIST_HEAD(pack_list);
  * CONFIG_MMU=n. Use PAGE_SIZE in these cases.
  */
 #ifdef PMD_SIZE
+/*
+ * PMD_SIZE is really big for some archs. It doesn't make sense to
+ * reserve too much memory in one allocation. Cap BPF_PROG_PACK_SIZE to
+ * 2MiB * num_possible_nodes().
+ */
+#if PMD_SIZE <= (1 << 21)
 #define BPF_PROG_PACK_SIZE (PMD_SIZE * num_possible_nodes())
 #else
+#define BPF_PROG_PACK_SIZE ((1 << 21) * num_possible_nodes())
+#endif
+#else
 #define BPF_PROG_PACK_SIZE PAGE_SIZE
 #endif
 
-- 
2.40.1


