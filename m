Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E97D05A9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346755AbjJTAEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346721AbjJTAEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:04:37 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE6C181
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:04:34 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so266583276.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697760273; x=1698365073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZE3cc6e0ypcAqaFcINIc2gZj+EhE8lhjLqWQSkY/ho=;
        b=mztIr8pNp6Epy4koEz62Tsg5/XZHiYPUUGt/Zj3yNUjTeIu2XCyrH3vhxZo9vo/Z+D
         Gsgj5HUa3dv4ISEOwsq9gfcUko1TxBwdeWlbgGUkxrpG6L9ObOyCng3zGfp2kzLioedl
         K67KNCK3IXmY1f+iksdSM6WP6nM0OuhpwYHzAv3byl0JQUj5V5BLV/FbpqynRZ9qEY9L
         XFGRCaqVc2aMDWM1PeGe6wGqf9EKSu/+i136EUmv5ZAEV5NTE/Qb8ozrKvQAu0r2aBqN
         cUzVyQcW4QFoDc6M+nr0+mknYLbhuGpr6pVpro5QDWFoccqO8uYJy6gIR1/B68YS0OVL
         B5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697760273; x=1698365073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZE3cc6e0ypcAqaFcINIc2gZj+EhE8lhjLqWQSkY/ho=;
        b=VmiG8yKHwh6eMsnTs2RLrIc3iSaTJZvH/BQ7+3L/j4ExYDGoqAhQC/iBI4CrMMGAno
         juOuBDHCtc5hBflBlbb81tIrUQFIyHyI4bh0cHK62nvqHK72f0ITmq6NROjWR8e0aDl6
         85/Q+mwUrhmXnLCLCbh/Rk6ICgray5AjqO9a0C838Gbx6ixzI4zqwIbotdi/hvUik4VD
         steS+z4MIC6DEwPnpg7uZZcWtRaUqcE0wu5D+ZvT0iHe4pMd0bNtnvwbpQZDaOIL9Taj
         QWu3olxbDgwKAnFnuudNcOUoNDjaJlgw9X8/uXf9nPoqTxpPnO4SiIciDT7leI1Jnp5W
         G+FQ==
X-Gm-Message-State: AOJu0YxHkqKxhybYLfUd5Eazgphz65AbPRJVd/mlxII66Wdttgf6ntft
        YHzYaKlQSdU5QBap7bmcGrMfoQ==
X-Google-Smtp-Source: AGHT+IH+iL5kcJERANbI1DhlZ2XbKBVAv5uNec+m11U5QkIoDBYLOjxKEvLjBXzzp8CGx/TuA7DQig==
X-Received: by 2002:a25:d650:0:b0:d9b:e407:663f with SMTP id n77-20020a25d650000000b00d9be407663fmr366426ybg.15.1697760273484;
        Thu, 19 Oct 2023 17:04:33 -0700 (PDT)
Received: from ziepe.ca ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id p85-20020a254258000000b00d7e339ada01sm173990yba.20.2023.10.19.17.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 17:04:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qtd0A-003Fme-A9;
        Thu, 19 Oct 2023 21:04:30 -0300
Date:   Thu, 19 Oct 2023 21:04:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/infiniband/sw/rxe/rxe_mr.c:106:9: warning: array
 subscript 0 is outside array bounds of 'struct sg_table[0]'
Message-ID: <20231020000430.GE691768@ziepe.ca>
References: <202310192300.lurP44yG-lkp@intel.com>
 <57edd968-91d7-41f9-8a29-e86d8f583efa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57edd968-91d7-41f9-8a29-e86d8f583efa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 11:22:00AM -0500, Bob Pearson wrote:
> On 10/19/23 10:33, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   dd72f9c7e512da377074d47d990564959b772643
> > commit: 592627ccbdff0ec6fff00fc761142a76db750dd4 RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray
> > date:   9 months ago
> > config: sparc-randconfig-c023-20211015 (https://download.01.org/0day-ci/archive/20231019/202310192300.lurP44yG-lkp@intel.com/config)
> > compiler: sparc64-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310192300.lurP44yG-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202310192300.lurP44yG-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_mr_fill_pages_from_sgt.constprop':
> >>> drivers/infiniband/sw/rxe/rxe_mr.c:106:9: warning: array subscript 0 is outside array bounds of 'struct sg_table[0]' [-Warray-bounds=]
> >      106 |         __sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    cc1: note: source object is likely at address zero
> >>> drivers/infiniband/sw/rxe/rxe_mr.c:106:9: warning: array subscript 0 is outside array bounds of 'struct sg_table[0]' [-Warray-bounds=]
> >    cc1: note: source object is likely at address zero
> > 
> > 
> > vim +106 drivers/infiniband/sw/rxe/rxe_mr.c
> > 
> >     98	
> >     99	static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
> >    100	{
> >    101		XA_STATE(xas, &mr->page_list, 0);
> >    102		struct sg_page_iter sg_iter;
> >    103		struct page *page;
> >    104		bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
> >    105	
> >  > 106		__sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
> >    107		if (!__sg_page_iter_next(&sg_iter))
> >    108			return 0;
> >    109	
> >    110		do {
> >    111			xas_lock(&xas);
> >    112			while (true) {
> >    113				page = sg_page_iter_page(&sg_iter);
> >    114	
> >    115				if (persistent && !is_pmem_page(page)) {
> >    116					rxe_dbg_mr(mr, "Page can't be persistent\n");
> >    117					xas_set_err(&xas, -EINVAL);
> >    118					break;
> >    119				}
> >    120	
> >    121				xas_store(&xas, page);
> >    122				if (xas_error(&xas))
> >    123					break;
> >    124				xas_next(&xas);
> >    125				if (!__sg_page_iter_next(&sg_iter))
> >    126					break;
> >    127			}
> >    128			xas_unlock(&xas);
> >    129		} while (xas_nomem(&xas, GFP_KERNEL));
> >    130	
> >    131		return xas_error(&xas);
> >    132	}
> >    133	
> > 
> 
> Jason,
> 
> Can you make sense out of this? The marked line (was 106, now 101)
> seems completely innocuous.

I think this is the key:

> >    cc1: note: source object is likely at address zero

So something is wrong with the call chain passing sgt into this
function, at least the compiler thinks it is an empty allocation.

Jason
