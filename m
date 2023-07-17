Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C17560D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjGQKp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGQKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:45:56 -0400
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5F5BC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689590738; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tvmM4VTRmIDU8CsvrGGiEdIRdU26jXPiOGp1wbOYSIMTmvvsmI2RXV12cxHxcZAWYN
    owymoqGxeJz536rK/smx9EqD/gA/+3HowHIX1sIHZdqjWQvMKgBU5uo9Q14R2QAc+HTh
    5XcPd3rZVF+Jq+bUtBV/Q2TMCsbxY/NIylwMElxObGvMgInFOB6IbdRNv63g3VyBWQR8
    PyKe+xgnL/FVhJPfIT6fqdAddsHSRS7y8aJSU4PLMDq+Cc3z+St0vw4ewRYXnhQQ7mzs
    y2pBvIkNZ79Dm1zekSFQ10DPG6REhOhAxly/fDHUNxw9ZismVRQlH1SoXbPQXnRMIHSY
    dAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689590738;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=76E7kv/rz3wVZ9AmXO1y062UWjx+pg+DHG1to8xcAk4=;
    b=QZjTrOhnqvmLUVejlMsbxju9o8w9S6uymBpFWgQFRePJw4FTKW5PmpCrORBEj4vzGd
    IDxGPFbPOdxwtwk3ykvSjyin9mD+uOn808tatpTsrzaq1tj7hIAs4mZWy0ZsRfW3mxPV
    8U00Ldx//3wn5vsg5Y+xWKJQ3s/7pd4qP8+6sLzG5cHD4tTB6KYK+Z37t2cOT8La4+Bt
    5EpELOsRMDq6a3ZCiRKJ+gUpPM02MOZyHqZPowhxk5oR6XtEI/64IhZu+E3QWhu34kpO
    ZpOSp66G5v7wlt/GtC1I1JHkHnxwUQ9jAtWTM/vkMP60gFoCvKohLpETsCsXR9PjFLGl
    BtuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689590738;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=76E7kv/rz3wVZ9AmXO1y062UWjx+pg+DHG1to8xcAk4=;
    b=dtIKLUHQyzgPi2SZawEvkiW93YwAD/o2TnEeBj2jRqBXEEOw2ljDSLKssLsTVBCn6K
    +GdRRcUaMtWS3vNNZrvliMR2k4Sz0l2X4ImMuqIVublCALNc8arAeVkLg+CR2L75DoCU
    8FYeUoV0xSBydC6w0tp5+feB84iftygj7OxubIezejWqjblaQoIx4kCD7psRNUUoV1Yo
    NOfqPgu9INZSANe5Zg0LK/hXMWx8WsKzFoTQ1dT3FSAULrcW/0dwcxYD5ZhQnrsKdTOW
    z8axbIARZz+UVzqlymVlj/qQFb/aLdogA+8+s0oHfE/5TEbZhQQF8sD5ZK6Yb8KKvQ0b
    p/ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689590738;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=76E7kv/rz3wVZ9AmXO1y062UWjx+pg+DHG1to8xcAk4=;
    b=5643LMIpI8lLvb6zwAZK4uT+/Zt+G8FsZ+mwgYx24eEt1xGmrzbHFpYne4364F7TZI
    jvu+U2rfYrwXtmQk5mCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6HAjbXqF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Jul 2023 12:45:37 +0200 (CEST)
Date:   Mon, 17 Jul 2023 12:45:30 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v8 3/4] arm64: dts: qcom: sm6115: Add EUD dt node and
 dwc3 connector
Message-ID: <ZLUbyocjNT2bGvVt@gerhold.net>
References: <20230717103236.1246771-1-bhupesh.sharma@linaro.org>
 <20230717103236.1246771-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717103236.1246771-4-bhupesh.sharma@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 04:02:35PM +0530, Bhupesh Sharma wrote:
> Add the Embedded USB Debugger(EUD) device tree node for
> SM6115 / SM4250 SoC.
> 
> The node contains EUD base register region, EUD mode manager
> register region and TCSR Base register region along with the
> interrupt entry.
> 
> [...]
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 50 ++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 839c603512403..db45337c1082c 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> [...]
> @@ -789,6 +801,37 @@ gcc: clock-controller@1400000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		eud: eud@1610000 {
> +			compatible = "qcom,sm6115-eud", "qcom,eud";
> +			reg = <0x0 0x01610000 0x0 0x2000>,
> +			      <0x0 0x01612000 0x0 0x1000>,
> +			      <0x0 0x003c0000 0x0 0x40000>;
> +			reg-names = "eud-base", "eud-mode-mgr", "tcsr-base";

TCSR is a separate hardware block unrelated to the EUD. IMHO it
shouldn't be listed as "reg" here.

Typically we describe it as syscon and then reference it from other
nodes. See e.g. sm8450.dtsi "tcsr: syscon@1fc0000" referenced in &scm
"qcom,dload-mode = <&tcsr 0x13000>". This is pretty much exactly the
same use case as you have. It also uses this to write something with
qcom_scm_io_writel() at the end.

Thanks,
Stephan
