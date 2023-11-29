Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC407FD8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjK2N6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjK2N6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:58:16 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9890BCA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:58:22 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5cc86fcea4fso57358517b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701266302; x=1701871102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfTfdXTp+yMT3mYQewRUIosVebrHQ8SQKCMMMwY3nr0=;
        b=z3M0hUNQgYZr38qfMjlSGmP74m/oqc6tZo4qCv3RdIpA7xLojpWxhx3/6tfsLpfNCQ
         7ijR6WjbH4+Ic3PDEs7xZMZf32G3xx7qypJ89O0vCd6YU9ORk2KMU3czjtMyz7F1AKDo
         9JZ0cdUm4D5nVGkq96XbTuO+/7FlwMHWVk2nSi1XEwMMa/a7f4HNCYcc9sZrfeewmIEX
         wSBMvV5eU026ypkfrarOsc6fcBUrULdAxUbkeP13QtGrYDeBPfTnAHZz5lDo3sxnbPBc
         VIWx8tOS6s9yLlHydw1ZP0inxIvE2c/GpOU65rLHlwZto5mAzrnhpY/O3Iu/oy1Rm7/n
         z34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266302; x=1701871102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfTfdXTp+yMT3mYQewRUIosVebrHQ8SQKCMMMwY3nr0=;
        b=G/TRLATQB4IQrff7bjmBPxHsR2dbFT8r/s8Pzv3gzyKCk3Ds22AMW5nM3F6g9ZWsN8
         HQAQ9nICCbC2vGPHm9+df0W27cz1O96TZl+NFtDrDCkli9BblG+1McmXkfAS5Vsrge8u
         HpY9l5DBuCqr/y1mZHM2lmQTCsmAvnf35c/PzcRLex01bbrO2GcbnphiQ+g7wwP/GJm6
         BPatDwOqccMs7JUj2qHYp5nDKl37zzN6mzn0Gfd0GaDQWpsK27HLzD5qNVn6vhooyUC0
         1BsLS/QccKdQ5bMBXLCL8j0M8tkSBkVvmwSR3ExirtYZrHdkQz9VhexMj+SqsIdX2c2y
         esog==
X-Gm-Message-State: AOJu0YxZa0zsh1TIMZGHWy2YVFVibfh561ei/N+tUYxHAPI0cDqzNDhh
        fVkpxkJOGki5nfSdIDYjobbJTDHwNUqSrTzacTjGWg==
X-Google-Smtp-Source: AGHT+IFqBkmwBygBxeMcHv/3k1pv0m4VZo9blFPEezAV0VZ+2zim93NLiXeFfcpmm+csnkY43vaUxmkF4uPcEnMuV3A=
X-Received: by 2002:a81:4322:0:b0:5d1:d1de:e8eb with SMTP id
 q34-20020a814322000000b005d1d1dee8ebmr4699621ywa.18.1701266301817; Wed, 29
 Nov 2023 05:58:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701264413.git.namcao@linutronix.de> <4a0aa2f626f5f6e5509f9d0d64345fc8fe3b34d9.1701264413.git.namcao@linutronix.de>
In-Reply-To: <4a0aa2f626f5f6e5509f9d0d64345fc8fe3b34d9.1701264413.git.namcao@linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Nov 2023 14:58:10 +0100
Message-ID: <CACRpkdZmgiON1Sz3e0LobeyDCpiyX-TGswC4xQ62sWQcEi2bjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spl022: switch to use default spi_transfer_one_message()
To:     Nam Cao <namcao@linutronix.de>
Cc:     broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Nov 29, 2023 at 2:32=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:

> Except for polling mode, this driver's transfer_one_message() makes use
> of interrupt handler and tasklet. This is problematic because
> spi_transfer_delay_exec(), who may sleep, is called in interrupt handler
> and tasklet. This causes the following warning:
> BUG: sleeping function called from invalid context at drivers/spi/spi.c:1=
428
>
> Switch to use the default spi_transfer_one_message() instead, which
> calls spi_transfer_delay_exec() appropriately.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Tested with polling mode and interrupt mode, NOT with DMA mode.
> Support with testing very appreciated!

Oh this is great!

Because I think Mark started nagging me something like 10 years
ago to fix this in this driver...

I have a device using DMA mode, I will dig it out and make sure to
get this tested ASAP, in the meantime:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
