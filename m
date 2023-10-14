Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3F7C92D8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 07:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjJNFUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 01:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNFUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 01:20:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8409BBF;
        Fri, 13 Oct 2023 22:20:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838B0C433C7;
        Sat, 14 Oct 2023 05:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697260809;
        bh=Ytj2/J6JoBkWt+fErmzSJIMEUCzhsog0az/dPrYSoqI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ICYTGHBrHoTDiCb37W1wDlaDlK2hb/Usrv/wIXwmxTCIWFzfO9QvRdHfeAbkk45gm
         OtFGC3aMI5oB9BrXLw5R675UrRIvEZleHHRci0z0YyJaAxxHmHI/eNdGcYSQMbxXvk
         YLu9JKXVZl/AZ3mfmFT0q0FyYyBjudqMVgdOhDYF07XRNDENqcCOqdNfkvAJBUXs1x
         aSOqcfKQK4oY4fcBsv9vsR4oUCAKoNw1LmLpFV8o5NXLHe+4VDpZPNJo5CWLgpDi8k
         NDFu6b2/fgdUCusNpdKVD8TemfPcRWlfp+cNascn79BgHfWV5a9cACas3mSKLjrj6h
         C5hreUQFnu+qg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Abhishek Kumar <kuabhs@chromium.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] ath10k: mac: enable
 WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON on ath10k
References: <20230629035254.2.I23c5e51afcc6173299bb2806c8c38364ad15dd63@changeid>
        <169634426707.121370.9448850980134728319.kvalo@kernel.org>
Date:   Sat, 14 Oct 2023 08:20:05 +0300
In-Reply-To: <169634426707.121370.9448850980134728319.kvalo@kernel.org> (Kalle
        Valo's message of "Tue, 3 Oct 2023 14:44:28 +0000 (UTC)")
Message-ID: <87il793hmi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Abhishek Kumar <kuabhs@chromium.org> wrote:
>
>> Enabling this flag, ensures that reg_call_notifier is called
>> on beacon hints from handle_reg_beacon in cfg80211. This call
>> propagates the channel property changes to ath10k driver, thus
>> changing the channel property from passive scan to active scan
>> based on beacon hints.
>> Once the channels are rightly changed from passive to active,the
>> connection to hidden SSID does not fail.
>> 
>> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
>
> There's no Tested-on tag, on which hardware/firmware did you test this?
>
> This flag is now enabled on ALL ath10k supported hardware: SNOC, PCI, SDIO and
> maybe soon USB. I'm just wondering can we trust that this doesn't break
> anything.

Jeff, what are your thoughts on this? I'm worried how different ath10k
firmwares can be and if this breaks something.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
