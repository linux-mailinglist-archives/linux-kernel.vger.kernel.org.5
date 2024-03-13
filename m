Return-Path: <linux-kernel+bounces-102355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1272887B116
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E0F1C28632
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC46C71730;
	Wed, 13 Mar 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPLveOex"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60294487A7;
	Wed, 13 Mar 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354156; cv=none; b=eeSeRnD+4xPA92lLuxnw+h91Tz2IE45Y0rT09rklD1BeDdFTJ2gn3k3FaVj/h/jbsSn9zr6WVrUPUBwVucWactxu52npnUxHA0NgMbry6wnOh+ohTjD3sbr+pHNXXSfFCOIN+bQ3U+Gf0Xb0MopYE7Ig/GDJE/fG9mYm/4mW3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354156; c=relaxed/simple;
	bh=JFXJFFEtKDig4ScYbvL92KgFkW4nPQQEBbS+hPAVQx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/OLyPUjS2mc3Ooqlgd4shLd7pFDwakuKTRKwTHPUbCduSoHlO7mwIZPwm+Qo1yb9OQCWBfeK9jQV0b/VQjQte8lThwCoeLVI1AefzjW0zbfAjg1wtwWSYWHgv9LMIzVaEpqSDbicoXbvdqJCN6XC6ZRrG+DRQ0aEGVI/hzqDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPLveOex; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789ca2086b6so6728385a.3;
        Wed, 13 Mar 2024 11:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710354154; x=1710958954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu9TSzUxdZ0PpMpVusNNqoVTI9+ZtwDdSin31u7vPO8=;
        b=HPLveOexLlCy14jPAePgDo7o4vpI9CjMlxsHkcZNVDw9/kebudjMke7I1R7vIm2J7H
         7lrm7rC3CcDodvo6eg+oOv+jp5Rk1GOwHIzYA99J1LVdGr/0tUHcQq+Lfx+yRiafoKkD
         9B+XyKJD1Lt6Pth1o3SLHZehfDXmecsOYRdaX+WWbFHtFWkmeTDLIh0ytlLN/hwBO/hH
         5u/f8OGpnUgpZw59NYH9rfrdhUFJQ7XyUfGSgKeJgvu+WQ/46tAP2llso5ieLUsSbPjA
         zbUkzCo0L77Ic34rZIC82pczWXoUmj6Q9uEYz/UqXwHz/UQEBTVolCtDB37wgfZMYMea
         nNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354154; x=1710958954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu9TSzUxdZ0PpMpVusNNqoVTI9+ZtwDdSin31u7vPO8=;
        b=hk/JbtFFoexZF39Cd6J4lasJsuj/HW0ayIp/K74vFzgYNzvJlggWrl7nWrgQq7stBY
         a+OU0+1+/YHrYHGjp2wATTFpRmwc5LIxl1oJsUwmqjrFUZGY2Ze5koIoPjoEIJkLzjNe
         zDZZ6IXbnDFMOYB3uEZJZhLAZzP22xGlNhPdyGhPHRUGSeG+A035ehcZmAETLyEFzmc8
         biBslAqOMpZRUUY17TEOzypw/VRaKIk1bEQ5zYVaDPucg+zDlA98kPxuaYsnRN83iGin
         mho+FEBbITXOQNChBoKweRffzFnj6B1axwU/V4ugmSRA0ghSCgSDojw2j4lhwHt6ll6B
         NNpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQBUazph1LcVSGeQud3Av0BAIBD7mC7PGR4OKSi3YLFYpv8X77+FrcHKSyjweSqSy/bqMxQVSAmV+A3WkOTYGusQJsCh9HLP2Z6h4NQfEw/6dCGGTXJH3MO9+kvJQbHo8QnC8bdb+bUmgwYpj0755qqV1mgzaC96fSx/5d8HREpm8FjQL5ZJAPSQ==
X-Gm-Message-State: AOJu0YyW9G39sQwA8EEBEBIGSP6pyCMEZNlBFl0+K20fCXdnc5I/vG61
	zUbNOFaGdABXrPFBk9bDbLImok/XNk17updq009I9a80S/9VD1QA
X-Google-Smtp-Source: AGHT+IFwsdo/7sapX0TzJBXqyFvWAlN4DaqwjRkvbi9MP/SK1ntjGN551/cHdoDbykf3nySISPR1dQ==
X-Received: by 2002:a0c:e902:0:b0:690:e990:c183 with SMTP id a2-20020a0ce902000000b00690e990c183mr668580qvo.10.1710354154306;
        Wed, 13 Mar 2024 11:22:34 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id e18-20020a0caa52000000b00690d2942caasm3343733qvb.20.2024.03.13.11.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:22:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id AD314120006A;
	Wed, 13 Mar 2024 14:22:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 13 Mar 2024 14:22:32 -0400
X-ME-Sender: <xms:5-7xZcWmTcXLJSJq7Qe0TY3cjeTSawYkf_faFuNN3dqH8WqlGaNZFQ>
    <xme:5-7xZQkcd6E0pX8jxlvf-q879l4eWI_RWj1DTM7mba-rHi3GuCj-pqVRNibai9zmt
    J5i6ttESDRd4BT31Q>
X-ME-Received: <xmr:5-7xZQZek2ApwGf1c2XC3zYwN3u6ZGl_GBE7hevkuPCpu6cVA-IA3kwukgNjoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeffhfdtkeevveelheduieehveetffduveduleeffedvvdekudekheehtdeu
    veeihfenucffohhmrghinhephhgvrhgsshhuthhtvghrrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:5-7xZbXYo6sbKfX73rEWj_AlGTqr6TOSnGOJvELGHjOOs9gyXDFXWQ>
    <xmx:5-7xZWmnlULMM341nu0GaR2vDf8c9tHGq-WH1U5nV8MxJK2gCt5Khg>
    <xmx:5-7xZQc607HXSMCmbLfGevE1aZQUWp-XtzQSOFDoztxrkWoedIu47w>
    <xmx:5-7xZYGQI4DLetnKjyyiAW50eenZj5EnAZHZl044NdEDgNX0IkloEg>
    <xmx:6O7xZZAtsqmHy0_eCLTdh-95KU42RjrfVIutDdwu_zpd44E50w--_jW9lsY>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 14:22:30 -0400 (EDT)
Date: Wed, 13 Mar 2024 11:22:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/5] Rust block device driver API and null block
 driver
Message-ID: <ZfHu48NGktOx_uhG@boqun-archlinux>
References: <20240313110515.70088-1-nmi@metaspace.dk>
 <855a006d-5afc-4f70-90a9-ec94c0414d4f@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855a006d-5afc-4f70-90a9-ec94c0414d4f@acm.org>

On Wed, Mar 13, 2024 at 11:02:23AM -0700, Bart Van Assche wrote:
> On 3/13/24 04:05, Andreas Hindborg wrote:
> > This is the second version of the Rust block device driver API and the Rust null
> > block driver. The context and motivation can be seen in cover letter of the RFC
> > v1 [1]. If more context is required, a talk about this effort was recorded at
> > LPC [2]. I hope to be able to discuss this series at LSF this year [3].
> 
> Memory safety may land in C++ in the near future (see also
> https://herbsutter.com/2024/03/). If memory-safe C++ or memory-safe C
> would be adopted in the kernel, it would allow writing memory-safe
> drivers without having to add complicated bindings between existing C

I honestly doubt it, memory-safe is not free, basically you will still
want unsafe part for the performance reason (or interacting with
hardware), and provide a safe API for driver development. I don't think
that part will be gone with a memory-safe C++. So the complication still
exists. But I'm happy to be proved wrong ;-)

Regards,
Boqun

> code and new Rust code. Please do not take this as personal criticism -
> I appreciate the effort that has been spent on coming up with great
> Rust bindings for the Linux kernel block layer.
> 
> Thanks,
> 
> Bart.
> 

