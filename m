Return-Path: <linux-kernel+bounces-157099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC358B0CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF111C23A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858215ECF9;
	Wed, 24 Apr 2024 14:40:37 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABD15ECD7;
	Wed, 24 Apr 2024 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969636; cv=none; b=dKJr2d9nDrtAeWpJb02pnIzVNHSoQrjH4zz6GwVh/7i/+89eYWvUiTCRhn2yMmZPaLCaMCMvNTchVZ8iF5SpyhAP7ID+btSA7+r+xHodDYubaRHvMwNRbDSQ8GImsZdlqW+4vTGW/X4PSU/UeWEHuaUfDcACG1i5Tb2nawsHc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969636; c=relaxed/simple;
	bh=/P16XX5iWdneekJXphwtShIEaCyHH6GK3VIZXrRz/bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smptyZ9Qyq3/s7tcW5hrPTYqoFzMpW7yGMIgWWPVaQxNS/UeNuvcTzu8Nb6MD+AKbyhRSIFhZHF0vZTawev5G3cPxzBjjoAMRf6WobqUb9CzLIVzOTERWzh23xd8V+0qJ11pQ6CtPlWejefceS9OO7oMhIyo1vEolFLHhkOQsdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbed179f0faso806660276.1;
        Wed, 24 Apr 2024 07:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969634; x=1714574434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1n3iR6ddwYoKM5lE0EM8akCCCwsZIPBSCjAQL1WN9kE=;
        b=TBRVPnu6iFoXPeDs7mZpzcQjfqp+5bBrRWn36jqIyKlUMJ5zbhj33zypuF2Pv4a/vI
         4yb1ZsUOGEaiAnPLK1iBpilekzL/y5e/8yOOz8q7SfvOyMVodvRXVs81KIbuOiDi6mYe
         44AvJwoboZBYor8IQ7pJT3ibdX2d1RrmAS313Nl2lK9HP2SKNOPs/XiIj5HdHBEbr8+B
         VWgKafTTteoWx0U1rfMSYf7m6lcFgVN/Xoin/7f249gHE5dvaPOghr1kGl3JJGshTUnW
         2kFPpZ7yJNRGG+Cph4DW9HFRVVnUKBixVonO6sv1zLjv0hwS5U3LXq/5cpXhbPZxUI4n
         NOzg==
X-Forwarded-Encrypted: i=1; AJvYcCW/b2i5ML2/vHWDkAHlnLyYYakavjHjQwEB6GjmKUV9BH/WWhumqOwB71twAbrn5fAFGTfmKQ1Inn9qqbFE/MVBtYL1FlunLWaH0vB26cGlmG+/DA0x97BrD5G0uCTiBgovptJ4H4biQNJM/fqSMrl6Ud7EPOYvHQR8d2r9/+xB64w5VMDzR27m7pv8n4mXNNJ8aAVlV5QQ0bQlOOxOP0OUmm5hz3Fb
X-Gm-Message-State: AOJu0YxtU+/L/lbO9u1XdceYd3CTS27p573Biq20iMdnzDQOGI5my4Ci
	i5A/vvbs7pOiAzNMqRkcMaPztv1CSqbSCNcNXPm467FMaHsArwwghwGiUd98kPs=
X-Google-Smtp-Source: AGHT+IGu1PqjQjvdPGqkbcXJMFXwmMORdq/2N41Fl/yBcVCPkL8oIYEDBkguAcFui59/tCtapstS4Q==
X-Received: by 2002:a05:6902:c0f:b0:dd1:6cad:8fd3 with SMTP id fs15-20020a0569020c0f00b00dd16cad8fd3mr2305063ybb.27.1713969634164;
        Wed, 24 Apr 2024 07:40:34 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id y6-20020a056902052600b00dcc234241c4sm3126656ybs.55.2024.04.24.07.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:40:34 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbed179f0faso806646276.1;
        Wed, 24 Apr 2024 07:40:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSB1BFwr2JlZjajEJ6NqaPKZBv6oKMFBJtXMJwjgo9WsJ3XF94E0DyQBILFLjBrFqXUpWllxUkQW3ALaxzScSIPR2rl15DqJ4yvSQld1mfha8DUUES49L7qkTk0N9Ps52/wSErpuNbdClQJKoRVC6xW0q/CjiHhl1cEwvlJL7TMqGxsdb68EPU3Np4n86ymA5+6rNic6LFrErZsQlPJUiRwTRA8gPo
X-Received: by 2002:a25:8485:0:b0:dc6:16b7:7d6f with SMTP id
 v5-20020a258485000000b00dc616b77d6fmr2151264ybk.10.1713969633810; Wed, 24 Apr
 2024 07:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240422213006.505576-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240422213006.505576-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 16:40:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_cUiBTv4UDp9kvbkqKxULsW98iE3dxHxfvuuP14vKhQ@mail.gmail.com>
Message-ID: <CAMuHMdX_cUiBTv4UDp9kvbkqKxULsW98iE3dxHxfvuuP14vKhQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: renesas: r9a09g011: Update fallback
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

