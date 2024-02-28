Return-Path: <linux-kernel+bounces-84931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C586286ADD5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11BA9B20E23
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F63115AAAC;
	Wed, 28 Feb 2024 11:35:27 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3FF15A4A8;
	Wed, 28 Feb 2024 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120127; cv=none; b=q/4UyLbJLltsO+T1M4YATa1qiU/Fu87LUqMK12+w5GT70NI5La3v91eo0nsp2WkzWwdUY6TkocJWw6bloctRXql90exiDXl9h5WirqdG2Vfj4T5uCrhXCViltXL82toJqXyc9NYlpxeCuYiK9QMeU+v3+zAVQOIRD2LFfgMig8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120127; c=relaxed/simple;
	bh=hFyaNw/njpQrUj1QHO73Wtedb/1YZ47LtV0a+piXmqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qb2pSGoYI7CixWODn/JoK1EPeeAbmnMGaLlAaZ/T7MyQLlbBVQlDkvqOyBsVBJUwsZP9g4KzJRWkVYumgYcuks3poZoPPwUAhK88LOr+tg3Y1eOUjRjXnt6y5SCVduVmzurmU2vWaPhqplCo5lC5x3gkLwjIKKS7WQvbMLr1zcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-608cf2e08f9so49293997b3.0;
        Wed, 28 Feb 2024 03:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709120123; x=1709724923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KX17BVNMfLjxXbuR6mT+yo104g+C4/26AtxcjQgFKOw=;
        b=Z7eCROt1NQx7bnuzhKfjiuWHtHWQQRYJM2tKecYPPn4LgdUbhYfi2G4GKcdS14+hYN
         vlJzGFWCCHEwrOmjGLiYZiV2YsM1cY/0TeX+bdBac9EKnKloidrqAntcSxqcq/+MlDR3
         ZVIEi8CGYbNTXePPGT+Obrr/iSdekZc4rGWAPVi2mI44RqOMxFEXD2bfMskC1EH1WXwj
         PQiHYFaSS7vNQXSdGlRJVeeyxZvrcGIbPHC6fxqNMWB3tbxROzO7nzTlD/8QPQQ+tS7h
         vjDwUbHvrNfI2HJdj3aqpsR2JfNwyejydSX4shdvmWz91aMcB13fjY7wODG/XRs7/uQr
         CEdg==
X-Forwarded-Encrypted: i=1; AJvYcCW8NA0xMI2u54GuylwPi++FjShmBPNw5IX6L4pi+M3xnBQh9XsGtlbXLi9ITVdO+dWi5nh+3fJCizR6PeZgEbOjOUrcrESr3IEeQuSLjcvjzdi6WR8NpFKQ2UpB2zl3jgcMAkzExIPwr+fdAocSv1yRyF2vwnZ7MBru8V8UgmG9Hm+Qr4OgEikFgs81
X-Gm-Message-State: AOJu0YzLg9m68KfuLH1IyxbxJB+ZVLA8zsRW6a3UfMXQuPeU2/K5f/Yi
	m5iM7habOCm4HwWGO3VfgAI6ivKmmRyRhNNFkPVvtaR9HRyo7TD9RwWa/oaXpXudcw==
X-Google-Smtp-Source: AGHT+IGYZ5GwXzVNYiYMD5J7mMjdrkpObdHo3gXoklW9sFTyhX7KG5ofofoE5lH7z7KyTb5E9TSWPw==
X-Received: by 2002:a05:690c:97:b0:608:d599:e078 with SMTP id be23-20020a05690c009700b00608d599e078mr5377566ywb.24.1709120123636;
        Wed, 28 Feb 2024 03:35:23 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id a11-20020a81bb4b000000b006049167ccffsm2251177ywl.65.2024.02.28.03.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 03:35:23 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso5605970276.3;
        Wed, 28 Feb 2024 03:35:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNXgfgH66cnxKBDyasGEhX2DeqY8DOeUwqcvH8bGZ1h3XMTUXh9Wf2dW02qseoyiu6b9AefVVBd3UJgeEEgL1v8g4rGWhFhBAFUc3XdZV0tMdA7xvnXTThYvRSbax9jSTX0saeleBXiFuI+ISA23BjO8iQId0cBebtGnS49njoBwji17xxOhcn+bfh
X-Received: by 2002:a5b:d49:0:b0:dc6:aebb:168e with SMTP id
 f9-20020a5b0d49000000b00dc6aebb168emr1909145ybr.26.1709120123183; Wed, 28 Feb
 2024 03:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240227232531.218159-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240227232531.218159-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2024 12:35:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW2KXruusuoqJQ-9H+mpqggyz-VihYp_NfgRtmFGQbfLA@mail.gmail.com>
Message-ID: <CAMuHMdW2KXruusuoqJQ-9H+mpqggyz-VihYp_NfgRtmFGQbfLA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: defconfig: Enable R9A09G057 SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:26=E2=80=AFAM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable support for the Renesas RZ/V2H (R9A09G057) SoC in the ARM64
> defconfig.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v1 -> v2
> - Included RB tag

Thanks for the update, will queue in renesas-devel for v6.10.

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

