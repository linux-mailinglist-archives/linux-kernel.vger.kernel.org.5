Return-Path: <linux-kernel+bounces-24482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA282BD34
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD99288140
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADA25D730;
	Fri, 12 Jan 2024 09:28:22 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDA956B7C;
	Fri, 12 Jan 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5f68e2e1749so53062227b3.2;
        Fri, 12 Jan 2024 01:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705051699; x=1705656499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFSXwEbB/Q5EnqhQ+Pg663NDioojHF/uWmL+sDkT0aM=;
        b=wLNpo1qNcMyMaBgmR0YdBGqgEH3HUViLOMJEsO1QKYLTHKbgguWP4UeDrcAUqGDzK1
         Jtw/hRyiSbhJfVBLdZ4ZHzGRKil1j9sr+dR3SBElvXDv7reEX0C1fcnPftsFl0cI73Ih
         7Z7CabuL8oYWDfIz0aXHmhG33Pd+tsWPNi3MqkMF82RmsCt4v/jN11eWrhMOEH5RdRfk
         BAX6daE422L1bIBUXfo/pSCAvnaurf8Zx/JZktevHv29xboiKJrjMn01cJ3AdG9A12d7
         MOGy7/uDd8KqQkMGJXZV1FDGn8yxD3i24MeOBanE4CT2wPodZHE6IPpB/CdQCc8IsiJc
         Axyg==
X-Gm-Message-State: AOJu0YwwR2CwHySxJsNgNnuZg0yddICRzX5+l8Km0PRDE3CeM0Reaa0a
	+PGIuI/dB5XdYhyF2TBahEb/MhBQOuxk/Q==
X-Google-Smtp-Source: AGHT+IGIsb6mUb+Gd2Ndvuu29BXUgX1PmoisoYXYuCRH8OTLz42eWw3Bdj5j6w1cZmEmL0hW0ZyOJg==
X-Received: by 2002:a81:5716:0:b0:5fa:1972:3871 with SMTP id l22-20020a815716000000b005fa19723871mr873739ywb.72.1705051698797;
        Fri, 12 Jan 2024 01:28:18 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id h184-20020a0dc5c1000000b005d8ce4ca469sm1186896ywd.99.2024.01.12.01.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 01:28:18 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5ed10316e22so59702987b3.3;
        Fri, 12 Jan 2024 01:28:17 -0800 (PST)
X-Received: by 2002:a5b:150:0:b0:dbe:a209:3305 with SMTP id
 c16-20020a5b0150000000b00dbea2093305mr425087ybp.98.1705051697598; Fri, 12 Jan
 2024 01:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214222107.2016042-1-song@kernel.org> <20231214222107.2016042-2-song@kernel.org>
In-Reply-To: <20231214222107.2016042-2-song@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Jan 2024 10:28:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUtzhwHLa_DTtH00YsZ6t_CefZjZj6oS_mpckHDNXpYWw@mail.gmail.com>
Message-ID: <CAMuHMdUtzhwHLa_DTtH00YsZ6t_CefZjZj6oS_mpckHDNXpYWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] md: Remove deprecated CONFIG_MD_LINEAR
To: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Neil Brown <neilb@suse.de>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Mateusz Grzonka <mateusz.grzonka@intel.com>, Jes Sorensen <jes@trained-monkey.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Song,

On Thu, Dec 14, 2023 at 11:22=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> md-linear has been marked as deprecated for 2.5 years. Remove it.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Guoqing Jiang <guoqing.jiang@linux.dev>
> Cc: Mateusz Grzonka <mateusz.grzonka@intel.com>
> Cc: Jes Sorensen <jes@trained-monkey.org>
> Signed-off-by: Song Liu <song@kernel.org>

Thanks for your patch, which is now commit 849d18e27be9a125 ("md:
Remove deprecated CONFIG_MD_LINEAR") upstream.

> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -61,19 +61,6 @@ config MD_BITMAP_FILE
>           various kernel APIs and can only work with files on a file syst=
em not
>           actually sitting on the MD device.
>
> -config MD_LINEAR
> -       tristate "Linear (append) mode (deprecated)"
> -       depends on BLK_DEV_MD
> -       help
> -         If you say Y here, then your multiple devices driver will be ab=
le to
> -         use the so-called linear mode, i.e. it will combine the hard di=
sk
> -         partitions by simply appending one to the other.
> -
> -         To compile this as a module, choose M here: the module
> -         will be called linear.
> -
> -         If unsure, say Y.
> -

Is this what you need to recover data from disks salvaged from a
commercial NAS configured in JBOD mode?
If yes, and there is no better way to do that, you probably do not
want to drop this support.  Actual NAS systems running Linux might
use this as well.

>  config MD_RAID0
>         tristate "RAID-0 (striping) mode"
>         depends on BLK_DEV_MD

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

