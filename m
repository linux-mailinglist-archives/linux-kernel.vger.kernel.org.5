Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05BF75687A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGQP6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGQP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:58:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F8CD8;
        Mon, 17 Jul 2023 08:58:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C1960F12;
        Mon, 17 Jul 2023 15:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51822C433C9;
        Mon, 17 Jul 2023 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689609518;
        bh=oxc0wIrykUcV4lXikRU9sbRAnt1ysqKy15IEX0mqF/Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UbNh4IekhjGWhrn4gvGQf61ZiY2gkxSLo98gAjJ8w8sUTRcyESEZx9fCfW2mEmhCX
         xb4x3PcxoUlV9iCYsVm/iCyndzYMMx6YSBgKISeXi+Yt64qwvIJGBGto4Ia+5NXAc1
         +T7DbHWA3ndowqUH0jq5xFTg+6P3HgCLsTELsB/37XY4SQT5JZ8wNubjT6bXYxzqxo
         CG+24S8iRFy7Hw3TZ3dnIsGdsOnu4/FpK4JPmtTzchaD19cPMZO0y14lD7nxI2g3ZA
         hN2tRFYVGNMY1v8YiQ2CuEMrO5We3Pnf2nCTgcaD9Go5+PtRGIKuUzLMtOemRVR0VD
         KKdg6Hua/kt+Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb-fixes tree
References: <20230714083645.4e587f71@canb.auug.org.au>
        <ZLTsXUFZy4Iggk5u@kekkonen.localdomain>
Date:   Mon, 17 Jul 2023 18:58:28 +0300
In-Reply-To: <ZLTsXUFZy4Iggk5u@kekkonen.localdomain> (Sakari Ailus's message
        of "Mon, 17 Jul 2023 07:23:09 +0000")
Message-ID: <87jzuy34yj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sakari Ailus <sakari.ailus@linux.intel.com> writes:

> On Fri, Jul 14, 2023 at 08:38:25AM +1000, Stephen Rothwell wrote:
>> Hi all,
>> 
>> In commit
>> 
>>   b0b43354c345 ("media: tc358746: Address compiler warnings")
>> 
>> Fixes tag
>> 
>>   Fixes: 80a21da3605 ("media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver")
>> 
>> has these problem(s):
>> 
>>   - SHA1 should be at least 12 digits long
>>     This can be fixed for the future by setting core.abbrev to 12 (or
>>     more) or (for git v2.11 or later) just making sure it is not set
>>     (or set to "auto").
>> 
>> Also, please keep all the commit message tags together at the end of
>> the commit message.
>
> Apologies for this, I guess I've removed one character too many from the
> hash.
>
> I'll switch to a script (or alias) to do this. It'd be, though, helpful if
> git could do this on its own.

Are you asking for git to create the Fixes tag? The documentation has
has a tip using --pretty=fixes which is quite handy:

https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
