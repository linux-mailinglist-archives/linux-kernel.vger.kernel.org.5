Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2063B770096
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjHDM4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHDM4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC45911B;
        Fri,  4 Aug 2023 05:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F31661FD8;
        Fri,  4 Aug 2023 12:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C06C433C7;
        Fri,  4 Aug 2023 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691153764;
        bh=j3jcM+LWqYTMODOTNKbVb3vbQMoAG124I/nb/tZvH54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/PiuOB0jcKI7AyImonno3okOsB5G997VLZVhDeQt/F+YtBlYduUe13oBBlWXjHFe
         bzQRepPPWEUqXLu+6m/01TLcYtg9vhqhZGhZJwfDvKr3CpuNzKhSckEyn2n+pByNRK
         2c6iSRnDp5w0SlRZeWsJ23sBu+BGRTxxFvI5WzpM=
Date:   Fri, 4 Aug 2023 14:56:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     RD Babiera <rdbabiera@google.com>
Cc:     heikki.krogerus@linux.intel.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: altmodes/displayport: Signal hpd when
 configuring pin assignment
Message-ID: <2023080408-splotchy-numerous-463d@gregkh>
References: <20230726020903.1409072-1-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726020903.1409072-1-rdbabiera@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 02:09:02AM +0000, RD Babiera wrote:
> When connecting to some DisplayPort partners, the initial status update
> after entering DisplayPort Alt Mode notifies that the DFP_D/UFP_D is not in
> the connected state. This leads to sending a configure message that keeps
> the device in USB mode. The port partner then sets DFP_D/UFP_D to the
> connected state and HPD to high in the same Attention message. Currently,
> the HPD signal is dropped in order to handle configuration.
> 
> This patch saves changes to the HPD signal when the device chooses to
> configure during dp_altmode_status_update, and invokes sysfs_notify if
> necessary for HPD after configuring.
> 
> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
>  drivers/usb/typec/altmodes/displayport.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Meta-comment, please fix your email client up.  The "To:" line was
incorrect, and when applying this patch I get the following:

---
  ✗ [PATCH v1] usb: typec: altmodes/displayport: Signal hpd when configuring pin assignment
    + Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com> (✓ DKIM/intel.com)
  ---
  ✗ BADSIG: DKIM/google.com

So, is this a fake google.com address?

I'll take this this time, but please fix your system up going forward.

thanks,

greg k-h
