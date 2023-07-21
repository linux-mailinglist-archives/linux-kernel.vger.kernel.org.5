Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E98575C6FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGUMjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGUMjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:39:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD682D56;
        Fri, 21 Jul 2023 05:39:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98e39784a85so639315666b.1;
        Fri, 21 Jul 2023 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689943153; x=1690547953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBWmRvJ6rLCVlUuynkQvN84w3Cg18aPij7FlE9/ewkI=;
        b=jaWgysHHTe1WTU9VN0h8AWNgdnUjQ3OYgW3ldXcAtHzwjxmekhiNlCiX6nqs3vLbst
         RWfDKxgbcWHIaaMm5Iz0sBlX1kl9yOS1zmEyfTxL0qE10ad2mgd2toamAKij/HrwUJGT
         KS8fGEVUx4DZkezSBiRoAs96omH81uQlUNqcNjcdZrnlGgr0w1C0Mq/z4EeA4KPi9oYx
         UV0u2PEtc7kV0z6pwgA/gThrlBpJfxH+gCnsz0d2sXlJyIQxuAIM5BagAV97+imj1Mhq
         Irz4QZy7Q3kX1EweuyHSj6y+I51Zb3NWymG8mL/Db1A6QL+WlwLVUFEdnwNUGnbSL24g
         oTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943153; x=1690547953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBWmRvJ6rLCVlUuynkQvN84w3Cg18aPij7FlE9/ewkI=;
        b=Ao8OQSo2d8j1UiRd9wvCDmqRC9S0CRPSwiYCPh5tfbu/qgf9viZCKTbt7jL+HIjeNz
         HmrfeRSxBFKqxyN8eIBRmOVVS27W6pAhJ0CW2EtwkkpwF4fe/PrF/DNIv8B+eQ9Jgsig
         SWpp9N6NafKH/9tiKBrvfTjHffGujxkm3HiAHRgqAIE3onSCySPOrjwRlWcCZXQsALf4
         u7soQ1ocal669F97hqhU3A9KCaMoXh8aEyfgV/IA1WZ/+0whf56GFOGAmJgBFEdtM8XC
         Y8tkA4vPwezkkMQMmy5xUUc9Wk4M1YCVguYixwxHiWZsuN9dYMqLDTkthnYCtQZI9k3a
         9OLQ==
X-Gm-Message-State: ABy/qLYXUsvFs+j09NsWcbhxrF36Udr+pTDAl15C6LpZ+VHmlOy/CVzq
        qDRlyD0LDVJ6FC2OhrWok1I=
X-Google-Smtp-Source: APBJJlFtcgWByzXrBVspPGT3Sy6Zkt225GnJ2K2MZZegMOL1I2moz8jmLkp4pWDZdHK+qZTj9x1GzA==
X-Received: by 2002:a17:906:30c5:b0:993:fb68:ed6c with SMTP id b5-20020a17090630c500b00993fb68ed6cmr1877710ejb.15.1689943153199;
        Fri, 21 Jul 2023 05:39:13 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id dk14-20020a170906f0ce00b009930308425csm2123640ejb.31.2023.07.21.05.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:39:12 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     claudiu.beznea@microchip.com, Guiting Shen <aarongt.shen@gmail.com>
Cc:     u.kleine-koenig@pengutronix.de, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] pwm: atmel: Enable clk when pwm already enabled in bootloader
Date:   Fri, 21 Jul 2023 14:39:08 +0200
Message-ID: <168994313438.2987087.16791169128100563867.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716020652.18557-1-aarongt.shen@gmail.com>
References: <20230716020652.18557-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Jul 2023 10:06:52 +0800, Guiting Shen wrote:
> The driver would never call clk_enable() if the PWM channel was already
> enabled in bootloader which lead to dump the warning message "the PWM
> clock already disabled" when turning off the PWM channel.
> 
> Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
> the PWM channel was already enabled in bootloader.
> 
> [...]

Applied, thanks!

[1/1] pwm: atmel: Enable clk when pwm already enabled in bootloader
      commit: 435ed5851458084b45f42df8689536d5f3d0e126

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
