Return-Path: <linux-kernel+bounces-153404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75F58ACDBA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B282827FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0E14EC7D;
	Mon, 22 Apr 2024 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZ+Lb0SE"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3748114A0B6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791061; cv=none; b=IZSSIynDfcmWz/NAu7nztjZTsTUo3rLzT1v5jgJ2KJkGnDILdRCRfEu89pfhewhZ/5wVwDP2JiDJP3qUeZadHHrFQYdLbVW1BPRY0ocsvRluiSjJOBdnp35gWmCvCt3Don+2Hf7J4k0jlFwYeTzdFdbMmt5YM9toStwLlXlI7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791061; c=relaxed/simple;
	bh=VbbA/s7KLCnQE7xa2XBEGfbJUh5YoqTO5XwvThu3xgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz2ptpErZASeaFjhYow8jpU81C9qeuzHWufVW82+BVHlNX69HcEW90P3JnGoaQYJk6cLKRbD96ZowNaozduAtlo0n6JO/lLovOG9gnPUn67f1t/vLV9nRCN9f0vIkj8Xn8pHkqV+2+Wh9WaN5nWx1doqSZylzVLBEIbQgPYDfQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hZ+Lb0SE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso5508029a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713791058; x=1714395858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iuMzujqDw2WAwNF9pTgdRvBBLCvmBGw54AkHaxIpYMI=;
        b=hZ+Lb0SE7tkQlz6u+OnS3zg9Oa4R8WUSVYTBZyrjcFMWdTsm4U2j9VdcfYnILYMCae
         G/SKkMNaRi9THp2Zs0rF4O47blFGMKVI4SXT9gc8ueY9kkf97IzkLFGIdEmLQ5o4QNmd
         I3anbaC8rpD7cBMzwLDHv51xy+Ki3AAYl8gddJhu81jIKVHLPj6GrwFgPp8YjHhFd7le
         Y27GaXTL5bbT9hz6AnqqYWWme87vqjQl50nbM5TvEKniVBJ9iVwFl7DtgP7ABpxXauqa
         iScMWPQDdCvs+of3V60zEOTa3+KrRUUMo/ERlpi3riuzs9WFjOSuFXKWieh4+uwNZ13K
         LfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713791058; x=1714395858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuMzujqDw2WAwNF9pTgdRvBBLCvmBGw54AkHaxIpYMI=;
        b=HgbO7VHEcEKOUGtEScqjkwh8eI6NLT7hsMJjAEaxj32KjkwWU1kIhepdl4SNcdcrO2
         kPH++Sgphcu0Xg9gysK2aOVkiJx0fWVji8WqE60ImaXN1XqWhf+Go4S9Iu9aeWac2fzZ
         cQCXQywldJ2j2oCsutn0kGw24tKuIekpuU7bEuEXc2ovh/Nf92aHFrDK3EMorrRLHiSa
         TmGEVQroow5ElJTsxSXj5//STektJ/B/+vO5Yi2Cse3BLQ7pqBqS908AIBDbNDC4LMek
         4V+crdvKOyhHfn2PYY6MpZtWBNWHZuSMuAySXq50pYYQfQUFj9PgjtMdoq5+w4vIYYAp
         JiFA==
X-Forwarded-Encrypted: i=1; AJvYcCWz7hm6BA2Zh28hYxleY00BN4UnFJIQ6GLSZdP3WU4pil+OtyWdKyY0ZQSSEGerw8XNnyHtUV+2AokdTh4pqCmNNx/MyR+ZYsuaIy3o
X-Gm-Message-State: AOJu0Yyr/fnKt8TVjrwHPWigCy0ISrvr+OSv/LUnGNtJoZkCcDtQqNa7
	zO/57FCLz9CcSXviTBdmHpBJuuW3r8j2HFJhiYd+a84ZqmNsvtDGB2WOKPldqI8=
X-Google-Smtp-Source: AGHT+IGAY3RPH2holTfD/QmJVlRaWK48fjTfI7XRh+HsNXpa4kzD5+b1fGhQBgzKyYCndtXlCIEmNw==
X-Received: by 2002:a17:906:1692:b0:a55:beab:cbed with SMTP id s18-20020a170906169200b00a55beabcbedmr1118197ejd.5.1713791058248;
        Mon, 22 Apr 2024 06:04:18 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm5738274ejt.94.2024.04.22.06.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:04:17 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:04:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net,v3] net: hams: Fix deadlock caused by unsafe-irq lock
 in sp_get()
Message-ID: <7d690606-7abe-42db-80d4-2ef979e8303b@moroto.mountain>
References: <20240419200453.13301f29@kernel.org>
 <20240420082102.63841-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420082102.63841-1-aha310510@gmail.com>

The ealier versions didn't build.  I feel like switching from _irqsave()
to _irq() was wrong but you just did it because you couldn't figure out
how to make _irqsave() compile...

On Sat, Apr 20, 2024 at 05:21:02PM +0900, Jeongjun Park wrote:
> After looking at this email and testing everything, I have confirmed
> that both patches are running without any problems in my environment,
> and the patchwork test outputs an unknown error in the patch
> in ap_get().

What does "the patchwork test outputs an unknown error in the patch in
ap_get()" mean?

> 
> But the patch for sp_get() is confirmed to have no problem,
> can you tell me more about the problem?
> 
> Thanks.

You say that it was tested but syzbot says that it doesn't have a
reproducer for this warning.

regards,
dan carpenter


