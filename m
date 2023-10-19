Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354567CF8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbjJSM0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjJSM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:26:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7EFBE;
        Thu, 19 Oct 2023 05:26:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5E2C433C7;
        Thu, 19 Oct 2023 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697718379;
        bh=NJeZagcb+M769VUrarpouaRWXr3bAXeFnWHPC5/oozQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G1zT++TYgnLvoW5DalEc/anydR3UGgZGl63e3fsD23bkTlbymDZd6sPN9Pn0xM9k7
         CcD/sYSpOmcFcT1FxSsxWONAznHLivKHcxD+E0OAxlCE5HPYQ4E2hxZywCkZ+Hp1Sb
         +9VPAzjRe7EwmtVOvSy4tXFvHKq/WdzdkpQocPRegEJSNxeO56txBosPAsWHk9MZ8l
         vGqASBsj1VVfYAk3O6ixovvaD5vVdRq9MzI8p3d9e5VkUSlmySDYUtizt/Te45pMZ/
         hNUFWCUXHq+G7X3OR1QZrUcMT5srBF+7BaMToF1Bggia6SrnvHmPLIoD0r57sas8RQ
         ENJklHkPS9VdQ==
From:   Lee Jones <lee@kernel.org>
To:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
In-Reply-To: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
References: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/6] leds: gpio: Keep driver firmware interface
 agnostic
Message-Id: <169771837822.2472592.6103041614974900310.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 13:26:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 19:10:00 +0300, Andy Shevchenko wrote:
> The of.h is used as a proxy to mod_devicetable, replace former by
> latter.
> 
> The commit 2d6180147e92 ("leds: gpio: Configure per-LED pin control")
> added yet another unneeded OF APIs. Replace with direct use of fwnode.
> 
> Altogether this makes driver agnostic to the firmware interface in use.
> 
> [...]

Applied, thanks!

[1/6] leds: gpio: Keep driver firmware interface agnostic
      commit: 04262082e2c203e6834bf65c7a46e2eadf212c66
[2/6] leds: gpio: Utilise PTR_ERR_OR_ZERO()
      commit: 36d270892d4733439d3fd5b713ef07029aae1bf4
[3/6] leds: gpio: Refactor code to use devm_gpiod_get_index_optional()
      commit: 4c5f908c04fda867c8130087a628a1bccec3fb05
[4/6] leds: gpio: Move temporary variable for struct device to gpio_led_probe()
      commit: 087da384361247adeb894dcb38fbbec8d4d53790
[5/6] leds: gpio: Remove unneeded assignment
      commit: cdae3873bb328fbc690722b76b67f00213c92ade
[6/6] leds: gpio: Update headers
      commit: 1f313de42c4ff9b590f00d747bab25adc0cb011c

--
Lee Jones [李琼斯]

