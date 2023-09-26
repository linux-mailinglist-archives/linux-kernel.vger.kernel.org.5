Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D039F7AF30B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjIZSgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjIZSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:36:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99C10A;
        Tue, 26 Sep 2023 11:36:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039DDC433C8;
        Tue, 26 Sep 2023 18:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695753393;
        bh=nB/bYvjQ2YqbWoDt/ygO0b3k0aUmsxkxaDBANtllUf0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J9n4VCgFEXCzXV3XHV2G304PB6SdxK9ZIn5W/NJY5vAerglOuQQvsFjZvFr9b9Uaw
         cJgJwLl84c9dRrkoGtaPx97/hGotwOKtDNVzOEaBUWLzbsGPwpOyKtngIHg9WNdUJB
         1fo5aATu4GmFra5DPTpTloSvbQvV9PVUImiZFeOoeQu8io1+R6RQRFEJvLz9w/zRpX
         icl0XqSdOUuUdD9Q2r2PRIQp0EpiumO/7RDP2bNwM4HKCkISEg8cENqYigfjtFtefQ
         GfxdwrFC15UWTrSOyTNxCyIkdfQApRHnZ+s6VkDAkJFJ3ngQJtaaEt7OsZvIbV+I8O
         ng6LAvBGaFrbg==
Message-ID: <77fa12a6-a81f-4fdd-a29c-145e9ca02a83@kernel.org>
Date:   Tue, 26 Sep 2023 21:36:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: memory-controllers: Make
 "additionalProperties: true" explicit
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20230925212626.1974676-1-robh@kernel.org>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230925212626.1974676-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/09/2023 00:26, Rob Herring wrote:
> Make it explicit that child nodes have additional properties and the
> child node schema is not complete. The complete schemas are applied
> separately based the compatible strings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/memory-controllers/ingenic,nemc.yaml    | 1 +
>  .../devicetree/bindings/memory-controllers/renesas,rpc-if.yaml  | 2 ++
>  .../devicetree/bindings/memory-controllers/ti,gpmc.yaml         | 2 +-

For ti,gpmc.yaml

Reviewed-by: Roger Quadros <rogerq@kernel.org>
