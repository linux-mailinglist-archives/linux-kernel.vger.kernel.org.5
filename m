Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA63F7D83CF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjJZNqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZNqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:46:33 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C667187
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:46:30 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ea05b3f228so519095fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698327989; x=1698932789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdyVVw0aBVMHPJpP77t0JsBJNKlhvsWo73t+NTi0GM8=;
        b=zSCLn1Xx3oirlDQLkV2dktoqiTTgCLUIjAUgiWgiQx36E6M67EdgwqaKpP7woCRjAh
         +piQKOs89247vNn960XRCU5hNc96TSfqzJXAh2HkU2cLdypASINfZPVqq+7xL/6a3nsb
         47mpF+gK2kGXVktz/gS6kOopKcwn1L7iDPlU8lERtUF0z6evcATShynlw6K2NTmjnqb6
         J3jugKPopMNl5oAO5vlNmrO4w/ZgTl1vaBWL6wNDtuyQE9yz7/0FfN1JEQUjj3KfOeK8
         gTdNXefDkH76n5ax50NUM2jEDb+UcA61ogFp1p0VxMRRzbjvFVKEKsuOW4Nt0vXqcez1
         ZUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698327989; x=1698932789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdyVVw0aBVMHPJpP77t0JsBJNKlhvsWo73t+NTi0GM8=;
        b=wT9Hx75fQ5ulQrlTbGZLYnqQWZMFKejqyFpu0kuDsbYHjTh1U6Bdn59m15e19wZlq3
         TNaL1oLUCkLT7l5Ar0iC1l4hBtqoK+jVEO6ySujz88wajEUjCMVeyFl12LeBQhDrMfmW
         Es/+S5sbovpy6cebqRFKRh27yBvPUaTsqhdBAxqkwmRBeqKr1H0TEyp31Ny8A9WzQN42
         r2LVrhpBxFrmQtLf2+10IaCF2VuuYjSRlcJp0dNYiS9/NYrI9pLhPgusSHq9x0L4g7t2
         9I85qiWj1ncyxxQP8l43JFGY9rC947S0i8Zgxgf/cFhXAyhlqQiooscP2ssE/J/iNGJe
         8OBw==
X-Gm-Message-State: AOJu0YyXWcG7NJD9AvRZIjeLC8HCxV4v23PCXog6zC7Uv09A3CucQE2D
        zzEQ0TUFMh8MAuNN1Tx9XKTc6ykOhj1lJHVUDSSqPA==
X-Google-Smtp-Source: AGHT+IG7t8B3P3kKeLg6CoQvDuqK9LBfIdNsKeqT9G9yoMJXpb7eWsJTzdRDKDCS3Xpwgm9anaN/0YyEZAjEQDYjsrk=
X-Received: by 2002:a05:6870:7a1b:b0:1e9:f0be:cbbe with SMTP id
 hf27-20020a0568707a1b00b001e9f0becbbemr24209376oab.9.1698327989467; Thu, 26
 Oct 2023 06:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-4-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-4-9258eea297d3@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Oct 2023 15:46:18 +0200
Message-ID: <CACRpkdZRW6Evzr+CWuhpz6hinfAnwXaEp4GG=9+zY6yJy14xmw@mail.gmail.com>
Subject: Re: [PATCH 4/6] tty: serial: amba-pl011: replace TIOCMBIT macros by
 static functions
To:     =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:41=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> The driver uses two TIOCMBIT macros inside pl011_{get,set}_mctrl to
> simplify the logic. Those look scary to checkpatch because they contain
> ifs without do-while loops.
>
> Avoid the macros by creating small equivalent static functions; that
> lets the compiler do its type checking & avoids checkpatch errors.
>
> For the second instance __assign_bit is not usable because it deals with
> unsigned long pointers whereas we have an unsigned int in
> pl011_set_mctrl.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

The kernel looks better after this patch than before, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Since the eternal defines uses masks rather than bits we can't
use __set_bit() & friends in this case and that's life.

Yours,
Linus Walleij
