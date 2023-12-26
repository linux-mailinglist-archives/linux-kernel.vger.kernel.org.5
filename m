Return-Path: <linux-kernel+bounces-11704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03F581EA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9811A1C20D43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194245240;
	Tue, 26 Dec 2023 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeJUzYJM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E25224
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5e75005bd0cso42291027b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 14:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703628743; x=1704233543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGyOmo1LInXd6cBCtzQtdu/T4kUyPwlVjT3/bkZ4u7M=;
        b=SeJUzYJMRArX6+hBdnCGHkYSxtyYwsaC/RVLeaxWNxKTeOoAeaw3J+eKEFrtFcUJtm
         /sUAjRun033uFtRVUZDPhAzO9zkbV71w6xvDxmmqJczRG1vWVmAFm6/hACUlcJRabpSQ
         keh0SdMmMUIAW/weAQLUYYCBmQf7pIlDyMa9/A6XgejTH/6WhKq+/hA0cgvq3+tX/ksg
         SJw2L8WFUqn7+BtsPHish94k9ayRUSlFCRwysd6g9Vwe++slLpM8mD8cKbO7Up+orP8l
         2Gt4j+cfrIGwOQf1pZR3uuPo+1BtVWi1r83ayEMo5fbJ2186jsrhBnIK12YetDmrEnqG
         uvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703628743; x=1704233543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGyOmo1LInXd6cBCtzQtdu/T4kUyPwlVjT3/bkZ4u7M=;
        b=hNLH9H+y7VfndHpH7SQPBp6UwBgnT18WifheQYO2fhynSYws8UacrhEPuUEFcY/9D2
         rGTnXAT5FQU347YO3ERPw8G1S6W7UkSpT4EZz/ZZ3r1ADZ0EgYG+bdcRa8Hgovtg0tc4
         BcktZ1ZWKpZWyk0NzPL521LpWLYT1OhpSw05FxtzBLPcU52ZXMlk1ZX+rKZtP8o3++GX
         9EuuQg1JUTxMvW1W0y+flz+eXciKZsNLxGijhMAa1EBMlj+mtesea5sPVfxmyCdt5Q6h
         7kxeSxH23xknarcU0hyoQwC6tdT8N3PcwWhu9UfTiGQToTJ19T4VKF385OPaKmIF2Hlz
         IGZQ==
X-Gm-Message-State: AOJu0YyykVm/RgGNOHGc0bapV94jsFpDwoBKPprp1xtL8ddFHJdP48TZ
	PmIi1bykCpLMzo60W1Jd/Vg91gyF7NwLpJNblZxzXb/vZSxY
X-Google-Smtp-Source: AGHT+IGpz2ZfdldDfyT/4SNCJK9n8IBWb3Jlm4kIXOPC7FxTomeK+3k4wRMA/Ntvl+efxqzmOUQ64ZcE9Xg+kSGFCPM=
X-Received: by 2002:a05:690c:243:b0:5ed:9207:341d with SMTP id
 ba3-20020a05690c024300b005ed9207341dmr924990ywb.8.1703628742827; Tue, 26 Dec
 2023 14:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222102255.56993-1-ryncsn@gmail.com> <20231222102255.56993-4-ryncsn@gmail.com>
 <CAOUHufYrzw7dDbchNkrrXnSqpeYasnfPh6qFoMNgAmbK9GXNaQ@mail.gmail.com> <ZYmi1GEH0ai/2iGo@casper.infradead.org>
In-Reply-To: <ZYmi1GEH0ai/2iGo@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Dec 2023 14:12:09 -0800
Message-ID: <CAJuCfpGvWimikdpOMuRuNisR3sas9ek7Y_2fCPe706PJ6y57+g@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm, lru_gen: try to prefetch next page when canning LRU
To: Matthew Wilcox <willy@infradead.org>
Cc: Yu Zhao <yuzhao@google.com>, Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 7:42=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Dec 24, 2023 at 11:41:31PM -0700, Yu Zhao wrote:
> > On Fri, Dec 22, 2023 at 3:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Prefetch for inactive/active LRU have been long exiting, apply the sa=
me
> > > optimization for MGLRU.
> >
> > I seriously doubt that prefetch helps in this case.
> >
> > Willy, any thoughts on this? Thanks.
>
> It _might_ ... highly depends on microarchitecture.  My experience is
> that it offers more benefit on AMD than on Intel, but that experience
> is several generations out of date and it may just not be applicable to
> modern AMD.
>
> It's probably more effective on ARM Cortex A cores than on ARM Cortex X
> cores ... maybe we can get someone from Android (Suren?) to do some
> testing?

Android is quite noisy and I'm afraid a small improvement like this
would not be distinguishable from noise unless it's much more
pronounced. I'll take a stab but don't hold your breath.

