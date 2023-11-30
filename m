Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84DE7FFDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377011AbjK3Vv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjK3Vv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:51:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858C410FA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:51:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE2BC433C7;
        Thu, 30 Nov 2023 21:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701381094;
        bh=PdtXF5Aamat7jNpaccR39b7qYr8BtOBhEp/0cTIPitw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P6kRRA1WEOGuI1g6/XwC1+CbGuTQmmF7fJT61v382BsHJ8x4QbUiJsl3vC2mqmEb6
         pzrH2NoZVjuPXdEWwdqJXPslpi7AB2ynkHmo2JDoqf+3EC1Jxw/ymOHl3mb+ljLkPn
         0nEEeM0hhCYzWB6oUwNg7WlKhs718AEyo2fLTiNU=
Date:   Thu, 30 Nov 2023 13:51:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, Kuan-Ying.Lee@mediatek.com,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] scripts/gdb: Fix lx-device-list-bus and
 lx-device-list-class
Message-Id: <20231130135133.1031e4b2ca96a288ce2c18d0@linux-foundation.org>
In-Reply-To: <20231130043317.174188-1-florian.fainelli@broadcom.com>
References: <20231130043317.174188-1-florian.fainelli@broadcom.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 20:33:16 -0800 Florian Fainelli <florian.fainelli@broadcom.com> wrote:

> After the conversion to bus_to_subsys() and class_to_subsys(), the gdb
> scripts listing the system buses and classes respectively was broken,
> fix those by returning the subsys_priv pointer and have the various
> caller de-reference either the 'bus' or 'class' structure members
> accordingly.
> 
> Fixes: 83b9148df2c9 ("driver core: bus: bus iterator cleanups")
> Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")

I don't know how -stable maintainers handle more than one Fixes:.  One
of the above was released in 6.3, the other in 6.4.  What are they to
do?

My opinion: developers should use Fixes: as a request to -stable
maintainers to target a particular kernel version (and later).

If the developers indeed want to fix both kernel versions then wouldn't
two patches be best?

