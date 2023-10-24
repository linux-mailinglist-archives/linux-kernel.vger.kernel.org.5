Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCB57D5854
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbjJXQ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343837AbjJXQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8189FAF;
        Tue, 24 Oct 2023 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G1sGCpTPpRYH405Dgwk8POGwifgPfOBE6A+Qe0PTDec=; b=IOlUJtAJ09C7MZ/SDOOBwO4TMZ
        DucMW7t6CRgCvBKWdz4gT0wgX9FudlG5ubBzB4fBzk5yKbyQkZn/5vAetcPopbm1nG9pz3B5pq92J
        /dlE+IIdOHvrLJ1Fr3mL2qZRm7eIlesLo/JMq8sbOwGc3DQtSI9IcSaW+Zi+1SgBw5QHU+zfyfatW
        ehw9AeZRM4q+6TvBuy01/9RS0ANCaFH9i9WtKpDpZfBNG3MZHRYkJzYq1+UUzuvnbqRtaFdeEdgg4
        7C2xBkTKAJ0+1yc4wDFquGcCisdrSx3lqrngxha26jYdXw57e6z3jSvfnsUgAqytBdMfNpbVPgW3g
        z55O1/VA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvKHG-003V45-PV; Tue, 24 Oct 2023 16:29:10 +0000
Date:   Tue, 24 Oct 2023 17:29:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, peterz@infradead.org, oliver.sang@intel.com,
        mst@redhat.com, maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
Message-ID: <ZTfw1nw15wijNnCB@casper.infradead.org>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
 <20231024083258.65750-4-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024083258.65750-4-zhangpeng.00@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 04:32:51PM +0800, Peng Zhang wrote:
> +++ b/lib/maple_tree.c
> @@ -4,6 +4,10 @@
>   * Copyright (c) 2018-2022 Oracle Corporation
>   * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
>   *	    Matthew Wilcox <willy@infradead.org>
> + *
> + * Implementation of algorithm for duplicating Maple Tree

I thought you agreed that line made no sense, and you were just going to
drop it?  just add your copyright, right under ours.

> + * Copyright (c) 2023 ByteDance
> + * Author: Peng Zhang <zhangpeng.00@bytedance.com>
