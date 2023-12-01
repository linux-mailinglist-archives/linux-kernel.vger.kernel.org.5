Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED12800AD0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378826AbjLAMZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378794AbjLAMZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:25:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AACEB0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:25:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679FCC433C7;
        Fri,  1 Dec 2023 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701433517;
        bh=ES0vSzbXawoJi7+xDKqmRn0m8Bd/4wkZeh9lptII0rI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ISsyYkkm0HG/zzAPwmMSoNMkI650Z0VLtwnR78mPiEJ7zOWBmllt833kbrdSCyEGY
         IgEV/ZOLGVOH4npFuRZbziLUEzHfY0qJR02ujNfG/PcgW5O804fig6FJ6ARrehUj8C
         oGnXaEkbZQnXhnw1GJFPPNxK9Apg6AGHPZjbADJLjbrf9hq1UWcCYlnauEQ5m4Xlgm
         q5iGormijJExTnIO93XV5Bz0XnFtjP28JJmyLx8CBzFRWyTuzThd/qNGbhehiWLhVn
         ZiCfa9I52Y+plP63q+zkCihiinWvwJ9etr87H+D+DV4+NzksJ8T02/bvbUkzQRdc1U
         URS79cPSn3z1A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, briannorris@chromium.org,
        tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v7 00/12] wifi: mwifiex: added code to support host mlme.
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
        <ZWnIMGytEdDCySS8@francesco-nb.int.toradex.com>
Date:   Fri, 01 Dec 2023 14:25:14 +0200
In-Reply-To: <ZWnIMGytEdDCySS8@francesco-nb.int.toradex.com> (Francesco
        Dolcini's message of "Fri, 1 Dec 2023 12:49:04 +0100")
Message-ID: <878r6ertxx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Francesco Dolcini <francesco@dolcini.it> writes:

> Hello Lin,
> thanks for the patches here, I can clearly see that this code is going
> through some real testing given the improvements you did lately.
>
> I have commented on the single patches, and honestly I did not look into
> the code details at the moment.
>
> The major feedback from me is the following:
>  1 - you should not add code with a bug and than fix a bug in the same
>      series, you should have a non buggy patch in the first place (e.g.
>      git --amend). (this applies till the patch is not merged into the
>      maintainer tree, of course).
>  2 - point 1 applies also to reviewer comments
>  3 - if you have fixes that are not connected to the feature addition
>      you are doing is beneficial to have those separated, this makes
>      reviewing easier, they can be "prioritized" to some extent (given
>      that they are fixes) and follow a slightly different patch flow
>      (they can get applied, depending on the maintainers decision, when the
>      merge window is closed and should be backported). Not to mention
>      that smaller patch series are appreciated, "Maximum of 7-12 patches
>      per patchset " from [1]
>
> In general I would suggest you to have a look at [1], not sure how up to
> date is that compared to the in-tree Documentation/process/.

I haven't looked at the actual patches but a generic comment from me is
that usually it's not a good idea for newcomers to submit a huge
patchset like this. Start with something small, just with one patch
first, learn the process and what we require from patches. After you
have gained more knowledge you can start doing more complex stuff.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
