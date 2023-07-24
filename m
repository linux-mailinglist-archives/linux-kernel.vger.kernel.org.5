Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9B75FC06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjGXQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjGXQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F771B0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 039E861261
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CB9C433C8;
        Mon, 24 Jul 2023 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690216017;
        bh=d7DmTXzRTVmIFN5K5gqsKRTU+7eTWOeYBkhb0UMLBaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hJgTUzB0NTTJxbx/yfsAh3TTjuxFQT0a3L5h4+wJ9LSWSpxHAvWeW7eDpy/gtl9XM
         sdlT5JUlyJb7+oQb/GRnUhDIYY9dS4KBgP8q/DFQkDgu8HD8PPDj9wxLdOzKHdv4/Q
         r87cMTmQ5izWiINGEcmfvh+PwNS2gJ+m40JPrKw4=
Date:   Mon, 24 Jul 2023 09:26:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Herve Codina <herve.codina@bootlin.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yang Guang <yang.guang5@zte.com.cn>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/1] Revert "um: Use swap() to make code cleaner"
Message-Id: <20230724092655.1982074ea5c6cf484c79317a@linux-foundation.org>
In-Reply-To: <20230724143131.30090-1-andriy.shevchenko@linux.intel.com>
References: <20230724143131.30090-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 17:31:31 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This reverts commit 9b0da3f22307af693be80f5d3a89dc4c7f360a85.
> 
> The sigio.c is clearly user space code which is handled by
> arch/um/scripts/Makefile.rules (see USER_OBJS rule).
> 
> The above mentioned commit simply broke this agreement,
> we may not use Linux kernel internal headers in them without
> thorough thinking.
> 
> Hence, revert the wrong commit.

As it fixes a build error I'll add cc:stable to this.
