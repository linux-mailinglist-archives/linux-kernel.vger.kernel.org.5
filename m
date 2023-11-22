Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF27F52BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjKVVjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKVVju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:39:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699CCDA;
        Wed, 22 Nov 2023 13:39:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24948C433C8;
        Wed, 22 Nov 2023 21:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700689186;
        bh=EEOjqT3UP3KXbuKk0Jj/F1pAkbZLbGDrS5Q7GLNt3kQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yW75kvZEoV+UoryZy5nutpVrdTdfKrZylBloJVNcdBKnrm/bTfmro8iuK+493oP2s
         nlWVzwEU3RJ6Tu6A/Q+h1esyk5F7uptmg+4VMz0nFGwPRY63sM+KyJ0QdxeBbBV0qi
         yV08pwkr1E7N9P1Lhg7vw8qLRyzhcymj2WDrqHCU=
Date:   Wed, 22 Nov 2023 13:39:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vinicius Petrucci <vpetrucci@gmail.com>
Cc:     linux-mm@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, minchan@kernel.org,
        dave.hansen@linux.intel.com, x86@kernel.org,
        Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com,
        gregory.price@memverge.com, ying.huang@intel.com,
        dan.j.williams@intel.com, hezhongkun.hzk@bytedance.com,
        fvdl@google.com, surenb@google.com, rientjes@google.com,
        hannes@cmpxchg.org, mhocko@suse.com, Hasan.Maruf@amd.com,
        jgroves@micron.com, ravis.opensrc@micron.com,
        sthanneeru@micron.com, emirakhur@micron.com,
        vtavarespetr@micron.com, Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
Message-Id: <20231122133944.297ce0001fb51214096dfb6c@linux-foundation.org>
In-Reply-To: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 15:31:05 -0600 Vinicius Petrucci <vpetrucci@gmail.com> wrote:

> From: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> 
> This patch introduces `process_mbind()` to enable a userspace orchestrator with 
> an understanding of another process's memory layout to alter its memory policy. 


I'm having deja vu.  Not 10 minutes ago, Gregory sent out a patchset
which does the same thing.

https://lkml.kernel.org/r/20231122211200.31620-1-gregory.price@memverge.com

Please share notes ;)
