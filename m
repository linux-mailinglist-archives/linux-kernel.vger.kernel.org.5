Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530238089F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjLGOK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjLGOKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:10:55 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB7F10E9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:11:01 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d77a1163faso5908897b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701958261; x=1702563061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4c23Qqi3a2Hf5J7gfxXHXb1GanE4tjJ0ZroI12SpwMs=;
        b=NXQ5OSNOnqA77nlisp9QyvczrnhUlBDnnrCuklXZdo1xqSlkZg4KCMWQfVzcJWgTVu
         jasb1iQBzcgsDbpcEzrwBlJ/El9QpO43rFhXWBZC5lmRN1oLeWIB9nvx6IqlhmbLRMCO
         Y9ziWMTOHCTgUATkd2S8t3PTIs3AU13RT4dPHALnXIJKx5DqY8QuojSN7ZiuzzpJ7C15
         9lEhnqgTXxh7hmOzvTkfbsM0yoUce7SgDjZIUXaxeuMXMH8KUk3oMI9gXFjeUbqbSbbO
         IUA6jkxFZ+7qWoAzgCnM5vnnYfN1PSbiI2ba3KHshTv2aGHWyo465ARgHISze2V/+9dj
         J7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958261; x=1702563061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4c23Qqi3a2Hf5J7gfxXHXb1GanE4tjJ0ZroI12SpwMs=;
        b=V8+el4G/M86frsN2ghMNVviZvTf2I/J/1g9uWbUO7EwZ/5QN9Nw4ESBPCZL5AP4yDa
         w8AoOSPWkYT7iC1shfUpXxsB3pMuGM3C7FhiUQKDvj0qNOV33CKHCGGlKyAQHWG7rDXD
         THwBlqVMqYn8ShA42dGtRB5/q602dKb9yzNQqIviQ8hv1X2aMOyRCx+smI0WWy5t/q78
         O5uUzPo1blrXLxSiyUy3BEfdAy2cW0IiqnG2zkN7JYnw1hTDNUTDluQq/HAStkIWN2ct
         mwxE83EjUXlRBEwMt1IYGpP8IynSOYH+kK7IvThjt16eryWM4fphPIlFxEPIl5OIU/WS
         Q6Mw==
X-Gm-Message-State: AOJu0YynKslorS5M5Y9/qvi/Edsa7fJnZG4YErLrz5dGjUk01ogZHryp
        lA46ZWv7x53nIe0CA/KO0l9YNwhLHC9xLqEk8/y9B4ruHahx3y5JUOY=
X-Google-Smtp-Source: AGHT+IHfZOsvWx7k5rwa8TLVbgwGAOeipHp5OxEj3mr89LZ/jCXwE4d7P8+lZhGKK91ejVX5+Ylua/a48gfeqRdku6s=
X-Received: by 2002:a0d:df15:0:b0:5d7:f0fe:2258 with SMTP id
 i21-20020a0ddf15000000b005d7f0fe2258mr3385408ywe.39.1701958260622; Thu, 07
 Dec 2023 06:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20231206073712.17776-1-jirislaby@kernel.org> <20231206073712.17776-17-jirislaby@kernel.org>
In-Reply-To: <20231206073712.17776-17-jirislaby@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Dec 2023 15:10:24 +0100
Message-ID: <CAPDyKFo2TPVqd_1_SvQL0xiqgn8ipUq4Z1txxo5nFNsYYk4CZg@mail.gmail.com>
Subject: Re: [PATCH 16/27] tty: mmc: sdio: use u8 for flag
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 at 08:37, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> Switch character types to u8. To conform to characters in the rest of
> the tty layer.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio_uart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 370fadf1d6d1..575ebbce378e 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -354,12 +354,11 @@ static void sdio_uart_stop_rx(struct sdio_uart_port *port)
>
>  static void sdio_uart_receive_chars(struct sdio_uart_port *port, u8 *status)
>  {
> -       unsigned int flag;
>         int max_count = 256;
>
>         do {
>                 u8 ch = sdio_in(port, UART_RX);
> -               flag = TTY_NORMAL;
> +               u8 flag = TTY_NORMAL;
>                 port->icount.rx++;
>
>                 if (unlikely(*status & (UART_LSR_BI | UART_LSR_PE |
> --
> 2.43.0
>
