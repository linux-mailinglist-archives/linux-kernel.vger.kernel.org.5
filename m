Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD33786E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbjHXL7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbjHXL7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:59:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0205198B;
        Thu, 24 Aug 2023 04:59:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35C5A66AF5;
        Thu, 24 Aug 2023 11:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F583C433C7;
        Thu, 24 Aug 2023 11:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692878358;
        bh=+PV2XW4U5Rbut0MTv49hBcdhZ5aEQZBFo5S55w+PYXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CVkLPFB5fOJAnrKZIzoEH0XkTesJmHCk4Mo/tShe8uO+WICNN2d1MV7rLX7Dfjlmn
         mnMNhctRW4TG1KV+jrBSfoAWw9vjfXJWuRFMH8y0cbQ+AsaKhvBO3i2H7bJYoXPNNb
         vPJCeoWnzAS0M480ndqtYxoyH9F2Onr/KhUpI1TLNcyIU88DInnqq6roNxELfMiAyE
         TB/tALc9jYPxFDB98qbgCUbqmeJCK5VCk1L7IKAZXJSIvIwBzoTkkY3Et2pgOdVyRY
         bjiOLb05tQt5nv+9+FliYulAnpJOVR9bwab1CSAyYVFzMBh03ogGgG6suUVknAnl7P
         AoVMS2/0qK7+g==
Date:   Thu, 24 Aug 2023 12:59:14 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3] leds: max5970: Add support for max5970
Message-ID: <20230824115914.GQ1380343@google.com>
References: <20230824111337.2589755-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824111337.2589755-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023, Naresh Solanki wrote:

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The MAX5970 is hot swap controller and has 4 indication LED.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
> Changes in V3:
> - Drop array for ddata variable.
> Changes in V2:
> - Add of_node_put before return.
> - Code cleanup
> - Refactor code & remove max5970_setup_led function.

This is 3 revisions in the past 24hrs.

Please refrain from machine-gunning revisions out like this.

Send one and give reviewers a good few days to review.

> ---
>  drivers/leds/Kconfig        |  11 ++++
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-max5970.c | 110 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 122 insertions(+)
>  create mode 100644 drivers/leds/leds-max5970.c

-- 
Lee Jones [李琼斯]
