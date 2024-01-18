Return-Path: <linux-kernel+bounces-30222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31869831BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68F1285478
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90E31DA3B;
	Thu, 18 Jan 2024 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="JC5eM+Id"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20DA635
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589308; cv=none; b=gRvPzmpafRJKN0+TJJ0DSKqSCcL8a8/rBjdA0wAVhDfi0oCjOuXNxyZMrNVZfFpZSRJ+GXojigAQpjK0gjj5iyH+IX0bf5rLrZ/C573MOBKor1tQ7GrLaETm9EEmRZOMwBZooNae+IV+RkEH25zw4FwKGrIFuWgawzC/kVLdGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589308; c=relaxed/simple;
	bh=nWxZoXnqA+m1F8noLorBvRBbVwo3Ghzh5g/uhciY28M=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MfV6Ny6wEblINxz+gtimY5m/xer9ahYBZ1/XMKvYX5czet/NyCfsjYlTLISbsvejyBWWIuGQzFcY4e7MKOyvV5SnI0qH1EMZ4KqBYog3Kzr8LQCHHY8VxbhqPo7jPiVSP6poU1PpUhHjDOZ1vfAn/yvyIOj/ZeJ7GbcGgPj7YuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=JC5eM+Id; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78315243c11so858255485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705589304; x=1706194104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVxmjtoLbdX7EDdsXjVidtJhDNnF1SPUOgvPjPFVQ/I=;
        b=JC5eM+IdEFqp/QQyuKFN34vpDujVCLKPsdUzSJjHOp8HWybJE//p2V9mB9pB9okE04
         LZhAWy+6OjKPvWWEQS/a5UZ9gHreuv1a6AWyZCfPnPTtI2dtA7vi0+48t5m217wAXQj0
         +oRS7YJAtPOHwPmpk6mv0P0hXzT0UxNXRdHFOFAYK/eDUgQRIHPVMEjsg0GIg1Gu+hMh
         Ftk7neIj4tzi0pXEnMufMPcbchxpich5SCX9na/Hok/BS5d8lHwhrhFRxhzq59DBygMz
         RdusKzdY5OUsx5VquPMpb8G2Ycdi+r7+usqHX2O+iwY7eFxVuT5Smc7P/v/heLrrjI0v
         53Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705589304; x=1706194104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVxmjtoLbdX7EDdsXjVidtJhDNnF1SPUOgvPjPFVQ/I=;
        b=Py0yi5X4ZOcIyNgcWYjMecNKHQ07xIukMyVH6113Po2JfuncWQND+ryLEs9pS4FlWE
         01vy7toJbMYmQ4CKpNHFlFN19OfOg4fNDR20BK6Od6Y8ZtkxR+221Ra7SyhJY95fOeQp
         49xVcaGfVPgkLLGsYs8z1RCDsObUtEN1CbeY5HxAWvGcp4MuA5jvlkvl31wXG4riaWfR
         Z/4FZrhI1VtO2p0DFak8TpccRqhWdQXBxsa0+UmWdXcZC6u73B+xFfjQDkLiYSDnK0Uk
         W9GEpORBuRsmFgmE19yNUUv7cR5O6mGTes3ca+h2NTNQ/3ePRVTCNkjEmxpTBNmFXGhv
         CZZg==
X-Gm-Message-State: AOJu0Yy5RPwfPEZfonVZjIsFziNkfWVOouRnV0DGBwZ7CDdPjCuMt5Q0
	F1pnKDfZaQVuLv9XsBZ2gc+45YwTI+Z+QesAMAgyOjzvPaOaqeovebbRKaKEVS4=
X-Google-Smtp-Source: AGHT+IGajBJ36LmLjSs9/3yRFfq0ausFe3LXPKC7KV8Lu+uOJ5KX+HjVmDDJ/4m3FU3/212zX7RDlg==
X-Received: by 2002:a05:6214:5186:b0:681:7567:86ee with SMTP id kl6-20020a056214518600b00681756786eemr1017913qvb.71.1705589304433;
        Thu, 18 Jan 2024 06:48:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:e85f])
        by smtp.gmail.com with ESMTPSA id w20-20020a0562140b3400b006817d42eac6sm1361209qvj.53.2024.01.18.06.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 06:48:24 -0800 (PST)
Date: Thu, 18 Jan 2024 09:48:19 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Christopher Li <chrisl@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Wei =?utf-8?B?WHXvv7w=?= <weixugc@google.com>,
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Suren =?utf-8?B?QmFnaGRhc2FyeWFu77+8?= <surenb@google.com>,
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Huang Ying <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>,
	Kairui Song <kasong@tencent.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Barry Song <v-songbaohua@oppo.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
Message-ID: <20240118144819.GE939255@cmpxchg.org>
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
 <CANeU7Q=mphnSfiZRwFhqFTy56d2ifa5Pz-aa1h3O1PXUo_cu=Q@mail.gmail.com>
 <CAJD7tkaTZz9-rtYab+pvf31dprjMLstnHeXk6HZ_0C-8Np=06A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaTZz9-rtYab+pvf31dprjMLstnHeXk6HZ_0C-8Np=06A@mail.gmail.com>

On Wed, Jan 17, 2024 at 11:05:15PM -0800, Yosry Ahmed wrote:
> > I think it makes the review easier. The code adding and removing does
> > not have much overlap. Combining it to a single patch does not save
> > patch size. Having the assert check would be useful for some bisecting
> > to narrow down which step causing the problem. I am fine with squash
> > it to one patch as well.
> 
> I think having two patches is unnecessarily noisy, and we add some
> debug code in this patch that we remove in the next patch anyway.
> Let's see what others think, but personally I prefer a single patch.

+1

