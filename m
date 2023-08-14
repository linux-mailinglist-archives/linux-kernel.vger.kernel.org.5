Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB277B025
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjHNDZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjHNDZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76759E62;
        Sun, 13 Aug 2023 20:25:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1599F628D1;
        Mon, 14 Aug 2023 03:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3B4C433C9;
        Mon, 14 Aug 2023 03:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983512;
        bh=N87VD/T9i6yQ5D9QoLwauJg1HLr5Ku06R+qPOCjuUYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnaqOih3XMIXZ0JQ66+k5tEDabgANcg23HESkvEbdkc16S0T++p1V7ANXYNyBpqal
         6N5VjbPSccmM1ckfVPhjX9mblZS9jmNiqyCsifSvfVZDKZusj+W/GRgvXzbz6UyY35
         h1liGEwOLSN7qlIwobehZynbysMy6VdNgXbpWebXhQIC5DTd3TW8qTeB9JJnuzZYDa
         rgoRNbt2n4aI/nZnkWN9B5dTtEp8aVNtUbKDYWs1Gz7zChZvVCCsvXAqcPfDAl5rOq
         7j6bXXSsXZrjUz3K97QK2cTF3+YdH1DvbxLSbzrkKS5nRUcC+Z5eYm5Gcv001gakd3
         67wEhtWQACScg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>
Cc:     Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: Re: [PATCH V5 0/8] Update GCC clocks for QDU1000 and QRU1000 SoCs
Date:   Sun, 13 Aug 2023 20:27:41 -0700
Message-ID: <169198364317.2443702.6468719777793676141.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803105741.2292309-1-quic_imrashai@quicinc.com>
References: <20230803105741.2292309-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 03 Aug 2023 16:27:33 +0530, Imran Shaik wrote:
> Update GCC clocks and add support for GDSCs for QDU1000 and QRU1000 SoCs.
> 
> Changes since v4:
>  - Updated the commit text as per the review comments
>  - Split the gcc_ddrss_ecpri_gsi_clk and gcc_gpll1_out_even clock changes
> 
> Changes since v3:
>  - Split the gcc rcg ops changes as per the review comments
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
      commit: df873243b2398a082d34a006bebe0e0ed7538f5c
[2/8] clk: qcom: gcc-qdu1000: Fix gcc_pcie_0_pipe_clk_src clock handling
      commit: b311f5d3c4749259043a9a458a8db07915210142
[3/8] clk: qcom: gcc-qdu1000: Fix clkref clocks handling
      commit: 2524dae5cd453ca39e8ba1b95c2755a8a2d94059
[4/8] clk: qcom: gcc-qdu1000: Register gcc_gpll1_out_even clock
      commit: 06d71fa10f2e507444c6759328a6c19d38eab788
[5/8] clk: qcom: gcc-qdu1000: Add gcc_ddrss_ecpri_gsi_clk support
      commit: 089aad8c769ca0710a66a2adc3e11d94b027b5f7
[6/8] clk: qcom: gcc-qdu1000: Add support for GDSCs
      commit: 76346cf7089abd488fb3ad9753901b99baa3cafc
[7/8] clk: qcom: gcc-qdu1000: Update the SDCC clock RCG ops
      commit: baa316580013ca100c23c8e92ac713f69f19fb08
[8/8] clk: qcom: gcc-qdu1000: Update the RCGs ops
      commit: 1c16a7b794e15a2e843a1fbfd3ffaea46672f6e7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
