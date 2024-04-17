Return-Path: <linux-kernel+bounces-149163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69FA8A8CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31FF6B24F95
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B8C3839D;
	Wed, 17 Apr 2024 20:06:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E1208D6;
	Wed, 17 Apr 2024 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384408; cv=none; b=iNUl8/mIk9eDeVWalEBZBdqXBQf6nXVxoCYsVQil0Ns/3RuN2N4Iy+veWBWEv9BepY3sE0V/eoTVrsf5Iv6vk3jUj+3f/+2Q9914X7WP9AsRSHBTh4EO64RcVOQs3GvS/Aexf6PjoAJWnNsGdPfiulGDuQGGfuZb4+HaMS3Z5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384408; c=relaxed/simple;
	bh=nv1mChUkPCiO/HWkxgelFfD99Z4nAlmsWNhrqLyMFWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPiJU3oaO4J0WPpFXI4Vk1ccG8fTn0FHum1rNHQpd9HwuypkaS0x1oBVj6EQePbCU+ESrgWNeg1NGbOwpEqbBMZUZeY7ACXvcjarTvdh+iZtm20YAsCW6q40thP5DBMiB0zVZkXkrQRtaOv9k2UNwoL6G37uLgCJpF/Ni0207gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85CCC072AA;
	Wed, 17 Apr 2024 20:06:42 +0000 (UTC)
Date: Wed, 17 Apr 2024 21:06:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marc Zyngier <maz@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, Yihuang Yu <yihyu@redhat.com>,
	Gavin Shan <gshan@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shaoqin Huang <shahuang@redhat.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
Message-ID: <ZiAr0OeeaCeKMY1I@arm.com>
References: <20240415141953.365222063@linuxfoundation.org>
 <Zh5UJh31PlBkpZWd@finisterre.sirena.org.uk>
 <CA+G9fYu-AjRm-BBA=8fWS8oCbBJ5W443JHPh3uddD7ea7MY-YA@mail.gmail.com>
 <86y19dqw74.wl-maz@kernel.org>
 <Zh61KobDt_y1O46-@arm.com>
 <2024041744-pretender-clutter-7d4d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041744-pretender-clutter-7d4d@gregkh>

On Wed, Apr 17, 2024 at 09:05:12AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 16, 2024 at 06:28:10PM +0100, Catalin Marinas wrote:
> > On Tue, Apr 16, 2024 at 02:22:07PM +0100, Marc Zyngier wrote:
> > > On Tue, 16 Apr 2024 14:07:30 +0100,
> > > Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > On Tue, 16 Apr 2024 at 16:04, Mark Brown <broonie@kernel.org> wrote:
> > > > > On Mon, Apr 15, 2024 at 04:19:25PM +0200, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 6.6.28 release.
> > > > > > There are 122 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > >
> > > > > The bisect of the boot issue that's affecting the FVP in v6.6 (only)
> > > > > landed on c9ad150ed8dd988 (arm64: tlb: Fix TLBI RANGE operand),
> > > > > e3ba51ab24fdd in mainline, as being the first bad commit - it's also in
> > > > > the -rc for v6.8 but that seems fine.  I've done no investigation beyond
> > > > > the bisect and looking at the commit log to pull out people to CC and
> > > > > note that the fix was explicitly targeted at v6.6.
> > > > 
> > > > Anders investigated this reported issues and bisected and also found
> > > > the missing commit for stable-rc 6.6 is
> > > > e2768b798a19 ("arm64/mm: Modify range-based tlbi to decrement scale")
> > > 
> > > Which is definitely *not* stable candidate. We need to understand why
> > > the invalidation goes south when the scale go up instead of down.
> > 
> > If you backport e3ba51ab24fd ("arm64: tlb: Fix TLBI RANGE operand")
> > which fixes 117940aa6e5f ("KVM: arm64: Define
> > kvm_tlb_flush_vmid_range()") but without the newer e2768b798a19
> > ("arm64/mm: Modify range-based tlbi to decrement scale"), it looks like
> > "scale" in __flush_tlb_range_op() goes out of range to 4. Tested on my
> > CBMC model, not on the actual kernel. It may be worth adding some
> > WARN_ONs in __flush_tlb_range_op() if scale is outside the 0..3 range or
> > num greater than 31.
> > 
> > I haven't investigated properly (and I'm off tomorrow, back on Thu) but
> > it's likely the original code was not very friendly to the maximum
> > range, never tested. Anyway, if one figures out why it goes out of
> > range, I think the solution is to also backport e2768b798a19 to stable.
> 
> How about I drop the offending commit from stable and let you all figure
> out what needs to be added before applying anything else :)

It makes sense ;). We'll send them to stable once sorted.

-- 
Catalin

