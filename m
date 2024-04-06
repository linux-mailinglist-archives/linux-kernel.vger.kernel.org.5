Return-Path: <linux-kernel+bounces-133874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0235489AA2C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE0BB239A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99344CE08;
	Sat,  6 Apr 2024 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lB2l4Ywu"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502D3FBA5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395238; cv=none; b=X6flFC5WAr9i3OswDgzdKK4TNM5bvU462MNd0//ibKsvfiuWVoeMbWJVqeCSg/UC1SHUgN9EdF+vH5Wcg4ucTVKlMAPrmuXm4yx1eZbzf7A3qy276BcqCZkPqc0woqjoWYnRKzRovwFwN72NhAHUrKq/2R0y0SDAfFAbEIRgUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395238; c=relaxed/simple;
	bh=V866d7v0EUjhFe+hV0qrTNaTJ3Gb92BOJZHI+Gz3L24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPM8zzPQj0i4bpguCtlbpeYlCQDT/S8I5ON4/hXPhJm33BqXxBjSoVHHY4GpSBmRh1G1RcBOl/xM8ENcKmmnjjmWXnMI+rPNXhaQ8BhqKrYzwwRUnGrdUxzVdxo2z20NovUlovz6FKvYl9UIcX3jKktrmDp3skBbSoLLGTH6kJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lB2l4Ywu; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E20F73FB79
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395225;
	bh=qzaONF2ufkMLEwxVO924M3LwWzApnPaibbBgBkLZGxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=lB2l4YwunUmf2+jdL5QZxL41cjtSDwXWT5tyAkjETaS2mqoFUw64VqBO38dZlClyM
	 3qTgiQkszAevQm6LYhm/Xt/oWFxGhj0slblNBezlrx+jOBXquWkY9hQ2KYYLGYjz0p
	 wFPzndEPnlNINkfaIEuOR/nRjOQNKRYysVgpJo4EdiQgub9ET8NEVnSI6JiI8a74oP
	 xx6ESaa3TmLuwMoPDiiQQFDxVQWn20fAs/y6csbQt+eTAa9IFOU6O6Hheza4DUJahT
	 VVnLmJiNGvh+mnrq8C8Jy18XK8/cGu0JPi9XITL4rwOLdWB8coHbMEQC48cYLJbcfN
	 yGB3h7ZJVz1hg==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-516ddd6d66fso140389e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 02:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395219; x=1713000019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzaONF2ufkMLEwxVO924M3LwWzApnPaibbBgBkLZGxs=;
        b=IJMcSpm9AxLBLXTVOOiynHaFlHdLh2d2H+r5GKSfsiXqOc2DD/M/xmwQYmWinuCHii
         fHizmEjCUJwhXGCqGaSxSFgRuOESoVPB4EFrOiuHJaGSCFkZhhD/QzF5iqaqtbV98Zy0
         6nYRQ+h4RzroOsTVaiPr2jnhVrhZONULJEN/w+A+61kyJTccIuMd3Optfy+RzW4r0sVX
         wF7D0KDzNNvubMNE/6XxIE4Ei8Iysjjag3MKTKrQX2RCete0WVplVS0zl3aSg9RL//n7
         BDydtssSoVR17Uy2/N6FZRXEUPwA4MNsunUps9ztBiXTnsg3cTqKV0FNM9VUzekA8+77
         NACg==
X-Forwarded-Encrypted: i=1; AJvYcCXsuNO3MN4fT0jCtK7GbfWvxKEm5MyQ9mi9AkY6DBSqoPuFPofv9Z+eWP8etWEsmNo04QnuvrsfZJ4xqiGLhfJCllBjj8KQ2ysviKKz
X-Gm-Message-State: AOJu0YxeWz1+z5n53AS5otUnuICZfthxcTFkkPpBniTa/LCkYOAQ4Fxn
	FU3u52e0gITEFWGUVuSU5XQ3HG6FIy5DBpy/W2ZVwH3EeArVkBPEiT7wM5/wRjupYuSHx035LPM
	/U66ipn/gx/3Yz/D18cPR2Rgv7ewMksiyGtYhDvEuEvEU5iKC8malxnI6HEAeIbIL0P9du4JKFI
	tRWg==
X-Received: by 2002:ac2:528f:0:b0:516:ace0:9a75 with SMTP id q15-20020ac2528f000000b00516ace09a75mr2341483lfm.23.1712395219275;
        Sat, 06 Apr 2024 02:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZAyOXnlJzHnF6UAxzVX17DxYL4mhxCDf8C91bLhJCKP1I0WnSc9EcZ/D+EvzXCHwk6NrkuA==
X-Received: by 2002:ac2:528f:0:b0:516:ace0:9a75 with SMTP id q15-20020ac2528f000000b00516ace09a75mr2341471lfm.23.1712395218819;
        Sat, 06 Apr 2024 02:20:18 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:18 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] selftests/bpf: Add tests for ring__consume_n and ring_buffer__consume_n
Date: Sat,  6 Apr 2024 11:15:44 +0200
Message-ID: <20240406092005.92399-5-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406092005.92399-1-andrea.righi@canonical.com>
References: <20240406092005.92399-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for new API ring__consume_n() and ring_buffer__consume_n().

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 48c5695b7abf..33aba7684ab9 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -304,10 +304,18 @@ static void ringbuf_subtest(void)
 	err = ring_buffer__consume(ringbuf);
 	CHECK(err < 0, "rb_consume", "failed: %d\b", err);
 
+	/* try to consume up to one item */
+	err = ring_buffer__consume_n(ringbuf, 1);
+	CHECK(err < 0 || err > 1, "rb_consume_n", "failed: %d\b", err);
+
 	/* also consume using ring__consume to make sure it works the same */
 	err = ring__consume(ring);
 	ASSERT_GE(err, 0, "ring_consume");
 
+	/* try to consume up to one item */
+	err = ring__consume_n(ring, 1);
+	CHECK(err < 0 || err > 1, "ring_consume_n", "failed: %d\b", err);
+
 	/* 3 rounds, 2 samples each */
 	cnt = atomic_xchg(&sample_cnt, 0);
 	CHECK(cnt != 6, "cnt", "exp %d samples, got %d\n", 6, cnt);
-- 
2.43.0


