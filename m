Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F4480A605
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574030AbjLHOvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574056AbjLHOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8931219A1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51706C433BB;
        Fri,  8 Dec 2023 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047073;
        bh=sZGnGeqLpB1IxcKgVGkGof0R2a8lgrqRAyyzVhs+8U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tn8QxkVAlTqmxjTnSmv0OKh8GH+Q3HrAEPw9sAdcYdRBN3bIDB5sL0A7PYLLcYA1N
         aCXFsj4fEMeMjBadIXAWihd7nLXv2iLekTr2vDSLwLLO6uxoQ5Qcadm0YF7bpY8SUP
         attWJ0vtiwdV7cyBkOBFNDAjmdKZhOJydvWwx//gDClo8rYZB8afbMu74JX3XslX0x
         ZqngfzxqRSBwqvM3mC+lGiuPj4dUY4OZp+MS7URUkLJP11eMFFMq0A0nfcGslcCiAA
         2JHiCZqmRsQq6TNMqr0z5rIN923Vxt12B7srwYCGnwShsyLbGgK7eAQ/5otOipcmrF
         r1yBSoDZSQKYw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Alex Elder <elder@linaro.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: enable IPA on sm8650
Date:   Fri,  8 Dec 2023 06:55:21 -0800
Message-ID: <170204733636.342318.7110729892065912812.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201-topic-sm8650-upstream-ipa-v1-0-7e8cf7200cd2@linaro.org>
References: <20231201-topic-sm8650-upstream-ipa-v1-0-7e8cf7200cd2@linaro.org>
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


On Fri, 01 Dec 2023 14:50:40 +0100, Neil Armstrong wrote:
> Add the basic DTS information for supporting IPA on the Qualcomm
> SM8650 SoC.  Enable IPA on the SM8650 QRD platform; GSI firmware is
> loaded by the AP in this case.
> 
> Tested on SM8650 QRD:
> [    5.764240] ipa 3f40000.ipa: IPA driver initialized
> [    5.787438] ipa 3f40000.ipa: IPA driver setup completed successfully
> [    7.446693] ipa 3f40000.ipa: received modem starting event
> [    8.413152] ipa 3f40000.ipa: received modem running event
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm8650: add IPA information
      commit: 9fdddbd134a68843364c3e8c57fbdc5da2a7083d
[2/2] arm64: dts: qcom: sm8650-qrd: enable IPA
      commit: 83c054b913cf6accd4cb31cee51729b322bde7fb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
