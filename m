Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097737AF50C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjIZU1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZU1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:27:14 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5B411D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:27:07 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59c0d002081so118061087b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695760027; x=1696364827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgr0elKj9lSA9DaoOQmGSleBXdUJYBk6OqVSBI3fCoo=;
        b=aawmHcirD8DsgSzYr46dSgc4RX94o0O2lew5iksT9aga1rcSVvJ/hnXDM8V6FitWsq
         Zcuv2+/iFeZwd7H4RNkuMTTpIR7BroGfS/2DmW90GH6GPs8eNY4csyymim1Z/hfPwRYh
         FBN9QAUERNuKBknhnJK4B/6aOMTy8eiCqnEiskfVtEG/mouwUm0iTHhHxDXF6JfMpAan
         zZDGphm7arpqIv4aBe8pwh1VQMAy/v9ootmIrttgW/l/3e09PoEHA+oB5vxEvacZ9F/9
         wxwwF4mWGcVCcNgVyNlNC11xRoei6//gAW5jqnQNvIPKxlGJTTqGOGAbGcY3Zt/50qT0
         +wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695760027; x=1696364827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgr0elKj9lSA9DaoOQmGSleBXdUJYBk6OqVSBI3fCoo=;
        b=BpPGB8RkZE4nCKof0ZLlYBg1UJ7mRVlDdpFHoUVGpmNNobL/VwQ5snenPgo2tgUJzG
         swd81aegy0SXLPybe1+vFG5zectrrfwsu4TJ0VZwj9skQh9mP5FPmPvC6BEsoUkBYzAL
         j7gsH5VqoAA3aRuHJaBwozb03t4AdnwSPLEdVfChSBfjgfBvah8wZUE5g5xDGZWHGG/4
         hqmO/MKRZEYzf/Jnw1Y49yg3tBIFbxy33fGqs6yW1Wyzy0k67O4oDQDPRGONOgCOH8ky
         YVwLD1lqyHrgAKsadpTylhsLTMVAPbO56H+GtmjibVAFxoLBG4ueRYRzCVXVYS0it9RV
         n6tA==
X-Gm-Message-State: AOJu0YznHW40AK83UAyhW9v0S0KwfIyFd5153MZo8DMJRZpQCwPA/at4
        gf/B3EdRwM0XLjt/Le8rMb+WNkzj0LTkWdlPhPOTgg==
X-Google-Smtp-Source: AGHT+IE9ToDynTpmGcT5P/uZKHvPeXXQc+bPT+qu/G4gEmvRth4jAWXdjvJ1oG4ktxEO98GYZKAnKHIrOYHNrw3dF/A=
X-Received: by 2002:a0d:e442:0:b0:59f:4f56:59bc with SMTP id
 n63-20020a0de442000000b0059f4f5659bcmr59412ywe.42.1695760026911; Tue, 26 Sep
 2023 13:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230926-pxa-gpio-v2-0-984464d165dd@skole.hr> <20230926-pxa-gpio-v2-3-984464d165dd@skole.hr>
In-Reply-To: <20230926-pxa-gpio-v2-3-984464d165dd@skole.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Sep 2023 22:26:56 +0200
Message-ID: <CACRpkdb8SwC=W6=Tiz0Uxk1MeQq2gBmDYQYyeKbWFzvaGA2mGQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/6] ARM: pxa: Convert Spitz CF power control to
 GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 5:46=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:

> Sharp's Spitz board still uses the legacy GPIO interface for controlling
> the power supply to its CF and SD card slots.
>
> Convert it to use the GPIO descriptor interface.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
