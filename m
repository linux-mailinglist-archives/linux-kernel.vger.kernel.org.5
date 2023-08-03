Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD176E087
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjHCGvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjHCGvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A92D64;
        Wed,  2 Aug 2023 23:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EE5B61BF4;
        Thu,  3 Aug 2023 06:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBB7C433C8;
        Thu,  3 Aug 2023 06:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691045469;
        bh=43k3EvbDnD0qrF1ZOik+dSjCAEk8l1OcVzga1U7RXGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UM4vpu/5tZk9q+Tqz9Abjqp/f132V1HhBguBhQIQWcQMje3n7qo6FKncCubHURu2m
         gTtDgRPXw5fQf68bShyxy+PIwVvfithi78umYXwaCyUkz3UD4WPMxMTZ9KnuvoJPhT
         EMYkx8XAudYc7mWsSyYMNBBB/R+sK8gT/UOK7P1c=
Date:   Thu, 3 Aug 2023 08:51:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: nfc: remove casts from tty->disc_data
Message-ID: <2023080359-senate-expose-46b2@gregkh>
References: <20230801062237.2687-1-jirislaby@kernel.org>
 <20230801062237.2687-3-jirislaby@kernel.org>
 <20230802120755.10849c9a@kernel.org>
 <6808de4a-6002-e8bc-5921-06b5938dc69e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6808de4a-6002-e8bc-5921-06b5938dc69e@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 07:08:07AM +0200, Jiri Slaby wrote:
> On 02. 08. 23, 21:07, Jakub Kicinski wrote:
> > On Tue,  1 Aug 2023 08:22:37 +0200 Jiri Slaby (SUSE) wrote:
> > > tty->disc_data is 'void *', so there is no need to cast from that.
> > > Therefore remove the casts and assign the pointer directly.
> > 
> > Which tree are these expected to flow thru?
> 
> The intention was through the tty tree. But I don't mind either way -- it's
> up to you Greg.

I'll take them, thanks!

greg k-h
