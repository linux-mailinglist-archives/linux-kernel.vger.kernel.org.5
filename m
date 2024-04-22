Return-Path: <linux-kernel+bounces-153719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84568AD20C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077461C20AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463C1552E4;
	Mon, 22 Apr 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2pcpYlO"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CDC154BE3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803884; cv=none; b=WMozckFNcyX3BoXgbL76CtdOjGls/WKXcglbVe+8/u7x27Dlnvrl0e3qtTx1fW7Vo3+gvLtwYn9HWNalNTaDv4OAqiLOY2yAsULv1mkXv/2H77NO8ARk4TjPsK2o63l0V7cZbv6zZL+qaBucRTa65iKv3fTeuseL5bSmaNDEyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803884; c=relaxed/simple;
	bh=d2qYpbUEJ3bo57WTysC1k9+78U0fLX5bGNTDzJBq7DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uVn/C0y3i2dUAZK25HONvywtWrCfx0rob3u1s1k7seNfeF+ROt8GJrW3K7v92oXI/bYG5KeuvzQIr+PahzIMIyigUdFeTTc1JxcTw0W+mfFLKKvmzWlkfIHUkINMo9ltGvGpycn4gUeayYZ/wxHtWX1OgC7qd7X1014j4qNaZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2pcpYlO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-345b857d7adso3654733f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713803881; x=1714408681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qax0/HGbPdCX4M7gDaYwDwDlZ1cE1xlWdr0Di9/Hmb0=;
        b=j2pcpYlOuSilrEE69yarnMHi8RKDx811Cc309uXq1ZnBitG9uTIMGb70RBV2iU3CfN
         5K6Q1yK57TqmD4jxlKtBfm1fZqQqRJOqSxJg0w0TkUYDA13QDQt9drRJ6nbZiSRmA/Ps
         2BbPOPZjayteo/gpfdQNC7G1Rda5oJKeB+mizzlcz4gbDTPxMduKXTw/9OKhj+9e/c8D
         mjhzQk8m+h6F3Mw+pdClP9eYEcU0Y0BWS27l4xBM2pHMUqw++9xwi5Nuc7N4F6W6lhjl
         Q8X9HL7M6ZRJ1i7bAIL3BF+uZQXsHuOEOMVhildVxEh5RqPOCWjjaJ23uzr/zTeL7eiA
         9u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803881; x=1714408681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qax0/HGbPdCX4M7gDaYwDwDlZ1cE1xlWdr0Di9/Hmb0=;
        b=aSIPWqQFqpnJL8L4Ak2gQDuqfsyHrPgUH4L9gVF7yGwczZhDD5hdbLegXMN+Wpr5J1
         5EuG+NZsivpji7YKRftJyIuhlquRt18v0bke/oCvWT+oE14vEDfnmd4dUAdsu8hFd+Bq
         xtVs/d9ksPj0lPM3RdBGeg/pw7yWw5//48Nz8fDsUL1qgfaKTXYsuGCkqFWUPFx1gyXy
         wQDZMNBS+hOnI3K8gJssuhK6fzHQp91NPMc1xBtJyz7OjBpPEe/WurQrJyduiV2vw84n
         sv6yxn4bf5zHEtU/24GNCBabs2KkZDBSLif29m4Wv+CROo8AsMppuaxsfHBxKBerz41R
         n4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFXfNAiuI4zgRP5AfhabFdhAVT6JpmBKx8mYXnsdID85/WgHZuANB1nv/s4Eh8De+24MGP2NB8CkdmlSw4nGpvOlawipxoYoDWak+J
X-Gm-Message-State: AOJu0YxW/0lpmE4XSQJpoavGHFF+I1AR/bTCCHBuECBsNr0M6fm++yeK
	BXw1XlNqJTKte0EZ/hJ67dvcsq6FQK7yj1+5He9Vy7G+XqBOsVnZaDLObLgdGA4=
X-Google-Smtp-Source: AGHT+IEzy7IMdvyIvZX9JXpBHD3JCWT5CYEangjxakk2Yk/cQGKphKCelIukMXUJsOjUWyYnWCSXyA==
X-Received: by 2002:adf:f312:0:b0:34a:9bd2:e062 with SMTP id i18-20020adff312000000b0034a9bd2e062mr5682563wro.22.1713803881330;
        Mon, 22 Apr 2024 09:38:01 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jp13-20020a05600c558d00b0041a9a6a2bebsm433343wmb.1.2024.04.22.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:38:00 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 22 Apr 2024 17:36:00 +0100
Subject: [PATCH v2 7/7] kdb: Simplify management of tmpbuffer in kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-kgdb_read_refactor-v2-7-ed51f7d145fe@linaro.org>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=d2qYpbUEJ3bo57WTysC1k9+78U0fLX5bGNTDzJBq7DU=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmJpJPqisf3kvs1fsDrTPdS/Hd2TSSUyPhD/I/e
 YRmAXjvr7OJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZiaSTwAKCRB84yVdOfeI
 oVLKD/4h96QoGB+ELO66U9tQqvmQKx7Tivdsqq8aKGjehaXAk2JgbjFI62eJd/dwlFkk6fR3PPp
 uUVId8dKR58fXSpB+yc3dei1qYxbdQf9EnPSvVZr3rzYB7RJeUHdxm629ZwuYZ6eG2IRh9gFwvN
 uxnsHpmiUhHbjCWpmzcNiBGrKcJEES/T7zITubiAMIR7DhBFztzdWt+Rw4DlF7aKobXBLYXrSng
 uIuA/fIP6CJQVWpqDAyKENpm6eIMDLRMWKqJtHFGBa9hARFsGv7xpWntSMvtNZxDJ1rtcnymxWU
 E1MPUBf16UzHJ9728ylZOlKSJgfzpeSVYgZw5WE+pHxEcKo/2+WpSppm7YJCvfObvk886tKI3r7
 1avBky2T2w9MTajvja8P57GdQpx/cQeFGuRV/Qm9YQsLqI6PTXtDySCamBKPy/yucQRVoNtyMnN
 9nHGtEhlWQ+6eUhZT8rUBBTzLIyXIkkAPDABVaQcNBqxNn2C6JVmra7MWPXWnZu8FzZw6La2tOr
 ClFQh9AzXn0IShJ7ypZqYoBX87lasKlU8Xa2FvmyuU478qj+Lq/CV9EOZXmF393FOFEVtfaCJ3p
 wwINiDgepdX9FlUsJPk3IEhCeCEop3FVm2EUFXbFCp9SS7sjZ+rr76/SKZONT0m2hjk9rwtbOv4
 95h571eDSbaFKuw==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

The current approach to filling tmpbuffer with completion candidates is
confusing, with the buffer management being especially hard to reason
about. That's because it doesn't copy the completion canidate into
tmpbuffer, instead of copies a whole bunch of other nonsense and then
runs the completion stearch from the middle of tmpbuffer!

Change this to copy nothing but the completion candidate into tmpbuffer.

Pretty much everything else in this patch is renaming to reflect the
above change:

    s/p_tmp/tmpbuffer/
    s/buf_size/sizeof(tmpbuffer)/

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 94a638a9d52fa..640208675c9a8 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -227,8 +227,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	int count;
 	int i;
 	int diag, dtab_count;
-	int key, buf_size, ret;
-
+	int key, ret;
 
 	diag = kdbgetintenv("DTABCOUNT", &dtab_count);
 	if (diag)
@@ -310,21 +309,16 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	case 9: /* Tab */
 		if (tab < 2)
 			++tab;
-		p_tmp = buffer;
-		while (*p_tmp == ' ')
-			p_tmp++;
-		if (p_tmp > cp)
-			break;
-		memcpy(tmpbuffer, p_tmp, cp-p_tmp);
-		*(tmpbuffer + (cp-p_tmp)) = '\0';
-		p_tmp = strrchr(tmpbuffer, ' ');
-		if (p_tmp)
-			++p_tmp;
-		else
-			p_tmp = tmpbuffer;
-		len = strlen(p_tmp);
-		buf_size = sizeof(tmpbuffer) - (p_tmp - tmpbuffer);
-		count = kallsyms_symbol_complete(p_tmp, buf_size);
+
+		tmp = *cp;
+		*cp = '\0';
+		p_tmp = strrchr(buffer, ' ');
+		p_tmp = (p_tmp ? p_tmp + 1 : buffer);
+		strscpy(tmpbuffer, p_tmp, sizeof(tmpbuffer));
+		*cp = tmp;
+
+		len = strlen(tmpbuffer);
+		count = kallsyms_symbol_complete(tmpbuffer, sizeof(tmpbuffer));
 		if (tab == 2 && count > 0) {
 			kdb_printf("\n%d symbols are found.", count);
 			if (count > dtab_count) {
@@ -336,14 +330,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			}
 			kdb_printf("\n");
 			for (i = 0; i < count; i++) {
-				ret = kallsyms_symbol_next(p_tmp, i, buf_size);
+				ret = kallsyms_symbol_next(tmpbuffer, i, sizeof(tmpbuffer));
 				if (WARN_ON(!ret))
 					break;
 				if (ret != -E2BIG)
-					kdb_printf("%s ", p_tmp);
+					kdb_printf("%s ", tmpbuffer);
 				else
-					kdb_printf("%s... ", p_tmp);
-				*(p_tmp + len) = '\0';
+					kdb_printf("%s... ", tmpbuffer);
+				tmpbuffer[len] = '\0';
 			}
 			if (i >= dtab_count)
 				kdb_printf("...");
@@ -354,14 +348,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		} else if (tab != 2 && count > 0) {
 			/* How many new characters do we want from tmpbuffer? */
-			len_tmp = strlen(p_tmp) - len;
+			len_tmp = strlen(tmpbuffer) - len;
 			if (lastchar + len_tmp >= bufend)
 				len_tmp = bufend - lastchar;
 
 			if (len_tmp) {
 				/* + 1 ensures the '\0' is memmove'd */
 				memmove(cp+len_tmp, cp, (lastchar-cp) + 1);
-				memcpy(cp, p_tmp+len, len_tmp);
+				memcpy(cp, tmpbuffer+len, len_tmp);
 				kdb_printf("%s", cp);
 				cp += len_tmp;
 				lastchar += len_tmp;

-- 
2.43.0


