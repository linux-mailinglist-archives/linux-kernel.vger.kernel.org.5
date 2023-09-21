Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607B07AA318
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjIUVrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjIUVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:46:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01826E8C;
        Thu, 21 Sep 2023 10:22:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF20FC4E685;
        Thu, 21 Sep 2023 13:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695303788;
        bh=EWdJvIwF6uv0RWl2Gt/yW75HzMTZ/s3XRzzcEYnfV7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QH0o15QG+AubVg6W1pk+o3mUkrKs+CPmKCMeHbIP1NMLSk+MCAMvzuby9ymnvm0l+
         kcRFHkUzLgmT18elmBM8npwxFYWov8LWYK4xwcb36u78XXIktx9JgCpO/gFilF26P+
         sJYdwerntMLkuNJoHidrfuR/Dtf9VoaY6DySkwWlTgCLFS62/iUVO/77lyxW0awSjh
         e+Na9Fgm4E0lIFMtDuxLp4NuelMx7q3NKWawVBceg+HYdNsMGU0DhVLNJWq9raAmg2
         uTfklCCHQXvDvD8Gv9HSfn8SKqdxhGrbExHxWVea06k7LponKAdd0t6s+MVBcxKP9q
         k7+r35VqwpAZw==
Date:   Thu, 21 Sep 2023 15:43:05 +0200
From:   Vinod Koul <vkoul@kernel.org>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 08/31] phy: rockchip-inno-usb2: Split ID interrupt phy
 registers
Message-ID: <ZQxIaU6ITbTGBkVC@matsya>
References: <20230829171647.187787-1-knaerzche@gmail.com>
 <20230829171647.187787-9-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829171647.187787-9-knaerzche@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-23, 19:16, Alex Bee wrote:
> Commit 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ") added ID
> detection interrupt registers. However the current implementation assumes
> that falling and rising edge interrupt are always enabled in registers
> spaning over subsequent bits.
> That is not the case for RK312x's version of the phy and this
> implementation can't be used as-is, since there are bits with different
> purpose in between.
> 
> This splits up the register definitions for id_det_en, id_det_en and
> id_det_clr registers in rising and falling edge variants.
> It's required as preparation to support RK312x's Innosilicon usb2 phy as
> well in this driver and matches pretty much to what the vendor does, so I'm
> not expecting issues for other SoCs with that change.

This fails to apply for phy/next

-- 
~Vinod
