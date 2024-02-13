Return-Path: <linux-kernel+bounces-63429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A52852F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A521C22A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D565524C7;
	Tue, 13 Feb 2024 11:21:43 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88D524A7;
	Tue, 13 Feb 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823302; cv=none; b=YcY3vdWzhhEYWae+gJMG4lQyBInKVAKDhKOPQjwtBSouNEyXH1nj177EMcNIBMyYAaqGD7nn+rZx479DPQXuYoKjh6m6aGtaGcH5vJ/8h5JLJhUQGk6Zol/BjBI9tJBochS53Z33pQmjG0FEob+j2ZBrB6A/Do+fk3zSR4+5ZSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823302; c=relaxed/simple;
	bh=Sw9aECovxuzHfbGjq+NuK5xwXC1F2IayjoSQFizg6p0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IT1/j1r//jq4NyQc2fx/8mGYB8oO3ARR7TykSDjEKQnYO7tGWU6FrWKEysnjivttLwT5sZ5+NP7gbiOD9+wkDGyW8zSi4g8FDRQxPoYfNsmLNdiRb0CsShNUdb7cewmehS5zFYvD+wBfKSK4HYzNKnma9lYGnOWtjK9j3oxRe3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso50084631fa.3;
        Tue, 13 Feb 2024 03:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823299; x=1708428099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BaPmfqU67eGkA9+Zdc/Y5R+aKMFy5zwM/Q9/t40NLg=;
        b=ZOd4fvEwqsx0mA1bDpWgR2xAMN0QRSxXV0buoWUr+68WqhH5dfto5lRuX2t0bh9Mvs
         x9BDujrmjv6jG6Rwjp2BKE4Pq7xLymaJje3ZmdlU4KjpjTJgjhgRTNADfUdnM7W+hWCW
         Ok8FCZGJYa+Wy6HEbjXFtSItwZo3t2CbwmuA199Be+WQepZl/IG5IBwvtXBq9DW+31wb
         7/HyKdoimn3IY3qKJCgX9J8dhV1wywmqpWhYPg5X9R7mtKBWrO5qHZQEpOZyh9nXfxiQ
         zW0P2v06kCzEWobaHbEJyc3hAqU3E2fABFJ0511AVt0SMvGOd3PhhMFuyJ17H9hjESLO
         apvw==
X-Forwarded-Encrypted: i=1; AJvYcCV10JciTTyM9LoNlA3zftcsohmPQlvrpvnW5FaHjYbRXQ3LE6xw6hCRFmr6UucIK1NPEl0f8ACDhLy/oqdsuGY2INPDR5yaPb8izRya
X-Gm-Message-State: AOJu0YwGnXMBLLLqaipPxkC84Ljpr49Q9XWlzxoOr6gPYloZ+RESf/7c
	wvRiTQp1MKh8L2u0NTQw77nCSjfx/TKYxNBtKBmSop90PhU6qo3n
X-Google-Smtp-Source: AGHT+IHuOif+sr41Wa6qJZiIXUJCrP+dy9nde5UkkjUi7lZtnEMzCKmoTzi4xyZwuPt17BYbzB7l7w==
X-Received: by 2002:a05:6512:41c:b0:511:3deb:dd04 with SMTP id u28-20020a056512041c00b005113debdd04mr5654853lfk.33.1707823299037;
        Tue, 13 Feb 2024 03:21:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcaHrYBec3HafZpMtMioRY3hOYRk9oCN7ya6mf+Q8W5wWPKbuFNUgV4/eGDo9Irly4+4BdAmVfJkR6yTnZnbDE1kt4ulFSCMzy5nA+zBts26GBhBxu8GJL8xu+SjTwVncsNnxD7ri/cH6t5n/6YhX9I23ph2jhw1jj+hVwrZdPkUJcU84VMjCGfKkJGjylhUo92K/YMXOjZxd5kw==
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id h23-20020a170906261700b00a3c9951edf1sm1183888ejc.115.2024.02.13.03.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:21:38 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net 3/7] net: fill in MODULE_DESCRIPTION()s for plip
Date: Tue, 13 Feb 2024 03:21:18 -0800
Message-Id: <20240213112122.404045-4-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240213112122.404045-1-leitao@debian.org>
References: <20240213112122.404045-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the PLIP (parallel port) network module

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/plip/plip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index 40ce8abe6999..cc7d1113ece0 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -1437,4 +1437,5 @@ static int __init plip_init (void)
 
 module_init(plip_init);
 module_exit(plip_cleanup_module);
+MODULE_DESCRIPTION("PLIP (parallel port) network module");
 MODULE_LICENSE("GPL");
-- 
2.39.3


