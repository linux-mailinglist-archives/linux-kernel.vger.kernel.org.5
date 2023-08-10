Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544D1778221
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjHJUZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbjHJUZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB26273D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A796866898
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB26AC433C7;
        Thu, 10 Aug 2023 20:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691699101;
        bh=1YYXvFAoppm4M8kiOkIWEqbRmKvfNZDSn9Ngz3JPAKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nv2GjkKRJtwGJdVS4ReDMYIqunL3Pv+KtO1RireTzIkzYGUlPAjKoCRaSUhNqxQSU
         UJTlYVOgEz12+kLlvWlYteXKKNkZGy4E8XQBxQUBTdKiuXgByFkYBGZA5CJMuZyJdH
         Hg4ef9Y6DZ80my1N1Xf38e7y/O+0qU5lWt8Plj5LK7F6xa1JbJOrkrsSV28GcSYjk1
         mWLwzP617xZ9ooLH56OWglb6fiZy+fRadKZ1I2lG2kKKBohHOcCl7/8r2qDWySDWR+
         +J66ty5N0U288JNVifaIm0ZVWIKL+ZcbaDVDiFhaGTzwFj7e6R6DuKJdFHNAC2se6g
         WLhye1H8PCcnw==
Date:   Thu, 10 Aug 2023 22:24:56 +0200
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
Subject: Re: [PATCH net-next 1/2] net/xgene: fix Wvoid-pointer-to-enum-cast
 warning
Message-ID: <ZNVHmDgI9S1JKyht@vergenet.net>
References: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:39:22PM +0200, Krzysztof Kozlowski wrote:
> 'enet_id' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>   xgene_enet_main.c:2044:20: error: cast to smaller integer type 'enum xgene_enet_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
