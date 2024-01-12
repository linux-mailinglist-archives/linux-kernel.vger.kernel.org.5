Return-Path: <linux-kernel+bounces-24723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D71B82C159
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11071B21A88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7066D1CD;
	Fri, 12 Jan 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyRU9vVZ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B31E529;
	Fri, 12 Jan 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so5344224a12.0;
        Fri, 12 Jan 2024 06:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705068404; x=1705673204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m9xZTx11OmgCZt+qN/iW5iWbq4AJYapvnHQdEWI74RE=;
        b=UyRU9vVZC/dFr6i3hALrMfVj7zSgeSRn1p/Z3z7KbZ5273vXu5q6ioBqTIdzaa8MIM
         7BNsG17d1MlCnMTYOy4vSxiAOsM0JNqSFtRhVXd/IH8knH+dhd5j/iZfkSa26cJEUQX/
         6Vvfp7FSJEw2U3zZmZLP0wIKjlh4YX14xPTQN5EsfSV+CI65Ve+n5CsY/pWUs0Mv+KbC
         sjzoh0Mlo1RdqrO+3t/EVLBmVJhpYlRt6deYLvOEWV2WkLE9/Ginoz4iMGMAobYDfcSj
         ut7O1WZ09riK9xNk623kTjVY+tDfknmFmXVWqQG0n4gK8GfPMhDd2Dslq9laxAZBcFig
         TuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705068404; x=1705673204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9xZTx11OmgCZt+qN/iW5iWbq4AJYapvnHQdEWI74RE=;
        b=YkcOGb7hg4unOjt2dyTsFgUoOWMuR9IiEq2lves3n9kh+1EwLMHMyfhenXtsATaVnf
         doI2cVf4kOs8Mpq8wEqZi+0EV9T2cFIV9TvXGUjwXc3YpCNnmbJKWs6QLtdfdPYGzxl2
         pubvy3I8mDxtmBQ5L+UnbC1WjjufAgjkcxlMo1f/UBqY+m0FlAkEddo/e13ejxWllYQX
         w7aJbfwt5ZuSt2vN7xQS7ipxx+UBtroNn2ZdOcxMJHgO+c15lzTTTrv6g/k/J7QLjxpm
         kOGA6IuJkd3NZLwBTlgLw6KnpfdynXdpTRtBBq+e5HekvxSaweCOWPIcNKtUiTGl/FoN
         xbhw==
X-Gm-Message-State: AOJu0Yw9f5h/eij8ei3Ij+N3phSKV6xqTeGccQJtH0sisweE75zGJgZK
	xxO062tMOG+fAs0tYKE7UdIcDvNRmUPxIg==
X-Google-Smtp-Source: AGHT+IELP6mAVOCbg+QO6yXHR3nqBP9HTdlE0d/dqFsUzQFooA9uKD4H1PHnYb7WhBbk/eTc2dTClQ==
X-Received: by 2002:aa7:d687:0:b0:554:242f:2ad3 with SMTP id d7-20020aa7d687000000b00554242f2ad3mr755904edr.48.1705068404439;
        Fri, 12 Jan 2024 06:06:44 -0800 (PST)
Received: from mwserver.home (217.97.69.136.ipv4.supernova.orange.pl. [217.97.69.136])
        by smtp.gmail.com with ESMTPSA id w13-20020a056402128d00b00554d6b46a3dsm1840245edv.46.2024.01.12.06.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:06:44 -0800 (PST)
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>
Subject: [net: PATCH] MAINTAINERS: eth: mvneta: update entry
Date: Fri, 12 Jan 2024 14:06:28 +0000
Message-Id: <20240112140628.62314-1-marcin.s.wojtas@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as driver maintainer and restore the maintained status.
While at it, update the file field to cover mvneta_bm part of the driver.

Signed-off-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4194f414dd2c..39eb0a6a2927 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12869,9 +12869,10 @@ S:	Maintained
 F:	drivers/thermal/armada_thermal.c
 
 MARVELL MVNETA ETHERNET DRIVER
+M:	Marcin Wojtas <marcin.s.wojtas@gmail.com>
 L:	netdev@vger.kernel.org
-S:	Orphan
-F:	drivers/net/ethernet/marvell/mvneta.*
+S:	Maintained
+F:	drivers/net/ethernet/marvell/mvneta*
 
 MARVELL MVPP2 ETHERNET DRIVER
 M:	Marcin Wojtas <marcin.s.wojtas@gmail.com>
-- 
2.34.1


