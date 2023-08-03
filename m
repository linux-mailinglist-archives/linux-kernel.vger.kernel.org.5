Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C9A76E49E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjHCJhV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Aug 2023 05:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjHCJg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:36:27 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CC335A1;
        Thu,  3 Aug 2023 02:36:26 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qRUkq-001sGb-08; Thu, 03 Aug 2023 11:36:24 +0200
Received: from p57bd9cac.dip0.t-ipconnect.de ([87.189.156.172] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qRUkp-00321y-Ow; Thu, 03 Aug 2023 11:36:23 +0200
Message-ID: <13c836b31909f2eb64dcf2a5feb22c2a3173bba2.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] sh: remove superhyway bus support
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@kernel.org>,
        "D. Jeff Dionne" <djeffdionne@gmail.com>
Cc:     linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 03 Aug 2023 11:36:22 +0200
In-Reply-To: <4a3fae63-cf85-4e18-b785-1a438ec761aa@app.fastmail.com>
References: <20230802184849.1019466-3-arnd@kernel.org>
         <D28BDDE3-7FE6-4ACC-98B9-B6AB6D9518A3@gmail.com>
         <fecb873aefad8dd4c1d89935cf8f7790e9ba231d.camel@physik.fu-berlin.de>
         <4a3fae63-cf85-4e18-b785-1a438ec761aa@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.156.172
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On Thu, 2023-08-03 at 11:19 +0200, Arnd Bergmann wrote:
> Applying this first should definitely help with the DT conversion,
> especially not having to create a bus specific binding for superhyway
> would help, as converting that to DT would be a complete rewrite
> but also be untestable without drivers attaching to the bus.

OK, we'll discuss this on the #linux-sh IRC channel and if no one objects,
I'm going to apply the series.

> I would also recommend trying to eliminate most of the SoC
> support for chips that only support a reference board but no
> products or known user of the reference board itself. While
> a lot of the conversion could be done fairly mechanical, at
> least the clk driver for each chip is a huge effort.

It depends on what Yoshinori plans for the device tree conversion. The
latest version of his series was posted here [1]. But he promised to
send a rebased and updated version soon.

> I looked at the clk conversion in the past, as this is not just
> needed for the DT work, but also to remove CONFIG_HAVE_LEGACY_CLK.
> The patch series I did a while ago renames the sh clk interfaces
> to no longer conflict with COMMON_CLK, which should allow it
> to coexist with a DT-enabled platform in the same kernel build.
> Let me know if you'd like me to dig out and rebase that series,
> it probably still applies and may help you here.

Yes, that would be greatly appreciated. Please go ahead.

FWIW, I am currently on vacation until August 15th, so I might be a bit
slow with open source stuff. I am using the free time to get things done
on my TODO list.

Adrian

> [1] https://lore.kernel.org/all/20180507155543.GJ1392@brightrain.aerifal.cx/t/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
