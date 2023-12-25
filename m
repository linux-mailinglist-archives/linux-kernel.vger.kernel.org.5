Return-Path: <linux-kernel+bounces-11185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449AB81E2A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 23:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A601C21326
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD16E219ED;
	Mon, 25 Dec 2023 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcgqU2T+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F753E15;
	Mon, 25 Dec 2023 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d2376db79so39804905e9.0;
        Mon, 25 Dec 2023 14:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703544768; x=1704149568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqN9XpjV9cnb6hmKZsdbfaWdcO7AePtC2sRrkO7qsCk=;
        b=mcgqU2T+pnSaCgLyKuhxSByCcJTOQI9P/HiaguQipwVmegwCz5xWVnDQIR+g/2W/8G
         UYnzbpxhR0saSZqtz+qVuKeohBH8ZRhLEVrRywHywJ6qNJX2ovHu3DNTV2VCZN1VcSWB
         pTOd/K7x84B8/RvetjlZ1ABSqhgWyzJ0RVqAgCJxCrpie3xlXEJU0XSG7IfoaGDcgaCu
         pZESdZumxEA7LA8z7SKtZl6ORRf2MkGLj9+RLnhkD+AdBLoqnCYULrhSUCKuUgNIDDbj
         KNfkGz+QStNAwei07BuN+1/kPn9ETeAYH9JSJlhvMChJHTDTut7YxNKfZyPcdYON4B7P
         Lhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703544768; x=1704149568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqN9XpjV9cnb6hmKZsdbfaWdcO7AePtC2sRrkO7qsCk=;
        b=Jlzlt2VV1LjXfFYJ3W6zvz+Qz9B3gI7W8TpTF0zdXB3j/8lLxjn9IG+KxdIFmgRzuH
         bGBdg3eSpSZnz662HtIByajRLevJtQ+8hDay81sA0MaFit0rRsK712uqwn2NUWtY7EaH
         ayzI7jH6LpAiGDDWj0AmTXh/a2D9jHkSiSClWGNUFcmsmB4H+DSOVdfUQADBYua0jkLK
         3DLLV5GmtyiLXue6n52sTqCpuc45/bIzoUEsFoX1+whsaccxksZprUe8o+4os3PPk2HZ
         tiVVsYEs2c/Vp+CGmdQ2Aam6p80wjDE9XD6mLDnOjxrnQub6Sy1hIJ6l88Mjaj8rrees
         QCQA==
X-Gm-Message-State: AOJu0YyK7yk0M3a3zg2u/kEvH0PZ2UgWABT3kWj26Q2shPtlrvdzYMZE
	alYKP2GY3oWeLV0aoglEFMZmezbjUJo5fA==
X-Google-Smtp-Source: AGHT+IFU2AefuduuvCAuQSv9oEppGQFQeU/S0giQOx/Qv14gcLcMIaKWA1OvD/joeuFcz5fcd/o0ig==
X-Received: by 2002:a05:600c:1387:b0:40d:492d:dc93 with SMTP id u7-20020a05600c138700b0040d492ddc93mr4231085wmf.64.1703544768332;
        Mon, 25 Dec 2023 14:52:48 -0800 (PST)
Received: from JWL.localdomain (217.97.70.170.ipv4.supernova.orange.pl. [217.97.70.170])
        by smtp.gmail.com with ESMTPSA id wj24-20020a170907051800b00a26ac6d55dasm4535158ejb.46.2023.12.25.14.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 14:52:48 -0800 (PST)
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	linux@armlinux.org.uk,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>
Subject: [PATCH] MAINTAINERS: Update mvpp2 driver email
Date: Mon, 25 Dec 2023 23:52:45 +0100
Message-Id: <20231225225245.1606-1-marcin.s.wojtas@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I no longer use mw@semihalf.com email. Update
mvpp2 driver entry with my alternative address.

Signed-off-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cef2d2ef8d7..38d1e4a7efa0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12815,7 +12815,7 @@ S:	Maintained
 F:	drivers/net/ethernet/marvell/mvneta.*
 
 MARVELL MVPP2 ETHERNET DRIVER
-M:	Marcin Wojtas <mw@semihalf.com>
+M:	Marcin Wojtas <marcin.s.wojtas@gmail.com>
 M:	Russell King <linux@armlinux.org.uk>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.25.1


