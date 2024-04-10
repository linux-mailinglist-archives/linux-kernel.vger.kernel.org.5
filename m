Return-Path: <linux-kernel+bounces-138427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E064989F113
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5291C22F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D63F2BAEC;
	Wed, 10 Apr 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KYNIafIf"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E567159909
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749443; cv=none; b=DveU/sko8IMwgnf3oIv7oPOYvHwGv6wjoNHtRUVn0eht4RYf8t22qwebkTSJFaaMEgIV38E3cX/6PIMwFMvJqLk8ekySyYy49APhzys8DG1XYy02/3qvAocNZLEXwaNuYzQxNt4esDOyJd0U+narzoMyxuFO6DVUdkLKgm+vs7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749443; c=relaxed/simple;
	bh=1W3oHWS8EZHgKe2N2jUl4Or194JGDOqy29IekKLCZUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU/wb8oKyaXYRleUkb5DZrboZ0Q6JQ84a5O1YgpZrTgoH1MoxYLMNLW1aKBdy9QMpmTJe0SEqo/Mz5MM3Mrh8eX8hYnuoEowjI6FScr9f8pe1k4EJXvsQFHkNEOGk0JAAeXUr9eWa0hakeT+iCY6l3903rTVzm95rwR6AKs6x3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KYNIafIf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41551639550so45928695e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712749440; x=1713354240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jkmHZc0pXR6BtgrKbSEN1SELtTPo2uZ3PAQ/N+1ESOI=;
        b=KYNIafIfbc3nVHjOxAAsgH94Rim64tQsXDsz8iF8i+nuDmXSsWVfDPyEgI/QhfU+OJ
         4lRP4JQ+HqpfPDmy7XHjn+ixIxn9+6yuBp0pXQPHAItZjMbyE5iLDPmhO+iZ0P6YpWBK
         p09C1EuljP/t6+7TG7bQIGZk71E+HERwWko9rQV1W3AROouAiFIFLwSfQEhlgasiIYhd
         zh17nFDm3Qu/eonzzM4LuTyRQ3QaYIJbuGMIoxpX52igrAFbbUq/wa3xYbiJc/rFLG+h
         SAVub1vKl0/28UtoRgYVmEbqhPdvJ8KpPkN65QsSFUWaBWEtsMuNTyYrUP+ETKAaixJ6
         lzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712749440; x=1713354240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkmHZc0pXR6BtgrKbSEN1SELtTPo2uZ3PAQ/N+1ESOI=;
        b=mtbLAWiH56KbxsGl7WsZRNMQqw2acmUDjdWqO7WGt+UT9IzYLJvmjo9h7SxRXspA7z
         dQweRMg34oylewLYMKe+nAC/0YPoPfTrG5ZULLzxs3aB9co+SzyDo61wM9Ag3eJdtc24
         is6QWlpl8ySkENwlfRgqfWhXPXbEwZnnWKzIoKHXF6lUX//sabNfMaR4dIyH7tth2hrS
         QvlrFsdqwMdgYPhe6Yu9Hg7By2liH29/shFOygbfHzmHEFqHN2xCMnTHOQUeY0YcjveN
         gt8Z9onOHH0byEqaV/0unrV8cCB53kqBF+hOI7jwMndERhbHTc72WLHMPg99m/qtFlCw
         qP/w==
X-Forwarded-Encrypted: i=1; AJvYcCVV7Ei520e7hSU3h4Iivvjh3R8WIbpcAnPy4tY2CgnuFCELlsPDM3hwbRecX5DkyhcSVS8KGi0t4tp4L+Swmm9UVsL8+ErsHOR3ddmI
X-Gm-Message-State: AOJu0YyLd0rmfsW/WZBoyy0pg8qFueK8EDBkysj5/yByzyGbdBHvu0vB
	4tKk4Xy1dmgayRYRslL3upU2DkJCDYjNXPYJCLjsNKejM3LVfbvfmc8TwhAP9Dk=
X-Google-Smtp-Source: AGHT+IF1cWnOijzkXw/T29WdvlG6JgneYSW1uLljAU8868cNC4uaDwT5xRBSa1k0Uk/y3K2VGgehzA==
X-Received: by 2002:a05:600c:310e:b0:416:2a3e:27dc with SMTP id g14-20020a05600c310e00b004162a3e27dcmr1954423wmo.24.1712749439940;
        Wed, 10 Apr 2024 04:43:59 -0700 (PDT)
Received: from u94a ([2401:e180:88b1:4156:66c8:d930:4ab7:c849])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b00416b28651e1sm2031889wmo.36.2024.04.10.04.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 04:43:59 -0700 (PDT)
Date: Wed, 10 Apr 2024 19:43:46 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Edward Cree <ecree@amd.com>, ast@kernel.org, harishankar.vishwanathan@rutgers.edu, 
	paul@isovalent.com, Matan Shachnai <m.shachnai@rutgers.edu>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next] bpf: Fix latent unsoundness in and/or/xor
 value tracking
Message-ID: <ogoballkzys66cu5mt22krntaswkau5bpnu7efs5x6uw7jdvng@drdai5ecq7d5>
References: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com>
 <77f5c5ed-881e-c9a8-cfdb-200c322fb55d@amd.com>
 <CAM=Ch04xd5u75UFeQwVrzP7=A5KPAw3x7_drqQHK3C-43T4T2w@mail.gmail.com>
 <9d149d61-239c-67ac-0647-b59a12264299@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d149d61-239c-67ac-0647-b59a12264299@gmail.com>

On Tue, Apr 09, 2024 at 06:17:05PM +0100, Edward Cree wrote:
> I don't feel too strongly about it, and if you or Shung-Hsi still
>  think, on reflection, that backporting is desirable, then go ahead
>  and keep the Fixes: tag.
> But maybe tweak the description so someone doesn't see "latent
>  unsoundness" and think they need to CVE and rush this patch out as
>  a security thing; it's more like hardening.  *shrug*

Unfortunately with Linux Kernel's current approach as a CVE Numbering
Authority I don't think this can be avoided. Patches with fixes tag will
almost certainly get a CVE number assigned (e.g. CVE-2024-26624[1][2]),
and we can only dispute[3] after such assignment happend for the CVE to
be rejected.

Shung-Hsi

1: https://lore.kernel.org/linux-cve-announce/2024030648-CVE-2024-26624-3032@gregkh/
2: https://lore.kernel.org/linux-cve-announce/2024032747-REJECTED-f2cf@gregkh/
3: https://docs.kernel.org/process/cve.html#disputes-of-assigned-cves

