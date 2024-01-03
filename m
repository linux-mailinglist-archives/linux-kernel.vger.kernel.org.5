Return-Path: <linux-kernel+bounces-15042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D7A822698
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166C11F22EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79F41390;
	Wed,  3 Jan 2024 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG5wXB+K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1810FE;
	Wed,  3 Jan 2024 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28ce9a0e544so146013a91.3;
        Tue, 02 Jan 2024 17:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704246066; x=1704850866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fsry+veA0BH9pQQgtym3vQ1xpw5YN/FTLuIDJlPaT/M=;
        b=XG5wXB+KD7PJ+JeTu94f18/1QjLLpjdTcNTJWT6qwNYEr6svx+gaU4s743w/TDxPk9
         LnlOumWItDWuPwwpIIC3CqGpJflk+KxThuzS3Dd5kPN8X9l+8rxa/mW0XEyYIO9YNJXn
         r6zSrbeqVZnFBq57ySuzxAqXNHG/gXDOsg4L1iEbgoJdK1EyED9V5FSgbPOC1EXnCXmx
         ySQYjKR4xq2BbNJK/RG+B62BLnZSKlhkrzEtg5aLh0l841RZsfPL30xHl094OMVuxJLQ
         vfbNcUJIQJVMbx2x+LaGhdTNiB+nPRRgOXlOiiyqsyuPMHDen5NGveRz5tQusoN71er5
         rz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704246066; x=1704850866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fsry+veA0BH9pQQgtym3vQ1xpw5YN/FTLuIDJlPaT/M=;
        b=HS7ssEB18JQZ6Q1g859aJOSDnv5VnzMPl/NUEYs7kQ+bGVOnmCoWGpCWffprdA5HOG
         lBoaDauI5j7CrqFeqLUD5u7xtqrxNUdyQCkc/q69/hvF+Uj41Fuls7bHjRmyiwPgWCKv
         vt/kcGVtleHwDp4IFIenVxutnZ3UHND2xKDEm1P/HYDJOQqJEd8JhIe328OWdmM3NGMG
         lR6+XWjcICS9OfqeoVFRPy6vk+Cgwq2lRPeeQlV2PoUETjeIf4dqrrcodBfcKCV+S1C6
         t2sWbvvx9xvkHa5RlHSLQiaf7xSeBCe7mXXPlBXVAEHvqbP41ic70+KX3Ug8bvQARG1v
         WONw==
X-Gm-Message-State: AOJu0YwjlFyYO81gLhYDBVaTGSPuS73d5Q+VUj/Zjb464VKlarJOTu+G
	4697likbWfAejgDvPpCBLPJsN7kej5Nake1JJNRGfLXYXcx+mw==
X-Google-Smtp-Source: AGHT+IEFA1WPqXBDf6TZ9sAPvWMZnLP1mKpQSnenwwwlgbRJFCw1RJsRUvloVhcxfRR496mPMA+HdaNkqeQLbJbJQe8=
X-Received: by 2002:a17:90a:7186:b0:28c:d9b:5983 with SMTP id
 i6-20020a17090a718600b0028c0d9b5983mr8760421pjk.48.1704246065933; Tue, 02 Jan
 2024 17:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204064934.21236-1-wenchao.chen@unisoc.com>
 <CAPDyKFpK2Yjj2oDWCUKHpht6PC9uNG-x2rPYO3EBD6GGWg4VZg@mail.gmail.com>
 <CA+Da2qyB2tQjq5wxoqNwjb5HXhdPHMsWN08Ot7nMEkZzOgQ9LA@mail.gmail.com> <7541f17a-f0a7-486b-9664-3573623d7154@linux.alibaba.com>
In-Reply-To: <7541f17a-f0a7-486b-9664-3573623d7154@linux.alibaba.com>
From: Wenchao Chen <wenchao.chen666@gmail.com>
Date: Wed, 3 Jan 2024 09:40:54 +0800
Message-ID: <CA+Da2qy7Rwkx-SXORi8DB5ptaTm1TuME+CgsCDk2Bs-rJo6gsg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sprd: Fix eMMC init failure after hw reset
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wenchao Chen <wenchao.chen@unisoc.com>, 
	zhang.lyra@gmail.com, orsonzhai@gmail.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com, 
	yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"

Gentle ping.

Thanks,
Wenchao.Chen

On Tue, 12 Dec 2023 at 10:57, Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 12/8/2023 7:52 PM, Wenchao Chen wrote:
> > On Thu, 7 Dec 2023 at 21:59, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>
> >> On Mon, 4 Dec 2023 at 07:50, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
> >>>
> >>> Some eMMC devices that do not close the auto clk gate
> >>> after hw reset will cause eMMC initialization to fail.
> >>>
> >>> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> >>
> >> I assume we want this tagged for stable kernels too, but do we have a
> >> corresponding fixes commit that we can point out?
> >>
> >> Kind regards
> >> Uffe
> >>
> >
> > Hi Uffe
> > Sorry, I forgot to add fixes commit.
> >
> > Fixes: ff874dbc4f86 ("mmc: sdhci-sprd: Disable CLK_AUTO when the clock
> > is less than 400K")
>
> With the Fixes tag, looks goo to me.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>
> >>> ---
> >>>   drivers/mmc/host/sdhci-sprd.c | 10 +++++++---
> >>>   1 file changed, 7 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> >>> index 6b8a57e2d20f..bed57a1c64b5 100644
> >>> --- a/drivers/mmc/host/sdhci-sprd.c
> >>> +++ b/drivers/mmc/host/sdhci-sprd.c
> >>> @@ -239,15 +239,19 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
> >>>          div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
> >>>          sdhci_enable_clk(host, div);
> >>>
> >>> +       val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
> >>> +       mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN | SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
> >>>          /* Enable CLK_AUTO when the clock is greater than 400K. */
> >>>          if (clk > 400000) {
> >>> -               val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
> >>> -               mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN |
> >>> -                       SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
> >>>                  if (mask != (val & mask)) {
> >>>                          val |= mask;
> >>>                          sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
> >>>                  }
> >>> +       } else {
> >>> +               if (val & mask) {
> >>> +                       val &= ~mask;
> >>> +                       sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
> >>> +               }
> >>>          }
> >>>   }
> >>>
> >>> --
> >>> 2.17.1
> >>>

