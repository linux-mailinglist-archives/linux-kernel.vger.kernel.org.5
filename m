Return-Path: <linux-kernel+bounces-148750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A858A86F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018BA1C215C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9072148303;
	Wed, 17 Apr 2024 15:04:30 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566F9146A9F;
	Wed, 17 Apr 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366270; cv=none; b=J5ownP4LIQZnMcPb+LuscowXKAWG5BQ8gv7Q5EZeWvBu+G8Rt55h2191L785enWtJYNxXmlOxwJwkM8x5/3gI48qUsUtEw5ED6L/Py4UEUfocmXUhTGaRvYOivJmMpflX+0dRrVRlYjSH2zA5tMwMcZ/INaG3RfYIwGxoyCQcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366270; c=relaxed/simple;
	bh=lXS1zX27CNjD5iT8H4jBr/oAVb3l1Qfc2uEUWSMms9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tx19HtEIGeeJIreO8UpShAD+V6oBWy2uNZfqc8rARTiD20f37ZeAzqD0WWnqItnXKzgCciK1363uZ3Xlh8kslmYJhl1lbW6ks7lloaVDTI/FarxLG/jHX0wu2ZgQe+vtFKo3kx3iztVnJbGWoWuRVWHX5OW7pbn3ILpb/hKleLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-617ddc988f5so65805937b3.2;
        Wed, 17 Apr 2024 08:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713366264; x=1713971064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmPbDx+9Otjmd3Nxkuoo97wZVDF9LaZCMQjGYZNrMXY=;
        b=WlpS2UQolmk2Vq7ZluEYBbKtsQkic6ST1nqiNdZRJHqYvSwUCK/1tKUl8yy+zlZSDo
         zKNDVUkRZV9xVY9R0JRxjf7i52inHi8A8kbQfZwZ0+7Si3MBtbxV/9Q4quZsZLy5eQQ/
         LUKuc5tZ1d8fGICy31ZIoJVekg+PGEQCpFcjKsWQsvRNvr8aSlPNSEYzYdwVcLj9ybLJ
         omXJro6BhbAnEwpP8kJHf/I65oY9tZ7U2+hCwBLVxC3/HRT87cbegfLlxJHjHetAICKA
         +ZiOQ00T5ytTZRDNv254ED04YAPE5m+biUWjBu36dVsiFwKSJOlwVCT+9JXJFjj6ykTK
         8Ffg==
X-Forwarded-Encrypted: i=1; AJvYcCVpfvdWRHq9I9f0gGY4aQqfjLdkrpTC+mCUuEqW1daGiHDXgfc2QzjiCg2re+I9chm2zOFGuuZTWC/S1LWiLw+zCEKjPoq/enI5SJyMQt3+hIsGklYD9RqdGdYN2LUQjWTUsgkB8Blhjms7paIfzsRYhvmxMmDa9mD482yUbvIjo66oXaLSZNF3gcqnedd9BcrGxKCUzkHWRbTp2OsNGzpUHOt3OdyHS/AP
X-Gm-Message-State: AOJu0YyqEbwT7h7HhyAeHKzTG5qYDOSg/vD5jy7A6w4uBkSZFuObRntq
	f7HNpH758zHrmJxKShvcQ1KEPLYAhkjKAUroyQXpWvZTAWqXmZoQ1rlPW9y3aF8=
X-Google-Smtp-Source: AGHT+IH5oUTL17S7sn7il+nUEmctv4jcj8o4kjQGqiJsMMd3jEcwJ272A6ccO361lI189UOKcArY0g==
X-Received: by 2002:a0d:cb8f:0:b0:61a:d2a0:5497 with SMTP id n137-20020a0dcb8f000000b0061ad2a05497mr9128715ywd.8.1713366263851;
        Wed, 17 Apr 2024 08:04:23 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id l36-20020a81ad24000000b0061248f16528sm133442ywh.66.2024.04.17.08.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 08:04:23 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61500da846fso41881367b3.1;
        Wed, 17 Apr 2024 08:04:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPiUKAcp1ZvDubQAVdOZetCGyEq+CiX6hGXH6irpndBN1tna5pXjDT5xaDXTKa2vvjE1rSEP8DQRCHMA67vv7uo0m9ZjpDT/v5ZX20R/R38a1oTbJen1TljSIpeLglHadGJv4ZARifqj4xuJL94Bbn25QX4J70dOl2qd6ZNPEgDUHtS1lE/510/DynKSo2pMJvitOFO+zTsyk96eQS+UmD67I39+TpU6Ff
X-Received: by 2002:a81:c10c:0:b0:61a:cc3c:ae69 with SMTP id
 f12-20020a81c10c000000b0061acc3cae69mr9032606ywi.18.1713366263495; Wed, 17
 Apr 2024 08:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240322144355.878930-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240322144355.878930-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Apr 2024 17:04:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpSUHjLG16xe2A9rg6kBC=yb9=ErvaB1H3qFa11Vtr3A@mail.gmail.com>
Message-ID: <CAMuHMdWpSUHjLG16xe2A9rg6kBC=yb9=ErvaB1H3qFa11Vtr3A@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] serial: sh-sci: Add support for RZ/V2H(P) SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:45=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add serial support for RZ/V2H(P) SoC with earlycon.
>
> The SCIF interface in the Renesas RZ/V2H(P) is similar to that available
> in the RZ/G2L (R9A07G044) SoC, with the following differences:
>
> - RZ/V2H(P) SoC has three additional interrupts: one for Tx end/Rx ready
>   and two for Rx and Tx buffer full, all of which are edge-triggered.
> - RZ/V2H(P) supports asynchronous mode, whereas RZ/G2L supports both
>   synchronous and asynchronous modes.
> - There are differences in the configuration of certain registers such
>   as SCSMR, SCFCR, and SCSPTR between the two SoCs.
>
> To handle these differences on RZ/V2H(P) SoC SCIx_RZV2H_SCIF_REGTYPE
> is added.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi Geert,
>
> To keep the changes minimal I've added a new regtype instead of
> port type.
>
> Cheers, Prabhakar
>
> v3 - > v4
> - Added SCIx_RZV2H_SCIF_REGTYPE to handle the differences on the
>   RZ/V2H(P) SoC

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

