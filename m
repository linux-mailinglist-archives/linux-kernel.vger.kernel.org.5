Return-Path: <linux-kernel+bounces-2101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D1F8157DD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEBCB24798
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D5125C5;
	Sat, 16 Dec 2023 05:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2mbYUiQH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42E18E0F;
	Sat, 16 Dec 2023 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=JTRGM6kINLV6hMcJUOeSF2SryxrbP5qZgaXJQ74eITo=; b=2mbYUiQHlTLkr2ku8bF5uu0sWP
	e2+fQ9U9aDDBLmsbsT/jrF3pN/tMDjF6e8KW5gH88xvmem3vTA0hH7AGpYxVccyxzVvxnCsiiLqgx
	P9yiSavydlUwThiC5al8hC28J6gd84QlpFfeZOsrVnoNc1z0i0GcK4okHsxPGbYMxo+yVjUi7mYUD
	JMZj4CeuTDHyYMBqAZjpBuY8yzBtq2NDeG7ZWsvNQUmczu0ZyK8AnTu3R4JOSLWL1+CirkQz3QCsQ
	lhGW/NaEz8OXSAMZEnJxJA3nJW5xs/k16teeSW0dn1y6mFrRT4nEULxedsW3YPmNldVVFAkCzUKeE
	BLA+yjTQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rENWT-005Vds-1U;
	Sat, 16 Dec 2023 05:47:37 +0000
Message-ID: <fb8c1ab0-f169-4a8d-bd84-3eb3b806f622@infradead.org>
Date: Fri, 15 Dec 2023 21:47:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scripts/kernel-doc: drivers/mtd/nand/raw/marvell_nand.c:352:
 warning: Excess struct member 'sels' description in 'marvell_nand_chip'
Content-Language: en-US
To: Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>
Cc: Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <202312160703.nnQfaSja-lkp@intel.com> <ZX04SC/YF4c45QGS@rli9-mobl>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZX04SC/YF4c45QGS@rli9-mobl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/15/23 21:40, Philip Li wrote:
> On Sat, Dec 16, 2023 at 07:39:43AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   3bd7d748816927202268cb335921f7f68b3ca723
>> commit: a8eaf3ef549980719c5fcca257d5b220ac0f3f1b mtd: rawnand: marvell: Annotate struct marvell_nand_chip with __counted_by
>> date:   3 months ago
>> config: arm-randconfig-002-20231215 (https://download.01.org/0day-ci/archive/20231216/202312160703.nnQfaSja-lkp@intel.com/config)
>> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312160703.nnQfaSja-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> 
> Kindly ignore this report and others that are related to __counted_by annotation.
> We will look for a way to avoid such reports which are duplicated with same cause.
> 
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202312160703.nnQfaSja-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> scripts/kernel-doc: drivers/mtd/nand/raw/marvell_nand.c:352: warning: Excess struct member 'sels' description in 'marvell_nand_chip'
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki

Hi,
This patch from Kees:
https://lore.kernel.org/linux-doc/20231215001347.work.151-kees@kernel.org/

should fix these problems. Jon Corbet has merged it into the (some?) docs tree.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

