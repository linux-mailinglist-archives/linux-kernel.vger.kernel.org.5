Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48877FF2D5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346054AbjK3Osf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjK3Ose (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:48:34 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC3B5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:48:40 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db53f8cf4afso490249276.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701355720; x=1701960520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0muDf491lrhXINQT2ZKN2LliQpFV7k/GNMdeGRlPdsU=;
        b=hQgGi9gqKRUwpt7+fo/Oe52nORnTqj9YwHKoOBhgCpMHdBbzFyb+TFfNxQJxMWbk3q
         E8hhNZVLIOtjsmMOfD+emJDs/ZcTe5y5oY63h3NnmVfb7ubc6ytnhb+tFGTA4jWtVZSY
         Wt9E8LMTxRpXI7uAoqdqCWM5d/3TtE0/7BKm+M3tA5xlRK5JMeo2bdBMRH/Qq3Ffoqqr
         jUlMcj2+6QQvONQwUBZlTHCV7aEQtNw6qELBsBngOZGoP5dSZ95Pm97zuW1E8QB8b5mC
         KyrlmhI8RBinEuNtzze4NkfQ2wk4Z1JCzmfQsXsEAvOmw//t651UgPvlbkIb0RAUCTu+
         EELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701355720; x=1701960520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0muDf491lrhXINQT2ZKN2LliQpFV7k/GNMdeGRlPdsU=;
        b=WJz0Ykrz2C00DdXHnJW19JuhwJ7GHauETMtTQjS8lHDwJ7wPXjXO8jcfQisTt57zzd
         Z/gpJ2NKW/e33OGu10c4SADwV1/3L4HuM8KlV3KxTJR50A8EuZu8W9RXERA0S0xb8mzX
         MwWbx1+ZMVbX5IyU9HnGtjKczk3L6WwU/2EFGhkGXcdnyfJNtVsgOolFTsIkAY/YnVMx
         F4a+Vt46KWfq9XHtxbc2R/KAyn3ID0yfF0S6GB+R255sTLmqbFyZ5pjN8YoP3o2yt4Wq
         6OHPAkgF9ka7+x9a2iwO3Vr7iVQ0ITqYdG6q9MQEfFop694bgLvdv52z7MO9IV9/vS7H
         YXaA==
X-Gm-Message-State: AOJu0YxUZQWglBCcS0Ta2nAMRk72PS1JWS3B2b4Ej+pp+Bsws3VrwEwk
        Hgem2dsJLwAVJL7QtIGO5bDjRhgRXHSqHMPCZRIKyA==
X-Google-Smtp-Source: AGHT+IFQS/1VjIkLOiYKm/oAogp0MILiq6YREH4hlSuAzTjzqwlbZ7sNF+IDm7meh5114BnsZPd04XpGqh9ajh9NxHA=
X-Received: by 2002:a25:8e0a:0:b0:da0:5ba2:6275 with SMTP id
 p10-20020a258e0a000000b00da05ba26275mr20783935ybl.34.1701355719730; Thu, 30
 Nov 2023 06:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20231130105459.3208986-1-lee@kernel.org> <20231130105459.3208986-4-lee@kernel.org>
In-Reply-To: <20231130105459.3208986-4-lee@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Nov 2023 15:48:27 +0100
Message-ID: <CACRpkdbvncOsbG2W3vJJz8N4mH8XCqyf_Ny1_hsLwK4P+7x1Cw@mail.gmail.com>
Subject: Re: [PATCH 3/5] usb: fotg210-hcd: Replace snprintf() with the safer
 scnprintf() variant
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuan-Hsin Chen <yhchen@faraday-tech.com>,
        Feng-Hsin Chiang <john453@faraday-tech.com>,
        Po-Yu Chuang <ratbert.chuang@gmail.com>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:55=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:

> There is a general misunderstanding amongst engineers that {v}snprintf()
> returns the length of the data *actually* encoded into the destination
> array.  However, as per the C99 standard {v}snprintf() really returns
> the length of the data that *would have been* written if there were
> enough space for it.  This misunderstanding has led to buffer-overruns
> in the past.  It's generally considered safer to use the {v}scnprintf()
> variants in their place (or even sprintf() in simple cases).  So let's
> do that.
>
> The uses in this file both seem to assume that data *has been* written!
>
> Link: https://lwn.net/Articles/69419/
> Link: https://github.com/KSPP/linux/issues/105
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Yuan-Hsin Chen <yhchen@faraday-tech.com>
> Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Po-Yu Chuang <ratbert.chuang@gmail.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for doing this Lee!

And as David points out it is even a bug fix at the same time.

Yours,
Linus Walleij
