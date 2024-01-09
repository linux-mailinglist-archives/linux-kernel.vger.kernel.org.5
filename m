Return-Path: <linux-kernel+bounces-20336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5D2827D74
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9AD1F241DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905364699;
	Tue,  9 Jan 2024 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="izpz8q5M"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCCC63A4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd33336b32so32259601fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 19:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704771866; x=1705376666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IirnRXaj1MUEQGJO0zbDoWzQpnWpqMe52m35Flc2QA=;
        b=izpz8q5MBW1FRzVC7qdMo3hQyPRbaEk4+TOL1ioe9j63uZUwoBqJxVCZFpjTuUfka0
         KdSlAmoE5GNOpTdfpKrfyZ7eAxGcO+CxbOTmODMp0+u6IHygISfNWc10yChNUlN96ckg
         VNLrh/P3v+L/XcKKeiFahtPMxkhZAJ4yzQp4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704771866; x=1705376666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IirnRXaj1MUEQGJO0zbDoWzQpnWpqMe52m35Flc2QA=;
        b=NgZbt4udW9q4CSiKz4B5VuRxrV9Uw+HNLvwnIa9OX2Mmgs2P9Lizjhnh4YsKdAURS6
         EoE9MqLbdvkzRP22ai+XnRksAnIVgKlEGgVDEqttw2vf8tzr/3llW+r8T90i/d8ns4RA
         Ap9/W5V/paNLrTDIYp/drVlcSs8yCKKl6AWJwqvYswn5cILNMMkyYq2uIGz0IRcqyB6N
         samOWawbt55JttuPVi3tg+ueH/tCfFEvEU7+Y3VB2EqtoPuzKJJrUBvqsUk1O6+Za/Kh
         dRl3OhcB2tKsm458eFTPugDYIdsqKrkeZ+dYfSDGzXIDK+/OzxMpH1qN3D4DR3WDdzf1
         UGBw==
X-Gm-Message-State: AOJu0YyMdymdiklCnK3adVVx/YNTUbKtFcyK/1JvsOfqWKLMxdAAT7vI
	aLGiEfiOMztdQZUnNnG+vVTKiKrWd//jeH2hzTq/bn32SJVj
X-Google-Smtp-Source: AGHT+IHYdJnZJ+ia5j3MDP+U7FWEJutaJ/CAtYrvXrMKolc4lrDjHs3uboOZeTMPAaG800e+FJBUDwDxKqaytC01MRg=
X-Received: by 2002:a2e:9b18:0:b0:2cc:7718:edfe with SMTP id
 u24-20020a2e9b18000000b002cc7718edfemr2040200lji.41.1704771865390; Mon, 08
 Jan 2024 19:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108204508.691739-1-nfraprado@collabora.com>
In-Reply-To: <20240108204508.691739-1-nfraprado@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 9 Jan 2024 11:44:14 +0800
Message-ID: <CAGXv+5G_7OA8m=KENsLbu3wig9D_LOA+oWswQK34wEHtzHXOhQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8192: Check existence of dai_name
 before dereferencing
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com, 
	Jaroslav Kysela <perex@perex.cz>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	=?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado_via_Alsa=2Ddevel?= <alsa-devel@alsa-project.org>, 
	Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 4:47=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Following commit 13f58267cda3 ("ASoC: soc.h: don't create dummy
> Component via COMP_DUMMY()"), the dai_name field is only populated for
> dummy components after the card is registered. This causes a null
> pointer dereference in the mt8192-mt6359 sound card driver's probe
> function when searching for a dai_name among all the card's dai links.
>
> Verify that the dai_name is non-null before passing it to strcmp. While
> at it, also check that there's at least one codec.
>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Closes: https://linux.kernelci.org/test/case/id/6582cd6d992645c680e13478/
> Fixes: 13f58267cda3 ("ASoC: soc.h: don't create dummy Component via COMP_=
DUMMY()")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Audio now works again on my MT8192 Hayato.

