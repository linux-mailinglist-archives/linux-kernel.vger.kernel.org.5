Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38EF7806AA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358312AbjHRHwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358351AbjHRHvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:51:24 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C424206
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:51:08 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-48ae4823077so183027e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692345067; x=1692949867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9DA4IDcpAmXOv7d2oJD3d3UaFajAPi9XbDwAsxLsm4=;
        b=H/If5wZ5hyuUbDm3DCwvLp4uS1ViBbkr6yYyQD0+EBvELt+ZAAwzlpjmPVtXmxEd6B
         b4BBan/5ld6yIVhgIOIAUfE5Yl4Lzjk/cL+UvBYmzCyTry6IiF5pzugOTEPS25yBf3jY
         zLC7XzfdYrM0KmXNG9mG6pOi8dRTIqk8c+W9GECXd25JOzn4VAUbuyjC86nYrigq2qdU
         F/3kMdJ2JtKi597QwzCI1RGEIz6lDsQ5w1k7G7L/X16cYNuRmJgrIPjwOYJJYpDtzAio
         icPfT8tVk2bi2cgl6+KtyC6X8fDI/E0B3rfCKA2GrOzBc7qvNpqcRcpBe0yTQVsYuU7X
         qB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692345067; x=1692949867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9DA4IDcpAmXOv7d2oJD3d3UaFajAPi9XbDwAsxLsm4=;
        b=B77vOH9DA4u7Dj4gRWP9Ze8QwLzIiLYrFLWEj9wa19QbhyWveHPH8kiYjZWQnuuCYa
         ds7lYzzUJi/NyCDF9Me65W/9vHCSJPAC6JuNFJeNHVRFV0tgFnpJ1S6WotMnNdxQXVzL
         cPPTQv37Iix+vqor6sS/XW+ZN8TPxMIX47VsO0KJxQq0FZtlpXnIdAUPtijWmsyJTSXj
         iQKok0IKBNC/8oa1BVVZ2jtFpBl/I0PWwvadKCpj+SICMdDz6IqkFCx9mUrJRSdpQFWG
         HY21AtEybLd+kXcBS4TjQbMWLPhvwA7DlGGbDp7Y8ZDI5zrifyHdjJUrQhmEk/nWsHqQ
         C5hg==
X-Gm-Message-State: AOJu0Yy1waAJcALuhnLUMkpLQ541Cz9Yf295esJzVX+u7nMmHfcssf8I
        Lv9SPheK0Bt7YedAv4ctq1KUThOodpoFzl/bQhaXmA==
X-Google-Smtp-Source: AGHT+IFdpboaxI+SV82u7O4mzVAkPe1ey6AP6pmPdhnAvT1jjSLLINrEjIFAIeiqJzJFdhi1y7bc2mHcxN6SJePxphY=
X-Received: by 2002:a1f:bfc6:0:b0:481:36b0:aa01 with SMTP id
 p189-20020a1fbfc6000000b0048136b0aa01mr1869663vkf.6.1692345067644; Fri, 18
 Aug 2023 00:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230812183635.5478-1-brgl@bgdev.pl>
In-Reply-To: <20230812183635.5478-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 18 Aug 2023 09:50:56 +0200
Message-ID: <CAMRc=Me=WPRGRhGcNVpVUnYvU8T=-C82QYVHhTffLcJaFq7rnw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: sim: simplify code with cleanup helpers
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 8:36=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in gpio-sim.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

I queued v3.

Bart
