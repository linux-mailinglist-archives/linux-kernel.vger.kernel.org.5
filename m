Return-Path: <linux-kernel+bounces-76536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8416585F88E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE0AB2776E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67233F9ED;
	Thu, 22 Feb 2024 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKpJGyLN"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B083133284;
	Thu, 22 Feb 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605937; cv=none; b=NgHF6JJPsoHU4cfz2iQhv0eK5QJzHB2T41kB5Ie45QtzDn3r6JgRZKKHFQanJbXGc15oXpwTLqwuUP92EmSwEXSMod8M3S0qZNJH8By3hnh3dHxtpFUrp0G1/9diS/C+x07t+shgMUWWnFjm29jajalqXSgQCW6IVLFH/L8onUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605937; c=relaxed/simple;
	bh=eeYv1ybpXWyYS6JOjbUn16FoaEHy+6aU+i+xe8O54iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UF8XR9YgmMpRVmNa4IXfNevLR5ZsEt/pEetJRWO/az8E6Xj1NM998LawnaAjL/c+krJpu7gyhGhBfKHyQEUoJjNZiksuFkNzueDHYMjMEPf9frSaQ1NYdxTsVRelxiwpo82hy4sGLloYjBRYq14v+L6hH4cGZsFAb2Y5JVgMwoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKpJGyLN; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5bddb0f4cso3229009241.2;
        Thu, 22 Feb 2024 04:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708605934; x=1709210734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl/74aNf6C30IbTq4SbKpxPwJU7CvFGlVk1glFIjawQ=;
        b=RKpJGyLN8B0FARSzTVMcd8RqQ/xyLOWF7imSwmcBqU/MW//m4LLE9y6U1utU7qN5f1
         tmj3f3306bnBoFsRdWPqvfPn6T0kbGJuQbAeWOdlPig5f4Xy+tdYljh/lJ9pSumxxbT5
         VfIGuAf1rTkQPFsuekj9dbLh9TE9K1GnNPUXwdeXO7rztwXkfvl8ZkXKABn8uv/D6yJz
         /w4i+JYPnrO8pBwmBDlYRmvHkTiZ08o+dX03vZa4NQciGoh7ZnJRgHL44O7pWb35GVRF
         hmKr6hGK8ezgGoOshGfMRg27F8u0UwnZkktYHuCflo78vk4E80zjFllMmUinLUd2FjUL
         xZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708605934; x=1709210734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jl/74aNf6C30IbTq4SbKpxPwJU7CvFGlVk1glFIjawQ=;
        b=ddQm6sgmstX3FAoewdznT4UMq1do31i4lt99UjC6DjmFMMr3/sbFdhciNIzdUcx8iB
         wwxNUr0y9Vw6sILPsZqV8YYnfijP1zef/ns84srMAB5YI5VhWjJNr2VuQWjrcywyoRnX
         55HaAYvwQBWeQu13MWkVbubhoIthv5Qy1KE+GQCDTIVb9hRtr6JvFxMma/+2EBEVauxe
         vAp3A7ZNo99iD9ZQsWmhg9QRP5AOcBKI4kwd8cP3U5SUG/oaUuOzKdmLy+ofJQ2DaU6E
         3mM2wSBqmXkBhn9G9HpLWhnxBMBZo8GS70ujcAXodAWRSoryV4DuHT8+cNHVUxG1XJ8b
         Ubgg==
X-Forwarded-Encrypted: i=1; AJvYcCUGL5GbOBk67LpBVgJqgKK3WyRMo8WBs6WrBtAqSB4/JIFlEM57WW7/mBsSCkVwzov4KB+HMFDcBDtGmagYIW4CFKyvn/ovlDeaK/q1K4p/1BsCziMVeRkTPni9F9FEucPxY88mEHmmifGxbn7cJ9Xx6IjQ88zCjwZJ2gJLoCkKxYyYZJORocnaWO/b
X-Gm-Message-State: AOJu0YzW6jACnyViu+T5BcLh8Q6anFAr0/Q9VOZ57Kx9UeMJj7EkjzcR
	KLsfaKABzp7T5PbzDH3+eOhIZEveYgqLhf7/k+/Kr0AcSMaNB71gDFSsH8LhqfeCCT0sDP5JcJ2
	Ioi1h2JbGQEDyDBk+WTJfIc7/6/o=
X-Google-Smtp-Source: AGHT+IHxuUFn2aORIQ2+krCTkMTbYoBRsJidrsynqYPOfpfz5UN/Eix+YdYxx8Y00b5H9pXDcJxwdHYGuhzAQLcek1Q=
X-Received: by 2002:a1f:6603:0:b0:4c9:98f8:83db with SMTP id
 a3-20020a1f6603000000b004c998f883dbmr12403022vkc.5.1708605934034; Thu, 22 Feb
 2024 04:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240219160912.1206647-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <47c8bbe3-610d-40cc-b505-e9ce9a371ef7@linaro.org>
In-Reply-To: <47c8bbe3-610d-40cc-b505-e9ce9a371ef7@linaro.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 22 Feb 2024 12:44:55 +0000
Message-ID: <CA+V-a8uPY8hwJc4xv7=K4eazTTVpvOwteRKnnFmXhHGyCsM6qA@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: arm: renesas: Document Renesas RZ/V2H{P}
 System Controller
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thank you for the review.

On Tue, Feb 20, 2024 at 9:51=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/02/2024 17:09, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add DT binding documentation for System Controller (SYS) found on
> > RZ/V2H{P} ("R9A09G057") SoC's.
> >
> > SYS block contains the SYS_LSI_DEVID register which can be used to
> > retrieve SoC version information.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    extal_clk: extal-clk {
> > +        compatible =3D "fixed-clock";
> > +        #clock-cells =3D <0>;
> > +        clock-frequency =3D <24000000>;
> > +    };
>
> Drop the node, not relevant.
>
OK, I'll drop the clock node in the next version.

Cheers,
Prabhakar

