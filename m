Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DC676E36D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjHCIop convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Aug 2023 04:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjHCIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:44:40 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC2611D;
        Thu,  3 Aug 2023 01:44:37 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qRTwg-001WrE-8V; Thu, 03 Aug 2023 10:44:34 +0200
Received: from p5b13a085.dip0.t-ipconnect.de ([91.19.160.133] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qRTwg-002tWG-0z; Thu, 03 Aug 2023 10:44:34 +0200
Message-ID: <fecb873aefad8dd4c1d89935cf8f7790e9ba231d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] sh: remove superhyway bus support
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     "D. Jeff Dionne" <djeffdionne@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 03 Aug 2023 10:44:33 +0200
In-Reply-To: <D28BDDE3-7FE6-4ACC-98B9-B6AB6D9518A3@gmail.com>
References: <20230802184849.1019466-3-arnd@kernel.org>
         <D28BDDE3-7FE6-4ACC-98B9-B6AB6D9518A3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.133
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff!

On Thu, 2023-08-03 at 16:58 +0900, D. Jeff Dionne wrote:
> On Aug 3, 2023, at 04:15, Arnd Bergmann <arnd@kernel.org> wrote:
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > superhyway was only referenced on sh4-202, which is now gone, so remove it all as well.
> > 
> > I could find no trace of anything ever calling
> > superhyway_register_driver(), not in the git history but also not on the web, so I assume this has never served any purpose on mainline kernels.
> 
> I don’t know, but I think it is fairly safe to assume that there were no superhyway implementations other than internal to SuperH Co (or Hitachi).  Probably not at ST either.
> 
> I think this board, and infrastructure, can go without affecting any actual (even historical) user.  If anyone wants further conformation that there are/were no users of this in the wild, raise a flag and I will find out.

OK, I'll think about applying this series. The thing is, we're going to convert SuperH
to device trees anyways. We're waiting now Yoshinori to post a rebased version of the
patch series.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
