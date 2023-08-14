Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4218E77B3DC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjHNIU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbjHNIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:20:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F89AC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:20:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe4a89e7efso36280375e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692001204; x=1692606004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aez+xP5mnAmM9w6EixqPtPxUkOBQnr9kWDfyOxUZrVQ=;
        b=mW3/KXDvKaTZ/7Iy6va66qlUTPT9ymimYCea/nBCN38QjpJkxqA52L9y2Z+FlRf7/W
         ePaYjcil42V/mPyptnn1j6CSe3bkRRVTuKTNKcn0rg60pnyfv5SLn02F+1760Y49IcqV
         9bqtDNl4YMnxFb1u4GvwwL8A1uRvMUyeGHVoctiNLZYDlh00cpl/PkVQaw9bg+WOc7Oe
         imCjFb90A1y5jnEisJ+cUJ3aNpSuPtSFxp/BrS+Jm8ewSn9TmHaV3/KqUj+f43V91zDa
         m8pcbmk2DyoYvh3KCiWYc9BEK4d65a9BLn1ohVN/8iBDDRUgGTcw6S1zHfj5Xa/7rKLH
         UiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692001204; x=1692606004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aez+xP5mnAmM9w6EixqPtPxUkOBQnr9kWDfyOxUZrVQ=;
        b=cm3R0j21bXFLcTdWHsoJdfIAORLA+B+LvpHOxaU+yf7R1IRhQyEouEn+8v/Ynf7zHo
         KjfYjGDbdoBadRndgdy7rME4GFZQVEPbhtBKXrx/UNxTSp4CPWn1L+ShD9MENhMsJPhu
         DQPJK0Mi3cmTcTPch9+qE1Kk251CVR3RNqan/N1RxghOJM3KNyw675m+wIzyypvcWadm
         biF54Quuwm3Vg+FwUEzi29hwl5PSodmAmOoj/u4C3No2F58eAxDiGpEVKqdekbzIyV9e
         JN8jK9Pcqa3ee9Ctfm/TUJ/BqJ6dZdqTEPnSE7M9TKDSaf2xb3eS34sEaE2j9a/15+Ix
         EJOA==
X-Gm-Message-State: AOJu0Yym7rih/yxFBbRmEbARp11TuX+1iQjkxtpL3QfXDew4IcHYkMA4
        c8Kn6/zwxnRF5IJNUUe/Ifm2WA==
X-Google-Smtp-Source: AGHT+IG7q8aCsVRGy4JrVMpHCdGrGUppeeW485Bt90if9jQ9Oipcpzw+M3RAZyKFgCY+W1kiMfwFJg==
X-Received: by 2002:adf:e90c:0:b0:317:9537:d73f with SMTP id f12-20020adfe90c000000b003179537d73fmr6374951wrm.30.1692001204380;
        Mon, 14 Aug 2023 01:20:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b003143ba62cf4sm13661259wrw.86.2023.08.14.01.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:20:03 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 14 Aug 2023 10:19:54 +0200
Subject: [PATCH v3 3/3] MAINTAINERS: remove OXNAS entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-topic-oxnas-upstream-remove-v3-3-e2ba579a49d3@linaro.org>
References: <20230814-topic-oxnas-upstream-remove-v3-0-e2ba579a49d3@linaro.org>
In-Reply-To: <20230814-topic-oxnas-upstream-remove-v3-0-e2ba579a49d3@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Andy Shevchenko <andy@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=YSP4DEAcN8p8UK/7eu/9X/kcfamghrIDWmcsP6PMKis=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk2eOwGTcrGhMacM6mII/K38MQbK8ABx5aRv01PJzD
 cGs+du6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZNnjsAAKCRB33NvayMhJ0Z9PD/
 wJVZ2Bv6BUGdM9qwtsouLbi/fo+YQOVKJVXd0hVntdmKnMPIGeuMDdCg160/10R4XsI4yhyOsS5lQh
 RaOVte6vPwdqFSqhyIWGLtTcszYGVDzEiEf8mgRtddeyP1fX7v4UDGZ8eUQjaqKBm2pxpzTvIf+1HP
 AHdsBmCjwD5Z1nlHECvgM9MKsokF9DIeNajeHX+Rlckl683vbYRw9bBlgoh91GHTpmwRZZ8naq1KhR
 8oOnd0hK9rLjNUFkImW1yHIJjzMycjSdxEfev4EqU4OHxnLiBRptOA27cV3VzAoozj1/B7qQW1qedJ
 MFFlZa6JAPzoINHcgfNmisVwmgI6g09McxXKnoLwveiJpJRmGxLyGRy/YoSw0rsI33z8FjgJueIQvi
 Ocr6yVNkDObh1Ofikc+qdjw/1DUY5336lcCs41oYAbFAIC/upQJa4moVk1ZVSJvDbUtvkQONraHZX2
 7lAsl+q7jb3Q/6Ol2ePDRiQSnjPbPljYOx3CmQzdUtf1K6niTk41IWYajIxS/Xw6iaQYF8lOGibJOY
 bn+mQov5WC936Wyz4L6WrvXYYEwtIKlQLnq0qWg3gASgUDRvJweyc+PqcZ6vFpi8yYGSnci6UQ/4f9
 7NbxaZIVqG+P0ZYf0U8Pp4Npt/botaSaLODY/U/a/oLSh8MPltp/wWA2wwxg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove MAINTAINERS
entry for OXNAS files.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02a3192195af..c8258178f19a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2506,16 +2506,6 @@ S:	Maintained
 W:	http://www.digriz.org.uk/ts78xx/kernel
 F:	arch/arm/mach-orion5x/ts78xx-*
 
-ARM/OXNAS platform support
-M:	Neil Armstrong <neil.armstrong@linaro.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	linux-oxnas@groups.io (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/boot/dts/ox8*.dts*
-F:	arch/arm/mach-oxnas/
-F:	drivers/power/reset/oxnas-restart.c
-N:	oxnas
-
 ARM/QUALCOMM CHROMEBOOK SUPPORT
 R:	cros-qcom-dts-watchers@chromium.org
 F:	arch/arm64/boot/dts/qcom/sc7180*

-- 
2.34.1

