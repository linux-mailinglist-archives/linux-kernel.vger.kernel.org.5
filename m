Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1C579ADAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjIKVFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbjIKLji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:39:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668E812E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:39:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so5663615a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694432373; x=1695037173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNTfpAlLwJmILsM2ML8AYXqOfMhJFlBtfc+NKYRir1U=;
        b=ghEBbB1urKJGeO8Bdy6HofhhQiZ1S9/1NhPG7BsncRMDGG0s5wlXonQOGlxx3mCzEp
         TilWMdnEyOCs0gkiHJmjCkgpyd7ExzLF/Tu34fhN8/6+VnBwsxwCzeWgexmuIvBaMw8Z
         dJ82hwi84usc0wlEKfbGtWoTaNixYew8o60dxoh0hKzNbt9GXjAKhoJTD/+sQdS8BdUS
         d3ZU+GHBp4Vlq1QX7zPgn44yoRm1EpADc37AqjLbxRr1uhgKl1FBR4lg4ahRVeRfWtZz
         9+FRq50oD3WMRi4cIC8zBX2iQY5tOmdmeVnRLUW9Fn7kwgZ7sPR2rb45+qfElWJ2n8v5
         qPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432373; x=1695037173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNTfpAlLwJmILsM2ML8AYXqOfMhJFlBtfc+NKYRir1U=;
        b=rZ8D1LOtaWTNBG5UzmYltqbNQRRl6dC+ojmICX7zC0bugzySem3qfIZr4YyXOXBJt9
         /OyQBTzhP9ee2CC6i/mmj4rDxjMweyUgd0KvYbxSriILgV4zCRXMHoa/Y+oHpL4+6FbH
         c6z3xnk84qoq2aFS2U8RHH+1EB19N2hcqI/FjP5wV2u4NkdHJ7Bl2sC1m/7M6g1hZw+I
         Gn/4Hc5Hfn19amBhLpK/S3w4xWhtAQVmruC+k8nXNKj9Rdsk00EwC82W4FpSflxKsWVa
         WmpcbjrOtP3rtusCQeCSKrqeKWnEk8jX1Dl1JBPt13UZDWV26g/d9GVlwoBa1qeC9Auo
         fa3g==
X-Gm-Message-State: AOJu0Yyhi92XHGAHZ3mxIsBs1D0cNjZDH82KECB4KrVSQ79eZ6lvnbqn
        Kry8mk5gK7sxzXmuDf2EFeNIag==
X-Google-Smtp-Source: AGHT+IHwEnPhO+VHQG0S+VrfAHaLii+tG8XXkAqNaOPbo0YVPvNOqmH3dpTLzyBvYyQwoxAyv+FnFA==
X-Received: by 2002:a05:6402:1254:b0:522:3ef1:b10 with SMTP id l20-20020a056402125400b005223ef10b10mr7390345edw.6.1694432373037;
        Mon, 11 Sep 2023 04:39:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id g15-20020a056402180f00b00523b1335618sm4431003edy.97.2023.09.11.04.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 04:39:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: defconfig: enable syscon-poweroff driver
Date:   Mon, 11 Sep 2023 13:39:24 +0200
Message-Id: <169443234708.34398.6225536362107834291.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901115732.45854-1-krzysztof.kozlowski@linaro.org>
References: <20230901115732.45854-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 01 Sep 2023 13:57:32 +0200, Krzysztof Kozlowski wrote:
> Enable the generic syscon-poweroff driver used on all Exynos ARM64 SoCs
> (e.g. Exynos5433) and few APM SoCs.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable syscon-poweroff driver
      https://git.kernel.org/krzk/linux/c/471eed5ad217fc8e83089e708d5cf5a1d0b205f7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
