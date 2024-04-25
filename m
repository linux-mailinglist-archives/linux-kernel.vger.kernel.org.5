Return-Path: <linux-kernel+bounces-158642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F40EC8B235B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913D71F22690
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656AB149E0C;
	Thu, 25 Apr 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="NRgp8HGU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8430149E05
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053588; cv=none; b=gCmqtPlv9qnNmf3HkLe2Qv4Dd+94VyRLh1AIvB5LNYiuS6elK++vTKF6E5mjf5zHcKZdTKzRm9CWAZ0pocIWhDsImAVvhiiJzrL1srKcXFWB91felYyDLUJee4vJfFYB5zSo1UH9FYkyJbQ9Pqx4HvHa4BqeoApVz1m3yWsCbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053588; c=relaxed/simple;
	bh=KbpZ8d+RgwRLaIMQKqSigv1pMFc5n3ynVMEzJAYBd0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lr0SxINP1JRMzB57csC3AHdk8wTuwDo9lGirPAFeqIxtkeYx01JbDqMLv0FLyh0SMeqKpTeTvtB5pDwtc/urAjVY7yOpatKmkllMYwyAxt7d41ouLvFDXoCaH9BN9SJTWE2YvhUBzzIydP5Jt3F8atZk0ws72Aykzqv3l+zUUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=NRgp8HGU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b6254a47cso3044635e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1714053585; x=1714658385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR5Th4rgsENBGC1XHGIaoOrv3KgiGLQWWbPFYgnaOZw=;
        b=NRgp8HGUleo4R2R34dIp8M961Lo6v72fpysxICs9WvOaGeFSK+YeZQUQYXpQq/qRBo
         KURk57Udb+3Jcntf8mGanubEU2y8KPx/3LVeq1vNXztSZ+T7wAf4p5/OMWd0wGjFv90x
         ZbIXAjSjacCrVG2AxDBKMRv7Kt2zbsZJtwtkko7f22tZHmueAHVedM35krXyCTVSwPoy
         oXbgJ8pGgwwDpnrf8cpCgM/fzwv696JYqII+biPcxq8zaLTKRZYJPqdZTISaMEiGdHe1
         MjXke+uVRWdmySD9qeDjaVbphDFCUEMMRJCkopdsU949LUvaT6y+/dH9R+ZB+/nzRXEp
         qS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714053585; x=1714658385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR5Th4rgsENBGC1XHGIaoOrv3KgiGLQWWbPFYgnaOZw=;
        b=bce2Kd5M4cVJH1gwrKYYUWjQ4NuZg5LATgVYRlhEoXjdXprvdtllq+PuL2Ea0NLrHz
         C1KRKJda/vaAHdmbDEVpvhlYo3bB5SBA75iWjWCj9rwEmkYZs+/VYrJ9Vq5vIeqFIpZN
         XFz6oNPG4U7AtCYjWgF6y1TCDoMEMVBza1zLq/sS9Dvfx5Ra1ybYkp1KsbQ45NlXKzkI
         9vtkO3GdqqVHyZ74iSicSXAOWRyXfDCQabbssQfuyQqVzeiipF5PnER8DVPTbD4380/P
         ggMNcB9H8yGg7wVx29RLbd5Y+VMhsNmehEZkgBApbrI6MH0ABoW6eMTdcwBQ0xwD6VBD
         OMxg==
X-Forwarded-Encrypted: i=1; AJvYcCXiCjy0I8AGlqkyX2+cmAUR6bulZw1p+jmF/33O6b2/OvYXn7zYqNMRfzqSNYF8x7O5LN6Z+iWptxFqApEl0py2YwofvWUWHtByXZpi
X-Gm-Message-State: AOJu0YyCcofG5u2hdtdDKvoKsF5/g7QpYCx38i0lEjwX7V3KScLCTk6n
	GwRcIh4mMkJTjrt9+Sqa0II1+Unp5aNOSC5um9E4/K5XKVPgmcByCFQ2LCF3mqnlabPrs0ptb/t
	w1Cw=
X-Google-Smtp-Source: AGHT+IHGaFhMe5yKL6F/+83lu4EV+Z0XaPXrPqBYQngm29el1FnXbXjw74hkSw+DvAhi+EO+LTBgaA==
X-Received: by 2002:a05:600c:1d04:b0:418:ee1e:3445 with SMTP id l4-20020a05600c1d0400b00418ee1e3445mr5798812wms.26.1714053585319;
        Thu, 25 Apr 2024 06:59:45 -0700 (PDT)
Received: from fbxleo.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b00418a6d62ad0sm31479464wmq.34.2024.04.25.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:59:45 -0700 (PDT)
From: =?UTF-8?q?L=C3=A9o=20DUBOIN?= <lduboin@freebox.fr>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?L=C3=A9o=20DUBOIN?= <lduboin@freebox.fr>
Subject: [PATCH 1/2] pinctrl: core: take into account the pins array in pinctrl_pins_show()
Date: Thu, 25 Apr 2024 15:58:01 +0200
Message-ID: <6df39bd47942156be5713f8f4e317d2ad3e0ddeb.1714049455.git.lduboin@freebox.fr>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1714049455.git.lduboin@freebox.fr>
References: <cover.1714049455.git.lduboin@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We previously only looked at the 'pin_base' of the pinctrl_gpio_ranges
struct for determining if a pin matched a GPIO number.

This value is present only if the 'pins' array is not NULL,
and is 0 otherwise. This means that GPIO ranges declared using
gpiochip_add_pingroup_range(), thus making use of pins, were always matched
by the pins in the range [0-npins] even if they contained pins in a
completely separate range.

Signed-off-by: Léo DUBOIN <lduboin@freebox.fr>
---
 drivers/pinctrl/core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 6649357637ff..901f2f9bf850 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1672,11 +1672,20 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 #ifdef CONFIG_GPIOLIB
 		gpio_num = -1;
 		list_for_each_entry(range, &pctldev->gpio_ranges, node) {
-			if ((pin >= range->pin_base) &&
-			    (pin < (range->pin_base + range->npins))) {
-				gpio_num = range->base + (pin - range->pin_base);
-				break;
+			if (range->pins != NULL) {
+				for (int i = 0; i < range->npins; ++i) {
+					if (range->pins[i] == pin) {
+						gpio_num = range->base + i;
+						break;
+					}
+				}
+			} else if ((pin >= range->pin_base) &&
+				   (pin < (range->pin_base + range->npins))) {
+				gpio_num =
+					range->base + (pin - range->pin_base);
 			}
+			if (gpio_num != -1)
+				break;
 		}
 		if (gpio_num >= 0)
 			/*
-- 
2.42.0


