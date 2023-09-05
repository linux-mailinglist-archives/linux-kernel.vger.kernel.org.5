Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5BC793054
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241831AbjIEUvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjIEUvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:51:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C2692
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:51:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF0AC433C9;
        Tue,  5 Sep 2023 20:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693947065;
        bh=IAfZD62GpmBQoVGiSUG9EApPenk0Eiw2bjCJMCsRqyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n9LEKj/AoIxy36nnexsV6oqzkMZkl9gynD9E6ojvBpffxxQVRz816uTmHvLZg4sFo
         NN57OGAR0rV6mxxgUA6NAFrDnSjn9rZ8N/VxkXyq1TppUgXaBNwOo7DZZzXlOWb6rc
         bvAsBxk54AHgNLe3uYYw6WXw7JbXJQpjWx50HDIhL9N3bBBgxExKob/9ybRAl8nm8v
         9cQd+1bLrqOuVo0qZ0jchYJlbjfpQjhz9jQxsW0Fy91wUZWx54vME6lPktNNc3dwgH
         Ua7q3i/fobLiaB+Wkwpbr73SlUgm1QoRAC9A0uGuF1uQltel6QeByTVXKh5PFAtCVD
         N7irBo0mhMZVA==
Date:   Tue, 5 Sep 2023 13:51:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Maxim Mikityanskiy <maxtram95@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH net] net: stmmac: fix handling of zero coalescing
 tx-usecs
Message-ID: <20230905135103.04649841@kernel.org>
In-Reply-To: <20230905-stmmac-coaloff-v1-1-e29820e8ff6d@axis.com>
References: <20230905-stmmac-coaloff-v1-1-e29820e8ff6d@axis.com>
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

On Tue, 5 Sep 2023 13:32:48 +0200 Vincent Whitchurch wrote:
> Setting ethtool -C eth0 tx-usecs 0 is supposed to disable the use of the
> coalescing timer but currently it gets programmed with zero delay
> instead.
> 
> Disable the use of the coalescing timer if tx-usecs is zero by
> preventing it from being restarted.  Note that to keep things simple we
> don't start/stop the timer when the coalescing settings are changed, but
> just let that happen on the next transmit or timer expiry.
> 
> Fixes: 8fce33317023 ("net: stmmac: Rework coalesce timer and fix multi-queue races")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

This does not apply cleanly to net, please rebase and repost.
-- 
pw-bot: cr
