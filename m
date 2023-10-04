Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979F87B871B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjJDSAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJDSAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:00:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2B9E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:00:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EC1C433C8;
        Wed,  4 Oct 2023 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696442432;
        bh=Kl3qkuDXwVsPtemGj5YLfWsZgo/fk06VDeK+hdq5JiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j0kwz0zqiLuwTdWFK4Xp5H0+qrsMOkaOOoLenoaD7ZiM72mZsYQNoWYF0eLPbKcB+
         nWoyQvPBeaxY0d/KoZj6wCeNVdSlC/vqzojUGHojMwWtuVO4QU67NXI+0dMiMNzuaf
         9RK68AGbS1L71+qzsQuILJXwK5U1D4+PYrLsCfbW334BZwjvBDttkvmoFoO7oUpZ3m
         P7rUkpU0d0aXnQOUKqjzDvZPMS9Zb59mtI45fBXyFXrDlD9eksA555ibq4Pg7XagAz
         fRtaj5ixqSNW+4F7sqVaQh81rJcDD/SDxtdFQn+Y6UfhkpFvQ3sCEZXg4dittX7ShG
         yue9UaFDGxiVg==
Date:   Wed, 4 Oct 2023 11:00:31 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Cc:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <bryan.whitehead@microchip.com>, <unglinuxdriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] net: microchip: lan743x: improve throughput
 with rx timestamp config
Message-ID: <20231004110031.7e9c32e8@kernel.org>
In-Reply-To: <20230926155658.159184-1-vishvambarpanth.s@microchip.com>
References: <20230926155658.159184-1-vishvambarpanth.s@microchip.com>
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

On Tue, 26 Sep 2023 21:26:58 +0530 Vishvambar Panth S wrote:
> +			netif_warn(adapter, drv, adapter->netdev,
> +				   "rx timestamp = %d is not supported\n",
> +				   rx_filter);

I addition to Jake's comments please also drop this warning.

> +			return -EINVAL;

And make sure this is the correct return code.
I thought -ERANGE was more appropriate here, but I could be wrong.
