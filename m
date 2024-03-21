Return-Path: <linux-kernel+bounces-110262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602DE885C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1396E1F243D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092F186622;
	Thu, 21 Mar 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTAqrAyE"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998408624B;
	Thu, 21 Mar 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035586; cv=none; b=U19SvsbDg0SyAuI5Vac5oxhMjE3ttcywYgUwYH+H3sWf+qKX+R/xyStNiW0yL74z0x7WhVv8tiiarHtqQcQPbyvwoFgb6ssSaMT8I3fWm66GckOPVe8i78cpKx/GU+NNS/7aR6+5rH1v+rRq6f1xqzxqUGmgl5XDqgz2tnDkKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035586; c=relaxed/simple;
	bh=zmAWQQMh7Czalgq6ff5HKbw7t4LUEUkl12QHvaq3bwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cnq4wZBspb7k5Wzx6CeeOLt5e05XQQJAX1C9dkWCSWUO/x4crHRrSibnjw96JztFs8X1AZcoTbXkf35WBwJPoHGr53i6mra0M0mbSqxsEUzbk6G0nEIrovOrXU2OradwWSaKKUdfR1ofSFVuYKJnd/wqEnaFCknMrz04vhRitUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTAqrAyE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-414783a4a4eso1109175e9.0;
        Thu, 21 Mar 2024 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711035583; x=1711640383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6DTJ6OPuAKII4pcTJJo4yMQiS4Vgzpfa0hoNMISqtI=;
        b=UTAqrAyEeGqhTlfXpn/b5BOVrvT8KN11fdhAh0vSHSs18NWsKGkr/vx9sxs+byvr8n
         2K/2vCqGpjeKR/e9w3gkQY8SUw15TClcaj6ZdlhkaM1shXKPoJer1C4PYT2RVRAsl4D4
         QBz7kAGMQ0LUp17cKg8TqwG3uYejL1X9kXFzwO8D9Ob5TwZO1IZA1Sm3zGRsQ7pHDOSW
         2qMK+9FLRkey+unyug75j51HSKXVHUN9Y1Lmtb61YSo5DfoJ1JebQ2ZXQVg5CiXfekZ0
         Ssz3/0DgsrlU2NZlgVxoFwD3vi80hJY6rIjr7hKGykkfVnslIBA4ENA9E/nPmVCr4kar
         3agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035583; x=1711640383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6DTJ6OPuAKII4pcTJJo4yMQiS4Vgzpfa0hoNMISqtI=;
        b=KmkgtjGkmn098yw1K1/ttT3NCBNsQ9CaDSNJAqr/FRLky32T0HfZbr/1ro0LMuCz5H
         qKJQD1v7Fd9WHGDuA+Y1dLl+pxbiBB+/LySS89cSBEiqBHWQUa9LVQ1akS0Q7SMseR65
         MFAACTdxyQqgLz0mkHWrjl9ghroP4BzZALweV8ka9zwrByDkhfhBZEQCOAu98JbbrZQR
         u5pL8eYPN30GPMbEK87jjj93iFO0iLZ1UI47KNUMVoyZESsdCiqJU7OH2qXCF/U2kpcz
         QCt68Nx9RogOXd0Wk62VTs1Kc6VTzNhuZEqnjBoXxCHmsht4w9wvyZGSDPpdARNBTTln
         B/oA==
X-Forwarded-Encrypted: i=1; AJvYcCWNeQ6PHzV+XEfe1nSuHzNpJnYg9L7RMjOqqwLTgTheXudnj57b9IusyTMg5sud8DFrfEEf0zQdmFRmuyYydS/zGukSrYIjMc8IO5ME/0MeoGwK34exYMdd0Oz5pQDGvctE
X-Gm-Message-State: AOJu0YwMqQm9QRRepTgbL6I0CvFp2swqLSvy/+V2esZfebDZ1LzX4ZWS
	XthINNYO3+XETyNx/GAFkpgESUfDwJ8cL5a576NapQ852wT+VC8Ry300Q/FjRvsgyZt+
X-Google-Smtp-Source: AGHT+IEhiPIRmvJR0woMqs6zzhGV450+aT5ag5DR7RwlcSbyuGifL7x0RY5n309NWzEUpUZjOkEx3Q==
X-Received: by 2002:a05:600c:4fd5:b0:414:9d1:d67b with SMTP id o21-20020a05600c4fd500b0041409d1d67bmr3626570wmq.36.1711035582687;
        Thu, 21 Mar 2024 08:39:42 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b004101f27737asm5935444wmq.29.2024.03.21.08.39.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2024 08:39:42 -0700 (PDT)
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
Subject: [RESEND PATCH bpf] bpf: verifier: fix addr_space_cast from as(1) to as(0)
Date: Thu, 21 Mar 2024 15:39:39 +0000
Message-Id: <20240321153939.113996-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier currently converts addr_space_cast from as(1) to as(0) that
is: BPF_ALU64 | BPF_MOV | BPF_X with off=1 and imm=1
to
BPF_ALU | BPF_MOV | BPF_X with imm=1 (32-bit mov)

Because of this imm=1, the JITs that have bpf_jit_needs_zext() == true,
interpret the converted instruction as BPF_ZEXT_REG(DST) which is a
special form of mov32, used for doing explicit zero extension on dst.
These JITs will just zero extend the dst reg and will not move the src to
dst before the zext.

Fix do_misc_fixups() to set imm=0 when converting addr_space_cast to a
normal mov32.

The JITs that have bpf_jit_needs_zext() == true rely on the verifier to
emit zext instructions. Mark dst_reg as subreg when doing cast from
as(1) to as(0) so the verifier emits a zext instruction after the mov.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 kernel/bpf/verifier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de7813947981..ee796402ef60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14046,8 +14046,11 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				if (insn->imm) {
 					/* off == BPF_ADDR_SPACE_CAST */
 					mark_reg_unknown(env, regs, insn->dst_reg);
-					if (insn->imm == 1) /* cast from as(1) to as(0) */
+					if (insn->imm == 1) { /* cast from as(1) to as(0) */
 						dst_reg->type = PTR_TO_ARENA;
+						/* PTR_TO_ARENA is 32-bit */
+						dst_reg->subreg_def = env->insn_idx + 1;
+					}
 				} else if (insn->off == 0) {
 					/* case: R1 = R2
 					 * copy register state to dest reg
@@ -19606,8 +19609,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
 				/* convert to 32-bit mov that clears upper 32-bit */
 				insn->code = BPF_ALU | BPF_MOV | BPF_X;
-				/* clear off, so it's a normal 'wX = wY' from JIT pov */
+				/* clear off and imm, so it's a normal 'wX = wY' from JIT pov */
 				insn->off = 0;
+				insn->imm = 0;
 			} /* cast from as(0) to as(1) should be handled by JIT */
 			goto next_insn;
 		}
-- 
2.40.1


