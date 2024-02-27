Return-Path: <linux-kernel+bounces-82849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6D9868A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64076283B33
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48AB5646A;
	Tue, 27 Feb 2024 08:10:19 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A856441;
	Tue, 27 Feb 2024 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021419; cv=none; b=RkOuOF1532R43CZ8cGpswnls7N1WBiwKQsThXPSH6l09tLMAxwtcOtSQNh5zYSTlx2xJzVT5YxIRaERA/sIReKX6HnYZLyKVpdHTsyeBwLGam8FMHrviNIaGF4O4mV4onJvRMcy4dSwtO8hlZSqwBYxuey2mAEHKGdpA0sMVSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021419; c=relaxed/simple;
	bh=BPyJtCmk9qWVCLq/x/4vQLcnG953c2gwDPjE+Mws0hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyjgb7k6W+VnlOgQ30+sZ6Y4yg9Le/CNp8pxL8AES0Iu4j96/m/SaI2snHhUyIOgQMXKiJhRc4CUT3/3lo0GfgCSsfDMOZbWqK6hIusEtZrOVZUCrR4doxFHWOfMoxhiBgMue402aafiPb7k5+KQJUJG+BdINXQ5AAYeHDcRHD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60915328139so14379417b3.0;
        Tue, 27 Feb 2024 00:10:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021416; x=1709626216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHKgvHCfQA0dLHWrUBiWkZ5daaE/U0GQuV+47oRC1J8=;
        b=atb4yIxLyXsAjMDfnup34VEx1Uf/mCsadz0t9qs3Xb0CtwDRaO8d/KHUhvolNLd1VK
         3qk/4Nx7bvdpRrAvZLYqIwchiMGp/Lem4qPRfVVdyRRU7F1F6U9BUTZfcHLI1KDOa8cO
         QLBsK7FdAv3y917RfomlukShXp8Or4cWFObWa+fJZD+ruyN3BUzyr13PKrNjFmqBcUH0
         bxXoXbvNcXyK5m5vpX3MtUWAShtvS6oUo2emRpk21mzEQXsLerkdD+YqE/3kd26rtU+d
         n17bm9fhSBewu6y1MpdtnPBwSm2+Fr79/MWW+d1ghr+nMbT+EIWW3Q8R88RSgByyCOGa
         jC8w==
X-Forwarded-Encrypted: i=1; AJvYcCU0fZBjGkFqeSpM79d/LlarzNH/mo6jT9ingdJh0iNSw3tupvNzDBkiz09DbU6U1J8IAxNWeNGurHH+Ce2PY5mw6oTgadGDaLUz5MJP6pyGbuxc+gfit3q5JX/Uz0VLuhX1dfRPDTkNImFBgYTDj7WgiGXfwOeJ54oVJ25rcg+BiZfI71QcSTP65oUB
X-Gm-Message-State: AOJu0Yz6FosYJzSUJ6TR/9aoaDW7cpY5+t1hp2XSeEbh/R58XSG/T3na
	nbkBU8gLkM4tSyixB12JCpaQ+YA9AjJ9KOLpp2F/Gw9YQa68CCSUJn9tI6VBJIw=
X-Google-Smtp-Source: AGHT+IFqPaKpcdeBWLSeUsXNlBQ2/EBy2z5NH4UyyNwAJmRVNFBN/RTUfhu632tBABRHVJq6PbZltQ==
X-Received: by 2002:a81:4113:0:b0:608:e6f4:4e14 with SMTP id o19-20020a814113000000b00608e6f44e14mr1419158ywa.47.1709021416519;
        Tue, 27 Feb 2024 00:10:16 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id v1-20020a81a541000000b005fff0d150adsm1599681ywg.122.2024.02.27.00.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:10:16 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60915328139so14379207b3.0;
        Tue, 27 Feb 2024 00:10:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUG9OFS5zOQmuPDUIcHGOFDfMr6/iomyew3isl/i8sghSpHmtqFxMRIOGiUSURzq1ro0fmuk5+eLxJH7+tqe5L72lnLH/peYz4/QzUEg6sDXANTtIOh8ho/IkZRsfibyNj8g+kv3Dxq70OhsaaJlXN+hmBhi9JROYzOozEq1u0KltbBQ9dU4M7gZIsV
X-Received: by 2002:a25:2e12:0:b0:dcc:58ed:6ecc with SMTP id
 u18-20020a252e12000000b00dcc58ed6eccmr1247229ybu.41.1709021415817; Tue, 27
 Feb 2024 00:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-4-aford173@gmail.com>
In-Reply-To: <20240227034539.193573-4-aford173@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:10:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUS2gMAZ=L-aj8GOti_cEsnrv6qz6aDLmj5-TOD3JKs7w@mail.gmail.com>
Message-ID: <CAMuHMdUS2gMAZ=L-aj8GOti_cEsnrv6qz6aDLmj5-TOD3JKs7w@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: renesas: r8a774e1: Enable GPU
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
	aford@beaconembedded.com, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:46=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
> The GPU on the RZ/G2H is a Rogue GX6650 which uses firmware
> rogue_4.46.6.62_v1.fw available from Imagination.
>
> When enumerated, it appears as:
>  powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.46.6.62_v1.f=
w
>  powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
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

