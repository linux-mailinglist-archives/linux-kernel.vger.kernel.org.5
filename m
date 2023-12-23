Return-Path: <linux-kernel+bounces-10310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD6581D288
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D097D1F230DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF265664;
	Sat, 23 Dec 2023 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jks/bfwF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F004A34;
	Sat, 23 Dec 2023 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UNrI5d+OwOlR9bsEA+kLfKKLgi1B2PVQGG+8MWXSfz8=; b=Jks/bfwFvpRCPEETX4cvjl3DBG
	WM7g0tH+gittme5QDF7URqwshe9rjnSTGGpkQBFM+8xFCQHTwzWBLVo+XO/Pf5a1oodFVEE0BHqE5
	bjdjfscqs1SL0+Cq9yW2jN2wnkv08bdBleGPxQrwI2dxDfNdK8hsk6uJCdW/hnJ52ymU3tN0pQ92z
	DhbZlgoic+nhre1dbDqkErhVuvlV0YB6AHY/EiwM+erncW2cSxVrpSoGbgURvMHOeIWgW7HnT/hhG
	XQETPqt1wZg1GCeEWa3LOuuPH/Xg9eXr3egNsheJrZDwIlGTqsB9Womnt1eC7ck+0Sv9inHDR+7gM
	b0v0YxmA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGugP-007QLP-1E;
	Sat, 23 Dec 2023 05:36:21 +0000
Message-ID: <9be5f009-9fcb-4299-9d2f-13b1263d83e1@infradead.org>
Date: Fri, 22 Dec 2023 21:36:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs/bcachefs/io_write.c:1570: warning: Function parameter or
 struct member 'bch2_write' not described in 'CLOSURE_CALLBACK'
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Kent Overstreet <kmo@daterainc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <202312182040.naGasU5s-lkp@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202312182040.naGasU5s-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/23 04:58, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
> commit: d4e3b928ab487a8aecd1f6a140b40ac365116cfb closures: CLOSURE_CALLBACK() to fix type punning
> date:   3 weeks ago
> config: x86_64-buildonly-randconfig-001-20231218 (https://download.01.org/0day-ci/archive/20231218/202312182040.naGasU5s-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312182040.naGasU5s-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312182040.naGasU5s-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> fs/bcachefs/io_write.c:1570: warning: Function parameter or struct member 'bch2_write' not described in 'CLOSURE_CALLBACK'
>    fs/bcachefs/io_write.c:1570: warning: expecting prototype for bch2_write(). Prototype was for CLOSURE_CALLBACK() instead
> 
> 

This needs to be fixed in scripts/kernel-doc AFAIK.

Cc:ing linux-doc mailing list.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

