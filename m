Return-Path: <linux-kernel+bounces-47264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2BA844B21
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A48C291743
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669E63B789;
	Wed, 31 Jan 2024 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xK41zBb/"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E2B3A8F2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740653; cv=none; b=XHvPUHEYk1L4f0mbc3/Y8Rw5jMlj64c3+McF6yzLV5Q+ha8Fye2eDqZ7AX5VYAluHpH9ebQVILE3FGyoPZh971OnedS5KicOY/T9TWSVQ+SdsOkn1Yb8Pv91NnEg8z0qczW89QpZVaeK2zJaNH47ar7bgNw8ZLLFeypIhGT+47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740653; c=relaxed/simple;
	bh=LPemJiJDNeh1UetE8kKmrKuqS+5AJjwLvDRlUyR+Sac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MfnTFchqCH5LSQhPRiR8eu6cdfD8TWyREQdLN88vOXUlVbXCSqv6zWMKydBpdhtXFlSA5COnYUVC2VDI3BXSRO6MqMvuwzPV191yUuFIfCSHpJOZh1/iUnob+aosB2oTw68toH6V1+qpAKsANiXnSOb6+uDEkkeASQg4lS7mX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xK41zBb/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-510322d5363so383035e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706740649; x=1707345449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ugdn3z0/uQcbatROe8KemahKg/7jjvyhRHQgV89WdMo=;
        b=xK41zBb/Lj1h91UQ8DKnG2IT/SiD0N5spF5QLZZ/SQ7h8F4J3uzdRh1KRsrtPkX2HH
         W+k9mn8r46yuDQySDv01qsb+3gStMFt5EDnapwsCaBIzKdCtzFkY37TxxDO370nIXYlu
         R/MerCWNhhHDl9pLFr5z7e2029SwFr3CDjnPHJwoMKBDoz5tohUFQiFymkiP3ABahN+C
         1QfIo7+ZOZciys6lVQtwmh0GSJkitsMsdYjpwzFnE91uSJ/HAZj4djVR1z9fok7ND53r
         MRVRhutbPREJ3oL/fx0OCRX3PDoatWOAa/+s6vBA0uQY9lO9ueVDjUxH37G00JyW2++w
         ZGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740649; x=1707345449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugdn3z0/uQcbatROe8KemahKg/7jjvyhRHQgV89WdMo=;
        b=JT/FHzdIq/hBy6RfT9rItPxgdxePFMfy0jUuB8TGaWttvEqOUVrMbkWWzYDrjtivxc
         bujWlPm2bZkt7PzwrMMZ7u4kcArTXguzErSA0oYZOjIMAhcOqE15buW0ef96UhXzfddF
         QPuDcn59JHMlPIDcEQ0KMo5S6gIiZkkT4mnkFXiKD0AyLZ9vTUaDsNqp/VfOyMe1BL5J
         wLoh1Gd+JJbOWuYbTde8OQDr7svGaKAJLPuUNbG+5GUwnzosJkCu3zYHq4BbMVeIbINF
         uvxmR7av6wvqRT+HnzPEuO8GRzDq1Td7s05UwUxLcYD41hDOjjhKFOnGRzlyLljYVN75
         CSuA==
X-Gm-Message-State: AOJu0YzDvhGFQFyitUx/CAv9NEbSEFc2UZDsm4QcHFwBVEOuFMiw7PJi
	M/9jFo42XWRrfVBVTNugLxWwSboPxwqEkshe5WQJcLZr8laT01AtJxSIhcZUZCA=
X-Google-Smtp-Source: AGHT+IHpMnm1d8vLLtzUTLq39bCw1dZD+PGE4OO35/C+h81CWbe7/xfuSysDp+9/iHlIPVPxtuq6YA==
X-Received: by 2002:a05:6512:3692:b0:50e:7fc8:f40c with SMTP id d18-20020a056512369200b0050e7fc8f40cmr615587lfs.54.1706740649659;
        Wed, 31 Jan 2024 14:37:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW1n2xLa5N2sdxGgFM2Mp6PPCu5n7ZYPla/ItamJtmzai0Ja480F4WO/7J69GEWvh2m5OQTNI2nCHqd6axJIyZ/qk7kRIeei9WHnKXHga3EMElD/lgPCxBQD7ORw3ltBA4DMFAmYFwIcz3sBS9FQYpVsVuiTaLdJNoK/NdQ28W03SDcX46ptn8r8OjNUf/I8ZUvQgigK/jUO6A0YPx4uLtLdn8Jp1vCYPHHBJolVXJM6yamXBuhFrLq+WlFVDJgYIc6/nz7TOM8A6KYcW5k3U/HLPtfR7Ccj5ODsE8bCLXV6jQIJ+RFCmk1MybpiiqRHxXuPAC0oRRNnXFa+Dn6HrcJ1CBQuccG22xhNN0vaj8d4vvQcjIhf3BQnU+ri/pSt5UjliEk36j1DG3P9fQZKteoMoG2oU4lH4OaVJ6+CeJDKdDnoKz4UCbfP035vk/QA0AJb+2SuPNbOs0KOA==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b0051023149df3sm1976021lfp.248.2024.01.31.14.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:37:28 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 23:37:23 +0100
Subject: [PATCH 4/6] wifi: mwifiex: Drop unused headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-descriptors-wireless-v1-4-e1c7c5d68746@linaro.org>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
In-Reply-To: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Kalle Valo <kvalo@kernel.org>, Arend van Spriel <aspriel@gmail.com>, 
 Franky Lin <franky.lin@broadcom.com>, 
 Hante Meuleman <hante.meuleman@broadcom.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Srinivasan Raju <srini.raju@purelifi.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The mwifiex driver include two legacy GPIO headers but does
not use symbols from any of them.

The driver does contain some "gpio" handling code, but this
is some custom GPIO interface, not the Linux GPIO.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/marvell/mwifiex/main.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 318b42b1896f..175882485a19 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -28,11 +28,9 @@
 #include <linux/inetdevice.h>
 #include <linux/devcoredump.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gfp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>

-- 
2.34.1


