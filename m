Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BEF7BEFE2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379242AbjJJAr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378721AbjJJAr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:47:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4C99;
        Mon,  9 Oct 2023 17:47:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AA1C433C9;
        Tue, 10 Oct 2023 00:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696898846;
        bh=U6LEJYuUeVc0ijopRiWP1lyH7WNEe7pADKgTe1SDe80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zn5tjchbfOIbLTsxVx9nsT5GsC1moZatY656JBJxwH77OnOe+vUCNNTWWB+GteyKZ
         60thf5w+lh/S4firKUBP6mb+qCZq0DMHhRmxTcUr6h6ROVeFyxHbWiw6iHly+YlwQ7
         Dd29A3803LA6/Yxlp3O7Kn2Yx2IZ+RmwSBGssyKvD51T+YjAOy3+n8k/JqyWxuJZl6
         ymGQ+BBRDPMWGe20THjmdKcK2UOYgXUKACG511v3itsK0V0/foyYm7OnpqxXb+fbMB
         0MgEiA6g8o3mpT8ruar9mzBGCru3gPpAHUy6nZs74wpGKMhGGH1NQxpqH816U1mduO
         zIdUZMKkI62gw==
Date:   Mon, 9 Oct 2023 17:47:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/10] appletalk: remove localtalk and ppp support
Message-ID: <20231009174724.1e42b9ad@kernel.org>
In-Reply-To: <20231009141908.1767241-1-arnd@kernel.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
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

On Mon,  9 Oct 2023 16:18:59 +0200 Arnd Bergmann wrote:
> The last localtalk driver is gone now, and ppp support was never fully
> merged, so clean up the appletalk code by removing the obvious dead
> code paths.
> 
> Notably, this removes one of the two callers of the old .ndo_do_ioctl()
> callback that was abused for getting device addresses and is now
> only used in the ieee802154 subsystem, which still uses the same trick.
> 
> The include/uapi/linux/if_ltalk.h header might still be required
> for building userspace programs, but I made sure that debian code
> search and the netatalk upstream have no references it it, so it
> should be fine to remove.

Looks like it depends on the ipddp driver removal.
Could you repost once that one is merged (~tomorrow)?
-- 
pw-bot: cr
