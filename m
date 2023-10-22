Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1322B7D23B9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 17:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjJVPqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjJVPqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:46:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBA319E;
        Sun, 22 Oct 2023 08:46:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183E0C433C8;
        Sun, 22 Oct 2023 15:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989580;
        bh=Mm+VlhFqSLI6KYeFntJha6+OeayGdA2ZEu/N8on3v04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AtClg8Njv9OReqyC1fLHgISvW9cIsaqi9fwdkE6oaXgjBIgrkzQ9LIvY8mC9xLBUp
         rFbJYiNp6hus5tGmMPR+/oVA4mdxANsymu/5zeQVh04HcZ5UCRzhFkdJ8Ovd6Fwtja
         zjJ0BPT2ThrcFn3vWLz27FC1Z+6Ln1GWMNWu7JQWvtErhLmpgjt4wynaN4/ztErK3R
         /Usr2bOfG//xoRB2p+8S5ER3nECPDvzdXbm3dsSdpanCrH5aBfvXd0eaCnMR8M/BXw
         W5r7aF9llaA9tp8KpGEAL/AlsWkX3VwE2qI+JwUiA6dc7qIrRe3+NYxkL4cITYKupP
         IC2h383wdr5uQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        "J.R. Divya Antony" <d.antony.jr@gmail.com>,
        Nikita Travkin <nikita@trvn.ru>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Markuss Broks <markuss.broks@gmail.com>
Subject: Re: [PATCH v2 00/14] arm64: dts: qcom: msm8916/39: Enable sound and modem with QDSP6
Date:   Sun, 22 Oct 2023 08:50:26 -0700
Message-ID: <169798982349.271027.9210121677851263066.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003-msm8916-modem-v2-0-61b684be55c0@gerhold.net>
References: <20231003-msm8916-modem-v2-0-61b684be55c0@gerhold.net>
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


On Tue, 03 Oct 2023 15:18:18 +0200, Stephan Gerhold wrote:
> Enable sound and modem on most of the MSM8916/MSM8939
> smartphones/tablets supported upstream by:
> 
>  - Adding the BAM-DMUX DT nodes to msm8939.dtsi for WWAN Internet
>  - Adding the QDSP6 DT nodes to both msm8916.dtsi and msm8939.dtsi.
>    This is needed because audio must be routed through the QDSP6
>    services provided by the modem firmware when the modem is active.
>  - Setting up the sound/codec related nodes for all the devices.
> 
> [...]

Applied, thanks!

[01/14] arm64: dts: qcom: msm8939: Add BAM-DMUX WWAN
        commit: 32f963412a2d8cb65ff2737e6763f88ed15a2efb
[02/14] arm64: dts: qcom: msm8916: Add QDSP6
        commit: 861aa8e6829cf2f1a9c5a52dd9cebc722cf7ca44
[03/14] arm64: dts: qcom: msm8939: Add QDSP6
        commit: 0718ff7185cf42f8e817e39552feb9d6ed901aff
[04/14] arm64: dts: qcom: msm8916: Add common msm8916-modem-qdsp6.dtsi
        commit: 8abbd235b2ecbfba0a445ccd400a54af8fd83bc2
[05/14] arm64: dts: qcom: msm8916-samsung-a2015: Add sound and modem
        commit: f276411d0f8286c7ff3e1bd6917ea7ee61152d24
[06/14] arm64: dts: qcom: msm8916-samsung-serranove: Add sound and modem
        commit: 6b66abd5858e025b2715b1efb193124dd7cc17c5
[07/14] arm64: dts: qcom: msm8916-wingtech-wt88047: Add sound and modem
        commit: 5db767ae36255c0301ede64ee8993e0909efa73f
[08/14] arm64: dts: qcom: msm8916-alcatel-idol347: Add sound and modem
        commit: 5d1cec28fd4d09e82e028903423829f59a033965
[09/14] arm64: dts: qcom: msm8916-asus-z00l: Add sound and modem
        commit: 462cdffaa83df28d5fbd0c1771eaa85954114c77
[10/14] arm64: dts: qcom: msm8916-longcheer-l8150: Add sound and modem
        commit: 1ab407193d38c775261d7beccd080e88f68c7243
[11/14] arm64: dts: qcom: msm8916-longcheer-l8910: Add sound and modem
        commit: 2821c34a996b4a0991d33bead5caa84267e2dccd
[12/14] arm64: dts: qcom: msm8916-samsung-gt5: Add sound and modem
        commit: 4f6b5edbcfbaa1061c29e6259cc5653f44b673da
[13/14] arm64: dts: qcom: msm8916-samsung-j5: Add sound and modem
        commit: cf12268e1b632c6ac16185bd1230af6e1ca517fb
[14/14] arm64: dts: qcom: msm8939-samsung-a7: Add sound and modem
        commit: dd5ab5d2ca722110c82459a571e367df7ee6d821

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
