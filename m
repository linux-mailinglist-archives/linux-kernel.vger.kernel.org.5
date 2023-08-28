Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9578B40C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjH1PJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjH1PJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA6CF4;
        Mon, 28 Aug 2023 08:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2058C64B0A;
        Mon, 28 Aug 2023 15:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE0BC433C8;
        Mon, 28 Aug 2023 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693235345;
        bh=qPriMxSAV88FlSYV2Hrf0f+uevuvbEuOnhth6VkWAhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZG2x7KvTVu+TXqpxQ8vkSNUY3CsPxKm9qutibXDS0SG7dIjI688xT4/14YGbhIwU8
         /fvvBCETif+pYsVpCrk4mrqu7i2LwcqMEBIWanxmQmcHm0GmQZcRNgYxA3MgrWvI29
         0LDOm4yv+wMhGCoS20nmPb8gKHsuJzpZKeuRihqtHOnFCDtxMoRWFeNtGSJViq+PaA
         NoZo4Ab7LnvVs2BcwFW5w0ZKeqVei08rILh5S1EljhJMX/3skDb5mEQ8zibQFvpnh8
         0e4dJTUEpOKDAspNX1Cs3tmfWW5qlbm3aqk/bWPOOWnVojS2vtF27LAki5uDLrHNNN
         bDhOSkZ4R+vcA==
Received: (nullmailer pid 539828 invoked by uid 1000);
        Mon, 28 Aug 2023 15:09:03 -0000
Date:   Mon, 28 Aug 2023 10:09:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mips: loongson: Add LS1B demo board
Message-ID: <20230828150903.GA499616-robh@kernel.org>
References: <20230825124115.1177577-1-keguang.zhang@gmail.com>
 <2856de1b-36cd-1d56-734a-401def967870@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2856de1b-36cd-1d56-734a-401def967870@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 02:45:41PM +0200, Krzysztof Kozlowski wrote:
> On 25/08/2023 14:41, Keguang Zhang wrote:
> > Add compatible for LS1B demo board.
> 
> Where is the user of this binding? We do not add bindings without users.

Maybe board compatibles should be an exception? They are rarely/never 
used by the kernel so the only user will be a board dts. I'm not sure we 
care about having every board upstream.

Rob
