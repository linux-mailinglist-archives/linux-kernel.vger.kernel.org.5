Return-Path: <linux-kernel+bounces-14624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD94821FCE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8011C2256B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0209515AF7;
	Tue,  2 Jan 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sTbeuXO7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6915AED
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ef7c6f4cfcso26525467b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704214670; x=1704819470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4472QStNp6Zr1RLAldtMI7Jne10bfsy1ti/c3TxR+2Y=;
        b=sTbeuXO7zin5KluO+qE6w4bhCBqDWrpbyu71ZjYVZQ61Q/uU/0tolijSQ0xX0oAyX7
         Ky3rjocPVD0ge5LkVDOxmeTnybINYQB1rbABbfhjOeDeYAkix0CWxp8vXjjwDLvQznWT
         IZdbnndQRTHFX0GdIxxjsIhjS5OLOYnP3PgU+teCuXiLFOorhnaSxrD1xUUIGRN7luuh
         FntnnnKBrhKkGum0TPVlKuiBSQY1LbDhLgiCcKqhwmwGdGMmcZPW1PVLsY1OtsKPGrz4
         sPQQHqcFYQjvgIva/RF5UGbiSlBgMWvwi0QNlAgACNOueLs9CGaIjP8uU3WW4e+fEn3i
         kIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214670; x=1704819470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4472QStNp6Zr1RLAldtMI7Jne10bfsy1ti/c3TxR+2Y=;
        b=h5dr3U1xCE13WffNhOyxHyUdS8wtjb99lz76FK5Wficv/U6zSqdh0bXG6EQhuqLwE9
         5r5P2ckwStEZgIjsdQ9pvDLPDxoRBEj2NQIBqzDoX3VJKT2oOWMN0PLHLoiJ8yK1Cf17
         p4I/cX8STn+QQpVFCqkbOQO3sUwuNT+ryEcVbHf56Ifc4sdfgfUsniWr8iliN6Mza1yH
         Pr/9wd80TtdTJt81G2KzAFfu2EA0rwozAFBpaxDd9+y347DpfVs3tX7DTZgPHiFWPbIG
         LBAv1RoVg5X7iTgxsF7OFZnOw4u+D0Fp2miXoI0F5v+Z37h8Q2MpiqIpWw7v2TwEyL5G
         xMbg==
X-Gm-Message-State: AOJu0Yykvtaw7O0y8+oCahHQBArqrt3GEoHrPaZuXgG/f5lhilTlBv8E
	bff48vQOXZLfWyVXrcUHHjhkoeW/bNT2gyIUpK0j/BfzeI9i+v5jnKk1JjPo
X-Google-Smtp-Source: AGHT+IGaie7llkC0WY/ixF26z8u+KlGBuJcMXc/mTXO9lJk5lRRKNK+aRovxY0vGl7k6LwgOSjGmAgsCULdJSRRqxi8=
X-Received: by 2002:a25:b2a2:0:b0:dbd:9bd9:2159 with SMTP id
 k34-20020a25b2a2000000b00dbd9bd92159mr10842360ybj.45.1704214669983; Tue, 02
 Jan 2024 08:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225093839.22931-1-mengqi.zhang@mediatek.com> <20231225093839.22931-2-mengqi.zhang@mediatek.com>
In-Reply-To: <20231225093839.22931-2-mengqi.zhang@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Jan 2024 17:57:14 +0100
Message-ID: <CAPDyKFpJYKLCrrb0-dPLNGcaLRjevWkrrXpJY70rbwjsUJdYug@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mmc: core: Add HS400 tuning in HS400es initialization
To: Mengqi Zhang <mengqi.zhang@mediatek.com>
Cc: chaotian.jing@mediatek.com, matthias.bgg@gmail.com, 
	wenbin.mei@mediatek.com, yangyingliang@huawei.com, adrian.hunter@intel.com, 
	avri.altman@wdc.com, vincent.whitchurch@axis.com, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Dec 2023 at 10:39, Mengqi Zhang <mengqi.zhang@mediatek.com> wrote:
>
> During the initialization to HS400es stage, add hs400 tuning flow as an
> optional process. For Mediatek IP, HS00es mode requires a specific
> tuning to ensure the correct HS400 timing setting.
>
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v1 https://patchwork.kernel.org/project/linux-mediatek/patch/20231201030547.11553-1-mengqi.zhang@mediatek.com/
> v2 https://patchwork.kernel.org/project/linux-mediatek/patch/20231222062236.26370-1-mengqi.zhang@mediatek.com/
> ---
>  drivers/mmc/core/mmc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 705942edacc6..d5173a9bb4b0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1822,8 +1822,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>
>                 if (err)
>                         goto free_card;
> -
> -       } else if (!mmc_card_hs400es(card)) {
> +       } else if (mmc_card_hs400es(card)) {
> +               if (host->ops->execute_hs400_tuning) {
> +                       err = host->ops->execute_hs400_tuning(host, card);
> +                       if (err)
> +                               goto free_card;
> +               }
> +       } else {
>                 /* Select the desired bus width optionally */
>                 err = mmc_select_bus_width(card);
>                 if (err > 0 && mmc_card_hs(card)) {
> --
> 2.25.1
>

