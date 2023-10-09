Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BB17BE4A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376769AbjJIPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376599AbjJIPXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:23:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363629E;
        Mon,  9 Oct 2023 08:23:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55786C433C7;
        Mon,  9 Oct 2023 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696865032;
        bh=ObvrkQNowN6D9lhZvrmX8Q8RKyFQ6TGkfKqLJZbpLMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yVVe3U5s4a6nvK4Cw7WftLl1t96uUaXLOc/CtJwGzyzOdTc80E2y/k9l5Jz+LIiEW
         VhjMe6aZrayIu2SH6tzH06ElK4Kb0Drsou4KmDvvWVqcm2Ndr0IdwS/Q2zp8AkBtZF
         RIhXV2nZBV3vlDdAqPF1I4SyysK5jr9pF/3eQ1+0=
Date:   Mon, 9 Oct 2023 17:23:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/10] staging: rtl8723bs: remove dead code
Message-ID: <2023100941-luminous-hula-7551@gregkh>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <20231009141908.1767241-7-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141908.1767241-7-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 04:19:05PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The .ndo_do_ioctl functions are never called, so the three implementation here
> is useless but only works as a way to identify the device in the notifiers,
> which can really be removed as well.
> 
> Looking through the exported functions, I found a bunch more that have
> no callers, so just drop all of those.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
