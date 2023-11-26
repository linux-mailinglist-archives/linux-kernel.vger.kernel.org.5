Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3508B7F93BF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 17:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjKZQZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 11:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZQZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 11:25:41 -0500
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Nov 2023 08:25:46 PST
Received: from kurisu.lahfa.xyz (unknown [IPv6:2001:bc8:38ee::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39C5D7;
        Sun, 26 Nov 2023 08:25:46 -0800 (PST)
Date:   Sun, 26 Nov 2023 15:27:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lahfa.xyz; s=kurisu;
        t=1701015603; bh=aGwI/sBkDJ0eK/6IECx5Wa1kB+sn3pxbBYSXU/jYCvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To;
        b=oX9lc5IID8jnjVdZDgFCx623A1+LrRDd62f6m3d0mQnlX3jUhEN3ySBkO2ryopJT9
         J1L/BzMViOY7JonATvFnGOJvX356RMN0rb3gUXZhjlV/hsQrYzpMKLEOoaYKsp34/C
         M2uirTsKAErlwpNoh06qcpXkNl0CAN2/zw3wmxfw=
From:   Ryan Lahfa <ryan@lahfa.xyz>
To:     zhengqi.arch@bytedance.com
Cc:     akpm@linux-foundation.org, brauner@kernel.org, cel@kernel.org,
        david@fromorbit.com, djwong@kernel.org, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, muchun.song@linux.dev, paulmck@kernel.org,
        roman.gushchin@linux.dev, senozhatsky@chromium.org,
        steven.price@arm.com, tkhai@ya.ru, tytso@mit.edu, vbabka@suse.cz,
        yujie.liu@intel.com
Subject: Re: [PATCH v6 00/45] use refcount+RCU method to implement lockless
 slab shrink
Message-ID: <oiinfvmshahzzwfjo3bn5zjspuoeei3yg3sutstmzkang4lwfp@m7esnepoxwtc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Given that this series removes the old shrinker APIs and re-adds new
shrinker APIs with `EXPORT_SYMBOL_GPL`, is the intention to prevent any
out of tree module user which is incompatible with GPL to use the
shrinker APIs to register callbacks?

Or is there an alternative I was not able to find out by reading this
series?

Thank you for your work,
Kind regards,
-- 
Ryan Lahfa
