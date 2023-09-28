Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9B97B100F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjI1AaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjI1AaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:30:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D40511F;
        Wed, 27 Sep 2023 17:30:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D7BC433C8;
        Thu, 28 Sep 2023 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695861007;
        bh=0k+eI+Gw38M0qYVrDonrZDI7ENLrygBXyK4wdkKYoIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJKNQ9QzxA6g5H9FkV7CK1+VWtwCNfWftUclPa+Lsffv2aA+qnAcP8VKZUkIe36+Q
         QowciZzooIDr/utrZc5FWRKV+79gbZUStIqGFGcUrFIviU8A58lLrFEUfkcdKReNCT
         9DYLWkDaW/FiFb/D4Wy0NeS/AmOOD9BrCZkgxOVOpM+jpR17EkJtblTHpjWYX7PYsE
         c1KIxhNmSc7Rb/NR1QVX14pzi1ZXeM2KKnPOnrhX/gKkGhGTPoXNZBLJ7zZ82bF2xt
         6lO3oR7eN2O0of7YJMTDIvMUAFwNpuho7OVhgUnG4tBhxRkRpoeBkTqSpCb7U8ypaN
         P1ObCCVXRnGVA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: apq8016-sbc: Add missing ADV7533 regulators
Date:   Wed, 27 Sep 2023 17:34:12 -0700
Message-ID: <169586125031.1226038.4446511866663817791.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230922-db410c-adv7533-regulators-v1-1-68aba71e529b@gerhold.net>
References: <20230922-db410c-adv7533-regulators-v1-1-68aba71e529b@gerhold.net>
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


On Fri, 22 Sep 2023 12:49:55 +0200, Stephan Gerhold wrote:
> Add the missing regulator supplies to the ADV7533 HDMI bridge to fix
> the following dtbs_check warnings. They are all also supplied by
> pm8916_l6 so there is no functional difference.
> 
> apq8016-sbc.dtb: bridge@39: 'dvdd-supply' is a required property
> apq8016-sbc.dtb: bridge@39: 'pvdd-supply' is a required property
> apq8016-sbc.dtb: bridge@39: 'a2vdd-supply' is a required property
>         from schema display/bridge/adi,adv7533.yaml
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: apq8016-sbc: Add missing ADV7533 regulators
      commit: 33e9032a1875bb1aee3c68a4540f5a577ff44130

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
