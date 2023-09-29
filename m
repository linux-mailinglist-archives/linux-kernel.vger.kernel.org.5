Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA287B3B73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjI2Uoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Uoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:44:34 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F9E1AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:44:31 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57b635e3fd9so6179924eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696020270; x=1696625070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXgaZuLH5GhY5YWuK4dVk1ahirvrXIvxqJnkznda2HQ=;
        b=nXKiFts/gaaPAQpSwxDDsiYDQ3KwybJRWgSlJoYapliVA8tguly+m28pw+F3iL9UQm
         03TlzrFiP0PDMOQDgLW6U5QXKg2uczRPzti/vMatsj5rif2mx17KG4nhGVkaQo6ghXh+
         pj01ULjagZHYPVBkP4taKcwP2W2WTTSMUq3hUgjF1+P6O6yAxFK+oO6ufPtE33Wl6hMq
         Tf7mnxyWNSSfRHHFSUtHrHSisIrtNmFfIztNKHX/qEADBb4i5hkmbze3pLbmtF3z8LCf
         w5CDoKD/Qis6ObNgkkRXkf/0dZ+5x9E3rc+g9mVx8Ci0pYMYFiSVB7YHvbW0PO/Wlv89
         OoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696020270; x=1696625070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXgaZuLH5GhY5YWuK4dVk1ahirvrXIvxqJnkznda2HQ=;
        b=OsnocHOM2KG1/BMk3HFH0gRr5+YQZj7VPnXmMMkCplgNbhK+2FLKdARFLcu0je/L2W
         TX0vwSnRaM8FNb/DUcIUlwppGCiNoSN+R67KQaxmtIiowFW1aGUSThZJ0W/zO5+sWP/G
         AUT1NCTGnoUztR5+d8gFP+V0uLkLK/ycgUl/Le3sB/58c3nYmzDGlLXlsfg/2TPzVpOW
         5Muve+eykvvGBgzDwBRHllu7NmNc9WGty+efCxn8de9EE9R+kRVzrTpn9IT+KcC2Ec7m
         O6qBIhcSB1wbeN9qILykaY5C34pG00EXqB5UDrdiDr9/HEXeZ9Tnr5qC1Tp/0zyShGNP
         5IxA==
X-Gm-Message-State: AOJu0Yxz86YnbCPsVCz2LYmc5RsjeZQEgCcd27iBASE8ydFL2hUVOnir
        ln84M4ActGarIGwlKUyptl+TiXXtGIECeNJZe6odk7KQbZqUZ2rX
X-Google-Smtp-Source: AGHT+IGwW+ZGTjCtnkf8EeHm+5d1gyXdI9e9XTf82f42V1QQYzuHt0f+TLPGcG+HAMgnndLYj3TS0Nkm/+GKJbn/Fus=
X-Received: by 2002:a05:6358:180f:b0:14f:3874:2746 with SMTP id
 u15-20020a056358180f00b0014f38742746mr1844462rwm.23.1696020270696; Fri, 29
 Sep 2023 13:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-pxa-gpio-v3-0-af8d5e5d1f34@skole.hr> <20230929-pxa-gpio-v3-1-af8d5e5d1f34@skole.hr>
In-Reply-To: <20230929-pxa-gpio-v3-1-af8d5e5d1f34@skole.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Sep 2023 22:44:18 +0200
Message-ID: <CACRpkdaSjhVhdRFxqftbEzh-f2Tc9vLz08NwsXTvSDbAaDGdTA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/6] ARM: pxa: Convert Spitz OHCI to GPIO descriptors
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

On Fri, Sep 29, 2023 at 3:15=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:

> Sharp's Spitz board still uses the legacy GPIO interface for controlling
> a GPIO pin related to the USB host controller.
>
> Convert this function to use the new GPIO descriptor interface.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
