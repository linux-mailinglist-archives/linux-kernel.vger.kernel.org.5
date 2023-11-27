Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B957FA52D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjK0PvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjK0Pu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:50:58 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230BD92
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:51:04 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507975d34e8so6090478e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701100262; x=1701705062; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSRGYqYUfUnqbzNe7H+CWECtE/5YcXXPUavqSdoHXi4=;
        b=dNcvmzLzgf5UKBCTUKR7+OeP3NQgbU6fjykfT68cuEqJ9cSAQKUeAM3aJMmNcEgsS1
         hiy+hyeJMgWT2VWUWswQfAC1wVbGy8iTAobBLtwRjBPFwyrpDeBvEZqihZfRlwLQmLDC
         q9MRbeQ6/ZjjwAV80qy7nMJXFz79MbaHTof7GmASU18lT2NLspOCz3kVxJhxV2zzK4UZ
         UpCZppeHI2ZkT7E2jgDweLQMusdU99+Vhdbwn4V+TkBC2S33a3HNWmcxiMk0Lq97/N6g
         vrpXnx5NHr+aNZGvhhv85VYR7bwyRj2mM5AAeTGVWNMLOW1O8/f2M/DfglrBRuH0RVr4
         XywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701100262; x=1701705062;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSRGYqYUfUnqbzNe7H+CWECtE/5YcXXPUavqSdoHXi4=;
        b=PQjtFZSimFQ0LSRRJZdSqGwc9YHSjdr2F4S798UVmMoR5MtwgPPs3ksTfnfUMbgJxE
         YbJjoAZ/y/Yyq37I6GqAdj9J8nqwHiPIxOXQLRJCYhZ/4qAqykvgcS8xssONQqbUTb8l
         znx6KrKJYHW/4E28xL/oEEgogulYXM/GofHPLmGVT/ngyooNjEro5hEZdA3j8eLnnfrj
         hyRGyO9Y28XbZcWoyTXsqNg91GAPl5OEolVGfFtI9mTAtW/f080FdQAM0I9r65CEGv5e
         YroDKZRwyChqanbTti4IesrUHhwbqfH0PcWs80uOur6ur8J1RF1KgVqDsNkserWSIpfz
         1M9Q==
X-Gm-Message-State: AOJu0YzhHwXUMi4drm7yvrRvzhmcehWb13BsmCclcTH6RHM8PoVLdGAN
        E6O/e50N1ebK9t5T6CjjCv/mDQ==
X-Google-Smtp-Source: AGHT+IFyYkInntn7WIIXtaQUomX+9JyW5bRImW46V9s7iz9kDzwm8pq5GnI0bsoTxBKg/4uR1CTr9w==
X-Received: by 2002:a05:6512:12c8:b0:50a:7575:1339 with SMTP id p8-20020a05651212c800b0050a75751339mr11124629lfg.18.1701100262314;
        Mon, 27 Nov 2023 07:51:02 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id b16-20020ac25e90000000b0050a71df5d39sm1515787lfq.300.2023.11.27.07.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:51:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v9 0/3] ARM/ARM64: dts: mv88e6xxx fixes for Marvell
Date:   Mon, 27 Nov 2023 16:50:59 +0100
Message-Id: <20231127-mv88e6xxx-mvebu-fixes-v9-0-d19b963e81fb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOO6ZGUC/x2LywqAIBAAf0X2nJBmaf1KdOix1h56oBRC+O8t3
 WYY5oWIgTBCJ14I+FCk82BpCwHzNh4rSlrYQZe6UkpbuT/OYZNSYsLplp4SRmnq0dtKm9k4Bfx
 eAf/Aaz/k/AE/SQPvZwAAAA==
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes and adjusts a few Marvell platform device trees
to the new bindings which will be merged separately to the
netdev tree.

The last patch adds the special compatibles we need to avoid
the annoying warnings on nonstandard ABI nodenames used by
U-Boot

This patch set mixes ARM and ARM64 DTS changes but I am
sure the maintainers can sort it out.

Link to v9 bindings patches:
https://lore.kernel.org/r/20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (3):
      ARM: dts: marvell: Fix some common switch mistakes
      ARM64: dts: marvell: Fix some common switch mistakes
      ARM64: dts: Add special compatibles for the Turris Mox

 arch/arm/boot/dts/marvell/armada-370-rd.dts        | 24 +++---
 .../dts/marvell/armada-381-netgear-gs110emx.dts    | 44 +++++-----
 .../dts/marvell/armada-385-clearfog-gtr-l8.dts     | 38 ++++-----
 .../dts/marvell/armada-385-clearfog-gtr-s4.dts     | 22 ++---
 arch/arm/boot/dts/marvell/armada-385-linksys.dtsi  | 18 ++--
 .../boot/dts/marvell/armada-385-turris-omnia.dts   | 20 ++---
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  | 20 ++---
 .../boot/dts/marvell/armada-xp-linksys-mamba.dts   | 18 ++--
 .../dts/marvell/armada-3720-espressobin-ultra.dts  | 14 ++--
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  | 20 ++---
 .../boot/dts/marvell/armada-3720-gl-mv1000.dts     | 20 ++---
 .../boot/dts/marvell/armada-3720-turris-mox.dts    | 97 ++++++++++++----------
 .../boot/dts/marvell/armada-7040-mochabin.dts      | 24 +++---
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     | 22 ++---
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        | 42 +++++-----
 15 files changed, 217 insertions(+), 226 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231127-mv88e6xxx-mvebu-fixes-45af7324c481

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

