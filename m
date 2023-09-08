Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25724798625
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbjIHKt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIHKtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:49:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7E31BC6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:49:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500b66f8b27so3297836e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694170190; x=1694774990; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qbOo5X1GmF4Mji7zXkN43mcZEPqaEoq2zzKXzxtGFY=;
        b=SYMMKNm9Kqp3u6xxt91xbaUVZJxkQmy5dZ5ORTabIsWqXIm//CDgthf6ITiaPCpMYM
         j2oOV8T5WhDT0KpNMqzRLjr7vFG8HHxs6yPgBW69TRUzEA3OuHjyMxL1d73D3tpx7xyZ
         3g0zpTbrl7SEBqLpfhxCTmv1yz3zZ+URALdSRHgSGgC9eVeUWlmiwWSjyYfSYtAjHfqW
         AzdWhivNxBwJx+FUTviDo0U7hdDXz1u0q8LHmu8fvqb4b/JcmOWTzOqjVoeo4/1I8KP8
         TS+yNjLCFnqxKuvMELuiVuBObHyFHrRvxA+jzrjV5+T7igePirlBd5WBPneEY0ibPoN8
         eLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694170190; x=1694774990;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qbOo5X1GmF4Mji7zXkN43mcZEPqaEoq2zzKXzxtGFY=;
        b=AFNOEo+qkAt7V418eTGA3xVVFgxXerWFdKdbzYoMVGKwyHRfCt3Iro3tJ7OKKfY7DP
         NM9mqyqF94qUn5y6hhwUp9zxDWqKtf2/FK83greMWNsogUnXodlqmkrCaZprhOqeeVSE
         lKa0FAkbJX/p1qVg3uLSMyNFQjvDFx5bMKyuVLJ68lIqMvD0+nmv7t4Z23YsdrhePwS9
         L62Lo21lRdVii9R8+eUak9E/2Pl0Oh2YHrFrj+V4SgDIgxcHDbG0mNjq7UTfJWfnJxSx
         hYmB5TLSnyYEpRtJ61mc1btTWzunYyHIMgmkpJ36T+87Yeah29mY5qWLKszMj83pV5Hu
         XABQ==
X-Gm-Message-State: AOJu0YyDKMAvGRMQNDFP/W3O7qLre3X6OF7aSEYxnXUWF9iU3BCHRTC9
        s3l9lQpmFgfnVMtvZKaYbNsWNw==
X-Google-Smtp-Source: AGHT+IHpFkgZk366+UIU+dd2NOu5Wg7pBVaDwvIOCqZ7Fo0xD8H0KsKTE+DY/wKpeXVqswE3WQmV5g==
X-Received: by 2002:a19:6917:0:b0:502:9c4e:d46a with SMTP id e23-20020a196917000000b005029c4ed46amr1152490lfc.32.1694170189812;
        Fri, 08 Sep 2023 03:49:49 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id y15-20020ac255af000000b0050089b26eb0sm243321lfg.132.2023.09.08.03.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:49:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] Minor IXP4xx DTS updates
Date:   Fri, 08 Sep 2023 12:49:47 +0200
Message-Id: <20230908-ixp4xx-dts-v1-0-98d36264ed6d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEv8+mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSwML3cyKApOKCt2UkmJdU9MkQyPLJFMLCwszJaCGgqLUtMwKsGHRsbW
 1AF1Cpn9cAAAA
To:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small fixes to the IXP4xx device trees.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      ARM: dts: ixp4xx-nslu2: Enable write on flash
      ARM: dts: ixp4xx: Use right restart keycode

 arch/arm/boot/dts/intel/ixp/intel-ixp42x-dlink-dsm-g600.dts | 2 +-
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-freecom-fsg-3.dts  | 2 +-
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-iomega-nas100d.dts | 2 +-
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-nslu2.dts  | 4 +++-
 4 files changed, 6 insertions(+), 4 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230908-ixp4xx-dts-55b129b58886

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

