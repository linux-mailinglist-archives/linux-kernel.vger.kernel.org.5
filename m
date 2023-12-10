Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7B980BE2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjLJXVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjLJXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:21:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA74F4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:21:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BC2C433D9;
        Sun, 10 Dec 2023 23:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702250479;
        bh=oezeBfZo/+ckCa0S1GKmQyyh1vQrPZkPD1HeZu+TTPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBbRV8SI1oBJIwgABz3q/FoKvwfhfUEFgqgtrmTtuH5YO++x13jpxNV6LpxzEix4U
         3gPwCfDQaP7hwW/SoOrCZYaK6DTIQxUhp2Zt+B9UwxR8KN/vilTDdrzFoBdtWBdTsn
         JWhVb6h0A8VtYBfSuvFhoTHy1aS/QfNjR9T4vHrqpLqO1DD+eTjEyHzFJthvPtSu2c
         MCwA78v+mjIl8i2iJhWRsydqcYkoADDW0nafLm9rU1Lm8fs2MoB9REVRhWLgbSZ1Lu
         TdPXsBIz8zn6ctio80//NKhPgAcFgyFZj9ZCbHRMaMR0mZvMPffX34tiUNYKelmIdu
         yuZy4j/mQKYtA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bryant Mairs <bryant@mai.rs>
Subject: Re: [PATCH] ARM: dts: qcom: Disable pm8941 & pm8226 smbb charger by default
Date:   Sun, 10 Dec 2023 15:25:40 -0800
Message-ID: <170225073875.1947106.17270085860203406913.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231203-smbb-pm8941-pm8226-v1-1-9ad75909604b@z3ntu.xyz>
References: <20231203-smbb-pm8941-pm8226-v1-1-9ad75909604b@z3ntu.xyz>
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


On Sun, 03 Dec 2023 15:19:18 +0100, Luca Weiss wrote:
> Some platforms don't use the built-in charging hardware (e.g. milletwifi).
> As this is an optional peripheral, default it to off.
> 
> Keep it enabled for all other boards that use smbb.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: Disable pm8941 & pm8226 smbb charger by default
      commit: c9c8179d0ccdf024ce467b4c9cf5de8821bc02cb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
