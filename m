Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6457C4E59
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbjJKJSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjJKJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:18:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E410894
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:18:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1E85F80E1;
        Wed, 11 Oct 2023 09:18:05 +0000 (UTC)
Date:   Wed, 11 Oct 2023 12:18:03 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Check valid console index for preferred
 console
Message-ID: <20231011091803.GC34982@atomide.com>
References: <20231011074330.14487-1-tony@atomide.com>
 <2023101131-maroon-stubborn-1364@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101131-maroon-stubborn-1364@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [231011 07:53]:
> On Wed, Oct 11, 2023 at 10:43:25AM +0300, Tony Lindgren wrote:
> > Let's check for valid console index values to avoid bogus console index
> > numbers from kernel command line. While struct console uses short for
> > index, and negative index values are used by some device drivers, we do
> > not want to allow negative values for preferred console.
> 
> What drivers use a negative index for the console?

This is based on grepping with $ git grep "co->index =" drivers/tty/

Not sure what all might be stopping making struct console index unsigned.

Regards,

Tony
