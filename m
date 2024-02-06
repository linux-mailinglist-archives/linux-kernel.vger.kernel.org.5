Return-Path: <linux-kernel+bounces-54667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C884B23B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9C7288F81
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3F12DDB5;
	Tue,  6 Feb 2024 10:14:32 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9524483CC8;
	Tue,  6 Feb 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214471; cv=none; b=ralH/ldIDuTQP4p16z4dHXu70IL3e/d4buEmVklEJ0ZYYLaUaEqEDFbGAmgjFg1HpH0S3jvo28OXMsras4xliPD2JTtWm0dJ0jzlS75t3Q6EiaBcWBVG9dTz4pmIjYPbCoKhmbXHV1SKI7GNJzKDsAxB7Y0xAJMPM1X+vR6BCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214471; c=relaxed/simple;
	bh=4e6QCB68l13am/1x6KIQRejlW6iaWAXrdTdsBGpLukM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPvKIRvjzfiDMs08j4wJ1OKE+KhyNNi4qhx/65h8/x7182n1zCr1OtPAknxcTzHbYRoXGXMaHIuzuBo6c1yYvpFxQOlOZybAq0bk4SGITmdU/XhxPuWU/Vf7pN6JpUbHe6PbZOLHAxBawZsTV9+OmmuRRgtUhmKFgTP0Zvu4rzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6040d0c9cf1so52402217b3.0;
        Tue, 06 Feb 2024 02:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214466; x=1707819266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtCCWZhu9Pe3rgXwf+V6JpR3qXWYyc8Tma3pMX6qmQI=;
        b=O4VcyE2i1EPXQwLiNMInTo0jAp6k/KXH9/94prhE/87hsbB/YjfV6RRmy/MI1kWPIu
         Ct/YIObrgo+kqoFyC53jBkiWJiIvCeVBI+g/Tp5FfKQBmCrXKDyRN2OcOjwfsP66OW46
         +oQO6P+taoouxAl7vi/LioSvG0wL7h9V5WoJDYWbpRSZE7NvZZJDyg3+rzKLgCxKjtzo
         mgsOI9+3aObcTbPU05QmUjFm4ExIsFidhb/1TKSVjFGmsCERNm9QsKJFU0s/aWoorcxz
         mSrC1kcR55VUh7B4K2Kef91av/t7tuSf65ZaLfF4oLJTE31AoIX7c4c6wcY37wvWy8AT
         C/MQ==
X-Gm-Message-State: AOJu0YyjkKOw4AP/Ro1WaZSAXUNJkRxXGmG6RVxN78hXFQZUevBDIkio
	+EG5i6vwq3v5gx2+FII6LWBGs58v/R6WtGQzte3N+BRqzlQF+Z/s2JEG4i+qPx8=
X-Google-Smtp-Source: AGHT+IGCsw1a2BP7IM4ZQEywRhOOeDzwLrIoCULoFmdGrAqNEU+R4ZrdS/DMZtXhoiMwhJZYR2ogjA==
X-Received: by 2002:a81:e202:0:b0:5ff:f2a8:9b57 with SMTP id p2-20020a81e202000000b005fff2a89b57mr1120734ywl.17.1707214466584;
        Tue, 06 Feb 2024 02:14:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYDEbs+mdHzcc+9Q7aCSaTdoGpdtMwtPrjCrBAwNigc8OIPaDWzduUiHhi0PKXQkQSe9Z0v1Rf9qcPaYdNsDcOfl3AMuJeRFltUCw18lbFDUdDz9o+Eb2wWJy2ioqUpecKj/tKj2NgK40r2bw614E=
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id n19-20020a819c53000000b005ff7a3cc04dsm404577ywa.129.2024.02.06.02.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 02:14:26 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-603fdc46852so57137567b3.2;
        Tue, 06 Feb 2024 02:14:25 -0800 (PST)
X-Received: by 2002:a81:e809:0:b0:5ff:b07b:fb0b with SMTP id
 a9-20020a81e809000000b005ffb07bfb0bmr1059881ywm.49.1707214464961; Tue, 06 Feb
 2024 02:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206071314.8721-1-liubo03@inspur.com> <CAMuHMdU7fYCsNT9ditqJ-saUsRm9J2zLh=-q-zmExhBRJeE8NQ@mail.gmail.com>
 <ZcIE/RMTq34TgpQt@finisterre.sirena.org.uk>
In-Reply-To: <ZcIE/RMTq34TgpQt@finisterre.sirena.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Feb 2024 11:14:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVj1bS9s69ASrd5xULc8oELoBbnb8HEX9MEmA43853_EQ@mail.gmail.com>
Message-ID: <CAMuHMdVj1bS9s69ASrd5xULc8oELoBbnb8HEX9MEmA43853_EQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] mfd: convert to use maple tree register cache
To: Mark Brown <broonie@kernel.org>
Cc: Bo Liu <liubo03@inspur.com>, lee@kernel.org, wens@csie.org, 
	marek.vasut+renesas@gmail.com, support.opensource@diasemi.com, 
	neil.armstrong@linaro.org, ckeepax@opensource.cirrus.com, 
	rf@opensource.cirrus.com, mazziesaccount@gmail.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	patches@opensource.cirrus.com, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Feb 6, 2024 at 11:09=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
> On Tue, Feb 06, 2024 at 10:33:22AM +0100, Geert Uytterhoeven wrote:
> > If all of this is true, is there any reason to keep REGCACHE_RBTREE
> > around?  If not, perhaps REGCACHE_RBTREE should be treated as
> > REGCACHE_MAPLE in the regmap core code first, followed by a single
> > tree-wide patch to replace REGCACHE_RBTREE?
>
> There is a very small niche for devices where cache syncs are a
> particularly important part of the workload where rbtree's choices might
> give better performance, especially on systems with low end CPUs.

The REGCACHE_* value is specified by the device, not by the CPU?
While some of these MFD devices are on-SoC, and thus there is some
relation between device and CPU, several others (e.g. PMICs) are
external, and thus might be present on systems with a variety of CPU
performance.

Perhaps the value should depend on some CPU heuristic instead?

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

