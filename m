Return-Path: <linux-kernel+bounces-96899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7388762BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27091C2149D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9713355C3E;
	Fri,  8 Mar 2024 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpaY0AEn"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D554746;
	Fri,  8 Mar 2024 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896098; cv=none; b=sh/co3er/6gzUqt44NTAR4JTUMT8g62L6gtFrLanLDsmu/mtPWRVKtfCrtDD0Ud7fhslK3R3LTpM0oVNMEoA7tLBTxjIsZbhnTYF1XWuxogOJpWZ9jpY0ioQF54D3m1fil+ciy61VIF0llON1C0HJ7jhq6uqWYsqSmxvSoBPyA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896098; c=relaxed/simple;
	bh=OR4ng6hQvro7ZBsX1o3XaRMRvF5ODFgK2Hn0v+CtAUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWfdkx2L6H56F7CHnwlntVkT5OpYpzsvP1rmQ38O3a1VFJV2n1WYBGuM0mSgYaKLhCqbODLf1l5KKNsQfo1GYDd9a/EwW6YLi//Bap1LvZVuD6WzYIDBtnZyZLtomWd28c8FFxY7VPfMUcRbYQWUnE57iakcgzPc/7seG60m5TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpaY0AEn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5682ecd1f81so536171a12.0;
        Fri, 08 Mar 2024 03:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896095; x=1710500895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjS1T5EZDkISTMFA/Hv7zuCa3iq95DmRVfFX3p+XzvU=;
        b=hpaY0AEnPMgxMXhuNcBnbsd1jfk3ddRkv2ED884gpjWpopJR93RMCzWSVoP69UpAMF
         vTgHecXEL3TuwpzAaL7BWuN+S1jTeVnvTv95lYHXzSexUIMPgzlCRfNgtWwxsMlNOBSK
         ukDuhoURE/qCotx/KKalihyEv0NPK1Yik5OLRtT9WfiZMSbBU0XvDkJOsKU/1S+Bj1dJ
         OTdDo5RTfJHz56muoYADiKvjKi05kZnl7LwXgY1dM01ZwtfD8ALP0h3WQzL6fQ9/6kpb
         1Sb67eP92urQACAUVf1xidX9zJbW7a4QQBwdckD9Yp5Tk1+mNtIROfBkdh3B2NnbD7dw
         x3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896095; x=1710500895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjS1T5EZDkISTMFA/Hv7zuCa3iq95DmRVfFX3p+XzvU=;
        b=PvCppUFXoJX+D8Z/QoxhVBdStZPSx/XMnzbzy+U7i+zeXKWmmt1LRs5dTL0MicYfjH
         X8LzQaypr/JyR0wrKWARDI57p8shpWdqwIqZoUBqx9rojzFa4HuUqadkqLQvWuX9izpI
         vyqJIBil12bftT5BVfo5bHgKO9EdMrytdxYsOJkq8EY80PCpZBxixqoaoyUD0nuIl3K+
         iZ/fRcbBlDXYAkZGXY41yPTLOxu5ATmtyN2l6vntCYtD4RUS1aeRIKML43En6BDvfIvw
         E4NMn2TFrlFIQDIvxd8QU20OKH/uwlZeg4EcqEAUMOaj1WpvGz05qNTzNDZK/lQcvHMS
         nnVw==
X-Forwarded-Encrypted: i=1; AJvYcCXDf4H7bJBpmLzIKVMA+7Ctp+DsOhQ3RARn4pdOOa/GLQdL4DN7WBMfC1Dn8zwt/ZFhi8sV8zoOyVx7wonhThPOCDKxWUJk3icBqJrN
X-Gm-Message-State: AOJu0YxgEEwFW9lDerklGfv+IJMdh3/kZArOyZCvBdP7g4GDwoozDJG7
	ov5sQeflpoCc1y2Qw5YrOPU5U5UcK6RQz4SnqmzrDC/smUqoTEMp
X-Google-Smtp-Source: AGHT+IGk6W9uxK5/rvUyc8vN77jtOzbhtn24rU49IHJ+Xu0E2oDpp9jlYhrnZfUh8NrfGEr4noAHLg==
X-Received: by 2002:a50:cc43:0:b0:567:dea:c3bf with SMTP id n3-20020a50cc43000000b005670deac3bfmr1415625edi.41.1709896095312;
        Fri, 08 Mar 2024 03:08:15 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-82.cust.vodafonedsl.it. [188.217.49.82])
        by smtp.gmail.com with ESMTPSA id p13-20020a05640210cd00b00568233e2fbbsm1040874edu.44.2024.03.08.03.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:08:14 -0800 (PST)
Date: Fri, 8 Mar 2024 12:08:13 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v2 4/6] media: imx335: Use integer values for size
 registers
Message-ID: <ZerxncwhQLgm3PMP@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240308083312.90279-1-umang.jain@ideasonboard.com>
 <20240308083312.90279-5-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308083312.90279-5-umang.jain@ideasonboard.com>

Hi Umang,

On Fri, Mar 08, 2024 at 02:03:10PM +0530, Umang Jain wrote:
> Consider integer values for registers that are related to various
> sizes in the register map. This helps in improving the overall
> readability.
> 
> No functional changes intended in this patch.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index ec27035586f3..3c593538f727 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -250,12 +250,12 @@ static const struct cci_reg_sequence mode_2592x1940_regs[] = {
>  	{IMX335_REG_MODE_SELECT, 0x01},
>  	{IMX335_REG_MASTER_MODE, 0x00},
>  	{IMX335_REG_WINMODE, 0x04},
> -	{IMX335_REG_HTRIMMING_START, 0x0180},
> -	{IMX335_REG_HNUM, 0x0a20},
> -	{IMX335_REG_Y_OUT_SIZE, 0x0794},
> -	{IMX335_REG_AREA3_ST_ADR_1, 0x00b0},
> -	{IMX335_REG_AREA3_WIDTH_1, 0x0f58},
> -	{IMX335_REG_OPB_SIZE_V, 0x00},
> +	{IMX335_REG_HTRIMMING_START, 384},
> +	{IMX335_REG_HNUM, 2592},
> +	{IMX335_REG_Y_OUT_SIZE, 1940},
> +	{IMX335_REG_AREA3_ST_ADR_1, 176},
> +	{IMX335_REG_AREA3_WIDTH_1, 3928},
> +	{IMX335_REG_OPB_SIZE_V, 0},
>  	{IMX335_REG_XVS_XHS_DRV, 0x00},
>  	{CCI_REG8(0x3288), 0x21}, /* undocumented */
>  	{CCI_REG8(0x328a), 0x02}, /* undocumented */

Looks good to me.
Reviwed-by: Tommaso Merciai <tomm.merciai@gmail.com>

Thanks & Regards,
Tommaso

> -- 
> 2.43.0
> 
> 

