Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4A7A8A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbjITRLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjITRKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC327CED;
        Wed, 20 Sep 2023 10:10:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC95DC433CC;
        Wed, 20 Sep 2023 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229826;
        bh=xORNwuaiBdlcQ+oz/AKk1EfwusQCgyC/d/Q/gfTmaU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZS/24/QW/PAWHVet8IANErdWPYhYCwLiWDv5voNPdKuENhv+/MB+NMMdDLzPrsYi
         ZhWCZu1mafHxjdmuxK5Ahzuc1ayAciqkRdMxDEStvpS0v67puSIhhxKI8gSFxAud4u
         Nu3/9wMoBGzpoRJVwdOheX9r///JXhL4gxleNjPP/69FTP5BduEIDvrFenmZQz2+eh
         Ygcse9EN2+QZ4qj7CrTs/DywV+kQcriDLTbVNivqwkyH8fHKZfD8G7CAVK74HC6RsL
         Alz5dplmfwNU7HdOZ0aGwgabFDN8DhmjEEskQLkpKfQodBA6V5eKPcurrMn7SWJBwe
         LCLFqGEaS0rNw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: Re: (subset) [PATCH 0/6] ASoC: codecs: msm8916-wcd-analog: Cleanup DT bindings
Date:   Wed, 20 Sep 2023 10:14:12 -0700
Message-ID: <169523004961.2665018.6811007282234942362.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
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


On Tue, 18 Jul 2023 13:40:12 +0200, Stephan Gerhold wrote:
> Drop the redundant reg-names and mclk from the PM8916 analog codec.
> Having the mclk on the analog codec is incorrect because only the
> digital codec consumes it directly.
> 
> 

Applied, thanks!

[6/6] arm64: dts: qcom: pm8916: Drop codec reg-names and mclk
      commit: c7b34291bb376598ea4279658bf3100c8cb1487b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
