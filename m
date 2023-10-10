Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BCD7BFE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjJJNoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjJJNof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:44:35 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A910F7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:43:31 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a505762c9dso69522727b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945411; x=1697550211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=bDsg4HyBxnQj9BsGh73No5c+i+SJcn+iAla/q4BV25JQKEFfZ7rnoTHF9k/2+GtiiF
         2pR40bmpI1/bh84IPDsZ75U1PXjyoWvbTbLRZG4OTol2XMpRHkifWfKSTkjxJOTdqGjN
         E0etK0PPePZQaTTJtVYRItiErhQrEpTC1LQxqmmrm6216uH7G7nNcsBHwgGPJJSpsIlx
         fNItgE0FmXR05l96oHgz80jhWQb9zylbjTFEj3r2hMQlSW+UpVHJao0SyBdF3fb37qlG
         RMwS0JSLdr+lxlYmuLA4EUQDncD1/0e/wp0NSZn7PLk9UlXDcN09uut2G56354l1aQjc
         7JeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945411; x=1697550211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=XHTGuOE07sM6y2gvmMtjjkQgrdUWsFgbi7FegOCI372/6j8S7BszToD1kzclEU3rhb
         pPZTnDpau5dVCjFjJUoqVcEwjVttnKu6Mx3kpMLO5yIs5kRF03/dtCr22GOcRuYQ6gGV
         cjwSVxGhnanos4o8qUGxxiwE4Al1l6Yc372H1wiUUmT3GaK+qFVA30dHmAUTEGWhLzga
         k6/v7sgshdxzyfWtxtO8GPLD7UeuH6Y24KNhTYo7viYHqZlRE7inP5NTZQU3nONxwB60
         1h64bBRfGHOuZ8ItXIDVfuypoHO7muAyEH/i/muzn44VBPmMjSHw0MYz236DDIcHUsfn
         kXqA==
X-Gm-Message-State: AOJu0Yx3lKG32mFy/3FXpPGNE8gkkCxpu+Dfu8FmmlB0vtdSCZVe3Ud8
        bFVTSjcCeZrlkuebPaO4+MtgVk0aXn239SAOhIzcng==
X-Google-Smtp-Source: AGHT+IEItpd8Q6wOYAjPFdQpKLuERjEAHoKQbqX7i9cE5Qkc0YMMTS2uOTDXaJ61JHWygvuQCrqKQkHPSdQvXnj78pQ=
X-Received: by 2002:a81:5b02:0:b0:583:a3ab:b950 with SMTP id
 p2-20020a815b02000000b00583a3abb950mr16262239ywb.50.1696945411098; Tue, 10
 Oct 2023 06:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de> <20231009083856.222030-17-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231009083856.222030-17-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 15:43:20 +0200
Message-ID: <CACRpkdafp2Ha50jkXWVo4JYeuReKOcy8vH5eqGqsuD7d6u511A@mail.gmail.com>
Subject: Re: [PATCH 16/20] pinctrl: qcom: spmi-mpp: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 9, 2023 at 11:22=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Patch applied.

Yours,
Linus Walleij
