Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D383A7FE57E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjK3BCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjK3BCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:02:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952CBD54
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:02:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F4EC433C7;
        Thu, 30 Nov 2023 01:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701306175;
        bh=6+gsd8x5pNDWNvTZPM/3wdWzz6chOW+kGf/ppspNWtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pck4JEhBPBYMB0v7we0k9h7jpGlwkqo8rLE9PRdPhV5r31CCzBd8rFisVQ04iykh2
         kcpw6kSv7oiDMTl4Sb7/J3jzMyNZpIA4FRUAOA7FmmJPyKVB83gjSm9OfbgqmfmSPT
         ZTqUzBCjLt4RTVQISILCyLdgWsTe1SvEJ86waQ+g=
Date:   Wed, 29 Nov 2023 17:02:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: No care given to GDB scripts..
Message-Id: <20231129170254.e7ca4c866b521c291e88395e@linux-foundation.org>
In-Reply-To: <25a5e810-1e57-4a59-ae82-cb2c7d28a116@gmail.com>
References: <cfc3aa17-0f1b-4ffc-b848-33baa51b1196@gmail.com>
        <20231129150629.0a82efbfc1494972e4e4f8cb@linux-foundation.org>
        <25a5e810-1e57-4a59-ae82-cb2c7d28a116@gmail.com>
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

On Wed, 29 Nov 2023 16:23:55 -0800 Florian Fainelli <f.fainelli@gmail.com> wrote:

> > Is there any way of scripting the scripts so we can have some sort of
> > automated testing down under tools/testing/selftests/?
> 
> That might be a bit difficult to do as this would mean that we can self 
> debug and introspect using gdb the live kernel. Testing using QEMU is 
> definitively doable however. Of course, I just found another script that 
> broke (device.py)!

Oh.  That sounds quite the exercise in the context of tools/selftests.

One can of course just fire up gdb against the vmlinux elf file and
play around, but I assume this won't permit a useful amount of the
scripts to be exercised.

Suppose someone has set up qemu or whatever and has attached gdb to it.
Could we provide that person with a script or a canned set of commands
which exercise the gdb scripts to a useful extent?  So rather than
attempting automated testing under the seltests umbrella, we provide
less skilled individuals with the means to easily and quickly check for
regressions.  I'd expect that such a toolset would be particularly
helpful for regression testing the scripts across all the supported
architectures?

