Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6B754A61
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGORGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGORGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325AFB5;
        Sat, 15 Jul 2023 10:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD5C60BE9;
        Sat, 15 Jul 2023 17:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87225C433C7;
        Sat, 15 Jul 2023 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689440771;
        bh=FRKLC6Y48KPvzIpgRiRkf6BoysdzX77ksSV9Le/w/no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzZc96rNv6jwf5SbCygHdmBX7M5mvGu+qos+F19nf3aRR3p2jTmMp39BoAfXheS9+
         8GaZJsrZDtSKo2uexPagQA6fFQzFQDSc2PYEn+Vr+YXDlVjEy9+vqiN6XjQJtwbGjr
         g3lTowIY0QlDneqcwbYMNdTs88rQOI3p7bscBbXLaOn+18KYttNEgc7hwe20j0WmcU
         K2CJTmzGOKPHzpD+PCPg5LbGrGn/SjbQi4DO0AGDJnyPc3x1at6vTZW+81WslesTHg
         X0JbrsLXPYUBBVY945Tw9QjuOtOmZkg25+/jLZ4VGW8UUSgGIKu2QBD0CUVK4D3Rsm
         V4ECPvWZhMpcQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: Explicitly include correct DT includes
Date:   Sat, 15 Jul 2023 10:09:37 -0700
Message-ID: <168944095053.1619705.12922488299155507753.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714175142.4067795-1-robh@kernel.org>
References: <20230714175142.4067795-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 11:51:41 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: Explicitly include correct DT includes
      commit: 6484be9dd109bded43953ae7883bd69b5d841a0b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
