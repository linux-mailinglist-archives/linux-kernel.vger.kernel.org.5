Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC189784696
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbjHVQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHVQI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:08:58 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298EACDA;
        Tue, 22 Aug 2023 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=G6ZcRu57pc0rNMbRY40DBeyunYVUkrnXfs8+LQg63vQ=; b=ZWcXMY2AQ9fQZ+rWYXzpW6ktKZ
        kVQzPqCHBpG6n07ynfUhC6ehC/jFk7Le15qzxDBmvlCv6ffI/5ZSwKv9NBG7dVoibEF4jhiy+i53S
        QZrDeIzbUuy7GUtLgaqowp6e4L/LujvTVKxVdyu7epiJdat2ybu/1lZLTuo026dkwl2I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qYTw0-004nZF-4u; Tue, 22 Aug 2023 18:08:48 +0200
Date:   Tue, 22 Aug 2023 18:08:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     kornel.swierzy@embevity.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix encoding of ethernet frame length for big endian
 platforms in QCA7000/7005 protocol header.
Message-ID: <ef21625d-5df7-4421-ab5b-3d49b83c553e@lunn.ch>
References: <20230822065956.8719-1-kornel.swierzy@embevity.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822065956.8719-1-kornel.swierzy@embevity.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 08:59:56AM +0200, kornel.swierzy@embevity.com wrote:
> From: Kornel Swierzy <kornel.swierzy@embevity.com>
> 
> QCA7000 protocol requires that ethernet frame length is encoded
> as u16 little endian value. Current implementation does not work
> on big endian architectures.
> 
> Signed-off-by: Kornel Swierzy <kornel.swierzy@embevity.com>

Hi Kornel

Please take a look at

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

and

https://docs.kernel.org/process/submitting-patches.html

This appears to be a bugfix, so it should have a Fixes: tag. It then
should be based on the net tree, and this should be indicated in the
Subject: line.

That change itself looks fine, you just have some process issues to
correct.

	Andrew
