Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778617A7029
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjITCKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjITCKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:10:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F039F;
        Tue, 19 Sep 2023 19:09:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2F7C433CA;
        Wed, 20 Sep 2023 02:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695175796;
        bh=ahu76PmIf0loEOsIZvlQKEsmmgqXjKmIxSpJWKbM5kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzIImjapkUX1xV3F1Z7fIuHcoGbC5vzQV3q0uzns7Llxs50vsFBg+4mfY2eWNkK+3
         i3DuSHifgOkfX490MvhWLCK+lMQOu6KMwH+90RlDtmQwBifVVvztzmZetUFRFM7E9q
         SqlubYUNgEgbqJminV7xUWdPsnbVoSlOLrtY6o62yKWgyK/BfNdy+UBexcktz/sni4
         tdEHz9Nbi2Np8d5VudDzmZKLMN5ZV9Yo8dI7jPqfLHJJhyHpuA1E/gsOL0+zCEN33U
         5ewFbLBmvsh0t04gVCkBY1E8BJPRm1SPMuPvJzsGwuiIpUuetEcJP4hkPkEXUj4+kg
         tkdQxwrr0V74Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sboyd@kernel.org, luca.weiss@fairphone.com,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v9 0/7] Add Qualcomm PMIC TPCM support
Date:   Tue, 19 Sep 2023 19:13:56 -0700
Message-ID: <169517603993.822793.12743751382669071299.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230816115151.501736-1-bryan.odonoghue@linaro.org>
References: <20230816115151.501736-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Aug 2023 12:51:44 +0100, Bryan O'Donoghue wrote:
> V9:
> 
> - Reuses glink ports {} definitions and locations per Bjorn's request
> - Adds additional port @ 2 to 8250.dtsi as a result - Bjorn
> - Drops logic in previous patch
>   "dt-bindings: phy: qcom,sc7180-qmp-usb3-dp-phy: Add input and output ports"
>   No longer required
> - I've amended the names of the endpoints to match sc8280xp too - bod
> 
> [...]

Applied, thanks!

[2/7] arm64: dts: qcom: sm8250: Define ports for qmpphy orientation-switching
      commit: ea96b90a58cf5d2e91ac177f081118ff26b85c1d
[3/7] arm64: dts: qcom: pm8150b: Add a TCPM description
      commit: 5a0539515cbfad30b3e08a00004ed0c86136add5
[4/7] arm64: dts: qcom: qrb5165-rb5: Switch on Type-C VBUS boost
      commit: c627d7337aae4d83b4db621fdb9e8f638056dcee
[5/7] arm64: dts: qcom: qrb5165-rb5: Switch on basic TCPM
      commit: 5b1b6da9d39d515395d85dc678ddac7ff1689438
[6/7] arm64: dts: qcom: qrb5165-rb5: Switch on TCPM usb-role-switching for usb_1
      commit: 25defdca4d902b338c05bc01a1de1064a6d3b7f3
[7/7] arm64: dts: qcom: qrb5165-rb5: Switch on TCPM orientation-switch for usb_1_qmpphy
      commit: 45219a6b9497cb7713dd2bc221248ee1a7e9bb3d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
