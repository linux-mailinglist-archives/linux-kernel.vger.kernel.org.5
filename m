Return-Path: <linux-kernel+bounces-52905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF6E849E16
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB91C22260
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575E92C860;
	Mon,  5 Feb 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVRpipaJ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833A3CF71
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146823; cv=none; b=F4wBaWZJE9t9ib2S8Tl8pgzt9UyWZ8Ax5CByJLCAAgXnFFf7p9/n88vQdckRBBtYL3vSsG7T6L5ydXxTySSce3Ihe0CXHr0sll/l5P+mT5ZyqcZdhF6H5e7gr1EabVwEwTOU3c42nVhkquZ4sCgju8Ve6v66VyMsyZzG0dIUZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146823; c=relaxed/simple;
	bh=lBmyhHAc/b/ds7tFylLz6RFQYMZo8mpB75YF921Oy48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTZS+0fhRE8y5g/R7PzKRnSaVJkSTBP56DydP7J9bEs6BewwV3A+2rm3yOv2BUiETMnRyQKiViuunRIM1gqELbVJ37U2DZ96zfjFLYa3gvFeSfiEbVUCiLi9aCNvgS6iYVQsa2KoWuzJtf1vGr+itXMtLAkMtaijdoGpS274pck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RVRpipaJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55ff4dbe6a8so3674821a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707146820; x=1707751620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lBmyhHAc/b/ds7tFylLz6RFQYMZo8mpB75YF921Oy48=;
        b=RVRpipaJBXzjc9qFH9fw8jISSQzJ9dwDCTzoSW2Gj/Fah07NNfrIwLQO5/sv3Z4paH
         o5fuW9ySFbVO5iGfF42uGkp+GVYEY6otdUBcgQK3bqkANYo+NkuWRsYnw6XLvPo4hEqd
         LHFPGpn8Ar8ZiHWxuMqw2/O/7YDJZ6GmwxFROH1sgShoynB2XIY897jPb8O6r1j37bFj
         c8EyirQrJ/CR35DGm3WQOMKyyuh5TpdXbYt8WvpDGC+e9Ug4fhGqokqoMcV7tbLzaO47
         QEdQQUAcdwQCA02DyJEc4vwULptmOPQ9wvIFVC+9wHEf7gJ3b8BlO06cgqNLDIJqYnA6
         BT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146820; x=1707751620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBmyhHAc/b/ds7tFylLz6RFQYMZo8mpB75YF921Oy48=;
        b=PtFIiU2dJA5bCUIGrmbW5Avu7as59RXgfxRhWIOU5QdhOosEZXNdxIbrEzbZxMmm58
         wFZknbiLKP+kd2AkNSf3Wums8l8w8SK3vjEICdMs2EZUZP0OAytoW0LSTArOoRsSdWXF
         NZO8kf3u+jbh/rZiHOyEgkPs94rVfFts6REZjXRpzS79wSapolmmxV4i1Qk9LGKj7Bgx
         smSfAPCxH6oYc8dKM3LiY6KPiyMty8e7kqDE4WvleknCu6OV3sRPzQQcbGotM7mTZdQn
         oPiMKFzzmjkxHK8Xg1UBWw9l79Oi6DzKOh82dCIw0LbSMhj1jT6/+exE4ScOftCSEU5N
         SPVQ==
X-Gm-Message-State: AOJu0YxNog3gBIZbSHltvwaIE6WPSC0ZQkgbyAASY7Mh8eClXVNJmc/p
	tmqvx+KmHtxsBa3rGIy21P/kzSNeXSqvWsa7WxcCZIyUNH1QgBDdiN6pLqvDwsjBz/7unOqWign
	xgc5k2f13SpRAR67UdTQkPqzdccBEdodVqUl8+8CJAUUUJrcyRkE=
X-Google-Smtp-Source: AGHT+IFQoasCqxFOs1K52ZI+x/XzUUqCmUS+VdtJeXp3SaImGzfi0s4W0syhmRtpTA5yDxCp/YQX6n0921f0iNYwxv8=
X-Received: by 2002:aa7:d314:0:b0:55f:3975:209c with SMTP id
 p20-20020aa7d314000000b0055f3975209cmr4541024edq.18.1707146820112; Mon, 05
 Feb 2024 07:27:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205124513.447875-1-tudor.ambarus@linaro.org> <20240205124513.447875-4-tudor.ambarus@linaro.org>
In-Reply-To: <20240205124513.447875-4-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 5 Feb 2024 15:26:48 +0000
Message-ID: <CADrjBPoBj_TKFJnBDJ8gMgj3PwjBT=g8sy_LhXnJFUTutuMKNA@mail.gmail.com>
Subject: Re: [PATCH v4 03/16] spi: s3c64xx: avoid possible negative array index
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 12:45, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> The platform id is used as an index into the fifo_lvl_mask array.
> Platforms can come with a negative device ID, PLATFORM_DEVID_NONE (-1),
> thus we risked a negative array index. Catch such cases and fail to
> probe.
>
> Fixes: 2b90807549e5 ("spi: s3c64xx: add device tree support")
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

