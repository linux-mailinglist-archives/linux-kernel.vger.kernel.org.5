Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40B57CFF62
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjJSQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjJSQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:22:04 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F49B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:22:02 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1e5bc692721so4613061fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697732522; x=1698337322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8Z8b47IL35J0M8IzMmQ/m6Z3gKcDDxbyFomY62RCb8=;
        b=XMAjsQzuSGKR8YV/BIezT2T4eTGLjCNLgSu2JslXkiEK8jShRawfb/V21xVMG8jOxG
         MBFFUl7kUhneuo3Go9k/mqrRo/6nKt9x27tt34kERixidPWOtTZtjZ9sbaLgwaQRT8H5
         hdoSXjXuV/dPFT8BlOJpL8vEcZJoQoaR9RYH0MQCTFmnJuSJK+bNrBiYBvrRNGKpiVB0
         DJUzhg3IV0GxlwhQf3iL0AadY4hoN0WZkmeD2oHfS+ZJp7vAmYWXb31zUAtVm1MknaIQ
         C/Yer6C4gS8zLB4h1dX5ZRS87IqwM1EhBXY+Cd/TQHtetm9jIpDVgcFwIkaqE8uEfgLy
         SDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697732522; x=1698337322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8Z8b47IL35J0M8IzMmQ/m6Z3gKcDDxbyFomY62RCb8=;
        b=Ugbb5+ocwf1xvsZdxMFaaxTHcpUyaOj1qWHxWyduSEpPDgvQscuV9apkbtwqJElXpl
         u6+8VlBhR3Xc/F5qpPTyFMx9fEs2pxR8BrJMkFN9Ac+HGhm+min+Yu7lXgE5TQIwPSiz
         msVmQgGbDh0Sdk96SwsIzuazoiw2bggFmlLxYeapvCC7GprfzS28UUr7LqN02fBFtLsy
         RnnCpurfkTvorIsFJXZnYdGxGEWRNh/pJ6YYg9kNsQBvT88jb033tCiofJ+HAHGZxea4
         axQGT0kcjxT0bPQF6Q4ZBMXpMM5eLxr//kWJxDgfXoddCuc8dthmfApnU8KZKztQQToJ
         h5ZQ==
X-Gm-Message-State: AOJu0YzkgnyOb58bICS4iqsYbph1FbAdfyi1KzbG+C67yO5IVAS5Yh3S
        jCf/3Vo4kMaYRsMARJlrfcw=
X-Google-Smtp-Source: AGHT+IEl8pPGIlMQIftnWiLzIBTyF12kFWseLWTw3rt22qly96DW3/+9l09R2o/4R3ur2kg0rrhXaw==
X-Received: by 2002:a05:6871:600c:b0:1d6:567c:deb4 with SMTP id qx12-20020a056871600c00b001d6567cdeb4mr3451672oab.42.1697732521863;
        Thu, 19 Oct 2023 09:22:01 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:1569:5535:218a:c00c? (2603-8081-1405-679b-1569-5535-218a-c00c.res6.spectrum.com. [2603:8081:1405:679b:1569:5535:218a:c00c])
        by smtp.gmail.com with ESMTPSA id ec44-20020a0568708c2c00b001e9dc5c73e4sm1214937oab.31.2023.10.19.09.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:22:01 -0700 (PDT)
Message-ID: <57edd968-91d7-41f9-8a29-e86d8f583efa@gmail.com>
Date:   Thu, 19 Oct 2023 11:22:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/infiniband/sw/rxe/rxe_mr.c:106:9: warning: array
 subscript 0 is outside array bounds of 'struct sg_table[0]'
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <202310192300.lurP44yG-lkp@intel.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <202310192300.lurP44yG-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/23 10:33, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dd72f9c7e512da377074d47d990564959b772643
> commit: 592627ccbdff0ec6fff00fc761142a76db750dd4 RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray
> date:   9 months ago
> config: sparc-randconfig-c023-20211015 (https://download.01.org/0day-ci/archive/20231019/202310192300.lurP44yG-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310192300.lurP44yG-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310192300.lurP44yG-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_mr_fill_pages_from_sgt.constprop':
>>> drivers/infiniband/sw/rxe/rxe_mr.c:106:9: warning: array subscript 0 is outside array bounds of 'struct sg_table[0]' [-Warray-bounds=]
>      106 |         __sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: note: source object is likely at address zero
>>> drivers/infiniband/sw/rxe/rxe_mr.c:106:9: warning: array subscript 0 is outside array bounds of 'struct sg_table[0]' [-Warray-bounds=]
>    cc1: note: source object is likely at address zero
> 
> 
> vim +106 drivers/infiniband/sw/rxe/rxe_mr.c
> 
>     98	
>     99	static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
>    100	{
>    101		XA_STATE(xas, &mr->page_list, 0);
>    102		struct sg_page_iter sg_iter;
>    103		struct page *page;
>    104		bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
>    105	
>  > 106		__sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
>    107		if (!__sg_page_iter_next(&sg_iter))
>    108			return 0;
>    109	
>    110		do {
>    111			xas_lock(&xas);
>    112			while (true) {
>    113				page = sg_page_iter_page(&sg_iter);
>    114	
>    115				if (persistent && !is_pmem_page(page)) {
>    116					rxe_dbg_mr(mr, "Page can't be persistent\n");
>    117					xas_set_err(&xas, -EINVAL);
>    118					break;
>    119				}
>    120	
>    121				xas_store(&xas, page);
>    122				if (xas_error(&xas))
>    123					break;
>    124				xas_next(&xas);
>    125				if (!__sg_page_iter_next(&sg_iter))
>    126					break;
>    127			}
>    128			xas_unlock(&xas);
>    129		} while (xas_nomem(&xas, GFP_KERNEL));
>    130	
>    131		return xas_error(&xas);
>    132	}
>    133	
> 

Jason,

Can you make sense out of this? The marked line (was 106, now 101) seems completely innocuous.

Bob
