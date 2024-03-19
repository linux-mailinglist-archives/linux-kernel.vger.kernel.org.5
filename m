Return-Path: <linux-kernel+bounces-107315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A49487FAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859A21C21B62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449E27D414;
	Tue, 19 Mar 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/mZW4cJ"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092907D090
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841304; cv=none; b=dpxgE/P2qKYyjw4VLTCcqoW2jpscmIbLYv1FoPhJo/7pPAWmSEIc0jdbvPyxoGJEvw8MRvCdg2znyBmAy3zfHIHuCuM6WUi7vh+DOYjdOx9VofMgEQKzQUAzdF5IwnfE1aBMolPREsJiHwKYUbTTixAiOYLY4KoAbf6ZsrL4rXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841304; c=relaxed/simple;
	bh=5DGsGaRy1eaD1w4IlwHuhLUmJWP+gJa6fNqIfuItsZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDO0QqN+IUjtWxQQMyJnhstMPYhSfeJQUVRD9IZkJi+UMd/6roEN4bTl45t1stTcpsxZX4JPsSX7H5aiIT3+7HuA8V3/BT4057K3RnYA3lJZxgLDEWJnUz4AtDEP1o1PnK/AJaTYt3eL48kGYjgubTxzgGrcnut3UVIfBZ9c/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/mZW4cJ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c38d4b670bso870388b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710841302; x=1711446102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZwvTELM6ByipvSR/wfDTLW1X7/KlLM1aOXjOWDL7DtM=;
        b=U/mZW4cJG/rtNBcBdJLoJ5y98UtuFxaHIoqpsaKXc5YwgW0ApgJZTOv6ofbbHis6Nr
         wc4c5J32lVqC1n0dib9V3hDRhpKCiqsSwjraBhWAbBOdFlP/x6qQDyIKOM3KD1KMblge
         bwiQt2H8kJPzRy0KxfoGVnNexKaGtVt2kLKeIZIzFm7I5g6kyPByhn/qFAEAQBxXoaXM
         J14OICgf9rRPEYd24OpBy8+yAqtgarKc7xTbCLzKw7pbpqnnSAl6zI3eo0U5vfJSYNs9
         Feuh/U/+QIraMs9nASGlORjLUD6spo8LNXtf55JnXFlkwjm1TDDqtailm+TUdfqcwO8G
         Xpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841302; x=1711446102;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwvTELM6ByipvSR/wfDTLW1X7/KlLM1aOXjOWDL7DtM=;
        b=Gx9wwofTo9MMp5WGpbZRrpb2KA9xqmUpaIE4QF28DlShvn965LEoe174dD/7sT1yp4
         dQ76rsqFiMZxBwHhAyLTeW93+hRgJ0PzxTYPWMpopFySIYyK5O3HvTKkXp/CTmxKWp7u
         FUUdy7YEzfkcLndQpLAkBdVG74jOs2M9D/WRReDQ3j7/u1+aYIbahKWRdIwUEX/86f4N
         FgwTwL6L/Wy11bEEfq3TEIQQNiC0EkgqOWPgKJJiLulwi4pFzh0mu/1LapOn0i/+Bc1s
         0wyG32Q63KZ4eBZx1Yqyn/RKtJQ1U9Bjapgn8iVusOZX0LkZqPIYDwNUzNIGxi7HQnrb
         Ol2w==
X-Forwarded-Encrypted: i=1; AJvYcCXVTYVejlJrE8UxEymp5d9R4F4IW0EwA9SQDj9mHoD89Rz58h5eVzWxW2z8GyxEiKX5sStrqXiiK1I50R+uVDAUIHSvGHeGeL+8rDZ5
X-Gm-Message-State: AOJu0Yz4z7n0SnUaH6TkCu+69P6P2Vw9yH8hcLjCdx2KgXIR8ZxC7g5x
	9yxfVFmwt/2hWAjYqw3bClqSmbQ8wxPWh+eebHuvnNxFQ5w7gxx7oU0hIdnx97unFMFp
X-Google-Smtp-Source: AGHT+IGwOyvn+IjcJV9WoC0uqc9TVdMrZljGfip5NbPFBLB5b5fIZHNI4sP+MYpz3oKDJCbVHW9TSQ==
X-Received: by 2002:a05:6808:1524:b0:3c3:88f3:96f2 with SMTP id u36-20020a056808152400b003c388f396f2mr6552697oiw.0.1710841302069;
        Tue, 19 Mar 2024 02:41:42 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id i185-20020a62c1c2000000b006e583a649b4sm9708761pfg.210.2024.03.19.02.41.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Mar 2024 02:41:41 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 1/4] mm/filemap: return early if failed to allocate memory for split
Date: Tue, 19 Mar 2024 17:27:30 +0800
Message-ID: <20240319092733.4501-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319092733.4501-1-ryncsn@gmail.com>
References: <20240319092733.4501-1-ryncsn@gmail.com>
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
---
 mm/filemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7437b2bd75c1..f07ea0b97698 100644
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
2.43.0


