Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE997D73CB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjJYTCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYTCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:02:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85F3116;
        Wed, 25 Oct 2023 12:02:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308ADC433C7;
        Wed, 25 Oct 2023 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698260564;
        bh=/9iWr4f/dsLFRv2le/lOb5v7vmV4yJB6T0i1GKy1FFQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JQl6a6s5ih0P9/E6pdGs9Pi0hfBJPAWvXW5nSLnzUyEt3o0M+ZgIa4wuo1n15nfFq
         4zPF5waP9ScISnJEgUJOGkTPOGvDQ9PkBpa5LuYD67qDUTEcnMTudNcmI6lysfHtxF
         QG2kzm5/GgO5cnkxsxSi5V+1Xp53Wvbvb9P+4V9eVzRQwe4E5s9G/Kv+tYOgA7C+4c
         Q8KY3/WV8W0vTGbVt+MGS2Ecj7/Wsb03pnPRzwredLsgpp1ukc5wbwsd5O7cy7QQVa
         0UhPky7SBhcHBRj9xDW/8gw0w3mIcopnMfpXfS6ZVO+ifo7INcbMLlHW/BkWrH6CoS
         EeBzHZJJMO5jg==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
In-Reply-To: <20231012-hid-pm_ptr-v1-0-0a71531ca93b@weissschuh.net>
References: <20231012-hid-pm_ptr-v1-0-0a71531ca93b@weissschuh.net>
Subject: Re: [PATCH 0/4] HID: remove #ifdef CONFIG_PM
Message-Id: <169826056250.336761.2729314989598019924.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 21:02:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 12:23:37 +0200, Thomas Weißschuh wrote:
> Through the usage of pm_ptr() the CONFIG_PM-dependent code will always be
> compiled, protecting against bitrot.
> The linker will then garbage-collect the unused function avoiding any overhead.
> 
> This series only converts three users of CONFIG_PM in drivers/hid/ but
> most of the others should be convertible, too.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.7/config_pm), thanks!

[1/4] HID: core: remove #ifdef CONFIG_PM from hid_driver
      https://git.kernel.org/hid/hid/c/df8b030d82dd
[2/4] HID: usbhid: remove #ifdef CONFIG_PM
      https://git.kernel.org/hid/hid/c/f354872108eb
[3/4] HID: multitouch: remove #ifdef CONFIG_PM
      https://git.kernel.org/hid/hid/c/fc2543414c3e
[4/4] HID: rmi: remove #ifdef CONFIG_PM
      https://git.kernel.org/hid/hid/c/eeebfe6259ba

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

