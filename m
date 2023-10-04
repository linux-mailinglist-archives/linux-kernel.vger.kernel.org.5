Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29E17B8C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245040AbjJDTHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343799AbjJDTHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:07:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E698B1B2;
        Wed,  4 Oct 2023 12:02:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB17C433C7;
        Wed,  4 Oct 2023 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696446157;
        bh=SGlKk9UgYFkMAL2XGFGQZBKyDXatYdRojMg8660XkVw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RoO0msv7Cl4OooIbjOp9gY6UHJ6fLJFofFzue0hzOk5mjKoA5/URCl8q81n0H9yLl
         KNhNkCc5judi7ra62zD/aYZQxprHx7Nu9IZ34Z7yNQLUjYUW2A9Hwu86Kbv8vlreQf
         Ii2kJve2qk6a2YmP5Qraoj2mzdQQwEyzs/jzN8si/OqqOKZ7Mbi0N2tVIfYYRMy2lf
         UNhVCDvAyeSy1jcRuDNTscFgCLueRO8khJC1plKWIpS+pab9vFT4Iziij7PoK5De6m
         7JMElqGYAoTmAuWdpUfA3ucmgxiLA2V3RGltsg1GIfu+EZ6IOVG9A/SrtfDXcaYH0P
         kb/DOQ96kwSgQ==
Date:   Wed, 4 Oct 2023 21:02:34 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Mikhail Khvainitski <me@khvoinitsky.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: lenovo: Detect quirk-free fw on cptkbd and stop
 applying workaround
In-Reply-To: <20230923231522.94060-2-me@khvoinitsky.org>
Message-ID: <nycvar.YFH.7.76.2310042102170.3534@cbobk.fhfr.pm>
References: <20230918145042.37368-1-me@khvoinitsky.org> <20230923231522.94060-1-me@khvoinitsky.org> <20230923231522.94060-2-me@khvoinitsky.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2023, Mikhail Khvainitski wrote:

> Built-in firmware of cptkbd handles scrolling by itself (when middle
> button is pressed) but with issues: it does not support horizontal and
> hi-res scrolling and upon middle button release it sends middle button
> click even if there was a scrolling event. Commit 3cb5ff0220e3 ("HID:
> lenovo: Hide middle-button press until release") workarounds last
> issue but it's impossible to workaround scrolling-related issues
> without firmware modification.
> 
> Likely, Dennis Schneider has reverse engineered the firmware and
> provided an instruction on how to patch it [1]. However,
> aforementioned workaround prevents userspace (libinput) from knowing
> exact moment when middle button has been pressed down and performing
> "On-Button scrolling". This commit detects correctly-behaving patched
> firmware if cursor movement events has been received during middle
> button being pressed and stops applying workaround for this device.
> 
> Link: https://hohlerde.org/rauch/en/elektronik/projekte/tpkbd-fix/ [1]
> 
> Signed-off-by: Mikhail Khvainitski <me@khvoinitsky.org>

Applied to for-6.7/lenovo, thanks.

-- 
Jiri Kosina
SUSE Labs

