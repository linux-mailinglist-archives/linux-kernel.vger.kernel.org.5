Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C277825E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjHJUvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjHJUvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:51:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DF62737;
        Thu, 10 Aug 2023 13:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9E1560DF5;
        Thu, 10 Aug 2023 20:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F93AC433C8;
        Thu, 10 Aug 2023 20:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691700696;
        bh=uc4/S/7TCcbiz3P0S21vusgTyPBdVSAtY0wrKfV+NU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XH9SRp89dPOffEfPah0TaR37jsZy1zBWGbXRJ6Rv+HDnKeFrlNpUkFRve+ba25i63
         4tRVK6D36VmYTm5NKUOp2ChFdHpPWQCKEvHq1ozxaJn4n7JZpB0WJHXLWEPo6USPFJ
         lGd3kggEq7JWiiiNvC8hUuiVvImck5guQctjREbzvda3JpPJoV9Tshm/uuWTzKWBMi
         SfIJvNpTvjD1diEeye20FfpuiZrlhO3iFJAm2iQzzRlaHBt4dhzy08GUhqDvvMNH9N
         WZuJ0TOmquSmZI9hjgZwnz3Er5+skOtn5wbmm+L1g2SPH6bYdSrgNlvgTuza3nx0d5
         TqvmF8Gg/0Byw==
Received: (nullmailer pid 1155354 invoked by uid 1000);
        Thu, 10 Aug 2023 20:51:32 -0000
Date:   Thu, 10 Aug 2023 14:51:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, vkoul@kernel.org, rafal@milecki.pl,
        quic_srichara@quicinc.com, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org, andersson@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        kishon@kernel.org, agross@kernel.org, conor+dt@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        geert+renesas@glider.be
Subject: Re: [PATCH v7 1/5] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Message-ID: <20230810205132.GA1154887-robh@kernel.org>
References: <cover.1691660905.git.quic_varada@quicinc.com>
 <0d42f556ab28123b2b508521a0c79c7597b8b0fd.1691660905.git.quic_varada@quicinc.com>
 <169166288301.4166332.13436758125497162213.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169166288301.4166332.13436758125497162213.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:21:23AM -0600, Rob Herring wrote:
> 
> On Thu, 10 Aug 2023 15:26:04 +0530, Varadarajan Narayanan wrote:
> > Document the M31 USB2 phy present in IPQ5332.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v7:
> > 	Move 'compatible' to be the first entry
> > 	In the example have 'usb-phy' instead of 'usb2-phy'
> > 	Add 'Reviewed-by: Krzysztof Kozlowski'
> > 	'make dt_binding_check DT_SCHEMA_FILES=qcom,ipq5332-usb-hsphy.yaml' passed
> > 	'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom,ipq5332-usb-hsphy.yaml dtbs_check' passed
> > v6:
> > 	Add 'Co-developed-by: Sricharan'
> > 	Add 'const' to compatible, vdd-supply
> > 	Remove label and use usb2-phy for nodename in the example
> > v5:
> > 	Add '#phy-cells', to be able to use generic phy
> > 	Remove 'Reviewed-by: Krzysztof Kozlowski' due to above change
> > v4:
> > 	Move M31 URL to description
> > 	Remove maxItems and relevant content from clock-names
> > 	Change node name to generic name
> > 	'make dt_binding_check DT_SCHEMA_FILES=qcom' passed
> > v3:
> > 	Incorporate review comments. Will bring in ipq5018 compatible
> > 	string while posting ipq5018 usb patchset.
> > 
> > v1:
> > 	Rename qcom,m31.yaml -> qcom,ipq5332-usb-hsphy.yaml
> > 	Drop default binding "m31,usb-hsphy"
> > 	Add clock
> > 	Remove 'oneOf' from compatible
> > 	Remove 'qscratch' region from register space as it is not needed
> > 	Remove reset-names
> > 	Fix the example definition
> > ---
> >  .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml       | 59 ++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/0d42f556ab28123b2b508521a0c79c7597b8b0fd.1691660905.git.quic_varada@quicinc.com

The bot was having an issue. This can be ignored.

Rob
