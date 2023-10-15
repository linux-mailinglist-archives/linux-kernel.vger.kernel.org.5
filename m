Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB227C9BB7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 23:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjJOVEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 17:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJOVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 17:04:04 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AD4B7;
        Sun, 15 Oct 2023 14:04:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4275240003;
        Sun, 15 Oct 2023 21:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697403840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1OtzKS+ZE0gLEodAJqaYLXSJ4vGUZAq2NAwhWxZ174o=;
        b=ENcQum01ypQhY9RbkdZ1iXD3eNEVGNB86Oeq4O2bM+Cckw0Rl8NpNJ2hf84agdFLShsrRO
        BDxq4Sbm0RdsPHYZQJpH+Xu4tvEHesnj44yRw/uHoAdW+WrwF+CG9lXGUeo06IsdQ2dejR
        279gQxszUBgkdkaj7zApbUn0v39QPUYfo1RqW1ukRKNpSvNGS1nRS8edwZdzFmbWlY6MB1
        l92af7LUG8leVT5zb/KhWjVrxD5K6JRIXYkgRgL33C/BOKa7E5nXVfoNGFQVUY8kBgj9aH
        kqH2GqM/9K+FvndE0uu5DV3ViVocsfxqRmR5XP2LFRkZIhtJ3iI7SWQCg4PpEg==
Date:   Sun, 15 Oct 2023 23:03:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: omap: Use device_get_match_data()
Message-ID: <169740375018.169509.5893287269026220454.b4-ty@bootlin.com>
References: <20231009211356.3242037-12-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009211356.3242037-12-robh@kernel.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 09 Oct 2023 16:13:42 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Applied, thanks!

[1/1] rtc: omap: Use device_get_match_data()
      commit: 3c8bdc20a44fd0126e331e0623e7daf00d186135

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
