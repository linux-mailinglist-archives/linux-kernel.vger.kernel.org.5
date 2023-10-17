Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD07CC33B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbjJQMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjJQMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:33:18 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E4A4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:33:17 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b5fe8ab5f9so2026362241.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697545996; x=1698150796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zOK25AhejJsCNGYHq5emnXVPEw8aJuYMYEOx/eSslY=;
        b=X6ZEI6VKLdgy4hArHuidZnwO95llrqocYliUr98W8TEQgc5asJtQU/Rl8hhXNmY41Z
         UMaUtWRKW6n6GJt1TreHcWHTKVVoJuhfcKkEmj8rgeVkJceDA8SlOjzky44uncQAPDPt
         7IWpIGAODf+cvNy4Hau5rbJExKUNmPkBl9mG5IU/qMkf9ju50TDsAoci/7twxkDKWUVc
         KQTn+KYpeLA/QdLRtjkxdxLYTY0iNG+zOAvYAbyl/Mz2Gf0jqNdIhCw/s+ywvt1zSrfy
         EVYTl+8Na+IuZCQTrkKFUKtcrMKmWcU4UlIjYbq6s0ss6yudnkwr7vxZMWOHCLRJuulU
         1tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697545996; x=1698150796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zOK25AhejJsCNGYHq5emnXVPEw8aJuYMYEOx/eSslY=;
        b=GdyeP/P2QwXmwsn6qHLY36aOAaGrRkZR8iHHgitbQj9WJEGONSd0KhFxSCxDsTc5Hp
         PjTdcnTSHyauOoZ6MdhgZF4HeGR/nQ3HzbdKAW6Ib8CXaZK1EBm79upXgQ+LVSYg8jtc
         Ix9g0Mqg2kPkBMPdwYXVtg6TPw7P4zRC+3aHafNw5W6wENQh2xTlKHyoRC5Uc9szHveP
         3MvCZjWOiC6CeOZrhzootWwRCGawV8/jSEpbmhAxJFLyIcQ7gJeqdbKIG8iyFukTCkoE
         h3vmIsIUf27SL4Of+YrE50nLEyqQH/l0TeQP8B9y05bHexRYYvWDW5EdIT32u4DxEBA8
         dADw==
X-Gm-Message-State: AOJu0YyRoY5dqHZ/WzcUl2DIahSNeBl/EuyEB0FllwXdQ6RYfpMyUJmv
        MaY5Dstr7LfmXwoX7lov+lC1k0rLd8JyjQGS/BD66g==
X-Google-Smtp-Source: AGHT+IHKa+vZOJw8H/LStebORG+Pgptjzt7WNiFEvBeVqbXr67kxtc+SjG30gXChUZuW6l9vM5obq62BORTYPHo3M/g=
X-Received: by 2002:a05:6102:2a57:b0:457:bff9:f51e with SMTP id
 gt23-20020a0561022a5700b00457bff9f51emr2478802vsb.27.1697545995341; Tue, 17
 Oct 2023 05:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231017120431.68847-1-brgl@bgdev.pl> <20231017120431.68847-54-brgl@bgdev.pl>
 <ZS59+F8trJIjZ1hl@smile.fi.intel.com>
In-Reply-To: <ZS59+F8trJIjZ1hl@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 17 Oct 2023 14:33:04 +0200
Message-ID: <CAMRc=Mdj5FvTcpbJ=6UvsGRjcz_dL+cqEwUNsyAcQXBXNiyq4Q@mail.gmail.com>
Subject: Re: [PATCH v3 53/73] pinctrl: intel: lynxpoint: drop the wrappers
 around pinctrl_gpio_direction_input()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 2:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 17, 2023 at 02:04:11PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > pinctrl_gpio_direction_input() now has the same signature as the
> > wrappers around it so we can drop them.
>
> W/o "intel:" part in the Subj
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Unless something new comes up, I'll fix this in tree in order to not
spam the list anymore with these patch bombs.

Bart

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
