Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C5A76F5F8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjHCXER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjHCXEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:04:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB6A30FD;
        Thu,  3 Aug 2023 16:03:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc34b32785so10840915ad.3;
        Thu, 03 Aug 2023 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691103815; x=1691708615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxdVo0H4Ogsm6y1B4bh/ICRf8zL9r8pBxK6Ht1YN6QU=;
        b=B1FXxq3xyAYEetNblcpVr3eqFdEVp27JMD86CR/EggjGafPeF6E0Qu787tQ5KXJGaT
         v2cPuAg+C1i93EfB4TizxepVrFZH8lbPopNs//XFToHcKPt5EXql5L4sydDrtAEgDsvW
         f2UVLu+Cpk0mTfsWlJMwdFU4oz6sy4l3L+mV/ekGiYJH1pmF1SfZBDh9hW+9YKLB/FHB
         QHPhqIEhBEYI0QDXYfS2Fg2SYwf6oa9VXHPJ5cFl9WkyNe5Zhk8E2dYjAKBWGU11l3w1
         kexodF7CcnK1IgEvhp6oc1Iwrt7FJ/5T8UGjWZXMGMCAd2UhG1T8XjCm6XfX7nwj69t4
         eDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691103815; x=1691708615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxdVo0H4Ogsm6y1B4bh/ICRf8zL9r8pBxK6Ht1YN6QU=;
        b=MTsrkIo6VRggiZUh0gHi1jahkssDAjDmxYbqdi+oqmYqGJLOyUYmLMgGLUHXhASfGP
         YVYAWlPqTgXLoZ7x/jhb0SRFKmDk2IQyNcG5LrvSOoFqh9i6S99nwglzHTpsBH8R4tWb
         RN33fYXy702LNedX5zQH0ZzjZBGrNyXY+uSSgkRGX24rpR1F6iN4WtInDEAm+KGAZonV
         WPDTYo7in3AQq1e7FGYMRVE4xWxZX+hHb7IgGAPg+qHvQSlI4yblvqWMftLRYRsKQqCp
         +j0rk/8klPZ5vrz3iVHYCNEGPQoc8Fvx0jzN5z0OJ26HpfO5BnpcXlRFm2GuyyzBK7Ie
         22LA==
X-Gm-Message-State: AOJu0Yww5Gks7VAoU7Do6Mchl9vOh+67wlH5k/72VLZoV8ZpZir09Toh
        kp+BqtF43PwT+bxaYZFY1T0=
X-Google-Smtp-Source: AGHT+IGTLIqDQyKKtQsXBAKVqKtFN5RUGOE+6K1WmgCYMpo3tJqJIIm02ZnnhklD8xBZED4d9EF6UQ==
X-Received: by 2002:a17:902:b78c:b0:1bb:809d:ae72 with SMTP id e12-20020a170902b78c00b001bb809dae72mr115625pls.33.1691103815263;
        Thu, 03 Aug 2023 16:03:35 -0700 (PDT)
Received: from taoren-fedora-PC23YAB4.thefacebook.com ([2620:10d:c090:500::5:e60a])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001bbb598b8bbsm372349plg.41.2023.08.03.16.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 16:03:34 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        taoren@meta.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 3/3] ARM: dts: aspeed: wedge400: Set eMMC max frequency
Date:   Thu,  3 Aug 2023 16:03:24 -0700
Message-Id: <20230803230324.731268-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803230324.731268-1-rentao.bupt@gmail.com>
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Set eMMC max frequency to 25MHz to prevent intermittent eMMC access
failures.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index 5c55afed946f..d17b977fee9b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -367,6 +367,7 @@ &uhci {
 };
 
 &sdhci1 {
+	max-frequency = <25000000>;
 	/*
 	 * DMA mode needs to be disabled to avoid conflicts with UHCI
 	 * Controller in AST2500 SoC.
-- 
2.40.1

