Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C75771B60
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjHGHRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjHGHRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:17:33 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D79319B5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1691392638;
        bh=+OenNrBzAmqFCbFqHNyWHPn56bzmSEBQTvxhWepBQiA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VRJ1o5A9UvpCUETjuIkPFZjnkaR0N0Zss8H5NkKo0TFrWaQtMpDI//g3JxQRUlTmk
         bLTUri9IuPCHa1ZxfbJlcHJTPQnNKCtQifWMgtbNhlmc6ixF0DzNbG2sozy2SmgWiB
         1d9qypQ1r3O0MikTFYD0MqpxUvORLTGj5UGiFXx0=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 46BC1659AD;
        Mon,  7 Aug 2023 03:17:05 -0400 (EDT)
Message-ID: <254baed00504ef3cec36e58540a3fdcca346a407.camel@xry111.site>
Subject: Re: [PATCH v2] LoongArch: Replace -ffreestanding with finer-grained
 -fno-builtin's
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 07 Aug 2023 15:16:59 +0800
In-Reply-To: <d591bfef-9146-abf6-04d0-96600ebb7a15@xen0n.name>
References: <20230806083021.2243574-1-kernel@xen0n.name>
         <CAAhV-H4ypd-+z-KbeGM6C_mNk0aggk2yhdDik-XfPNWqsO=j=A@mail.gmail.com>
         <d591bfef-9146-abf6-04d0-96600ebb7a15@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-08-06 at 18:31 +0800, WANG Xuerui wrote:
> > > +cflags-y +=3D -fno-builtin-memcpy -fno-builtin-memmove -fno-builtin-=
memset

Can we only apply them for GCC <=3D 13?  I think with GCC 14 the built-in
implementations are quite reasonable (well, maybe it's some human ego
because I wrote them :).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
