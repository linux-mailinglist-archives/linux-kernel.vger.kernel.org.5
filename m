Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4497546B0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGOD7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGOD7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:59:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB57F358C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l+q68KBe+8nXV0cOjAwQofMDskSvIjb730x1Yrm5888=; b=Wc3/75xk97LMC8vxR+F4N+8nkH
        rvI2oDM+jwRckDL/y7JHfvtHqb4BUG5zbDOiZg4RQTOUudrtudz3ty+3kRRn19yA5UuvvBoiBIyfZ
        gqbSI9rGd3ltoS959pYsVtMp+8nS0SYvkL86j+x5jiR9h8mdcFPyj2JjDJTVLPM8Y8eGZXn0w7fE8
        jxjpVIvobIcWiR58N/lWhYlxXTrBRTiPNoNBZtshexums51OuV2cbfAMF9RUXnxZoTXsG07GL403K
        NCaADEL5j+Lwi6rGosr5b2d1Ih9TNODluuT/k42gwF6fWvQMSQek+X7Vc2od3E+MJ5U7w0pt+Z1M7
        +ZywhOEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKWR0-001nxD-Q6; Sat, 15 Jul 2023 03:59:06 +0000
Date:   Sat, 15 Jul 2023 04:59:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: memory-failure: avoid false hwpoison page mapped
 error info
Message-ID: <ZLIZil71OXXk8amg@casper.infradead.org>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
 <20230715031729.2420338-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715031729.2420338-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 11:17:28AM +0800, Miaohe Lin wrote:
> folio->_mapcount is overloaded in SLAB, so folio_mapped() has to be done
> after folio_test_slab() is checked. Otherwise slab folio might be treated
> as a mapped folio leading to false 'Someone maps the hwpoison page' error
> info.
> 
> Fixes: 230ac719c500 ("mm/hwpoison: don't try to unpoison containment-failed pages")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
