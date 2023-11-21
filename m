Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8240B7F25FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjKUGzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKUGy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:54:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A37BB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:54:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7927CC433C8;
        Tue, 21 Nov 2023 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700549695;
        bh=RC5ZdYA1C0XmYYroKXT596EA+PosEEwbcr5BlUftzz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cIPNBoVW+CIEuujkcy643EdBJLG/1c5e/LQ3JEe5jKWq4O2dwGcXb9SIuRKd4bdgH
         MoFaA3SCR0YBWn8bjyWvEE8naeFCgWR/7vD0CiXeyQrPYV8eLs/qKpLcEiWMTi2jCS
         HWgHAlVcR5dPQmnPzdF16zzataafTPMOTOkbo7wzgkvfNMKmQn9uKBOe24QIg26Eeg
         V6r1uJ3TgInM9NHdeGAI8QVaFQFegEo/uMqI3W5GQd6be3BNvDbxeVVmoiW3Gb6G4V
         G+r7n1wNayHQ4E7IjfmiaN/jE1OQlakHZXXGMF+jeGFMJPKNjMAHX+uIj5S3sLHeDA
         NAUyS+7wwis1A==
Date:   Tue, 21 Nov 2023 12:24:40 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: qcom: correct clocks for
 SC8180x and SM8150
Message-ID: <20231121065440.GB3315@thinkpad>
References: <20231120070910.16697-1-krzysztof.kozlowski@linaro.org>
 <20231120070910.16697-2-krzysztof.kozlowski@linaro.org>
 <CAA8EJpq6YOYGvxFwreNSoTShrKryqeEy79CTb0dFO-Dv8RNxZA@mail.gmail.com>
 <d2e4d7b0-39c9-4443-b0d3-774bdf79404b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2e4d7b0-39c9-4443-b0d3-774bdf79404b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:48:25AM +0100, Krzysztof Kozlowski wrote:
> On 20/11/2023 11:11, Dmitry Baryshkov wrote:
> >> +    then:
> >> +      oneOf:
> >> +        - properties:
> >> +            clocks:
> >> +              minItems: 7
> >> +              maxItems: 7
> >> +            clock-names:
> >> +              items:
> >> +                - const: pipe # PIPE clock
> >> +                - const: aux # Auxiliary clock
> >> +                - const: cfg # Configuration clock
> >> +                - const: bus_master # Master AXI clock
> >> +                - const: bus_slave # Slave AXI clock
> >> +                - const: slave_q2a # Slave Q2A clock
> > 
> > Mani promised to check whether we should use the 'ref' clock for the
> > PCIe hosts or not.
> > I'd ask to delay this patch until we finish that investigation.
> 
> Right. I thought that his Rb-tag solves it, but if not - let's wait.
> 

We discussed mostly offline, after I gave my R-b tag.

I checked with Qcom on the use of "ref" clock in both PCIe and PHY nodes.
It turned out that both nodes indeed need the "ref" clock, but not the
GCC.*CLKREF that comes out of GCC.

GCC.*CLKREF is only needed by the PHY node since PHY uses it for it's internal
logic. For PCIe node, RPMH_CXO_CLK should be used as "ref" clock since it is
used by the PCIe IP internally. This behavior applies to other peripherals like
UFS, USB as well with same inconsistency in DT.

So we need to fix this for those peripherals also. I can take up PCIe and UFS,
and someone needs to fix USB.

And for this patch, "ref" clock needs to be added to SM8150.

Thanks Dmitry for pointing this out mess!

- Mani

> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
