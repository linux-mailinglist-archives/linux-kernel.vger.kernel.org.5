Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6085775655C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGQNqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQNqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:46:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D428F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2mbBr1wISc8JCKNOqvm+I2DcHCPVJP4RjwQFJAmpNA8=; b=c5/sx/U50fbG2h9zLVfolw7wxu
        9BdHny/dmLIhpnUhkcd5dCPx9w7/PrBzgAkHonvolXuEuP+rhk9tbKzD0PY3jtiDQFaclX4L08nrN
        SPtMlx8DtEyZQFhx63cb0W4pHlj4ito22hwQibC9SGl0qrYCv6l5KRxVOylUZNNy3tleLG/4anF+u
        msaAMmp4d3fkous7tyv7yJoQntzHtsGmtn9d0EWrGxZgTGztbeNY8lQuQQ6cf0O5wZ+wtN+AzdvtS
        zeyGL9NJBv03nky1fXe691ZENlOUY9sb7/XLYhrw8Psb7lvDS+B9SXzmaf2g6gteKQY3bmsgEtRnY
        +pKb/UTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLOYF-003xZ6-7N; Mon, 17 Jul 2023 13:46:11 +0000
Date:   Mon, 17 Jul 2023 14:46:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH 6/6] mm/page_io: convert bio_associate_blkg_from_page()
 to take in a folio
Message-ID: <ZLVGI8wpIYgs5Vqd@casper.infradead.org>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-7-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717132602.2202147-7-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:26:02PM +0800, Peng Zhang wrote:
> Convert bio_associate_blkg_from_page() to take in a folio. We can remove
> two implicit calls to compound_head() by taking in a folio.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
