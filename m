Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352B07A996C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjIUSOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjIUSNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:13:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C97186801;
        Thu, 21 Sep 2023 10:37:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E36C4E75B;
        Thu, 21 Sep 2023 14:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306560;
        bh=3KLcy3EQJ1puV3dzsk0w22+qc/0ywWz1dFJWwZrszw0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ZgN2pHpaTAJywaqK3L2xHTEt38W3XyjPeK6GHDRQUF05hLwTBcXgmV4+tnzV8nRn4
         sgUxL7hA0SkOSJEh786iIP01Da9ywW645pkyx9mS2uEPNHNYAqFJ7j1godAfJh5U5p
         EM5WqjyCeOPb0wuvNrbftYywu72dh3CXaD+EoXVccOOfcQsnVi0AD9GjoSzirNX7nO
         RoDIOT0Fvp1XA9D2MVhiIaphWcKxUkaZboNg9emaGKCYHG4RtGExTbxPkGKM8M3gEp
         tJNM4GNgAYKLCcCvVDovR+WhqCNAelh6sVaOxA3D4BLh8OYDO+N8nU2DXfNvrWHOt7
         8oZc8PsnCmtiw==
From:   Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        kishon@kernel.org, arnd@arndb.de, geert+renesas@glider.be,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <cover.1693468292.git.quic_varada@quicinc.com>
References: <cover.1693468292.git.quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v12 0/4] Enable IPQ5332 USB2
Message-Id: <169530655544.106263.15705008242028949711.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 16:29:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Aug 2023 14:47:42 +0530, Varadarajan Narayanan wrote:
> This patch series adds the relevant phy and controller
> DT configurations for enabling USB2 on IPQ5332
> 
> v12:
> 	DTS:	usb2_0_dwc -> usb_dwc
> v11:
> 	Driver: Rebased to accommodate https://lore.kernel.org/linux-arm-msm/20230824091345.1072650-1-yangyingliang@huawei.com/
> 	DTS:	Sort nodes in alphanumeric order
> v10:
> 	Driver: Restore register success print per Dmitry's comment
> 	DTS:	usb@8a00000 -> usb@8af8800
> 		regulator_s0500 -> regulator-s0500
> v9:
> 	Driver: Since the driver code has been picked up for merge,
> 		(https://lore.kernel.org/linux-arm-msm/169226613917.81413.1200008047604336868.b4-ty@kernel.org/)
> 		adding the coding style fixes alone in this patch.
> 
> [...]

Applied, thanks!

[1/4] phy: qcom: m31: Fix indentation issues
      commit: 90f7af497a78bf920a63119f2c7e9dcd98d028fe

Best regards,
-- 
~Vinod


