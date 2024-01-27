Return-Path: <linux-kernel+bounces-41019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE3083E9EF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5472B23D01
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EACBA30;
	Sat, 27 Jan 2024 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bd6hJAUn"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B5BA22
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706323367; cv=none; b=QKqZfDHFX1Aqfu7PZ4ADysv2dLew6RRZXkTeRLuaBYjwX9wejrNB+x66TzIecstECWwdQMg4RNysS37tzJyH4nadDau/YMD6Onwb/uG7m/XpKAxjTmTcp3xGvoMdtTh+/tA7fsD1XeJYB0vzjUNp55sjkCRpn6BUxrvbfmIyRG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706323367; c=relaxed/simple;
	bh=TnRkg9YGAMzV36PzYApm/o0Nz4O0TWszbHDaIw2yvJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqRxivoKBUOMpYSC7PR5SlgekjqLzCiqcKoLlz3riaDa0qliuTbojZA3UPHyEIFFkjzen8RxZfOuKrGR+UIKy2XSO+pUMrBE+huzHQr+cweYbenKFpc10xqgjSXBYT70+ZO43Oa6WiP8zCMV9LFyz1dNEFQ1ubUAqaLTHFRrnvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bd6hJAUn; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ff9adbf216so8320807b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706323364; x=1706928164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf45TsL/1FBpc+V5HKmqZ7dALipphhxtwIfGvzGgYB0=;
        b=bd6hJAUnRGvIKdCIzdDvoeg+h+kfjaOTHi+ig6VAcMMQzb7J8LDoFsnwqVhw/Hw6KI
         MiSodAVPB486QpCup7R0SJgbtwb9XHC8Jm0ceKyiT9zb7EhDOhpHSSZNV0MC0/iclIMQ
         Xe9tr3SXTIq9c8Y+YiSAE2IeIVcR1tmE3Nz++Tq7Tte3GbTQXGuyNhKwIIeUu3BM1Vx8
         n3zSBGnSi0ajp6T2aRZJ90AQDIycUDfyrgu3VUI9hSJXrJIS9eotwXWXkucg9ghF0+ij
         fGaCuI85y35BLj85jwza7eEJvYtmRyl73mv1k4QoFpYlxzoLdzV6C3nQLOa9JT2M8LET
         TrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706323364; x=1706928164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zf45TsL/1FBpc+V5HKmqZ7dALipphhxtwIfGvzGgYB0=;
        b=HQ7Y70el+iSAu5PEzlJjdJ3+dT9fk7PCuK3lEoNFoTDeozqa4PnvNKa7159NlqZiu+
         QvJn/gTM/wfszKxMkr8ryPHre81mszAKoRFRy5fEeFhDG6lIGt+yf20hxRjBNWA66MPX
         s5+isG1YYhbfdWRlINOw3SCClC0EBCu3U83iBzFRYsSsmcOx0hWSIMyqhntZ2zqzisfe
         K5vH05fl6dlLTixB8xBDCwvSRAdoEKVvNIJxzdn6p8oJDbSiyUJoxU5XeTBxaZVPZzSD
         VZD33YRcli7vVNubkmm46zxsowddPqIdu+bH0su3PlH2y10DeFoRJ+dbrt5OnNuZ4mPj
         6fBQ==
X-Gm-Message-State: AOJu0Yw6CxtjeHYyy144zPEoor8s2xcGawkwgYu/PaHYbc+PSLYvowLr
	AejxTunY3Lnku28xfAMg+pt8F/qHLbKJgdfe4U3o6LReXVCHPIccsxM9NHg8FDC0StddJSb5XSB
	1IWv0z3+WYqhQqvbY2i3FVhUd4CLvN1VoAeJpfw==
X-Google-Smtp-Source: AGHT+IHRZPdhgUs/BZGvmVBOvQRD+JgpezMtVZsrlzFangPEP9tjCbmnm9ccToRn0csAj1ZBk6Dz9HZ3cZhVHRwsFEo=
X-Received: by 2002:a81:7e08:0:b0:5f6:eb69:5e1e with SMTP id
 o8-20020a817e08000000b005f6eb695e1emr932145ywn.57.1706323364675; Fri, 26 Jan
 2024 18:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127001926.495769-1-andre.draszik@linaro.org> <20240127001926.495769-2-andre.draszik@linaro.org>
In-Reply-To: <20240127001926.495769-2-andre.draszik@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 20:42:32 -0600
Message-ID: <CAPLW+4mcTHyoX85pTCEkNf5ZonJm62NLSg7Q+wBKPrr1QV7hbQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] clk: samsung: gs-101: drop extra empty line
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, alim.akhtar@samsung.com, 
	s.nawrocki@samsung.com, tomasz.figa@gmail.com, cw00.choi@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:19=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> There is an extra empty line here which doesn't exist in any of the
> other cmu code blocks in this file.
>
> Drop it to align cmu_top with the rest of the file.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/clk/samsung/clk-gs101.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs=
101.c
> index 4a0520e825b6..27debbafdce4 100644
> --- a/drivers/clk/samsung/clk-gs101.c
> +++ b/drivers/clk/samsung/clk-gs101.c
> @@ -25,7 +25,6 @@
>  /* ---- CMU_TOP --------------------------------------------------------=
----- */
>
>  /* Register Offset definitions for CMU_TOP (0x1e080000) */
> -
>  #define PLL_LOCKTIME_PLL_SHARED0                       0x0000
>  #define PLL_LOCKTIME_PLL_SHARED1                       0x0004
>  #define PLL_LOCKTIME_PLL_SHARED2                       0x0008
> --
> 2.43.0.429.g432eaa2c6b-goog
>

