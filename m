Return-Path: <linux-kernel+bounces-153716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7F28AD208
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38281282795
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6562A153820;
	Mon, 22 Apr 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHfxEBFA"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21481153BF9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803880; cv=none; b=TIeqCopigsRE7j0we8l+YZoE+8l5Dn+eDYsjTEBCTcFjXBNY6k+MRP5Bw9ImXD96QE9jDcU4npox5n3UI3s41iOQ8aN9bv0AtPv4zuxNyb8B+IXDGYjvDmxjHI1nsUab+juguSjW6pqLydQ9qojt6Vm9UnVnxRmyItvnPQhjTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803880; c=relaxed/simple;
	bh=6LfmSdx/1tWhrPN9tMn/IBWgdpfapqTqrf1F8jgiXeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gqu9aYVOA+PewU9AEA9miHDG/TKrj3nGo/MmJ5EFjyqhL0IgnHUNfrGgttYZrtug7L8mqj3C8O3dQtkmx+bUT2uQ8baoQ5xXBSuIGrXN/7EzPHgsacAi5ZPs2QPbFRIqC2kN0n4NcvJSiAzddh05yWHvyvvM6NLgsG6FzYf7aHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AHfxEBFA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a55be31dfso8788085e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713803876; x=1714408676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nk5QmCkWRIrgsvRQxugPUqs3aSht8TynNH4Q3EEiYLA=;
        b=AHfxEBFAq4hzwPz1UNg949kQyrF0CuN6WlCaK+VlP1J8ES1RYf3vaEunvdTxjX/MX0
         MhASTXwYTh68UbissuX3I9CeE1ZHKB2J/k9/MKtljPr7HoxBWL7QRkjfdZjDkEH+z4w7
         kEvH35C7kZEyEWvI3RGw/iE4i12cSIh6/tqLg213QaYnBdiBxURqn4XiFbrZgeZPM0h8
         ec+YaFAPgv/SxVHe4Sw1ChJ32PsqrYskxVztbOSjuuDIkB4vjwYHO5sKPpjyDKA+AVr7
         PUVlMvQvod3wOi8aWQwlQPclU2/BiJsAIVmT51MR2Knng6CKmBR7ok1T20E8jOPbEXtv
         9TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803876; x=1714408676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk5QmCkWRIrgsvRQxugPUqs3aSht8TynNH4Q3EEiYLA=;
        b=wxGKNHeWh1brxvf+YmJ+e3BeNIEJnsqoRp88moEXV5MX1Pt10K2ZVx/ASu6yfjJCv0
         ceqYm8W3/aCdLjobObnb6D8kdZ+YCoa9xq/+bvfJc1fj48zi8txy1NeFvFJgNBzgZLyf
         gaR6ZcRoXeDjVIywbvuoOKzEos7F38jS9gj8rHumz5xWhcoilYVUgKwiCeshqm5BWtjp
         5ADdwETNPh5oycqcq42CRADvXdSspAwTgXBxrL3+zyBKA7K5MlwxYH/W9MDWDsjhgGPj
         o6F4sJ5SCQ3ok3vBhUDM5cddUaV8SAZXp1AP0FFpytCCL+nmbVGLpF1j4z8aHJiJon7g
         JnCw==
X-Forwarded-Encrypted: i=1; AJvYcCWtxLsTTBCOHr9Y8hx5xCf6fVbcF9JJv4a4SuLeycSQwLJ5SimbmD3Om730oHuujtM4183P8Set9Rw7ikvyh/YCiggaCb45T9WaX7zJ
X-Gm-Message-State: AOJu0YwLnIm4wXfKZtoBG3G1amCdfOdlPTlAFqQl3ucU9lfhKnw90DeE
	AnuGpjpIlqFzvw+DgKR3iC49se10QBdMsa2QdImxlyvVgoUl2x3TXBVb0F1k3wnaOx6gSvcnjLk
	7TbY=
X-Google-Smtp-Source: AGHT+IGdbZ8ROPEXmCAeRFFCE1IlKVnfn0ElcoTrib1PzzWJrx4X84g23yKrGfh1exX8j/noBOsw+Q==
X-Received: by 2002:a05:600c:4508:b0:418:95a1:1975 with SMTP id t8-20020a05600c450800b0041895a11975mr7465378wmo.20.1713803876595;
        Mon, 22 Apr 2024 09:37:56 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jp13-20020a05600c558d00b0041a9a6a2bebsm433343wmb.1.2024.04.22.09.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:37:55 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 22 Apr 2024 17:35:57 +0100
Subject: [PATCH v2 4/7] kdb: Merge identical case statements in kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-kgdb_read_refactor-v2-4-ed51f7d145fe@linaro.org>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=6LfmSdx/1tWhrPN9tMn/IBWgdpfapqTqrf1F8jgiXeI=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmJpIkax3nnA8BhAmdwQ+q1JJXdXciyaK0wRTdp
 ze988FFBCSJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZiaSJAAKCRB84yVdOfeI
 oR5fEAClOzm3rSzOJIWjtF0ie6Zo4S6K2VgsbsQjG1WYduTN0xhNl8G86G3XNOCAmkJ7AKx2ZMW
 812W94SHSmJhU3wdvG9Ntr9TV3MBRsyLsxysGx0ybN3lzrzkL9MqdEKvg4ggwJ0Aiof+k/39wam
 xKydldkAjYsz7a+2DggOpZKP81AX+E0FERXmwOac3VKvpZfpYszCIqcOEV6U+ImwMeGgnM0Cyef
 xA4uNDcbmnqgOhbOoENorBYREX5cJf5uanSD0NSl5gCHTiAlLZf4DVC+cDFvss4XpNoKu1YmulQ
 SPFgFT6TI/ml4YX52jcsiIY//G5prGPg6TC4SIL98ivTCMHN0VaYDWfLoXCb4ScMctSjYs4SNPS
 bOZbKCJcjj4B5W4AjFaHhHWTMn/0cJlBunXUTgnON0xoA64565OeRMtX4bBrBEpTlnT+EE67f9n
 mP7xzNYfRL5I4nYyMDCTePpaXfGai+LTQCeM/fFUIuDxD8PweAvQlYJd0Glp0vygcKbTA7pqDuw
 UvS5kUcZ6p2XZ9ovgZQVApXUT0JtAmKOUBlbQdJN6Zc/GZ0fm9Q02b+2oSAMC7pWPmtnrTxbwBH
 2EMMW5g0z5lfdGROq83V6O0H75DAQi13UlIxjCWO5VoGJyr9XQCf1+oir+bpHE0VoFQ1sNNBEj2
 pI39upZA9fQFO5A==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

The code that handles case 14 (down) and case 16 (up) has been copy and
pasted despite being byte-for-byte identical. Combine them.

Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug fixes
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 69549fe42e87b..f167894b11b8e 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -298,6 +298,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		}
 		break;
 	case 14: /* Down */
+	case 16: /* Up */
 		memset(tmpbuffer, ' ',
 		       strlen(kdb_prompt_str) + (lastchar-buffer));
 		*(tmpbuffer+strlen(kdb_prompt_str) +
@@ -312,15 +313,6 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			++cp;
 		}
 		break;
-	case 16: /* Up */
-		memset(tmpbuffer, ' ',
-		       strlen(kdb_prompt_str) + (lastchar-buffer));
-		*(tmpbuffer+strlen(kdb_prompt_str) +
-		  (lastchar-buffer)) = '\0';
-		kdb_printf("\r%s\r", tmpbuffer);
-		*lastchar = (char)key;
-		*(lastchar+1) = '\0';
-		return lastchar;
 	case 9: /* Tab */
 		if (tab < 2)
 			++tab;

-- 
2.43.0


