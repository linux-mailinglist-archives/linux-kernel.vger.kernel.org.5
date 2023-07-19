Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B84775A0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGSV7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSV7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:59:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B51FDC;
        Wed, 19 Jul 2023 14:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B290C61852;
        Wed, 19 Jul 2023 21:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EA0C433C7;
        Wed, 19 Jul 2023 21:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689803990;
        bh=NPZ2zlHWpq/Wbwqq/LXMY0mNMpyY8P8jMZ/UIlCWaBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnbRgyQvvOD7UpR2u3pvvqqbol+MasDVHdU0XsqNc3+0Qb/MIdj9BEGM7TxWoTGIo
         ElZ1aeXMyOyt9TIPPYRz3wpQ+do+Kjm3fKcveIg4dQQDBvM5HG94c124SnW6RiEdMJ
         i5PFCzZzZfK0GFZXciY19QQ33ettBE1lnfkCdtV3k5Iltpd2EsynwfgRKX/0f6gcsq
         KoQ2B40lgCQB3zmnIcUY5uK1YEauYTdTh2mWS64acJ+L5cTbX4hiVlf4JBJGIE2PJk
         IojtKyszvXujEso9Q8A0T5cpKqfyJaeqlranZ6vVpSMy+Kp4PsRbDRgqxWXq8K8QgO
         eOvL7uDXqZJwA==
Received: (nullmailer pid 852428 invoked by uid 1000);
        Wed, 19 Jul 2023 21:59:47 -0000
Date:   Wed, 19 Jul 2023 15:59:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org,
        Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>,
        Andy Gross <agross@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ASoC: dt-bindings: pm8916-analog-codec: Fix
 misleading example
Message-ID: <168980398687.852368.16225201877767633294.robh@kernel.org>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
 <20230718-pm8916-mclk-v1-1-4b4a58b4240a@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718-pm8916-mclk-v1-1-4b4a58b4240a@gerhold.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2023 13:40:13 +0200, Stephan Gerhold wrote:
> SPMI devices typically have a single address cell and no size cell,
> i.e. reg = <0xf000> for the audio codec instead of reg = <0xf000 0x200>.
> 
> The example is a bit misleading because it uses the latter. Copying
> this into the device tree would be incorrect and was fixed before for
> pm8916.dtsi in commit c2f0cbb57dba ("arm64: dts: qcom: pm8916: Remove
> invalid reg size from wcd_codec").
> 
> Make the example more clear by adding the outer "pmic" node which
> specifies the same #address/size-cells that would be used in the
> real deivce tree.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../sound/qcom,pm8916-wcd-analog-codec.yaml        | 92 ++++++++++++----------
>  1 file changed, 50 insertions(+), 42 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

