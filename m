Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9B080AD44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjLHTnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:43:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FFF1729
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:43:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332fd78fa9dso2267137f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 11:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702064606; x=1702669406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEJCryZOY7/zM8uMtAIXnTjj+RgXAZj+NQh24K145R8=;
        b=qz2LBg36Un/64fIiuA/Z/wdRszfRJvtGyGInuxsx9eZKL4kFKaWF9i9TzUiecFv3ab
         WhCVp6aFBsUzSqwQ1IAPXzOUrrzaE/Efvz7VBOZt/0qwY8ZT39GxjTk6dIX6fh1Fb4ST
         CbqxA+w/MMIUanHCx2/R7xFpWf8bZKsgXtfByRzqkPKq7sTTquX4SPuH6g61Na0SzMrY
         /IkFXlAzbftUZ4SMZChI9zEGrCer+oXzN5n1+mDlLRll5j2/NTCRGiB4XjGGcpOGYxb4
         ldfgr3crGeikCq9LECRQSGfTDDN/wCFFeMUgPBHSBvKpdcK7okFSgJxppXpleZstA31s
         5TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702064606; x=1702669406;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEJCryZOY7/zM8uMtAIXnTjj+RgXAZj+NQh24K145R8=;
        b=VrUj4/ZA6bCWMtyor/+KrMoo4NwrCo0BKyixuxtClNvDXoBL4UZAjza7fkIsVlY4eH
         MuWEScZ3z/Pqj/yvtdOg3AzMgnbzZIOPCYEUWBd5rs3Zjr4BMBzjLAyWq1JS7BBIGta7
         PYzqeHJGft+H5pdTdBgHeK2kOXDJDLIeahsDyYKZFgpzuBADD62Mi5GDvz6k+OPUF3BF
         IPM4v0kTr2gBFz1YBph+HS15GA1Z7pRVOtHTxlD6EpXkNtkaX1x0/9Xecp5waHXE2Dob
         F2jE5Rvp5u3oRVq8rQUIjuDwacdYbBzX3oohH7tbjtcxxRBuH3Z15CP/g2LOFe6L2kOu
         wP2Q==
X-Gm-Message-State: AOJu0YwMVu1DnnLkGHA030woJGHClHRHRl6FnCmzz6jAyv8hxgh6bDqC
        UPzqVhwTLVLYoJR1mt95ouvBtw==
X-Google-Smtp-Source: AGHT+IGUZ0M5XfwQtXVfb2fFWHIXJ8eCSwRd4AUrMyT3otXdE/VM8Wxvk+NVq9q1AibYzcHmtCgkGA==
X-Received: by 2002:adf:ee0d:0:b0:333:58eb:8d6d with SMTP id y13-20020adfee0d000000b0033358eb8d6dmr136808wrn.103.1702064605915;
        Fri, 08 Dec 2023 11:43:25 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d58ca000000b0033338c3ba42sm2653920wrf.111.2023.12.08.11.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:43:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231206221556.15348-1-paul@crapouillou.net>
References: <20231206221556.15348-1-paul@crapouillou.net>
Subject: Re: [PATCH 0/3] ARM: dts: samsung: exynos4210-i9100 updates
Message-Id: <170206460423.126390.6462198989409881978.b4-ty@linaro.org>
Date:   Fri, 08 Dec 2023 20:43:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Dec 2023 23:15:53 +0100, Paul Cercueil wrote:
> Here a small patchset with a fix and some improvements to the DTS for
> the Galaxy S2 (aka. i9100) phone.
> 
> The first patch unconditionally enables a regulator, which seems to be
> needed for the phone to boot properly. I do not know what it is
> connected to.
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12
      https://git.kernel.org/krzk/linux/c/84228d5e29dbc7a6be51e221000e1d122125826c
[2/3] ARM: dts: samsung: exynos4210-i9100: Add node for touch keys
      https://git.kernel.org/krzk/linux/c/6e73b11062b2e3e873666ba35577437502cf1dd2
[3/3] ARM: dts: samsung: exynos4210-i9100: Add accelerometer node
      https://git.kernel.org/krzk/linux/c/50c7cdc9a4d2d21373c1ab52c131109ab30c53f5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

