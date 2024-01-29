Return-Path: <linux-kernel+bounces-43182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25983840CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580DD1C2353D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455FA157031;
	Mon, 29 Jan 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzBGEBTe"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D84315703C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548010; cv=none; b=kZf1t0Ig9GOjUPT/epVKeaKgfQ0mH9XXiLettQK3u2sa6v7UxD9iX2SjTs6GQsX/u/eJbyY+P2/jrMEOP3U6124oF8ldJloT7v2OzFx6jd+VKcKtmVc9Apxridn02M7818nyqt32m3h4uUmUyT9EarX5oSYQn9k5ZDKFEg/mH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548010; c=relaxed/simple;
	bh=aHP8f/jy8s8m5foj4ZrWGt+6GAdokU3T6VB4KE47DVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpKYXY1MTC+AKxliTD+xyIQ8mbajyD/yxYQpmdrlzFgxGttRfDm5nr0Nxo5amNWVsazeWxNOf4OSDWxK24LTb5ajIu41lqxJA16EJM42QOWy//We/DKXTe6MV9X6gbBd+cnTIMWoqF1bLp8cYbkgjc/9oR5XYEReZ3HvGuDAaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzBGEBTe; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59a146e8c85so1526659eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706548008; x=1707152808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9e9aTgW69SCUZ7Nc/7sxARbcemroWx1eN9b35d29Ho=;
        b=UzBGEBTefQ3cy0mQX67K4dKiCpiiVNqE2wLBepQ2WM9c+/ckCdjOnqbmYETbqap48V
         gW1j/V4l/6aHvFfUoncb7pIKYtVMj9a9qnYRyDgag4D5FS9Vg2BSSs1DWaf9yUcMuPr6
         1HU+qBHd5/HWIC17JZeRJ/tGt5+JqpS+AUeQpiP7ynP7O5Ryxr3gAUCrZw/rLLu8tHwU
         dymxdC+DWua9FtpabboNCXueM1DYBpe3LyANZiAMRqVnNQRzfvjjYJnEvTzjiLDWlBBx
         uLL3f5F2dfQcW3LSm18lanUSDBz9TuLHK53plUBfS1VSHxoINyeisj0NdkcqL9ZBiMAM
         qBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706548008; x=1707152808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9e9aTgW69SCUZ7Nc/7sxARbcemroWx1eN9b35d29Ho=;
        b=rvElJDSyStuCWWMb/X16Bwta7UfzPrGgtlaHxWa0AKwFS+NN2v4Vgw1us8FeOr/6ZI
         tTfl0SD7bXjno3tfa88QQqYqyXkvhunfrSZNOFqXpUV1iBrBGx8EP8aU5NL3AYZPr8OM
         gsb5eDTDIGuVHWbQ2nazIyD754xohtcNuth3IhsOz3k2OedtC4/dc3pOh3DBf0sHZ4id
         npDyXJ+gNJl8f144Ct9y/qbiwrwg5UjNTklo9GPM740y4uGB02sARuxPwpD+P38jrqzI
         Uogh1CBAb+NJUVu6akdLkMWigoLroqL+6kwO6uzBLP/e3TROaWy8afIMfYMfJhq3dKwI
         iZVA==
X-Gm-Message-State: AOJu0YyP0uiKPExnoN+KTS2ScrQ9vP3nk4fZGcp/M2Y1m7H//LskdS2z
	4FAPNpy/7US2wh2JOROb6je6MbTHZKRo1Y3YxfAf3wU0it06xmUf
X-Google-Smtp-Source: AGHT+IGdxuoFd4LUiMNuUO/uxr16fX5q6e1Nvuc62bGBd5Y01eX8ww0nnR180D976To9gSq/43n88A==
X-Received: by 2002:a05:6358:7205:b0:176:5cad:a2e1 with SMTP id h5-20020a056358720500b001765cada2e1mr6548304rwa.26.1706548007807;
        Mon, 29 Jan 2024 09:06:47 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id c26-20020a62e81a000000b006ddc84a03c8sm6083271pfi.85.2024.01.29.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:06:47 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 29 Jan 2024 07:06:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, Mike Snitzer <msnitzer@redhat.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Bob Liu <bob.liu@oracle.com>, Hou Tao <houtao1@huawei.com>,
	Nathan Huckleberry <nhuck@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] softirq: fix memory corruption when freeing
 tasklet_struct
Message-ID: <ZbfbJuRRklWhYk4Q@slm.duckdns.org>
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com>
 <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
 <ZbRDnSyiSE93puQL@slm.duckdns.org>
 <CAOMdWSK5CfVpvwmCxCtYLJ-Qt+ZwhETF3K+AhNcBGtEpkKvFqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSK5CfVpvwmCxCtYLJ-Qt+ZwhETF3K+AhNcBGtEpkKvFqg@mail.gmail.com>

Hello,

On Mon, Jan 29, 2024 at 09:00:38AM -0800, Allen wrote:
>     I rushed to reply to the draft patch you sent, I should have
> looked harder. My apologies.
> The idea that I have been working on is to completely move away from
> using tasklets.
> Essentially, "get rid of tasklets entirely in the kernel". So, the use
> of tasklet_schedule() & tasklet_hi_schedule()
> will have to go.

The idea is to take over the tasklet[_hi] softirqs once all users are
converted. Otherwise, we run into the problem of setting priorities between
tasklets and the atomic workqueue, which may be a theoretical problem.

>    I have a very hacky draft that is still wip. I am going to borrow
> many bits from your patch which makes
> the work I have better.
> 
>   Perhaps we should start a separate thread, thoughts?

Sure, please go ahead.

Thanks.

-- 
tejun

