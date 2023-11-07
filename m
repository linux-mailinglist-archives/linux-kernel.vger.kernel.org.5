Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F37E3573
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjKGHDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjKGHDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:03:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2655C126
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:03:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14915C433C7;
        Tue,  7 Nov 2023 07:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699340579;
        bh=JDRGlM9lrsHUhV43a6D7wVaw0GwPSvbuJMm3TbmECDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0kjZWwChfUkzXoNI3F0xNtc+Hxuv7g98mWrYubOvkUH6fWwAeBIJcpNktzR7Aakl9
         dUPzVJkP4xdUYhFSJ6ybb/rFX5zqT9/V/nQW5HkOzauL3MsfDkY3YmL3Pj9INU33Us
         e1EtFqahjL0WXs5LHsi8XuoiBtMtfqc7TBImUTMQ=
Date:   Tue, 7 Nov 2023 08:02:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 0/3] Revert "usb: phy: add usb phy notify port status API"
Message-ID: <2023110713-morphine-mortuary-337e@gregkh>
References: <20231106110654.31090-1-johan+linaro@kernel.org>
 <2023110623-pointing-stump-643d@gregkh>
 <ZUjM/VEliT5c8H4C@matsya>
 <28e77cbc531248bf913ceedba6425cf6@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28e77cbc531248bf913ceedba6425cf6@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:44:26AM +0000, Stanley Chang[昌育德] wrote:
> Hi Johan and Vinod,
> 
> I modified the Realtek phy to solve this issue and only use the generic PHY.
> And submitted these patches today as follows
> https://lore.kernel.org/linux-usb/20231107063518.27824-1-stanley_chang@realtek.com/
> https://lore.kernel.org/linux-usb/20231107063518.27824-2-stanley_chang@realtek.com/
> https://lore.kernel.org/linux-usb/20231107063518.27824-3-stanley_chang@realtek.com/
> https://lore.kernel.org/linux-usb/20231107063518.27824-4-stanley_chang@realtek.com/
> 
> I don't think this patch is needed to revert a08799cf17c2 ("usb:phy: New usb phy notification port status API").

I had already applied those reverts yesterday, but forgot to push them
out (sorry about that, now fixed.)  Let's start over here and you can
rebase your new series on the 6.7-rc1.

thanks,

greg k-h
