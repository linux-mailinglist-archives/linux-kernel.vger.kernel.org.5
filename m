Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0B17D1C96
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjJUKvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUKvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:51:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206F4D52;
        Sat, 21 Oct 2023 03:51:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EF6C433C8;
        Sat, 21 Oct 2023 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697885506;
        bh=Fg640wx54tMtPfiRC5yJ/+rN6QS6OgMeInT9QaJ00Yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NstxjAaMCut5TlWkZz6vZf157SUSRwZdMITRlxTCW6xOBEDh/b1zJNZ8q2l1mA5bx
         ZNo29MQWDA4TLNisNVw4ntgAH7vmEe+ivfEmBWZfKdN3LVgPFsWWzPXTjEpcGc1f6S
         TAV/ks3WtjPVqnXtfpTniZjRnjkKDtAS8+hyK+/8=
Date:   Sat, 21 Oct 2023 12:51:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     RD Babiera <rdbabiera@google.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, badhri@google.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: altmodes/displayport: verify compatible
 source/sink role combination
Message-ID: <2023102114-vanilla-feisty-14b7@gregkh>
References: <20231018203408.202845-2-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018203408.202845-2-rdbabiera@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 08:34:09PM +0000, RD Babiera wrote:
> DisplayPort Alt Mode CTS test 10.3.8 states that both sides of the
> connection shall be compatible with one another such that the connection
> is not Source to Source or Sink to Sink.
> 
> The DisplayPort driver currently checks for a compatible pin configuration
> that resolves into a source and sink combination. The CTS test is designed
> to send a Discover Modes message that has a compatible pin configuration
> but advertises the same port capability as the device; the current check
> fails this.
> 
> Verify that the port and port partner resolve into a valid source and sink
> combination before checking for a compatible pin configuration.
> 
> ---
> Changes since v1:
> * Fixed styling errors
> * Added DP_CAP_IS_UFP_D and DP_CAP_IS_DFP_D as macros to typec_dp.h
> ---

Git stops the changelog at the first "---", so everything below:

> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Is dropped, which is not what you want (did you try applying this
yourself?)

As the documentation describes, please put the change information that
you have here below this line:

> ---

So that it will not show up in the changelog.

Please fix up, add the reviews that you got, and submit a v3, as I can't
take this one as-is :(

thanks,

greg k-h
