Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D427A7775
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjITJ2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjITJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:27:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469018B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:27:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D03C433C7;
        Wed, 20 Sep 2023 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695202035;
        bh=184LulnXChUk8vYVE1Xgq+y+IncgcGuIQLYNhg9Uo4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuMwjWb9UoczeKt9iQdhK2HJwX2Ifa9zCGatw1QkfkZq18FppfyK8VEwe8uUpJxh3
         LOFT4lmWvNL5f3rrAKZyAnQ7T0w2hRMKoXrFQqII82u+KiuaZL1C8KQ4LQA7EW4/t4
         d6Niqp5L7ecCBNGEi9kzw9Rqsi1ESrPeCYRXQLiM=
Date:   Wed, 20 Sep 2023 11:27:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     peter.chen@kernel.org, pawell@cadence.com, pavel@denx.de,
        rogerq@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdns3: Modify the return value of
 cdns_set_active () to void when CONFIG_PM_SLEEP is disabled
Message-ID: <2023092039-helping-unselect-adb9@gregkh>
References: <20230920082856.1782284-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920082856.1782284-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 04:28:56PM +0800, Xiaolei Wang wrote:
> The return type of cdns_set_active () is inconsistent
> depending on whether CONFIG_PM_SLEEP is enabled, so the
> return value is modified to void type.
> 
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://lore.kernel.org/all/ZP7lIKUzD68XA91j@duo.ucw.cz/
> Fixes: 2319b9c87fe2 ("usb: cdns3: Put the cdns set active part outside the spin lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> 
> v2:
>  * Add Cc: stable@vger.kernel.org

The changes here need to go below the --- line as the documentation
asks.  Putting it here will just break things :(

v3 please?

thanks,

greg k-h
