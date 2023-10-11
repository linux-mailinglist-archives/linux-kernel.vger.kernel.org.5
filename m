Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A377C4710
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344586AbjJKBKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbjJKBKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:10:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4C792
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:10:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD97C433CD;
        Wed, 11 Oct 2023 01:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696986614;
        bh=2IfNHYRbev2ob8PWFLqJ/T/VpvjKdoXQ/QJwspMHZVQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=azd0VSfOVuUgSlae+InN/Nq0QJC5WUtCO/YxqhpEbFIYFUpyiyDyb6V3bE1s+8631
         dLXPNNEBRg9WYNwbyh9SEL94tP1io6c82lloUP5xjmRaTCr9ELT85IDVq5xg8ts/w5
         0/QIy8+GdxsT0bT18PFF39/agaql2agzuPCUtTX52GtptjnryvX5EBWPbPKPUQxyA3
         DYG/SeWTMegue7lrEukE6JiFyG40bmVjuIxYakBb2eti3qxHDR8oh0SDi1XTp5hJOy
         MXXy5sfhXSF8rDAXQxTPSdhArn+3a/HiTRhAk7V4mY1S4Nd9fG7eWK3mEzCveaYTWf
         MsMr8JG4BK+Sg==
Date:   Tue, 10 Oct 2023 18:10:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Joel Becker <jlbec@evilplan.org>
Cc:     Breno Leitao <leitao@debian.org>, davem@davemloft.net,
        pabeni@redhat.com, Eric Dumazet <edumazet@google.com>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: Re: [PATCH net-next v3 2/4] netconsole: Initialize configfs_item
 for default targets
Message-ID: <20231010181013.67187de2@kernel.org>
In-Reply-To: <ZSWlppHwravDLyZN@google.com>
References: <20231010093751.3878229-1-leitao@debian.org>
        <20231010093751.3878229-3-leitao@debian.org>
        <ZSWlppHwravDLyZN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 12:27:34 -0700 Joel Becker wrote:
> > +#define NETCONSOLE_PARAM_TARGET_NAME "cmdline"  
> 
> Perhaps `NETCONSOLE_PARAM_TARGET_PREFIX` is better.  Makes it clear this
> is not the whole name.

FWIW I had the same thought when looking at v2.
Didn't wanna nit-pick but if there's two of us...
-- 
pw-bot: cr
