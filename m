Return-Path: <linux-kernel+bounces-68690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F0857E77
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B148C1C2511B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238512C531;
	Fri, 16 Feb 2024 14:02:45 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098D12BF1D;
	Fri, 16 Feb 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092164; cv=none; b=USSOSyIIo6KVHo5za7CSs17gS6DxL/yjFN01u0hzErTrJwZYn0moLIfIE6UnQzf6IUnejocXvfnBc3gAv4UrdeIXyXSBsc8mwk5Y/jOOctT7YwCVijakB6H1IIUkoEdI+0eNMu2tpzcD72Actya8isqcdB0g4cznTETWhzWzUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092164; c=relaxed/simple;
	bh=saxZgwZCgYNTc6/zL0jSZwZvnJFXmPohhFYyCQsuK0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ly46Dbb7k7n3EOU+2+bbOB7ultP+wrh50bHvXsPucCvMROI+NGFBV7Ay58p23fik+r3Q93OOhXhllcvobQ6leC4xjUQR98bvWFIIKYVpwdUhgngFIV4r0OlBTzFhrrXQtIrqkMxHAUQI4sF5IE1j3fWS8rBK7EMKmFmdTBenmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso2172447276.3;
        Fri, 16 Feb 2024 06:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092162; x=1708696962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvA+n/hlz0w5VlO4pipSSw3lBcaAl9ag73pmB0pWksE=;
        b=ikR7uiy0CIc4kV42Qcpapfke6c3Cpc02TqXzMlNV1BlOt/W2C019rUc4vSP8B3p2oy
         PtEpVcnuKkyB8C1SBKjznq9xKJ/pCjZEmyKMK7vkpPhM8EvfgO7KqanNqEG2lRFDXh0g
         /F1me86i23RRNqzO54ij3TeTXPKI/Hy3++sa5l5C1PVkX6yzxjXuhfezV66jR62YM2ZG
         /kcVh+rS9Tf1+xezsY09YpJ1b1cL4REILPCeyRRtTf2G/s326f3Q6bi3MNlu3fv+JjAw
         mhobT9bOuml0fyrUpZoFpHdWYdEVyyu8swFN/86qag/Fb5u+v8jIaBLuKqP2Q2jGFzfD
         bcwg==
X-Forwarded-Encrypted: i=1; AJvYcCVMZjHhcBv/snja45rdNMyk/Pdgmp1aUBWdXqhX4Fccy8i3ibvKy3DdVLTiZaoJwxTL9fnzPj48FLnCinJKqo3rvq9HuUSRgi1lC2yZULqI5K3djEiY2HljG5o//QayUSTlrRSrP5X+0YFOa4RUFK1p5yxJ9maNs13433EhuyhS2GEZj9+MMZxjvTTI+sjDo/56VdMZflq+FB/+jmPvniAtc/TY7+/i
X-Gm-Message-State: AOJu0YyLFGS9KbeNGed4uLTHwMT3ZcziLfI7gelTTeCWRCOaPlBRVztQ
	Ds//uzItMhl9ZhasJvqF+hlmnuFz2QXWEhEQ6mkR2sYI/V+qYQM2k0ZQTF5FNVs=
X-Google-Smtp-Source: AGHT+IE3IVd1t0yhpt9UdCdxGPeoBiUwOSoFzEakjPBpozOZi1GpF15Pi8NcOnPilOwPCbPHNo/JLQ==
X-Received: by 2002:a25:d388:0:b0:dc6:4062:1341 with SMTP id e130-20020a25d388000000b00dc640621341mr5069526ybf.16.1708092161749;
        Fri, 16 Feb 2024 06:02:41 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id i126-20020a256d84000000b00dcd25ce965esm321388ybc.41.2024.02.16.06.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:02:41 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-607e707a7f1so15197627b3.2;
        Fri, 16 Feb 2024 06:02:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUESBV//jSfddCkKfCS+P5S5U+lbU9yiUf/hxREBLYjDK4NHSFC80eBsvF5JPQxZ/ducA1riB5jL7gzIqvyrB3Y7b4m79seZd4z1C9DOG908Qq5DOga6CEqXUtOGU/yM34BvQSpK0BNaYzrUzUj8xMon4Ff4z/zRVNe2U+MykiaYFgZ2IECSLe3ZF8Lxh7mxhconS8+53D2gddqdoPInaFgiklb25EH
X-Received: by 2002:a25:ab86:0:b0:dc7:465a:2cb2 with SMTP id
 v6-20020a25ab86000000b00dc7465a2cb2mr5366370ybi.30.1708092161385; Fri, 16 Feb
 2024 06:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:02:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVJ0OywBOJ16RwXGUCUPNE2aFBiZBrwOuxPgZ_YXi-gkw@mail.gmail.com>
Message-ID: <CAMuHMdVJ0OywBOJ16RwXGUCUPNE2aFBiZBrwOuxPgZ_YXi-gkw@mail.gmail.com>
Subject: Re: [PATCH 02/17] dt-bindings: clock: r9a07g044-cpg: Add power domain IDs
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:43=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add power domain IDs for RZ/G2L (R9A07G044) SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

