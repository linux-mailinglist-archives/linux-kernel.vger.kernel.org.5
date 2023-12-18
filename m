Return-Path: <linux-kernel+bounces-3304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F43816AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059AF1F22FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C922913FE6;
	Mon, 18 Dec 2023 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU19BBON"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EEA15492;
	Mon, 18 Dec 2023 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336672406f0so597597f8f.2;
        Mon, 18 Dec 2023 02:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702894370; x=1703499170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WtXLxQwCFo504IjsHi0YpiharpdePiqBc5i2KE37aE=;
        b=lU19BBONqPBO3IApsjTmA6DMufnH/A41NV5QhRlZ/2dgfG3blokJ8MMCiiFpxCdugK
         1pSNJ+0tM/ibODQ8o6cZ86sbzn02+67S1686raH39VKjwcrxOAS6+SaIaKDmCnzUn7Pv
         r45+1muiXFasXAE233BgpxR9jCjVtBjWe0d5eDlTVcl93XxTBqh4ShFGxB0v0u/kUN47
         Dzueux1IzDoPURn/WeSDiEwLKvXAzN/LPNPfnU3j+QSZLOF9wILslzyeHiuHR5v+qDV6
         odM9WQPqf+pJ2rhWEF47ioVKmOapCjYaNKKVBhERZEpCtvOxIxkuX0LN1aqXbtL15Q5t
         iDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894370; x=1703499170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WtXLxQwCFo504IjsHi0YpiharpdePiqBc5i2KE37aE=;
        b=D82ULtg9+AUnJBYZeBGX++jHBy/+oEYRMw3yvqFNa70OW7/3O0aPH0LpbfdZvq1HsO
         EGlfTQnxg9PFk5Wv0StWbdpfOkV/O2pDeSf+llpRaovaKlnb5jxIgiV7JNtD4XzzXjaV
         XgzJB3DtmegBSCJLWhvbPXaqEE0qbg6Ro8SJ3x6sS+KTI9bO3RtWMBuUNjSpaKuXIXxd
         T1CI7Y/Jp1GkkHB96NQ16apZxjphZAHhYcuBmEBNu54Wnr+gfvjY82E2djsrejlcQ+xq
         2SYHaeW3pIs6Qa1Yo2Uaf/xRHkUCsoK2iMBRSg1gA5ogHXzTwhsPiNWP5Z66rrUDVJsN
         Amrw==
X-Gm-Message-State: AOJu0Yy6Wz2wVn1o5OUQBZcnZUwqqHwfwC7Up39u2+EUkJfnrRch154c
	E2b3k7gYNSk3ie8+rASgbYA=
X-Google-Smtp-Source: AGHT+IEk0WnHrPvB6e5s1TX9Icl5DzhvBKsYduxD+/CToPTHJcdjQhGln4XwMYlycSfTpH6t5eUGow==
X-Received: by 2002:a5d:670b:0:b0:336:4bc7:1d3d with SMTP id o11-20020a5d670b000000b003364bc71d3dmr3388761wru.57.1702894370453;
        Mon, 18 Dec 2023 02:12:50 -0800 (PST)
Received: from lukas-virtualBox.. ([208.127.103.55])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d564b000000b0033664ffaf5dsm3666051wrw.37.2023.12.18.02.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:12:49 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Peter Griffin <peter.griffin@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in GOOGLE TENSOR SoC SUPPORT
Date: Mon, 18 Dec 2023 11:12:25 +0100
Message-Id: <20231218101225.27637-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0a910f160638 ("dt-bindings: clock: Add Google gs101 clock
management unit bindings") adds the file google,gs101.h in
include/dt-bindings/clock/. However, commit 9d71df3e6eb7 ("MAINTAINERS:
add entry for Google Tensor SoC") wrongly refers to the file
google,clk-gs101.h in that directory.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Adjust the file entry to the actual file in GOOGLE TENSOR SoC SUPPORT.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d984bd745e93..d05c81acd849 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9034,7 +9034,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	drivers/clk/samsung/clk-gs101.c
-F:	include/dt-bindings/clock/google,clk-gs101.h
+F:	include/dt-bindings/clock/google,gs101.h
 
 GPD POCKET FAN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
-- 
2.34.1


