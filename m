Return-Path: <linux-kernel+bounces-81376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9725F867510
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84B51C250F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9589A7EEF7;
	Mon, 26 Feb 2024 12:33:20 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF77E569;
	Mon, 26 Feb 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950800; cv=none; b=YRcyVhkehCdWIpe+srS+Wk7ZxYBWSnTc0pxcp3CJJb+M5ujE11wq1UPtvtQUagz99qZu86td5Vz2k6ipVy9eV4L8ZTEaoufZ4AgD9+8iXbXbIqHXMpCIfSww7VKvGfQY36uu8vstGv+27J2ZLHqriuUfigtWPmu7YcqrlqTw7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950800; c=relaxed/simple;
	bh=NAXgruINWdOQv8VRnp1gn8XclW92gQqN4yv7U/TfJwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9qIhYXFygOEF2lwvT4XA5BxbLNa+YPpK4nyHDHkh3QmhM8nzM2meoAIDQaur3QBbAj6hbDnnd3gZ0EjFMfXI1Tmo/jZw/+Dj9nLJccnDevY80CRNCV7Vs/1U68/J4PKMsspMQkJFbByUnc6x9xJOmUrYG6Yqgar0TLBOHZ2KqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68f9e399c91so23888776d6.2;
        Mon, 26 Feb 2024 04:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950797; x=1709555597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7Jt6uOGYEF2aQdl/7Fp6F1BKKNUfz+MFg3gqXg/aVI=;
        b=vu13B6/B/v/ihJI8pnyPloan8v+uyqADRsw7kZaDVDGAhxsG8YxpkPcRyyQeD2jVyy
         mUo2kZC7324JxjTP+JzVMM8SOcLc6Brxd89BF9hQymAeT1VjsREE/H1ixANio0saiMKj
         LJA/indnVL5PBrWfCEtx41g9WwU9+gHRntzQq6+dnIfRxFv3ytagTw3X5vIMVNPiUuZI
         uE7tEE+xwp4nLSbznW66x9zA0gwWuCSCd3GebppIB2E2EP0/jb7chKnAliAAULvQKkE3
         AYqTAp5O+Y8BaPTB106urtJ7RkyMAvmJxo5fKhCxlknZXZo6xFqYrb5mNcspu5pGwlaW
         TJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCVScpXo+QLPDDn9E7kW4uHIyFrvkUY0u7EcY+rtJfx7H2bKJR0H8DFVi9RLYIJTooG2ik+qcAAXIo4Qpn5w8GiPVxNFVthTsU2zGm1ENJvWQHtzQBAE9J/KgxhuVWvcSU0ujjxYHogvYR56qdCV1qrQV68q/kdASpatobbpaXwymVISFvQSAn9zHnxcMXVzzK4kpWe6gF8mqH3pKi99Fn7IaBsnKRuVM2OBG+aKZA==
X-Gm-Message-State: AOJu0Yz/kIlkvO69qQ6t496KaIl3hS76aN8LfEP0viwVPESGtOuziu2x
	VmSFzM8x1rGwUxujbZz84G5b4M4jjtrf4uKkhg+7fopMMaj2Owqk7bmBLUMOs6I=
X-Google-Smtp-Source: AGHT+IF7HkvvFrGX+e9P2Fon9GwVWSTyrXraAW9omwnJtiMWP3h4WRWxkEDniIAoWtiaYGvtAoTgAw==
X-Received: by 2002:a0c:e286:0:b0:68f:714d:3e87 with SMTP id r6-20020a0ce286000000b0068f714d3e87mr6760275qvl.60.1708950797203;
        Mon, 26 Feb 2024 04:33:17 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id og17-20020a056214429100b0068fe3170b0esm2864225qvb.11.2024.02.26.04.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 04:33:17 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783045e88a6so269017885a.0;
        Mon, 26 Feb 2024 04:33:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWy/qDwvGp33svSE0yWKzyuHon8HS2OIRP/WgdP8/PoMibD2OrkZuTRba2A+svL/xcjtwUHZRDd5DaLHvqOthvOVzzisQObles36IeUKoiploy78GcW8t+AboVMK0voPVJvWkw6LwGkMEw9pYSgU+Hv1JupmFfAHZJErmDnc1nNIC2unTa5j+x/aLjXvBGW2ueIZ2jcaJpMueYzSoUxodgi1lNABmTFUl42Isx69g==
X-Received: by 2002:a05:6902:3c5:b0:dc2:2041:fc49 with SMTP id
 g5-20020a05690203c500b00dc22041fc49mr4426711ybs.5.1708950484424; Mon, 26 Feb
 2024 04:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222083946.3977135-1-peterlin@andestech.com> <20240222083946.3977135-6-peterlin@andestech.com>
In-Reply-To: <20240222083946.3977135-6-peterlin@andestech.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 13:27:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWzzrQBq-RzFnfr8pXgeUOuqG8CwCjwDOwfCJzGQ=ZDJA@mail.gmail.com>
Message-ID: <CAMuHMdWzzrQBq-RzFnfr8pXgeUOuqG8CwCjwDOwfCJzGQ=ZDJA@mail.gmail.com>
Subject: Re: [PATCH v9 05/10] riscv: dts: renesas: r9a07g043f: Update
 compatible string to use Andes INTC
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	alexander.shishkin@linux.intel.com, andre.przywara@arm.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org, 
	conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org, 
	devicetree@vger.kernel.org, evan@rivosinc.com, geert+renesas@glider.be, 
	guoren@kernel.org, heiko@sntech.de, irogers@google.com, 
	jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com, 
	mark.rutland@arm.com, mingo@redhat.com, n.shubin@yadro.com, 
	namhyung@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	peterz@infradead.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org, 
	sunilvl@ventanamicro.com, tglx@linutronix.de, tim609@andestech.com, 
	uwu@icenowy.me, wens@csie.org, will@kernel.org, inochiama@outlook.com, 
	unicorn_wang@outlook.com, wefu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 9:40=E2=80=AFAM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
> The Andes hart-level interrupt controller (Andes INTC) allows AX45MP
> cores to handle custom local interrupts, such as the performance
> counter overflow interrupt.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Changes v1 -> v2:
>   - New patch
> Changes v2 -> v3:
>   - Fixed possible compatibles for Andes INTC
> Changes v3 -> v4:
>   - No change
> Changes v4 -> v5:
>   - Include Geert's Reviewed-by
>   - Include Prabhakar's Reviewed/Tested-by
> Changes v5 -> v6:
>   - No change
> Changes v6 -> v7:
>   - No change
> Changes v7 -> v8:
>   - No change
> Changes v8 -> v9:
>   - No change

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
so Palmer can pick it up with the rest of the series
(the Renesas tree imerge window for v6.9 has closed)

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

