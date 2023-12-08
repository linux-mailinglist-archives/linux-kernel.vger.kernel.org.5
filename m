Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397F28099CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573166AbjLHCyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573047AbjLHCxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD081BD4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDF8C4339A;
        Fri,  8 Dec 2023 02:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004013;
        bh=ct5z8TaxhTCE0x9MRzGXnRXlpuL+SWMfJGjjFvf5OIQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mZ3kTbWK9D/8AlbQwTvJTA7fi/v2jyWRnX5v6QjQAzKZqKIx6K2Mf8vA5eYEMOY9k
         AvNGezq/2O/FPHDW2PUye1gPp6jaBdUqMll1q+U5TCQztgC2XApMl67/E2mO52GBZb
         WA+cLIO1b1moL6rbPmG+qv6I8inHTH8gPKPrh71+vayvpyBJ1GnLiadf69JorKscX/
         FYlGpCOFmCaGXmMOBYSWEEsgb6BJ0sAKZxvdKhrhmmI68cV6vX4FDNNOat3BgK6TBM
         CWoAVve9YhvhVbT3JQ9konUS4Llry7aFxpomiv4PgzPxDr7Ln9ApuEzSnpDWDPCXOu
         Za9a6D3BeaLCg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: qrb5165-rb5: correct LED panic indicator
Date:   Thu,  7 Dec 2023 18:57:37 -0800
Message-ID: <170200426918.2871025.16561322859589865587.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111094623.12476-1-krzysztof.kozlowski@linaro.org>
References: <20231111094623.12476-1-krzysztof.kozlowski@linaro.org>
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


On Sat, 11 Nov 2023 10:46:23 +0100, Krzysztof Kozlowski wrote:
> There is no "panic-indicator" default trigger but a property with that
> name:
> 
>   qrb5165-rb5.dtb: leds: led-user4: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qrb5165-rb5: correct LED panic indicator
      commit: dc6b5562acbac0285ab3b2dad23930b6434bdfc6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
