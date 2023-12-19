Return-Path: <linux-kernel+bounces-4683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE5B818094
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1700E1F243C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1279F6;
	Tue, 19 Dec 2023 04:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBXAwVCN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E066D3F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b7418bea02so197543539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702960298; x=1703565098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KASV8ZY3q4Gm++WZlk7mbPwpsWDMSJh7Y1zsTXQhMQ4=;
        b=fBXAwVCNsUgB2D1U++KbQIjAQuG8rsBhf/r+qKVqUAoMKWbOIVJD+KYJ/T73sBnY3t
         Ozrw+PYUuluHj1xMSPCrZRMqIV6PgXMddBVlYLuqnxDS+g3IDHbbC9/kwgrMVQaeUzzv
         C5Xblv2xNEaYOGHP2A7mpDAY9vPfZnQe9xmWvfbjoO9um9q9sJ1GtAHYTCr2gn8OFKsh
         W4ckEdo1k9StrGTaTEGM1g6iwwgDgZWp0lcVo4GBeeREROuJcgavD9lTrAuXFqUFQ3fG
         3mNBh0tZRcCijoydGXyzrM5nNA+BFAAMPaZOY1IEXjOaNx3R+F4za2WCPfGqsY7ow1MV
         C8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702960298; x=1703565098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KASV8ZY3q4Gm++WZlk7mbPwpsWDMSJh7Y1zsTXQhMQ4=;
        b=UARNXqRcyitPgtofMNbo43H9lWblXzR8HUxLHfQhViYN/hiyQzFidJeT4RDDOW09xi
         t1c+1TEDf4z/ZhKbsxso7Gq2vQJZaCYfSB25dptO0/t63OP9LPSj4gD9jWR/kQNlEaIJ
         v6AjgA4+A93SanzKt2wHz4e1W74r4FMaGROB/zZ5O61VaxZTIgs7z9m3vEOyIYXHEYGj
         AP1IOSRqKB6C57mr0V7CaRwmUguwVFtfIfymHwGmm0wA8Jcwg9icZRym71OBOV2Ww5aF
         tItfkuwrI72EyjMx2ihVNRcJk8mNT9QTxfJJDUNWzbnBMFZK24ZDdi4x0UFhQ5JakI8R
         R6AQ==
X-Gm-Message-State: AOJu0Yz2+px0QgrJ0ahlWzhmM6jhRfwZOIVl2oOLAC1qiV+bnnzSGGGb
	MjscOpfaWGsqRbU8FhC4338=
X-Google-Smtp-Source: AGHT+IHBQGuQpaCjfbmEqKhvpwV4Dyb8OSyRzQXCS8TyuU0AA7gKbA3htBg3b+dop44dZKEl6aBpJA==
X-Received: by 2002:a05:6e02:1e09:b0:35f:a313:5555 with SMTP id g9-20020a056e021e0900b0035fa3135555mr8026312ila.64.1702960298277;
        Mon, 18 Dec 2023 20:31:38 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902cece00b001d0c37a9ccdsm19949051plg.10.2023.12.18.20.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 20:31:38 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH 2/2] crash_core: fix out-of-bounds access check in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 12:31:29 +0800
Message-ID: <20231219043129.38841-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZYEOshALGbDKwSdc@MiWiFi-R3L-srv>
References: <ZYEOshALGbDKwSdc@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 11:32:02 +0800, Baoquan He <bhe@redhat.com> wrote:
> Hi Yuntao,
> 
> On 12/19/23 at 10:02am, Yuntao Wang wrote:
> > On Mon, 18 Dec 2023 09:29:02 -0800, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > On Mon, 18 Dec 2023 16:19:15 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> > > 
> > > > mem->nr_ranges represents the current number of elements stored in
> > > > the mem->ranges array, and mem->max_nr_ranges represents the maximum number
> > > > of elements that the mem->ranges array can hold. Therefore, the correct
> > > > array out-of-bounds check should be mem->nr_ranges >= mem->max_nr_ranges.
> > > > 
> > > 
> > > This does not apply after your own "crash_core: fix and simplify the
> > > logic of crash_exclude_mem_range()".  What should be done?
> > 
> > Hi Andrew,
> > 
> > I actually prefer the "crash_core: fix and simplify the logic of
> > crash_exclude_mem_range()" patch as it makes the final code more concise and
> > clear, and less prone to errors.
> > 
> > The current code is too strange, I guess no one can understand why there is
> > a break in the for loop when they read this code for the first time.
> > 
> > Moreover, I think the current code is too fragile, it relies on callers using
> > this function correctly to ensure its correctness, rather than being able to
> > guarantee the correctness on its own. I even feel that this function is very
> > likely to have bugs again as the code evolves.
> > 
> > However, Baoquan also has his own considerations, he suggests keeping the code
> > as it is.
> > 
> > The link below is our detailed discussion on this issue:
> 
> There's misunderstanding here.
> 
> Firstly I said I have concern about the patch, I didn't NACK or reject the patch.
> 
> [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
> 
> Usually, when people said he/she had concern, you may need to
> investigate and resolve it or explain why it's not need be cared about.
> 
> E.g on above [PATCH 3/3], we can add below code change to stop scanning
> when the left ranges are all above the excluded range, assume the passed
> in cmem has a ascending order of ranges. Say so because I checked code
> and found that crash_exclude_mem_range() is called in arch arm64, ppc,
> riscv and x86. Among them, arm64 and ppc create the cmem from memblock,
> riscv and x86 create cmem from iomem. All of them should be in ascending
> ordr. The below code change based on your patch 3/3 looks safe to me.
> What do you think?
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index aab342c2a5ee..39b6c149dc80 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -574,9 +574,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  		p_start = mstart;
>  		p_end = mend;
>  
> -		if (p_start > end || p_end < start)
> +		if (p_start > end)
>  			continue;
>  
> +		if (p_end < start)
> +			break;
> +
>  		/* Truncate any area outside of range */
>  		if (p_start < start)
>  			p_start = start;
> 
> Secondly, I welcome people who are interested kexec/kdump code, and raise
> issues or post patches to fix bug, clean up code. I like these patches.
> They can help improve kexec/kdump code and solve problem in advance.
> I would like to review and make the patches acceptable and merged
> inally. And I also hope people can follow the later issue reported by
> other people or LKP if their merged patch caused that.
> 
> Lastly, people are encouraged to help review other people's patch
> and give suggestes to improve the code change. If patch author don't
> respond for a long while or the work has been suspended for long time, we
> can add comment to tell and take over the work to continue.
> 
> These are my personal understanding and thought about kexec/kdump patch
> reviewing and maintance. So cheer up.
> 
> > 
> > https://lore.kernel.org/lkml/20231214163842.129139-3-ytcoode@gmail.com/t/#mfd78a97e16251bcb190b0957a0b6cb4b0a096b54
> > 
> > The final decision on whether to apply that patch is up to you and Baoquan, if
> > you choose to apply that patch, this patch can be ignored. But if you decide not
> > to apply that patch, then this patch must be applied, as it fixes a bug in the
> > crash_exclude_mem_range() function.
> > 
> > Sincerely,
> > Yuntao

Hi Baoquan,

I must clarify that I was not complaining about you. On the contrary, I am
grateful to everyone who takes time to review code for others, because I know
it is a lot of work.

I'm relatively new to the Linux community and still learning the various rules
of the community. I'm very sorry that I didn't fully grasp your previous intention.

Regarding the method you suggested to add a 'break', I did consider it initially
but later decided against it because the memory ranges obtained from iomem may
overlap, so I chose a safer way instead.

Finally, I would like to apologize again if my previous response offended you.
That was not my intention.

Sincerely,
Yuntao

