Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DAC7A43F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbjIRIIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbjIRIIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:08:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C331BE4F;
        Mon, 18 Sep 2023 01:07:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2840C433C8;
        Mon, 18 Sep 2023 08:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695024422;
        bh=uJkf9iGWgr0ZsZQx4mCtdTcCP+ImSmVZVX+N5RQOjtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzIRtDZXPuPp5JDlrgyEEJALcW17PZWcxEx2CbfkTcPEsOTh7fZMyYZjsSo0x82uP
         bW/dFRhiQQyELHc2edGywca89NaNbzeKfQN/xK4n0qMwvpaesSXaLpG3n3YN5QqfYi
         bUVSxoV31Jbcy5N+BkkaOlM1qQfGla9T9EoLnRLM=
Date:   Mon, 18 Sep 2023 10:06:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edward AD <eadavis@sina.com>
Cc:     syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tty: fix memory leak in gsm_activate_mux
Message-ID: <2023091826-spherical-shindig-016b@gregkh>
References: <0000000000009bb78206055feb7c@google.com>
 <20230915112324.941574-1-eadavis@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915112324.941574-1-eadavis@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 07:23:24PM +0800, Edward AD wrote:
> When the call to gsm_register_devices() fails, we need to reclaim the memory
> requested in gsm_dlci_alloc().
> 
> Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
> Reported-and-tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
> Signed-off-by: Edward AD <eadavis@sina.com>
> ---
>  drivers/tty/n_gsm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

This message never made it to lore.kernel.org, so you might need to fix
up your email system so that it doesn't get dropped from there.

Can you do so and resend?

thanks,

greg k-h
