Return-Path: <linux-kernel+bounces-96582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A6C875E82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB86B22A8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908334F217;
	Fri,  8 Mar 2024 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeTEWAVi"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E54EB50;
	Fri,  8 Mar 2024 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882982; cv=none; b=j/R/yvFC3DRVHd2HDIyudHDacSkEUH9Xzcp7QuLeSnXwIaLjOAlcPbOcI1neBwtuxmD9gycwUiluKJNwzizDy/5JqB+EJE+F2ixtKHrJNcVuB1eaZsJm3oLvmGlXvFHrZqbMKTMcGbA4szPchRSPsHTIIls4xPphSvnzFbQguzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882982; c=relaxed/simple;
	bh=3wpJoYIBNPT1RDiXfXuWp5p50gKosbHZhl+rgLfdIyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNDWQ+204wU9/YJcq/cEzVcRgxB8Wr0Gv/AdBESiDBy3o7Bltpqr5KQPQuX+NzHkkdBpkV9PbMOLHQfyPwAQkT1PXPjH5o6ueYKKDmjEEZ4cgzvlGokMqSE/x5AQM2IFw++NkVJitEKXV8JzMP078hljWMLwdPROyNjizkvmjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeTEWAVi; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a1cd796813so26698eaf.0;
        Thu, 07 Mar 2024 23:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709882980; x=1710487780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nXejeh4l9H+06qZGldlEJ+T5glCtHAjj6L+4wjA2ME=;
        b=EeTEWAViId7eXDjuFXVitVxoxrLS5Hnq+/xM7BVB4dfCYjS2zd0VusHHK04ZIhDcX7
         j6CiBa4Zs23TMp/hPGzABpPzXLwzIBh+q5z9Fa8Pz213LHft8gN2vayyeghqzOJ9EPfi
         k8nRk1rKOMQgAqibdYG/OIjMdjaUqYcknOY14WWPmwDkr1Ufa6JKW+PSZAk+6rwwePxv
         MTY3OCxRq9amAby7QxrSD50E9nfJq9xa/gH7RZcHyvH37fS4k5yH+cK418lcoix7qEmv
         d7Ryn43aX15wPlBawbnrRw/ViCmmzVKQmtNgeKrEA3pgZIDjUKG8wPes5J5rnTHk/HS+
         N2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709882980; x=1710487780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nXejeh4l9H+06qZGldlEJ+T5glCtHAjj6L+4wjA2ME=;
        b=CeGwOogmcDPG7kAlW3EfUfctudpy8v9DDrHwjvBOEoJ4OOPb1xi4BEkXKb4jKlxigU
         S7aHZO1mf/rCoENXczfD0V4Clvrgws6riC+Ra+iBlptgMMu6yDKI7ocj5lQGdKj6SV4O
         KQiAdTlwJkDBYbzcY6lIR3bJm72MUABu1kHCsKRTA5ikYlP0tS/XepxJucZnv4AQi+hb
         JNtlkXQwYYPtZnGmC7KoVzW14P+J0OW/SB9J4lsPw5UIjJ1AYMEsBKbDQC9Vb7OzZDYb
         0+WlvL24w1zXtO0BVgMqbRbcvuk9dCCkabvImICl9RxVHiMeJRk6As1KyfaTuFMGU+Z8
         +jEw==
X-Forwarded-Encrypted: i=1; AJvYcCW1J+MSEimYdqNxFgYFGbZXxGEiz/5ytI/XEAL/e3MzCvClfhF42wveJ/agbA+SYwLSla/fZYwNF5nYEGFviW/PoEWn9tFz+KczUEP5su2Kcxl2vBmJaWtJwS0EiTLv2exfvT62yIlA0OAOPW+NzJAxKKnMctK9jIv9DSMxQZ/UiMMRL9A=
X-Gm-Message-State: AOJu0Yxp0VJwN07zifvhGCHlnpwvc1SF7GAVHgnqcufIVtIjT5mldDrw
	j6LBkonixd189GPE+Ro/H/3iVyfnGFuQcgOI0QVr1PBWdRHX4yi47rFvvK7nKyX6l2pFdl6F53I
	48rVDQl1mG/M2DUUhwQJYgZzKvT8=
X-Google-Smtp-Source: AGHT+IGfPKC1vAGMMd+/KzXy2O0/LixaCY+jyT/LJJSJQrZ6JoQiRQvUj1Su1Dj3OW3cPC0bKw+srckL7pOTKUdmbd8=
X-Received: by 2002:a05:6871:620f:b0:220:a34d:d26c with SMTP id
 rd15-20020a056871620f00b00220a34dd26cmr909873oab.14.1709882980664; Thu, 07
 Mar 2024 23:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMhs-H_eUKm7C40oCzuKwwEMZAcOJ-g4MghAfkGAmxRM0AXPUw@mail.gmail.com>
 <20240307190408.23443-1-justin.swartz@risingedge.co.za> <20240307190408.23443-2-justin.swartz@risingedge.co.za>
In-Reply-To: <20240307190408.23443-2-justin.swartz@risingedge.co.za>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 8 Mar 2024 08:29:28 +0100
Message-ID: <CAMhs-H9Z4iB-MA4_CwsJAee5CUDNFynT0nLoBz_3A-ToJzJ_xg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mips: dts: ralink: mt7621: reorder serial0 properties
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 8:05=E2=80=AFPM Justin Swartz
<justin.swartz@risingedge.co.za> wrote:
>
> Reorder serial0 properties according to the guidelines laid
> out in Documentation/devicetree/bindings/dts-coding-style.rst
>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

