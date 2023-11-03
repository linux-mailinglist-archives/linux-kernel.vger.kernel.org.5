Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131247E0C60
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjKCXmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjKCXl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:41:58 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30F1D48
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:41:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C586240002;
        Fri,  3 Nov 2023 23:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699054908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=01UalbeeXeLylUyRzF/vSpZA0gSYvuxFA9cB6+h3P1Q=;
        b=l7vr27CXDc41xs4jbHLNnd0VYqkRE7A5NvcwQnO7NZjSQL/5wzEIKxItB345z97S+G6gfM
        FHyVvTMaPVFcBoNmuWxZRCtzwWhoinbvoSLoy1ZHYOMG73D4sRSkGsbSkAd5Tj5zqhLnpH
        6yj9GT1i9A2yOCqNw1TbFWIpZ9SoNb+13KBmx78zI4tgm68dHzOABq3ZoKwax1ZR/uDxPA
        I00zWwShBj5+WAYLxSSSt+LLItXNFFv2i0vhqH94EN8TxWIuGOQqb3RflwY0UwEEP+/mjh
        Oe2CoBFzcRUMnyVu14VoBRfE5Dy8v2GnkakgOCQeKE5I7ACkgawj0aFCCOXWrg==
Date:   Sat, 4 Nov 2023 00:41:47 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     BMC-SW@aspeedtech.com
Subject: Re: [PATCH v1] i3c/master/mipi-i3c-hci: Fix a kernel panic for
 accessing DAT_data.
Message-ID: <169905489155.439104.1007504050351939428.b4-ty@bootlin.com>
References: <20231023080237.560936-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023080237.560936-1-billy_tsai@aspeedtech.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Oct 2023 16:02:37 +0800, Billy Tsai wrote:
> The `i3c_master_bus_init` function may attach the I2C devices before the
> I3C bus initialization. In this flow, the DAT `alloc_entry`` will be used
> before the DAT `init`. Additionally, if the `i3c_master_bus_init` fails,
> the DAT `cleanup` will execute before the device is detached, which will
> execue DAT `free_entry` function. The above scenario can cause the driver
> to use DAT_data when it is NULL.
> 
> [...]

Applied, thanks!

[1/1] i3c/master/mipi-i3c-hci: Fix a kernel panic for accessing DAT_data.
      commit: b53e9758a31c683fc8615df930262192ed5f034b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
