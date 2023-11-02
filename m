Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390AC7DED2D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjKBHXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:23:03 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7505012A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:22:57 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D8A923F17D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698909775;
        bh=Pd7/lFtP4BYuqq3e5ONr1i/noTjwBlQpKuQjz8D374U=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=Aizbkzh4jNb/2LzSU+PaSBMwBqyab8eqoiUpmsB/IU82MH7QxNkkph8shV4sleMb/
         7P4PrJwRz9ysLzeyetE7p9w59cXc+58SJjGA9UVJipMKZJzvQCnVLlbzuy84P/zsRG
         G97PAaUy7Jdm6HRJNIuRU0dVxPEFnxf7Qp0aYi+ryzk7iFapISnmRNW7i3W4XRGo2O
         PUX5yauGroWA9ZVpa/KU82dxPHIBTIGZP8+eIcfyvVG00O4G6n+nDV0Sz3VWcSIT3H
         FWiA3rnCsPCBnfAvL9+p7doCfpWxKwd6dsuEBzSMR6FSrh4q9FSTz+8gXHynbgpPWR
         MWdUAfWjpKKNg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9c749c28651so40333666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698909775; x=1699514575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd7/lFtP4BYuqq3e5ONr1i/noTjwBlQpKuQjz8D374U=;
        b=e5Ye7167S00Bt6TUqXjWrdQ9aU40zVK6DcRlT1DCiDcLooIS4wzFg5Qjqr3Uh7Kk8S
         WRMjhxDn7XuaJAdwaWWkEr81hSB5lFxcnuJA4/pVt6zHK/MVCkqDmKV/aHZzBWww+4Hw
         IGUeA3JoU6A90UHK7amLKz1jvR3lgZJIxSqijwnDOSi4BX93rvnyVxNwQ5PcEUvSTbVx
         u1/sScyid25tszYaerMKgG7/dRb3UCqK89gTtUipK9M0IzqWkMTLHe7kstn/FKDj06gH
         PQjjzWkF6Q44RYZ/akUPQboXRCseGE53VfY9l75hihJPDw7V5iw6GldR7jbosWev/n/N
         i7lQ==
X-Gm-Message-State: AOJu0YyzVyc9dAgtoMS2lBGcZxQf9Er++i804ceKnJC3+MdXiRkXgMGQ
        S9AWwzjv77YKgQTO9FLpfylXhnOtyuD61OUV8POkyxA6mrxfR4YOYHVoktrHS/tIQ2tupAvXTvZ
        sqwgePG2N48/14nY7AmN5HWFP5fyIgdehBYp4mnc9tw==
X-Received: by 2002:a17:907:2ce4:b0:9d3:ccf0:761e with SMTP id hz4-20020a1709072ce400b009d3ccf0761emr3442236ejc.49.1698909775543;
        Thu, 02 Nov 2023 00:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrcaepUPUtioNdapJVIzKQ0rujHR+g4fkf/lk1zTtPY1f2mSTPZz6aIQYCyYYCxcwy7R2PJg==
X-Received: by 2002:a17:907:2ce4:b0:9d3:ccf0:761e with SMTP id hz4-20020a1709072ce400b009d3ccf0761emr3442218ejc.49.1698909775093;
        Thu, 02 Nov 2023 00:22:55 -0700 (PDT)
Received: from localhost (host-79-33-130-95.retail.telecomitalia.it. [79.33.130.95])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090606c900b009b27d4153cfsm781396ejb.176.2023.11.02.00.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 00:22:54 -0700 (PDT)
Date:   Thu, 2 Nov 2023 08:22:53 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        zhumao001@208suo.com, yangtiezhu@loongson.cn, ojeda@kernel.org
Subject: Re: [GIT PULL] Modules changes for v6.7-rc1
Message-ID: <ZUNOTRWCWNJkn66n@gpd>
References: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
 <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 09:02:51PM -1000, Linus Torvalds wrote:
> On Wed, 1 Nov 2023 at 10:13, Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > The only thing worth highligthing is that gzip moves to use vmalloc() instead of
> > kmalloc just as we had a fix for this for zstd on v6.6-rc1.
> 
> Actually, that's almost certainly entirely the wrong thing to do.
> 
> Unless you *know* that the allocation is large, you shouldn't use
> vmalloc(). And since kmalloc() has worked fine, you most definitely
> don't know that.
> 
> So we have 'kvmalloc()' *exactly* for this reason, which is a "use
> kmalloc, unless that is too small, then use vmalloc".
> 
> kmalloc() isn't just about "use physically contiguous allocations".
> It's also more memory-efficient, and a *lot* faster than vmalloc(),
> which has to play VM tricks.
> 
> So this "just switch to vmalloc()" is entirely wrong.
> 
>               Linus

I proposed that change mostlfy for consistency with the zstd case, but I
haven't experience any issue with gzip compressed modules (that seem to
require less memory, even with larger modules).

So, yes, it probably makes sense to drop this change for now and I can
send another patch to switch to kvmalloc() for all the decompress cases.

Thanks,
-Andrea
