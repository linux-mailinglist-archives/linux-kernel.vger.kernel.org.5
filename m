Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19DE763CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjGZQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjGZQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402222118;
        Wed, 26 Jul 2023 09:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA93861B91;
        Wed, 26 Jul 2023 16:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375B1C433C8;
        Wed, 26 Jul 2023 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690389704;
        bh=CS9RMuDaUok8xZl/RidQR1ehhEMJPsgbH3ctQzoSDmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3NwI4yK630H5roG4L5eGP+eMawDj91qe3/cbMB3nsEPLoCCehBLYWTXPOw8I3XqH
         DEwaFxOZAhWGC5/y2XY/loJNeC5u21YiLaIieZV0Zf7fv5uAYqjTJcxoXK/qYQtsGV
         g+OafF5uyMWbwcTz7/Col/KiPUri0oB37xJbdJRTRnvYpaLXYVDBIJHK+Qbf2OHvUh
         lO+WfpI/Mydt6D3dNSEJX344+M6TMlvEDrpVZaoQp/mx5ZFFuLfLxppL13qnGpyJJ9
         OtUfmcpA2d/zjkafxU8O/faXhezvKvU/RT7qp2NUNDXZJbS06nM9y6J6cZp4HIZ8tY
         A4U2nEJrVpGvw==
Received: (nullmailer pid 1563413 invoked by uid 1000);
        Wed, 26 Jul 2023 16:41:42 -0000
Date:   Wed, 26 Jul 2023 10:41:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: arm: msm: kpss-acc: Revert "dt-bindings:
 arm: msm: kpss-acc: Make the optional reg truly optional"
Message-ID: <169038970170.1563359.11519848655721979990.robh@kernel.org>
References: <20230724090109.19489-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724090109.19489-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Jul 2023 11:01:09 +0200, Krzysztof Kozlowski wrote:
> This reverts commit 981be238e1d28e156aa9da2a8722f86f02fd0453 because it
> was totally bogus and duplicated existing minItems:
> 
>   ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>   Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml: ignoring, error parsing file
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

