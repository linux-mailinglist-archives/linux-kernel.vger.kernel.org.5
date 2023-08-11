Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1797877994C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHKVTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKVTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:19:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9335171F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 496FD61174
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 21:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F678C433C8;
        Fri, 11 Aug 2023 21:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691788761;
        bh=WoUL3JmZz8jZhBlEYl9A6rlfL6c8r7YNkR1pJ54jBfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hHozSo4XLCu0zYXul56t5fF43UuJTcs6C2O5I1zvKN8D002XPQesfBwMm7lNH7QHx
         1JbaMPgmKZj25T+pG+zxgWErHeTezbISXj7q2sTk2NZgcOzMMk+I0uA/7Vi5xsGDGr
         jucQGE0EULvKRqnrxEU3MNXa+QZ83GHbrYV+izow=
Date:   Fri, 11 Aug 2023 14:19:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: zswap: multiple zpools support
Message-Id: <20230811141920.2f9bab6f21ab635ff1bd63ac@linux-foundation.org>
In-Reply-To: <CAJD7tkZ7dLwny7-CX7qCywZPtki+fDuESGfv+B9QG87cSsrHVQ@mail.gmail.com>
References: <20230620194644.3142384-1-yosryahmed@google.com>
        <CAKEwX=OLR02MazB31wR-nphjZJvBHrm5Zy7hLPByZ3ubgO8mjw@mail.gmail.com>
        <CAJD7tkZ7dLwny7-CX7qCywZPtki+fDuESGfv+B9QG87cSsrHVQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 03:35:25 -0700 Yosry Ahmed <yosryahmed@google.com> wrote:

> >
> > I'm experimenting with some other zswap changes - if I have
> > extra cycles and resources I'll try to apply this patch and see how the
> > numbers play out.
> 
> That would be amazing. Looking forward to any numbers you can dig :)

So this patch seems stuck.  I can keep it in mm.git until the fog
clears, but would prefer not to.  Can we please revisit and decide on a
way forward?
