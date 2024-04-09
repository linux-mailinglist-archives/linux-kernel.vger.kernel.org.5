Return-Path: <linux-kernel+bounces-136342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B8289D2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47941C22791
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4969C7B3FD;
	Tue,  9 Apr 2024 07:15:21 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58A2EAE9;
	Tue,  9 Apr 2024 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712646920; cv=none; b=DjtPD3g1KAierNWgol7py0Gq7lhN1Lebar+EmYoDtuqTXl0g8QYZk/PQtmAx/koQLbHsR4ywS4k0WLpcua9WHh47PFFSUXHPLt1vG9i+rWVu1AtFCHt/Xfm8lXblDSZ8JIq72gz6nF/Z0BK0U9VdnznapOVOQKMHui5VRz0qE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712646920; c=relaxed/simple;
	bh=kZeZDpvDhgQHjJRM2Bq/1wDRQG+O/WgjTTA91Txg9zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAY1TTUON+XEqsRTKxF5C++dX8p7hiLiN/nmr7wpeQ5SzIaALnCq/Wk3HBjk51PbDNmNotkWvb07d6LHy/EZaYu9bZgBG9aE5UsvlErl82XAlBLooPPQAR1HTztdBau77MS8WA3H9gXIqyMAlDvY/0UcGpOtHHYkhaL1DJnA/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6150670d372so48912037b3.1;
        Tue, 09 Apr 2024 00:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712646917; x=1713251717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBJu5F6YpSTJLRMDOchXILY0XfUp8hZW0pkMDWSU8vQ=;
        b=KjBeQ/y3RbwAzmjjvYkpK5ZMzB+z2VYqIwPZJt3ZcqFoZ6JTRtl4hP9tMJZ7tsu4AX
         opNo+YYGKTJoUxPJl7HUzd2v448/zFT986sp1yzNhF5wCiZDZhYH0V/Rfjas/3bCwx71
         jRL88e2L8HvSYIBS3cxh02DFQOXHJgWcVdBEjgoHMYB8HhlxqAhK2GBkpWqXDMephUig
         tbbZfh8xYLbUUqkgRuyY3Y2svWBsiHrmvwEQOBMZtYB9G7WUf0tF5oBqBn9pHiHkLUU+
         X3+mtWxsbtgHbeIS+OcZK6l+R0hXqjnCPLImBkYJU3pqmfUMRy4Q3UvprP6RvuefhC3U
         GERA==
X-Forwarded-Encrypted: i=1; AJvYcCUDFZ2RlboO+givETEsA+R2wBc31G55UPNS34vd8iWHSvqc2ImYTXteiAdXck5i0gxERs9Q1etz6dl1snJfLo/bG3+r+/yvPCexviQAK3ZHvb1jKNAeS3TWo6oRepPkmXI4dL+5d87C0yBuh0Mxag==
X-Gm-Message-State: AOJu0Yw00vWLNc2s0q2kCdO2mLyMC/mNIdensoT2ltrYQtq62oftRDAd
	rEXLWzMgjhp8TOTFMeC92Ac8XJZN279brR+xsf22NzcrXSKQBZar6ke0ympp2xc=
X-Google-Smtp-Source: AGHT+IFnXsuEwVCOSkpBiyOfSEMidMA70781MpLQ2C3XY6kZnkTP0QIipztzizlmuYFV9YNmEwGf6g==
X-Received: by 2002:a0d:c344:0:b0:615:2849:6086 with SMTP id f65-20020a0dc344000000b0061528496086mr10357547ywd.10.1712646916017;
        Tue, 09 Apr 2024 00:15:16 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id jv3-20020a05690c748300b0061520765e11sm2025235ywb.143.2024.04.09.00.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 00:15:15 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-617d25b2bc4so39354457b3.2;
        Tue, 09 Apr 2024 00:15:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzHeeEOTdMS6/CMicBeIcuzhiS98+bmL5tJmEBypqpRwLIgyonqmibvprDbjcHKSH7ZlphGnGvyLvhyCSeBsgHxOFgWzfpmPQ2s1YNFAYto1v0W+miPTZXMlbADhvMUnbp0iPyHYloPCvs4A8dOw==
X-Received: by 2002:a25:aea4:0:b0:dcd:40fa:7bd0 with SMTP id
 b36-20020a25aea4000000b00dcd40fa7bd0mr8167509ybj.3.1712646915579; Tue, 09 Apr
 2024 00:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408185520.1550865-1-namhyung@kernel.org>
In-Reply-To: <20240408185520.1550865-1-namhyung@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Apr 2024 09:15:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQ_osFeknmg=oR6-fMH_MkVqabCtbynxQ6UvpZRwry3Q@mail.gmail.com>
Message-ID: <CAMuHMdXQ_osFeknmg=oR6-fMH_MkVqabCtbynxQ6UvpZRwry3Q@mail.gmail.com>
Subject: Re: [PATCHSET 0/9] Sync tools headers with the kernel source
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung, Arnaldo,

On Mon, Apr 8, 2024 at 8:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
> I'm gonna carry these changes on the perf tools tree.  I'll update the
> vhost.h once it lands on the mainline.
>
> This is the full explanation from Arnaldo:
>
> There used to be no copies, with tools/ code using kernel headers
> directly. From time to time tools/perf/ broke due to legitimate kernel
> hacking. At some point Linus complained about such direct usage. Then we
> adopted the current model.

Do you have a reference to that?
I was gonna reply to [PATCH 8/9] (where I was CCed) with "why can't
you use the original include file directly?", then read the cover letter.

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

