Return-Path: <linux-kernel+bounces-56771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D884CEF1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092DB28D245
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C7781AC0;
	Wed,  7 Feb 2024 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c153YLC8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D591181AA2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323672; cv=none; b=YwuZTYpf42DAsmgGNp29eErUsArsoei2XQEeS6dNTcKiM87t01DmFrGW2TvrVEsiKszjgn7j4A0xJk947ewXq8H3zYZE5a+eAj67MJHa0JmUSvpl7mbnMKjxSjr9wObquhQKzryypIH05xquyNqEfBsEf5eMLcvhIVXv5dB//jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323672; c=relaxed/simple;
	bh=oag201Dwg2R1YiuFTZ3pJhwIjzZHqggc69L2jZaITxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjI3LexfsZ0mIglD1oEUZ+XdSqXUTphX6XvZNV/pHqYZfnZIxDZkH9drCENccTUtqru2/Dvv0Z2RLdlT+jyxbNTNuaZEpfm56m2/TWH1eyjGWfUIpiDcUxLjc4wj+neREEVgsQpmXWmnxZGpb95oTUq6RHTWlJhKNHIsicnedjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c153YLC8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e06725a08dso549452b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707323670; x=1707928470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qWJfZs5obAhPKW/hvHK9EKHhgFJrOCu3nsb0TTXjds=;
        b=c153YLC8K0VLA9ww0qPgttt/R81XOQPLuwBWm1bHm/xGlVxUNto+GWFH6KQdT+lrvg
         t2MC++EJbl1sSFX5GVgHLa85DG9dD/k6rpclsKGPLPLywr/XS8SRIMHKOeIYgsasqQvu
         c1wtD4W33mySvA8NlOZYT4APKIXUheeS9Ra1NpYMsG53/iNqcPs431sGi3VNIfGE4+kB
         gBSdZjOb9PEHtx8E0p0P0sfu74ihPZfAUzoH2Ms/IQi+uLu0DGR8KUJM79/B9VyY1RoM
         EWT4+a+GT8101l2YieLy8IOeyYSMlxj2BYQyiullggU2QdjVOv1vSjXNFpcDkGKlffTt
         YVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323670; x=1707928470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qWJfZs5obAhPKW/hvHK9EKHhgFJrOCu3nsb0TTXjds=;
        b=DZv2bl1RVQ7Fh2JZdOLxlZ21s6e6S7xcKnTdtzV2qtIvWVgB21uRJ3scR/9QKQNuJg
         mqS8DboGls2aFKMfdufAx0p/pypbsl/Rn4yE14uq3nVV+HI3Azlh/V8nAT72cREB8say
         OjGiliB22EhNXwAX5AVapz562MA3/yCxbXKIvrsVVAbiuqcN4EM3RDFg89wXq+ZLV2mU
         pQ68TvWEl8p/TP0H/iuVGRE+NXcT7nMl3bY1g97OEJDdgDyZ+AHsgZ4SPAGgxkOpKODF
         FI0NbE09Mx1Os7EKBhRS2GlZgddorQLJL+j7k7rlLFPRiSCnzLWChgLrvicMr1APrEl1
         XWCw==
X-Gm-Message-State: AOJu0YxbtRYmffbHr6lZQS/S3ksFgmwptSrKdkb+BBTv6cat92Yhc9IM
	j+KEka5e0+hhJ1RBj65kpcpVc3a5E6fsxk7FMOnmGE639M6I/XKL3Xa9pUHYDuA=
X-Google-Smtp-Source: AGHT+IHzISXcDhzxb3uxSLeubLzvHSYCuz5U73OLZbGdn1XxCYfBWHIVlY+XBHlSSbk7QwjNU9+cvg==
X-Received: by 2002:a05:6a20:d390:b0:19e:99f9:a91a with SMTP id iq16-20020a056a20d39000b0019e99f9a91amr6682175pzb.43.1707323669941;
        Wed, 07 Feb 2024 08:34:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTGPhBcSbwQ+NlNeDJuIDhKCNAJsdMLbEgPKKXkWZbNPo7sAqaHHM0shhIablUiK9LZSe0SsgbioTmm5KDQiIXp2eEzIyrWf1syfZyIXVSBhAKmRIwYhLgwMzVAkM2mTAfMS7wkSrT3ZLHHNsxRSITPZcsSl+4
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id ku8-20020a170903288800b001d949e663d5sm1655342plb.31.2024.02.07.08.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:34:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2024 06:34:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: make wq_subsys const
Message-ID: <ZcOxE2nznfq7dcNh@slm.duckdns.org>
References: <20240206-bus_cleanup-workqueue-v1-1-72b10d282d58@marliere.net>
 <2024020752-tannery-frozen-04ea@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024020752-tannery-frozen-04ea@gregkh>

On Wed, Feb 07, 2024 at 10:12:34AM +0000, Greg Kroah-Hartman wrote:
> On Tue, Feb 06, 2024 at 03:05:06PM -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the wq_subsys variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> > The maintainer asked [1] for this patch to be received through the
> > driver-core tree.
> > [1]: https://lore.kernel.org/all/ZcEeOueCbrltxr_b@slm.duckdns.org/
> 
> There is no cross-tree dependency at all, but hey, I'll take it, no
> worries...

Ah, my bad. I branched out wq/for-6.9 before rc1 and was assuming the
dependent commit was still in the driver core branch. I should have just
pulled linus#master. That said, that patch going through driver-core should
still be fine.

Thanks.

-- 
tejun

