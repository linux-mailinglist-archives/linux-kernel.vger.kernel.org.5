Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024097A8941
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjITQHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjITQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:07:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE30B9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:07:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A00C433C8;
        Wed, 20 Sep 2023 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695226032;
        bh=3uzNs0nUQHnC8DAXANEMXp/C0mvTUZssBZN/6eeV6D8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GC5fYtzBtzOX3JkqCQtIzslv3qoM8bDvQUxJskQr/99qHmcGBQ+MzLtNmz3ifp8sx
         c4/gbsWY+hHRhdhIaiOIEikZOfDE0k1IhuPg9S8Lr2PGPQeE022Zfq9wj1iz0BA+jM
         MhpjYvhxqVJdy6cPQGGf3+L5OE93zQGX8S0PbO00=
Date:   Wed, 20 Sep 2023 09:07:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     liwenyu <wenyuli@ex.bilibili.com>
Cc:     bsingharora@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangyun@bilibili.com
Subject: Re: [PATCH] delayacct: add memory reclaim delay in
 get_page_from_freelist
Message-Id: <20230920090711.ecc2d84cc29bb0fa540f1999@linux-foundation.org>
In-Reply-To: <181C946095F0252B+7cc60eca-1abf-4502-aad3-ffd8ef89d910@ex.bilibili.com>
References: <181C946095F0252B+7cc60eca-1abf-4502-aad3-ffd8ef89d910@ex.bilibili.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 17:38:49 +0800 liwenyu <wenyuli@ex.bilibili.com> wrote:

> The current memory reclaim delay statistics only count the direct memory
> reclaim of the task in do_try_to_free_pages(). In systems with NUMA
> open, some tasks occasionally experience slower response times, but the
> total count of reclaim does not increase, using ftrace can show that
> node_reclaim has occurred.
> 
> The memory reclaim occurring in get_page_from_freelist() is also due to
> heavy memory load. To get the impact of tasks in memory reclaim, this
> patch adds the statistics of the memory reclaim delay statistics for
> __node_reclaim().

Please review Documentation/accounting/delay-accounting.rst, see if
there is some change we can make to reflect this patch.

Your email client is wordwrapping the patches - please check that for
next time.

