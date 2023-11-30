Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB057FF4AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbjK3QUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjK3QUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:20:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56222700
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:19:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC8CC433C9;
        Thu, 30 Nov 2023 16:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701361170;
        bh=mDtzF7NAf/4/gCyKEm5oMxB9JWjUMGxC0nVhCgSfJiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lbLLL9vY1iZm73oW0pLb5e2DTUMZwAVzUyefidj4FWo5C5BEKe0QdpDdbG48LcpVR
         RGVEOqcSIEiYSLWUJi7eFZbo6zoyYvnMhIuFWrq6+IMh/0b03TTVWdV3YsMdEFRc2Q
         BJBvgqW0vCh7Bamjd5FtC0tZZY4LTFNienKCGV/8=
Date:   Thu, 30 Nov 2023 08:19:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Stephen Rothwell" <sfr@rothwell.id.au>,
        linux-next <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: linux-next: lots of errors/warnings from the
 -Werror=missing-prototypes addition
Message-Id: <20231130081929.46a79c33edee8651c63112dc@linux-foundation.org>
In-Reply-To: <4be73872-c1f5-4c31-8201-712c19290a22@app.fastmail.com>
References: <20231130075838.05e5bc9b@oak>
        <20231129131003.d2c1078847c3865c1ac2dfd5@linux-foundation.org>
        <ebb5b1a2-ed27-4a77-b62b-1d3f19bddd85@app.fastmail.com>
        <20231129151030.24b807f1d2b43be301a533b7@linux-foundation.org>
        <4be73872-c1f5-4c31-8201-712c19290a22@app.fastmail.com>
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

On Thu, 30 Nov 2023 09:07:38 +0100 "Arnd Bergmann" <arnd@arndb.de> wrote:

> > I guess it should precede "Makefile.extrawarn: turn on
> > missing-prototypes globally".
> 
> I already have a collection of patches to fix up known
> -Wmissing-prototype warnings across architectures in the
> asm-generic tree, so I'll add this patch there:
> 
> commit bdef96eb0b89dfa80992312a8e3b2613bf178ae5
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Thu Nov 30 00:07:07 2023 +0100
> 
>     arch: turn off -Werror for architectures with known warnings

I think this would be better in the mm-nonmm tree, alongside
"Makefile.extrawarn: turn on missing-prototypes globally".  Can I steal it?
