Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46A878F95E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbjIAHyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbjIAHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:54:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42121725;
        Fri,  1 Sep 2023 00:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CD6BB8250E;
        Fri,  1 Sep 2023 07:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D7AC433C9;
        Fri,  1 Sep 2023 07:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693554797;
        bh=aAT23neAsYBRF9oZshtg21Y1tE4vO6glXWh4/q5/+L4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zo30jpmiu/K2R/7+X2jhqTpQgTVfJ2P1+sJpy97Uw3rH7wgtrh9Vgzku7qoAOHaRj
         BpuUOU6I6DgUkctXhgKy4bKxlft6YcJKwXUyw7F68Cq2Xj9zqWrj8WRm7KjMrcv5Lc
         jPVD/+iTzkftqI03RuIMJq7UEC1H4sM3TsQOwa5rMbFQYnsVyqyRbCqhufITzOpViy
         sn1FWfCzFIY2/uZ7U6uycWg8MGa1PwOW/uun5u2RHhYkDR4C6vzla0fAO+m6NeojrQ
         xj0Yl39IBjiHAS89dBDvL+Fg2hG1PiMS2f9X9L6CvurhaAQNyIsmpEOA+OVH80/dVJ
         nH+Hh44+f6pFA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3a85b1b7574so967540b6e.2;
        Fri, 01 Sep 2023 00:53:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YxgfJNT2C1+zC5dYknENfzyLgk+Hbhxs/+FvvkhvrRx8aqGV+L+
        SKjJUqw6+U+HgU0oZal8KdR9jR1sedVBI5ZMt2Q=
X-Google-Smtp-Source: AGHT+IEvLFgcS0a8Zj3woHMJO9b2jvu9IpKQI20JCOe6k/JdRDQUCm0hf9BfXoPxWrl3zSGCc0j1Tb16Uk+KFCXnitM=
X-Received: by 2002:a05:6808:4e:b0:3a6:f622:70f1 with SMTP id
 v14-20020a056808004e00b003a6f62270f1mr1627759oic.57.1693554796224; Fri, 01
 Sep 2023 00:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAGXv+5EU-qvTee1f0kicZA-er2Li=EcV0zWdOGUPoqdOxi69vw@mail.gmail.com>
 <CAK7LNAQ58pnnk-XThrnJEhL72HUEXo-CFScYdt+yx_PrWqcRTA@mail.gmail.com> <20230901051336.GA2845123@google.com>
In-Reply-To: <20230901051336.GA2845123@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 Sep 2023 16:52:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATBLXjy-dH1WHQ=Wmc=MebQ6=BzLnWLkUtjaVoM_DQADA@mail.gmail.com>
Message-ID: <CAK7LNATBLXjy-dH1WHQ=Wmc=MebQ6=BzLnWLkUtjaVoM_DQADA@mail.gmail.com>
Subject: Re: make -jN modules_install breakage in next-20230831
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 2:13=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> On Thu, Aug 31, 2023 at 11:55:35PM +0900, Masahiro Yamada wrote:
> > On Thu, Aug 31, 2023 at 5:59=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> > >
> > > Hi,
> > >
> > > I observed some breakage with `make -jN moudles_install`. The scripts=
 produce
> > > some bogus paths, which `cp` then complains it can't find.
> > >
> > > I run the following for my workflow.
> > >
> > >   $ nice -n 10 sh -c "make -j72 Image.lzma dtbs && ./pack-mod.sh && c=
b/sign.sh"
> > >
> > > pack-mod.sh is what fails. It basically does:
> > >
> > >     make -j72 modules
> > >     make -j72 modules_install INSTALL_MOD_PATH=3D${TMPDIR}
> > >     depmod ...
> > >     tar ...
> > >     cleanup
> > >
> > > I get errors like the following:
> > >
> > >
> > >   CALL    scripts/checksyscalls.sh
> > >   CALL    scripts/checksyscalls.sh
> > >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3b=
d189478-dirty/kernel/arch/arm64/crypto/sha1-ce.ko
> > >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3b=
d189478-dirty/kernel/arch/arm64/crypto/chacha-neon.ko
> > >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3b=
d189478-dirty/kernel/arch/arm64/crypto/poly1305-neon.ko
> > >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3b=
d189478-dirty/kernel/kernel/time/test_udelay.ko
> > >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3b=
d189478-dirty/kernel/kernel/configs.ko
> > >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3b=
d189478-dirty/kernel/fs/nfs_common/grace.ko
> > > cp: cannot create regular file
> > > 'tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-d=
irty/kernel/kernel/time/test_udelay.ko':
> > > No such file or directory
> > >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3b=
d189478-dirty/kernel/fs/nls/nls_cp437.ko
> > > make[2]: *** [scripts/Makefile.modinst:127:
> > > tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-di=
rty/kernel/kernel/time/test_udelay.ko]
> > > Error 1
> > > make[2]: *** Waiting for unfinished jobs....
> > >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3b=
d189478-dirty/kernel/fs/nls/nls_ascii.ko
> > > cp: cannot create regular file
> > > 'tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-d=
irty/kernel/kernel/configs.ko':
> > > No such file or directory
> > >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3b=
d189478-dirty/kernel/fs/nls/nls_iso8859-1.ko
> > >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3b=
d189478-dirty/kernel/fs/nls/nls_utf8.ko
> > > make[2]: *** [scripts/Makefile.modinst:128:
> > > tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-di=
rty/kernel/kernel/configs.ko]
> > > Error 1
> > > make[1]: *** [/usr/local/google/home/wenst/linux/mtk/Makefile:1822:
> > > modules_install] Error 2
> > > make: *** [Makefile:234: __sub-make] Error 2
> > >
> > >
> > > Note the duplicate "kernel/" in the path for test_udelay.ko and confi=
gs.ko.
> >
> >
> >
> > The paths to test_udelay.ko and configs.ko look quite normal to me.
> >
> > "kernel/kernel/" is correct.
> >
> >
> > The first "kernel/" means in-tree modules.
> >
> > All in-tree modules are installed
> > under /lib/modules/<ver>/kernel/,
> > while external modules are installed
> > under /lib/modules/<ver>/updates/.
> >
> >
> > The second "kernel/" is the directory in the source tree.
> >
> >
> >
> > I cannot reproduce the error.
> >
> >
> >
> >
> > But, indeed. Your installation log looks weird overall.
> > No idea what is happening in your case.
> >
> >
> > If you add V=3D1, Kbuild will show more logs, and we may get more hints=
.
> >
> >   make V=3D1 -j72 modules_install INSTALL_MOD_PATH=3D${TMPDIR}
>
> Here's a cleaner repro on next-20230831:
>
>     $ export ARCH=3Darm64
>     $ export CROSS_COMPILE=3D"aarch64-linux-gnu-"
>     ### defconfig attached at the end
>     $ make olddefconfig
>     $ make -j72 Image.gz modules
>     $ make -j72 V=3D1 modules_install INSTALL_MOD_PATH=3Dtmp
>     make --no-print-directory -C /usr/local/google/home/wenst/linux/mtk \
>     -f /usr/local/google/home/wenst/linux/mtk/Makefile modules_install
>     make -f ./scripts/Makefile.modinst \
>     sign-only=3D
>     rm -fr tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel=
 tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/build
>     mkdir -p tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ tmp=
/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/arch/arm64/cryp=
to/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/crypto/ =
tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/bloc=
k/zram/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/driv=
ers/bluetooth/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kern=
el/drivers/cdrom/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/k=
ernel/drivers/hid/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/=
kernel/drivers/i2c/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6=
/kernel/drivers/iio/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b=
6/kernel/drivers/iio/common/cros_ec_sensors/ tmp/lib/modules/6.5.0-next-202=
30831-13643-ga47fc304d2b6/kernel/drivers/iio/light/ tmp/lib/modules/6.5.0-n=
ext-20230831-13643-ga47fc304d2b6/kernel/drivers/iio/pressure/ tmp/lib/modul=
es/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/iio/trigger/ tmp/=
lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/input/ t=
mp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/input=
/joystick/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/d=
rivers/input/joystick/iforce/ tmp/lib/modules/6.5.0-next-20230831-13643-ga4=
7fc304d2b6/kernel/drivers/input/misc/ tmp/lib/modules/6.5.0-next-20230831-1=
3643-ga47fc304d2b6/kernel/drivers/input/rmi4/ tmp/lib/modules/6.5.0-next-20=
230831-13643-ga47fc304d2b6/kernel/drivers/input/serio/ tmp/lib/modules/6.5.=
0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/input/touchscreen/ tmp/l=
ib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/media/com=
mon/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers=
/media/common/v4l2-tpg/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304=
d2b6/kernel/drivers/media/common/videobuf2/ tmp/lib/modules/6.5.0-next-2023=
0831-13643-ga47fc304d2b6/kernel/drivers/media/i2c/ tmp/lib/modules/6.5.0-ne=
xt-20230831-13643-ga47fc304d2b6/kernel/drivers/media/platform/mediatek/jpeg=
/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/me=
dia/platform/mediatek/mdp/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc=
304d2b6/kernel/drivers/media/platform/mediatek/vcodec/common/ tmp/lib/modul=
es/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/media/platform/me=
diatek/vcodec/decoder/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d=
2b6/kernel/drivers/media/platform/mediatek/vcodec/encoder/ tmp/lib/modules/=
6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/media/platform/media=
tek/vpu/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/dri=
vers/media/test-drivers/visl/ tmp/lib/modules/6.5.0-next-20230831-13643-ga4=
7fc304d2b6/kernel/drivers/media/usb/uvc/ tmp/lib/modules/6.5.0-next-2023083=
1-13643-ga47fc304d2b6/kernel/drivers/media/v4l2-core/ tmp/lib/modules/6.5.0=
-next-20230831-13643-ga47fc304d2b6/kernel/drivers/mmc/core/ tmp/lib/modules=
/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/net/ tmp/lib/module=
s/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/net/phy/ tmp/lib/m=
odules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/net/usb/ tmp/=
lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/net/wire=
guard/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drive=
rs/net/wireless/ath/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b=
6/kernel/drivers/net/wireless/ath/ath10k/ tmp/lib/modules/6.5.0-next-202308=
31-13643-ga47fc304d2b6/kernel/drivers/net/wireless/legacy/ tmp/lib/modules/=
6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/net/wireless/marvell=
/mwifiex/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/dr=
ivers/net/wireless/mediatek/mt76/ tmp/lib/modules/6.5.0-next-20230831-13643=
-ga47fc304d2b6/kernel/drivers/net/wireless/mediatek/mt76/mt7921/ tmp/lib/mo=
dules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/net/wireless/m=
ediatek/mt76/mt7996/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b=
6/kernel/drivers/net/wireless/ralink/rt2x00/ tmp/lib/modules/6.5.0-next-202=
30831-13643-ga47fc304d2b6/kernel/drivers/net/wireless/realtek/rtl8xxxu/ tmp=
/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/net/wir=
eless/realtek/rtw88/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b=
6/kernel/drivers/net/wireless/realtek/rtw89/ tmp/lib/modules/6.5.0-next-202=
30831-13643-ga47fc304d2b6/kernel/drivers/net/wireless/virtual/ tmp/lib/modu=
les/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/platform/chrome/=
 tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/rem=
oteproc/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/dri=
vers/rpmsg/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/=
drivers/scsi/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/drivers/usb/class/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b=
6/kernel/drivers/usb/gadget/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47=
fc304d2b6/kernel/drivers/usb/gadget/function/ tmp/lib/modules/6.5.0-next-20=
230831-13643-ga47fc304d2b6/kernel/drivers/usb/misc/ tmp/lib/modules/6.5.0-n=
ext-20230831-13643-ga47fc304d2b6/kernel/drivers/usb/serial/ tmp/lib/modules=
/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/usb/usbip/ tmp/lib/=
modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/vhost/ tmp/l=
ib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/watchdog/=
 tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/fs/fat/ tmp=
/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/fs/fuse/ tmp/li=
b/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/fs/hfsplus/ tmp/li=
b/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/fs/isofs/ tmp/lib/=
modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/fs/lockd/ tmp/lib/mo=
dules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/fs/nfs/ tmp/lib/module=
s/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/fs/nfs_common/ tmp/lib/mod=
ules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/fs/nls/ tmp/lib/modules=
/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/fs/udf/ tmp/lib/modules/6.5=
.0-next-20230831-13643-ga47fc304d2b6/kernel/kernel/ tmp/lib/modules/6.5.0-n=
ext-20230831-13643-ga47fc304d2b6/kernel/kernel/time/ tmp/lib/modules/6.5.0-=
next-20230831-13643-ga47fc304d2b6/kernel/lib/ tmp/lib/modules/6.5.0-next-20=
230831-13643-ga47fc304d2b6/kernel/lib/crypto/ tmp/lib/modules/6.5.0-next-20=
230831-13643-ga47fc304d2b6/kernel/net/802/ tmp/lib/modules/6.5.0-next-20230=
831-13643-ga47fc304d2b6/kernel/net/8021q/ tmp/lib/modules/6.5.0-next-202308=
31-13643-ga47fc304d2b6/kernel/net/bluetooth/ tmp/lib/modules/6.5.0-next-202=
30831-13643-ga47fc304d2b6/kernel/net/bluetooth/hidp/ tmp/lib/modules/6.5.0-=
next-20230831-13643-ga47fc304d2b6/kernel/net/bluetooth/rfcomm/ tmp/lib/modu=
les/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/bridge/ tmp/lib/modu=
les/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/dns_resolver/ tmp/li=
b/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/ipv4/ tmp/lib/=
modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/ipv6/ tmp/lib/mo=
dules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/ipv6/netfilter/ tm=
p/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/llc/ tmp/l=
ib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/mac80211/ tmp=
/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/netfilter/ =
tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/sched/ t=
mp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/sunrpc/ t=
mp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/sunrpc/au=
th_gss/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/=
vmw_vsock/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/n=
et/wireless/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel=
/sound/core/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel=
/sound/core/seq/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ke=
rnel/sound/drivers/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6=
/kernel/sound/soc/sof/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d=
2b6/kernel/sound/soc/sof/mediatek/ tmp/lib/modules/6.5.0-next-20230831-1364=
3-ga47fc304d2b6/kernel/sound/soc/sof/mediatek/mt8186/ tmp/lib/modules/6.5.0=
-next-20230831-13643-ga47fc304d2b6/kernel/sound/soc/sof/mediatek/mt8195/ tm=
p/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/sound/soc/sof/=
xtensa/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/soun=
d/usb/
>     # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/arch/arm64/crypto/sha1-ce.ko
>       cp arch/arm64/crypto/sha1-ce.ko tmp/lib/modules/6.5.0-next-20230831=
-13643-ga47fc304d2b6/kernel/arch/arm64/crypto/sha1-ce.ko
>     # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/arch/arm64/crypto/chacha-neon.ko
>       cp arch/arm64/crypto/chacha-neon.ko tmp/lib/modules/6.5.0-next-2023=
0831-13643-ga47fc304d2b6/kernel/arch/arm64/crypto/chacha-neon.ko
>     # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/arch/arm64/crypto/poly1305-neon.ko
>       cp arch/arm64/crypto/poly1305-neon.ko tmp/lib/modules/6.5.0-next-20=
230831-13643-ga47fc304d2b6/kernel/arch/arm64/crypto/poly1305-neon.ko
>     # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/kernel/time/test_udelay.ko
>       cp kernel/time/test_udelay.ko tmp/lib/modules/6.5.0-next-20230831-1=
3643-ga47fc304d2b6/kernel/kernel/time/test_udelay.ko
>     # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/kernel/configs.ko
>       cp kernel/configs.ko tmp/lib/modules/6.5.0-next-20230831-13643-ga47=
fc304d2b6/kernel/kernel/configs.ko
>     # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/fs/nfs_common/grace.ko
>       cp fs/nfs_common/grace.ko tmp/lib/modules/6.5.0-next-20230831-13643=
-ga47fc304d2b6/kernel/fs/nfs_common/grace.ko
>     # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/fs/nls/nls_cp437.ko
>       cp fs/nls/nls_cp437.ko tmp/lib/modules/6.5.0-next-20230831-13643-ga=
47fc304d2b6/kernel/fs/nls/nls_cp437.ko
>     # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/fs/nls/nls_ascii.ko
>       cp fs/nls/nls_ascii.ko tmp/lib/modules/6.5.0-next-20230831-13643-ga=
47fc304d2b6/kernel/fs/nls/nls_ascii.ko
>     cp: cannot create regular file 'tmp/lib/modules/6.5.0-next-20230831-1=
3643-ga47fc304d2b6/kernel/kernel/time/test_udelay.ko': No such file or dire=
ctory
>     # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/fs/nls/nls_iso8859-1.ko
>       cp fs/nls/nls_iso8859-1.ko tmp/lib/modules/6.5.0-next-20230831-1364=
3-ga47fc304d2b6/kernel/fs/nls/nls_iso8859-1.ko
>     # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/fs/nls/nls_utf8.ko
>       cp fs/nls/nls_utf8.ko tmp/lib/modules/6.5.0-next-20230831-13643-ga4=
7fc304d2b6/kernel/fs/nls/nls_utf8.ko
>     # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/fs/fat/fat.ko
>       cp fs/fat/fat.ko tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc30=
4d2b6/kernel/fs/fat/fat.ko
>     make[2]: *** [scripts/Makefile.modinst:128: tmp/lib/modules/6.5.0-nex=
t-20230831-13643-ga47fc304d2b6/kernel/kernel/time/test_udelay.ko] Error 1
>     make[2]: *** Waiting for unfinished jobs....
>
> I suspect what is happening is that the prepare target (which does
> `mkdir`) is getting executed at the same time as all the install
> commands. This seems to only happen if module compression is enabled.



Ah, you are right.
The module compression was missing in my mind.

I locally fixed up the code.

Thank you for catching it.



--
Best Regards
Masahiro Yamada
