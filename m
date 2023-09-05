Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A587932AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 01:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbjIEXoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 19:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjIEXoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:44:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C1D1B4;
        Tue,  5 Sep 2023 16:44:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3B5C433C7;
        Tue,  5 Sep 2023 23:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693957448;
        bh=Iy2Smr5XT9EydF4Ow/Odp5Oq0/ZFb4pdyDqcePjHOR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F2fPLad9rpQsL2yHDA/o1oETOAvn9xq8oG3LdyD83KFnrrXMpylapPzdxe1AZmC3n
         R+EdrjzWzoZvPHmTN4IF81I3mZsUrLiSvLMz5qlk5xGa2an1XsNUZRHJrkURTUsXgg
         31RVRWdKcc5LY3iOiWw9q25vYLdZ+BoZt1uf8mp2ZHzP7yMSa7YAjWuysEoaxh62GT
         4z0kpLNL4v/cQABh/M7SuX8jo2RwW40PWbBXPiv+PzNVzmH/Ajr/6x0oLJF0eoKFI2
         T9wsWV6V2HsutE3biEsIKXhsZiaOFbQOVtaCW9E/DuYIaBXqco28K97z9AVELuC/2E
         IzEfMJKX4oqaA==
Date:   Tue, 5 Sep 2023 16:44:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the net-next tree
Message-ID: <20230905164406.04ff113c@kernel.org>
In-Reply-To: <20230906085543.1c19079a@canb.auug.org.au>
References: <20230626162908.2f149f98@canb.auug.org.au>
        <20230906085543.1c19079a@canb.auug.org.au>
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

On Wed, 6 Sep 2023 08:55:43 +1000 Stephen Rothwell wrote:
> > Documentation/networking/kapi:144: include/linux/phylink.h:614: WARNING: Inline literal start-string without end-string.
> > Documentation/networking/kapi:144: include/linux/phylink.h:644: WARNING: Inline literal start-string without end-string.  
> 
> These have not :-(

Fix posted. I thought it was about phylink_mode_*() but apparently 
the warnings are always reported with line num of the first line of
the paragraph, and the problem was actually in %PHYLINK_PCS_NEG_*.

Humpf.
