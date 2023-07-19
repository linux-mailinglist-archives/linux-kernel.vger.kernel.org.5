Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE7D758B93
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGSCyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSCyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A371BC9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BAAF616A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206D3C433C8;
        Wed, 19 Jul 2023 02:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689735255;
        bh=wlZfctky3f4PK8EC1uB7joPxedy1epUHYSMhC4EUhUY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tZf6/6a76OyeGixaJOFwU+ORSziU9wVBHSN+Z2MLWUH9dZydOURdxlBEtBRxTZsck
         C2oiq+IKiAQzUMQP0trAVCPLpjPeZIbhHWmKUigqARKPXIJfxLHlRWqT8w51laFm3u
         P7PoKoOik5KdhokVOx6gWXVTHiapOv7O+yMZpspgl8Vrh3xtK3jccVzMj9OMEJuVxL
         BNUASAAkUpkrv7RvH7/E6YsO2ci1YsWXYvcXLuv45UaF7ZXx8gE8uYPEIP8vuuaFyX
         z4bDa+KPriS2ThXw44nJdQoSdZOUypyAKQ2Bl4+kajv1U8qJAu/egr1yD1FqKPzGIw
         jd0y3w/oHhOeg==
Date:   Tue, 18 Jul 2023 19:54:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        mchan@broadcom.com, netdev@vger.kernel.org, pabeni@redhat.com,
        prashant@broadcom.com, siva.kallam@broadcom.com
Subject: Re: [PATCH] tg3: fix array subscript out of bounds compilation
 error
Message-ID: <20230718195414.4c6f359f@kernel.org>
In-Reply-To: <c196f8f9-3d2c-27c6-6807-75a6e6e4d5a5@amd.com>
References: <20230717143443.163732-1-carlos.bilbao@amd.com>
        <20230717192403.96187-1-kuniyu@amazon.com>
        <c196f8f9-3d2c-27c6-6807-75a6e6e4d5a5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 10:52:39 -0500 Carlos Bilbao wrote:
> >> Fix encountered compilation error in tg3.c where an array subscript wa=
s =20
> >=20
> > What is the error ? =20
>=20
> drivers/net/ethernet/broadcom/tg3.c: In function =E2=80=98tg3_init_one=E2=
=80=99:

What compiler are you using? Any extra flags?

I remember seeing this warning too, but I can't repro it now (gcc 13.1;
clang 16).

> >> above the array bounds of 'struct tg3_napi[5]'. Add an additional chec=
k in
> >> the for loop to ensure that it does not exceed the bounds of
> >> 'struct tg3_napi' (defined by TG3_IRQ_MAX_VECS).
> >>
> >> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>

We need a sign-off tag
--=20
pw-bot: cr
