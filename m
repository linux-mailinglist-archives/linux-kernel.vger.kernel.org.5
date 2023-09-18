Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA457A53D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjIRUUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjIRUT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:19:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE008F;
        Mon, 18 Sep 2023 13:19:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48365C433C8;
        Mon, 18 Sep 2023 20:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695068392;
        bh=lgKTJttU3vBHsXfAuVjsF6p8uoUUCVqIrWPXUqL2PhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VhsXJc+fdL3QjF0Vl3Md17K5xmCYwSXa2Po1SZHG8jjc75demx/YE3T/oRG6EPoJB
         64XofwD39/KUKOcPtd/FD9BhlT4bVBR3d0FMG4gLlCkYjf5JNC71skeNTFkPZcLJ/3
         NrGLk1Z1DvgbA3Ag64A0Oz4BfYOiaGK+zNTaD5Fz6CnJghwz58XGOkNoHLuNgdMtSc
         mL7ddF8yggeeBHtEFhKfYaDdVmK4BjOyP4eyfDOSiixoqtgVr7HYKTbHt9i6ca54Y0
         P56iYbUVDkWoWJ8mZvTai+dUfPgeB+mqdlPXjndxI2yqGPse/7l+WnpWdO2Xjru8rb
         8alOB8nAFiMpA==
Received: (nullmailer pid 1711800 invoked by uid 1000);
        Mon, 18 Sep 2023 20:19:49 -0000
Date:   Mon, 18 Sep 2023 15:19:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     andersson@kernel.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com, Thinh.Nguyen@synopsys.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        lgirdwood@gmail.com, mathias.nyman@intel.com, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, agross@kernel.org, conor+dt@kernel.org,
        bgoswami@quicinc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 14/33] dt-bindings: usb: xhci: Add num-hc-interrupters
 definition
Message-ID: <169506838863.1711748.10580032008247397299.robh@kernel.org>
References: <20230916001026.315-1-quic_wcheng@quicinc.com>
 <20230916001026.315-15-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916001026.315-15-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Sep 2023 17:10:07 -0700, Wesley Cheng wrote:
> Add the definition for how many interrupts the XHCI host controller should
> allocate.  XHCI can potentially support up to 1024 interrupters, which
> implementations may want to limit.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

