Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB407A4D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjIRPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjIRPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:55:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5A120;
        Mon, 18 Sep 2023 08:51:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FA2C43397;
        Mon, 18 Sep 2023 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695043146;
        bh=hBpZeohfKBVKg3GI59uHeoX3VFbPP5FzPHW0VLd/4Hc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Y47Goxhbk1pdJsYaNffhzqnTfAlVKZMtIAU0VlNXP/RUSnyepT9/QKSxITCZe//+t
         Hs4PTX2XbYI2SDt8KbDLZEJQUfnFPsTEZmq3rPWlq03/S0DKqIW0ejfaZyp/MdoBQG
         dMHcAVQo3Chum3Y6I/mWq4Ru2aTwI46r5nSn1Vw+i/cmzWMg0rSf23hSyf7eddgw52
         o+1ohB/mVNwMxi79yxROowdYw5Z8J8tnJRfuqpOEiEAJT1x042s7/394UPDQW02DbE
         Dc+ICDjZ/aTZIztTWlahk3zCQt7K5qxLjuIdUW+SxjGRIDgh/v2TygSqkpl0HyBH9a
         ut9RCv8xOB9Jw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230907071614.2032404-1-s.hauer@pengutronix.de>
References: <20230907071614.2032404-1-s.hauer@pengutronix.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ping-Ke Shih <pkshih@realtek.com>,
        Yanik Fuchs <Yanik.fuchs@mbv.ch>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169504314310.617522.5940520888124788704.kvalo@kernel.org>
Date:   Mon, 18 Sep 2023 13:19:05 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The MAC address is stored at offset 0x107 in the EEPROM, like correctly
> stated in the comment. Add a two bytes reserved field right before the
> MAC address to shift it from offset 0x105 to 0x107.
> 
> With this the MAC address returned from my RTL8723du wifi stick can be
> correctly decoded as "Shenzhen Four Seas Global Link Network Technology
> Co., Ltd."
> 
> Fixes: 87caeef032fc ("wifi: rtw88: Add rtw8723du chipset support")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reported-by: Yanik Fuchs <Yanik.fuchs@mbv.ch>
> Cc: stable@vger.kernel.org
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless.git, thanks.

2e1b3ae3e1f2 wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230907071614.2032404-1-s.hauer@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

