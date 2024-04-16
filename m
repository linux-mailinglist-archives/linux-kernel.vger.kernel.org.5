Return-Path: <linux-kernel+bounces-146662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FEA8A68EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D9228B15C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A43E129E9C;
	Tue, 16 Apr 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYq3Y4u7"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0731129A71
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264331; cv=none; b=a3ckneAl1QOeAVP1lHeTLN08pwIrFrfge+oiuIELhR06p253NU30YHlYWkmokM/CUrXqzmw6I2hAuELlrEqEddPNLxdOQCMr1e5hnP8dDgJpdiskDHFRzqskiGfDULjEZyRJpjwelJGI0c18PxhjEY2p/nQocdcpHt7P/VeN1sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264331; c=relaxed/simple;
	bh=S4M9Ru+1w6mbv19P1LIu/epAWq5YDJmDyvRXYCK9Uq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbYr4DOOCMkyZJTFmTcvpS5aWt0V+7H20s6zeVRrN1I05Ueyfe2GNpw83d50/uO0JqOK//61FupOGK89u++xQ0CxsKbZ8DVhE2dbJ2HJvv8UDnv/xIUGSyba8EtIUcLhgfi/DnyeWX4IS5Fcy/ZJF+l1QX3Y0szzcLdlUG/D8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kYq3Y4u7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343e096965bso2806183f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713264328; x=1713869128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3zSnbElzKQHrnLI0Y5ncXpIrKp1Mj5wQa45HhWSlw8=;
        b=kYq3Y4u7d2i/zxZdCZoEF/Gl2tpBtMRo+iNI96JjuT2GdTMaHymZ+td4IjOp2ZDDs0
         aziEI7rq1xSbNGKK+hnhPAbMXJrEyEhtdhhtuLjdpyKLyfvDd1ojC3ZvpP/+gXDSjoaE
         5GqInhZIH5bIx6ETNJegd6dM5S3OCGTwjXUw3nH9ra1zvOUIvXQGb9sUncRS7+EOQYM3
         eMdLhgRHbxrjChU5qoc+NaqQ9jq/YwllmD6HBzNYafFbINmoJwmFk3UaKnuctCKBHtAO
         T5fYFqeYRr6boitD+kCnJ2pGbQshfAfr3l1YwMpsPZcSur+nHF4SUkKKOcb67PNPWG6+
         CMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264328; x=1713869128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3zSnbElzKQHrnLI0Y5ncXpIrKp1Mj5wQa45HhWSlw8=;
        b=Eqn+/ql1328F5iGVjF/gNNel7yX6O+0mwHcAy1e4NvBBKYW9cPtMZpNHmyFchVGlkn
         UECsmsWpKkpRFV70i3raRef2B9kcS5A5Z7sEByzIvwXVtF70+lpoUP020r9arOiiIp8t
         k6UpNObwjyM2FctpFqp8yo7kEf55d1+j+mWoRJG99Z1GyT2+rizkoYZt46cO8OqeX8fL
         Pl/wgjXQ8N5tCJHc+WXmaEY0rE4Il43+8SyLkjm69vn0/jdWiaqUuowQrUVmSOPhqrWA
         X8l2XyBEwO3OQeC5pmvx2tHB7CFsncfkQsEFr1mf+mKGNbobnKDdcyjmQsUjudDVe3XZ
         gFwg==
X-Forwarded-Encrypted: i=1; AJvYcCXzsT72awpG2Bmy4aPrIC5fRe4cYG76LqUO/STH/N5JaFXsDmjD4m+tp0DVpIhgki+rwRuqx5amd/mH/hPPw/hqHNUYsijUAsDnCOZ+
X-Gm-Message-State: AOJu0Yw97ydn/GG4mkomk758x/xO6RpWcMXFN7YNevHq32mXVcqwLodV
	M/lyzBwrnY22uWdQR3khBg9RPemzWhUG12v5C8IXKZhtV6ybNhFRLzof4XE/4lU=
X-Google-Smtp-Source: AGHT+IEz6WRB5qOtlWnobbrrDvCFGZjBjm3K48IZnQKITkZAtG91am1SaEGBYjuYiccpZNzIgVJAGQ==
X-Received: by 2002:adf:fa8b:0:b0:346:c912:3e97 with SMTP id h11-20020adffa8b000000b00346c9123e97mr11039481wrr.44.1713264328219;
        Tue, 16 Apr 2024 03:45:28 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6709000000b00343956e8852sm14470141wru.42.2024.04.16.03.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:45:26 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 16 Apr 2024 11:43:21 +0100
Subject: [PATCH 4/7] kdb: Replace double memcpy() with memmove() in
 kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-kgdb_read_refactor-v1-4-b18c2d01076d@linaro.org>
References: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
In-Reply-To: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=S4M9Ru+1w6mbv19P1LIu/epAWq5YDJmDyvRXYCK9Uq0=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmHlaIgp772UyxnY8agt2JGoM8TVxz0LSXOcPKI
 cGsKObOlh6JAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZh5WiAAKCRB84yVdOfeI
 oXJgD/wJGBNVaYRnmXaLvz4adNakAOABFGn+Hw9X9UCHv1p8XXE+9aFHB23q/dWWRTUhAGVbuZ4
 48eZlLE7wdD2jJwF66IAB9QjH3wzLceNb/uhrYLDa+lYQFpYsYH0TzC23HYvnixnP4Qjo5ICgCd
 k+PnfUlyb//WTxydsON5gVknc+AFcAMIHaa11Mf9bW5LU+UcxXm6VLb+NEys0wARasqCWj+qlyO
 rt4Uvi1lhMrIkdCo9itLfc3p/tiHwaTpnVFFTZ7HYKW6syWQ4iVYya/KjavJ8KdqCa/VdgRCbmY
 QjF9GR8vDmwZroXglAuTp1iF9jgTRsLiuEaYncipHZbsbdp7tlIIkGlBg/x7zBMf4jACGqd7Zva
 8iOnR3DY3KRRpTvhm+k2Srd7d6W3gmMSD1THv7NyJ5FSznvjvXxFJyqQ9juTDEQ/1o2ODw8HzvB
 VGi/56glgFiBYzMacbK73ksF2N38FYT7pNOT6vDZyt5YSlOyQZEAa+ChIVon4t6LNdUjy5QLOeG
 vx4etwiKu7nTnTSrdstKo2b47Y+hL9BEtH3GtSknjgX3V4qCmp40uoWVTEfezO4UxU23WQVW9ug
 84nYz9mn3j90MoquPAl66cQ7tQ9mMFhpFp0DMvEF7NPgE6tq2+HcD8kWTYiTbE0HKrtRkiFfHPs
 fOGr5ZwF06vsO+Q==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

At several points in kdb_read() there are variants of the following
code pattern (with offsets slightly altered):

    memcpy(tmpbuffer, cp, lastchar - cp);
    memcpy(cp-1, tmpbuffer, lastchar - cp);
    *(--lastchar) = '\0';

There is no need to use tmpbuffer here, since we can use memmove() instead
so refactor in the obvious way. Additionally the strings that are being
copied are already properly terminated so let's also change the code so
that the library calls also move the terminator.

Changing how the terminators are managed has no functional effect for now
but might allow us to retire lastchar at a later point. lastchar, although
stored as a pointer, is functionally equivalent to caching strlen(buffer).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 69549fe42e87b..df7b5eb52d74f 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -250,12 +250,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	switch (key) {
 	case 8: /* backspace */
 		if (cp > buffer) {
-			if (cp < lastchar) {
-				memcpy(tmpbuffer, cp, lastchar - cp);
-				memcpy(cp-1, tmpbuffer, lastchar - cp);
-			}
-			*(--lastchar) = '\0';
-			--cp;
+			memmove(cp-1, cp, lastchar - cp + 1);
+			lastchar--;
+			cp--;
 			kdb_printf("\b%s ", cp);
 			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
@@ -272,9 +269,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		return buffer;
 	case 4: /* Del */
 		if (cp < lastchar) {
-			memcpy(tmpbuffer, cp+1, lastchar - cp - 1);
-			memcpy(cp, tmpbuffer, lastchar - cp - 1);
-			*(--lastchar) = '\0';
+			memmove(cp, cp+1, lastchar - cp);
+			lastchar--;
 			kdb_printf("%s ", cp);
 			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
@@ -389,9 +385,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	default:
 		if (key >= 32 && lastchar < bufend) {
 			if (cp < lastchar) {
-				memcpy(tmpbuffer, cp, lastchar - cp);
-				memcpy(cp+1, tmpbuffer, lastchar - cp);
-				*++lastchar = '\0';
+				memmove(cp+1, cp, lastchar - cp + 1);
+				lastchar++;
 				*cp = key;
 				kdb_printf("%s", cp);
 				++cp;

-- 
2.43.0


