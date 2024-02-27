Return-Path: <linux-kernel+bounces-82853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D49868AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8602822DE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D85646E;
	Tue, 27 Feb 2024 08:13:17 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880856449;
	Tue, 27 Feb 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021596; cv=none; b=VAvdFEYgMMBizwtCZm4mZM4I4Jvd4eYppM6TrCDideGJbsXB90e50oaVjiPAb+NrIMmJ/NoJJHmaO8jxT6i9VD0x0y1G33FFNZr81G6wQYN7qp/IJJtFtOG81TycElPK6hdpqtQwFbIq53kCbDeyl6wtbhnDGigiX0+SmbH5QA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021596; c=relaxed/simple;
	bh=9RD7LxWeQLqLBg9sjVSIvwV6LHoARcR1L/9VpDZCB8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFYuVYYTOO6UcXkDgVWiKtF5q6LzaAYLV8BCH4b2MlmOiyHezUjjbVgthCUm7tOdspvDFKNouP0je5fiokm3+Fo1IdIv4s9TIGIlPybB1nU6eUBoQ9gxNlCgKhs3fS3YXHHmJVdEPCdl+jKpGEpmyqDhO8ayip1OH8VmLFqPKZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6093247d1acso121827b3.0;
        Tue, 27 Feb 2024 00:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021593; x=1709626393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVOe12NY6Hd6XHyETGn8V8NNE5eD7ofZbpGZVlTMsYw=;
        b=fg+u/jmtZA+vQM9caxTAVHoUE2hRgvrpfiwolwKGbYjCsfYwcJX9YTAwvJRACG7gqD
         KDB6kmy4v0kBeLoyDSn0iQutKKLgZLeSAZU7SMUjaEbQRxseTE8K0FsDz9jec8b3pHH8
         REWYzvn9uEC7cyRPLIkYrDCNMf6oAvL/K2D+17XbQeJxM821eGd201FWdhrmNNxyxt7x
         BcOGNPsg7R4HsRnJWX+RCSyLML88UyRoY1n2+nrCeV81YRH+ebD8bqOyMsjXSzQsIP4Z
         ZG8cBH5J64Qny1NWrPY3RAq+fUq4w7uCN8G4EPgmL7L29dEGPvQ3ppaBAEiSAsv0AeW6
         Dq1A==
X-Forwarded-Encrypted: i=1; AJvYcCWL33GX+19vG/MPlJ8t4R3ofYnnS+0mm7DnFjfwoFtYTfFjQwiLhRy0KdPjZlVAYRanPtpS0ls3naaCCqB+JIylspaOpDlVxCyyspnJMNmuas+Oat1xhz6vExFkmTO3GZSuaFGnrrRIPy68Uy4epJ7lYNzrrwU0zZc/Sz0Xlk62RxacxoyK8NW+ptHx
X-Gm-Message-State: AOJu0YzXUlANE7wd+tZRU8ZyEDJPQNgMwFdbUyPBL/CHjEixHk2A++T4
	YhjajokE33LEHF5nPmwUgMI9zxGvD0PIYm5qa3RinudoVxS5aun4Zc+ba1oCTsE=
X-Google-Smtp-Source: AGHT+IFkkXieFkInDtmRulTNtba82nRl+8H0i4kdTdk2SXIz1K6bDy0tC0IVBI+AL4y18YQPt0D0QQ==
X-Received: by 2002:a81:5217:0:b0:607:fc53:8a40 with SMTP id g23-20020a815217000000b00607fc538a40mr1548093ywb.28.1709021592937;
        Tue, 27 Feb 2024 00:13:12 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id a11-20020a81bb4b000000b006049167ccffsm1583692ywl.65.2024.02.27.00.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:13:12 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607cd210962so35914947b3.2;
        Tue, 27 Feb 2024 00:13:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/m2/38wejeKdfCPE44e/3gFVzXEIyssRFRyYDEVnhbGRTradk9DaxDzVGeyBQbavo3nkbgMmEbbPdv6AAbxATp7QDZFG0Pl92C8PKfQiV8Izqu2YzojGNnrofT55Og+N/gScVkXXNlIIvF+8OE5yickq+//aLV0oiH/4vXvA6pyAbr/mAo4MQ6XaS
X-Received: by 2002:a25:ce11:0:b0:dcf:a52d:6134 with SMTP id
 x17-20020a25ce11000000b00dcfa52d6134mr1335614ybe.26.1709021591812; Tue, 27
 Feb 2024 00:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-7-aford173@gmail.com>
In-Reply-To: <20240227034539.193573-7-aford173@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:12:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXtO9nnGWtqP9P5Qw98gsdf3ayHJ=nW_F3AcNk_3egGkw@mail.gmail.com>
Message-ID: <CAMuHMdXtO9nnGWtqP9P5Qw98gsdf3ayHJ=nW_F3AcNk_3egGkw@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: renesas: r8a77961: Enable GPU
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
> The GPU on the R-Car M3-W+ is a Rogue GX6250 which uses firmware
> rogue_4.45.2.58_v1.fw available from Imagination.
>
> When enumerated, it appears as:
> powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.2.58_v1.fw
> powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
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

