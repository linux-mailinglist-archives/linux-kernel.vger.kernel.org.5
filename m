Return-Path: <linux-kernel+bounces-105340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFEF87DC76
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E259B1C20D06
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF190EAC5;
	Sun, 17 Mar 2024 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="xqeF3ZSr"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9003CA78
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710659406; cv=none; b=hS+GRJNPMIF73uuEbudLOuf3+nne4gaDFTPXT5FCvLCx++2clfMBMnjQEQcLZ+aCNaVc0GQnz043GGHSy88FmivgZ/75AlxPLotyQ0M/stV3wnXJI07wc6SYlrgovUN9MN1z+WH7EXX9V+4NO7a2l02uXrt5xj5oTsOikVnoiVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710659406; c=relaxed/simple;
	bh=dAQ9Ys7rOJEtw8RI9uIex68C6AmMXZZy9eJKYxACNKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JSxWfxi13M2rF2SSdlhJr/fowJ7VNr/uD8OaCHA/mD96uYD0/AXFYTOfkD9vDQGxCf3sk6Si2X4kofgSZVWEqlXL1VZrnMoB+U7Wp1+C3U9zXbBSM0zKcTz3iKKgFJ8zWkv+NFDVRY4lq64nmIf7Myicx4Or+p+/ZEfBRa/geH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=xqeF3ZSr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so815726566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 00:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710659402; x=1711264202; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LkTu2DdOoIjtFjz1QLN2HyrHjy50grh8crsRFwnCysE=;
        b=xqeF3ZSrljSoXSzUvpZcAvgzAhmWJnZQjOL9oI+kRbLtHUtJMiEglIk7Bl5KYJbuvb
         F29AR1swJD/1p1cpRTniO8wh4/6kP1Ge9P9OLJvJ/nI9O9Hes+F5294Qv4gyOtIyLT00
         7eI6OGwa2jgDSPbq9go4DeL97Y5lKl7ceoHa7mVmRanZa5yiufzZhbe3yt6E2DL02VCv
         RQkneAb79c5RjrNQGe0Hxhl3AjN9/0nq0drtGwRAt0ejQqUJBew2H88fA6OUgD+zBeGB
         TnbGTw08hSfT/qP6pPZbMSdosN8DqUK/JdG7VnqrljE/7WZkGoI5o7qwNlCX2NIlvmGZ
         Lv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710659402; x=1711264202;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkTu2DdOoIjtFjz1QLN2HyrHjy50grh8crsRFwnCysE=;
        b=WAN4QO3KU4j6+6swZb0asFdHgZNL/OM+p/cZg5Il/96fuCDNMs4qoSP4HQKVqOiQdn
         FFnNNkVo2bCpI+54lyc/qCXDKi1qX/+qpr3fYe15mKMeVq3NulmaTZL2AQcMsFpWonyB
         FhydEMOStw3Ym3wnqJL+MwMWWfnIT6eUM926R5zYlnzPO6UB6thvJjAF47viSNDpUnQ4
         T7GNgVnm7a15nh3yJWyL0dGFHZTyrSdR/l+OaJ651Yt+YD3l4NpJQm3sZqxc1qSF6lPk
         gMSZZ1WzwetSyH484DZl24ztg6a8e5okoI5IGWxWE2UnIm2SAy+tCs3lRYFpt1jNb36s
         IRKw==
X-Forwarded-Encrypted: i=1; AJvYcCVS7Y3tF4K815r6xWFj5ribRVngjAKQ1wqeDt90jK0Fvnj9D2zzDjbITDf1L8eNXtoh3mwZRqR0SnHF3yhIhYuVx3zvMj/Bi/tRdoDL
X-Gm-Message-State: AOJu0YzbPgfHkqT1Rs4Dg3y9YjhqLRfLGX8iQ9AHAonnIw9S2NvMlsdw
	rBFsJGh1J29ga/awJPy6GaxihHn0cnxZltcoqomzrZiq7L731Mmm5NwSHEeQucE=
X-Google-Smtp-Source: AGHT+IF+FesYNXd78NW1aWUCW24eNFXC/7tgT88xR5E77bbR/6D1v1T9UYJRmLhwB5oKfZvCCmzwbg==
X-Received: by 2002:a17:906:6a03:b0:a46:75d3:dd46 with SMTP id qw3-20020a1709066a0300b00a4675d3dd46mr8184725ejc.17.1710659401525;
        Sun, 17 Mar 2024 00:10:01 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709064a1700b00a462e5d8d4asm3462772eju.114.2024.03.17.00.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 00:10:01 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <Damien.LeMoal@wdc.com>,  Bart
 Van Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,
  Greg KH <gregkh@linuxfoundation.org>,  Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno
 Lossin <benno.lossin@proton.me>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  open
 list <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/5] Rust block device driver API and null block driver
In-Reply-To: <ZfZajb_vcRwLacfH@casper.infradead.org> (Matthew Wilcox's message
	of "Sun, 17 Mar 2024 02:50:53 +0000")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<ZfZajb_vcRwLacfH@casper.infradead.org>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Sun, 17 Mar 2024 08:09:53 +0100
Message-ID: <874jd5qqpq.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Mar 13, 2024 at 12:05:07PM +0100, Andreas Hindborg wrote:
>>  - Adopted the folio abstraction where applicable
>
> I don't think this was the correct move.  The memory you're managing
> with folios is only used for storing the data being stored in the blkdev.
> It's not mapped to userspace, it doesn't make use of the flags (locked,
> uptodate, writeback, etc), it doesn't need an LRU list, a mapping,
> an index, a refcount or memcg.
>
> I think you should use pages instead of folios to keep a handle on
> this memory.  Apologies for the confusion; we're in the middle of a
> years-long transition from the overly complex and overused struct page
> to splitting it into different data types for different purposes.

Ok, thanks. I'll swap it back.

I was under the impression that using folios also give the advantage
that handles are always head pages. No need to worry about head/tail
pages. If the driver moves to use higher order pages for larger block
sizes, would it then make sense with folios, or are page still
preferred?

> More detail on this here, if you're interested:
> https://kernelnewbies.org/MatthewWilcox/Memdescs

Thanks, that is useful.

Best regards,
Andreas

