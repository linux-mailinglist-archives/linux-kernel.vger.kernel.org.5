Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7C37BB5D9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjJFLE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjJFLE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:04:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FCE83;
        Fri,  6 Oct 2023 04:04:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9936b3d0286so365741266b.0;
        Fri, 06 Oct 2023 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696590264; x=1697195064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2WiOCrWmhLJuTIepEjZQuImlrrjxsWBQrKZp+iyTHw=;
        b=fa4hWWzrFioGCaoP66Dr6mDfuZ5JBZEDZ0GSaN8rUick6jB26ycQ+VgrHAvbC2UslW
         ZNIs6PkiHMU8clsUkI//cB0sJi9CPm+RzAHicKCt1u1h9+aivw/GmNFF+3xnTYegJimQ
         MzHvgXBguuEY4xfMfXbDAt/6tC5reovhg+rnvCq0GzwLjV5WgRmiqv/L4vguDMzjGiER
         jmxep9LP+UDGUzebV8iqi76bAMxxF/92/4AJVn5sYAhdv8vBzn+JmpSgkJTmHcl7+Yn9
         h5AYoinoJyvgDiO4cWDwgsE/GFv5c0fsV4Ej7xxbhWRP2Mti5qOv8dwMYu0V1yssbbES
         mqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696590264; x=1697195064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2WiOCrWmhLJuTIepEjZQuImlrrjxsWBQrKZp+iyTHw=;
        b=WcS5lFwsApc6MrKDTSe6t36WRDhC2cYeCDHWDwIDWJ2tYaTh+imEV5pura3JQCqPeu
         s9lwy3xkosMOcvacCFyeRDt97x6epnfMY8adKRO6oG0/yQlr5V2pnw8wna790S5BQFVa
         TROQAXl+JsMptNFJTuqlHFdXYKS1L8eyInbt4dfTIVK8yOMKN0JvDkxp8XEMCPzP1H9i
         fBmn7svONQ1ybFqGxHReW7Gaw/aWaFfepxfv3OpYTgpuAS9uxbUMjdHvEBrk37tIhzeX
         g3dcrspBpTL0d7zE8XV07qvOXzxLpW9FzHjkTfyKXY9qY5agTAbefPOXpJpxs5OrQ6/5
         G+kA==
X-Gm-Message-State: AOJu0YxVLi9TKvtIY99/MVM+ABAXZWZRyF9/ujqvqPD7zUCiNaa5K/O8
        5k7HoqCEBwvlrw8DEwx0HFM=
X-Google-Smtp-Source: AGHT+IEB0eKBGK0XKUxTBG7I/xaeZ2hb7hfg84mTMgJrb/rakr9HXd1NOLOglC7QaegcLP5d4JksNA==
X-Received: by 2002:a17:906:5357:b0:9ae:7681:f62a with SMTP id j23-20020a170906535700b009ae7681f62amr7743546ejo.44.1696590264233;
        Fri, 06 Oct 2023 04:04:24 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id kb4-20020a1709070f8400b009adc81bb544sm2677862ejc.106.2023.10.06.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:04:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 6 Oct 2023 13:04:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        x86@kernel.org
Subject: Re: [tip: locking/core] locking/futex/selftests: Remove duplicate
 ABI defines
Message-ID: <ZR/ptQMWKxHCeXyp@gmail.com>
References: <20231006095539.1601385-1-usama.anjum@collabora.com>
 <169658834039.3135.4395839213523782496.tip-bot2@tip-bot2>
 <20231006104325.GC36277@noisy.programming.kicks-ass.net>
 <ZR/oKYY7R52wKYC5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR/oKYY7R52wKYC5@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Oct 06, 2023 at 10:32:20AM -0000, tip-bot2 for Muhammad Usama Anjum wrote:
> > > The following commit has been merged into the locking/core branch of tip:
> > > 
> > > Commit-ID:     d351a9e56cc90a9ff694550e4b3bcaf51a391525
> > > Gitweb:        https://git.kernel.org/tip/d351a9e56cc90a9ff694550e4b3bcaf51a391525
> > > Author:        Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > AuthorDate:    Fri, 06 Oct 2023 14:55:37 +05:00
> > > Committer:     Ingo Molnar <mingo@kernel.org>
> > > CommitterDate: Fri, 06 Oct 2023 12:29:45 +02:00
> > > 
> > > locking/futex/selftests: Remove duplicate ABI defines
> > > 
> > > Kselftests are kernel tests that are built with kernel headers
> > > from the same source version. The kernel headers, which includes
> > > current ABI definitions, are already being included correctly
> > > in the futex selftest Makefile with the help of KHDR_INCLUDE,
> > > no need to define them again.
> > > 
> > > Remove duplicate ABI definitions, which is effectively dead code.
> > > 
> > > No functional changes intended.
> > 
> > so.. as it happens I recently built these things as stand-alone, and
> > then you ver much end up using the system headers.
> > 
> > Also see 20230922205449.808782861@infradead.org where I add more of
> > this.
> > 
> > Specifically, if one does:
> > 
> > cd tools/testing/selftests/futex/functional; make
> > 
> > You don't get kernel headers and stuff does not build.
> 
> Hm, I did this after applying the patch, and it does work,
> but maybe I missed that those definitions were picked up
> from system headers...
> 
> So how about we make sure current kernel headers are applied
> correctly in a 'standalone' build? There's no reason they
> shouldn't be.

Anyway, I've removed this patch from tip:locking/core until
this is cleared up, as your usecase is obviously a valid one ...

Thanks,

	Ingo
