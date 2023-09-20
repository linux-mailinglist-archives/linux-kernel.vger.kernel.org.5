Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8887A7155
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjITD4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjITDzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:55:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED6F5;
        Tue, 19 Sep 2023 20:55:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54165C43391;
        Wed, 20 Sep 2023 03:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182106;
        bh=lS5QsmDIxhnq9nnMl0m5YDi8EJfraAZLdVal/TChSgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1N+lYm2wHIv1+kaGxqIxTjWvBrSQCbc7lvBtAU8v19pGhlQKARoXyPKwwgtKNd9c
         CtXrVQmDqCEcmnHxA2H7qqHjYC57KzO8nUI7/XeonRZDs+1qF+WzTRH/4rLqKTrzG4
         vP3VskkLscHSpqg1T1KHT57OOSjS5II8SL7woyd1ii4B8l6JsbjL7XGTMKMYv/lEl3
         M67R/Bt3f7Zsic7xWBxyaBMZ/fKVyqWWR2UJ8Zc0MnhGqhoa2tj7GkHKjgP5CMwKNi
         cbEnPcAJ8Z0V87AdIaPJbO+QNoXpu3egquiLkr+zRpasLLnL+SfT/o32Ols1ICJMau
         qLkPtFNH67lCg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ohad@wizery.com,
        baolin.wang@linux.alibaba.com, linux-remoteproc@vger.kernel.org,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
Cc:     quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Subject: Re: (subset) [PATCH v2 0/2] Fix tcsr_mutex register for IPQ6018
Date:   Tue, 19 Sep 2023 20:58:57 -0700
Message-ID: <169518233725.1055386.8371009743953920681.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230905095535.1263113-1-quic_viswanat@quicinc.com>
References: <20230905095535.1263113-1-quic_viswanat@quicinc.com>
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


On Tue, 05 Sep 2023 15:25:33 +0530, Vignesh Viswanathan wrote:
> IPQ6018 has 32 tcsr_mutex hwlock registers of 0x1000 size each.
> The compatible string qcom,ipq6018-tcsr-mutex is mapped to
> of_msm8226_tcsr_mutex which has 32 locks configured with stride of 0x80
> and doesn't match the HW present in IPQ6018.
> 
> This series fixes the following:
>  1. Fix the tcsr_mutex register size to 0x20000 in IPQ6018 DTSI.
>  2. Remove IPQ6018 specific compatible in hwspinlock driver so that it
>     falls back to pick of_tcsr_mutex data.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size
      commit: 72fc3d58b87b0d622039c6299b89024fbb7b420f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
