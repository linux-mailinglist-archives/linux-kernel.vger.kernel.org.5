Return-Path: <linux-kernel+bounces-134999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D789B9C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969652826FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C33B782;
	Mon,  8 Apr 2024 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCdJ1pjI"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF8381DF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563801; cv=none; b=OiQUM18sIKv1lnnf3t9h8XLkbkbvycrRmxJWDDxuN1F84FLuhGbjt8k0xJpUHmbovZWaJLkBkToI37ISepUNALei+v55fAlVWDTZEBjr5MGXB2KmVegOJAeafGi7lTBcByg52PWd4+p8qR9gwO8Z2MWUHD3Iro1npY/ZCcxiSPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563801; c=relaxed/simple;
	bh=ljkAHH/jrVsEddYmqwbcAhxir0nJCPPqH96atvjx+I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS1tzAATXuPytOoCLY/lHJxXMtbw6plhlC7iPA9xjjku3rXVKxU640QIknkAiz1YWjYgx6L6NZDJ+tb675VurbGApX1Tjyp3YxRZl+f9O17C5go1OWl6S7XtRmAl4UWF4+EJEVfOYmpJaY9btS7V/DZ3pbBlCxAKggvM8Oni4QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BCdJ1pjI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso2150296a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712563797; x=1713168597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OzIHovojG3644yJzi7Rp4zPvS+LnsKi9BT3OOCmERoA=;
        b=BCdJ1pjInKKk4vrgVcjnsJf+I8ArtH02GFeLNUq5rIpogQRb1hlTw5Z4a3CIC9dQ86
         p99pc2LF+33dZHwTcmQ1PXNyRNgdShtYxKUSWlLafAORk5KWI3oB/Ej8E8U0MpM8EJlY
         qpkdpWMfD8j733hkxoa0lhQ8kmu+Quh1PTpL/yIXyID5KDMxHta/P9lXZ3uyOkRE1FNP
         NVbd3Z2+aDKxlS+UCRpPT6VnHCKMul0ZxQ4TisDo8oMpguE1aYKRNXfWum1OD/3yOZFA
         jUaYsiHZiRh/Emp4+Hs73LZBgkDILK2QonUpJAWjV06+OC6Mh1L222fKXGtzA9bfNqtI
         dvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563797; x=1713168597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzIHovojG3644yJzi7Rp4zPvS+LnsKi9BT3OOCmERoA=;
        b=xVWJOBjfohHBasIe0VSBY/02tuAPvdcA3imaAb++DNfW2MP1RDXcueWKsWndhKL7jF
         gaJTCku9WC8Nr/aYB4Gp74R+EeHOqw3J2oZd1Qe7dqyqHMsCMSquivmNU3Rfl+PZ7EvQ
         WdFsFgFiYsT0bcr4kPwM38XDVjmw0PZhTASIZaxE9xUk16uqAw7GU5kbYg3XQIJOEEV+
         Onga6HGOor9UM2lX8tONqSg2rBMH9vTs0zFyDHQWrdT2s6n4Kl71/08yapXJYAo9R0gv
         Dp6A5650kc+jSXH2SZqw5PFBJIIAYxX6jk211pq0m5SGLXYXOIRLw9mMJH3S2WQIWQ3L
         v18g==
X-Forwarded-Encrypted: i=1; AJvYcCVAI+v7Xd/cCaMCcZ7e6kAOh72Bf7u5/V+xOzhBfYq1seUEKY6/26TAM1uCQ8YIW4dZydafo81WnLa9lW1aD+AekpEKlkT54uKAmFh9
X-Gm-Message-State: AOJu0Yx7KQCDUOnbPYM04DJkzoj1Bpn3EwFkMf27NMfTi8nHHiLpk/DM
	NnqGnMBzvhwkULFpOGlq0LosvrC2zfPymR6NUgEDnLBrEPAjXe+jNOPWmzGrFQw=
X-Google-Smtp-Source: AGHT+IHtvCDCPVlkweFZtEXFJMtCJqeKZm0fgLqDOmu+n81huoTOcfZOWzp5QNMYK38WJkLMK2XiTQ==
X-Received: by 2002:a17:906:3391:b0:a4e:768a:144f with SMTP id v17-20020a170906339100b00a4e768a144fmr4666050eja.36.1712563797196;
        Mon, 08 Apr 2024 01:09:57 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id gt17-20020a1709072d9100b00a51b3d4bb39sm3081020ejc.59.2024.04.08.01.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:09:56 -0700 (PDT)
Date: Mon, 8 Apr 2024 11:09:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] thermal/drivers/mediatek/lvts_thermal: Improve some
 memory allocation
Message-ID: <d97f2a57-d318-455b-a860-8bd7972c8aaf@moroto.mountain>
References: <42a87fb9837f1760d1ad4eb7162a7536785dc6f5.1712520052.git.christophe.jaillet@wanadoo.fr>
 <8cb69f245311a348164b0b5ca3dbc59386746035.1712520052.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cb69f245311a348164b0b5ca3dbc59386746035.1712520052.git.christophe.jaillet@wanadoo.fr>

On Sun, Apr 07, 2024 at 10:01:49PM +0200, Christophe JAILLET wrote:
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 3003dc350766..b133f731c5ba 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -204,7 +204,7 @@ static const struct debugfs_reg32 lvts_regs[] = {
>  
>  static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
>  {
> -	struct debugfs_regset32 *regset;
> +	struct debugfs_regset32 *regsets;
>  	struct lvts_ctrl *lvts_ctrl;
>  	struct dentry *dentry;
>  	char name[64];
> @@ -214,8 +214,14 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
>  	if (IS_ERR(lvts_td->dom_dentry))
>  		return 0;
>  
> +	regsets = devm_kcalloc(dev, lvts_td->num_lvts_ctrl,
> +			       sizeof(*regsets), GFP_KERNEL);
> +	if (!regsets)
> +		return 0;

I understand that this preserved the behavior from the original code,
but the original code was wrong.  This should return -ENOMEM.

> +
>  	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
>  
> +		struct debugfs_regset32 *regset = &regsets[i];
>  		lvts_ctrl = &lvts_td->lvts_ctrl[i];

The blank line should come after the declaration.

regards,
dan carpenter


