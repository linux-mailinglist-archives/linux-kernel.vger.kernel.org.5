Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E72D80075B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378004AbjLAJnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377992AbjLAJna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:43:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFE910DE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:43:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4C5C433C8;
        Fri,  1 Dec 2023 09:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701423815;
        bh=25pjr03NymDAPlM072b5W0m3OKHkhVTbuQtF6H2DbYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHlJlG1AuVQ5t+QkSYRXKfcsL4V0rPltvaY3mVNTv0OrI1OiK18w5oXvegqDzZSFd
         tCARYAiO/cn7Hjt9F8lvupwmpV5oDvNszdesbw6Rp16Blh7B4Y3Xjoh+1qJxfAZFxf
         ME+wREKAjSQG8kMYX6v9wyvETNhaqIVbgl31dc5XQbdd/ETpRfN4GUfAG2oi0eS/dx
         //6NIsLBza4yL6G9bvvrHYeIwlGSqPbYXecgpExB/tHYHekAgTIiadnZydTh4d1E4+
         FFyl5ydAzlMxlNw9FWsa5MJp7kt4FRZ6yJSX7uiY1rHXHT8mlWCFGPj/Ovwg9koWQc
         /ghBENR7OjUWw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r904B-0003K4-0M;
        Fri, 01 Dec 2023 10:44:11 +0100
Date:   Fri, 1 Dec 2023 10:44:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: soc: qcom: stats: Add QMP handle
Message-ID: <ZWmq619zryYHV_kK@hovoldconsulting.com>
References: <20231130-topic-ddr_sleep_stats-v1-0-5981c2e764b6@linaro.org>
 <20231130-topic-ddr_sleep_stats-v1-1-5981c2e764b6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130-topic-ddr_sleep_stats-v1-1-5981c2e764b6@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 03:58:21PM +0100, Konrad Dybcio wrote:
> The stats can be expanded by poking the Always-On Subsystem through QMP.
> Allow passing a QMP handle for configurations that support it.

I know Qualcomm likes their opaque acronyms, but how about mentioning
what QMP stands for here and in the binding below?

Especially since we also have QMP PHYs (Qualcomm Multi PHY?), which I
doubt this is related to.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml
> index 96a7f1822022..686a7ef2f48a 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml
> @@ -31,10 +31,24 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  qcom,qmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the AOSS side-channel message RAM

Johan
