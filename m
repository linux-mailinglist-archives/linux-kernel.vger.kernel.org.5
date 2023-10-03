Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3624F7B6CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjJCPQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJCPQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:16:56 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E0E83;
        Tue,  3 Oct 2023 08:16:53 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3af65455e7fso720418b6e.3;
        Tue, 03 Oct 2023 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696346213; x=1696951013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4ae0RRMoTga+gtJl22Je3cvBedkJ8+kyu4Au/fIbrQ=;
        b=duUSJfFuHARpzYp6CNMfI4OGTBVKZb0XrqIOIX1xo/QHalMtAKtTz7LJYx989YZBrH
         8XW5byOI96NsVAWU82H3vumrTd0S7yjQB3nXQwL6iAUCE9+8CTHYru63sBTE21R+bKB3
         5vfceyzzritUpCc7QRWPegmNUMjAs/4xj7vSo4U5tfinx244pAsqIK4e400zjR6sSy7D
         wPHJQyETYcCIT0p52SfIwCHaspfdPh8obdHuxU5h49UYYotuNwGByWdPQRag1C3Fw6Iv
         mXIBv5jY23DH1IbdgJl1Xll24DRK2juD+3DH5cJiNnt46YiLSaanleDhNxfAaVkJwrkt
         lpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346213; x=1696951013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4ae0RRMoTga+gtJl22Je3cvBedkJ8+kyu4Au/fIbrQ=;
        b=iltTbo1Zq1vmUXRtvMMf/aWa7z7+g0vatsqCimzPpld2AU3oUwj7wvHGcWJ/eECzJq
         M8xbyv4YNJRVk3Qoir1R6ek/YXSw4CeE5PIAtashkHU2w7Roh/gQZcbqmo4Nf5ESfG8G
         VYwbd4+fb6MGMiqbS05ushk6VR/E//23TKN8cjAKsmA5Rp3CWIHVw9XB5FoOiNAns/cz
         oNQmF2dG1rY9Ca0jRLQ6caVW7FoQz4oBG92bng/GB4se/PyEEnToZ8Q+ylj8hhnuFfHG
         bzC59GHDrvMNMmTOxY+KswCJiHRvkTKziZnU3y16W/C1QMO+1GJPNzPlTMYTvGkjq4Bk
         ShnQ==
X-Gm-Message-State: AOJu0Yzjw6T9E9MFIIiX93IY2ee7oJpwiNEp1XFIv1ObreDSxB5v0ycX
        65iFPu15kfI2OjSpmda0InZdOnGELYJgHZuf7yE=
X-Google-Smtp-Source: AGHT+IEfuZ94VWCEmgyXwCydZNzN7eSKHshl37YDLU9JmihWLNbU7UYPSNm3CQLCByQf05GhYdKtuB4kIrf+nIds2lU=
X-Received: by 2002:a05:6808:1a96:b0:3a7:2456:6af6 with SMTP id
 bm22-20020a0568081a9600b003a724566af6mr13430282oib.31.1696346213032; Tue, 03
 Oct 2023 08:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-35-brgl@bgdev.pl>
In-Reply-To: <20231003145114.21637-35-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Oct 2023 18:16:17 +0300
Message-ID: <CAHp75VexazbYskr2pxOPzZe8q=o4ZCHnhcN6U1XX=Th8sxXCgQ@mail.gmail.com>
Subject: Re: [PATCH 34/36] treewide: rename pinctrl_gpio_direction_input_new()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 5:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Now that pinctrl_gpio_direction_input() is no longer used, let's drop the
> '_new' suffix from its improved variant.

This and other "treewide" patches in the series are redundant. Just
name the functions better to begin with.

--=20
With Best Regards,
Andy Shevchenko
