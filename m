Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321A37F15F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjKTOqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjKTOqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:46:46 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444E3C1;
        Mon, 20 Nov 2023 06:46:40 -0800 (PST)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r55Xp-00089h-Fo; Mon, 20 Nov 2023 15:46:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Bee <knaerzche@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH v3 1/5] phy: rockchip-inno-usb2: Split ID interrupt phy registers
Date:   Mon, 20 Nov 2023 15:46:36 +0100
Message-ID: <3530941.iIbC2pHGDl@phil>
In-Reply-To: <20231119121340.109025-2-knaerzche@gmail.com>
References: <20231119121340.109025-1-knaerzche@gmail.com>
 <20231119121340.109025-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 19. November 2023, 13:13:36 CET schrieb Alex Bee:
> Commit 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ") added ID
> detection interrupt registers. However the current implementation assumes
> that falling and rising edge interrupt are always enabled in registers
> spanning over subsequent bits.
> That is not the case for RK3128's version of the phy and this
> implementation can't be used as-is, since there are bits with different
> purpose in between.
> 
> This splits up the register definitions for id_det_en, id_det_en and
> id_det_clr registers in rising and falling edge variants.
> It's required as preparation to support RK3128's Innosilicon usb2 phy as
> well in this driver and matches pretty much to what the vendor does, so I'm
> not expecting issues for other SoCs with that change.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


