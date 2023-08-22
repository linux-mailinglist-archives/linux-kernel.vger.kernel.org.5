Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54660783786
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjHVBjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjHVBjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:39:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873E13E;
        Mon, 21 Aug 2023 18:39:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso2841307a12.1;
        Mon, 21 Aug 2023 18:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692668355; x=1693273155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhIOJpykyDzQ+VCn+TLVVSTJ6B4L1SH3F+7Lz/pPEA4=;
        b=c11QZBS+r7x0CWEUP4FACwNzMvKDz2Fw5BKcKmU/aDUOKnIECH43SbcUAmYVS1t2e8
         FRydUSvCAfCQZD0oM87hbrqoJB82tjTs2V1joK+gNfa5WEG1RhByV55rmdYDuPV3a0Mk
         ZsLAI+OJm/uKtA/2QdgAK3eYXcmnONVBvwDAIq8EhyuzXPaiQMVm8t6DZx9URPuc2Fr1
         C/kO2Ovs6GrjgQa8i/xubZ3p3dxzqMIHFuN6k+Z8srcj+I/IZtGtc3vLj7VEzPrEfU2O
         EdVtxVRLlF1IT63XwKrbckSTagrq/H5ZmzScgsXna9Qyzy3Ph1rk4QLCtY6XvmpuHwCV
         3R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692668355; x=1693273155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhIOJpykyDzQ+VCn+TLVVSTJ6B4L1SH3F+7Lz/pPEA4=;
        b=ZYP0157p7KuSPoobN7Wj94fsYORIryTRm9x32e1ICoYhVtJcSkDrL5w61lfgGL5AkM
         0C5mno0Zsq03+pxm/x3c7TS1TZDSMqzy/AU5QQB99uCLJZoAv8RSStvrNhqVoKpGsavV
         5Q6muAO7bJmYXHUqPzxbKoUSZUdd6maF5ZLG2dW4RwQb7CT6rpvnL6AEdI4ltlg4YpNA
         EmY4S5YKpG1n5ERl2nhp55+Au2djMcC51A9xG8xJVoXMnMhancujFDXi6s0WAVWFKmsB
         EAvEDpJwirAkGPFpL6PPzwb5tWNgEXvm/qdbcLHvGbNN8Q24IWfv6Z5E5vOjpyS+ai/U
         mVWw==
X-Gm-Message-State: AOJu0YxgSn2vauzq/S5GknyHYbI7O7p35WKoH69/lSJIkTnws+K3rxYY
        eWK4THWXjDvNiSKTIeLJ+aORUqXl6N+cUwrKHnk=
X-Google-Smtp-Source: AGHT+IFoyc4kNW3AYbcpR0x17NEZoO6nJrd2PM+kI4viupEvlkQz3g5cDYIR987jn1pTI/2AjTgn7tSIY3buuBX60qQ=
X-Received: by 2002:a17:90b:1d8b:b0:268:5c3b:6f37 with SMTP id
 pf11-20020a17090b1d8b00b002685c3b6f37mr7081291pjb.0.1692668355384; Mon, 21
 Aug 2023 18:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com> <433392a3-5ec4-cd63-fa5b-58e24deb56b9@huaweicloud.com>
In-Reply-To: <433392a3-5ec4-cd63-fa5b-58e24deb56b9@huaweicloud.com>
From:   AceLan Kao <acelan@gmail.com>
Date:   Tue, 22 Aug 2023 09:39:03 +0800
Message-ID: <CAMz9Wg8kanG=2g6Y8TVcB7-=O8MgXrjgJ0YCewqa0cM51nXf=g@mail.gmail.com>
Subject: Re: Fwd: Infiniate systemd loop when power off the machine with
 multiple MD RAIDs
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Kuai <yukuai1@huaweicloud.com> =E6=96=BC 2023=E5=B9=B48=E6=9C=8821=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> =E5=9C=A8 2023/08/16 17:37, Bagas Sanjaya =E5=86=99=E9=81=93:
> > Hi,
> >
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> >
> >> It needs to build at least 2 different RAIDs(eg. RAID0 and RAID10, RAI=
D5 and RAID10) and then you will see below error repeatly(need to use seria=
l console to see it)
> >>
> >> [ 205.360738] systemd-shutdown[1]: Stopping MD devices.
> >> [ 205.366384] systemd-shutdown[1]: sd-device-enumerator: Scan all dirs
> >> [ 205.373327] systemd-shutdown[1]: sd-device-enumerator: Scanning /sys=
/bus
> >> [ 205.380427] systemd-shutdown[1]: sd-device-enumerator: Scanning /sys=
/class
> >> [ 205.388257] systemd-shutdown[1]: Stopping MD /dev/md127 (9:127).
> >> [ 205.394880] systemd-shutdown[1]: Failed to sync MD block device /dev=
/md127, ignoring: Input/output error
> >> [ 205.404975] md: md127 stopped.
> >> [ 205.470491] systemd-shutdown[1]: Stopping MD /dev/md126 (9:126).
> >> [ 205.770179] md: md126: resync interrupted.
> >> [ 205.776258] md126: detected capacity change from 1900396544 to 0
> >> [ 205.783349] md: md126 stopped.
> >> [ 205.862258] systemd-shutdown[1]: Stopping MD /dev/md125 (9:125).
> >> [ 205.862435] md: md126 stopped.
> >> [ 205.868376] systemd-shutdown[1]: Failed to sync MD block device /dev=
/md125, ignoring: Input/output error
> >> [ 205.872845] block device autoloading is deprecated and will be remov=
ed.
> >> [ 205.880955] md: md125 stopped.
> >> [ 205.934349] systemd-shutdown[1]: Stopping MD /dev/md124p2 (259:7).
> >> [ 205.947707] systemd-shutdown[1]: Could not stop MD /dev/md124p2: Dev=
ice or resource busy
> >> [ 205.957004] systemd-shutdown[1]: Stopping MD /dev/md124p1 (259:6).
> >> [ 205.964177] systemd-shutdown[1]: Could not stop MD /dev/md124p1: Dev=
ice or resource busy
> >> [ 205.973155] systemd-shutdown[1]: Stopping MD /dev/md124 (9:124).
> >> [ 205.979789] systemd-shutdown[1]: Could not stop MD /dev/md124: Devic=
e or resource busy
> >> [ 205.988475] systemd-shutdown[1]: Not all MD devices stopped, 4 left.
>
> Without the problem, did the log complain about this?
>
> Could not stop MD...Device or resource busy
>
> Thanks,
> Kuai
>
> >
> > See Bugzilla for the full thread and attached full journalctl log.
> >
> > Anyway, I'm adding this regression to be tracked by regzbot:
> >
> > #regzbot introduced: 12a6caf273240a https://bugzilla.kernel.org/show_bu=
g.cgi?id=3D217798
> > #regzbot title: systemd shutdown hang on machine with different RAID le=
vels
> >
> > Thanks.
> >
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217798
> >
>
Hi Yu,

Everything looks normal.
I can see the MD raids stop without any warning/error messages.

$ sudo journalctl -b -2 -k -o short-monotonic | egrep md[0-9]+
[   13.418154] u-Precision-7960-Tower kernel: md/raid10:md125: active
with 4 out of 4 devices
[   13.424050] u-Precision-7960-Tower kernel: md125: detected capacity
change from 0 to 1900396544
[   13.525198] u-Precision-7960-Tower kernel: md123: detected capacity
change from 0 to 1900396544
[   13.576770] u-Precision-7960-Tower kernel: md122: detected capacity
change from 0 to 1900417024
[   13.585705] u-Precision-7960-Tower kernel:  md122: p1 p2 p3
[   14.323717] u-Precision-7960-Tower kernel: EXT4-fs (md122p3):
mounted filesystem 6d53dc8e-3f45-4efa-bc0e-4af477fac217 ro with
ordered data mode. Quota mode: none.
[   14.814365] u-Precision-7960-Tower systemd-gpt-auto-generator[587]:
md122p3: Root device /dev/md122.
[   14.829064] u-Precision-7960-Tower kernel: block md122: the
capability attribute has been deprecated.
[   18.133316] u-Precision-7960-Tower systemd[1]:
unit_file_build_name_map: normal unit file:
/lib/systemd/system/casper-md5check.service
[   20.609948] u-Precision-7960-Tower kernel: EXT4-fs (md122p3):
re-mounted 6d53dc8e-3f45-4efa-bc0e-4af477fac217 r/w. Quota mode: none.
[   39.161554] u-Precision-7960-Tower kernel: md: requested-resync of
RAID array md125
[   77.344788] u-Precision-7960-Tower systemd[1]: Got message
type=3Dsignal sender=3Dorg.freedesktop.DBus
destination=3Dorg.freedesktop.systemd1 path=3D/org/freedesktop/DBus int
erface=3Dorg.freedesktop.systemd1.Activator member=3DActivationRequest
cookie=3D89 reply_cookie=3D0 signature=3Ds error-name=3Dn/a error-message=
=3Dn/a
[   77.736790] u-Precision-7960-Tower systemd[1]: Sent message
type=3Dsignal sender=3Dn/a destination=3Dn/a path=3D/org/freedesktop/system=
d1
interface=3Dorg.freedesktop.systemd1.M
anager member=3DUnitNew cookie=3D716 reply_cookie=3D0 signature=3Dso
error-name=3Dn/a error-message=3Dn/a
[   77.772791] u-Precision-7960-Tower systemd[1]: Sent message
type=3Dsignal sender=3Dn/a destination=3Dn/a path=3D/org/freedesktop/system=
d1
interface=3Dorg.freedesktop.systemd1.M
anager member=3DUnitRemoved cookie=3D717 reply_cookie=3D0 signature=3Dso
error-name=3Dn/a error-message=3Dn/a
[   77.808791] u-Precision-7960-Tower systemd[1]: Sent message
type=3Dsignal sender=3Dn/a destination=3Dn/a path=3D/org/freedesktop/system=
d1
interface=3Dorg.freedesktop.systemd1.M
anager member=3DUnitNew cookie=3D718 reply_cookie=3D0 signature=3Dso
error-name=3Dn/a error-message=3Dn/a
[   77.844795] u-Precision-7960-Tower systemd[1]: Sent message
type=3Dsignal sender=3Dn/a destination=3Dn/a path=3D/org/freedesktop/system=
d1
interface=3Dorg.freedesktop.systemd1.M
anager member=3DUnitRemoved cookie=3D719 reply_cookie=3D0 signature=3Dso
error-name=3Dn/a error-message=3Dn/a
[   77.880866] u-Precision-7960-Tower systemd[1]: Sent message
type=3Dsignal sender=3Dn/a destination=3Dn/a path=3D/org/freedesktop/system=
d1
interface=3Dorg.freedesktop.systemd1.M
anager member=3DUnitNew cookie=3D720 reply_cookie=3D0 signature=3Dso
error-name=3Dn/a error-message=3Dn/a
[   77.916817] u-Precision-7960-Tower systemd[1]: Sent message
type=3Dsignal sender=3Dn/a destination=3Dn/a path=3D/org/freedesktop/system=
d1
interface=3Dorg.freedesktop.systemd1.M
anager member=3DJobNew cookie=3D721 reply_cookie=3D0 signature=3Duos
error-name=3Dn/a error-message=3Dn/a
[   79.072786] u-Precision-7960-Tower systemd[1]: Sent message
type=3Dsignal sender=3Dn/a destination=3Dn/a
path=3D/org/freedesktop/systemd1/unit/systemd_2dlocaled_2eservice int
erface=3Dorg.freedesktop.DBus.Properties member=3DPropertiesChanged
cookie=3D724 reply_cookie=3D0 signature=3Dsa{sv}as error-name=3Dn/a
error-message=3Dn/a
[   79.112778] u-Precision-7960-Tower systemd[1]: Sent message
type=3Dsignal sender=3Dn/a destination=3Dn/a
path=3D/org/freedesktop/systemd1/unit/systemd_2dlocaled_2eservice int
erface=3Dorg.freedesktop.DBus.Properties member=3DPropertiesChanged
cookie=3D725 reply_cookie=3D0 signature=3Dsa{sv}as error-name=3Dn/a
error-message=3Dn/a
[   79.188801] u-Precision-7960-Tower systemd[1]: Sent message
type=3Dsignal sender=3Dn/a destination=3Dn/a
path=3D/org/freedesktop/systemd1/unit/systemd_2dlocaled_2eservice int
erface=3Dorg.freedesktop.DBus.Properties member=3DPropertiesChanged
cookie=3D726 reply_cookie=3D0 signature=3Dsa{sv}as error-name=3Dn/a
error-message=3Dn/a
[   79.228790] u-Precision-7960-Tower systemd[1]: Sent message
type=3Dsignal sender=3Dn/a destination=3Dn/a
path=3D/org/freedesktop/systemd1/unit/systemd_2dlocaled_2eservice int
erface=3Dorg.freedesktop.DBus.Properties member=3DPropertiesChanged
cookie=3D727 reply_cookie=3D0 signature=3Dsa{sv}as error-name=3Dn/a
error-message=3Dn/a
[   79.268794] u-Precision-7960-Tower systemd[1]: Sent message
type=3Dsignal sender=3Dn/a destination=3Dn/a
path=3D/org/freedesktop/systemd1/job/1915 interface=3Dorg.freedesktop.D
Bus.Properties member=3DPropertiesChanged cookie=3D728 reply_cookie=3D0
signature=3Dsa{sv}as error-name=3Dn/a error-message=3Dn/a
[   81.064804] u-Precision-7960-Tower systemd[1]: Got message
type=3Dmethod_call sender=3D:1.67 destination=3Dorg.freedesktop.systemd1
path=3D/org/freedesktop/systemd1 interface
=3Dorg.freedesktop.DBus.Properties member=3DGet cookie=3D31 reply_cookie=3D=
0
signature=3Dss error-name=3Dn/a error-message=3Dn/a
[  286.066341] u-Precision-7960-Tower kernel: md123: detected capacity
change from 1900396544 to 0
[  286.073500] u-Precision-7960-Tower kernel: md: md123 stopped.
[  286.175794] u-Precision-7960-Tower kernel: md: md124 stopped.


--=20
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
