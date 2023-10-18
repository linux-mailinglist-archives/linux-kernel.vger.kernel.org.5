Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EE77CD137
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjJRAWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJRAWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:22:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD36A4;
        Tue, 17 Oct 2023 17:22:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E1CC433C8;
        Wed, 18 Oct 2023 00:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697588524;
        bh=yvDrPqrXntymzsv0rV2G8oAfgBeUR+LCbtYO+Qqupro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZErzBCjBWkKqnZ2uoBXRSMcxqK0E5vIC8VwutpgZZ5CnxzSAKPfNI4A4A0m4AIdq2
         LLaGLvPPVWEgPFE5AKOnQrEb0LPy30+HpbIvfeMCLZ3ZcjrpygBGB2onYesMHCH/xk
         bCKixTeOsz0TXYtUYsd1JlvwHjl/6dZLPS5jagXjFY2hjdoZSGhCXo0qYpLbfz0ERJ
         VhX1oLBYcte70RovBCZ4kydaadCcUfGRpAXLd6Cninv4DirciN4uL5WBqB1ZuKDDG0
         Oecge2AQLahA1HUwHxKOqzAzxoGtzIi+E2uyhEOyzwFbWGzctTgqucrcCPrW+n/KBh
         jBmyKu4q0Wpbw==
Date:   Tue, 17 Oct 2023 17:22:02 -0700
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
        Rodolfo Zitellini <rwz@xhero.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 01/10] appletalk: make localtalk and ppp support
 conditional
Message-ID: <20231017172202.71c8dcf9@kernel.org>
In-Reply-To: <20231011140225.253106-1-arnd@kernel.org>
References: <20231011140225.253106-1-arnd@kernel.org>
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

On Wed, 11 Oct 2023 16:02:16 +0200 Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The last localtalk driver is gone now, and ppp support was never fully
> merged, but the code to support them for phase1 networking still calls
> the deprecated .ndo_do_ioctl() helper.
> 
> In order to better isolate the localtalk and ppp portions of appletalk,
> guard all of the corresponding code with CONFIG_DEV_APPLETALK checks,
> including a preprocessor conditional that guards the internal ioctl calls.
> 
> This is currently all dead code and will now be left out of the
> module since this Kconfig symbol is always undefined, but there are
> plans to add a new driver for localtalk again in the future. When
> that happens, the logic can be cleaned up to work properly without
> the need for the ioctl.

Hi Arnd, the WiFi changes are now in net, could you rebase & repost?
