Return-Path: <linux-kernel+bounces-94109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA24873A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9856D288F83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2C1350CA;
	Wed,  6 Mar 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GACM9Jef"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA34DA1B;
	Wed,  6 Mar 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737504; cv=none; b=svFjOc3JZPELSsDhsEJ1vhLeqcRn2+7WLbEa6TDCF/PQfYCTVy0bR+jAZALYrLi0FdP2cUg284sbvGQN41GWD9ZoGegiyW8IY6yS3pqtW1cxLrwdm0SxsbczAKs0Gt54J1v82aRuJ0K6v1gvYluCcEehKWLerMZAHh9GjzEYfsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737504; c=relaxed/simple;
	bh=43GXM3Q8D5bmb35Ep8tlcjDpUea4lF28uw+na04zbs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0NQQ1Dr79QY6fhVtLqcTEUByxt/u4EZ/xKCG+kl0L+WFrWPDtdu6EiMIZ3opD9zPLjmQf+iEhF9Jabs0OpcesTu1HHUH/+9jxFBAqoghpQwd083yJO5d0TGIGMdHixgyzP5OiuIuMHD33Xwz84l/humotdmoj26pPSPdR61C7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GACM9Jef; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d27fef509eso15026861fa.3;
        Wed, 06 Mar 2024 07:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709737500; x=1710342300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43GXM3Q8D5bmb35Ep8tlcjDpUea4lF28uw+na04zbs4=;
        b=GACM9Jeff0j7GoLB4xVUPVP+86w0aLRcXzamDygWt27SsIl1TzR+xOiEeWxfQeKNmm
         0jwKEunR8h+uaeVosAhnlve9v1vlBnMxbsg8FeXu1rXlwWrTQmQ7xFfw5C355kqlk5mH
         ddVQI485gtMYGEDRc7E4fE+0Uv6+X+rEckNk9LfjYnvF8a65d8q6rWHW3U+cFQ2SWUbE
         BjjQx3o510VzRDiHkYPRJt+h94O6JH3/yQ8SkEtcnLL/FMK8btmYP9Vxcil95ojs+Xfa
         VDUIk8mfv2YY9ePNVgRjNPbWG4oCbeR6hbRnOleAaY+1gEXfT7Vretr7iOMT9/9HCjEM
         oVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737500; x=1710342300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43GXM3Q8D5bmb35Ep8tlcjDpUea4lF28uw+na04zbs4=;
        b=bJq0m54zMDAMTU+Giw3PxPSjMaPvKAT6pxxxg9IP8Q4JaEPZsev40gbCSkqNFsGP8g
         Eqtng9Cbfsz86mxXeYooC+8KPFJft2EDCGNSXjn+KUruh5lUpI8Cu0swzeU0rUmkLnp4
         XVlV/LMjf6kiegYHS0AKXZf8Op8xu0CSODL+di3MPEJwHjwVF/ekr/HT2M4Q8xaDgA0y
         tg7tqT/QLAw4wkS4pXvUFVBlGl23j6P1QS2xEoEHkslb74ge9NvwgkRXQ4cRAvSdL6Rb
         qzNHWNck2eW9u0EKKwlioQQQlBvcRyc26V8gwhtzVqxXwS7ll2wAVrF/T1fvZ23o0OHl
         Ullg==
X-Forwarded-Encrypted: i=1; AJvYcCUPANWaJgCnPprfA9BM6FUlZ0y9AoR3Q4mlFtyvLKkGt/Iym5O0KpeF/35H8e7mP/onWsPBlTZDAb28Vz/sCSsAA4hLf2cjCcv6FRnlAc2Ticqhequ2LCn2TzyFOeH2a+35QfToWuTewYkFru/edWo2dYkGky9RteVM/5IDFKr/0m/43A==
X-Gm-Message-State: AOJu0YzN3C74m7h5pwVwjHi0zJrmYfxAKra77fZKTTtjCNQI49B5waNN
	uaUCbPgOiP0VBcaO8DA/dH1ELRb8mIYBFxLNdZ12utMzpJAjFnxzlkZjkzJ+Spa5G0NofMkqpok
	7l9N7/oiviYD5D8e4MVD7IARfZvA=
X-Google-Smtp-Source: AGHT+IEEVeDiNEpHKSHTjKvhESMzneWqkwWwVGe8WoB74soHvGsOkOKPL5fYMktXsrfWue5FRmqbdFaGULj6kEl+Zug=
X-Received: by 2002:a2e:a99f:0:b0:2d3:87b:7e9e with SMTP id
 x31-20020a2ea99f000000b002d3087b7e9emr4317395ljq.39.1709737500066; Wed, 06
 Mar 2024 07:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304-pinephone-pll-fixes-v3-0-94ab828f269a@oltmanns.dev> <20240304-pinephone-pll-fixes-v3-5-94ab828f269a@oltmanns.dev>
In-Reply-To: <20240304-pinephone-pll-fixes-v3-5-94ab828f269a@oltmanns.dev>
From: Erico Nunes <nunes.erico@gmail.com>
Date: Wed, 6 Mar 2024 16:04:47 +0100
Message-ID: <CAK4VdL0zWRg4hzUbuZsnabU53x3DrOiemH0tGnpbK9ECQvM1qg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: allwinner: a64: Run GPU at 432 MHz
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
	Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 6:01=E2=80=AFPM Frank Oltmanns <frank@oltmanns.dev> =
wrote:
>
> The Allwinner A64's GPU has currently three operating points. However,
> the BSP runs the GPU fixed at 432 MHz. In addition, at least one of the
> devices using that SoC - the pinephone - shows unstabilities (see link)
> that can be circumvented by running the GPU at a fixed rate.
>
> Therefore, remove the other two operating points from the GPU OPP table,
> so that the GPU runs at a fixed rate of 432 MHz.

In addition to all of this, the A64 user manual does say explicitly
that "dynamic frequency scaling is not supported" on PLL_GPU. So I
think this is really needed for a reliable GPU experience on A64.

Acked-by: Erico Nunes <nunes.erico@gmail.com>

Thanks

Erico

