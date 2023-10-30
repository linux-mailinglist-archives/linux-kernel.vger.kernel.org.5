Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343F07DBE5C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjJ3Q4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjJ3Q4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:56:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC4DB;
        Mon, 30 Oct 2023 09:56:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C1BC433C7;
        Mon, 30 Oct 2023 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698684960;
        bh=7+7vRhXHb5QjQwut8OzZIttdLSOWtUI77jnd6XpGSc4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IIWebl7JgzJnu8OG5ttQkIo9V8/m9IvZLf/StWmZgBfxWD9jeT/YVvjLlXZfhgH5s
         kcR75Po7P1yB1jcFGhWlpFs8RJPPacFX/rmewlstO3kP0siwx/qbB4jQOiFti4A1q9
         mj5sFcZTYPJdkXJUR9RzanWW8/4aH1Fc89jjzSPAm5qL82K+88AKpP6KzuaKfvZF0p
         LBDvpLeLTlGahSrdM2KKfAxUYXzDb7pveOMwWUA6aCOvlx/g0jv+JMIR1jXkjoiXF4
         biqdLLSyukbxjK+7wnxw9qisV1bQJWTmHVyChAGrn3htbVw+xF9A9w2OD9yjg+4PBH
         AtbosC34rrQWA==
From:   Kalle Valo <kvalo@kernel.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     arnd@kernel.org, Larry.Finger@lwfinger.net,
        alexandre.belloni@bootlin.com, arnd@arndb.de,
        claudiu.beznea@tuxon.dev, davem@davemloft.net,
        geert@linux-m68k.org, geoff@infradead.org,
        gregkh@linuxfoundation.org, gregory.greenman@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nicolas.ferre@microchip.com,
        pavel@ucw.cz, quic_jjohnson@quicinc.com, stf_xl@wp.pl
Subject: Re: [PATCH 00/10] Remove obsolete and orphaned wifi drivers
References: <20231023131953.2876682-1-arnd@kernel.org>
        <20231030071922.233080-1-glaubitz@physik.fu-berlin.de>
Date:   Mon, 30 Oct 2023 18:55:53 +0200
In-Reply-To: <20231030071922.233080-1-glaubitz@physik.fu-berlin.de> (John Paul
        Adrian Glaubitz's message of "Mon, 30 Oct 2023 08:19:22 +0100")
Message-ID: <87cywwvyli.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:

> There is some non-x86 hardware like the Amiga that still uses
> PCMCIA-style networking cards on machines like the A600 and A1200. So,
> unless these drivers are actually causing problems, I would rather not
> see them go yet.

There is a cost maintaining these drivers so I would like to see more
information in the report, at least:

* exact driver and hardware used

* last kernel version tested

* kernel log messages from a successful case

Here's a good example:

https://lore.kernel.org/linux-wireless/20231024014302.0a0b79b0@mir/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
