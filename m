Return-Path: <linux-kernel+bounces-7711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C628181ABE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840DA287686
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A1410F5;
	Thu, 21 Dec 2023 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUbY0xlr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C567F0;
	Thu, 21 Dec 2023 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7b7fe0ae57bso11863839f.0;
        Wed, 20 Dec 2023 16:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703119832; x=1703724632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqxZyPIm5tE52kVQmZ74eT+BOOkp647sWKEQUJpbsZE=;
        b=fUbY0xlrGTWEW+hG3axxUB+3ciJNdojo6dtVSBR/LEu0cXvWLzq+IgS2YXnpL5NyeL
         uhOpftaGhwrJ3BnZOMc9D+sywfb8g8xO0SOmXQuoceRX21KRGqN7OoTk+2Bky8nkkdYR
         zqmFxqUmm7actCOMwjwJFs73IWJAv3866P2h1efbHLExxycPMaohS0UawAicwLcSkLpr
         qrTTDqaPTxkQ5KRhlO5P7B7EboKP9S5BUprtI7GTwXBhLNGuAeyPA2gMVwu4DuDyUZg+
         iDJwUO4/+UbGpC58H2hrM/3zbUmHYJ0riSD/QFp5yuXo+1kLpIIpQ/Kk5df2VBlpHm1d
         IbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703119832; x=1703724632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqxZyPIm5tE52kVQmZ74eT+BOOkp647sWKEQUJpbsZE=;
        b=as+S8oiJDEH1L89SEbAbdbQLX/SJA6cibd95vbp8ENg9qNPOaMmZsVKFuaO9rZd++2
         bR6i2sozfEXORYOebRXHdcd4DyJqdyI3Gwci2qkav0B1ffp8FCHdU2Bo1tnwWfPcilY3
         wi+H1Lx/5SFN909lRISNcepe1pOPGhLhrdztwOQsUuQKTnf9/hhUpLiwbdmP3PIZmccK
         zx7Ya7IrdIU47okzZKYNre2Ql32ZYzXvlMU+os9JN9igrHoT1u0oi453L1jBxI9WcYxm
         MsrX8XPSr+hUMxC4QCOM85n9IbUE3q6M0lJGvR7yZ4h6YCqOetobum0Zpjac4oYy76IO
         NunQ==
X-Gm-Message-State: AOJu0YynQWqis0C+L3nEZQPpmzXGecmXEi/laYaIRrbC68Ar9wQwfCno
	+IdsSrqQ0RpyecwadnwbKybSY6iV57Mx0H6SH0w=
X-Google-Smtp-Source: AGHT+IFvcePCft0/m9LYDHk+AjGrrmPztrI7RSQFfyZ9I6Ws65U3aVgYVG18rGNg03iYgploDuQ5pLbVqNrdXP/xdxU=
X-Received: by 2002:a5d:97d4:0:b0:7b7:c8cd:7552 with SMTP id
 k20-20020a5d97d4000000b007b7c8cd7552mr9196880ios.36.1703119832306; Wed, 20
 Dec 2023 16:50:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01_qktkitg@mail.gmail.com>
 <20231218144431.GB19167@cmpxchg.org> <CAJD7tkakMjE1sNfexLzooptDyQS4YZf5DmuoywnSFD7JTbh9BA@mail.gmail.com>
 <20231220051523.GB23822@cmpxchg.org> <CAJD7tkbzVjYxykracNW729xKTqFdpk5Hw5k94Epc_uSvUP1g=g@mail.gmail.com>
 <20231220145025.GC23822@cmpxchg.org> <CAJD7tkbmWcEvsfF8i+HrRetTVu6v4fKFn2WL0RLsHNheu=5wVw@mail.gmail.com>
In-Reply-To: <CAJD7tkbmWcEvsfF8i+HrRetTVu6v4fKFn2WL0RLsHNheu=5wVw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 20 Dec 2023 16:50:20 -0800
Message-ID: <CAKEwX=OM0-auqDz9E1=_tC9n=KMFCs7JBYM1OhcZsOiH6cJmHw@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org, tj@kernel.org, 
	lizefan.x@bytedance.com, cerasuolodomenico@gmail.com, sjenning@redhat.com, 
	ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeelb@google.com, muchun.song@linux.dev, 
	hughd@google.com, corbet@lwn.net, konrad.wilk@oracle.com, 
	senozhatsky@chromium.org, rppt@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	david@ixit.cz, chrisl@kernel.org, Wei Xu <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 4:24=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> We can agree to disagree here, I am not trying to block this anyway.
> But let's at least document this in the commit message/docs/code
> (wherever it makes sense) -- that recurrent failures (e.g.
> incompressible memory) may keep going back to zswap only to get
> rejected, so workloads prone to this may observe some reclaim
> inefficiency.

I'll add the following caveat:

Note that if the store failures are recurring (for e.g if the pages are
incompressible), users can observe reclaim inefficiency after disabling
writeback (because the same pages might be rejected again and again).

to the zswap documentation and the cgroup documentation then? I'll
repeat this caveat in both places for self-containment purposes.

