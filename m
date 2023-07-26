Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63D9763AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjGZPRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjGZPRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:17:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EB8213F;
        Wed, 26 Jul 2023 08:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9672C61B19;
        Wed, 26 Jul 2023 15:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057A0C433C8;
        Wed, 26 Jul 2023 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690384601;
        bh=jXmlPNBNKU/m6JnEaxERgV4+Wjg7gBsUypiX9XsIgXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bdNnh1nWVplqfOpP1fTLlWY2pNs7zfk4AqckXmX8HWQ/oXGppHQ8m7g9+qB8jz68r
         RBEPZoBGZhM8vItiWYu4N4MtJUS8gQ5Ceon1DqUb6VZDZ1aFOfWbw+LSvubfA3NkgT
         D6JtEOAE2M+eRRT8sTw6M9jTCJc+2qjgQqgqcROhhKr+3lLIEGgozDqDeNGavJGAC1
         aBJunax+8eIwjQGQVztHaeaEw14alyvu6kfz0J96+DIEWRHU+fItzAFQRIUaND7B66
         mzzI1DoKRh1nFgHr/vMhwiAwXH/CF7uvtwOTUn97UXdfTblX/VTo6xksaT7IEVY625
         2awRO955WfAnQ==
Received: (nullmailer pid 1463673 invoked by uid 1000);
        Wed, 26 Jul 2023 15:16:38 -0000
Date:   Wed, 26 Jul 2023 09:16:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>, coresight@lists.linaro.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 12/13] dt-bindings: arm: Add support for DSB MSR
 register
Message-ID: <169038457610.1463167.3960750985842576776.robh@kernel.org>
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
 <1690269353-10829-13-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690269353-10829-13-git-send-email-quic_taozha@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 15:15:52 +0800, Tao Zhang wrote:
> Add property "qcom,dsb-msrs-num" to support DSB(Discrete Single
> Bit) MSR(mux select register) for TPDM. It specifies the number
> of MSR registers supported by the DSB TDPM.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring <robh@kernel.org>



