Return-Path: <linux-kernel+bounces-93116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135E5872B36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EB0281492
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB37D12DD9C;
	Tue,  5 Mar 2024 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrXHOuG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC97E581;
	Tue,  5 Mar 2024 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681973; cv=none; b=czkmLdodNfhX/gIeMCLWP0sOvg2o2qW6YcFWt/GXBjFZpFNQ/Ei2o69vHbV75HVomPHdN/OqdgAyYVZHPUW0pg3ogBodkTU2QM60IddYCNacC1SngZ06ZloHz8GOaPixFbO85r/kciOf7Ol8b1YM+dSBhX/FQrjAUNqisOpjvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681973; c=relaxed/simple;
	bh=0WKq2SVEvxpP+1ncC/HkwCmFo+bMUGrCOaZgdBI8xhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/+zL8yOZe1KguKshSCqLaLjoom7H+XLTVd6lklzfzmPKb58ltpb+ZvKSSmy+wLyLTR/oS0mrMHczLjHc3Oiv1WW529Z8rwchLzcT2iQLaJzJoLCiAJKS1Z40vo8YXiHDASKhwCE0QX0TqodQu2VFoP8zYMjFy0TSggcpmY2UYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrXHOuG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93758C433B1;
	Tue,  5 Mar 2024 23:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709681972;
	bh=0WKq2SVEvxpP+1ncC/HkwCmFo+bMUGrCOaZgdBI8xhg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DrXHOuG4+0G2fQIj9hLT1rgzGoIDuTcUheEnY8vADe8Q7/qPJlCOOg+eIlNgk+dVO
	 IcYLGu9lkBNOsxSjz03v/ERiwbeClJvEcGcShZP4zkqk3BwJy3zXqir285xBkPSSw5
	 Rtz81FWyoiZIDjmcRW0kl2ctWXYy0mXkg4bV4zmfESxT+wsqDcPa31tNWCdfC0dn9W
	 JXqfyjub+rbixVuyuCtxqE3G9Qg6jDTN4P0/ci13wOMSb0bvAp1Yi28Pwk7u/xYTRZ
	 Tl6En0FBylAFBfmI3VF1RAbTTMbiGwgelgBsojTTFbguAKWvKL0/ReG5hjMzjxql/I
	 ARJjLtR+u+gxg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso8421375a12.2;
        Tue, 05 Mar 2024 15:39:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNgXCmxkRmhhVWn5llKgs4VruYS3Ewv3hzUFckQmYPCiGnGrDp+BCZk2Cv/cm9gQBzCqK/RUg4KnhB0pspTNtWATeHzGnrcBGuXpGunKZ3X+Ov56resqc2o8NA7kxrw+eK+6qX3o8hIA==
X-Gm-Message-State: AOJu0YyYfn6NORMsDKwjqsKvuuA0+ZJqW2B+EAvRVJywYgI/IIKMh9SY
	CXqKiu4dAs/X/sh0vLKD5ebLjOabGt5v59+015pMUcyen4XOy/x6MhR7LDlaqg56vqikm/uor2q
	BQb33sTyIKyoxy+ycoLIEqKV6FCc=
X-Google-Smtp-Source: AGHT+IEB6V0Shy2ZvcaxQBZLlfsMO3KwwVzXupQ9uDjw1BFd30mhk74+4sUNNN+jon5kpSkKL5kyYuj5HLQYuJjmpDI=
X-Received: by 2002:aa7:c594:0:b0:567:2cf:1ecc with SMTP id
 g20-20020aa7c594000000b0056702cf1eccmr8400959edq.30.1709681971001; Tue, 05
 Mar 2024 15:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com> <tencent_93C7B4F91D79712162D243201AF9F8520409@qq.com>
In-Reply-To: <tencent_93C7B4F91D79712162D243201AF9F8520409@qq.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 6 Mar 2024 07:39:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT1YM-N-W-GsuhhXpBh7Hjip9GofJCSxzbGpxyncn+TTQ@mail.gmail.com>
Message-ID: <CAJF2gTT1YM-N-W-GsuhhXpBh7Hjip9GofJCSxzbGpxyncn+TTQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 4:03=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
> Add compatible string for Canaan K230 PLIC.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index 709b2211276b..122f9b7b3f52 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -65,6 +65,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-plic
> +              - canaan,k230-plic
>                - sophgo,cv1800b-plic
>                - sophgo,cv1812h-plic
>                - sophgo,sg2042-plic
> --
> 2.43.0
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

