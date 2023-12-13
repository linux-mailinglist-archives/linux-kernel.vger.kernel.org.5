Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC97881190E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjLMQTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjLMQTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:19:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D884120
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:19:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB708C433C7;
        Wed, 13 Dec 2023 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702484366;
        bh=+aCtXby44eV/reOr+yI/a4TpeRyBh8tioyCMaTqfaQY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cdRFNNMVB1ZwDP83qv5fSq5FQsjMr3UgA9s/cQ1AOiwW3PaBDTUrzOKwE+OQqyJxS
         tECbuKqFeaFG1BrfxVtlw13xi5dOV0Xzy41xchIIpsiyGv1RQt51wMKL1Enju2X3kj
         jZHrja2jYbdyL6EtsUbso2q9yqG9VzdkN6Cw1+U//M5X26+Sqk0BNS0QFDCn1XWCPP
         g2lk77s+5N+K0N/bpdiXc8XxaY6pgDLNUPfoBA5YVCUs+hbp8XFHLTc1CrXEj7W4LV
         UW94VlmEOYiofo6xmUXy3RoKfnnW1BXLRD6SskULaej3sHj3vk5ImlUOQr61AvC3Qr
         oQ7AJCYus0qoA==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alex Vinarskis <alex.vinarskis@gmail.com>
In-Reply-To: <20231211111441.3910083-1-andriy.shevchenko@linux.intel.com>
References: <20231211111441.3910083-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 1/1] mfd: intel-lpss: Fix the fractional
 clock divider flags
Message-Id: <170248436569.1008120.549492306300764112.b4-ty@kernel.org>
Date:   Wed, 13 Dec 2023 16:19:25 +0000
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

On Mon, 11 Dec 2023 13:14:41 +0200, Andy Shevchenko wrote:
> The conversion to CLK_FRAC_DIVIDER_POWER_OF_TWO_PS uses wrong flags
> in the parameters and hence miscalculates the values in the clock
> divider. Fix this by applying the flag to the proper parameter.
> 
> 

Applied, thanks!

[1/1] mfd: intel-lpss: Fix the fractional clock divider flags
      commit: 03d790f04fb2507173913cad9c213272ac983a60

--
Lee Jones [李琼斯]

