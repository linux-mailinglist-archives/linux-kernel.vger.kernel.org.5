Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCE7E503E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjKHGNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHGNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:13:14 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30CD41
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:13:12 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5bd5809f63aso2685763a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 22:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699423992; x=1700028792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqET+/tUbFu2Jp9wRy1DEiP4GTn/JAUINR9zHqa/AlU=;
        b=XbChFd9FlVs4t7/Ef3yRcPeuy9eaEGk8gnV/0p6ge8WpN9MzBFWI+T2xKEpzjt2osY
         LRGST6BC3rg4rzSqrQ+wuSA8Hdr4WAPy7k2Yhy6WmR+WMF0hdGs22WM1Zi6e8YOAH4EF
         rTmi2R6m6BZVRwLSVpCSkCYiUBFCcuD+tGEYZA0Yuo7mbo6N83CkA6J99m0XjzWjYOnG
         egVlhX62YrLop+ozjPvqLTKHau7IIiMETQ1ETlL4uwK8gKVEkdkJGfn7wV1A+CLxvqS1
         WassyDNeo4u1ljpf1lP53H2u7ngVJvFbOzHXMxQy/ZtNNSE6S/qr8vx25l49ivU9jvgG
         /cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699423992; x=1700028792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqET+/tUbFu2Jp9wRy1DEiP4GTn/JAUINR9zHqa/AlU=;
        b=gmm9N/t+7UrZchD3pI37QPnK+vrZr6Y867FY986oVhAHovqehGDCLfA1qdIZQgsvwW
         0VTxvBIVkuhEcYJOWbQNAyE7nrJrYfb0FQRa7jXiqeG9laajg4mg8nQMwGCPSJWdLmFe
         RrLGncmxENlBvpgOL34DovXRPnoxIT/9QWg2kItVC7RlFN/2V0DW1BMzKHHxk7fe/c2w
         bABBeZbDqd8EVfYNNOEqbwo+o0nHw8SitkrzSNlXZK5Nyo942sRv414fCjt2B8JpXX6k
         07fVFnJ60J0AtsltVGxiRZVdyOBzZub77eu82sYPAzQbG3dhXvYf0Mw+ptA/TWQ2sRes
         vs9g==
X-Gm-Message-State: AOJu0YwEuZnHi5p5pLzflUPM57TwCD9jHT58nDpjYHBB+MmRI4Xi3aO1
        d86i4I2ivldCFatylZ1H0NIsG9HS2mzhOREJVq0=
X-Google-Smtp-Source: AGHT+IHpdE+SHUhlg41LDgR83N6jNh0Bs3AiiFpPYiktqU9+a3AFWX5KM2j0MLP9vhd632/I6QaBjA==
X-Received: by 2002:a05:6a20:1608:b0:161:ffbf:d949 with SMTP id l8-20020a056a20160800b00161ffbfd949mr1253550pzj.3.1699423992235;
        Tue, 07 Nov 2023 22:13:12 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id rr5-20020a17090b2b4500b002804af3afb7sm792350pjb.49.2023.11.07.22.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 22:13:11 -0800 (PST)
Date:   Wed, 8 Nov 2023 11:43:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/opp/debugfs.c:48:54: warning: '%d' directive output may
 be truncated writing between 1 and 11 bytes into a region of size 8
Message-ID: <20231108061308.jcoj4bjzv4m5pilx@vireshk-i7>
References: <202311061847.BOtfUmbQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311061847.BOtfUmbQ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-23, 18:41, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d2f51b3516dade79269ff45eae2a7668ae711b25
> commit: 46f48aca2e5aef3f430e95d1a5fb68227ec8ec85 OPP: Fix missing debugfs supply directory for OPPs
> date:   4 years, 11 months ago

This is a really old commit, are we running the test over it ? Or it is what git
bisect reported ?

> config: x86_64-randconfig-r025-20230725 (https://download.01.org/0day-ci/archive/20231106/202311061847.BOtfUmbQ-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061847.BOtfUmbQ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311061847.BOtfUmbQ-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/opp/debugfs.c: In function 'opp_debug_create_one':
> >> drivers/opp/debugfs.c:48:54: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Wformat-truncation=]
>       48 |                 snprintf(name, sizeof(name), "supply-%d", i);
>          |                                                      ^~
>    In function 'opp_debug_create_supplies',
>        inlined from 'opp_debug_create_one' at drivers/opp/debugfs.c:119:7:
>    drivers/opp/debugfs.c:48:46: note: directive argument in the range [-2147483644, 2147483646]
>       48 |                 snprintf(name, sizeof(name), "supply-%d", i);
>          |                                              ^~~~~~~~~~~
>    drivers/opp/debugfs.c:48:17: note: 'snprintf' output between 9 and 19 bytes into a destination of size 15
>       48 |                 snprintf(name, sizeof(name), "supply-%d", i);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I tried to reproduce it for ARM and don't see the warning locally. I saw a
similar one earlier (reported by the bot), which is already fixed:

make ARCH=arm64 O=../barm64/ -j8 CROSS_COMPILE=aarch64-linux-gnu- W=1 CONFIG_DEBUG_SECTION_MISMATCH=y

-- 
viresh
