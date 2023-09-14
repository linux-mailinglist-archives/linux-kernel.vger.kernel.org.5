Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC087A0DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbjINTFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbjINTFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:05:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453C10C7;
        Thu, 14 Sep 2023 12:05:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34460C433C7;
        Thu, 14 Sep 2023 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694718305;
        bh=C2p16jszPccNENVYFMm6hSk6QYVllb038XOCX1sz83g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xRWg1FWsVG7mnkdIzOVfBHl+4csSigkXv1FqGXo2+CbbVXp1sjwYIrh4HM5M7Zyc+
         nhJvlsq/c9u9tnCOOHR9jfwB4nDMo6cYJI1AO1aK528bPXQeS2fA4xRAq/07+cO7zN
         hHkEaTi64UUJoIG8HmeB1aJ8CiPpoi5FbNo2pjx8=
Date:   Thu, 14 Sep 2023 12:05:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "\"Mike Rapoport (IBM)\"" <rppt@kernel.org>,
        stable@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v3 1/5] mm/cma: use nth_page() in place of direct struct
 page manipulation.
Message-Id: <20230914120504.b9bbed45e3b2f59b94e87587@linux-foundation.org>
In-Reply-To: <5C626EBA-B115-4A95-8D55-5EE28C872419@nvidia.com>
References: <20230913201248.452081-1-zi.yan@sent.com>
        <20230913201248.452081-2-zi.yan@sent.com>
        <5C626EBA-B115-4A95-8D55-5EE28C872419@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 22:16:45 -0400 Zi Yan <ziy@nvidia.com> wrote:

> No related bug is reported. The fix comes from code
> inspection.

OK, thanks.  Given that none of these appear urgent, I'll move the
series from the 6.6-rcX queue (mm-hotfixes-unstable) and into the
6.7-rc1 queue (mm-unstable), while retaining the cc:stable.  To give
them more testing time before landing in mainline and -stable kernels.


