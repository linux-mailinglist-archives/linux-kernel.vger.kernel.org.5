Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AE77BE4AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376938AbjJIPYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376771AbjJIPYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:24:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C002B6;
        Mon,  9 Oct 2023 08:24:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638CEC433C8;
        Mon,  9 Oct 2023 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696865054;
        bh=Kaj3Z1tW1udqMMePJvXDVKy+9Nhy223eBQjA1Yw3D5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxoGdX7zxlhxGhhl4Ah1dOAeE6EEl6CLB1lqKjtaOEU3JWTvuk9WNEfZLCVV2gZUv
         kWMswm4XyKMW4cVei9WtelWjjj5Rg72d/IBLSizDicH2x2QSVrYL9AguKfTBmL7oDG
         uWZmUpbPo6ICEE2NutNLqzGIFhjeJsxQSE8qvosM=
Date:   Mon, 9 Oct 2023 17:24:11 +0200
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
Subject: Re: [PATCH 05/10] staging: rtl8192: remove unused legacy ioctl
 handlers
Message-ID: <2023100900-plunging-pajamas-2d7a@gregkh>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <20231009141908.1767241-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141908.1767241-5-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 04:19:03PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The .ndo_do_ioctl functions are never called, and can just be removed,
> especially since this is a staging driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/rtl8192u/ieee80211/dot11d.c   |  41 --
>  drivers/staging/rtl8192u/ieee80211/dot11d.h   |   2 -
>  .../staging/rtl8192u/ieee80211/ieee80211.h    |  12 -
>  .../rtl8192u/ieee80211/ieee80211_softmac.c    | 563 ------------------
>  drivers/staging/rtl8192u/r8192U.h             |   2 -
>  drivers/staging/rtl8192u/r8192U_core.c        | 109 ----
>  6 files changed, 729 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
