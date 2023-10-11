Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA217C60BC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376496AbjJKW6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjJKW6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:58:30 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ADAB8;
        Wed, 11 Oct 2023 15:58:28 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fa5d9f3a2so17124639f.3;
        Wed, 11 Oct 2023 15:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697065107; x=1697669907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRyXfw6oDnrYF/zDNW5wWAwbCqim2kPOLkomEzubNKA=;
        b=dOlIouQQrNbGs7uK8ZjWsin1yHykdHOQnJHhZD5RKVDPNj+Rg6uySJZMIvlYZkHbxg
         gWcFFWobtbgvLjz3aKveQ6uHNpT22EJitqC0tXZ2dX+ZAXJbhvKirb3nIXpXk/op8Chk
         uAb9pa39gtYpqbJnPVFG3TbretSoHpd5y6J/Gaa0u4FN5owuwy6ZH9RQvW8eHXE/2BIl
         5S53Pi7yUXoKzy5wEHFV2dSn/ksvKi213sUlGJ+EZVBfQqxd/id7m9hVFM49VAv7DEJ7
         nMdAd3xe6//4WhxKuj/+xdZfmpCzUDYo9z186rs3Eq9Uu0YYJbGNwoZkPf0VgbtmnXDI
         M3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697065107; x=1697669907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRyXfw6oDnrYF/zDNW5wWAwbCqim2kPOLkomEzubNKA=;
        b=rMho8bAbDxBVyQj28nuBsEC6p498MzKoiVLjtMmAyg0XDsJ05/5060eyCzQMmLyAIX
         QaSxzIStIXbiH+kzgMJj5iCEn31SzUKBGwA6SVh/h4wo9IOjauxGJVxdDQ74p6zH7gyp
         Zov3lDQTjRPItcw+xpcRjEiAF2loKOAwQnBGZI7Sc7yMmBBv5q1Wtn4P+4D3mexZzE5c
         Csv3+2BIb+hSpNlx40VPLKeXAe6fE3grrziDIiBNusYrblY8iWYLi3LL/ZWtXSspFHs8
         9rA/5+a151oLuL7PCyK9K19u6VvLqHpZDJa0H9MQKbuWM8vSojwYFjNJ2bX641REO8xb
         DtPg==
X-Gm-Message-State: AOJu0Yx2s+lIGIiKHiuZaAmJ+rWV36G/DGjeIrGbJISNUlOmQgS/2NfX
        UjR9fE4yx3kfiddNXKmz/Ns=
X-Google-Smtp-Source: AGHT+IGr33e6DeCq1Es2U6HxAMuQ4JLQ/vv/kv6x+u7LSh3/UX9r/b7JjU6RiJK1gSoGoaNV1TnVrA==
X-Received: by 2002:a05:6602:29a3:b0:785:d4f5:2225 with SMTP id u3-20020a05660229a300b00785d4f52225mr26077672ios.19.1697065107372;
        Wed, 11 Oct 2023 15:58:27 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:fcdc:5119:7b2f:72b3])
        by smtp.gmail.com with ESMTPSA id dq15-20020a0566384d0f00b0043a1f6dc8d4sm3632691jab.4.2023.10.11.15.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:58:27 -0700 (PDT)
From:   Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Lokesh Poovaragan <loki@gimmeapis.com>,
        Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add Turing RK1
Date:   Wed, 11 Oct 2023 16:58:22 -0600
Message-ID: <20231011225823.2542262-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011225823.2542262-1-CFSworks@gmail.com>
References: <20231011225823.2542262-1-CFSworks@gmail.com>
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

Add the Turing RK1, a Jetson-compatible system-on-module (SoM)
powered by RK3588, from Turing Machines, Inc.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ca5389862887..13b6cdc5ef82 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -870,6 +870,11 @@ properties:
           - const: tronsmart,orion-r68-meta
           - const: rockchip,rk3368
 
+      - description: Turing RK1
+        items:
+          - const: turing,rk1
+          - const: rockchip,rk3588
+
       - description: Xunlong Orange Pi R1 Plus / LTS
         items:
           - enum:
-- 
2.41.0

