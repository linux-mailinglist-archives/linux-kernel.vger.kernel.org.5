Return-Path: <linux-kernel+bounces-76204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C5385F424
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64DF6B26733
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7360C374E0;
	Thu, 22 Feb 2024 09:20:39 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50536B04;
	Thu, 22 Feb 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593638; cv=none; b=UosVDz0ucGRIuIAM1uqOveXB+tOQvK8CqKhOgRS8ze0fFmMCkZxysXBFnqTUyBbVT42rA+If6ur+4c+uTlSMhUvKuMJglh0Jn2CcOMJ8epz//xW9gjYStU1GgPK03FdksnaKWqlY1KgKoRyOiCDYCYMY15rApQRPY8PdGAChKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593638; c=relaxed/simple;
	bh=IMQw77ccF4g2DANOObaMDODO48zmcN77rc7eCX8aoQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEb8zLmR1x6+DhkywaBrTByoOM18HFkmouakhParHdiKA5H33Ma334DS0W9QFxwB7qN+XMS1k2dq8LH4xiLc9wEUj6ETZdVHyldwaSbvzSjlJhRYLidAmme5B3Wzf0ayaDjKPMxPl3msllHqeNQxNFOzsYOuGN5iBNzAcL2IdhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-608a1deb6d4so1626067b3.0;
        Thu, 22 Feb 2024 01:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708593635; x=1709198435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3B7i94vDchiq91cc9YFdV+tSxnmxn5ulFc88M4Jfpc=;
        b=HHN+QFeLlaWa/lvmdea7YqJk1upRCwYGOVBQYnZD/4OGa6Lx5PaHNApMsaW2iXGX7z
         uFn1zppWWXU7X5l6GzhaapHG5h8R8xct7KUoAAGdVnH970iIEQMCUU5bXMcytCzD5a+f
         Ey1wVFJg1tcOnM9iwRrnKblSRBYmANl17GHhJ5p76dL0FjeaZ5aRoQOTBYsr0gmD3rr4
         4lPYveKAqddaiogiMma1Bko41WyDB+7TkgX3fYi/KVBemGVU3QSDozXAQJtdNBX3j5E4
         ivbZdoTokIhS7XBXZRUdCR+SE4PA5fdmVR6qkxFZjNXm6u1jSjzzkFEiCDZo3882dTvV
         OWSA==
X-Forwarded-Encrypted: i=1; AJvYcCWpvLYIxRKixGjBslMP21WIAtaQ3RWhzibi/EE0D62kIKYn3oU+udJdnOrqpPBCFfZm6eeDFKWvo2Em5Oxg1O0FzMbLfoPDEuFoW6G16oHScvNc+49xFQ/BnPZaluJx5F1/zN7q0nLq
X-Gm-Message-State: AOJu0YxmPX+WyUyAvpU8P2RrNqMbsr3dPIx1t/0d14Orbk3USBmxEpsx
	jy1+vc45QZaFvR4oscwMWt55+woa5t7+FXzfoJqYpsMr89FBwUA1QOXdr6N0+TE=
X-Google-Smtp-Source: AGHT+IH/uUJzII/+d/aL7TBg2PGOfhwznjQclPlTvce4hFi2s3uMnNzT5PjU1NqBQ/UYFvzkxq7c2g==
X-Received: by 2002:a81:9945:0:b0:608:bcc:3a1e with SMTP id q66-20020a819945000000b006080bcc3a1emr14717734ywg.19.1708593635655;
        Thu, 22 Feb 2024 01:20:35 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id o184-20020a8173c1000000b0060410ee94a7sm2943215ywc.143.2024.02.22.01.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 01:20:35 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc73148611so8621686276.3;
        Thu, 22 Feb 2024 01:20:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZHpJCmZzQJpXQtKjMgBJKtY13DKMhBWMRhOFbZFmIW2RIZH3bP85hucSZ/z2fLcoPkYNYxmvfbI/eEeK+w+3Fxv0zY5w2tqkKhRIbJ4fDDGW5SOpf9nTiFldAhN6fxHeGJjNzWqX1
X-Received: by 2002:a05:6902:310:b0:dc7:483d:5903 with SMTP id
 b16-20020a056902031000b00dc7483d5903mr1918977ybs.17.1708593635269; Thu, 22
 Feb 2024 01:20:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@linaro.org> <20240221-fix-sh-mmcif-v2-2-5e521eb25ae4@linaro.org>
In-Reply-To: <20240221-fix-sh-mmcif-v2-2-5e521eb25ae4@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2024 10:20:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=PogDu8RAKvBw6wY280zg53-aNypdmBQDgbanOXQFSA@mail.gmail.com>
Message-ID: <CAMuHMdW=PogDu8RAKvBw6wY280zg53-aNypdmBQDgbanOXQFSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sh_mmcif: Advance sg_miter before reading blocks
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:23=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> The introduction of sg_miter was a bit sloppy as it didn't
> exactly mimic the semantics of the old code on multiblock reads
> and writes: these like you to:
>
> - Advance to the first sglist entry *before* starting to read
>   any blocks from the card.
>
> - Advance and check availability of the next entry *right after*
>   processing one block.
>
> Not checking if we have more sglist entries right after
> reading a block will lead to this not being checked until we
> return to the callback to read out more blocks, i.e. until the
> next interrupt arrives. Since the last block is the last one
> (no more data will arrive) there will not be a next interrupt,
> and we will be waiting forever resulting in a timeout for
> command 18 when reading multiple blocks.
>
> The same bug was fixed also in the writing of multiple blocks.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 27b57277d9ba ("mmc: sh_mmcif: Use sg_miter for PIO")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, eMMC works again (tested on APE6EVM and KZM9-GT-Dual).
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

