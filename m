Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF047715EA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHFPhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 11:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHFPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 11:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1074171B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 08:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27913611AF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 15:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579F7C433C7;
        Sun,  6 Aug 2023 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691336226;
        bh=2mjUK8700j2g79TU7Ih+YIIZC0YtpcE+kTjNT8R0CGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsGd4QRKxt0EYKFdTHhkTw3chr5tuibu0t6WAJe5OHdfSMg+qMmcOUrAz7VHLVjx+
         8HZqicBCR2C3uNmmqt8FfB0PwZSr2/K/cDNTFiczGwWKdHQoMdk3CP8CMRoNvs0CH2
         mKhqq9MX3spfTbVK67nqyea0Z1MYlPmu9jVUD20x6/ss78WPchc33rcnyLV9D8FGjd
         RwFnH3ruq7PQEdmo0kv8bHwVN9E46h9wqAMrFpxo+3LFVnYgjJcztsXO2MxewWXNrv
         S/+2uOzKfWp5bkjYPmiV8pXeaf/H60Bsjt1DXpR7iFFW6sfPhIPHdvfMWZxoQsFQa1
         +Xvhb4jcbQnbg==
Date:   Sun, 6 Aug 2023 17:37:02 +0200
From:   Simon Horman <horms@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, robh@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 10/10] net: fs_enet: Use cpm_muram_xxx()
 functions instead of cpm_dpxxx() macros
Message-ID: <ZM++Hq8h6EUnUGQL@vergenet.net>
References: <cover.1691155346.git.christophe.leroy@csgroup.eu>
 <2400b3156891adb653dc387fff6393de10cf2b24.1691155347.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2400b3156891adb653dc387fff6393de10cf2b24.1691155347.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:30:20PM +0200, Christophe Leroy wrote:
> cpm_dpxxx() macros are now always referring to cpm_muram_xxx() fonctions

nit: fonctions -> functions

Thanks Christophe,

This minor nit notwithstanding, this series looks good to me.
I'll send a reviewed-by tag for the whole series in response
to the cover letter.

...
