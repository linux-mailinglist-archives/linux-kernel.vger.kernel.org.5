Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66E77F61E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345902AbjKWOsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345872AbjKWOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:48:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90904D5E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:48:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B336C433C8;
        Thu, 23 Nov 2023 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700750920;
        bh=u1dfPAl8WU4nH1bqr+U/uJcJjIRSFeshXRZIIy7HgTw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KioWlU0zmU30FWER87A8d5h5uul9ohvHD+i0X704NCKIYMg8CIhu8OYWNR5uH6hT9
         8j/QU+ung6WIr/9ZNBmh+jvAYMUYATV2jaXsIL14e+VFrX7hIPPd4Y3C6KsnEgHZPt
         iz5pd3LzK2QpHtRFFpkZQEntsc47alcz746BqT+ZXscNP56Pn6c7j/Y/aVIm/ixask
         TXFjGn1/C03I72hRt9T6/hnVDW8sm1zKooGwdNYJwPjPE2rMNqazOnaVofLg03H1oc
         OmQpJ2vj+rLmvRGadRlf4fTLA8fvgSFXUeKpjc79nJozWWrBg83Fb8HlLStfYepPlu
         YENPJUi1+9zHQ==
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com>
References: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/4] leds: trigger: gpio: Replace custom code for
 gpiod_get_optional()
Message-Id: <170075091897.1365956.17632014819922518514.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 14:48:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Nov 2023 21:53:07 +0200, Andy Shevchenko wrote:
> gpiod_get_optional() and currently used fwnode_gpiod_get_index()
> are both wrappers against the same engine internally. Since we
> have a pointer to struct device there is no reason to use fwnode
> type of GPIO call. So, replace the current fwnode call by respective
> gpiod ones.
> 
> 
> [...]

Applied, thanks!

[1/4] leds: trigger: gpio: Replace custom code for gpiod_get_optional()
      commit: cafe2f8ed515e586b020a60df44e9f251f4d6248
[2/4] leds: trigger: gpio: Convert to use kstrtox()
      commit: 001813a6f0c7b05c139cde5d5177a4a9bfe39b09
[3/4] leds: trigger: gpio: Use sysfs_emit() to instead of s*printf()
      commit: bd4f0709c66394bb746c985872c4153ac93877b7
[4/4] leds: trigger: gpio: Convert to DEVICE_ATTR_RW()
      commit: 0603a253b18421a336c3be14bdcd1c5d75b6503b

--
Lee Jones [李琼斯]

