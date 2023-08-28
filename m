Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016E378ADAD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjH1KuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjH1Kth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:49:37 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68295F9;
        Mon, 28 Aug 2023 03:49:15 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1c8be41e5efso2059469fac.3;
        Mon, 28 Aug 2023 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693219752; x=1693824552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FkMCvWKkmZO1lazxPjQWZRNND5Yi2Heq0nhss7cMBzU=;
        b=W5BlAmPfxrj1WgIVa98GZtugOqbdmxksUCvlAIynTPNb/KT0Vnu6oNbsKl9EFUZOuk
         QEEqfxq7Ia25BBslY57bgYK3iEu1KVUrlq1cYUjN+VUwu+kuXASv1FUUJXzj6dXGPuRO
         V3MBCkKcIB064mods6z38LYculqNO9ukMhBGYimimpK5Me3w6SEZqRfqIinlS09ZC8I4
         nRt55p0GR2AM9Pj5z8nnZD51Hn+lGt3JCk+MLQbxbHFSer884kUFmzzIRu4mocK8e13C
         iSox2kvifxTQcHDOq2dhI3dawORO+2SXZzflInmDY/XarOuYtFzk5jMWkMojLxsKyOk0
         UdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693219752; x=1693824552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkMCvWKkmZO1lazxPjQWZRNND5Yi2Heq0nhss7cMBzU=;
        b=gaDk2P74apj5oda3VMibUbeuKM8vCGhGIMIvkSCxx0aN1lf2mxAaF0IvX+N8HUtAaF
         nUqmx8ORLpIVyxUXm8zResHVgr+B9OzTt7CMGArPkzyda60jujHg8dDI8fYrVFHZteWy
         Jkaa3rYYR6Jj0PbbUoNArFjNmmZpZ6DFovTjaCW5n1sfISkAhADvTNUFfCtbcwgkFNav
         QnA5h3GeV5zRdYMQAnQHkh/MKb5HVfHgSRn9NoEzRluzW1tIlwP7QM1RQyKAVWs27drT
         1PZ76ECoIQDxmOk+ssh2MGaIB9FSQtf8+0z/Y8CMxMrNtl3qVzCDhWb5JPLBdbPmXAgA
         zbtA==
X-Gm-Message-State: AOJu0Yx2qtz5SSMz4lF+rndhkXmfEAA52qW+XAvGI8oI0jE/5pV/JUXD
        XXzj60QNGjK6O62nqBxeZaNVfQ644aqbArzVWfc=
X-Google-Smtp-Source: AGHT+IHvDXaz575ElTSkYTqQLKxgZ57hBezeEu6jW0nc2EDYjWPOZOPcZa8yzGG5ISHSNtDAI8dH/Fu6GCMLbDm8QtE=
X-Received: by 2002:a05:6870:d0c3:b0:1bf:d869:cd97 with SMTP id
 k3-20020a056870d0c300b001bfd869cd97mr10594537oaa.29.1693219752017; Mon, 28
 Aug 2023 03:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <20230818101630.000027f4@linux.intel.com> <b0488ff7-10c8-4b4e-28b8-01809133c297@linux.dev>
 <CAPhsuW6cSLqwRVO_EpFyimvc7hgi1rb3T8-NA+stHdwrqrScBA@mail.gmail.com>
 <20230822083923.00007fb6@linux.intel.com> <CAMz9Wg8KE1rDkSaQnUTJ5ikzH7YGGYbkLM3AcrVue3=JgK+14w@mail.gmail.com>
 <35130b3f-c0fd-e2d6-e849-a5ceb6a2895f@linux.dev> <CAMz9Wg_zKSJ2vL=r2zAtLBOv4GSMT63+ZQGXfYTjVJsE+DLQGA@mail.gmail.com>
 <CAPhsuW6W0XgFjH1zNC+EFYjujd4smEiWs+-nYCWQ+KaFmbuvkg@mail.gmail.com>
 <CAMz9Wg9y52iuxJRSQFC2N5Katt72v-o=JvEjegJt-MwORmw9tQ@mail.gmail.com> <CAPhsuW7XEy4q3XR389F7CUvXvJ=0JR0QkMOr4LU03avT0erAfg@mail.gmail.com>
In-Reply-To: <CAPhsuW7XEy4q3XR389F7CUvXvJ=0JR0QkMOr4LU03avT0erAfg@mail.gmail.com>
From:   AceLan Kao <acelan@gmail.com>
Date:   Mon, 28 Aug 2023 18:48:58 +0800
Message-ID: <CAMz9Wg-dcBFnw-3SfsD6Lrhp4o7cVf_w7y2X7yQ_hWCg+CiRXQ@mail.gmail.com>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
To:     Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d9517e0603f971e2"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d9517e0603f971e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Song,

Song Liu <song@kernel.org> =E6=96=BC 2023=E5=B9=B48=E6=9C=8828=E6=97=A5 =E9=
=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi AceLan,
>
> Thanks for running the experiments.
>
> On Fri, Aug 25, 2023 at 9:32=E2=80=AFPM AceLan Kao <acelan@gmail.com> wro=
te:
> [...]
> > >
> > > Could you please run the follow two experiments?
> > >
> > > 1. Confirm 12a6caf273240a triggers this. Specifically:
> > >    git checkout 12a6caf273240a =3D> repros
> > >    git checkout 12a6caf273240a~1 =3D> cannot repro
> > Yes, I'm pretty sure about this, that's my bisect result and I just
> > confirmed it again.
> > I also tried reverting 12a6caf273240a and the issue is gone.
>
> The log doesn't match my guess. Specifically:
>
> [  420.068142] systemd-shutdown[1]: Stopping MD /dev/md123 (9:123).
> [  420.074718] md_open:md123 openers++ =3D 1 by systemd-shutdow
> [  420.080787] systemd-shutdown[1]: Failed to sync MD block device
> /dev/md123, ignoring: Input/output error
> [  420.090831] md: md123 stopped.
> [  420.094465] systemd-shutdown[1]: Stopping MD /dev/md122 (9:122).
> [  420.101045] systemd-shutdown[1]: Could not stop MD /dev/md122:
> Device or resource busy
>
> For a successful stop on md123, we reach the pr_info() in md_open().
> For a failed stop on md122, the kernel returns -EBUSY before that
> pr_info() in md_open(). There are some changes in md_open() in
> the past few release, so I am not quite sure we are looking at the
> same code.
>
> Therefore, could you please help clarify:
>
> 1. Which base kernel are you using?
>
> From the log, you are using 6.5-rc7-706a74159504. However,
> I think we cannot cleanly revert 12a6caf273240a on top of
> 6.5-rc7-706a74159504. Did you manually fix some issue in the
> revert? If so, could you please share the revert commit?
Yes, I'm basing 6.5.0-rc7 706a74159504 to apply your patch
706a74159504 Linux 6.5-rc7

Attached how I revert the commit.

>
> 2. If you are not using 6.5-rc7-706a74159504 as base kernel, which
> one are you using?
>
> Thanks,
> Song
>
> >
> > >
> > > 2. Try with the following change (add debug messages), which hopefull=
y
> > >    shows which command is holding a reference on mddev->openers.
> > >
> > > Thanks,
> > > Song
> > >
> > > diff --git i/drivers/md/md.c w/drivers/md/md.c
> > > index 78be7811a89f..3e9b718b32c1 100644
> > > --- i/drivers/md/md.c
> > > +++ w/drivers/md/md.c
> > > @@ -7574,11 +7574,15 @@ static int md_ioctl(struct block_device *bdev=
,
> > > blk_mode_t mode,
> > >                 if (mddev->pers && atomic_read(&mddev->openers) > 1) =
{
> > >                         mutex_unlock(&mddev->open_mutex);
> > >                         err =3D -EBUSY;
> > > +                       pr_warn("%s return -EBUSY for %s with
> > > mddev->openers =3D %d\n",
> > > +                               __func__, mdname(mddev),
> > > atomic_read(&mddev->openers));
> > >                         goto out;
> > >                 }
> > >                 if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
> > >                         mutex_unlock(&mddev->open_mutex);
> > >                         err =3D -EBUSY;
> > > +                       pr_warn("%s return -EBUSY for %s with
> > > MD_CLOSING bit set\n",
> > > +                               __func__, mdname(mddev));
> > >                         goto out;
> > >                 }
> > >                 did_set_md_closing =3D true;
> > > @@ -7789,6 +7793,8 @@ static int md_open(struct gendisk *disk, blk_mo=
de_t mode)
> > >                 goto out_unlock;
> > >
> > >         atomic_inc(&mddev->openers);
> > > +       pr_info("%s:%s openers++ =3D %d by %s\n", __func__, mdname(md=
dev),
> > > +               atomic_read(&mddev->openers), current->comm);
> > >         mutex_unlock(&mddev->open_mutex);
> > >
> > >         disk_check_media_change(disk);
> > > @@ -7807,6 +7813,8 @@ static void md_release(struct gendisk *disk)
> > >
> > >         BUG_ON(!mddev);
> > >         atomic_dec(&mddev->openers);
> > > +       pr_info("%s:%s openers-- =3D %d by %s\n", __func__, mdname(md=
dev),
> > > +               atomic_read(&mddev->openers), current->comm);
> > >         mddev_put(mddev);
> > >  }
> > It's pretty strange that I can't reproduce the issue after applied the =
patch.
> >
> > I tried to figure out which part affect the issue and found when I
> > comment out the pr_info() In md_release(), the issue could be
> > reproduced.
> >
> > --
> > Chia-Lin Kao(AceLan)
> > http://blog.acelan.idv.tw/
> > E-Mail: acelan.kaoATcanonical.com (s/AT/@/)



--=20
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)

--000000000000d9517e0603f971e2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Revert-md-only-delete-entries-from-all_mddevs-when-t.patch"
Content-Disposition: attachment; 
	filename="0001-Revert-md-only-delete-entries-from-all_mddevs-when-t.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_llurank60>
X-Attachment-Id: f_llurank60

RnJvbSA1OGRkMTA2ZGI4OGYwMGIwOGQyMGQ0YTk0OWEwMDE2MjkyMzhkYmMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiQ2hpYS1MaW4gS2FvIChBY2VMYW4pIiA8YWNlbGFuLmthb0Bj
YW5vbmljYWwuY29tPgpEYXRlOiBNb24sIDI4IEF1ZyAyMDIzIDAyOjM0OjA4IC0wNDAwClN1Ympl
Y3Q6IFtQQVRDSF0gUmV2ZXJ0ICJtZDogb25seSBkZWxldGUgZW50cmllcyBmcm9tIGFsbF9tZGRl
dnMgd2hlbiB0aGUgZGlzawogaXMgZnJlZWQiCgpUaGlzIHJldmVydHMgY29tbWl0IDEyYTZjYWYy
NzMyNDBhZTQyODQyZGU4Y2MwNWZlYWE4NmU1ODJkNjEuCi0tLQogZHJpdmVycy9tZC9tZC5jIHwg
NTIgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogZHJp
dmVycy9tZC9tZC5oIHwgIDIgLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwg
MzcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9tZC5jIGIvZHJpdmVycy9t
ZC9tZC5jCmluZGV4IDc4YmU3ODExYTg5Zi4uYWY1ZDM3OWFkMzU3IDEwMDY0NAotLS0gYS9kcml2
ZXJzL21kL21kLmMKKysrIGIvZHJpdmVycy9tZC9tZC5jCkBAIC02MDYsMTAgKzYwNiw2IEBAIEVY
UE9SVF9TWU1CT0wobWRfZmx1c2hfcmVxdWVzdCk7CiAKIHN0YXRpYyBpbmxpbmUgc3RydWN0IG1k
ZGV2ICptZGRldl9nZXQoc3RydWN0IG1kZGV2ICptZGRldikKIHsKLQlsb2NrZGVwX2Fzc2VydF9o
ZWxkKCZhbGxfbWRkZXZzX2xvY2spOwotCi0JaWYgKHRlc3RfYml0KE1EX0RFTEVURUQsICZtZGRl
di0+ZmxhZ3MpKQotCQlyZXR1cm4gTlVMTDsKIAlhdG9taWNfaW5jKCZtZGRldi0+YWN0aXZlKTsK
IAlyZXR1cm4gbWRkZXY7CiB9CkBAIC02MjQsNyArNjIwLDcgQEAgdm9pZCBtZGRldl9wdXQoc3Ry
dWN0IG1kZGV2ICptZGRldikKIAkgICAgbWRkZXYtPmN0aW1lID09IDAgJiYgIW1kZGV2LT5ob2xk
X2FjdGl2ZSkgewogCQkvKiBBcnJheSBpcyBub3QgY29uZmlndXJlZCBhdCBhbGwsIGFuZCBub3Qg
aGVsZCBhY3RpdmUsCiAJCSAqIHNvIGRlc3Ryb3kgaXQgKi8KLQkJc2V0X2JpdChNRF9ERUxFVEVE
LCAmbWRkZXYtPmZsYWdzKTsKKwkJbGlzdF9kZWxfaW5pdCgmbWRkZXYtPmFsbF9tZGRldnMpOwog
CiAJCS8qCiAJCSAqIENhbGwgcXVldWVfd29yayBpbnNpZGUgdGhlIHNwaW5sb2NrIHNvIHRoYXQK
QEAgLTMyODUsOCArMzI4MSw2IEBAIHN0YXRpYyBib29sIG1kX3JkZXZfb3ZlcmxhcHMoc3RydWN0
IG1kX3JkZXYgKnJkZXYpCiAKIAlzcGluX2xvY2soJmFsbF9tZGRldnNfbG9jayk7CiAJbGlzdF9m
b3JfZWFjaF9lbnRyeShtZGRldiwgJmFsbF9tZGRldnMsIGFsbF9tZGRldnMpIHsKLQkJaWYgKHRl
c3RfYml0KE1EX0RFTEVURUQsICZtZGRldi0+ZmxhZ3MpKQotCQkJY29udGludWU7CiAJCXJkZXZf
Zm9yX2VhY2gocmRldjIsIG1kZGV2KSB7CiAJCQlpZiAocmRldiAhPSByZGV2MiAmJiByZGV2LT5i
ZGV2ID09IHJkZXYyLT5iZGV2ICYmCiAJCQkgICAgbWRfcmRldnNfb3ZlcmxhcChyZGV2LCByZGV2
MikpIHsKQEAgLTU0ODgsMTAgKzU0ODIsMTEgQEAgbWRfYXR0cl9zaG93KHN0cnVjdCBrb2JqZWN0
ICprb2JqLCBzdHJ1Y3QgYXR0cmlidXRlICphdHRyLCBjaGFyICpwYWdlKQogCWlmICghZW50cnkt
PnNob3cpCiAJCXJldHVybiAtRUlPOwogCXNwaW5fbG9jaygmYWxsX21kZGV2c19sb2NrKTsKLQlp
ZiAoIW1kZGV2X2dldChtZGRldikpIHsKKwlpZiAobGlzdF9lbXB0eSgmbWRkZXYtPmFsbF9tZGRl
dnMpKSB7CiAJCXNwaW5fdW5sb2NrKCZhbGxfbWRkZXZzX2xvY2spOwogCQlyZXR1cm4gLUVCVVNZ
OwogCX0KKwltZGRldl9nZXQobWRkZXYpOwogCXNwaW5fdW5sb2NrKCZhbGxfbWRkZXZzX2xvY2sp
OwogCiAJcnYgPSBlbnRyeS0+c2hvdyhtZGRldiwgcGFnZSk7CkBAIC01NTEyLDEwICs1NTA3LDEx
IEBAIG1kX2F0dHJfc3RvcmUoc3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVjdCBhdHRyaWJ1dGUg
KmF0dHIsCiAJaWYgKCFjYXBhYmxlKENBUF9TWVNfQURNSU4pKQogCQlyZXR1cm4gLUVBQ0NFUzsK
IAlzcGluX2xvY2soJmFsbF9tZGRldnNfbG9jayk7Ci0JaWYgKCFtZGRldl9nZXQobWRkZXYpKSB7
CisJaWYgKGxpc3RfZW1wdHkoJm1kZGV2LT5hbGxfbWRkZXZzKSkgewogCQlzcGluX3VubG9jaygm
YWxsX21kZGV2c19sb2NrKTsKIAkJcmV0dXJuIC1FQlVTWTsKIAl9CisJbWRkZXZfZ2V0KG1kZGV2
KTsKIAlzcGluX3VubG9jaygmYWxsX21kZGV2c19sb2NrKTsKIAlydiA9IGVudHJ5LT5zdG9yZSht
ZGRldiwgcGFnZSwgbGVuZ3RoKTsKIAltZGRldl9wdXQobWRkZXYpOwpAQCAtNzgyNiw2ICs3ODIy
LDcgQEAgc3RhdGljIHZvaWQgbWRfZnJlZV9kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNrKQogCXN0
cnVjdCBtZGRldiAqbWRkZXYgPSBkaXNrLT5wcml2YXRlX2RhdGE7CiAKIAlwZXJjcHVfcmVmX2V4
aXQoJm1kZGV2LT53cml0ZXNfcGVuZGluZyk7CisKIAltZGRldl9mcmVlKG1kZGV2KTsKIH0KIApA
QCAtODE1OSw4ICs4MTU2LDcgQEAgc3RhdGljIHZvaWQgKm1kX3NlcV9zdGFydChzdHJ1Y3Qgc2Vx
X2ZpbGUgKnNlcSwgbG9mZl90ICpwb3MpCiAJbGlzdF9mb3JfZWFjaCh0bXAsJmFsbF9tZGRldnMp
CiAJCWlmICghbC0tKSB7CiAJCQltZGRldiA9IGxpc3RfZW50cnkodG1wLCBzdHJ1Y3QgbWRkZXYs
IGFsbF9tZGRldnMpOwotCQkJaWYgKCFtZGRldl9nZXQobWRkZXYpKQotCQkJCWNvbnRpbnVlOwor
CQkJbWRkZXZfZ2V0KG1kZGV2KTsKIAkJCXNwaW5fdW5sb2NrKCZhbGxfbWRkZXZzX2xvY2spOwog
CQkJcmV0dXJuIG1kZGV2OwogCQl9CkBAIC04MTc0LDM1ICs4MTcwLDI1IEBAIHN0YXRpYyB2b2lk
ICptZF9zZXFfbmV4dChzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqdiwgbG9mZl90ICpwb3Mp
CiB7CiAJc3RydWN0IGxpc3RfaGVhZCAqdG1wOwogCXN0cnVjdCBtZGRldiAqbmV4dF9tZGRldiwg
Km1kZGV2ID0gdjsKLQlzdHJ1Y3QgbWRkZXYgKnRvX3B1dCA9IE5VTEw7CiAKIAkrKypwb3M7CiAJ
aWYgKHYgPT0gKHZvaWQqKTIpCiAJCXJldHVybiBOVUxMOwogCiAJc3Bpbl9sb2NrKCZhbGxfbWRk
ZXZzX2xvY2spOwotCWlmICh2ID09ICh2b2lkKikxKSB7CisJaWYgKHYgPT0gKHZvaWQqKTEpCiAJ
CXRtcCA9IGFsbF9tZGRldnMubmV4dDsKLQl9IGVsc2UgewotCQl0b19wdXQgPSBtZGRldjsKLQkJ
dG1wID0gbWRkZXYtPmFsbF9tZGRldnMubmV4dDsKLQl9Ci0KLQlmb3IgKDs7KSB7Ci0JCWlmICh0
bXAgPT0gJmFsbF9tZGRldnMpIHsKLQkJCW5leHRfbWRkZXYgPSAodm9pZCopMjsKLQkJCSpwb3Mg
PSAweDEwMDAwOwotCQkJYnJlYWs7Ci0JCX0KLQkJbmV4dF9tZGRldiA9IGxpc3RfZW50cnkodG1w
LCBzdHJ1Y3QgbWRkZXYsIGFsbF9tZGRldnMpOwotCQlpZiAobWRkZXZfZ2V0KG5leHRfbWRkZXYp
KQotCQkJYnJlYWs7Ci0JCW1kZGV2ID0gbmV4dF9tZGRldjsKKwllbHNlCiAJCXRtcCA9IG1kZGV2
LT5hbGxfbWRkZXZzLm5leHQ7CisJaWYgKHRtcCAhPSAmYWxsX21kZGV2cykKKwkJbmV4dF9tZGRl
diA9IG1kZGV2X2dldChsaXN0X2VudHJ5KHRtcCxzdHJ1Y3QgbWRkZXYsYWxsX21kZGV2cykpOwor
CWVsc2UgeworCQluZXh0X21kZGV2ID0gKHZvaWQqKTI7CisJCSpwb3MgPSAweDEwMDAwOwogCX0K
IAlzcGluX3VubG9jaygmYWxsX21kZGV2c19sb2NrKTsKIAotCWlmICh0b19wdXQpCisJaWYgKHYg
IT0gKHZvaWQqKTEpCiAJCW1kZGV2X3B1dChtZGRldik7CiAJcmV0dXJuIG5leHRfbWRkZXY7CiAK
QEAgLTg3NzIsOCArODc1OCw2IEBAIHZvaWQgbWRfZG9fc3luYyhzdHJ1Y3QgbWRfdGhyZWFkICp0
aHJlYWQpCiAJCQlnb3RvIHNraXA7CiAJCXNwaW5fbG9jaygmYWxsX21kZGV2c19sb2NrKTsKIAkJ
bGlzdF9mb3JfZWFjaF9lbnRyeShtZGRldjIsICZhbGxfbWRkZXZzLCBhbGxfbWRkZXZzKSB7Ci0J
CQlpZiAodGVzdF9iaXQoTURfREVMRVRFRCwgJm1kZGV2Mi0+ZmxhZ3MpKQotCQkJCWNvbnRpbnVl
OwogCQkJaWYgKG1kZGV2MiA9PSBtZGRldikKIAkJCQljb250aW51ZTsKIAkJCWlmICghbWRkZXYt
PnBhcmFsbGVsX3Jlc3luYwpAQCAtOTU3Nyw4ICs5NTYxLDcgQEAgc3RhdGljIGludCBtZF9ub3Rp
ZnlfcmVib290KHN0cnVjdCBub3RpZmllcl9ibG9jayAqdGhpcywKIAogCXNwaW5fbG9jaygmYWxs
X21kZGV2c19sb2NrKTsKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUobWRkZXYsIG4sICZhbGxf
bWRkZXZzLCBhbGxfbWRkZXZzKSB7Ci0JCWlmICghbWRkZXZfZ2V0KG1kZGV2KSkKLQkJCWNvbnRp
bnVlOworCQltZGRldl9nZXQobWRkZXYpOwogCQlzcGluX3VubG9jaygmYWxsX21kZGV2c19sb2Nr
KTsKIAkJaWYgKG1kZGV2X3RyeWxvY2sobWRkZXYpKSB7CiAJCQlpZiAobWRkZXYtPnBlcnMpCkBA
IC05OTM0LDggKzk5MTcsNyBAQCBzdGF0aWMgX19leGl0IHZvaWQgbWRfZXhpdCh2b2lkKQogCiAJ
c3Bpbl9sb2NrKCZhbGxfbWRkZXZzX2xvY2spOwogCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSht
ZGRldiwgbiwgJmFsbF9tZGRldnMsIGFsbF9tZGRldnMpIHsKLQkJaWYgKCFtZGRldl9nZXQobWRk
ZXYpKQotCQkJY29udGludWU7CisJCW1kZGV2X2dldChtZGRldik7CiAJCXNwaW5fdW5sb2NrKCZh
bGxfbWRkZXZzX2xvY2spOwogCQlleHBvcnRfYXJyYXkobWRkZXYpOwogCQltZGRldi0+Y3RpbWUg
PSAwOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9tZC5oIGIvZHJpdmVycy9tZC9tZC5oCmluZGV4
IDFhZWY4NmJmM2ZjMy4uNGUyNjVlMzhjMjI5IDEwMDY0NAotLS0gYS9kcml2ZXJzL21kL21kLmgK
KysrIGIvZHJpdmVycy9tZC9tZC5oCkBAIC0yNTIsNyArMjUyLDYgQEAgc3RydWN0IG1kX2NsdXN0
ZXJfaW5mbzsKICAqIEBNRF9OT1RfUkVBRFk6IGRvX21kX3J1bigpIGlzIGFjdGl2ZSwgc28gJ2Fy
cmF5X3N0YXRlJywgdXN0IG5vdCByZXBvcnQgdGhhdAogICoJCSAgIGFycmF5IGlzIHJlYWR5IHll
dC4KICAqIEBNRF9CUk9LRU46IFRoaXMgaXMgdXNlZCB0byBzdG9wIHdyaXRlcyBhbmQgbWFyayBh
cnJheSBhcyBmYWlsZWQuCi0gKiBATURfREVMRVRFRDogVGhpcyBkZXZpY2UgaXMgYmVpbmcgZGVs
ZXRlZAogICoKICAqIGNoYW5nZSBVTlNVUFBPUlRFRF9NRERFVl9GTEFHUyBmb3IgZWFjaCBhcnJh
eSB0eXBlIGlmIG5ldyBmbGFnIGlzIGFkZGVkCiAgKi8KQEAgLTI2OSw3ICsyNjgsNiBAQCBlbnVt
IG1kZGV2X2ZsYWdzIHsKIAlNRF9VUERBVElOR19TQiwKIAlNRF9OT1RfUkVBRFksCiAJTURfQlJP
S0VOLAotCU1EX0RFTEVURUQsCiB9OwogCiBlbnVtIG1kZGV2X3NiX2ZsYWdzIHsKLS0gCjIuMzcu
MgoK
--000000000000d9517e0603f971e2--
