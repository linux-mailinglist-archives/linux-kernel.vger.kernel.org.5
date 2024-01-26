Return-Path: <linux-kernel+bounces-40344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3617E83DECF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9D11F27FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4341DFE4;
	Fri, 26 Jan 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="iG3pWC+W"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1BB1DA32
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286862; cv=none; b=M9PoZ00ACYiGb7ACkkmTg1xGFErKc4kE6zScpSPsNZWnSL+wdQ77yooFXbW8SyVLUxfp775ern3ZoRDpck5NImBSaij+pKL9m4OGOSBpo8LBrciD5WsUndqc7gjomCdlyQ0KS15eO3OdzMJFYhwHkitnaGdfRKWf6/F3BSRMCtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286862; c=relaxed/simple;
	bh=017GdyE1IE2uKm0Y+x/yCoiXpG39BJE37eyLPVYEpnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lijjQupkUxH9yYRN6TxvEDC0J4zRRm475c4+zrpkyO+z6gfEeadBVs5qJ/E4XqpmYh6keVoX+/K7zaDuONH8NZ5JmLgg8XmMiaRotoSbV0cqSaquuB6FefgVVOCYK8k3fE1Zzvx1SP9fhm6Qb086p10UaWXSlKNNgoDXn8f1s9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=iG3pWC+W; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42989a64713so3569821cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706286858; x=1706891658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKRWQpKoDhVi11EbJncjcZq8dzTJ4ms1gdUVmVL1vMo=;
        b=iG3pWC+W+7NC04JDOnObeYobCnyM9DRLB24VDrbC+Pt70FMUeYFoGYjkHvhAvuRtL+
         IZziTrbWWuL5mnqhEAMPZq/nl+pLNwZubHhGumprMq5CnaGx/19DQKsTQRW5DObEN4YG
         Mh37uC2O1Xo+vgF3mIWIMTVAvp9uN7s45X3rfkA6Cf1Zfu5KhTsZxBzJs6QTLBYI7EZD
         bIkFiXYtuc/geI2CdHRQ5lwlFQGgB7SdqR39Qqi5OwEPSHNfu9l0jUbCaA6ANBusTsfW
         b2Nhhx3VjgRyJ8IrXB3bRu0Dp3BFLRzHKiiJaJ/6kdeYT4vTnyWrqgP32FmS+aD/n/KQ
         qDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706286858; x=1706891658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKRWQpKoDhVi11EbJncjcZq8dzTJ4ms1gdUVmVL1vMo=;
        b=N/nZfUj1OSPBsHhrvz1ca2onzkwu6YFo7eBLEUoOgdh2AZfK6wAHgtAY/LBfYyA9sy
         Nd17Rh3cVfZM1xz84uL1KBVQURAIxhEwtSNCUmCd3/zgtG6osxhPGmP6m9n3B430ifAM
         shIlb514REzuPaz+PbkH52lXqq/XxY9xXGUQPQkXD/Z8EDXtxNoWFmvrc60bnuK91Kr8
         Nf7YfkPpMRo39hbsoE5vFHvnRsm0rsc31ffqXhk9kgXo4VPo9fVpV0OVfUu3/hBHM45k
         AYauoACxeCrbw8DtfKC970+lEkC3WE7ApkbRri65nhfQ3dHGyMdBVdh7uh1wwziqGD7a
         t0dw==
X-Gm-Message-State: AOJu0Yye6laLVyanH0Wf7QFygZN1PQyrPrnXVuQA+zJZ4acu6T8fr/8O
	rgk2Gpf2MvQcq4+/8wQEeDA/Ci2AEzaIYQPDY1BwIq66+8tHHazDaqjqFTHAoYw=
X-Google-Smtp-Source: AGHT+IGUR0dOLRsatsRzJjXg2S4qZHwNs1TSu/FR2bKyi/XH0DHAoB6rSk6mIGDhkpJJg+zzwH+lTA==
X-Received: by 2002:ac8:5710:0:b0:42a:504b:67ac with SMTP id 16-20020ac85710000000b0042a504b67acmr107263qtw.68.1706286858505;
        Fri, 26 Jan 2024 08:34:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:271e])
        by smtp.gmail.com with ESMTPSA id hh10-20020a05622a618a00b00428346b88bfsm640126qtb.65.2024.01.26.08.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 08:34:17 -0800 (PST)
Date: Fri, 26 Jan 2024 11:34:01 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com,
	yuzhao@google.com, yangyifei03@kuaishou.com,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
Message-ID: <20240126163401.GJ1567330@cmpxchg.org>
References: <20240121214413.833776-1-tjmercier@google.com>
 <Za-H8NNW9bL-I4gj@tiehlicka>
 <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com>
 <20240123164819.GB1745986@cmpxchg.org>
 <CABdmKX1uDsnFSG2YCyToZHD2R+A9Vr=SKeLgSqPocUgWd16+XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX1uDsnFSG2YCyToZHD2R+A9Vr=SKeLgSqPocUgWd16+XA@mail.gmail.com>

On Wed, Jan 24, 2024 at 09:46:23AM -0800, T.J. Mercier wrote:
> In the meantime, instead of a revert how about changing the batch size
> geometrically instead of the SWAP_CLUSTER_MAX constant:
> 
>                 reclaimed = try_to_free_mem_cgroup_pages(memcg,
> -                                       min(nr_to_reclaim -
> nr_reclaimed, SWAP_CLUSTER_MAX),
> +                                       (nr_to_reclaim - nr_reclaimed)/2,
>                                         GFP_KERNEL, reclaim_options);
> 
> I think that should address the overreclaim concern (it was mentioned
> that the upper bound of overreclaim was 2 * request), and this should
> also increase the reclaim rate for root reclaim with MGLRU closer to
> what it was before.

Hahaha. Would /4 work for you?

I genuinely think the idea is worth a shot. /4 would give us a bit
more margin for error, since the bailout/fairness cutoffs have changed
back and forth over time. And it should still give you a reasonable
convergence on MGLRU.

try_to_free_reclaim_pages() already does max(nr_to_reclaim,
SWAP_CLUSTER_MAX) which will avoid the painful final approach loops
the integer division would produce on its own.

Please add a comment mentioning the compromise between the two reclaim
implementations though.

