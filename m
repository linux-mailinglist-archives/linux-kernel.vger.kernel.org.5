Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393D77F6CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344624AbjKXHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXHhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:37:51 -0500
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5772BD72
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:37:56 -0800 (PST)
Message-ID: <a2a9b649-04fc-4e75-94b0-d5df137a833a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700811473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjMI1MPtpwadsFtx6psItLhcfNdYPfIwh32yRRxk1iA=;
        b=aZfn3DXEU/+dBvXPclrLyl6Hx8KjxjmSAFh8Y3ztc1cJZArVhIbvUeG8i/ul499cTF2lhc
        g8mZK19ZZlXa1FUkB35IVN794seOOPWr/j+CWkRaHBkJ6sbKJeH7ruG8GJqPt6r95+PYdM
        vZjKD1ktjKkWyCLe1my5XGaEg6dC5nA=
Date:   Fri, 24 Nov 2023 15:37:45 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5 08/20] drivers/gpu/drm/loongson/lsdc_i2c.c: remove
 I2C_CLASS_DDC support
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>, linux-i2c@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20231123094040.592-1-hkallweit1@gmail.com>
 <20231123094040.592-9-hkallweit1@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20231123094040.592-9-hkallweit1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/11/23 17:40, Heiner Kallweit wrote:
> After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
> olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
> Class-based device auto-detection is a legacy mechanism and shouldn't
> be used in new code. So we can remove this class completely now.
>
> Preferably this series should be applied via the i2c tree.
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>

Thanks.

