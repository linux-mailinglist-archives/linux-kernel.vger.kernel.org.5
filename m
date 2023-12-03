Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F98020BD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjLCEvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjLCEvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:51:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE6116
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B21C433C7;
        Sun,  3 Dec 2023 04:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579101;
        bh=S0yq8trChhQB2QxtIfpHYOXLs2J2fS+sqWGhqbXRkuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jhd5nNqWV4U1XmA1QMb2m+SmDA38x6TgCz5gTaUz/pWG+WHhRFjK5p96Yq46v/lMx
         cyX/GPDCrT3SW4HOL7hhiWBXzHQ8/8XEq7xNiX+1x5aKwATEPkFd4/8gPnNniCv6i2
         wL1bNgXnJ55HrenTRcdbf2kMIObZu7OM8nuSKuw2oLLa1lJ0wNMvdEswa3sSPDeRDq
         nS2O6jrRPttLUjr44sHmZQYaWivlW8+OT/cEnLPfO5QDVdy4ZO5Jts76FfXloVsiCQ
         mYeGhIXQOVflTYElk0vr7e140HUWH2+XzqRuCNQys83Vt6F3bC/JVqXbwGG0Zb675d
         BCRIV+pqZ4teg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-crd: fix eDP phy compatible
Date:   Sat,  2 Dec 2023 20:54:32 -0800
Message-ID: <170157925833.1717511.5166881247887847999.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016080658.6667-1-johan+linaro@kernel.org>
References: <20231016080658.6667-1-johan+linaro@kernel.org>
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


On Mon, 16 Oct 2023 10:06:58 +0200, Johan Hovold wrote:
> The sc8280xp Display Port PHYs can be used in either DP or eDP mode and
> this is configured using the devicetree compatible string which defaults
> to DP mode in the SoC dtsi.
> 
> Override the default compatible string for the CRD eDP PHY node so that
> the eDP settings are used.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-crd: fix eDP phy compatible
      commit: 663affdb12b3e26c77d103327cf27de720c8117e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
