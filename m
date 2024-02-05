Return-Path: <linux-kernel+bounces-52393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB484977D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E6A1C22675
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE9D175BC;
	Mon,  5 Feb 2024 10:14:18 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD017591;
	Mon,  5 Feb 2024 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128057; cv=none; b=iXs1G2a5ujziE2S82YZkEZy2BgH4IOasWamr7q0yNhgPi4z1igTahTTvcq/3Q6P3u+/qPFZOqvY9Qm+xL5mBoRJ7rbnekwttvuu+UUZ9GGvRYptbtbuTQka7X/L/hcgKTtUdBVQsB4XRj13tbwrABptW4nPYjHnYmAfJShpmVBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128057; c=relaxed/simple;
	bh=cLlSglYo5zPsuAw9zjY3og+Hq2BehO4c6tsRI1MltBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRYVLKbcCtCOkC1hf+/9OlHZG3e/+wHN4fBXl1fNniV9zJ8oEPHMaD6d8XBreARmGKlloaW8kUIzY8Fj251QUL1hZCvSfSL50hdcEdLZ43zeSEGyUnT4gWnUzQ+dXzOJbg4xl+8G7gUH4h7HeaNL2I0E5zGRS9i/ZbXeTyxO5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51149561a39so1362866e87.0;
        Mon, 05 Feb 2024 02:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128054; x=1707732854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeD6034q8KvdXPJcZmxXEmuuy9qPKKAyxbAnHHYFoBw=;
        b=bh5qrIsb6A70nxaTDhOQzKSL4g0G83nDCwgiiPVxoGyjS/4txcCZtc22A96fgL1zgb
         J7mhlzzsxmJBPerAv6vviQkN/6HzeFiFMQt0apElgm5jQWHDiy6NYffm/gtg9olq1Idv
         PVtSeFkDzRj8xTe4v3OaBdoQijsJj57qUrYefKO10CFy5m5Qsr1tpd3SFnjRTYx5yoX/
         w2KlTA3SgQXRKftaodar7knrWkM/GlLuJxInOZBaccPMa39DMMbEfixTDY11503yOpAF
         jtcVA8TCtGYDeMPbq6zZ4zw+5jLRAGgpNwqWICuYjxlklc4mWrPbFEeq/DYJt/11DGKI
         33YA==
X-Gm-Message-State: AOJu0YzD0UTQREEeOYPKHbojRFWW9H43KyoWS+VFjSjATdeTLicTYXQv
	udqO55F3Kgb3rXgC1hMjWptBbqv6deqiJm0JgG1JAhPU+PtIs8Ob
X-Google-Smtp-Source: AGHT+IH9vIQfMphf+ijF86P4/5pCidJzrw2PA9uORGeBmFw466WTI8+fY5JCTopxOoT25xS1y5EItw==
X-Received: by 2002:ac2:5dc1:0:b0:511:4c68:f3d0 with SMTP id x1-20020ac25dc1000000b005114c68f3d0mr1718997lfq.23.1707128053944;
        Mon, 05 Feb 2024 02:14:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGJNaFjJFONdP4Ck144ao/toV+XFRQ6NTZNXDEuYQQOqnz1DoHWE05TZAy7GzDMtA4NNbTicG0GHftjIXW+7HLkSuXbZmuVXdSvwTMlbI35nJpQ4opkia5Ei51hxgVE1sWCdZuljSO2rjhaRVxYbrKbZ8qKYObcAeAEGry7CyvHuePusM2cg7xHjMjc1O/uwm427BC4o4x8QjJxj0nzOE8FLKqsP9TLPDUNDw=
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id vh8-20020a170907d38800b00a3708787ca9sm3910043ejc.146.2024.02.05.02.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:14:13 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net 02/10] net: fill in MODULE_DESCRIPTION()s for mpoa
Date: Mon,  5 Feb 2024 02:13:51 -0800
Message-Id: <20240205101400.1480521-3-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205101400.1480521-1-leitao@debian.org>
References: <20240205101400.1480521-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Multi-Protocol Over ATM (MPOA) driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/atm/mpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index 033871e718a3..324e3ab96bb3 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -1532,4 +1532,5 @@ static void __exit atm_mpoa_cleanup(void)
 module_init(atm_mpoa_init);
 module_exit(atm_mpoa_cleanup);
 
+MODULE_DESCRIPTION("Multi-Protocol Over ATM (MPOA) driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


