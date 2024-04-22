Return-Path: <linux-kernel+bounces-153717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A37F8AD20B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFD0B23ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6042154BFE;
	Mon, 22 Apr 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emX9lxJ3"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C415444B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803882; cv=none; b=HXpYpD8n0Fm/mulVRqpdLxuwWZLWbdY2D4E0RZ4wEeawd7267IFAlkb2Pp/4bs5gjPyenR+fHkJECEmG8YY4Wn09cMn1XIVp8iZf3Z3nsv6vxPED0xPVRAWH3SHBbSTOmmJu8ovf7AYaHikRH+dw5S1TJ2p90CrIZ66rXIJeqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803882; c=relaxed/simple;
	bh=9ajOnuk8c/3dgVcp4I+/1t4zbyy/pCAdQ2SjxrxY5/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HOTgdJUkmJN3Es/BWdyJfRpHF+FP+bLbu0XeYf5wYewcO7wQp1ug1JrXpQjyXj8XFH2x6Tw41sa0tcRjbALM4k7VPkK8IG2nBSnZAQvLveBzw9wP7dhRngqK7IoiJ6aVGwSFnyqz88iSxkUWEq6MoBds7iCmx/x2JAVfBkb6UJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=emX9lxJ3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a55be31eeso9338405e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713803879; x=1714408679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZGZDEe7fnoZT93Svr7Nmn3u9YXAd7uDjSZyL4bPcxE=;
        b=emX9lxJ39rNkRWo0dBjicYwtlfLh2czHRU4K+TCbGuTdOnyWdB/iM34oGm3sxsKCOC
         7K3/PYU1BAr+3fvbRDq8zU0uYd9qHQbVTYvbFoF2laSQKQtaYKqN0sIeLX6vfoCgPQNm
         qZk2y5Zi4ZFn2FjT0bsbY18RCoNJ8nRDIMsm16VQxLIYr+Fs8qMDZlkYU5yOztoR+TFU
         55TjRFXsPIW/UuClNPU3Afu8deuuBQtTbxfucixmL38a/6vKTvjfmpRdm7FRncQj+ls0
         SoPC/EH0jZ7fu0hP4qfnsvz+GGoXW534hcIX/4ySa28X6JIsiHEUrvcuDQzf42ZfKDPx
         WSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803879; x=1714408679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZGZDEe7fnoZT93Svr7Nmn3u9YXAd7uDjSZyL4bPcxE=;
        b=CIAGRgVwULDrSU4iqQypEkygELFIgJLako5SaFQ8nDiEStX9PR1NrfRxVaXpcLP7dr
         Y61k3fika2FNzsIMmA5CeOCYnp9P7iUTWatREkFdES70Q2zUI8kBVSkY3NJfR8Ay/YoI
         inyKE9V9vbZGQ0AEXZoRaMqDL96Q0d9bu1iYmInAmEvIUsunXkwhxAtgGgipvCHo06BU
         5KFQPaMy3i9uPjKF1rk5WRq31IUx+b8wjKGzz9iNJMR04W9HWSeGaMadtzzdUK2mkebf
         Kz4vS/B+Vxr6JBaBtcPuJBwikpd6mm061S48xrKHzG84nX5d1a4zulPYHfQMbkWLJpx8
         dung==
X-Forwarded-Encrypted: i=1; AJvYcCXGBc9qGgJfv2V8vePgcBTLluGw93u1w6pfPQ08MO3sU64QNFEgMOYnzTQ2MmUZIUJUq2kz4hvUO+1pwIYFpE/7xBiR1R/nIh9IImvF
X-Gm-Message-State: AOJu0YycHCnFksJqjqzJn5aPfkezro90OUdkFGLSQVww2If96EjlKRge
	8IlJPhi2qfE71v55N0fKN0749RjVl/jIn2k3YqFN4WYbe8p8PeVwk7mReanm03I=
X-Google-Smtp-Source: AGHT+IEXFlj5GoEouTne/NUIpKd2uLL5aHsKuorpOmx9f/agwxML5PNLpBAAwQO4eBdFAX6Ve1ICPA==
X-Received: by 2002:a05:600c:5494:b0:419:f3fa:2434 with SMTP id iv20-20020a05600c549400b00419f3fa2434mr6943703wmb.41.1713803879635;
        Mon, 22 Apr 2024 09:37:59 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jp13-20020a05600c558d00b0041a9a6a2bebsm433343wmb.1.2024.04.22.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:37:59 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 22 Apr 2024 17:35:59 +0100
Subject: [PATCH v2 6/7] kdb: Replace double memcpy() with memmove() in
 kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-kgdb_read_refactor-v2-6-ed51f7d145fe@linaro.org>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=9ajOnuk8c/3dgVcp4I+/1t4zbyy/pCAdQ2SjxrxY5/0=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmJpJAFzVzaduRhdf4iIyVREZ7MeHvob4Xtd3BR
 7GLT8ka0sCJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZiaSQAAKCRB84yVdOfeI
 oV/xEACkDdfOdizY/ztkA6mJARyXym2GSv1nS5yuuEP/cL81L4tENqnRSKTI+rb1LKJssvmXr8P
 OYC9wXUPSnT0RCCROUvEvpHHHbGueO3I3x4HN09nah+m2TVhpFn6Hykd9Hg/OJs7EXGNAW9kGm5
 zCprCSbbvDnD0Mv+OmPZBwhpmNAo134OF0YNFtme8+ehwe4YriCnmXzgojF6RRZkF50N2PeRlPT
 ErkzwY60/w3Z+u36HFkzYmh/tnD77nu9mX1V6KaWFRzUF+XVlvKHGknU+dAzAK0LD+CrRW5iTq5
 pbxzbdbG7nYYPNuv+GkcrS4d+nZQLPU4OMChSYWUUpp61W1I0h2iuVi6e2dTYydydwjQ5E07Pgk
 INdMo/EJuTWd/+JTrvA5q0O8UI1lg1uJ1FagxC4flnss9VW6dkTnR+yeqWzQg1Y3eXE7ZmtOP8o
 uEIu7heYRsvliWkRVL5uXMlxJPF0MXDYKkSiNrvLzwoJlb3a/scjQdJdj67VrAM+Mo6Qfgbrd4P
 6/PRuwJ1+i6vRNThJz2xVYpLJq7K+/aWCr9XARKzTYK0DKlvdxN6WFVIQsDOMNs0Mc6zEILDgzk
 GSNdTmalIqQwZ79BhC925qohq6GCShPRSpA1svvKE+EmT/lwBKiQZy3ce0qizq+8ZjC3I3QlyCK
 lcSErY+3tmPgE4A==
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
index 2cd17313fe652..94a638a9d52fa 100644
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
@@ -379,9 +375,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
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


