Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCDE766B96
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjG1LVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjG1LVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:21:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5491731;
        Fri, 28 Jul 2023 04:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 652D1620FF;
        Fri, 28 Jul 2023 11:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA6EC433C7;
        Fri, 28 Jul 2023 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690543289;
        bh=5Ljg5W9xJaG5OJJ6VBPirbBblULOZWgo2u2fBfwRRzs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=nAxu22Kn7bch92daBwFiFa+4mSC/bM0i0o4OUjpIayEoZRQr32PFJbtLu8x8yc40L
         1T73YSkZLu2c9vRysRVSvFlW2pM5hNZHMoFtiTtBEpHyDOAdmFr4otf48YtyP7mRma
         wkwcf0OMeLh3k/ThE95bXZmfP5U4T2ZZzblf2mInK0vW5wocHtRIVZ6dImvTS5eiCP
         Xsb6i9MxCBRNRJtPJLGjORtZVg0BEUBjeJpt0pGTJaRc+pE1W+Hhz2oLeVz5T9jiPn
         YDMHB4pjUpjSLSywB3BV/AiJDcPZSUBjNgjuEKL3TkmweCluXnZjlDmE9DGSg796G3
         0iTxBoEIg2QlA==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726065633.74924-1-krzysztof.kozlowski@linaro.org>
References: <20230726065633.74924-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: st,stpmic1: Merge patterns
 for nodes
Message-Id: <169054328743.350271.8132596639688808363.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 12:21:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 08:56:32 +0200, Krzysztof Kozlowski wrote:
> Properties should be described only once, thus having separate pattern
> for children just to specify the $ref to regulator.yaml is not correct.
> It also makes impossible to finish it with
> additional/unevaluatedProperties:false to restrict allowed properties in
> regulator node.
> 
> Merge the patterns, so each regulator subnode has regulator.yaml $ref,
> additional properties and ends with additionalProperties:false.  This
> points to missing regulator-min/max-microvolt in LDO4 node.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: st,stpmic1: Merge patterns for nodes
      commit: 36392f2ca024765039fa45fc5b085210998ffc7a
[2/2] dt-bindings: mfd: stericsson,db8500-prcmu: Add missing unevaluatedProperties for each regulator
      commit: 3d2b5d02738ee802f44f3f9c6ae8932e548188d6

--
Lee Jones [李琼斯]

