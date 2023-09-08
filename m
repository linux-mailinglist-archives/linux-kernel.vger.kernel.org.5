Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB1C7988A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243855AbjIHOZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbjIHOZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:25:53 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CBF1BF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:25:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-770ef1f4513so5615085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694183091; x=1694787891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLb+//P8hXuhyiy1tYEU/lgNsD4NXkZLeS/D3BLtHFA=;
        b=RMs3BUF9PKj0UGnITdlC+hWjL4HsDi0vbk72B5BoV54JhXEIIS3B84bEeqS7xX31pJ
         JsWH0RTyfUnQA/qLPBHlRN548nVCuwPuAllshQ187QCV31DQ6fbALeuWUJUZs+k2wg9W
         j+Pp0fXepCZ4a1cKTylXac+AqgIAaVULMfq3rl9fVH/x78TOVJ7FMsO0SmvwZwzVYjb2
         CqMr/aGP2lky8zhm3IGRWUoMLgqxRj/7oQA08Pp0O4477mDpIo8dCin62Nmo5xjABApS
         U+UR9SOPRo1FibEDhpEZAYsr6l33Uzjf02DaEYyhyR7PrUDdSBg9HMHPjdruYanz8zoF
         Od3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694183091; x=1694787891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLb+//P8hXuhyiy1tYEU/lgNsD4NXkZLeS/D3BLtHFA=;
        b=IUzlCSeX9YzYPdHcwcAy5gk+gzKA8dk4LYJJ4y91TNhLU7lKQNUb+r484fFvWS8UB7
         tH2YTfJ7gFZQQVuHuaTQU6GwDhwy/BelPKRx6mNn7O++GLFzQqc+qJyW0EzCRjbCgoKA
         lhk87U81yK9Of8xoVKSZMy5yXHX6aqwYt5mYCduA7qaBGgVt9FLi3N6uvz5kAws0ehAx
         LqTe31SOtPc/54ZLcYxz1ToClTQPVNZxLD0djy6nQC6Vo1qOJqcxETnuaWT8oF6L+AWn
         S2cP+9iXsrnHhyTgcGSM8DHIGT/e3cL1RKQM4GtQumB14jqWoPVYSIdz2GpHEybLouax
         S2lQ==
X-Gm-Message-State: AOJu0YzVCLp9gF57YzDo5o9r3ciEXaElOAgnQlsKMAnIKDFxPiGuGLqq
        gsvKkSsczqeKIfkmGRI7N5bDjQ==
X-Google-Smtp-Source: AGHT+IEAttA6l6imvc/t0hlnv+yee8e+U3gqd02dV9cS7adwX9rfD+eUPDxf5v7iqMHe/dVQfTzXmw==
X-Received: by 2002:a05:6214:84f:b0:63d:4a9b:b29f with SMTP id dg15-20020a056214084f00b0063d4a9bb29fmr2451336qvb.65.1694183091101;
        Fri, 08 Sep 2023 07:24:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id e17-20020a0cf351000000b0064f50e2c551sm743246qvm.1.2023.09.08.07.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:24:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qecPh-001ITv-MR;
        Fri, 08 Sep 2023 11:24:49 -0300
Date:   Fri, 8 Sep 2023 11:24:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH for-next v6 5/7] RDMA/rxe: Allow registering MRs for
 On-Demand Paging
Message-ID: <ZPsuscPwNslStltB@ziepe.ca>
References: <cover.1694153251.git.matsuda-daisuke@fujitsu.com>
 <3fb02f58aa660d2d4a01bb187ce683eee23a138f.1694153251.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fb02f58aa660d2d4a01bb187ce683eee23a138f.1694153251.git.matsuda-daisuke@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 03:26:46PM +0900, Daisuke Matsuda wrote:
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index 834fb1a84800..713bef9161e3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -32,6 +32,31 @@ static void rxe_mr_unset_xarray(struct rxe_mr *mr, unsigned long start,
>  	xas_unlock(&xas);
>  }
>  
> +static void rxe_mr_set_xarray(struct rxe_mr *mr, unsigned long start,
> +			      unsigned long end, unsigned long *pfn_list)
> +{
> +	unsigned long lower = rxe_mr_iova_to_index(mr, start);
> +	unsigned long upper = rxe_mr_iova_to_index(mr, end - 1);
> +	struct page *page;
> +	void *entry;
> +
> +	XA_STATE(xas, &mr->page_list, lower);
> +
> +	/* ib_umem_odp_unmap_dma_pages() ensures pages are HMM_PFN_VALID */
> +	xas_lock(&xas);
> +	while (true) {
> +		page = hmm_pfn_to_page(pfn_list[xas.xa_index]);
> +		xas_store(&xas, page);
> +
> +		entry = xas_next(&xas);
> +		if (xas_retry(&xas, entry) || (xas.xa_index <= upper))
> +			continue;
> +
> +		break;
> +	}

while (xas.xa_index <= upper) {
      xas_store(&xas, hmm_pfn_to_page(pfn_list[xas.xa_index]));
      xas_next(&xas);
}

Again no need for retries

Jason
