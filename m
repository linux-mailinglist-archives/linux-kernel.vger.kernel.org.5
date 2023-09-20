Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C37A8C15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjITSyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjITSyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:54:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF62C6;
        Wed, 20 Sep 2023 11:54:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26676C433C9;
        Wed, 20 Sep 2023 18:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695236054;
        bh=otb5DM/4dhf30T5dFnYMnw7MyuNEWEkpWHoB3snPXyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhubmkO7L0v45tnu09+stzCUT/fNV/OtFtzPV8j8YSjueRocNpa4Y3ESgPVAOXvOb
         1XOf05kQpaHXhFl35oTfA4t7OSxaZbp1AoFT9CdbISs4nE7qFCOe2egbldrJATe6aA
         WODXdTYMuURkoptVMo/Wz32NwkD0woOBrjK4V5uV8INwzP572JZ5b6fbkfyCnZqByb
         YJqe01YJbHtGa1IE2uCsWmtnsaCCYPXm6D4r4BmDklrmvyVjl5G3nRsX3+gAxMSyIp
         XSZj2zQLjSq8mPfS5ADNfbP7DkEEVL1N65qkwvM94O83yU6uvv+wcDW/hOBW6a/Cbn
         zvZ6c8BAuqPHQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 0/7] Initial support for the Fairphone 5 smartphone
Date:   Wed, 20 Sep 2023 11:58:20 -0700
Message-ID: <169523629862.3360741.11240206637939402551.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
References: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
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


On Tue, 19 Sep 2023 14:45:54 +0200, Luca Weiss wrote:
> Add support to boot up mainline kernel on the QCM6490-based Fairphone 5
> smartphone.
> 
> These patches only cover a part of the functionality brought up on
> mainline so far, with the rest needing larger dts and driver changes or
> depend on patches that are not yet merged. I will work on sending those
> once these base patches here have settled.
> 
> [...]

Applied, thanks!

[1/7] arm64: dts: qcom: sc7280: Mark some nodes as 'reserved'
      commit: 6da24ba932082bae110feb917a64bb54637fa7c0
[3/7] arm64: dts: qcom: pm7250b: make SID configurable
      commit: 8e2d56f64572e0432c355093a7601bde29677490
[4/7] arm64: dts: qcom: pm8350c: Add flash led node
      commit: bfd4412a023b2a3a2f858f2ffc13705aaeef5737
[6/7] dt-bindings: arm: qcom: Add QCM6490 Fairphone 5
      commit: 4b1a16d776b474345b12f834de1fd42bca226d90
[7/7] arm64: dts: qcom: qcm6490: Add device-tree for Fairphone 5
      commit: eee9602ad6498eee9ddab1b7eb6aede288f0b934

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
