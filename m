Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7274A7A7036
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjITCKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjITCKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:10:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F74CE;
        Tue, 19 Sep 2023 19:10:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4790C433CC;
        Wed, 20 Sep 2023 02:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695175800;
        bh=Vv/k0XfU635pKagxS1yVwKInDfpvPuQUWW4tmVK3bH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZTCNhCkAGmZJrqZcS/ojYeWZSoHbkfPlQdikglz5QftJkjuSufYxt2OY3ow4zkqp
         eMvZAA/KEf7fJYeOS0KcKtXMzwvVHtHv6eIdFx8CaX5CPE8k+yMNM+cMgHaLZnF7LM
         Eqy/cQT7qlkbuSidYKimEkDe0WDyzs46yQWUs/gqLox0GZfHLYGzT4VapLW/bzmkkx
         OmbhbKXAo2DSiReq1ctdSIKiz/ZJ4CeNKWHPU8AFnvHNOuEeAj7rvBND5oKmMsBJaN
         aMO90G0Adc9WUwobdFBqg0MXNmEtMwT72WT+FJ0Omz5sH076w3Qgy+Q8HKc2sn7KG9
         Sxnod11HithRQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH 0/5] RB1 features
Date:   Tue, 19 Sep 2023 19:14:00 -0700
Message-ID: <169517603987.822793.12171416203818012201.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906-topic-rb1_features_sans_icc-v1-0-e92ce6fbde16@linaro.org>
References: <20230906-topic-rb1_features_sans_icc-v1-0-e92ce6fbde16@linaro.org>
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


On Wed, 06 Sep 2023 11:24:54 +0200, Konrad Dybcio wrote:
> This series brings:
> 
> - a boot fix (Qualcomm's promises of updated hw never materialized)
> - regulator fixes (way back then schema didn't notice my mistakes)
> - GPIO LEDs
> - USB3
> - remote processors
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: qrb2210-rb1: Swap UART index
      commit: 973c015facabcbd320063648010942c51992c1a1
[2/5] arm64: dts: qcom: qrb2210-rb1: Fix regulators
      commit: 31bee70793b67f4b428825434542afc72ddb2b3b
[3/5] arm64: dts: qcom: qrb2210-rb1: Enable remote processors
      commit: 9692ccc49583cd43184ea192af127635877e0f24
[4/5] arm64: dts: qcom: qrb2210-rb1: Add GPIO LEDs
      commit: 02a2fcfbb835bac0c523b3f89326bc1c69f83ce0
[5/5] arm64: dts: qcom: qrb2210-rb1: Hook up USB3
      commit: 59f9ff79cd9cf3bc10743d61662b5729fcffff24

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
