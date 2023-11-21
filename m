Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F057F2528
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjKUFSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjKUFSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:18:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE8ED;
        Mon, 20 Nov 2023 21:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0IQyXB4lFR5QVHXCSZcGjzmyyThMkWKD+nk8D0ijT9w=; b=4kpD4oxlnlflUTPXRGTky1Rbrq
        TXgXHt7jI+pXwCDIHvo9KL7BmAclqhOXsA+GM/gDmiB94fguYgyFfGNiCK2M8oO5TeZLOETSHDthJ
        4E11MN/no4PoG8WTweUICysT3YSbIVyBWREeXJ2t0IiqWnthMqyf+fIrKvRT8K95+rarV+lLLoS22
        tRd+pRD5b+VmXV0ouMb5wKbJHKTkMpyuWmS+cPwWY5ECpw2JZrovMP546MQ3U0KWxq1rp1rxL00BI
        k4YrR/MRchV70bn9gUS1/igjpw4SvNo0HpTzXXWkFRob178m4XbFgfTETGvSBS/nTKI0eluFlPbqq
        XKyLV2JQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r5J9a-00FfQY-1U;
        Tue, 21 Nov 2023 05:18:30 +0000
Date:   Mon, 20 Nov 2023 21:18:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/12] Convert write_cache_pages() to an iterator
Message-ID: <ZVw9ppybs8FmIPVc@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626173521.459345-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just curious where this did end up.  I have some changes that could use
or conflict with this depending on your view.  They aren't time critical
yt, but if we're going to the road in this series I'd appreciate if we'd
get it done rather sooner than later :)

