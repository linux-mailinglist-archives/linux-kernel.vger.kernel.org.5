Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB747BD8D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbjJIKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345755AbjJIKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:38:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A549D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:38:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50585357903so5766341e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696847897; x=1697452697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhITP4Yy7WXGwmIes2WbbQwN+GVUNeY15zfz6HuWGq8=;
        b=bJzN5mNsIZZIo3ojVhy4sXNjOybUIC3BNappOlpoFaWYRe3k1aN6tAAxnm9bNUrmFS
         /BamV3SgGvgwnrCJ4o0ao+26eDvPGObtI+Q1NRxHMZNESkdXmkn/GSvN54BtFJyzr+Kw
         Kl02ZbimUyQL8A89wrq0Zsa8fj2Jn639qIayOdXwL1W9QXowSWHFF7Lbdat71+TZ3LNF
         AMQaTxwWjRHEU2KjutNEKX0xLtJ6lobiryPGpR+3ygKgin37kinHvmZYmu1qAxN63h8K
         TBueRTZzsGqH8OKYblpdV9rtii60OtA8WVxKDbO/X14iTSJ1KsWk/vfgoN08/OitpmQ3
         eXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847897; x=1697452697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhITP4Yy7WXGwmIes2WbbQwN+GVUNeY15zfz6HuWGq8=;
        b=vXFGKZdyY8ZXxvnmEmUSG6Vd4glXY1li1+7JrDOjVBNVtad4/GZRCD5iQlRKbeSIHz
         yfi9nHDDR+YqkorBuST6+f7IIR/dMzMkDc0FUI/+8dz6rVB0UoRYNUF5oIZYWyihE2bT
         pED74JdN7ofGML7JVej4UYp78GPI+ALSdSuYzTqlTVNxL5opqm1gklJcthZ3Aq2ujKgT
         yC+TJrH0N8/kcRRu6z4aUsHSy6uwYFbQKDYKeYNKv1pqzI/JguRk7UptmNR84+bFxkEf
         +dnGc8mbwLNa90gYgSv11d3CvB0xpBJTQwfEkkCT0DyGmLTyP/AN97TCF/zZaMBwRNa3
         YSWA==
X-Gm-Message-State: AOJu0Yz7WmP5s9kbgYlXc00XT77yKNmQjilDuYNARJQ0mx9Po4YOoK/L
        4ruy9AMjFNJd35dL6wJQFgidfQ==
X-Google-Smtp-Source: AGHT+IEw02s/JSFo5TB6eohkIlaWTojWoWVG4Lxy+dJdkOmW529AwG29W34mVYGpT1qUBMfVhuKBeQ==
X-Received: by 2002:a19:4f5b:0:b0:502:bdbd:8442 with SMTP id a27-20020a194f5b000000b00502bdbd8442mr11206784lfk.50.1696847897129;
        Mon, 09 Oct 2023 03:38:17 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d5489000000b003179d5aee67sm9287802wrv.94.2023.10.09.03.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:38:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mateusz Majewski <m.majewski2@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 0/4] Fix Samsung pinctrl driver static allocation of GPIO base warning
Date:   Mon,  9 Oct 2023 12:38:09 +0200
Message-Id: <169684788462.41819.14878284195642677330.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006125557.212681-1-m.majewski2@samsung.com>
References: <CGME20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3@eucas1p1.samsung.com> <20231006125557.212681-1-m.majewski2@samsung.com>
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


On Fri, 06 Oct 2023 14:55:53 +0200, Mateusz Majewski wrote:
> The object of this work is fixing the following warning, which appears
> on all targets using that driver:
> 
> gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
> 
> This needs a small refactor to how we interact with the pinctrl
> subsystem. Finally, we remove some bookkeeping that has only been
> necessary to allocate GPIO bases correctly.
> 
> [...]

Applied, thanks!

[1/4] pinctrl: samsung: defer pinctrl_enable
      https://git.kernel.org/pinctrl/samsung/c/2aca5c591ef4ecc4bcb9be3c9a9360d3d5238866
[2/4] pinctrl: samsung: use add_pin_ranges method to add pinctrl ranges
      https://git.kernel.org/pinctrl/samsung/c/bf128c1f0fe1fd4801fb84660c324095990c533a
[3/4] pinctrl: samsung: choose GPIO numberspace base dynamically
      https://git.kernel.org/pinctrl/samsung/c/deb79167e1dadc0ac0a9e3aa67130e60c5d011ef
[4/4] pinctrl: samsung: do not offset pinctrl numberspaces
      https://git.kernel.org/pinctrl/samsung/c/8aec97decfd0f444a69a765b2f00d64b42752824

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
