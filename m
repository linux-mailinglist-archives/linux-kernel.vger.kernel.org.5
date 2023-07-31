Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6BB76A321
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjGaVmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjGaVmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAD8130;
        Mon, 31 Jul 2023 14:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53D50612F2;
        Mon, 31 Jul 2023 21:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94784C433C7;
        Mon, 31 Jul 2023 21:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690839736;
        bh=Iu978Lm0V72u8OFjnPHx80yu7uDx5IJV9cwyHqcixlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pND/HZjsDfEoMrstHlrtfbI0w5JkC46OzgkAIBjPDJ5gMO0tsBHnZn/5Y0F/FaIUi
         EjTijss5T1pBEyg5GYPgMb894tDOEJv0G3xzy/cvTzUe4W9y/iZHDmTaqJSpF1D7Yg
         YBKkYZXhYQB2jo8BVxm3g+vmI7EWOUdBCwZ4q6k4Yjsg6Tm0xEWTPihJche2AU4WU3
         aE73vJpjboSRWpCU/Wd8kQSsjAS12YxBun/6x668Drzh5W8wu7Rhs892wJXfPoM367
         tPodV2RomJMGMhUHdK7dPoZ6+/GD9nXPdGgnCuDkMLqPhtceeymTeIs5AUYAB5uzR8
         FMXwxUZ2OAXUA==
Date:   Mon, 31 Jul 2023 14:45:21 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: qcom: msm8974: correct qfprom node size
Message-ID: <ff6fwomoik6kz4jtbm5jac7jahrtcia5fb6dj5ykxg7xt574sn@ti42sevqj6pk>
References: <20230130-msm8974-qfprom-v2-1-3839cf41d9ee@z3ntu.xyz>
 <866f1f66-8845-2453-ab9c-d125e23ae758@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <866f1f66-8845-2453-ab9c-d125e23ae758@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 08:20:41PM +0200, Konrad Dybcio wrote:
> On 15.06.2023 20:17, Luca Weiss wrote:
> > From: Craig Tatlor <ctatlor97@gmail.com>
> > 
> > The qfprom actually has size 0x3000, so adjust the reg.
> > 
> > Note that the non-ECC-corrected qfprom can be found at 0xfc4b8000
> > (-0x4000). The current reg points to the ECC-corrected qfprom block
> > which should have equivalent values at all offsets compared to the
> > non-corrected version.
> > 
> > [luca@z3ntu.xyz: extract to standalone patch and adjust for review
> > comments]
> > 
> > Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes")
> > Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> Not sure of the actual size of the region, maybe Bjorn can help..
> 
> Downstream 3.10 suggests 0x60F0, 0x20F0 after adjusting for the ECC offset
> 

There is indeed 0x3000 bytes until the next region, but afaict the
corrected ECC values only cover the first 0x800 bytes thereof.

Can you please let me know if this patch fixes a problem, or just
makes the numbers look better?

Regards,
Bjorn

> Konrad
> > Changes in v2:
> > - Keep base offset but expand reg from 0x1000 to 0x3000 (Konrad)
> > - Link to v1: https://lore.kernel.org/r/20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3ntu.xyz
> > ---
> >  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > index 7ed0d925a4e9..3156fe25967f 100644
> > --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > @@ -1194,7 +1194,7 @@ restart@fc4ab000 {
> >  
> >  		qfprom: qfprom@fc4bc000 {
> >  			compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
> > -			reg = <0xfc4bc000 0x1000>;
> > +			reg = <0xfc4bc000 0x3000>;
> >  			#address-cells = <1>;
> >  			#size-cells = <1>;
> >  
> > 
> > ---
> > base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
> > change-id: 20230130-msm8974-qfprom-619c0e8f26eb
> > 
> > Best regards,
