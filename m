Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEA477FC8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353567AbjHQRHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353402AbjHQRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E22D7D;
        Thu, 17 Aug 2023 10:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD97561E59;
        Thu, 17 Aug 2023 17:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B94C433C7;
        Thu, 17 Aug 2023 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292061;
        bh=jjLMJQLkvBtPmN2DZO+wAXBMk5uQ7gi9EiUBK0dmS5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPF0kOUF36cY8Ge4aicrd+cOzkG+UYr6dgNy5ouH0jzZuuaGdCwkZqulHjGZ4wGdm
         Ucfyr1fDIDAI/u+gYOKmgYT+GDa8HKDgSNy7ll9E0VFiHzinTiGZRxWbn1pvp7bgMs
         DkEQpWYSRA4v7/B+jz94T+VzR0wPqBOmjgvGsxmslBv6bCOXwd7qkNIW5U+87fc7Kv
         6bKIsWUCKAfsYmFT+wgyeN/3Pfi4JF0yV2juBS4A/kFQ2Xa4BpjvPPlJUhd8didGqX
         70n8CoPDRVlgJSZc/ArPZbOtNrqTWUkLoYXK23v4lq+fXlNwOeQMjrEn6rmplgopDw
         OItlFBsvSO3cw==
Date:   Thu, 17 Aug 2023 18:07:36 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: Add ti,dss-oldi-io-ctrl
 compatible
Message-ID: <20230817170736.GK986605@google.com>
References: <20230809165752.46133-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809165752.46133-1-afd@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023, Andrew Davis wrote:

> Add TI DSS OLDI-IO control registers compatible. This is a region of 5
> 32bit registers found in the TI AM65 CTRL_MMR0 register space[0]. They
> are used to control the characteristics of the OLDI DATA/CLK IO as needed
> by the DSS display controller node.
> 
> [0] https://www.ti.com/lit/pdf/spruid7
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Dropping.  Please resubmit once the discussion is over.

> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 8103154bbb529..5029abd6d6411 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -69,6 +69,7 @@ properties:
>                - rockchip,rk3588-qos
>                - rockchip,rv1126-qos
>                - starfive,jh7100-sysmain
> +              - ti,dss-oldi-io-ctrl
>  
>            - const: syscon
>  
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
