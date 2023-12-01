Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4E80089C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378380AbjLAKkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378333AbjLAKkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:40:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0473A1B4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:40:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1B2C433CA;
        Fri,  1 Dec 2023 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701427243;
        bh=MUxGg67sGjrRyrFbECfUufgp71bKjdNxv9joWnz9hRg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=k2tlZ2qEhFpx891blljms3LpcFGEXY9W5UHkhHal1WIT49yKLYz8Dt81SGiHyDpOA
         hvT6jZveUxAFWV78PEBHh8BiQMC+IPShxlLeLGKe4+Ze7+WltVvzAndxGpzGd3FUfB
         H+FrXXbCmXCY5423AhP2B3+Z1pphR01P50fKBTNHGw75B/1WeuGkC/GFrJMucMAegZ
         L3GReFQgkDoShwVfFNUe1teinX9zOww3DeUTn+HjLRngvhyc9yEG24uywK9dx45Hcy
         roAPVVpUCucSjirr4ZJIgzqO8KqILL+GHXBvFPYQgmFg6nPefhG24S0q0LnZ5C3s21
         u+l9Bqb7o939A==
From:   Lee Jones <lee@kernel.org>
To:     Eckert.Florian@googlemail.com, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, gregkh@linuxfoundation.org,
        u.kleine-koenig@pengutronix.de, Florian Eckert <fe@dev.tdt.de>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231127110311.3583957-1-fe@dev.tdt.de>
References: <20231127110311.3583957-1-fe@dev.tdt.de>
Subject: Re: [Patch v9 0/4] ledtrig-tty: add additional tty state
 evaluation
Message-Id: <170142724145.3350831.5316050550655479371.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 10:40:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 12:03:07 +0100, Florian Eckert wrote:
> Changes in v9:
> ==============
> - As requested, I have removed the memory leak fix patch from the previous
>   patch series v8 and have send this patch directly to the stable
>   mailinglist [10].
> - I also have removed the not needed wait for completion code path on
>   sysfs attr store and show, for the new configuration options, as
>   requested by greg k-h [11].
> - Patch v8 3/6 dropped, because the change is not correct as mentiond
>   by greg k-h [12] and this part of the code will be removed anyway
>   in this patch series.
> - Update naming of the function ledtrig_tty_waitforcompletion() to
>   ledtrig_tty_wait_for_completion() which match better with the API call
>   function wait_for_completion_timeout().
> 
> [...]

Applied, thanks!

[1/4] tty: add new helper function tty_get_tiocm
      commit: 5d11a4709f552fa139c2439fead05daeb064a6f4
[2/4] leds: ledtrig-tty: replace mutex with completion
      commit: 50744fe65a4c8b78eff9a4b70825dd7c768f9f69
[3/4] leds: ledtrig-tty: make rx tx activitate configurable
      commit: 8e7b857c0eafdc49ff0e63e9252ed0273b9efdbd
[4/4] leds: ledtrig-tty: add additional line state evaluation
      commit: 7f5a46671b2253989b2674407d624f1fcc77d60f

--
Lee Jones [李琼斯]

