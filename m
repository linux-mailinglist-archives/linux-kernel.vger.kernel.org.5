Return-Path: <linux-kernel+bounces-24968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1BB82C566
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477FFB219A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE00F17C9B;
	Fri, 12 Jan 2024 18:27:56 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03417C8D;
	Fri, 12 Jan 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e82f502a4cso58009917b3.0;
        Fri, 12 Jan 2024 10:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705084073; x=1705688873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BJ2WZX4mtYqpwBUHJyyeiT7eNbqAuxy96Kww4r+LXQ=;
        b=GUt+ndJf52R/+30jG/w/aJJQWnspE13Xmif7JivZcKju1OgdPNPR6z67cTCq25QSdt
         ModJZ0DkkrgdwYdoFp1TgNr/UA5eNE0UO+7xobGkLJ9GdgrIgOwtF/jId4BCKcSK5tnN
         6lpaooo0PVDHtBq+zL2AiMmSKM4Jwwls89kzZ8R2ifIDTq2jiABEZ3pcMvL5h9eTI1/j
         8H9ico0Gz9lVtTALdPznGO6OpxFYGvX9P+CY/CBLYZqNSc6ReqmC+EPv2MIaNsHa0cyS
         7RkcBiMpfVbDMTC3BRzfjV0zOTd783qPdKJyvP1dPuvbI0cZke0iDSxBL3CDKPFYeNTB
         wmLA==
X-Gm-Message-State: AOJu0YwxK1ryP39vJz+f5pAVQuqAprdcwZxz+pPrqk4g4bwPS/kSgmrG
	JPm1FJktf49W38ucAMK0mtwB5Qv4ywRi5Q==
X-Google-Smtp-Source: AGHT+IE9RoWp3i10xpf6g1epyIgWlK9Sn/awn4vi1jxOqmRmn2q4EuJbdULMc4brijGsWdtY0usgjQ==
X-Received: by 2002:a0d:d5d1:0:b0:5fb:60db:86b0 with SMTP id x200-20020a0dd5d1000000b005fb60db86b0mr1390345ywd.19.1705084072947;
        Fri, 12 Jan 2024 10:27:52 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id v141-20020a814893000000b005fb420b14dcsm1422530ywa.108.2024.01.12.10.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 10:27:52 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e7467eb93aso58735757b3.1;
        Fri, 12 Jan 2024 10:27:52 -0800 (PST)
X-Received: by 2002:a25:d84f:0:b0:dbc:d3a5:d039 with SMTP id
 p76-20020a25d84f000000b00dbcd3a5d039mr779893ybg.32.1705084072167; Fri, 12 Jan
 2024 10:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214222107.2016042-1-song@kernel.org> <20231214222107.2016042-2-song@kernel.org>
 <CAMuHMdUtzhwHLa_DTtH00YsZ6t_CefZjZj6oS_mpckHDNXpYWw@mail.gmail.com>
 <CAPhsuW6KVN1c=dB1RXVQjygBevVcb_1qQJoLz3zA-qTVVmbCAw@mail.gmail.com> <20240112171010.GA18360@lst.de>
In-Reply-To: <20240112171010.GA18360@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Jan 2024 19:27:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWvo5ggC31Ukd8+sLC1jyqcXw=T-tVDtwdLqRg87HwvCQ@mail.gmail.com>
Message-ID: <CAMuHMdWvo5ggC31Ukd8+sLC1jyqcXw=T-tVDtwdLqRg87HwvCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] md: Remove deprecated CONFIG_MD_LINEAR
To: Christoph Hellwig <hch@lst.de>
Cc: Song Liu <song@kernel.org>, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Neil Brown <neilb@suse.de>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Mateusz Grzonka <mateusz.grzonka@intel.com>, Jes Sorensen <jes@trained-monkey.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Fri, Jan 12, 2024 at 6:10=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
> On Fri, Jan 12, 2024 at 09:08:04AM -0800, Song Liu wrote:
> > Thanks for the heads-up. I honestly don't know about this use case.
> > Where can I find/get more information about it?
>
> What NAS uses md linear?

No idea, I was just wondering....
Lots of NASes sold support JBOD (yes, I know I should not use anything
that lacks mirroring for data I care about ;-)

> Either way you can always set up a dm-linear table to get at the
> data.

If dm-linear offers the same functionality, I have no objection.

Note to self: learn about the difference between dm and md, finally...

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

