Return-Path: <linux-kernel+bounces-124345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A242891606
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8564A1C235B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730DC85922;
	Fri, 29 Mar 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAUUEsHo"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E1823D9;
	Fri, 29 Mar 2024 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704503; cv=none; b=V4wuiCd+mIozBcpRc4104MeFG91mw9u9kxTLLkKwdUj78bLKvZum4G3sXeueWimfYxV01b8g8uaNyta3HYqbZXeNy9U9bkLVwiHQj5YHDc5cFBMZw+zaVa2jPk4Vt7YTOWiybaQsdQxH+8NeOKfDpIac74e5QSJ195vBaDeONIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704503; c=relaxed/simple;
	bh=SHFdYTplvlOn+ggiMzH/HZZS8PzXy1ho54FtpQJcLFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7J7n9uwHw9AW42vdXXjaa95cP8o5tbnKyzy8YuEAyOblyEo0qdYaqDO3iYLm2Ks4zvxIadOttI1VGFmeFAVrgO/vl8PZesUpPnkv8Zv8T6HMzkqf4L0Ex1gayiJFsXrUxtrwQFlP9tcZRu1rDj+NUMW3H+bCKlWHgjKIi71W94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAUUEsHo; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d700beb60bso33890131fa.1;
        Fri, 29 Mar 2024 02:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711704499; x=1712309299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=066JbWD6+sdeM8NUEow4XI6o/PIAb6Ac0ifLv3nJ9F8=;
        b=CAUUEsHon4rYsygy+KY+mdr9LtfJHgfVNHJCFicPwQxq0O7G63v9fQGYSkr137QlLG
         kuAPh+F6PnI6m/94HjaTgkmUXrGjY8TYHOtx+52MKVI/2UdFxGZLzpIwfWs5EikATc6R
         6vUVZB18OvrGKQFGQZcBq6jN9OoSYQXb5NxyTJyRSeAv+CMZjP43lYrR5CsKcVaCUnk8
         YLSMmrs6b/6pVIJZ7PXVWvPm+uNhJTzX66/kcU+oBRoONEjxoxR+/KGmYCrUYRsCcRxo
         jf74gAAOpSvjUivG9zd6wc5tsDIP2Ohd7HTYwYl7+lrsQi3Yi5QjFNmNNO8YE5UmzTr2
         MGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704499; x=1712309299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=066JbWD6+sdeM8NUEow4XI6o/PIAb6Ac0ifLv3nJ9F8=;
        b=nGGkwx4hRmCocx4Co/LNYgTwMkAYn9Nz+Y3/oJvXbLx94BjrZohzJuP3MOB7u3t1Ef
         59DcHbUWq+HP4e3YXpN4Yp3CD2LGn8db4AqmhPJIWdZ4omO5DxXmdH70A2keKbAp83ef
         nF+3TT5SBeCXrn6N69gtgAf3dHk/sX6mKH8UZaB4g8WFt02dwENlrxfa26Aj3D3QIPQR
         YDwYWjwxyROFgq13+hg8wVcvy7D6TBuINCuaRkx1RX8OnykJ0hinAOGDUJctdBWkrM7s
         NGeDIS/f9hlwaeQyxBg8JJImXZt3UsrOAh8Uqr4ZvDQxtzslj7KWDUaA2aVrzelU/aiO
         TMRg==
X-Forwarded-Encrypted: i=1; AJvYcCVKl1+CySu2yS8fv4+LF0d/17UAh0FjGo01ryD+3mwQx9FoMxoMOo2GVNvqsJHDk8Z6A8P1iSmM0fgbK9qWyQ4RLHSVJ37oWQLdWDn5
X-Gm-Message-State: AOJu0YwEZk7UQZz+0EWx1GG3V95k6hExkbSLxxpzFXJ0Ns4eOKoFeYg2
	/BqL1pWv1PKE1s+WPdyQjsA80BxPC/YQqSBp2A0LEHM1bNyuh4+jty3asB5/5J0=
X-Google-Smtp-Source: AGHT+IExo88sD1Ktl8GpwspwucY0XOL5dUgi85yDVTbfTXiKdQAclrTQKjIeWxCOiwra/nqNxYhoaA==
X-Received: by 2002:a2e:a0d3:0:b0:2d4:8d75:7a64 with SMTP id f19-20020a2ea0d3000000b002d48d757a64mr1207885ljm.13.1711704498858;
        Fri, 29 Mar 2024 02:28:18 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id jx24-20020a170906ca5800b00a47152e6d10sm1700975ejb.134.2024.03.29.02.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:28:18 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: bpf@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 1/2] x86/bpf: Fix IP after emitting call depth accounting
Date: Fri, 29 Mar 2024 10:25:07 +0100
Message-ID: <20240329092723.17435-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329092723.17435-1-ubizjak@gmail.com>
References: <20240329092723.17435-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

Adjust the IP passed to `emit_patch` so it calculates the correct offset
for the CALL instruction if `x86_call_depth_emit_accounting` emits code.
Otherwise we will skip some instructions and most likely crash.

Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
Link: https://lore.kernel.org/lkml/20230105214922.250473-1-joanbrugueram@gmail.com/
Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a7ba8e178645..09f7dc9d4d65 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -479,9 +479,10 @@ static int emit_call(u8 **pprog, void *func, void *ip)
 
 static int emit_rsb_call(u8 **pprog, void *func, void *ip)
 {
+	void *adjusted_ip;
 	OPTIMIZER_HIDE_VAR(func);
-	x86_call_depth_emit_accounting(pprog, func);
-	return emit_patch(pprog, func, ip, 0xE8);
+	adjusted_ip = ip + x86_call_depth_emit_accounting(pprog, func);
+	return emit_patch(pprog, func, adjusted_ip, 0xE8);
 }
 
 static int emit_jump(u8 **pprog, void *func, void *ip)
-- 
2.44.0


