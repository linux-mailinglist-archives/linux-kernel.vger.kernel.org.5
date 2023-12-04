Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ABB80410C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjLDVl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDVl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:41:28 -0500
Received: from gentwo.org (gentwo.org [IPv6:2a02:4780:10:3cd9::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31413B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:41:34 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
        id B0DA648F2E; Mon,  4 Dec 2023 13:41:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id AECE74662B;
        Mon,  4 Dec 2023 13:41:32 -0800 (PST)
Date:   Mon, 4 Dec 2023 13:41:32 -0800 (PST)
From:   "Christoph Lameter (Ampere)" <cl@linux.com>
To:     chengming.zhou@linux.dev
cc:     vbabka@suse.cz, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v5 9/9] slub: Update frozen slabs documentations in the
 source
In-Reply-To: <20231102032330.1036151-10-chengming.zhou@linux.dev>
Message-ID: <dd73fdd6-b093-b32a-85a3-25cd22c21652@linux.com>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev> <20231102032330.1036151-10-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023, chengming.zhou@linux.dev wrote:

> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> The current updated scheme (which this series implemented) is:
> - node partial slabs: PG_Workingset && !frozen
> - cpu partial slabs: !PG_Workingset && !frozen
> - cpu slabs: !PG_Workingset && frozen
> - full slabs: !PG_Workingset && !frozen

The above would be good to include in the comments.

Acked-by: Christoph Lameter (Ampere) <cl@linux.com>

