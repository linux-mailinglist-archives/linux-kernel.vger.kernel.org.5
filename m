Return-Path: <linux-kernel+bounces-43941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BE841B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2708B21397
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C89381AB;
	Tue, 30 Jan 2024 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmRJlS0H"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB91237701
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706591526; cv=none; b=OXpSIW0xloDEDPJfAHJyecJ+fh9ImG3uX4aMBTKfqfmfrK4dRYPoHu7qhHXYw3ZeoMzKPl8Q+IVTqkQr7Bif5ygtQgXBUb4DNr7JyL9jFLoPQ3wUO9zRQeceNgKq7PXNJOSBGXaOlVmjqnQvqAiytxlY20oPQW0z4tTTItEwijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706591526; c=relaxed/simple;
	bh=gRa6zDODoyhQ3+n0FAjSpIYjIVhjcGxZbfcryB4c7Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=taxlq7G9WCv6UsBc4QQR0+TJF8nXRGFYJhDystiNEosxHq4NOWAzA21tUSUs8sh8i3DZoEGOmaC0JDNvD+dRui9usONJxwuR4GM67elFv7UrHXi2jZoP/k0f98Ljmri/2pBbU0qtEOoNHWUeg8Wyr6kMDMWhka1Wyw79qfz29rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QmRJlS0H; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ae4eb360aso2027489f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706591523; x=1707196323; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFkJ8YEcx1vJ5tSiLYWZOmA0x6d7CoNNJ6/W8VFHiks=;
        b=QmRJlS0H38DxlvDCzNU9bvCreG1rPs8fp9fAK04ViSq781AaN1z6TQLtmB9/5qsax8
         3UrhCTax6VaORSxp3izXIVLmrXJVhtrtgxuqmfXLDPuF/uJZlnyVw3AV26dmPcCN6IJT
         7C/zTntRjk6oAdq7wzsad32KAp7tUoZxKN2RiNs0/vAAdmWMtNGlH7BWtv38pLwb6T70
         Zq/CPq0VWIS+wEv1JmDieOYUkJFHO8ktVX8H78Sa1PAoPd8gEoO03Btt8A+xJQpo3ZC0
         H8CiYMsgsuunjIKlwHKlxkwc9Mdc+lbG2nM4VmPJ0XqDt7mdIRcS6GCNaJgWLIbksn1o
         kyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706591523; x=1707196323;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFkJ8YEcx1vJ5tSiLYWZOmA0x6d7CoNNJ6/W8VFHiks=;
        b=YcXOJpMIoo7cUdWMbsv0GrEl5Bra2DW++ljgS4iEWTnG4gLvmoERsLaC/VAiY5PNm5
         fDQwONcl3flxjstuaX6ddL3gUIR8vncHGNKWqWj7GRRw1kVNLHFrBx5E50Y1KrpHxSZN
         bw1zxt3Xadx+1a8rhYmPXM2xuwt931tjRZbTIu+clZnf/zJyMbZl/q6WQ5ZdQG99ZRiU
         ETKEmwqcyBhUqxIHjCz/YhHI8hAD536PzUsbva2tRggXKsF//SsUwt4xO7O1RTfDTVQg
         BMyGyUf/mbNo+63iwiFWIzMjmc8e6FM68TU9K1NeaRF/x0ulEWGwOz8ToIp13vV/7Vov
         BcrA==
X-Gm-Message-State: AOJu0Yz/FF8YyOAouJai339Vzu6fNDDuqeFXphnlQhQ2nD4vlyYRpld7
	nyVT6hOf5go24DveJfi64V5hc6pBzouyzjkyh+NIg2efiVjfMW+K8to1/9MDkmU=
X-Google-Smtp-Source: AGHT+IGKV6vXZKlzQvf+WVjlAtnlCBfj/HLfKNq4VXtrhVgXZCLSnPizN49taJaeWoeDjenPtNcpPg==
X-Received: by 2002:adf:e2cc:0:b0:339:58fc:4934 with SMTP id d12-20020adfe2cc000000b0033958fc4934mr5190229wrj.2.1706591522842;
        Mon, 29 Jan 2024 21:12:02 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id e10-20020adfe38a000000b0033afcc069c3sm148033wrm.84.2024.01.29.21.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 21:12:02 -0800 (PST)
Date: Tue, 30 Jan 2024 08:11:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Matthew Brost <matthew.brost@intel.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: drivers/gpu/drm/xe/tests/xe_migrate.c:224 xe_migrate_sanity_test()
 warn: passing zero to 'PTR_ERR'
Message-ID: <d06df232-e96e-45aa-b749-21ef729a9463@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   41bccc98fb7931d63d03f326a746ac4d429c1dd3
commit: dd08ebf6c3525a7ea2186e636df064ea47281987 drm/xe: Introduce a new DRM driver for Intel GPUs
config: sparc-randconfig-r081-20240128 (https://download.01.org/0day-ci/archive/20240129/202401292346.V7E6rEzz-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202401292346.V7E6rEzz-lkp@intel.com/

New smatch warnings:
drivers/gpu/drm/xe/tests/xe_migrate.c:224 xe_migrate_sanity_test() warn: passing zero to 'PTR_ERR'

Old smatch warnings:
drivers/gpu/drm/xe/tests/xe_migrate.c:254 xe_migrate_sanity_test() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +224 drivers/gpu/drm/xe/tests/xe_migrate.c

dd08ebf6c3525a Matthew Brost 2023-03-30  210  static void xe_migrate_sanity_test(struct xe_migrate *m, struct kunit *test)
dd08ebf6c3525a Matthew Brost 2023-03-30  211  {
dd08ebf6c3525a Matthew Brost 2023-03-30  212  	struct xe_gt *gt = m->gt;
dd08ebf6c3525a Matthew Brost 2023-03-30  213  	struct xe_device *xe = gt_to_xe(gt);
dd08ebf6c3525a Matthew Brost 2023-03-30  214  	struct xe_bo *pt, *bo = m->pt_bo, *big, *tiny;
dd08ebf6c3525a Matthew Brost 2023-03-30  215  	struct xe_res_cursor src_it;
dd08ebf6c3525a Matthew Brost 2023-03-30  216  	struct dma_fence *fence;
dd08ebf6c3525a Matthew Brost 2023-03-30  217  	u64 retval, expected;
dd08ebf6c3525a Matthew Brost 2023-03-30  218  	struct xe_bb *bb;
dd08ebf6c3525a Matthew Brost 2023-03-30  219  	int err;
dd08ebf6c3525a Matthew Brost 2023-03-30  220  	u8 id = gt->info.id;
dd08ebf6c3525a Matthew Brost 2023-03-30  221  
dd08ebf6c3525a Matthew Brost 2023-03-30  222  	err = xe_bo_vmap(bo);
dd08ebf6c3525a Matthew Brost 2023-03-30  223  	if (err) {
dd08ebf6c3525a Matthew Brost 2023-03-30 @224  		KUNIT_FAIL(test, "Failed to vmap our pagetables: %li\n",
dd08ebf6c3525a Matthew Brost 2023-03-30  225  			   PTR_ERR(bo));
                                                                   ^^^^^^^^^^^
This should be "err".

dd08ebf6c3525a Matthew Brost 2023-03-30  226  		return;
dd08ebf6c3525a Matthew Brost 2023-03-30  227  	}
dd08ebf6c3525a Matthew Brost 2023-03-30  228  
dd08ebf6c3525a Matthew Brost 2023-03-30  229  	big = xe_bo_create_pin_map(xe, m->gt, m->eng->vm, SZ_4M,
dd08ebf6c3525a Matthew Brost 2023-03-30  230  				   ttm_bo_type_kernel,
dd08ebf6c3525a Matthew Brost 2023-03-30  231  				   XE_BO_CREATE_VRAM_IF_DGFX(m->gt) |
dd08ebf6c3525a Matthew Brost 2023-03-30  232  				   XE_BO_CREATE_PINNED_BIT);
dd08ebf6c3525a Matthew Brost 2023-03-30  233  	if (IS_ERR(big)) {
dd08ebf6c3525a Matthew Brost 2023-03-30  234  		KUNIT_FAIL(test, "Failed to allocate bo: %li\n", PTR_ERR(big));
dd08ebf6c3525a Matthew Brost 2023-03-30  235  		goto vunmap;
dd08ebf6c3525a Matthew Brost 2023-03-30  236  	}
dd08ebf6c3525a Matthew Brost 2023-03-30  237  
dd08ebf6c3525a Matthew Brost 2023-03-30  238  	pt = xe_bo_create_pin_map(xe, m->gt, m->eng->vm, GEN8_PAGE_SIZE,
dd08ebf6c3525a Matthew Brost 2023-03-30  239  				  ttm_bo_type_kernel,
dd08ebf6c3525a Matthew Brost 2023-03-30  240  				  XE_BO_CREATE_VRAM_IF_DGFX(m->gt) |
dd08ebf6c3525a Matthew Brost 2023-03-30  241  				  XE_BO_CREATE_PINNED_BIT);
dd08ebf6c3525a Matthew Brost 2023-03-30  242  	if (IS_ERR(pt)) {
dd08ebf6c3525a Matthew Brost 2023-03-30  243  		KUNIT_FAIL(test, "Failed to allocate fake pt: %li\n",
dd08ebf6c3525a Matthew Brost 2023-03-30  244  			   PTR_ERR(pt));
dd08ebf6c3525a Matthew Brost 2023-03-30  245  		goto free_big;
dd08ebf6c3525a Matthew Brost 2023-03-30  246  	}
dd08ebf6c3525a Matthew Brost 2023-03-30  247  
dd08ebf6c3525a Matthew Brost 2023-03-30  248  	tiny = xe_bo_create_pin_map(xe, m->gt, m->eng->vm,
dd08ebf6c3525a Matthew Brost 2023-03-30  249  				    2 * SZ_4K,
dd08ebf6c3525a Matthew Brost 2023-03-30  250  				    ttm_bo_type_kernel,
dd08ebf6c3525a Matthew Brost 2023-03-30  251  				    XE_BO_CREATE_VRAM_IF_DGFX(m->gt) |
dd08ebf6c3525a Matthew Brost 2023-03-30  252  				    XE_BO_CREATE_PINNED_BIT);
dd08ebf6c3525a Matthew Brost 2023-03-30  253  	if (IS_ERR(tiny)) {
dd08ebf6c3525a Matthew Brost 2023-03-30  254  		KUNIT_FAIL(test, "Failed to allocate fake pt: %li\n",
dd08ebf6c3525a Matthew Brost 2023-03-30  255  			   PTR_ERR(pt));
                                                                   ^^^^^^^^^^^
s/pt/tiny/

dd08ebf6c3525a Matthew Brost 2023-03-30  256  		goto free_pt;
dd08ebf6c3525a Matthew Brost 2023-03-30  257  	}
dd08ebf6c3525a Matthew Brost 2023-03-30  258  
dd08ebf6c3525a Matthew Brost 2023-03-30  259  	bb = xe_bb_new(m->gt, 32, xe->info.supports_usm);
dd08ebf6c3525a Matthew Brost 2023-03-30  260  	if (IS_ERR(bb)) {
dd08ebf6c3525a Matthew Brost 2023-03-30  261  		KUNIT_FAIL(test, "Failed to create batchbuffer: %li\n",
dd08ebf6c3525a Matthew Brost 2023-03-30  262  			   PTR_ERR(bb));

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


