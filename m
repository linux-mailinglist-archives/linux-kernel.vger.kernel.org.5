Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A8878F7E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 07:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348219AbjIAFNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 01:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345281AbjIAFNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 01:13:46 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE16AE7E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 22:13:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68becf931d0so1311390b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 22:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693545219; x=1694150019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OvHM+CKwnHbIeFvnDrCIt/qJ/JBJgavM5NTUs391Nig=;
        b=mDGQ3/12SCviDXzULIUZMvEmLc240LAZHwZWaFcsHge6sWUFLoTSReXJG36whuioW5
         JhAFp1JmRWVzMnqfiPBd0tKJqrIY8z5nHOrL7cmc53zwzxeCsUAeJGiylgaqsgkiQnLa
         UQx7UM2VKVX/hAoe3CJvuYrPs9wC7sNN27Toc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693545219; x=1694150019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvHM+CKwnHbIeFvnDrCIt/qJ/JBJgavM5NTUs391Nig=;
        b=Rbe7Il/5IVOpDH0zUmZQkjRiMHnOTDDqJuNnvbvqE3y44J5pAzUGuPOZuskhmc9CiW
         cHm7fDUFULbNSKVLZhve9LTLudv52BBhhRixQYqiJgR8/3931dfWL8T2syCzl3URDQf/
         lK/i2zX2PfC1HQbbKloHAodTHdAAQdYwjQaCKjSLWictge58YERQtmWDDUK9ZFawupmN
         JrggGeRyMjOntIl4XQJcjFks5kjCVidfdG6dlDEIQ1QlAYz4Hwn3niGYwfbZ6uXVFucZ
         BFO0CSp+ITOubZZ/mzQANRzbZaIzgL3JLNWtwXPZ1o0fSFF/1KqidATBiGHyO7l5IgXz
         1eWg==
X-Gm-Message-State: AOJu0YzJMwIscm57zfAgQGc+Ix0YjOPoDjl3d8FDLrKmF5D3XT7qZd2v
        hfHzI0nN92QsqWd1ACUJbEiTpw==
X-Google-Smtp-Source: AGHT+IFITxs6aV3JQqw4o1wVlbCxfK+CZykXNeOEcQS8LvbPIhxs0MnfxIp/m6ZPiS+ybe8xtLFa7A==
X-Received: by 2002:a05:6a20:3a96:b0:11f:2714:f6f3 with SMTP id d22-20020a056a203a9600b0011f2714f6f3mr1535967pzh.11.1693545219119;
        Thu, 31 Aug 2023 22:13:39 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:1571:fd85:e25c:7145])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001bdb0483e65sm2047621plg.265.2023.08.31.22.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 22:13:38 -0700 (PDT)
Date:   Fri, 1 Sep 2023 13:13:36 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: make -jN modules_install breakage in next-20230831
Message-ID: <20230901051336.GA2845123@google.com>
References: <CAGXv+5EU-qvTee1f0kicZA-er2Li=EcV0zWdOGUPoqdOxi69vw@mail.gmail.com>
 <CAK7LNAQ58pnnk-XThrnJEhL72HUEXo-CFScYdt+yx_PrWqcRTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAK7LNAQ58pnnk-XThrnJEhL72HUEXo-CFScYdt+yx_PrWqcRTA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 11:55:35PM +0900, Masahiro Yamada wrote:
> On Thu, Aug 31, 2023 at 5:59=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > Hi,
> >
> > I observed some breakage with `make -jN moudles_install`. The scripts p=
roduce
> > some bogus paths, which `cp` then complains it can't find.
> >
> > I run the following for my workflow.
> >
> >   $ nice -n 10 sh -c "make -j72 Image.lzma dtbs && ./pack-mod.sh && cb/=
sign.sh"
> >
> > pack-mod.sh is what fails. It basically does:
> >
> >     make -j72 modules
> >     make -j72 modules_install INSTALL_MOD_PATH=3D${TMPDIR}
> >     depmod ...
> >     tar ...
> >     cleanup
> >
> > I get errors like the following:
> >
> >
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/checksyscalls.sh
> >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd1=
89478-dirty/kernel/arch/arm64/crypto/sha1-ce.ko
> >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd1=
89478-dirty/kernel/arch/arm64/crypto/chacha-neon.ko
> >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd1=
89478-dirty/kernel/arch/arm64/crypto/poly1305-neon.ko
> >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd1=
89478-dirty/kernel/kernel/time/test_udelay.ko
> >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd1=
89478-dirty/kernel/kernel/configs.ko
> >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd1=
89478-dirty/kernel/fs/nfs_common/grace.ko
> > cp: cannot create regular file
> > 'tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-dir=
ty/kernel/kernel/time/test_udelay.ko':
> > No such file or directory
> >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd1=
89478-dirty/kernel/fs/nls/nls_cp437.ko
> > make[2]: *** [scripts/Makefile.modinst:127:
> > tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-dirt=
y/kernel/kernel/time/test_udelay.ko]
> > Error 1
> > make[2]: *** Waiting for unfinished jobs....
> >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd1=
89478-dirty/kernel/fs/nls/nls_ascii.ko
> > cp: cannot create regular file
> > 'tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-dir=
ty/kernel/kernel/configs.ko':
> > No such file or directory
> >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd1=
89478-dirty/kernel/fs/nls/nls_iso8859-1.ko
> >   INSTALL tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd1=
89478-dirty/kernel/fs/nls/nls_utf8.ko
> > make[2]: *** [scripts/Makefile.modinst:128:
> > tmp.7i3QCV3ac8/lib/modules/6.5.0-next-20230831-13697-g09d3bd189478-dirt=
y/kernel/kernel/configs.ko]
> > Error 1
> > make[1]: *** [/usr/local/google/home/wenst/linux/mtk/Makefile:1822:
> > modules_install] Error 2
> > make: *** [Makefile:234: __sub-make] Error 2
> >
> >
> > Note the duplicate "kernel/" in the path for test_udelay.ko and configs=
=2Eko.
>=20
>=20
>=20
> The paths to test_udelay.ko and configs.ko look quite normal to me.
>=20
> "kernel/kernel/" is correct.
>=20
>=20
> The first "kernel/" means in-tree modules.
>=20
> All in-tree modules are installed
> under /lib/modules/<ver>/kernel/,
> while external modules are installed
> under /lib/modules/<ver>/updates/.
>=20
>=20
> The second "kernel/" is the directory in the source tree.
>=20
>=20
>=20
> I cannot reproduce the error.
>=20
>=20
>=20
>=20
> But, indeed. Your installation log looks weird overall.
> No idea what is happening in your case.
>=20
>=20
> If you add V=3D1, Kbuild will show more logs, and we may get more hints.
>=20
>   make V=3D1 -j72 modules_install INSTALL_MOD_PATH=3D${TMPDIR}

Here's a cleaner repro on next-20230831:

    $ export ARCH=3Darm64
    $ export CROSS_COMPILE=3D"aarch64-linux-gnu-"
    ### defconfig attached at the end
    $ make olddefconfig
    $ make -j72 Image.gz modules
    $ make -j72 V=3D1 modules_install INSTALL_MOD_PATH=3Dtmp
    make --no-print-directory -C /usr/local/google/home/wenst/linux/mtk \
    -f /usr/local/google/home/wenst/linux/mtk/Makefile modules_install
    make -f ./scripts/Makefile.modinst \
    sign-only=3D
    rm -fr tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel t=
mp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/build
    mkdir -p tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ tmp/l=
ib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/arch/arm64/crypto=
/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/crypto/ tm=
p/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/block/=
zram/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/driver=
s/bluetooth/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel=
/drivers/cdrom/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ker=
nel/drivers/hid/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/ke=
rnel/drivers/i2c/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/k=
ernel/drivers/iio/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/=
kernel/drivers/iio/common/cros_ec_sensors/ tmp/lib/modules/6.5.0-next-20230=
831-13643-ga47fc304d2b6/kernel/drivers/iio/light/ tmp/lib/modules/6.5.0-nex=
t-20230831-13643-ga47fc304d2b6/kernel/drivers/iio/pressure/ tmp/lib/modules=
/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/iio/trigger/ tmp/li=
b/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/input/ tmp=
/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/input/j=
oystick/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/dri=
vers/input/joystick/iforce/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47f=
c304d2b6/kernel/drivers/input/misc/ tmp/lib/modules/6.5.0-next-20230831-136=
43-ga47fc304d2b6/kernel/drivers/input/rmi4/ tmp/lib/modules/6.5.0-next-2023=
0831-13643-ga47fc304d2b6/kernel/drivers/input/serio/ tmp/lib/modules/6.5.0-=
next-20230831-13643-ga47fc304d2b6/kernel/drivers/input/touchscreen/ tmp/lib=
/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/media/commo=
n/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/m=
edia/common/v4l2-tpg/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2=
b6/kernel/drivers/media/common/videobuf2/ tmp/lib/modules/6.5.0-next-202308=
31-13643-ga47fc304d2b6/kernel/drivers/media/i2c/ tmp/lib/modules/6.5.0-next=
-20230831-13643-ga47fc304d2b6/kernel/drivers/media/platform/mediatek/jpeg/ =
tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/medi=
a/platform/mediatek/mdp/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc30=
4d2b6/kernel/drivers/media/platform/mediatek/vcodec/common/ tmp/lib/modules=
/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/media/platform/medi=
atek/vcodec/decoder/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b=
6/kernel/drivers/media/platform/mediatek/vcodec/encoder/ tmp/lib/modules/6.=
5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/media/platform/mediate=
k/vpu/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/drive=
rs/media/test-drivers/visl/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47f=
c304d2b6/kernel/drivers/media/usb/uvc/ tmp/lib/modules/6.5.0-next-20230831-=
13643-ga47fc304d2b6/kernel/drivers/media/v4l2-core/ tmp/lib/modules/6.5.0-n=
ext-20230831-13643-ga47fc304d2b6/kernel/drivers/mmc/core/ tmp/lib/modules/6=
=2E5.0-next-20230831-13643-ga47fc304d2b6/kernel/drivers/net/ tmp/lib/module=
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
=2E0-next-20230831-13643-ga47fc304d2b6/kernel/kernel/ tmp/lib/modules/6.5.0=
-next-20230831-13643-ga47fc304d2b6/kernel/kernel/time/ tmp/lib/modules/6.5.=
0-next-20230831-13643-ga47fc304d2b6/kernel/lib/ tmp/lib/modules/6.5.0-next-=
20230831-13643-ga47fc304d2b6/kernel/lib/crypto/ tmp/lib/modules/6.5.0-next-=
20230831-13643-ga47fc304d2b6/kernel/net/802/ tmp/lib/modules/6.5.0-next-202=
30831-13643-ga47fc304d2b6/kernel/net/8021q/ tmp/lib/modules/6.5.0-next-2023=
0831-13643-ga47fc304d2b6/kernel/net/bluetooth/ tmp/lib/modules/6.5.0-next-2=
0230831-13643-ga47fc304d2b6/kernel/net/bluetooth/hidp/ tmp/lib/modules/6.5.=
0-next-20230831-13643-ga47fc304d2b6/kernel/net/bluetooth/rfcomm/ tmp/lib/mo=
dules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/bridge/ tmp/lib/mo=
dules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/dns_resolver/ tmp/=
lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/ipv4/ tmp/li=
b/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/ipv6/ tmp/lib/=
modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/ipv6/netfilter/ =
tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/llc/ tmp=
/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/mac80211/ t=
mp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/netfilter=
/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/sched/=
 tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/sunrpc/=
 tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/net/sunrpc/=
auth_gss/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/ne=
t/vmw_vsock/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel=
/net/wireless/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kern=
el/sound/core/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kern=
el/sound/core/seq/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/=
kernel/sound/drivers/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2=
b6/kernel/sound/soc/sof/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc30=
4d2b6/kernel/sound/soc/sof/mediatek/ tmp/lib/modules/6.5.0-next-20230831-13=
643-ga47fc304d2b6/kernel/sound/soc/sof/mediatek/mt8186/ tmp/lib/modules/6.5=
=2E0-next-20230831-13643-ga47fc304d2b6/kernel/sound/soc/sof/mediatek/mt8195=
/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/sound/soc/=
sof/xtensa/ tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/=
sound/usb/
    # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/arch/arm64/crypto/sha1-ce.ko
      cp arch/arm64/crypto/sha1-ce.ko tmp/lib/modules/6.5.0-next-20230831-1=
3643-ga47fc304d2b6/kernel/arch/arm64/crypto/sha1-ce.ko
    # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/arch/arm64/crypto/chacha-neon.ko
      cp arch/arm64/crypto/chacha-neon.ko tmp/lib/modules/6.5.0-next-202308=
31-13643-ga47fc304d2b6/kernel/arch/arm64/crypto/chacha-neon.ko
    # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/arch/arm64/crypto/poly1305-neon.ko
      cp arch/arm64/crypto/poly1305-neon.ko tmp/lib/modules/6.5.0-next-2023=
0831-13643-ga47fc304d2b6/kernel/arch/arm64/crypto/poly1305-neon.ko
    # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/kernel/time/test_udelay.ko
      cp kernel/time/test_udelay.ko tmp/lib/modules/6.5.0-next-20230831-136=
43-ga47fc304d2b6/kernel/kernel/time/test_udelay.ko
    # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/kernel/configs.ko
      cp kernel/configs.ko tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc=
304d2b6/kernel/kernel/configs.ko
    # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/fs/nfs_common/grace.ko
      cp fs/nfs_common/grace.ko tmp/lib/modules/6.5.0-next-20230831-13643-g=
a47fc304d2b6/kernel/fs/nfs_common/grace.ko
    # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/fs/nls/nls_cp437.ko
      cp fs/nls/nls_cp437.ko tmp/lib/modules/6.5.0-next-20230831-13643-ga47=
fc304d2b6/kernel/fs/nls/nls_cp437.ko
    # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/fs/nls/nls_ascii.ko
      cp fs/nls/nls_ascii.ko tmp/lib/modules/6.5.0-next-20230831-13643-ga47=
fc304d2b6/kernel/fs/nls/nls_ascii.ko
    cp: cannot create regular file 'tmp/lib/modules/6.5.0-next-20230831-136=
43-ga47fc304d2b6/kernel/kernel/time/test_udelay.ko': No such file or direct=
ory
    # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/fs/nls/nls_iso8859-1.ko
      cp fs/nls/nls_iso8859-1.ko tmp/lib/modules/6.5.0-next-20230831-13643-=
ga47fc304d2b6/kernel/fs/nls/nls_iso8859-1.ko
    # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/fs/nls/nls_utf8.ko
      cp fs/nls/nls_utf8.ko tmp/lib/modules/6.5.0-next-20230831-13643-ga47f=
c304d2b6/kernel/fs/nls/nls_utf8.ko
    # INSTALL tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kerne=
l/fs/fat/fat.ko
      cp fs/fat/fat.ko tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d=
2b6/kernel/fs/fat/fat.ko
    make[2]: *** [scripts/Makefile.modinst:128: tmp/lib/modules/6.5.0-next-=
20230831-13643-ga47fc304d2b6/kernel/kernel/time/test_udelay.ko] Error 1
    make[2]: *** Waiting for unfinished jobs....

I suspect what is happening is that the prepare target (which does
`mkdir`) is getting executed at the same time as all the install
commands. This seems to only happen if module compression is enabled.

If I dump the make database with `make -p`, I see rules like the following:

    tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/kernel/t=
ime/test_udelay.ko.xz: tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d=
2b6/kernel/kernel/time/test_udelay.ko FORCE prepare
    tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/kernel/t=
ime/test_udelay.ko: kernel/time/test_udelay.ko FORCE

which indicates that the dependency is off. If I turn off module compressio=
n,
i.e. CONFIG_MODULE_COMPRESS_NONE=3Dy, then the rules become:

    tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6/kernel/kernel/t=
ime/test_udelay.ko: kernel/time/test_udelay.ko FORCE prepare

which works. If I apply the following change:

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 459cb1fed223..91c13845cdb3 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -123,7 +123,7 @@ quiet_cmd_sign :=3D
       cmd_sign :=3D :
 endif
=20
-$(dst)/%.ko: $(extmod_prefix)%.ko FORCE
+$(dst)/%.ko: $(extmod_prefix)%.ko FORCE prepare
 	$(call cmd,install)
 	$(call cmd,strip)
 	$(call cmd,sign)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

then things work even if module compression is enabled. The database
dump now shows the install rules have proper dependencies on the prepare
target:

    tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6-dirty/kernel/ke=
rnel/time/test_udelay.ko.xz: tmp/lib/modules/6.5.0-next-20230831-13643-ga47=
fc304d2b6-dirty/kernel/kernel/time/test_udelay.ko FORCE prepare
    tmp/lib/modules/6.5.0-next-20230831-13643-ga47fc304d2b6-dirty/kernel/ke=
rnel/time/test_udelay.ko: kernel/time/test_udelay.ko FORCE prepare

Hope this helps.


Regards
ChenYu


My defconfig:

CONFIG_DEFAULT_HOSTNAME=3D"localhost"
CONFIG_SYSVIPC=3Dy
CONFIG_AUDIT=3Dy
CONFIG_GENERIC_IRQ_DEBUGFS=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy
CONFIG_BPF_SYSCALL=3Dy
CONFIG_BPF_JIT=3Dy
CONFIG_BPF_JIT_ALWAYS_ON=3Dy
CONFIG_PREEMPT=3Dy
CONFIG_IRQ_TIME_ACCOUNTING=3Dy
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy
CONFIG_PSI=3Dy
CONFIG_IKCONFIG=3Dm
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_LOG_BUF_SHIFT=3D18
CONFIG_UCLAMP_TASK=3Dy
CONFIG_CGROUPS=3Dy
CONFIG_BLK_CGROUP=3Dy
CONFIG_CGROUP_SCHED=3Dy
CONFIG_CFS_BANDWIDTH=3Dy
CONFIG_RT_GROUP_SCHED=3Dy
CONFIG_UCLAMP_TASK_GROUP=3Dy
CONFIG_CGROUP_FREEZER=3Dy
CONFIG_CPUSETS=3Dy
CONFIG_CGROUP_DEVICE=3Dy
CONFIG_CGROUP_CPUACCT=3Dy
CONFIG_CGROUP_BPF=3Dy
CONFIG_NAMESPACES=3Dy
CONFIG_USER_NS=3Dy
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_LZO is not set
CONFIG_EXPERT=3Dy
# CONFIG_IO_URING is not set
CONFIG_PROFILING=3Dy
CONFIG_ARCH_MEDIATEK=3Dy
# CONFIG_AMPERE_ERRATUM_AC03_CPU_38 is not set
# CONFIG_CAVIUM_ERRATUM_27456 is not set
CONFIG_SCHED_MC=3Dy
CONFIG_NR_CPUS=3D8
CONFIG_HZ_1000=3Dy
CONFIG_ARM64_SW_TTBR0_PAN=3Dy
CONFIG_COMPAT=3Dy
CONFIG_ARMV8_DEPRECATED=3Dy
CONFIG_SWP_EMULATION=3Dy
CONFIG_CP15_BARRIER_EMULATION=3Dy
CONFIG_SETEND_EMULATION=3Dy
# CONFIG_ARM64_BTI is not set
CONFIG_ARM64_PSEUDO_NMI=3Dy
CONFIG_ARM64_DEBUG_PRIORITY_MASKING=3Dy
CONFIG_RANDOMIZE_BASE=3Dy
# CONFIG_EFI is not set
CONFIG_PM_WAKELOCKS=3Dy
CONFIG_PM_DEBUG=3Dy
CONFIG_PM_ADVANCED_DEBUG=3Dy
CONFIG_ENERGY_MODEL=3Dy
CONFIG_CPU_IDLE=3Dy
CONFIG_CPU_IDLE_GOV_LADDER=3Dy
CONFIG_CPU_IDLE_GOV_MENU=3Dy
CONFIG_CPU_IDLE_GOV_TEO=3Dy
CONFIG_ARM_PSCI_CPUIDLE=3Dy
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
CONFIG_ARM_MEDIATEK_CPUFREQ=3Dy
CONFIG_ARM_MEDIATEK_CPUFREQ_HW=3Dy
CONFIG_VIRTUALIZATION=3Dy
CONFIG_KVM=3Dy
CONFIG_JUMP_LABEL=3Dy
CONFIG_ARCH_MMAP_RND_BITS=3D24
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D16
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_MODULE_COMPRESS_XZ=3Dy
CONFIG_MODULE_DECOMPRESS=3Dy
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_DEV_INTEGRITY=3Dy
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_PARTITION_ADVANCED=3Dy
CONFIG_MAC_PARTITION=3Dy
CONFIG_BINFMT_MISC=3Dy
CONFIG_ZSWAP=3Dy
CONFIG_ZSMALLOC=3Dy
CONFIG_SLAB_FREELIST_RANDOM=3Dy
CONFIG_SLAB_FREELIST_HARDENED=3Dy
# CONFIG_COMPAT_BRK is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=3D32768
CONFIG_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=3Dy
CONFIG_USERFAULTFD=3Dy
CONFIG_LRU_GEN=3Dy
CONFIG_LRU_GEN_ENABLED=3Dy
CONFIG_NET=3Dy
CONFIG_PACKET=3Dy
CONFIG_UNIX=3Dy
CONFIG_XFRM_USER=3Dy
CONFIG_NET_KEY=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dy
CONFIG_INET_ESP=3Dy
CONFIG_INET_IPCOMP=3Dy
CONFIG_INET_UDP_DIAG=3Dy
CONFIG_INET_DIAG_DESTROY=3Dy
CONFIG_TCP_CONG_ADVANCED=3Dy
# CONFIG_TCP_CONG_BIC is not set
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
CONFIG_TCP_CONG_LP=3Dm
CONFIG_TCP_MD5SIG=3Dy
CONFIG_IPV6_ROUTER_PREF=3Dy
CONFIG_IPV6_ROUTE_INFO=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_IPV6_SIT=3Dm
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
CONFIG_NETWORK_SECMARK=3Dy
CONFIG_NETFILTER=3Dy
CONFIG_NF_CONNTRACK=3Dy
CONFIG_NF_CONNTRACK_SECMARK=3Dy
CONFIG_NF_CONNTRACK_PROCFS=3Dy
CONFIG_NF_CONNTRACK_EVENTS=3Dy
CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
# CONFIG_NF_CT_PROTO_DCCP is not set
# CONFIG_NF_CT_PROTO_SCTP is not set
# CONFIG_NF_CT_PROTO_UDPLITE is not set
CONFIG_NF_CONNTRACK_FTP=3Dm
CONFIG_NF_CONNTRACK_PPTP=3Dy
CONFIG_NF_CONNTRACK_TFTP=3Dm
CONFIG_NF_CT_NETLINK=3Dy
CONFIG_NF_CT_NETLINK_TIMEOUT=3Dy
CONFIG_NF_CT_NETLINK_HELPER=3Dy
CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy
CONFIG_NETFILTER_XTABLES_COMPAT=3Dy
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dy
CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dy
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dy
CONFIG_NETFILTER_XT_TARGET_CT=3Dy
CONFIG_NETFILTER_XT_TARGET_DSCP=3Dy
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dy
CONFIG_NETFILTER_XT_TARGET_MARK=3Dy
CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dy
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dy
CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dy
CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dy
CONFIG_NETFILTER_XT_TARGET_TRACE=3Dy
CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dy
CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dy
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dy
CONFIG_NETFILTER_XT_MATCH_BPF=3Dy
CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dm
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dy
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dy
CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dy
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dy
CONFIG_NETFILTER_XT_MATCH_DSCP=3Dy
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dy
CONFIG_NETFILTER_XT_MATCH_HELPER=3Dy
CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dy
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dy
CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dy
CONFIG_NETFILTER_XT_MATCH_MAC=3Dy
CONFIG_NETFILTER_XT_MATCH_MARK=3Dy
CONFIG_NETFILTER_XT_MATCH_POLICY=3Dy
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dy
CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dy
CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dy
CONFIG_NETFILTER_XT_MATCH_STATE=3Dy
CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dy
CONFIG_NETFILTER_XT_MATCH_STRING=3Dy
CONFIG_NETFILTER_XT_MATCH_TIME=3Dy
CONFIG_NETFILTER_XT_MATCH_U32=3Dy
CONFIG_IP_NF_IPTABLES=3Dy
CONFIG_IP_NF_FILTER=3Dy
CONFIG_IP_NF_TARGET_REJECT=3Dy
CONFIG_IP_NF_NAT=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_MANGLE=3Dy
CONFIG_IP_NF_RAW=3Dy
CONFIG_NF_REJECT_IPV6=3Dy
CONFIG_IP6_NF_IPTABLES=3Dy
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_RPFILTER=3Dy
CONFIG_IP6_NF_FILTER=3Dy
CONFIG_IP6_NF_TARGET_REJECT=3Dm
CONFIG_IP6_NF_MANGLE=3Dy
CONFIG_IP6_NF_RAW=3Dy
CONFIG_IP6_NF_NAT=3Dm
CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
CONFIG_BRIDGE=3Dm
CONFIG_VLAN_8021Q=3Dm
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_NETEM=3Dm
CONFIG_NET_SCH_CODEL=3Dm
CONFIG_NET_SCH_FQ_CODEL=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_CLS_U32_MARK=3Dy
CONFIG_NET_CLS_ACT=3Dy
CONFIG_NET_ACT_POLICE=3Dy
CONFIG_NET_ACT_GACT=3Dy
CONFIG_VSOCKETS=3Dm
CONFIG_BT=3Dm
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_HIDP=3Dm
CONFIG_BT_MSFTEXT=3Dy
CONFIG_BT_FEATURE_DEBUG=3Dy
CONFIG_BT_HCIBTUSB=3Dm
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=3Dy
CONFIG_BT_HCIBTUSB_MTK=3Dy
CONFIG_BT_HCIBTSDIO=3Dm
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_RTL=3Dy
CONFIG_BT_HCIUART_QCA=3Dy
CONFIG_BT_HCIBFUSB=3Dm
CONFIG_BT_HCIVHCI=3Dm
CONFIG_BT_MTKSDIO=3Dm
CONFIG_BT_MTKUART=3Dm
CONFIG_CFG80211=3Dm
CONFIG_NL80211_TESTMODE=3Dy
CONFIG_CFG80211_CERTIFICATION_ONUS=3Dy
# CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is not set
CONFIG_CFG80211_DEBUGFS=3Dy
CONFIG_CFG80211_WEXT=3Dy
CONFIG_MAC80211=3Dm
CONFIG_MAC80211_LEDS=3Dy
CONFIG_MAC80211_DEBUGFS=3Dy
CONFIG_MAC80211_DEBUG_MENU=3Dy
CONFIG_MAC80211_VERBOSE_DEBUG=3Dy
CONFIG_RFKILL=3Dy
CONFIG_PAGE_POOL_STATS=3Dy
CONFIG_PCI=3Dy
CONFIG_PCIEPORTBUS=3Dy
CONFIG_PCIEAER=3Dy
CONFIG_PCIEASPM_POWER_SUPERSAVE=3Dy
CONFIG_PCIE_MEDIATEK_GEN3=3Dy
CONFIG_DEVTMPFS=3Dy
CONFIG_DEVTMPFS_MOUNT=3Dy
CONFIG_CONNECTOR=3Dy
CONFIG_MTK_ADSP_IPC=3Dy
CONFIG_GOOGLE_FIRMWARE=3Dy
CONFIG_GOOGLE_CBMEM=3Dy
CONFIG_GOOGLE_COREBOOT_TABLE=3Dy
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=3Dy
CONFIG_GOOGLE_VPD=3Dy
CONFIG_MTD=3Dy
CONFIG_MTD_CMDLINE_PARTS=3Dy
CONFIG_MTD_PARTITIONED_MASTER=3Dy
CONFIG_MTD_SPI_NOR=3Dy
CONFIG_PARPORT=3Dy
CONFIG_ZRAM=3Dm
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_NVME=3Dy
CONFIG_EEPROM_AT24=3Dy
CONFIG_SCSI=3Dy
CONFIG_BLK_DEV_SD=3Dy
CONFIG_BLK_DEV_SR=3Dm
CONFIG_SCSI_SCAN_ASYNC=3Dy
CONFIG_SCSI_SPI_ATTRS=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_WIREGUARD=3Dm
CONFIG_TUN=3Dm
CONFIG_VETH=3Dm
CONFIG_PHYLIB=3Dy
CONFIG_PPP=3Dy
CONFIG_PPP_MPPE=3Dy
CONFIG_PPP_ASYNC=3Dy
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_RTL8152=3Dm
CONFIG_USB_NET_CDC_MBIM=3Dm
CONFIG_USB_NET_DM9601=3Dm
CONFIG_USB_NET_SMSC75XX=3Dm
CONFIG_USB_NET_SMSC95XX=3Dm
CONFIG_USB_NET_MCS7830=3Dm
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
CONFIG_USB_IPHETH=3Dm
CONFIG_USB_NET_AQC111=3Dm
CONFIG_ATH10K=3Dm
CONFIG_ATH10K_SDIO=3Dm
CONFIG_ATH10K_DEBUG=3Dy
CONFIG_ATH10K_DEBUGFS=3Dy
CONFIG_ATH10K_SPECTRAL=3Dy
CONFIG_ATH10K_TRACING=3Dy
CONFIG_ATH10K_DFS_CERTIFIED=3Dy
CONFIG_MWIFIEX=3Dm
CONFIG_MT7921E=3Dm
CONFIG_MT7921S=3Dm
CONFIG_MT7921U=3Dm
CONFIG_MT7996E=3Dm
CONFIG_RT2X00=3Dm
CONFIG_RT2800USB=3Dm
CONFIG_RT2800USB_RT3573=3Dy
CONFIG_RT2800USB_RT53XX=3Dy
CONFIG_RT2800USB_RT55XX=3Dy
CONFIG_RT2800USB_UNKNOWN=3Dy
# CONFIG_RTL_CARDS is not set
CONFIG_RTL8XXXU=3Dm
CONFIG_RTW88=3Dm
CONFIG_RTW88_8822BE=3Dm
CONFIG_RTW88_8822BS=3Dm
CONFIG_RTW88_8822BU=3Dm
CONFIG_RTW88_8822CE=3Dm
CONFIG_RTW88_8822CS=3Dm
CONFIG_RTW88_8822CU=3Dm
CONFIG_RTW88_8723DE=3Dm
CONFIG_RTW88_8723DU=3Dm
CONFIG_RTW88_8821CE=3Dm
CONFIG_RTW88_8821CS=3Dm
CONFIG_RTW88_8821CU=3Dm
CONFIG_RTW88_DEBUG=3Dy
CONFIG_RTW88_DEBUGFS=3Dy
CONFIG_RTW89=3Dm
CONFIG_RTW89_8852AE=3Dm
CONFIG_RTW89_8852BE=3Dm
CONFIG_RTW89_8852CE=3Dm
CONFIG_RTW89_DEBUGMSG=3Dy
CONFIG_RTW89_DEBUGFS=3Dy
CONFIG_USB_NET_RNDIS_WLAN=3Dm
CONFIG_MAC80211_HWSIM=3Dm
CONFIG_INPUT_FF_MEMLESS=3Dy
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_KEYBOARD_ATKBD is not set
CONFIG_KEYBOARD_GPIO=3Dy
CONFIG_KEYBOARD_CROS_EC=3Dy
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_CYAPA=3Dy
CONFIG_MOUSE_ELAN_I2C=3Dy
CONFIG_INPUT_JOYSTICK=3Dy
CONFIG_JOYSTICK_IFORCE=3Dm
CONFIG_JOYSTICK_IFORCE_USB=3Dm
CONFIG_JOYSTICK_XPAD=3Dm
CONFIG_JOYSTICK_XPAD_FF=3Dy
CONFIG_JOYSTICK_XPAD_LEDS=3Dy
CONFIG_INPUT_TABLET=3Dy
CONFIG_INPUT_TOUCHSCREEN=3Dy
CONFIG_TOUCHSCREEN_ATMEL_MXT=3Dy
CONFIG_TOUCHSCREEN_ELAN=3Dy
CONFIG_TOUCHSCREEN_USB_COMPOSITE=3Dm
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_UINPUT=3Dm
CONFIG_SERIO=3Dm
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_PCI1XXXX=3Dy
CONFIG_SERIAL_8250_DW=3Dy
CONFIG_SERIAL_8250_MT6577=3Dy
CONFIG_SERIAL_OF_PLATFORM=3Dy
CONFIG_SERIAL_DEV_BUS=3Dy
CONFIG_HW_RANDOM=3Dy
# CONFIG_HW_RANDOM_CN10K is not set
CONFIG_TCG_TPM=3Dy
CONFIG_TCG_TIS_SPI=3Dy
CONFIG_TCG_TIS_SPI_CR50=3Dy
CONFIG_TCG_TIS_I2C=3Dy
CONFIG_TCG_TIS_I2C_CR50=3Dy
CONFIG_TCG_TIS_I2C_INFINEON=3Dy
CONFIG_I2C_CHARDEV=3Dy
CONFIG_I2C_MT65XX=3Dy
CONFIG_I2C_CROS_EC_TUNNEL=3Dy
CONFIG_I2C_STUB=3Dm
CONFIG_SPI=3Dy
CONFIG_SPI_GPIO=3Dy
CONFIG_SPI_MT65XX=3Dy
CONFIG_SPI_MTK_NOR=3Dy
CONFIG_SPI_SPIDEV=3Dy
CONFIG_SPMI=3Dy
CONFIG_SPMI_MTK_PMIF=3Dy
# CONFIG_PTP_1588_CLOCK is not set
# CONFIG_PINCTRL_MT2712 is not set
# CONFIG_PINCTRL_MT7622 is not set
# CONFIG_PINCTRL_MT7981 is not set
CONFIG_DEBUG_GPIO=3Dy
CONFIG_GPIO_SYSFS=3Dy
CONFIG_BATTERY_SBS=3Dy
CONFIG_CHARGER_GPIO=3Dy
CONFIG_CHARGER_MT6360=3Dy
CONFIG_CHARGER_MT6370=3Dy
CONFIG_CHARGER_CROS_USBPD=3Dy
CONFIG_SENSORS_TMP401=3Dy
CONFIG_THERMAL=3Dy
CONFIG_THERMAL_WRITABLE_TRIPS=3Dy
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=3Dy
CONFIG_THERMAL_GOV_STEP_WISE=3Dy
CONFIG_THERMAL_GOV_USER_SPACE=3Dy
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
CONFIG_CPU_THERMAL=3Dy
CONFIG_DEVFREQ_THERMAL=3Dy
CONFIG_MTK_THERMAL=3Dy
CONFIG_MTK_SOC_THERMAL=3Dy
CONFIG_MTK_LVTS_THERMAL=3Dy
CONFIG_MTK_LVTS_THERMAL_DEBUGFS=3Dy
CONFIG_GENERIC_ADC_THERMAL=3Dy
CONFIG_WATCHDOG=3Dy
CONFIG_SOFT_WATCHDOG=3Dm
CONFIG_MFD_MT6360=3Dy
CONFIG_MFD_MT6370=3Dy
CONFIG_MFD_MT6397=3Dy
CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
CONFIG_REGULATOR_VIRTUAL_CONSUMER=3Dy
CONFIG_REGULATOR_USERSPACE_CONSUMER=3Dy
CONFIG_REGULATOR_CROS_EC=3Dy
CONFIG_REGULATOR_GPIO=3Dy
CONFIG_REGULATOR_MT6315=3Dy
CONFIG_REGULATOR_MT6331=3Dy
CONFIG_REGULATOR_MT6332=3Dy
CONFIG_REGULATOR_MT6357=3Dy
CONFIG_REGULATOR_MT6358=3Dy
CONFIG_REGULATOR_MT6359=3Dy
CONFIG_REGULATOR_MT6360=3Dy
CONFIG_REGULATOR_MT6370=3Dy
CONFIG_REGULATOR_MT6397=3Dy
CONFIG_REGULATOR_PWM=3Dy
CONFIG_MEDIA_CEC_SUPPORT=3Dy
CONFIG_CEC_CROS_EC=3Dy
CONFIG_MEDIA_SUPPORT=3Dy
CONFIG_MEDIA_SUPPORT_FILTER=3Dy
CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
CONFIG_MEDIA_PLATFORM_SUPPORT=3Dy
CONFIG_MEDIA_TEST_SUPPORT=3Dy
CONFIG_MEDIA_USB_SUPPORT=3Dy
CONFIG_USB_VIDEO_CLASS=3Dm
# CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV is not set
CONFIG_V4L_PLATFORM_DRIVERS=3Dy
CONFIG_V4L_MEM2MEM_DRIVERS=3Dy
CONFIG_VIDEO_MEDIATEK_JPEG=3Dm
CONFIG_VIDEO_MEDIATEK_MDP=3Dm
CONFIG_VIDEO_MEDIATEK_VCODEC=3Dm
CONFIG_V4L_TEST_DRIVERS=3Dy
CONFIG_VIDEO_VISL=3Dm
CONFIG_VISL_DEBUGFS=3Dy
CONFIG_VIDEO_OV02A10=3Dm
CONFIG_VIDEO_OV5695=3Dm
CONFIG_VIDEO_OV8856=3Dm
CONFIG_VIDEO_DW9768=3Dm
CONFIG_DRM=3Dy
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_DP_AUX_CHARDEV=3Dy
CONFIG_DRM_DP_CEC=3Dy
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=3Dy
CONFIG_DRM_PANEL_SIMPLE=3Dy
CONFIG_DRM_PANEL_EDP=3Dy
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=3Dy
CONFIG_DRM_CROS_EC_ANX7688=3Dy
CONFIG_DRM_ITE_IT6505=3Dy
CONFIG_DRM_PARADE_PS8640=3Dy
CONFIG_DRM_ANALOGIX_ANX7625=3Dy
CONFIG_DRM_MEDIATEK=3Dy
CONFIG_DRM_MEDIATEK_DP=3Dy
CONFIG_DRM_MEDIATEK_HDMI=3Dy
CONFIG_DRM_PANFROST=3Dy
CONFIG_FB=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
CONFIG_BACKLIGHT_PWM=3Dy
CONFIG_BACKLIGHT_MT6370=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=3Dy
CONFIG_SOUND=3Dy
CONFIG_SND=3Dy
CONFIG_SND_HRTIMER=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_ALOOP=3Dm
# CONFIG_SND_SPI is not set
CONFIG_SND_USB_AUDIO=3Dm
CONFIG_SND_SOC=3Dy
CONFIG_SND_SOC_MT8173=3Dy
CONFIG_SND_SOC_MT8173_MAX98090=3Dy
CONFIG_SND_SOC_MT8173_RT5650=3Dy
CONFIG_SND_SOC_MT8173_RT5650_RT5514=3Dy
CONFIG_SND_SOC_MT8173_RT5650_RT5676=3Dy
CONFIG_SND_SOC_MT8183=3Dy
CONFIG_SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=3Dy
CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=3Dy
CONFIG_SND_SOC_MT8186=3Dy
CONFIG_SND_SOC_MT8186_MT6366_DA7219_MAX98357=3Dy
CONFIG_SND_SOC_MT8186_MT6366_RT1019_RT5682S=3Dy
CONFIG_SND_SOC_MT8188=3Dy
CONFIG_SND_SOC_MT8188_MT6359=3Dy
CONFIG_SND_SOC_MT8192=3Dy
CONFIG_SND_SOC_MT8192_MT6359_RT1015_RT5682=3Dy
CONFIG_SND_SOC_MT8195=3Dy
CONFIG_SND_SOC_MT8195_MT6359=3Dy
CONFIG_SND_SOC_SOF_TOPLEVEL=3Dy
CONFIG_SND_SOC_SOF_OF=3Dm
CONFIG_SND_SOC_SOF_MTK_TOPLEVEL=3Dy
CONFIG_SND_SOC_SOF_MT8186=3Dm
CONFIG_SND_SOC_SOF_MT8195=3Dm
CONFIG_SND_SIMPLE_CARD=3Dy
CONFIG_HID_BATTERY_STRENGTH=3Dy
CONFIG_HIDRAW=3Dy
CONFIG_UHID=3Dy
CONFIG_HID_CHERRY=3Dm
CONFIG_HID_CHICONY=3Dm
CONFIG_HID_GOOGLE_HAMMER=3Dm
CONFIG_HID_VIVALDI=3Dm
CONFIG_HID_LOGITECH=3Dm
CONFIG_HID_LOGITECH_DJ=3Dm
CONFIG_HID_MAGICMOUSE=3Dm
CONFIG_HID_MICROSOFT=3Dm
CONFIG_HID_MULTITOUCH=3Dy
CONFIG_HID_PLANTRONICS=3Dm
CONFIG_HID_PRIMAX=3Dm
CONFIG_HID_SONY=3Dm
CONFIG_HID_RMI=3Dm
CONFIG_HID_THINGM=3Dm
CONFIG_HID_WACOM=3Dm
CONFIG_HID_WIIMOTE=3Dm
CONFIG_USB_HIDDEV=3Dy
CONFIG_I2C_HID_OF=3Dy
CONFIG_I2C_HID_OF_ELAN=3Dy
CONFIG_I2C_HID_OF_GOODIX=3Dy
CONFIG_USB=3Dy
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_MON=3Dy
CONFIG_USB_XHCI_HCD=3Dy
CONFIG_USB_EHCI_HCD=3Dy
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_EHCI_HCD_PLATFORM=3Dy
CONFIG_USB_OHCI_HCD=3Dy
CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
CONFIG_USB_ACM=3Dy
CONFIG_USB_STORAGE=3Dy
CONFIG_USB_UAS=3Dy
CONFIG_USBIP_CORE=3Dm
CONFIG_USBIP_VHCI_HCD=3Dm
CONFIG_USB_MTU3=3Dy
CONFIG_USB_MTU3_HOST=3Dy
CONFIG_USB_DWC3=3Dy
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_SIMPLE=3Dm
CONFIG_USB_SERIAL_CH341=3Dm
CONFIG_USB_SERIAL_CP210X=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_OTI6858=3Dm
CONFIG_USB_SERIAL_QUALCOMM=3Dm
CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
CONFIG_USB_SERIAL_OPTION=3Dm
CONFIG_USB_ONBOARD_HUB=3Dy
CONFIG_USB_GADGET=3Dy
CONFIG_USB_CONFIGFS=3Dm
CONFIG_USB_CONFIGFS_F_FS=3Dy
CONFIG_TYPEC=3Dy
CONFIG_MMC=3Dy
CONFIG_MMC_BLOCK_MINORS=3D16
CONFIG_MMC_TEST=3Dm
CONFIG_MMC_SDHCI=3Dy
CONFIG_MMC_SDHCI_PLTFM=3Dy
CONFIG_MMC_MTK=3Dy
CONFIG_LEDS_CLASS=3Dy
CONFIG_LEDS_GPIO=3Dy
CONFIG_LEDS_PWM=3Dy
CONFIG_RTC_CLASS=3Dy
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DRV_CROS_EC=3Dy
CONFIG_RTC_DRV_MT6397=3Dy
CONFIG_DMADEVICES=3Dy
CONFIG_PL330_DMA=3Dy
CONFIG_SW_SYNC=3Dy
CONFIG_UDMABUF=3Dy
CONFIG_DMABUF_HEAPS=3Dy
CONFIG_DMABUF_HEAPS_SYSTEM=3Dy
CONFIG_VHOST_VSOCK=3Dm
CONFIG_STAGING=3Dy
CONFIG_STAGING_MEDIA=3Dy
CONFIG_CHROME_PLATFORMS=3Dy
CONFIG_CROS_EC=3Dy
CONFIG_CROS_EC_RPMSG=3Dm
CONFIG_CROS_EC_SPI=3Dy
CONFIG_CROS_KBD_LED_BACKLIGHT=3Dy
# CONFIG_CROS_EC_LIGHTBAR is not set
CONFIG_CROS_EC_SENSORHUB=3Dm
CONFIG_CROS_EC_TYPEC=3Dm
CONFIG_CROS_HPS_I2C=3Dm
# CONFIG_COMMON_CLK_MT6765 is not set
# CONFIG_COMMON_CLK_MT6779 is not set
# CONFIG_COMMON_CLK_MT6795 is not set
# CONFIG_COMMON_CLK_MT6797 is not set
# CONFIG_COMMON_CLK_MT7622 is not set
# CONFIG_COMMON_CLK_MT7981 is not set
# CONFIG_COMMON_CLK_MT7986 is not set
# CONFIG_COMMON_CLK_MT8167 is not set
# CONFIG_COMMON_CLK_MT8365 is not set
# CONFIG_COMMON_CLK_MT8516 is not set
CONFIG_MTK_ADSP_MBOX=3Dy
CONFIG_IOMMU_DEBUGFS=3Dy
CONFIG_MTK_IOMMU=3Dy
CONFIG_REMOTEPROC=3Dy
CONFIG_MTK_SCP=3Dm
CONFIG_MTK_CMDQ=3Dy
CONFIG_MTK_DEVAPC=3Dy
CONFIG_MTK_PMIC_WRAP=3Dy
CONFIG_MTK_SVS=3Dy
CONFIG_DEVFREQ_GOV_PERFORMANCE=3Dy
CONFIG_DEVFREQ_GOV_POWERSAVE=3Dy
CONFIG_DEVFREQ_GOV_USERSPACE=3Dy
CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=3Dy
CONFIG_EXTCON_USBC_CROS_EC=3Dy
CONFIG_IIO=3Dy
CONFIG_IIO_SW_TRIGGER=3Dm
CONFIG_MEDIATEK_MT6360_ADC=3Dy
CONFIG_MEDIATEK_MT6370_ADC=3Dy
CONFIG_MEDIATEK_MT6577_AUXADC=3Dy
CONFIG_IIO_CROS_EC_SENSORS_CORE=3Dm
CONFIG_IIO_CROS_EC_SENSORS=3Dm
CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=3Dm
CONFIG_IIO_CROS_EC_LIGHT_PROX=3Dm
CONFIG_IIO_HRTIMER_TRIGGER=3Dm
CONFIG_IIO_SYSFS_TRIGGER=3Dm
CONFIG_IIO_CROS_EC_BARO=3Dm
CONFIG_PWM=3Dy
CONFIG_PWM_DEBUG=3Dy
CONFIG_PWM_CROS_EC=3Dy
CONFIG_PWM_MTK_DISP=3Dy
CONFIG_RESET_SIMPLE=3Dy
CONFIG_RESET_TI_SYSCON=3Dy
CONFIG_PHY_MTK_PCIE=3Dy
CONFIG_PHY_MTK_TPHY=3Dy
CONFIG_DAX=3Dy
CONFIG_NVMEM_MTK_EFUSE=3Dy
CONFIG_EXT4_FS=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
CONFIG_FS_ENCRYPTION=3Dy
CONFIG_FS_VERITY=3Dy
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=3Dy
# CONFIG_DNOTIFY is not set
CONFIG_FANOTIFY=3Dy
CONFIG_QUOTA=3Dy
CONFIG_QFMT_V2=3Dy
CONFIG_FUSE_FS=3Dm
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_UDF_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_PROC_CHILDREN=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_CONFIGFS_FS=3Dy
CONFIG_ECRYPT_FS=3Dy
CONFIG_HFSPLUS_FS=3Dm
CONFIG_SQUASHFS=3Dy
CONFIG_SQUASHFS_FILE_DIRECT=3Dy
CONFIG_SQUASHFS_XATTR=3Dy
CONFIG_SQUASHFS_LZ4=3Dy
CONFIG_SQUASHFS_LZO=3Dy
CONFIG_SQUASHFS_ZSTD=3Dy
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=3Dy
CONFIG_PSTORE=3Dy
CONFIG_PSTORE_CONSOLE=3Dy
CONFIG_PSTORE_PMSG=3Dy
CONFIG_PSTORE_RAM=3Dy
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V4=3Dm
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_ASCII=3Dm
CONFIG_NLS_ISO8859_1=3Dm
# CONFIG_SECURITYFS is not set
CONFIG_LSM=3D"lockdown,yama,loadpin,safesetid,integrity,chromiumos,selinux,=
bpf"
CONFIG_INIT_STACK_NONE=3Dy
CONFIG_CRYPTO_CRYPTD=3Dy
CONFIG_CRYPTO_DES=3Dy
CONFIG_CRYPTO_ARC4=3Dy
CONFIG_CRYPTO_ESSIV=3Dy
CONFIG_CRYPTO_XXHASH=3Dm
CONFIG_CRYPTO_USER_API_HASH=3Dm
CONFIG_CRYPTO_USER_API_SKCIPHER=3Dm
CONFIG_CRYPTO_GHASH_ARM64_CE=3Dy
CONFIG_CRYPTO_SHA1_ARM64_CE=3Dm
CONFIG_CRYPTO_SHA2_ARM64_CE=3Dy
CONFIG_CRYPTO_AES_ARM64=3Dy
CONFIG_CRYPTO_AES_ARM64_CE_BLK=3Dy
CONFIG_CRYPTO_AES_ARM64_NEON_BLK=3Dy
CONFIG_CRYPTO_AES_ARM64_CE_CCM=3Dy
CONFIG_CRC7=3Dm
CONFIG_LIBCRC32C=3Dy
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_DMA_RESTRICTED_POOL=3Dy
CONFIG_PRINTK_TIME=3Dy
CONFIG_STACKTRACE_BUILD_ID=3Dy
CONFIG_DEBUG_INFO_DWARF4=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_KASAN=3Dy
CONFIG_KFENCE=3Dy
CONFIG_KFENCE_SAMPLE_INTERVAL=3D500
CONFIG_PANIC_ON_OOPS=3Dy
CONFIG_PANIC_TIMEOUT=3D-1
CONFIG_SOFTLOCKUP_DETECTOR=3Dy
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=3Dy
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=3Dy
CONFIG_WQ_WATCHDOG=3Dy
CONFIG_SCHEDSTATS=3Dy
CONFIG_PROVE_LOCKING=3Dy
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
CONFIG_DEBUG_CREDENTIALS=3Dy
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D20
# CONFIG_RCU_TRACE is not set
CONFIG_BOOTTIME_TRACING=3Dy
CONFIG_FUNCTION_GRAPH_RETVAL=3Dy
CONFIG_STACK_TRACER=3Dy
CONFIG_TRACER_SNAPSHOT=3Dy
CONFIG_BLK_DEV_IO_TRACE=3Dy
CONFIG_LKDTM=3Dy
CONFIG_TEST_LKM=3Dm
CONFIG_TEST_FIRMWARE=3Dm
CONFIG_TEST_UDELAY=3Dm
