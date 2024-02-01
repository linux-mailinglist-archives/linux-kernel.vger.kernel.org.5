Return-Path: <linux-kernel+bounces-47976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4541E845593
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC42D287468
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2C615CD6B;
	Thu,  1 Feb 2024 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yh8Ofelf"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521DB15B991
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783804; cv=none; b=WEY6WjWP0g3cLL7SZHJ6ZLicxOrzGeYxauSoXtcTnYBNFz63jOUfbQe3r4PUDVuTCc6bifpt1zISmzj1c8zdg1wMe93uaoKOQSu/lnx8F3B4gnAVuwY4rrvrA05I8wWk5mxh1Jg58z8WQ/STUQBzjBdTu2If7PmAC4d+osfX8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783804; c=relaxed/simple;
	bh=qgxGtqz0Hm8lEhfsyYOFZ9uLr5Gy8MYtN5ATEsQTVzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eisIRsJq8bE0whN5nXZfMSj5Nd1i4AZhj8ZfiQWiF9XqWfVxG+RRY16kbW3TetKhJBf+3ffk1Uy8RkahF+h5LAIXWqEhM5Mwrcwm8frTtZXSIcWmXyQKjGgUY35HGmsfPl3p29/QFjHcU8O7Wo8kcCjkhK+aJ7aZul2biBP/6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yh8Ofelf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3510d79ae9so89255466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 02:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706783800; x=1707388600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELqpTZvLgMMzm02/IMeIQHM4yd50odkFSFWfS3rIHB8=;
        b=Yh8OfelfyjqLUJiInJH87wphodH2rFuwk0fTEWUGNMCVSo2yFVn9fM5nkapWiPkWew
         BEZw3WYOZG9BggtEeZPzPRoGRyCPsWuvESURIZGj2yf5ILH+zMneQA71vyoByMRICVBF
         SVrKm6NvwJKhgBQXTJxs2DF9+x35vcMmezqfeKdVJE6IDpy7IeK3Bh46lJSsck62BWCu
         riNKUtO1cVVbWoTR927seDAv8EQcQwmStUC2piJuJCRKVx2fD/+GSTALXkdi1+UN1LmM
         Tq/o7xWpow4S6uUpDD3RgxEs3WBpd6eXyGDLHC11N6WiK7HntSxLTlOkX2fLpznfw918
         vlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706783800; x=1707388600;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELqpTZvLgMMzm02/IMeIQHM4yd50odkFSFWfS3rIHB8=;
        b=ekhfP9H8GU3Q0EiSiSYz8EcNxHc0lKOAdigz2+yAOlR6tD1d2/vgqJy8e+fe/lNmnD
         NTi8rf0iLRM/AXrmYxHSNV43U+/1paz9HdGcG/+Zf6aQ0AdDvYBL5rIogDUqMvAud688
         LLi7yb4lDZD2DCvjL66DCtVY8fMO2l4lJ6p1O24qu8j0xl4+vWPpu10xdnMHWpW4C0ap
         6AN2na3weXYjSNI7YKfQxtPy5cPOFjHDotEsvSVxTog6jXFOK4wS0gkxgi71Z+MXZL7m
         d8Pv4Ab1H4w6qWXybb+FjdodSeLt/8I7RTtrFoiJuwnnIBxb/C9MVyAL2AtNuF9zOaRF
         BEWg==
X-Gm-Message-State: AOJu0YxlG+DDVXxlBVto50O7E4lHYuU2NpOrkWu58zdvp9xN8aSmAteI
	+GvEKJZa/ZruD/AC1mjf2uopM3oQjIzpNmHowKGJNRpuMRAgOal1BLIMjVEQOI0=
X-Google-Smtp-Source: AGHT+IG51xzHVAwchknDXRBtyIfXiaNx3yhCsqxzIRo2AHV2f7ixQ6e7ZDydPbZDY8bN3iL8mvK8+w==
X-Received: by 2002:a17:906:e2cd:b0:a2c:5139:8b11 with SMTP id gr13-20020a170906e2cd00b00a2c51398b11mr3336749ejb.56.1706783800692;
        Thu, 01 Feb 2024 02:36:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWmc9aGbJwGUYavUlRyMX9smG3xrl896IawCZCtAOTT5UuQQXkuBD41PHVIXBbT8uW9fvjz/KaDJXE2x94kOE415xUE0y6g0/MCYwp7fN/PFCDp39uHr2P8giHMLydukrFG8xEWOKlnu7GZqShsAdRJEukR/hpFXSLuVbEZ7ztWCfMWa1OeBGmcG42jXAxDMerKDHTPo24xhucyZmfinM5aHTTwP+wZ8DTiHbrd8urlSE+nWjZaWkrcl/GJilx9nRfH9EiPHbrE4aDbR5aQZfiN8aGm9e9uvMkem+nxGh4B29HLpMoe9VRUtooFzf+6TUSlbqQjLm5TYLNbNPRd34vpRMZKoadNL+E5hY4l8/VQ1atvR+4kt6Pz+X0SLkAwE9J/X559QjvurlSL7xKjKul+ff44eKfEJbF/yGMoochVwnHon8ISkQTlqjEHQdw6Yc9nw00Y1qwQ38pfztASo4sUTO9DdVzSrlh4O9D3ODEAnI5nI/3IdRA/bGHjoksV8PraE+pOHRqy4J6F06cXcLmdychwPzfzwHZZyawAFMY7TLGVSh3N6yQWQLlBeuCSoXUpmGAWtgVvYIBM2Ai1sMLf83ziqPzAzW6rfJsVpjbYzdy3IxbRPowrSBHdYvz9P2qwSTdQUXq7P53KxeCtLyckBYIJxEtnKPMMN1U2svdvOrLODg1Xeg==
Received: from [127.0.1.1] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ty5-20020a170907c70500b00a35a8571419sm4552308ejc.135.2024.02.01.02.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 02:36:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
 tudor.ambarus@linaro.org, willmcvicker@google.com, 
 semen.protsenko@linaro.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com, 
 tomasz.figa@gmail.com, cw00.choi@samsung.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240130093812.1746512-2-andre.draszik@linaro.org>
References: <20240130093812.1746512-1-andre.draszik@linaro.org>
 <20240130093812.1746512-2-andre.draszik@linaro.org>
Subject: Re: (subset) [PATCH v2 1/6] clk: samsung: gs101: gpio_peric0_pclk
 needs to be kept on
Message-Id: <170678379863.179994.10165116011101753606.b4-ty@linaro.org>
Date: Thu, 01 Feb 2024 11:36:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4


On Tue, 30 Jan 2024 09:36:40 +0000, André Draszik wrote:
> This pclk clock is required any time we access the pinctrl registers of
> this block.
> 
> Since pinctrl-samsung doesn't support a clock at the moment, we just
> keep the kernel from disabling it at boot, until we have an update for
> pinctrl-samsung to handle this required clock, at which point we'll be
> able to drop the flag again.
> 
> [...]

Applied, thanks!

[1/6] clk: samsung: gs101: gpio_peric0_pclk needs to be kept on
      https://git.kernel.org/krzk/linux/c/8a96d2701f7c794e45102a9cc7fc4a5c4951e699

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


