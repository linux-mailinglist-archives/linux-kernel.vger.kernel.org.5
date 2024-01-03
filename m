Return-Path: <linux-kernel+bounces-15440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBDB822C08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADDB1C23392
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3441418E2E;
	Wed,  3 Jan 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPFMgp3o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974218E15
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so6935163e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 03:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704281002; x=1704885802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJRFm+aJFXgkxWtqPNaVAM12RXPKxO0DGGq8KgLaeE0=;
        b=IPFMgp3o+/ebLmnN7/Xto97/ZnuiFEXQBBYpFbhQ7G1pFsTEMX496etf7bXQ99U5H6
         JwRcvQHHbVWTPuh0s1qsQUQruH+mO6O2PpxZBRKANrpgeC185Jh3rFUAxG6ThPIHEwu4
         ibfA0yWtKAw1TS28IP/Q3NiH4C6gdY8RmuBFfKEsUeVGaIBPFkoIU7OGfxuybldayqGN
         t3PWexb38xiMV3tq+zz12EPEmqY9I6ijkqrIce3xE+5b6TKeTitHyYbSK2hxAOSPKgSq
         0dBuKt6/vcQaDkVg3FWjCyKW4ttCTPCMOwiyv8XhQdmsRYPmENuiQnoySSREjk03ALJ9
         SliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704281002; x=1704885802;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJRFm+aJFXgkxWtqPNaVAM12RXPKxO0DGGq8KgLaeE0=;
        b=Sn44xTf6G9a87cubm1Xft1ou26ytIIOdlRHLX35AjaM46NcK2lGp8EcOokXR4R5tl6
         o6w4F0dWCq8BI1PlnLxhzesewX2SvqzxKQW0t3SE40CfkjqhdUhcKubkY8YqD5I+/Me5
         XIS9pVD3zHa+lvKAFJ7x99DzDJIOtcP+ndiqRAWE+R+B2Io8xcVonQ3XdtUpo1Wr+hbJ
         1ajmW3yuopJbSXHeK/3uV7YLcMwTXv7pYUmLo6txqwx17TvhqqMElSjYHCNSe2QE+RxM
         qCZkNj4NA6fIZXb3ZiPVDcoINGF/CeV93i2bLBF583/mvuY+QAOlQPEBB+eSs6XaIJWZ
         CLpg==
X-Gm-Message-State: AOJu0YyguS508+rd4/5zulChlMeSHAVRE1gMFng8wDQ/fVaj27wyT/Kr
	eSo7bWR8LEUg0mRt5n8Yafi2DSc/YJe0nA==
X-Google-Smtp-Source: AGHT+IFJVTLwzRGF1DuQP3vjPisYKxiWF+5uAzI0kdZJOWOmMPRP4sLXPJuiATG9UCHDYViYbvZ6Qg==
X-Received: by 2002:a05:6512:ad0:b0:50e:6b38:9e0b with SMTP id n16-20020a0565120ad000b0050e6b389e0bmr6715682lfu.73.1704281001941;
        Wed, 03 Jan 2024 03:23:21 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402044200b005553a8bb61dsm10309013edw.87.2024.01.03.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 03:23:21 -0800 (PST)
Date: Wed, 3 Jan 2024 14:23:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, deepakx.nagaraju@intel.com,
	joyce.ooi@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Nagaraju DeepakX <deepakx.nagaraju@intel.com>,
	Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: Re: [PATCH 5/5] net: ethernet: altera: rename functions and their
 prototypes
Message-ID: <ca5c5be7-9270-412b-a868-d5e28116f983@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213071112.18242-6-deepakx.nagaraju@intel.com>

Hi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/deepakx-nagaraju-intel-com/net-ethernet-altera-remove-unneeded-assignments/20231213-151600
base:   net/main
patch link:    https://lore.kernel.org/r/20231213071112.18242-6-deepakx.nagaraju%40intel.com
patch subject: [PATCH 5/5] net: ethernet: altera: rename functions and their prototypes
config: m68k-randconfig-r081-20231218 (https://download.01.org/0day-ci/archive/20231220/202312200739.79WGCuyb-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312200739.79WGCuyb-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/altera/altera_tse_main.c:266 alloc_init_skbufs() warn: double check that we're allocating correct size: 24 vs 164

Old smatch warnings:
drivers/net/ethernet/altera/altera_tse_main.c:271 alloc_init_skbufs() warn: double check that we're allocating correct size: 24 vs 164
drivers/net/ethernet/altera/altera_tse_main.c:988 tse_open() warn: 'priv->tx_irq' from request_irq() not released on lines: 988.

vim +266 drivers/net/ethernet/altera/altera_tse_main.c

bbd2190ce96d8f Vince Bridgers   2014-03-17  257  static int alloc_init_skbufs(struct altera_tse_private *priv)
bbd2190ce96d8f Vince Bridgers   2014-03-17  258  {
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  259  	struct altera_dma_private *dma = &priv->dma_priv;
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  260  	unsigned int rx_descs = dma->rx_ring_size;
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  261  	unsigned int tx_descs = dma->tx_ring_size;
bbd2190ce96d8f Vince Bridgers   2014-03-17  262  	int ret = -ENOMEM;
bbd2190ce96d8f Vince Bridgers   2014-03-17  263  	int i;
bbd2190ce96d8f Vince Bridgers   2014-03-17  264  
bbd2190ce96d8f Vince Bridgers   2014-03-17  265  	/* Create Rx ring buffer */
ad6f888f174e6a Nagaraju DeepakX 2023-12-13 @266  	dma->rx_ring = kcalloc(rx_descs, sizeof(struct altera_dma_private), GFP_KERNEL);

There is a mismatch here.  dma->rx_ring was changed to altera_dma_buffer
but the sizeof was changed to altera_dma_private.

ad6f888f174e6a Nagaraju DeepakX 2023-12-13  267  	if (!dma->rx_ring)
bbd2190ce96d8f Vince Bridgers   2014-03-17  268  		goto err_rx_ring;
bbd2190ce96d8f Vince Bridgers   2014-03-17  269  
bbd2190ce96d8f Vince Bridgers   2014-03-17  270  	/* Create Tx ring buffer */
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  271  	dma->tx_ring = kcalloc(tx_descs, sizeof(struct altera_dma_private), GFP_KERNEL);
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  272  	if (!dma->tx_ring)
bbd2190ce96d8f Vince Bridgers   2014-03-17  273  		goto err_tx_ring;
bbd2190ce96d8f Vince Bridgers   2014-03-17  274  
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  275  	dma->tx_cons = 0;
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  276  	dma->tx_prod = 0;
bbd2190ce96d8f Vince Bridgers   2014-03-17  277  
bbd2190ce96d8f Vince Bridgers   2014-03-17  278  	/* Init Rx ring */
bbd2190ce96d8f Vince Bridgers   2014-03-17  279  	for (i = 0; i < rx_descs; i++) {
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  280  		ret = tse_init_rx_buffer(priv, &priv->dma_priv.rx_ring[i], dma->rx_dma_buf_sz);
bbd2190ce96d8f Vince Bridgers   2014-03-17  281  		if (ret)
bbd2190ce96d8f Vince Bridgers   2014-03-17  282  			goto err_init_rx_buffers;
bbd2190ce96d8f Vince Bridgers   2014-03-17  283  	}
bbd2190ce96d8f Vince Bridgers   2014-03-17  284  
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  285  	dma->rx_cons = 0;
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  286  	dma->rx_prod = 0;
bbd2190ce96d8f Vince Bridgers   2014-03-17  287  
bbd2190ce96d8f Vince Bridgers   2014-03-17  288  	return 0;
bbd2190ce96d8f Vince Bridgers   2014-03-17  289  err_init_rx_buffers:
bbd2190ce96d8f Vince Bridgers   2014-03-17  290  	while (--i >= 0)
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  291  		tse_free_rx_buffer(priv, &priv->dma_priv.rx_ring[i]);
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  292  	kfree(dma->tx_ring);
bbd2190ce96d8f Vince Bridgers   2014-03-17  293  err_tx_ring:
ad6f888f174e6a Nagaraju DeepakX 2023-12-13  294  	kfree(dma->rx_ring);
bbd2190ce96d8f Vince Bridgers   2014-03-17  295  err_rx_ring:
bbd2190ce96d8f Vince Bridgers   2014-03-17  296  	return ret;
bbd2190ce96d8f Vince Bridgers   2014-03-17  297  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


