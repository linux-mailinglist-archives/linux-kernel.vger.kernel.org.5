Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254D877FC61
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352732AbjHQQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353793AbjHQQyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BA72D7D;
        Thu, 17 Aug 2023 09:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09551650F4;
        Thu, 17 Aug 2023 16:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFCFC433C9;
        Thu, 17 Aug 2023 16:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692291275;
        bh=RmSAB4XZQa5AqTnuFBlgXIUu2P/Oxf/lSy2CeI8+irA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j22dLx0eM4jTeMXgIWvqDIHjQHfM3pOBE9DJJ6ZA5bgQTh8/4D5E/ITmRShU3jRa1
         vmUYPAjPgI/XJ3T/xMucWw55PmyT4tXJsGFKoxI8+gHaaFWF6mj/NhJdHFwG1JaIma
         7/ZynfBlCQuoFs207XN+Bw5cw2g6YZWERpzs/fg9v+Ob5gtAnTuznkhFa5KyQsI/rt
         xWHTIeFofCmJe7qvzc9oliHZ5AEgOsQz/ZRKtWCDIDhseAoYXiUnKoE/mJ42/mDaXd
         WhX/B4eizWnVm4RFjPI27fRq0YQ5JEHc2/aJ/8VjjKyG45MNWi+XpY6a9I/LD2DhDT
         QgfkOQc82PvKQ==
Date:   Thu, 17 Aug 2023 17:54:30 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>
Cc:     "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "Leal (Long) Li" <Leal.Li@monolithicpower.com>,
        "wyx137120466@gmail.com" <wyx137120466@gmail.com>
Subject: Re: [PATCH 1/2] leds: Add driver for mp3326
Message-ID: <20230817165430.GG986605@google.com>
References: <97598d1812a7430d8f11682038ecf6dd@monolithicpower.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97598d1812a7430d8f11682038ecf6dd@monolithicpower.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023, Yuxi (Yuxi) Wang wrote:

> This patch adds a led
>  driver for the mp3326 which is from Monolithic Power Systems, Inc.
> 
> Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
> ---
>  drivers/leds/Kconfig       |   7 +
>  drivers/leds/Makefile      |   1 +
>  drivers/leds/leds-mp3326.c | 836 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 844 insertions(+)
>  create mode 100644 drivers/leds/leds-mp3326.c

Where is patch 2/2?  Is it related to this one?

Please sent all patches to all people, so we can see what's happening.

-- 
Lee Jones [李琼斯]
