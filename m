Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23E78F147
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346828AbjHaQ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346832AbjHaQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C903110C8;
        Thu, 31 Aug 2023 09:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E0296423E;
        Thu, 31 Aug 2023 16:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F3DC433BA;
        Thu, 31 Aug 2023 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693499318;
        bh=2Ww9Q0u01Ue+C8XQjrYkRHwNmgFGRGEhWZl6ghxXldA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQ7DVYv1EQJjy14V0lYUk3VQ8WGwCK6l3oPzoE/loFFS/jMB6h9bpmbRLEiKwzGgw
         QRXySJsQqdhXraaq1cuL4QnN7EapEqVNq3vcLLgUxJQhtxFiHK0lNYpbX8gavTHYWF
         kMqv/uPNizTJBvLdOmr2g4pcp2tLBiFnJu9xzcxpzfSHMwkPYODJME9nwiEQ54Ctpa
         KAEzzyPSR8eUemdjm2tFnl0fX26jzYr6FADPg+D5aSkSSv49ziZu+McTBvzwgfX5P4
         iM2Fdl6/RZqqCJFiwH4lqIkzaxIzU1Piz/QKUldlPrpTZaXF5Cua47KJD7uhZ6TqId
         HonvaYww0XrUA==
Received: (nullmailer pid 2392965 invoked by uid 1000);
        Thu, 31 Aug 2023 16:28:35 -0000
Date:   Thu, 31 Aug 2023 11:28:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v14 3/9] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
Message-ID: <20230831162835.GA2390385-robh@kernel.org>
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
 <20230217-topic-cpr3h-v14-3-9fd23241493d@linaro.org>
 <CAPDyKFrXT+2NEMUzVv-kWjXAhLinXq99GKq4_Ge2VjthtYxtaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrXT+2NEMUzVv-kWjXAhLinXq99GKq4_Ge2VjthtYxtaA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 01:01:44PM +0200, Ulf Hansson wrote:
> On Mon, 28 Aug 2023 at 13:42, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> >
> > Add the bindings for the CPR3 driver to the documentation.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > [Konrad: Make binding check pass; update AGdR's email]
> > Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    | 286 +++++++++++++++++++++
> >  1 file changed, 286 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> > new file mode 100644
> > index 000000000000..acf2e294866b
> 
> [...]
> 
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    cpus {
> > +        #address-cells = <2>;
> > +        #size-cells = <0>;
> > +
> > +        cpu@0 {
> > +            compatible = "qcom,kryo280";
> > +            device_type = "cpu";
> > +            reg = <0x0 0x0>;
> > +            operating-points-v2 = <&cpu0_opp_table>;
> > +            power-domains = <&apc_cprh 0>;
> > +            power-domain-names = "cprh";
> 
> Rather than using a Qcom specific power-domain-name, perhaps a common
> power-domain-name for cpus, that can be used for "the performance
> domain" would be a good idea here?
> 
> I have suggested using "perf" for the SCMI performance domain [1],
> perhaps that description should be extended to cover this and other
> performance domains too?

Better yet, nothing. There's no value to -names when there is only 1 
entry.

Rob
