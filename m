Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA85E80A7C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574384AbjLHPp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjLHPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:45:27 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B4010EB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:45:09 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c66418decaso1527126a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702050309; x=1702655109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSIhejMi2RvmJNFCsKZgxBFrupMMmn935wC4f2iCNQg=;
        b=SG5akY1mKeb173NWrMvDQNYMtzLFEBTnRw5d4TBLUBR6MBUf8wg6DSePX6Nj6AYPzK
         BwbTjWaoqW1SN4UKcKfdxZ1cSwljrgfUMF7qV4uA5HC9nRlx5iBrtoO+xR5mduXFHHlA
         09MrTvdWIMdebw/TQb314vdqqYA3+3Tme8dGdpCzZA5xWjdMD9L0Qc52dO73RjE+liyx
         sE4VpHXdGJAMFO/ygAX426ZAXiSYQyv3LG6ZwcDH9BZ2F3G4y3HUT+xi69Yx70QszT95
         IbUvhgiu8+1Y+XpYgTujSHT5x83T5Ov7QWXaayAoWt+phaO/efRSHlFMbWVQorCKVnlV
         297w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050309; x=1702655109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSIhejMi2RvmJNFCsKZgxBFrupMMmn935wC4f2iCNQg=;
        b=HM37wOWsaCa8/urQ0iK4ebt9imXzmcJOe3TXKhrnOlcd5WNevBN92oZf/pj706GkJH
         qkgeKv4h+Jd7NWoNIZXeXMeixsskJrV2nZZ/oYqIvGr2a58BEzh6St+G1wzm1kd1wieZ
         1lpDNC6NpP9W5kxZSk9sHlYUu29HU7PLaws7ut19XZsCVDD24gqNthyLdXdMja0YcVbL
         KscdAtqKPyMhxvYHCkIn5lSF8VPZaHmShrCmTOVP4FDnZN7FYsUqBU2N72aNpGLm72gu
         bVmN4D6q8Et2CoEGThzOSRrCTtSkklY9rrSyxBFGL+6/1QFk6x65i4Y6q2jwstDB3P7Q
         Or3g==
X-Gm-Message-State: AOJu0YzrEKWBkBbAja5hVEVHo0cD2Djpa4cz62zP7l7yFcI7DZ+m6r/c
        hMwatmn87MkNNc1ol4kAisZHvQ==
X-Google-Smtp-Source: AGHT+IGdUUbB++2LBRHDq+4gTXricXvOqgQFyCf+OZTByWhnSGPh/zvXwXZbFMSj/bMMd8fVtscIDQ==
X-Received: by 2002:a05:6a20:3ca3:b0:18b:ec94:deed with SMTP id b35-20020a056a203ca300b0018bec94deedmr208781pzj.45.1702050309405;
        Fri, 08 Dec 2023 07:45:09 -0800 (PST)
Received: from [10.4.166.75] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id fb32-20020a056a002da000b006ce7ed5ba41sm1698369pfb.55.2023.12.08.07.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 07:45:09 -0800 (PST)
Message-ID: <35bff89e-a984-42e3-a6e7-1933b12b6451@bytedance.com>
Date:   Fri, 8 Dec 2023 23:45:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] mm/zswap: make sure each swapfile always have zswap
 rb-tree
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
References: <20231206-zswap-lock-optimize-v1-1-e25b059f9c3a@bytedance.com>
 <202312082309.xvC0Rdd9-lkp@intel.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <202312082309.xvC0Rdd9-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/8 23:17, kernel test robot wrote:
> Hi Chengming,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 0f5f12ac05f36f117e793656c3f560625e927f1b]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/mm-zswap-make-sure-each-swapfile-always-have-zswap-rb-tree/20231206-174717
> base:   0f5f12ac05f36f117e793656c3f560625e927f1b
> patch link:    https://lore.kernel.org/r/20231206-zswap-lock-optimize-v1-1-e25b059f9c3a%40bytedance.com
> patch subject: [PATCH 1/7] mm/zswap: make sure each swapfile always have zswap rb-tree
> config: i386-buildonly-randconfig-002-20231208 (https://download.01.org/0day-ci/archive/20231208/202312082309.xvC0Rdd9-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312082309.xvC0Rdd9-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312082309.xvC0Rdd9-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/x86/kernel/asm-offsets.c:9:
>    In file included from include/linux/crypto.h:17:
>    In file included from include/linux/slab.h:16:
>    In file included from include/linux/gfp.h:7:
>    In file included from include/linux/mmzone.h:25:
>>> include/linux/zswap.h:53:43: warning: non-void function does not return a value [-Wreturn-type]
>    static inline int zswap_swapon(int type) {}

Ah, will fix to return 0 when !CONFIG_ZSWAP here.

Thanks!
