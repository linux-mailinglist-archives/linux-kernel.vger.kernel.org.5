Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B708761E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjGYQUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjGYQT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:19:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327311A;
        Tue, 25 Jul 2023 09:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A7F76179A;
        Tue, 25 Jul 2023 16:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C647C433C8;
        Tue, 25 Jul 2023 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690301993;
        bh=O0xlvC0v8lQMUfRa0bL717dXjSMBPnduOOvYxmERoaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkQVVV0LrvWEBH2nSBYEfC8MIQB/+Lmy4uFgqUgITvha9L6FktWN2G8r4iEmxae+E
         IRYT8DncnvnTDl5JATWB3V0MKWbLQCoCkTJpDpseps0jEb3OoDHwUyD/S7z5quSoWf
         CsA+A0Ek9RkCAeGIeMDWFZeMXk8x9OIHvQ4nxkOQ=
Date:   Tue, 25 Jul 2023 18:19:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wayne Chang <waynec@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>, WK Tsai <wtsai@nvidia.com>,
        Henry Lin <henryl@nvidia.com>
Subject: Re: [PATCH v2] usb: xhci: tegra: Add shutdown callback for Tegra XUSB
Message-ID: <2023072532-vacancy-headlock-46be@gregkh>
References: <20230718091425.307589-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718091425.307589-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:14:25PM +0800, Haotien Hsu wrote:
> From: Henry Lin <henryl@nvidia.com>
> 
> If memory accesses by the Tegra XUSB controller are translated through
> the SMMU (System MMU), the hardware may continue accessing memory even
> after the SMMU translations have been disabled during the shutdown
> process and this can in turn cause unpredictable crashes.
> Fix this by adding a shutdown implementation that ensures the hardware
> is turned off during system reboot or shutdown.
> 
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> ---
> V1 -> V2: Resend for the typo in the mailing list
> ---
>  drivers/usb/host/xhci-tegra.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

Does not apply against 6.5-rc4 at all :(
