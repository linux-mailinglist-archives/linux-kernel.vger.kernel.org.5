Return-Path: <linux-kernel+bounces-47409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DB5844D94
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABC41F24079
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F2A38;
	Thu,  1 Feb 2024 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9TQrAbV"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62337C;
	Thu,  1 Feb 2024 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745868; cv=none; b=gD4NcGoqqYIfKF/rJ8jpHInkpuJcmts7H1BCKrD+I9jIEL8TQ3KnPePoobofh/1RrpIZB6YCuuxa+dfOweyNVjFB3cc6GVzl+b3xMm+6NhiMtYP24dBKlMohRc2zt0Hu+MqilXyHk556l0zTK2wMMB4rRdVXThWdHTB/QfMQ/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745868; c=relaxed/simple;
	bh=ocp7AlYTWdpktj/bKSgADTaYJuvdE/zKdxZf6Npx1Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3pz66sVxfJGOyHgLplQIUWhAoXU6oibiUriLQLp7dITL+wc1mrHYj7HGQPdU90dTzje7f9vLPQY6ncob/lBYkm+48+PitWPzh0EV7c65uw2KLSMMMEu++glPrNinnxp4Y0mLcZtr83g8nRRwgUT5Mek0UJ5cm6JKbVixElK4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9TQrAbV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ddb129350cso227815b3a.3;
        Wed, 31 Jan 2024 16:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706745866; x=1707350666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWmJW1ioE6shF94cLYg8UXpbXdCkseBL4kZBLYoeBuI=;
        b=h9TQrAbVdqErNQWKOE2o55fn2ZaOQbFr4FxM2aEUYvaAQ38nZllnVy3ZU4RVmC2E9U
         I+kPu7BlXSu+hcCkuXx96kyBqxlyFVt+5YA7GFmlT6EbDRVsdZEO7tH6dPbhVJ/aNykH
         H5fyVLERaCVQGeQaybF4SSmO6o40eVxbToEIeSNzherMCG2GE3u2v606M71PE3blkad+
         1Eslf3KcjHWYqu0vC6uoTFcXjCwNWivuCq27ZOrxzZ4ZRW5aEgjH73BuhdLHQ9Tq4x8s
         rB8wfrydKDQNegS4ErRgFplngPbvsEZauAXdbLqFjtaLOwq5y7uJbRakJD2o6ilLfd4U
         YGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706745866; x=1707350666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWmJW1ioE6shF94cLYg8UXpbXdCkseBL4kZBLYoeBuI=;
        b=VkdkvcD610i90dvrbVV0gDCTwsdSUonIN9hdbFldWCgpFnRUTKVQqZRxhiINRcj5Qx
         hks3oNLQ93I72czpT9MxxJAg/GuURuf/ujqhgjjcbDMBRmhTqNfPOz/fIDty1dXkMcZX
         AdbukNPqJ6A1Xo3/7pLQbV8rvX75h3iEp051/Cw5ymVk/qKv9loZgwiCgqRqEAk49CIk
         K8LHo3WktDZgR1hMSiHnkEcMjm0qcDS13mO7lagkoS/b7MDuo3FQZKjyODhQ8HFeY7uw
         j080gUQjZMtorXi5Tg2JW0vZoPVWf+g/o4danyz15syvxrKY3P28SZsFjmMJEJPOG3eA
         tlNA==
X-Gm-Message-State: AOJu0YyuVF61qtYbiIW5isDMFxTdFzVjxj8Xa4BOdvOa7aR3Hvqa7dZj
	s9ZITcsawNmZlMIFTtsdOsapgHIS2dYZAy+agPCyKdwN+VYyW9Sg
X-Google-Smtp-Source: AGHT+IGBKobfIm1xyfYyTe1hLyDXEz+BO2PI+5A5iytez90gtfBGuKYEcrsACR6tlmTY3B1KQ7lVsg==
X-Received: by 2002:a05:6a00:1c91:b0:6d9:ac1f:421e with SMTP id y17-20020a056a001c9100b006d9ac1f421emr3881511pfw.26.1706745866320;
        Wed, 31 Jan 2024 16:04:26 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id jw3-20020a056a00928300b006dbd2231184sm10443282pfb.70.2024.01.31.16.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 16:04:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 31 Jan 2024 14:04:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com,
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com,
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
Message-ID: <ZbrgCPEolPJNfg1x@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>
 <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
 <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>

Hello, Linus.

On Wed, Jan 31, 2024 at 03:19:01PM -0800, Linus Torvalds wrote:
> On Wed, 31 Jan 2024 at 13:32, Tejun Heo <tj@kernel.org> wrote:
> >
> > I don't know, so just did the dumb thing. If the caller always guarantees
> > that the work items are never queued at the same time, reusing is fine.
> 
> So the reason I thought it would be a good cleanup to introduce that
> "atomic" workqueue thing (now "bh") was that this case literally has a
> switch between "use tasklets' or "use workqueues".
> 
> So it's not even about "reusing" the workqueue, it's literally a
> matter of making it always just use workqueues, and the switch then
> becomes just *which* workqueue to use - system or bh.

Yeah, that's how the dm-crypt got converted. The patch just before this one.
This one probably can be converted the same way. I don't see the work item
being re-initialized. It probably is better to initialize the work item
together with the enclosing struct and then just queue it when needed.

Mikulas, I couldn't decide what to do with the "try_verify_in_tasklet"
option and just decided to do the minimal thing hoping that someone more
familiar with the code can take over the actual conversion. How much of user
interface commitment is that? Should it be renamed or would it be better to
leave it be?

Thanks.

-- 
tejun

