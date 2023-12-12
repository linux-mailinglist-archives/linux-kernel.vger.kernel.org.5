Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67C80F455
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346653AbjLLRVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346670AbjLLRVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:21:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB698F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:21:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5E0C433C8;
        Tue, 12 Dec 2023 17:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401681;
        bh=xLkBkixDQKbXEltygIuDMWgT2+tKHTyJguNt0oCZ1Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ni5IZcrivfNznvASlMU0Q2n6Kp8hvI9+Q6CHG54W2Vku+AoedZxkjuqwdIEV7z/Bp
         rs89sLvn3o4hxHoeYW/sw1Znd8HQaLkOTQUUquwY8nhU4nTgiZOFLrjnKitcinbZ4P
         zcG41Qx/178fc5iXLGQEQqJn4g1xe0pXetJHH8xmNMihtZPi6mr/MeiBqjPEzuO9ji
         OVxegVdQpX9pM3Pij4Rr7tgC3yKfL4PW82A5jANb11ao9Lzd+bMn1vzv08R7ndAPgi
         0eq8fau88PzsfwBn1h4Wx4HXiyFI0I3rK+W1ZI1dT5Eib3+kUAdFHQlAGQWz8u/uyi
         5rro2tioVaSlQ==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v2 0/6] SM8450 / SM8550 Adreno
Date:   Tue, 12 Dec 2023 17:20:54 +0000
Message-Id: <170238387694.3096344.13849459949323517316.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
References: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
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

On Mon, 04 Dec 2023 13:55:19 +0100, Konrad Dybcio wrote:
> Following the merging of related bindings, driver and mesa changes, enable
> the GPU on both of these platforms.
> 
> P1 for Will/iommu, rest for qcom
> 
> 

Applied SMMU bindings change to will (for-joerg/arm-smmu/bindings), thanks!

[1/6] dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU
      https://git.kernel.org/will/c/4fff78dc2490
Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
