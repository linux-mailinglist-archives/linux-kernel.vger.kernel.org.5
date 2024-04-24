Return-Path: <linux-kernel+bounces-157102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC498B0CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201F21F27A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FCF15EFA1;
	Wed, 24 Apr 2024 14:41:36 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508BF15ECC9;
	Wed, 24 Apr 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969696; cv=none; b=j3xjXG9PxUo6PfkVsJX5J0BjBRXICHTl2INWb/jGEA4PvTU7bMGkgjsa2RLvJnRN426EDIW3Mxrjj43GIVyeMjI5fMDapv04E/GxNZZPR7tDZtsnz/zyDV1NsB9b9n/p05LWFBA/dCCee4H1Ut8Ueda0ZfPQp/zG2EhWeEsoSXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969696; c=relaxed/simple;
	bh=/P16XX5iWdneekJXphwtShIEaCyHH6GK3VIZXrRz/bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSj1QMqQBR91TJlZns5Pcszj4QPjyjRKH68WRC80guVUmfZddbuEAAhS7CySC3onnLiWeMLlJ/01q+GkilmdBW3YIj7GQF0ibtgAap8SEK27UX4fY3KtQphG4ROCj4J5TivAGJllOdkjLrsQCrOzFzEWbOwbfwdNH6/tO+E+hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61b3be24dd9so8693367b3.0;
        Wed, 24 Apr 2024 07:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969693; x=1714574493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1n3iR6ddwYoKM5lE0EM8akCCCwsZIPBSCjAQL1WN9kE=;
        b=DIW+1RE6mmSIZPwSzsYSvloS+X2JkRCcCiky0dkap+JqLMetFDxp6Sjj6ESzU/VZT9
         vXe2M48l4wy5aw2IM0Dzc92GWzPDONW5Y+9Qv+krzvH6H5oKsD2qaIpRsTCZwdS/lzqa
         AgU7vHkCOem3iuad8F+tHLGkmWGYz2mXPYExlSb4wen5uudUV2rIbhr/ZWxjShpEPFiX
         fvih7cbZxLMr7ioBd9uKLnXJAAd/AiLPRG36yIMiFIVUAlU0WF6FEVnz2eHoBZyMoJ0E
         2Y8KL18d2Wc8EfbztVVDRjeXOxA6cACHHgBdmTQI6OZkVtuYqXxwuRSKB5rXyXNj+03D
         8dvg==
X-Forwarded-Encrypted: i=1; AJvYcCVk2MI8u4fYRvA36Neq8sbO0GvfLxNWDEvVsHSq6eaNH+kg5XtKRZh5Pj7XgUvUS5J1NlA78sRYmKJZgRQjuFLeS2aEiZDZd1NkgAy8E+jeKINLWDihUYwaRr9SRi4qXItSdGovbEit8GLYkuig+rew6h/wwSufx9BSYdvng+t+vgeW8gB/mVDhdW/APNODSbc1f2Aq4eoGF5zWAlMremL/YuXcpehJ
X-Gm-Message-State: AOJu0YwIYz02u8FAuNbir/rlz54zr4EYm6n2uzpQenJcJnli9EdQIgDl
	iSScuqaanwohWnc64J4I4MMY23/+Zhr8WSMr82AypDieJYZqWnykgPaB9cFm7PA=
X-Google-Smtp-Source: AGHT+IHGGKd5kIRjh6WFFLHFKXcg8ExfG/SYZ2hRGsoBmUB6oqWtGDD3y5X1J6OeN49cHnaOmsEdMQ==
X-Received: by 2002:a05:690c:3382:b0:618:5c6e:9291 with SMTP id fl2-20020a05690c338200b006185c6e9291mr2222823ywb.17.1713969692903;
        Wed, 24 Apr 2024 07:41:32 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id i134-20020a816d8c000000b0061b09824e52sm1235915ywc.7.2024.04.24.07.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:41:32 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so939185276.0;
        Wed, 24 Apr 2024 07:41:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrKz5LgCfKagErZPD3MGAqZ8UffhmZ6XaTDMgqIHoLoH+iwaPuiTqpIp9xdfniry/P9Boj3NaKa80qtQp5a0ccCTHDRa9ZTRcZYOYDVZD/9GucBvkx5h3K8Agbqdr+r9RW4QyFxULmyZU28MAe1e7X33EDPjxBJe+Ox/2Wtdy2CmpgNWU+FejSXjzYOaP6nCZShct/t/fm271YoBVb0v19fd02ROVR
X-Received: by 2002:a25:2f8e:0:b0:de5:5e85:6fc7 with SMTP id
 v136-20020a252f8e000000b00de55e856fc7mr3217864ybv.9.1713969692429; Wed, 24
 Apr 2024 07:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240422213006.505576-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240422213006.505576-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 16:41:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV6qy_L7EVYw73iA0hNmZS+mMPSOQPdfhiT2xJ3F9gaFw@mail.gmail.com>
Message-ID: <CAMuHMdV6qy_L7EVYw73iA0hNmZS+mMPSOQPdfhiT2xJ3F9gaFw@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: renesas: r9a08g045: Update fallback
 string for SDHI nodes
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

On Mon, Apr 22, 2024 at 11:30=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Use 'renesas,rzg2l-sdhi' as a fallback string for SDHI nodes, where
> hs400_disabled and fixed_addr_mode quirks are applied.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

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

