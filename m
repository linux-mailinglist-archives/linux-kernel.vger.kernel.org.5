Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919EF78416D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjHVM75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjHVM74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3ECF2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 045506563C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE980C433C8;
        Tue, 22 Aug 2023 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692709180;
        bh=tw2DZxp2aA6aUUxGY+zi8BEPNPbMSVqXZhNHQnrWVes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d60GkdI++VC7L7uGyXPaOfMngeaTCDY3tLX+bzKIOuRKUfWfY2fb4+FvovZ8Tk8C3
         EHzmCzJgfdV3QJqGcgvwl+L4nRMLzHWutzP3kufjvWyZ5751bOqShD5x+cLIPIB2LR
         xEORS/DXIF5HZDwb3uWXU1FCBz9jAMRLB3jIww5o=
Date:   Tue, 22 Aug 2023 14:59:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: core: Remove unused PORT_* definitions
Message-ID: <2023082210-clasp-guru-0456@gregkh>
References: <20230821083857.1065282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821083857.1065282-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:38:57AM +0300, Andy Shevchenko wrote:
> For the last couple of years Linux kernel got rid of a few architectures
> and many platforms. Hence some PORT_* definitions in the serial_core.h
> become unused and redundant. Remove them for good.
> 
> Removed IDs are checked for users against Debian Code Search engine.
> Hence safe to remove as there are no consumers found (only providers).
> 
> While at it, add a note about 0-13, that are defined in the other file.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: tested via DCS (Greg), dropped 1 change due to that, added a note for 0-13
>  include/uapi/linux/serial_core.h | 43 +++-----------------------------
>  1 file changed, 3 insertions(+), 40 deletions(-)

You forgot to cc linux-serial@vger :)

I'll take this now, thanks for cleaning this up.  Hopefully we can
resist the urge to add new ids here.

greg k-h
