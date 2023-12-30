Return-Path: <linux-kernel+bounces-13364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0255282040B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC75EB2137A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908DE2569;
	Sat, 30 Dec 2023 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="I4KSlf/e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11BB23AF
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2768b78a9eso337311366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 00:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1703925291; x=1704530091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jKSwzg5qyL9S9punEuxfKNhmr3B9w+Hx8x84ychqNZo=;
        b=I4KSlf/eOLGBilBW0ohqJzKGmtzMjF8aOokU1I67Uaj+/q+7O1XvwDkB+hYTJCN6/U
         8q8g79Yf7SlbB0gnUafJC+RCqpwHSNa9bU1gVMoi3bgbs34VPnzSR+MAq322FzohJtim
         83/D5r5jCLppj6nSv4vAQKe6P2m/NHmg6ChV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703925291; x=1704530091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKSwzg5qyL9S9punEuxfKNhmr3B9w+Hx8x84ychqNZo=;
        b=ldzlg4UOPHxr1aWxntEmLM466/Ot43K69gg+53tuAjGPOFrt3182GgXE4pMtti6xC1
         W6xKCqVjfyYLbpaUb1Kkvosej7Hkxuyaf7WTETKxjBO4SaqDqEWYhkpODy4AuItn+6ke
         7cdP8arMZrbAA6qhnPKlG/WWjsEXg8I6xKf0kaGrkUVYHu7F9PjhqfydXdew+qwyHqkc
         UpqoJuFWktaLYJoneXggK2YuiZvyioNsZSxhMGHgiB2rbiYnnj5AFIlTwmqUsG8aRms0
         l4W/uDtlLbT8fvZYOI2fleklm7zas3CbvssRjHjgy+9Agt8pP1DOD7COHEujEYHSYbLM
         Bs0g==
X-Gm-Message-State: AOJu0YwlNyNlJ3weivi850DhRh/qaWefEwchb8N0EF+1LTZLGOkN5UKg
	nq/MWWFYNJ+X//CGZlERqVJ7ZIphWt0XJ8zCAU6LnOgEa3iglQ==
X-Google-Smtp-Source: AGHT+IGZ1829LMk+ibKivi9thXfdLJc26LZgUmRke9amhyQhkx0MkfWd+YibVkFTZXYyPxySeMX0Z8quwmY2SmDM7zQ=
X-Received: by 2002:a17:906:97:b0:a27:a953:bf63 with SMTP id
 23-20020a170906009700b00a27a953bf63mr1356526ejc.42.1703925291104; Sat, 30 Dec
 2023 00:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMVG2su=Kt5mkyEHGh5D4YH+1xTUFX3BhOjf-D0bcRTntav3ng@mail.gmail.com>
 <jt3gy5v3jhqadakhxbdezvfo2n2f4n7sc52ljw4kztct6poihr@zork6muwdity>
In-Reply-To: <jt3gy5v3jhqadakhxbdezvfo2n2f4n7sc52ljw4kztct6poihr@zork6muwdity>
From: Daniel J Blueman <daniel@quora.org>
Date: Sat, 30 Dec 2023 16:34:39 +0800
Message-ID: <CAMVG2sveJiXO=88uFfrxYK0n3Nx1a4mTDJZ6N-zwaAUj76twDw@mail.gmail.com>
Subject: Re: Stack corruption in bch2_nocow_write
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, 
	Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Dec 2023 at 02:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Fri, Dec 29, 2023 at 07:43:13PM +0800, Daniel J Blueman wrote:
> > Hi Kent et al,
> >
> > On Linux 6.7-rc7 from bcachefs master SHA f3608cbdfd built with UBSAN
> > [1], with a crafted workload [2] I'm able to trigger stack corruption
> > in bch2_nocow_write [3].
> >
> > Let me know if you can't reproduce it and I'll check reproducibility
> > on another platform, and let me know for any patch testing.
>
> this should be fixed in the testing branch:
>
> commit ab35f724070ccdaa31f6376a1890473e7d031ed0
> Author: Kent Overstreet <kent.overstreet@linux.dev>
> Date:   Fri Dec 29 13:54:00 2023 -0500
>
>     bcachefs: fix nocow write path when writing to multiple extents
>
>     Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>
> diff --git a/fs/bcachefs/io_write.c b/fs/bcachefs/io_write.c
> index c5961bac19f0..7c5963cd0b85 100644
> --- a/fs/bcachefs/io_write.c
> +++ b/fs/bcachefs/io_write.c
> @@ -1316,6 +1316,7 @@ static void bch2_nocow_write(struct bch_write_op *op)
>                 closure_get(&op->cl);
>                 bch2_submit_wbio_replicas(to_wbio(bio), c, BCH_DATA_user,
>                                           op->insert_keys.top, true);
> +               nr_buckets = 0;
>
>                 bch2_keylist_push(&op->insert_keys);
>                 if (op->flags & BCH_WRITE_DONE)

Thanks for the quick update, Kent.

With this change and a few runs of the reproducer, I still hit this
stack corruption with the same backtrace.

Let me know for any further testing,
  Dan
-- 
Daniel J Blueman

