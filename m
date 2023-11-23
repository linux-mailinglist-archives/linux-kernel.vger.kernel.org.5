Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624CC7F6870
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 21:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjKWUTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 15:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 15:19:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723E6127
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 12:19:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4C7C433C7;
        Thu, 23 Nov 2023 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700770794;
        bh=UuTLzGGuH9YcnubjdF1BCJM+K4+61EnWHvDrzsYsIjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/IYGv0y33AVuo6lVGfICAh9QGCeCF05WduzQig+AWwMeM7xMbDEiE049+6LzaOoR
         vCfuf8Qyw4nfPp/Rm9M2b1iG9OSOokB5gWsSjAHpDRCU0D+3aOrtwDN1sfJpeFtR6p
         bPHgaCBJvKCfquudN2B/3zcOdVZADe4nUm4aI0Qg=
Date:   Thu, 23 Nov 2023 20:19:45 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-usb@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/17] tty: small cleanups and fixes
Message-ID: <2023112321-veto-trapping-ca47@gregkh>
References: <20231121092258.9334-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:22:41AM +0100, Jiri Slaby (SUSE) wrote:
> This is a series to fix/clean up some obvious issues I revealed during
> u8+size_t conversions (to be posted later).

I applied most of these except the last few, as I think you were going
to reorder them, right?

thanks,

greg k-h
