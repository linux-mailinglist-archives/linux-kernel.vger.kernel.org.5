Return-Path: <linux-kernel+bounces-45876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B284376D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4F5B24FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F455A796;
	Wed, 31 Jan 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4gH3AKn"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A754F90
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685013; cv=none; b=V3FVIrZaKvVh2dTEM2ZLO/8MpjTxU/NcJaMLDPGSx4hXfIY4tXeJY/nqE3D9nEPhM30VrTe4B3tA8JWhNjgADkmdYBTOp/xuPNqTzSIOBQs+LbtUGegl8PkL9iu/HujTt11FiJIj5ix542Ib4Pjp/rtd0ESiE5U/jd5fjwBhRTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685013; c=relaxed/simple;
	bh=N7Rb76xtAihOSGgHLIxPhp8qnHuyGM9SCr1+zt+seug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O/KeCiaC48V5/Nq0qnr8U5cecnq6qazRuufV7MQlPrWQqSikHQcgjS0J+n3s8M1X4SN0b31y7qFq8Knbz5vuMQJ4EUQrDpKtH7j8EWcCU0Sh93fwUOqapPsRAIRG0uV1liRF8PbH+l38vzgTWxsdxWXRe9HkxUORJFXzB2sHSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I4gH3AKn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ed3101ce3so60328515e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706685010; x=1707289810; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzUML6NehRjq09oGSxNuYEWmU/TVTg/6MOHGTd1ruRM=;
        b=I4gH3AKnp82W+TeZRs7LUY7owupBFxsM5AZgX1eBBONeKyj0xCZ/B+jzIKEZvyMDbJ
         P1h+7QvX6bQ2LJKpGJIltrdnvODq1Jq+ulP0lzfx6TIuPMbxzCMYtcg6hdYndwdYsmC2
         o2BNeU2x55XI9Yhlmc2RHS/ZHIBAZMKhK+26esbTFA3y3qKnrOPRv8UYLUyhkySqW0oJ
         /nrCeKbSEwlME6c5pQFnrHwAgW3Lj2fk/jvYM11YJZdOLHsjhp/1uDD/3k4DBBsspIYF
         dC0IF2A24QNfGMs7FkXs4Ri+cGDWD0qC1ZRxWaak1X/3EEG53BKF2OOMNuMVH9VbElLy
         AswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706685010; x=1707289810;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzUML6NehRjq09oGSxNuYEWmU/TVTg/6MOHGTd1ruRM=;
        b=V+cGJXXuy7yhnP1XC3vUWuhVsBVdt6MS/93dRxu6eaKnA+YhJTSwSF1V0CrRL3P6Vj
         3DVcF3CyqJPbdgVOoUIfyaXdBJgH7jzvsRuZCXiIz4sEnDl4ONp9Z8+6WuX7P3BKSeRK
         eRTjAMejuAVV0azyUhEQBkmmv+MuPlIkOvSSaBCfafrjRAF1TmcMrWyvMLoe1YfVm5X2
         vUx8zXG/yZReGRt3ALXS5m6W6Tta2+MHdShHLrbh7/lZ0PRqKRwQ7zpBeBPADDAFPr47
         l7I5f//7lT0HITct0OvYEsspJsxYuOYaJHq+0iuYxiv4rWF2Bgv3FRBt8i0NLyWGc1ts
         UvhA==
X-Gm-Message-State: AOJu0YzRzMJIBwsQ6/Nh+ly4XjcuKoYlMAIImCPlZh2DN3AKVxgokrXJ
	MHw4faOfiU4BH44eOA4KQvRiDNu+xY2OyDjzYXO0aXmhME15XZC+ANBfUWY/9o0w1VHxh1R62f6
	F
X-Google-Smtp-Source: AGHT+IGOAuMjabgFSTRl/iF1SMdls3jHR5/paMKe+B+jUUAkMSCYfYfWIthewE8vE+w6Sj6vwl1wcg==
X-Received: by 2002:a05:600c:45c6:b0:40e:d332:bb8f with SMTP id s6-20020a05600c45c600b0040ed332bb8fmr668333wmo.5.1706685010527;
        Tue, 30 Jan 2024 23:10:10 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c00cd00b0040f02114906sm650532wmm.16.2024.01.30.23.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:10:10 -0800 (PST)
Date: Wed, 31 Jan 2024 10:10:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: rtl8xxxu: fix error messages
Message-ID: <7b144531-a8da-4725-8911-9b614a525a35@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The first parameter of WARN_ONCE() is a condition so this code will end
up printing the function name instead of the proper message.

Fixes: 3ff7a05996f9 ("wifi: rtl8xxxu: support setting bssid register for multiple interfaces")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 3b954c2fe448..bd6fd3120562 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3593,7 +3593,7 @@ static int rtl8xxxu_set_mac(struct rtl8xxxu_priv *priv, int port_num)
 		reg = REG_MACID1;
 		break;
 	default:
-		WARN_ONCE("%s: invalid port_num\n", __func__);
+		WARN_ONCE(1, "%s: invalid port_num\n", __func__);
 		return -EINVAL;
 	}
 
@@ -3618,7 +3618,7 @@ static int rtl8xxxu_set_bssid(struct rtl8xxxu_priv *priv, const u8 *bssid, int p
 		reg = REG_BSSID1;
 		break;
 	default:
-		WARN_ONCE("%s: invalid port_num\n", __func__);
+		WARN_ONCE(1, "%s: invalid port_num\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.43.0


