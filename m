Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432D47D9C50
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbjJ0O4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346150AbjJ0O4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:56:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F07FC4;
        Fri, 27 Oct 2023 07:56:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACF2C433CA;
        Fri, 27 Oct 2023 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698418567;
        bh=UkrJJKFDaGsaGInrfBTniS0YOnaygnlE0aUXj/QEbRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMrDw8bm1YGFQK3mnbMefa6IgJLHNfikKQ1/RYoC7mlEoEJDqWLljJQ4xsr7FS0Sh
         QC8WqBLtYtjh0lSBPNitqvrf5ZKYaedkOlVhtBVvkrrLUvhLqJGbaH4dteog8fQNgY
         jpM5oGuVvmjIGhfHlki88Jiy6U4g6HXJR7nz1Wlg=
Date:   Fri, 27 Oct 2023 16:56:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vamshi Gajjela <vamshigajjela@google.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH v4 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
Message-ID: <2023102735-critter-crust-542f@gregkh>
References: <20231027141534.3723781-1-vamshigajjela@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027141534.3723781-1-vamshigajjela@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 07:45:34PM +0530, Vamshi Gajjela wrote:
> The function uart_fifo_timeout() returns an unsigned long value, which
> is the number of jiffies. Therefore, change the variable timeout in the
> function uart_poll_timeout() from int to unsigned long.
> Change the return type of the function uart_poll_timeout() from int to
> unsigned long to be consistent with the type of timeout values.
> 
> Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> ---

Again, I can't do anything with just a 3/3 patch.

Please send whole series of commits.  Again, what would you want to do
if you got 1000+ emails a day to do something with?

thanks,

greg k-h
