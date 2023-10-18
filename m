Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CD27CE2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjJRQXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjJRQW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:22:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EC2B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:22:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83113C433C7;
        Wed, 18 Oct 2023 16:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697646174;
        bh=UEcgxYj3ZEPopuz17qufQXDDsCe/+unWDdGOKIvbSt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nWMAkT4X1otXFlW7ow74vie/BuZZO+NXo8lQYnsoniD3wQL9hYlGdx1dEV2y0QLCL
         u6DTUTHwsBWYv9y1JvaSiAEujqO6p4X6OCH7U/hp+zmaVD28v5y2Kq1yRwbaF9blpz
         DVhOVHKldFM3HNVxEAEQZSKFXG1w8mO64TcOD/KI=
Date:   Wed, 18 Oct 2023 09:22:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] mm: kmemleak: use mem_pool_free() to free object
Message-Id: <20231018092253.a12815afa7db9049f95fc195@linux-foundation.org>
In-Reply-To: <ZTAAftQF8ReYAHlF@arm.com>
References: <20231018102952.3339837-1-liushixin2@huawei.com>
        <20231018102952.3339837-6-liushixin2@huawei.com>
        <ZS_-MBDKXR9qFXDb@arm.com>
        <ZTAAftQF8ReYAHlF@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 16:57:50 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> > Could you please reorder this patch before the previous one? If you
> > added a Fixes tag, we may want a cc stable as well (as for the other
> > patches with a Fixes tag) and it makes more sense to backport it on its
> > own without the __create_object() split. Otherwise:
> 
> Ah, ignore this. If we want a cc stable, the whole thing needs
> backporting, including the split which is essential for the subsequent
> fix.

Do we want a cc:stable?  That tag wasn't originally included.

If so, all seven patches?

If "not all seven" then can we please have two series, one for the
backport patches, one for next merge window.

