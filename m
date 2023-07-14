Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F883754338
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbjGNTa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGNTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:30:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F04A3A84;
        Fri, 14 Jul 2023 12:30:51 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.15]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MUGyh-1qTVA632tX-00REWL; Fri, 14 Jul 2023 21:30:13 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 249BC3E8B2; Fri, 14 Jul 2023 21:30:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1689363012; bh=CISj4qU9OcEeQGiukeYRyVdl6TwuDHKzkw84duv5uOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQhYJXlYNhUA8LuEu3QcFFlBGoJszh3QDoycoPRXrkQony/dLev6cSqroq1DNN34V
         MzY3u/9fItFdTHT6t0UgBgfjLX0t7mkv7ke89PU3aykkr1uNJNFgeHn1jWJtsUCM7m
         0PQO16AoHHweFpz4/lAhptzi/ISKnms/7g7iXZPE=
Date:   Fri, 14 Jul 2023 21:30:11 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: flatten KBUILD_CFLAGS
Message-ID: <ZLGiQxF5ffbWR7tR@fjasle.eu>
References: <4f414a87-0c54-44bd-b218-f6f0b22c57ef@p183>
 <ZLEmgxm73zzmffWD@fjasle.eu>
 <4dc7e56c-6692-4d4c-a8d2-05abe4501e66@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dc7e56c-6692-4d4c-a8d2-05abe4501e66@p183>
X-Provags-ID: V03:K1:RV94P47dRwqIWQzk2E1jpf7PQqVEUEbiiKo03YWPfAdjKM/YZSz
 XuOdV/Y1JikVgCIKGDJU5DMdgAjuEnV12nvb44/csvihOjs70L7PWppKOUQrytHOj9zwATH
 8e11Ch1wLsUSMdkWdxoS+kGsu5PYcjo86oaSVaZ33E9gZnrRZcyFWC9vevHTk0LiQXEFsMi
 hsB/i+FwnLNXY3YGAW4sQ==
UI-OutboundReport: notjunk:1;M01:P0:Uc1P/VNFwcE=;v+jzC2Sc9Qq7gBx8sn68yFh5AYB
 0l9Rp0e2vuTltDs7wUfq9YrxoOonpuwYc9lHoZmO5THB+BvsJHy86xFbd8GtrHxiBLypA/cPW
 HV8MjW1mCqb4NeNR/oDvllhozSRbCA0bGfrvLmzq9xjpRJpIWbOGq+SNnVa6oDnSH1UScLzyb
 86AXdewm8qv6sMek090zdsBetcKiZjjRO7sl9QzcpE6ZZ5J6aRn6Qc7Xq+MxkDMxiK6ZX5UjC
 BaV+FtrSf9hWKU7Z57ZiEm3iKlVPRR+Qucc/5IQdNu1WwrdeZElUw2lrv9ptwgOfrsuwShvuR
 J3n8BvXAIbs/vDjaM5k79wdjpDt7USi8+0A9oPgSoVG0Dg9kwrtMfRqV6+G8JI/INe63F6FEJ
 K3w2puoN3RF6adwIoADH5RMUw10A6UjZy8Px14PTFwpABhChGA7w/Gpi7PM3hU6wioJNzNijv
 5exjSEAtO7sEZ6INSS/6ajMtV7WlejogYznHgNdO6CJivw0e1WHooVf2D+t0yKOldiUfd+nre
 l5IngG4LKP6HdL6J/ngrVANOsK4pyqgk+WB2gOCOL5Big0x4ZGyS9lvdiNjqPtXxmBfpKY5GW
 1xTzi4i0sdTyy03PftY1O594OFKBJdIk1rsM62l5Y4PGQ8mBWFzaYJcgVfDefl7aheoQ6kpXc
 RlX0auM/QuXYGiRx4kx2ZxI1pIaj9WaSBnjVmS5GUg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 08:45:00PM +0300 Alexey Dobriyan wrote:
> On Fri, Jul 14, 2023 at 12:42:11PM +0200, Nicolas Schier wrote:
> > On Thu, Jul 13, 2023 at 09:52:28PM +0300, Alexey Dobriyan wrote:
> > > Make it slightly easier to see which compiler options are added and
> > > removed (and not worry about column limit too!).
> > > 
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > ---
> > > 
> > >  Makefile |   22 +++++++++++++++++-----
> > >  1 file changed, 17 insertions(+), 5 deletions(-)
> > > 
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -555,11 +555,23 @@ LINUXINCLUDE    := \
> > >  		$(USERINCLUDE)
> > >  
> > >  KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
> > > -KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
> > > -		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
> > > -		   -Werror=implicit-function-declaration -Werror=implicit-int \
> > > -		   -Werror=return-type -Wno-format-security -funsigned-char \
> > > -		   -std=gnu11
> > > +
> > > +KBUILD_CFLAGS :=
> > > +KBUILD_CFLAGS += -std=gnu11
> > 
> > If you want to put -std at top, on contrast to the sorted options below,
> > you could also merge the two lines above.
> 
> I don't know. Standard choice is arguably the most important option
> so I put it first.

yes, I think I would have put it on top, too.  I just would write it this way:

    KBUILD_CFLAGS := -std=gnu11

    KBUILD_CFLAGS += ...

But it is bike-shedding, ignore it if you're not convinced.

Kind regards,
Nicolas


> > > +KBUILD_CFLAGS += -fshort-wchar
> > > +KBUILD_CFLAGS += -funsigned-char
> > > +KBUILD_CFLAGS += -fno-common
> > > +KBUILD_CFLAGS += -fno-PIE
> > > +KBUILD_CFLAGS += -fno-strict-aliasing
> > > +KBUILD_CFLAGS += -Wall
> > > +KBUILD_CFLAGS += -Wundef
> > > +KBUILD_CFLAGS += -Werror=implicit-function-declaration
> > > +KBUILD_CFLAGS += -Werror=implicit-int
> > > +KBUILD_CFLAGS += -Werror=return-type
> > > +KBUILD_CFLAGS += -Werror=strict-prototypes
> > > +KBUILD_CFLAGS += -Wno-format-security
> > > +KBUILD_CFLAGS += -Wno-trigraphs

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
