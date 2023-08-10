Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD577729B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjHJIPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjHJIPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:15:45 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054F6E56
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:15:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d64f0c2bc95so74699276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691655344; x=1692260144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6igqJ9ZyQ2GF0rdrrnwoxnHECBjtXWYbdW7KwQPNBM=;
        b=MYLNQ0xVjgD4fgI0MMOh8A2iOzW+fpprPZwQMkAajWkyF7G1Ob9iDF+R5lC+8PR5tV
         V0NEYRdx6h6obZEvZKTqdQvtu8g+fxt4HYLevFCPLKJq1y7lcpQk5NqOtUqD6PhWF5qO
         x55NJ6X+0jq0YHAtU9tRzlqrglcm3riO2gvW74LIvPRD0cXMr6c4gIJ/xb2hiEB3N98H
         Zc9nOth9+hCv9mtWdrCwhFVvnDJpt9dduTwuKHgzoahDPEZW9ttpizqoDLq3IXB0oObd
         +oViGT+ZhLBKxMHZzXtYNhBtBQeW51NobM2ru6ZPhPS7BwOIMHZRc1c13D0Bg45wNN1g
         rIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655344; x=1692260144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6igqJ9ZyQ2GF0rdrrnwoxnHECBjtXWYbdW7KwQPNBM=;
        b=Qm/YiL1dqOxfwu4wAnu1g14vYykI8YP0RFBTe05u2pT2jx10TBk/vqklXWslXjiDK8
         m+a4yJbWw8pqsE5bv3j0Bud/31hzduI6JSxO1sgNJfkgbOpIDQoN1XQc5EXbyp/j0IV+
         bCGzvpEWOxQR/p4jj75lJp795c1kER4iFKg3Bj2E/QE08u/ApXe2xXHe69BlwBwgwQ/s
         SfloXNw2oT2edk+VH13fWivQ2p+/IBiGrtTDjfDRb/cH66LnrEpcvPYBaueDrY7DH2nz
         mL+V1f7ld9CLFBOW643WmI0RVJRgs335bhKvCeBAmjbDN5PnJPF+H/pA+ca7tiVkyugH
         WTiw==
X-Gm-Message-State: AOJu0Yw31hurlw3dHhd9bgYp27xn0u4QpANBfjy/MVs2tRkjeBhCJ7AV
        aaRpSDoyhRu3WtY3+OjD980PigjCwKuLO04ZsQFMFA==
X-Google-Smtp-Source: AGHT+IFH+lA0a80GB/MMkSRqolWuqSrTtMHQqr8GGyFLAzUlM4ks9hSFFzsNznnUi6VYH+jmQZ0cZmiPUYkWvtHXI+I=
X-Received: by 2002:a25:76d0:0:b0:cef:e2c4:d366 with SMTP id
 r199-20020a2576d0000000b00cefe2c4d366mr1955723ybc.48.1691655344173; Thu, 10
 Aug 2023 01:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230517181353.381073-1-kursad.oney@broadcom.com>
In-Reply-To: <20230517181353.381073-1-kursad.oney@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:15:33 +0200
Message-ID: <CACRpkdYiOK6853iKpy8bqfGokq5yRBiena8uUYm87L6r0vd6Wg@mail.gmail.com>
Subject: Re: [PATCH] ARM: memset: cast the constant byte to unsigned char
To:     Kursad Oney <kursad.oney@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 8:14=E2=80=AFPM Kursad Oney <kursad.oney@broadcom.c=
om> wrote:

> memset() description in ISO/IEC 9899:1999 (and elsewhere) says:
>
>         The memset function copies the value of c (converted to an
>         unsigned char) into each of the first n characters of the
>         object pointed to by s.
>
> The kernel's arm32 memset does not cast c to unsigned char. This results
> in the following code to produce erroneous output:
>
>         char a[128];
>         memset(a, -128, sizeof(a));
>
> This is because gcc will generally emit the following code before
> it calls memset() :
>
>         mov   r0, r7
>         mvn   r1, #127        ; 0x7f
>         bl    00000000 <memset>
>
> r1 ends up with 0xffffff80 before being used by memset() and the
> 'a' array will have -128 once in every four bytes while the other
> bytes will be set incorrectly to -1 like this (printing the first
> 8 bytes) :
>
>         test_module: -128 -1 -1 -1
>         test_module: -1 -1 -1 -128
>
> The change here is to 'and' r1 with 255 before it is used.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Kursad Oney <kursad.oney@broadcom.com>

Wow you found this old thing!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Can you please put this into Russell's patch tracker?
https://www.arm.linux.org.uk/developer/

Yours,
Linus Walleij
