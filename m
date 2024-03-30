Return-Path: <linux-kernel+bounces-125885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E1E892D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE7D1F21765
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F29647F5B;
	Sat, 30 Mar 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDYRHKqH"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E43BBC7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833000; cv=none; b=A3WJTgZOcw0pU7B2l+uyyNoQP9d9t42yjAOSpfXp8w7hpEopwQicSgHiuyzSg3aafZky29V9MI5Xn0yD6DdAsoo/klI5arabEJ6WX/XpU2Lqx6KvesU+sG2nAvm/rmyuT4cJ3r0HTGfOwdsaxNulvmRbtx0JeZsau8q/3hY8d1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833000; c=relaxed/simple;
	bh=jpeN1Yqiy86IASrMw5IJ3mejJAeGCwK9WF/sWpjQR4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M9m6TGFNR5aOHZVKzB2COxCrCd1MzK7Oz1A1MLHmTM0SHcDb69Lyn06uecCOr6cpjQY5+ZPC4m26vWrKUuyTSH0lCrzOkQi+ipObkV4CZ5lJ64RqB8lqtoO2S7Zqz1ff4b2gg6olVhlPBoPHtfiLJ7kH4BCM4uiFB2rJsCbZct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SDYRHKqH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41553b105b8so8201935e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711832997; x=1712437797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFZ6AvemSHHbcptkzhx+Eo5vulQUyGFEmtEeYrKTAdw=;
        b=SDYRHKqHgC8sVL3OuWEyFHNfmVwVLU2DiDCA6TS8+9qshlNe6rE9veV3ziGHMMl0/q
         10KaSpr57Ochd33Li73lI+QqB8ZDDwqA6lQ4FPgv+qPMkHjLEleWtZbeYD4IRgvJK+Vc
         Ktxfye+CWgeX98pyBHbrydYN5WiDYKbCEc9vnvFmkiqBHWqDW0ZLrD6LKi+qvAUP51my
         ZdNFPkjapRRpjmW4+sFO+BMh/KZZtF9YufL7msB+ILKL94znr0TsclsYbHsZ5mjZlFxx
         QNgSM1ZTP8TkXQU0SQQLm5fcIBblTo95SCPAosN4SMu6l8CDZl9iYpRFy6CZQzAg2A05
         CZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711832997; x=1712437797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFZ6AvemSHHbcptkzhx+Eo5vulQUyGFEmtEeYrKTAdw=;
        b=gNWQIhOLopaadm5LTqeWKd5UdffjIG7ODUstBEe42DfHEjR3EDdpmTW3aqS57FaRfF
         mzLwscqLT+2YKFbIHBGj8Kwb+amrPFc8yDnSoGDWJNG4RJMkLhSf33WeqRa3qoPmEVre
         4VUNKxQyC0tTu7+qmuyGG/tBkH0Oj7t8fFRW/bO/3u80c2Ob8PUWsolNKjEeGps121Gq
         nm3+IgCerS9vy1eqXemYFeosMbTTw5vOPsT6zF2Ex44fJTyjcGRT4fUc0dsUpYjrzzOS
         YfwlhOr+aYYVIszbVAYKeiEcpKzLVljgNZZTbWgAI6/JGM4KFcGNJrgLniqB87NntBsi
         aUCw==
X-Forwarded-Encrypted: i=1; AJvYcCVYPkQALvd+UA/GqQfESQEH3tZlWUxanGjqxgCiGSWtBazM6SiLMR5Z6Q1MEXgqaTccVVn4WmHtL6Ac1jGrCA3hUA52n4WKicZmiVfq
X-Gm-Message-State: AOJu0YxQCDFIOyA0qllSJ2O+kOOiArNX38j+TCnfyPPh3HMFgdoqWveh
	3YK4nh2tybGKABstyZrqsMlb7r4GwcC55z/c55Y4t43UDlZUe3U4JXUWb3ZBEvE=
X-Google-Smtp-Source: AGHT+IGdfuyJzSIxSkkcrfLi5TlHT2+g+ykSm6cJanYYnEITTKeGYlCFJjitdO5Wziu0DGC7W0P2jw==
X-Received: by 2002:a05:600c:5114:b0:414:1eb:301a with SMTP id o20-20020a05600c511400b0041401eb301amr3461429wms.28.1711832997494;
        Sat, 30 Mar 2024 14:09:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id je4-20020a05600c1f8400b0041496734318sm11500465wmb.24.2024.03.30.14.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 14:09:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pinctrl: sunxi: sun9i-a80-r: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:09:54 +0100
Message-Id: <20240330210954.100842-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
index 919b6a20af83..5b4822f77d2a 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
@@ -169,7 +169,6 @@ static struct platform_driver sun9i_a80_r_pinctrl_driver = {
 	.probe	= sun9i_a80_r_pinctrl_probe,
 	.driver	= {
 		.name		= "sun9i-a80-r-pinctrl",
-		.owner		= THIS_MODULE,
 		.of_match_table	= sun9i_a80_r_pinctrl_match,
 	},
 };
-- 
2.34.1


