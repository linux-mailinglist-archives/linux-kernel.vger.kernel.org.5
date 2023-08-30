Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6982078D281
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjH3DXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbjH3DWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:22:49 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986071A1;
        Tue, 29 Aug 2023 20:22:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A728E32003F4;
        Tue, 29 Aug 2023 23:22:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 29 Aug 2023 23:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1693365765; x=1693452165; bh=o/VONQHUq9
        xAiRo+AGRw830zSqwSj1iW1vkdoxTZSmc=; b=BDjeTPWkTAhZo1BtDcGPfnyy0y
        L0wyZtSWKuFg6Z5UlMFeZluZF3vXDi+nEkRw8TOTPU9ohniT+THfgznF0n3/njDz
        pLhYSz1LI7lizRzqmW04tEmpCaUlPEiRGpNGRVRYz7NrVunkD4PhHoMS3QU9c9AI
        vTOZPZUsDuDNM4vY4XfpJDELfPDoV/uBWCe8O4S0ryOaLZxJg84OWHAB9q48DyRK
        ajdC2TNGatatRe8xCvJm+6x1C9ur89pvF1P6MVugDPdYw6uIqW4x+aVM6Gb4NGM3
        c/nERSeTjFO6Ho/e5sCOZgR7loV3ZXJjqbDMusT0rpEzQKEZMB0ULyActAIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693365765; x=1693452165; bh=o/VONQHUq9xAi
        Ro+AGRw830zSqwSj1iW1vkdoxTZSmc=; b=vbpeWuFFterzKqRBEXKe1qKjUq7Ec
        xb2dF0EmQZn4h0B8KPnZKo17SzATOjd04Fa5gDwkNjQ1WELDh1gcOHld/dvA3k9u
        uMmaQxXhhpGiai/Nr2uyYvLVkxnxpwgN9/xtZq443HKE537A3+4daGxAXj0ZrvRU
        OiXQCbGNJC9dlekncTwRY/JMCZ7qInGdropcwx67EpWdCo1aCO2yXr3aYr/JgiSl
        14dGcHk46ACtHWOeflxl44IUEeqbrDCEJ/aJF2Ox4Jh/QirFltmwapiE5x4cQs0z
        5qKHUL62fG3bwAp1IvJK6p6a7X9m2FTOpZNp7yXq+aQTcOkp5if18dp9Q==
X-ME-Sender: <xms:BLbuZCgGVfGt7yY_tRwPWjEwyYhdIEOMATGSa9uG6yxnvspkEBSLPw>
    <xme:BLbuZDCrkcnP4ggs20gZID1vFgIod-bzhqX41Jl3_YS7WxlkX0RZ7Lq9rUSjBC5jx
    X9fTbl5azRaUdgU4j8>
X-ME-Received: <xmr:BLbuZKFbcxoMH08VyL06EB3FycOtx_M5XKhlil5x79LIzUBrj6ipVCGvmB5Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnheptdehkeeigeeggfelkeeufeefjeduvd
    ejveduvdehtdegveeftdeugeetvdeltdejnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:BbbuZLQVwEIvP9P55jqtqp0b7OQ78gv8OYXuFmj3Fs5lrGiEvoem1g>
    <xmx:BbbuZPy5fFVTO6yxzjMxmJoJ_tuh0NXSYYK7pU8VF9S44b43u8sisw>
    <xmx:BbbuZJ40avIyVezGV_HSVhXxHUjqLnKOuyFlgg6AHK3e6XPVRaQMiw>
    <xmx:BbbuZP9P3djlu0wzdNaZNWKs-QBxbuW4LnwuWKeGF1fCD-lK-BXyRA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 23:22:42 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v6 0/1] platform/x86: asus-wmi: add support for ASUS screenpad
Date:   Wed, 30 Aug 2023 15:22:36 +1200
Message-ID: <20230830032237.42987-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the WMI methods used to turn off and adjust the
brightness of the secondary "screenpad" device found on some high-end
ASUS laptops like the GX650P series and others.

Changelog:
- V6
  - Move bulk of cover letter in to commit message
  - Add define for ASUS_SCREENPAD_BRIGHT_DEFAULT to be used on boot
  - Remove the use of max() in update_screenpad_bl_status()
  - Previous: https://lore.kernel.org/all/20230827232358.80512-1-luke@ljones.dev/
- V5
  - Add minimum brightness to prevent screen from becoming invisible
  - Previous: https://lore.kernel.org/all/20230630041743.911303-1-luke@ljones.dev/
- V4
  - Fix a null dereference that happened if the display was powered off and dev struct uninitialised yet
  - Previous: https://lore.kernel.org/all/20230620030033.55033-1-luke@ljones.dev/
- V3
  - Refactor error handling in all functions
- V2
  - Complete refactor to use as a backlight device

Luke D. Jones (1):
  platform/x86: asus-wmi: add support for ASUS screenpad

 drivers/platform/x86/asus-wmi.c            | 133 +++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |   1 +
 include/linux/platform_data/x86/asus-wmi.h |   4 +
 3 files changed, 138 insertions(+)

-- 
2.41.0

