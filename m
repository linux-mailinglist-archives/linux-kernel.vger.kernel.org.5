Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593EC77A0AD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjHLPMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHLPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:12:12 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD661984;
        Sat, 12 Aug 2023 08:12:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc0d39b52cso18189115ad.2;
        Sat, 12 Aug 2023 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691853134; x=1692457934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ignyGYbUhiro7sp9pns65fCFSZE8D435RePFW+tmIxQ=;
        b=mfwclZ6AkfVpdPH6aefIaSl87gqAAKO0yKQVe1T9zugP/3snDx3VxOx5S7LZoST8BU
         8lYaq0wdfMrDIa5zRoPRfRxxOs57NwiFabW8r9UauKNHt29AUQn7/GY9uh2z9kbdFx/t
         0CuLY9GHsehXj+tMDNHUINWV44ofKQI7JSvtn6WNAmPx5VqFipOQ8Ny9Ywabfhh5m92q
         NH3madymlDIPESxxF4fmmCoe43zP78s+8lfjerX2aj2nQRzGsNNSo8byIHjDAOA2wq29
         HmqtcqdzEzMVk1SZeydSosLqYWtE7TICPq4LIbkXvIs72Hi1EnJf1tXMBXexD3YMyQk4
         g4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691853134; x=1692457934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ignyGYbUhiro7sp9pns65fCFSZE8D435RePFW+tmIxQ=;
        b=X+CiLktD88/oUe8+VmT121ztoQG7hFXeLpb1w+cDzBG6477D29a/d0gtl7XA1vYxVl
         sURhxFi2ZV7ucQRmLyyMC1iiQyI9wpLe6UVB/3Nu6eqe8QslHubs3d+nqhl33KJlXR65
         7Td7hZ71nufxt4mTyneLZeQ1dlplqCdeJ4CD3/lJWlseY6bB8wwdcqf1Rpve57paNTCX
         gjnqzwPfaaourY26XRqeLBk/EvxspPDkXBIelj1ix0ddCJVyqyAPfNEOUY997rCsAujF
         evPVx/ce32zzU3tQHOm9hGms0XLQfjR+5akgis2gNGCnSVspQLdfAxCjAolJRWJgSV5e
         WJXQ==
X-Gm-Message-State: AOJu0YyBVYMKTLxMrdwb0uGyp/5EaoMieI4xIJDW6SIOPwKZMuy7dryG
        bPjqh0KDhjYDmHDjaSBnw8AvH0jfo6PGZWZC
X-Google-Smtp-Source: AGHT+IEgMYxDqJQyDXMPiIh42MXSuuu+YT8CCypWuikKy+hTnohqcVnEDmQgivbyWIY+bJwBH28QDA==
X-Received: by 2002:a17:902:ec86:b0:1b0:3df7:5992 with SMTP id x6-20020a170902ec8600b001b03df75992mr3945834plg.32.1691853134710;
        Sat, 12 Aug 2023 08:12:14 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a195100b0026b41363887sm1040927pjh.27.2023.08.12.08.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:12:14 -0700 (PDT)
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
Subject: [PATCH 2/5] dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
Date:   Sat, 12 Aug 2023 23:11:32 +0800
Message-Id: <20230812151135.1028780-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230812151135.1028780-1-keguang.zhang@gmail.com>
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Loongson LS1B and LS1C compatibles for system controller.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
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

