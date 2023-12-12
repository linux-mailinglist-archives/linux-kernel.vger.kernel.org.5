Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17180E357
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjLLEet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjLLEer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:34:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB1AA6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:34:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE29AC433C8;
        Tue, 12 Dec 2023 04:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702355694;
        bh=I4R2B+RBsqShG0X7SO/Qln27isb1UxQm2PVbMLk8OOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wy92Xu0GuNi3RkDwWZAuzbNoIjXotFScQWQgipvCy8rbWuwEtGNNfejlHjThN+JMl
         47IMZuY5r71OZiQSS+oTobYoux2XYkkJGsTZmX2r4rwxhT5YW0upI5RB+2eYOqIAaq
         FrY7N19ZDQWDBgU79AkenynQOiD73Dn1ow0ZzAAtDfWD3dn21gS3fPLRSiy+PmD5eO
         CHNjFvcfPdIOf2/DXZDZornN/EJsnNiKYar/FWS2KQzm68Iiz1h6xNTZLcC1YE818F
         isoBWGEF1bIvYOpoykA83aW7SDPHzY4lV21NK4YH3U4Ak+PTDnucDx3jdwrZeQnrAr
         2btfDRBwjS89A==
Date:   Tue, 12 Dec 2023 10:04:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: axi-dmac: Small code cleanup
Message-ID: <ZXfi6dqrZADEkCya@matsya>
References: <20231204140352.30420-1-paul@crapouillou.net>
 <20231204140352.30420-2-paul@crapouillou.net>
 <ZXb5IhaNiKJufH/k@matsya>
 <3da88ffe37e1fa20918848fdef8f80e5ae49743a.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3da88ffe37e1fa20918848fdef8f80e5ae49743a.camel@crapouillou.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-23, 13:15, Paul Cercueil wrote:
> Hi Vinod,
> 
> Le lundi 11 décembre 2023 à 17:27 +0530, Vinod Koul a écrit :
> > On 04-12-23, 15:03, Paul Cercueil wrote:
> > > Use a for() loop instead of a while() loop in
> > > axi_dmac_fill_linear_sg().
> > 
> > Why?
> 
> Simplicity? Code quality?

It would be great to mention the reason :-) right?

-- 
~Vinod
