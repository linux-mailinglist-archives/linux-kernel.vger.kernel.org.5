Return-Path: <linux-kernel+bounces-124211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81BC8913EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF24B22A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A90520319;
	Fri, 29 Mar 2024 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LCldFd8y"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995992D602
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711695216; cv=none; b=O8Z8e0dQeyCH5rs/U4o7lFGREROc1e4mW4HjnWEgV7rdpje3y/wGqaOByxGaCCbJALD1BzbYungHN/1xrDlgftl5wr5EQYv1huWWNvN41Rs8eLZJ0CuB0CEA7l1RANTrtzQlEVXTGc/0YoDsDX7vrtiB7jVe/gWVVpuW5BapXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711695216; c=relaxed/simple;
	bh=wcXR61i87gB4ld+xFW+Urk6TWyhdRMxzkgOdBLrbUxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H70absrmm0i9e9L79GsRSdLXe4KAPi+JiHZ4A3c9zleweo5TZRm30vIsCbIgya/RrSOgCCcH0z4YB3QXQZo//I28BlTMu14E+IXJm6AiuhgaQTaYdS/55V1FvukRjttNeLMZVW/2xw2AbE2yOKrHVkcVboksvQflPtQn8DCgs8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LCldFd8y; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso218092466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711695213; x=1712300013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcXR61i87gB4ld+xFW+Urk6TWyhdRMxzkgOdBLrbUxI=;
        b=LCldFd8ytl2Qna87QTl1jDk1dOC+xx5aeNSmy1juv4QS76+Mw+SdoeK/Dl7uVyn/MW
         eDNMGjWH3ebSoCExgJwHlxp8WZWKrP/bXcPV9WS5b9VwwROBMSf3H/0g+pK7i9Zv6uoJ
         LXrvFI6FfMjmggJkyeli7xKJwX6cmlKC9NVNGIPGSr+83u6ap+P5sXVY0dFo5KXfpg8C
         E4v6e6WdlrQSABaUnFVMG3GdvvpezHJvHIDIA5FWqLjpV/lGPKdCQ7uajYAa/TqhC5Q/
         gcu3FZaC4q2kcdUL5Ba97pv8FnAQ7KaLtmUGm3z+o1cFAzImwbMn2NcTbznaG917zt5b
         pDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711695213; x=1712300013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcXR61i87gB4ld+xFW+Urk6TWyhdRMxzkgOdBLrbUxI=;
        b=qEz5ryBK4qEGUeHTRKSe/NsZ5j3AbY8HRHnpCcwzeevbEo9xFWcR74RdXcMoiSZf3t
         MYWs1oOxMyaWVJQJ+KHsJ7M3tBwI3WtxyV5awDntIJVTPMJ7zJBCyd3bDE0xNqO+ozXi
         dbYmjpGV1sbwWVvI8PiC78xlrdkO52Vy390Lz2+E0yGEGYUFACWaPgNZ4kv6V/5lyO2B
         dNve6GII3VYlizQ6dKSRls6hRoNDU8iZrFWN1ULOVB5OSI/af9Xr2KRgb4pp2MPiWAQp
         FlK60UcBUpl7qUJIBSUssIZz/z3Al/uc24D8I19dRNm5YyN8mTpqfazik7pMJyS2L2e2
         j2+A==
X-Forwarded-Encrypted: i=1; AJvYcCUQsH1XZvWVc4sVKgP9yVOn6WOahJbd0mYRvIDiEQtUDNV42AdCE2YE4NE0vVmj6g1dpzDEc9CySy+jwYmm6gWgmnd9n8js+86ZAlHi
X-Gm-Message-State: AOJu0YzsYVPvMcJNmZMMPSlojt3/A4N4hcKBHGyhI2XtM7T/pkAmvKta
	k+xP27t1GPHiS6dEWAlIB0+f7lNs30HgHpx6GKAUDTwamsctIs6ae904z7SO7l8=
X-Google-Smtp-Source: AGHT+IG0JFu+Ik/0xsYF2sKJvwQC8WMfDBELf60Gw3unUkzIdk7GlnrFb8mf7yF9RXSl1NDEz+Dw4Q==
X-Received: by 2002:a17:906:52d1:b0:a44:51c1:733c with SMTP id w17-20020a17090652d100b00a4451c1733cmr980442ejn.39.1711695213035;
        Thu, 28 Mar 2024 23:53:33 -0700 (PDT)
Received: from u94a ([2401:e180:8810:bf68:a132:2657:d239:3e12])
        by smtp.gmail.com with ESMTPSA id gq21-20020a170906e25500b00a4e373ff59dsm307019ejb.98.2024.03.28.23.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:53:32 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:53:18 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: ast@kernel.org, harishankar.vishwanathan@rutgers.edu, 
	sn624@cs.rutgers.edu, sn349@cs.rutgers.edu, m.shachnai@rutgers.edu, paul@isovalent.com, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH bpf-next] Fix latent unsoundness in and/or/xor value
 tracking
Message-ID: <7o5espvlmyttj74awibexz3q7dkvrerswgsn3x7vxesjxf5ggu@urrrltbmsqir>
References: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>
 <7s76qe3ucxiyjctbztrpuevwu4hxeogrm7bbarewjbu6bhsyfr@m4dkjap7hiyy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7s76qe3ucxiyjctbztrpuevwu4hxeogrm7bbarewjbu6bhsyfr@m4dkjap7hiyy>

On Fri, Mar 29, 2024 at 02:34:00PM +0800, Shung-Hsi Yu wrote:
> [...]
> Fixed: b03c9f9fdc37 ("bpf/verifier: track signed and unsigned min/max values")

Should have been

Fixes: b03c9f9fdc37 ("bpf/verifier: track signed and unsigned min/max values")

Sorry for the noise.

