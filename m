Return-Path: <linux-kernel+bounces-106707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25787F235
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79391F23AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107F59140;
	Mon, 18 Mar 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="RTDU9oaq"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D358AC3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797587; cv=none; b=BQE+lL85963AvwqBzeMGi2wPaM5m2DW8R1/dyc64hSxu7dGb8yLBw9u2TOee+6iSW7iUm4GeTqv9HPc25K+U+mkTyGTF9LwiRJhyNQ+Toq+CWnNpY4NlhNP4Emao13rwaTwP0CddK/zPEj+Dc2hYJnWxtSjI9vtiqvKnF2as2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797587; c=relaxed/simple;
	bh=9UyEleUnZum8/j9s4RGJ600MaybJEwjgwNGZe5TtsUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQS0gOW3/IooCLBU5xpGbz+YPLw0zhqdCoxX30O0DapQ3k+q56mofgVRnx6nwb2xiVfiy08K5s1AAPH10Wk9/QCfD18zhBkoHGYJe5pOO/FJ/+2tpY07yh9GJZvl7Mz0QwQZLIGSS+R0pkvls6Xy5cAWsndTbagvnNrvpKrB908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=RTDU9oaq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a0ba5098bso28525151cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710797583; x=1711402383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mGPv8yamP9bphcl7rsqbJVKUCn1NBYwIxJacintSX4E=;
        b=RTDU9oaqsdXUorIbRjEhK9OIxR741Co9b21x0FX5SCuhXXUtUQrsjFs5DQ9P+rOVGm
         7y4EoDmqrd19H6iiU9yAc35sYfVodWMS6HZ+L9aBG+cA7O23YmGe+DVJB7NRzIckOhoY
         TbIEIux0kSGGBAhKnf8KHFtVnrFna3qGgLcAui5SpkrPmIg/xzhUEAcJVaJCU97frCPo
         DXICth2ujuhmOa1I3yF/UQZAnx0mTomKdZ9sjx6Lyybslhc0O0UCCVA2GQ7dm8jf6QxM
         YFbrzR5qakiy094/zZJvRWrQvy3qMl0nm+RN4jnazi/az8cKw2CL9f3v4Y0Ez2IOrbKz
         hYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710797583; x=1711402383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGPv8yamP9bphcl7rsqbJVKUCn1NBYwIxJacintSX4E=;
        b=jqmilrfzSImIQUFHitvnbnlnJTC/hHUQGYGnYmwVWQ6X9X6WYzUId0Xl/kHRjQ9tya
         FMwcJ9HQyHgMAiVKVubf6l4BaKU7ekrwhoHa7Nt0Oo1RhSrm88uBePVkD3fi5ydToDwP
         Npas1gwl2987SPkFwGUBaWw8oZZTC3tNBH2n6kpRpQLw0lrhaf04c35n+DLh6a0j06Xe
         V8NieqNtAbUqKX0radXng7T3882CRnEnyT6dWywRt9ab2SK23S9jGty6qh1ZKU3VwgWC
         yDyeiYqGS9stm+JkZyViaHqmpTedwUD4EAOhQTnoaoNEDOPiQdxgFgpQjMv2PDRiTPB2
         /dWw==
X-Forwarded-Encrypted: i=1; AJvYcCXGXR4sSmJXDOrzk8HOJjDGlkSEftzVRYUipSZ6TI4WI/BHpa/F5ucgNf9mfNVAFZhAOP6+aSc+g1R/920dvm1nvQssJuF60sGMjzhc
X-Gm-Message-State: AOJu0YxqVcpq28cs1cAyXCjQ7uGhT4To8q4Vw/1PFlTxnczYPzJYG9M7
	tlaND/w+bdXN8Ytf6IDpbzvkm/BXF4gjzZ9eveFBLRggg0gTysvQKWSCoMjhPTomuKjhpV+LkoY
	8
X-Google-Smtp-Source: AGHT+IHy9RlxCISU3kmenwXlDWSWKdj/pdGdU/FQ7uGUX7Pn1QHqJCVyLWVjT1NiurJWUrhsxjcsvQ==
X-Received: by 2002:ac8:7e96:0:b0:430:e2a3:f80c with SMTP id w22-20020ac87e96000000b00430e2a3f80cmr696515qtj.31.1710797582770;
        Mon, 18 Mar 2024 14:33:02 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ay29-20020a05622a229d00b00430b385f721sm3924923qtb.15.2024.03.18.14.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:33:02 -0700 (PDT)
Date: Mon, 18 Mar 2024 17:32:57 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
Message-ID: <20240318213257.GB4210@cmpxchg.org>
References: <000000000000bbb3d80613f243a6@google.com>
 <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
 <CAJD7tkbEuFkGuQeYjKS02rQoAAKOKieAJ1P2mwukirW3e2JN9A@mail.gmail.com>
 <20240318210917.GA4210@cmpxchg.org>
 <CAGsJ_4wEjgAscao4BiLbNFChfF7aTpFFdXXozWC45_j+vADdPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wEjgAscao4BiLbNFChfF7aTpFFdXXozWC45_j+vADdPw@mail.gmail.com>

On Tue, Mar 19, 2024 at 10:15:43AM +1300, Barry Song wrote:
> On Tue, Mar 19, 2024 at 10:10 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Mar 18, 2024 at 01:17:19PM -0700, Yosry Ahmed wrote:
> > > On Mon, Mar 18, 2024 at 11:00 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > > >
> > > > On Mon, Mar 18, 2024 at 9:58 AM syzbot
> > > > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=13043abe180000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=19bb57c23dffc38e
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=adbc983a1588b7805de3
> > > > > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > > > userspace arch: arm
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1706d231180000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ba7959180000
> > > > >
> > > > > Downloadable assets:
> > > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff2/vmlinux-e5eb28f6.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/7539441b4add/zImage-e5eb28f6.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
> > > > >
> > > > > ------------[ cut here ]------------
> > > > > kernel BUG at include/linux/scatterlist.h:187!
> > > >
> > > > Looks like the provided buffer is invalid:
> > > >
> > > > #ifdef CONFIG_DEBUG_SG
> > > > BUG_ON(!virt_addr_valid(buf));
> > > > #endif
> > > >
> > > > which is "src" from:
> > > >
> > > > sg_init_one(&input, src, entry->length);
> > > >
> > > > Looking at the surrounding code and recent history, there's this
> > > > commit that stands out:
> > > >
> > > > mm/zswap: remove the memcpy if acomp is not sleepable
> > > > (sha: 270700dd06ca41a4779c19eb46608f076bb7d40e)
> > > >
> > > > which has the effect of, IIUC, using the zpool mapped memory directly
> > > > as src, instead of acomp_ctx->buffer (which was previously the case,
> > > > as zsmalloc was not sleepable).
> > > >
> > > > This might not necessarily be a bug with that commit itself, but might
> > > > have revealed another bug elsewhere.
> > > >
> > > > Anyway, cc-ing the author, Barry Song, to fact check me :) Will take a
> > > > closer look later.
> > >
> > > I am not a highmem expert, but the reproducer has CONFIG_HIGHMEM=y,
> > > and it seems like zs_map_object() may return a highmem address if the
> > > compressed object is entirely in a single page to avoid copying to a
> > > buffer:
> > >
> > > if (off + class->size <= PAGE_SIZE) {
> > >    /* this object is contained entirely within a page */
> > >    area->vm_addr = kmap_atomic(page);
> > >    ret = area->vm_addr + off;
> > >    goto out;
> > > }
> > >
> > > The virt_addr_valid() check seems to indicate that we expect a direct
> > > map address in sg_init_one(), right?
> >
> > If the page is highmem, kmap_atomic() establishes a temporary mapping
> > to it in the direct map, such that we have a legit kernel pointer to
> > the memory. Otherwise the memcpy() in zswap also wouldn't work... Am I
> > missing something?
> 
> Right, we built a map but it is not a linear mapping. so we can't use
> virt_to_page
> on this kind of non-linear mapping.
> kmap_to_page can handle both linear and non-linear, but  Ira's commit
> added a WARN_ON_ONCE in it for non-linear mapping case.

Ah, I misread what virt_addr_valid() does. It actually excludes
kmap. Which, yes, makes sense, if the next line does virt_to_page()...

Sorry about the noise.

