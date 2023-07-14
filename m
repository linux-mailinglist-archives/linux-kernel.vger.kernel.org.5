Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74584753215
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjGNGgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjGNGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:36:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396F930D7;
        Thu, 13 Jul 2023 23:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=piPKsxY5Rl0p5bZSsZwd82W/y+JBPIg9n7o0YUowYaY=; b=auOnV/iXNYupYvOxlubXO36ewX
        4demD8frDEdp6+cocLBPxR5hgwn1JqKH1SC7G5zuUjh0hym86uT/oBCAUgbZqUhq1CNm+uFM3yast
        iAKNvedThnZYvCrOUvcfBeuZXIH1+yY08zp4nq0PU/IQKLSqbsXoGkArIEP4NgGN8czzfBFoiZboi
        KTxSjUMLb9AnKNvQ0cuKAGIJLjParaXI91Q9XFg7pE6hzishK56k6Kkt4jZOb7tzXz00MktYX0QxE
        jqiG+pd9zvds0jdEWfPWXIne4E6riV2CDAeYoZrK3Hqd7G3oU4j46qtzp42TvuflxuS3W9N+Ua2fu
        wYGQRICA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qKCOy-005BeC-2N;
        Fri, 14 Jul 2023 06:35:40 +0000
Date:   Thu, 13 Jul 2023 23:35:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     liubin001@208suo.com
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs:Comparisons should place the constant on the right
 side of the test The if statement uses an assignment statement as a
 condition, which is confusing.
Message-ID: <ZLDsvGI67LzOPp/l@infradead.org>
References: <tencent_31C29C1E7BD35451F49750644121169CB608@qq.com>
 <e48842634c7d7ee1123d1887e7a04377@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e48842634c7d7ee1123d1887e7a04377@208suo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:26:08PM +0800, liubin001@208suo.com wrote:
> xfs:The if statement uses an assignment statement as a condition, which is
> confusing.
> Signed-off-by: Liu Bin <liubin001@208suo.com>

What's the point?  I prefer the style you change it to as well, but
there is no real downside, and changing code just for the sake of it
causes nothing but churn.

