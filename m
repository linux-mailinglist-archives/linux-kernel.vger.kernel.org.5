Return-Path: <linux-kernel+bounces-106264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3539087EBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655B01C21368
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D8F4F5E6;
	Mon, 18 Mar 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PRAXt+D+"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04974F1FC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774416; cv=none; b=mGVVy9LYKXd4o8h2Y4viZpK5minD42QlBS/xhSRSM1msiSTAQuWfhJHypqhf6WC5JRjNwyW3EJWPoLuGk7R59Qh5ZxGeSce+MYlvTAb0YMQxt1Tag0J1cEBPGLj9kEkZ+MR2/pZBYM+8mj3f4GC2VygOvXWWlspdhYzZUAfzzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774416; c=relaxed/simple;
	bh=K0nvCIylbWgeeIKuasya7FXkwj+gmnUaEX7YhrtKh1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFhDaVq/QVfQPr+0BNg4rtYRWjnpOApoj1SEn/zVs9wkBqZ6bq5gLuIXzOMmcV5moXOPXGKNTJWptuezUixdxFxVNlCAXS12wJ/PmE+HeYrmD88J6wVHcux4FVD/WOd24iXvDlkMzz9ie7wNBhmuiydKqiez/Uj5fg//upgKwYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PRAXt+D+; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c05fe1c4-569a-4b7d-a53f-938c0b470600@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710774412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkX+ZZDRxq0hnwohy4/NEYPdtVJTyCK6MVxLwPlhAKI=;
	b=PRAXt+D+9ygCxcSLtqW0JZdUF+ZbKwoCuP2VpeRWiFbzaE58BE6dZXkMbFA8TBwL4mWqHl
	C/KEkQNCVv3s6vT//kUTFU98oxlF4QQNvs8ZPY9GfGFK+W7s6HdaYLSRkD3+2O4sbOZQof
	jkTNslI0N5qHobO4rhRxyCKOjH1TCuY=
Date: Mon, 18 Mar 2024 11:06:51 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6/6] drm: zynqmp_dp: Add debugfs interface for compliance
 testing
Content-Language: en-US
To: kernel test robot <lkp@intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 linux-arm-kernel@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>
References: <20240315230916.1759060-7-sean.anderson@linux.dev>
 <202403161837.76okceZN-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <202403161837.76okceZN-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/16/24 06:55, kernel test robot wrote:
> Hi Sean,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on v6.8]
> [cannot apply to drm-misc/drm-misc-next linus/master next-20240315]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/drm-zynqmp_dp-Downgrade-log-level-for-aux-retries-message/20240316-071208
> base:   v6.8
> patch link:    https://lore.kernel.org/r/20240315230916.1759060-7-sean.anderson%40linux.dev
> patch subject: [PATCH 6/6] drm: zynqmp_dp: Add debugfs interface for compliance testing
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240316/202403161837.76okceZN-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403161837.76okceZN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403161837.76okceZN-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    m68k-linux-ld: drivers/gpu/drm/xlnx/zynqmp_dp.o: in function `zynqmp_dp_rate_set':
>>> zynqmp_dp.c:(.text+0x1a7a): undefined reference to `__udivdi3'
> 

Will fix.

--Sean

