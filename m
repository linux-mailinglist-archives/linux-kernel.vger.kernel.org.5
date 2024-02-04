Return-Path: <linux-kernel+bounces-51742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D032848ECA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6681F21B78
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35022EE3;
	Sun,  4 Feb 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="G8GkPM4k"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACDC225CD;
	Sun,  4 Feb 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707059206; cv=none; b=JbjEmEMtGLboknCSOC8BfQy6Ke/Antn0wtiTd0c/RoIGrimLolVWCm9BqxI22Z3ynnjC194uMfgjG2eIW1Vn90CxgCDNp8+IB3FH8TiZW5u022/gZ9zcgbUSNYudUYlpalmTidCdCdbKO15F2xvCb/PzutM6Zm3B/cCVm38yWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707059206; c=relaxed/simple;
	bh=txiLzQ7wIQfEY0+jHKRkldSl4XQ1Jb2EK9W5T3yr/eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYAn/DCbOqm/UCuD38diKPDtTHxymF+VhDWMCAEGVF6xn0gPmvm28zvFyJE7FXkYDb5wiW9vRBUNi03Cg4uiuwtXwHi2iW5up0FMAQz7g0bh26FNuP2xTMZsWrbNj31R4aELxOHx9u19Mfzpcif/sL6VvL4+TFfm4x1+cgrQR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=G8GkPM4k reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3394932a12.0;
        Sun, 04 Feb 2024 07:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707059204; x=1707664004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3fWDt5Cz/GC++Vf8McF0DhkwQ/uDHEXb4KCp3AjvDc=;
        b=pdCKdjJquvdIFjXDoubWaPfgal1OPDKFfoY9Xv2AhHK9EU2Yfw+EZHKQGrS4f1MdyP
         Ab4brGeEUnwbGgWdSjMp9Fl41Emdl85dYoUV3ROAeo/mAScwR34LWi7sN7qdZllpNdM2
         46nbtPNkYTWPHrOKi1lJYmmYB9BYweyHcgl7BijEByS8EpnAswtSin9swRVoqqf0ZkpJ
         4+fvP+rk/rEQTJSYmqjkElXdCugofZ6k6j5wgdl7esdnnLRU79WUeH00yyw3ihPryt2J
         7LVjMa0FtO33KsdnfvjjK0sopwULesXzdldzOr4I4+A6Vc1J6hP5SFfG7SYn7X47SKwH
         toRQ==
X-Gm-Message-State: AOJu0Yx6ctV8E/aIjWjlVDroFjRppV5vaTNZJtG/8x9sFZt4F6BJ11gV
	Hjhm9BaSSFvkn8w5x/eocWQDxBo4tymJ7s5EwILvBBdMWVPuDcBi
X-Google-Smtp-Source: AGHT+IGbbWJlL+CqieIeCScZjNGNh6CFCP3WSw3E6VYmC6CJZ/zLylktpUBfEnYM2Uok4og8Y1hlGg==
X-Received: by 2002:a05:6a21:8114:b0:19e:4f18:b944 with SMTP id pc20-20020a056a21811400b0019e4f18b944mr2888806pzb.31.1707059203748;
        Sun, 04 Feb 2024 07:06:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVJMFN9/ov5iPZJ9zNEfh5a8NstQkpSyYHH+TB99VVl1Ewh34j6DTKs5oRQqg3fT7oZP7u98gQsfU1wVex5Q4WGFtRM60q6TMhOiBk8jELDJFXCLyRoejNKfcdEcgLl11YGwJzf2qGsVg==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id x27-20020a63485b000000b005d8e280c879sm5261553pgk.84.2024.02.04.07.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 07:06:43 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707059202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3fWDt5Cz/GC++Vf8McF0DhkwQ/uDHEXb4KCp3AjvDc=;
	b=G8GkPM4k4hM3+2GhDG7BHA0u0UYtl2yXgSJk+xMtUQQHi+KKmK1ee4PFv7IuD0Y677IJT2
	m2wPQLADYK/BmrOBN/PhGonLIq21PhcDFwEDiVZKnpaQ+nRGaZDzxT8Pw7IOuKAPCwYQbi
	VxrltmMX4NlBe8IXz/P9QvPAizDXescdnjYxQPgsvH2iMkg2lLKf4ymPeO3dYWYvo1guT6
	sfAP6YO1GydxUoCHXEvdzklodXsHupK+Up0Eu8Eh48G8XHb6mXBzrkDvi5L72NLIUpl+vL
	XpoHJzeTslFfpgOIam0k4Lx8zRiu5aEmy+3nKjOPeKGwy1FPJCJMsaDiIBWfqA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 12:06:57 -0300
Subject: [PATCH 1/2] mips: sgi-ip22: make gio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-mips-v1-1-05af5e9a7ead@marliere.net>
References: <20240204-bus_cleanup-mips-v1-0-05af5e9a7ead@marliere.net>
In-Reply-To: <20240204-bus_cleanup-mips-v1-0-05af5e9a7ead@marliere.net>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=txiLzQ7wIQfEY0+jHKRkldSl4XQ1Jb2EK9W5T3yr/eE=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv6gcjd4/T3By43GAoGT52YB/ZdUywJ4v0EB3H
 PctXvIS6aGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+oHAAKCRDJC4p8Y4ZY
 pgGPD/9lDXqx1VcjjbIpHnrQqx+HHUtLv8a17za+YokogmO2B0ZkdPc5+d/S0Oay/N3FTDqFXCU
 5jnOlKTJ+6G21q76bRlwGhFGWcGst/H6kPtMH4G9aXEYG/kWhWRqnH4Eeu7G0D5afN0ntbaSwXc
 67udEfncTqvNvoU6lHOhlFcH6THhqbLMaOQaylKE8Tru/UHBUAlkh5AuYov1RsrGFBEFnZ5h/lB
 gQ2g21nL3d+Fk5kCE09lhJX8smz8kWVawlmSsC9NgRYRU4l8gFRYs8oPA/JxefwHhK5L1Gzax2K
 H7V9b8QryCyGuy9yt10CQmwju5UaH1eFz/wyjcxH7EX92EwiT78iro/qzUqwbwWD+M2XWlLj7D2
 0V0dHooTMltivxLEpc0qN5LPPSE957m7AeW6mV0MSL/c/7xgXCsMYdLdUsG2a9qxgMjEA1OZ/pl
 x4IdmbrVMbobc5+6ssCw4TSeCdZMFPEh/uZEpf3baNF9XZQew2Lj1D/f3Tf8kzeDmHFTSu1A+zg
 eOYTO0wP50bZ73C+XfkSZACLDWC/RVjqDVcYugLulvg0iI4cia68m5UMrx9J1fe26djwseHd/Eq
 4LNxa5BCZ2SRKmv4Gr1FLhgG1rsCSzsfEjtduJsnZQBVeN6rpL7ajh3PqAuYs6hEBtL1BgYnZvw
 RnWZOtsYbNmt+jA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the gio_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/mips/sgi-ip22/ip22-gio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index 81c9f0a8880b..a3cdcb289941 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -12,7 +12,7 @@
 #include <asm/sgi/mc.h>
 #include <asm/sgi/ip22.h>
 
-static struct bus_type gio_bus_type;
+static const struct bus_type gio_bus_type;
 
 static struct {
 	const char *name;
@@ -378,7 +378,7 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
 		printk(KERN_INFO "GIO: slot %d : Empty\n", slotno);
 }
 
-static struct bus_type gio_bus_type = {
+static const struct bus_type gio_bus_type = {
 	.name	   = "gio",
 	.dev_groups = gio_dev_groups,
 	.match	   = gio_bus_match,

-- 
2.43.0


