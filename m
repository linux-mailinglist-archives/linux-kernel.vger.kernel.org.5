Return-Path: <linux-kernel+bounces-131277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B33F898599
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F82A1F27AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F538811E0;
	Thu,  4 Apr 2024 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjPeZ8cT"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A2F8004D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228424; cv=none; b=b9hiP9jMFKYYK7imp0MjQChcRWhzBD9r2fxWWM+5WsaNZaQbeE0E/GK3jDVoOQlSGZkfz2mPO0+EZCeXnmyYLS4zWMF6VJa+3qRvIWs9Ciyd7TWj2Sfz6fFAYAY88AxI0LSxKi6Dd57LMM0mX+Zsry9AmOeiVXAd2DB56iLv9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228424; c=relaxed/simple;
	bh=5vDpEzWOeRFVUxsC5ueIjdNgMUPXl4u7A2JrAbQ+ovg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HFBbPV+gI8WBIYBwX+C++NK72xvwTOd6mAlXTh+UIKylLJyWmVd97BNrd8N72EBpM4dLfiT/zfapXcQvRDe55qepP7k7lTevADUWQrKpwED2Dabo1OdyhcJaJqEIJzRaVPDmjD24m1qthKQR4HDnFSLjgnQIh2RZOo3I3Mg4FHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FjPeZ8cT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d23114b19dso9503081fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712228421; x=1712833221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rChZ9UiC5LEOmFsB147qXIMI1R8mmS3WQNsfr48Zgms=;
        b=FjPeZ8cTh8x5haNXyBhXyteFYvVIZ8+o4+gc3yZk8YsSQcWz1ioWHjjDjg4vDZlj0c
         VjECW+6QRDY+pThIh+oE/evqgHlMwjsDjOeMlykXtdaum2FACNwEQqDJps7V3othtHle
         gDvW7Yccmcl2Pg5tdoNwV2aarz6XaSH5NwYzIHCySPN+ZoC1W2jimDFiegP8ijuGpD3L
         Asjwz1ZpQRGXX5+8JINrgmncrK/TjuiB90VGGjaTNHZUYnh7D8j9BSBc4b19nGDYH3YF
         1+4Yy5W5B6z78OIgWHZiYlRrtBKylMR7AHVdI4POvWoIWl/mIaveRBFkqwmkstLLHmJ9
         wQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228421; x=1712833221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rChZ9UiC5LEOmFsB147qXIMI1R8mmS3WQNsfr48Zgms=;
        b=ifv6qC0EJBrIn+onK4qfiazmsI8KAVIGtoDn87BNEiODlH/MNurl6W+x+ptVGGsqN8
         9v7gv+w+e8BmKP1mqPYCyeMoRYdvGxwMJohZ+rFGu2vqZuK+Nj1dwPjNCBqxwzV7mNG8
         zc1OMDvMGs/+TqwYq63cwhhBrt0R/gbnlvfXjcR5j6UdzzAG7tCxChir66wgaglweQ2j
         emfsf8K+v7kr/+pWkb1AhkVKhsxGFdm5zO5Il3pq7ktV9t6T4g/GjgoQFwVsPUksggCP
         eq+ifuY+0FanJWmTTQxIoiw/CtvMTU2yasQlAbg0zaVjeb+e1F8aiQgh3BIXxPZn17Bm
         5F5g==
X-Forwarded-Encrypted: i=1; AJvYcCWNZtucFKS5s4qlTac41Mp8ML61SGSIwkkEpQir3NXWRZYoSSfO9X88eZGGrSy4EjikGjJsJKQxzSherflGKk2rEwX52Vx4PSEAiuIn
X-Gm-Message-State: AOJu0YyWHhJomT5tQ6vtLlpGZA7nF73pZV+7a1ppKpC0CRnc+P5/MrE3
	NGvss81evfsIW6YYF0yB9+Q6r3h6SY+wmGsNW/joyXFJDiFmz7OCFIJnm/CQfiCzqmpLToaKYSQ
	E
X-Google-Smtp-Source: AGHT+IGLj9gMfinVp4kaCRhsThjciVQsHSyheIJUESN2bhJ9YJ7rs92deDBvfq0b7RjBO2kUgtvFqg==
X-Received: by 2002:a2e:908c:0:b0:2d8:2f68:d41c with SMTP id l12-20020a2e908c000000b002d82f68d41cmr1809509ljg.3.1712228421267;
        Thu, 04 Apr 2024 04:00:21 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id m19-20020a2ea593000000b002d816c0500asm1079899ljp.118.2024.04.04.04.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:00:20 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add a git for the DT IDLE PM DOMAIN
Date: Thu,  4 Apr 2024 13:00:18 +0200
Message-Id: <20240404110018.568143-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let' make it clear that we have git to manage the corresponding patches for
for the DT IDLE PM DOMAIN.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fb5b93dfbfe..c40c580f6df2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5586,6 +5586,7 @@ CPUIDLE DRIVER - DT IDLE PM DOMAIN
 M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
 F:	drivers/cpuidle/dt_idle_genpd.c
 F:	drivers/cpuidle/dt_idle_genpd.h
 
-- 
2.34.1


