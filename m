Return-Path: <linux-kernel+bounces-3028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803481664C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A99D1C20852
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0096D19;
	Mon, 18 Dec 2023 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4+pcFjP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4506FA4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-20308664c13so2069551fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 22:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702879848; x=1703484648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3r99F4vTwCpnbqDKoMm/OyT56eRkkUx331L3tjXnj14=;
        b=e4+pcFjPQVwDMQr1sA6f7R823SkGqtUvWR+IDgNK5o1r3uvCQUL6f1ajRVinj+d+qb
         4LS47g02XPnuV7X9E+rt6G0YOmJWr8OK7TRReIzNpAJ9A2c+W3/dXS3qTwbETcqMo5T3
         bgueJfwzC/CPn3Oz5+VQouuZdH/eoV1oIxs/DGgaQ3ApWiG76AMGPCqGATT54IbYwmB9
         o5Etm1IBONbcQ6YFnZEM9spQWZb7qflFt8EfVy4s5ymHG5Ykb6npePd1R/u42bXOZJfx
         RMhIWKFoNvN8KDUzx3KGwPA2Iw+yEpzyUruA99M6BM2Cxm6ScP2I8OMjeXXnmyZEeWnd
         foBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702879848; x=1703484648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3r99F4vTwCpnbqDKoMm/OyT56eRkkUx331L3tjXnj14=;
        b=vRzyWyXcD4J+dJhsYf4HpvIww/IK/X3Y3y4GeTe48D7ahyH8bBVtVAwalic0KLY3IL
         swbV/Jqsq1dRepxCbwXjFlQ/JnGFo5LWrbF1U0YuH+BVmaoat66L/RpPGNToLi7pCPGB
         cUPefCTKTk8zn68D2Yii1AdflxMChdkKm7mOeZrs+/lnwT7CFtdc9TwkvaM19Iya9uUj
         tBmWszBgT5mjE+/UNQmvdWtmtyqbNBNTsJfkhxDu/B+lc03oI8P5ftfna7JBiZJ3VTx5
         DNgtwi+kwVLsd1tPU5EESR+KDn5EgvTWdizUjCw/+Idjt8oJj+sIu26F7xSQcEAmZCjD
         L1TQ==
X-Gm-Message-State: AOJu0Yw8/4fdnlWH2b+dcoAXC06nQq9IyWUu/R8bpMANYZ4kkHmhdJqT
	l9k8pu6oVqfaD7Nzzu72Dr9+weYPiVRtzKbCN4A=
X-Google-Smtp-Source: AGHT+IE+lIfbWXYxzLYjjV/vlFd2O8QI+jCclyKcPJtNl/b2FqhJXGfuATkJjZi8mc/w4YBBTes30g==
X-Received: by 2002:a05:6870:14d3:b0:203:1c85:21fc with SMTP id l19-20020a05687014d300b002031c8521fcmr10560044oab.57.1702879848699;
        Sun, 17 Dec 2023 22:10:48 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b005c1ce3c960bsm17065767pgg.50.2023.12.17.22.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 22:10:48 -0800 (PST)
Date: Mon, 18 Dec 2023 11:40:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/opp/debugfs.c:48:54: warning: '%d' directive output may
 be truncated writing between 1 and 11 bytes into a region of size 8
Message-ID: <20231218061046.jurwf7j2wlja6jgf@vireshk-i7>
References: <202312170608.s9xI4TQb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312170608.s9xI4TQb-lkp@intel.com>

On 17-12-23, 06:23, kernel test robot wrote:
> Hi Viresh,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
> commit: 46f48aca2e5aef3f430e95d1a5fb68227ec8ec85 OPP: Fix missing debugfs supply directory for OPPs
> date:   5 years ago
> config: x86_64-randconfig-a006-20230623 (https://download.01.org/0day-ci/archive/20231217/202312170608.s9xI4TQb-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312170608.s9xI4TQb-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312170608.s9xI4TQb-lkp@intel.com/
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

Can someone check if this happens on mainline too ? I think this is a
False report.

-- 
viresh

