Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0697CA628
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjJPK57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjJPK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:57:53 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA01B4;
        Mon, 16 Oct 2023 03:57:48 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7ab31fb8bso51807187b3.1;
        Mon, 16 Oct 2023 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697453868; x=1698058668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLo6lm8DCOrQa7cpbQxRmZ4AW2SzeQU7OJCzMZY1x2g=;
        b=aDSw4pIKJC98rWNixSFAUkUY4AhA5ORPJMY3vs/jWbxM8ysxoDT/y73tkxLCB8hvGW
         Q9yMMUFqvL6ADygXXnhWUQiVlQgfFLgWF1CMrMdH6svoin6ME+OqPA5dmr5aTK80ceBa
         QGk9365gojojInRY4k7V2G87iOz82CDhb6WNKPyvylvJRaVG4Kdr4PP15VE6jj/rhxb2
         +80/g3jsaK3S4HDB1N/dqdn/RIs7M5nz9873oymhW2QMPIppR9uoiIeT80TJiLtxjol9
         BvzTj98+YBZJko9PFeLoE4JnMK1hGnshVP0mbuuwoKLDBgTbhbpYiKQfB7HCiRRf7oPM
         n6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697453868; x=1698058668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLo6lm8DCOrQa7cpbQxRmZ4AW2SzeQU7OJCzMZY1x2g=;
        b=srSYM9E/JDmpBhyUZhWSGbfFHxup/TLdS7ioZW1ymqlhK0GhE7PJLPmuZtYh0UyBWy
         PKqBOYDhrkp5tWAAkk74vYEAKhqY/T20JT5du2Rx0DqJaMNQNT86Acuuc/VdrQpMBb2F
         7grR8TijQn4TlSwIoQkElgaJlB+tqyxdhYx8TBIqfaGqDy7/NxiH5H9n9e7MErY6ozH0
         gVtHia65X5v38WfFPXZ7Hhsf68BVF6RB0hQmPoxGvxSKrIT8bQCi0oVo+V34DsvBkUmk
         Xhg280IRdggcwbIE9qh/+mE1eD5Z3q0HX9VNV+NWfASJcN4s/P0nYCFHMWXrwTEpNWAq
         jW3A==
X-Gm-Message-State: AOJu0YwHAoNpDF5HRZigi/7xL2FLNVDc+y7zpRKtj/Z4pJmKFSGn8Dbk
        Bk4IZLdQgRngo2PZ5/ifSY4scQGOZ277TAXiCf4=
X-Google-Smtp-Source: AGHT+IHc7UWoEBo9CKelVYa69UU9KXXFr9P5dhwxdsEhcMwW8dLuDYlvP5XHBxrpFdYeirrlCzCr7lCvaT/m0X/J7YM=
X-Received: by 2002:a81:8441:0:b0:5a7:c8fa:c620 with SMTP id
 u62-20020a818441000000b005a7c8fac620mr18397132ywf.0.1697453868093; Mon, 16
 Oct 2023 03:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz> <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz> <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
 <ZSk16iTBmZ2fLHZ0@duo.ucw.cz> <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <ZSmg4tqXiYiX18K/@duo.ucw.cz>
In-Reply-To: <ZSmg4tqXiYiX18K/@duo.ucw.cz>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 Oct 2023 12:57:36 +0200
Message-ID: <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Werner Sembach <wse@tuxedocomputers.com>, ojeda@kernel.org,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-input@vger.kernel.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 9:56=E2=80=AFPM Pavel Machek <pavel@ucw.cz> wrote:
>
> So... a bit of rationale. The keyboard does not really fit into the
> LED subsystem; LEDs are expected to be independent ("hdd led") and not
> a matrix of them.

Makes sense.

> We do see various strange displays these days -- they commonly have
> rounded corners and holes in them. I'm not sure how that's currently
> supported, but I believe it is reasonable to view keyboard as a
> display with slightly weird placing of pixels.
>
> Plus, I'd really like to play tetris on one of those :-).
>
> So, would presenting them as auxdisplay be acceptable? Or are there
> better options?

It sounds like a fair use case -- auxdisplay are typically simple
character-based or small graphical displays, e.g. 128x64, that may not
be a "main" / usual screen as typically understood, but the concept is
a bit fuzzy and we are a bit of a catch-all.

And "keyboard backlight display with a pixel/color per-key" does not
sound like a "main" screen, and having some cute effects displayed
there are the kind of thing that one could do in the usual small
graphical ones too. :)

But if somebody prefers to create new categories (or subcategories
within auxdisplay) to hold these, that could be nice too (in the
latter case, I would perhaps suggest reorganizing all of the existing
ones while at it).

Cheers,
Miguel
