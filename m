Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C081763DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGZRdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjGZRc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802D02696;
        Wed, 26 Jul 2023 10:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11E4761C03;
        Wed, 26 Jul 2023 17:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF2AC433C7;
        Wed, 26 Jul 2023 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690392775;
        bh=Cu9ADdxUn4Vjuuuu5fCdXgTIS4gN48R2EByULEFioQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xwd2qU9V6MS6YK2q9bYdstjRNBTbgq0MjOtsFH7ExlzwV2zmWCQ0dMrrBaigqDL4G
         quVWnwJvm04Qc5GG4vPonxd7ZqOGbYMbf4NVe1V7N3xJFVqTWwqPJtd5ncZfIjTz25
         ydOvWfqb7qZl4RdHpJGqNu+56qaj4npNHPU25yB21NMbHjjJSJud76miyi5QB23x4a
         Cu1yWsUymI6ENL99eXhBmT3OfHqsGlkVhSWCPqf+6u1tV6Fifjsv39EbWBKQWD+UNu
         0sdsNWQevG7KWzhlGz3JI9NrYaqUuReS2OfIqY9qXPAWbr3Ule3cjYmT/+sXevGzsE
         oWXcN+8HqOytA==
Received: (nullmailer pid 1693967 invoked by uid 1000);
        Wed, 26 Jul 2023 17:32:52 -0000
Date:   Wed, 26 Jul 2023 11:32:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Robin Gong <yibin.gong@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pascal Paillet <p.paillet@foss.st.com>,
        - <patches@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2] regulator: dt-bindings: add missing
 unevaluatedProperties for each regulator
Message-ID: <20230726173252.GA1686272-robh@kernel.org>
References: <20230726074940.121040-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726074940.121040-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:49:40AM +0200, Krzysztof Kozlowski wrote:
> Each regulator node, which references common regulator.yaml schema,
> should disallow additional or unevaluated properties.  Otherwise
> mistakes in properties will go unnoticed.
> 
> Reported-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Closes: https://git.codelinaro.org/linaro/qcomlt/kernel/-/commit/1c8aeef8a6e84520b77f0c270d99c8bf692c5933
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Humm, I have a meta-schema to check this and did a pass fixing them, but 
seems some of them I missed. I'll have to check the meta-schema (still 
some false positives in it, so I haven't committed it)

> 
> ---
> 
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Changes in v2:
> 1. Rebase, drop patches from work-in-progress branch
> ---
>  Documentation/devicetree/bindings/regulator/mps,mp5416.yaml   | 2 ++
>  Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml  | 2 ++
>  Documentation/devicetree/bindings/regulator/pfuze100.yaml     | 4 ++++
>  .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 2 ++
>  .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml | 1 +
>  .../bindings/regulator/richtek,rt4831-regulator.yaml          | 1 +
>  .../bindings/regulator/richtek,rtmv20-regulator.yaml          | 1 +
>  .../bindings/regulator/richtek,rtq6752-regulator.yaml         | 1 +
>  .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | 2 +-
>  Documentation/devicetree/bindings/regulator/wlf,arizona.yaml  | 2 ++
>  10 files changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
