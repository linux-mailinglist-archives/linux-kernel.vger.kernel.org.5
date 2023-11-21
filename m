Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FAA7F392D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjKUWaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjKUWaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:30:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F084E1AC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:30:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210E2C433C7;
        Tue, 21 Nov 2023 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700605809;
        bh=E/bj/1FVapv7EKfhI42/zUXrmVv/I6HbzaDjwjJln44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J0O/QUcwf+hJ+9u9th7dU4ofixzovumMaQmyel928dNYI3hDAJCkcNaTDY1YmSPSY
         k4JEXGgkPh6+2HD0yj3ygvLKntXV+4Tm7RJc8gv8cB45K2aA93QUPbdxgrZW+Bmino
         9zX/6yfoT0Q66adsWy5pqbzUZROQLvIzs3aXRDrdnySIdjnXW0jVo39VHRA4WbT15p
         dij3w0gQdCj4D7jnuEasrt64GCxI7XA9h8wX45W1J/xG5/QYDT0XMbMmdgg/dgYLBs
         oculAlRo7XNFCoKGLeEguIrSPGRw6zvAciYRVBJddP01oVEsSOQEffzrbkFGmMwy7M
         mSCzyhHpnt5kA==
Date:   Tue, 21 Nov 2023 14:30:08 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 10/17] tty: hso: don't initialize global serial_table
Message-ID: <20231121143008.576f4ca9@kernel.org>
In-Reply-To: <20231121092258.9334-11-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
        <20231121092258.9334-11-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 10:22:51 +0100 Jiri Slaby (SUSE) wrote:
> 'serial_table' is global, so there is no need to initialize it to NULLs
> at the module load. Drop this unneeded for loop.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>

Acked-by: Jakub Kicinski <kuba@kernel.org>
