Return-Path: <linux-kernel+bounces-160854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A15DD8B4392
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B51B283EDB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDB383A1;
	Sat, 27 Apr 2024 01:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mcFOAAIL"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1018488
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714182286; cv=none; b=DViyq9XOkDMP7jJOZx5rIRU9RcICOXxVgdeiTAaI9uSC4emiII7JixXpzcStZ5JkzVoPaM5Mlu4X8eQt8jlmJ5p9bo8oTDnfUDVUTwAXpj8TRxFAGwrPi8zVu95cleS6VqZqbSPHzjTxGaP4QZDH2XbwuaAtAKgOvqSfMYT4Nn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714182286; c=relaxed/simple;
	bh=J/kY/h0yhbemgzQevQoopMuCLmz3jZt1PDqS5csOeOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfzMRgshIw53OV8cmquebOzJHBCVR/wJxoOuf746ocVPmo4gQ6BQaF44se0n7o4gVBp3kDTa435zWVhTcTFr2ylcpoIdmd5Y01POTt3BKYe1G/2qUmQ1sxhdZIvOl0l0JylJmioThepI6XjUcVcfUgXQ4LOWew02vFpIcUmfws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mcFOAAIL; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de46b113a5dso2974822276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714182284; x=1714787084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QGCg4Zu+ZV3ocI1mnZ5+/Ant+yZ7/OtI/o1sSvTL4HM=;
        b=mcFOAAILZUunyYOKuFt/cAJChqSl8yRe5klNosuPAm7aFd9RsxS9ywibAgR4UwUus+
         P7CwRViRZTCfaTYWuwiXm7sqThDf/fS01jQfPNHg8ghXiQRRqqY5oHKhXfoYPATg3WTH
         liShh+Mgj2X2jvo/XIMIxq9tPjjugPJaLGUc0hmD1Eubf5Vp0KkfP4P/efsmsAlW0Hgt
         vc1QVNsE32rQXAPNG5ZufNrNoevZOuEx48J5DJ3yVcl+FOMMjw9dVo00istp9WeJUFn0
         COpN00IjDFW2dOzc+Qq3mtcOB4BY+Hery2nbNEK6OZpdm8MaZjFNK7/x/+UFA3ZZupdF
         +YiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714182284; x=1714787084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGCg4Zu+ZV3ocI1mnZ5+/Ant+yZ7/OtI/o1sSvTL4HM=;
        b=hykk+4IqaLKYH5yjQ+sSmh1tftqzPHA3H4NRxsyuxf/HqzGjkLi7PCfkt8MDAJHdvm
         P+qW/G2QsdrZG7NkQcFlw47LQ78HzkOFqNttMjh5hhNQMDN2CoWuQu2Dh1bq4IC7Fqkw
         fsGbow4ANS95dDMOlWkKT32RTihQzY2h1XD1kGkaz62OTVXlzrG6CLY5SI4ruocaMwdK
         hLcPB7ABxiyCNhOjM7wZloLIV+5iPUJDY0VyskE8LLrEQ+kgjv3Vi/6lxKUJKPAZnPLE
         b7bAVMxnXsC+Tu7MQqW2KfoGAnmXukcS8NSEkyDs3T/b2aqdOI5mdGmVgcHs0/MvknS+
         RviA==
X-Forwarded-Encrypted: i=1; AJvYcCVCaGy51Zy7PLaFRyF7WXJ23V5ZX7z49X//2iOvtPAc/YjJn/ltGFERrHXregbxGn9TDX/EkxVXuaRB0U8tkJPLlHmBaa1fXvGqbV8f
X-Gm-Message-State: AOJu0Yw8P0Km/Xgb+99KRYa1QypK2n+MbB5qqruZiu2mh675DuzPbdIQ
	teVDxdcI+BhC5K66KuMBo3VKgapECUM4f4lZoVchtEdI+zMkAZjY1kgn96alYC76BfwUfJrG+n1
	ejLDD99gojeCY3sg8rd0GsxINA4RsSZpcQAf1cA==
X-Google-Smtp-Source: AGHT+IG1A0M8caFGulGcx2R5Fp59/NY4nN7r8y1wfNgBJA6VQ6kPux0p8Muei5EVBn19NOuDzqIElo1na2AKOn3EzLM=
X-Received: by 2002:a05:6902:1024:b0:dd1:48c9:53f3 with SMTP id
 x4-20020a056902102400b00dd148c953f3mr5689733ybt.60.1714182284249; Fri, 26 Apr
 2024 18:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426235857.3870424-1-dianders@chromium.org> <20240426165839.v2.1.I30fa4c8348ea316c886ef8a522a52fed617f930d@changeid>
In-Reply-To: <20240426165839.v2.1.I30fa4c8348ea316c886ef8a522a52fed617f930d@changeid>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 27 Apr 2024 04:44:33 +0300
Message-ID: <CAA8EJpog5yn5kiabJOZRipTx--onH9cepPe0dD4nA=Hm0aZS+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Linus Walleij <linus.walleij@linaro.org>, 
	lvzhaoxiong@huaqin.corp-partner.google.com, 
	Jani Nikula <jani.nikula@linux.intel.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Joel Selvaraj <jo@jsfamily.in>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Apr 2024 at 02:59, Douglas Anderson <dianders@chromium.org> wrote:
>
> The mipi_dsi_dcs_write_seq() macro makes a call to
> mipi_dsi_dcs_write_buffer() which returns a type ssize_t. The macro
> then stores it in an int and checks to see if it's negative. This
> could theoretically be a problem if "ssize_t" is larger than "int".
>
> To see the issue, imagine that "ssize_t" is 32-bits and "int" is
> 16-bits, you could see a problem if there was some code out there that
> looked like:
>
>   mipi_dsi_dcs_write_seq(dsi, cmd, <32767 bytes as arguments>);
>
> ...since we'd get back that 32768 bytes were transferred and 32768
> stored in a 16-bit int would look negative.
>
> Though there are no callsites where we'd actually hit this (even if
> "int" was only 16-bit), it's cleaner to make the types match so let's
> fix it.
>
> Fixes: 2a9e9daf7523 ("drm/mipi-dsi: Introduce mipi_dsi_dcs_write_seq macro")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - New
>
>  include/drm/drm_mipi_dsi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 82b1cc434ea3..b3576be22bfa 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -337,12 +337,12 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
>         do {                                                               \
>                 static const u8 d[] = { cmd, seq };                        \
>                 struct device *dev = &dsi->dev;                            \
> -               int ret;                                                   \
> +               ssize_t ret;                                               \
>                 ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));    \
>                 if (ret < 0) {                                             \
>                         dev_err_ratelimited(                               \
>                                 dev, "sending command %#02x failed: %d\n", \
> -                               cmd, ret);                                 \
> +                               cmd, (int)ret);                            \

Please consider using %zd instead

>                         return ret;                                        \
>                 }                                                          \
>         } while (0)
> --
> 2.44.0.769.g3c40516874-goog
>


-- 
With best wishes
Dmitry

