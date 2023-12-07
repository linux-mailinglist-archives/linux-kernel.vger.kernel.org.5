Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3686680839C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjLGIxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjLGIxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:53:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B3F10B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:53:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D33FC433C8;
        Thu,  7 Dec 2023 08:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701939208;
        bh=DhSbqjsnrf7h3qd/f9SD+8GsKgMde5b6jsS8tzFL0Tc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Sukd+z35LV7PFNWE1vLfL8foH9cYFCR3ZR2Tu0hpnkI6Hc5+V/5LwFBR5VyNDHW9a
         /MWsvUaxFy7+n0Oy5gqltAeo/+1nZBQ1jtvzFIdwcz+5eBpV0VnAR/JqxqREvXeDPE
         AF1wxNOqLyRiMLOQhR9Xqd1obQXGQ7yk8dc5YsP8ojmAh2GFrg/x4VM7z/Vg1x1ZPC
         jkTYfbTZLEB9mxkXU635xG+MfVRgvEeJjBnat1gPz4jPNbgHMk38K0g4YmxHlQkPEE
         jMETGQT1tJ+kP+ILo8HLxMkY+UqtIH1ORDvdU/j3qCG8cIQt5WUVk7s/pmPkKmF7OV
         JOsiVE0BA/Ejw==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <bentiss@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
Subject: Re: [PATCH v2 00/15] selftests/hid: tablets fixes
Message-Id: <170193920703.229356.5910722658341910962.b4-ty@kernel.org>
Date:   Thu, 07 Dec 2023 09:53:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 11:45:51 +0100, Benjamin Tissoires wrote:
> the main trigger of this series was the XP-Pen issue[0].
> Basically, the tablets tests were good-ish but couldn't
> handle that tablet both in terms of emulation or in terms
> of detection of issues.
> 
> So rework the tablets test a bit to be able to include the
> XP-Pen patch later, once I have a kernel fix for it (right
> now I only have a HID-BPF fix, meaning that the test will
> fail if I include them).
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-5.8/selftests), thanks!

[01/15] selftests/hid: vmtest.sh: update vm2c and container
        https://git.kernel.org/hid/hid/c/887f8094b335
[02/15] selftests/hid: vmtest.sh: allow finer control on the build steps
        https://git.kernel.org/hid/hid/c/46bc0277c250
[03/15] selftests/hid: base: allow for multiple skip_if_uhdev
        https://git.kernel.org/hid/hid/c/110292a77f7c
[04/15] selftests/hid: tablets: remove unused class
        https://git.kernel.org/hid/hid/c/b5edacf79c8e
[05/15] selftests/hid: tablets: move the transitions to PenState
        https://git.kernel.org/hid/hid/c/d52f52069fed
[06/15] selftests/hid: tablets: move move_to function to PenDigitizer
        https://git.kernel.org/hid/hid/c/881ccc36b426
[07/15] selftests/hid: tablets: do not set invert when the eraser is used
        https://git.kernel.org/hid/hid/c/d8d7aa2266a7
[08/15] selftests/hid: tablets: set initial data for tilt/twist
        https://git.kernel.org/hid/hid/c/e08e493ff961
[09/15] selftests/hid: tablets: define the elements of PenState
        https://git.kernel.org/hid/hid/c/83912f83fabc
[10/15] selftests/hid: tablets: add variants of states with buttons
        https://git.kernel.org/hid/hid/c/74452d6329be
[11/15] selftests/hid: tablets: convert the primary button tests
        https://git.kernel.org/hid/hid/c/1f01537ef17e
[12/15] selftests/hid: tablets: add a secondary barrel switch test
        https://git.kernel.org/hid/hid/c/76df1f72fb25
[13/15] selftests/hid: tablets: be stricter for some transitions
        https://git.kernel.org/hid/hid/c/ab9b82909e9b
[14/15] selftests/hid: fix mypy complains
        https://git.kernel.org/hid/hid/c/ed5bc56cedca
[15/15] selftests/hid: fix ruff linter complains
        https://git.kernel.org/hid/hid/c/f556aa957df8

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

