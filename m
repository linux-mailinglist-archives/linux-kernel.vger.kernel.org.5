Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879EA7C590C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjJKQW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjJKQW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:22:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D191
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:22:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D97C433C8;
        Wed, 11 Oct 2023 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697041377;
        bh=L+z+TtDcCiFtqaagBTUm6XkUXnNHXrekg2OIPgiZcXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kVuEeJRI1gd5wh/U+7Ky1UVZRzfUOEzHsmYTvBY4kBBQmbScFQnBqENnpkKwTNNpx
         KM1n6l+VmlwiQtm0bufmOzcXj6uLm1PFXj4RdpM5JHWrk18iN6RebIO703itEA2C9w
         IH4QHmCD7QfrT13c5vyGeJhDunCJzo3roNSCjkA7X/lo2CFpxDeZDhC2++mNymECka
         DsVDBa/OMnv2N+fLGvCtYFAkmJtpS7WRN4i6YEHdV0UUlaF8xwJR+emy+Hz7i0rmEW
         R8NePblJv6srOC9FEwDBGEjUKR8zTPB0IllJM+PZ7ERi0RrCPgs72EgHCx6xx3g/+g
         nZKJCXb3X3arw==
Date:   Wed, 11 Oct 2023 09:22:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Davide Caratti <dcaratti@redhat.com>
Cc:     Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] Documentation: netlink: add a YAML spec
 for mptcp
Message-ID: <20231011092255.383ae6ed@kernel.org>
In-Reply-To: <CAKa-r6sT=WaTFqumYOEzOKWZoUi0KQ8EYpQ753+C5JjjsUb3wA@mail.gmail.com>
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
        <20231010-upstream-net-next-20231006-mptcp-ynl-v1-3-18dd117e8f50@kernel.org>
        <20231010180839.0617d61d@kernel.org>
        <CAKa-r6sT=WaTFqumYOEzOKWZoUi0KQ8EYpQ753+C5JjjsUb3wA@mail.gmail.com>
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

On Wed, 11 Oct 2023 12:13:04 +0200 Davide Caratti wrote:
> > Do you not want the exact length for this?
> > If YNL doesn't support something just LMK, we add stuff as needed..  
> 
> ohh yes, we had NLA_POLICY_EXACT_LEN before but ynl doesn't seem to
> support it. I can try to add the support and include another patch at
> the beginning of the series, is that ok?

Yes, definitely, thanks!
