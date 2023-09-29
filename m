Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F8B7B3AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjI2TXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjI2TXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:23:19 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81351B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:23:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c724577e1fso45008915ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015396; x=1696620196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uITMbz4SVXsN3h2p6aW3e9TM2Nhes+MRerhsiPaKZNY=;
        b=AbbVozCPWIk1zV6cZUH5CSaZpt7rK1BnPE1Ux7/ha8/NLhTBab64ak5Ad8jvl/S1B3
         ICGZ37cXj0jZVuWNTfPmWfj1RQFV9x0WyHo0YD+W3qc9g6qfxrIFEgkTeBTdGv6IBV3X
         c+F/oyGPtFczP67f76G7q3J3LJkIOJ/HYe+EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015396; x=1696620196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uITMbz4SVXsN3h2p6aW3e9TM2Nhes+MRerhsiPaKZNY=;
        b=FgCgCX2UiE5UqYXk3fdnftYgDW4qz2dpu+p8aCuuQ9KHlFNbgLlYYwjPT0lk9GTlDQ
         1nT2lYpyWKs3lro+t01JyiAT9o0+WZqr0MuNMZ+fcesPpq1UME/w/+xuYhPpa0MIhEvY
         E+p+xDww2GykjL60LbFiJ30u7l0BxSg1XPDAtnUiDvzwbx+bBVwrxXULP9XGvC9cBNSZ
         ZgSzR86sgppYryUmiR+tSvra1I15kvV0sTfyAkQceOoChf8+Qhd1a7llqrMBZzRxrz6z
         uMrKqXBBbzz5TwpkxmXPrXdpdcL/zaDrTL9K4NgAeANp5z9dKqW92d010d29SeZYWQFK
         Mzfg==
X-Gm-Message-State: AOJu0YxeFbO1JRgkg5Wi0d8mdEjZ/ji099xNtgV3OsMYbYN8yLb/i20u
        zmLODoQwuZqFMeCLJcjCixrn5A==
X-Google-Smtp-Source: AGHT+IEl0LvVWNhM9XEtVBHF0eypOkjX2wKUhmTs9VMGSa1/dOxPXszHikcyziAnfqiFcWEiXhH1Og==
X-Received: by 2002:a17:902:bd94:b0:1b8:4f93:b210 with SMTP id q20-20020a170902bd9400b001b84f93b210mr4598464pls.45.1696015396110;
        Fri, 29 Sep 2023 12:23:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709026b4a00b001b8a2edab6asm17138005plt.244.2023.09.29.12.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:23:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Anna Schumaker <anna@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-nfs@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nfs41: Annotate struct nfs4_file_layout_dsaddr with __counted_by
Date:   Fri, 29 Sep 2023 12:23:13 -0700
Message-Id: <169601539363.3014051.18337419689508974314.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915201427.never.771-kees@kernel.org>
References: <20230915201427.never.771-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 13:14:27 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nfs4_file_layout_dsaddr.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] nfs41: Annotate struct nfs4_file_layout_dsaddr with __counted_by
      https://git.kernel.org/kees/c/4d8e2b2fb0cf

Take care,

-- 
Kees Cook

