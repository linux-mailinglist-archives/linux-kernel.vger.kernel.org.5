Return-Path: <linux-kernel+bounces-135528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5618489C732
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4C51F23363
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016313E8A5;
	Mon,  8 Apr 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/zw37wc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1CF13CFAF;
	Mon,  8 Apr 2024 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587056; cv=none; b=qX5Nl8gAVj1EBnoRQHtXFbSljt7ceh81fyveLRDEkpOkbGxT0JK6XpWafrXZJJKTT13Z+EaQQEwzDUPO0N9WKEmFI0DA7HYv8ElBcxc2y+mAMCQQ5P/7/Edf+Oa589QszLkt+BH7GAyxT7sN/UPAI0aJr+4Nzde5aeZFTVe2vSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587056; c=relaxed/simple;
	bh=zY/qVqZFx784TVeRHAP6KJW2AtpHy59nPe0QednZNHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmN6lydCUKzIzPP/IbueAfnpsFgMcfy2G7jMwcdCnHu5o6SJFIok3VxfxMubwOciYQVXtUlwEfiRSp3vgFYhuuA6libtHBHLEB/0srasyOZcaV/nnmor/RWAx2a30WcRO5Q/NbnbWLYdRtdCrRGSb4H1TYltk19+S9AHhJwNuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/zw37wc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DD7C43390;
	Mon,  8 Apr 2024 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712587055;
	bh=zY/qVqZFx784TVeRHAP6KJW2AtpHy59nPe0QednZNHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I/zw37wcZK1ziVQ2Bs7hvgieBDAGwapVV02v0CKKvK1Daf0PUKV8/mhtnJSnD2fsl
	 fgQVsej3lgvHa5Vt1rj4yVWKHWxmNVI4q2r3v9kCjc4vcDvz+y1jxAI4atLWVvm6/P
	 PL1WNtnfS1rLQLTH+2S/mD5Roo/Q5m5uaOudJofQzpXG6CYqLxC/t5YcnPJiQxPa74
	 P8BungPr6wsTKmtpX/0voTHc9SVDFTpxpP83LZuEJpS/Y9mQXDYZAeQpq3Dv6gOV3w
	 AOrgoWHvAVFsz9jWCgw0JMyWPTsx9OJKmv87bbNIv/+UGqxDzR0A1LGBrruy6togYx
	 jMwKq7v634zMw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so16922041fa.3;
        Mon, 08 Apr 2024 07:37:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNCyaNLpjZjJbp5J27xXQh7zKU3GM9XIWeio/Gxy6skCbzHjTGhCR3MKmziy9ZbJ2pOZ6uVEJeDKPYMZ5c7yukNa9ajbV2vjW8LZdN
X-Gm-Message-State: AOJu0YzzOs9lrr8K7sWNSo37EaX1gqoa+KjJw+iB6Yzt4eFdO70WF+5U
	KSVflBbN0PJxUhEKReWenjpc8y3vYCi1A3ynnFBE/iUItFoZyoEYHyhRBSIBKt42HigJnQPTeJd
	p0tSJvpqhK/VdRYZpddyiEAyoTpA=
X-Google-Smtp-Source: AGHT+IGwF8JHhG7QdVgtEZkjWHl3DvPcPdWdlHQEj/e4X0EP9bIE+AUm66Y9qxQf4N2pq0y9cgBt0NYcUKA5VXQgEAw=
X-Received: by 2002:a2e:9f43:0:b0:2d7:1ce5:3e24 with SMTP id
 v3-20020a2e9f43000000b002d71ce53e24mr6688567ljk.34.1712587053980; Mon, 08 Apr
 2024 07:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408141817.E22F8128369@smtp.subspace.kernel.org>
In-Reply-To: <20240408141817.E22F8128369@smtp.subspace.kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 8 Apr 2024 16:37:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGTrx_9igrewHOkfHAej4NdJBSKHtpCoQcif08EtF0pAA@mail.gmail.com>
Message-ID: <CAMj1kXGTrx_9igrewHOkfHAej4NdJBSKHtpCoQcif08EtF0pAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] crypto: s(h)aving 16 byte constant off arch/x86/crypto/sha1_ni_asm.S
To: Stefan Kanthak <stefan.kanthak@nexgo.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	tim.c.chen@linux.intel.com, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 16:18, Stefan Kanthak <stefan.kanthak@nexgo.de> wrote:
>
> Get rid of 16 byte constant, use shift instead of mask
>

This is missing a signoff

> --- -/arch/x86/crypto/sha1_ni_asm.S
> +++ +/arch/x86/crypto/sha1_ni_asm.S
> @@ -104,9 +104,9 @@
>         add             DATA_PTR, NUM_BLKS      /* pointer to end of data */
>
>         /* load initial hash values */
> -       pinsrd          $3, 1*16(DIGEST_PTR), E0
> +       pinsrd          $0, 1*16(DIGEST_PTR), E0
>         movdqu          0*16(DIGEST_PTR), ABCD
> -       pand            UPPER_WORD_MASK(%rip), E0
> +       pslldq          $12, E0
>         pshufd          $0x1B, ABCD, ABCD
>

Wouldn't it be simpler and therefore better to simply zero register E0
before loading E into the top lane?


>         movdqa          PSHUFFLE_BYTE_FLIP_MASK(%rip), SHUF_MASK
> @@ -297,8 +297,3 @@
>  .align 16
>  PSHUFFLE_BYTE_FLIP_MASK:
>         .octa 0x000102030405060708090a0b0c0d0e0f
> -
> -.section       .rodata.cst16.UPPER_WORD_MASK, "aM", @progbits, 16
> -.align 16
> -UPPER_WORD_MASK:
> -       .octa 0xFFFFFFFF000000000000000000000000
>

