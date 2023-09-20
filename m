Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A637B7A8A42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjITRLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbjITRKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63058129;
        Wed, 20 Sep 2023 10:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5036EC433CA;
        Wed, 20 Sep 2023 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229823;
        bh=u5gZSSDuo6bC0Rf1ntYLT4MADeEqbRtBchnHNiD3jso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGdc8wpw46wpbq+2K6KBvvl8w2hOQ3WF/XPGskKzYGMC+eQo44HkOSLF8SAk+/r0l
         avuH4AdjzwfUpQQwVtWwfZWnlIFEKaUvAwADmpu/U88n49pMBLmw283B16pc38J4ze
         WJOcYdTRimE2xzXfS2WzZ5ttY9ffSv2XI5x5sfvFMGUar428CKbWILAmeLnPkAutCx
         Wg9Ewa7ViWtFq06DZYfwyV//Ha7wpqda9T6jk7zQfJ9IyIWNfomF1BgUVFZXpCMBTV
         dCkE/nrAyEAolm4sCalMNnrk14CNLpL4gzNBGAw+jrybM7U0xEW3MbpY21K6DYkGnt
         bwsKq+F+xb/0Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org, bryan.odonoghue@linaro.org,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] soc: qcom: llcc: Add support for QDU1000/QRU1000
Date:   Wed, 20 Sep 2023 10:14:09 -0700
Message-ID: <169523004944.2665018.13586229919901477277.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
References: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Aug 2023 16:26:48 +0530, Komal Bajaj wrote:
> This patch series does the following -
>  * Refactor LLCC driver to support multiple configuration
>  * Add stub function for nvmem_cell_read_u8
>  * Add support for multi channel DDR configuration in LLCC
>  * Add LLCC support for the Qualcomm QDU1000 and QRU1000 SoCs
> 
> Changes in v8 -
>  - Removed macro DEF_NUM_CFG as suggested by Bryan.
>  - Rebased on top of linux-next/master.
>  - Link to v7: https://lore.kernel.org/all/20230810061140.15608-1-quic_kbajaj@quicinc.com/
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: cache: qcom,llcc: Add LLCC compatible for QDU1000/QRU1000
      commit: 8e2506d0123149a7b7846fbabbf4295b6005faf4
[2/6] soc: qcom: llcc: Refactor llcc driver to support multiple configuration
      commit: 16fa93112f26a7a151f3d86a2a9223c564f6e3bf
[3/6] nvmem: core: Add stub for nvmem_cell_read_u8
      commit: 54e1f99d91405417b3ddb6050cfba82733c3aa41
[4/6] soc: qcom: Add LLCC support for multi channel DDR
      commit: a78502a4b2201235d93b04ac2902e01e32588bd5
[5/6] soc: qcom: llcc: Updating the macro name
      commit: 0bc76be64e80b15b975345b6957a87a1893c34f2
[6/6] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support
      commit: db1e57928766966cd542e59789125968ac29b9da

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
