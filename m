Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03C753148
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjGNFbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjGNFav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5444830D0;
        Thu, 13 Jul 2023 22:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCFDA61BD1;
        Fri, 14 Jul 2023 05:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FA3C433A9;
        Fri, 14 Jul 2023 05:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312646;
        bh=uWzK3T4H75FO+amhAnZLMxl4Ty4qc3TYlrmMGhE1eJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHZCFvxTf94MaEuPGy2cPaWSDGa6s03ACC69Mfm4g4zdJd3F8WlmgxBx5B4Mh+bvo
         sX994VQMByaSh+Wanf9SCHWh29FL/rUqZIcRYtyXXRllE2396w5irGFVa50mobv2Hh
         uUGoblMHk8u2v7jWwpb1oYM7R0KlhVMBGEmggOT5gU1lv99w7ZQRbW64ncAHQempEc
         t1s6nfVeq28fdOV4zc8iovyxtzbZHP3+lBvf3rck77aXlBzBhFmQr0qFS+aMysDjtf
         9/U8WldTxOP37xP8zXYESP9KaKzpDcXmmbwrMR2CqlefEt2g2pXtvyp3+W2SAhG/gS
         rzNjoh/rmbZOQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Bring back cpufreq-based DDR votes
Date:   Thu, 13 Jul 2023 22:34:01 -0700
Message-ID: <168931284122.1538684.2859305610327156457.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711-topic-7180ddr-v1-1-56e4f13afe9b@linaro.org>
References: <20230711-topic-7180ddr-v1-1-56e4f13afe9b@linaro.org>
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


On Tue, 11 Jul 2023 13:00:53 +0200, Konrad Dybcio wrote:
> ChromeOS folks reported that bwmon is too slow and getting rid of
> statically defined CPUFREQ-based votes (effectively floor votes because of
> how opp-peak-kBps is interpreted), has a major performance impact in some
> common applications. Bring them back until MEMLAT support is introduced.
> 
> This is a partial revert of the commit referenced in the fixes tag.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180: Bring back cpufreq-based DDR votes
      commit: 5e6d88815c2f8ec5e30101de7de5f6de72576a61

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
