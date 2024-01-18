Return-Path: <linux-kernel+bounces-30556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A1A83206B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7FC1F21CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E492E642;
	Thu, 18 Jan 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO2uE6Up"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F52E413
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609263; cv=none; b=dOBQb4jimrUnaPEyDLbkcwuoy01zFMgnFNkLSwPYIhJ2y9nyUMqT9Bv4qJljAjzcpMaEi5lUl2AzUfoSFEF733B/Wi7wUIv8l3WWq9xIJtUgzMJjSE4NhSQAZdXA0BJHZLzPfGRoNKM6p+SsWH2977fD6MvD38JmVXohgs2f5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609263; c=relaxed/simple;
	bh=ylo497vrS9F+ETAy9ybQ2/eITqabfK68j7rK5FzECyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTw3rEeZU7YFqyTSPSBm7WAI+mK6LBA6pTyCDcgzLJjHt7Hh6RcHj9Zvaadb8d9ZKE7eqEm3sEik3YWs72btHmYJYLIvMTFRz4TNwNNwkgPGFP4fkPMJIvqF7mSAcIAwh/eClkiWy0uREQONErbKKZR4gHuxVOclg7qXElOaavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO2uE6Up; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so346575e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705609260; x=1706214060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OG1lQkxW6MHGxP8IYqG9fcxPOWLktFdBZC4G3nspmY=;
        b=CO2uE6UpLqVCtBxaYyA84O8hNc5sm/iPx8GwcA3sdZZoflChNHcamWNtXTxElK0JxG
         xEInobzhYrnm1+vM2SVWM3/NGwY5w2pubLgSHbF484gv6T32rSOVpnpwtJFNPtD0qdBq
         JGQ3JTq5MIert5gLYcGWNgpmFrxso3BZ8FnM5QACB76api7vSk4aSnLN7dmaz1jYG7C/
         At+ry+bVZvxgCETqJ/+Lwn8wFINVrP3QXC4Yly6w6fLmvLUijrOfgKC07EjalCMAUhgc
         WorrvO3SIj7ABZ9zaUMAuifjpm3d9bec9UB5lWo6vvxymZAyReUmuQhLSpuOAtr5x93f
         VsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705609260; x=1706214060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OG1lQkxW6MHGxP8IYqG9fcxPOWLktFdBZC4G3nspmY=;
        b=cyE11W61WaOKCkwPb16g0eZRXAncioYRPpEXZo/UcXUjFTZn6ANGlwrQc95wNf74W+
         Axpqvq8XUbWW9GetkJae4flDfxKLxkEJc3qiTjXvD/Z8wUpAEGx6xMVImT93DBH9C7x+
         /xF/NTt8occQEkS9NCcGQD0QiQcOlohgEnjyhsbfUA52celj8vBuFJZGRQf+UDga5SSD
         Wn5r/iVBv1ooOxpFqBgj30xxsoXyT7nEv5af55oF8PuIU3DoXPQNegAANzDoBaysR7ZI
         Io3Ni/DPiNvBydHd2hET9bUNdSLpTeNuulEgcAG53L2F1tNQEP7KrQAZGZDVny71E5Ib
         qbqg==
X-Gm-Message-State: AOJu0YzaXRhOj9aHTHQ98HDs9lFusi6qmTjd35UYT2fKl+IZyegfHZAe
	h14wrJfaf7NVf0QWZKzAQqEMp0H8jE/4h5X31NQfp2RluUa9zR51
X-Google-Smtp-Source: AGHT+IH8XeUGZlVFd7HwPY1S2QP44VUM1O5Y1YiOs45bSy6gY2HfZkW4e8AXDSDqzVtlbaY4klCNYQ==
X-Received: by 2002:a05:600c:4f42:b0:40e:5a80:6177 with SMTP id m2-20020a05600c4f4200b0040e5a806177mr810142wmq.69.1705609259903;
        Thu, 18 Jan 2024 12:20:59 -0800 (PST)
Received: from localhost.localdomain (host81-156-206-78.range81-156.btcentralplus.com. [81.156.206.78])
        by smtp.gmail.com with ESMTPSA id bi15-20020a05600c3d8f00b0040e83eac47fsm9892872wmb.5.2024.01.18.12.20.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Jan 2024 12:20:59 -0800 (PST)
From: Levi Yun <ppbuk5246@gmail.com>
To: james.morse@arm.com,
	pierre.gondois@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v3] firmware/arm_sdei: Fix invalid argument to unregister private events.
Date: Thu, 18 Jan 2024 20:20:54 +0000
Message-ID: <20240118202054.81795-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118201514.81046-1-ppbuk5246@gmail.com>
References: <20240118201514.81046-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To unregister private events in device freeze, it should call
cpuhp_remove_state with sdei_hp_state not sdei_entry_point.
otherwise, it seems to fail on cpuhp_cb_check.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
Fixes: d2c48b2387eb ("firmware: arm_sdei: Fix sleep from invalid context BUG")
Reviewed-by: James Morse <james.morse@arm.com>
---
Changes:
    v1->v2: add fixes tag and resetting sdei_hp_state
   v2->v3: add missing resetting sdei_hp_state.

 drivers/firmware/arm_sdei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 285fe7ad490d..973972d50287 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -763,7 +763,9 @@ static int sdei_device_freeze(struct device *dev)
 	int err;

 	/* unregister private events */
-	cpuhp_remove_state(sdei_entry_point);
+	cpuhp_remove_state(sdei_hp_state);
+
+	sdei_hp_state = 0;

 	err = sdei_unregister_shared();
 	if (err)
--
2.41.0

