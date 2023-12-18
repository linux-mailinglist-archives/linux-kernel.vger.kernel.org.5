Return-Path: <linux-kernel+bounces-3337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E65816B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681CC1F2111D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D91945A;
	Mon, 18 Dec 2023 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYPJaB+u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5D19458
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55359dc0290so914951a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702895330; x=1703500130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0uGkSaUKMQUNmBDew3hhiDswln1HBKsL2x7GLxqndE=;
        b=WYPJaB+u0HyTXnSd4y8QIqWTaFyHpedCiVzZ2AfMthezgb7nPz9encvg/692s6aTlj
         1zUB06F9BfeNBlGgNqDAxQGPTgC9hFlvLTDyCEX6Zr0KfY81UgzSiOluTvq3/JiOZc5G
         X8MePT525lxsySSvk80gFHgQK2i1PB1jEg9kFWfNhHbyKus6NBH8FcEudHxvc/I0l1uM
         WglRw7EZvzwQGtFqO+TEevsSQXxe7sQrlFFz7xcEraqviysS+6s35vxLxOBw21NAirnS
         pjVgpoKAuvneTEDs06HgtYFbHxm247Ck3M+P2A7q4JWSrlAObx4YkCkXFbZBjPJTJhZ7
         SUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895330; x=1703500130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0uGkSaUKMQUNmBDew3hhiDswln1HBKsL2x7GLxqndE=;
        b=vxQfpwUaLlHNt4oUvP29wacCQtbyQ8MG0UnpqogHuGSrc0P2Z8XpbsXOuCwvyJtXHP
         kqLekoTwYPPHJTldfnT4PjJ7HeyEIHcHmuZvL/5EMrXlXZHTnvhDO7tAslVecUxZRcF8
         Sbuba8Jw2oJqmsQ1pX4J71LHQlIVM19eHDdPJCKhREMDTuIxfdnMfkQk4GQvZ+KJHBOx
         I5HowY1qI6R1ezchjxks6DcCQgZom49UwJCkgKQ7WAWzeGD1ZSBoCEnDLwRPtYk9lBx8
         tBLQPse+PpTbMJWrlEfS5th8+WjxdOPp6aQmoYo+IZxCNS/cRu/xX4rm8aAsPwtPIwKm
         WkHQ==
X-Gm-Message-State: AOJu0Yzfaipn4jQsR1xeTRHz3szQGT5ghcmaVmRZG7V+0GOiqpJ540H8
	v+3t+D+Pm5KhVaehmH9+sH3Eiw==
X-Google-Smtp-Source: AGHT+IHCeu8ZzhmPds/NFMvOCjSzvkZ71BeYmz2sMnBC0Zue6Ca65aVLmHb+vB1JQVh9BpbG66Xf9Q==
X-Received: by 2002:a05:6402:28c:b0:553:5927:5da7 with SMTP id l12-20020a056402028c00b0055359275da7mr856800edv.11.1702895329760;
        Mon, 18 Dec 2023 02:28:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id c6-20020a0564021f8600b0055306f10c28sm2083464edc.28.2023.12.18.02.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:28:49 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] regulator: MAINTAINERS: add status for IRQ helpers
Date: Mon, 18 Dec 2023 11:28:45 +0100
Message-Id: <20231218102845.41875-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each maintainer entry should have a status field:

  $ ./scripts/get_maintainer.pl --self-test=sections
  ./MAINTAINERS:23368: warning: section without status

Fixes: d55444adedae ("MAINTAINERS: Add reviewer for regulator irq_helpers")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30322190a72f..6fd22db830f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23367,6 +23367,7 @@ K:	regulator_get_optional
 
 VOLTAGE AND CURRENT REGULATOR IRQ HELPERS
 R:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Maintained
 F:	drivers/regulator/irq_helpers.c
 
 VRF
-- 
2.34.1


