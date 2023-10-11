Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1927C5257
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjJKLnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjJKLns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:43:48 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E79E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:43:46 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d857c8a1d50so7035057276.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697024626; x=1697629426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ms2vtbDlNLotZRA9zziKsDWimhPIOZieH9Xxbts9Gc=;
        b=Xgf5xcA9ZmI0rsdXBX4sb5GATD/BhmMDXZVQyg8yDgHqWHRIZ6TEIzbzllWM3lq6Dn
         bbkPxYiA3MI8rJmSSZwTwnCxbVEL98vpnY5+k3IXZMJvZxT4VOj0L7DcmrrgRlA75QQi
         FHIW66s+wEqgQXWpVe703uZzZB/Za+w3/4VF7ggergduZe7EkxpglfACWZIEjiztOSPR
         cijCEBPcjdGy4X5vbL7nIXjZcdt87teHNIXFFq6jxSzLwSEmO2jKiHA+Q3CVtZHqB2vv
         N5bm4FCbpIoAr+nC1gpKzCq8NbnyBcQUd9YIuRYrznCVHhqFqPm87gCDcrz6BzxrkO8N
         rz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697024626; x=1697629426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ms2vtbDlNLotZRA9zziKsDWimhPIOZieH9Xxbts9Gc=;
        b=Z/Bx+TjtoUTWorUfci0IaMC27nBNDB4iow+wzB/oGdk8KpozVMHs6naJ5+VGatZOXN
         /1UMMQ/k3bWRxOOQJivX4gnN04n34rUBloXhHrkbjy9ljK/RWA2rq8Ji3Bh6N2UABb/3
         X+DtCbIvIU2yPDHuEYlxDNOkWM2FaVvsCVbz/5dG5ScudaqJmmyj1o2FHWcTvCtth+IZ
         Y3gxr8TMUvRJ0Xc53lXtHukVBvnRjteI727PCO5iQFMyLF3fKuqIm7h2OVDE5L7f5gEr
         fkr54DahLs6xHXSRKdIDMX+jV5H6rrTu2oHFGC9qfgqXIkjxUSbemTmNQrHzCig8Q9dr
         mhUA==
X-Gm-Message-State: AOJu0YxdiZjOilB84wn8s5vAOSgTHn1SE8Yb1X2V390lHckDH4izMinK
        O+tfuAJ9ljFQcbPgooLwZMBR1q2mXd/fzUBLg/urgg==
X-Google-Smtp-Source: AGHT+IGv903cvmdbSYh+DAb+5Tz4rULNvXAQTlBg+7mdFxAdgy0NyhnbXdLN6utN8XfBDPbmB7i+1uIbbVMACSQpBvk=
X-Received: by 2002:a25:ccc1:0:b0:d6b:6b53:d1ab with SMTP id
 l184-20020a25ccc1000000b00d6b6b53d1abmr19665014ybf.38.1697024626069; Wed, 11
 Oct 2023 04:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Oct 2023 13:43:34 +0200
Message-ID: <CACRpkdbEzT-VWOP26oDWc7YE=t_wNOJKo=CfQxZ-vk5Rsmzt8A@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] hte: Improve GPIO handling and other cleanups
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 5:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This is a series provides a new API to GPIO library (so far only
> available in the GPIO tree), and respective update to the Tegra
> HTE driver. On top a couple of other cleaups (patches 3 & 4, they
> can be applied separately).
>
> Patch 2 inherited tags from its respective discussion thread [1],
> but I believe the Tested-by needs to be confirmed again.
>
> Due to dependencies this either should be applied to the GPIO tree,
> or to the HTE when GPIO updates land the upstream (optionally with
> the first patch be applied even now to the GPIO tree independently).
>
> Another option is to have an immutable branch or tag, but I assume
> that was discussed and rejected (?) in [1].
>
> Link: https://lore.kernel.org/linux-gpio/20230905185309.131295-15-brgl@bg=
dev.pl/ [1]
> Cc: Dipen Patel <dipenp@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

This is good stuff. The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
