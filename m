Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C2875FC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGXQ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGXQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:28:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F331B90;
        Mon, 24 Jul 2023 09:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE346126B;
        Mon, 24 Jul 2023 16:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A57C433C8;
        Mon, 24 Jul 2023 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690216122;
        bh=lxGAMbe4glHJGmlZVuH5/303VTnfVBaqcV1ylcKxjoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jkjZ53gG+sPiNhbq+gMO5vgg1WnkyLvGTmSrHHFBhD3xtfzU4yfg0ud6W8S/qItKW
         gh2aZti/Yd/7l4/JJO6UzqVI/nKJusFuzx9EdAvPjAIyRcqUMpaTAwLjC2Ir9Vvz2p
         1B8/SlUOjQp1HULfTuv4GaB9dDSys35kXNmRy1OSmsNt5OABFFYgMJtywMJxVWdSqf
         Qqj/6YPLaOO4c2CdgoTmnKxt5IGVW/sH4jozhNq8OBTl5FobkvRw6Nb08oPc++lTvV
         YKpJF1C9saY32oyjfYd3hhJyC71qbSxnSHtvlpbT55DNtEAePF10McltKVGgR0/eLH
         vhq7DSPcMWNNQ==
Received: (nullmailer pid 3789312 invoked by uid 1000);
        Mon, 24 Jul 2023 16:28:40 -0000
Date:   Mon, 24 Jul 2023 10:28:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: qcom,dwc3: drop assigned-clocks
Message-ID: <169021612042.3789253.5446474765514651082.robh@kernel.org>
References: <20230723141550.90223-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723141550.90223-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Jul 2023 16:15:49 +0200, Krzysztof Kozlowski wrote:
> The binding does not have to specify assigned-clocks, because they are
> already allowed by core DT schema.  On the other hand, fixed
> assigned-clocks in the binding will not fit different boards or SoCs.
> Exactly this is the case for Qualcomm SuperSpeed DWC3 USB SoC controller
> binding, where few boards have different assigned-clocks:
> 
>   ipq8074-hk10-c1.dtb: usb@8cf8800: assigned-clocks: [[5, 131], [5, 132], [5, 133]] is too long
>   sdm660-xiaomi-lavender.dtb: usb@a8f8800: assigned-clocks: [[37, 92], [37, 91], [38, 64]] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 9 ---------
>  1 file changed, 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

