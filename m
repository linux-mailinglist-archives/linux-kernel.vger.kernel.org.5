Return-Path: <linux-kernel+bounces-118188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFC388B594
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA771C3C982
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05A127B60;
	Mon, 25 Mar 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4py96hw"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5284D15
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410630; cv=none; b=kaJ+6KgOyxxQjwJTg1JiHbrlSoiBXU3ZDrcmoKnZfx7e3r/0ZFFZ5kZEtYaI/l+PGaGc9wNJF66Sta2JUcIv4iH3HYtq36PdRv0yY0Sp99Pkh89ER6NJ1jB1wcw8sOINaFzxKXUWPhUXFPJsKT4/frIutnQrGNwBO8hp8hDuHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410630; c=relaxed/simple;
	bh=4PhLDyJKyNrd+eY0Bpr57YddoLSPy5v21IAWqWdH8Io=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SmoVo300jR2+ERraC4pmEyQHewnXT78y62EjwZN0vAKeW9LeZ2meOH9IHiG0CBdi8nWNmyQH+uwFrZ2nEzVa9eRZESCSP1Ln1QJg1SFyBt/VgR7kT3TxhsT/GAa1MQJGm6ky5kZyaxnEJSfDEtg0R2zYRql4+yltXehjmxYOSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4py96hw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0815e3f9so75220987b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711410628; x=1712015428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rS+9vqlodSMLG0LOLi3GYviKuQ0ce9GmEUN+BZASUg=;
        b=t4py96hwnBcj231C7LOLMDhDlXIwVLiBAj/vTVUrgybSbjxxQ1ng3xZ7zeIS2F5CJK
         WD5iW6fiDK5HwWwpCi9rBSE+tMoQvsIUJjno4GFYZDxiJerFSmq3EI1SRbL09LbrC56Y
         bNzsCpjzOfEDfluDHWmJSzdTHcCjo9xPWgaPRAgrP1Vnao1hSZBxCgw9oKQQ3Iq4SMkn
         0wRg8t8K/BJQAXcYa8a03hOO8btO0GJijd5YRpDbq629KPwiRW8C4cAH2ux4KtA8KdrF
         NZ9o7LndH8Fl1Ke8HgcoWzsTAIJf8eMkNSb/fxg+Gowr18qROXjvhegO3z+6qczw0wq2
         rT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410628; x=1712015428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rS+9vqlodSMLG0LOLi3GYviKuQ0ce9GmEUN+BZASUg=;
        b=m4O5Tq+g6HEeX8mdq5N6hXp1m1S3WotxwPXWcMB1Uhio1sgRDoXjf/v1uK9BIPlQ3W
         PxY0ls/V3U8NW/Wrvmd7Acw9BtsjND1Tn+cpvf6ErD54Ib8OFMGATuq6cqaCZtg6kLty
         +x221H2EM0oDRTSZAIcCXv6WX8RZSiAY7Dmy0zjdZIAqK30WEMBx520SQHJ86m9B0fsW
         FhkWqHwejcS7L134Li8GHxf198VmZqjEQFVoBmsWDRA40XaRrEZKnkVPjLwLh9KgeqmQ
         4vtKkiW87zQXEvr685W2sMV/eODrlG7ygMbt7AJBt7OBqAN5UPK+B8R7LOQmeLb9mdW4
         I2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV29AQMrN9QucxFhgTtf89VFdQEvSgOTXwefJifR6xr98nga7EPR3Qk8rQhck5qM6NrBk4+Mb2oINLbJyQN6TPsls2FLIJYRlVRsAm/
X-Gm-Message-State: AOJu0Yw1qqM648WII/augGjCnFPmFVH5JazHMC5Qr9DHFp62pqGQ8/bY
	tNmHmR2a4FAfv8QuMgefnSRcCJEGLT5kRDW5CNLT6aRa76dINb6dknVQtt+WHASMxtY84xGKG8X
	gLHg+IlNuImelYWeGNg==
X-Google-Smtp-Source: AGHT+IGKv5EFMnzQrdwPt+dy51PJVNwrFBzsXHDzxlAniqnpd5xrXPYCvCMKdfAD9j2nV5K8TiJsS4lrUK/HiNL3
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:e82:b0:dc6:dfd9:d423 with SMTP
 id dg2-20020a0569020e8200b00dc6dfd9d423mr371033ybb.3.1711410628291; Mon, 25
 Mar 2024 16:50:28 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:50:13 +0000
In-Reply-To: <20240325235018.2028408-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325235018.2028408-6-yosryahmed@google.com>
Subject: [RFC PATCH 5/9] mm: zswap: remove zswap_same_filled_pages_enabled
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

There is no logical reason to refuse storing same-filled pages more
efficiently and opt for compression. Remove the userspace knob.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 498a6c5839bef..0fc27ae950c74 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -123,14 +123,6 @@ static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
 module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
 		   uint, 0644);
 
-/*
- * Enable/disable handling same-value filled pages (enabled by default).
- * If disabled every page is considered non-same-value filled.
- */
-static bool zswap_same_filled_pages_enabled = true;
-module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
-		   bool, 0644);
-
 /* Enable/disable handling non-same-value filled pages (enabled by default) */
 static bool zswap_non_same_filled_pages_enabled = true;
 module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
@@ -1392,9 +1384,6 @@ static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value
 	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
 	bool ret;
 
-	if (!zswap_same_filled_pages_enabled)
-		return false;
-
 	page = kmap_local_folio(folio, 0);
 	val = page[0];
 
-- 
2.44.0.396.g6e790dbe36-goog


