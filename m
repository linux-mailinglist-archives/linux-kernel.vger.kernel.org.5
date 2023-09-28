Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0805B7B1F34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjI1OIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjI1OID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:08:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6BF8F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:08:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1528C433C7;
        Thu, 28 Sep 2023 14:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695910081;
        bh=hTjXKLo4bLLR3wCZ6F5q3vPoyk/RkdCfzfXhllKmjtk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rm/y+2AUiNj1Bd2DpFCefm0GyNrfmR2WKlizu4SStsCqvLI091iNMbdISvH/l7Ay+
         dRwXWWO5c15uHrW9Z77s6qlpfaj4dwYUZUHra0ss7F+aqDnfp8kPalQRU5R4W7AP/x
         FvgJcN1Vz0esJzrmhLanWQGoA7ZclUs+VOSoXOUKRmbm7s64pA78Ho67ix7tuEQ4Dj
         nfUOZ0CGxRd5fcgrdMSSf9NCkaC8A/9Fxw/auAnmehxFRzZYxDJva1D/SlSvTLInR9
         4c7Atuu4Eok0JswCg7WjV+sfi/13RBVdtPwM7CdrcV05ZEVaYZ9/j9n0KXA+4/rsan
         8iKyM/ASTNEWg==
From:   Lee Jones <lee@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20230926190834.932233-1-andriy.shevchenko@linux.intel.com>
References: <20230926190834.932233-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/4] mfd: lpc_ich: Make struct lpc_ich_priv use enum
 for chipset member
Message-Id: <169591008056.1621069.6569980985596979738.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 15:08:00 +0100
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

On Tue, 26 Sep 2023 22:08:31 +0300, Andy Shevchenko wrote:
> We have a specific enum for the supported chipsets.
> Make struct lpc_ich_priv use better type for the chipset member.
> 
> 

Applied, thanks!

[1/4] mfd: lpc_ich: Make struct lpc_ich_priv use enum for chipset member
      commit: be05b4a42901fc3bee6f84719178508f8cd82b9c
[2/4] mfd: lpc_ich: Convert gpio_version to be enum
      commit: a7c5e755ef3d14fcf201660531261ab650812baf
[3/4] mfd: lpc_ich: Move APL GPIO resources to a custom structure
      commit: 123a58d7c429d30f6e0e615b20c1b74e1e1e6616
[4/4] mfd: lpc_ich: Add a platform device for pinctrl Denverton
      commit: 032d77aada6e56f8232d836a006b541045297d82

--
Lee Jones [李琼斯]

