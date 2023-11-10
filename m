Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F567E83C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbjKJU0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjKJU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:26:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E22A7532
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 05:28:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC265C433C8;
        Fri, 10 Nov 2023 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699622921;
        bh=RKp5JkDrgXTCaSZhsV2VwufdEyP5Z2U+wHi62OW9Q6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tODKqcpuMevzLNd4CWQL470DP6V+/C91mGFko7GtrGqiI5/8nJL+iaOSGXfe9iJam
         4+2AJKynIosW4XZVgpbwO9XoXEoZLdeJh5NBu9kxI3XgY35UdPOBey65o6O8wI5IjD
         O4+074ugJgTxCpnS/mBi7qoHI8ZpB8F8cL7nLhTkOSuElxIkqL8LTYTIwv7CY2WIGE
         2zc8BYyEA4oxTgNiw/zVbllNyov/yZMJpMuCG6ege/eGhVnGIXZ3gbmJUCN8lraQM3
         5mybm5OxBhiC1wALLfpbxcxiEju0Rvk4xfBu3+tDRWskYuvAvzuB/e/bmM00yIdGmW
         Hhmq9Cne10bGQ==
Received: from johan by theta with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r1RYp-0007mQ-1r;
        Fri, 10 Nov 2023 14:28:35 +0100
Date:   Fri, 10 Nov 2023 14:28:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v11 02/13] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Message-ID: <ZU4wA9xhfjYBCaTU@hovoldconsulting.com>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-3-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828133033.11988-3-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 07:00:22PM +0530, Krishna Kurapati wrote:
> Add bindings to indicate properties required to support multiport
> on Synopsys DWC3 controller.
> 
> Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index a696f23730d3..5bc941355b43 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -85,15 +85,16 @@ properties:
>  
>    phys:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 8
>  
>    phy-names:
>      minItems: 1
> -    maxItems: 2
> -    items:
> -      enum:
> -        - usb2-phy
> -        - usb3-phy
> +    maxItems: 8
> +    oneOf:
> +      - items:
> +          enum: [ usb2-phy, usb3-phy ]
> +      - items:
> +          pattern: "^usb[23]-port[0-3]$"

Shouldn't this just be

	pattern: "^usb[23]-[0-3]$"

so that it matches the names that are used by the nvidia bindings?

We already have some inconsistency in that Amlogic uses a variant based
on the legacy names that needlessly includes "phy" in the names:

	const: usb2-phy0
	const: usb2-phy1
	const: usb3-phy0
	...

I don't think we should be introducing a third naming scheme here so I
suggest just following the nvidia bindings.

Johan
