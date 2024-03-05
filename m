Return-Path: <linux-kernel+bounces-93103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02B4872B14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DDB283909
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9876F12D74B;
	Tue,  5 Mar 2024 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwujledT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921812D20E;
	Tue,  5 Mar 2024 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681621; cv=none; b=s/w0QLgaxVMrxVBI9zvVOQEQ7aj28MqxH6mjCn7u32Ie2G8D0NEm7wc+VuJLuifMJINkgPxuMVJ0eyMqEpwJK+E6a7dMufj5r7v/msd1En2lb8ZX2m2RHMkugGQuNZLUgtdGrdHjvfNzSKk11m3PiK2Maf1wjxMi/MX1eTNJmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681621; c=relaxed/simple;
	bh=eLpdEbLb/e5fMTtGq4VE53hJODUQV0E7L2x6Fi1q+GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9nzj+LEPIsw8AQ1jzswOEpXx0Ov/0PQD66FCYl7W/JvdKMTG1an5aA9EN2gUe3SkZCSwxiE6FxG5Fq3rvucIYVo5uXJIbn4RVEMUP0nQG4b88Ph47tkCvpbCi+x9botbPpWnJv6pbUoqrb2vYUtSkmDJeqsd2m7a46U8cQxZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwujledT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F54EC433B1;
	Tue,  5 Mar 2024 23:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709681621;
	bh=eLpdEbLb/e5fMTtGq4VE53hJODUQV0E7L2x6Fi1q+GQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YwujledT0wjoR1dOgkhjHbu20ofdHfBi85Be6kukJDk/vI4ww9ayamqiugYQimwnw
	 OMoMOZHsO9Zfz0hoS5zBFvFCnAozYufp9nBstrdepb6/RrhnmGo/GkQHh7rK+sXYVq
	 b3GqgLwkb3RCy7Sq7M8EkdixR9+bJryOr2AdkR83ZmEv0vQzXj2DTCW4QFfpxMOdfY
	 MyopwrkrUKwsY5DiWqDlpG9MDZMZrIUtEdmbtH8fcbga4+evMzOU/ZwB4V3i35cvaW
	 UbGjzNyPFKSO/60YmkpLXPk2ECmdIoTeOLzK9E7pAyYoUYZqRtQ45ZMx7is9ZTd3zN
	 h7a8uLRrGYvxQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so18240891fa.3;
        Tue, 05 Mar 2024 15:33:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJIBbktlN0yH3FY3BailXOPxTECvH862FKw9N6g1gIE7CVQMb0bg5lO8JG3i26eIhVoKr4Mna6p5++SM8VwnrCygM3Rly3E7vYBCWRM3/IuTGx0GsxlYHYF/BQd5q1+4c0PTllgSeXOw==
X-Gm-Message-State: AOJu0YwmemRS4KjMYP1gFnSY+LDem24GJtWoGLiALssskRbOukPvWTLK
	IzIdofIo8ZRc4/E65H2dd+dmqJ6rP2gXrjq+GoOzZOJJvmqTw/yTQDSROpZCJ9drRKcyr73A3E3
	UVwEnCNV0spu/K14Jvs0zMUfZego=
X-Google-Smtp-Source: AGHT+IGg0aE/JTW6xwqaUQn2xbuKQVBVSRFqFG9CACRonHlxpjny0NRLymtQDYdaNsAxMQ9m2w/KjejdKarYzDPbMJA=
X-Received: by 2002:a05:651c:793:b0:2d3:dcb0:56d9 with SMTP id
 g19-20020a05651c079300b002d3dcb056d9mr2172197lje.29.1709681619544; Tue, 05
 Mar 2024 15:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_587730262984A011834F42D0563BC6B10405@qq.com> <tencent_26733B06E132C458857C36DEF36D084A6A0A@qq.com>
In-Reply-To: <tencent_26733B06E132C458857C36DEF36D084A6A0A@qq.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 6 Mar 2024 07:33:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ_TCkkE9daRHzyY7fMcqULQUHj9vj7sVhtkp9Td__Fsw@mail.gmail.com>
Message-ID: <CAJF2gTQ_TCkkE9daRHzyY7fMcqULQUHj9vj7sVhtkp9Td__Fsw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: riscv: Add T-HEAD C908 compatible
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 3:44=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
> The thead,c908 is a RISC-V CPU core from T-HEAD Semiconductor which used
> in Canaan Kendryte K230 SoC.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 9d8670c00e3b..e853a7fcee8a 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -47,6 +47,7 @@ properties:
>                - sifive,u74
>                - sifive,u74-mc
>                - thead,c906
> +              - thead,c908
>                - thead,c910
>                - thead,c920
>            - const: riscv
> --
> 2.43.0
>
LGTM, Great job!

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

