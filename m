Return-Path: <linux-kernel+bounces-149318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD68A8F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7979E2830DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D313C3F9;
	Wed, 17 Apr 2024 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yC6nk6Zd"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C104176FD3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396974; cv=none; b=SgXFivEMRZ4nTqvLhPH2xN7xodNAMbni/VJuKOhJup9pADWcK91LUe4gXSm5BD5Uq5659DhUgHs3lnQF6QXtWLtGvpLg8d/asrrxcEg6g+H8TZdnZAFf5EsncwbSYv4HuEMQopGaBnX9lS0+y0K5V/Ik6CfgV7O7cxwnlVAB0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396974; c=relaxed/simple;
	bh=Gy+v3kHc6gUJFOVz0cecKLWhrUu0SiEkWzcElEXVN2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cYkoN5HnOZ0QRxY0sZTtCEVAvSIL7HR3X06I6c5M32DZRZF3s0dziW3xwQHEMNIwt4DwbWg1uqM3Ebq8GSlW/mKAa4gJu+HCInUU21adPoFoVTFVxJC9SEjhEJWXDGPCzeGadzkGovw/3Fsp49d8VKUk8RbRAaPpcgLHH6vC9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yC6nk6Zd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45c577ca9so824266276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713396970; x=1714001770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs92mryat0OzgsnGDmpmqjunv7BtT58JcaK8X9mxrOg=;
        b=yC6nk6Zd3WcMYzL6BE7wfY5N2nO70MIxTp0qTwezhzjc98+/K2D3s7Y5FKdaIDjG9l
         YW37oVlf4klsdOaf4YF5+PVBnEYdLvlQnYcTKX+1IVcHnuwbSmMoWRiIwDCe4xtMDoL9
         sJHJ38IBY2uLwtGtXtZzj88xQBqY7Rj4tduJflbpxT+Jed4xtirWTDNlcyp6DKjsDLfG
         A2lES1+5OCo2yVJ4f1pTfXIRDJrsSSU34BAqlpzWoFLS21Oy2dClCfbJ8iVq5qO+U6YJ
         9rBdSYwGdK2OaE8VZNQxKAIwr2dmvAYfZJemOTpuuvrLJi7CL1BDkm0L9IK6cfCsAygD
         a57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713396970; x=1714001770;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs92mryat0OzgsnGDmpmqjunv7BtT58JcaK8X9mxrOg=;
        b=vgXJc0vdh8u3Pga9nQxIi5kKiGvjp1mKjWMIKccLCGNIXCil4nIdpwSB+3tzWhTyj1
         VWEZrFa1pl5mj41O7TNB4Aae1txNpj8r6z/WQ9OVlqmQjJoxkHJAennPvw7WqXbg1BsS
         nwRUjWHHvBRTuvFrIeV5X7F7QXA/zu9NZ+HarzZsyveAiv+Bw+3Hzk6uhwVZ/yLxGi1N
         ry5kE2Ak4CTp903N+8QHyCT662T026NF/rkRk944/St/t4PVM2KWF/vgKOvGJnQzAj+E
         UvQpKuO9AGxa4QGgZ8CAXIeGYq8HX7eLQq/UHaUYgQeTDdeADdMCA4d1mZVN1ivrKOwG
         BMYw==
X-Forwarded-Encrypted: i=1; AJvYcCVxfv2RZYpeJ4eqhMEOFOCb9zuVYwHrkMv84JmeLCuxGMNFFstlFzP3puvZ/DChfMjwcoT68XEDkynJuu7IB3CSmtmsmPU7zT+VPL6g
X-Gm-Message-State: AOJu0YwhRN6E788hZsqmfWZ0bsoK1CazsN43UlJiDQiBplu9EmcxrkMK
	X76IlIan4VDmXBeZs19XiytGlOJZYNAuEkNpECXJlFQQUZZkdXL6Zjk/jXovlzcGRtwUiV0/XgL
	nDg==
X-Google-Smtp-Source: AGHT+IHEhF7lDtoLx34mV+jWNMhTS0HLGFkeJKmUJfFO1OhU3vwakHQ1bDQ0bBfedBtzlbUtNTylxJhjpPg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1883:b0:dd9:2782:d1c6 with SMTP id
 cj3-20020a056902188300b00dd92782d1c6mr173619ybb.1.1713396970482; Wed, 17 Apr
 2024 16:36:10 -0700 (PDT)
Date: Wed, 17 Apr 2024 23:35:06 +0000
In-Reply-To: <20240417233517.3044316-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240417233517.3044316-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240417233517.3044316-5-edliaw@google.com>
Subject: [PATCH 5.15.y 4/5] bpf: Fix out of bounds access for ringbuf helpers
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tr3e.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"

From: Daniel Borkmann <daniel@iogearbox.net>

Both bpf_ringbuf_submit() and bpf_ringbuf_discard() have ARG_PTR_TO_ALLOC_MEM
in their bpf_func_proto definition as their first argument. They both expect
the result from a prior bpf_ringbuf_reserve() call which has a return type of
RET_PTR_TO_ALLOC_MEM_OR_NULL.

Meaning, after a NULL check in the code, the verifier will promote the register
type in the non-NULL branch to a PTR_TO_MEM and in the NULL branch to a known
zero scalar. Generally, pointer arithmetic on PTR_TO_MEM is allowed, so the
latter could have an offset.

The ARG_PTR_TO_ALLOC_MEM expects a PTR_TO_MEM register type. However, the non-
zero result from bpf_ringbuf_reserve() must be fed into either bpf_ringbuf_submit()
or bpf_ringbuf_discard() but with the original offset given it will then read
out the struct bpf_ringbuf_hdr mapping.

The verifier missed to enforce a zero offset, so that out of bounds access
can be triggered which could be used to escalate privileges if unprivileged
BPF was enabled (disabled by default in kernel).

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: <tr3e.wang@gmail.com> (SecCoder Security Lab)
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit 64620e0a1e712a778095bd35cbb277dc2259281f)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 14813fbebc9f..3dfc45ed428a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5153,9 +5153,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case PTR_TO_STACK:
+		/* Some of the argument types nevertheless require a
+		 * zero register offset.
+		 */
+		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
+			goto force_off_check;
 		break;
 	/* All the rest must be rejected: */
 	default:
+force_off_check:
 		err = __check_ptr_off_reg(env, reg, regno,
 					  type == PTR_TO_BTF_ID);
 		if (err < 0)
-- 
2.44.0.769.g3c40516874-goog


