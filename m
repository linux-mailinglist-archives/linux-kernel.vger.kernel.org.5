Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512167F52F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjKVWHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjKVWHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:07:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86518B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:07:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA48BC433C7;
        Wed, 22 Nov 2023 22:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700690837;
        bh=879KXznwiWs4VGcvpRH7TOoxpdcEDnzryeA43aJHal4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kaT6RmOHm1SuksgdO9VhP1QwTnHKvyx8n67Cii1r36lgGYVlDcNxr7FYHE35gVehs
         xfyobqvZnZlB30qpmihQfFmaGsdPzR6aKL5xVXJGEkB9y3NbQP2QqSHceBd/DIk09b
         ZrtrBxmS9TGT0BDxUb0y1nFPPuErhcScijaWpyvo=
Date:   Wed, 22 Nov 2023 22:07:15 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roy Luo <royluo@google.com>
Cc:     stern@rowland.harvard.edu, badhri@google.com,
        quic_kriskura@quicinc.com, francesco.dolcini@toradex.com,
        quic_eserrao@quicinc.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] USB: gadget: core: adjust uevent timing on gadget
 unbind
Message-ID: <2023112253-fresh-blazing-baae@gregkh>
References: <20231122220001.539770-1-royluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122220001.539770-1-royluo@google.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:00:01PM +0000, Roy Luo wrote:
> The KOBJ_CHANGE uevent is sent before gadget unbind is actually
> executed, resulting in inaccurate uevent emitted at incorrect timing
> (the uevent would have USB_UDC_DRIVER variable set while it would
> soon be removed).
> Move the KOBJ_CHANGE uevent to the end of the unbind function so that
> uevent is sent only after the change has been made.
> 
> Signed-off-by: Roy Luo <royluo@google.com>
> ---
>  drivers/usb/gadget/udc/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

What commit does this fix?


