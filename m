Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4634766B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjG1K7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbjG1K7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:59:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA592701;
        Fri, 28 Jul 2023 03:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEB89620D2;
        Fri, 28 Jul 2023 10:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83DEC433C7;
        Fri, 28 Jul 2023 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690541970;
        bh=GaR8fM1qvnhj2/WSSv0B+sHOorbQm8I8+qLSHbOpqu4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=sFNig5dUS4R8iWAyc4JmmdkV19ZKVuONYA//u4n6sx2nYxVGD7evahq+y9OQESrsd
         CKHOYeBCRNc2GFXRgQwZdjqEv9tOwDvv2Z/4TDK2jJ9uKkeygcf176N8UEtxaswQ2I
         k5xK4RqSURLjbnseR1x9OdTWLkh7wkKKVH3m2D/EqQ8wIQtYXEpy4HU1mp2vbWe8GB
         VSFmhFCQwyVhwzo0v5jpNxJ08AmhoUj8pknopKYMv4e8+Wqum7NySUoWeOWlLbZE75
         3YbpGEpsajbpFy20JsVrUmBrFR3kC5O9KWfqv0gv/+C9u78ygRp27Ls5F7g5h7M8SF
         NJI4jeYoPCcpw==
From:   Lee Jones <lee@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230723142842.98204-1-krzysztof.kozlowski@linaro.org>
References: <20230723142842.98204-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: maxim,max77693: Add USB
 connector
Message-Id: <169054196859.339271.10574297199743644900.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 11:59:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2023 16:28:42 +0200, Krzysztof Kozlowski wrote:
> Add micro-USB connector under "muic" node to properly represent the
> hardware.  Deprecate also the old "max77693-muic" in favor of generic
> "muic" (this is max77693, so there is no need to state it in its child
> nodes).  This "muic" node is used only to instantiate MUIC driver by
> compatible, thus actual Linux driver changes are needed.  Extend the
> example with this new code.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: maxim,max77693: Add USB connector
      commit: 0ddf8139e205a2adba575a552d7520f6e1849b7d

--
Lee Jones [李琼斯]

