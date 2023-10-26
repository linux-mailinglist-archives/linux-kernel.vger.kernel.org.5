Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076657D83B3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345059AbjJZNhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:37:36 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA2D187
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:37:33 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7c011e113so7307717b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698327452; x=1698932252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOx8ddXc9Yb3bG6JoRDnlwg8757x2FxWfqO5ucclk30=;
        b=zfDXuaaw4RgQfQ+NkWn5wjm9vPsaP0FnmEdSfI7WMVVRG1Iy1F1metRKnZa14w0cwm
         d4c6HqrI/8AmzdMJfFHOwyPDGoJV46Nl0rQJPRhx7/+5uFWJQMQz3/GFBdLMHPWyFLk4
         RknBqe26GyEeNbOqV0SuWd3sRtJcVaFhwFakkEFRX1cjfCWpBLmfKQYhBUYpvCRKhkaC
         UaiRm0SYOxl+HST8RL75wd/uWmlLjvNOACrhoKaBMlZu1bXTWh2dbBe2jCPAQqrS5Soe
         +MYvesVkIcEGEha42zYv8826W7VcRpQS3pEomJ9ZbuxEF6ATlKXKOPGlaksXU/BONiqO
         DiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698327452; x=1698932252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOx8ddXc9Yb3bG6JoRDnlwg8757x2FxWfqO5ucclk30=;
        b=DSBAXxlmFFCw3ajAYljVdNcjk8lOb3W6y1FpoGRXDVKJMOtgiUYqEZ61Hp5tvnQsFR
         j8vLyBcHv/oe/6ZfYbFUApkr5oMA9Rnle51tMaGHmAUgpF5EV4bFx1y98NaPNoad97gk
         JTdLa2/eM6IO3zuloc+3MKavDgRXNIZSvzXoOSPbVikz7nJonP8Qly81n3tt48HUw9rl
         Mzm03yk+jNlUyk/RGftE6WLW/Sw+wuxJH9RZPkZicbrm1LDxDuJSG50N7Xx5xPeB5WCc
         T9AibOe0SFfONeT1UNlVIsskswETuYXN7tluU6a6cpR3ujZlzJI2f1B3J0QgUeJsqOzf
         u0dw==
X-Gm-Message-State: AOJu0YzAW+boelF1kCyHJsEa2n5e0vEvHiCe4vRkyzHn3IJ8F0jRx1FF
        XNWzS4hVQ5iJY7HsLngpIkGBQKuTRFwRoY7jPDTDRw==
X-Google-Smtp-Source: AGHT+IF7yl72QxYny7p60ivvgeD16vtCXalAnDaE7lw9lLxXrLOrIca+EPOAUIhxKK6pLp+OC+111zcBVAAfVBNGvGs=
X-Received: by 2002:a81:a187:0:b0:5a7:ab55:b9af with SMTP id
 y129-20020a81a187000000b005a7ab55b9afmr20163841ywg.35.1698327452521; Thu, 26
 Oct 2023 06:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-2-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-2-9258eea297d3@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Oct 2023 15:37:20 +0200
Message-ID: <CACRpkdaBGRsH3q9xY5-YuvgO4jXSr9x-+wZZ4bPXByZbrHt4Qg@mail.gmail.com>
Subject: Re: [PATCH 2/6] tty: serial: amba: Use BIT() macro for constant declarations
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:41=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> The driver uses bit shifts and hexadecimal expressions to declare
> constants. Replace that with the BIT() macro that clarifies intent.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  include/linux/amba/serial.h | 182 ++++++++++++++++++++++----------------=
------

Since you don't know where this header may be included, you should
add #include <linux/bits.h> at the top of linux/amba/serial.h

With that fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
