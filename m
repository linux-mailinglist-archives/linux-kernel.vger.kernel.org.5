Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE47F4979
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344278AbjKVOyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjKVOyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:54:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6864311F;
        Wed, 22 Nov 2023 06:54:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DD0C433C8;
        Wed, 22 Nov 2023 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700664878;
        bh=+sDZdcVmCxzlpku0u5hP/hTUo6Jty1e6yGw1zaWCyVk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kalaTLNstoTOkQQFik64V3M0XnHVQvvpeRBuS3sVs+66bqjlEHVWuX3QiLL7qd1aT
         c3BwSNL+jHgHMdSswZsIrNmsf+7Pchk3lUfLHLsYqPDnK/T3tuvQnkoMXfq6l0Q11T
         Uq/BSyZAdBVNDkni2b/w12bePQOvS2wr1ingcR+MTj5/aAq/coOPmOatzXnFl1fVmv
         33Y2Vd8K4wbbZtbQFuuumDsO2iXSlZ5wdK185aE6HPtwguioogpwaHage/9Q2kelvR
         zzJr8evaCgX+8rtZabFfJqQwZwNJGWgkxYPqu4/rfhymS5ORX42m7EsFnTNW0ykquY
         ejueY3/7OGp2g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/7] wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW
 accessors
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231117094425.80477-2-ilpo.jarvinen@linux.intel.com>
References: <20231117094425.80477-2-ilpo.jarvinen@linux.intel.com>
To:     =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170066487414.4178710.14428414852217491443.kvalo@kernel.org>
Date:   Wed, 22 Nov 2023 14:54:36 +0000 (UTC)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> The rtlwifi driver comes with custom code to write into PCIe Link
> Control register. RMW access for the Link Control register requires
> locking that is already provided by the standard PCIe capability
> accessors.
> 
> Convert the custom RMW code writing into LNKCTL register to standard
> RMW capability accessors. The accesses are changed to cover the full
> LNKCTL register instead of touching just a single byte of the register.
> 
> After custom LNKCTL access code is removed, .num4bytes in the struct
> mp_adapter is no longer needed.
> 
> Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
> Fixes: 886e14b65a8f ("rtlwifi: Eliminate raw reads and writes from PCIe portion")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

In the next version please add "wifi:" to the title for patches 3-7.

7 patches set to Changes Requested.

13458674 [1/7] wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors
13458675 [2/7] wifi: rtlwifi: Convert to use PCIe capability accessors
13458676 [3/7] rtlwifi: rtl8821ae: Remove unnecessary PME_Status bit set
13458677 [4/7] rtlwifi: rtl8821ae: Reverse PM capability exists check
13458706 [5/7] rtlwifi: rtl8821ae: Use pci_find_capability()
13458678 [6/7] rtlwifi: rtl8821ae: Add pdev into _rtl8821ae_clear_pci_pme_status()
13458705 [7/7] rtlwifi: rtl8821ae: Access full PMCS reg and use pci_regs.h

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231117094425.80477-2-ilpo.jarvinen@linux.intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

