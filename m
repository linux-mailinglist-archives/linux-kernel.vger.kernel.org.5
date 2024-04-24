Return-Path: <linux-kernel+bounces-156929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4F38B0A79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A771C23A32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9A315B57E;
	Wed, 24 Apr 2024 13:09:30 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76DF1598E5;
	Wed, 24 Apr 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964169; cv=none; b=S7RJ3LRVZ7sWXDJm09cD+LIjb3KP+cGZX8VweTfx0RJh7r1IUkgyIMlp1qQaWxX/UmT4E3dhdU0YR01b5AdDidY1h37JQ4YU36oUApl5wynSRkOa0TaMPpMtYmCH52BjaoX18Lf1heRKo32ZCDDs7fQaMACAmWONIn8CVwd0jg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964169; c=relaxed/simple;
	bh=75R0hi6xxQzQP7J3rpFLOI9RJeymEoKu056YrXuz308=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOaVZxpFZESwNQmYJP2GPJ5cwt3M4JZm6PykvbpIWY3Om3A0FKj+Ss8voJ/GGKZJns+XwECiGFKhsM6WAsYj0qRZ6uYqftfyN62ePkhoCIptIkr+lhm6WwKY1abfEQejMc+lKsBq14znj+blGrixMCiotusGiMoKKiq8tpB2I2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61b3be24dd9so7612077b3.0;
        Wed, 24 Apr 2024 06:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964165; x=1714568965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xxwNYEWxxeYtCAyvMedqQ43RfWohIK85VVdJWkk9A8=;
        b=bXTXf086KMcQdB0zZeRv792kni7yzU679cuq3j1BHDnYc2IF+HJISoYQtCDXx8uPhj
         4SibOaaxeQGHTSB3Cv1Bc4umEZSQoPOFFdXFG/iqmub1wFhmI/ko2LYaZAPT1qeNWfCG
         YzUtw7Ljo3Zx9QX559aYTOGv4bT8LzIYB5rxSBdaJ9CvvA05KH92zqcJ/mK96F61yWZy
         hW9jPD1d5RS0tlXJ4BK2C6PVqmk9gKoVqcDvwVGyRBNc2t27MhipK6LdUNlt9+gsLuNN
         T1zwXjNkNg3yBBSvVG+G5jx8UqvAAOEhRLp/hSK0EuGiNyEKk4pm1DntcLBtzPslHky/
         Rqnw==
X-Forwarded-Encrypted: i=1; AJvYcCWqzdk0KMcoeRn+ON652rFCTRTcp8XobVPTaFtYooiyrJ+mK32MVN+97rarLairMC+8pGRez2rXU4j6N1prbxEODyA/21rGoeajBz/jVQsEw6z7Qo5KEl6VvQAfnJ+3krf0pDtZjjZH4KEP+qIfT2vpgpJ4/Dza/+N+I/KFBddIdZJQNkAdfliVAO11CsQrFrtkMHM9M+YQndhgVTVk1kqxMZr6PNNpSs4=
X-Gm-Message-State: AOJu0YwJvOUPodnoqvT89fTqCcSqe0Q0JOVKpjC7zbjKYvhanzGlEfmM
	Ry9Y5isinRcUInClv+HoUHDJ8PYZ4WdP9O1PoEbOhGtijsoH9yuYLPErEUFq
X-Google-Smtp-Source: AGHT+IHN3O5B2vo30VfY+qqMbsKrR91q24DZBuBbgzYx+WSqALqi7GckGB3p8WDDdjvbClRU9Tea+g==
X-Received: by 2002:a0d:d0c2:0:b0:618:498f:9dbe with SMTP id s185-20020a0dd0c2000000b00618498f9dbemr4848557ywd.10.1713964165443;
        Wed, 24 Apr 2024 06:09:25 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id bt6-20020a05690c072600b0061524fc1411sm2964894ywb.45.2024.04.24.06.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:09:25 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso828876276.0;
        Wed, 24 Apr 2024 06:09:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFBz4XO3fIn8R2slgHKh51oukLzkTmtak3AUkX3zvV8D+JFY1cv2CF6ktjx/B4YocL7RBtErM6XHsRTvKivt747/ebcv/r6izLqZDb3g468EMk5YiQYOo3vJJhY4Ua0IGsbJvmOdnCRmqSHl0Twgm6KjAHD9j3/F8fvm7qUtwdexd4lmzEoUNRgzdtosOmrDp/bjNdxMYFukXOJRUzEEVP1Ve3cnvkc3g=
X-Received: by 2002:a05:6902:72f:b0:de5:4b29:22e6 with SMTP id
 l15-20020a056902072f00b00de54b2922e6mr2273181ybt.1.1713964164555; Wed, 24 Apr
 2024 06:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407131931.4055231-1-ming.lei@redhat.com> <7e38b67c-9372-a42d-41eb-abdce33d3372@linux-m68k.org>
 <Zij97qGQY1MRrEb8@fedora>
In-Reply-To: <Zij97qGQY1MRrEb8@fedora>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 15:09:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrx8M62ETfuX44UZ_y8ab-JwTNA28V6WObg_kFXP+HyA@mail.gmail.com>
Message-ID: <CAMuHMdVrx8M62ETfuX44UZ_y8ab-JwTNA28V6WObg_kFXP+HyA@mail.gmail.com>
Subject: Re: [PATCH] block: allow device to have both virt_boundary_mask and
 max segment size
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	janpieter.sollie@edpnet.be, Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@kernel.org>, 
	dm-devel@lists.linux.dev, Song Liu <song@kernel.org>, linux-raid@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ming,

On Wed, Apr 24, 2024 at 2:41=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
> On Wed, Apr 24, 2024 at 12:26:26PM +0200, Geert Uytterhoeven wrote:
> > On Sun, 7 Apr 2024, Ming Lei wrote:
> > > When one stacking device is over one device with virt_boundary_mask a=
nd
> > > another one with max segment size, the stacking device have both limi=
ts
> > > set. This way is allowed before d690cb8ae14b ("block: add an API to
> > > atomically update queue limits").
> > >
> > > Relax the limit so that we won't break such kind of stacking setting.
> > >
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218687
> > > Reported-by: janpieter.sollie@edpnet.be
> > > Fixes: d690cb8ae14b ("block: add an API to atomically update queue li=
mits")
> > > Link: https://lore.kernel.org/linux-block/ZfGl8HzUpiOxCLm3@fedora/
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Mike Snitzer <snitzer@kernel.org>
> > > Cc: dm-devel@lists.linux.dev
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: linux-raid@vger.kernel.org
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >
> > Thanks for your patch, which is now commit b561ea56a26415bf ("block:
> > allow device to have both virt_boundary_mask and max segment size") in
> > v6.9-rc4.
> >
> > With CONFIG_DMA_API_DEBUG_SG=3Dy and IOMMU support enabled, this causes=
 a
> > warning on R-Car Gen3/Gen4 platforms:
> >
> >     DMA-API: renesas_sdhi_internal_dmac ee160000.mmc: mapping sg segmen=
t longer than device claims to support [len=3D86016] [max=3D65536]
> >     WARNING: CPU: 1 PID: 281 at kernel/dma/debug.c:1178 debug_dma_map_s=
g+0x2ac/0x330
> >
> > Reverting this commit, or disabling IOMMU support fixes the issue.
>
> Can you test the following patch?
>
>
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 8e1d7ed52fef..ebba05a2bc7f 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -188,7 +188,10 @@ static int blk_validate_limits(struct queue_limits *=
lim)
>          * bvec and lower layer bio splitting is supposed to handle the t=
wo
>          * correctly.
>          */
> -       if (!lim->virt_boundary_mask) {
> +       if (lim->virt_boundary_mask) {
> +               if (!lim->max_segment_size)
> +                       lim->max_segment_size =3D UINT_MAX;
> +       } else {
>                 /*
>                  * The maximum segment size has an odd historic 64k defau=
lt that
>                  * drivers probably should override.  Just like the I/O s=
ize we

Thanks, that works for me (both with/without IOMMU support)!
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

