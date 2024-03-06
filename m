Return-Path: <linux-kernel+bounces-93671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354D0873318
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6775D1C22EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0275F549;
	Wed,  6 Mar 2024 09:53:18 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04F5DF0B;
	Wed,  6 Mar 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718797; cv=none; b=EtaASY37rzo5l92+wgzL4ko/3AYwmkAEl3QDkTXd5c2lfVG+SpoZfiNzde0e7pW/ACeDpXHtnNsG0QrXZdLV5WBLyxcmeAnN891wWOP6gKGyAJ7cUr8BLWSR5UzdvC4sRI1XbXpOyMavBqew5gTrG/gx7cBv2coXfak5Z4dPnfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718797; c=relaxed/simple;
	bh=gjzjavJboeMXFVPXyAg/kK09uy05JnfW2++qiIN90U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJg+sS+9gBlDfB+z2VZ+fBSLlzUz9zMEPq6MKn/sudG/HY+q3oSmufdTSYGow0d2WKW9hrxdXIbFRv/SBHdy2E/JNDFjozBJjlZ8Z9W3CwvSB5sRZqCkaJMIrAidpHlfzjp+Rfdm3SI8nIIRgNE4vTopQTxRjtzEoFC38gFe3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609d9ce5bdeso5105977b3.2;
        Wed, 06 Mar 2024 01:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709718794; x=1710323594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaSwI4jn/JlLsHT0t8KerNyLmYzVbK+4rtbctCdIEa4=;
        b=eYPEpW7j3gdXnko/uAvNEbaSLDzARipWuAw3OgMLSiMmzickGA/D9QwB9WciP7+bvX
         cB9sESruBmHsraNevr6yRvJgQJOEKXcrOcuQ22fmC64EK0AP2Eq+qOIS4IL3s0Yc1VaI
         Vrj9OpMJ+rTGeT6wp/gCJxleEETjvtw8BNUBM/6XOauXilrGJmKp5X5WfcLWnYNafPTP
         exwG/YZCZmdvIXit0Ki2gfktUDhSLNJjmHe6z4E8agGK8s57IHMG2FfuGSxu0LGTaOCL
         dcsjrh9YbxS9U+VaKM/3M3ou71PlRCeYaTdQQdkKNzT8sKS+O2SSrWBlmS3+Q8QiKmKy
         piOg==
X-Forwarded-Encrypted: i=1; AJvYcCVls4GnJV/fXEHrW921VS1mGTxpICZmYTRWzXn6cbe6fRKVA9BhD92Wk4909W7WDfg0bIIusfA87PMRbbbQ/vJ/8DEd4hIKUQVfypKUGb+P5ZioW0hEgzsHRUpCE8YqCd6KtVsQCDVwqplJ+cioI4EXGQqwNY8TYs0FaEGNO8Je12K8yG8bYY/5b1MOOU9B8aPxaptgZvYwOhv3t8b5pmZQdR5/BntgsNI4
X-Gm-Message-State: AOJu0YwIWa0me748s6HZHIKzRcdNaXo+B8UKM2tPXOkzb143Im1MHIcd
	Z7emXpLoatjfOsVGpvBNzojSKNj13kwsOPLiZUPMNWzRWVvNWW84ZE3wYMXeEtk=
X-Google-Smtp-Source: AGHT+IHOYIagqpdLy26kN9vXUIkoboZglFCp7Qa60nWyFJcxHi4OhGcYB4+ixnZjJxvPiRoRauIp0g==
X-Received: by 2002:a81:9e4c:0:b0:608:e62b:d89e with SMTP id n12-20020a819e4c000000b00608e62bd89emr15019701ywj.33.1709718793895;
        Wed, 06 Mar 2024 01:53:13 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id y1-20020a81ca41000000b00607bc220c5esm923412ywk.102.2024.03.06.01.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 01:53:13 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so7100411276.0;
        Wed, 06 Mar 2024 01:53:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxx/00za0bz4ZObTic17Kq9FGwauFEXVaVW4+bWFAc/lOMmatd95TJG2/XHbLy52bQ5f31CBRQc1xsZJXnDLEmQQpauJyCpCBuSNcTw9Qdv0a6pK9eOKHbQK0XJ0wutMAyQcHBnly3S8paUI9vrcLWEKq/eb3Wut7ew02p+bkuiic/katSEDYmBOsS3d4wpj0zYnQz0QjlUEX39qaXGOeO+kb3P9xjoz5f
X-Received: by 2002:a5b:2c7:0:b0:dcd:1f17:aaea with SMTP id
 h7-20020a5b02c7000000b00dcd1f17aaeamr12332456ybp.26.1709718792806; Wed, 06
 Mar 2024 01:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Mar 2024 10:53:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW0MxqxRwULhLsRtnYXYK8NYxq-uU7E2BscbvPh3axYFg@mail.gmail.com>
Message-ID: <CAMuHMdW0MxqxRwULhLsRtnYXYK8NYxq-uU7E2BscbvPh3axYFg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Document R9A09G057 support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

Thanks for your patch!

On Tue, Mar 5, 2024 at 6:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.co=
m> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document support for the Serial Communication Interface with FIFO (SCIF)
> available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
> the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> (R9A07G044) SoC, with the only difference being that the RZ/V2H(P) SoC ha=
s
> three additional interrupts: one for Tx end/Rx ready and the other two fo=
r
> Rx and Tx buffer full, which are edge-triggered.
>
> No driver changes are required as generic compatible string
> "renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P) SoC.

If you declare SCIF on RZ/V2H compatible with SCIF on RZ/G2L, you
state that the current driver works fine (but perhaps suboptimal),
without adding support for the extra 3 interrupts?

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

