Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7497B4B94
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjJBGm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjJBGm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:42:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CBEBC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:42:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3247cefa13aso5734581f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 23:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696228941; x=1696833741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFLmBMbTAf5mYpVSeF0tgLxlIm+hQtraBWqw0SVaZ1s=;
        b=naGNygrWouv1YEjdJBD+4287aMp5/GFRojK0NrGzzsdHpmff/N6Io1fiYjlkMD4aw6
         00oet6LnyjwPxQbu99r1+fu5kyqYPenaYRmQeQ6ffkTh1AE5RtYnPS9ZXtLmiUWHOhhL
         OJuaYcvCpUtBNYQn2bL2T/6pg6EP+v8C6YMM8NgTfbGPm2CH7fqmZoujoJyvNxEow2HQ
         mHoXB89mF/4n98+PCVqylfjxp/fHkkho+eANT53vHan+RFgKiy+v1kUeFJWuwjvoKvOp
         VNpdRNy01htzmY1nnH2VE7SDYyZJFveOVXtMORoIjuhv5j04wfKD9Ckx+uHxMOYL+zVg
         xsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696228941; x=1696833741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFLmBMbTAf5mYpVSeF0tgLxlIm+hQtraBWqw0SVaZ1s=;
        b=qdiAl/xvVn/JygNJIJC8ewuEb8GWKNchvOXBJoHUIjZtamqM1iyYoJIr/6v95zwTvi
         RLxwIwncxf2iOPPRm58KoqpQ0slD33ER2YLLCMNWAeG9S1XQla9BxROKNxyXDTOByOq8
         W0YuoBWj1au/C0ri6b2Pm6at7ijL96asnmikXLRBT3y5symv8uRW7sli59uHEbl8k+L8
         OUzYK5NMKXLbbjDgiX6/7AizMWVdGZOfaxa6eVATVnXtZ8xqDoYJi75Qttu19BUz5s35
         mCjOMXTgfy77gRzDbKyInkL8EzcwD7OhsLf9qhB8uOEsa1YsRV3utvJOTsALfTLZSOuS
         IaPA==
X-Gm-Message-State: AOJu0Yz31S4/9JIOfuWKQycaFGb9y/glHZ42m+GxgblmCR2nc/A0qW4b
        buvR4ly3ZudUKki+tHb5otyyGQ==
X-Google-Smtp-Source: AGHT+IG5F6WCA+givsf9KFa40Uq2QQ0EtyZVPcp2/kezx1bCSCz837j2NkrcYNJnzvEwO3xWwac9nA==
X-Received: by 2002:adf:f085:0:b0:320:77f:a97c with SMTP id n5-20020adff085000000b00320077fa97cmr9346986wro.63.1696228941280;
        Sun, 01 Oct 2023 23:42:21 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d594b000000b003140f47224csm9346368wri.15.2023.10.01.23.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 23:42:20 -0700 (PDT)
Date:   Mon, 2 Oct 2023 09:42:06 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] bcachefs: Use struct_size()
Message-ID: <ff682afb-a914-4cd7-8d19-202a6cb778de@kadam.mountain>
References: <120b638f99b088f91d5a4491c800463c554e70b8.1696144401.git.christophe.jaillet@wanadoo.fr>
 <7ae7737e-e32c-e9e7-880c-cafc240e7c33@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae7737e-e32c-e9e7-880c-cafc240e7c33@embeddedor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 09:23:17AM +0200, Gustavo A. R. Silva wrote:
> 
> 
> On 10/1/23 09:13, Christophe JAILLET wrote:
> > Use struct_size() instead of hand writing it.
> > This is less verbose and more robust.
> > 
> > While at it, prepare for the coming implementation by GCC and Clang of the
> > __counted_by attribute. Flexible array members annotated with __counted_by
> > can have their accesses bounds-checked at run-time checking via
> > CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> > strcpy/memcpy-family functions).
> 
> I would prefer this as two separate patches.
> 

I kind of feel like it's all part of one thing.  It's easier to review
as one patch.

regards,
dan carpenter

