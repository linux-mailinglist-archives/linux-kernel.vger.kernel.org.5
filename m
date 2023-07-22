Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0786E75DA19
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGVFOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjGVFOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B009E19A2;
        Fri, 21 Jul 2023 22:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F6E960B08;
        Sat, 22 Jul 2023 05:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B61C433C8;
        Sat, 22 Jul 2023 05:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002855;
        bh=FMrg/Gz+a6gVv2jfKf/0jZq6TlwZPqeKvfcszvu/qoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6PFjPPZ4T111lVO/WmGj4MztWgTSwTiTPjlmgcUCQM3KsDzpD9/snwhc5yfVHmvS
         6wWdqyT9Sz5hUNc4j8h2qhTUpSS1d7UuCog4BPtmi8tS6TS3IG+g0pW23kwsBTy58L
         gkX0Oir20YI+KbbWwjHBbpGm9+LbxGFZFmO0NgUsd3nxz80SSHVLJJ+Zpq3t1i1YQk
         nDEdH5uB80mEStMqrf0Zz+T8b+B5UzFG+6MNPJWZ3v+rItC9MLfaZFeD3MGWvnhKCT
         s7/EaO0B4ZchAmvr4tt3hPP0j98JxKGVPVbh81n6bjcnYs6ts//SvjGDEW2Se6Onlx
         qyFGFTKXwLo7Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-j5-common: Add touchscreen
Date:   Fri, 21 Jul 2023 22:17:14 -0700
Message-ID: <169000304203.3611206.306028690038120210.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230715214046.14902-1-linmengbo0689@protonmail.com>
References: <20230715214046.14902-1-linmengbo0689@protonmail.com>
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


On Sat, 15 Jul 2023 21:41:01 +0000, Lin, Meng-Bo wrote:
> J5 and J5X use an Imagis IST3038C touchscreen that is connected to
> blsp_i2c5. Add it to the device tree.
> 
> MFD driver for SM5703 is unavailable at the moment, which is required
> to power up the touchscreen on J5, so it's disabled on J5 for now.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-samsung-j5-common: Add touchscreen
      commit: 63c7fe554264ed17716df8eb9150d8e057d4c728

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
