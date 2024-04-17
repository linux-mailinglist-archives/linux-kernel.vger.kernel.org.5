Return-Path: <linux-kernel+bounces-148164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDB68A7E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0792823A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7DC128372;
	Wed, 17 Apr 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anB29Elb"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2016BB21
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343491; cv=none; b=ZsKehGefjVNlv4Mm2SUArkDWbn7KnkpTAKTL9kYQ910DNwT+/1NG0eeNcbw4pd3Wh61SXEXn8tbvXIl1Mmdo4IhvDp2vA4WbJWA19N9M0zJAjbobC78s3oMQKsRaTkhEtC7ymV4LyLWaF+acX66U704L/l5bg/uNZkn/USi/3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343491; c=relaxed/simple;
	bh=62qdf0MjfZ9+olO2ON2tKhaWuTwZqvJ4hVI3GsU0ZsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyUGq553YOhl2fA0Vf181XRNlGmJOVjtq8I22ZtqW/4Zd9N6Uz5nknfxvie5BBGGiLsJ7gCfwt5Ae8nRvEnwMpPdRbYyflLRh4GsVWTDh7FoGkRL5poldsrhBxgSESRoMcng35F6xTfJntyJcwUuZLeOQtXyoV/e3NUK0WZY2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=anB29Elb; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso3522921276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713343488; x=1713948288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUPDHuJgbEhcxGrf9RO0YvQKRqZaKvY08c3XMxThMtg=;
        b=anB29ElbwgCn2H+zjD63i8KMz5CG+MJcqx6grJL4b7kC7Ojn+WmV2O5rlbHZscUJ4C
         s4fMyU1+lyzoIHAMRNIQhT0dqNy3v0pr1wprRF6hm0FXxCwBKmk27gT2UP4UFmlSQFVU
         hRYfjO8iOKykuRYUQCBDQ29KrNF+dehHUmmzXj249X9sBaQJSqmuBNR0QP4vlXvaMe81
         hdy0dyyI0YEyXkv2Xmj3R6LjQjFM9u9xcHLRCaZ3/fEkBNWaszyGC/mQkwId8VZg2sRu
         0ollAv6zl7qEXssBBV3g5N7kFTRHg1stBH0Bab6EGck1br3f1GMaavnETGbyu01fuqwN
         O4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343488; x=1713948288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUPDHuJgbEhcxGrf9RO0YvQKRqZaKvY08c3XMxThMtg=;
        b=EzXrRxkbI2Stz9klWfdJSLQAMuUEKLzUW/+UXLgunozfNsHSjvSLlPaW6SftIoOsHd
         OhrnAqnpz0tXPcKZJ46+s2mfRkA5POSYmQUC86CLiL50q2PTCVx2/hzDjm+SrynAycMj
         HUogkCZTIo3g66lxyhOQv2jrjHfrGxPvtMYqv+4Nd5w+4IWmsUOWqmaFL2pQvw33x1Mz
         HDe0+N4n6Op55Wz6MfET6Va8W9XOeJfR3+r+lH8a0/kAO5L0HPLXyt8XHjN438cjRdjA
         5zFY4UIGxb0zssE9ocQjpG82i0wLKIPaqnEy4ZJEGOwBCBRKDzla4wNPfWQOxLCx+QbE
         LMqA==
X-Forwarded-Encrypted: i=1; AJvYcCUGBZwKA2l0pw+n+OYjyFHpIdi+GGYosIB2XfkI/c7qUq6gkdz7PpIpZxikZ5+R+H9fWk4Uj/lJ7xvDx1aKiyeRtuUhGPvJ8EpIS7+Y
X-Gm-Message-State: AOJu0Yx3JEcfqHVqCv2KRw9La6uG0yh9kMQvHrBGExzrXOpexPHFTSoZ
	V5O8lcNtksEERRKNnC08ZeltGYSc1GFvVQr87peAF13Nl80dAUz7V6udgTWYXevYs/0R0uHSclv
	IlxkEcrnejUfqS19pSaDwIKCLDBH0VBVts8H8oA==
X-Google-Smtp-Source: AGHT+IEqHMRvom0iWLGcDMIX6MMDmGJuXm9C6a6p3VWgXb1lMC9v99HG9mosDP74t16pkkQoXUvXtUBwwTi6W1xBvYw=
X-Received: by 2002:a25:ae97:0:b0:dc7:140:8c0c with SMTP id
 b23-20020a25ae97000000b00dc701408c0cmr16434750ybj.23.1713343487742; Wed, 17
 Apr 2024 01:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411064614.7409-1-krzk@kernel.org>
In-Reply-To: <20240411064614.7409-1-krzk@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 17 Apr 2024 10:44:36 +0200
Message-ID: <CACRpkdYDDJ9g5iSZvi_4pPdH3LWNd7PHS4QP5mkt2q+O+t_FAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] pinctrl: freescale: imx8ulp: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	zhanghongchen <zhanghongchen@loongson.cn>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:46=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.  Pin controllers are
> considered core components, so usually they are built-in, however these
> can be built and used as modules on some generic kernel.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

All five patches applied, thanks for fixing this Krzysztof!

Yours,
Linus Walleij

