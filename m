Return-Path: <linux-kernel+bounces-103735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 976F887C3C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536DB283748
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6870B76028;
	Thu, 14 Mar 2024 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+5X+orP"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62265757E4;
	Thu, 14 Mar 2024 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445306; cv=none; b=kMV59j2RYgq+8dWtA8j7bBGRALxWq2MqMM22/DAinLnkZQhdEU/v+JgEpe09sM0Dl/I+h3lN2eohWkSwUVeS8Z9fq/rHnsSabPyIa1TCAsggV+LX3PNVPNY+wL6NI8u2v1Sxg3hPo0s9mboKiDtOfMRnwYhZ9xe+1JkK2lEpIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445306; c=relaxed/simple;
	bh=Ec/8nrm/d7FLFDatEQHA6MtRCtdWILB72zpzpZwxGvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mjd4gMh+/Nupl8DyKgwRSjR00u/YsIsmylUFO/GsYpyFXRjSW/JFM3Tb22umxH1dX1sLR0PmGUSTPRm6FLv7y3iedqtd/747NH2UYe6R7I0Wqa2nV8XV/Kco2uakEPhd5UCzs1d1pto1a0cTskmNEto6kcll/UXWl1Q2wlTkEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+5X+orP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so1161294b3a.1;
        Thu, 14 Mar 2024 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710445305; x=1711050105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec/8nrm/d7FLFDatEQHA6MtRCtdWILB72zpzpZwxGvE=;
        b=k+5X+orPMDKbuu/LvTu50T87yp55zXRuA0AkYSCIc+NYBOcQmky2XnrObyqnPG/N4+
         Ilwml1sisYhf3X6d8Pijy8sjyU0f/tTUPnrgRwZicqVJJS/B0twe5menX/BWemSl4Ybh
         6q07JXyLFJtu2Afjo/Sv51gWtENV2WY54V2uhgtTESiY8NdyD6jM3+GoldxL4lCdqTp4
         auuxS6t+foWOzYHbZEgV++DhePR2l8GKB7xTgJzAuKffrvRTa0mM+pXHNYjXJASVDoev
         E80hVYPo1XZycW9TiSBWhkwu0k8/Kf7P1lQnzaBw21s/Lup6kNmrJEor6VPFPJSiwt8z
         2nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710445305; x=1711050105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ec/8nrm/d7FLFDatEQHA6MtRCtdWILB72zpzpZwxGvE=;
        b=tcxT/4MgCEJlHdhvj6gs4V2S4ilYbETQY9KYSb51k6V8bgk6NFXk2f1Epx/ZspmwsU
         Kz8nvNznepzGwqC7pvjGh0db6K38g5s8toeOuuYkHrgJjbx8jEQKZ2E1YciSk6HzkD4A
         zwHmB2bi3DQ3/S4PMLwG7dkw0IivgwGgvxveF/IJ+MDiSxUa1/+2iTxCS2VIM26XgZP/
         opu3BFyGCR6paVoZp5cZEUx1pjTXF49d2GYnz2t5vqZ+dLK8kdHuPVIJJbeUvwNyb7/O
         /NrY5qogn47eL6gri1JW0pzrdm03oaOKD/Uz9em7QAaTH4FfbLVsCrd6ocumkpcAsDAh
         fbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx2TWF5TX5o5uzrJ+gXhv/A78ccTd2IxIY/edluc0glhGwO1x76QyG2jOzbd4lHsH4NkPxsHWr3Ssg2XpgW0NVYOjWQyzsY/n9+DNdeMKLXjdGNxJV2GiMZ39Rynjv1eUWSink0eIJyujSN9S683NnlHm+ACtOj0AxMJduFHvz0BqrgBzUTB4UFQ==
X-Gm-Message-State: AOJu0Yz2AhlWVJn64xlUHnJI59oC56Axyn9+QbQ5nu8cmjaTMEvbSqS0
	r7Zh1Sq/D54FGwIxJ7oQrGf6nL1xSSRonbLm2tzIg/gKLnuq7r6HNF6wE9wJdWOSrZinMW96m0U
	k/TH26jOa89nb64XFGmQpBMQuH/E=
X-Google-Smtp-Source: AGHT+IFOSZ/BRo9o5hwPJ2i90uLPIBo7QjcsgkSMOH+JW2YA4Z2jy8DI5Ewt+DLbqHEvgd/sSIjeV6dPBQFXSW0bpSs=
X-Received: by 2002:a05:6a00:3d56:b0:6e4:890a:7af with SMTP id
 lp22-20020a056a003d5600b006e4890a07afmr1259464pfb.26.1710445304659; Thu, 14
 Mar 2024 12:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313110515.70088-1-nmi@metaspace.dk> <20240313110515.70088-2-nmi@metaspace.dk>
 <ZfI8-14RUqGqoRd-@boqun-archlinux> <87il1ptck0.fsf@metaspace.dk>
 <CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com> <87plvwsjn5.fsf@metaspace.dk>
In-Reply-To: <87plvwsjn5.fsf@metaspace.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Mar 2024 20:41:32 +0100
Message-ID: <CANiq72neNUL1m0AbY78eXWJMov4fgjnNcQ_16SoT=ikJ3K7bZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yexuan Yang <1182282462@bupt.edu.cn>, 
	=?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
	Joel Granados <j.granados@samsung.com>, 
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 8:23=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk>=
 wrote:
>
> The way the current code compiles, <kernel::block::mq::Request as
> kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the `rnull`
> module. A relocation for `rust_helper_blk_mq_free_request_internal`
> appears in `rnull_mod.ko`. I didn't test it yet, but if
> `__blk_mq_free_request` (or the helper) is not exported, I don't think
> this would be possible?

Yeah, something needs to be exported since there is a generic
involved, but even if you want to go the route of exporting only a
different symbol, you would still want to put it in the C header so
that you don't get the C missing declaration warning and so that we
don't have to write the declaration manually in the helper.

In any case, if we really want to avoid exporting the original symbol
(perhaps so that "only Rust" can use it -- or someone trying hard to
bypass things on purpose), then we could still avoid the helper and
instead write a non-generic `kernel`-private Rust function instead.

Cheers,
Miguel

