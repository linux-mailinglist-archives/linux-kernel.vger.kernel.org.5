Return-Path: <linux-kernel+bounces-153715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398DC8AD206
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FCF286401
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90489153819;
	Mon, 22 Apr 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXBKRerc"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D5153BC3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803877; cv=none; b=ksrhslvNuL3p+f0ec9kPMX51kUlB1hbil6JJGwQniPDOsZ98bvRbBPXk60A7URRKFz6tM+kxVBENyJiimPnLEu8soYn2Jrjfs8TTpKKR1NucDKZ2SQh0ltPe+MOH/X/XEGmTFmRy35NardwXxhVLKzuMs3uOegUQ3LJ4GeZT62U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803877; c=relaxed/simple;
	bh=jn1ryZV2lseU9K0OYgA4GJIVFoBB6E4nLhtvlmWlSd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/5bVS+kQpVCXiFnmqvAw+BUiu3R7YS0KzmZ1UhrAaq3ra+b5VAdLPraRhWg3c2xrZGAEdT8Mm0GGp4uJlt31kQzmKUucqJ0w8cv77ON31IMvjYT3J/kGNOIY3/GLiuTIf+JCHHPxloNpNLtreLhkAg0FduAZwEAEkUTGqBqgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RXBKRerc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3481bb34e7dso2560671f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713803875; x=1714408675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qw8fuXLn1BipxTXGJjzIm9TXoIt9ndz+hzAX+iGey14=;
        b=RXBKRerchyjTwFhkxeoqr8K7ZlMetLhLv/hwTU9mlXmQrQe5UgBnj1H+xXgYtyG8qh
         Xi5+wpMpgUQaW59ugmNTDa9mmd809sQDilwGSx++Mmt59QACNDP+7GJAhl6nAAvYyQnx
         n5y2WHYrqK+RNNtGaga0Ydd7+MvgFxJlwDrbhn/kHgq7w6f1zTskbmFFD8ZAy4kZooTw
         Coj4ixYomACwXbe4PcUUc5Umq6JXK/kJ2hgEE1fvakLHt+6UDjIE6IgoSCj+1xL7WJBz
         offfkieT9djyi7yn96r4Fr0oe92sW2cW5b26ZGtwaC7IlRHgAiKlIw3o0cSVWC/lNlCq
         KFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803875; x=1714408675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw8fuXLn1BipxTXGJjzIm9TXoIt9ndz+hzAX+iGey14=;
        b=BvAUFUZkFp6YJu/gOAb7avQaezN3681KujfXYgezs9I4GB4C5CxcEs7EzL8dAaP7q6
         lqSLnMFXh6w3HNNHzhErkPMtbOCu3z5VTi48SnVQaTovmv4gXBaJxjudUR3cDgTzZVMj
         Tc48alB/+R1JzzM2JPWLrPj1Fs/RLqbrj2+pebQCa+Gyi1twAZ5RM4VoDgE5GFKaLESA
         aEINzPw7TbOfj9ZQjudFlQ9Xz45AUX2aal5UaHVOZXfCqC/VXRUOFs93zNyl49OC1oM/
         xjs6RYQB/QgBPoRK1QifTMSio7uodJKvfnYTjB6uSP221C3AP4cuAXMSYxHJ0gJbrK0r
         uBmw==
X-Forwarded-Encrypted: i=1; AJvYcCVKlwzlRZm9zVqEya9KWNgRqzti/NLI+M0E5g/A4NT2Qg5dnw5bvCQ6z36+6l4PeqrBNm9VYGnlIwAZEQMrfsDkDqiFTunomMgNmHTO
X-Gm-Message-State: AOJu0Yx3lUP9KhMHa9FiDArFT2OIEh1AZkucQpABkZVN1EWq9BkHrbJB
	GfsDDY/JQUht0w5hnrGqUg5b2EuzNEjfqz72oFDifmWdVD0digMu+jsRwGrOKOM=
X-Google-Smtp-Source: AGHT+IGryKOg26pY9YVtF/etPlBEZSaLETo3yB57+/SrqCekYX9SP+Epj5P1Hph73oDDUhm2wLh4Hw==
X-Received: by 2002:a5d:64a6:0:b0:34a:65c8:7413 with SMTP id m6-20020a5d64a6000000b0034a65c87413mr8526451wrp.30.1713803874749;
        Mon, 22 Apr 2024 09:37:54 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jp13-20020a05600c558d00b0041a9a6a2bebsm433343wmb.1.2024.04.22.09.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:37:52 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 22 Apr 2024 17:35:56 +0100
Subject: [PATCH v2 3/7] kdb: Fix console handling when editing and
 tab-completing commands
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-kgdb_read_refactor-v2-3-ed51f7d145fe@linaro.org>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=jn1ryZV2lseU9K0OYgA4GJIVFoBB6E4nLhtvlmWlSd4=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmJpIWu4GpGHzCm/ReOjDS8WmJ0VBKNsUqlRj8p
 PvT0hB7oC+JAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZiaSFgAKCRB84yVdOfeI
 ofrMD/9Dd6x3qx/aTRlgNTpZTqArAi2poVMKGjmG1834eWva0RZweTx6WYLiH/wrJLRc/6MTaQQ
 GhwXARUTJTzkBwkwnmgaBn5FdQfVm+yqqyykDjkmt8GKErzPLMmO3mor1EOyvjHvuZoxNxFa9A0
 H2o30hkW0G2ceopv+UIbjciCydcesR0BvQ77g4kDKQw5rt3M3uX3VWWziTfHT5HKjKRQgBjxEfF
 VqPpU9WJOCxGSI+43KB1lIG9Jmx2dibWlwMAFHRsOHuHuiSaF0Mu1tiPZrbloa0Wg6qR2BP5BpC
 EWpTcjJCMMS1onNpc6ocPHKxu74mw9I5R5+PfgXCBcr4VThKk0RBc2yBLedKOTMo1umwnytbmso
 cU00codNlahOf7pqzLNVuVvgWzYV1Efexu3sMSUenMxAgulb79Zg54aiPphOCRy8jmKSAYdy7uH
 YahNZ1BgELG2BuoX+UcGME7b3LJ76/9Tysb9vndVo/tQy9Aly48cpIUC8zMIbikLDKxx/cuuVoJ
 KKosrrN82soM72sdCEW7cq5zgWnjGICCzTSk20y8dl+hXyoMPPip7CoKGDOnqkUHpu6zh2HswFR
 Wt1DG4BqESNKBG8dD8do6KHmjwdfFFTUfcmrQBTTwhzNgnVAqoU/RsygQuHcfCpsX2lr+0xZWxs
 SgCt+E5vAk70OSA==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently, if the cursor position is not at the end of the command buffer
and the user uses the Tab-complete functions, then the console does not
leave the cursor in the correct position.

For example consider the following buffer with the cursor positioned
at the ^:

md kdb_pro 10
          ^

Pressing tab should result in:

md kdb_prompt_str 10
                 ^

However this does not happen. Instead the cursor is placed at the end
(after then 10) and further cursor movement redraws incorrectly. The
same problem exists when we double-Tab but in a different part of the
code.

Fix this by sending a carriage return and then redisplaying the text to
the left of the cursor.

Cc: stable@vger.kernel.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index a42607e4d1aba..69549fe42e87b 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -364,6 +364,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_printf("\n");
 			kdb_printf(kdb_prompt_str);
 			kdb_printf("%s", buffer);
+			if (cp != lastchar)
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		} else if (tab != 2 && count > 0) {
 			/* How many new characters do we want from tmpbuffer? */
 			len_tmp = strlen(p_tmp) - len;
@@ -377,6 +379,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				kdb_printf("%s", cp);
 				cp += len_tmp;
 				lastchar += len_tmp;
+				if (cp != lastchar)
+					kdb_position_cursor(kdb_prompt_str,
+							    buffer, cp);
 			}
 		}
 		kdb_nextline = 1; /* reset output line number */

-- 
2.43.0


