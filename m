Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19277D954D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjJ0Keb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjJ0Ke3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:34:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3718A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:34:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7EBC433C7;
        Fri, 27 Oct 2023 10:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698402867;
        bh=Z69Iak1OZ6khdmyqVFeCCZ5rvCZc39XumyIBgPwnBAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCEu82v6BBCEwSrCNS80JvJeUystIGiQ8ix7rtiXLbCusg9qF6O7EcrIybEj8pqT4
         +hfdJ4WQKx4Iw24FnTgBSDPSaDT8WCM8FfRl8Vap0Sl3w31vViR2+wbp7tUUzMWwGv
         HgMkLAiRo8YjNeN2FLJrOmbdnD29dZB+4ndKD9tk=
Date:   Fri, 27 Oct 2023 12:34:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     sebastian.reichel@collabora.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
Subject: Re: [PATCH v3] usb: typec: tcpm: add get max power support
Message-ID: <2023102711-candle-untitled-05a7@gregkh>
References: <20230322093120.8686-1-frank.wang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322093120.8686-1-frank.wang@rock-chips.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 05:31:20PM +0800, Frank Wang wrote:
> Traverse fixed pdos to calculate the maximum power that the charger
> can provide, and it can be get by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
> property.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

What ever happened to this change?  Can you rebase and resubmit it
please?

thanks,

greg k-h
