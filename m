Return-Path: <linux-kernel+bounces-137670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6F89E5AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5838D1F22862
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A9B12B14F;
	Tue,  9 Apr 2024 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="hhR3SBhO"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822C13E404
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712702204; cv=none; b=fD/V0mObEUd/ji5rsOsFJ8rSkNj8NY+8mbdynM5bW7mZ4zyNHVEMF2tcsQPjXW3FBG48ClOP9G8zh+3s5L1MHqAy8z/Td3wRmG2CfixxK6E6eZVHUmgxoaSGcdpgeruOus33+qCqO3SnjrilspQ4CgAcUJxotvbO4H4ykFg1NHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712702204; c=relaxed/simple;
	bh=ekmWQXPMS1ofI798+g9KJMBbmIdCWYxH3WwE6dopHvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAjkcPHNJ5tVM6YCr5kRSVuiRbFNnJ6UfmupFpTs2HUu/ljTCLGk/f36VRPyrzuhe5jRBGKR68UUROR9NOJNCqmQqbMF9jjbUnhYtAlP+iyBHdzMT2n7npebIfTof6l/yglNG43nGdL2asyVZsCua0bDFtxB3JCRefjFZB5UqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=hhR3SBhO; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b236a942dso17540486d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 15:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1712702200; x=1713307000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=99sdplKohlye3r4EJyuRnGxNAU41Gs/6WufhBIEtHTM=;
        b=hhR3SBhOuInBI67Zbcf8kHQhQwMic8++0dwWcgpwh09Bv4/YjrA7cvpmDwfJ5fNggt
         Ez/1AIROqWwoWl84TsY+roSooLcZnXIfMoj/+ISX9/I1NVhzsLLXT8am6WxYB7oH6R4W
         M4EeWx1JpdSp3o43EzlDwg9xLD1eV517oaLOroMt76SRmgcVZE5hALRNyj1yTUH9OMmL
         draZq/syQmaLXPPytiUvOE73vB8syiCKx6iyj0kNC94e+Z1ICWz/m9ReASrh+jAUQF4a
         CLksDGT+UDzIKqyyIErgB+2t7xazcWAzP9crEH4PwZkkZw7dLZM1Kwuj6F+DK04gnSyn
         Mn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712702200; x=1713307000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99sdplKohlye3r4EJyuRnGxNAU41Gs/6WufhBIEtHTM=;
        b=U/zWXmqLLglY7kP//v7oReGrmo3p5OqeJ+bjEmk472G3ozg/tcYI8Y8Ns1fm4C6WVO
         hnaUGGaCP8+ko3pTGl+TObcL9A47ONqmegRZMv39a5F2Q2qQH1TzKOuYFNQKMyo9fDrv
         dABVGojsS+Kg2/AemOATTDD9d1vPNqnVJ2PWZ+SB4RzfSHOpXaNc9m7X+UvBhYVoWZgc
         syX5WdaBrzsng9YkPqPQ/RrfvE7sxGcAXQL6oaei3ILf9pnZ7f24xvpPS/AKUHeEUm90
         MAeA3ZxWNNT4PGth1RJmK03GxcOHVqEuouexjoe2oO0bQME3qTHQPvecAAabwQ4dSIYZ
         cfNw==
X-Forwarded-Encrypted: i=1; AJvYcCVrLXN8oxZGlYXWbCpz7AoNXz8oE682fI1I5QU6/aWayBdoJ7N5iHxFYzSxUaW643obp1RK5Jk+WTKWDlLibUyQ32xPVGMpBDiCq8T9
X-Gm-Message-State: AOJu0Yxin0avEq0rNfrDkHfw0NCodjKigKZVpjjmS4X5OZmUN4q502/z
	U9s3WJgW4gagW52wAZQ9W1DiQ6nUgLZBtkERwfQ9SfOEGxTPk+9g2ezGlcm3Thg=
X-Google-Smtp-Source: AGHT+IH3zjPIq/2rU2Q+QMQhrWtdTesHopSX764fJEFz7KNJ8EcquWTJaKtRksgWvIZKZKBshA04Eg==
X-Received: by 2002:a05:6214:5602:b0:699:45f3:d3a7 with SMTP id mg2-20020a056214560200b0069945f3d3a7mr6376509qvb.16.1712702200125;
        Tue, 09 Apr 2024 15:36:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6db8])
        by smtp.gmail.com with ESMTPSA id p24-20020a05620a057800b0078d6c4b0b3bsm1153406qkp.26.2024.04.09.15.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 15:36:39 -0700 (PDT)
Date: Tue, 9 Apr 2024 18:36:38 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: kernel test robot <lkp@intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, vbabka@suse.cz,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	akpm@linux-foundation.org, david@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mgorman@techsingularity.net, ying.huang@intel.com, ziy@nvidia.com
Subject: Re: [PATCH] mm: page_alloc: consolidate free page accounting fix 3
Message-ID: <20240409223638.GD1057805@cmpxchg.org>
References: <a2a48baca69f103aa431fd201f8a06e3b95e203d.1712648441.git.baolin.wang@linux.alibaba.com>
 <202404100519.mVXXF6kV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404100519.mVXXF6kV-lkp@intel.com>

On Wed, Apr 10, 2024 at 05:15:01AM +0800, kernel test robot wrote:
> Hi Baolin,
> 
> kernel test robot noticed the following build errors:
> 
> 
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20240409-154935/Johannes-Weiner/mm-page_alloc-remove-pcppage-migratetype-caching/20240321-020814
> base:   the 10th patch of https://lore.kernel.org/r/20240320180429.678181-11-hannes%40cmpxchg.org
> patch link:    https://lore.kernel.org/r/a2a48baca69f103aa431fd201f8a06e3b95e203d.1712648441.git.baolin.wang%40linux.alibaba.com
> patch subject: [PATCH] mm: page_alloc: consolidate free page accounting fix 3
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240410/202404100519.mVXXF6kV-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404100519.mVXXF6kV-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404100519.mVXXF6kV-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> mm/page_alloc.c:808:54: error: too few arguments to function call, expected 4, have 3
>      808 |                         account_freepages(zone, -(1 << order), migratetype);
>          |                         ~~~~~~~~~~~~~~~~~                                 ^
>    mm/page_alloc.c:645:20: note: 'account_freepages' declared here
>      645 | static inline void account_freepages(struct page *page, struct zone *zone,
>          |                    ^                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      646 |                                      int nr_pages, int migratetype)
>          |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 error generated.

Looks like a false alarm because the test bot didn't pick up the
fixlet to remove the page parameter from account_freepages():

https://lore.kernel.org/all/20240327185831.GB7597@cmpxchg.org/

It's right in Andrew's tree.

