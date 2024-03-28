Return-Path: <linux-kernel+bounces-122839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F46088FE35
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1976F295836
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047DF7F464;
	Thu, 28 Mar 2024 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdAUr0hF"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4B7EF02
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625789; cv=none; b=bNsa7l3Pbv8VgDJ1aVm0vTZ8U0pSbnWdv3ZDw7OVCYio0g306th8KVZ/kXe/eSrwwqy5Bh/tF6KutPIQB8oZ6MYORvf+zP30EmbYOxiwqdQZUw/ChTtkdD5nFMzO0SbGaY4pkTajlXBkX0g7dw4+eUd/xVyrT2nXFOYG5ElOEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625789; c=relaxed/simple;
	bh=ilFiE9F2pbJK4CUMlqxrCeQ1cVjq7bZKPhWVwfSrj9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoJW4sqXWjpYHJkvtCBqqvDszTztrU3ibEBbkuYrxFmaWyHJgaL0kvneTqgM02NU1LeI13/oqpUWvduUl2l6XzNJGbxvMlBJZjDsbazaanLTWQ123kNiqONxzYXpS9EMf+NiNYN5+Tdt/uvLmoWiY/d9aw06pU0W9gJnItkA91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tdAUr0hF; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-690c43c5b5aso4481406d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711625786; x=1712230586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/prkjkwBayqxMQUYRG7IzJfpOCSd/2k5XXEN/lDQzgY=;
        b=tdAUr0hFkCKJHDI8qlWl6HmDvuVsRGRbk+cOnoNM0xtRJVUo8vnVMWnTq1YHS/Qnek
         0SKBtiPBIvk2jnoDiRajZAp/6IUnu9CLE613IGXZuuPOaYpdHRWnNlH2umhL+w4zUYeR
         npz7YouK6t2Us/FuWqUH4JeTDyyTPyyu9fxi4sOLpm4sZDsOAz33u8R9lFarj/qnwsg9
         yZh5EBQogMSxmQZt2kogAd40HzvtCo+ePt4wTd4CZqqh5FRx2VdqWv9gF3MPRzwuo8Up
         yVKUuDx+hgsuPaEr8FHyw76hUqhGOMgGsBITP+yTOJGJx+tZkb0IH+mAQGz5andLHwuG
         +YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711625786; x=1712230586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/prkjkwBayqxMQUYRG7IzJfpOCSd/2k5XXEN/lDQzgY=;
        b=IphJWT23v1G/Jexr2kB5Yn1WDwNzIpyPIWn2JkyPjOTUUlXq4gkWCf/AczksgH6jdp
         ejs4ThFgPkQb/E60Tb4U1XM6QP6MMxJnR11ZNoQGzADLVXjF+Ia4DXLQ4kz+lkmTk9O7
         iNwXayWkz02lyQLifSHF9N0/hNXYLuNAiNuy2nr1PepdPoK4nVrzEZ3iiPGBsWyoCALp
         Ry62n9tQwAuz79ap3rrJjuHqGWw2/aanXC6Ss4s/DZWmBuPH9UPPT9K01VyWtIJ7l6W7
         6md5aRUhgq/x/pPDl4+Tc1zuIMCV6CXZKJgkB/6DhQIwWu/Hs+venmhhMvt7JYHlII4a
         HQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGfRJWN6OQvvdgWwygXRqWIGRzzQMEd6v2UoZB4STYbS9+Xw0NQJXUWbPB8tE3vPpI/FG3DtFIG5kcy2FPqrA7M6Kp9XQfJZziItsQ
X-Gm-Message-State: AOJu0Yxhi075OBWBmLjBuRynOXHc04zhmCeNqxmZU/6zvcc+qDYvZF5S
	16qaHuKN7qPFpTR0O3fRRhTP4dbEo00AsTq/DJHCbfnAAjt70mhTXMH1a8G635m33P8gR3Mt0NN
	6omm2kl4ntWOjtFZ/emh7eLwTuaO9KImzSNMJOw==
X-Google-Smtp-Source: AGHT+IECGMP91OnvJpnEQBoQ4ZvbqvFkvhcH6wJdMgASlS9vR/dFRa/h/ehJAtH5CkKObHpqEYR5kJ/+W/XF3z8Eh9c=
X-Received: by 2002:a05:6214:14a3:b0:696:3704:712c with SMTP id
 bo3-20020a05621414a300b006963704712cmr1853382qvb.63.1711625786555; Thu, 28
 Mar 2024 04:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326172813.801470-1-tudor.ambarus@linaro.org> <20240326172813.801470-4-tudor.ambarus@linaro.org>
In-Reply-To: <20240326172813.801470-4-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 28 Mar 2024 11:36:15 +0000
Message-ID: <CADrjBPpjK15MDTcSdOhiC6FnJcofDGArEvrkhdz+CHoFzpFheA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] clk: samsung: gs101: propagate PERIC0 USI SPI
 clock rate
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	willmcvicker@google.com, kernel-team@android.com, s.nawrocki@samsung.com, 
	cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
	semen.protsenko@linaro.org, linux-clk@vger.kernel.org, 
	jaewon02.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

On Tue, 26 Mar 2024 at 17:28, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> When SPI transfer is being prepared, the spi-s3c64xx driver will call
> clk_set_rate() to change the rate of SPI source clock (IPCLK). But IPCLK
> is a gate (leaf) clock, so it must propagate the rate change up the
> clock tree, so that corresponding MUX/DIV clocks can actually change
> their values. Add CLK_SET_RATE_PARENT flag to corresponding clocks for
> all USI instances in GS101 PERIC0: USI{1-8, 14}. This change involves the
> following clocks:
>
> PERIC0 USI*:
>
>     Clock                              Div range    MUX Selection
>     -------------------------------------------------------------------
>     gout_peric0_peric0_top0_ipclk_*    -            -
>     dout_peric0_usi*_usi               /1..16       -
>     mout_peric0_usi*_usi_user          -            {24.5 MHz, 400 MHz}
>
> With input clock of 400 MHz this scheme provides the following IPCLK
> rate range, for each USI block:
>
>     PERIC0 USI*:       1.5 MHz ... 400 MHz
>
> Accounting for internal /4 divider in SPI blocks, and because the max
> SPI frequency is limited at 50 MHz, it gives us next SPI SCK rates:
>
>     PERIC0 USI_SPI*:   384 KHz ... 49.9 MHz
>
> Which shall be fine for the applications of the SPI bus.
>
> Note that with this we allow the reparenting of the MUX_USIx clocks to
> OSCCLK. Each instance of the USI IP has its own MUX_USI clock, thus the
> reparenting of a MUX_USI clock corresponds to a single instance of the
> USI IP. The datasheet mentions OSCCLK just in the low-power mode
> context, but the downstream driver reparents too the MUX_USI clocks to
> OSCCLK. Follow the downstream driver and do the same.
>
> Fixes: 893f133a040b ("clk: samsung: gs101: add support for cmu_peric0")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter

