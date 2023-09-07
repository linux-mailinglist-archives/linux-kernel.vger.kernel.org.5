Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6DA797889
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbjIGQsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjIGQsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:48:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050931A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:48:17 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7e6d9665bcso1036765276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105239; x=1694710039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYoxChlU4Q9Xf4jiILAEb1/yHuX3jjQxtu/fJCh6QGo=;
        b=T85rvb0SCA15x8ix5Y5yvpxwUbgeUaepjGgGQI8xihNnzqjZ9m59dFVEQ6Qhc5NpTQ
         pOysdpmK2WnaAieESDlEK8dBIyabwAMZ7iprje9/oxVFTLdqhFL4W5d7evGVu//A30eM
         qwIz6ExlcPjGRQewmaLOChquycKTAkHLaDIurA4JvJ4OAezbp2hIcSc/BwFa9dSRoXHe
         SRmCmSjcR8Mb96risKJ070PRjn9S1Q6Y6bgft6bMIt3/gIl0x0rGLgPoWmBScNsY0YiM
         9RuueOzg+cNyp6KaaaRrM4sDuRB5N+uBEOwOI5+9TUez0XHAzNuuKtGOKo+N39Hftb5A
         btvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105239; x=1694710039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYoxChlU4Q9Xf4jiILAEb1/yHuX3jjQxtu/fJCh6QGo=;
        b=SBgk0WzrZo1YKvxcwwymDd9TZNB1DM3sh29YBSx7lPJQ7fnBadCjLlrTicyK3mGfjV
         D88joNhXggH/onxIlc8YEfEB8sX4XsfwxBXxh3T3wr7lGN/yQCyPVwGw3ZfuoQ63QRx0
         Ex59OBSFI/kZk+9lvG+ie1CZQ/YWVmjYw6q2MqBRYk+ki/RrsCo4RGl7T9UkCxtuqtNS
         lZFfrAMzZJ10x1xsDtPiZ/K59t+yFxHbTRK29f8vWxZpRzF9KMz6dTKZER9y3OrrVO7+
         1QjcD2n8uG1gZc8RJgUI/1JLRr12hrsv1faMXsQJ/mvncXJA/sjFwQOOeWpQKi1CgwMD
         cx/Q==
X-Gm-Message-State: AOJu0YzbSmDEAG7PoBJ9kfDWGDGFlBbaUXIHuaFqPxbnaJoPUhgNDhb+
        AECVAurytWaMxW51yBgqk7OvDHM3yZdE8xq1WpeIG4u2NPhc+Kv8jBg=
X-Google-Smtp-Source: AGHT+IHaxiCnBZm00LuWWUA+a8rnudg+hvum/6YQLw0kwU5o8WTcy0PQZuAfaxNBOQSTfwUYu0m1J/nwQGnmFDsy/5I=
X-Received: by 2002:a25:e6c9:0:b0:d05:fa02:5bf5 with SMTP id
 d192-20020a25e6c9000000b00d05fa025bf5mr19872193ybh.48.1694072468477; Thu, 07
 Sep 2023 00:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-21-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-21-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:40:57 +0200
Message-ID: <CACRpkdY-DMJAzkjVFx2Jyw6yG76u8cZ61YPUbcCsosN5kZ02Ww@mail.gmail.com>
Subject: Re: [PATCH 20/21] gpio: sysfs: drop the mention of gpiochip_find()
 from sysfs code
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We have removed all callers of gpiochip_find() so don't mention it in
> gpiolib-sysfs.c.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
