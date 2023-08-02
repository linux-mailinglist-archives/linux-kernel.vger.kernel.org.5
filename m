Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387D76C993
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjHBJjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjHBJjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E909DE4D;
        Wed,  2 Aug 2023 02:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86B39618AC;
        Wed,  2 Aug 2023 09:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD1EC433C9;
        Wed,  2 Aug 2023 09:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690969143;
        bh=usG9b09TPI2Nm0uCNY/vSjiTKmjnQWhtZ5dO4cYwwig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XwJ62TxKvGgJhMGEgM2pZLcgxplb3ZeWc6W5W29lGpkjpj5Gge5VoVJLOEjCljVhv
         u3DtGOHBY1IhzmNMXdlMoV+tQ5JMkCEzfOT0emeXPuaIzQjr+4uG2exxAgJS7Z0SpY
         3QnxmY6FaJfRAcnFAq0sFlE+xV9AXt5TguaS91V8=
Date:   Wed, 2 Aug 2023 11:39:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] usb: xhci-plat: fix usb disconnect issue after s4
Message-ID: <2023080243-matted-abnormal-0fb0@gregkh>
References: <20230802090642.1642-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802090642.1642-1-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:06:42PM +0800, Yinbo Zhu wrote:
> The xhci retaining bogus hardware states cause usb disconnect devices
> connected before hibernation(s4) and refer to the commit '547d55fa83
> ("usb: ohci-platform: fix usb disconnect issue after s4")' which set
> flag "hibernated" as true when resume-from-hibernation and that the
> drivers will reset the hardware to get rid of any existing state and
> make sure resume from hibernation re-enumerates everything for xhci.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  drivers/usb/host/xhci-plat.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

What commit id does this fix?

Should it go to stable kernels?

thanks,

greg k-h
