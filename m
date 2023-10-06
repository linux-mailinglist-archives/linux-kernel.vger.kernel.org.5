Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603227BBD62
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjJFQ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjJFQ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:58:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23413C2;
        Fri,  6 Oct 2023 09:58:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488DFC433C7;
        Fri,  6 Oct 2023 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696611521;
        bh=NFj4vVc1fCIclAhI8pfhw7GEj2uuK7WTrV8YlLj1+g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIge65iud54gSg3U/szqIbnED9Y6mLJgsTie67JsedpY2Zo/62YlyIDGGQ4p9qNdt
         0cPNLtjSP+tgu1FbLUG2n1BtphDA610LRdel+/LcxrsLGAZfsg+R8uSdhTZiy8f2vm
         p9d537E7CR1abE765/vsyspVA24OkhLAe04MHiW22TWwIjDBg/faSocTOHzoo24oO8
         zVR0liAs8eQs/F9AbpnUeDgINt7w1nAQyXViwVRM8StyU7+zgCRYG9cadaCBW9QJ9f
         sL2AawGL3i4BNrjCey/gFhnLu8yJ4vPt9MgWT1ocDfFCL00Pq2T4OrWzCbS8AVnjm6
         f8Ae6rfSThs3g==
Received: (nullmailer pid 4069262 invoked by uid 1000);
        Fri, 06 Oct 2023 16:58:39 -0000
Date:   Fri, 6 Oct 2023 11:58:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: fix regex pattern for matching
 serial node children
Message-ID: <169661151881.4069209.6322844044130586278.robh@kernel.org>
References: <20231005093247.128166-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005093247.128166-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 05 Oct 2023 11:32:46 +0200, Krzysztof Kozlowski wrote:
> The regular expression pattern for matching serial node children should
> accept only nodes starting and ending with the set of words: bluetooth,
> gnss, gps or mcu.  Add missing brackets to enforce such matching.
> 
> Fixes: 0c559bc8abfb ("dt-bindings: serial: restrict possible child node names")
> Reported-by: Andreas Kemnade <andreas@kemnade.info>
> Closes: https://lore.kernel.org/all/20231004170021.36b32465@aktux/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

