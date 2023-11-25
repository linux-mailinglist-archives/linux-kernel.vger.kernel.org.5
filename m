Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248677F903F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 00:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjKYXFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 18:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYXFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 18:05:15 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC77512D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 15:05:20 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-db40b699d2bso2636281276.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 15:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700953519; x=1701558319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5t0Y/VnICe+ERJNkW/1rkcBwpPmZhdYUYmi9BmnfaA=;
        b=JnaPy2260sNyY9Wf8olvqHLbnZ2VisJzyzxJIRG8BJmCpXLo6XQPn/uzXqDTG7Bmsu
         D7a/FoZqMqbc0qHOzXf7Hn4Vx+V/Xdnsq0eZbvXj1Mt++HQXv74Qx0yIpRcaIMlKioXm
         awCkYjjEWgzBfRol3+sLlUfslNS4xDI4qVqsH31PpDnoi/BbUSKi4h88NXUXkenyFEoK
         we0n8+KSB35JonWnbfAA0sTus4PcpqRZhOs9+PtMUCrlaTYc3T6UIDSjf3xS2AAHYSg6
         rFDRhTFWAeihGvJDMp8TVIXw3c495ayNc9lw/gIf0GKrHoj8216XR+gSS7wrtsMumVdM
         YOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700953519; x=1701558319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5t0Y/VnICe+ERJNkW/1rkcBwpPmZhdYUYmi9BmnfaA=;
        b=b9gDA+0qi+ennkqoweEMTyvJPUWGpk/aaq00YLCHp4RxUIjADkPihOtTRpI86rCXfE
         Z92Xlui9iNqVPix+YLvIVMMfOQR0fdhHBqQ5haapGVTqQbSWK3MytQ/+NXvDNXcMBD8t
         O6bho6ZYrbHDHf7ytvehT7qRbafC4w5yIDSe6iTLv50rhyswBFpDG83ABNESkrpzW/+z
         qSwbo8So9QXF042ATbiwbhtwLS2jXe4UWjTWEzmc4WJyBWF5cAMvkHPMzWrF5NVrP8Zx
         p4txybHkCnKROw/25AKHgBO+k+4zUj/PucIi3Y2K87ZowSwibvKrE2PnYVUroyxe/rC3
         frpA==
X-Gm-Message-State: AOJu0Yxnl5ZnY/2aZgxQxN9vUBV7sBtJHcdVdQZXENrAVpR+G3dM5sgy
        es8LkBApiNa1FMbjPltd3Fe+GQM4Vzp7YQ8zUJK6FA==
X-Google-Smtp-Source: AGHT+IHQdFfZH4UJ8HNqgw4c532iHTxW1BWuqc5WPvk5v0u68UcrrD7/uoRsgyVS6Pwx5ZL6hxlrDv/Mr4uKiQUO7+E=
X-Received: by 2002:a81:a195:0:b0:5ca:e0b1:45d5 with SMTP id
 y143-20020a81a195000000b005cae0b145d5mr2342082ywg.23.1700953519713; Sat, 25
 Nov 2023 15:05:19 -0800 (PST)
MIME-Version: 1.0
References: <20231125-dropcomment-v1-1-15800415aae0@linaro.org> <ZWFepm7ufLdl115j@rigel>
In-Reply-To: <ZWFepm7ufLdl115j@rigel>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Nov 2023 00:05:08 +0100
Message-ID: <CACRpkdZvwePEaRVQLafD8KmiOENgEGFFDBXGPqS5_WLzNi2_yA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Drop cargo-culted comment
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, Nov 25, 2023 at 3:40=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
> On Sat, Nov 25, 2023 at 12:25:47AM +0100, Linus Walleij wrote:

> > -/* gpio_lock prevents conflicts during gpio_desc[] table updates.
> > - * While any GPIO is requested, its gpio_chip is not removable;
> > - * each GPIO's "requested" flag serves as a lock and refcount.
> > - */
>
> Perhaps provide a comment as to what the gpio_lock DOES cover?

Normally yes, but Bartosz just said he is going to replace this spinlock
with a mutex so it's better if he adds it then.

Yours,
Linus Walleij
