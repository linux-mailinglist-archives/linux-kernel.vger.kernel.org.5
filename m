Return-Path: <linux-kernel+bounces-105505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C936087DF72
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CACEDB20CB5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A301DA22;
	Sun, 17 Mar 2024 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sheg7rOY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B661D537;
	Sun, 17 Mar 2024 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710701991; cv=none; b=n9t2Bcd4ggROHK0DSm6swryyJSGHe6iquz/Q70cupYOwmIYogpsYOAtS2l2mZzMoqXQviWfUXpYpCJhOY4tgLRJVX+kh7JttquL4uyEEKo4wi9P8IpVPwy+UQbYeVqkPZfO/HnM+H680MZ1bEJKPQeFNJ6xZPZl5eL5YLKhvSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710701991; c=relaxed/simple;
	bh=eEcx4nr4CbIEDZ73FBW/lYmpnu9poaFi2q+u8EJ46Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QW+h1kQBRFUPKvUNzCWbL+fPFgT4Fo8p1hraL0u/eegs2IZ62d7KJbk0JsyGoBroTxHgbXc/9XZwbeilVvnVd332zGBABVJ1CRvzGJNkuskJjQTiBbEBDiUzq+MEWvJ2S74faNKVGYCqgsBX/x36BsszpSRieJ3Gabp6aoRTGFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sheg7rOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E437EC433C7;
	Sun, 17 Mar 2024 18:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710701990;
	bh=eEcx4nr4CbIEDZ73FBW/lYmpnu9poaFi2q+u8EJ46Mw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sheg7rOY9AEl8f4aS2T0JVYyUEpqqH9nTpoX9BJO7YYOu2waGvraye1vG+jcZUbcA
	 VOwTAcbOBfcF0rWhZ01QdWC6cr/ACmwSQrPHSxe/Yas7z5Z9dFHyj5xDUMorX8halN
	 HBVpfpkyB5PdWKMtbdDofNcMGNJFWAplRDVoodh8BXdS3zcEwNJEZli75dXi4r2dkb
	 e3va0MPyjeJlkdeIrs2q66sgWxbnIxxtnFn5che0pcK+mHm71+myTnwgknLPGc/KBn
	 6Py88dFNYXg5o0fPJUpDCS5dpl6zSgRV9SIECLLfuauR7Y9zzuJPTOnuvxuAuRUkKc
	 hH5knxTWCoZ5Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46805cd977so333523466b.0;
        Sun, 17 Mar 2024 11:59:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFUZADsWeH7t46u2EVf6DY6d6aH+OMW7ZrOofAFdLDGEMuirrLAq4nYtK7LlM3l7WPJzy3cxThgk3uRoyXvo3I/OsM5wWEDiHiDe7uk8DmUcLlsvZQ+v8e5hMbzUw/2hSxh4D6Wv1RCYarDmVkUTXVf9nDuE5Gb2ormmGRgyzQLfxsi7xp
X-Gm-Message-State: AOJu0Yxr+LO2gg5Dqedlydsaqf3oYPRMSYzbkt1Cyq6+TRSJxgyKcjQa
	e61I6uayPGLudmwN7tUlYK/mpq2cdYsHn76zYHNG7z+a/NUU+Mt8NmN2jmBY/VovYCHCUedQS0/
	JNnIBXT6aW4J8wN80cHteSVq7nA==
X-Google-Smtp-Source: AGHT+IHXmDQcoBpEG7P/jd72N8SjRsw/4nVttA2xS0/VB/Czg98Z6kMH1XdW6JGvB1L6zB1PG/og5ahKug3PnUqqfnM=
X-Received: by 2002:a05:6512:606:b0:513:cd77:4a88 with SMTP id
 b6-20020a056512060600b00513cd774a88mr6175517lfe.29.1710701969239; Sun, 17 Mar
 2024 11:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com> <20240313110147.1267793-20-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240313110147.1267793-20-angelogioacchino.delregno@collabora.com>
From: Rob Herring <robh@kernel.org>
Date: Sun, 17 Mar 2024 12:58:58 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+zDc3vwAJHgWwSvauXr2-1NMbbznbj3v1PyMv+9UA5wA@mail.gmail.com>
Message-ID: <CAL_Jsq+zDc3vwAJHgWwSvauXr2-1NMbbznbj3v1PyMv+9UA5wA@mail.gmail.com>
Subject: Re: [PATCH v3 19/22] ASoC: dt-bindings: mt8192: Document
 audio-routing and dai-link subnode
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: broonie@kernel.org, wenst@chromium.org, lgirdwood@gmail.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com, 
	trevor.wu@mediatek.com, maso.huang@mediatek.com, 
	xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de, 
	kuninori.morimoto.gx@renesas.com, shraash@google.com, amergnat@baylibre.com, 
	nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de, 
	dianders@chromium.org, frank.li@vivo.com, allen-kh.cheng@mediatek.com, 
	eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev, 
	jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com, alpernebiyasak@gmail.com, 
	ckeepax@opensource.cirrus.com, zhourui@huaqin.corp-partner.google.com, 
	nfraprado@collabora.com, alsa-devel@alsa-project.org, 
	shane.chien@mediatek.com, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 5:02=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Document the dai-link subnodes and the audio-routing property, allowing
> to describe machine specific audio hardware and links in device tree.
>
> While at it, also deprecate the old properties which were previously
> used with the driver's partially hardcoded configuration.
>
> Also, since describing machine specific audio hardware and links replaces
> the now deprecated old logic doing the same in a driver hardcoded fashion=
,
> it is not allowed to have both the old and new properties together.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 139 ++++++++++++++++--
>  1 file changed, 129 insertions(+), 10 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

