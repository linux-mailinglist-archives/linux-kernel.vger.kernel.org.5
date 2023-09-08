Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9707987C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbjIHNZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243544AbjIHNZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:25:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ECB1BF0;
        Fri,  8 Sep 2023 06:25:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92464C433C7;
        Fri,  8 Sep 2023 13:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694179510;
        bh=9ndHr7tfUjp4mVv9z+x8c5QATDVhJpJXez+DnQJHD4Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LSuiyWgqfqI/+cwgkgQLy7meh9HOXIGWKWHt9NZ32wVrLp9fCDtsfb574ghdFXdPu
         Zw3gg+1SHOnmVrOUARCkrAZvHvncOQITDoTnrF65nNkg9B/jhCuP1UHmNJo4VgFTjI
         C1MVc+RLSKoQ1vDHhEOXxpDVM0hCfhnqBVP9gd4jjo9c/ZLuAy//gpVcq2Ftn6hmj1
         VZt3bAC5XcUEll4IxmWx4XLS85aQgUegnmRRVuY9kHelRE9DoE53bGEWAbkXca19U3
         /EibWgc1NagVVJTX7q4jD+Ji6br27ko5GSH/dpAJTlV6hNms0Ieyq5X32szxSDXvUU
         p4KzYY7Ve+pzA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yanik Fuchs <Yanik.fuchs@mbv.ch>
Subject: Re: [PATCH] wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM
References: <20230907071614.2032404-1-s.hauer@pengutronix.de>
        <bed0e0cacc44476582fc58180d77519c@realtek.com>
        <20230908113655.GF637806@pengutronix.de>
Date:   Fri, 08 Sep 2023 16:26:38 +0300
In-Reply-To: <20230908113655.GF637806@pengutronix.de> (Sascha Hauer's message
        of "Fri, 8 Sep 2023 13:36:55 +0200")
Message-ID: <878r9gn6cx.fsf@kernel.org>
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

Sascha Hauer <s.hauer@pengutronix.de> writes:

>> Should it add a Fixes tag? 
>> Fixes: 87caeef032fc ("wifi: rtw88: Add rtw8723du chipset support")
>
> Yes, I forgot this. Kalle, can you add it once again while applying?

Yes, I'll add it. I guess it would be good to apply this to wireless
tree?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
