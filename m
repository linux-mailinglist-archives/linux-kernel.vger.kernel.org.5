Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F827CF89F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbjJSMVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjJSMU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:20:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627CBB6;
        Thu, 19 Oct 2023 05:20:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8027C433C8;
        Thu, 19 Oct 2023 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697718057;
        bh=XFuvtHIa7r/OH39BIUY2Rg3BlL4Ej+ED/kG0o9vR93Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lL4GTEtH8PL5mUD4nerM8N3hrP2HgEf9TtWzriEIHLO3yBdd2r2F6bAKPz/5sMJYF
         3WCw0BOPLH2CCqD3VYNPsuqDm+lSI7p8C6TYvJSFsqk+d8AOyi57JqO+DVSTxWjcwK
         Bns62ClLB7ar2dsTvBWRtA7IfsyO1AtDSCt8A+lKIp9v7DL7Fw5czjPK5OFr5SGwkP
         bIMQ1n/g6TqdfFWApd/I2YaJ76vJUVdGHdNSpRFf8ai+XXZNa5BptaBF33Qa+VfSB3
         FUOua3sHRCbCgHj9B+LySXq82BuMiVqaPAO9pFSXJ21HHNye1BOL0dYB1Df77mJFjH
         nc9b67gWxzvtg==
From:   Lee Jones <lee@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Denis Osterland-Heim <denis.osterland@diehl.com>
In-Reply-To: <20231016153051.1409074-1-andriy.shevchenko@linux.intel.com>
References: <20231016153051.1409074-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v2 1/1] leds: core: Refactor
 led_update_brightness() to use standard pattern
Message-Id: <169771805542.2469471.17417276812343058652.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 13:20:55 +0100
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

On Mon, 16 Oct 2023 18:30:51 +0300, Andy Shevchenko wrote:
> The standard conditional pattern is to check for errors first and
> bail out if any. Refactor led_update_brightness() accordingly.
> 
> While at it, drop unneeded assignment and return 0 unconditionally
> on success.
> 
> 
> [...]

Applied, thanks!

[1/1] leds: core: Refactor led_update_brightness() to use standard pattern
      commit: 0e5bb700df6a6fe36d9487a4e0a82a4c7b1f7b4e

--
Lee Jones [李琼斯]

