Return-Path: <linux-kernel+bounces-146658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACBD8A68E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989F4B21B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A9128385;
	Tue, 16 Apr 2024 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oby7qBd0"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0D127E32
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264325; cv=none; b=RNZ9QdNctBnyiLilT3UJUPneU2Y2l0P5dL2lZU1lRBrjT6yzFt2RvanGc3VCIo58e9+Tc3gIaQB57wteNDa2WrRz1hYcd5XzuSV5OY29pE2heSnePMXgAs26NAM2byrdFLbYHb0QqCdod+sNmnW08V6bLmuGPVxaqrhtSd1nwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264325; c=relaxed/simple;
	bh=4kQYUNc9mzRT+PHh7G/UYt0sG1PbuqHRv+Wn2eqN/AY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RrwGkr5ZkCzpICoESgFNy1LbQ7UWiiub8Jq5CIGmvLLckR3LvHt2PprTrNyiglV/8J48SJFWKWSn6RYGWYUWdPQzm403b8LzCEI3Ms4Ll44apWFiZigXhm453D94ANkrR4g8WlXUYsO0WrzANKe9pDlcLkbwjHuZHf/TibSaFUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oby7qBd0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4155819f710so29056855e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713264321; x=1713869121; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73kbs5VJGtZKxtjSM37kUl+tdcgdJXHyl+eR81HvUto=;
        b=oby7qBd0/9+6m+BiyWFSnlE/N8CM5qBPLR1RWN/PcjNe3oBVinbEzGpVAOw7M/Jmdj
         2rBNGNeK2ufoqpmTts4aRDQV3gSUOhE80889iiPzEyol4VQLzJj1FoFw5cyD5Sq02FSI
         lzuySQtlvHryYVUU8fjrOXcONU1P+GmBYeLS8B+Q6YLZluZUB/r8KhfbpKc4ZHPkGf+Y
         MwSACzei7D48eNVBfhZb/HDEK/Rh9Fz1jsKf4ykhyVA8HKPNaN/lrSskgjaTAb0tpmmP
         Ep/GsqWEBoj44noh7AEp6AHpLfBu89LaOGU2hnMNLtKSCAq1HBlajrzaKmUy1g9bbL0k
         Nxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264321; x=1713869121;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73kbs5VJGtZKxtjSM37kUl+tdcgdJXHyl+eR81HvUto=;
        b=qesWdWQJqUDyOMh6JQHxDhaNt/lDz4WGum9j5w3hVwCz9P1xJwxVKLcREQLmvfHw1y
         8+33f6QwIjZc+kQSvQds5yEQ5ObJh4gIkikLTw2KqS+H7eTZqL2PfNo7V4bObV28qbaG
         s1yaUsfr7AlXvTFtGvuXGojOdnUJsoFGitD/wHGCNX5ZMY6p2ZmRzZX05pfw7OeWfT2q
         8D72wbeJBj1+oPMFqpJs9hy6MQHASUmTvE9FGJ+0/cp9Hyxq9MUkubP2SiGhrbRjcrNf
         /I24WGSR7AU2GpBgblhW2gCekRLTesMYRqNUvkKUZft7TgLMcaCW7CaVLB9DctcttPpp
         VH3g==
X-Forwarded-Encrypted: i=1; AJvYcCX4+AEaDPE3vqjHAMq3eZShj/cZyM5Zv5TO+FNkOBcCPbKygnCt1D2Ze03aLNW24s0ndU1faRTsfnyXF4OIoAvCw1ddO2KqNcYvVQ4v
X-Gm-Message-State: AOJu0Yw9r0GNBWC5gWn8Q8pvn2CXE0GP+Qf1r9CG/qV5q4XGrbjPqW7S
	KFdh5AzMwZE1ei9JTWkWa5C+VreRCNrPYmv1+PhoODLJAnYzKhH/NhM+qXhfjoM=
X-Google-Smtp-Source: AGHT+IEus0QrFqsiwanPBFgmjAVGHYH7Qs5v7rzguwH+k374rvHQ1vLsxPb89GflAFcILrO0wlrBiA==
X-Received: by 2002:adf:f404:0:b0:347:eb55:8f5 with SMTP id g4-20020adff404000000b00347eb5508f5mr3633603wro.7.1713264321139;
        Tue, 16 Apr 2024 03:45:21 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6709000000b00343956e8852sm14470141wru.42.2024.04.16.03.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:45:20 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 0/7] kdb: Refactor and fix bugs in kdb_read()
Date: Tue, 16 Apr 2024 11:43:17 +0100
Message-Id: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEVWHmYC/x2MUQqAIBAFrxL7nZCiP10lItTdagk0NCII797Sz
 8AwvPdCpcJUYexeKHRz5ZxEdN9B3H3aSDGKgxmMHax26tgwLIU8ClYfr1yUIW9wjdphCCDDUwo
 //+k0t/YBfZhk+WQAAAA=
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=4kQYUNc9mzRT+PHh7G/UYt0sG1PbuqHRv+Wn2eqN/AY=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmHlZMs0vwQ8tOuyT2arstjNqtfoUEl8ZHGNwwr
 tCDqzdIr+CJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZh5WTAAKCRB84yVdOfeI
 oTcoEACAPJFW5SjQtzaP6yGRdaHprXnRsogRVkZu6Q7ty0kWbvGjFDMKiIzb6A0ttgGmwyCIgcZ
 8iwQbdZFWioLmhyLSU6TDlt5tMOvzkjELjhJ98xkyPu7EMJYuqVrAzev5fm4sRpOVq+M1mCUm3w
 Qa7xPTYGMd6V+P8dHNTiZmvm7qYOausPaN0+X8kbiqWSs0FuTWZXmyV00MY6FxpW+7PGoQFFMKN
 hdQ6ftQXESXkqWojUg/9oGwdryVBl9S3lK3NOwfr1qhI6SsGWNMOomc8ln3MYfzsoH8kWIBSHyT
 /1hoxSVDbI7cri7PtOXvorJ0zuXkZ+oLXZrec8EYPOfoJoMNdhfsuaAg95IYsdkxF+dQv1EkA4T
 ViJUgS5+aeVWX/53vhPs/jqIn/245moTmTSRNF+TrnKvGPXvXduk5uCNP1cVNGm0pJO9hAjz6ic
 Shsewo20iC9Fiza1yLwFlmDDZXQdXGGsr1zxHDGkFKkmwwBL8szle7ZbgFJ25uc/H7hBvJBaetk
 KQmZoIUdVmHgkb6O60FSIvSUrR4d0Gt+615z+rXhsGeEbBvflcfFbOLoHLABQwRJGJa7klj+pem
 2KF+WxmoryDpTDWZ3g2mLejv2ucfXE5Ovw4okZxKQ41cZnbCcSLrpRcYHuxxk/wOtKKUTSQyMLB
 NRHWG6fvJT/V07g==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Inspired by a patch from [Justin][1] I took a closer look at kdb_read().

Despite Justin's patch being a (correct) one-line manipulation it was a
tough patch to review because the surrounding code was hard to read and
it looked like there were unfixed problems.

This series isn't enough to make kdb_read() beautiful but it does make
it shorter, easier to reason about and fixes a buffer overflow and a
screen redraw problem!

[1]: https://lore.kernel.org/all/20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com/

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Daniel Thompson (7):
      kdb: Fix buffer overflow during tab-complete
      kdb: Use format-strings rather than '\0' injection in kdb_read()
      kdb: Fix console handling when editing and tab-completing commands
      kdb: Replace double memcpy() with memmove() in kdb_read()
      kdb: Merge identical case statements in kdb_read()
      kdb: Use format-specifiers rather than memset() for padding in kdb_read()
      kdb: Simplify management of tmpbuffer in kdb_read()

 kernel/debug/kdb/kdb_io.c | 133 ++++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 75 deletions(-)
---
base-commit: dccce9b8780618986962ba37c373668bcf426866
change-id: 20240415-kgdb_read_refactor-2ea2dfc15dbb

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>


