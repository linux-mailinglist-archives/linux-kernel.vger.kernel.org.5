Return-Path: <linux-kernel+bounces-122621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA7188FA7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFEC2A6E46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B754664;
	Thu, 28 Mar 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwf0mKCK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A822381BD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616194; cv=none; b=T8NbI2vUTLblX44VVAacnEHg9ju8tWR/DHbMTnnLvDHcQD2q1pS8raeVNQqp4TZIe8g3Xn8oCwQaJHyRvBTA8Joy5uCquiZTa8yEjDSodyjBosB7yFparpgUG9RYVVAKkeDcS+1WQjvXS7c1AljpV2ngY74nPNFRQZ5NId8EbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616194; c=relaxed/simple;
	bh=sn26jcHoHp3rn3lPXDm90hjY8VZCi4B+vwCXcc9SUCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R05mLBqx3YILbyc0KTOLuESWvjdb6aLVjhHeMTjeMQFM3qAk+j5f9qWv5Y4PYGMM+3nSQKYCTSlBeiusWgY9gXkfMR9u39jY8WgXcPokEqJfZsUSVZZjV1HFJz5BWrMI7+D3TJROjpz1pTRbxpP2GdjxnGTrw4OlgUr8zRAcxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwf0mKCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03692C43390
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711616194;
	bh=sn26jcHoHp3rn3lPXDm90hjY8VZCi4B+vwCXcc9SUCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nwf0mKCK4huYstYzoO27pcySz5iQHPG6I9nlUb3es8TgYkZQ5EO78iOS3zv1OLgm6
	 W72af5WVltvmJwAEHVaYA5HpgtThO/HbZpAL5hEgqW/tXEz5YAPrWuln1FP/Sb/2wJ
	 OrHKouvBoqVyUk+myxDbiZjO63Ji3y5agsTs+Zi58G7bkQzB5iunH5FDMSeM7py/IX
	 oThFiKcTOoaXvd/lE/7zgHxs9YmJq/jRMsecBgZVyM6ZVRDJy8O+6amdaO6IFDbAFN
	 DwWRRM/N/+7POt+ONQ5qjPRHS7svpkODNSMn+yHDkJscUZwECMDDc89sOg2AkCeT+D
	 5SPAWoUPLiZgA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513dc9d6938so792103e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:56:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqKpvWs/UJuCcUOqByAkAI8FgKhYCg0rzfPfxCjXBXTmEVS8dV3hkfskzbNhnGWKrcjM488/fL/aX6IcnppIpf2veVw7QEodgbS2WF
X-Gm-Message-State: AOJu0Yy0wptxZ50ReBdErxn5em0yWuGT6W0YuYafekP7BMjsMO5peGGX
	IeKtUZ9hOGRCXB9aD15vUYaFDdjoI6O0Eo0WA8kfwHBV3JkT0iADcDxKE2VGpdb/Pueo8A9rimB
	iHR1vUKrG/rhV3KQL4EqzxkU0C9o=
X-Google-Smtp-Source: AGHT+IE/Cz9APrKf8Mboej/dREtBrI61XRy3HPAuzEg5cxw1nJ4SaU4yXZVjvcBc9yPukib1z+QzyiwSbbfqSMwuFZQ=
X-Received: by 2002:a19:e05c:0:b0:513:5951:61a4 with SMTP id
 g28-20020a19e05c000000b00513595161a4mr1211899lfj.6.1711616192309; Thu, 28 Mar
 2024 01:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
 <20240327190723.185232-1-ryan.roberts@arm.com> <CAMj1kXF68MH0HUH8FHpHAoSs_tPbMGek5mY2U4BL-i_RWoZ+5Q@mail.gmail.com>
 <a6da59d1-28b5-4cc0-aae9-fca1286be577@arm.com>
In-Reply-To: <a6da59d1-28b5-4cc0-aae9-fca1286be577@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Mar 2024 10:56:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGY6d64PO9x1TwGv4mpZ8gFdSbkuxHz-S=z8tDPKHENOQ@mail.gmail.com>
Message-ID: <CAMj1kXGY6d64PO9x1TwGv4mpZ8gFdSbkuxHz-S=z8tDPKHENOQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: mm: Batch dsb and isb when populating pgtables
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 10:45, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 28/03/2024 07:23, Ard Biesheuvel wrote:
> > On Wed, 27 Mar 2024 at 21:07, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> After removing uneccessary TLBIs, the next bottleneck when creating the
> >> page tables for the linear map is DSB and ISB, which were previously
> >> issued per-pte in __set_pte(). Since we are writing multiple ptes in a
> >> given pte table, we can elide these barriers and insert them once we
> >> have finished writing to the table.
> >>
> >
> > Nice!
> >
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  arch/arm64/include/asm/pgtable.h |  7 ++++++-
> >>  arch/arm64/mm/mmu.c              | 13 ++++++++++++-
> >>  2 files changed, 18 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> index bd5d02f3f0a3..81e427b23b3f 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -271,9 +271,14 @@ static inline pte_t pte_mkdevmap(pte_t pte)
> >>         return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
> >>  }
> >>
> >> -static inline void __set_pte(pte_t *ptep, pte_t pte)
> >> +static inline void ___set_pte(pte_t *ptep, pte_t pte)
> >
> > IMHO, we should either use WRITE_ONCE() directly in the caller, or
> > find a better name.
>
> How about __set_pte_nosync() ?
>

Works for me.

