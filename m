Return-Path: <linux-kernel+bounces-142243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAED8A296F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD811C21B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3E2BB13;
	Fri, 12 Apr 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIBY2Ke3"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8718030
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911039; cv=none; b=Z5f7NP70NQmZXcbaCoPwVUkz12eVJL9/SiMeosht8A7kWQB76JGbtqKdhrKgATUngZMJLXQtdpFYHmM4sTRcokplDIyfHhLW5HEKJbu5QnEoBYUGN5REbNXx8OvDm+Ptgst/5vPGlm9QcOcOk0gnZIGmtOKiSRCnkotP6zx1DcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911039; c=relaxed/simple;
	bh=UXhULSRsCjHCssdtYJT1cvp74SqjokSLuEvNUkZIlH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orWQYjiM5WjeiTIDNQzdl4N0eANZJd44M9owRRUdjroHEFsXD+Gpjl95HYTjcVe+j8HKGKUbaOSM8TdNEowTeDzyFFRa1RqDXQn8iSVpItyd3iL1BsiqC67y8ud3zW2IwLHp3zn45SEGVL3/dXAfhm3A7ZJdqbButcMx/SsTFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gIBY2Ke3; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc73148611so736986276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712911037; x=1713515837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXhULSRsCjHCssdtYJT1cvp74SqjokSLuEvNUkZIlH8=;
        b=gIBY2Ke3rYWxGzVKKHX2fEVNUS8l5m0oUEOw4ElxbxGJ3vSk2qdnpHakp+XME0dP+F
         rQ5/5BaMVeF3KtdrpG7vR7FFlMXKDehCeYn1tPLmUVv6WpZ0vcgnGshm2Xi1rbjPTRjk
         2ch4qX5frdi20joAWsiA/qXpQ6c78dz/1628mQJHp7SS40YpJL3zBx61BalIwt66kNsI
         jjNeho7ctVhtaxE9xoCDt+rWFONls/75EAAZ16wgiUtnzxcKoipMog24HkKiH31U+ci4
         cC+pnZgo4tZ2Kabfnp5+s7qgn0yYl9vSjq4XgDCL2CmLWFLfrvJs5eLJ4Svss3wMFZCv
         ba9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712911037; x=1713515837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXhULSRsCjHCssdtYJT1cvp74SqjokSLuEvNUkZIlH8=;
        b=Yy4TmSS/7xuN8E+DIMQ41UGAGzE9+DDdbARx+a41dC8EkMqh4+4Wi59qm66kK/Xhw5
         CDhtZ5A9CU4tN0575hiciqOTZktqa7BVnMmro2+aYLxy8OJTgstwyQv4nSTgCytyNjT5
         jK4/hHpinhIg+Q8M7xTqE4bEHanVDW+F9DbOtwDXVVRuY7xFrYS/eFGCUTbhiIbHwbsZ
         dTU9s4+TmVO9xHiG0Jje+WFnlYqExDzU8VEtOPBZNCRXIv1oy3U82YP2jKjCr/+NvqZS
         0DwPA8ukXP8soNldX/DWu63ivKtRQeiuU4f5mvlyN4QvOPHdzvl7k9PRi3j6OuOpcWSn
         WyyA==
X-Forwarded-Encrypted: i=1; AJvYcCUfI0Ab1drUybpkdpz4UzvN1BkKZnCgztBCCK00hSuLPcfbPadHHFF9X9O9Xj4JjsqUQK2XkY4RZm5o3k1jFGW/cuVPCpanVcxrqehj
X-Gm-Message-State: AOJu0YwVR3txPhQ/nNXz3uWKuAjsWrsuZ5aSGtsrCabHJHwDPi/kScvL
	Sxhdn7s7h5khaxzrwKswe/76oaE6bc3rsaJGX4TDQNEgWk2XmT6W1BLQ42YyPT9qz2aOoR0kYoA
	JJfZCcdRf6oMXrUcmNgfoVsNwHTlSIm7Kq6eGmQ==
X-Google-Smtp-Source: AGHT+IEDIX9KYQNW/UojXF2G4UMFeUDK0N84b3GjCBGs5oNVjsvP2eeUiBkx3liWnNP1h3R3ng2gaSs2JzTXPv1Htfg=
X-Received: by 2002:a25:c70a:0:b0:de1:133b:5053 with SMTP id
 w10-20020a25c70a000000b00de1133b5053mr1898633ybe.20.1712911037446; Fri, 12
 Apr 2024 01:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410073044.23294-1-boy.wu@mediatek.com>
In-Reply-To: <20240410073044.23294-1-boy.wu@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Apr 2024 10:37:06 +0200
Message-ID: <CACRpkdZ5iK+LnQ0GJjZpxROCDT9GKVbe9m8hDSSh2eMXp3do0Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm: kasan: clear stale stack poison
To: "boy.wu" <boy.wu@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, Russell King <linux@armlinux.org.uk>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Iverlin Wang <iverlin.wang@mediatek.com>, 
	Light Chen <light.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 9:31=E2=80=AFAM boy.wu <boy.wu@mediatek.com> wrote:

> From: Boy Wu <boy.wu@mediatek.com>
>
> We found below OOB crash:

Thanks for digging in!

Pleas put this patch into Russell's patch tracker so he can apply it:
https://www.armlinux.org.uk/developer/patches/

Yours,
Linus Walleij

