Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32A7D0416
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346602AbjJSVkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjJSVkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:40:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0291116;
        Thu, 19 Oct 2023 14:40:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F187CC433C7;
        Thu, 19 Oct 2023 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697751605;
        bh=x8GN6NCbu6Jk2mBeilh7gQpV1V166ITF8wV8WZ8Ek0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=to2UauIl3D3hwG5RmRnkrOS1DYL9XFSGhy7AnbJaHCXWB1KffB7tMJGcltBXZrPX/
         SHMTWHuFFaofvz6bf3vJdB4IeeiQxmo6X8zAS23BT8h6gUAVWiNKvR33JNhlLkwYM+
         ggxco2EUInTehFsFfMqBACGYg25QC1ZCogOlH+ia56BF4SMuN9OwCq9Ibkec22r68g
         CsA43XYVJiaJb3RJnH2PR3mqScVUDo6B3NPaSk39dEMnQ2ertwr1BKYuy2/Vl9YHtp
         GabfRHHgXvBtGKTkWBPyxaz4KiuMID8YUgSztQAuFkdHSFymoCP4enVoq3aGk9fPt/
         +DfOeIAXj8LJg==
Date:   Thu, 19 Oct 2023 14:40:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the wireless
 tree
Message-ID: <20231019144004.0f5b2533@kernel.org>
In-Reply-To: <987ecad0840a9d15bd844184ea595aff1f3b9c0c.camel@sipsolutions.net>
References: <20231012113648.46eea5ec@canb.auug.org.au>
        <987ecad0840a9d15bd844184ea595aff1f3b9c0c.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 10:10:10 +0200 Johannes Berg wrote:
> > I fixed it up (I just used the latter, there may be more needed)  
> 
> Just using net-next/wireless-next is fine, I actually noticed the issue
> while I was merging the trees to fix the previous conflicts here.

Resolved the conflict in 041c3466f39d, could you double check?
Also, there's another direct return without freeing the key in
ieee80211_key_link(), is that one okay ?
