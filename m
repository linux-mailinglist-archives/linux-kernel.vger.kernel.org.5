Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B32678B46D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjH1P0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjH1P0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB42CE0;
        Mon, 28 Aug 2023 08:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61F326159F;
        Mon, 28 Aug 2023 15:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFAEC433C7;
        Mon, 28 Aug 2023 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693236361;
        bh=fyWNGovzoeDje8CxRLrvvVXyOgXpzhQkMKQe4q48xL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FW6DUaH7WcqX81M30jg+1fRrAtPxaDcXdPyhJswG+qP2HaNgqHcPAD5k4lgOGCTzB
         XDYHcCKFL/wj7czE2sXKqyB6n6h9ON8tmAqxodRJKcZ1rvkOKZn2o86HjNLtyOhXYs
         Oaf8A4vjLSfzkbKotInRo1cAXYwpkI99ud6o+YTNYrDBGDnpfJ5bFGc5xv0aHd496Q
         F0Xd6FvF/z0lzl8f1rpjfH8caN7ApANlI7wNw6Wp9HsUec0hxwconehjVyvgBPdIo1
         UuRPv8ZQq+jiE2JN21jEBjol51bhfJtFqeC55Sb4IS5WSA6CTpHscBJEVu8kElyMBR
         UZFl630YWnTWQ==
Received: (nullmailer pid 585443 invoked by uid 1000);
        Mon, 28 Aug 2023 15:25:59 -0000
Date:   Mon, 28 Aug 2023 10:25:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,rpmh: do not require reg
 on SDX65 MC virt
Message-ID: <169323635886.585376.11658175824382059513.robh@kernel.org>
References: <20230827114026.47806-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827114026.47806-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Aug 2023 13:40:26 +0200, Krzysztof Kozlowski wrote:
> The MC virt interconnect in SDX65 DTSI does not have reg.  Similarly in
> the downstream DTS, thus assume this is an interconnect without own
> dedicated IO address space.  This fixes dtbs_check warnings like:
> 
>   qcom-sdx65-mtp.dtb: interconnect-mc-virt: 'reg' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

