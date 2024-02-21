Return-Path: <linux-kernel+bounces-74114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2214F85D01E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB8D285BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BDE39FEE;
	Wed, 21 Feb 2024 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K57iZaKy"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A122F0C;
	Wed, 21 Feb 2024 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494670; cv=none; b=XMMk0U/vsGuWE2xtXTRwzWmJSDZCpnIIEPH37PqJ0pBLckFELhib97FP3vaG5ZWXL/xhz8vOJIG+wvddn7f9Wxnp3Mty1B/Kfn5ijfjtp3cTrihmxGJr1wr6EXVdraQ2jYldrEyrqcZ4HYhdppSRIdUe3u2mSKcGEIEi3yXwG4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494670; c=relaxed/simple;
	bh=OR32rfWwqviOyaWVmjc1QHD68SeoWr7UywdOWUPAcGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCpiv8XyK+eNVG/kkhZ7jtFGbXkEFW7Inbc8OJlqGePZioj9GWQTiOskYDfCnEbnGk2H43U1S9yT6eBpGBzubOL//BkjezwyhQObKfFdyeOQk6ce8p6TUJF3OimhA5D0LxNiP8UKpzb5kwu9GHI+pKSMyXeKuNm+ixqv/IU0L/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K57iZaKy; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d220e39907so67386571fa.1;
        Tue, 20 Feb 2024 21:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708494667; x=1709099467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sA+prMwPrieisZTlntbGwJdqfOFYtGdFvXg2Kpl0Qog=;
        b=K57iZaKy26k9SKkyQf5WWNLGduyUy7cgkqKx44OFj5EktMNOmfpxCJExJhTyPuYKCb
         COwbAw1gyjdi3/qvbTmnpPTRMRL0/jkMvNYEetMip0UwGYq3OM/y0dYQ/b+GS+c7RoUI
         lnT4ueF37BqSCEtsxuWaL/5AzODNskoAVB6vVSTH98aRvPW6MPJmKpkuTY9tv5ELYHvg
         Rec0p5i3gC3SKVSN4wHXU5QbxvIxV+9df/IBZxDJGCG1nKLhYMI1pqjPpD5BqQSa6pNv
         n//g/v+qF934gTZuHzHTht93FrffYa7YsB545fkZdW9O0RkmK55fBqJ8zHIxZbvkBkhe
         //BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708494667; x=1709099467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sA+prMwPrieisZTlntbGwJdqfOFYtGdFvXg2Kpl0Qog=;
        b=VOQQ7I3w9BnBA9b5uyLPg8wRGol3g084AF99phamLIdeD9egLNLRTMBGqiZnHrhuhA
         zOM5zk+f3gtSLEDN4wK8/wJwh2S4dF8B4xPJHxtAjAB9BovcS11Iq2rmx60MBDX2TURm
         qL24BSa3fGU2INDg1eYPjBofdiNZclXVvEWW2JV3K/8VgjSUlpkUi2OLNdUy1rLJoNL1
         DndhXqdAlIetS+gO6dCLkkEoIOJ4LZB8xSrfcZ/ThVsWk00P3rsUSCKNYLuMybT0TB6Q
         T2dXzPkbyc+nrqKD7cdVMpnxs3LOnT+DViHNn54GldTG6y6V4bIO7mNzKOrxtZBt9TcN
         p6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2OEMf2lO0QSfMJaitcbXx5ekBpaSDTLAQtmpM5ewjA6WGdwSjPmVQzd9Xu+rhZocCQkfcVACggw/P44pPKDUlN8uTBTKk3+xfRBB4vuwYZpVW1vP0sCUI3vBWjIxD/OHrk4t54MfVHZg=
X-Gm-Message-State: AOJu0Yyu4MnjHglIR7M0QV3M67t6R9+dL7Me9gb+nGH0JydGtjx01rFp
	W9CK5ap3Mgpq/fGieVh6K6wVK43XFlc1qolmx85f6W3LbVievdK8lbX/rfoqeskdVGbv4L5DwPK
	DtNbQXQqQVDVOi6JppaUjk2VeAsrg3JLb
X-Google-Smtp-Source: AGHT+IFmM/VdDZXIoTMsEpM4pWB+1n+RPoE+FFfk+TeIHFHgMXj843KNNmqlt7TRiY63SkeiaYdXMmR83rkT8KYBjK8=
X-Received: by 2002:a2e:3318:0:b0:2d2:426b:455c with SMTP id
 d24-20020a2e3318000000b002d2426b455cmr5817101ljc.0.1708494666925; Tue, 20 Feb
 2024 21:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221052624.573287-1-zhaoyang.huang@unisoc.com> <20240221054124.GA14358@sol.localdomain>
In-Reply-To: <20240221054124.GA14358@sol.localdomain>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 21 Feb 2024 13:50:55 +0800
Message-ID: <CAGWkznHTY-ROF-D2w8BjGabfzw1yAqoGsHz321BUKrRBcWuqaw@mail.gmail.com>
Subject: Re: [Resend PATCHv9 1/1] block: introduce content activity based ioprio
To: Eric Biggers <ebiggers@kernel.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 1:41=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Wed, Feb 21, 2024 at 01:26:24PM +0800, zhaoyang.huang wrote:
> > +/*
> > + * bio_set_active_ioprio_folio is helper function to count the bio's
> > + * content's activities which measured by MGLRU.
> > + * The file system should call this function after bio_add_page/folio =
for
> > + * the buffered read/write/sync.
> > + */
> > +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
> > +void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio)
>
> How did you test this?  Nothing calls this function, so this patch can't
> actually be doing anything.  Are you planning to update any filesystems t=
o use
> this?
Thanks for asking. I verified this patch in an Android based 6GB RAM
system by modifying EROFS/F2FS/EXT4's aops API which I didn't
upstreaming yet. I would like to recommend this to the desired fs if
this is accepted.
>
> - Eric

