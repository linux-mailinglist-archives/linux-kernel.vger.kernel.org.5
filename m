Return-Path: <linux-kernel+bounces-148393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7298A81E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC931F215BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F4113C834;
	Wed, 17 Apr 2024 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7z34YSP"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A4113C8F0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352770; cv=none; b=r7FDiaxG6R0iVWPPw+8LRlZHEH+VMtNq4lAV2l8/cWsLONJIQphgKejQTP2ChH0jWBagJD7+iTUD1PwaykDq6tleQaa5FvFfo3QFM2dV1zg8l7TcNl5Bgw5tjhig9FyVrHQnm0qF15LWjge3q8m+bxnxPjZCI3dOvLtUh9Qph6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352770; c=relaxed/simple;
	bh=nShAutHtuE37PrbMJ/3jcXGQkinGfTAuQNwXS5UlpzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKrgtrE5zXc/0Mhd3pw2pz/PU2CRv0WW9C/b07rR02PA2POWnCY8GgEisY0viw0G/WRX9WcZZ+mYpzCGRq6ZCZCQG1/LFIzU2sNQ919Gdr9vpnq9AP7MsxwHDWknMMzIQAqRhuqPxNGhXGprvO25LehSemwu/RsDuV1X45dYd8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z7z34YSP; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6a04bb4f6d5so881736d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713352768; x=1713957568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nShAutHtuE37PrbMJ/3jcXGQkinGfTAuQNwXS5UlpzU=;
        b=z7z34YSPrpD8V4XxSZ9O5iyVYGJUJk5H9tHkF0p8lvxJeYg71VCT+P6bzC2gFmanp/
         JPgQU/PVdT08T9sYB6jp7COJfoc09m+kMkNW6UNBpkZULb8tx/9tH6AKSeqxgpL7wBWL
         cbDv8smolzN03+eJjepy3cub3MF2kop+HVCg2ogkiHknovUkCphMLbcsZxEgO+nYyBYa
         T6Hb0uKE1B5Lu23GRoWXo/ldJ60jkYVildqHWvOOqiyS5/P+PCuDWrkEDrUODGBugaiG
         ujX2auSNmgTag7MGR1BnY2Wsz06mX1JB1PiX3i4ZyK8ylxtenjmR8uyOnXYz6zNMlH0h
         XgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713352768; x=1713957568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nShAutHtuE37PrbMJ/3jcXGQkinGfTAuQNwXS5UlpzU=;
        b=TBDHKd2+Cc2zDLm91Yz2I6d+kJZJI/QZRecUWsxaENDIRnIARnokF2WTXBkZY02oTz
         hxHn2H6FniIRl7n7l87Bn7h9Tb5Cxfggag7nEaefmedTwDLzW/XIW9jw+y8ycmESuVhX
         Lbd8YlwujwVTw7byEJt/fyrfPD9Ry+nKE5mCC85dkbX7tC1owxRySPU5uKy9Bx692lM1
         aidzHixQMYqj3j59hQTysb2Y0RGihZ+KIyvY0qDsCb2wY/IWX4CHx4E9XhLc3xaqa3KG
         zc2wJTu0SJ9XFnCqoNNKO7lmlvFoW1/L+GSKlx0iEP33fVPrPF70v9ozGVvJM7F2kVfG
         MwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmntaFNzZKNHP/VjGv6Jr3SWnSUVb6UxstMO4/TGqZzALZzd0g2p5TXggryKcQOqbBkOG7kXEqCcrNWOSg6RODOQqlrKoMYCPs/wP3
X-Gm-Message-State: AOJu0YwwQOrW7kUygdWfkHIXRd9HK/LJ6QNViGTEmirQCFtNPUdLfUS/
	IF/3349BQ24CKRcEsF/YrPXessxTOULPpMQOW9m7fgMWtle5pC/mBQgI9YoC81K9cZ2h4BeNmFQ
	fPmEv+8oUw9Y+0/M5Ahe5LpfxtE5MzkyvAJCkQQ==
X-Google-Smtp-Source: AGHT+IFR6bhoypxiwiBMPF6IZr+uTIkVIpmOnJDANxKEhpPmGSVL/We4VkZgS73RHfl6aXFF1JnugYKsEXaCY4mMUq8=
X-Received: by 2002:ad4:4514:0:b0:6a0:4d4c:2ee3 with SMTP id
 k20-20020ad44514000000b006a04d4c2ee3mr269913qvu.30.1713352767703; Wed, 17 Apr
 2024 04:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405060826.2521-1-jirislaby@kernel.org> <20240405060826.2521-13-jirislaby@kernel.org>
 <CGME20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae@eucas1p2.samsung.com>
 <91ac609b-0fae-4856-a2a6-636908d7ad3c@samsung.com> <d70049d5-d0fe-465f-a558-45b6785f6014@kernel.org>
 <Zh-fgtujwjiSXz7D@monster> <c091da0b-a150-428a-bf96-75f9f3eab2e2@samsung.com>
In-Reply-To: <c091da0b-a150-428a-bf96-75f9f3eab2e2@samsung.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 17 Apr 2024 13:19:16 +0200
Message-ID: <CADYN=9LCJS0SW4PuF+e356HUxhzJYi093K6U+BdErPohq4RDWQ@mail.gmail.com>
Subject: Re: [PATCH 12/15] tty: serial: switch from circ_buf to kfifo
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org, 
	linux-amlogic@lists.infradead.org, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 12:20, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 17.04.2024 12:08, Anders Roxell wrote:
> > On 2024-04-15 15:28, Jiri Slaby wrote:
> >> On 15. 04. 24, 14:58, Marek Szyprowski wrote:
> >>> On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
> >>>> Switch from struct circ_buf to proper kfifo. kfifo provides much better
> >>>> API, esp. when wrap-around of the buffer needs to be taken into account.
> >>>> Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for example.
> >>>>
> >>>> Kfifo API can also fill in scatter-gather DMA structures, so it easier
> >>>> for that use case too. Look at lpuart_dma_tx() for example. Note that
> >>>> not all drivers can be converted to that (like atmel_serial), they
> >>>> handle DMA specially.
> >>>>
> >>>> Note that usb-serial uses kfifo for TX for ages.
> >>>>
> >>>> omap needed a bit more care as it needs to put a char into FIFO to start
> >>>> the DMA transfer when OMAP_DMA_TX_KICK is set. In that case, we have to
> >>>> do kfifo_dma_out_prepare twice: once to find out the tx_size (to find
> >>>> out if it is worths to do DMA at all -- size >= 4), the second time for
> >>>> the actual transfer.
> >>>>
> >>>> All traces of circ_buf are removed from serial_core.h (and its struct
> >>>> uart_state).
> >>>>
> >>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> >>>> ...
> >>> This patch landed in linux-next as commit 1788cf6a91d9 ("tty: serial:
> >>> switch from circ_buf to kfifo"). Unfortunately it breaks UART operation
> >>> on thr Amlogic Meson based boards (drivers/tty/serial/meson_uart.c
> >>> driver) and Qualcomm RB5 board (drivers/tty/serial/qcom_geni_serial.c).
> >>> Once the init process is started, a complete garbage is printed to the
> >>> serial console. Here is an example how it looks:
> >> Oh my!
> >>
> >> Both drivers move the tail using both kfifo and uart_xmit_advance()
> >> interfaces. Bah. Does it help to remove that uart_xmit_advance() for both of
> >> them? (TX stats will be broken.)
> >>
> >> Users of uart_port_tx() are not affected.
> >>
> >> This is my fault when merging uart_xmit_advance() with this series.
> >>
> > I'm trying to run on two dragonboard devices db410c and db845c and both
> > fails to boot see the boot failure from db845c [1], linux-next tag: next-20240415.
> > I tried to apply the patch [2] (that you proposed in this thread) ontop of next-20240415. However, that didn't
> > help bootlog on db845c [3].
>
> This is a different issue, which I've reported 2 days ago. See the
> following thread:
>
> https://lore.kernel.org/all/d3eb9f21-f3e1-43ec-bf41-984c6aa5cfc8@samsung.com/

Oh ok, I did the bisection on db845v, and that led me to this
patch 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")

Cheers,
Anders

