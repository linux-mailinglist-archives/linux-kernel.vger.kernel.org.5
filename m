Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A87BB5BD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjJFK5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjJFK5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:57:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650C4CA;
        Fri,  6 Oct 2023 03:57:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b64b98656bso346362766b.0;
        Fri, 06 Oct 2023 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696589868; x=1697194668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdPZ2n/inxbF+GLKHf2xYTHCQpKgQLArQVCufDqXbP4=;
        b=NbyyWBRMgiK2pS0IKdBdnKyz6W1Ckf4PJ+BRZBXaJZKDZ15+A0yGDiIjvAb7sMQYpa
         hm0f0Lu1u4+6rKUMduZ0Cidk7Jyk11N9PDvpFuRlHxZuC36HphJUKcH/wfUg87f9BJxU
         4MJWZ3B29KKsCmYWQEiL4St3SHniv68a4u6i6m9ox8jig6ckhZOU8SoQi9PAwLXiyAZK
         qUfDrkqVydq/SgO9dShrOU2i9e5NFqMqen+AwOhOA/SrdaqYt7s2dVTwxZ1YlETF/AnX
         iIpMSqciOzaNJ7xKcev08DyhmOV+SQstroc+XSpn1Bw9SaLbnMAEkDJCiIsrIFHMjrer
         VfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696589868; x=1697194668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdPZ2n/inxbF+GLKHf2xYTHCQpKgQLArQVCufDqXbP4=;
        b=L16c4PcCBkLgcS9Jeo2dRkpNAJdV1t5xkepX9qG5oBA/sIpZVbEPh8pEakiXulUJa8
         j4m0x7SKnphLPRXnVaORtu6sS5i03JDFumI7IR3s3vaBVjY647nUnqqv7oy09fHYtRJG
         MjY+fvefssdk49O50tU8jNVAfvK6yYIMzZ4vG1pMbMSXkJdm2xPVMNwvdJPYGtjQPXnG
         jr/xp61PLljoe9vwAxN+b8QXMlKVDRLsCaZL5w65c6IbbmJds5+YPGescU/+y/B//lYH
         epk+/UkiEK3RUl1CFvO4HVLmd1zfjWiDeFjCh3mfH4ri/xG/p7RWw8y4XDjKe8fjs1Hq
         iu6A==
X-Gm-Message-State: AOJu0YxCe0oFpSTKgpoIfgjM/R8k+StvfFc9/bmnyQAp14PVdnGohHUM
        hX1J2FhcYTo/CQAjfWH7u58=
X-Google-Smtp-Source: AGHT+IFZXGCg+k/FRgyd7QhYUcHDNs4MWkgjuEWCKmqnEGDRl76v1W6eN8LswOTe6CO1ViS02CItCA==
X-Received: by 2002:a17:906:23ea:b0:9b7:37de:601a with SMTP id j10-20020a17090623ea00b009b737de601amr6163292ejg.49.1696589867825;
        Fri, 06 Oct 2023 03:57:47 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id rv18-20020a17090710d200b0099364d9f0e6sm2671875ejb.117.2023.10.06.03.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:57:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 6 Oct 2023 12:57:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        x86@kernel.org
Subject: Re: [tip: locking/core] locking/futex/selftests: Remove duplicate
 ABI defines
Message-ID: <ZR/oKYY7R52wKYC5@gmail.com>
References: <20231006095539.1601385-1-usama.anjum@collabora.com>
 <169658834039.3135.4395839213523782496.tip-bot2@tip-bot2>
 <20231006104325.GC36277@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006104325.GC36277@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Oct 06, 2023 at 10:32:20AM -0000, tip-bot2 for Muhammad Usama Anjum wrote:
> > The following commit has been merged into the locking/core branch of tip:
> > 
> > Commit-ID:     d351a9e56cc90a9ff694550e4b3bcaf51a391525
> > Gitweb:        https://git.kernel.org/tip/d351a9e56cc90a9ff694550e4b3bcaf51a391525
> > Author:        Muhammad Usama Anjum <usama.anjum@collabora.com>
> > AuthorDate:    Fri, 06 Oct 2023 14:55:37 +05:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Fri, 06 Oct 2023 12:29:45 +02:00
> > 
> > locking/futex/selftests: Remove duplicate ABI defines
> > 
> > Kselftests are kernel tests that are built with kernel headers
> > from the same source version. The kernel headers, which includes
> > current ABI definitions, are already being included correctly
> > in the futex selftest Makefile with the help of KHDR_INCLUDE,
> > no need to define them again.
> > 
> > Remove duplicate ABI definitions, which is effectively dead code.
> > 
> > No functional changes intended.
> 
> so.. as it happens I recently built these things as stand-alone, and
> then you ver much end up using the system headers.
> 
> Also see 20230922205449.808782861@infradead.org where I add more of
> this.
> 
> Specifically, if one does:
> 
> cd tools/testing/selftests/futex/functional; make
> 
> You don't get kernel headers and stuff does not build.

Hm, I did this after applying the patch, and it does work,
but maybe I missed that those definitions were picked up
from system headers...

So how about we make sure current kernel headers are applied
correctly in a 'standalone' build? There's no reason they
shouldn't be.

Thanks,

	Ingo
