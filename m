Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19E7666A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjG1IN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjG1INg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:13:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F073C11;
        Fri, 28 Jul 2023 01:13:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99454855de1so245528066b.2;
        Fri, 28 Jul 2023 01:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690532005; x=1691136805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8jQrccsPc+Yci+ONr3TsmC4imyyjo9X+IFR2I4Ay5I=;
        b=GmOdYJLbZqJo3SA5BqvtqN7S2msoqTc8OXT9WGmg/YUlNeR6ayCRn7jqA2TRw7+VVa
         Qd20oAqCvl+vEKTo8NT1k/uGOVt0e9857bbDT9lnOsgKqJ9so2uqY7LxyJIVFZAODx99
         JhjBjc4CRVQGrYZ4oDfCQxfBU4maEo9Ls1tkKJmJELfq1YJhKKEYUmqaQMbZL4qAzA7f
         v3k/NIehKZQsFIIv4WXDmOlHnY6bdy1SGsURMuIgNxFBvnBVMsL5+7bgUHuQpsjGyALu
         H8yvjD/Ng6OIYVpetSvt1c4NHPTXOLmD3Xh4K+WnW0rf1l7lsRG0FuGHysTCjHaXc1Fz
         nGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690532005; x=1691136805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8jQrccsPc+Yci+ONr3TsmC4imyyjo9X+IFR2I4Ay5I=;
        b=asyyTUymBs2IwWcgBPFZmXX+syOdaRdHQzRBP0uGjAeqim5N1aNudSt4TvNuvaTr7T
         urkNKQNmyHqTrAAPcofVG4rzXljn0yS/VQsOJ/lA/gKWx2acAc7f6807rDey5jfhL5CY
         XaDiOKMgtqDi1Q0SiVNbKls+inEq2Q9x5vO5h6ahWl+vGsg7BwJP0SYJ0o2d4io+EehR
         /dcvrfKAbk1xdn4yFzb3PhodM3Y6LNpEHqc8nfoXzVKWbC8gr/rHiOHurVbzchKh6IU5
         Sj7WZP8JbboS58ItN19kdwPZR6QKGKsrL8BJqLQc5q8XPFH2B/x4RUPNf2iK54N/D2IT
         nHBA==
X-Gm-Message-State: ABy/qLb5KipmfJF6AQ1HDq5ZgpoAR7WZxZZ09trjNzxp9z+rpT1DB5y5
        prPFBxal9mD0T1qGAQq/9Xs=
X-Google-Smtp-Source: APBJJlFy7shLRCnh1rx0nPjpKfoveclxsf4mIU6Cr1i93tFVItp3jezGvRFx9BiegdVzXsOX/b4OqA==
X-Received: by 2002:a17:907:a06c:b0:99b:bc52:8d2 with SMTP id ia12-20020a170907a06c00b0099bbc5208d2mr1296250ejc.6.1690532004876;
        Fri, 28 Jul 2023 01:13:24 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e6-20020a1709067e0600b00992b66e54e9sm1736948ejr.214.2023.07.28.01.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:13:24 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: pwm: brcm,kona-pwm: convert to YAML
Date:   Fri, 28 Jul 2023 10:13:20 +0200
Message-ID: <169053199369.3516709.17303093302143505470.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230618142327.GA20367@standask-GA-A55M-S2HP>
References: <20230618142327.GA20367@standask-GA-A55M-S2HP>
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


On Sun, 18 Jun 2023 16:23:27 +0200, Stanislav Jakubek wrote:
> Convert Broadcom Kona family PWM controller bindings to DT schema.
> 
> Change during conversion:
>   - add used, but previously undocumented brcm,bcm11351-pwm compatible
> 
> 

Applied, thanks!

[1/1] dt-bindings: pwm: brcm,kona-pwm: convert to YAML
      commit: 8b9d91d23c18423d4e4bda735f20b669fb28115f

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
