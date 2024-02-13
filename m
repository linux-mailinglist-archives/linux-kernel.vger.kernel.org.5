Return-Path: <linux-kernel+bounces-63671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695585330A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D64B23329
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6693B57875;
	Tue, 13 Feb 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AIaqCwPT"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3357865
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834350; cv=none; b=ckfnhpyjYi6YRo8A3J9gg0PjYmIeCJqF0660u3TFWE9y61ctfcSCN0ExR+j2KjoxlEI/aKtjtkRA5sb8srjfaeRoGpx0tWBfosjfsOLAMaXuzxIFyqfMGkqcR4hs7tC++kkqJzMmFe6adQQ/dnZ/pvIrHzjXOdQdu0yfzJQ/Euw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834350; c=relaxed/simple;
	bh=X4shIH4Wr5pt55xQGZcHYq266klbBFPIeROLNWrEh60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDei0m6IAQFJ5uaSJTH1f1auKIxwMj0BJHyfIJSLCbmfSzL50x5Kn+CjcbJlwpsf+a3ubsfJVMXv6cKiQO78iVO6yieFQiGtuSTNV+esFng9D6kXxz4PyKIzI4cyo2yt2xHl9+JlE8jePioWh2ROPUHQ0B9qZY2iruqg5ooKBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AIaqCwPT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3566c0309fso537469566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707834347; x=1708439147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyO3k1PUHkf0DTFKDVTvjkF1slnGeiMvgKzqY1R1vZo=;
        b=AIaqCwPThS0bFSzTYbWrGmHhuYQBXRjoHhEKIJw5kkScnG5eBGYquPn8I9+33l6zxT
         6IXgTUDe2p492MbVIO7kLloe6O0Pe+++EpvN75+wAACs0ES3Q1woYJzCN1P4PWeE7Ypd
         Z99FYSkgE4KPUa4M1iY8Qlpj0IF48ulG7+F8DCGCZy8iXL4dUhBdabe9ONbZoKoWvS0a
         jnNVvIWYeykNtX86EAcwC66HxRhJIHuPVu72awUaWABypEOhJkF1zJZYy8x0ks85bbO9
         HPTUyQMRcBxk6K6pXoLUXVH2VqXAsCKeATwrCaV9bVTyTWUzHJ73zhrlS2xe77eOQwEy
         Ka/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834347; x=1708439147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyO3k1PUHkf0DTFKDVTvjkF1slnGeiMvgKzqY1R1vZo=;
        b=GcG6EvuE0H420qyEnyhDQ9Wwbpp/Iw+ubA7iTQwx53OKerdEHWzhHpiZ04iBC+FVN2
         8R19tunICG5Z02x/qrksul1gv0lli8UnyGHFeuviwggrnucoMna2idqZhCAo5dYX2xYw
         MVCFhoOPxhiyAL8U+cpttG9lQOJAvNbZFuoKDksOUuJo9GbUd2HilLqMKpZjymrj6tMc
         KywjUO4TRB6mVF7j/+gyIOylrtOcqWDdj6IYV4Sk53IF0S8CPa2WSepmObSvCMkNdTvd
         pLloTZ52if5NsvRc6I9hccV8f9moPeuxi+0Dkds85N3DxApC+EQ+mmQVvwAbsgKCQBbM
         em0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/8QOdX5uN7+spdxVP0oAdSO3MjTjuSj4cpNtCWMaR0xGjLg7mJoNHAIrEKqAO3xm9hT5/EghQJTYrqgu7kjy0rl/p2PeEKGuz8J4m
X-Gm-Message-State: AOJu0YxGmBe5OKG/WXYJaaodxH3l3gPg2d7jn9i1OcXADxvWPQggLUup
	N3ms14DcfVycRUqvYHeUi8EqatR6cPwqPKpFV4JkInhKgQaI+iL4VjYinl6Mjwo=
X-Google-Smtp-Source: AGHT+IEtH690NDhq0BZA5oR5pICFr2zi1bg0SnzYVaGkCrYuaggXr7BA3cC/Af5MJwiwmwG1j0Js6g==
X-Received: by 2002:a17:906:370e:b0:a38:215c:89b with SMTP id d14-20020a170906370e00b00a38215c089bmr7288005ejc.73.1707834346621;
        Tue, 13 Feb 2024 06:25:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlYGAXYBwiHE3BQznOgrFzzKQBeyezWk23o9Bc6z2jRt8i3C7MyRV10Yfdg/ke27CwsgZLWRsD/kG73ElRLMI8DAo+x4rXAaBP7jWAkiP+6svR0TzGqcSsd3AuB2IR1ysHKFSgSaYnXiswAgjj07lMzFm9n352edoaLtPTu5m5IGGE
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id y21-20020a170906559500b00a34d0a865ecsm1314906ejp.163.2024.02.13.06.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:25:46 -0800 (PST)
Date: Tue, 13 Feb 2024 15:25:44 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Stefan O'Rear <sorear@fastmail.com>
Subject: Re: [PATCH -fixes v2 2/4] dt-bindings: riscv: Add ratified
 privileged ISA versions
Message-ID: <20240213-88c9d65fd2b6465fc4793f56@orel>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213033744.4069020-3-samuel.holland@sifive.com>

On Mon, Feb 12, 2024 at 07:37:33PM -0800, Samuel Holland wrote:
> The baseline for the RISC-V privileged ISA is version 1.10. Using
> features from newer versions of the privileged ISA requires the
> supported version to be reported by platform firmware, either in the ISA
> string (where the binding already accepts version numbers) or in the
> riscv,isa-extensions property. So far two newer versions are ratified.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> Changes in v2:
>  - New patch for v2
> 
>  .../devicetree/bindings/riscv/extensions.yaml | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index 63d81dc895e5..7faf22df01af 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -121,6 +121,16 @@ properties:
>              version of the privileged ISA specification.
>  
>          # multi-letter extensions, sorted alphanumerically
> +        - const: sm1p11
> +          description:
> +            The standard Machine ISA v1.11, as ratified in the 20190608
> +            version of the privileged ISA specification.
> +
> +        - const: sm1p12
> +          description:
> +            The standard Machine ISA v1.12, as ratified in the 20211203
> +            version of the privileged ISA specification.
> +
>          - const: smaia
>            description: |
>              The standard Smaia supervisor-level extension for the advanced
> @@ -134,6 +144,16 @@ properties:
>              added by other RISC-V extensions in H/S/VS/U/VU modes and as
>              ratified at commit a28bfae (Ratified (#7)) of riscv-state-enable.
>  
> +        - const: ss1p11
> +          description:
> +            The standard Supervisor ISA v1.11, as ratified in the 20190608
> +            version of the privileged ISA specification.
> +
> +        - const: ss1p12
> +          description:
> +            The standard Supervisor ISA v1.12, as ratified in the 20211203
> +            version of the privileged ISA specification.
> +
>          - const: ssaia
>            description: |
>              The standard Ssaia supervisor-level extension for the advanced
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Note, QEMU doesn't add these extensions to the ISA string yet, but I think
it should start, particularly the profile CPU types which should ensure
all the profile's mandatory extensions are added to the ISA string in
order to avoid any confusion.

Thanks,
drew

