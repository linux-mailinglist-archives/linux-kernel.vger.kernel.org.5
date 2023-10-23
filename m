Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070397D3F01
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjJWSTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjJWSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:19:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBE1B7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:19:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3416C433C8;
        Mon, 23 Oct 2023 18:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698085183;
        bh=dy5yOFfR2RJAzRBmoL1rH+mUOjMCsv2fNpdQ/Sto3lc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vXdn0UnakIS2B8at7h4P6EDPAiNz8TD4z+xOjeLd9Sd2+WjXNQUEvv88N3pXnMMRH
         3lfIspRCaTyZwQ78O9+25dOEBXS9npCQJpmIA6YTmbvj2v0quGQoqMgdVbIfkXVxuH
         IOb7mOnbSkwCRUda2YaimCV8XD4REovhfc3vIEzI=
Date:   Mon, 23 Oct 2023 11:19:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, rppt@kernel.org,
        david@redhat.com, vbabka@suse.cz, mhocko@suse.com,
        willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm: memory_hotplug: drop memoryless node from
 fallback lists
Message-Id: <20231023111942.b0c70656b90ea6575cb44240@linux-foundation.org>
In-Reply-To: <d97ba697-16d9-4e62-86bd-31207b621b11@bytedance.com>
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
        <9f1dbe7ee1301c7163b2770e32954ff5e3ecf2c4.1697711415.git.zhengqi.arch@bytedance.com>
        <87bkctg4f4.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <4bfa007c-a20f-9e68-4a9f-935dacf43222@bytedance.com>
        <8734y2f868.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <b6319738-0d71-4083-a5db-845430b8a5d8@bytedance.com>
        <87pm16doe5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <d97ba697-16d9-4e62-86bd-31207b621b11@bytedance.com>
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

On Mon, 23 Oct 2023 11:17:03 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> Hi Andrew, can you help modify the commit message to this? :)

Done, thanks.
