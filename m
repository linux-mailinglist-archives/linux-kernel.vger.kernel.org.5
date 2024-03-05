Return-Path: <linux-kernel+bounces-93101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACBF872B10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67162284D99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB3312D747;
	Tue,  5 Mar 2024 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V61IP9fV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA9A647;
	Tue,  5 Mar 2024 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681554; cv=none; b=jp4IFDnDBFVVjsElrKLGpUDl5Hvh14kiyPc8f36w8OHSEDRwEfKuhdVtngRiKGvxSXJQcO+NKccuHaMOAy5advtwcFkC7AncvpaldH3/Fj9gHrdzmh2VDtJXqbNWNQlMkkh7y62qmRJaNsw9SRIQhGXBLgD8t6ITTOmAFecwIc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681554; c=relaxed/simple;
	bh=80lvfzGKAe7kEBkauCv2yMWIGPq3NW6MljARA8V1sos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPTz3wRLhGOaLMi2TPLsVY/REuMEJHIrjz4ecDaTVoUcOnUvHSjukXayb6ygzNTYQMhLmHaSXjHiCJ6Lerc7/F/D4eA9rLcGpqbStOD1b2zQOm4WLMBg/sEPNUNXbQgkCy+clT8K63ztbTm0ws97bTznHHS0DNx7Lyyb1bwpBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V61IP9fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA058C433B2;
	Tue,  5 Mar 2024 23:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709681553;
	bh=80lvfzGKAe7kEBkauCv2yMWIGPq3NW6MljARA8V1sos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V61IP9fVQO21PP3bJMIqz/79X5pZAG06WSN9f7zC/ea85Jfj0VD8mA0u1PSFOtLOC
	 RUbT2l9DMXG5RZmKOeVPxbDpytt5w8TMIwFfJOfoLPnwHhckftitAW0RDowdgveWnc
	 AHcUt2lqhv13wSFIKqFBocroEIYTg2NyoLp67JsTGkwKsz87FOg6nN/SMK6ZlVqd69
	 slZGFuZ0MSxNe2xbagMMvC569Stop3FcvlB/qgXBk/3L8c9Kqf60WkmHx6a6o3ELdI
	 /uIrKPu5TLiZuR0uXv8R3u6VPbDCVp4zbP/Ihb6CHYnybYAjN0yHC1n1pW27/+D2XP
	 PwiyqyhdUz/tg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so76915731fa.3;
        Tue, 05 Mar 2024 15:32:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5+7fFQZdhwbWU9olGivYhlTL0iP/LST11LpC9LxJSSj8vt7LRloiMVxjgJ3ukHomrynWJS1hlAWxGGvI5L8ZcJI6037lcfEKWxn+mn7qXM92dOOFGcIBPynxF4QmHj+cQHQgHkciroA==
X-Gm-Message-State: AOJu0YxT4cKP812E2FgP2+zsAeciTkZCNj/bG23sdpV1tmeyGHp1+iOi
	qB12wQ4NdfI506tFQun1OypUPXhilxAUznPfoElPCFnNTSMcteY1LaIDDNuRLBrDcxwnW5VXu95
	2x6NsCB0GSxmKrKJ540S26F03e6M=
X-Google-Smtp-Source: AGHT+IFWBGx8vg36clcVJGz6YYNWtxYPJ8dI9W5dVEDPoJeAufsytZgWUj1Bv9JfKRKZua3gnDxuRk9rWeeALEezvLs=
X-Received: by 2002:a2e:9085:0:b0:2d2:c8ee:c99b with SMTP id
 l5-20020a2e9085000000b002d2c8eec99bmr2112010ljg.29.1709681551908; Tue, 05 Mar
 2024 15:32:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com> <tencent_AE58630CDF9DA09FF6B5633B2E4C8C668806@qq.com>
In-Reply-To: <tencent_AE58630CDF9DA09FF6B5633B2E4C8C668806@qq.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 6 Mar 2024 07:32:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRqd2tcSF6qanEok-FBXytbFMQLeno1PRGwYuFoTjsWRg@mail.gmail.com>
Message-ID: <CAJF2gTRqd2tcSF6qanEok-FBXytbFMQLeno1PRGwYuFoTjsWRg@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] dt-bindings: timer: Add Canaan K230 CLINT
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Mar 6, 2024 at 4:03=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
> Add compatible string for Canaan K230 CLINT.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/=
Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index fced6f2d8ecb..06c67f20ad3c 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -38,6 +38,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-clint
> +              - canaan,k230-clint
>                - sophgo,cv1800b-clint
>                - sophgo,cv1812h-clint
>                - thead,th1520-clint
> --
> 2.43.0
>


--=20
Best Regards
 Guo Ren

