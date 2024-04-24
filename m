Return-Path: <linux-kernel+bounces-156863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BA88B0966
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB359B22CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40615B114;
	Wed, 24 Apr 2024 12:25:27 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534015AAA2;
	Wed, 24 Apr 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961527; cv=none; b=BstdDsmz5BBzge62OFdmHEcscIC5E682uYKeNH84KibeehSrYReSonxH3Ovd0a1B8V1QbZqDPdHRM0+o8wxgC3zT793paxsh944KZIuUczYh2yDoirtaCZWyX5cbYifuo3CYa47lkXiu/ThIGoXN2nAVHyOGL6ciyG1iBUQmL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961527; c=relaxed/simple;
	bh=tC6NyA0n84H3G/z+AK+AUxaovsudnYNRT5DQbv/tRUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcb6R312SIskjT0zMDW/4wa6ouf15Pkiib5JSjqBJejNckLuaHFjOGq6ysrOqikJMlSk6eZj9ENip1d/sN9SjQosQAvz3eJrGL4e2LyTUiRKYKqUnD2TK/62g8goytk3onBD3168hp4nbeFsuUz/b4XubOm+nrGO5k/XxMGmfys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so6541225276.1;
        Wed, 24 Apr 2024 05:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961524; x=1714566324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YShRaMXP667P8UCwxbncDrLw3DknnrXZDIxHU+P4n0Q=;
        b=u4BqPCt2Mn2LvQnTlZ9WZ+ISOYJZeie6OCnVR/WzKqNgTa2sVxMffNm2CZVoi7UP9E
         Y/ZxtSweLmr00TT2NpoOsP521mrRf7Eb04nKzvkxKunfsk2MOuu5xCPMhRwiAgIbb4XC
         SUnWkgP4lRa6Ln803006MtUkJ9ghes/oNbzaNNSe+mP7YPM2AOiRVtjlZZ48onBtp0LF
         ILo1t6m/psLr7fWB/uQTSDW4Xs4meztw2hzaGjUrsWeISinnmW5Y26Lkgnp8b+i/nErf
         QDzZfyZ45MXxR36GoiU9fJWrGe22i8uewBi1y8by9FpeNSYPa8tfoDTzGiBuTQqAVEgw
         XFew==
X-Forwarded-Encrypted: i=1; AJvYcCUT2Kvk+z5ExZTgSrwpKoyQFEDD+nMBgKPUdsf9SbqWntjXwt0YVKgJE9Au3xHNUxJ7GJWcvcntrwjOOvTbs/NoKIrNRUNoVJZcvI2oiJMx+xYJykwGHh7HKafpf7RE7nNEX4Ub0w3RdjebC34Q0B2oa4GELBo1hUaRXLVw1WdQyHJ18pAHIWcZZf8Nq/OSwVfL8lSf1IMa9Q2WXEIeW7p2hTiR15/w
X-Gm-Message-State: AOJu0Ywn9DvDufhax10ibRVnEZzk41cvv5WRvQc8sIKmtPGU9hRVzjYX
	qNLuU6hwF5mb5iKULUyuuAbOr4dDXRQBLRq88A+ZidbOXk5tUG5eR+XdHfgz
X-Google-Smtp-Source: AGHT+IH6CEzOCOo/RZ0FS2prsLKfZ3bke7jS9SW9fLhNf24lvY7ET1wJwtKHYA24jBC/fnc/kIQoXQ==
X-Received: by 2002:a25:68c5:0:b0:dc2:279f:f7e with SMTP id d188-20020a2568c5000000b00dc2279f0f7emr2486667ybc.10.1713961523957;
        Wed, 24 Apr 2024 05:25:23 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id t188-20020a25c3c5000000b00dc6c58ae000sm3183225ybf.16.2024.04.24.05.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:25:23 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so6541212276.1;
        Wed, 24 Apr 2024 05:25:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHRcaoiUTSopLXI4l9Q2zldvlXbSeEAL3Oa9sZMoVTHT4kryyojQaXrtCOlEdIa7CnrLLVPe/xcJUtg6BlV1Nneb14Nt4zRPWE05zN50pKO2mnWjCr39+qikK8da2LosIEgi8JzB0lDVJ4PXBbsEFsIQpS2MQlB15RrelIds1PXod3EwG6qEKYf4gPNT8uhtvAbX0lnDjUgUFE1BwfyvpCrExZetni
X-Received: by 2002:a25:2fd1:0:b0:de4:6efa:debd with SMTP id
 v200-20020a252fd1000000b00de46efadebdmr2589829ybv.29.1713961523423; Wed, 24
 Apr 2024 05:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423182428.704159-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240423182428.704159-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240423182428.704159-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 14:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXvH1mYeGazJ5TpsuiA2+Ly19p1eOhti6Mva81S4u0f0w@mail.gmail.com>
Message-ID: <CAMuHMdXvH1mYeGazJ5TpsuiA2+Ly19p1eOhti6Mva81S4u0f0w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: renesas_sdhi: Add compatible string for
 RZ/G2L family, RZ/G3S, and RZ/V2M SoCs
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 8:24=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> - RZ/G2UL and RZ/Five ("r9a07g043")
> - RZ/G2L(C) ("r9a07g044")
> - RZ/V2L ("r9a07g054")
> - RZ/G3S ("r9a08g045")
> - RZ/V2M ("r9a09g011")
>
> The above SoCs have HS400 disabled and use fixed address mode. Add a
> generic compatible 'renesas,rzg2l-sdhi' fallback string for these SoCs,
> where fixed_addr_mode and hs400_disabled quirks are applied.
>
> For backward compatibility, compatible string 'renesas,sdhi-r9a09g011' fo=
r
> RZ/V2M is retained.
>
> Also rename sdhi_quirks_r9a09g011->sdhi_quirks_rzg2l and
> of_r9a09g011_compatible->of_rzg2l_compatible to make it generic.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> - Updated commit message
> - For backward compatibility retained RZ/V2M compat string

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

