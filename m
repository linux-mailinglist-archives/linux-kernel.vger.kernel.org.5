Return-Path: <linux-kernel+bounces-152941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A578AC661
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71468283387
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8175D53803;
	Mon, 22 Apr 2024 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rNa/imUB"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92C535D4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773366; cv=none; b=NdTOdBqgOpOTJKjq+v0hBuUGOEw79OawFGozFUIbNXdUNFRtlzbbu6b8d54UXMeyLY07IYXM2m28SsG8v3B92MJjf6LjAnpLFoPdnEx8FHX/yFeiPmi+9hEB1CzSgK+8g+cay4hgpIbxX+lc6kjyh8KD8L0LGmUcx8Hn9bPh7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773366; c=relaxed/simple;
	bh=YIO8cDM25qQNZ4cv/ubwGqUQhUGYfoqZi8Ig4uTr/Sk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=cOtWL9Aj3Fc0EKr2a3irQuJDLOQKRlFqdoIXmHa7PdBwf6s58C4iQ90+Ip7WnqJU+JGblZ0WQ2aCeudt0vtLxI8FQiifAvKnpy8++bUF36YvcnL0hxXkx3hlSN2nxEp7s1VpHe6TmvzbfNMK5226KtBT+VzSs67vVcIdupZjcwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rNa/imUB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41a70466b77so2556625e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713773363; x=1714378163; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=G8Z1W9cBwZwFr+xw5xhgBlfEeDfYZ9v69oNkjrxgbOY=;
        b=rNa/imUBVTrJ1RpiBMNOyDhyno+kdSij38C3WhN3YthESsBc7q1ejUCThwaSIyEA8M
         3jxxiiKSuHzbzLHrqIOJJWAY+GLZYruemAFPOpjojPSRZzliDUjTqOrWJLl14cPyHePk
         y0zxyyM1eq32qzYzgTXxTGfF2twiTDgwY68ri5ImEmreWgaT+FqnLfwRUBtQhFVoteLE
         PfsH33517L17ISJl/wFOZx34R/HuhIERhKKF2NZb2Kn3NmQnlo9ibqdVcQtqVObrLyqU
         RjkCJQ7RKfbUgNRsCvh2Jyn3xx0e7g8U8nQJzXTy7sNFmKOgbWWf6elrzMGf8PupZge/
         69Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773363; x=1714378163;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8Z1W9cBwZwFr+xw5xhgBlfEeDfYZ9v69oNkjrxgbOY=;
        b=Wd0nLNFphEluQI3Uideh57aD7Z7VX1SPrfolhMrIpS2p/sILjdLeInrWViVvaOVT89
         bWB7ubukSxamKUBosu9+svrWU0227EwUrya5+1dEHkX0bbe9vVOzzpbD+Gvv6c3rxMVh
         0WFcf+E/oP+dwWWtIALTrOwFBkpAXrYaLYlOPAktQ8+oMozD3EX8Qpcvv/Lxw6LU0qhR
         7OAJbBVjRk1SwpqFRFA1pj2uhMBwARpY1mjbHeRSTg0Rt/ZbQUoc/6BtvkiuzqAqOvQJ
         F2WS86NkdmYhZate0+RG8ibt2DKdf/eV5AirJ1qJVT2mQ2DaRtbGPHAGZ5MOTQQvVxYo
         eOKw==
X-Forwarded-Encrypted: i=1; AJvYcCW/O688rFzlnAXkd99wL/TCcgTo2mbS4CLTOAUhTkyW3FBX3mdI0r/TVliWqo53SfQiZ06oc84YGs5xJSD8m+IQ9ZHR058MO08Is9Vz
X-Gm-Message-State: AOJu0YxvTZm+MVw1ZAeWv/CHOXIO3A2VPTXSbou8ZKAzF1a2eY9J/c/p
	ZtcQFmBPdu3aDCIurlFsxC85TvjeXUZGE4LCWirUgHPjeu7qVSXpE7wlb5yjX8I=
X-Google-Smtp-Source: AGHT+IFcBHuQrYYsaNLbUg30qmwUhwRzvle0l0p4jwsnHIaO8PpRDz4ckky8oOJr2gRpkpQzb3NY4A==
X-Received: by 2002:a05:600c:3587:b0:419:5c4:b430 with SMTP id p7-20020a05600c358700b0041905c4b430mr8846265wmq.14.1713773363290;
        Mon, 22 Apr 2024 01:09:23 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a619:ccb0:5f40:262c])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d6445000000b0034659d971a6sm11274074wrw.26.2024.04.22.01.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:09:22 -0700 (PDT)
References: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
 <20240419125812.983409-4-jan.dakinevich@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
 <jbrunet@baylibre.com>, Michael  Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob  Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor  Dooley <conor+dt@kernel.org>, Kevin
 Hilman <khilman@baylibre.com>, Martin  Blumenstingl
 <martin.blumenstingl@googlemail.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v3 3/6] clk: meson: axg: introduce AUD_MUX_TABLE()
 helper macro
Date: Mon, 22 Apr 2024 10:09:04 +0200
In-reply-to: <20240419125812.983409-4-jan.dakinevich@salutedevices.com>
Message-ID: <1jv849akel.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Fri 19 Apr 2024 at 15:58, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

> This macro takes into account ->table property of
> 'struct clk_regmap_mux_data'.

Useless if the interface of controller is fixed.

>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  drivers/clk/meson/meson-audio.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/meson-audio.h b/drivers/clk/meson/meson-audio.h
> index cbcdbd487d4a..1947c6cbf233 100644
> --- a/drivers/clk/meson/meson-audio.h
> +++ b/drivers/clk/meson/meson-audio.h
> @@ -17,9 +17,11 @@
>  	},								\
>  }
>  
> -#define AUD_MUX(_name, _reg, _mask, _shift, _dflags, _pdata, _iflags) {	\
> +#define AUD_MUX_TABLE(_name, _reg, _table, _mask, _shift, _dflags,	\
> +		      _pdata, _iflags) {				\
>  	.data = &(struct clk_regmap_mux_data){				\
>  		.offset = (_reg),					\
> +		.table = (_table),					\
>  		.mask = (_mask),					\
>  		.shift = (_shift),					\
>  		.flags = (_dflags),					\
> @@ -33,6 +35,10 @@
>  	},								\
>  }
>  
> +#define AUD_MUX(_name, _reg, _mask, _shift, _dflags, _pdata, _iflags)	\
> +	AUD_MUX_TABLE(_name, (_reg), NULL, (_mask), (_shift),		\
> +		      (_dflags), (_pdata), (_iflags))
> +
>  #define AUD_DIV(_name, _reg, _shift, _width, _dflags, _pname, _iflags) { \
>  	.data = &(struct clk_regmap_div_data){				\
>  		.offset = (_reg),					\


-- 
Jerome

