Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397377D3516
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjJWLpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjJWLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:45:01 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CC4D7C;
        Mon, 23 Oct 2023 04:44:59 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso3030019276.1;
        Mon, 23 Oct 2023 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698061498; x=1698666298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7b2hdSdEiM4o4XM7ucCEd7vEq2WMd68fJSI4N1cSH8=;
        b=Pd1Ypr+6gYzF6Z/msQE/BLb3nB58yJ2Ni/YoIznV5qgD2MY2JPhVYzRbFDf0x+YgU3
         aBwGt9MnqSsHFEkjYKAQHCR7NlMFPyis6DAnuia3IVCnBuIzfHef+Yz0ehM25rW2jG6W
         wnvU5Qrx1pGTkL3cYI7VM61pVPJr4lXzmsoJtE7NQjn/1cATtDvqJp2l32IZGlcE84dX
         yaqyxZPRtQuxzvIPXJaK3IuYvjjHw8JDPXMfFoMY8cbQc1/FQ/mTts353qcQDIuwugqB
         tumLns7vt4HwbR5xhGHEG3dEogRXOeZR0h3HC+d7VzNOymiqhfjP9OJ0YbvilaSWeC9s
         3srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061498; x=1698666298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7b2hdSdEiM4o4XM7ucCEd7vEq2WMd68fJSI4N1cSH8=;
        b=wHnpaIs9XRBKBP/HYEuFn3FKiCT9TmCvBQPKURNCy055kYW8iO29ntppglUNR/L8NT
         qY9htuhNvY4Hjvir57bsDpsmrkZG3edHEOmRNhldp0owaES+B0KBcQHyHG3H71vKpRy8
         79Bgy7kZI4lcyzX/CrOLpPr4fpvY/3Z/HvQQLXqaiCYwbcqleqtlEafzN0j5+izSUTJ1
         jAVhQL8hr4GfpSZau6BazfiyF4OwTQ7GvvdO9sE+BuPDfSRGqTPnAXIWJQ0myO8+otVb
         CmjqH6NR/ikI/v4yjl07GoJed39bLl2cUzEmS1rInHGKwA30Dx0g+gw3jyyFMZwXrApd
         AW5Q==
X-Gm-Message-State: AOJu0YwPx0ADfPI+ZSmDz+rg8mL5837+AtARVzzK/sDWZYUMwPrYa/56
        sEa+0I59uj1LfGUFAVkpJKvjXQ+K7p4RuwYd/PgUXKqmiCo=
X-Google-Smtp-Source: AGHT+IEl1Dvvreu0PH8ctorZ6vOxpcr1R02nRfhTfWYX9itZ1OXyNVSNZR6ZVjHTnprtQGvXOyRPq6Kuilsh3emHPDI=
X-Received: by 2002:a25:428e:0:b0:d90:c424:53ee with SMTP id
 p136-20020a25428e000000b00d90c42453eemr9341179yba.9.1698061498418; Mon, 23
 Oct 2023 04:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz> <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz> <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
 <ZSk16iTBmZ2fLHZ0@duo.ucw.cz> <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <ZSmg4tqXiYiX18K/@duo.ucw.cz> <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com>
In-Reply-To: <87sf61bm8t.fsf@intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 23 Oct 2023 13:44:46 +0200
Message-ID: <CANiq72kvZcNp2ocXoqBae9q2UW+RPQy3dXUr+QS-izKpM1yyoA@mail.gmail.com>
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org,
        Werner Sembach <wse@tuxedocomputers.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        linux-input@vger.kernel.org, ojeda@kernel.org,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 1:40=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> One could also reasonably make the argument that controlling the
> individual keyboard key backlights should be part of the input
> subsystem. It's not a display per se. (Unless you actually have small
> displays on the keycaps, and I think that's a thing too.)
>
> There's force feedback, there could be light feedback? There's also
> drivers/input/input-leds.c for the keycaps that have leds, like caps
> lock, num lock, etc.
>
> Anyway, just throwing ideas around, no strong opinions, really.

Yeah, sounds quite reasonable too, in fact it may make more sense
there given the LEDs are associated per-key rather than being an
uniform matrix in a rectangle if I understand correctly. If the input
subsystem wants to take it, that would be great.

Cheers,
Miguel
