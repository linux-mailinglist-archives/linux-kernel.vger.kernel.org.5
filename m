Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C9675D622
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGUVEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGUVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:04:45 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64141FD2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:04:44 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-34896a1574dso11957575ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689973484; x=1690578284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TWvFaC6AvxQczFQknimLznH6e8RL+Evefj60YX6+Do=;
        b=CpdNL6wyKAAXvV6iE2nP64cVgurRfmYGDPoFed2uZi24Le1tudjFCKZowuusK1Ga0R
         z9RBX4wHE4Odvic2duusAfUMogZWJB4ixH18Np1AOqvVFjXqcs2rTVBntXWDcXmOB0n4
         1xkDm+YMWw7fbkIFngKtApCe1pWZPDD0vg/3Ra70TfVpLGa9rrpVchYtBU6ng1R9ArYe
         TG7CHNDgR26fmr3K5dJABipcZC3YeoNGISqyi16Jh9PPgXTSpTa1DediOKIZVXaZOAXG
         4mm1jB9N52ftt1hWEjBZoC8wMVSAfZRuxiuOkn3h4J/5NvaK/QjDILv27R6jq4oMM5Oe
         qZnA==
X-Gm-Message-State: ABy/qLZ6x0bdMkL/4aGCU11l18i0H54cOBVBUVaUa7X/e0/6C8KlMPoX
        4/PonqRN4eNxQ6F2p+1NPF8=
X-Google-Smtp-Source: APBJJlFqtgkPnRDMjZf1te86CNa/yazgLKME7V8uGOU/ofEdeddbXOq24m+GC85MN1R4NKZgGN8nYg==
X-Received: by 2002:a5e:c110:0:b0:787:17d6:fbc7 with SMTP id v16-20020a5ec110000000b0078717d6fbc7mr979927iol.13.1689973483785;
        Fri, 21 Jul 2023 14:04:43 -0700 (PDT)
Received: from snowbird ([2601:282:1800:1f50::d356])
        by smtp.gmail.com with ESMTPSA id q7-20020a5d8347000000b00785d794ec4esm1338952ior.23.2023.07.21.14.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 14:04:43 -0700 (PDT)
Date:   Fri, 21 Jul 2023 14:04:38 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        mawupeng1@huawei.com
Subject: Re: [PATCH 0/3] percpu: some trivial cleanup patches
Message-ID: <ZLry5gupx9mp1659@snowbird>
References: <20230721131800.20003-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721131800.20003-1-bhe@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jul 21, 2023 at 09:17:57PM +0800, Baoquan He wrote:
> There's a left issue in my mailbox about percpu code at below. When
> I rechecked it and considered Dennis's comment, I made an attmept
> to fix it with patch 3.
> 
> https://lore.kernel.org/all/Y407wDMKq5ibE9sc@fedora/T/#u
> 
> Patch 1 and 2 are trivial clean up patches when reading percpu code.
> 
> Baoquan He (3):
>   mm/percpu.c: remove redundant check
>   mm/percpu.c: optimize the code in pcpu_setup_first_chunk() a little
>     bit
>   mm/percpu.c: print error message too if atomic alloc failed
> 
>  mm/percpu.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> -- 
> 2.34.1
> 

Thanks for these. I left a few comments. I think I might have some stuff
for v6.6, I'll figure that out in a couple days. If that's so, I can
pull 1, probably massage 2 and send that out again, and then I think
you'll need to resend 3.

Thanks,
Dennis
