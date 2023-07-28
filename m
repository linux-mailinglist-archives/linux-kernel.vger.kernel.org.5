Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AD7767061
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbjG1PUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjG1PUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:20:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F23580;
        Fri, 28 Jul 2023 08:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 053F46216C;
        Fri, 28 Jul 2023 15:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BA1C433C8;
        Fri, 28 Jul 2023 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690557635;
        bh=85EdRWkikIMBuWzYz9zr0M6a4S8P+N877KIBHuPUOUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1tMNpGBX2sPXA35jIqt9P33/wYYRwL9CSFkMYtpB429n7aQm0vzxFG8xgdFlbPab
         nF6iWivm/qICWwmdXDcQZplnyskRujkHCHgB4gn6NpuD6M4nxUtmxpi1aHR/orXuFu
         njINj4C+UF3NTeRD0QYFtLzkYLW+24469dyLqjzRX0ZTM/LvXX0sCYRZgsnNE722mU
         EhVS5jhu5SukMj2/ebDChR7S/7rB6i7iFT7fpT/sMc0ZdqQFC2oaCG+LIxywdg5s98
         x8TFcIhSLPkaGFYmvVNPbHz/nSXwGzWtJ2sxBk40fD/dqjdyr6zjV00VWLX4D056gL
         8CCDMUreBBTsw==
Date:   Fri, 28 Jul 2023 16:20:30 +0100
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Purdie <rpurdie@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] led: trig: timer: stop offloading on deactivation
Message-ID: <20230728152030.GM8175@google.com>
References: <728da6e11d34a39f717be07e246dcc4964b0fd51.1690542871.git.daniel@makrotopia.org>
 <ZMO70XCBY3dqpdAY@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMO70XCBY3dqpdAY@duo.ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023, Pavel Machek wrote:

> On Fri 2023-07-28 13:30:58, Daniel Golle wrote:
> > Stop hardware blinking when switching from 'timer' to another trigger.
> > 
> > Fixes: 5ada28bf7675 ("led-class: always implement blinking")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> ACK.

Could I have that in full please, such that b4 can pick it up?

-- 
Lee Jones [李琼斯]
