Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE37EE6B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjKPS2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKPS2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:28:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25DD1A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:28:38 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc131e52f1so17448365ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700159318; x=1700764118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7reBGJiccGvFEPh84DNhsMy+d8d0VEfZ803Vs8wYx6A=;
        b=Bw1+HklBx24qQvlrxlGvf87SNTxgtB2H7RSTrdsZR2AFH/KEUZU6rNkusOea1sCbaZ
         6s+REsEmrGSJdW+777sPyeSg/94oYl4/QHj/FAyXh8+M8PfDWi6pDCAEIkfxgQFMh9np
         TfsUBXnvkRI3p21iy2fFS/mz0lThRZHYoOrjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700159318; x=1700764118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7reBGJiccGvFEPh84DNhsMy+d8d0VEfZ803Vs8wYx6A=;
        b=APmqezBQgU3Zr/mw3rimAaCSZbjS3UCIvHbU/ruR2fJhc0Nf2fjXVfm/i9RNK3wDSl
         2TE4LbNrSRpNHhZJIaeWJXDyotchXphjI1ssEen8DvWmCOUIXFSzXlD5WRq6naq/k2U/
         VEk3Cz4uyJiCImZgvjeHFJHKobzS0lVH4OMuj7zpZUkHgwrkaLGnf+zx2LCM8yjpBPRO
         SyzJDXJ9uUgJD8rf9vvsmCRGg/rtqkfVUlr5y064aTyFXUgHx/OykRFQeFUAkQLp7MDs
         sx+mn+152ZUtSBBG+uiICJj0x85OjzV5BTEYYAaOXyByi++s8wD0M1z5QFt2BPlx5syr
         UYhQ==
X-Gm-Message-State: AOJu0YwSO4rZlwix9rsOC9aNdz9NiOwXk+wgOQIBWD9yF8Jchq0R5rUf
        n8XJyPw1Xx1zJAZO8Wun6ixqZw==
X-Google-Smtp-Source: AGHT+IGAIJ1flNjVNFt30991BeOzVwdm7nFOpSj7aipBLifSRgBzIDb+/MN7TcTVw7PDSnp4FgwR1Q==
X-Received: by 2002:a17:903:485:b0:1cc:38e6:f097 with SMTP id jj5-20020a170903048500b001cc38e6f097mr3076987plb.7.1700159318125;
        Thu, 16 Nov 2023 10:28:38 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709028c9200b001bdeedd8579sm9514614plo.252.2023.11.16.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:28:37 -0800 (PST)
Date:   Thu, 16 Nov 2023 10:28:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nouveau/gsp: replace zero-length array with
 flex-array member and use __counted_by
Message-ID: <202311161028.E780FBB146@keescook>
References: <ZVZbX7C5suLMiBf+@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVZbX7C5suLMiBf+@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 12:11:43PM -0600, Gustavo A. R. Silva wrote:
> Fake flexible arrays (zero-length and one-element arrays) are deprecated,
> and should be replaced by flexible-array members. So, replace
> zero-length array with a flexible-array member in `struct
> PACKED_REGISTRY_TABLE`.
> 
> Also annotate array `entries` with `__counted_by()` to prepare for the
> coming implementation by GCC and Clang of the `__counted_by` attribute.
> Flexible array members annotated with `__counted_by` can have their
> accesses bounds-checked at run-time via `CONFIG_UBSAN_BOUNDS` (for array
> indexing) and `CONFIG_FORTIFY_SOURCE` (for strcpy/memcpy-family functions).
> 
> This fixes multiple -Warray-bounds warnings:
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1069:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1070:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1071:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1072:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> 
> While there, also make use of the struct_size() helper, and address
> checkpatch.pl warning:
> WARNING: please, no spaces at the start of a line
> 
> This results in no differences in binary output.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks nice to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
