Return-Path: <linux-kernel+bounces-135223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DCB89BCFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E216284914
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE3C537FA;
	Mon,  8 Apr 2024 10:25:13 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5552F82;
	Mon,  8 Apr 2024 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571913; cv=none; b=SyYQG/QpwaZ8gUdQ/TuRrsx59Khbv6VIfImENXGCwUWq59SAlnFPuw49xjqr0kqbDL3X/N1VH6hura2z27NeBdEG4ylgJRuYs7GkL4RjlePvrDOM1BJsIM5BhyffHs/DmGfjgWVn9XyhEu8lnAO5uOa3ODZqvc0+480W3YX6TNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571913; c=relaxed/simple;
	bh=6PQHuZtbGRHNbt2CiLFJi5hZAOYL4NFFgPtNkjEwCCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3ua5NIW4VDaclbqW+tP+4PLI4iJu4k3xGivSX2QrnjP+afzpt4gt1P7ntxN8zsy6VKto7N1kkkzE5ttdL9Nn+cA32J2SrDNV/Kf1jAkOfjtsf4PBsww9HKWo9kC6f1SoVvwSi0efTfvTiN0Qs+V2pp7OfcMvn21KV26d1NHn/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6152088aa81so45936057b3.0;
        Mon, 08 Apr 2024 03:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712571909; x=1713176709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xilN0xXrZoZ/rcurnvscBoInxVNoO7pN3wIittGiLGA=;
        b=p9FNFBvh0qTal4L6z5/dcvtuf/dVy2ruapnIemVv/0icy2R2Ou3zGytKmoZyR7JuW8
         zi1gg2VNA3pYOrlAbFIbOB4IksGRDvZIFAqy4WbMbXLt0+Yh3wVPAX5+8q84LnljGI+e
         hgC4hB0nr2M/WPdMJO0mClPCyjDA7h94AUmbBwShOoQMt8F/TUoivZiotYNQSQYamhd8
         D4RLKWTo0amM58/EyHt/Q3CMH2KeIyveflFVZUULhZV/MTrhvuvbZx0E3qW6PCVij66G
         Qz3pbSI2Ux1JdYkrapkQN30JloWn1dVFaxTNhSE5qcZEraWPI02ukbu4jVEcmhtX5Gpv
         AN0g==
X-Forwarded-Encrypted: i=1; AJvYcCWz8L/ytye82EFhEy9o3K4rTJN/4LjAhi798Q+M95XCKNCL6fVDCgg7KlkC6T4QUpdCW78YR70xw0cssZdmtZNMr6gS1G+TJhK/fK0yAmY3Cr/ytRGFc0Ig4XoEC3DeQbpNT4N4cKqe/5pVjU7ihFilga+XYpi4ZQ3zVP30sxEUM75Is4485tcMwccm
X-Gm-Message-State: AOJu0Yx7DTMs9BOvIw91zSUkFCMzUrp+DK007FFHj4PjkBaJzkqCjSn6
	9eh0ayR687pRMeDSZ8zwOx/q/0iH2j0Doyt6DckD/K/mve9u/ki77JIonON5IP4=
X-Google-Smtp-Source: AGHT+IHkdDgHrgM1eQ9UydRBI1WP3cKcLXxNb1ykXdmhVvMw7D8Ml6OYeACRQEIUxAYvmxXjSQ+yHg==
X-Received: by 2002:a0d:d40b:0:b0:615:22ff:b57d with SMTP id w11-20020a0dd40b000000b0061522ffb57dmr7596592ywd.42.1712571909494;
        Mon, 08 Apr 2024 03:25:09 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id s17-20020a814511000000b0061813dec952sm249526ywa.1.2024.04.08.03.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 03:25:09 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso3773293276.0;
        Mon, 08 Apr 2024 03:25:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWeYJ6ZqVFPS3zCqT5KVYLgjk25/Vl1cirvy624DZ6cty/rh5FLIYbgBEaWrMhoLn/RX67fG4s/TtTUhv5gu/ov/iHUbFB5gVJsaTNJU4XVjj4AbqySqde/9m0bK6QQ25rSwYaeJtZES1oADSlSvE4I6P9x2jD/Xpjm97DiRhKWFfCWytWtp4L7tEM
X-Received: by 2002:a25:dcc4:0:b0:dcc:e187:6ceb with SMTP id
 y187-20020a25dcc4000000b00dcce1876cebmr6303357ybe.17.1712571908970; Mon, 08
 Apr 2024 03:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328065738.3049316-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240328065738.3049316-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Apr 2024 12:24:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWtOeUZW76oe+S8-_-1F800NhE3q4of3TFVr8vp_j403w@mail.gmail.com>
Message-ID: <CAMuHMdWtOeUZW76oe+S8-_-1F800NhE3q4of3TFVr8vp_j403w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzg3s-smarc-som: Fix ethernet aliases
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, robh+dt@kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:57=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Fix typo in ethernet aliases. U-Boot uses ethernetX (X=3D{0, 1, ..., N})
> aliases to update the DTB of Linux with MAC addresses. The ethernetX or
> ethX aliases are not used in Linux by ravb_driver.
>
> Fixes: 932ff0c802c6 ("arm64: dts: renesas: rzg3s-smarc-som: Enable the Et=
hernet interfaces")
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.10.

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

