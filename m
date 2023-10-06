Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439877BBCB2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjJFQ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjJFQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:27:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F7ED8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:27:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9F6C433C7;
        Fri,  6 Oct 2023 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696609640;
        bh=90ddX5tPs3p1lK97UoymRRx1iOBXjVZFctsN3JCcwoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jmhUeixjf25xWnwRNP14IFN9CdnfbsfH+Nj+5YUTEbgcRIz8usaLiX2M/tHQlCRa7
         AuBYiz9usSHEYn6uCuxw31N6x2A3mpc2s/8A1JPeeDuoMvtbMP8fi1Z2cfcFwAvem7
         mVbMHISCJzIi+9b37/aweG4KbSGm0HEz09TzDXsU=
Date:   Fri, 6 Oct 2023 09:27:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel@collabora.com,
        Paul Gofman <pgofman@codeweavers.com>
Subject: Re: [PATCH v33 3/6] fs/proc/task_mmu: Add fast paths to get/clear
 PAGE_IS_WRITTEN flag
Message-Id: <20231006092716.d7a31ee613b1ffc4f592d48f@linux-foundation.org>
In-Reply-To: <6cee3838-1807-4983-9d7f-b3a30ee30563@collabora.com>
References: <20230821141518.870589-1-usama.anjum@collabora.com>
        <20230821141518.870589-4-usama.anjum@collabora.com>
        <6cee3838-1807-4983-9d7f-b3a30ee30563@collabora.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 16:40:53 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> You picked up all the other patches in this series except this one. Thank
> you so much. I'm unable to find any comment on why this wasn't picked or
> maybe you missed it?

Ah.  The email didn't land in my inbox (or lkml, or linux-mm) and I
didn't notice the gap.

I found it on lore, thanks.
