Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3827BEA8E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378347AbjJIT1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbjJIT1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:27:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA8093;
        Mon,  9 Oct 2023 12:27:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32B5C433C8;
        Mon,  9 Oct 2023 19:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696879643;
        bh=bMuuJuCXLdqxidHDsH8QCILci9B9gM7g0lwjeG1YW4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zH4xbDsiAQHqh6hl8mrAxYcwj8mNztG5SYCp7m1W3xhND77GB3rwmbtQwUEp7F3Uw
         UXe/oyvEukMz43DGszMtGlflcZmRQhICRgJmWArRZ+8XMfEb+Vrx2HHsLCjAQ+S73w
         9gcdagDN42f8J6TBq09O0xKebvtnByN6FBpnEVDI=
Date:   Mon, 9 Oct 2023 21:27:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Doug Brown <doug@schmorgal.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] appletalk: remove ipddp driver
Message-ID: <2023100910-hydrogen-unless-9916@gregkh>
References: <20231009141139.1766345-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141139.1766345-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 04:10:28PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After the cops driver is removed, ipddp is now the only
> CONFIG_DEV_APPLETALK but as far as I can tell, this also has no users
> and can be removed, making appletalk support purely based on ethertalk,
> using ethernet hardware.
> 
> Link: https://lore.kernel.org/netdev/e490dd0c-a65d-4acf-89c6-c06cb48ec880@app.fastmail.com/
> Link: https://lore.kernel.org/netdev/9cac4fbd-9557-b0b8-54fa-93f0290a6fb8@schmorgal.com/
> Cc: Doug Brown <doug@schmorgal.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
