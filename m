Return-Path: <linux-kernel+bounces-65548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9245C854E92
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FDE280995
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A41F64A94;
	Wed, 14 Feb 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hadR5BUK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DF8612E6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928191; cv=none; b=PMfjacrLUjQRXTU5vLLhy5uYo12zlV1DLqqmwKZMGREyYlj2l38irB+IPCWI1ciV8z8JtLBgWSRdHXwU6sdygWmGcU4/FvexJA/nLC9LxWRusOKMFUFVzDjiCQycKr0HOGK6ySlR9yOzxYjJafrmMwUD+YxZtI6ey2z5fs+oSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928191; c=relaxed/simple;
	bh=+Hgot9mCszq9rkwkXCHwpnTcuuQ1rFaolx0bqd0P9X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MheAqiDlo5/D2yplzNkYDBpmJpIOkrHx+BwOUbt3LaPt+SZuFlwITEHSJbQgRzfxg2JHgWTd4DyzNVjzpL1gbvHgY5rbjxwMXUTmrGIQC8O5xRSNmfFZR7sAyY3x4EuWPZr57tLOQXPPA4lNzh4zkiS0+Jr1JHwVSEW4UTQvEl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hadR5BUK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso92965e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707928188; x=1708532988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vG7i4rTv5dN/K3IttStABw6h9ZHaBPfu/H1rnYVvfSA=;
        b=hadR5BUKXLBkhKI8OX07ovgNpr32r+hB/Se57CQRP3PP+G23vXrWyxeMeof3/ua52i
         6Hz0HmFzVAN5WRvj9acVyByQCocUFhTEVndTcUhQYmCLNOWkzsdr9w3OhMw4EhoY+UM6
         7J9xjTTUCfvxCeFbPMsL4QqFqsyb+1Vd0KYPw5TTTPseKKzPbO99yx/rlyufmnlPbMMR
         cYwNELss5l8mej/LU8+wV8Pl8ySZ6wUCdJAOdQnC5hFXtdVBZJqTDBYK1/qoJmFh1nUv
         f5/vCPiB2pwWTnoDpr2sHV2scAVQmOhUnOlZt56CQ4sDhAb+KzBxu2UEtWtJvnWQ31hu
         dDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707928188; x=1708532988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vG7i4rTv5dN/K3IttStABw6h9ZHaBPfu/H1rnYVvfSA=;
        b=BE+NrAk4zuTmQurrQC3NuHCE02MVOCVxQsMAUeDt7sQPvepfylJi3GHnkUdkLhPNlf
         AnzsDDU74e9mJDk5b4mPtP2NepB8MI8SQNZOL/A2hK87JUrlN3FHDeuThawg8/ux4caE
         TTcSCDLoZ2gpMUsm5SEcEARCk6XUe5lLx+WVotCXpkeSHdXgkMESzhS1LW2oZlbkDcOe
         ioRTlgmNmbg/4h8o5M6XaY5ySXZ3mS28K6Hzb4qwvCCR8efYtCK16S52LJu19QyzpQIy
         3Fs2f5Vb0lmvsXthc6jN+EWlRrLtzNyc6gzfNFcq9PeKV1hrbpQSzPuXioMIrQSsZVGB
         6TTA==
X-Forwarded-Encrypted: i=1; AJvYcCXwJ1qakCU+awmhg2JHGwXFRmulbzdZVhYXOYOmwBQU+x2dZwvO8sY39pZjtNRL8wk33tsw0Dga04BJE0zfSgqh5fcyVK0pQ9CTvxHO
X-Gm-Message-State: AOJu0YyaZjNMiFGqnq4WJtGCxPW6PcUIjCp2OyZEXQunKJjAt6mFtcZ1
	ghzvbaAeNW/mfJAdSW5klFdfWKsOet4xgKHgjRZq99XkYT2MACIRMHQTtruGgQ==
X-Google-Smtp-Source: AGHT+IEfoGVEcSkXcvHm9vOSlr8zdWFY2LiFK/ZqzUsRqAzqSErJ5TjzXMSPE5rGzs06KCKoPTgvzg==
X-Received: by 2002:a05:600c:519b:b0:411:e5c1:9b2a with SMTP id fa27-20020a05600c519b00b00411e5c19b2amr166293wmb.2.1707928187624;
        Wed, 14 Feb 2024 08:29:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTndGOWllW29C9NCd6GB5W+GrXhfNKAS8hQ9ZMrGGufMYE0N0LcmrQqDdtFfrmT/CQmeC/ieRIBChaF/mS2ijPZEw10gGsdJpn1gd5kJ69gwGvog55s7r5Gl/IfVntFj+cGu3+V24FlEIIrzZ/C//5OZEEbduhMedb+DMQPnsXVuifDYpWbdcW6DKM6hK9rVVp6USakKw/rh9fkIWtFOe30xtca25+9QBCXzgeLq4pG1ldhq8hBPX2bXmxqEA3Bx2OTpw+CP8NIHcvg5BMN9Dz/jrI++2ml8mo5l63AzoZCn/aaWNtekd5WYyGk484sjRm0tbdMcLLjfK7lfbj6WZgOgEwF5gXHCNpAlKJnsUeVEERaAu+BIW3DcB9+yrqeeCJpJ55MARx9J8rjH4amn8edwIYiyGQbZLpa0auY2SjrE8RMesK+4njl2cEicQfsO03AzO+xPZyT0g7bXbgL6FtA6dM8nRkdCoSQFdgo2JlbG3MKL9tUSelDUjiKjyWH3lCMDr2Pg3NM02TCV28F7dx8ZUenim87Bt95w==
Received: from google.com (161.126.77.34.bc.googleusercontent.com. [34.77.126.161])
        by smtp.gmail.com with ESMTPSA id cl3-20020a5d5f03000000b0033b7ce8b496sm10424662wrb.108.2024.02.14.08.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:29:47 -0800 (PST)
Date: Wed, 14 Feb 2024 16:29:45 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, rananta@google.com,
	ricarkol@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com
Subject: Re: [PATCH v5 4/4] KVM: arm64: Initialize the ptdump parser with
 stage-2 attributes
Message-ID: <ZczqeTEOVVcRPNi3@google.com>
References: <20240207144832.1017815-2-sebastianene@google.com>
 <20240207144832.1017815-6-sebastianene@google.com>
 <Zcq7AoII8qLWwjsu@linux.dev>
 <Zcuf1ZUvwhxBobuG@google.com>
 <ZcuihokcWA3q-pZS@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcuihokcWA3q-pZS@linux.dev>

On Tue, Feb 13, 2024 at 05:10:30PM +0000, Oliver Upton wrote:
> On Tue, Feb 13, 2024 at 04:59:01PM +0000, Sebastian Ene wrote:
> > On Tue, Feb 13, 2024 at 12:42:42AM +0000, Oliver Upton wrote:
> > > On Wed, Feb 07, 2024 at 02:48:33PM +0000, Sebastian Ene wrote:
> 
> [...]
> 
> > > > +
> > > > +	snprintf(marker_msg, MARKER_MSG_LEN, "IPA bits %2u start lvl %1d",
> > > > +		 pgtable->ia_bits, pgtable->start_level);
> > > > +
> > > > +	ipa_addr_marker[0].name = marker_msg;
> > > 
> > > Is the dynamic name worth the added complexity? I see nothing wrong with
> > > exposing additional debugfs files for simple attributes like the IPA
> > > range and page table levels.
> > > 
> > > I know it isn't *that* much, just looking for every opportunity to
> > > simplify further.
> > > 
> > 
> > We can keep them separate, I have no strong opinion about this. I think
> > this was Vincent's, original suggestion to have them so I will check with
> > him as well.
> 
> Well, if we get to the place where there's a single struct containing
> all of the required data upfront then this becomes less of an issue.
> This is useful information still, so let's see if we can go about it the
> other way.
> 

Allright, I will create separate entries for getting the ipa_space and the start
level which will be exposed in the vm debugfs dir.

> > > > +	ret = kvm_ptdump_parser_init(&parser_state, mmu->pgt, m);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > 
> > > Can this be done at open(), or am I missing something?
> > > 
> > 
> > I guess we can do this in open() but then we will have to add again that
> > struct that wraps some ptdump specific state tracking. It seemed a bit cleaner in
> > this way. What do you think ?
> 
> Allocating something that looks like an iterator end embedding it in
> ->private isn't too uncommon.
> 

Ack, will stick to this approach in this case.

> > > >  	write_lock(&guest_kvm->mmu_lock);
> > > >  	ret = kvm_ptdump_show_common(m, mmu->pgt, &parser_state);
> > > >  	write_unlock(&guest_kvm->mmu_lock);
> > > >  
> > > > +	kvm_ptdump_parser_teardown(&parser_state);
> > > 
> > > Same question here, can this happen at close()? I guess you'll need a
> > > struct to encapsulate pg_state and a pointer to the VM at least.
> > >
> > 
> > Right, I tried to avoid using a separate struct as we discussed in v4.
> 
> Sorry, I hope I didn't confuse you in my prior feedback.
> 
> What I had issue with was the multiple layers of function ptr / ops
> structs for managing the file interface. I have zero concerns with
> organizing the _data_ for the walk this way.
>

Right, I see what you mean, thanks for the clarification.

> > > Actually, come to think of it, if you embed all of the data you need for
> > > the walker into a structure you can just do a single allocation for it
> > > upfront.
> 
> -- 
> Thanks,
> Oliver

Thanks for the feedback,
Seb

