Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441FE7CC76C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344343AbjJQP0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344327AbjJQP0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:26:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A786BA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:26:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914D1C433C8;
        Tue, 17 Oct 2023 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697556380;
        bh=6c9g+TsbNLPgQESWrmr2fOIsVB5tfJx/lE+QaNHkWkk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E0fCTElf6Op4uqTcgXFqUTD1JmmUcWlep46ulGMHEZKW8ukh9HdjEbNOi7mVtOqBN
         Myx02rKPSHYd70LV6XfCSUDq9JSgUfOpbIEsaT9LU+dEorDfZWxW+hgIPJNP2h6XKG
         N+6r09diVSN+pEU8D2TzoA8rA4dRQg8hQwf8CrWk7lDS1fhHustRuKBt3WNzWDAq5t
         /P+lLp0b9R6EBDw5IGw8yFO8hE1HA9i3tkgjpyXDoqoUc4OIcect88iqY9yEDyzI+r
         CQOoHKA8kZnQ3VmPkU+46TbiJZjO7FCbijxsiheLX3BgHja8knyXh9GjMmYTclqJ9b
         fiMpPaDORRnhA==
Date:   Tue, 17 Oct 2023 08:26:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Simon Horman <horms@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH net-next 2/5] net: stmmac: fix PPS capture input index
Message-ID: <20231017082618.4558ad06@kernel.org>
In-Reply-To: <004d6ce9-7d15-4944-b31c-c9e628e7483a@pengutronix.de>
References: <20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de>
        <20231010-stmmac_fix_auxiliary_event_capture-v1-2-3eeca9e844fa@pengutronix.de>
        <20231014144428.GA1386676@kernel.org>
        <004d6ce9-7d15-4944-b31c-c9e628e7483a@pengutronix.de>
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

On Tue, 17 Oct 2023 11:12:53 +0200 Johannes Zink wrote:
> > If it is a bug fix then it should probably be targeted at 'net',
> > creating a dependency for the remainder of this series.
> > 
> > On the other hand, if it is not a bug fix then perhaps it is best to
> > update the subject and drop the Fixes tag.  
> 
> I added the fixes-Tag in order to make code archeology easier, but as it may 
> trigger picks to stable branches (which is not required imho), I have no 
> objections to dropping it for a v2.

Would be good to clarify what impact on device operation the problem
has. How would end user notice the problem?
Does it mean snapshots were always or never enabled, previously?

Note that if you submit this fix for net today it will still make it 
to -rc7 and net-next by tomorrow, so no major delay. We merge the trees
on Thursday, usually.
