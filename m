Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950107A28D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbjIOU6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbjIOU55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:57:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120EFA0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:57:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fac16ee5fso2401408b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694811419; x=1695416219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5BeJTKQ+1ikY10aMboTw9qo9cYRheGp8DXKbuRu77g=;
        b=UdLc2GKFGvI+Ek1td0zQybW6j6P5quhJ5s7rdIX2aH+2u5dtS0lXjvRInGTYK0GAqY
         U64H5IuTz0RbI1cBBe1J6t4XMTM+Rnm7F1+K20a3WUAhV+iGZ/x0qN3sOcY3uWlOIF01
         iLuvHtJ/n5JYAPpB8bAmuYWWiE5v3fPoYLfhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811419; x=1695416219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5BeJTKQ+1ikY10aMboTw9qo9cYRheGp8DXKbuRu77g=;
        b=Lljn8sccKPAOBFgrMKt1NbYbJz6XMAJ1/FiTY7dc8L5bL4UWpvQOCQulKzmODHIgtl
         XbCAFOVwpbQcD1rQ7wiyeekW0E29jLgf7yldWz4AaYK6pSAFPyJgwcGs25uKuv3Hhym6
         /rMAKBPKhKWlPDRmWOQ9qxR6Qaq1Z+Ho9CzanWOOsBvQ0lixap9vs8da3m8OHBNUzkWL
         84WYJJuBxnPskhKzsu3zCADKdMox/YBwZbc+zg0ipINnG8RmRxyLGQG/EgAbxaIynA7x
         1u1/o6YlOapISI2iWfm6HvAGPhrcFbQ18h0zNXrtlb+MulWnaIbqo/LPVG1Xud79GZGT
         VDCw==
X-Gm-Message-State: AOJu0YxMcUkUom7qQdzCXHvjlgaARtql+VQX1JA7OEkGbaSuIaMYyygR
        gcgvo/O5PFPDPHjWMqAIVgYEYw==
X-Google-Smtp-Source: AGHT+IHJBAYhxn1GGRB5vzrXcaafNOi0rnc01xyeDJrxzCSkXZlY8N/3npkmx1Wu5YzdeWtLZT+rkw==
X-Received: by 2002:a05:6a21:3297:b0:133:e3e3:dc07 with SMTP id yt23-20020a056a21329700b00133e3e3dc07mr3739773pzb.49.1694811419599;
        Fri, 15 Sep 2023 13:56:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m21-20020aa79015000000b0068a6972ca0esm3336769pfo.106.2023.09.15.13.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:56:59 -0700 (PDT)
Date:   Fri, 15 Sep 2023 13:56:58 -0700
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
Subject: Re: [RFC PATCH 03/14] mm/slub: move kmem_cache_order_objects to
 slab.h
Message-ID: <202309151356.1A6AC69@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-4-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-4-matteorizzo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:22AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> This is refactoring for SLAB_VIRTUAL. The implementation needs to know
> the order of the virtual memory region allocated to each slab to know
> how much physical memory to allocate when the slab is reused. We reuse
> kmem_cache_order_objects for this, so we have to move it before struct
> slab.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Yay mechanical changes.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
