Return-Path: <linux-kernel+bounces-150378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737908A9E35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B2C1F22999
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEAA16C6AF;
	Thu, 18 Apr 2024 15:21:37 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE716C6A0;
	Thu, 18 Apr 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453697; cv=none; b=p0AcoXma0brM8CBHAx3LF6pZuO7IaSCOzNSaf2jqHcyJIIywB7hiCnrk7mrP8DeZKUwIpzI3Cy4qgcGc3wl5gHcEP01fn9h2jflz+/dGhYPo5erlvHrEKdcMJ1czxNkMSIT9vxN5g9qyA61a+fJ8qUAOcJOcbAGEsaZLoIzIf+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453697; c=relaxed/simple;
	bh=7UYcCUeYn6Coe86aauPHZ6/NFvTa59LJUiHO1ntopsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmOagAXua71zFzRQmeWt/vEmZWdWqf6PNEPN9RssEMgGiQtQWhkBhPtIx0x3tNNF0FOxQ4KQCkeUAh3ALl0qWIZpXme64//0NpKsEA8n/WGBgKabVyG7X2hX4ENC1mPsiHRKk+e2g7XH1uHnUUrVLnjBWUstGdItULuRm45UR8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de462979e00so1267030276.3;
        Thu, 18 Apr 2024 08:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713453695; x=1714058495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+69YcfMmJc9DOa/fxucqvVTNDdF8csV69viBtfool8=;
        b=W7NWlxs6iNcoyD2IBh0x1R0u+PtYt0aqm1NT68q+cNMo98YJt7PZVjxNFHZRRNWvNv
         x2Gyx+TIV563+ZmBPc5QyfdTaZduKULqZilp0je5bjS4nyny+e76h0AyQSQYmDGgp80L
         SVp1Mqc6AbGj0GL5LO56fsNSuPFddzHFTKtjdq6Omwpuw5o/opvAxxkOjrB+OvBw0OX9
         SPWUqBkSpfjv7ioEnkXYRpcegRFcb41aHbDmU646R7SVeENedl3wvVXEfq5JNjPVW/na
         X6Yyn8S+ff+m2bibLdAZdSYzkEwhORZaIuLLOvsvdVAMBmv0UDTLszd7BNl1/tZ/HTGP
         yYgA==
X-Forwarded-Encrypted: i=1; AJvYcCUezGbYeUokJ5U1l7p7V1eGphAwKQXhXrlCOCu4iUn6E6fshpGM2+az0+cqJWg7oAhtrA1M/OcD1NRLCMe6m/07jZFTHK2ntdDXy1Jx7kxGVce4+YjyuqUnhNGI3/wxRGijZIh90JkSgoyScI0fZVTfgF/PS0xV2qCaS5TnkgWAz01/VcqzW1yIGQ3/
X-Gm-Message-State: AOJu0Ywmw6DBrSOC5R/mhKK3faLm9lxeA1prDcGcZzbt3YoVT2Vihqt3
	dpTKXSfqGkGBLOfgZx8Dx/7IVuKC5uV08FmSBPO/ARnSOhLRNT5JgunTB5H+
X-Google-Smtp-Source: AGHT+IFRzi5o6EGgWbMuGvJEhg9M+n6oLlbtaSwEcn6drUQWCWPLfRUH6XeylcZJ1Zrbe60AHw7FaA==
X-Received: by 2002:a25:938c:0:b0:de4:68c2:423d with SMTP id a12-20020a25938c000000b00de468c2423dmr2000703ybm.14.1713453694856;
        Thu, 18 Apr 2024 08:21:34 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id v16-20020a258490000000b00de0e1b77311sm395336ybk.15.2024.04.18.08.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:21:34 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc71031680so1063319276.2;
        Thu, 18 Apr 2024 08:21:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdsJq70BYu1hso9oz8BZ31p58yffY2OfpYruaa9EeXIrN1e9upojP2syuptxGO76pb4DUblozxWyjuqO2+i56dmLBV2eOqAnGFDApLrUP3uKE01UJtujflXwmPM9rxw1TiFRpKEU+x9IhNRz+HMftYTLiq2CQ4wp57zBeH/IjrKvGz6oqFDG9OSPcW
X-Received: by 2002:a25:aa49:0:b0:dc2:2d0a:4d55 with SMTP id
 s67-20020a25aa49000000b00dc22d0a4d55mr3040669ybi.63.1713453694453; Thu, 18
 Apr 2024 08:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417112003.428348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240417112003.428348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 17:21:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUAe7hCA4=6H=xHSOEppE9fvGpjzLGynvPR8cy_XXFzKA@mail.gmail.com>
Message-ID: <CAMuHMdUAe7hCA4=6H=xHSOEppE9fvGpjzLGynvPR8cy_XXFzKA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzg3s-smarc-som: Enable eMMC by default
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:20=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable eMMC by default on the RZ/G3S SMARC platform, as previously done
> on RZ/G2L boards and other Renesas platforms.
>
> The SW_CONFIG2 setting selects between the uSD0 card and eMMC. By setting
> SW_CONFIG2 to SW_OFF, we select eMMC by default.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

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

