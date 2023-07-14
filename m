Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2064275313B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjGNFay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbjGNFat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27692D40;
        Thu, 13 Jul 2023 22:30:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B522461BB2;
        Fri, 14 Jul 2023 05:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C02C433C7;
        Fri, 14 Jul 2023 05:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312644;
        bh=lSSN95APEL7fLu2uQXGTXNzE+1BlON4YS574Wh09i1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dsIrGegOJgRs7Rrgzne+lRVnMksRTDVFnJQW8BAuhNrVZU5h81OLM39pC6Y2RWNka
         9GJSN6emEaK8vKplby9LCmw3HDvH10gq7SDwwluNUOCoDEpGzulCTRjBvoZbn7okNi
         UnTzYRRDGyeTI846AfQKP2rLPZbDwIw/vNbVEM/e9QMBz63wbDxVlyTF8YiTRssIQ6
         CIT0d+iftfWQaHDimdl7ON8QITNYU9avX7bzvzd5GIbtSTaGGQKpiBk7T9VHHAyVNm
         ecU2j42z7EtaYxx9pWUdR13EjsK8QoXbD1poTqxMJ/7EHd1N/v5yj09L6/SNlwdahm
         G/6BRLRcv8p3A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/4] SM8250 + SM6350 BWMONs
Date:   Thu, 13 Jul 2023 22:33:59 -0700
Message-ID: <168931284121.1538684.4889558485048519833.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711-topic-sm638250_bwmon-v1-0-bd4bb96b0673@linaro.org>
References: <20230711-topic-sm638250_bwmon-v1-0-bd4bb96b0673@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Jul 2023 16:35:12 +0200, Konrad Dybcio wrote:
> SM8250 and SM6350 both have 5 BWMONs: one for the CPU path, one for the
> LLCC path and 3 more for the NPU.
> 
> This series hooks up the first two for both SoCs.
> 
> Rebased on top of djakov/icc/icc-next, atop the 7180 addition.
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: sm8250: Add BWMONs
      commit: 2a2bd124d4c01c53833a4f0c7fef4faf18351c51
[4/4] arm64: dts: qcom: sm6350: Add BWMONs
      commit: 1df6b32e3819dc1de5ccd49982686153ab9e158c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
