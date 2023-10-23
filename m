Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9077D39E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjJWOnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjJWOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:42:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBB01FD6;
        Mon, 23 Oct 2023 07:41:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF551C433C8;
        Mon, 23 Oct 2023 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698072091;
        bh=N4If+wgwsD8dFTdUHEouchVNBSUFE+9hWZEa6Th40ts=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qD+ozjajwsL/rFVAaZsugmIyEH3vwd5drmhXUIXfjLh1gKwHJWIN1dobJ88kx4Egh
         RHA4m/cy5OiAXs+dPr2hUVPCKRKLzCsK4ipHu/V3SBzjatw9ibogQb9E3+cQVZZSnW
         bhogHTKie9F8J4xFYhhGmRkymJ2uqsEoy6vRAmBgpTjNE6DooXvbMnRHTmt80js1v6
         fUJE2AEkblMuFSj6kajAKMdP8frLSty/xG8TbjwDC7PenDxpsGKxWxCWhf0BxcJUWQ
         N2wZvRaECSlzwYO5tL4q7HJCK+XVhR8pNAV7KKU/ZGN5RO8kx5lGbXFRPOluU7RHcB
         A9gJHTEZj/aqA==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Geoff Levand" <geoff@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Jeff Johnson" <quic_jjohnson@quicinc.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        "Larry Finger" <Larry.Finger@lwfinger.net>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Pavel Machek" <pavel@ucw.cz>, "Stanislaw Gruszka" <stf_xl@wp.pl>,
        "Gregory Greenman" <gregory.greenman@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/10] Remove obsolete and orphaned wifi drivers
References: <20231023131953.2876682-1-arnd@kernel.org>
        <87v8axzc46.fsf@kernel.org>
        <50eafe40-9c50-48e2-8d48-6a113c8fd87d@app.fastmail.com>
Date:   Mon, 23 Oct 2023 17:41:24 +0300
In-Reply-To: <50eafe40-9c50-48e2-8d48-6a113c8fd87d@app.fastmail.com> (Arnd
        Bergmann's message of "Mon, 23 Oct 2023 16:10:16 +0200")
Message-ID: <87edhlz9ij.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Mon, Oct 23, 2023, at 15:45, Kalle Valo wrote:
>> Arnd Bergmann <arnd@kernel.org> writes:
>>
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> As discussed previously, a lot of the older wifi drivers are likely
>>> entirely unused, Though we can't know for sure.
>>>
>>> As suggested by both Greg and Jakub, let's remove the ones that look
>>> are most likely to have no users left and also get in the way of the
>>> wext cleanup. If anyone is still using any of these, we can revert the
>>> driver removal individually.
>>>
>>> I would suggest merging these for net-next after 6.7-rc1 is out
>>
>> Why net-next? I want to take these to wireless-next to avoid any
>> conflicts with other wireless patches.
>
> My mistake, I actually rebased them on top of wireless-next before
> sending out the patches, I just forgot update the text I had
> already written a week earlier.

Ah, good that we are on the same page then :)

>> We could take these to wireless-next after we submit the last new
>> features (-next) pull request to v6.7, so most likely already next week.
>> So if anyone has any problems with these speak up now.
>
> Sounds good to me, thanks!

Thanks for the patches! I applied them to our pending branch for some
build testing, there were few conflicts I guess due to recent cleanup
patches but obviously easy to fix :)

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/log/?h=pending

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
