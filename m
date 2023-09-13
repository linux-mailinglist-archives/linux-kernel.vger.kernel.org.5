Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D7379F2C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjIMUXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjIMUXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:23:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A730D1BCA;
        Wed, 13 Sep 2023 13:23:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCDFC433C8;
        Wed, 13 Sep 2023 20:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694636611;
        bh=ztbgy5BuL+2Uttk7oJdHexZviR9cWaXgkYXcRz91PPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zwu/XuSCQ5uvnV0KV7hedxSYDCpc/qbnjI7cMxM+grkVfigIw3spFtQOoGy/YcE96
         4OoT7vCTIEcOiqukA8a4Uhxh/tgOE/j30Le/ErNaFfpx1UiulrYwTVV8UIl/v8AYTE
         17KgzqqFXH954jJFiujc+bF8p6BhkIvhvCmDNzGk=
Date:   Wed, 13 Sep 2023 13:23:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-Id: <20230913132330.00b3ef07f696cf9efc4d0886@linux-foundation.org>
In-Reply-To: <ada473e9-aa2f-c6ff-b869-cf94942ddd20@bytedance.com>
References: <20230912120429.7852428f@canb.auug.org.au>
        <e639a428-0fb7-7329-ce52-e51f7951a146@bytedance.com>
        <20230913093553.4290421e@canb.auug.org.au>
        <ada473e9-aa2f-c6ff-b869-cf94942ddd20@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 09:10:11 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 12 Sep 2023 11:27:22 +1000
> > Subject: [PATCH] bcachefs: convert to dynamically allocated shrinkers
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >   fs/bcachefs/btree_cache.c     | 22 ++++++++++++----------
> >   fs/bcachefs/btree_key_cache.c | 21 ++++++++++++---------
> >   fs/bcachefs/btree_types.h     |  4 ++--
> >   fs/bcachefs/fs.c              |  2 +-
> >   fs/bcachefs/sysfs.c           |  2 +-
> >   5 files changed, 28 insertions(+), 23 deletions(-)
> 
> This version looks good to me.
> 
> Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

I not longer carry a post-linux-next patch queue, so there's nothing I
can do with this patch.  I'll assume that either Kent or I will merge
it later, depending upon whose stuff goes into mainline first.

