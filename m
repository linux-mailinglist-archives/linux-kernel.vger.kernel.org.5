Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4043C7A28FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbjIOVHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbjIOVHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:07:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C1DDD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:07:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso20554205ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694812031; x=1695416831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gpm6l2zbYEP+V6IdYZx55UZQF+is/o4lwglBKgVrZz0=;
        b=fDH01NjiO2bMTMbSUOKhTrBeyBJCZ+IXCSijkAE3a+rPlYYAQZOjn19HId8V+9B6BY
         ITxKj9wmAvlb70AWIhoHExt0c6VfPpV5FGlL0LS29ZHhsTeeTS5aRXmvN8QvL95PsgKI
         D3YQgn5y497iv/wxpNZLrA9sNKsj8C2qj1jdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694812031; x=1695416831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gpm6l2zbYEP+V6IdYZx55UZQF+is/o4lwglBKgVrZz0=;
        b=Z8QnmgD5LrUsk6P0XAMZMnN1jyutcErAR2Mab+Tt3cSU3w2X5YnFYCAgbOGDnHD6dL
         9R0rGMJfAznny3lGngZ5EWgBV/HfGf9e8i2Xr+7+G/Eg9jZuvVNRdddLtDwsA6TlEWgf
         0YfBq5ytNCxAxtV/4nktQmwnpYMYf4gNm+rhd0ASU4vKmzKKHU2V+/52pIyijUbwECt8
         mesD9r/E4O0CeYAtQBf/yLYfgK8n/o+knodSgSQD/XCg6rHeQkPCpdixFH1JY4ivkA56
         cbFaFJju7uUMle1gp9/JnO+iAWkW8dLqSCRcWTmWFTPer+OfLbWQhGv2NZqPv6hIXbHK
         Djmw==
X-Gm-Message-State: AOJu0YzpQERjSLyTgLNNAEL/bdqQYF2/MF4hRVTtfupi4+d4HHWzD1pg
        w7eWJhiEJD56WZJ0C0eZsNJdsA==
X-Google-Smtp-Source: AGHT+IEG2bCBbADESOrcfwhEKDiH90vpRH4uBGBmGx+GTX8gOEqkcnRXiWFTKwkpE3Lhi3WQISqwLg==
X-Received: by 2002:a17:903:2783:b0:1b8:b382:f6c3 with SMTP id jw3-20020a170903278300b001b8b382f6c3mr2890153plb.13.1694812030972;
        Fri, 15 Sep 2023 14:07:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001bdc208ab82sm3788343plg.97.2023.09.15.14.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:07:10 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:07:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
Subject: Re: [RFC PATCH 08/14] security: introduce CONFIG_SLAB_VIRTUAL
Message-ID: <202309151407.2FD7F80B@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-9-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-9-matteorizzo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:27AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> SLAB_VIRTUAL is a mitigation for the SLUB allocator which prevents reuse
> of virtual addresses across different slab caches and therefore makes
> some types of use-after-free bugs unexploitable.
> 
> SLAB_VIRTUAL is incompatible with KASAN and we believe it's not worth
> adding support for it. This is because SLAB_VIRTUAL and KASAN are aimed
> at two different use cases: KASAN is meant for catching bugs as early as
> possible in debug/fuzz/testing builds, and it's not meant to be used in
> production. SLAB_VIRTUAL on the other hand is an exploit mitigation that
> doesn't attempt to highlight bugs but instead tries to make them
> unexploitable. It doesn't make sense to enable it in debugging builds or
> during fuzzing, and instead we expect that it will be enabled in
> production kernels.
> 
> SLAB_VIRTUAL is not currently compatible with KFENCE, removing this
> limitation is future work.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
