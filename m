Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDFD7E8233
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbjKJTHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345109AbjKJTHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:07:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720762CDD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:31:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16845C433BF;
        Fri, 10 Nov 2023 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699641083;
        bh=hwCvephXkVaTmz22ATWp2p7mlz7+SKurkbCDiuKn4Vo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LW65BgWnZC7HeHU+pkcCg+T+OR16Z6yZdHaj3NMy3LFgtdfdJhfNlRetWITbmG0Sg
         yAuSXeDpXHtDAa017hsIv+elgdjy2N5bik8uQvJJTVJnPKFugwhtLuxs7DvkDUqP+G
         IpwJ9b+R7+6MThAVIAB9+g1OvsDpdK7Wp7X+e/eo=
Date:   Fri, 10 Nov 2023 10:31:22 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Hyeongtak Ji <hyeongtak.ji@gmail.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: Re: [PATCH] mm/damon/core.c: avoid unintentional filtering out of
 schemes
Message-Id: <20231110103122.21d5fb5f3d60f1f4f5bd143f@linux-foundation.org>
In-Reply-To: <20231110182240.65426-1-sj@kernel.org>
References: <1699594629-3816-1-git-send-email-hyeongtak.ji@gmail.com>
        <20231110182240.65426-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
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

This can be addressed by including an explicit From: line at start of
changelog.  Which should we use?

> > 
> > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

I'll add 

Fixes: ab9bda001b681 ("mm/damon/core: introduce address range type damos filter")
Cc: <stable@vger.kernel.org>

