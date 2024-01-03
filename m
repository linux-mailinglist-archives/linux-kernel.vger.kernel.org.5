Return-Path: <linux-kernel+bounces-15391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34ED822B60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25D11C2331E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90DC18C28;
	Wed,  3 Jan 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAcaFfEL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDE18C0A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbdb8e032f7so209921276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 02:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704277673; x=1704882473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L8nUGwMGmcdQ37anP4pXbySXho8ZvOsvtGKAUVKkBoE=;
        b=AAcaFfEL/zc+DPcuT8WIV6yyWCd4JyyIjNw7C+plFq4U91Bpyq7huqFrp1FfoIK0TX
         zn8ddkK030kUmth5Rfszt3bkN2SXF5GAB2WA1ADLIO0xIWGH1OapIID8wz4QR5AyyTu1
         CCXuCCKo7R8ho6P2apU63W7LysB3FIDFTA/X8b9g3V6cM3p6xqFQqOvJrnR/z/nMZPO/
         SfEOgZvlkzupgP5aERbaiAfTGqjAryxUZHsgQH7gBLcqTgHSw/cQiQGEnJL5oINe1ji8
         LMtRxRWRmmtg7/FQSiC/bCtBGxslUAmZdg0qXyK0MBbTuc2AHhX2U5dQZ1tx/6Ky9fBg
         shvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704277673; x=1704882473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8nUGwMGmcdQ37anP4pXbySXho8ZvOsvtGKAUVKkBoE=;
        b=wnB8XZL3WBTDCmTEp8PDd9/CNyUkkrYxv0kwk0eAHmEUyTMoC+/Qr9YynX2M+/bt4G
         NaSaHHXTp15g7OyyAGhfZfbsKPQ6RuHogYo762Kvau7kilJ6KDJUzrQoxicT8ywZj2W4
         spGb5oSBffjSE8GmEC+srZZwYqjimKGcA+prO7cKkIjZ6MNyo9NXwe/6M4n7UUFQcbO5
         qf9Tkozk1NUedJDjF0FnlTgrRv5x/gt1FHKL77WDo/INMVf6N3WYMot+85avPglIumbQ
         +PoEkyWqazgeyYFmDKE/Db6SL/53SAi+f23tMntA6xnrl1wNDH1GkfHrl+xsddrcaC/r
         r8Eg==
X-Gm-Message-State: AOJu0YyNT/Faf/90S47ma53IfdviuF0NzNT3tBIzwFq4h/oruMtcjgHG
	UUNSn0QLJl3/pJ1EyE0KnkBNJpnDUFXL+g04Yg19v6Sc4N28lNBTvdRimK1P
X-Google-Smtp-Source: AGHT+IEUPNT2HMmW05/SR8MDqddWqlAS7vZ7shNJ7I7uIXlGR59qr5DBqeSRyt9sBZpoCJ9vUnoT8h2VTVj2ohvsU6U=
X-Received: by 2002:a25:8a88:0:b0:dbd:998:5fbd with SMTP id
 h8-20020a258a88000000b00dbd09985fbdmr449597ybl.32.1704277672737; Wed, 03 Jan
 2024 02:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204064934.21236-1-wenchao.chen@unisoc.com>
 <CAPDyKFpK2Yjj2oDWCUKHpht6PC9uNG-x2rPYO3EBD6GGWg4VZg@mail.gmail.com>
 <CA+Da2qyB2tQjq5wxoqNwjb5HXhdPHMsWN08Ot7nMEkZzOgQ9LA@mail.gmail.com>
 <7541f17a-f0a7-486b-9664-3573623d7154@linux.alibaba.com> <CA+Da2qy7Rwkx-SXORi8DB5ptaTm1TuME+CgsCDk2Bs-rJo6gsg@mail.gmail.com>
In-Reply-To: <CA+Da2qy7Rwkx-SXORi8DB5ptaTm1TuME+CgsCDk2Bs-rJo6gsg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 3 Jan 2024 11:27:16 +0100
Message-ID: <CAPDyKFocwf2pc4h+Ua4meP90RegSmXdV1De5jVJ50UnxRzWYmw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sprd: Fix eMMC init failure after hw reset
To: Wenchao Chen <wenchao.chen666@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Wenchao Chen <wenchao.chen@unisoc.com>, 
	zhang.lyra@gmail.com, orsonzhai@gmail.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com, 
	yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 02:41, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>
> Gentle ping.

Thanks for pinging and sorry for the delay!

Patch applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

>
> Thanks,
> Wenchao.Chen
>
> On Tue, 12 Dec 2023 at 10:57, Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 12/8/2023 7:52 PM, Wenchao Chen wrote:
> > > On Thu, 7 Dec 2023 at 21:59, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >>
> > >> On Mon, 4 Dec 2023 at 07:50, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
> > >>>
> > >>> Some eMMC devices that do not close the auto clk gate
> > >>> after hw reset will cause eMMC initialization to fail.
> > >>>
> > >>> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > >>
> > >> I assume we want this tagged for stable kernels too, but do we have a
> > >> corresponding fixes commit that we can point out?
> > >>
> > >> Kind regards
> > >> Uffe
> > >>
> > >
> > > Hi Uffe
> > > Sorry, I forgot to add fixes commit.
> > >
> > > Fixes: ff874dbc4f86 ("mmc: sdhci-sprd: Disable CLK_AUTO when the clock
> > > is less than 400K")
> >
> > With the Fixes tag, looks goo to me.
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >
> > >>> ---
> > >>>   drivers/mmc/host/sdhci-sprd.c | 10 +++++++---
> > >>>   1 file changed, 7 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > >>> index 6b8a57e2d20f..bed57a1c64b5 100644
> > >>> --- a/drivers/mmc/host/sdhci-sprd.c
> > >>> +++ b/drivers/mmc/host/sdhci-sprd.c
> > >>> @@ -239,15 +239,19 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
> > >>>          div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
> > >>>          sdhci_enable_clk(host, div);
> > >>>
> > >>> +       val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
> > >>> +       mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN | SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
> > >>>          /* Enable CLK_AUTO when the clock is greater than 400K. */
> > >>>          if (clk > 400000) {
> > >>> -               val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
> > >>> -               mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN |
> > >>> -                       SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
> > >>>                  if (mask != (val & mask)) {
> > >>>                          val |= mask;
> > >>>                          sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
> > >>>                  }
> > >>> +       } else {
> > >>> +               if (val & mask) {
> > >>> +                       val &= ~mask;
> > >>> +                       sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
> > >>> +               }
> > >>>          }
> > >>>   }
> > >>>
> > >>> --
> > >>> 2.17.1
> > >>>

