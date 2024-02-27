Return-Path: <linux-kernel+bounces-82852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8E4868A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180801C21127
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79B35646F;
	Tue, 27 Feb 2024 08:12:53 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9055E78;
	Tue, 27 Feb 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021573; cv=none; b=BMV+T45v+nPj8fKCf2Lb6ZEhg2cHtxkX2GCGekfoFJOPGV7eifowC5F+hG4qioI4wyhoOOfdJDxsJXlrMJqZvEhcmI9EOm1GuUlw9J3eiygEery1KP7rsJ1TU1922UZWwJht3RfpIgV6r2uM5z4yKSyoZQVaJv+tNyz8xYYvKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021573; c=relaxed/simple;
	bh=zrZNsgj5kbElcnQmq2L1TJfkDxwpID6PxN1Dthe45BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7ofaW8g7abiKiXnJ++ySUH9H0aQwgb0FyTG2iITrU8aGL+8PIFUifZEz6X7g2dkTNuSG1yZGUy5gWO813qcUaFR6Ko6H2lZ5nCTVI5ANpIf4xZUOZEEocHricjnR1c2gy3kRi+xP9rOR/XV/PzOxC7P6DlLgR6ZsSXL9H50o1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-608e3530941so24380057b3.1;
        Tue, 27 Feb 2024 00:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021568; x=1709626368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHn2r0gOJkRntSoutMiiF0ECORnR9mSgKiX3cgiGkQA=;
        b=L694ZL4P/vNFJC5ZXs8AvL190pyAzUYCBfDVpbj7CDe4qebtGSpFsJJqrbCyUFMNy1
         uoQl5nqEuPHH3l8uzQ21fhlHIzYkDtE0NE7SKw1lP0/QjT+sujnaRk8sG5fka1R5HFd7
         XWRqtViT3io++KJINFDRbZWvSmGyQXwFim6ECgsVC+mXreU7sJdlW5JsTiqlOiOvPbil
         viqTSLp02s1z15tb/cTPK0NNZye9vNXkxqG6vYh9tiPSydSC3L+SsWDKEit2f9EwseJQ
         6TbRirjlyYFemSZKmHdcXYTBQKPcusmhymjmXY+HFhQCki2zRkkMkNo9wxIwW0BF8l1/
         OhIw==
X-Forwarded-Encrypted: i=1; AJvYcCUPXuzD3dYrHiyLzoqtoBFzqw6uaudke0Wo/7kewfzGLFAoIDrR+JIWv38lTfZMKDu1DTSin/+zscRgWxmTAH9AA9UgoJW+YNpyJNP9ISc1zZYngvKQSbyh50r+LYr/W2Pa9646FfZVtWCM/Yp/BqOIgYdNkriW3pLtKT9WiiqZ0CkeeRJdnosbAED/
X-Gm-Message-State: AOJu0YyWj8XgUNFgl8MYVX1Lz4Vs98CA6sNHx50L41Ob3RnfL7LI3YP7
	cOnmKzIYH9GuyLRQhKE92p4PyclLEtnxi9fx1LhgKAjJzvtq3U2bjyS3lr6TC4E=
X-Google-Smtp-Source: AGHT+IHf/zjzkVEfAmV3zADqAvWVXTCsAKsN+U4SmXJLhxOZNvR0tc3pGoxp0GYnbdL9TPoVVDf70w==
X-Received: by 2002:a81:4316:0:b0:608:e3ac:e6ed with SMTP id q22-20020a814316000000b00608e3ace6edmr1565054ywa.10.1709021568031;
        Tue, 27 Feb 2024 00:12:48 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id u6-20020a816006000000b006085e262414sm1659691ywb.81.2024.02.27.00.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:12:47 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso4084760276.1;
        Tue, 27 Feb 2024 00:12:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxREthMCZ9qsR55n11xlcJpb8FxYEObRNmKqqYr8PNi5PQW+UBAsWx04yxKTbzamQDoKKlWvj7DZszBI42RMx9/MDXFa2d/+caIQwkKZybiMUHepNtu7Wi1/ynY4sMAnvD4/XvISlYCBaMYB/MB95RC4BKTbdTdSh3V63NAFuexcFJ6uFM4TIbnlHI
X-Received: by 2002:a25:b121:0:b0:dcb:be59:25e1 with SMTP id
 g33-20020a25b121000000b00dcbbe5925e1mr1585696ybj.30.1709021566147; Tue, 27
 Feb 2024 00:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-6-aford173@gmail.com>
In-Reply-To: <20240227034539.193573-6-aford173@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:12:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJEeD_2CRTk3UCR9BCUWj1K42-V+Nhz3=DO73AOUa24g@mail.gmail.com>
Message-ID: <CAMuHMdXJEeD_2CRTk3UCR9BCUWj1K42-V+Nhz3=DO73AOUa24g@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: renesas: r8a77960: Enable GPU
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
	aford@beaconembedded.com, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:46=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
> The GPU on the R-Car M3-W is a Rogue GX6250 which uses firmware
> rogue_4.45.2.58_v1.fw available from Imagination.
>
> When enumerated, it appears as:
> powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.2.58_v1.fw
> powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

On Salvator-X with R-Car M3-W ES1.0:

    powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.2.58_v1.=
fw
    powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
    [drm] Initialized powervr 1.0.0 20230904 for fd000000.gpu on minor 1

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

