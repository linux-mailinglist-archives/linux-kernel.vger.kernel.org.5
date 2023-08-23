Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0BB784E63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjHWBqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjHWBqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B9E4A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CADC461BFA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A172DC433C7;
        Wed, 23 Aug 2023 01:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692755205;
        bh=TsZD25Y/24LTSpkUXi5ab7o3lyZUrIrCSQaeiBB8jwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R15edRetBKcnFq8DTLxzpfxVenxWiQpVjITO0OaTo/HlqYgK25BvOT1Ur68fSVxJD
         4F8dN2bOvAfOfhjfHzM6XFdJhxslbaNQ6H85G4MeaQCVoSFUL4jQkeprIWHCygfz8d
         qcIHiQxA58RdQg0qNSEizuJ9KT+j3kRPm1xJtpC/DoM44R34WjeikXbVm8juyVf7FL
         Pbuj/C/CDHXz6qbSHuVbDOiYsDGeV5se9Uiq1fHXNc/84Vc7tsq0YfhdhDaNx4pgkW
         rISWaWit+2o/IVHN9IbTbYV1LIr6FHb6uDMHZZaKeeVlJPI1GtJWR6YXvDNinam6A2
         U2S/iuV8rrCog==
Date:   Tue, 22 Aug 2023 18:46:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH net-next] net: generalize calculation of skb extensions
 length
Message-ID: <20230822184644.18966d0f@kernel.org>
In-Reply-To: <20230822-skb_ext-simplify-v1-1-9dd047340ab5@weissschuh.net>
References: <20230822-skb_ext-simplify-v1-1-9dd047340ab5@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 08:51:57 +0200 Thomas Wei=C3=9Fschuh wrote:
> Remove the necessity to modify skb_ext_total_length() when new extension
> types are added.
> Also reduces the line count a bit.
>=20
> With optimizations enabled the function is folded down to a constant
> value as before.

Could you include more info about the compiler versions you tried
and maybe some objdump? We'll have to take your word for it getting
optimized out, would be great if we had more proof in the commit msg.
--=20
pw-bot: cr
