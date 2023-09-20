Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF97A8A25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjITRKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjITRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D21EA;
        Wed, 20 Sep 2023 10:10:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385E9C43391;
        Wed, 20 Sep 2023 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229814;
        bh=icMbnMCivl6XtizPdU2hl9OASrROLgB1ExFgzceYpjg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TS1dRJyZyFqltcyF1L7xdY8GzkmNouhXktii5ZZwhBj5YbFcEBoPhsnwloMliE9tp
         Jg3/ZDFTd14IeqzpjSqSL0P7+0J0wYofbWmKXmyhFYhwvmD+ilpVNRD9+VFj832q4e
         InaYQR563neRMSQF/R9+IolvH98DffCVT/HL7cAss/Ix42Z6gSKwwAQ8cibL8HAO/q
         3XQqtszlIMNgLO4SkessgQdEhsWASVMegodh+RdzLXhmJrLmZSzfbA4cH8NALU1kNN
         bAC+VJNJkFEzemuWl6WpMiOQcoVhYxMJyaXRwTHAnD6lFXptn8pKquP6KBJhrkiFSc
         RbgZLW0bNsT8Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/3] ARM: dts: qcom: drop incorrect cell-index from SPMI
Date:   Wed, 20 Sep 2023 10:14:02 -0700
Message-ID: <169523004943.2665018.5938387194105724011.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827122842.63741-1-krzysztof.kozlowski@linaro.org>
References: <20230827122842.63741-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 27 Aug 2023 14:28:40 +0200, Krzysztof Kozlowski wrote:
> The SPMI controller (PMIC Arbiter) does not use nor allow 'cell-index'
> property:
> 
>   qcom-sdx55-mtp.dtb: spmi@c440000: Unevaluated properties are not allowed ('cell-index' was unexpected)
> 
> 

Applied, thanks!

[1/3] ARM: dts: qcom: drop incorrect cell-index from SPMI
      commit: 340ed74de508e5d79599b67553ee1e8e8239e0d1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
