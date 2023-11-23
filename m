Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61687F621B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbjKWOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345950AbjKWOy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:54:29 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D78DD66
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:54:35 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5ac376d311aso9387397b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700751274; x=1701356074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRvtJNZozpO0bnie9sd9zh5ke0kldmBEFtw2MsgOEU0=;
        b=mkG7RxcOGHGD1Svy91l5iyaLhXFAtN0FPpQsflgm9H9pNivjRKUD6t7kC/qFFZxFE/
         T26YFg+qz61P2r22INtnRmrHKKIfkp1oKTh/wpjLBcQbACFFbR8jVw1sZLl2Y46Qilbw
         vgpW5XfjrtOwEvz0ewhfrQ/U60tN3odC4iT5LE3diyR8U7Da8Q/6CJYAs7R6DGHzavEB
         rYpQzh/E1Fy5aj0KU5AkdSGlw57fI7fhkZiE4zzV7vTwBD6ZmOPlk9lg0OIqlNb2hHAD
         Su0tp3aWjIGg6ep0FGAtwSp8/ZQ3lrrFg3iN0ICtFZgwnio9J5Op+H0x8x7hHsH97z9j
         xU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700751274; x=1701356074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRvtJNZozpO0bnie9sd9zh5ke0kldmBEFtw2MsgOEU0=;
        b=e6uFUG4A11bZyEQFkdrIPZOb7hF58+eMWnmjSTRBYGVYIhdZSGO4RNreBarfM+Ek2C
         82x0tqA4ipr5i7LA+Z2ywyB4k9GjK676CTq9JwGIvQRFCfjPJ/YeVtdQErJKmzpRw5ck
         cHL8OwJMiKlPf2Gqff4R8C4xCcZTPa1gSj1w/T3ccL+AW/yk0nt3sH7bkgxNyDsvaiI8
         uXbjqtspHH8+PSu5kiJeWXtYWlFzsNmPqSre/4RzWnuC2ul4NGrv7VQ6GtQwF2SLw62r
         8819AZZvhpeaIc86Tu/d7OjzmM6XAEwxnLG4vlipBPcJ2sXifH8Li4XyTJXgPsalN54E
         yrXg==
X-Gm-Message-State: AOJu0Yw6d6c/cjLURH1mvA9yA5qisGgkRlk3aAjoz4GfLpsvBb+DJZVS
        xPG4De1yP2UJ0+RZ/6fXiE/aXuWxlYY5WyqCEU6z7MuwqsRMBtJGeJs=
X-Google-Smtp-Source: AGHT+IEqHGUy8srm+W2fOIN/DF+rCJy6HEwoShEzTGFqCsOxU8MZDzOqoPECz3axzRKlSd8vE4exbeUo5+mR58vqu+s=
X-Received: by 2002:a81:6c04:0:b0:5ad:a3f9:1b10 with SMTP id
 h4-20020a816c04000000b005ada3f91b10mr5685572ywc.10.1700751274772; Thu, 23 Nov
 2023 06:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20231122175039.2289945-1-andriy.shevchenko@linux.intel.com> <20231122175039.2289945-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231122175039.2289945-4-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Nov 2023 15:54:23 +0100
Message-ID: <CACRpkdZo3W6ServvKQV5KpBuOqXYPE=OCVoLvC1kA585H=vMDA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] pinctrl: baytrail: Simplify code with cleanup helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 6:51=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
