Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5870779CA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjILIty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjILItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:49:51 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3971310C7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:49:47 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4943862e73dso1547613e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694508586; x=1695113386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD+MQJMeaBa6LFiT1hlKHLQpprHXSGsKW9Ny8S5q/Ig=;
        b=KoBlR2Ata623NR1NDHn+TJhvPNJxlZXlFrD9NiJbryhbU08dvy6jWvwoskd15Rtv5b
         xZG4L0DNDdGrzN70WKi8gNLoeX/c1mqKAPu6k34vs/vClha3bIdbM7kwVcBoTjgX9AVa
         h8AJCH2D8ftUV5AJkqcQPMXUkmcRI/qMNaGnAQbaSzF6s4WgeTkf27Mv37z4psosYpcQ
         mBiu158MzRBtYpVhqPwh3ADLUko/kEHvEAKmARkkSisJ85OlLvr38sSUgNtbrg37nSgA
         nUsuh2xceqpFj6T2ySUxOgY27QLZZMEY4QzCAmHkU4sWpVIFSlNMTr9asCfeyyTQ2iLV
         8zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508586; x=1695113386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mD+MQJMeaBa6LFiT1hlKHLQpprHXSGsKW9Ny8S5q/Ig=;
        b=l9x4UnrgG+9s8PohX4nLyUziFS4/qqpgteEHrqoCsQ9uvYRrSNT4XmD/SqZgCRtMdi
         Nh1Fh/i5/XZ6kBq8OoDH7Obqeap780cDldLucJpLyAXE2dhRHDqzCWVuQbuu2MbWrhUb
         l05RWAK/BOw9P4MPglHgaZsQCoc4RAlZd+IEpzU/v3oecFratcHd0jeaLj8za/eVhHbq
         erlM6B3Ch9CT60dtokrVGCJC0RrmEldxjs9anMFU0MkbSwsn2CyF2fm1tAKMgHV0AvdS
         TzrmC3VOSWtoovTtQbX6C/FJu07gWSKFWyJsYvN7lA2mttu5EsY0/t2k7x5pAEKiqoEs
         1Xjg==
X-Gm-Message-State: AOJu0YxF9Xne2hVtAGpqjXF5d57jj9kSVECmEbQFpDxDWIpWGOFkVEIv
        Ls8d7BYnACkFWpXXW9q8rYOhmxrj42CT0DmDYCXhog==
X-Google-Smtp-Source: AGHT+IElu424t/b8d80CYSFdFlzkKycfRWGMJCtpMumDMtu8yR2dpAVu6q4YzRxTCXN4YZLnuuutHif/fDOEVKbTSJg=
X-Received: by 2002:a1f:c9c3:0:b0:493:5363:d1dc with SMTP id
 z186-20020a1fc9c3000000b004935363d1dcmr9446089vkf.12.1694508586058; Tue, 12
 Sep 2023 01:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134633.619970489@linuxfoundation.org> <1ffe4f64-f238-859a-ab14-7559d03c4671@linaro.org>
 <CAEUSe7_XA16yZAHA+YTbJygwaUYkU5gs=FnV9BAmQRYzwgVjvQ@mail.gmail.com>
In-Reply-To: <CAEUSe7_XA16yZAHA+YTbJygwaUYkU5gs=FnV9BAmQRYzwgVjvQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Sep 2023 14:19:34 +0530
Message-ID: <CA+G9fYsiWEKSV0EeU0cXsJZ3U75fbdGyCmDx07ksFMUW5jouyw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jack@suse.cz
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sept 2023 at 07:55, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wr=
ote:
>
> Hello!
>
> On Mon, 11 Sept 2023 at 14:58, Daniel D=C3=ADaz <daniel.diaz@linaro.org> =
wrote:
> > On 11/09/23 7:40 a. m., Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.1.53 release.
> > > There are 600 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patc=
h-6.1.53-rc1.gz
> > > or in the git tree and branch at:
> > >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > We're seeing this new warning:
> > -----8<-----
> >    /builds/linux/fs/udf/inode.c:892:6: warning: variable 'newblock' is =
used uninitialized whenever 'if' condition is true [-Wsometimes-uninitializ=
ed]
> >      892 |         if (*err < 0)
> >          |             ^~~~~~~~
> >    /builds/linux/fs/udf/inode.c:914:9: note: uninitialized use occurs h=
ere
> >      914 |         return newblock;
> >          |                ^~~~~~~~
> >    /builds/linux/fs/udf/inode.c:892:2: note: remove the 'if' if its con=
dition is always false
> >      892 |         if (*err < 0)
> >          |         ^~~~~~~~~~~~~
> >      893 |                 goto out_free;
> >          |                 ~~~~~~~~~~~~~
> >    /builds/linux/fs/udf/inode.c:699:34: note: initialize the variable '=
newblock' to silence this warning
> >      699 |         udf_pblk_t newblocknum, newblock;
> >          |                                         ^
> >          |                                          =3D 0
> >    1 warning generated.
> > ----->8-----
> >
> > That's with Clang 17 (and nightly) on:
> > * arm
> > * powerpc
> > * s390
>
> For what it's worth, bisection points to 903b487b5ba6 ("udf: Handle
> error when adding extent to a file").

I see the following commit is fixing the reported problem.

commit 6d5ab7c2f7cf90877dab8f2bb06eb5ca8edc73ef
Author: Tom Rix <trix@redhat.com>
Date:   Fri Dec 30 12:53:41 2022 -0500

    udf: initialize newblock to 0

    The clang build reports this error
    fs/udf/inode.c:805:6: error: variable 'newblock' is used
uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
            if (*err < 0)
                ^~~~~~~~
    newblock is never set before error handling jump.
    Initialize newblock to 0 and remove redundant settings.

    Fixes: d8b39db5fab8 ("udf: Handle error when adding extent to a file")
    Reported-by: Nathan Chancellor <nathan@kernel.org>
    Signed-off-by: Tom Rix <trix@redhat.com>
    Signed-off-by: Jan Kara <jack@suse.cz>
    Message-Id: <20221230175341.1629734-1-trix@redhat.com>


--
Linaro LKFT
https://lkft.linaro.org
