Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA287A8947
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjITQJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjITQJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:09:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A94B9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:09:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fbd31d9ddso5585667b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695226174; x=1695830974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZPdmXl4ZwuGt3eSBwgMVSxnCz69SpDGNBEX3pNmeW4=;
        b=dBGejAoiNfKlqcB9pU3BB1FsLB2r/BlAQUcI9iy6LZq7I2DdVJA/UwAFMxlZOn/Z+B
         kTGq/zI11AKO4BEUYQx0Db78V5bO5N+nFKI7MNRocKcrRyhd4CcASMeOh6xb7f5fgKCz
         ugnzDCxsJQ62TsnOs3UWlklgLILb2eN8/lF8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695226174; x=1695830974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZPdmXl4ZwuGt3eSBwgMVSxnCz69SpDGNBEX3pNmeW4=;
        b=Tbnw4wZWn1Q3ptUOduG2wdXaj3liJChElBTGIQjde6eAbXSRy17wb2hMXKqSG3oo3/
         jA+HK7eX1C3y1I+KkTs5O99gD25+13+K8D1gRxAP7ZytE9n4S1ELtZoo1grovVvcV3hX
         jr/yZQF1NHe+NbMsxb/MivU3/IpLOGypfoLv4wmQ6QmGNMp4VM4jOG3dCW7Boxu4Uspd
         wCuHzu4lij7B2cdoO1c4Q3Pl+E823aDgXvx/kvS1mAs0i1sjj3CguLa3VlqNaAqZmopU
         vkdmJAfFumU5FIYWgAzZlZ66lGPpFUPuLwcUq3px42TbwL/3xu2EK4ZQwcmXlP/G5sNT
         n48w==
X-Gm-Message-State: AOJu0YwEwhsbvSKaxSzFKCKXHg25iPz8KDiYvlaREe5IsJe8k94XLR0e
        51y4Om4rne//C/XgASemiiUPlQ==
X-Google-Smtp-Source: AGHT+IFZEbhAj0VF0cfiwS9CwelgZgX4SNQUZu5W0XXu7LEGDZAj+oplpFNBiJANw/y7//sKSq9U9w==
X-Received: by 2002:a05:6a00:8087:b0:690:f6a1:ae62 with SMTP id eh7-20020a056a00808700b00690f6a1ae62mr1544166pfb.23.1695226174549;
        Wed, 20 Sep 2023 09:09:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x23-20020aa793b7000000b0068bbf578694sm10668960pff.18.2023.09.20.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:09:33 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:09:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: include/linux/dma-mapping.h:416:36: warning: array subscript i
 is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'}
Message-ID: <202309200904.CEED70DA33@keescook>
References: <202309191958.UBw1cjXk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309191958.UBw1cjXk-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 07:27:26PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2cf0f715623872823a72e451243bbf555d10d032
> commit: df8fc4e934c12b906d08050d7779f292b9c5c6b5 kbuild: Enable -fstrict-flex-arrays=3
> date:   4 months ago
> config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230919/202309191958.UBw1cjXk-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309191958.UBw1cjXk-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309191958.UBw1cjXk-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/skbuff.h:28,
>                     from include/net/net_namespace.h:43,
>                     from include/linux/netdevice.h:38,
>                     from drivers/net/ethernet/marvell/sky2.c:18:
>    drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_unmap_skb':
> >> include/linux/dma-mapping.h:416:36: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
>      416 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
>          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/ethernet/marvell/sky2.c:1257:17: note: in expansion of macro 'dma_unmap_page'
>     1257 |                 dma_unmap_page(&pdev->dev, re->frag_addr[i],
>          |                 ^~~~~~~~~~~~~~
>    In file included from drivers/net/ethernet/marvell/sky2.c:41:
>    drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
>     2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
>          |                         ^~~~~~~~~

The .config has:
CONFIG_PAGE_SIZE_16KB=y
which makes PAGE_SHIFT == 14

#ifdef CONFIG_PAGE_SIZE_16KB
#define PAGE_SHIFT      14

ETH_JUMBO_MTU is:

#define ETH_JUMBO_MTU	9000

which forces "ETH_JUMBO_MTU >> PAGE_SHIFT" to be 0.

I think the right fix would be:

dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT ?: 1]

Thoughts?

-Kees

-- 
Kees Cook
