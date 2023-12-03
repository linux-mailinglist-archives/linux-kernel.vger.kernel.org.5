Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375C0802106
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjLCEyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjLCExY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:53:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3C42122
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E48C433A9;
        Sun,  3 Dec 2023 04:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579126;
        bh=g9M9djE+Zo2OXIDWinS0oNMbR3ZSzjxtKnWXMhw6wI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SpKeB8HW4cy+hPa+FVjptdgDzrDMRDnS91UmNrziuyUZC0EcnT3uEO5wV+b5mMy6m
         iF1HXcXBVBaDd0W0XZmFrfO63mRThmmdiL5Xk1JuMcLQnm2NY+kqeBAo7uDYj3SioO
         tNUkCTyFknslfiwaGxdfDpN9RUX5EkrQpcoLVSPcc7xmsSRzwMqvWHBTvhHho5KqXf
         +Xp+s2HAXmeIFWCIa3d1rCoMKBPEhC0TE2CzIMXkeNHqYheFEtPxKXakguIG72LZxs
         VKnnTSvGPc17rsirBVcvvdOgbUz/KFnM5wS3LJzcmpPYOZcimXmOP17fjMoRlr5U3Q
         238sq8IQyK2yQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: (subset) [PATCH v7 0/6] soc: qcom: Add uart console support for SM4450
Date:   Sat,  2 Dec 2023 20:54:52 -0800
Message-ID: <170157925811.1717511.17508500866528370526.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129103325.24854-1-quic_tengfan@quicinc.com>
References: <20231129103325.24854-1-quic_tengfan@quicinc.com>
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


On Wed, 29 Nov 2023 18:33:19 +0800, Tengfei Fan wrote:
> This series add base description of UART, TLMM, RPMHCC, GCC and RPMh PD
> nodes which helps SM4450 boot to shell with console on boards with this
> SoC.
> 
> 

Applied, thanks!

[1/6] arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db node
      commit: 924645058d31bde9788d6b493adefc6f113b3272
[2/6] arm64: dts: qcom: sm4450: Add RPMH and Global clock
      commit: 483fa5552d352f3bfe835a3156e6cf037c4cf77f
[3/6] arm64: dts: qcom: add uart console support for SM4450
      commit: 980679261b061da92fc441fa4e2fdb7ef8baadb2
[4/6] arm64: dts: qcom: sm4450-qrd: add QRD4450 uart support
      commit: b6fbe1112e40109b8a0013d19b2d97f01438482d
[5/6] arm64: dts: qcom: sm4450-qrd: mark QRD4450 reserved gpios
      commit: 6e28e70f00756275151ffb02534c6d2318229416

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
