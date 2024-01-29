Return-Path: <linux-kernel+bounces-42787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301EA8406C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A1C1C241DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021BC634F0;
	Mon, 29 Jan 2024 13:24:30 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E48634E7;
	Mon, 29 Jan 2024 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534669; cv=none; b=uO0K8DWJhAdp53T2CGUdmOyG8uJcY3lFYsGIiaPQUY1ctv8Jbqm+GhACYEvCZcI/VsAGn69taEmGnLJExLv3WC/NnFNn+Q9D5o+BKCpPb5ABMpf6LLKtwfNzvbdIr4C9vq4gFOtgyhBQwnx1e3neMQ+tSoyoUbS9VDoMPnuK/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534669; c=relaxed/simple;
	bh=MaNdJSmcRmSoKWAWXNV6XJ3Z/352Xc8kckkjeiHFpn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTZVnNlGxIeXD+OO88XTH7WE5BnursAlDKiZDjphS+B0IDh30NO1CKU7D5HXAGjFoFLxc32HcGN/ZpwnZE8D99VFfmJyYwZRC6j3nx79f1jo0Jv5Bu2Cb5NWKrJ9TMlioBixQsmT2FOr1M609dhKihSeNVsgVN0xjCmTlyuEU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-602ab446cd8so26499057b3.1;
        Mon, 29 Jan 2024 05:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534666; x=1707139466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60bQeQ4OLSEiw7dGbd1NiVHh4XdBGJExrqOIQcNDss0=;
        b=Js3uSvvore/iXnNefzIyvelUBRUSywv2T69Hv9M22Hi8vi9fv3uNI2OXvyC1yIySNC
         aDEJ5sMfSRlMtvvkM4wKg+emlmyu42uXGwqpogejVKsLTcsz1stYUZeiDsiiDjEueJFU
         +TBQAyYvgn5YveHJKuv+p2C988A3W6dT6toxux675tOqa4CIjI8GKJ19W3BOAU+G6Uvi
         GXvrcVGPn4BF+6LMWSjHOKkw75+eX9EnEsIgSXgyNsFTJm/W3lSYtxClX/h2kZ5mMRbt
         5ZwAEtXkPd95KJTFVv+A9BPddhxT/Ob9CykGSRCbElYAuN3TV1OREtb+Hr69XGp9Zyva
         iMAA==
X-Gm-Message-State: AOJu0YxMgaANt5JlnL7lebCkXoTl5gNMFu9ZwFUkURaR+81wU+1sNqK9
	FY+drh1ONJfL3MzYvEG2hFKEqE2gN+6A3wb1+2Fw0n+Za5bcAhQYe/RtlQ0FO1w=
X-Google-Smtp-Source: AGHT+IEEGHiW2XJUkOVt9t4Yty+4Oq+ZJE3BDAnGN5akOpUfyFzcMJhqZ+5Mk3T79Pe278ga2YaaHg==
X-Received: by 2002:a0d:d4c4:0:b0:5ff:7f34:1e92 with SMTP id w187-20020a0dd4c4000000b005ff7f341e92mr4065766ywd.98.1706534666153;
        Mon, 29 Jan 2024 05:24:26 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id p64-20020a819843000000b00602b93f6f27sm2465433ywg.120.2024.01.29.05.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 05:24:25 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-602ab446cd8so26498827b3.1;
        Mon, 29 Jan 2024 05:24:25 -0800 (PST)
X-Received: by 2002:a81:c444:0:b0:5ff:aa81:b47d with SMTP id
 s4-20020a81c444000000b005ffaa81b47dmr3501080ywj.88.1706534665529; Mon, 29 Jan
 2024 05:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117131807.24997-1-wsa+renesas@sang-engineering.com>
 <20240117131807.24997-3-wsa+renesas@sang-engineering.com> <CAMuHMdX7Z8w0JykKuboP__ZE4x+LeKSQAGdyrUezERxysPUCKA@mail.gmail.com>
 <ZbPKPGB7DIHhZ3GJ@ninjato>
In-Reply-To: <ZbPKPGB7DIHhZ3GJ@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jan 2024 14:24:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW6KV0Gh-JA8x2Z_vj2n5QPDLLFFZRNLUg2rdc3wFqChg@mail.gmail.com>
Message-ID: <CAMuHMdW6KV0Gh-JA8x2Z_vj2n5QPDLLFFZRNLUg2rdc3wFqChg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] arm64: dts: renesas: ulcb-kf: add node for GNSS
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Fri, Jan 26, 2024 at 4:05=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > Can it be used over I2C too? Is there some strapping to select the
> > interface used? I couldn't find that in the documentation.
>
> It looks to me they both work at the same time. I was able to write and
> read via I2C (thus not very meaningful data) while serial port was doing
> the real work. I am not aware of a full GNSS implementation supporting
> the I2C interface, so I considered it good at that point.

Indeed, drivers/gnss/ seems to have no support for I2C yet.
Queuing in renesas-devel for v6.9.

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

