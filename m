Return-Path: <linux-kernel+bounces-157044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB5D8B0BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A331C23C46
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8220E15F321;
	Wed, 24 Apr 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHuAsj4R"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73415D5A9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967565; cv=none; b=CR1TheS1dybEih6aBwh62ufm86Ss8QQSCpr1KeszlcjADkoLUOXFqmHm+L8cBIpAHsbGMa7czCszSRH50R70vrUI3LQUYiv5XYOGaBwDTZOM1RM3gfysNLY21AQBumR8oSBVMfAjxrOg2dPvcAGVT3XXEmZXfsqgn+rbZXMEM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967565; c=relaxed/simple;
	bh=m1nIw6K/wxbB+0xqkP9QU662J3mgsOoAQo76wtMC2n8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iA0/ZXdtt8zfXvesSHFfTcJDH4YEvmiA/c/z+wvqGIivMdgAbwbqCCtDMN9L0QPUbH1zqA0zQxeu4KBetJULDGFj+cwaSiNCYKzZkia7p1XgnO7z93VhSjZp2AvDuPZ44S1FcZQcomwT6dgrnoM4Wt1w39cb/OfMvAYf3ImJy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qHuAsj4R; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41aa45251eeso20106025e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967558; x=1714572358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7xv5Gr4R7/WZHUDWU1nCwM+2Vbz0wc+mfKaI2SQTzI=;
        b=qHuAsj4RAh4vAeSZuQ+fjWM3ommnqMZyWiJk6IOUG/WYMEL/FFCZbxIv/pZoWdVHAo
         rnxgNWH9gyVAtBFP4anpTsmiO2PAptpyYJa27EPYSyrFVK1CMt95cUOD5/NE75HrM76D
         u9s36zzKNaZYKdaAUGWvHdzhWpfPA4COkYt07tHfGXlXkrpt/DtSTaRW9Z1ogYrfoHwt
         t3Rg1Df99RmYA4RyhvPGEMHMhN+dXlgyUNUOchhVVchzIY53EkptOXoUsibKsmdJVlGy
         Zaa4wpymUhucJuDo/zpN1BIYOllaImaT9HeG6Glwm3LHeb2GGaVSSmv3YM+frV8e6iEv
         pUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967558; x=1714572358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7xv5Gr4R7/WZHUDWU1nCwM+2Vbz0wc+mfKaI2SQTzI=;
        b=cSbYWTbmMRmNuDoaWqE1BQtzIatq+Rg7qa672uvmICiVLows6QG2+TUG0VrsSyqyIx
         QnxDcaubLDun7Et92gcxofdW6JrbLVcMF4aefgQDCppszGuloPWQDCj2U01WLUbrzx5e
         lAnduCaOH/llBJ05smfuC01csmeuWzc+1F0Qks6gY4SlnG9/FVEWOzYaKOmU4MLlueOP
         m/cd6ut4dXWdTMKYHCm1VDCTmnhKFgzi/nWofAWoGpe3K0HKaJN6qZCyxlyCWVO7v0Zq
         h1tFeuKuB1zoogFtF5MXcnny0mS1rxU3U0hpmGgD4oWL/mLXpUF8PhxfHgheUGa8Beyi
         Gq3g==
X-Forwarded-Encrypted: i=1; AJvYcCX5/AH0ryvUAMEbVrIuENPHLRwLTQbWRQgZGhkyWdeiE3jAiH0E4q8jDBeSKNPBB7Juu9M+Z7C+uuCTQdv9R8C7uUIVnx45LZEUOx+M
X-Gm-Message-State: AOJu0YyKXSaV/q6e+kGpiPZy3ii+lXbUBTXA62zttmA5SK+2d2wrsZSI
	SDY7gShUHrQLB6/ssC7SKwjITOTD90IPh54BmxYe8VP3O9NyzSC13PCLNUglxQWQLhXZJLO0mO8
	7ek0=
X-Google-Smtp-Source: AGHT+IFq937L1Vi7JpHySQ2WjDRGjy5vgDcZRame4pNbvUA68UU9PQwXRC9KVlFkoL4mT3S8Fd8sgw==
X-Received: by 2002:adf:e50b:0:b0:343:efb7:8748 with SMTP id j11-20020adfe50b000000b00343efb78748mr1632812wrm.66.1713967558452;
        Wed, 24 Apr 2024 07:05:58 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm9105325wrs.108.2024.04.24.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:05:57 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Apr 2024 15:03:39 +0100
Subject: [PATCH v3 6/7] kdb: Replace double memcpy() with memmove() in
 kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-kgdb_read_refactor-v3-6-f236dbe9828d@linaro.org>
References: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
In-Reply-To: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Justin Stitt <justinstitt@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=m1nIw6K/wxbB+0xqkP9QU662J3mgsOoAQo76wtMC2n8=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRGhHh0sDmQu0SuR6ilg48GgyUTWyWMpc6f/b
 7cMSMspygCJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikRoQAKCRB84yVdOfeI
 oWitD/92rzCg+qesbfCyE2mJoqhkiy0mr+6LY0ERzA4UQyQczanvfLm/oDA7/lgsVhNoqcc1mQr
 WJXP0XD7ZcigdkkOCQxM6XtTqotz6YvjxpLxcVVFgx1A4Of79ca6WkZGtC2F8QN5/kGzcpZqwjx
 hrBGYW8zG/5UGFz+91CQ+acTceX/bmbDpJq4FDVRSIdX0BAFzWFmliRA1ayfmOl95kWrd9COgSY
 TakLYAogsd5nOMUL3d2mFcQWK7ZqHl1+tv9NA67ZobfJ2QIjmOfOe+vTBNXE8UiGlTnR/XqhQQI
 B51sjhxd/MzAYlBPuM1odRN6eYmtH4WWLTmn0EKf/M+cpTXSOpTtqRt9JkpWkT/hd0KpPkJvchq
 ASsZMIo97PJY28gmN91fE0JDT/VtxwqHGp4tM84+DUZK9w3IlJOEDW28c1OuIx9s6BCMYrCSVPM
 ERusAc8+EtWW9vw95wYHRZOtjgeDklxQb+Zk+G8/Do8JYRr+82vnEl8x0VSkeqgX35azMroX3Gx
 YrCjphlt3LxHzcUZbKnEbHVNzmaQs8dcsYkGHthMCpSvql1pgbRW9zCWP0ONSMQ4L2ojQL/pzbR
 WKbdl+oPfBbYEyOBEMOX3bBEgcD/1il/y1JcUsZ5tqGR8dMhotfw4yBdsd/0qKvb+SbeCEPGcQW
 r3MFtMTucJ/0+oQ==
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 2aeaf9765b248..40617f36a6db4 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -269,12 +269,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
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
@@ -291,9 +288,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
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
@@ -398,9 +394,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
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


