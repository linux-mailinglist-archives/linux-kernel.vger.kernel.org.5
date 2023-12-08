Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C1E8099E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573085AbjLHCyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbjLHCx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA401FCA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257EAC43397;
        Fri,  8 Dec 2023 02:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004023;
        bh=H15XYAtye/qQoEeLo3qCrLhORvyocUOUC7CpeVLwFYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxmD7BhH26wMckfyxD8AICsBMmIxLRtgjev2EoLun64RRYpBvF9e/WEK5i2ujkCmG
         54WctvSXWE+XxUkQxsvZ8JNkLcX4h2QLmrppYht7yZZxPET4OGNkbkYNOGeMQ7NEeW
         bjBnEt7H3NmrWV2i8al4yNeZ7Fkjg/CebgjPpi0otoVgWQQOUvCQIJkqU0eFNYh5Jl
         YyPPh3Fw4PnNhnTNAffyQMYmE7PuR2+8502Oc5sl8oe90tiq15NfozeKwOtfFO+364
         R5OFpvy41Na3HEc+RT/DvOI8fVbPGJ58fOZ2/8J8rzXsIIjhJ9hgmsy5MzjcM4/rbY
         Aj47/OF0JcWOQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: ipq5018: add few more reserved memory regions
Date:   Thu,  7 Dec 2023 18:57:47 -0800
Message-ID: <170200426909.2871025.1437158063576224855.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025-ipq5018-misc-v1-1-7d14fde97fe7@quicinc.com>
References: <20231025-ipq5018-misc-v1-1-7d14fde97fe7@quicinc.com>
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


On Wed, 25 Oct 2023 22:12:12 +0530, Kathiravan Thirumoorthy wrote:
> Like all other IPQ SoCs, bootloader will collect the system RAM contents
> upon crash for the post morterm analysis. If we don't reserve the memory
> region used by bootloader, obviously linux will consume it and upon next
> boot on crash, bootloader will be loaded in the same region, which will
> lead to loose some of the data, sometimes we may miss out critical
> information. So lets reserve the region used by the bootloader.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: ipq5018: add few more reserved memory regions
      commit: a427dd16e61f3d145bc24f0ed09692fc25931250

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
