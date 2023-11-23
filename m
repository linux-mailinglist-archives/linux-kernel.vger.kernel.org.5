Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197B77F5A78
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbjKWItq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Nov 2023 03:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKWIto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:49:44 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E685D12A;
        Thu, 23 Nov 2023 00:49:50 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5b383b4184fso6669127b3.1;
        Thu, 23 Nov 2023 00:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700729389; x=1701334189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hslGwW8weSF/trUGnCGzI7NRZ/1Gm67BIvImSjeFisc=;
        b=jm2cyCkxNa8RFVosetIJ4sRX7QUjVv5i4xqzGrWGI2S/8Q5M9Md11R0lPqNV6I/wZ6
         mz3Hov3DMKREEE5HwfQBcTHMczBNFMOvWqcx11nOtRLcbsmNeHm9VCBZJj5flUVMhBpl
         Qoamnqso3q+pNhezwpYe5ugP6W5LmKD+8mWOjXhQrxNf20PC5EDfcNj4PQ+OAsQlFeC0
         9HqcfrcccLfYIk97Lt5YEZ2hrZ5CtJZLCmzs1ohkMFN3qgu9fV3wc7Cmdq8MFNjPhTp3
         iXB/Th7ynCt9G5jMe6v/ZMzEm7MYnnLLUMWX5uvK08KkxvavU1zT8U9EjlbDX3DBJL9O
         I5zA==
X-Gm-Message-State: AOJu0YyaO7+bU6qbVY0pYe6GT+W7dZa7KoQ2v3r5cqIaG42cweK2ZfiA
        /IEOQ7ao71zZTWnmdpOqfUgWDmYnltUJnA==
X-Google-Smtp-Source: AGHT+IHEgFOTdj3vD34AFdULlM9N21oBAL/SI4LKddnDZRET1ss97usoaQHk+A+2noBQ/byTnTgLUw==
X-Received: by 2002:a0d:fdc5:0:b0:5cb:7fcc:ffe9 with SMTP id n188-20020a0dfdc5000000b005cb7fccffe9mr4403504ywf.51.1700729389561;
        Thu, 23 Nov 2023 00:49:49 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id u78-20020a818451000000b005af5ef0687bsm265708ywf.13.2023.11.23.00.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 00:49:49 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5cc5988f85eso6601557b3.2;
        Thu, 23 Nov 2023 00:49:49 -0800 (PST)
X-Received: by 2002:a0d:dd04:0:b0:5ae:dff7:6159 with SMTP id
 g4-20020a0ddd04000000b005aedff76159mr4958402ywe.18.1700729388887; Thu, 23 Nov
 2023 00:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20231122224409.2808999-1-robh@kernel.org>
In-Reply-To: <20231122224409.2808999-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Nov 2023 09:49:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUsTpjnpmu8axdfxbWRv1DpX5yuJHbCYZ7bwdGESU75fg@mail.gmail.com>
Message-ID: <CAMuHMdUsTpjnpmu8axdfxbWRv1DpX5yuJHbCYZ7bwdGESU75fg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas: drop unneeded quotes
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:44 PM Rob Herring <robh@kernel.org> wrote:
> Drop unneeded quotes over simple string values to fix a soon to be
> enabled yamllint warning:
>
>   [error] string value is redundantly quoted with any quotes (quoted-strings)
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v6.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
