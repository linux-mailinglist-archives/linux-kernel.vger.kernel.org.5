Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523237E8242
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjKJTI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbjKJTIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:08:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156926D5E7;
        Fri, 10 Nov 2023 10:31:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E427C43395;
        Fri, 10 Nov 2023 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699641096;
        bh=Cd+a5xzw1t7k6mz6ZPquvIB5Ojq2rLP5RewLP3v40qA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cLpW5BMj+iwJDnH11uWDwp+RwLlXxJL7ovTVethAaULIpRW2lNkTP+AW5E3SYrp2x
         4BwwaIGsG5fmyT+COnH9i5YuP+6U33hW12UBly2A3EIrhf60g7hibgCykRoIMa4ti+
         kZpWjxtJn2NhtqFEthWKsNa1cSK5s0aljGqfB2vbWJI6tD6UEUO2J0Ol/AyFfOuPrH
         mNzuaoStE9hZ1guJsvj7CqmPovnLW8Y2z9R2b1pJT2fU/ol2HQJKs7/gD3iadvoT06
         E6azr0SzwftNQKfG26nKMtzbDAaezkj8rJoZ+w/y/qfQNwUCgxrs4RiOIGo955KX02
         N6xOSz7wK3tng==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Hyeongtak Ji <hyeongtak.ji@gmail.com>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hyeongtak Ji <hyeongtak.ji@sk.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core.c: avoid unintentional filtering out of schemes
Date:   Fri, 10 Nov 2023 18:31:33 +0000
Message-Id: <20231110183133.65565-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110182240.65426-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 18:22:40 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello Hyueongtak,
> 
> On Fri, 10 Nov 2023 14:37:09 +0900 Hyeongtak Ji <hyeongtak.ji@gmail.com> wrote:
> 
> > The function '__damos_filter_out()' causes DAMON to always filter out
> > schemes whose filter type is anon or memcg if its matching value is set
> > to false.
> > 
> > This commit addresses the issue by ensuring that '__damos_filter_out()'
> > no longer applies to filters whose type is 'anon' or 'memcg'.
> 
> Nice catch, thank you!
> 
> checkpatch.pl shows one warning, though:
> 
>     WARNING: From:/Signed-off-by: email address mismatch: 'From: Hyeongtak Ji <hyeongtak.ji@gmail.com>' != 'Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>'
> 

Also, I think we need to add below?

Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos filter")
Cc: <stable@vger.kernel.org> # 6.6.y

> > 
> > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
