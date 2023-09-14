Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9B379FBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjINGYA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 02:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjINGX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:23:59 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD24A98;
        Wed, 13 Sep 2023 23:23:54 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.96)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qgflP-002rc2-1L; Thu, 14 Sep 2023 08:23:43 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.96)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qgflP-0030DN-0a; Thu, 14 Sep 2023 08:23:43 +0200
Message-ID: <70e9fe45ca8bbe2dec5541a0c21bee3de8f82f91.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Sep 2023 08:23:42 +0200
In-Reply-To: <190041c8-2d99-4bc3-adc3-6fbe902c1265@app.fastmail.com>
References: <20230802184849.1019466-1-arnd@kernel.org>
         <20230802184849.1019466-4-arnd@kernel.org>
         <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
         <5dad2d86-78ea-4a39-8ee1-98e3eb134d36@app.fastmail.com>
         <CAMuHMdVYcvPL+JpPw9sA48=615cdfwa8d0LP-bVp0NWqbQ+JOw@mail.gmail.com>
         <190041c8-2d99-4bc3-adc3-6fbe902c1265@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On Wed, 2023-09-13 at 16:30 +0200, Arnd Bergmann wrote:
> > In the meantime, there is a v2, which I wasn't aware of when I wrote
> > my previous email, so perhaps my comment is no longer valid.
> > "[RFC PATCH v2 00/30] Device Tree support for SH7751 based board"
> > https://lore.kernel.org/linux-sh/cover.1694596125.git.ysato@users.sourceforge.jp
> 
> Right, it looks like the GENERIC_IOMAP part if gone from that
> series, and I also see that the PCI host bridge does not actually
> map the port I/O window. That's usually fine because very few
> drivers actually need it, and it also means that there should be
> no need for GENERIC_IOMAP or the simpler alternative.
> 
> The first version probably only did it accidentally, which is a
> common mistake, and I think the ones for hexagon, m68k, and
> mips can probably be removed as well with some simplifiations.
> 
> x86 and ia64 want GENERIC_IOMAP because they require using
> custom instructions for accessing IORESOURCE_IO registers,
> but it's not really generic.

Would you suggest to apply your series before or after Yoshinori's series to
convert arch/sh to device trees? If you want it to go in before the conversion,
could you rebase your series against v6.6-rc1?

I'm asking because the current version did not apply against v6.5-rc2.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
