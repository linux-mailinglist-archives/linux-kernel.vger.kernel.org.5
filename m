Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BF47520FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjGMMOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjGMMNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:13:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9AB2D74
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3urhFUwWWNebcnKy85rTPq0px8uLk6KxMdBPu3Dv3ts=; b=RQJEc8fbULoN1uB9CkXJAs0SuM
        A/YvJ5VmqtwGh/ZEnXqQi0C1SY22cAAvttC9Q+IyZvVLeplm6lkQdjgKQT6UrofVywqmKQ7+d+BtW
        rtd6hK5o/MbnigOfguSAzl/61GTcyrHy1/jEAZchqj/lEU1IFe2nrZt4ukXAAuRwlQ4Ip7lpaDuNv
        y2eflSSsSUjNdwMifxQ8r2/8W/krejjuG/Dyrvwz2RytEspmPcbIRH6Dr7zYgclj9Zn4aZtVN0Rk9
        hNtYsc05oq3mqMWWyny40cRuwnt/AkkKFc47Oc8R+3McdlNFpKij7KBW1xlpC6emnuQ5DKqhRd+6A
        cv5Q//Aw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJvBm-0007fJ-Hf; Thu, 13 Jul 2023 12:12:54 +0000
Date:   Thu, 13 Jul 2023 13:12:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: use RMAP_NONE when calling
 page_add_anon_rmap()
Message-ID: <ZK/qRqAs4F30TQP9@casper.infradead.org>
References: <20230713120557.218592-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713120557.218592-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 08:05:57PM +0800, Miaohe Lin wrote:
> It's more convenient and readable to use RMAP_NONE instead of false when
> calling page_add_anon_rmap(). No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
