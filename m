Return-Path: <linux-kernel+bounces-84921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B587986ADBC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CB91C228C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8E73536;
	Wed, 28 Feb 2024 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7jhKv6r"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84EA7352D;
	Wed, 28 Feb 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119918; cv=none; b=XNql5Zf9azb2FDuJc2JwGIeif1fw7lw5xxL4irlENLxthK6pq9Wl4LoU0EAPTf8PciIqIVVWAf9sS/kZOuKxb0JXt9TqKEP66IIKgcTWmnwD6Ge2zufG7AZcbusow+TQK0C5HB+svooO55Xs2a58ulwmekHFBjFSdG70bSk7+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119918; c=relaxed/simple;
	bh=iz2+Jb/8dTUvgoff2FN8yxVcFXnUxXeuchrvTFUu+vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebOOcJuNMKgdYWkAyWjNFXW3VBvLjsbdQWqsmI5H6DoCMPyVz50TT5BEnbYRU8J34bfkT3QrkozcM4+GKBmO8CmsqYrkwbdaurSP9GH1JoKepSgln0cf8YwtVBRI4+1oFqZFWzV+PcJc2oV/bMHeTij/2zf6estIZBN4vg3e51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7jhKv6r; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4d331ba6078so365241e0c.3;
        Wed, 28 Feb 2024 03:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709119915; x=1709724715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz2+Jb/8dTUvgoff2FN8yxVcFXnUxXeuchrvTFUu+vY=;
        b=D7jhKv6rcc519p9QYjRCXu4eCFoz8Bq9qqwGgK9LmtqK5cjdHamrd7gVERfzo9kRGZ
         EuY7KVgUV5tHMMMTmrgy5SPFjIwuAAp5Hs0BPOn18E2mjPH6hniC9bcqEZhDh2ljaXPN
         M5U1GAqgaTFxVe0zEVsNY5T4yFdSM8l2Azih2xI54HlO1WyJPgKXBnjxBM/hIRe5JhPG
         Kv7n3Iqn/ioTU8eMQbAebIedB791rqQnl3vA1h5S8A8e41ceHJ+JM2am7mPL7+bsG/tC
         LaKuUUNe93Ogw/EBwXQx7wvCbo0xz+++8Jln4OPCRGY5YFPV6iM6DZqHN1woOS4TArqZ
         dT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709119915; x=1709724715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iz2+Jb/8dTUvgoff2FN8yxVcFXnUxXeuchrvTFUu+vY=;
        b=XpEj6QnqWKi9S0e/bBSXzjfdPifFZ3tXvCcz28p0rr7MRTvcwzm49rbAwLW9GXUQOp
         Z9dKw9jZwh3YT86qLQKg0cgBPK26X9EncM0PjuF8WG+zHBP3gVumUTcDigjyGg6zPOV2
         gZCpT9Ua2BSIV22guBFv6fJGDjuS2HcGFyLyfUq8wRg1QrP/dBzEFcYhcd0cJIshN3RS
         MCvqytmwAS5mqV8q+7gYzcv6wBbIXIv8mzn1x8Otm/MVG+R3G9V/XKmFxbtqXGiqblS1
         k7f7IqxDwhTOczfTyGNo2b3ADmeJclMCP/pbwlIOIJPlMgP1PwarwDB14pZ3O/599c11
         pVlw==
X-Forwarded-Encrypted: i=1; AJvYcCWiZXltlpRANVGymxOsw1+VJCJfomFSsfiGlJhLzt/zLyG4ch9RmbIev1ROvvRH53VZ/EBCUgIiXByoPzWraaoEvXr+/4jvRNujt8CGYbYonQz+wp/4VE5Zct/MY0+li5Jm2mc+u4Aa72iJVMuWiE3+pw4Ke/TPWb8irn+FVJKYCAketui8vjL6v5Hn
X-Gm-Message-State: AOJu0YwmEheby5yl4EaFrwIbYRkEtuIAjpqxKtQa11WZj8MxB/zRl1hE
	i6uiJ0yI5VuJm3GeJHYP/FY/oez6Y4ezjGL32P/vC3CAsoMUIvb+e0f/OdBeeeYACScxH4bAhLf
	mLW2IaULOmb/7S+tESEqj7SiOjbk=
X-Google-Smtp-Source: AGHT+IGDipX2IVIH80/KU2LPt226VTjmFS4ViAHeJZ5UN3Tzl7sYyODC6rfHT9W9FPIiS0/bv5H4OzfsSkwmKm4RW/c=
X-Received: by 2002:a1f:d403:0:b0:4c8:8d45:5325 with SMTP id
 l3-20020a1fd403000000b004c88d455325mr9610229vkg.7.1709119915466; Wed, 28 Feb
 2024 03:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240227232531.218159-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8e4e05f9-5bd1-4f31-a2ae-fc1567405c11@linaro.org> <CA+V-a8vSCif-JXGFtn9k-JRBsV3sKH4YoGJzQbum0DV1JS5hmg@mail.gmail.com>
 <20240228-suds-gradation-bbaa44b1038c@spud>
In-Reply-To: <20240228-suds-gradation-bbaa44b1038c@spud>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 28 Feb 2024 11:31:04 +0000
Message-ID: <CA+V-a8s3+Q54H5L33vrL=yhhzbVRK9UN_tffDW3V_BJDtudBPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: renesas: Document Renesas
 RZ/V2H(P) System Controller
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Wed, Feb 28, 2024 at 11:16=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Wed, Feb 28, 2024 at 09:43:22AM +0000, Lad, Prabhakar wrote:
>
> > Sure I will add "|". On that note some bindings have "|+" and some "|"
> > what is the preferred one?
>
> I don't think the + should be used anywhere, it preserves all newlines
> at the end of a block of test. Maybe there's some specific instances,
> but in general I don't see a reason to use it.
>
Thanks for the clarification.

Cheers,
Prabhakar

