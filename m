Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003A975466A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 04:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGOCrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 22:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGOCrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 22:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F5E35A8;
        Fri, 14 Jul 2023 19:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA47E60C90;
        Sat, 15 Jul 2023 02:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B45C433C7;
        Sat, 15 Jul 2023 02:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689389267;
        bh=npCaulUvpAlcTzN+7RhVwGYK3NG5QK8JcvfC/iJ0j58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ibt1SXjBrpPGaRMeWEJyQoJh+3Rj78TdqEVNGfimqA04jM1RO06IMDqRs+hvNqt6l
         hNtVm5JGm8ImCVeJRTIKDMLDMp08GgpnyOcncli6jjcy3sCgo028c5AGBNJpwkaos4
         p1n5PEdW5BmPFlRVBDg+w+rCL/dOIfsoImWyyGzUu9LVV17h95lrflYrmM5SoXJq6O
         u8RaS8i3WRjpksYLPb0a9/+3FrDmJNiGGXZJrU0KIE5melAheOF8/+bueaTgJhiqQh
         OmlNnx9wchMsFbU9Fd49J0QaZ6jifbIPuVYj809g2gWvaPVDdCrx42v1B/wsnOTSfD
         NKXSfQhXfGcBg==
Received: (nullmailer pid 876497 invoked by uid 1000);
        Sat, 15 Jul 2023 02:47:45 -0000
Date:   Fri, 14 Jul 2023 20:47:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: qcom: lpass-lpi: Remove
 qcom,adsp-bypass-mode
Message-ID: <20230715024745.GD872287-robh@kernel.org>
References: <20230714-topic-lpass_lpi_cleanup-v1-0-dc18b5bd14f7@linaro.org>
 <20230714-topic-lpass_lpi_cleanup-v1-2-dc18b5bd14f7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714-topic-lpass_lpi_cleanup-v1-2-dc18b5bd14f7@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 14:40:47 +0200, Konrad Dybcio wrote:
> This property was introduced as a bad hack. Now that it's useless, get
> rid of it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml   | 5 -----
>  1 file changed, 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

