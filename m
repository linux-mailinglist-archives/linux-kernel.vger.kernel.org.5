Return-Path: <linux-kernel+bounces-144523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F18A475F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DC31F21043
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579F31D53C;
	Mon, 15 Apr 2024 04:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P3ABdVV7"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEAD17547
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 04:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713154290; cv=none; b=XqqhyGxUSkhpgKXa9NLzMRvBc2u4QAOLgi2kj6tqw5aVIrIv5b2SryPZzQYEgysCJpMtdJ2G9514H8OcKVK90GKdByFVa7wKfm6H0z+wVzAIVfxyym7fo2anvj5JSMD4wvkdmGAIL+lzcvPGveSAPkKG1nDj2wlZw5qU3865cno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713154290; c=relaxed/simple;
	bh=gmT5t4FTIELSxuSJS0pdw1YZ2JjTGWs2mgeSWUwOzRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp8vNTTFD+kAmbLhjVYdCJqvgKlKpxFZLaKcNVoAu2ytC3nXi5WSCeoz9T071sDo9BWi57WZFq1yhppJWB88oSyak9xCTrWff/fZqx0/lJCYimk+V0mgzhBuD1pSdKPjTtLjvM04s+LjJoaKTZxLSyWuAzeTqXKGciGOiFu9U/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P3ABdVV7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4186dca2aa9so904415e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 21:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713154287; x=1713759087; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QiU6mOFJe7fZ7988jfCiI5R9Naxgg0XxvdFSn3F4lS0=;
        b=P3ABdVV7YSGOc0CMML0TPlyJiez3WhV1ofAaSgUejr7mYhT682dp/DXVk80mVtSIki
         6eJOBB28osCYC+YumCA4M5eMIKX83FHU66bPo8o9NrVlHQbzWdIkrhVRHKOnaJowHgoc
         lDtmqOBQN7NSAcwcpeA/fP6AGkGNvVwayCNsMWxTVKAiPqb8huMpMAA/R8/yhRwLshRw
         hn7+kFq91/OEwKIQoSy89VLEltZkdRxJ32P0Gw+rtM977Kltvbo9MqNHmeWnXHZlmKKZ
         7VfiUCeqeJWEYQtbvWghWVhrQM3BkZL+L8wcM/ZtdfJWtJO5YWI3gnHV+VrfwiTjCfQU
         V8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713154287; x=1713759087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiU6mOFJe7fZ7988jfCiI5R9Naxgg0XxvdFSn3F4lS0=;
        b=l7CD/mWhIAj1xW+q1VtRkXBjqUQY3X43fl1QzEsZJlErJzt3nb3HhkEqHj8OKsPXPv
         1rfx1lh87DYinaycwzPA3I7z7Ku4jS0l6DX7IAoo+oWRyROyH3RW7g647znGT9x9+A/B
         7ySsdaGLFeP6eBqrSzc43wq0QEVM8jwiMNQHowmoiz0RA2QCXNKHOvSuvF8cElCFsuHg
         1kCQVqT3EHryvqGreCZiL9pInpRuV0nq5zY0XVptcaN6vBBHvYrq7FOccELODE68YRj0
         hllWYNzoQxJbFOJg6+G86HNxJiABsPhqFNIbpnQEJJuGCdoZ4PIqVbIA8qN1CfZMsh6z
         t8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVDuGqrcirO6M0rrbd5xpApCk2nPJ3Eou9L9N6tKIgkU42+S7Q950pDRkgWhSWy8wWCM2qd6h0Ls/juVkjj5NVbU7BrdhYnJVQYuPcl
X-Gm-Message-State: AOJu0YzLtiMm7LfjnhpqSkdW7DWRM8RnhgL6e4hS3PuZ2YlLJcmfy1q6
	ri4/u6+puc/ph7F8H+nbUY7M0K7tmS2AjtjAPZoOwYsMCPfITfLjSWjtA1c2xCw=
X-Google-Smtp-Source: AGHT+IHOaXP139wfghHTAG+za3RhEN3s4Ldk4VPJSgeS0RjgUHz0oud9GU6g39LN7i5bjw0zN1imYQ==
X-Received: by 2002:a05:600c:314c:b0:417:e4ad:d809 with SMTP id h12-20020a05600c314c00b00417e4add809mr5885418wmo.25.1713154286738;
        Sun, 14 Apr 2024 21:11:26 -0700 (PDT)
Received: from u94a ([2401:e180:8880:b3f0:8218:d004:f133:6b08])
        by smtp.gmail.com with ESMTPSA id g4-20020adfa484000000b0034330c9eccasm10969876wrb.79.2024.04.14.21.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 21:11:26 -0700 (PDT)
Date: Mon, 15 Apr 2024 12:11:06 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Harishankar Vishwanathan <hv90@cs.rutgers.edu>
Cc: Edward Cree <ecree.xilinx@gmail.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Edward Cree <ecree@amd.com>, "ast@kernel.org" <ast@kernel.org>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>, "paul@isovalent.com" <paul@isovalent.com>, 
	Matan Shachnai <m.shachnai@rutgers.edu>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpf: Fix latent unsoundness in and/or/xor
 value tracking
Message-ID: <2m7bajdbjed3tp5dd2ft5wiecvufofq7sd2cdrjk547wgaooop@iwszxfoqaugk>
References: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com>
 <77f5c5ed-881e-c9a8-cfdb-200c322fb55d@amd.com>
 <CAM=Ch04xd5u75UFeQwVrzP7=A5KPAw3x7_drqQHK3C-43T4T2w@mail.gmail.com>
 <9d149d61-239c-67ac-0647-b59a12264299@gmail.com>
 <ogoballkzys66cu5mt22krntaswkau5bpnu7efs5x6uw7jdvng@drdai5ecq7d5>
 <C11E783B-50EB-40F4-A3CB-F9ED5B909B9B@cs.rutgers.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C11E783B-50EB-40F4-A3CB-F9ED5B909B9B@cs.rutgers.edu>

On Sat, Apr 13, 2024 at 12:05:18AM +0000, Harishankar Vishwanathan wrote:
> > On Apr 10, 2024, at 7:43 AM, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > On Tue, Apr 09, 2024 at 06:17:05PM +0100, Edward Cree wrote:
> >> I don't feel too strongly about it, and if you or Shung-Hsi still
> >> think, on reflection, that backporting is desirable, then go ahead
> >> and keep the Fixes: tag.
> >> But maybe tweak the description so someone doesn't see "latent
> >> unsoundness" and think they need to CVE and rush this patch out as
> >> a security thing; it's more like hardening.  *shrug*
> >
> > Unfortunately with Linux Kernel's current approach as a CVE Numbering
> > Authority I don't think this can be avoided. Patches with fixes tag will
> > almost certainly get a CVE number assigned (e.g. CVE-2024-26624[1][2]),
> > and we can only dispute[3] after such assignment happend for the CVE to
> > be rejected.
> 
> It seems the best option is to CC the patch to stable@vger.kernel.org (so
> that it will be backported), and not add the fixes tag (so that no CVE will
> be assigned). Does this seem reasonable? If yes, I’ll proceed with v3.
> I'll also mention that this is a hardening in the commit message.

Sounds good to me. Not 100% certain that this will avoid CVE assignment,
but does seems like the best option.

Shung-Hsi

