Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6897ADB7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjIYPdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjIYPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:32:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EC21B2;
        Mon, 25 Sep 2023 08:32:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43080C433C7;
        Mon, 25 Sep 2023 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695655968;
        bh=9kY8d7fPm3V2FOg2yCYMYdIUQkKXq5qEPj5+mr6AxjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzh3ktmgllWZnurSKje1C5WUioprloyGKlOqEw++66au/67Cim0L4bRmI4nWb2Vbh
         EFrUVleWajSCkB2nDQy1VInmsTZDBXBiKRHuvb4lqKs9PEXMBx6jXaup+iqdgVKjyK
         cMkMahfEzV2FmKGg8uAFMFM9ZirJIK6e9U7XaZ5kIuQY9UWYmeeCrXRbf+9BrhY+wt
         NCVCrsqsdXvTMrSbavWzvYU0eypoBLOapO0OI94LrJ0WROpvKFQ/JauhhHJkAeWaGA
         b/UOlojkMyOAhakNQE/AqzLI7eIwrpYMXMQM+raLmIujPWleo72qEMTbmZiOD2rbGd
         YO73uWW9MjEjw==
Received: (nullmailer pid 1409816 invoked by uid 1000);
        Mon, 25 Sep 2023 15:32:45 -0000
Date:   Mon, 25 Sep 2023 10:32:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     alsa-devel@alsa-project.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, bgoswami@quicinc.com, perex@perex.cz,
        gregkh@linuxfoundation.org, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, tiwai@suse.com,
        conor+dt@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Thinh.Nguyen@synopsys.com,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mathias.nyman@intel.com,
        konrad.dybcio@linaro.org
Subject: Re: [PATCH v7 13/33] dt-bindings: usb: dwc3: Limit
 num-hc-interrupters definition
Message-ID: <169565596417.1409760.904452104136965315.robh@kernel.org>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <20230921214843.18450-14-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921214843.18450-14-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Sep 2023 14:48:23 -0700, Wesley Cheng wrote:
> Ensure that the number of XHCI secondary interrupters defined for a DWC3
> based implementation is limited to 8.  XHCI in general can potentially
> support up to 1024 interrupters.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

