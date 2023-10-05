Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1027BA19C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbjJEOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbjJEOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:39:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B1324843
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:05:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FA9C433B7;
        Thu,  5 Oct 2023 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696514739;
        bh=uEs+c2evdAN1gGRELIzgOPEmlANziGZN9NaBywOLzVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q0UghGfvomUGJjKVgB7EPISuwTzykstgzqZoQQoyr1v4jQFCR2YiSIB2j4OvDki4Y
         DykfvZLOqqbKJsswerJN1NM8sWOTOKX7ppC9EVGJXh9kT745ExQgPZPu2v7NM48vYA
         bTDW5iMCXK/+i3lYYCA9KwS1U6hlunEHWLralA412S2zKG3KpYjoKgphJDRBmlUxnP
         ZwimK57Z2PrNOXkSErMA1MGAG80jh6aIHOfq64IsKTAPPjOPYOtat6/eCI3KHtYbr1
         oPXp5YVb0/1sZqrFlYetYso8MY+qeIX7enuC+TK2J94fUe8XMHBHpq8C4gWSb5owmI
         W90baIp4KOXAw==
Date:   Thu, 5 Oct 2023 07:05:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     alexandre.torgue@foss.st.com, andriy.shevchenko@linux.intel.com,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, fancer.lancer@gmail.com, joabreu@synopsys.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts
 handling
Message-ID: <20231005070538.0826bf9d@kernel.org>
In-Reply-To: <20231005121441.22916-1-rohan.g.thomas@intel.com>
References: <20231004092613.07cb393f@kernel.org>
        <20231005121441.22916-1-rohan.g.thomas@intel.com>
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

On Thu,  5 Oct 2023 20:14:41 +0800 Rohan G Thomas wrote:
> > So the question now is whether we want Rohan to do this conversion _first_,
> > in DW QoS 5, and then add xgmac part. Or the patch should go in as is and
> > you'll follow up with the conversion?  
> 
> If agreed, this commit can go in. I can submit another patch with the
> refactoring suggested by Serge.

Did you miss the emphasis I put on the word "first" in my reply?
Cleanup first, nobody will be keeping track whether your fulfilled 
your promises or not :|
