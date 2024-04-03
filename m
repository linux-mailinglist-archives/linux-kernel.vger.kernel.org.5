Return-Path: <linux-kernel+bounces-130250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100928975EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15FB2B28C12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18820152527;
	Wed,  3 Apr 2024 17:06:23 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3236152506
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163982; cv=none; b=gZxkq5uxurk+3UbriOXG1RGoEkN1eB/MSI7uYAmjcWggBBj2mxkiLwZVLdAujhABh/yLi/FswBCtyliPSYqqBwdJ1Oauwb4zGqnNsIquiBRq0MwgIHt/w6reY6jwMXDKLzCv4YXrD/7CPZic5sMUzYJS7O47BUJhDfP5VFM+wZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163982; c=relaxed/simple;
	bh=qEkqhTYZBeZMIo679GxKV0q/1U6lMpuBFaZXFWCTn9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCAqVAYwuaeeIaSPdL9B5OzD3jqbsF0gHH2zck4YKhH/gYqhZCz1WoXYT14YFUjgXYhRjg0Fl4BmQrU6uS0Q9d4dUUBMJtAy9vVKy6yqoLOqTN0+YQAqLFl4DYGGIkKKW3KbzMZ1haTKwYlC8gM/6KAXlZiDliBn4TmHcl2SS5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d33e20cbfso3191085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163980; x=1712768780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDjpkau67SMrTngM+gKSIs1aeMAzFg6hSQJLXCLbDQE=;
        b=rtk7T4XTA8xDnVOSet2/IhyVKUC2Q/dOUlLJASQ+yBbThq4HcqkJU2NsnRLReGl51t
         Nq9H5WYYurnWIPzbADENhSOympmPpOe+jiJZesA0h1yCpZJJVEknYF47QWMcWto5exRV
         chlYCvjJJZ9oXl9XXB0kPrmjadcOWk26/TjurkBLKO6GHog0Dnr3kFbQaK4yRp8oIc9l
         7S9YPhFxseXp9moPtrgCO3WQJxcaKl3jzy6WiY/Yu7+pGDSa4zXAVgBBRtahtNU2FWxY
         kLhrJNIAalSFetkt89PSFcxqGV7eXNRx1s2Nfdn8PJUdTBPX7x7r+c+ACFVq6Bwi52ge
         6iUw==
X-Forwarded-Encrypted: i=1; AJvYcCW43CT7sk/NJSbjXPvKVRA+QO95uOe3Ktj/x+UmcfqsGcczoXf1K/hKehSwi5K+GEFEmzk3PjPAYLWO7EALggwpgfX/VqeZeo7WH3ec
X-Gm-Message-State: AOJu0YwiUNYOGoCd8EAt4Jy8M6F5iC7rN9Nr3NcM0DffMuuhEPwt+nRX
	tt2cgUj7ITTraDEuyaFev+uTm4SJtTH5T0hxjXnZyB9VzMzAXfFHKa4X++Fw0g==
X-Google-Smtp-Source: AGHT+IGeOn4A+YeQJsZOd4gYvjHH/LHMhzDJf5qPz5YLq6UjLZggV9SMRGip5xuusW9cXVH4r17sOw==
X-Received: by 2002:a05:620a:8804:b0:78b:c3f6:6459 with SMTP id qj4-20020a05620a880400b0078bc3f66459mr37761qkn.3.1712163979775;
        Wed, 03 Apr 2024 10:06:19 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id bl2-20020a05620a1a8200b0078d39480ab1sm545985qkb.48.2024.04.03.10.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 10:06:19 -0700 (PDT)
Date: Wed, 3 Apr 2024 13:06:17 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Matthew Sakai <msakai@redhat.com>, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, dm-devel@list.linux.dev
Subject: Re: drivers/md/dm-vdo/data-vio.c:969:2-8: preceding lock on line 966
 (fwd)
Message-ID: <Zg2MiSlrQ9zTna6q@redhat.com>
References: <801d737e-f7c0-b853-d7e-63eb68c7fd7b@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801d737e-f7c0-b853-d7e-63eb68c7fd7b@inria.fr>

On Wed, Apr 03 2024 at 12:47P -0400,
Julia Lawall <julia.lawall@inria.fr> wrote:

> Hello,
> 
> Please check whether the lock should be released before the returns.
> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Wed, 3 Apr 2024 22:16:44 +0800
> From: kernel test robot <lkp@intel.com>
> To: oe-kbuild@lists.linux.dev
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
> Subject: drivers/md/dm-vdo/data-vio.c:969:2-8: preceding lock on line 966
> 
> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> CC: linux-kernel@vger.kernel.org
> TO: Mike Snitzer <snitzer@kernel.org>
> CC: Matthew Sakai <msakai@redhat.com>
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3e92c1e6cd876754b64d1998ec0a01800ed954a6
> commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
> date:   6 weeks ago
> :::::: branch date: 11 hours ago
> :::::: commit date: 6 weeks ago
> config: s390-randconfig-r052-20240403 (https://download.01.org/0day-ci/archive/20240403/202404032212.NV7EJ2Zj-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 13.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Julia Lawall <julia.lawall@inria.fr>
> | Closes: https://lore.kernel.org/r/202404032212.NV7EJ2Zj-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
> >> drivers/md/dm-vdo/data-vio.c:969:2-8: preceding lock on line 966
>    drivers/md/dm-vdo/data-vio.c:972:2-8: preceding lock on line 966
> 
> vim +969 drivers/md/dm-vdo/data-vio.c
> 
> 79535a7881c0cb Matthew Sakai 2023-11-16  952
> 79535a7881c0cb Matthew Sakai 2023-11-16  953  /**
> 79535a7881c0cb Matthew Sakai 2023-11-16  954   * vdo_launch_bio() - Acquire a data_vio from the pool, assign the bio to it, and launch it.
> 79535a7881c0cb Matthew Sakai 2023-11-16  955   *
> 79535a7881c0cb Matthew Sakai 2023-11-16  956   * This will block if data_vios or discard permits are not available.
> 79535a7881c0cb Matthew Sakai 2023-11-16  957   */
> 79535a7881c0cb Matthew Sakai 2023-11-16  958  void vdo_launch_bio(struct data_vio_pool *pool, struct bio *bio)
> 79535a7881c0cb Matthew Sakai 2023-11-16  959  {
> 79535a7881c0cb Matthew Sakai 2023-11-16  960  	struct data_vio *data_vio;
> 79535a7881c0cb Matthew Sakai 2023-11-16  961
> 79535a7881c0cb Matthew Sakai 2023-11-16  962  	ASSERT_LOG_ONLY(!vdo_is_state_quiescent(&pool->state),
> 79535a7881c0cb Matthew Sakai 2023-11-16  963  			"data_vio_pool not quiescent on acquire");
> 79535a7881c0cb Matthew Sakai 2023-11-16  964
> 79535a7881c0cb Matthew Sakai 2023-11-16  965  	bio->bi_private = (void *) jiffies;
> 79535a7881c0cb Matthew Sakai 2023-11-16 @966  	spin_lock(&pool->lock);
> 79535a7881c0cb Matthew Sakai 2023-11-16  967  	if ((bio_op(bio) == REQ_OP_DISCARD) &&
> 79535a7881c0cb Matthew Sakai 2023-11-16  968  	    !acquire_permit(&pool->discard_limiter, bio))
> 79535a7881c0cb Matthew Sakai 2023-11-16 @969  		return;
> 79535a7881c0cb Matthew Sakai 2023-11-16  970
> 79535a7881c0cb Matthew Sakai 2023-11-16  971  	if (!acquire_permit(&pool->limiter, bio))
> 79535a7881c0cb Matthew Sakai 2023-11-16  972  		return;
> 79535a7881c0cb Matthew Sakai 2023-11-16  973
> 79535a7881c0cb Matthew Sakai 2023-11-16  974  	data_vio = get_available_data_vio(pool);
> 79535a7881c0cb Matthew Sakai 2023-11-16  975  	spin_unlock(&pool->lock);
> 79535a7881c0cb Matthew Sakai 2023-11-16  976  	launch_bio(pool->completion.vdo, data_vio, bio);
> 79535a7881c0cb Matthew Sakai 2023-11-16  977  }
> 79535a7881c0cb Matthew Sakai 2023-11-16  978
> 
> :::::: The code at line 969 was first introduced by commit
> :::::: 79535a7881c0cbe95063a2670d840cc950ae9282 dm vdo: add data_vio, the request object which services incoming bios
> 
> :::::: TO: Matthew Sakai <msakai@redhat.com>
> :::::: CC: Mike Snitzer <snitzer@kernel.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

Thanks for the report but this is reacting to older code. Changes were
made to address sparse's concerns about this same code, please see: 
commit 872564c501b7 ("dm vdo data-vio: silence sparse warnings about
locking context imbalance").

If wait_permit()'s sparse __releases annotation is somehow
insufficient for silencing cocci please let me know.

Thanks,
Mike

