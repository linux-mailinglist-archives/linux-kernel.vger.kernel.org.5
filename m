Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A3761FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGYRPb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 13:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGYRP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:15:29 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B9611F;
        Tue, 25 Jul 2023 10:15:19 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qOLcw-001mdv-ED; Tue, 25 Jul 2023 19:15:14 +0200
Received: from p5086d382.dip0.t-ipconnect.de ([80.134.211.130] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qOLcw-001NaV-6S; Tue, 25 Jul 2023 19:15:14 +0200
Message-ID: <605d12e8a4fdcb238efc9b18fbd2637474de0049.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sparc: Use shared font data
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     davem@davemloft.net, benh@kernel.crashing.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jul 2023 19:15:08 +0200
In-Reply-To: <ZL/+Bz5C2Mxx0Msw@gallifrey>
References: <20230724235851.165871-1-linux@treblig.org>
         <20230725161040.GA832394@ravnborg.org> <ZL/+Bz5C2Mxx0Msw@gallifrey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 80.134.211.130
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave!

On Tue, 2023-07-25 at 16:53 +0000, Dr. David Alan Gilbert wrote:
> * Sam Ravnborg (sam@ravnborg.org) wrote:
> > On Tue, Jul 25, 2023 at 12:58:51AM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > sparc has a 'btext' font used for the console which is almost identical
> > > to the shared font_sun8x16, so use it rather than duplicating the data.
> > > 
> > > They were actually identical until about a decade ago when
> > >    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
> > >                         "broken bar" to "vertical line"")
> > > 
> > > which changed the | in the shared font to be a solid
> > > bar rather than a broken bar.  That's the only difference.
> > > 
> > > This was originally spotted by PMD which noticed that PPC does
> > > the same thing with the same data, and they also share a bunch
> > > of functions to manipulate the data.  The PPC code and the functions
> > > I'll look at another time if this patch is OK.
> > > 
> > > Tested very lightly with a boot without FS in qemu.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > Looks good, thanks for the fixes.
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Thanks
> 
> > Let's hope someone picks it up...
> 
> I was hoping Dave would, but I realise Sparc doesn't get much
> these days.
> Of course if anyone feels guilty about their own patches adding code
> they can take this patch to make ~340 lines of penance.

You can ask Andrew Morton to pick it up through his tree. He usually does
that when no one else is willing to pick a patch up.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
