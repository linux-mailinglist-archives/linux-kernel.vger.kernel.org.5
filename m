Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB5D78EFD4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbjHaO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHaO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:56:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D121B1;
        Thu, 31 Aug 2023 07:56:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9A74B8231B;
        Thu, 31 Aug 2023 14:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECF3C433C9;
        Thu, 31 Aug 2023 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693493772;
        bh=jmlOubIGHQ2DoRnY5MFlnRc2j08gG6fBV336tJEzh8U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hWprHtsQI7WZikkrJejUZg3tc6n8Q49en1IuK9JtjI53EVBLt7vQVj79edr/S1ulv
         3eV++NJEQ1VFI3HK7pS7VjeGG6A1uabs/ftvTFqPi0N1di0T3ih/98oPIZDvUGy1yq
         6bXG6Wg/8PhQranPaJqqwPBD7+suGDJdBjiETLKXymNg5+mDzNFbjez1rfpAmK9luk
         B0UfrY023ETuOd9sRlVLY3B6L7TCz2z4PqE+IvaXzHlFlMQd3tJ0E0oK9q6dVg5XbM
         XMClDNHuYZN/sChnTTP5s8ZLjOIztcqyOAWoWaToRg8IZRLCIGCdjqYzOVKHOqreuP
         +9ro3zIQmqhhQ==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3a76d882052so537519b6e.0;
        Thu, 31 Aug 2023 07:56:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YwjfyXbE9TupBXFiQx76DyjKlpKpYRumBJKkrZnyj3grnEV9YIt
        mQmKbuXNyP3OplwHJFEN8vnSjsqTtGv94yQsLtQ=
X-Google-Smtp-Source: AGHT+IG0gmsy4bGiM7pim2MyZEqgCQbnAIeucX3NGRgcSk52LqF6L3rjKgAP+jrG25Z2Ph7RZm0WUxsLixhQAtQhvc0=
X-Received: by 2002:a05:6808:30a1:b0:3a8:f3e7:d696 with SMTP id
 bl33-20020a05680830a100b003a8f3e7d696mr5583040oib.45.1693493771789; Thu, 31
 Aug 2023 07:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAGXv+5EU-qvTee1f0kicZA-er2Li=EcV0zWdOGUPoqdOxi69vw@mail.gmail.com>
In-Reply-To: <CAGXv+5EU-qvTee1f0kicZA-er2Li=EcV0zWdOGUPoqdOxi69vw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 31 Aug 2023 23:55:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ58pnnk-XThrnJEhL72HUEXo-CFScYdt+yx_PrWqcRTA@mail.gmail.com>
Message-ID: <CAK7LNAQ58pnnk-XThrnJEhL72HUEXo-CFScYdt+yx_PrWqcRTA@mail.gmail.com>
Subject: Re: make -jN modules_install breakage in next-20230831
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Aug 31, 2023 at 5:59=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Hi,
>
> I observed some breakage with `make -jN moudles_install`. The scripts pro=
duce
> some bogus paths, which `cp` then complains it can't find.
>
> I run the following for my workflow.
>
>   $ nice -n 10 sh -c "make -j72 Image.lzma dtbs && ./pack-mod.sh && cb/si=
gn.sh"
>
> pack-mod.sh is what fails. It basically does:
>
>     make -j72 modules
>     make -j72 modules_install INSTALL_MOD_PATH=3D${TMPDIR}
>     depmod ...
>     tar ...
>     cleanup
>
> I get errors like the following:
>
>
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/checksyscalls.sh
>   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189=
478-dirty/kernel/arch/arm64/crypto/sha1-ce.ko
>   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189=
478-dirty/kernel/arch/arm64/crypto/chacha-neon.ko
>   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189=
478-dirty/kernel/arch/arm64/crypto/poly1305-neon.ko
>   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189=
478-dirty/kernel/kernel/time/test_udelay.ko
>   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189=
478-dirty/kernel/kernel/configs.ko
>   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189=
478-dirty/kernel/fs/nfs_common/grace.ko
> cp: cannot create regular file
> 'tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-dirty=
/kernel/kernel/time/test_udelay.ko':
> No such file or directory
>   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189=
478-dirty/kernel/fs/nls/nls_cp437.ko
> make[2]: *** [scripts/Makefile.modinst:127:
> tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-dirty/=
kernel/kernel/time/test_udelay.ko]
> Error 1
> make[2]: *** Waiting for unfinished jobs....
>   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189=
478-dirty/kernel/fs/nls/nls_ascii.ko
> cp: cannot create regular file
> 'tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-dirty=
/kernel/kernel/configs.ko':
> No such file or directory
>   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189=
478-dirty/kernel/fs/nls/nls_iso8859-1.ko
>   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189=
478-dirty/kernel/fs/nls/nls_utf8.ko
> make[2]: *** [scripts/Makefile.modinst:128:
> tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-dirty/=
kernel/kernel/configs.ko]
> Error 1
> make[1]: *** [/usr/local/google/home/wenst/linux/mtk/Makefile:1822:
> modules_install] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
>
>
> Note the duplicate "kernel/" in the path for test_udelay.ko and configs.k=
o.



The paths to test_udelay.ko and configs.ko look quite normal to me.

"kernel/kernel/" is correct.


The first "kernel/" means in-tree modules.

All in-tree modules are installed
under /lib/modules/<ver>/kernel/,
while external modules are installed
under /lib/modules/<ver>/updates/.


The second "kernel/" is the directory in the source tree.



I cannot reproduce the error.




But, indeed. Your installation log looks weird overall.
No idea what is happening in your case.


If you add V=3D1, Kbuild will show more logs, and we may get more hints.

  make V=3D1 -j72 modules_install INSTALL_MOD_PATH=3D${TMPDIR}






BTW, you are not testing linux-next, right?


The commit hash of next-20230831 is a47fc304d2b678db1a5d760a7d644dac9b06775=
2



commit a47fc304d2b678db1a5d760a7d644dac9b067752 (HEAD, tag:
next-20230831, origin/master, origin/HEAD)
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Aug 31 13:54:04 2023 +1000

    Add linux-next specific files for 20230831

    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>






Apparently, your version
"6.5.0-next-20230831-13697-g09d3bd189478-dirty" is different.


I cannot find commit 09d3bd189478.
And, it seems a lot of local patches applied on top.





Next time, please send repro steps for linux-next.







>
> If I revert commit 3ee3181f8721 ("Merge branch 'for-next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git"=
),
> then everything works again. Not sure which commit is to blame though.
>
>
> Regards
> ChenYu



--
Best Regards

Masahiro Yamada
