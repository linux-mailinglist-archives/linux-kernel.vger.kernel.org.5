Return-Path: <linux-kernel+bounces-150232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA098A9C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800121C2119B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3AE1635D8;
	Thu, 18 Apr 2024 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nTdxmyn6"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C39165FD1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448839; cv=none; b=BqPEW8fPyBvtO/baj7Ob1r/AE23Kahyg3lk+oD/V5G62n8h61hwiL4QfqtkldmLdsp5gJwoEG+HHZkl0Kjp0cQroGFVcXPRCL9EyAyWnkNX7mcq+ojObFGGMabBT/PLfvaWiehBmUeLZzHUS+PwC9yiXeo23UDHpZhp3luXJtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448839; c=relaxed/simple;
	bh=CUz1FL6OrWD9gkCWSmzSXTuA30S6H+md2CZJdOSANdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxjS8x5Uh4MDrr9tJ/DBYHJhiShSApwapaE586JSiD8/ux+9cfb0z03ei+Ecpi5kwYshqoLl5wog52oKRNCib9XX3Ta/KIBJyOndEejBDBNZGSFEXayvktsTX0LtReTZzypnzO60TUKRNdUFP+5Sxtkc75BbTJ9HOnU3dWgFfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nTdxmyn6; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de45e5c3c68so1069078276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713448837; x=1714053637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfdRxoYWFZnh1Pzjp/pkGuOdpYAMzwLC3mfVu9MRkXs=;
        b=nTdxmyn6gEFreaudLtwHACCjfLX9/3zbcDSjYPD09faiP+3QNjbxMeoT0P1iGlCFtp
         WPNilWwIL0A/yGuy8GsbFyJzL7j1LO09AlaMaOgOdjjH2iOrs2LK+61VidwLbXmxAUQg
         EL/lUHdxCC9fd51YP4HmNxnDbKSmZqUnxjAOdDHtivab78/8DMqx4dbsA5es043rLdhm
         PakDyDT8tuPOyw0MaZ/6vtaeBuVI/FJz5PDQAnpykz+oGEeqgqrpCEDsn2GAkb0B5zmc
         G0SmJNuwvTDKMcRh8Sx2WWAq1I3YNWHqQQxkzvvwreVQEmOElrCorXwFk6MIUSE5hyPE
         CO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713448837; x=1714053637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfdRxoYWFZnh1Pzjp/pkGuOdpYAMzwLC3mfVu9MRkXs=;
        b=Loj8gtvEUp/T/qaQR9k2Lw+NnfYXDOOjdV6af5ST+zq4s/2ZRzTZlNfGQ/8Fl0dnnn
         vb8dMrkM8JQqRw+xXWIiKLcd2PXVk7fUS6GjaCNbxeMwR3afOW/qv9qdZ7TTadD2F3CU
         fzLfGlv6YkF0ALplQSUHemzrVjy5z4UR9wKe2yhdo7nXBlY4Ovpey47XA68MGDTu9auo
         nTiv1yj0WStcP/ioYEc9fv0dMI5aMcJJemkhl24m2FsU3a7MOdEa/0tTBt/1WoRY8Z2x
         eq2N2si0z4JUKbPOgC8wbGNBZB1FSxgZ1WoLIhW3NBSeumEAGRtTu64FEqDMkX/wm08N
         fTvw==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZVepoTkWjtttZynL44GsF0k/b5ZFdwAWbSMh0yhy3ERJDce64GUJ5dN/JfwWyH9oW7+uzKzDTDz5nntpiW7XN5cP1qVYQVtV1+O/
X-Gm-Message-State: AOJu0Yz2WH/6YG1TqW1jhYzkB+b7UXNJOaiuz10u+9Q2Bf7+FNQrZZwB
	VBv5yjbxJEHJshBTmXQxJlxXvlXs2dbG3PlecC420h0dNpO/sKaaXr9AGZZ6tZ6vyW43OwyjwNj
	OjPQPdA1EdQP9K3/M8EqddXr2VQqr0iTpfQH7lQ==
X-Google-Smtp-Source: AGHT+IG6AB7cK4gQyrTBcYydPTwRbBVUhUDB6blxZ1fiVtij9UP56RzjDgGZ+5mPHYa0AbKtxwlXvMzWeyimBXDNk1Y=
X-Received: by 2002:a25:ef05:0:b0:dcc:96db:fc0d with SMTP id
 g5-20020a25ef05000000b00dcc96dbfc0dmr2573050ybd.25.1713448836586; Thu, 18 Apr
 2024 07:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
 <20240410071439.2152588-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=V2J=Tth2zhpo-kPo4uvESt70mFneO2V6TV-haac0VZuQ@mail.gmail.com>
 <CACRpkdYtM=5jdQddCqRFgBRXvcJEjk1ULJNKKFz7jhhkGxV59Q@mail.gmail.com> <CAHwB_NLfaQWhFSbZ2ASmYgXJaVOTrjac3F0hyCJdwTTo-zHJrQ@mail.gmail.com>
In-Reply-To: <CAHwB_NLfaQWhFSbZ2ASmYgXJaVOTrjac3F0hyCJdwTTo-zHJrQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 18 Apr 2024 16:00:24 +0200
Message-ID: <CACRpkdYoM40RZyjTxLwDNta2+uV31_zzoj7XrXqhyyqrDtd5zQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] drm/panel: boe-tv101wum-nl6: Support for BOE
 nv110wum-l60 MIPI-DSI panel
To: cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc: Doug Anderson <dianders@chromium.org>, sam@ravnborg.org, neil.armstrong@linaro.org, 
	daniel@ffwll.ch, airlied@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 2:42=E2=80=AFPM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:

> I learned from himax that even if the same controller is used with
> different glasses, the corresponding parameters are not fixed.
>
> For example: _INIT_DCS_CMD(0xB9, 0x83, 0x10, 0x21, 0x55, 0x00),
>
> even in the group initial code, the same register will be loaded with
> parameters twice.
(...)
> So assuming that the registers of the two screens is the same now,
> it cannot be set as a common parameter.
> Otherwise, it may be a bit troublesome for the maintainers.
>
> If necessary, I can break out starry_himax83102_j02, boe_nv110wum and
> ivo_t109nw41
> as separate driver. Then add some define to these registers.

Why would you do a separate driver per panel despite they have
the same display controller? I don't get it.

Use one driver, use different compatible strings for the different
panels and use the corresponding sequence for each panel
selected by compatible string.

For example, see drivers/gpu/drm/panel/panel-novatek-nt35510.c:

static const struct of_device_id nt35510_of_match[] =3D {
        {
                .compatible =3D "frida,frd400b25025",
                .data =3D &nt35510_frida_frd400b25025,
        },
        {
                .compatible =3D "hydis,hva40wv1",
                .data =3D &nt35510_hydis_hva40wv1,
        },
        { }
};


Take some inspiration from this driver and how we parameterize
the different data depending on compatible string.

Yours,
Linus Walleij

