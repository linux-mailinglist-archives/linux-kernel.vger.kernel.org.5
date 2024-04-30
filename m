Return-Path: <linux-kernel+bounces-164410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507798B7D57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007BC285DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1A17994C;
	Tue, 30 Apr 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqE6EtVn"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039A140E3D;
	Tue, 30 Apr 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495454; cv=none; b=G5GvWyI1mku9oFA4sK+u2Vphf+v8WjAQbuk5bp1D6hWtCMHsz1cTDZGtvHvhDPnAIEgd/3YOmv7J1GBTXbExSJ8QKky3tWoO3wrFC5KIwtmY3ujjdgHlnpodh+FdIaBy4oO68rXqh18ZYMb4XWdNxC+BSwoIj8qI9jqEwj+wKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495454; c=relaxed/simple;
	bh=G9vB1nooIxRswEOIKbMpLoq04GPEEua4LmPf5f5poJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMCKdoCeia2cvtbvsGaSqf0wQunhSBzkcaDlAbuYns+umVPxu1548mr3HgNBqWwJWvhTn3pWERpuLaAt1qXdyU+6lSf3BpVrZicFA2dGAXuCRcfmldGpujJEdrYVIKu7b2e8GpWzMsSf3x1up29JQ50k7Q4vNyLR3TM6wEP8bvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqE6EtVn; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23cd15209fdso999371fac.3;
        Tue, 30 Apr 2024 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714495452; x=1715100252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vBEjO+9pc+arsf9+tmcwdln2e/QvSzJgkokolEz1odM=;
        b=XqE6EtVnc9N6oKPWmAXF3ToyEr8AnukNh5PjzSYC/LLpupDwFPFcOtV68+UmgHbmJX
         bn6SGv66YjgFjwFYm1JfDiAs8sl/HWa6Mz6YZOe2ACCm9U+AFb5yg2+YpfgU4d30m6yz
         tSGtiQRKkxiB4Giel3hh+Jq0uVGDnkB0aMvNyCzrttvI3CPSzodQSgiYmNwmkAMcr+Dq
         M/HiDzQAiMzpfHTlU30tiACuTUKvc+UzEm9LPxI85pKOz6S6umg+sWkmZcG0nOXEnykk
         aL1vtCXENj6IyugYsfmFaBmZP5Eqd5vToixOBfQGL1O5MqBfzz0DGiMxnOnzMjeLFQuk
         zwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714495452; x=1715100252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBEjO+9pc+arsf9+tmcwdln2e/QvSzJgkokolEz1odM=;
        b=v1I2cxeRshcm94E25Qhd3UlNrnG7HeBYeSvKtJ+mM/QxPGXGuUeiq0ztXo89Yz+33F
         nsKaz4GBAv6HLAPddLsudialLy6Yeeu253Z33bgoEZAnDRGKyoN8m5WNzltIKswfJOXG
         +CO42cBeu54LGFVbPyDMzObwOEgHmSb/R9yeekKawoagco9XupLq1QeRiCko16DAhBpR
         CQyuRLh9AnZVT5tAZ727fY/zilOuERRprBXlvQU/qpwmOxk2kjPRvkP1F/uzv2R9Fs1J
         GUs7MJiFAyzQ48jx+9PCx8x0uoUqxHdUhghUOfaL8i2NU0/JfGszIj4D/sHX7BhoCmyc
         LO2g==
X-Forwarded-Encrypted: i=1; AJvYcCWw+x8c3oob+awfY0AEUEAlOyEXzeWrXYQusI5bNl86sx/Nj0R3WG12MBRVJKeJupNDHXWpRZo3st5GVpmEFBdbHEHfQqMnhnr8BGN7H0rzf/Preh1mHr03qzsHSbKmmZVWKIWuFo0KGel6
X-Gm-Message-State: AOJu0YyyYy5F5bjHWm+5p2p1DddMaUoEI+2uEsYZdbu+54lF1lRyoEsh
	HJ+quTDaSDW7+iDUdy85W6doETNDHYK6MQFSc55ql8H2GvALAi2D
X-Google-Smtp-Source: AGHT+IHv2F/hzutPBzYM+gPFXcC4JCjCJxx4QTQ7ZS06VquCVpD8MZ/eO0GSNHNxgetHSPrCPBo0gA==
X-Received: by 2002:a05:6870:58c:b0:23c:e21:ae78 with SMTP id m12-20020a056870058c00b0023c0e21ae78mr11786478oap.46.1714495452066;
        Tue, 30 Apr 2024 09:44:12 -0700 (PDT)
Received: from hercules ([68.69.165.4])
        by smtp.gmail.com with ESMTPSA id n66-20020a632745000000b0060fc94219b0sm6249719pgn.45.2024.04.30.09.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:44:11 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:44:09 -0600
From: Aaron Toponce <aaron.toponce@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: add chacha8_block and swtich the rng to it
Message-ID: <ZjEf2VV4igcCtkRE@hercules>
References: <20240429134942.2873253-1-aaron.toponce@gmail.com>
 <20240430031105.GA10165@sol.localdomain>
 <ZjB2ZjkebZyC7FZp@hercules>
 <20240430162632.GA1924352@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430162632.GA1924352@mit.edu>

On Tue, Apr 30, 2024 at 12:26:32PM -0400, Theodore Ts'o wrote:
> I'm not sure I see the point of trying to accelerate the Linux RNG.
> Sure, doing "dd if=/dev/urandom" is *fun*, but what's the real world
> use case where this actually matters?  The kernel RNG is meant for key
> generation, where a much larger safety margin is a good thing, and
> where absolute performance is generally not a big deal.

The goal is just to make the CSPRNG more efficient without sacrificing security.
Of course most reads will be small for cryptographic keys. ChaCha8 means even
those small reads will be 2.5x more efficient than ChaCha20. The dd(1) example
was just to demonstrate the efficiency, not to be "fun".

> I judge the risk that you are a shill sent by a nation-state security agency
> ala Jia Tan of xz infamy, trying to weaken Linux's RNG to be very low; 

Unlike Jia Tan, my name is not anonymous. I've been very public and transparent
about who I am, the software I work on, the security research I've participated
in, and the communities I involve myself in. I don't work for a nation state nor
am I interested in compromising the kernel RNG.

In fact, I work for a local ISP out of Salt Lake City, Utah where we provide a
web hosting product with KVM. We are very interested in a secure Linux stack as
our business depends on it.

You and I have also had email communication about the kernel RNG in the paste.
I've also interacted with Jason Donenfeld about the RNG and putting together a
document on the evolution of the RNG from 1.3.30 to current.

I'll ignore the attempeted ad hominem. I understand the uneasy feeling due to
the xz(1) backdoor and the kneejerk reactions to not trust anyone with proposals
that might seem radical.

-- 
 o .   o . o   . . o   o . .   . o .
 . o   . o o   o . o   . o o   . . o
o o o   . o .   . o o   o o .   o o o

