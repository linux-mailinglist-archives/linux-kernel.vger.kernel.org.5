Return-Path: <linux-kernel+bounces-11739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2D681EB07
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D007B21FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5270B1C10;
	Wed, 27 Dec 2023 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyyYQGg1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21289A32
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703638110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eUX0XCx8ofDRM2q8IIgdryT7rgA75m19d3GXDJ/iBmQ=;
	b=OyyYQGg1GCvuO8a3H4GUW6xjZva6sKtaiiKEyn/Jcj9ViTA5veqAii2n/hXymjtw8LLpeV
	xYTPqyZhgTkYTxAXUajin4ysEljakuNnGBmDq0rp1viVHzNSQS2uLvi5TDzVsA8diaLS58
	RZ3IKmeoXWWJU6GcuJIzBnBGA0pWWn4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-HuwGuWFiOByNu8nRhNJGQA-1; Tue,
 26 Dec 2023 19:48:29 -0500
X-MC-Unique: HuwGuWFiOByNu8nRhNJGQA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD23E29AA2C9;
	Wed, 27 Dec 2023 00:48:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C538A1C060AF;
	Wed, 27 Dec 2023 00:48:27 +0000 (UTC)
Date: Wed, 27 Dec 2023 08:48:24 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: Youling Tang <youling.tang@outlook.com>, oe-kbuild-all@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>, linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] kdump: Remove redundant DEFAULT_CRASH_KERNEL_LOW_SIZE
Message-ID: <ZYt0WCBrxRHIx81F@MiWiFi-R3L-srv>
References: <MW4PR84MB3145D3EB871BBD59AA71C0FC8198A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
 <202312270133.8w4Wrh4h-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312270133.8w4Wrh4h-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 12/27/23 at 01:13am, kernel test robot wrote:
> Hi Youling,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.7-rc7 next-20231222]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/kdump-Remove-redundant-DEFAULT_CRASH_KERNEL_LOW_SIZE/20231226-193215
> base:   linus/master
> patch link:    https://lore.kernel.org/r/MW4PR84MB3145D3EB871BBD59AA71C0FC8198A%40MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
> patch subject: [PATCH] kdump: Remove redundant DEFAULT_CRASH_KERNEL_LOW_SIZE
> config: i386-buildonly-randconfig-002-20231226 (https://download.01.org/0day-ci/archive/20231227/202312270133.8w4Wrh4h-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231227/202312270133.8w4Wrh4h-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312270133.8w4Wrh4h-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

This has been fixed by patch author's v2 patch:
https://lore.kernel.org/all/MW4PR84MB3145459ADC7EB38BBB36955B8198A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM/T/#u

> 
>    arch/x86/kernel/setup.c: In function 'arch_reserve_crashkernel':
> >> arch/x86/kernel/setup.c:479:8: error: implicit declaration of function 'parse_crashkernel' [-Werror=implicit-function-declaration]
>      479 |  ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>          |        ^~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +/parse_crashkernel +479 arch/x86/kernel/setup.c
> 
> a0a0becd2da0ba Yinghai Lu     2008-07-03  468  
> 9c08a2a139fe83 Baoquan He     2023-09-14  469  static void __init arch_reserve_crashkernel(void)
> ccb4defa71744f Yinghai Lu     2008-06-25  470  {
> 9c08a2a139fe83 Baoquan He     2023-09-14  471  	unsigned long long crash_base, crash_size, low_size = 0;
> 9c08a2a139fe83 Baoquan He     2023-09-14  472  	char *cmdline = boot_command_line;
> 55a20ee7804ab6 Yinghai Lu     2013-04-15  473  	bool high = false;
> ccb4defa71744f Yinghai Lu     2008-06-25  474  	int ret;
> ccb4defa71744f Yinghai Lu     2008-06-25  475  
> 4ece09be9913a8 Jisheng Zhang  2022-03-23  476  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> 4ece09be9913a8 Jisheng Zhang  2022-03-23  477  		return;
> 4ece09be9913a8 Jisheng Zhang  2022-03-23  478  
> 9c08a2a139fe83 Baoquan He     2023-09-14 @479  	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> 9c08a2a139fe83 Baoquan He     2023-09-14  480  				&crash_size, &crash_base,
> 9c08a2a139fe83 Baoquan He     2023-09-14  481  				&low_size, &high);
> 9c08a2a139fe83 Baoquan He     2023-09-14  482  	if (ret)
> 32105f7fd8faa7 Bernhard Walle 2008-06-26  483  		return;
> 32105f7fd8faa7 Bernhard Walle 2008-06-26  484  
> 3db3eb285259ac Petr Tesarik   2018-04-25  485  	if (xen_pv_domain()) {
> 3db3eb285259ac Petr Tesarik   2018-04-25  486  		pr_info("Ignoring crashkernel for a Xen PV domain\n");
> 3db3eb285259ac Petr Tesarik   2018-04-25  487  		return;
> 3db3eb285259ac Petr Tesarik   2018-04-25  488  	}
> 3db3eb285259ac Petr Tesarik   2018-04-25  489  
> 9c08a2a139fe83 Baoquan He     2023-09-14  490  	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> 9c08a2a139fe83 Baoquan He     2023-09-14  491  				    low_size, high);
> ccb4defa71744f Yinghai Lu     2008-06-25  492  }
> ccb4defa71744f Yinghai Lu     2008-06-25  493  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


