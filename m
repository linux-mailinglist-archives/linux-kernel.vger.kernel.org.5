Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D0A8020C5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjLCEvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjLCEvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:51:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970E5116
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4F5C433CB;
        Sun,  3 Dec 2023 04:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579108;
        bh=271tYevWkSetGdYCuU7C59CAuTV9QQWyrcu6WcOI7sY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bOihLPmpZUs0+BN+nBWH2ERX+mNlYTCuvJCuwGrnMOvqxsRMAgXi6VIqAMcIp+4rG
         rigMaqkWXjNm6XaudfArzUkq2g1fRQEmqyK4CCmF9hQAVgseYZv85oEW2DcrhEzfbK
         9Mxwkk8e2CsrRb6TbPaJVGlTAT4PsWYcumZu/ExmhdlsOZ/qIFZ01U5F/GEKeAv03t
         kNH5EHcAETCWV+bnYAHEv4A4ZYAWurGu6fTk9n6LS/BhzHwX9DOz6cdDV9MkGx2fS3
         Z0zaVVTnOJ1aglJv0iZMYPf+UM1r05mvv6BPfOVyNHDuX0J/hamc6dWI+rfyHea+40
         dOLqeVjScKvrw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [RESEND PATCH 1/3] ARM: dts: qcom: sdx65: correct PCIe EP phy-names
Date:   Sat,  2 Dec 2023 20:54:37 -0800
Message-ID: <170157925790.1717511.17259915404588781563.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924183103.49487-1-krzysztof.kozlowski@linaro.org>
References: <20230924183103.49487-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 24 Sep 2023 20:31:01 +0200, Krzysztof Kozlowski wrote:
> Qualcomm PCIe endpoint bindings expect phy-names to be "pciephy":
> 
>   arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dtb: pcie-ep@1c00000: phy-names:0: 'pciephy' was expected
> 
> 

Applied, thanks!

[1/3] ARM: dts: qcom: sdx65: correct PCIe EP phy-names
      commit: 94da379dba88c4cdd562bad21c9ba5656e5ed5df
[2/3] ARM: dts: qcom: sdx65: add missing GCC clocks
      commit: f64f653df2ef713359178c731bc8f89ff54014b1
[3/3] ARM: dts: qcom: sdx65: correct SPMI node name
      commit: a900ad783f507cb396e402827052e70c0c565ae9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
