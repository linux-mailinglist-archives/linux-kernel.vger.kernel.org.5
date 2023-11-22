Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FF37F460F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbjKVMZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjKVMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:25:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8510F2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:25:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59990C43142;
        Wed, 22 Nov 2023 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700655927;
        bh=oqJMUoWJEhPsBbu0gDpzxXA6F0uFWKXoqQOh+lSyF7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0oXtWwQNk8JD/VG0PZ0PYNh8N9rB9rW5vX7MchrKQMxU8DtlWNmmOVFGivQ2cmnH
         w9Syh1QLRSPtZe9ZXT31po9IuEsHHyUkMjp+lU/7QIwVFfMrl492faNk4Gdl9edWbj
         yVZtrahi59PwxeQjLB5u2yZTaiRxP5/5d021OmnlW1vWJAO2UdZJmkrHjDImeRNd6b
         HgcN65AwvzDhQI3zfZHfO9FFBpoM8tPLUOPuWGyRjQKDC5ggitn9qHN2wff5vB1hPX
         iL2J7YinckVEwBVTgvBGSP79/yL2E55vYbQYvN73x5zcpbskEinI7yTumfLuObY1v2
         Z82tmE9TgGvaQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5mIY-0000CO-0V;
        Wed, 22 Nov 2023 13:25:42 +0100
Date:   Wed, 22 Nov 2023 13:25:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: [PATCH 09/12] dt-bindings: usb: qcom,dwc3: Rename to "glue"
Message-ID: <ZV3zRqjjlT06N7Kw@hovoldconsulting.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-9-ab4a84165470@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dwc3-refactor-v1-9-ab4a84165470@quicinc.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:11:17PM -0700, Bjorn Andersson wrote:
> The Qualcomm USB block consists of three intertwined parts, the XHCI,
> the DWC3 core and the Qualcomm DWC3 glue. The exsting binding represents
> the Qualcomm glue part, with the other two represented as in a child
> node.
> 
> Rename the qcom,dwc3 binding, to represent that this is indeed only the
> glue part, to make room for a combined binding.
> 
> The large "select" is included to avoid the schema to be selected for
> validation with the upcoming flattened binding - which includes
> snps,dwc3 in the compatible.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
 
> -title: Qualcomm SuperSpeed DWC3 USB SoC controller
> +title: Qualcomm SuperSpeed DWC3 USB SoC controller glue
> +
> +description:
> +  This describes the Qualcomm glue-section of the SuperSpeed DWC3 USB
> +  controller found in many Qualcomm platforms, with the XHCI and DWC3 core

This should be "xHCI" throughout the series.

> +  portions described as a separate child device.
> +  The combined representation, defined by qcom,dwc3.yaml is preferred.

Johan
