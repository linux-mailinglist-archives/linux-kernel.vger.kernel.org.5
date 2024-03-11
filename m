Return-Path: <linux-kernel+bounces-98486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84797877AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A882B1C21401
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6019DC2E6;
	Mon, 11 Mar 2024 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrxDfHEZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4301AD55
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135751; cv=none; b=UEA6MaL7TqwZSH+WkgcQd9ZHl08NBl9W7XY0jjQDR9IPbSk7x6AVAz+J6/m3ZrhnAI5XdgTDVhSPcNVGQUYGRN+t5clPkGAqM+VVEMAeCC2Fdsyu8Wj3C4/pE1jheCkR9YdZVYfkpwPpCq+hYGoBnLq9w84786ncDbcXL0pQopc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135751; c=relaxed/simple;
	bh=554JiCVrTEqIGWzxwv207Bs6CL1uIPaO1lIjJSecXM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dBeWuvvAXCxi6lW9QuV7ZigYE4131GXdUgBXC++XR6gOUATNFAvAEB/TkwqYbdzeV0hcWH0dKQhdine6RMsItRyhv1uFvy+pyhTQtAnbMbTL6r8QCGRXqwAzlNyi+dCpc8C08PlJWowQZZP12RdqrEZyA8sUYwJ9y0SmHcEF4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PrxDfHEZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4132a5b38fbso1945285e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 22:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710135748; x=1710740548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=agTvG5cRxRrqxJ/ok4HD4zoUrLt9mGNejOLoWfzX3yY=;
        b=PrxDfHEZquDkl9d1QdRee1KTqBazeYyVEwjDYexmV4mKurZVMHeth5ejx95njFrres
         GUQIikj5da6UwNm+HL0fqI6ky1NNcJ/WfJAbULE9MEpMp+y0ifq+hIDVlYuStBhwGS8B
         +w3nQ/0m6MfKAJ6sjISlqoHzGibzIGuuYaCzdBYTpK28k4ampmSTRXGa31ScVyo+oFqo
         EAfUyMnuVvgrrVQkhpRxBB577or+uNzdBf/BzAm410orMd/EOzsTxM5ELOAuHPosdR21
         6gWBsq8SS7Jcx55lbjS7dnfl6ERzITLwGBpBXBgrrfMJ8iqWVeakqZn6jIUwTgw6wW5I
         s0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710135748; x=1710740548;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agTvG5cRxRrqxJ/ok4HD4zoUrLt9mGNejOLoWfzX3yY=;
        b=nl46zu9f3aO6Zh5XpupAsMZnG134ZbPVm1SyISqpKmGF/VKcaQJJCfpj8nB1/dFFV9
         x5zn1Dgi8Fnkejd95qrDyb6WAIJvIIRcrJQ2igR8x8dadAHX5TiShFrvaQdzyMh+9IJG
         s6U6WAyYB7tabZCJPIuJMfeetkweywigSGz7/HEzbWypiOKABoxPu+BgcLQ78UbBDp4M
         BBgnTdWSFWKZ6iKPNSAwQlbAZN2MVfNNSxxxbwMgyQHBp1nwumtyFADEd2hHLKTvJ6Jo
         Wq92L0sLn9pQbFp3xm0n/mcgmmjiDd0QZJ+jTKQ9rX77G/XX9z/cgUMpyRq04A1L54zw
         MuQg==
X-Forwarded-Encrypted: i=1; AJvYcCVqC1x03H1UTCHSQyOOd/Cn0ixYlkybuGuHo58eoKCZ/c9JcyXlt9GR/2njZLWNQJvamnuIanPAvKyTNvZH+Tc5uyRdAlcN09sB1XbO
X-Gm-Message-State: AOJu0YxxqCXbz7pDVqyfWE4rGIL8aWy8vozwF+vysnFMXA7BN0xVSWVD
	Ty5oHbmWMyKKIUHLzynttLRD7w+X5Bx2e2t/rWvD2zbwuPsg7FQH4p2fj3aL2m4=
X-Google-Smtp-Source: AGHT+IHcEUskvZd7qnAEHlPyAJb2cBooyyTksS+KQEO9Da4xnf/ENcOZb+NEjGkW4ze/e2NWd/THXw==
X-Received: by 2002:a05:600c:4689:b0:412:c1d4:da7d with SMTP id p9-20020a05600c468900b00412c1d4da7dmr4448255wmo.33.1710135747900;
        Sun, 10 Mar 2024 22:42:27 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id jg8-20020a05600ca00800b004128f41a13fsm7760330wmb.38.2024.03.10.22.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 22:42:27 -0700 (PDT)
Date: Mon, 11 Mar 2024 08:42:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Xingui Yang <yangxingui@huawei.com>,
	john.g.garry@oracle.com, yanaijie@huawei.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, prime.zeng@hisilicon.com,
	chenxiang66@hisilicon.com, kangfenglong@huawei.com
Subject: Re: [PATCH v3 1/3] scsi: libsas: Allow smp_execute_task() arguments
 to be on the stack
Message-ID: <0cf17536-beba-4a8f-836b-553a9e0d1046@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307093733.41222-2-yangxingui@huawei.com>

Hi Xingui,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xingui-Yang/scsi-libsas-Allow-smp_execute_task-arguments-to-be-on-the-stack/20240307-174215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20240307093733.41222-2-yangxingui%40huawei.com
patch subject: [PATCH v3 1/3] scsi: libsas: Allow smp_execute_task() arguments to be on the stack
config: i386-randconfig-141-20240308 (https://download.01.org/0day-ci/archive/20240310/202403102353.jUPi6fOP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202403102353.jUPi6fOP-lkp@intel.com/

New smatch warnings:
drivers/scsi/libsas/sas_expander.c:148 smp_execute_task() warn: possible memory leak of '_req'

vim +/_req +148 drivers/scsi/libsas/sas_expander.c

adfd2325dfc5cf6 Xingui Yang     2024-03-07  138  static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
adfd2325dfc5cf6 Xingui Yang     2024-03-07  139  			    void *resp, int resp_size)
adfd2325dfc5cf6 Xingui Yang     2024-03-07  140  {
adfd2325dfc5cf6 Xingui Yang     2024-03-07  141  	struct scatterlist req_sg;
adfd2325dfc5cf6 Xingui Yang     2024-03-07  142  	struct scatterlist resp_sg;
adfd2325dfc5cf6 Xingui Yang     2024-03-07  143  	void *_req = kmemdup(req, req_size, GFP_KERNEL);
adfd2325dfc5cf6 Xingui Yang     2024-03-07  144  	void *_resp = alloc_smp_resp(resp_size);
adfd2325dfc5cf6 Xingui Yang     2024-03-07  145  	int ret;
adfd2325dfc5cf6 Xingui Yang     2024-03-07  146  
adfd2325dfc5cf6 Xingui Yang     2024-03-07  147  	if (!_req || !resp)
adfd2325dfc5cf6 Xingui Yang     2024-03-07 @148  		return -ENOMEM;

I haven't looked at the callers so I don't know how likely it is for one
of the allocations to fail and the other succeed...  But it seems
possible.

adfd2325dfc5cf6 Xingui Yang     2024-03-07  149  
adfd2325dfc5cf6 Xingui Yang     2024-03-07  150  	sg_init_one(&req_sg, _req, req_size);
adfd2325dfc5cf6 Xingui Yang     2024-03-07  151  	sg_init_one(&resp_sg, _resp, resp_size);
adfd2325dfc5cf6 Xingui Yang     2024-03-07  152  	ret = smp_execute_task_sg(dev, &req_sg, &resp_sg);
adfd2325dfc5cf6 Xingui Yang     2024-03-07  153  	memcpy(resp, _resp, resp_size);
adfd2325dfc5cf6 Xingui Yang     2024-03-07  154  	kfree(_req);
adfd2325dfc5cf6 Xingui Yang     2024-03-07  155  	kfree(_resp);
adfd2325dfc5cf6 Xingui Yang     2024-03-07  156  	return ret;
adfd2325dfc5cf6 Xingui Yang     2024-03-07  157  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


