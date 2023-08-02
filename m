Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D9276DB0B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjHBW4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjHBW4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:56:46 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFCE9B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 15:56:45 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d3563cb41e9so307812276.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691017004; x=1691621804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdwmbxTZ9xoN49nagt8lPukQ2l2Y83hDT7IQe2sYCPs=;
        b=mnWE+2pZOygQHoK/v9aGFiO96jjkyFJ3T2pYe4NJBXK/+Tk75WLjNrOmshDQpy1248
         sNVNxeFmtlUaYVABwKHxdlnveS2693KKCBo50B69kJeYFwYBP2UPr1keCf1g+yAEFJdZ
         cKy1EqWnHxN9znkZk65VSTWMuzu4k/vmP6z2fnrzKzueT4mfHN8E3Q4OvynoT9oZs3/y
         0Gk/Ja/XxWFB/+HSLILN8yhgv964UrDYepU5YLTkNaYhZTXjeDMuRTNLTAxKitEwfKnN
         n6Bu+Zc+BHeE4JCqhXuSApwfZdSrDFGlFmidr5EL7GfMxBnutE4OVDWp1e4dJIFfOchd
         FcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691017004; x=1691621804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdwmbxTZ9xoN49nagt8lPukQ2l2Y83hDT7IQe2sYCPs=;
        b=R45iZ2rVEyr+Aq+Ok9otZB1ClaRyIy9RUhADekUx4U4yN/0uikiAEru7Pmr2V2bjkT
         GYyw89wdF94VH7MSmgDJClFO6SiVoJW0dbuKeJWKa0/WPzHM6aliq0qJNJCqyo6vteOD
         ZKbfY9WmJo1RLOnNZ7BxxfmRkr1i4SfDiMC64sXaRKvXXSmj568BGX70XGX0Gzq8YhHC
         RlKg1ZL6OLdB3oQ+UddVTk8OgSugAyGM+/8Rv3lxZ1NOpX2/cAWyWUplMlM7450raic+
         W+2ShRjHCmlqDuGNUlTzTEQammRt0ZC8Qef2/p1WI3h8+N4GU9z+X0IgBSjZ6mOUUrTZ
         4zkw==
X-Gm-Message-State: ABy/qLZ7UvwlcKB1RHdnCwstGhAsG9dehGBm1G3LNlAjHMTvtoJsD7l2
        JnGQiDsSJJIIlRLG2ZLqKh7wMi9yo3TaapxnwBNfYA==
X-Google-Smtp-Source: APBJJlGVzLLx9DFJyblaI+NJuVC5XH0vSXNWYbehcYXT3HYdEaMR429GifgoYUyPJa/KFMrgJ6nQje34cFR/0MnOe44=
X-Received: by 2002:a25:acd1:0:b0:d12:29c8:782a with SMTP id
 x17-20020a25acd1000000b00d1229c8782amr14156188ybd.61.1691017004553; Wed, 02
 Aug 2023 15:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230801190951.51818-1-brgl@bgdev.pl>
In-Reply-To: <20230801190951.51818-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Aug 2023 00:56:33 +0200
Message-ID: <CACRpkdZFr_rqwuv5vxJYWP32g22cXh-n9aFYOO5d1ufNvaFWWw@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: mark the GPIO chip as a one that can sleep
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 9:10=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Simulated chips use a mutex for synchronization in driver callbacks so
> they must not be called from interrupt context. Set the can_sleep field
> of the GPIO chip to true to force users to only use threaded irqs.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Obviously correct.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
