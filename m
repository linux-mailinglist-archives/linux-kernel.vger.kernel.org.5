Return-Path: <linux-kernel+bounces-6351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D9581979A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746B51C252E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86717125AC;
	Wed, 20 Dec 2023 04:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW+bDsyj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE41173B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso28955e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703045805; x=1703650605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmFRQc3E/ET5jgrtsAbnSkKJCHzabblomSdD+OjeUsA=;
        b=LW+bDsyjxecN6lTQy0xHY5SwLYm5VMX/Hg3yu2af2wkFc7vFsVHP3/g0TsM5l+vPm1
         i6pyhNBbrEHk6vy8tw/xE63vqKuqt7PHczu0irzbOOEeFTdhoz2rlflO7hs1hGxPAhId
         jNqCdt4hISGuoDOYsO9UwEXXbkvbUS1TpGNfr3oYLLjjB7OjAJe26ml0he2TPk0iateU
         dbhdjwK4Q9m/qmpyz3aRUKdMBo3uXuL8zpOrR93bUX3BVBS/eqN2+weng2Tnaqu3K+nR
         nWqPtzJ+IyzNglg1QJz0SWkbXUBiT/HDHANGxE2FlIUoXw2JSwGqDqpI6eONN1NB/gz6
         W1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703045805; x=1703650605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmFRQc3E/ET5jgrtsAbnSkKJCHzabblomSdD+OjeUsA=;
        b=spveMQmFfvB3YnX1KmilGl1iMC4E1UsZ4vTMoVaVNrcUJkTJMNnjp80q2uVTPHhh7L
         lBe2KKNCyyn40YTAB+A6PvMTodSL1gMRKR6S1I2aoW92JL/3aNaKJ8wKnIpbldWUcq/Q
         u6ignFZgNCzJMhpdmIcrba58o1mzveEhpq2CNhDCvk3JuxdkwEewthpEJsyel/4p1DGQ
         X95wsvHeXETfYBE18dkSItscXSRMdR45kWh2jJxhekW5wrAgLPHXSAVrAkIRa86k97HA
         MDa+3DTq20rMGU95ExeHTM6vZFCjFX4JlgO7LVC96SAt/W+tjNAgnqU0+cJe+7LkqwOM
         2Z5A==
X-Gm-Message-State: AOJu0Yw1roR90LRpCDoXO7zZld531Rc61i0cVbZWZpEHZHRHTeSq3AaK
	Z1lOeLBSqMHoONp0uYoKCBZgxcuCUYsR9jyNBfxx/KFgnb3D
X-Google-Smtp-Source: AGHT+IGQhTJJNWiY6fC30Ah4lqY817BxZMdpoi/AqZs6g+A6xMaTvYnmKr2LGf7gdQiYuL0SNjka8oaTlYu/MjAMkwo=
X-Received: by 2002:a05:600c:1c9a:b0:40d:2bc7:e9b with SMTP id
 k26-20020a05600c1c9a00b0040d2bc70e9bmr91376wms.4.1703045805256; Tue, 19 Dec
 2023 20:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220040037.883811-1-kinseyho@google.com>
In-Reply-To: <20231220040037.883811-1-kinseyho@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 19 Dec 2023 21:16:06 -0700
Message-ID: <CAOUHufaK3X0d9ovEMkFfb3cugqzcnxxqn=o6O-1oohaYANtB0A@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 0/4] mm/mglru: Kconfig cleanup
To: Kinsey Ho <kinseyho@google.com>, Donet Tom <donettom@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:01=E2=80=AFPM Kinsey Ho <kinseyho@google.com> wro=
te:
>
> This series is the result of the following discussion:
> https://lore.kernel.org/47066176-bd93-55dd-c2fa-002299d9e034@linux.ibm.co=
m/
>
> It mainly avoids building the code that walks page tables on CPUs that
> use it, i.e., those don't support hardware accessed bit. Specifically,
> it introduces a new Kconfig to guard some of functions added by
> commit bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> on CPUs like POWER9, on which the series was tested.
>
>
> Kinsey Ho (4):
>   mm/mglru: add CONFIG_ARCH_HAS_HW_PTE_YOUNG
>   mm/mglru: add CONFIG_LRU_GEN_WALKS_MMU
>   mm/mglru: remove CONFIG_MEMCG
>   mm/mglru: remove CONFIG_TRANSPARENT_HUGEPAGE
>
>  arch/Kconfig                   |   8 +
>  arch/arm64/Kconfig             |   1 +
>  arch/x86/Kconfig               |   1 +
>  arch/x86/include/asm/pgtable.h |   6 -
>  include/linux/memcontrol.h     |   2 +-
>  include/linux/mm_types.h       |  16 +-
>  include/linux/mmzone.h         |  28 +---
>  include/linux/pgtable.h        |   2 +-
>  kernel/fork.c                  |   2 +-
>  mm/Kconfig                     |   4 +
>  mm/vmscan.c                    | 271 ++++++++++++++++++---------------
>  11 files changed, 174 insertions(+), 167 deletions(-)

+Donet Tom <donettom@linux.vnet.ibm.com>
who is also working on this.

Donet, could try this latest version instead? If it works well as the
old one you've been using, can you please provide your Tested-by tag?
Thanks.

