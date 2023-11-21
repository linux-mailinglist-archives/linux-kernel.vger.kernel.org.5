Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC97F3011
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjKUOBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjKUOA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:00:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42574D78
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:00:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7FBC433C8;
        Tue, 21 Nov 2023 14:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700575254;
        bh=w7YdJzRR6ob83BoAwBQ4tXEIudgax1ZMqEvN7E+987o=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=o6tMvTxiVFn3fwv9A5qj+eEDa5j20thIPgZ6pjgAE4G+JpctYA+njsZz/Hgev3W0H
         dJC4YcVZlHPV3tqi+fu/eSo/2z/hrT+0LpIP9vvkLeToP8hvYowjWDqoueO/kc5aTG
         fW9ak8engG5t+kDYZpSrp7s4MBYpTxQFkhXn3RGlSGZpCF1NyjDCrSgxPPHLcvnazk
         32GOpXaMI36X5E9IDiwweBEvPbZTKb4NfUZcII1n6ycFDeGi2B1zHAugOUO9AWvDDp
         4lIm69Gv7cQhAaunIbaMYdCKHGJRsud1mj4c1q41TinQBTZ2ZeLANgK8A11b7Uwk/7
         Pl6GlHzHNAXxQ==
Date:   Tue, 21 Nov 2023 15:00:50 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Input Devices <linux-input@vger.kernel.org>,
        Mavroudis Chatzilazaridis <mavchatz@protonmail.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        LinuxCat <masch77.linuxcat@gmail.com>,
        Marcelo <mmbossoni@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Fwd: Logitech G915 Wireless Keyboard acts weird on 6.6.0
In-Reply-To: <0e10112a-7560-4dd8-8a03-5fdfc838168f@leemhuis.info>
Message-ID: <nycvar.YFH.7.76.2311211458030.29220@cbobk.fhfr.pm>
References: <6929ebbf-f2e0-4cd4-addc-1e33ecf3277f@gmail.com> <ZVyr-of1X4RudpWG@archie.me> <0e10112a-7560-4dd8-8a03-5fdfc838168f@leemhuis.info>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, Linux regression tracking (Thorsten Leemhuis) wrote:

> I guess part of the problem is that Bastien got reassigned and might not
> care about the kernel anymore.
> 
> Another part of it is that Jiri was CCed, but Benjamin was not.
> 
> Ideally of course Mavroudis Chatzilazaridis, the culprit's author would
> look into this, but from a quick search on lore it looks like Mavroudis
> is not a regular kernel contributor and thus might not even know how we
> expect situations like this to be handled.

A comment from Mavroudis just appeared in

	https://bugzilla.kernel.org/show_bug.cgi?id=218172

pointing out that indeed the report descriptor of the device he is working 
on is different than the ones from the reporter.

Until this mess gets figured out, I am now pretty sure revert is the way 
to go for 6.7.

-- 
Jiri Kosina
SUSE Labs

