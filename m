Return-Path: <linux-kernel+bounces-43888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A77841A67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698A41C219DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25876376F7;
	Tue, 30 Jan 2024 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="bQxv+0Nd"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EB944364
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584783; cv=none; b=Wk/ZlCgQW8WOn/vMCm/T/QlJaYeUCS9VLelxrF4uSZzsvcdTpKl/f2QZkmkugGqPnCiMBPHYZ5oiIb+QW4akub7kqAtF29FXqbMDdgg6jQVS3J06II34fcY3liq0dfSIUh+8dxzHTq89+ziDbIkHfhnJHuVcamuiDuRjTlJ/DO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584783; c=relaxed/simple;
	bh=xu8bS73WL64T/uCUK9ybQA3+ldl7TujgshbkdB9KNOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWWLL1b2pxRsQk7JAlBl2p2XvdItOzKIHR6ChePLMRMINLf/O6mR9+HCDUN3BoivK3k1Py1pj+uZBvF5D6yzCaQswrxLQ+jSdNxXSDtjkMXn9Mpgidt/jlXuT/Hwsdkl2MRrkNS5RTOU7MsThzGeCqtwmL0j9PQ3aoNvDKJLZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=bQxv+0Nd; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42ab7522c75so985661cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706584780; x=1707189580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdNltEfvc6hS96Sm8FriYdAybrLE7K4oc53Dd6d5CEA=;
        b=bQxv+0NdHLglvxJUv9eIqFhXbVWX/tSDbeDU0WaCpFhvot941Sw7RpGbEa2H/kyPfY
         zXsMPT+3CUPQreSfoOnAE7Q0Y+VYzVbjbW2H198l4Q4NtdIUdzxsb+71JRfp/pcGBuhA
         7i64RP0TdKDSsD8AMKThnuP8gHFXpaGyUSg89v8Zm9hMmGVzQNE99bL8K3tsc+dl6YAf
         ckSves7NsDDj5C3x1uvaqYHDbMPLpx7VnR50gdgdbrnFMl2LNibY5dKvD9EwYvIyTKPs
         /o3wwpRbE42YtYqrp3S61co82Le07JXMqad1eDPVZUu8+CFyJLqlCOzzVwiJxwyXpfWt
         g2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584780; x=1707189580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdNltEfvc6hS96Sm8FriYdAybrLE7K4oc53Dd6d5CEA=;
        b=qWRmRsFZJfyLGu5E+XLlQ8t9xj21E+aTPdvJOt00xu01bkWMcGF0jsfBIlkNCxNRQ7
         G//oYgfgf7m7hdAnq75iSIwyt5FUschG5KnNcjS/8PJh+/m/fZTrXc31LZ4aA3uS4X3j
         83XJfh/dhREimjs28VAUn9giXyu7eXRv0XUs+JZ/yGnS1J4vmklgK4l2B9h4ujupHEds
         h+MUSfpWYqE6Jz+i9D3onwbaDUIe/UXinME0I5Y9H8p38rk7KA5JjEP2j2Y1niSbN+h4
         MG2Z+nHs2woU9eJopY2zN1vnav4S444jAPZD/0GPEy1IkTAaSdhvU9KIgxc4b2XOel52
         0MuQ==
X-Gm-Message-State: AOJu0Yy0CsNuT1vbK6jdrw9NaIZXg0Dyd7IxSXIYTxKAYiOw7MLCwDyM
	kQ9va/D3QhC3LWWqzqJgt6LAuxBGijqAM8CNlaZsKNSPrIAlztShdi9kW3VEs+I=
X-Google-Smtp-Source: AGHT+IEp11DmXSRvvRbGY7Eyv1n2THY0n8sBn20stFRADb8dLmCoEVEUvnNwIx2UxPtZH5FWRcwidw==
X-Received: by 2002:a05:622a:5ce:b0:42a:7d81:2f2d with SMTP id d14-20020a05622a05ce00b0042a7d812f2dmr8649588qtb.86.1706584780239;
        Mon, 29 Jan 2024 19:19:40 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ge10-20020a05622a5c8a00b0042998676bc3sm3447924qtb.43.2024.01.29.19.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 19:19:39 -0800 (PST)
Date: Mon, 29 Jan 2024 22:19:38 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/20] mm: zswap: rename zswap_free_entry to
 zswap_entry_free
Message-ID: <20240130031938.GA772725@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-2-hannes@cmpxchg.org>
 <eceb2dc5-f13b-4c54-b2dd-0e4a199c1280@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eceb2dc5-f13b-4c54-b2dd-0e4a199c1280@bytedance.com>

On Tue, Jan 30, 2024 at 11:13:16AM +0800, Chengming Zhou wrote:
> On 2024/1/30 09:36, Johannes Weiner wrote:
> > There is a zswap_entry_ namespace with multiple functions already.
> 
> Another is zswap_invalidate_entry(), maybe zswap_entry_invalidate is better.

You're right.

I originally had a patch for that, but then dropped it because it is
sort of also a tree operation and it looked a bit weird to me.

But I could be persuaded to include it again, no strong preferences
either way.

Thanks

