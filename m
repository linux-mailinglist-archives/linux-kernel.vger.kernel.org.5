Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E3575575F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjGPVW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGPVW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:22:56 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959061B4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:22:55 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-cae0ad435b6so4149562276.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689542575; x=1692134575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehHFd2i1D4cdxDgZXxDtxev4s/OtFUIBV9R8JH1GczI=;
        b=TUANb1xdwg4ApfDT153qsO6QCznb5nxHBKEhNirqqCNXAE2sRkK2qbvW49vqxIsAj2
         o2d0ZFedzmRDzUrDHmn0LcAsYOg6z8ZPD+RX6Vqg3LesLA6K8FweiqJ6RiNjb507yS7J
         mdzOgTJygiJIrBrFtehvMOuu6AhkSN0LytONWTRC2sSOQeK9jfjBPxGgmtKU3x5wVAuk
         pGIeeLly8iAwYCG5ts7WPiV6nwFJ9jkDCjgu5w3cFHMpcmzUjp6oCkVNsHui7JD8NlYY
         /naJzYS/oBC+CDcx7XIUGGVbOkDCjT84b8RociW+eusq3Wx7Uvgx9u/SPNpIoF3bfmLH
         gjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689542575; x=1692134575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehHFd2i1D4cdxDgZXxDtxev4s/OtFUIBV9R8JH1GczI=;
        b=Ln65yZt8X8elEFmynpJGps4rDZ6ZcYFkI74Gp9BXnN+MpEe2zBFlqnxiYjbbOCsS5/
         ZCz9+y9csyaas98+6wiLSO6Tzxfk6dVUqrRvzdGuR2stwdrmJHKHO5DaNaYPdLsvCT5z
         zpyFhR2rUY97O4RkmlWSaCG6AA3FYBuSBBJdukYzdK2ZlLfNMKYLykwlYm8hjq38ECM4
         u58flWP4Cw2OvvyFH9QrBNa599dwgklxhbEqeWS2GIUXX3lsYeOcjVBXLx622lyP1i6U
         gDd/o5WbBZX6XDPsfS/kZsPE5UlFpwV+Qmt0tnLGbO2/Qpvp4oeItE4qNBzQh7PvEp8r
         eOhg==
X-Gm-Message-State: ABy/qLZwIm4/hq5nLo5Ld62Op5bCy9iCkammoC1D6fA75KxLiIJ5NIk/
        O6/BD1PviuS5A09XAwz7b4BSBKHvLLwsBSEYVye3WA==
X-Google-Smtp-Source: APBJJlErNg8Oc3PPMT7Mk+Lfx5QAC/OC92g4sKDGGNguhpK28xKdYtC3K+IjcJQWqeu8+LMrged+MnE1lM++5T7GyW0=
X-Received: by 2002:a0d:eec3:0:b0:577:3fb4:f245 with SMTP id
 x186-20020a0deec3000000b005773fb4f245mr12710224ywe.19.1689542574879; Sun, 16
 Jul 2023 14:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230707095415.1449376-1-arnd@kernel.org> <20230707095415.1449376-3-arnd@kernel.org>
 <CACRpkdbiDUomH8HLkk_jyJZYc+mEmRaFL8-JasDmd=ooSB62Qw@mail.gmail.com> <1c0119cc-7787-4f95-870e-da1c5894625d@app.fastmail.com>
In-Reply-To: <1c0119cc-7787-4f95-870e-da1c5894625d@app.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 23:22:43 +0200
Message-ID: <CACRpkdYVQa-p_tA5reK1Biniz6xf9gWm3K8JKCbjr4fO3=GHZQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] dummycon: limit Arm console size hack to footbridge
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 4:28=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:

> Since you have already spent the time to build and test a kernel with
> this patch, can you do one more test here and check the text size
> reported in the atags on this machine and the actual text sizes you
> get from both vgacon and cyber2000fb?

Heh I tested this then walked out of the office for vacation.

But I can put a note in my calendar to test it when I return to
my equipment!

Yours,
Linus Walleij
