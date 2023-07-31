Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60C6769FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGaRoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGaRoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137E610B;
        Mon, 31 Jul 2023 10:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DBF16124F;
        Mon, 31 Jul 2023 17:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F50C433C7;
        Mon, 31 Jul 2023 17:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690825469;
        bh=ERL5BDHihGjEFPJ2UxTVdlcp/qwmTYb2pctG9U8dKXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9wI4zjSS2eLIrbHx+v2W5ABu327IFBU7OpWsBtnWP7CyJKgH3MM2b74/KPrg+ZVo
         RmxUepvPvmOwwVj48jucpb0t13CsAzF1h/x4gkiSb/U8Ht1sTX2LA25hmwn6P4yVMS
         pzbxFVIKN1TFUtiF954RsmrsGYxaUkJYhStlIPl4z8kWouTB4L74UHpY2O/z/50usb
         eKQYPdDFCZPxzDpIdB7WA5Qes8Uf+/AYxc4HuoJkJLnOcShzUwHZJMvz6asm1kVa5o
         Wa7ccOI5eH8nqUEQvxHclgD1vCPkCU2kJNxEMJicQtrSs6/nC9ISiHRARoM1HWAu6E
         mUe0wZSfDFVYA==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Explicitly include correct DT includes
Date:   Mon, 31 Jul 2023 18:44:24 +0100
Message-Id: <169081113966.3427180.6648898239320683110.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230714174021.4039807-1-robh@kernel.org>
References: <20230714174021.4039807-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 11:40:20 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Explicitly include correct DT includes
      https://git.kernel.org/arm64/c/b9d601249740

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
