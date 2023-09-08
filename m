Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049427988BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243918AbjIHOaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243964AbjIHOa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:30:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352C11FDC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:30:19 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-414e78cdc11so15207321cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 07:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694183418; x=1694788218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xuLwfgsvmAUWs7vxqHGdnIpvRxY+S+flrjEPUNwXBKI=;
        b=M4WarCHtCh+dV73cMhkCDNdExz0FQuZ5zqQiAClVRzG9FscGFh5VcQBlvTeaK1Qxbt
         TjYokDGnuL1Oc3NBrwjSi/feR30+0YmthFWYwIFtkqYqH6Xx52uG1IJ+WcY+BqJZzlus
         kDLGOOT/hBLAZvHhShoY7T2WEAxiYceKmlO+ZInOD7guzBjussyeaRtoyE/qWmUDkU6e
         XINmNS/H61q+8aq3quZytrw5HeQeBjI2cWUV5AlebA+QyYOlXmB3fhrGbTulAuLYTtKn
         B81b0k6Z8gOYM3RNv3O9fGHmB3YEH/fQUQs5B26AIInexjkYhc7ri07NqmkAuOJEvXTs
         n+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694183418; x=1694788218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuLwfgsvmAUWs7vxqHGdnIpvRxY+S+flrjEPUNwXBKI=;
        b=RGjVooSvixy5BrhJmCnAYmnefjLrQWLQmnWTdbsItH06cm/MZt/BJJ60ISr4zc6ETi
         X+j7vFbMGMc7eBW2jy7eqh6UuWdQ6C+7gGxbnuG/0HmugDj2t2j97xnEeByx1w4wZ85g
         P4um68asmRAW716mW8mgeeFW6wtdBvSc19KG4Phj5nBoVLgPQJY9DwY8d/Y+7kEkfGMB
         bVCxP1nxscj/NieU4YIYXm/0Stc0/UXmrMZrzBeywD2bmsu8Fo0CLeU4ja8Wsukyt7Oy
         4KVgmZAx6e3lp8JCw4Bxt3ZixbZd6vhH7PTICwAWrukyDEb8zRQIG+W77uATfRb3koYK
         XIPQ==
X-Gm-Message-State: AOJu0YyPCgByRh2K1/v7OdR3ayizuBszrH5bo2+79/SjMXDcuGc31Yet
        DIJMDC//k2R2rU9e6BPN3qoVlQ==
X-Google-Smtp-Source: AGHT+IFn+3AwcxfCceLAeJPw+uVKytit2Yc1k7eETIMBnv1PTC1MyLerbBnm/iqfTL7DAhdHs0W3DA==
X-Received: by 2002:ac8:5911:0:b0:412:2dd3:e0fb with SMTP id 17-20020ac85911000000b004122dd3e0fbmr3222450qty.5.1694183418289;
        Fri, 08 Sep 2023 07:30:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id x19-20020ac85393000000b0041511b21a7csm64615qtp.40.2023.09.08.07.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:30:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qecUx-001IWw-RI;
        Fri, 08 Sep 2023 11:30:15 -0300
Date:   Fri, 8 Sep 2023 11:30:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH for-next v6 6/7] RDMA/rxe: Add support for
 Send/Recv/Write/Read with ODP
Message-ID: <ZPsv98Mr6ogzchCL@ziepe.ca>
References: <cover.1694153251.git.matsuda-daisuke@fujitsu.com>
 <f15b06b934aa0ace8b28dc046022e5507458eb99.1694153251.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f15b06b934aa0ace8b28dc046022e5507458eb99.1694153251.git.matsuda-daisuke@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 03:26:47PM +0900, Daisuke Matsuda wrote:
> +static inline bool rxe_odp_check_pages(struct rxe_mr *mr, u64 iova,
> +				       int length, u32 flags)
> +{
> +	unsigned long lower, upper, idx;
> +	unsigned long hmm_flags = HMM_PFN_VALID;
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +	struct page *page;
> +	bool need_fault = false;
> +
> +	lower = rxe_mr_iova_to_index(mr, iova);
> +	upper = rxe_mr_iova_to_index(mr, iova + length - 1);
> +
> +	if (!(flags & RXE_PAGEFAULT_RDONLY))
> +		hmm_flags |= HMM_PFN_WRITE;
> +
> +	/* xarray is protected by umem_mutex */
> +	for (idx = lower; idx <= upper; idx++) {
> +		page = xa_load(&mr->page_list, idx);
> +
> +		if (!page || !(umem_odp->pfn_list[idx] & hmm_flags)) {
> +			need_fault = true;

Again you don't need the pfn_list and rxe should perhaps ideally find
some way to disable it since we store struct pages in the xarray.

This could also be a xas loop

Jason
