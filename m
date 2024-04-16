Return-Path: <linux-kernel+bounces-146663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D66C8A68EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0091C21315
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF412A170;
	Tue, 16 Apr 2024 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHCsMsV9"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF66129E6A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264332; cv=none; b=F9nBNAY5iwmnwOFwoetjaxuKn3EK/3nrIQF3guCHMALK/JYRE2GRymOJYpQIYGUEOpYleHY0EJvqZkMKMF5pCTtKZ+hhK0YFXZCDPPU9OcHPu0bmVSYsupOQYI6Lc1jdDJ3AgJQvHmTjknBs6GcpA0A/lMLBLQlBPfIzKfefG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264332; c=relaxed/simple;
	bh=4idmgQRyyCbZHKD0Mmm9fLBykSjWqWqEhno1YDmNYTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tSn5dUnf1QmKUao+ShTH/PmuXEtsv2RveJAGeUCA308Y6Goj9+l5DpZOW8ozlP+qwe6/FpEl5wU4PI492xSd9HCKb8bavlB/5Rq1MRr5oSOQVR0C+pn3UZ65RKNGy22JxuPjqj5PJzdXF2BhZi/kH8SrOZS3UFW3S39I4p+FgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QHCsMsV9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343f62d8124so3483702f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713264329; x=1713869129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oS0wWNbf8WiBpvrYnZvz7jP/0PigZGSr5b4L4txYIPU=;
        b=QHCsMsV90Nl0JPXTHTG45SrbbMsFM9o0vPVvyO8jG3A7lDVWQ0ZQGHmMKqTNd1dtkY
         neeCrS8jeVtBjR8MEnUvxe2hq2JV5c0g/m+M3VbDQsLFhUehaCVi76AbkdPiq4WOyrrP
         gMLTG+FR82F6Qsfz8ffw05a+kXoCy1Ad0Qg7yY+PqylMO14pSdkrzAW2Xuby7K1mznG/
         IiuuwUxoL3mJMK5NwMbkTCi4v7eMMPjKO+PM5yyt7SXyQi+QsR3T10tAsO2fHT6MWO+z
         QjXZ6nb+QG06Xn2AvMo+icvhtRci27mOUMY+gPSKB9Vq+kXVMu0h0mguIXka8wGET6No
         VUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264329; x=1713869129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oS0wWNbf8WiBpvrYnZvz7jP/0PigZGSr5b4L4txYIPU=;
        b=IfAB1lrM9QeVosGi0EIHTfg3cuMrQDZKZVUR3nAWnO+DTwKiMSVLKPUHS3EXjUcnhI
         EYtzuwWJGeANPRQc/3LLtfZkbg8Thz9GVIPbasuMOMJjPP0oaBQD+kAaYGuFUYt7dzH/
         eyZbu7L1TzdeuYD6kr6imG9SNua/gMxUPVieREipBs3tXMSLDVbu9kXTUVOUScr5PfOb
         HqxhrdCM2jWG8AE41HM1sjdm08qxYW3Z3IRh/LaPxS4fUayaayyPV2FJWiokd00iItio
         3ZAq+UgJKg1kYUBuiQFUoPJs97StKFIjDdazRYimJ1Ccgej0OB0pTqyXssEpArBE7Pd+
         kCRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi5L0zejU8joroaTQA2f9a13b6cqMskSz7UqOA9K73VhdlMCSmipq1QmIc8AtAoRF2NCsrvQpfyHj3hYEfxNgrcBkpN+bbAMfYKUb/
X-Gm-Message-State: AOJu0YwoKAYHC9QJkFRfidUXJaiSfp7QgOjeBJ4J4mq5cFC3yxTMAMsW
	L/q3CFw0xpdGB5La0OJKYWn7rh/JujDm6ejerN6/leaJJutehIqI+kaGlG0TLb8=
X-Google-Smtp-Source: AGHT+IGqn+jcRQRpVFydNv1MCf62MNjuNj8pVlNatJ76HLkHJFok8Y910GSeuntpkpLe2kK4s4cXpg==
X-Received: by 2002:a5d:698e:0:b0:349:8ba8:e26d with SMTP id g14-20020a5d698e000000b003498ba8e26dmr522518wru.13.1713264329427;
        Tue, 16 Apr 2024 03:45:29 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6709000000b00343956e8852sm14470141wru.42.2024.04.16.03.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:45:28 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 16 Apr 2024 11:43:22 +0100
Subject: [PATCH 5/7] kdb: Merge identical case statements in kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-kgdb_read_refactor-v1-5-b18c2d01076d@linaro.org>
References: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
In-Reply-To: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=4idmgQRyyCbZHKD0Mmm9fLBykSjWqWqEhno1YDmNYTY=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmHlaWddLOeypVnkvDnI41vqqFzzDHlgZEm7ZQ+
 k/lch9GSvuJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZh5WlgAKCRB84yVdOfeI
 oddlD/9Qq2vjLJ9Ne/HilYWm9854QfB2Ft2pTDtk+nSeYNOmndUo4mxsrx07ACsaTHELqkpyzru
 mYQ8nF91ATm/JqApBrmKWQS/kyEAQH9GSy6BNyB1ClmWeblW5RiJnLyXvgh0KqlzmV8rRAmxqkS
 NutuxoFzNHELJbNm39+g3UUuUAS6Ozo/HRa4tYJCtiCJJ1Vzy658NPBJFjhZCq++We4V9Ooiqjc
 sAin15aBhnVrJu07qq5iKx71cmzUfb0SCTbqezv4BxmV9izjoDcCS3yhRuI0+Ojk4g982+oLbYL
 O94AMF/nNAZougTU9hdYHNflwpKKKMfbjex5NvdIIoQPC858zpPmt6KMAmlPFRKrPJoS5dwbwLL
 tdWclePn/dsfGz6Db5d06C4I34YIO6m5egQ5CjEARv0OptV8tPLpxvMjL9moE/rXT3nNmI3Wi2Y
 zfDHGkI3eYL6BEJcP0kO5smagn8RjfAmVkFgjgy93JjJL/e6H8CGJfRG4gk0t6FJOiA5IeaKYa8
 y8f9zcfOgtLcgvZNFK3/t+rAtXo+RVx6L/ebJA9gf0p1coBYuqOMGDbejiexeZhQwRuamgM7n3W
 pg9tyTUxInl4AZFw5jDv8jdis1TFbnq0keD5BjWlALndIRTKGdldk2vEo0H1H9TRcuErS77l2b8
 9RyOU3TUD1JxjuA==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

The code that handles case 14 (down) and case 16 (up) has been copy and
pasted despite being byte-for-byte identical. Combine them.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index df7b5eb52d74f..08a86a329eb64 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -294,6 +294,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		}
 		break;
 	case 14: /* Down */
+	case 16: /* Up */
 		memset(tmpbuffer, ' ',
 		       strlen(kdb_prompt_str) + (lastchar-buffer));
 		*(tmpbuffer+strlen(kdb_prompt_str) +
@@ -308,15 +309,6 @@ static char *kdb_read(char *buffer, size_t bufsize)
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


