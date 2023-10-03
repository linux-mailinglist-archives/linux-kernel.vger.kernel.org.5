Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE3C7B6BF3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbjJCOog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjJCOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:44:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5731AF;
        Tue,  3 Oct 2023 07:44:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5D0C433C7;
        Tue,  3 Oct 2023 14:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696344270;
        bh=/B3cve6YrGk+HiByt3eCtzticC+G5KGeINugbxRXa+0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=G9ra3rfOvF81SNltY0+7rB9LU2lNRMkOpcFYKiesBTdxVqnBcstMgJaMm8OKYuyzE
         fhCd/gNuADS31jGfMzsRQVgDa0XjzkUH7PIWqzOyhLAHc9hVFGtSXWiqNUdhcoTcuY
         0834LPN9Fy1QfcgTUQc1RVcqXa41TU6G3F3BOAQYb50kZJycXoIB1dPNp9W+L0Sr4v
         uycxxBmg2sRItx23zyRM9uMGWcB3n04SMsL73yA4vAmjQvP4/yssGu7azBtiTN+h01
         YXHydglDNUwkE918pxqTIKWiXem2aqyDrAeLLcdc0W3Q/q8UjNExAmxCrM68ii2c4c
         HPA4nrMmYdxQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath10k: mac: enable
 WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON
 on ath10k
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230629035254.2.I23c5e51afcc6173299bb2806c8c38364ad15dd63@changeid>
References: <20230629035254.2.I23c5e51afcc6173299bb2806c8c38364ad15dd63@changeid>
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        kuabhs@chromium.org, netdev@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169634426707.121370.9448850980134728319.kvalo@kernel.org>
Date:   Tue,  3 Oct 2023 14:44:28 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abhishek Kumar <kuabhs@chromium.org> wrote:

> Enabling this flag, ensures that reg_call_notifier is called
> on beacon hints from handle_reg_beacon in cfg80211. This call
> propagates the channel property changes to ath10k driver, thus
> changing the channel property from passive scan to active scan
> based on beacon hints.
> Once the channels are rightly changed from passive to active,the
> connection to hidden SSID does not fail.
> 
> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>

There's no Tested-on tag, on which hardware/firmware did you test this?

This flag is now enabled on ALL ath10k supported hardware: SNOC, PCI, SDIO and
maybe soon USB. I'm just wondering can we trust that this doesn't break
anything.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230629035254.2.I23c5e51afcc6173299bb2806c8c38364ad15dd63@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

