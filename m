Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B647E75A12E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGSWAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSWAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076431FD9;
        Wed, 19 Jul 2023 15:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DDC661852;
        Wed, 19 Jul 2023 22:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D79C433C9;
        Wed, 19 Jul 2023 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689804012;
        bh=sOL4QJ8Up3hlV7T9f3HrCxwumWrI72GRQ9N+y83we14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Av+C/wUwsYPZRoX6SyEwedo+ATgiMEuFG+K9PeNZaO8/OOXhZdOz+dNGf75P+/w7e
         Xf7AAacy6Excho/Za5K1J6b7hVQeou6BH1m7OHzHaPy1wiCY45oSXq+P4rtPf396gC
         p8Jb0YdRNBJm51g9crvtfx25+Vukc4IgouIWvtjmS68GcdMWNbjQuGadtiWt3qS4Px
         XmVwLrua+ndMOb1n5LxA8QTHiJpQsrRBkRY2dE3Nes5SpFT3LwxWjhOS701d9Ehq0n
         qQhAibuDc4klStKPhfTIcdSW9Mk6R3OcweDJ0E9yUPD0F90P3/KI5210XxU+6/fkV+
         fi/CKUj2ty7fA==
Received: (nullmailer pid 852942 invoked by uid 1000);
        Wed, 19 Jul 2023 22:00:09 -0000
Date:   Wed, 19 Jul 2023 16:00:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/6] ASoC: dt-bindings: pm8916-analog-codec: Drop
 pointless reg-names
Message-ID: <168980400907.852867.15301265985147515272.robh@kernel.org>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
 <20230718-pm8916-mclk-v1-2-4b4a58b4240a@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718-pm8916-mclk-v1-2-4b4a58b4240a@gerhold.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2023 13:40:14 +0200, Stephan Gerhold wrote:
> pm8916-wcd-analog-codec has just a single reg region, so having a name
> for it provides no additional value.
> 
> Drop it completely from the schema and example. There is not really any
> point in keeping it (even as deprecated) because it was never used. In
> old DTBs it will just be ignored as before.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml      | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

