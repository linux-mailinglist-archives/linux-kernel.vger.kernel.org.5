Return-Path: <linux-kernel+bounces-599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89542814365
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8E21C225E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BF6111B4;
	Fri, 15 Dec 2023 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W/FgsE3G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA01D287;
	Fri, 15 Dec 2023 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=iu4O73Xc0+NsCJpIRfRNkXbG4KZ0txkBhIcf/sjzikA=; b=W/FgsE3G2smGE2l3Te0EC0Z+1o
	IieHpcs4pq5vaZELWAcZAKXauDKMyPx2lHssphRyrsjgGHT5ZHvhnGkLuBl2h6ehA8iub7OobVyf4
	Ju9x2CiT1Mf/cajKS2jx+goVSF/i3JjYrON049uHQWavFyuFPR6ChlAF8Sf46m1nk6bK9Jwdyuyg3
	4ZZuQx4lvw4A+Lva999OMdmnJftLssBrpAZ5+hCYDsO5RAAai1F8g5MEdRWdfU+yvkidgLNLIrgdb
	x6BPIRolSEe1ple9dcCmz8MPxblIP3bXT/rIRLd9A9kUniWINwa7dC5JuCBKwZ/iNeVCoO0mxng/d
	z7TZBBDA==;
Received: from om126156224122.26.openmobile.ne.jp ([126.156.224.122] helo=[192.168.43.165])
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3Kc-009qUW-2a;
	Fri, 15 Dec 2023 08:14:04 +0000
Message-ID: <16ce5dbc-9a64-4197-a399-27828eb2d9db@infradead.org>
Date: Fri, 15 Dec 2023 17:13:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/ethernet/toshiba/ps3_gelic_net.c:330:33: sparse:
 sparse: incorrect type in assignment (different base types)
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>
References: <202312142250.7GMllD1E-lkp@intel.com>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <202312142250.7GMllD1E-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/14/23 23:51, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
> commit: bebe933d35a63d4f042fbf4dce4f22e689ba0fcd net/ps3_gelic_net: Use dma_mapping_error
> date:   9 months ago
> config: powerpc64-randconfig-r122-20231213 (https://download.01.org/0day-ci/archive/20231214/202312142250.7GMllD1E-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20231214/202312142250.7GMllD1E-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312142250.7GMllD1E-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>>> drivers/net/ethernet/toshiba/ps3_gelic_net.c:330:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] bus_addr @@     got restricted __be32 [usertype] @@
>    drivers/net/ethernet/toshiba/ps3_gelic_net.c:330:33: sparse:     expected unsigned long long [usertype] bus_addr
>    drivers/net/ethernet/toshiba/ps3_gelic_net.c:330:33: sparse:     got restricted __be32 [usertype]
> 
> vim +330 drivers/net/ethernet/toshiba/ps3_gelic_net.c
> 
>    295	
>    296	/**
>    297	 * gelic_card_init_chain - links descriptor chain
>    298	 * @card: card structure
>    299	 * @chain: address of chain
>    300	 * @start_descr: address of descriptor array
>    301	 * @no: number of descriptors
>    302	 *
>    303	 * we manage a circular list that mirrors the hardware structure,
>    304	 * except that the hardware uses bus addresses.
>    305	 *
>    306	 * returns 0 on success, <0 on failure
>    307	 */
>    308	static int gelic_card_init_chain(struct gelic_card *card,
>    309					 struct gelic_descr_chain *chain,
>    310					 struct gelic_descr *start_descr, int no)
>    311	{
>    312		int i;
>    313		struct gelic_descr *descr;
>    314	
>    315		descr = start_descr;
>    316		memset(descr, 0, sizeof(*descr) * no);
>    317	
>    318		/* set up the hardware pointers in each descriptor */
>    319		for (i = 0; i < no; i++, descr++) {
>    320			dma_addr_t cpu_addr;
>    321	
>    322			gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
>    323	
>    324			cpu_addr = dma_map_single(ctodev(card), descr,
>    325						  GELIC_DESCR_SIZE, DMA_BIDIRECTIONAL);
>    326	
>    327			if (dma_mapping_error(ctodev(card), cpu_addr))
>    328				goto iommu_error;
>    329	
>  > 330			descr->bus_addr = cpu_to_be32(cpu_addr);

The values of the gelic hardware descriptors are all be32.  I think what we
want is to force cpu_addr to be32 so the conversion to be32 won't give a
warning, so something like this:

  descr->bus_addr = cpu_to_be32((__force __be32)cpu_addr);

I'll prepare a patch and submit after some testing.

-Geoff



