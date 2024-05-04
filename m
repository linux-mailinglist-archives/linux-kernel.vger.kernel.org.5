Return-Path: <linux-kernel+bounces-168501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A05D8BB951
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7E91F234B6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496CEEBB;
	Sat,  4 May 2024 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqs5/ltv"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF82AD2D
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714790877; cv=none; b=knTT83ILUePt5UFhfpv7eKvKfeNLUqv93b4pDEhtr3Z80PkzMu21BisFInP6l6xj9q83PrWbt6nm1Wu0jj0wsmZ2VF9kZzIu/vcmGryQhZ/CO+nQP/I1jRQtWXOnVe4Rh/ktMC12Uuy0qShapZDucYIj7Qzvb58653EDXOOL78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714790877; c=relaxed/simple;
	bh=5JQ+PciXGBfqr3585pp1l+Yf2bSgp0V0fbsYUs9AeeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIJAJdL6me1vAAkyJAd+37WCQr9ymUoduFdWm2LN45tAIj/5QyDa4zcdt6Xppi8JxfovXUHaZGVoALDEtwMXKGIr4lVzwLmEs3Hr0zefCGJq5LGjY8c44MA7Z1zCXffmqle7D2HHMFq4ggoRe9oMZWFX40xixbVq6MMVUiRyAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqs5/ltv; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5acfba298d5so131179eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 19:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714790874; x=1715395674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpviiK45PfH9lm5OyL0Rvy5gReR5EB5K2kEbT4EwRMw=;
        b=hqs5/ltvG/yyD4YNNbbZx8u0K85yo6fMZg/6ZdcG3wCGXq3AqFFSKXBsEAIMLADdLp
         7kGSi5sXe9ugUoChd+yti6vsI2RsJgNzAK4yD9rtPBGgkpqWsDwccFvsEcfmrGp0+HcC
         5O2JLyDz/dFTx9FEH/iduFKa2ql+LJ7klfA2luF5rJ3hCRBS1u0ET45f+nyILgyTmUTc
         b8To22U01DQwzlvUYrKpeTJmdJz3fJ9d2e8UfWL57bEO6dSS5egAtvv/QUGw2GVnS8Os
         9n7xgFF5B1KPKlbJJUhc9coAlUdKQYTL7JmdZZp8DOvAXn6I3oEEsXl+BMPi1sGnsxe5
         XcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714790874; x=1715395674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpviiK45PfH9lm5OyL0Rvy5gReR5EB5K2kEbT4EwRMw=;
        b=Jy1Cregwys3oeLnAj/xAIaxMrs40OHNYih/2i/eeVgVjPJseZx3yNX5qTKCBOuB4MW
         +EEHRfBxgy3C7MwUYhYLtfBOFNzJKPRJRxDZ2nR+SblacsGa+4OC7DhE3cttRdWqgMyu
         Y4pWcb7hmV7cIrm1kNwYLWY0qEKIOW4UFSRF4H/RAvOkZqcypO6xJj+X9T4sAOBJPyep
         gXot8VynTzb7sC64AMgzHtpe/bRBqci9iE27z5oOkPlzFYEcff22+fvyBzfcCStd7Ire
         HBVAqoLZBTk+fRnCbTeSnHicTbSasWtgx1ZLkKD8/FklVzVHxshun+zpfWmINdER/Z4e
         GObQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoIxl2EbwTDJy67BboteVXZQfu2qiWv9z4a6TSAHwuvg7gKMZA1Wb+NnKyeITT6hjMB8KgTbMNZ++As1mH0M/Yk3tQ/BF5QFqDrLxf
X-Gm-Message-State: AOJu0Yy+x5/IxEF8+VbWXSJfPcvfHoythOZL1xhmIwFxkn3ytNDjFyya
	jIVkJv0zuWbk/E57fx87YeMW0l5o9NpIpgG85nLFSkw3DAfthOLpV9IgfPoF
X-Google-Smtp-Source: AGHT+IHI8kVeY1mEGCxJqdVjBf2N8secormTFKCCCAp0IUM8AWDigGZoNpLC2S6L88eHZDrmLu7pWA==
X-Received: by 2002:a05:6358:9149:b0:183:a0ac:b5c2 with SMTP id r9-20020a056358914900b00183a0acb5c2mr4505424rwr.11.1714790873866;
        Fri, 03 May 2024 19:47:53 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id qa3-20020a17090b4fc300b002affd099d22sm5795901pjb.40.2024.05.03.19.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 19:47:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 3 May 2024 16:47:52 -1000
From: Tejun Heo <tj@kernel.org>
To: John Stultz <jstultz@google.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Will Deacon <will@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Subject: Re: WW_MUTEX_SELFTEST hangs w/ 6.9-rc workqueue changes
Message-ID: <ZjWh2MbDs1CF8PUB@slm.duckdns.org>
References: <CANDhNCq2n2HVUnVi0K+cw_7MUd1h49BzTxLEk6V3G2c=BBUYBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCq2n2HVUnVi0K+cw_7MUd1h49BzTxLEk6V3G2c=BBUYBw@mail.gmail.com>

Hello, John.

On Fri, May 03, 2024 at 06:01:49PM -0700, John Stultz wrote:
> Hey All,
>    In doing some local testing, I noticed I've started to see boot
> stalls with CONFIG_WW_MUTEX_SELFTEST with 6.9-rc on a 64cpu qemu
> environment.
> 
> I've bisected the problem down to:
>   5797b1c18919 (workqueue: Implement system-wide nr_active enforcement
> for unbound workqueues)
> + the fix needed for that change:
>   15930da42f89 (workqueue: Don't call cpumask_test_cpu() with -1 CPU
> in wq_update_node_max_active())

This should be fixed by d40f92020c7a ("workqueue: The default node_nr_active
should have its max set to max_active"). Can you please confirm the fix?
Thanks and sorry about the hassle.

-- 
tejun

