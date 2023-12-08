Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2978099C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573144AbjLHCyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjLHCxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D25F172E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE80EC433CC;
        Fri,  8 Dec 2023 02:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004011;
        bh=Z6n/+nID4ewJlze65BwH1SFveUAH/ABWb0Y50HV+A2w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EbFZ0vIaSDy9lQM7OP4YuzM6iVIRvsicbqjek6zcQ9ZColJQX41cfR/Odo43nP3iL
         qSK5tSbzZpqC7ILGEY+tql1wHicM0n7VXYYbglphFR6UY6BIBSs8MDELLnDlPrl/xa
         yVPG1I7iRDIoIxPmBsNnGkNOh2DaCJ5wjBN7t5F9kJ9ZwIZwi+QbBi96DZjhPZ7wfK
         +3KDIOp2SbA6oxANGmqeUY//MqeDdJozKklc8XdEBinhiOIYJU0KbhcCbZLQfr4K+4
         9mcYkE6Gn/MZ4XvI/oOermlFCMhWiPwJTWNNfmkmQdNitNGSjXmM0CIQrriaPte/gp
         v/H6gjgF+bBCA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/3] arm64: dts: qcom: sc8180x-primus: drop sound-dai-cells from eDisplayPort
Date:   Thu,  7 Dec 2023 18:57:35 -0800
Message-ID: <170200426916.2871025.9487099350234282419.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107103540.27353-1-krzysztof.kozlowski@linaro.org>
References: <20231107103540.27353-1-krzysztof.kozlowski@linaro.org>
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


On Tue, 07 Nov 2023 11:35:38 +0100, Krzysztof Kozlowski wrote:
> Qualcomm MDSS Embedded DisplayPort bindings do not allow
> sound-dai-cells:
> 
>   sc8180x-primus.dtb: displayport-controller@ae9a000: #sound-dai-cells: False schema does not allow [[0]]
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sc8180x-primus: drop sound-dai-cells from eDisplayPort
      commit: 5a71b4719be718ffd99dfc08a457cefac4070102
[2/3] arm64: dts: qcom: sc8280xp-x13s: drop sound-dai-cells from eDisplayPort
      commit: 7613e707612e50fb73bba3e9ae1b281f36eff24b
[3/3] arm64: dts: qcom: sm8350: move DPU opp-table to its node
      commit: fabfc74f1b3ab1801d54cf32d8e44a893340be7f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
