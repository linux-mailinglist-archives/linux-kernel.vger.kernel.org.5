Return-Path: <linux-kernel+bounces-61206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD82A850EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099B71C2167D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC87464;
	Mon, 12 Feb 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHVahMUL"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B410A23
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726873; cv=none; b=nSZYaKPTGa56h6K0Ff7icpom+k44nHgV2ajw+HrmiV1HFhSz9ROVazinmWzosRZM+Fcly6xzd6W/ia6iZASDts25kfaJtNwHot7WQygFPrrdwxIJlwowN+NzB/M0OnWQ5m69oHG/PEGsvWgVfdSWyFjPpxy0CYRkT3cBCmxepU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726873; c=relaxed/simple;
	bh=HlXn3h+kaQ0ElD0RQ8Ha9CS2kgD8dt6z4YNhjTiljZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SGJhZpooEa7Q/0sIE5e5igB+Kvq/ZJsGBn/SQPfAUK13X1vr5Lqj29m5V6FFgwAlcZ4z112dIqQOknWCNC1APd/iuOc83m6NlajH8/6z9Iy1pe2Tp1xeb+u+6PwjcpPgkpX1nuJsCByz/hCHQsUbeNmz7RwHWcGQPVPFWXHU4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hHVahMUL; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5114c05806eso4568955e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707726870; x=1708331670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gv5wKhvz2IkMiVTY6JBsKVbcSvEbLs7uJIPS1y/GGHA=;
        b=hHVahMUL7Ie+bKU+dKwYKKqREmmxVR5DYml1yKsOevkq7Fyc1rggzJIg5dGjU8aTRT
         zcamReHQwBxIt1g17pjoqcaZKvVw0C/msaA6RqZ+7S/0pn5vekU2qP3H4kWvnn057oQE
         MLI8aAGZcfH8NZDFNYUGbtJsNuDw7c4hNuUWftJa2gx7LrcUosN/aZpGf8/RHwh/gknv
         Rc8jYSylKOeChQkViHIsSLaP3UFAuI6i/5U/SHVEOJ73lxcd+gR0l9vL+HqFUDKEZAhg
         3bCUfxacZC417VUSrXsSvhzerTzuyMCCEKs124Elbwyk0Yez2Gek7NkFbaQZtPkN2JIE
         NBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707726870; x=1708331670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gv5wKhvz2IkMiVTY6JBsKVbcSvEbLs7uJIPS1y/GGHA=;
        b=AFzk+N9bIwrH3E1d80b1uKIZkR+1th6s2UTwBh1GWmEedGYYPW8oZcBdHQ/1QpLTEX
         rrdBAgDKHi+B8njBfc2tDXKSna0SZTB4JBXwYfmaPYJDHJgKVyoXoQkgtsL/b+grilCn
         hY80X8ctLR3xpfbsXENrHN8hqeQlJfcyLGJ5hkXUa4eAdN/7vkVPsrVpa36NjD0U5p+v
         uuLOyTtah/jGWjUisgQEoQ4+Hmj+Bvzu6oxLXVPm+YqbsKRodiWqtNuXkdwPJtv6rjS/
         u6KIKC3npu25kWni96SG4w80GOG3ghHVxch5QP3GXvkbUeBAVoPeBDCajC+Zz6UDqisu
         ApNA==
X-Gm-Message-State: AOJu0YwnBwkceEP37feVza8P9HEkUHl01jYbAiVyRFGN/G7vsXzvFjvN
	GKHQyhnBXRBjswAMEjnU/5BqOK0NwoKzkMqRhtIj649au3BflI7Dj/RS8HIc+w0=
X-Google-Smtp-Source: AGHT+IGxLy+g+zXrEzb6fK7p+nnX2U1Ebgap6clpVk38ct0XBVElw0mqtAvQW8HzVwU5SlBZAAnqfw==
X-Received: by 2002:a05:6512:ac3:b0:511:622a:97bc with SMTP id n3-20020a0565120ac300b00511622a97bcmr4332576lfu.18.1707726869900;
        Mon, 12 Feb 2024 00:34:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2/OOxwQkBfCOqrL69OJ2Og2SLXQbIWxYUftBYaEdpQwcR9KvBj46EaZ/X0p/ECSV6BbcYFfOvCibaxWiaIH8O+40/0TBOGdb42Ra6AqIcOSAVcCwIRGv573ZeMpqVLuvr4YJKNtDlP1j41LiGSiUDlEV69bRyqOTMbMYfZeoUo/MS13JUVmk16rtLWu02oj0un0+f1SKLSEAaBfb9PkljhnaKNk1CPrurjGfcdB+GOhPzgd8rYFcgPH+jHSpRy16k6PrmGXja33hzMUoD53Nor5PTjdU4ofSJDeXN6g8VETb2iRyUdxHLWklpu51CDB2n9fe6R729XyFpfNQzuu558tQ+sozROWCXAuzkCRW8gjrffGPFBWPP01J3r+6Y4uah0YAmR41ZtopZObs=
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id y12-20020a056000108c00b0033b40a3f92asm6111024wrw.25.2024.02.12.00.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 00:34:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/3] dt-bindings: auxdisplay: hit,hd44780: drop redundant GPIO node
Date: Mon, 12 Feb 2024 09:34:24 +0100
Message-Id: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Examples of other nodes, like GPIO controller, are redundant and not
really needed in device bindings.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/auxdisplay/hit,hd44780.yaml    | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
index 406a922a714e..73d07f2cb303 100644
--- a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
+++ b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
@@ -99,17 +99,7 @@ examples:
     };
   - |
     #include <dt-bindings/gpio/gpio.h>
-    i2c {
-            #address-cells = <1>;
-            #size-cells = <0>;
 
-            pcf8574: pcf8574@27 {
-                    compatible = "nxp,pcf8574";
-                    reg = <0x27>;
-                    gpio-controller;
-                    #gpio-cells = <2>;
-            };
-    };
     hd44780 {
             compatible = "hit,hd44780";
             display-height-chars = <2>;
-- 
2.34.1


