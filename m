Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6427A1B44
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjIOJxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjIOJxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:53:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E82727;
        Fri, 15 Sep 2023 02:51:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF018C433C8;
        Fri, 15 Sep 2023 09:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694771517;
        bh=HzrhYbMbX0nF6Txa78jKopQDXazvQhqkMOm3sDgFktM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBLp35uVAIAxNF1SYKjADENGMkUkn5QlTgZaep6pr76zQl4XUIhLgg6ihK9NuytGg
         o18NLvmIAa+WeK5RL7n66x4TUwxorUbyU4qTLZf1O0oAwEvdjQ8k/zfWtib8ajOB4W
         sQoEINJYOdo8PAs43ElcmPXF6jLlApsczCelFtu4=
Date:   Fri, 15 Sep 2023 11:51:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Enlin Mu <enlin.mu@outlook.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, enlin.mu@unisoc.com,
        enlinmu@gmail.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: add cpu id information to printk() output
Message-ID: <2023091552-sanitizer-vertigo-8a75@gregkh>
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:40:34PM +0800, Enlin Mu wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> Sometimes we want to print cpu id of printk() messages to consoles

This is rejected every few years.  What has changes from the previous
times this was sent?

And why can't you use trace_printk()?

thanks,

greg k-h
