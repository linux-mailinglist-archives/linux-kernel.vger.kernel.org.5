Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE57CB2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjJPSpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjJPSpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:45:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC2895
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:45:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5396FC433C8;
        Mon, 16 Oct 2023 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697481929;
        bh=5MhX2Fy9tH7BfEElMnLHmqrtjZcPf/XVb+qq3sXMBFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2HpJzUZOEd976UzH0Y+Lv9hCK9jkRdSqQWAp5HDlBYC34yBfLOW+RSbK1GTVzvGPM
         UkrldNOkgl9jIX98l295dWU+xdpok6hYPEfSssMCVVMM4p08YkndE2SUdCUVzeOqsf
         +lSihLl1p+hFNgWXC+sij8IKQsYyKBya7A50ruhk=
Date:   Mon, 16 Oct 2023 20:45:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Check valid console index for preferred
 console
Message-ID: <2023101615-unsoiled-splicing-6cf1@gregkh>
References: <20231012064300.50221-1-tony@atomide.com>
 <2023101649-gladly-scarily-329c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101649-gladly-scarily-329c@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:45:00PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 12, 2023 at 09:42:56AM +0300, Tony Lindgren wrote:
> > Let's check for valid console index values for preferred console to avoid
> > bogus console index numbers from kernel command line.
> > 
> > Let's also return an error for negative index numbers for the preferred
> > console. Unlike for device drivers, a negative index is not valid for the
> > preferred console.
> > 
> > Let's also constify idx while at it.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Oops, you want these to go through my tree, I'll take them now...
