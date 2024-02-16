Return-Path: <linux-kernel+bounces-68724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB500857F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A76CB2827C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791312E1DF;
	Fri, 16 Feb 2024 14:12:42 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FEB12DDBE;
	Fri, 16 Feb 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092762; cv=none; b=p7Hq+SoVRjl0OW0rx6JrqvtxiW062rrK15MKNQvOb5lkOa1Ftxk/7cOgHz2cZGPManeEjqDn/aBZPQ2lUAiDuosG7JffeEZupeyK4+NCl2j3b8Ot4WhYXm6ljy5MDqaZPVHuLP6xccGOceiQ0wrxuRLcKppNmq7C1hxr+tYKpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092762; c=relaxed/simple;
	bh=8MQbPyWOcudw5n4vO0msx8tDd2p7vySEFcdrj+SXoyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmsBYghE7qpnlc0oMbu8vPCHRxu6CmJGhsdzMXH+vdw+fp2JeBKi/9hAoWzwY+3YkhOy40/Gmw/aLZMhqFzx+F+6qShzhdH7Qzwug/1DHqY0ZXFUa6LpC5pACGUsuXYa1sFb2OqNYvW9i8ipSMVM5D2k/Ab+gV8xBqS/6GSXqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60495209415so20687357b3.3;
        Fri, 16 Feb 2024 06:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092757; x=1708697557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCEAJzYERTZa1lUHsnan5I6epPyLItD9aG9FckH/eVU=;
        b=F0mHNe/N22Fp5P2yZ9D8y/IR0sOecYMQFh0yo47MRkQf9a90TepI7Fy4AUcto7JGMP
         eT3oNOXWdx3rba/r2QM2bqrGqmzXqx8uHKuHcAkMNuiV9wmjTa6wq4xp/1WeAO8CrTBq
         GIBvo9V1mqcANPL2dnaSdpyt5nxhSBPulg38DPKLMyuqBbSYvk6PdVhqi6SkjVV4mIn+
         0Mctb0Vv51SuaHcHsLR+X4jOLoUTDejoxkoXFlhNkkeiIMmSlZJXRkle35XUV6MWuEii
         f4mj0QZkfiR1nULjRSRpOP6mT/OxcwVTvu8CcDSKHXnirAlvJD0GTx6/fZ/7GNTneMPs
         Ldig==
X-Forwarded-Encrypted: i=1; AJvYcCXXovpBezyPCKmBZxuGXIM+mlCres9PdQ1Gfw7MtDiJsGBD4LXeQuyZDX+suOwgbOD357QOGwysVLo1sTV8pDYswzsculLALolFGT0vBiz5FRVCYyZYIpSZdRJnlGzEStpX0Ny93N1SyOhxlgwElR8qi98fCnRUmrJUEd7U6gyCHwPHJ9cpC5fG2hhlERN6/YI8XWzzSlmj23Gd0y7J8EyBgE3+opQo
X-Gm-Message-State: AOJu0YxPz1oO5pkKz+dwV0PA89xke0OGDqMUR8lUfF38YTwtL+iY9F+N
	qTEa+oZGfwd6776mpMLYNx5X2o8wQPVt/ZSIw60+c2Znwqnotq/QeoTTXTV710g=
X-Google-Smtp-Source: AGHT+IHIOQQWsmsjWFk35auBK6b9+DKc5Oz3MKbcenOeCu3nroL5aruwbMK9JUNQCpChEQO/AWpgXw==
X-Received: by 2002:a81:c310:0:b0:607:ffb2:fc0d with SMTP id r16-20020a81c310000000b00607ffb2fc0dmr1230646ywk.15.1708092757174;
        Fri, 16 Feb 2024 06:12:37 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id h123-20020a0dde81000000b006040d34e58csm354646ywe.74.2024.02.16.06.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:12:36 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso2140309276.2;
        Fri, 16 Feb 2024 06:12:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDjxiIOI7rm5SINuzEbtrc6vMVIOlivW028R2U2v60zcchNLWnFOI257Fe+MsO5TuP0HFaZdL3GeL6o0L6diA18+sJzbkwEVV0C++iQ57TKQo8VLQ23ExUkxbgE7He7lEeB2rTsnlOQGcyLNwA3dHjQKAtbA9RLSKuYvx68AiF4eg0LztEEuRN3plymVQJ/4wShsNwKplt7LQNt8ggSLRMaI2XbvOs
X-Received: by 2002:a25:7209:0:b0:dcc:32cb:cb3b with SMTP id
 n9-20020a257209000000b00dcc32cbcb3bmr4968431ybc.44.1708092755767; Fri, 16 Feb
 2024 06:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-18-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-18-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:12:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWKrr6B62pe6ptibbPB733qGmL38A0eigXqqOOKN9HYXA@mail.gmail.com>
Message-ID: <CAMuHMdWKrr6B62pe6ptibbPB733qGmL38A0eigXqqOOKN9HYXA@mail.gmail.com>
Subject: Re: [PATCH 17/17] arm64: dts: renesas: r9a09g011: Update
 #power-domain-cells = <1>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Update CPG #power-domain-cells =3D <1> and move all the IPs to be part of=
 the
> always on power domain as the driver has been modified to support multipl=
e
> power domains.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

As RZ/V2M uses the Internal Power Domain Controller (PMC), which
is not yet supported by the driver, I'd rather defer this until all
domains are handled by the driver.

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

