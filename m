Return-Path: <linux-kernel+bounces-75893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E0D85F05F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B37F1C21433
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF241775F;
	Thu, 22 Feb 2024 04:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/yMmm/k"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513317597
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708575156; cv=none; b=rZBrOvebwE+CMAIYRsLxMZvnAxUWhXrstQ8q1CVWtpnQzcdjtTdW5bxANZvB7nfbVRWQmzGsrqdAkrRSpgBGL+czeRCVJpui3ma+W1c6yqybX0VSme6WpNUNRFOhDHP+sMIsAb3l5NzjLxr1c6PIgfNqMzHzd79Qh2MApINLRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708575156; c=relaxed/simple;
	bh=H/OLToJz+dgjJOzefoYguLHXE2+tHxbLQRtRjU8o2Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2flDYydyuNqykxTUnjG6HTA4PeGM6IVC/q5Naj1ZsiYye8MEZAeQbDX8m1a0m9T2IP/nisawslKfsk6iMSIlranKcCD38Ls9NYwpEHjg7dOwUAROWVm9o17rJS5KumhRXIt+WbjvKXvXePbxvfot/ndcrySjktqqnQD6Tgtl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/yMmm/k; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68f9218e777so11504846d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708575153; x=1709179953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e58DbB4xiwM0z5f6d/qtKGhcFnmKvWPyWMuz5PIe+p0=;
        b=V/yMmm/kQwK3DlbWQDPnoleVwVMt/en3K6sDJyoeIZjs0+WYb60X9YBHv8VVyDoIJn
         43rAU0iMkTACd7Obk5YV0VNLdtXqjFbm8jSrj9p6vQYSg5/APYgTEG4bo9U+sLgbIXlF
         OfbjZWE7OCjMPz2iVXZHUPYx+y9I1OoblLKOh2MvfWSCP/un4odi7ODcPpB3IySt9/8+
         m2+IM3VXSnNHXUbicdYw/4FqXckKEmqprHRlNonxDucbp1+GykZLRvQDFCncIbtFD8rV
         yoarc931mjLbUJwslfaLQZJ67CfyuBnmBlqtYDrZ4IG8HyIO0LUaKkMbr9Pq4VU5tEgN
         l9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708575153; x=1709179953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e58DbB4xiwM0z5f6d/qtKGhcFnmKvWPyWMuz5PIe+p0=;
        b=IzkmRgJKBhoBmCH7SozkiC6wk9Zjv31D5DwQE6EGEVWjRddB5Gmy9Ipkzj1dgsf4PY
         UIJfRLa4LX4PVKP7s5QPWmVyg7qxXniuHrTO2xjA7w8wC2R2egOou6vok2orj1/ace37
         BrFowP5D5SsLXmsSSj+pnAfwt83RGyNJqMMBYPvcaduKeOufoxCKOvOFJOX+BYXbjSrD
         v5xNUrl+wmlC8ubAfl6cz4lTo2XhjFZ5harcj16TQaOtrXNOVP3G1z/R6nP+M6sCarQD
         fbKDcdMXRxMMM29EDAVaOmLx6AiHNaDoWDOt6vxAwdUmbUjn9/hVcIACH5H7vXIJ9ec+
         dPFg==
X-Forwarded-Encrypted: i=1; AJvYcCVO1AIN7kYOcvpPLnXNjRXxQo+FxRO1myb5YfBTNDRyuXdYJT8/MIxWP9cSbgg69hz29fB07KAlks4hreyIHQAE9JE/NG2mROOK+ZMd
X-Gm-Message-State: AOJu0YyyfWO8gqIMG0c23tX5VkRqxRp1DKidn+DNhlmnSSSDxaUru7dA
	ycYY3JRHCuIoB2ui6r+XJnzQWIrGuIekdRfRlMpmiPcTU7i/8xXj
X-Google-Smtp-Source: AGHT+IHtFuWnpPtzgM5BXclzFdWw9/7q+40mOH5r2FCCBffOGuYsM2bnq7paumo3Cz4ks6SU6NcSQQ==
X-Received: by 2002:a05:6214:2422:b0:68f:6dc5:149b with SMTP id gy2-20020a056214242200b0068f6dc5149bmr11442225qvb.58.1708575153544;
        Wed, 21 Feb 2024 20:12:33 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id na4-20020a0562142d4400b0068f75622543sm3861611qvb.1.2024.02.21.20.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 20:12:33 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id AC4841200043;
	Wed, 21 Feb 2024 23:12:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 23:12:32 -0500
X-ME-Sender: <xms:r8nWZf045lMD4UPX7z7npdaZdrNTRlFC511BFtOMdlK3YQon7ANWDQ>
    <xme:r8nWZeGta8fdgCtD1EvsJJi4dYxEs7d-pq2fF0I4kcvnanCdunITCiK7y7lsC5OYM
    ZaLZfHyYgsD3-oW3Q>
X-ME-Received: <xmr:r8nWZf6G3QecciP9UCT3eaZDRAfY7CkU_Ch6-TwXuML7VolT8gO68hamVIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:r8nWZU0aplvds15emkmx1Kkww-98t8ShyOtsnuVeLIS4LoImzHaEzA>
    <xmx:r8nWZSElmoJ3q_n2x3l38P4V337u9ikUYe9AZZIatbHD1kZdvWQIXQ>
    <xmx:r8nWZV8RUHJRtNatTll3h64YkYaBWzY8eAa5xIbzuytPD9pBnwg0nQ>
    <xmx:sMnWZV1yEJb7Ml2z-QiPIbkUrm_Z73RFfsUekCKgbYP2473i0lEyZ7qdqPI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 23:12:31 -0500 (EST)
Date: Wed, 21 Feb 2024 20:12:09 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH 3/4] locking/rwsem: Clarify that RWSEM_READER_OWNED is
 just a hint
Message-ID: <ZdbJmbltYYBPvU-3@boqun-archlinux>
References: <20240213031656.1375951-1-longman@redhat.com>
 <20240213031656.1375951-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213031656.1375951-4-longman@redhat.com>

On Mon, Feb 12, 2024 at 10:16:55PM -0500, Waiman Long wrote:
> Clarify in the comments that the RWSEM_READER_OWNED bit in the owner
> field is just a hint, not an authoritative state of the rwsem.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  kernel/locking/rwsem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 2340b6d90ec6..c6d17aee4209 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -35,7 +35,7 @@
>  /*
>   * The least significant 2 bits of the owner value has the following
>   * meanings when set.
> - *  - Bit 0: RWSEM_READER_OWNED - The rwsem is owned by readers
> + *  - Bit 0: RWSEM_READER_OWNED - rwsem may be owned by readers (just a hint)
>   *  - Bit 1: RWSEM_NONSPINNABLE - Cannot spin on a reader-owned lock
>   *
>   * When the rwsem is reader-owned and a spinning writer has timed out,
> @@ -1002,8 +1002,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>  
>  	/*
>  	 * To prevent a constant stream of readers from starving a sleeping
> -	 * waiter, don't attempt optimistic lock stealing if the lock is
> -	 * currently owned by readers.
> +	 * writer, don't attempt optimistic lock stealing if the lock is
> +	 * very likely owned by readers.
>  	 */
>  	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
>  	    (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
> -- 
> 2.39.3
> 

