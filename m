Return-Path: <linux-kernel+bounces-51673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10034848E1E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21731F2255A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0651F22EEB;
	Sun,  4 Feb 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="oJ/WjPrq"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F7E2260C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707053996; cv=none; b=SwiOWsBOBsbO8TbtP6Ai1ryrt5jPXGoLqlEKOsU9nlO8cZcNB8TvRSJpgVLiho1zuXMz8CyM0e/qkNDyzuKLkt4eLLGiRtUGl5Mbpu2uJ3PAmgF3ge2aKy96DrSKMcIENGls+FlN39LNwJb7mfMqC3YDayT/UPEqwHZVmmwPlMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707053996; c=relaxed/simple;
	bh=JSbhb9OPyI48ywBtCJEfyrdloBMHffBsAxBgZQ83mds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RwWIT1Ev/0wC3DBOmaKQNAznieiKSfQtWn/5zPrGVfq2/6XhZKE/xch3OAd3mLOdpWhVFIznCBn3MtsfcfWT5o70KfP6eU1Q7LFm9JY10nMe0hWfn5Wup4e5DUc3hu7fNnOEJnw5RFvqNdOlEJ8I2N08Z+OqZsGyxuDQWwRrun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=oJ/WjPrq reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8df2edd29so2837090a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 05:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707053994; x=1707658794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZR0Vx+PAXq3U7uwJOXiA9Qb+UCDSL9VfDx1t5c/o6c=;
        b=uT1tOosbJ5B7QijwHYPC/uRLv7ZuIwQ2KhNqAX71cFyyupzxZ7zSl+Y7l1jmuMZGKl
         cMK14AXlO4ogzbLRc7DqQE+lFu0tC1UBLnFhm7XDs5BwFtEIb8GnaRjsC8i3x3psqwkr
         wKt1sR8jewrbt/CepCzVu//L4HYOHIROIP8BSAjmAhuP+7vslL2Z9YXvJhGvPorGY+Wg
         TqYaIlfcRhBgvVToMqKcb3SsKhMVpdjfkIPBRoGyaC+bzIoDKRRidSU1TcVENaw+gVBr
         Am42Oj9ip/DCJo+Q4WNTYooImV5ngZMErcPNob91ER/jhBUzxM+z8gm//W/Cqy+Malbp
         nt6Q==
X-Gm-Message-State: AOJu0YyOgnAly3VLXfxKCR/quwmZ2iDpKB76Qkb0dljM+gmtO4lUTQqN
	Uw9pQTwYJyok3m1j+Cmm3FY32Au04qx49WXEKPCOSlgcNBwMjKkT
X-Google-Smtp-Source: AGHT+IHh75Hs2O3RTSIF3tEW9eIdCW92RzhtAlaSnMNCskXgBrEcCp50OjwdDooDagH8f+GfLH9QoQ==
X-Received: by 2002:a05:6a21:195:b0:19e:3161:2c97 with SMTP id le21-20020a056a21019500b0019e31612c97mr11191065pzb.10.1707053994240;
        Sun, 04 Feb 2024 05:39:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU6rNZj5DBexTnI2kyR6nl49hctl+6aD6brK1V+0x7whIpF6VZ7AdnpL1iCHLjm2sn4LuglKbvOjIqk2VzVmqAVtZDzi0+PtDZc1MWNhOmzO+hbMvTjFrY9V4ETfUDNeTdORR3cakEvU7ADnp1HKR1K
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id jx15-20020a17090b46cf00b00296540086a5sm3264279pjb.23.2024.02.04.05.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 05:39:53 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707053992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZR0Vx+PAXq3U7uwJOXiA9Qb+UCDSL9VfDx1t5c/o6c=;
	b=oJ/WjPrqlZbSFfgdUREtxd7yqLtiGcqvQeaOo6ywOGZYv5Bpg/DEDsCFdWuCTKP5VyXuKY
	a2MxTQ21QD55FksYRl4ZZlkI6OYjtOZghWKafyScTuUOKDGfSuCTMxcIuzU1IWr2IAVZru
	TWv8ELluyeYHLZITbccwfc6lFXoeifCvanz6RjdaBe57FAbc6OedRx2Dc8jRHSBf/jedxf
	MizjDBWxCQnrFEVdRKTR7Ugt5zunS9l1Mkvw30Rf7y6xKdx8C5lkX05wV/0QJy9V59zBvL
	fPC9pYVr5NitAXnzAC/kTKnpYZKFUBYAccL7gSEAHwyRi1sTcXqptDuJ86aaTw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 10:40:16 -0300
Subject: [PATCH 2/2] clockevents: make clockevents_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-time-v1-2-207ec18e24b8@marliere.net>
References: <20240204-bus_cleanup-time-v1-0-207ec18e24b8@marliere.net>
In-Reply-To: <20240204-bus_cleanup-time-v1-0-207ec18e24b8@marliere.net>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=935; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=JSbhb9OPyI48ywBtCJEfyrdloBMHffBsAxBgZQ83mds=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv5PAmPK0eaNvEQ6Gq5VNauK53Q+pIf9QXFuYK
 Llut2IznuaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+TwAAKCRDJC4p8Y4ZY
 poHzD/4y8lerTf4BThaSvJWZp+BVzoKUJt1ZGCL5a6Jrn/Lcj5+r7t+zhGnfFuFpNGvxBKHiqEH
 mWXOjKz9jXS7fZspMpnE/4x96Q+TnY2SPZYFcYlf5FxiLSeKbrHKGw95Yy9K3kkm+pqS+5/k9Pa
 Nxlah8NH/Gyvis1eWM4gSrIery0yUdwVlgI8j0zrjnfiO1+FEgbf21woe6XD+5f/fTOB1BJtvWk
 lNymcR/UO4zXWFcnccT/tGNIBcY8WV81krYfBRzyt7Z7DxkITuBDbXYYYC1XZ9iP246PwI7Cs1k
 yuW2uA2LtqDrXSF5PdKTJnQ2Pfy6ESbiUgeVLgI2hrdMtkIVK/SmG/1+Yr/zQW5au6d0OVgrNWd
 PECUT/HY5Z28bg0Aw59Zbib+tQop0NcANx2G31Y24UtWrAKvVwzSjEzJHzULino81vHziOYlWKf
 t7YWrgZqQp8qo5nh90TEW4ayak5HrXgby41CMfPogNFwtFMz2Jx8QjLSrLs5w+5bOYBxcS+XE/1
 ZH5HqMhofU5TgI00QewXa12vdQbhIwBuf75Iz9v14MOAIKO6iOL1ITlyYvcYgKJBIJFZy3IrGQZ
 d++n+BUWHDsCCNFVgSHDfOr75ttTgCv4UnufxI0cbi6Yim900T3tyn6fhWdVqqs5urBGfQTrsnT
 gW/5nFFQRTJG1ww==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the clockevents_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 kernel/time/clockevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 960143b183cd..a7ca458cdd9c 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -659,7 +659,7 @@ void tick_cleanup_dead_cpu(int cpu)
 #endif
 
 #ifdef CONFIG_SYSFS
-static struct bus_type clockevents_subsys = {
+static const struct bus_type clockevents_subsys = {
 	.name		= "clockevents",
 	.dev_name       = "clockevent",
 };

-- 
2.43.0


