Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF77FA0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjK0NWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjK0NWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:22:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305101A3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:22:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5ABC433C9;
        Mon, 27 Nov 2023 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701091350;
        bh=ctK+hzgQC+MSLrY/zdUFkWtbnB6zds12J32HcsBK/zc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KW4paEx2pGcLIuM4lm1CrNXkrBmaG29is/BxD8BmmmBf08D3aRpeIoHwj9Cx/p3nY
         yN3ued0C1c2b2nPPBj7GzF3TypElCj4WVr5cGj05Pf5tW3TEnX/yopo3t0nnL8fjjs
         LMJtrqatLKh9MQBU2fj9FxaQZ35X+1zJ2Kd1uExiDcp6SDdjIQlDsKkiENi407uHV4
         8OSxtmkavJ0zKHJkIW5N6bMYY+TC1Z9SLOrJ0+SaF1HIsI3JCpyYFueYc+gQjc4HGX
         BuBY01a1n5vZfHwOCmEaSjCUEqL8iqZn0GPVKED08Pl9FQiuEVZwpJHTBhSGikcguG
         ewtcHT030MBFA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alex Bee <knaerzche@gmail.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20230830133623.83075-2-knaerzche@gmail.com>
References: <20230830133623.83075-2-knaerzche@gmail.com>
Subject: Re: (subset) [PATCH v2 0/5] Add USB support for RK3128
Message-Id: <170109134730.42627.8256424679982843015.b4-ty@kernel.org>
Date:   Mon, 27 Nov 2023 18:52:27 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Aug 2023 15:36:19 +0200, Alex Bee wrote:
> While interestingly the dt-binding for the Innosilicon usb phy found in
> RK3128 SoC exists already and it is exposed in the SoC DT, it has never
> been added to the driver.
> This patch-set adds support for this early version of the phy and does
> some DT-fixups in order to make the 2-port host/otg phy and the respective
> controllers work.
> 
> [...]

Applied, thanks!

[1/5] phy: rockchip-inno-usb2: Split ID interrupt phy registers
      commit: 2fda59099462ee700e424ba3ac928d13ad6389a8
[2/5] phy: phy-rockchip-inno-usb2: Add RK3128 support
      commit: 62ff41017e147472b07de6125c3be82ce02a8dd7

Best regards,
-- 
~Vinod


