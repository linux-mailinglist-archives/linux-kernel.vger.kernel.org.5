Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B8758558
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjGRTHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRTHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:07:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F13F0;
        Tue, 18 Jul 2023 12:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8C7C616C6;
        Tue, 18 Jul 2023 19:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924F8C433C8;
        Tue, 18 Jul 2023 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689707232;
        bh=yRaOQYTa1Amdd2MVTupX3C9Di+NVA1VQM28fL5G7oYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3qvXYinwNYlyZLCvM+ApMbhj7aWV5wLjkFIrpzxyszxUsepdaRRs1zEaQfjkqwgG
         Js8153/OwE4SyKMlJ3mIN9/DYAoRUQhz2Z3PyKITdjYoL/j1YphC4Ok37o5yS5f9Qv
         R0zW7LBAyT6JFxGyb0tH3X3A1P4v/Jc5ijx9dSmT+T07iADmWl0Jxf9UUPmUEGksGi
         /OGidkmUsgDgFJLdNLK7jRrQAC5w499GG7Lpv3MNlW9QVeWNsYw3hxpky99RUpZE1K
         Q5EmrfwJN28aiqTjm5kXEX2iS931ql4jBinmn9db4XIv22phDBj/IfaLW7v2T4FquY
         s9SJZb7Oow/0g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] clk: qcom: fix runtime PM bugs
Date:   Tue, 18 Jul 2023 12:10:35 -0700
Message-ID: <168970743315.3401131.3621273125910411303.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718132902.21430-1-johan+linaro@kernel.org>
References: <20230718132902.21430-1-johan+linaro@kernel.org>
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


On Tue, 18 Jul 2023 15:28:54 +0200, Johan Hovold wrote:
> This series fixes a number of runtime PM related bugs found through
> inspection.
> 
> Johan
> 
> 
> Johan Hovold (8):
>   clk: qcom: camcc-sc7180: fix async resume during probe
>   clk: qcom: dispcc-sm8450: fix runtime PM imbalance on probe errors
>   clk: qcom: dispcc-sm8550: fix runtime PM imbalance on probe errors
>   clk: qcom: gcc-sc8280xp: fix runtime PM imbalance on probe errors
>   clk: qcom: lpasscc-sc7280: fix missing resume during probe
>   clk: qcom: q6sstop-qcs404: fix missing resume during probe
>   clk: qcom: mss-sc7180: fix missing resume during probe
>   clk: qcom: turingcc-qcs404: fix missing resume during probe
> 
> [...]

Applied, thanks!

[1/8] clk: qcom: camcc-sc7180: fix async resume during probe
      commit: c948ff727e25297f3a703eb5349dd66aabf004e4
[2/8] clk: qcom: dispcc-sm8450: fix runtime PM imbalance on probe errors
      commit: b0f3d01bda6c3f6f811e70f76d2040ae81f64565
[3/8] clk: qcom: dispcc-sm8550: fix runtime PM imbalance on probe errors
      commit: acaf1b3296a504d4a61b685f78baae771421608d
[4/8] clk: qcom: gcc-sc8280xp: fix runtime PM imbalance on probe errors
      commit: 10192ab375c39c58d39cba028d9685cefe1ca3c2
[5/8] clk: qcom: lpasscc-sc7280: fix missing resume during probe
      commit: 66af5339d4f8e20c6d89a490570bd94d40f1a7f6
[6/8] clk: qcom: q6sstop-qcs404: fix missing resume during probe
      commit: 97112c83f4671a4a722f99a53be4e91fac4091bc
[7/8] clk: qcom: mss-sc7180: fix missing resume during probe
      commit: e2349da0fa7ca822cda72f427345b95795358fe7
[8/8] clk: qcom: turingcc-qcs404: fix missing resume during probe
      commit: a9f71a033587c9074059132d34c74eabbe95ef26

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
