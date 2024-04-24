Return-Path: <linux-kernel+bounces-157559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF78B12D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5593F1C24CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD041D556;
	Wed, 24 Apr 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC9stBG4"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335A19479;
	Wed, 24 Apr 2024 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984673; cv=none; b=szONQ8QjoVENL3OT28557IxUApyWHEqA07snCgT/AKmFNyQQb+VA6npxkMyBT4sTbr2pM2Pc/LyFwD46vuTjqrb+gJbScIylY8yge28aNIHg9MB8Tl9692jupli6bKuoK+DI/PDqBp5A2EgRFY26HSEyqIbFqSrChl8ZZmCZknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984673; c=relaxed/simple;
	bh=aoossQlzk+5pxRemPeXnUmuEGyFVwNi8l6egUwStIKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ScSxCfWa0+PrFFQOYspH7ZD+mqOtiIzMUyozx1o+ZbYZ5rHFUSCc5omtmePWwCJ12UXDjhknvKy43pQbOaqj4H1+Hm96rHclVxc3Zsntp25jqtl9EJuSxTlq7WMGo6Yyddz8w0Dk/F/bx71k+Y/HubchpypbQvGLxLA28XWWYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC9stBG4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a519ac18b3so202190a91.2;
        Wed, 24 Apr 2024 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713984671; x=1714589471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAbLEAVuW4sSbM42C7LJb1PPQ7uzIoK60RBbrjt4ULU=;
        b=YC9stBG45AopiYHBzSVGrtBdrpp5tLuEBYSIVGaRR+rGrim9i5sVY1ghFkKtnu2vNv
         E3SHb9tJXHlRWgo84FG+D4rqnvQxVkqOzIkwgJKHqtZG74QwBIcqmrrKsIzqRoytNSjd
         aV3s+GFjTIgjo7+a2yU/wPTfwSKPUIYry72hrHNtiJePZcMZ9e5Uq4Gj//Zw8WCbc/BP
         k0NUx+9eOZhd1xi/+HdXnxjqgoWFmeK7FTkD4Vi8mgEUoZ/CWIX2lCUafTRx2qMbjtfE
         24AgipDACX3EhZh7qTzXjIS9f1/FnolMoYUUMx68FzFOBatftCVylFBJdAm0WhEOedry
         ks+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713984671; x=1714589471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAbLEAVuW4sSbM42C7LJb1PPQ7uzIoK60RBbrjt4ULU=;
        b=NgtcEy5kV2df/nbL78xY+YpuN9Q1Zavi0GLl5SlIscdOZcQC8O2Ka2xD5VIg+/GPeW
         4yeqKVyqH43wfz5mHk4ul6IY8XBHxsSLMNXUYjG3bUarZ0xanYUAdiKpLisBvjpZ4l/O
         zZb88BWrNPenxwMIny7tXEOXGG3QczIJZdiO09Zp4RFe4nZdzYdMfAJChSKCz2M+MDSK
         q9JtXIPzg5XybXDaLKssIJiR8NQ3Fgyd07SmVbOH3F5zB5GQHv5Wy1oeSCsu9MdAWkud
         UcMnGcg75aLUPYhIiUf7xwjcHLO4mkd00GdC+cC/B9bLYFhgimH9yIOGezH87Jp7qQJl
         JSsg==
X-Forwarded-Encrypted: i=1; AJvYcCU67Bp4lkzrZ3w0HMxuh+h4wlccwCsU1bV4mgdaek3LN2QXKXAVQliF+9uxOQEiNuVjE6Bmr3uEPUo16+DnVGrMfCNyeg9c83SYuY7JIobFunBLTndyLFwmWhQIXm35SZvM8GOjgKpXnmHXvqxKn529AO/EFI4FjXc30vstFjvN4YBew2k=
X-Gm-Message-State: AOJu0YwbmFMrvc2o2EWIBiuNF4bXVAuCgdd7IbOTYoo0hOTCkSKk4MyW
	w9tyK+ckW8TYKec4gUk7zzu5SpnRh9v9HlwZ6IzcEuqvPw0QARyc
X-Google-Smtp-Source: AGHT+IHl4DSRBBK5EU7FX+5Xap62TW85oFKwK3LiNNqa2nIFMaTpiwS5/2XjpkpWxLT5r1xxzB4UQA==
X-Received: by 2002:a17:90a:d90f:b0:2ae:e22f:38f5 with SMTP id c15-20020a17090ad90f00b002aee22f38f5mr3107642pjv.10.1713984671079;
        Wed, 24 Apr 2024 11:51:11 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001e425d86ad9sm12268728plf.151.2024.04.24.11.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:51:10 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Phil Elwell <phil@raspberrypi.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH 1/3] dt-bindings: gpio: brcmstb: add gpio-ranges
Date: Wed, 24 Apr 2024 11:50:37 -0700
Message-Id: <20240424185039.1707812-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424185039.1707812-1-opendmb@gmail.com>
References: <20240424185039.1707812-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add optional gpio-ranges device-tree property to the Broadcom
Set-Top-Box GPIO controller.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
index a1e71c974e79..f096f286da19 100644
--- a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
@@ -62,6 +62,8 @@ properties:
 
   interrupt-controller: true
 
+  gpio-ranges: true
+
   wakeup-source:
     type: boolean
     description: >
@@ -88,6 +90,7 @@ examples:
         interrupt-parent = <&irq0_intc>;
         interrupts = <0x6>;
         brcm,gpio-bank-widths = <32 32 32 24>;
+        gpio-ranges = <&pinctrl 0 0 120>;
     };
 
     upg_gio_aon: gpio@f04172c0 {
-- 
2.34.1


