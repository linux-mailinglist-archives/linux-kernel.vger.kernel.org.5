Return-Path: <linux-kernel+bounces-89410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB22986EFFE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9141C20896
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6A14291;
	Sat,  2 Mar 2024 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8edHRy5"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286114284
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709373955; cv=none; b=Rh0mpwbNqXlY01cNMZUmaJOAHlWh4GB0kXhk3JB9H1PRB7RbLY2xNleA+xoKYUiki8sAwI/Ec1lxN0LEctFL/g4ShJyCIS+xv4nKADEAQ9rExtZRpsUDfF3qMfZP2xvjr6lF8NshgVdEDFSRbicfd2U+m9107/3apqCo0r2LIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709373955; c=relaxed/simple;
	bh=hh0T0s0UufgYOP8l9L/QviOwtz3/7LcIlwRMvhfReS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kSIeReq2vbRzK/7UK0oUT7bBaRWkrTrGWQR/bdrMAS7ymOF0uET/8BoorNFOKHvsYseuPdH0OsCzOWiFf4z9OrdB6ro2/o0q6AgjPGGPSuGUUsGqWIVp+TLCmtBOiI1BKDm+YHEfdZHmXWz5PV41m3rbP1HhQiTizNWcCYyrFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G8edHRy5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412d67e4e91so1197665e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 02:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709373951; x=1709978751; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFUtAlxmJVizfJmrvCvJuODkamjzYH11rLdKEFqWZD4=;
        b=G8edHRy5eZmgCtCCJhPqvbnBxXxnEQjuMdTY12ayWvSMgvuzKcKZcLWwrdS0ksOHvz
         8VchfdqBLI7uf31su2GJwlgLbmvdxqw/74b+6TjCc0Z2g42orhe3vnzZIfZ4rD4mUPb3
         nVNC/TFSBbiIi8/PFepHjy/pKqibeLfcErBhwlXAbCQ+5SrVRQ1PJVXPVoJXkO0+q83F
         3qf56HnaNccpL1/mvzvy1bm27rqbsCe9Q7oPez5J0OY9gKXuJm9izd2657aAuL/e43FF
         4jmpMIUI2UBz5mxv00Uz8sHZx26QH0VwB62ofTnmN8yjVI0N4VhKGhZuiGjJd5iu4haA
         7FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709373951; x=1709978751;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFUtAlxmJVizfJmrvCvJuODkamjzYH11rLdKEFqWZD4=;
        b=eKWaL9qx5BSkBlJzIqjkviFL0M0Xn2CUzxRHnhakkR48YtLOIWid7DQ/l0bnVKhJ6u
         t23HKROOgcVB1YIEkvXxMRc7WFb84L5B0BhDFcqaDHLFmeA3uXvPDz1v49PMLHX+xIUi
         u1ZZq4YFvltxrdA5LcEpc5lu9UVF5HnDpp/Yp6Lbn5sMvLX1brk/kzx1tqMqZOQqUUn7
         uMWhSbIYAWpWzb70FMDKiYKZyyHQ3Axr3GiMQp82p40UaO2054PpUuUljFy32hAhsyV1
         LKaDqZ3EXzOSPPfHgzlCPUpGJfuOo1O+4F8ADLIxeqFlgP4m6MW9M7nr8fZS8XFDeT+I
         d5PA==
X-Forwarded-Encrypted: i=1; AJvYcCU1O9WKQFibi4i7DVmiiL5OC8WyhcKwpTIf1vOhC10w8GOk2wc15gmJ82fkAVvLsTq5Nni59YqDtwJ95djO9QH7nU2t51f6GXKJFcIc
X-Gm-Message-State: AOJu0YwYlCnuHquPiO/6g3sPK/a2Raf4FNQSYJtk0/2psPS1jbeICMT3
	ulaKaENG/8IyUovGxAGX7vp72xb0g88Yfrkd8buqFd/w4imZM5vNaKsosjjBVx4=
X-Google-Smtp-Source: AGHT+IE/6SL7kjXh20wHEUAKzmd/8XbfNxpOYBUCPI3xcrJ7z8PdOZnCGUgJshdX0SqyWiPn91TuIA==
X-Received: by 2002:a05:600c:468a:b0:412:bcc9:32dc with SMTP id p10-20020a05600c468a00b00412bcc932dcmr3663497wmo.31.1709373950800;
        Sat, 02 Mar 2024 02:05:50 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c138a00b00412cbe411f0sm666647wmf.0.2024.03.02.02.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 02:05:50 -0800 (PST)
Date: Sat, 2 Mar 2024 13:05:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Xi Pardee <xi.pardee@intel.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Rajvi Jingar <rajvi.jingar@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: drivers/platform/x86/intel/pmc/core.c:500 pmc_core_send_ltr_ignore()
 error: uninitialized symbol 'map'.
Message-ID: <cdae87ea-ad8b-44d4-936a-c3b698186932@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5ad3cb0ed525b80c7f66c32b49a68c1f3510bec9
commit: 2bcef4529222424559ac9b45948ee9d82c09d9b5 platform/x86:intel/pmc: Enable debugfs multiple PMC support
config: i386-randconfig-141-20240302 (https://download.01.org/0day-ci/archive/20240302/202403021544.6qtkaAly-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202403021544.6qtkaAly-lkp@intel.com/

New smatch warnings:
drivers/platform/x86/intel/pmc/core.c:500 pmc_core_send_ltr_ignore() error: uninitialized symbol 'map'.

Old smatch warnings:
drivers/platform/x86/intel/pmc/core.c:500 pmc_core_send_ltr_ignore() error: uninitialized symbol 'pmc'.

vim +/map +500 drivers/platform/x86/intel/pmc/core.c

92f530edd7c955 drivers/platform/x86/intel/pmc/core.c Gayatri Kammela   2022-11-14  463  int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
9c2ee19987ef02 drivers/platform/x86/intel_pmc_core.c Rajneesh Bhardwaj 2016-10-07  464  {
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  465  	struct pmc *pmc;
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  466  	const struct pmc_reg_map *map;
36974daf53888e drivers/platform/x86/intel_pmc_core.c David E. Box      2021-03-19  467  	u32 reg;
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  468  	int pmc_index, ltr_index;
9592438886756c drivers/platform/x86/intel_pmc_core.c Andy Shevchenko   2019-12-18  469  
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  470  	ltr_index = value;
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  471  	/* For platforms with multiple pmcs, ltr index value given by user
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  472  	 * is based on the contiguous indexes from ltr_show output.
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  473  	 * pmc index and ltr index needs to be calculated from it.
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  474  	 */
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  475  	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs) && ltr_index > 0; pmc_index++) {


ltr_index comes from the user via pmc_core_ltr_ignore_write()  Assume
that it is zero.

2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  476  		pmc = pmcdev->pmcs[pmc_index];
9c2ee19987ef02 drivers/platform/x86/intel_pmc_core.c Rajneesh Bhardwaj 2016-10-07  477  
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  478  		if (!pmc)
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  479  			continue;
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  480  
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  481  		map = pmc->map;
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  482  		if (ltr_index <= map->ltr_ignore_max)
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  483  			break;
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  484  
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  485  		/* Along with IP names, ltr_show map includes CURRENT_PLATFORM
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  486  		 * and AGGREGATED_SYSTEM values per PMC. Take these two index
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  487  		 * values into account in ltr_index calculation. Also, to start
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  488  		 * ltr index from zero for next pmc, subtract it by 1.
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  489  		 */
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  490  		ltr_index = ltr_index - (map->ltr_ignore_max + 2) - 1;
9c2ee19987ef02 drivers/platform/x86/intel_pmc_core.c Rajneesh Bhardwaj 2016-10-07  491  	}
9c2ee19987ef02 drivers/platform/x86/intel_pmc_core.c Rajneesh Bhardwaj 2016-10-07  492  
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  493  	if (pmc_index >= ARRAY_SIZE(pmcdev->pmcs) || ltr_index < 0)
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  494  		return -EINVAL;
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  495  
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  496  	pr_debug("ltr_ignore for pmc%d: ltr_index:%d\n", pmc_index, ltr_index);
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  497  
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  498  	mutex_lock(&pmcdev->lock);
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  499  
1c709ae12dad6f drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13 @500  	reg = pmc_core_reg_read(pmc, map->ltr_ignore_offset);
                                                                                                                             ^^^^^^^^^^^^^^^^^^^^^^
map is uninitialized.

2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  501  	reg |= BIT(ltr_index);
1c709ae12dad6f drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  502  	pmc_core_reg_write(pmc, map->ltr_ignore_offset, reg);
9c2ee19987ef02 drivers/platform/x86/intel_pmc_core.c Rajneesh Bhardwaj 2016-10-07  503  
9c2ee19987ef02 drivers/platform/x86/intel_pmc_core.c Rajneesh Bhardwaj 2016-10-07  504  	mutex_unlock(&pmcdev->lock);
36974daf53888e drivers/platform/x86/intel_pmc_core.c David E. Box      2021-03-19  505  
2bcef452922242 drivers/platform/x86/intel/pmc/core.c Xi Pardee         2023-06-13  506  	return 0;
36974daf53888e drivers/platform/x86/intel_pmc_core.c David E. Box      2021-03-19  507  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


