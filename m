Return-Path: <linux-kernel+bounces-126504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60418938C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B40E281BCD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC9BBA49;
	Mon,  1 Apr 2024 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="awqdFPRm"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9398F6E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711958177; cv=none; b=M8xH0tvvDcUomApLdL5iePvDPS/7XXlu9pDeVVvMaHWFkR5gBm6mREyOdmCg9qkjnQZ6Cf7KkwK403S1uCzb51lbcF4caEbR/Dyj2GXWpBQevSi2g3cp4+6SQ2eJpChtM27M58Pn/Ox7NaXJby9LgBGaJEaBqHGJDj3Z5F/BwOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711958177; c=relaxed/simple;
	bh=cgdtpYyjvErlX+/utjCkRaIwVeHPHbXHGies5CxxI0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXK4Yr5Kx+XxSLi5CYutWtSMkHmC8SXJ6VqqS4WJ8hemr7xCkxJN82C7hl2JIhfzdu90NVcc5Rpjr1CzVmRcwh/GdSzDIerUbhUawPsVGvo+oUDR3jYJoi+UOOdOFLFU/4TOftKsQ0o30gtyu9eLaUNHrVT18ijujCPQZ25G9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=awqdFPRm; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=awqdFPRm;
	dkim-atps=neutral
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id E36E8276
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:56:08 +0900 (JST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29e06733018so2921446a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 00:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1711958168; x=1712562968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/bmRW0RZrolxTvrm8LcMiQ+wRa4Ya61rnM0CmvyhhU=;
        b=awqdFPRmjnk/7pZsDYheI/wAwmIlIku6xWWT6OweYbwOWfz/DJPm9Pjttl7M/H4FIB
         mPMAtocOtu5+jWv4j6Qo0hZKV9ipugOch+Av7NJZr3WqGErAqYS0Bsd41JPIsNmk59Gz
         LBbDdmTtJLFmU9KE3GB1Sh8SzToK9E2zT0fUYv30ZG4qKtLKuKRaR1mC0t+8eQMBKico
         OAFWLA++VPztpYUU0X7m6LeqLCXKM8vLpFZCyROz7jFqXcGCpoBtD1nKAWpw7mSGJTye
         gzFbwqIKDwZBxgeFXTLV6qL+7sV94QJ6eEgLPyDbnIaM/YJLPQa4ESOOm8kHamd5WVRk
         2ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711958168; x=1712562968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/bmRW0RZrolxTvrm8LcMiQ+wRa4Ya61rnM0CmvyhhU=;
        b=w+BiQ2nnCNQvUXvkW9dMC81m8qRqMX4MeEmFavuumIQ+tW1dQXrVJr8pgJQPypQS+w
         /JBkj0y24+CHJRmUm/kJAdh/6JI4qWr0SSSkG2/1EGYtyYDctJfX0S+qeSQFrk4thXgZ
         FNCEoejaAOdIsVxFJv2IeJLIh+H8afBjUi/Bgm+sFEQJSRfzhJQ5xtAEVYGBIUzMerva
         BcnbaX1fZP5EVq1B1GoOpAfeKqJ4Fer9WIka2Wzd8wZpK3ppHrfPUDoIvQCXA8hnpo5U
         tI7gxWsxj61hSXdExMjRa+ffA2U35uVJjBxaC9FG7KKi8qsPHKhleRzOCrF/5R7WtD3W
         5fBA==
X-Forwarded-Encrypted: i=1; AJvYcCWk5iOWktS+65Opru238leQjPIb59AQY292PcJFiFse+x5hGpoY3FGkUkkjFY/AA2PE6alXvCtYUofwhKr0jQMxVpTDgur8xWNNKKkP
X-Gm-Message-State: AOJu0Yz9JXM6AGuYcAsJo+aTOwhb1FA6aD7+gXG6BhWdcL06Z8vHCbkf
	90lvFT++tbzUOK6wFytsRCM6bAP9l2dADa8uPquuhTivp09LxKmrMoQ4hfnZ9JJbIH+B/C09VCF
	eGfqmLJiTT5VMSGgQEFCUFHDP8wU8+Aziji+nw6XW87CSJGpjuISj4D4R0qnBj/M=
X-Received: by 2002:a17:90b:4c05:b0:2a2:434a:e644 with SMTP id na5-20020a17090b4c0500b002a2434ae644mr739028pjb.25.1711958167648;
        Mon, 01 Apr 2024 00:56:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQltWPRncLt13ChqratVLhmMs+Pjq8XMc73VtWtFv+JAusnWsYxaGUJXFQp+XxHQNqKROHpw==
X-Received: by 2002:a17:90b:4c05:b0:2a2:434a:e644 with SMTP id na5-20020a17090b4c0500b002a2434ae644mr739009pjb.25.1711958167223;
        Mon, 01 Apr 2024 00:56:07 -0700 (PDT)
Received: from pc-0182.atmarktech (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id ev9-20020a17090aeac900b002a03d13fef5sm9414600pjb.7.2024.04.01.00.56.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2024 00:56:06 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rrCWT-00D2zY-1h;
	Mon, 01 Apr 2024 16:56:05 +0900
Date: Mon, 1 Apr 2024 16:55:55 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"bumyong.lee@samsung.com" <bumyong.lee@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"petr@tesarici.cz" <petr@tesarici.cz>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
	"lukas@mntmn.com" <lukas@mntmn.com>
Subject: Re: [PATCH 1/1] swiotlb: Fix swiotlb_bounce() to do partial sync's
 correctly
Message-ID: <ZgpoizG3JMGKWdFH@atmark-techno.com>
References: <20240327034548.1959-1-mhklinux@outlook.com>
 <ZgO3HlYWo6qXaGs8@atmark-techno.com>
 <ZgZNAM337-UEY1DH@atmark-techno.com>
 <SN6PR02MB41574B5BC91B70AE74E51FE6D43A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Zgd_JaCHzOOLqWUM@atmark-techno.com>
 <SN6PR02MB41578CEA46D8DD626829294ED4392@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41578CEA46D8DD626829294ED4392@SN6PR02MB4157.namprd02.prod.outlook.com>

Michael Kelley wrote on Sat, Mar 30, 2024 at 04:16:30AM +0000:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com> Sent: Friday, March 29, 2024 7:56 PM
> > There are two things I don't understand here:
> > 1/ Why orig_addr would come from slot[1] ?
> > 
> > We have index = (tlb_addr - mem->start) >> IO_TLB_SHIFT,
> > so index = (33 - 7) >> 5 = 26 >> 5 = 0
> > 
> > As such, orig_addr = mem->slots[0].orig_addr and we'd need the offset to
> > be 30, not -2 ?
> 
> mem->start is the physical address of the global pool of
> memory allocated for swiotlb buffers.

Argh.
Okay, that clears up a misunderstanding I've had since day one... I
should have done a little more reading there.
I've re-checked now and indeed mem->start comes from the pool init, and
corresponds to the reserved memory base.
(I'm not actually 100% sure reserved memory has to be aligned, but at the
very least I've never seen any that isn't on my hardware so I'll pretend
it must be without checking)

That makes much more sense with your fix, I agree offset must be
negative in that case, and it'll work out.

> > Well, either work - if we fix index to point to the next slot in the
> > negative case that's also acceptable if we're sure it's valid, but I'm
> > worried it might not be in cases there was only one slot e.g. mapping
> > [7; 34] and calling with 33 size 2 would try to access slot 1 with a
> > negative offset in your example, but slot[0] is the last valid slot.
> 
> Right, but there wouldn't be one slot mapping [7; 34] if the
> alignment rules are followed when the global swiotlb memory
> pool is originally created.  The low order IO_TLB_SHIFT bits
> of slot physical addresses must be zero for the arithmetic
> using shifts to work, so [7; 34] will cross a slot boundary and
> two slots are needed.

Yes, since the mem->start/slots belongs to the pool and not the mapping
this didn't make sense either; there's no problem here.

> > 2/ Why is orig_addr 37 the correct address to use for memcpy, and not
> > 33? I'd think it's off by a "minimum alignment page", for me this
> > computation only works if the dma_get_min_align size is bigger than io
> > tlb size.
> 
> The swiotlb mapping operation establishes a pair-wise mapping between
> an orig_addr and tlb_addr, with the mapping extending for a specified
> number of bytes.   Your example started with orig_addr = 7, and I
> posited that the mapping extends for 40 bytes.

Sure.

> I further posited that the tlb_addr returned by
> swiotlb_tbl_map_single() would be 3 to meet the min alignment
> requirement (which again only works if mem->start is 0).

Okay that's where I'm lost.
1/ I agree that swiotlb_bounce() called from swiotlb_tbl_map_single()
cannot be called with a tlb_addr past a single segment (which I'm not
sure is acceptable in itself, taking the real value of 2KB for io tlb
"pages", if the device requires 512 bytes alignment you won't be able to
access [512-2048[ ?)
2/ swiotlb_bounce() can be called from swiotlb_sync_single_for_device()
or swiotlb_sync_single_for_cpu() with no alignment check on tlb_addr,
we're just trusting that they only ever pass address within the same
constraint ?

If you assume tlb addr can only go from the start of a slot to as far as
the min alignment allows then I agree there's no more problem, but I
don't understand where that comes from.


Either way, that's not a new problem, and the old checks aren't making
this any better so as far as I'm concerned this patch is Progress:
Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>


Thanks for taking me by the hand here; if you want to keep discussing
this I'll be happy to give it a little bit more time but I might be a
little bit slower.
-- 
Dominique

