Return-Path: <linux-kernel+bounces-27302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C1982ED84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116921C23248
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD581B7FC;
	Tue, 16 Jan 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpH/qViK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A101B941;
	Tue, 16 Jan 2024 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e800461baso11416915e9.3;
        Tue, 16 Jan 2024 03:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705403770; x=1706008570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bV4EzhRkZw5eNG7ZovPTr2GfxWsv5MIBKsQhvD/ibb8=;
        b=CpH/qViKI2WF0U05Ch5X5Je5Wd0ltw8HvN/j8jxJ1lFd9RHGiNHXGEyzt/JeXFheLd
         6UHHXpd5mOIeZTH3iAWSPcXkT5SsSbKKecpxDgMjOXz8ikjh9M9nazadeCYBcfGK4Lw3
         ImdkLXk//ZWbuulAMbU7bza5Q233BD2yzoL3R5Nftqx4xQ0q9DQnm9VRyXA6wnuJvGGC
         mGFIROezKGQulHH/6027z8RxEvojGjqYBrf55xZ4skQpBC0va1xZXRznSfAI20JeXI1S
         2baRgoakt696H8R9QpgK/3t5EX5i1h2/hSLphDkDQNfm3iNWl4KwBPCfAmlcthz1GZqV
         TKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705403770; x=1706008570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bV4EzhRkZw5eNG7ZovPTr2GfxWsv5MIBKsQhvD/ibb8=;
        b=TDcY0yd/7C48oPIGaGd0xdx7P/VsDdZhz1kO2GBNMSTv35JRzHZxtXCm+YtCZdqclI
         x7ZhsmLXS30V1wLf9QqTTUYgCP2im8grgpsAesfSO+A3toh/EnXLb7K2K27eLvWEgIEP
         h6+N+Hm8y2ioPw+Dc0bmQyYqXsfc1qU10ducVHptn+XAid3vgApn7AQ91L3wkjw6UWw0
         v763EumJG8HR5E71hk5mtmoXGy+WeoxZTGqKsicQqaAOmWsuMGPP3uVPoHSDSS9izJR+
         9Y1D6pTNx4yDgwNs6zAcfhqGeAjKVX5y9N1pGxvCTMGYfzp/V+9/K/DFfICUWelG7C1L
         inhQ==
X-Gm-Message-State: AOJu0YyTv2r3U09FzTSRvuoa52Oe3DUN3CUF6QwVSWqHbOcfuz/uZ+fp
	MO6jKyIAE16KImaoj4KrXfE=
X-Google-Smtp-Source: AGHT+IHM9MvVRGvEUj/8Da942kzvMhJ/jHKDIdyczZcz2JU+V7Py2yNESnBCAoWPKM+3iTd1BzZ+GA==
X-Received: by 2002:a05:600c:3093:b0:40e:4303:df0 with SMTP id g19-20020a05600c309300b0040e43030df0mr2089782wmn.258.1705403770493;
        Tue, 16 Jan 2024 03:16:10 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b0040e77ce8768sm7102765wmr.16.2024.01.16.03.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 03:16:10 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/nouveau/fifo/gk104: remove redundant variable ret
Date: Tue, 16 Jan 2024 11:16:09 +0000
Message-Id: <20240116111609.2258675-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being assigned a value but it isn't being
read afterwards. The assignment is redundant and so ret can be
removed.

Cleans up clang scan build warning:
warning: Although the value stored to 'ret' is used in the enclosing
expression, the value is never actually read from 'ret'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/nouveau/nvif/fifo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/fifo.c b/drivers/gpu/drm/nouveau/nvif/fifo.c
index a463289962b2..e96de14ce87e 100644
--- a/drivers/gpu/drm/nouveau/nvif/fifo.c
+++ b/drivers/gpu/drm/nouveau/nvif/fifo.c
@@ -73,9 +73,9 @@ u64
 nvif_fifo_runlist(struct nvif_device *device, u64 engine)
 {
 	u64 runm = 0;
-	int ret, i;
+	int i;
 
-	if ((ret = nvif_fifo_runlists(device)))
+	if (nvif_fifo_runlists(device))
 		return runm;
 
 	for (i = 0; i < device->runlists; i++) {
-- 
2.39.2


