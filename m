Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193BF7FB3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbjK1INH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjK1INF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:13:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70846C1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:07:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC038C433C7;
        Tue, 28 Nov 2023 08:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701158860;
        bh=0t+O+30Xv5t/NqO26Aolg8thAtJ3OrzSz6sxE+kDq18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wZg5YV72F+D/Yaov5ZJtMMfrCI70bcfZPYtVG97UzrnZqGNDp5215cHjUEsns6TfA
         wMFUIMh5+jZs87WA8JtzUItRNXkkAY9HaVB0jMgK/0s+35aFzkfUfK4jFeyAfmMwH9
         P4vmeKXZpOSljde8EvefzsR4IzXBlEwRlKwCVjs8=
Date:   Tue, 28 Nov 2023 08:07:37 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     RD Babiera <rdbabiera@google.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, badhri@google.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: class: fix typec_altmode_put_partner to
 put plugs
Message-ID: <2023112847-verdict-percent-71b3@gregkh>
References: <20231127210951.730114-2-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127210951.730114-2-rdbabiera@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 09:09:52PM +0000, RD Babiera wrote:
> When typec_altmode_put_partner is called by a plug altmode upon release,
> the port altmode the plug belongs to will not remove its reference to the
> plug. The check to see if the altmode being released evaluates against the
> released altmode's partner instead of the calling altmode itself, so change
> adev in typec_altmode_put_partner to properly refer to the altmode being
> released.
> 
> typec_altmode_set_partner is not run for port altmodes, so also add a check
> in typec_altmode_release to prevent typec_altmode_put_partner() calls on
> port altmode release.
> 
> ---
> Changes since v1:
> * Changed commit message for clarity
> * Added check to typec_altmode_release to only call put_partner if altmode
> belongs to port partner or plug
> ---

This info all goes below the following lines:

> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---

Down here, otherwise if you try to apply this patch, your signed-off-by
lines are removed from the patch, right?

As-is, this can not be applied at all :(

Please fix up, thanks.

greg k-h
