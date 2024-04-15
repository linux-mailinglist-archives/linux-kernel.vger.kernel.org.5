Return-Path: <linux-kernel+bounces-145651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1C8A5900
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D6B1F20CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902B083CB7;
	Mon, 15 Apr 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEycy8+y"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8575839E5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201555; cv=none; b=cZmZJNomMCfpAQ9MuThKXoRrQyVfXfGdy9neKjTCiC3j2fdut9HFh74XrghabgJB++/nSRcdwPfXMKrsR/EYtKE1U0JIr1JSWkhzAkNN6mrJZpKhqSn3HdnmiaAxXGt3EhNpVsuw/SnkUQ3ip5Z6zNUoU/KsS+tdqSwKg5O2hWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201555; c=relaxed/simple;
	bh=lLIOvfVm18UTpicKdH4FOcN1juZAjvD4d0PBeYxJtIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOjA3jKwLK8Z7zqQXLKw+zOWB1jmZtvxc+2QeA409hqzyK6/vUbDOgg/Ayy+y9mJB7grTIlBQbp+DpJ/jPaV6PYB77GLcHrIbF8Y8U0u7nBvuJDfi40oo6kADxctGKfpAOY1YyiyVx6+fKsJ9p6c7qPUjpn5zRh0sAF9qQEOsFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEycy8+y; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so2209752a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713201554; x=1713806354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B+L8KNGbsq36FmjcGvQ6kYVRELiG3WmiEI53/0190Sw=;
        b=IEycy8+ydYC6Y4VMMbnJwWRyIxAOQyuRULZ+1PBRGcqNYa85G7iDk0WsdIbUEqxO6k
         cTtlHOmgya4T4BDoNaGgjfSXsCnaHtDtcsrPBIbWUjis4TG/sOcqHaul5G1He5EMTErh
         wWt6yJ79JEuUgbkQ/ErO+fPAkh7ACqSNaWCuIo6E9qKy284oqHOhJhQjTqW0mwo1f1k0
         a1vwasgf86tOEz/fBTJdE1iC8nWOTCPUAanF751tuRb3VPwJgGVWn9fkVr0YnQ0RTrLT
         pmizCagyR+scK4h6tiyVfV2YKSejDNaEPq6rs1PkmY5tfFLW3Qi85PF1t51SQ/ST0kUH
         h7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201554; x=1713806354;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+L8KNGbsq36FmjcGvQ6kYVRELiG3WmiEI53/0190Sw=;
        b=ubQXXN6GBFPYMuoax4c4n394g/7r389GAPAnW45Vks8Oxh2cHVa2dPUtNeBm0MlpgC
         Ze7GJ5mNMX4c80rubLI7s/nfmBgFwfvppmKBfLp1McYdJ9uwmwyikFYc+ct+L9f9cVo4
         c/NENsCyTqwfAbJI5Acv9/lTq51MeqqqSXHGJ7gwcE6AdWgCvz8ZrsQfq54lvr8FQM+3
         9WFXk7ES2Qi942R//pXJ8MEuq9uhIgTHHaUy4f/VYkirCR8ND8BF0rOwPLG/jSqIiFie
         tgfsRL+AGLtDOyBeeW2YihuH/z3bJ3Cp0vrx85LUOFFJPCKT/UECXS5dxhqHTziWy/0u
         jcsw==
X-Forwarded-Encrypted: i=1; AJvYcCWtnskAnWJIISPHaDpr7qwfYCzKgUTefVu1Kl2anRq55N6lVZ8A/6LwA9CJgHkx+AKA1QUvjBlTBiBzXN+XlLbdK1KrMV9/xnsb5fqs
X-Gm-Message-State: AOJu0YykTiN6GVMY0YWGfbvUobmPJXB6reSw1Q8KuVQXr1i7DzYlCXHg
	/Mc0wKEZ4cTq/kACHdT+tDf4sLwRd49LW+Jl5I7Z86sZN+KmIOy8
X-Google-Smtp-Source: AGHT+IGZsDnsN/0G69F9r9pl4nCedE8as+ni4AOnw741cJ5yApDTX6VIYEFjdIjzcaV4wIkNMeB2jQ==
X-Received: by 2002:a17:90a:d998:b0:2a2:b096:f1b2 with SMTP id d24-20020a17090ad99800b002a2b096f1b2mr7627869pjv.32.1713201553844;
        Mon, 15 Apr 2024 10:19:13 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a537abb536sm8751648pjq.57.2024.04.15.10.19.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Apr 2024 10:19:13 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 1/4] mm/filemap: return early if failed to allocate memory for split
Date: Tue, 16 Apr 2024 01:18:53 +0800
Message-ID: <20240415171857.19244-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415171857.19244-1-ryncsn@gmail.com>
References: <20240415171857.19244-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

xas_split_alloc could fail with NOMEM, and in such case, it should abort
early instead of keep going and fail the xas_split below.

Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 480ae6589803..12089c24abfb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -880,9 +880,12 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
 		void *entry, *old = NULL;
 
-		if (order > folio_order(folio))
+		if (order > folio_order(folio)) {
 			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
 					order, gfp);
+			if (xas_error(&xas))
+				goto error;
+		}
 		xas_lock_irq(&xas);
 		xas_for_each_conflict(&xas, entry) {
 			old = entry;
-- 
2.44.0


