Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F045D7D5D81
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbjJXVuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjJXVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:50:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADB5D7F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:50:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ca74e77aecso1675995ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698184208; x=1698789008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUk/3FUrTP2O4nxINnBvX1NoZwU7c4mrwIneHTDtXz8=;
        b=ecZEhEWNeFWjXXZhmpUQxqgQXST3Pc9zkLw3mrVneHts2vbd/VahNRRr8KbUiSEN4g
         zsrzSYlJvaUxjgdvNncP533jdFysu9Uv1t2Mqt7/V+ysQmbSghDEKQA+0qXpSz1FV1Yw
         U4EKIt+Hk7tBzbH9Bw8fEYCpv7y2cxaWN5tQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698184208; x=1698789008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUk/3FUrTP2O4nxINnBvX1NoZwU7c4mrwIneHTDtXz8=;
        b=mSQET9Kl68G66RM855J0kQg7f46QdXk64g+ROWoMHDDsRvqNoEGFUc3cQpdDWSzhXG
         nD7BBBS+bwNmDrvT9AblV1hKNXOVtCLWZ4v/DTW6vZsh+A/aMl5y0P2V4z6hviT8D3TR
         lq6X/P7g8UdGZjs+2FB4/RQqa74BXI7Dkd0oZ0fn8GQEqg7050goMJSibAI+xK4lH5O2
         GOCSf/QaNDDHp/lL7ZfBTosWPFWttt3S7Pa4PrBllGjGL/+T7qTGzapa56Y9/NTB+4tv
         U3bAfzm3nFnCA/oGQMPlVx5ZmW01ULu/sYjQxa8SGNwjfc6VHiI/isC1FPOrlf+fp7Wz
         IVRQ==
X-Gm-Message-State: AOJu0YyZ3n5MKzMmk5/3J0DpKzYXsheysxZWBue4B6Q0/X+Oyw3mgfpT
        KqVXzoz84DGvV8P/CnQwAkNZCg==
X-Google-Smtp-Source: AGHT+IF9lyQ5nSycCSb10w5BnVo03pMKn2LFjJp83sLHplgq6hXesFpem/RWipRfu7bv0jUOjIuR1w==
X-Received: by 2002:a17:902:e54e:b0:1c9:ddd8:9950 with SMTP id n14-20020a170902e54e00b001c9ddd89950mr17532154plf.21.1698184208126;
        Tue, 24 Oct 2023 14:50:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k20-20020a170902ba9400b001b891259eddsm7867560pls.197.2023.10.24.14.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:50:07 -0700 (PDT)
Date:   Tue, 24 Oct 2023 14:50:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Remove initialisation of readpos
Message-ID: <202310241449.7E91697@keescook>
References: <20231024145600.739451-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024145600.739451-1-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 03:55:59PM +0100, Matthew Wilcox (Oracle) wrote:
> While powerpc doesn't use the seq_buf readpos, it did explicitly
> initialise it for no good reason.
> 
> Fixes: d0ed46b60396 ("tracing: Move readpos from seq_buf to trace_seq")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Yeah, looks right -- it'd even be right if the member still existed. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
