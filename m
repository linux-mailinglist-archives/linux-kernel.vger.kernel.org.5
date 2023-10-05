Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6587BA669
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbjJEQdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjJEQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:32:40 -0400
X-Greylist: delayed 1029 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 08:45:50 PDT
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4C44BF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=glxtyoqeaI0kbkfNF4iPI6CTTiHa0BUQ75DXKNcNDsQ=; b=Hj/mQTHPrHOhfnc+0vx/7Gr0wf
        +63HJXuM5mYseQtCsn5h0iTaaQ86SdVtqfdEfgwSffPVJ42DTvUXH3wnCtcTy3GBkv4DXBWiePwPT
        IxIu4FeR1JQz8elkj8OGrt9SkRnabcFxV/iGzmUx1WDefkTLJnagREMxflNG7TMcqYjo=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.96)
        (envelope-from <kilobyte@angband.pl>)
        id 1qoQGt-002gHy-1z;
        Thu, 05 Oct 2023 17:28:15 +0200
Date:   Thu, 5 Oct 2023 17:28:15 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: what to do on no reproducer case? (was Re: Fwd: Uhhuh. NMI
 received for unknown reason 3d/2d/ on CPU xx)
Message-ID: <20231005152815.GA630707@angband.pl>
References: <0e6de51b-da1d-43f0-ffae-fb521febbe07@gmail.com>
 <ZQo8hzP-eRjXvtXf@debian.me>
 <2a298145-b6ec-4b4e-bd45-0cddf62b6052@leemhuis.info>
 <bcf1998e-5efa-4505-a8d2-3381c16de885@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcf1998e-5efa-4505-a8d2-3381c16de885@gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 07:50:29PM +0700, Bagas Sanjaya wrote:
> On 21/09/2023 15:10, Thorsten Leemhuis wrote:
> > Yes, without a reliable bisection result there sometimes is not much we
> > can do -- apart from prodding various developers directly and asking for
> > help or an idea. But in this case that's not worth it afaics, as
> > messages like
> > https://lore.kernel.org/all/e08e33d5-4f6d-91aa-f335-9404d16a983c@amd.com/
> > indicate that it might be a hardware problem and not really a
> > regression. Hence:
> > 
> > #regzbot resolve: inconclusive: not bisected and might be a hardware
> > problem after all

> Thanks for the tip! Now to fix up:
> 
> #regzbot inconclusive: regression not bisected - possibly hardware issue

This doesn't seem to be a regression, I'm seeing this (reason 2c/3c) since
forever (2019) on my box (2990WX), up to current -rc kernels.

Of course, it might be a different problem that results in same message,
but I don't pretend to have a clue about the cause -- just reporting.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Q: Is it ok to combine wired, wifi, and/or bluetooth connections
⢿⡄⠘⠷⠚⠋⠀    in wearable computing?
⠈⠳⣄⠀⠀⠀⠀ A: No, that would be mixed fabric, which Lev19:19 forbids.
