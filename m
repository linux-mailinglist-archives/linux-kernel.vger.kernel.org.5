Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91B67DE21C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbjKAOMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjKAOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:11:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068CB10F;
        Wed,  1 Nov 2023 07:11:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so11273611a12.2;
        Wed, 01 Nov 2023 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698847912; x=1699452712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QUmuCahrXz9QtT0sHWIYLvC83NtAQFvVCj6txbIwhU=;
        b=TPold3FhKjOjJzbQDDsZlfk0agnA3e3TlYIWTPkXvkvJ1/3NOxWienkU1WiuSNE4+B
         8fcqAzxh9cYwZItUFCXdxJpQ/0H+hN7Oi5ZyvCd52t3dbL72vLbGsE7QQlJZS8d+u2Bk
         rlRK96HQ7xX3qMB0vfeMRb+wymNTIIMaC9VoMW0VfUPXQp1hc8K07Y1cq2oI6UyW5mzF
         /MKe8J8zH/w2gUTtnm6cD3VevXqlzghXgS2b8e/WnHaIO8aOez/R7Lx3yOYuv6RH2KVU
         Kojb+JWr2E8L7Sa14YdcnV9ONRd3tZqBv9Q+cRFznnf598ENEUlg6sM8dujBoepCSzY6
         jvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698847912; x=1699452712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QUmuCahrXz9QtT0sHWIYLvC83NtAQFvVCj6txbIwhU=;
        b=Chy/bKIJdrltqIRVOQcW0Lz1zzw9CczA893Fn4dQmXmY/1Gt5Ar3VQfjZdjTAYO9CG
         D8gXruoLo8vbb65OXUWmcr0HKD8WPgmcriQKvdEUzuRpu0IvYe+RxrdAwrI99TLUXXHu
         aa03ashmo+QQM+hfqIysSm6xfmH7vd/CC/k72W6pPuYDo67jjIpp5VJv4FChLmARN13t
         BRL9jjz7FDnEN/aF4LKj5jk3mtvwAVtqxRE7R0+IP3eiBjND8BFU7AakUK3cLeFXTCe9
         ZSQ0HADD7weeSnLBrzZapKCs2pB0degcOOV9YAPscLddyvTVGcHOjP984Ih5pS+MLw4r
         yAyw==
X-Gm-Message-State: AOJu0YxCF/WlN2YtjwFs1qpy6ComZ6JFiFcGhsWGbo3pYL14AEQpXEYF
        f3RA4bAA4p6+FP+9FyQLYU8EuJkR4jc2C5GQGvvXu8DzRv0=
X-Google-Smtp-Source: AGHT+IG9PRuUvcdRBBnWW3qxr8Ys0iAvPjdLcRlrUpbF+IxwgqCut0kbYS3npzf8/lQAVte32nN+3+Y8Wp9IzbMhb9w=
X-Received: by 2002:a50:d094:0:b0:540:302c:71d7 with SMTP id
 v20-20020a50d094000000b00540302c71d7mr14222544edd.26.1698847911707; Wed, 01
 Nov 2023 07:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231011193444.81254-1-jandryuk@gmail.com>
In-Reply-To: <20231011193444.81254-1-jandryuk@gmail.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Wed, 1 Nov 2023 10:11:39 -0400
Message-ID: <CAKf6xpuJe6Cza6bow3QxDGf1viu0kish7Y8YRN8haXL1oEF3HA@mail.gmail.com>
Subject: Re: [PATCH v3] Input: xen-kbdfront - drop keys to shrink modalias
To:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>, stable@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Do you have any feedback or can you pick this up?

Thanks,
Jason

On Wed, Oct 11, 2023 at 3:34=E2=80=AFPM Jason Andryuk <jandryuk@gmail.com> =
wrote:
>
> xen kbdfront registers itself as being able to deliver *any* key since
> it doesn't know what keys the backend may produce.
>
> Unfortunately, the generated modalias gets too large and uevent creation
> fails with -ENOMEM.
>
> This can lead to gdm not using the keyboard since there is no seat
> associated [1] and the debian installer crashing [2].
>
> Trim the ranges of key capabilities by removing some BTN_* ranges.
> While doing this, some neighboring undefined ranges are removed to trim
> it further.
>
> An upper limit of KEY_KBD_LCD_MENU5 is still too large.  Use an upper
> limit of KEY_BRIGHTNESS_MENU.
>
> This removes:
> BTN_DPAD_UP(0x220)..BTN_DPAD_RIGHT(0x223)
> Empty space 0x224..0x229
>
> Empty space 0x28a..0x28f
> KEY_MACRO1(0x290)..KEY_MACRO30(0x2ad)
> KEY_MACRO_RECORD_START          0x2b0
> KEY_MACRO_RECORD_STOP           0x2b1
> KEY_MACRO_PRESET_CYCLE          0x2b2
> KEY_MACRO_PRESET1(0x2b3)..KEY_MACRO_PRESET3(0xb5)
> Empty space 0x2b6..0x2b7
> KEY_KBD_LCD_MENU1(0x2b8)..KEY_KBD_LCD_MENU5(0x2bc)
> Empty space 0x2bd..0x2bf
> BTN_TRIGGER_HAPPY(0x2c0)..BTN_TRIGGER_HAPPY40(0x2e7)
> Empty space 0x2e8..0x2ff
>
> The modalias shrinks from 2082 to 1550 bytes.
>
> A chunk of keys need to be removed to allow the keyboard to be used.
> This may break some functionality, but the hope is these macro keys are
> uncommon and don't affect any users.
>
> [1] https://github.com/systemd/systemd/issues/22944
> [2] https://lore.kernel.org/xen-devel/87o8dw52jc.fsf@vps.thesusis.net/T/
>
> Cc: Phillip Susi <phill@thesusis.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> v3:
> Add Mattijs R-b
> Put /* and */ on separate lines
> ---
>  drivers/input/misc/xen-kbdfront.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-k=
bdfront.c
> index 67f1c7364c95..d59ba8f9852e 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -256,7 +256,16 @@ static int xenkbd_probe(struct xenbus_device *dev,
>                 __set_bit(EV_KEY, kbd->evbit);
>                 for (i =3D KEY_ESC; i < KEY_UNKNOWN; i++)
>                         __set_bit(i, kbd->keybit);
> -               for (i =3D KEY_OK; i < KEY_MAX; i++)
> +               /*
> +                * In theory we want to go KEY_OK..KEY_MAX, but that grow=
s the
> +                * modalias line too long.  There is a gap of buttons fro=
m
> +                * BTN_DPAD_UP..BTN_DPAD_RIGHT and KEY_ALS_TOGGLE is the =
next
> +                * defined. Then continue up to KEY_BRIGHTNESS_MENU as an=
 upper
> +                * limit.
> +                */
> +               for (i =3D KEY_OK; i < BTN_DPAD_UP; i++)
> +                       __set_bit(i, kbd->keybit);
> +               for (i =3D KEY_ALS_TOGGLE; i <=3D KEY_BRIGHTNESS_MENU; i+=
+)
>                         __set_bit(i, kbd->keybit);
>
>                 ret =3D input_register_device(kbd);
> --
> 2.41.0
>
