Return-Path: <linux-kernel+bounces-103303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A387BDBC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6261F23937
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E675C60D;
	Thu, 14 Mar 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu2w+gOg"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0596DCE3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423047; cv=none; b=g239GvCTvHqTWHIeZXmn7E1InevoFd4+ZRDOep4RgHHQw/CaIqEl1qgg3LIHnWdI8j1TUq9g0KpiDWjDc1shXbycoxg5oLnsC/VebYjL3A9Ng8D+vRiuGZ65KeMZb5i0MY7BFTEVxCzJtVWauw2qz6Q9fdhTOnlLuaVRepL95Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423047; c=relaxed/simple;
	bh=11j+Z3UFl/e7AjIJcRHi2dz2L+8S9g3f5yDsqvNuBV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhcBhW/D1wq64qINq1YriaxkNQ+8W1UCPuU2jH7zngBVN3aXPO2JC6VcXMZ0ne1ZNl77tEDV8J5TtAKsAyLZmKUl7eZjiZmlWoiM2aWVEc9W/UKQ2LachULF8dgBgLkSrOzPND+5fsllDDY5x9yC1r3XVVrw950RvGTYm6Rb284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nu2w+gOg; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so1112012e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710423044; x=1711027844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=86yHLksSztOa2QFDhY00gGhv0MGKwJBozJPgYBlG5kQ=;
        b=Nu2w+gOgNoBawfoWW7J7GMIEXzvfNM4dKaIR8BT724cqyRaVVidGCrvJFou0LVM4oo
         snSCP0Ws4OsNgzyZZaMvxIcZ+bEbUerjhqfx8j8QHxG+mF7phtJxbM3tg0TA/Zdz8CU9
         3DIm50CNY9p12dgR1p66DDgLEnBMdZ9tUPTT129a0eNr3sYnKbxKm0U6P1oESxfoWyZb
         e8TrGmjZGkhMKaZNicN3rSuLOunxAxgO7YEROGevEKfN6+6RnKOiayOiscEqseqwRO19
         aNnVZkroJhJEMbM7zWX2IP8+tTTNTAUluMJ9cZihSOotswRKbQJiFp09hrn3XxYbU3Co
         fW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710423044; x=1711027844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86yHLksSztOa2QFDhY00gGhv0MGKwJBozJPgYBlG5kQ=;
        b=IRthph0ERKHynF53Wesm4ifzlsW5m5bCiBqodRKl1cB1/WtNKS4uGMC0PeyZaQeITK
         Uhpsq+Mqq2T8IsOugRYLcdCjePS18wxIWetWFzJnMu3Un8wiHUWoMEs8ufRaCjybpwhs
         5m0poBU1ujWGaul+QqO2xe1mLvNETAq3OQvRmIB+J+FSvacXQShNkarqFCVCxf7sluBj
         R2MywdapxxOjnwfDfRo9sNvKcchFcYaHn7vfdvKlBbQHV3QlJq51205gEAkHBqiL7HBz
         NcsiNCOMBpC/dg7IYSgcnSLbbTTZgVHKWnhdpA5Ki5S/MX2qUj2IU0WAha5whtfDWzMD
         FhsA==
X-Gm-Message-State: AOJu0YxohA/qerr0LxgVy7vwrdQA/rdjcsJ6qDubIgPyS0g6PB0l3g3Z
	ta++4r5bSBFESeDDaAct4mZsMIynmrbSNzfswmGjqAB2dsyT5rkjsJN/lyz1M4Y=
X-Google-Smtp-Source: AGHT+IH9MrqihKkfEzTbqPu+2K9+3izR3okzeB9SWVDvZd2rTdQvgjDWFZ9R9M41VsxvuggqOXa8kQ==
X-Received: by 2002:a05:6512:370b:b0:513:32e2:141b with SMTP id z11-20020a056512370b00b0051332e2141bmr86493lfr.67.1710423043347;
        Thu, 14 Mar 2024 06:30:43 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c470d00b00413f1c01a7bsm2157935wmo.16.2024.03.14.06.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 06:30:43 -0700 (PDT)
Date: Thu, 14 Mar 2024 16:30:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org, eblanc@baylibre.com
Subject: Re: [PATCH v3 03/11] mfd: tps6594: add regmap config in match data
Message-ID: <bb5de326-899c-4c32-b9af-f1698316e5f8@moroto.mountain>
References: <20240308103455.242705-1-bhargav.r@ltts.com>
 <20240308103455.242705-4-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308103455.242705-4-bhargav.r@ltts.com>

On Fri, Mar 08, 2024 at 04:04:47PM +0530, Bhargav Raviprakash wrote:
> +static const struct tps6594_match_data match_data[] = {
> +	[TPS6594] = {TPS6594, &tps6594_i2c_regmap_config},
> +	[TPS6593] = {TPS6593, &tps6594_i2c_regmap_config},
> +	[LP8764] = {LP8764, &tps6594_i2c_regmap_config},
> +};
> +
>  static const struct of_device_id tps6594_i2c_of_match_table[] = {
> -	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
> -	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
> -	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
> +	{ .compatible = "ti,tps6594-q1", .data = (void *)&match_data[TPS6594], },
> +	{ .compatible = "ti,tps6593-q1", .data = (void *)&match_data[TPS6593], },
> +	{ .compatible = "ti,lp8764-q1",  .data = (void *)&match_data[LP8764], },

The casts are no longer required.  Same for tps6594_spi_of_match_table.

regards,
dan carpenter


