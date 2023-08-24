Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FCB786FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbjHXMvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbjHXMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:50:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D71E59;
        Thu, 24 Aug 2023 05:50:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a6f6a66e1so2158579b3a.2;
        Thu, 24 Aug 2023 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692881447; x=1693486247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEnO7+4Ucyc9S7UpaeQH2qCtWkbPSwVUI/lztRqRSCc=;
        b=Kr6KYeCCzb1FqfLDm6L/W1YznkJbI1MLy6qfy0p+SER8/Prvxn0y4XmUOSIbvPQsb7
         Xc3ZMXp9wQk7quwnGfLAG1eGRPXEnY7FYeIponpEvKcnsExgsKSHwQgqoImCbMotFbMX
         MO5bjZO5elRElvvrKOYRi25s82SeQQDvc3IsavH4aEMz0rJd1vuleTluBImYLx1R13rf
         PPF4IjwOMdtJW8u3wWrgCs8JmMUlsyWSsXZ/vSM/NbcJHDkdRwMN/Bq2fK2ZLhBS/AaV
         xrQkdDroHORBaHDUwEzneYavGYjWZ/Lcv4Q3is7Y9LdGgrQgEDDkUVX10wk0mxYIDG+O
         l2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692881447; x=1693486247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEnO7+4Ucyc9S7UpaeQH2qCtWkbPSwVUI/lztRqRSCc=;
        b=g1ccNZDoiEZoUVYsp6RTIRI0oKGlouXm6h29urIr+XmHKd1UAgPFc2rkl7AW8Y8BXl
         6ZUloZVg4Zf5WT9u+L48IRtvp7G7oy3Mppw2N9bGZTjdIbmteAaIAXEJ8rePktqWzDl1
         NBWyHj/2sSYNvMWoRlD4VQeCyMI2Eq+U/UledExDktVRM/jZhyVWg2umxxL/I6z9Xze5
         ScJcOqeS5a13/xGQqFzEke+UYgWhPys1Us6J40oUxTBorVAsnI555nWsI9wXQRMrN34V
         m+ZTjeQNGpTQ1qgP9NhT93oESyJKzkFgdhzleUkvWkvxkfz6qsnrxe+2CSapPWH7or7D
         BG+w==
X-Gm-Message-State: AOJu0YzVsjZ7nF4lxo+zlJp8Bil+5mTvfi3b9+q+w++7dxCp5TnBdj5U
        32FnNhkC+8wCUF406rQxqF5zjLgSIwTwSeGP
X-Google-Smtp-Source: AGHT+IEJezqgxyuKMZOPnyEl/qqvBIYOTw8oxxpD1uk5UcTBbkSzuwhIiGs7TIDE/ERjC4BUcN0WxA==
X-Received: by 2002:a05:6a20:969a:b0:13d:c70d:de62 with SMTP id hp26-20020a056a20969a00b0013dc70dde62mr11644803pzc.22.1692881447110;
        Thu, 24 Aug 2023 05:50:47 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001afd821c057sm12837295pli.58.2023.08.24.05.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 05:50:46 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v3 1/4] dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
Date:   Thu, 24 Aug 2023 20:50:09 +0800
Message-Id: <20230824125012.1040288-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824125012.1040288-1-keguang.zhang@gmail.com>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Loongson LS1B and LS1C compatibles for system controller.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V2 -> V3: Change compatibles back to loongson,ls1b-syscon
          and loongson,ls1c-syscon
V1 -> V2: Make the syscon compatibles more specific

 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 8103154bbb52..c77d7b155a4c 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -49,6 +49,8 @@ properties:
               - hisilicon,peri-subctrl
               - hpe,gxp-sysreg
               - intel,lgm-syscon
+              - loongson,ls1b-syscon
+              - loongson,ls1c-syscon
               - marvell,armada-3700-usb2-host-misc
               - mediatek,mt8135-pctl-a-syscfg
               - mediatek,mt8135-pctl-b-syscfg
-- 
2.39.2

