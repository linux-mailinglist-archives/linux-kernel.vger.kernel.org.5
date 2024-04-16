Return-Path: <linux-kernel+bounces-146660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0085C8A68E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246681C20D93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D621292C8;
	Tue, 16 Apr 2024 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMO1aXNq"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F9128376
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264327; cv=none; b=ToXBYpv9+eT6FNEZ9zFN+R5AmirJrgw9jDwmoskPLKSz3ncNjrowoeLCR6hFuvS4mZP7kdUrzEoqM4h+BuyLPwDv0sgX6Tkepxfa/2MZ5TVFlAVMoaWw3zOQU3JZ1dTK4Y1M7AI+CnXmtd+dR25a3tGjyrLYW9cQ7dy35fg8lQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264327; c=relaxed/simple;
	bh=/6p73t1vQBs60bTu8b+1GCgEu36ZH+1LONSsLqShnFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqV0h37zWkvuwr+AXuDjpw3fu1IzN4wwv+GaEuIUL23toS67E7hzn75xeccDu1FFZym197soG2h1S9V0C4DcnW04c800fDsUhUXJWEEWuR/a5VG8G8I/zQQcAYbW89FUnDyvNMDJM3w/wpzzER+lKcTk5/MJJOGhPCG4pOso/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MMO1aXNq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343d7ff2350so3051351f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713264324; x=1713869124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0169n4vHsrlup9ubNFunAJmhMk888VjX3f7O4lXGgA=;
        b=MMO1aXNqlEDvIjLeGtewsFhLXn9NtgvtuLHRoVNKrIatofoTd1+cHmUXIOXq+vCpnB
         RTF74sYP/Bol0HIu6+EFR0GV0qvDMGKsu/6gZl3OuaXpEkolf5VVk5xT4yMJjPtIpFly
         Yx9M+HPA/qY3SJmqXzGKO5Uy8X0n/OM89qG55YZeY/qdohDeCK0zZVb8A4zc15JXm9lQ
         XMpfPzb0d7qeBy31ZS4jt0dlqBWFm9xUOdWM47hrGZso++rEmHg2dwEXAJnjMPL47uFC
         7Y9SJgTh0o0B+4iW2DNKMEAj7x2wqLeoMQD/qfwaN4ODWcE3TimQ3/FMppCKIAzESVhy
         ZHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264324; x=1713869124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0169n4vHsrlup9ubNFunAJmhMk888VjX3f7O4lXGgA=;
        b=QNY/CXM2cYVmGwB3kxbOo/Uh2w7nyZwXh7b5LxDfp7ppn3OE3eU2M4Kj8i/GI92u5Q
         Dji3iyeUQIa4iO17woCUAoLTtptOh2TfuhoTuXnW+SYRM6il9mq2Wucq3i/HznzijGOZ
         WrEOgpQCpmTX+eESnpJfpAoL1WyGhuUXA6YDLaZl/TC4UIB1yrMb86maWXE1qFB+xYEe
         F8o+VAF9vx/DtO3PI/EbGagZEG3vHnV0fHXrm7LGxw95pBhxL6/8ll6Xv4XGbqIbaGhg
         lAhQJqCjiQSiCQWnzyZvxh4GO+oRmOHqKy3Vj8Gl/xriMnPjbkiHbJj7ZSPFfpC6Dl8d
         Udhg==
X-Forwarded-Encrypted: i=1; AJvYcCX00LUMGALuK8UIcljCYXUhPVbhAU5qSH0WCrSjGXErguEizjc9lKoXvqlr3Sr9UqqJeo9i5EUczdz6+PuoBrBpvcywudNOtyZBE788
X-Gm-Message-State: AOJu0YxFu6xNuLlx5739HQfCsrS4NBORywj6e9rye/89HWk5GapHFN8g
	FbluLzLk3mv82m8RoVupI8ktyEuzHVB1vVflSeVD/Kf/GljTRbyxkzVnK4pxwK4=
X-Google-Smtp-Source: AGHT+IGuOwdGbie/pxpSPz94XUUg9zfb//N0KACafx0VLdOJav+40VrZnhnexV6h1XjRB6n5HJzmOQ==
X-Received: by 2002:a5d:558a:0:b0:348:1fde:180d with SMTP id i10-20020a5d558a000000b003481fde180dmr1439589wrv.15.1713264324163;
        Tue, 16 Apr 2024 03:45:24 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6709000000b00343956e8852sm14470141wru.42.2024.04.16.03.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:45:22 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 16 Apr 2024 11:43:19 +0100
Subject: [PATCH 2/7] kdb: Use format-strings rather than '\0' injection in
 kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-kgdb_read_refactor-v1-2-b18c2d01076d@linaro.org>
References: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
In-Reply-To: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=/6p73t1vQBs60bTu8b+1GCgEu36ZH+1LONSsLqShnFQ=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmHlZrYDalepy0FpLWeF0EGeYOYWieNEdAFaX2U
 vqR3b0WOtOJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZh5WawAKCRB84yVdOfeI
 oUdND/0XUCjVwdM1VAk8s8wd/ywUnsHM53bbyB1U303aMdO3jiiQozqSV5yJ8dYsdA1ivsDvraC
 0ZGT4+QG15h+MvIfHSrRcQRd0dqi5rFnYZd2Rs0V0gSqZznS4Geqmg290iJRqqVfN906SZvgPyB
 7fDi3kg0RSgLM4/+GL6xgWn8GWaEiInEqljjhsZYsGQ3FnaTvyusQGdZPIyh5ZlU/zJ5iJOXIZ2
 G0Ckc1zvyy/+VIjuEYRNLSEDQJwqgfR3rI+7O3Veyos/5kQmJxz8ozXtgQ8nUWN0xIjYyFKbISM
 SctlwDlp0nYyqgVQP9ZO9kC1Vg4AOmYRUdmVye4OEIrjj2gE7bB06y5tWCPe1gj/ioMlE7n6KOU
 2mtmVb4KWEjeP4bij98eIoONCzDc3VLpsBC9E29SU+r+hjRdT6A44vSyfG2o5LG5LNn/tEjw/W1
 zdjw20kp5v5bbL/HYehx5ef+GTldZlp7FcZ0ySasBrUYHDxDBCJgae3y+YD/RO67DVEMbE1s664
 7dE5ToQQOyNlitD6E4/la2UA8BNzWLu5O9v7dpFBhYTQtMbLWPgteLNORNUEyKetqSnncI8jPiB
 2cAvuOyyUMSJ7p/gBjHUivzNJPud8/IVX+Pm0eluGhHa29mNrF/ygc2bX6FlRqffn5o9TlgsiKf
 462jIxIKGp5gONQ==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently when kdb_read() needs to reposition the cursor it uses copy and
paste code that works by injecting an '\0' at the cursor position before
delivering a carriage-return and reprinting the line (which stops at the
'\0').

Tidy up the code by hoisting the copy and paste code into an appropriately
named function. Additionally let's replace the '\0' injection with a
proper field width parameter so that the string will be abridged during
formatting instead.

Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug fixes
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 06dfbccb10336..a42607e4d1aba 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -184,6 +184,13 @@ char kdb_getchar(void)
 	unreachable();
 }
 
+static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
+{
+	kdb_printf("\r%s", kdb_prompt_str);
+	if (cp > buffer)
+		kdb_printf("%.*s", (int)(cp - buffer), buffer);
+}
+
 /*
  * kdb_read
  *
@@ -249,12 +256,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			}
 			*(--lastchar) = '\0';
 			--cp;
-			kdb_printf("\b%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("\b%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 10: /* linefeed */
@@ -272,19 +275,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			memcpy(tmpbuffer, cp+1, lastchar - cp - 1);
 			memcpy(cp, tmpbuffer, lastchar - cp - 1);
 			*(--lastchar) = '\0';
-			kdb_printf("%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 1: /* Home */
 		if (cp > buffer) {
-			kdb_printf("\r");
-			kdb_printf(kdb_prompt_str);
 			cp = buffer;
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 5: /* End */
@@ -390,13 +388,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				memcpy(cp+1, tmpbuffer, lastchar - cp);
 				*++lastchar = '\0';
 				*cp = key;
-				kdb_printf("%s\r", cp);
+				kdb_printf("%s", cp);
 				++cp;
-				tmp = *cp;
-				*cp = '\0';
-				kdb_printf(kdb_prompt_str);
-				kdb_printf("%s", buffer);
-				*cp = tmp;
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 			} else {
 				*++lastchar = '\0';
 				*cp++ = key;

-- 
2.43.0


