Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13067CC46C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbjJQNSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjJQNSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:18:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D03C10EF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:17:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A635C433C8;
        Tue, 17 Oct 2023 13:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697548643;
        bh=4nxP30gbvbNfQrY208MgnErY+n4i02uV5NqlW9QbLzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBuaUInP4tgE2HpRyQ1jcrpnrSEvHJo+OYTaWY8jEOzCA3pIFUmlpBBCqdnZIiNVG
         PuQqn5WvPSP51VNsRyrto64K9+offURwZ9At3X0w+urQ4G74qaxxUtxnIdVAjio9G5
         +5OsTi9s1qaxMLnuU4puNkRabM5RBBgcR847JEe8=
Date:   Tue, 17 Oct 2023 15:17:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charles <be286@163.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]         usb: gadget: f_uac1: add adaptive sync support
 for capture
Message-ID: <2023101743-repaint-krypton-ba0c@gregkh>
References: <20231017083918.1149647-1-be286@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017083918.1149647-1-be286@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 04:39:18PM +0800, Charles wrote:
>         UAC1 has it's own freerunning clock and can update Host about
>         real clock frequency through feedback endpoint so Host
>         can align number of samples sent to the UAC1 to
>         prevent overruns/underruns.
> 
>         Change UAC1 driver to make it configurable through
>         additional 'c_sync' configfs file.
> 
>         Default remains 'asynchronous' with possibility to
>         switch it to 'adaptive'.
> 
>         Signed-off-by: Charles <be286@163.com>

Why the odd indentation?

And why not use your full name?

Please fix up and send a v2.

thanks,

greg k-h
