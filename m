Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14D578DF77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242821AbjH3TMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245212AbjH3Osq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:48:46 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C49FF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:48:43 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso83806121fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693406921; x=1694011721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0s5rdZ1FiTFkxNksF6bbHJ9HKt0mAK3Fjc6AoSjYvk=;
        b=PYHG4ONBwLQw5Ra5s8YGR+F7DIdVvdg4isyAJn122P8+QoGOroUvBBY/v5itx6wtSy
         1gY+8+lj1t1XfgTb0dArFUF/NOF9qVTmz+fpBu+5SGDMkpJl61J23efrWTfGdNJJBef4
         EW9Y7YTQYbJmavrGOu06L+y+dGtx1y5WIv+ieNHkInG3tgz3bNGnOR3kVknqSlRlrRZa
         TX3hFhzL4tZftTDE6e6Sbz+I/Ng6bzExX9WzD60YFy9D7gkOonwrpHIWdQ3R2sbYCSpy
         J+cAJ3lZET0wIPiBwr1EwHPAOI2kyTqZEVdgtQseYX2OkGqsshSGZN6usgSWIIX2aaig
         mggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693406921; x=1694011721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0s5rdZ1FiTFkxNksF6bbHJ9HKt0mAK3Fjc6AoSjYvk=;
        b=f21cldPk/LzodRLkwrYTSKsD0wiBTwVwUWsroQCh7jCucd3KNTJ7rbWHPyLYxVT+Gm
         EzlSiMyLNXrmN03ICc53hydnviZYChNvWBNdkpfQV5FtQu9Mz51lpo447eET3B/qUiFX
         /+GF94azlxO2q8OYntwuk2MglcQKjS3gqI7+0xl9ULc2RDD2TIeLBtsPbhy0dfHnh9Ev
         cbyfFfY9ZrJN8j+knWNe3shTKWJYEwhbI5PqAjPmtzgH4qTXaUH4Y0luKY83uPwVhGW9
         yL0kbCE4+/VzN5ApDy4zmIuWU0xkN8esQOTlASU3zzzQq02HjC/PlsBtSmmLhKPtvcDc
         A12g==
X-Gm-Message-State: AOJu0YzZ/qeMwvxYQFkWbJ0QifgFt7sX8nPG0/HR8PveFpR8TnrLiSjv
        q8djo9Sb/dh0eWNwFGUsowc=
X-Google-Smtp-Source: AGHT+IENIjdVHjEuVjroRVntHbePkfsyv+44mTXRHE3Eb7WYnwxYJ/210xRyEX6YKYcVkcvqFZs7+g==
X-Received: by 2002:a2e:9d8d:0:b0:2bc:f41a:d9c6 with SMTP id c13-20020a2e9d8d000000b002bcf41ad9c6mr2012590ljj.0.1693406921097;
        Wed, 30 Aug 2023 07:48:41 -0700 (PDT)
Received: from pc636 (host-90-235-3-170.mobileonline.telia.com. [90.235.3.170])
        by smtp.gmail.com with ESMTPSA id z4-20020a2e7e04000000b002b9ff8450aesm2574689ljc.91.2023.08.30.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 07:48:40 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 30 Aug 2023 16:48:37 +0200
To:     kernel test robot <lkp@intel.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Message-ID: <ZO9WxbYUVDfak/5H@pc636>
References: <20230829081142.3619-5-urezki@gmail.com>
 <202308292228.RRrGUYyB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308292228.RRrGUYyB-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:30:19PM +0800, kernel test robot wrote:
> Hi Uladzislau,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Uladzislau-Rezki-Sony/mm-vmalloc-Add-va_alloc-helper/20230829-161248
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230829081142.3619-5-urezki%40gmail.com
> patch subject: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
> config: csky-randconfig-r024-20230829 (https://download.01.org/0day-ci/archive/20230829/202308292228.RRrGUYyB-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230829/202308292228.RRrGUYyB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308292228.RRrGUYyB-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    mm/vmalloc.c: In function 'vmap_init_free_space':
> >> mm/vmalloc.c:4506:45: warning: ordered comparison of pointer with integer zero [-Wextra]
>     4506 |                 if (busy->addr - vmap_start > 0) {
>          |                                             ^
>
Right. I will fix it. We should cast the busy->addr to unsigned long.

--
Uladzislau Rezki
