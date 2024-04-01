Return-Path: <linux-kernel+bounces-126967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589DF894517
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9011C216C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2868C535C4;
	Mon,  1 Apr 2024 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYks+45T"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E917552;
	Mon,  1 Apr 2024 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997920; cv=none; b=pysj8pQ71c002KMVH/RqGM4XbuCvk/Kw+aUEN/NogGa9nxQ/UUpNrpvqOEh6tgIgyjrJLSoVSic8Bm7RomzfBSzU02aqZeJX55Lr9a4uykk49qEF0j25hmll1I2jR6BWNniKIZRjDRYfBtuxS6TuhcEtBdSI7zjIlHNyi8xTGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997920; c=relaxed/simple;
	bh=DN0KOMHcZ1or7S2QQF5oxSbhQx21xfdAIAZXtf6YLHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Knp/PepdOo9ACEBAC6cLGRIiBk4oM5q2y/bv5SCT3fvq12DrekIGuT1+KxGAeX853A647/xVy2VMmxLrBq5HzPiaY49GzCDZvLag192/mq7ShkQyaqDCZgCrSubO/WZweZXVDEYMunVTxH17TEEhT3rBg4VRtZMKl7zb4I+ogrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYks+45T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4155baa696eso11727475e9.2;
        Mon, 01 Apr 2024 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711997917; x=1712602717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWhMYh6uZqhi4yxfcWPavYH5BRlfqBi73rcJeXnIbfA=;
        b=cYks+45TAQfh2jhPVN8wMvTzP/zoNAgG1gszodrNRSdgrZitJqx4WBykmnI5SnErNX
         +/JWRR1w6XQ8nFOLE1XSSwz1rI5wA4cZzk3fGsdm5DhoQxduwxrVxqqnaaCYSEa+fn3a
         fSWxCOLkx+JBtwTgt1vhpMnywcljkQEcX5rgOTA+e+lfrsR0QPzYvdBlOI2fFwAvGu8k
         dbFl6dcUYbvjzwaeNy9RjNjeqhQ3HS9hSqDZnHvQVcPfjOUe0qSIhgIB8PElA80xFz9T
         awBOYU58oXYYbKTQEqxTtfQnvobc0l5bkeAzq4IknNkDEl1/lC/fayjhAEfyvkR6dEud
         z4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711997917; x=1712602717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWhMYh6uZqhi4yxfcWPavYH5BRlfqBi73rcJeXnIbfA=;
        b=DKJL6O9QrakWitVi1xXtfuuetHHS9g6oh6KSS8BQlEA/QgRgq5Hc1M5XHeb6R3NuAK
         j3CXOtQQmiVuyCzfzkPkb4nut4/auTOOsYt2wPXXhDxIMz4ykpfzYcQX2dVejliLD/Ar
         UJujElfcKpejgNpwZwtdfkLI8LlaP7OaPfdtny0iY5K9P+/E7R+yHb2AbSGKjYPNPljS
         Z4M4AqLrjOydSio7h4SMLfceK3OzPxDtM39O/AmlQTBzAzScFIuF/xoY7+x5tpMm41l9
         eUBBzZb7LOC7aA+XTxrSLTXj48X6NMb19zAh4MIENC8QWNhzzJX4LmCklwObU0IuOzms
         2HvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHW+ltjvsP5Z6g9apzUxgPEZXlfY7g6R2HJKPlaJ2NE1hg/bTFdQq4RZiya+yZn6LAqNJbLdxmx3oQ3G/PYRTwGS11HH4MWsW3wYXfmk1LGwC694wXjLKsY7vNLqJPt0dUSYlAyhXBn1Z524yBmYRu3S9khZHPGWoh
X-Gm-Message-State: AOJu0YzaGlq6SNG7I/3ZWumhcrVrN4Jk6YGaLnTbL2Y2E1iNmiDRLGpq
	1Sx2x/MZdVqyvjjfTAz8Qo4lFQx05OubCQOOBGxLfp9caUtjyePO
X-Google-Smtp-Source: AGHT+IH8GFovz8ZlOS7P3ULNt0nHIWY26BOBLVKhMlG6lwjX/Cm2xJSdIFPOCtzvDtnS1X4Gsp7ZZQ==
X-Received: by 2002:a05:600c:927:b0:414:669b:aa9 with SMTP id m39-20020a05600c092700b00414669b0aa9mr6524644wmp.28.1711997917076;
        Mon, 01 Apr 2024 11:58:37 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041552dbc539sm10950986wmk.11.2024.04.01.11.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 11:58:36 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	=?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RESEND bpf v2 1/2] x86/bpf: Fix IP after emitting call depth accounting
Date: Mon,  1 Apr 2024 20:55:29 +0200
Message-ID: <20240401185821.224068-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240401185821.224068-1-ubizjak@gmail.com>
References: <20240401185821.224068-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adjust the IP passed to `emit_patch` so it calculates the correct offset
for the CALL instruction if `x86_call_depth_emit_accounting` emits code.
Otherwise we will skip some instructions and most likely crash.

Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
Link: https://lore.kernel.org/lkml/20230105214922.250473-1-joanbrugueram@gmail.com/
Co-developed-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
v2: Simplify calculation of "ip".
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a7ba8e178645..e55745f512e1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -480,7 +480,7 @@ static int emit_call(u8 **pprog, void *func, void *ip)
 static int emit_rsb_call(u8 **pprog, void *func, void *ip)
 {
 	OPTIMIZER_HIDE_VAR(func);
-	x86_call_depth_emit_accounting(pprog, func);
+	ip += x86_call_depth_emit_accounting(pprog, func);
 	return emit_patch(pprog, func, ip, 0xE8);
 }
 
-- 
2.42.0


