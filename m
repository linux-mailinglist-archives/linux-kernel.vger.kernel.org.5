Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F3B7985C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbjIHKXy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbjIHKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:23:50 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2BE1FC0;
        Fri,  8 Sep 2023 03:23:09 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qeYcR-000mZf-Ob; Fri, 08 Sep 2023 12:21:43 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qeYcR-00250o-HD; Fri, 08 Sep 2023 12:21:43 +0200
Message-ID: <456ea951a34b3c599d990eddd15fee490fbaee37.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 08 Sep 2023 12:21:42 +0200
In-Reply-To: <CAMuHMdVf6pBn2O61ynkdk9MDj0WiMt-12ffvpzfgL51Kz4_Jfg@mail.gmail.com>
References: <20230802184849.1019466-1-arnd@kernel.org>
         <20230802184849.1019466-4-arnd@kernel.org>
         <d737e5a40f7e2009222d98de7696cc78740869e3.camel@physik.fu-berlin.de>
         <CAMuHMdVf6pBn2O61ynkdk9MDj0WiMt-12ffvpzfgL51Kz4_Jfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Fri, 2023-09-08 at 12:20 +0200, Geert Uytterhoeven wrote:
> > Why aren't you removing the function ioport_unmap(void __iomem *addr) completely
> > and just turn it into stub? Is it still referenced somewhere?
> 
> Because architectures are supposed to implement it (there is no
> __weak default).
> 
> An alternative would be to provide a dummy static inline, like
> e.g. m68k does:
> 
> arch/m68k/include/asm/kmap.h:#define ioport_unmap ioport_unmap
> arch/m68k/include/asm/kmap.h:static inline void ioport_unmap(void __iomem *p)
> arch/m68k/include/asm/kmap.h-{
> arch/m68k/include/asm/kmap.h-}

OK, that explains it. Thanks!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
