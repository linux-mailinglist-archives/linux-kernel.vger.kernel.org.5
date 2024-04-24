Return-Path: <linux-kernel+bounces-156951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84558B0ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C832848C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8E615B99C;
	Wed, 24 Apr 2024 13:24:34 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD715A4B0;
	Wed, 24 Apr 2024 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965074; cv=none; b=oeFLxy0c9K0l9Q7KL/eRMXuzL5UnuAksBHXPJLFCiKvQfPdcP/fRiCGgi6Eo4NAQasQZ8NucMqWf5pqSmgfZVQgX3rSbJYM5oaRjsg97LIL2hov+uI1SfNm5rzZ4VIYlXlVOC9avthitXU7E0v94AoqSC9ISsC0nRW8S4wVFD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965074; c=relaxed/simple;
	bh=Q3m87IDm/Ct0o/oCyeCmHB+FEV7YHiiEzkX+PjM5SsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hovd7/Np6h/K4V/ctlwDs+DzZcTdoox9xzPQut5Iah4I1dwso1pdsBvVN+cLmF8Glkik+OUciNd+JKY1zmJbrG0UK3uDVsZZ8ZSD12jHlpiCzEV2jRmvwEKpqW9V3K1gLQk4wsQGw3QpvhKFY9WDApgnbufQRT6sD2ncWA8q/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de466c64161so7158375276.3;
        Wed, 24 Apr 2024 06:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713965071; x=1714569871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wl15hx5/hiafLFkb58MOP001kZ5yZtElePF2wRLPMEg=;
        b=PDfU0CIIfKwpHdgKEuPArnE0w67NI+QAHVzPzQftL9SCWMcRqlfDikueY4qoYfjA7x
         tb1/FNrwF9SDnczYbdxuiPrzMcSFIL4QHr44aj0X1MSzYszRnocEVnTghBfIRnDD6CpM
         3Z+SCixXjSOUxl1JcV/VKgaQfzhBUvALGz0i9qNUouY3b4yz1u24kyiRhAcPFtuP2DWR
         7wgbB+DVN3gkdj+XMzQ+AnjJe/ba1xbxgmcWIe+qEGvLxEzHP51hFgAIsTHH565n4Qlk
         JHl1uRpFqCgolEO2EEr42kmr7RpXB7G0cqxMuPhNZ1cydRMV3OQcqQ82ZgQkmuHV9NcX
         4iqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCAOe/flMyn8iFRKN8O5oZzD0Y89Quq0z+NOAJpokK73saHOkaUaEaCgUvqkDI8wXtPrOVrrt0Q3ekRI6qiaIVRMSdEFkiwWCvTUXQ4bSFHQTQ4C4sJDde9ey2zkrmXlr5N+v8O80prx0EH9t4TZtSeLjfkQ7yndpWp4pBRxh3J7vmrmzHrNDnKUrC
X-Gm-Message-State: AOJu0YxLEshCoVLSondw9ICbVIR4m7yP1qXmpxJf/rYKczLWj3+nXrmq
	HdgGcu0hRn724wBVf3cLN3XyHGQjdiTWebYT/AeMFqzlOUaPmNInw1dcG7Lm
X-Google-Smtp-Source: AGHT+IFs8KBHIlr8iI5+jKqHi3Z6fGfr5t/qq7Lhq0urLWpZqPDm3eU/cSthb3ceAA1xPHWSTNepNA==
X-Received: by 2002:a5b:a:0:b0:dc6:b617:a28c with SMTP id a10-20020a5b000a000000b00dc6b617a28cmr2647620ybp.5.1713965071017;
        Wed, 24 Apr 2024 06:24:31 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id k7-20020a056902070700b00dbf52d2844bsm3115088ybt.11.2024.04.24.06.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:24:30 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de469a634fbso7024589276.2;
        Wed, 24 Apr 2024 06:24:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3rwqjyimOacyWYKW5Bm40WLJjJ3auuz2LcdrVhcKS9KeEp5ywrYy2vmcK0Y6H1rylRSnZiXOP0QxG4aq2PGDjn+St+f5k0GKtAvtjThI+qNJiv8raPImtMEfuyYorL8VL0qB/wPz7Pl9nXUlVOXqXEc0pEzt92r6rYh+NJ8esyVMkU/8nohBlBNi/
X-Received: by 2002:a25:c1c4:0:b0:dbd:1dfd:8b8 with SMTP id
 r187-20020a25c1c4000000b00dbd1dfd08b8mr2679489ybf.24.1713965070581; Wed, 24
 Apr 2024 06:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417114132.6605-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240417114132.6605-1-paul.barker.ct@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 15:24:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWq2y0ELZpj38TZLequjB_=5_1VQe-1XCBjTLmW86xjog@mail.gmail.com>
Message-ID: <CAMuHMdWq2y0ELZpj38TZLequjB_=5_1VQe-1XCBjTLmW86xjog@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Limit 2.5V power supply to
 Ethernet interfaces
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:41=E2=80=AFPM Paul Barker
<paul.barker.ct@bp.renesas.com> wrote:
> The RZ/G3S SoC supports configurable supply voltages for several of its
> I/O interfaces. All of these interfaces support both 1.8V and 3.3V
> supplies, but only the Ethernet and XSPI interfaces support a 2.5V
> supply.
>
> Voltage selection for the XSPI interface is not yet supported, so this
> leaves only the Ethernet interfaces currently supporting selection of a
> 2.5V supply. So we need to return an error if there is an attempt to
> select a 2.5V supply for any non-Ethernet interface.
>
> Fixes: 51996952b8b5 ("pinctrl: renesas: rzg2l: Add support to select powe=
r source for Ethernet pins")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.10.

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

