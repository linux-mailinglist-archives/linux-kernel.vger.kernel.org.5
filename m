Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E376799BE0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 00:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjIIWHH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Sep 2023 18:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjIIWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 18:07:05 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E987D9;
        Sat,  9 Sep 2023 15:07:00 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qf66U-003ZTJ-9l; Sun, 10 Sep 2023 00:06:58 +0200
Received: from dynamic-089-014-158-203.89.14.pool.telefonica.de ([89.14.158.203] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qf66U-002Ij2-2q; Sun, 10 Sep 2023 00:06:58 +0200
Message-ID: <06b34c01b1781ae76df1f037bcde261f9bdc162e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/4] sh: remove stale microdev board
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 10 Sep 2023 00:06:49 +0200
In-Reply-To: <20230802184849.1019466-1-arnd@kernel.org>
References: <20230802184849.1019466-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.14.158.203
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On Wed, 2023-08-02 at 20:48 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This board was an early prototype platform for early SH4 CPUs and related
> to the already removed SH5 cayman platform.
> 
> The microdev board itself has been kept in the tree for this long despite
> being in a bad shape even 20 years ago when it got merged, with no working
> PCI support and ugly workarounds for its I/O port implementation that
> try to emulate PC style peripheral access despite being quite different
> in reality.
> 
> As far as I can tell, the ethernet, display, USB and PCI devices on it
> already broke at some point (afbb9d8d5266b, 46bc85872040a), so I
> think we can just remove it entirely.

The series didn't apply cleanly against v6.5-rc1.

Could you rebase against v6.6-rc1 once it's out so I can pick up this
series for v6.7?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
