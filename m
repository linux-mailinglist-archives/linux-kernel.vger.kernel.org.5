Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49C47A294A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjIOVXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbjIOVXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:23:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36246101
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:23:05 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-577a98f78b2so1908377a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694812984; x=1695417784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiVyFYFD+iY/+Ocrmo3l32JHL4fUNs4RLt/6Kj3cZUw=;
        b=d3U4W1LFavFPht1x25ls6ivrIShNxB9NmTtrc2L7xOhNutXS+EOV/8W4eeI/IjPuSV
         qqFEGdNm5/fgGOsC1s/P8IPLd5uUpabi8gSbxMI+8FZmm0SCIp8dl8XFjqMV5DStF6V8
         DShYduPlVlIt87KTFEQ4h8/uvTxdxBBwqgF0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694812984; x=1695417784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiVyFYFD+iY/+Ocrmo3l32JHL4fUNs4RLt/6Kj3cZUw=;
        b=rp5twOyp4+tN397tAVC3npwJdWYnUCHgPTrXcs6GyteFTIcJtzDDCBFMwD5S/0CWQe
         TQLW8oshKzopM57n/MYpTZDNqF4J5aJMf8RWnhW1ZTiopcH23NZhM8aq+TESIanEbngf
         HD2w087Enx7rqsgQxQSHnR3ZqsTbpg6idoMbEvNUMLOIWEzX8luwFqpiZfjhLpO4/eaE
         QOlIGzWA/61ek5TSSh9lw/CaEKudPGZTRwYyFzztOqvPAwa0QaY9CGAwOP3WZJa+LOo/
         4j15issH43DaoKvRpp75yjYu6COLLh+rVgiX1h3DI+7ENjZf9QcLxAv7s1P51hfnLqmp
         X0Qg==
X-Gm-Message-State: AOJu0Yxz34kt/sv0cXi3N+SX4KbxON8Qi3Yj1ZA+yih//MKcXc22tkpG
        yPhld96OQHDA2T79bW0ZMJNP/g==
X-Google-Smtp-Source: AGHT+IGK3s7+1sbLHNP+MzY1eBho88i+hlkIlJpvOqkzeAkzu9GD01LibMXuB4ThZYh7TqDkMF9xFw==
X-Received: by 2002:a17:902:dac5:b0:1b5:64a4:bea0 with SMTP id q5-20020a170902dac500b001b564a4bea0mr3329386plx.10.1694812984632;
        Fri, 15 Sep 2023 14:23:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001bc5dc0cd75sm3904512plg.180.2023.09.15.14.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:23:04 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:23:03 -0700
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
Subject: Re: [RFC PATCH 12/14] mm/slub: introduce the deallocated_pages sysfs
 attribute
Message-ID: <202309151422.C3F39B8D8E@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-13-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-13-matteorizzo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:31AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> When SLAB_VIRTUAL is enabled this new sysfs attribute tracks the number
> of slab pages whose physical memory has been reclaimed but whose virtual
> memory is still allocated to a kmem_cache.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Yay stats. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
