Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8047FE40C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343635AbjK2XK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343640AbjK2XKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:10:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E146D7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:10:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96778C433C7;
        Wed, 29 Nov 2023 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701299430;
        bh=N/H0WI8OOAZg5IsWZvaQQHP/VpfSznz5JRrpi05DQq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YDok8f2518AVgQG+4UbU1jDVslt6EdxIDQcEA9vP/gGtXvaGokTj3clVuawA/cGXw
         4aqQWtzWKem2vtw5Ub1sBn+3QvIq/SfJ6ogTJQYOko4tZoMau1Nb4B9Y/lpe+yocnu
         PEvzSJk+c3KNAvWZP7c0XdWMiPiaqvlDul7kElLw=
Date:   Wed, 29 Nov 2023 15:10:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Stephen Rothwell" <sfr@rothwell.id.au>,
        linux-next <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: linux-next: lots of errors/warnings from the
 -Werror=missing-prototypes addition
Message-Id: <20231129151030.24b807f1d2b43be301a533b7@linux-foundation.org>
In-Reply-To: <ebb5b1a2-ed27-4a77-b62b-1d3f19bddd85@app.fastmail.com>
References: <20231130075838.05e5bc9b@oak>
        <20231129131003.d2c1078847c3865c1ac2dfd5@linux-foundation.org>
        <ebb5b1a2-ed27-4a77-b62b-1d3f19bddd85@app.fastmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 23:51:04 +0100 "Arnd Bergmann" <arnd@arndb.de> wrote:

> I did all my testing with CONFIG_WERROR force-enabled, so
> the bit I missed here is that at least three architectures
> that are missing fixes also set -Werror: mips, sparc and alpha.
> 
> How about adding a patch to no longer force -Werror for
> these?

These architectures are doing it wrong, aren't they?  They should be
using the CONFIG_WERROR infrastructure rather than hard-coding it?  If
so then sure, a standalone patch to clean that up sounds sounds
appropriate.  I guess it should precede "Makefile.extrawarn: turn on
missing-prototypes globally".
