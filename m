Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8331A7FA29B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjK0O2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjK0O2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:28:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006AA59FA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:08:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C873C433C9;
        Mon, 27 Nov 2023 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701094123;
        bh=wn7K+MJ4CCUYwE/Jmw8x+LP459OMd0Ff92Uy1W27qFY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NZsq3uLNd/9703PT2wWztiWDYt9MEeniA4F061hp7w0uYqIxzzOecYGkZt5kF6y2p
         sP0wDVz/zjFuYX5N6bNrZlN8DcJ1ueKUiRJTx64PE9q3dMlhEEJXpU6U94cQxuXLER
         tdBeiDszeaSOyccm7v746m9G7r91DOJoeVUHLlz9N4nkeOAc9fcFm3AkJvqdhQj7jB
         jqALVZGfpJsDY/kgjh+jPa7urVBy3589nwmW4XyNNTc6XIUBYStU7eHhd7oHN4tIu7
         FGLADXux5JurYFIBHH2kkfzO0izX62BOOeRXG/WDVBLF1KueQ+3+XkabbKtsp0DIDe
         lqp5MpnLp73gw==
Message-ID: <7fbe4090-94cd-4aaf-98b6-07f2a089d51a@kernel.org>
Date:   Mon, 27 Nov 2023 16:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] interconnect: qcom: Introduce support for SM8650
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
References: <20231123-topic-sm8650-upstream-interconnect-v2-0-7e050874f59b@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20231123-topic-sm8650-upstream-interconnect-v2-0-7e050874f59b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.23 15:32, Neil Armstrong wrote:
> This covers the RPMh Network-On-Chip Interconnect bindings
> and driver for the interconnect framework.

Thanks Neil!

> As reported for earlier Interconnect drivers, the IDs
> for multi-rsc voting has been removed from this driver
> so the proper solution can be developed without having
> to remove entries later on.
> 
> To easy Bjorn into merging the DT bits, would it be possible
> to have an immutable branch with bindings shared with Bjorn once
> this patchset have been properly reviewed and accepted ?

Hi Bjorn,

Here is a stable branch with the DT bindings header that might be needed
for SM8650 dts patches.

https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git/log/?h=icc-sm8650

Thanks,
Georgi

> 
> Dependencies: None
> 
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Collected Reviewed-by
> - Moved required block in bindings as requested by Krzysztof
> - Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org

