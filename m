Return-Path: <linux-kernel+bounces-82848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F54E868A84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409661C21CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B032E5646D;
	Tue, 27 Feb 2024 08:09:57 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8595467C;
	Tue, 27 Feb 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021397; cv=none; b=DeQ4Ydt56IjIIckJZyMmnu9AEyCA6NZLthlCVjee9U5SwMfBMyP5YswXjU1WZowc04EOSsZjfbf/+/PgFb2n7nFLBTb6W/e87FzGiDXn4JLKOIVq9VkgtE6o68hGNvnr8/MWfsRLjHgMJeGczuMyBfRRYKf+XwVufdq8kGc6POk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021397; c=relaxed/simple;
	bh=dE27OkOv1DTsp3HB1NDlDgJ5Hqay4jF3HK5PY13Y5do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYDcQCmaMDkASdnnPNiL5gb57FJz6Rg/lGvC8Er6JAy0rqYSAiXP3hFor14E5r/IrVTt8R4jD26KRqOfdVwvH/Zwlye3uik1ZIDmLUOWUw0tSamS34k2UHyazZf5Oft7JWtBXys7JWBxfrV2oqWKcF5ZhHnp74Ow7Rc/FtHSSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607cd210962so35890267b3.2;
        Tue, 27 Feb 2024 00:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021394; x=1709626194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oNxsCY0M4jeXi/rHTScBBRSGzK8KOWMJG/0W06N5ho=;
        b=X775cf4angu6teSLyc4hnsmq6AyqwLGclHnjviMiqSVh6imJNg+/k1LTdtVmKagmzs
         KY8GD/ocyHiqsPjc+q8UDKibPN3IzOOYrM8ujln00o7YATQ5gDzeEzcQiXh6JxXsh8Lp
         Y36KiC4srQVEUcxxLoT3CZFPQ3874F1Xb1uh1OWaV8oEchsD09UI87dqZ3FWh32x+Qwu
         mVUPP2NVMYH2c7ZayNnd6Qk+sRxyX6/k02Nktji4HA4Jx+LKsvggbEM8hQWSH03iOmNg
         3rZT68BbLg2TuaqCUvxXRQbPq0p6yb0syrouTLAj1ZBSyc6H5OMRgdYB3lA2vawBv30v
         47Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUKKGMlnuNQIolKE/+fq558OFIOLHIwq6QqAMWdHxA4ks6OL+irZ5aQLB3r5wA4eK87RwV0eYNcNKA2laxOedF8dF2c2aLNlWBByGEWkBFkdq0gxguprD+tHiepL4E8YfiYuhnjjwkkOI/m9vWxz4F5opuihUcv3/iz1fv8a2tKPH0tvKWosjXk1E5/
X-Gm-Message-State: AOJu0Yzm0ILlRmeXpEzYUgREI5/u7DI0N4xOggQlX9xckuM+wc66NVRB
	KAHW+NBIHagCq037Iz/fBwhqpSdMw0TjZT2IbG5A7ByaoAHrSU0YUSgzRKJpCHc=
X-Google-Smtp-Source: AGHT+IHrjsBvTYqqE3LfEN6w7yrzrPa+WSTxxfXjxF78kdLXJCts7gUiC+00Jj637KQssiWkzGbQHQ==
X-Received: by 2002:a81:8d07:0:b0:5ff:9676:3658 with SMTP id d7-20020a818d07000000b005ff96763658mr1299386ywg.48.1709021393733;
        Tue, 27 Feb 2024 00:09:53 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id z127-20020a816585000000b0060755a31c0bsm1626366ywb.100.2024.02.27.00.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:09:52 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so3985360276.2;
        Tue, 27 Feb 2024 00:09:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVO4mg4frQZ45h+CqE/OJ4ogUHjmFQ2ornzJHRpb4iD1NYC2OJJ8K0eB7MML+YLZ4bbPuoze3VS05Vng8xD/H42haUPcxWjOzc+fAgRJoMj/E6YfqSJs+Vpxem40tZA33ximBPkBZcKvJZ5d+1iqQp+ZU6fdAjZWdt5xCEASEtJ+zSJfDyaqcZ47N0c
X-Received: by 2002:a05:6902:4ea:b0:dc2:4397:6ad3 with SMTP id
 w10-20020a05690204ea00b00dc243976ad3mr1606683ybs.44.1709021392447; Tue, 27
 Feb 2024 00:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-3-aford173@gmail.com>
In-Reply-To: <20240227034539.193573-3-aford173@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:09:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWvSvosV6E5P9cY6dum9C-McJ8q0fOZE58zp4TZYUOKBw@mail.gmail.com>
Message-ID: <CAMuHMdWvSvosV6E5P9cY6dum9C-McJ8q0fOZE58zp4TZYUOKBw@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: renesas: r8a774a1: Enable GPU
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
	aford@beaconembedded.com, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:46=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
> The GPU on the RZ/G2M is a Rogue GX6250 which uses firmware
> rogue_4.45.2.58_v1.fw available from Imagination.
>
> When enumerated, it appears as:
>   powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.2.58_v1.=
fw
>   powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

