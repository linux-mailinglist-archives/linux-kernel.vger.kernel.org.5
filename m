Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5522377821D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjHJUYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjHJUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF67B273D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F16D6688B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBF3C433C7;
        Thu, 10 Aug 2023 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691699084;
        bh=jopQY+MDrQTMS3xALVuBPVjTeyBhfxPaw9HNa4wXAqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0nLVAaoxggl1/VDsP7crLb2P+88Vnh1A84/Ue4PnQePt83IrJVnvEy426UHvOBWN
         g9M3L9OfbV5hxhTy/lGhtGA2nVYwBEnT+HVHB9u9+eyNAtynVyk78yqJP++v+M2eMg
         o1mQPherG59JnkmVxIE0ZrhDUkKRYJY/2jlnNzCH+ab6YtG31qWno8HVatk3BwrupB
         A1ZDNxbrR+J3ecPePjE1ibk+9rDlch70w3+KwD6c2jiNrYAb0K+W+DqUxKO2i9KoP4
         Zkr0jN9Nt6JFTfRGfFW894ekLhW+QKvr5eHIPdt1AJr7qhJrkkfc9LgbsStA4rcKBA
         z4GUfLey3zlkA==
Date:   Thu, 10 Aug 2023 22:24:38 +0200
From:   Simon Horman <horms@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH net-next 2/2] net/marvell: fix Wvoid-pointer-to-enum-cast
 warning
Message-ID: <ZNVHhslhaVJOO/tI@vergenet.net>
References: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
 <20230810103923.151226-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810103923.151226-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:39:23PM +0200, Krzysztof Kozlowski wrote:
> 'type' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>   mvmdio.c:272:9: error: cast to smaller integer type 'enum orion_mdio_bus_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
