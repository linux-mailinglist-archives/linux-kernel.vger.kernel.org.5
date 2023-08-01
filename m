Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8536D76A8CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjHAGOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHAGOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5612A;
        Mon, 31 Jul 2023 23:14:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0769C61470;
        Tue,  1 Aug 2023 06:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118DCC433C8;
        Tue,  1 Aug 2023 06:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690870484;
        bh=higrHVSWznLUFGb/TRuJBmwWbMFNkkcos/Ir86LqGTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEHAVdGETHIsEgIxJO6WHbwUqCeUWI7PTF3sqWTbxRFJpHXOVwodwFYAZ0V11J8UU
         fgjzYMG+tOj48pThpkZz4J8NZeE0urt9ml1xWwh5nu2QPh0pnNhVBh9jdt0SS3c1Nq
         uwzenTZN+gUpnHUUQT3ry/3uRItbgy6MjubEw1Os=
Date:   Tue, 1 Aug 2023 08:14:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] usb: common: usb-conn-gpio: Prevent bailing out if initial
 role is none
Message-ID: <2023080127-remake-wrought-5b07@gregkh>
References: <1690869695-32018-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690869695-32018-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 11:31:35AM +0530, Prashanth K wrote:
> Currently if we bootup a device without cable connected, then
> usb-conn-gpio won't call set_role() since last_role is same as
> current role. This happens because during probe last_role gets
> initialised to zero.
> 
> To avoid this, add a new flag initial_detection in the struct
> usb_conn_info, which prevents from bailing out during initial
> detection.
> 
> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
> v2: Updated the bool name to initial_detection.
> 
>  drivers/usb/common/usb-conn-gpio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documetnation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
