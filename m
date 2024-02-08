Return-Path: <linux-kernel+bounces-58218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06E984E2EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD0C1C26D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97E678B69;
	Thu,  8 Feb 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biegjxks"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0BC67E93;
	Thu,  8 Feb 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401670; cv=none; b=NW+UeK4XMTESRUVg0Num7faji+F/wiDnOwlph8h2Y5v5dO6Sh96sAoRWOzcqCYFcc5W2qmj3+73D9xFQezpOQOYeIwDd9TPN7CU6w0rY2Mq6s9t+vONBymdtGuc77t5zM3olQMRhLxQebFDkX69FXLh7M/olFNRtLD2KCc/wpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401670; c=relaxed/simple;
	bh=esiRYFwIEh8zGi66dB2OgFMx04uRoqhUXBs5pWjxU8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTRdLvmqJZqFyxB8sK2/imX8ETRICb9W8hsVeCIykUejG0th8pL5rj3shUSTLXtCp37O/nh5cEBpkvyL2CwJDTT7TVsXTJKtnI+1+mwsV8mLuZ5lLk+3C7tIktRXf6QEIKsYsglUGy3tDu5eXPk8/PTlnHdrrrITX18z9xNmc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biegjxks; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28a6cef709so254864366b.1;
        Thu, 08 Feb 2024 06:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707401666; x=1708006466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDKJggBNKUh5J1UD60+/UCBCI6C1MTiVKiks1Qd8k3o=;
        b=biegjxkszB86OLmMbfvG8HUkJjtKnG4mUUHyzy4yeB0lJrtwf3k1zVJGV0FZl9h2WU
         9dHyVWAQLnM9b0zsx/Kua1QQWZWvhmjomSS5OfTifuidQTqx/FKhW3WQBSjSUJsQu7xi
         fHYGCGm0MKEQ2W+gdE4ok2ld5jstm9roE1HJbFQTWhj3aMV0+lsKQr9ID+CoKGQdct8z
         icdBSDrcHEjRoH4TYjXIY4AturkCunlRLJJ3UvSO3sjLXU7O8QyhpRDWBbIXiBpG93Bi
         i2pNCFs/eB4L6Xwt+vN6xtGVhJskt5hmOnlR/ywRh96p+ewD6aBCafeHDbUxtWESWmMk
         VY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401666; x=1708006466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDKJggBNKUh5J1UD60+/UCBCI6C1MTiVKiks1Qd8k3o=;
        b=KUgZSWSWPrajUcP6RsmU7gbzaloCxs2nspFytKKOHfVr7PkeW2xvSo3RRQ7ZXlfDKx
         V/qGCXjCj4D/WXstvuF2PEq9ofP2t/ag5DrU2gixSoOPT4byA8addmjzKmYN+eCF/KK3
         pLqrIaOvF5Gp8wWtXpZAjD201hHk9GZT4g56YLQJ4TJOhC3whKmKtHNz3j36mzkb+KEd
         frAbBjJThYxY/5lCL/OkytDNC44JFTHqX2tfLTsBHBIBoUZcUV68q0Aof/FBoSMqNZt+
         WdRnA+919Rk/VskVMCWcJhh10Fd1ki9pfDk3KQY3lkE/j31FoPgVu7k8BE9k/k9N5iy9
         +7CQ==
X-Gm-Message-State: AOJu0Yy0XoA1l2IDzhQULJWcCFTIbIEiWD9SGxHfu3uzFUfSCdsaTEbC
	pNiwpCWNt32TB7mJ/F4kG1vIorwfp2FDIBShEG2d2JEdF5/1zLr5
X-Google-Smtp-Source: AGHT+IHr4RdcZIOaiSh1Q3PJLh4mVb4SUYUwnQUTA1xO6hlUnbTbmNqlpNO2IEh7urUC0/CYI9RdoQ==
X-Received: by 2002:a17:906:51:b0:a37:461c:61ea with SMTP id 17-20020a170906005100b00a37461c61eamr6213238ejg.43.1707401666084;
        Thu, 08 Feb 2024 06:14:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoXDprPoNLSf2MZ9/EnDleTd8xWd97TTn50rofvdwKhL8xCFOh2TlzUy+KkTqjRDlgLpqs2vrcVBTXLXm75Gugm50V5UpW9uiKe8XIpysaLfGBKGFA1JlX2CRbF0p5cVNyZcohCtQPO9+he/imflmMPDY0HprXZqtHTcXuTI55pmA6SqLgBTQkCFEwNQdIBAjlrGFEWJsN5SvnqNdvgVD5sfPMCWNGSctd37zIRhkdcm3Rv9NXmQvDLR9+aDzjOtNvw+IdRaFZDSnlD/SYPNrlWbG0U6Y8b04nmUSNPhSkib7+tbUFu/w2TIgrlcW2tI0RqfM8BXi8nhA5lS/gcn1/od8WVD8dc0+GJKrTFfzSAeqn+BY9/CuDG2XbkDb2HXF9q0hbCg==
Received: from andrea ([31.189.46.254])
        by smtp.gmail.com with ESMTPSA id ga6-20020a170906b84600b00a371c568978sm78815ejb.150.2024.02.08.06.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 06:14:25 -0800 (PST)
Date: Thu, 8 Feb 2024 15:14:21 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH] riscv: Fix text patching when icache flushes use IPIs
Message-ID: <ZcThvZgdzVHotyQq@andrea>
References: <20240206204607.527195-1-alexghiti@rivosinc.com>
 <ZcS+GAaM25LXsBOl@andrea>
 <CAHVXubj7ChgpvN4F_QO0oASaT5WC2VS0Q-bEqhnmF8z8QV=yDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVXubj7ChgpvN4F_QO0oASaT5WC2VS0Q-bEqhnmF8z8QV=yDQ@mail.gmail.com>

> I did not even think of that, and it actually makes sense so I'll go
> with what you propose: I'll replace atomic_inc() with
> atomic_inc_return_release(). And I'll add the following comment if
> that's ok with you:
> 
> "Make sure the patching store is effective *before* we increment the
> counter which releases all waiting cpus"

Yes, this sounds good to me.


> Honestly, I looked at it one minute, did not understand its purpose
> and said to myself "ok that can't hurt anyway, I may be missing
> something".
> 
> FWIW,  I see that arm64 uses isb() here. If you don't see its purpose,
> I'll remove it (here and where I copied it).

Removing the smp_mb() (and keeping the local_flush_icache_all()) seems
fine to me; thanks for the confirmation.


> > On a last topic, although somehow orthogonal to the scope of this patch,
> > I'm not sure the patch_{map,unmap}() dance in our patch_insn_write() is
> > correct: I can see why we may want (need to do) the local TLB flush be-
> > fore returning from patch_{map,unmap}(), but does a local flush suffice?
> > For comparison, arm64 seems to go through a complete dsb-tlbi-dsb(-isb)
> > sequence in their unmapping stage (and apparently relying on "no caching
> > of invalid ptes" in their mapping stage).  Of course, "broadcasting" our
> > (riscv's) TLB invalidations will necessary introduce some complexity...
> >
> > Thoughts?
> 
> To avoid remote TLBI, could we simply disable the preemption before
> the first patch_map()? arm64 disables the irqs, but that seems
> overkill to me, but maybe I'm missing something again?

Mmh, I'm afraid this will require more thinking/probing on my end (not
really "the expert" of the codebase at stake...).  Maybe the ftrace
reviewers will provide further ideas/suggestions for us to brainstorm.

  Andrea

