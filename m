Return-Path: <linux-kernel+bounces-2653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09329815FFB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D9F1F2163D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3424D44C7B;
	Sun, 17 Dec 2023 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMK/1RL2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF844369;
	Sun, 17 Dec 2023 14:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4B9C433C8;
	Sun, 17 Dec 2023 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702824521;
	bh=2v6c7w5YjYuTrHr0xyiSsUNzB7hn7P+PURHZkaEiMq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hMK/1RL21kGQvTj8TT/U9fKNJsBKKg/5XgCvbOl4a961bh6SuZG5kmKzqiEBYD1QG
	 5Wstc8CkMtQGhvG+yaOJ4gYPJ0eonehdvqBI9sdgcXoeVZxzM0aKk+YHCHz7msZVny
	 fyh+C+MTIQdx4nRX/hJcegpNosNJsriK3EqzQXUGAfJWlMQuzThuAoueVpDKT836Vz
	 TKCfcDn6EbbuZT6QKKusBvm33fTHXAadZIcMXlFMHobWMrvoN7vc2pHmLqgcFvyAJP
	 2P3//EOOZ8DEdnY5PSVwkgNUT+sB/zocYYKUaThW78pWbB3v8COOQsPkD5UtgWeD9R
	 6a7Zqbg9DVbMg==
Date: Sun, 17 Dec 2023 14:48:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
 joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
 paul.cercueil@analog.com, Michael.Hennerich@analog.com, lars@metafoo.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dan.carpenter@linaro.org, dlechner@baylibre.com,
 marcelo.schmitt1@gmail.com, oe-kbuild-all@lists.linux.dev,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/15] iio: adc: ad7091r: Move chip init data to
 container struct
Message-ID: <20231217144823.7d6f8473@jic23-huawei>
In-Reply-To: <202312172006.b2fep1oG-lkp@intel.com>
References: <9d1248860193b55e79640b2e64c21c66bd6645f9.1702746240.git.marcelo.schmitt1@gmail.com>
	<202312172006.b2fep1oG-lkp@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Dec 2023 21:04:50 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Marcelo,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on linus/master v6.7-rc5 next-20231215]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/scripts-checkpatch-Add-__aligned-to-the-list-of-attribute-notes/20231217-055420
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/9d1248860193b55e79640b2e64c21c66bd6645f9.1702746240.git.marcelo.schmitt1%40gmail.com
> patch subject: [PATCH v4 6/15] iio: adc: ad7091r: Move chip init data to container struct
> config: um-randconfig-r111-20231217 (https://download.01.org/0day-ci/archive/20231217/202312172006.b2fep1oG-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312172006.b2fep1oG-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312172006.b2fep1oG-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/iio/adc/ad7091r5.c:59:14: error: initializer element is not constant  
>      .irq_info = ad7091r5_chip_info_irq,
>                  ^~~~~~~~~~~~~~~~~~~~~~
>    drivers/iio/adc/ad7091r5.c:59:14: note: (near initialization for 'ad7091r5_init_info.irq_info')
>    drivers/iio/adc/ad7091r5.c:60:17: error: initializer element is not constant
>      .info_no_irq = ad7091r5_chip_info_noirq,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~

You should use a pointer rather than assigning the whole structure.

>    drivers/iio/adc/ad7091r5.c:60:17: note: (near initialization for 'ad7091r5_init_info.info_no_irq')
> 
> 
> vim +59 drivers/iio/adc/ad7091r5.c
> 
>     57	
>     58	static struct ad7091r_init_info ad7091r5_init_info = {
>   > 59		.irq_info = ad7091r5_chip_info_irq,  
>     60		.info_no_irq = ad7091r5_chip_info_noirq,
>     61		.regmap_config = &ad7091r_regmap_config,
>     62		.init_adc_regmap = &ad7091r5_regmap_init
>     63	};
>     64	
> 


