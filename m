Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616D377F3F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349863AbjHQJ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349480AbjHQJzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:55:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8605712C;
        Thu, 17 Aug 2023 02:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D70A61701;
        Thu, 17 Aug 2023 09:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8575FC433C8;
        Thu, 17 Aug 2023 09:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692266146;
        bh=Fh06Vul6kUtxm5v0Al+KBxIVTAQZE1h73BsYg77XvSI=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=MmkTMe92HkQ0gIn5FTvpvHdU84rFFSxkcdmdMMUsP2tbBr8uPxOePLHCmb+VGYCV4
         wIQNn7fODQQhTVYIsBtWnZHcEBZf4jjraQbpU59omdO+Uc33DTYoYLRUin29dEk17q
         U64rub7TPb296lPgei3QyD/qPrkilRd89rjtt61+1z/aRdwAwSmyOS+u7WBvhwlTiB
         zZjmL1t+fTpY8uM+TZLIndsmlineFkfGWzy0FoPn9X0Gi5DLdy5jG1X/WGs9IYqPZr
         90BKrI5DZSMELVFOV0PX5+zQW2/ugOgz1Y9nlLzJpxW9K1wVjDV7rK5S6X6MP2xAQj
         Fso+ZsvZmWNIg==
From:   Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        arnd@arndb.de, geert+renesas@glider.be, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com, quic_srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <cover.1691999761.git.quic_varada@quicinc.com>
References: <cover.1691999761.git.quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v8 0/5] Enable IPQ5332 USB2
Message-Id: <169226613917.81413.1200008047604336868.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 15:25:39 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2023 13:36:00 +0530, Varadarajan Narayanan wrote:
> This patch series adds the relevant phy and controller
> configurations for enabling USB2 on IPQ5332
> 
> v8:
> 	Driver:-
> 		Change commit subject and message per review comments
> 		Don't include of_platform.h
> 		Change struct initialization coding style
> 		GENMASK -> BIT for one of the defines
> v7:
> 	Binding:-
> 		Move 'compatible' to be the first entry
> 		In the example have 'usb-phy' instead of 'usb2-phy'
> 		Add 'Reviewed-by: Krzysztof Kozlowski'
> v6:
> 	Binding and dts:-
> 		Dropped the qcom,dwc3.yaml patch as it has been picked up for linux-next
> 		Add const to compatible, vdd-supply
> 		Move nodes per register address
> 	Driver:-
> 		Add vdd-supply
> 		Cleanup error paths in probe with dev_err_probe
> v5:
> 	Binding and dts:-
> 		Fix email id
> 		Removed 'Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>'
> 		as had to change bindings file to be able to use generic phy instead of
> 		usb-phy
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: phy: qcom,m31: Document qcom,m31 USB phy
      commit: b11f8acb937ed64841eeba22b0f0371ded58bef2
[2/5] phy: qcom: Introduce M31 USB PHY driver
      commit: 9bc2b3b35334aa2742ad3dc4219c001279a97998

Best regards,
-- 
~Vinod


