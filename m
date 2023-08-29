Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8FD78CCA9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbjH2TGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbjH2TFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:05:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C714CFF;
        Tue, 29 Aug 2023 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gj1475y6YPHMbgYi7t3QoRaGwpUqmVhjBLX7hdQv8dM=; b=2ATrGX9eb8MplDLGod9gLLe7fG
        7JLASlz1FGWnlfcgh++YbPGScpSwCQtVrJXqZS+7+jZX4EyAqD7ACsG7PYRwKSoSXh//+ItaZDE+/
        6QaFZNPRpNAuXUvYGBWGBSyx7pBJ1H+i6OghTWu+7PZBbjMwFghwFzHmTSySCdcrvdFwxTfC57x5W
        /M7GaRVQ/KPd+kYMCjqVQ7r1NopgzkxcsPZcvnD/n3c0cs0XjMUAWa/nwU6q8GDHEjl9wUIQIMOb+
        HPtv+2ww5EPSb5aLKZNZPSox/aTCLVmQABD+kxj+980ETisJ4vCay4e93KIYcGeRzcwNP53xaCvAh
        xHnE1w3g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qb422-00C6jz-36;
        Tue, 29 Aug 2023 19:05:42 +0000
Date:   Tue, 29 Aug 2023 12:05:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module/decompress: use vmalloc() for zstd decompression
 workspace
Message-ID: <ZO5BhjEyITT5YvTm@bombadil.infradead.org>
References: <20230829120508.317611-1-andrea.righi@canonical.com>
 <ZO4fvAKJfKs8USZO@bombadil.infradead.org>
 <4ut44zckyknjwdzvxzefiysfjorl3nzqvs2j3scsrlgmgngjgs@hjrkcqoavq5h>
 <ZO4u+6atPevjudZm@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO4u+6atPevjudZm@righiandr-XPS-13-7390>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 07:46:35PM +0200, Andrea Righi wrote:
> On Tue, Aug 29, 2023 at 10:30:55AM -0700, Lucas De Marchi wrote:
> In conclusion I think we should be pretty safe for now by just changing
> gz and zstd.
> 
> Maybe having two separate patches is better (in case we need to revert
> just one for any reason...)?

Yes, that is why I already merged your zstd patch. If things do blow up
the collateral is smaller.

  Luis
