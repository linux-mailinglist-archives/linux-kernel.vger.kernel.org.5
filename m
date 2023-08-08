Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7727735CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHHBWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHHBWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:22:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD93E5A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:22:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb84194bf3so33827665ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 18:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691457734; x=1692062534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdrpnCU+URUIiVCQslFWJZMGyYZvlLsKuoWY8EjeOqw=;
        b=DVAoA+l+jc4aCXAwCbbTIwkP4CaJuzIqyxBOq2Izr05TzozyFayNyqg1XgWOHvKs1d
         dRWo26IL8ykTyO5WciiVs9NSSrryu08xLEa6uBCZeZnjGamRpXijWQ0t9qK51bN8Kgz4
         wZ0WGFV4EXUFTF8UDIwjAG+476CeyzQTp1yambnWVpAgI713e/VQQni7ix+joAoAdW9b
         Rfids4EI1QbqqvFFQPfULHzSeavOwav5jPf2tX8r9mqygggQa/6mCr0Xsr91f1GPR/nB
         Aerur14PfKnKZpYaH0kDAmh1PTK5BTaEU8ZP8AwPtu0KgD5F4CXtz1XVzXtqLRH13Qg9
         UfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691457734; x=1692062534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdrpnCU+URUIiVCQslFWJZMGyYZvlLsKuoWY8EjeOqw=;
        b=OKCHTu7ePa7oBvf0uBbCGipAwdf2FmSNEPBFoELBeAvhG0kVq4juE5XNMSDrv54U8T
         YUWfXBAtgpYrS6iGxFeXwV5vnEY9KRY+MP1GWsUZ8epGtxgFdu2y5JR2Jys+fNZzcSsx
         XFV156SeCQZq8YWlnXFP3xaefM4c/xaAEudA9rx8RigQOhsOrhU2a0WjDi4nGhJY2u09
         2m/ezt62fKHVD4+ZHKp3Hun6+MnmOT0Ojt5CU/uJmo2+8zbPemx0BPjSMTvzK9zOISW0
         otUYo9UwFWlO2OVyEAc0uA2Ao9lGbgMYWbTO9pm39y8njJ6AE14UTdBCj+UZuaFma9Ym
         HHjw==
X-Gm-Message-State: AOJu0YypBmOxUfsYQ/LBnxF6J7hRRVEyzjWRsIVoG1IIMdO/wRieRi+X
        mrpNUKtcB8uALZ3J41Nqpxqhi7Q9eP0=
X-Google-Smtp-Source: AGHT+IEYZamFL/O1wGtoFYatSsUq5SrYKvglUQJwJlajxQn24hEQbHrgTxkU8W9mDYFMLGmujEoAuA==
X-Received: by 2002:a17:903:24d:b0:1bb:20ee:e29e with SMTP id j13-20020a170903024d00b001bb20eee29emr11939346plh.1.1691457734603;
        Mon, 07 Aug 2023 18:22:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001b89891bfc4sm7516291pls.199.2023.08.07.18.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 18:22:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 7 Aug 2023 15:22:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, kprateek.nayak@amd.com
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <ZNGYxBCtaMclAl8x@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 18, 2023 at 02:16:45PM -1000, Tejun Heo wrote:
> Unbound workqueues used to spray work items inside each NUMA node, which
> isn't great on CPUs w/ multiple L3 caches. This patchset implements
> mechanisms to improve and configure execution locality.

The patchset shows minor perf improvements for some but more importantly
gives users more control over worker placement which helps working around
some of the recently reported performance regressions. Prateek reported
concerning regressions with tbench but I couldn't reproduce it and can't see
how tbench would be affected at all given the benchmark doesn't involve
workqueue operations in any noticeable way.

Assuming that the tbench difference was a testing artifact, I'm applying the
patchset to wq/for-6.6 so that it can receive wider testing. Prateek, I'd
really appreciate if you could repeat the test and see whether the
difference persists.

Thanks.

-- 
tejun
