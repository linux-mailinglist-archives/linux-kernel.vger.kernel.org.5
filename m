Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4657AB2D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjIVNmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjIVNmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:42:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957F2CE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:41:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-503012f4e71so4385891e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695390117; x=1695994917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNyatKE1jxYtMSShNIBuDi669vU2qZU1RTH/jHEa998=;
        b=CiZTd6O8ffh+MA6LF1onxvHKFTjjGGSt0ayGAD7/xetFDPu4QyZkdyr9S4xjmAc6FD
         tw+kHvV1eR1aiLyzVlF7PRh3U7uSXsRP5LbolgHaxdVdWyodPahWVrZn8OOZmF4Kc0x1
         x5JB+OK5mz+SvQiorl+i1cXzKx2SzpvsRoupYf7jhPufGYg/hwdt/Fs+trCpg0qDnEmZ
         S6RCUJViVq77cWpPO2vTBzbQBruXk2HTyVHGKYXRxSAxZS+36HE1fX3sJlFQAdQoAS7s
         yV2/YhFma+gPtTUEHyhO2DA/TkZUm1AVeEh92F/WZj2axAr02m1PJg/TH4xnWJ3LD90i
         zeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695390117; x=1695994917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNyatKE1jxYtMSShNIBuDi669vU2qZU1RTH/jHEa998=;
        b=u11tKCynWpglNk4ELzfOH8Za7GkEHTKkSj51QxWOrXlNNNX1lr3rXkY0i60yXKY70Q
         5Edy52iCdIBD6gQeSgXpPMr29vOplECzDtd+S3oebbp3P22QOl31BmBnjTMuyBryH85x
         lrkf9P9dLB4F/IfarO37J57xZuxwDumoFtE+voLoZw54gtPdObVp0UrkOXkpXqT6U+Oa
         53jLcIy2y1uZ3JSAu+IojtLBCCgynGMwUkkf+D2GlJgozoVJ1wBs40yytabH4FxRxEJd
         0DojHNdKkyHifOtExgs0Xoi9KFN8bYxBRZxWgh9HTe2U6rAPkcSObeKA0M/IqcyMC509
         eguA==
X-Gm-Message-State: AOJu0YyOAIscwC24xIcE1ifLQQyHYX0kVMBOphCFwp635zVaSkw/k4kz
        Exn7LMittNHx/D2+Tsdz99ODFhWDXNE=
X-Google-Smtp-Source: AGHT+IGLEvMlHwkAzpSnQrKJflkM7c9m/I6oKmtnlycjlNzOy+Wgu2dsmNFZMhkINl9Fhb3oF9AaOw==
X-Received: by 2002:a05:6512:2210:b0:503:16ec:7153 with SMTP id h16-20020a056512221000b0050316ec7153mr927525lfu.31.1695390116452;
        Fri, 22 Sep 2023 06:41:56 -0700 (PDT)
Received: from pc636 (host-90-233-214-51.mobileonline.telia.com. [90.233.214.51])
        by smtp.gmail.com with ESMTPSA id x24-20020a19f618000000b004fdb85646f1sm731972lfe.201.2023.09.22.06.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 06:41:56 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 22 Sep 2023 15:41:53 +0200
To:     Jaeseon Sim <jason.sim@samsung.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: Re: [PATCH] mm/vmalloc: Remove WARN_ON_ONCE related to
 adjust_va_to_fit_type
Message-ID: <ZQ2Zob9+9P0kK7ha@pc636>
References: <CGME20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65@epcms1p1>
 <20230922062704epcms1p1722f24d4489a0435b339ce21db754ded@epcms1p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922062704epcms1p1722f24d4489a0435b339ce21db754ded@epcms1p1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 03:27:04PM +0900, Jaeseon Sim wrote:
> There's panic issue as follows when do alloc_vmap_area:
> 
> Kernel panic - not syncing: kernel: panic_on_warn set ...
> 
> page allocation failure: order:0, mode:0x800(GFP_NOWAIT)
> Call Trace:
> warn_alloc+0xf4/0x190
> __alloc_pages_slowpath+0xe0c/0xffc
> __alloc_pages+0x250/0x2d0
> new_slab+0x17c/0x4e0
> ___slab_alloc+0x4e4/0x8a8
> __slab_alloc+0x34/0x6c
> kmem_cache_alloc+0x20c/0x2f0
> adjust_va_to_fit_type
> __alloc_vmap_area
> alloc_vmap_area+0x298/0x7fc
> __get_vm_area_node+0x10c/0x1b4
> __vmalloc_node_range+0x19c/0x7c0
> 
> Commit 1b23ff80b399 ("mm/vmalloc: invoke classify_va_fit_type() in
> adjust_va_to_fit_type()") moved classify_va_fit_type() into
> adjust_va_to_fit_type() and used WARN_ON_ONCE() to handle return
> value of adjust_va_to_fit_type(), just as classify_va_fit_type()
> was handled.
> 
> There is another path in adjust_va_to_fit_type() which could
> return failure and will be handled in alloc_vmap_area().
> Remove WARN_ON_ONCE() for this case.
> 
> Fixes: 45c62fc2897d ("mm/vmalloc: Remove WARN_ON_ONCE related to adjust_va_to_fit_type")
>
This is i do not follow. The stack shows the warning in the __alloc_pages() path.

What does this patch fix?

--
Uladzislau Rezki
