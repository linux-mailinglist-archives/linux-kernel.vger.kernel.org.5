Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973708099CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573174AbjLHCyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjLHCxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB6C172A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F4EC433CD;
        Fri,  8 Dec 2023 02:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004015;
        bh=nM8BSXEj29maitOiRsn/Int4RvFo7oixuKmT5mrbqIc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ju0QhnKbBXXqMvEIDZNypjszSBKtKVBqwYQMuE5vqPYP5Hae7GmS+2sxVhZcdzTqb
         p4Kdn/IV1DiLd7bv0/6XmUXF3B63XnFrDcsf6Zp/XgqpR9aHvC/C2QoBj932l5vvIV
         95WtMCuaerCU+4PT3sSYX+3Z9bHn3ucaroAUDixvOYm3TsLaTOJDXz2j8lWagF7Z5j
         yaQH+fOUbPxwtkAfklIwoO+gjNbHLMRFl47zCsSPdoUVBV2XfygXkQSoS4qGKUS0KG
         aksYbNKew06FI6EtjUVXlxYlHrAYhCMYsG3cYvpLOssaN3nC1qK5nB39OOot+nvhoO
         FuNrCyqoHbg8A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: drop duplicated PCI iommus property
Date:   Thu,  7 Dec 2023 18:57:39 -0800
Message-ID: <170200426902.2871025.4888269570677484292.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112184430.3495-1-krzysztof.kozlowski@linaro.org>
References: <20231112184430.3495-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 12 Nov 2023 19:44:30 +0100, Krzysztof Kozlowski wrote:
> The IOMMUs for PCI controller on SC8180x are defined in iommu-map, so
> drop duplicared iommus:
> 
>   sc8180x-lenovo-flex-5g.dtb: pci@1c08000: Unevaluated properties are not allowed ('iommus' was unexpected)
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8180x: drop duplicated PCI iommus property
      commit: 2c21e5a84524381977b4744e906fb31862ac5809

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
