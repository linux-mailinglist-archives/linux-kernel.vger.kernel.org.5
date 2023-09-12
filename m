Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FC779D070
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjILL4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjILL4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:56:44 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFF110D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:56:40 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7a512434bc9so4039002241.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694519799; x=1695124599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM+GZDrqeSJbN3AByx2ZfKWwBecQmUtkdjQEAlP2iy0=;
        b=MDHZsNvSeLS/OCwtRwoa/16HNGkASThsry1ARnMrmiVUlYMCS/sBIRgSW7Nty47b1l
         scwSdIocwZVW31HblVIPK5/QqSTQ5Beo9mmiZBtB46MQXkRzvsTis/RanMpgClHOEonw
         3DOXhSuSbrqoOJEvhWI1Y9JCCpOYB5bZ4LQj1w+YObArarFd7YELLNPFLzz9rGCEGhUi
         XBs+rLbDj210qIUjC31Yd34qn1VANEowaSzNdS6W+d/1jKWaBPQqMKRwI7CAswXympvL
         jFWGrmT/IfG2DW2YNiR1r7+zknMFZOFc1R68auILk0SW3eLLDNK53/lJoe8y+AGVcOo7
         TYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694519799; x=1695124599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hM+GZDrqeSJbN3AByx2ZfKWwBecQmUtkdjQEAlP2iy0=;
        b=DlFR2L8/EnXRrNneb8EAAXXE3eOVyL6qcQHP1JTdHgeSmba2UCkAdrKEBE+NWQ5imO
         pBqDjtlUoTBw9UU61wfHc7c2S2VftnIuX30D9h6P+d8zE6KyNKd7/r+Sf4QL3EVgaapT
         8sERl5TYJNmaIKRqbjlQIQf1yoxY/0/ZB/JgkD89OOkW4ay06matF5d1hInDmXLcmQP/
         w0oa4OIjeoWSiRstwQ5EKIRoH+wtfs6qPmHZ5KgfznnbuIpnvMmMgV2OPCh3aCVb1llz
         N3D8nbEiaUPVk3KKG3HddTQ4pd0QGo8IiPSBynfnBOxniAl51d2EHdxYqLFF6yGnYvRa
         frGA==
X-Gm-Message-State: AOJu0YwV2pjOCMfXkbBtum7HJMTiNnqy0SSc8Lyxv9/sb7TxUyhaZUaz
        HTvjQuWZGIgYiFsdARt14yy2gLp1zzbLyMEZ14Ac4A==
X-Google-Smtp-Source: AGHT+IGgWWHDG3U3xZjhxJlUgNBntR20hjZb21XDRq5dpijLuAigU2VJD5bsWfFlFRPo7V/LoyZy0iqN5FJ9h/3IbKI=
X-Received: by 2002:a05:6102:3564:b0:44d:6320:f0c5 with SMTP id
 bh4-20020a056102356400b0044d6320f0c5mr1070772vsb.12.1694519799125; Tue, 12
 Sep 2023 04:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134633.619970489@linuxfoundation.org> <1ffe4f64-f238-859a-ab14-7559d03c4671@linaro.org>
 <CAEUSe7_XA16yZAHA+YTbJygwaUYkU5gs=FnV9BAmQRYzwgVjvQ@mail.gmail.com>
 <CA+G9fYsiWEKSV0EeU0cXsJZ3U75fbdGyCmDx07ksFMUW5jouyw@mail.gmail.com> <2023091233-boots-line-a3d4@gregkh>
In-Reply-To: <2023091233-boots-line-a3d4@gregkh>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Sep 2023 17:26:27 +0530
Message-ID: <CA+G9fYt2Jnxwvpzcd66HCqkPi6CNistHfmxQYAzX22OWHUoUSA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     jack@suse.cz, stable@vger.kernel.org, patches@lists.linux.dev,
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

On Tue, 12 Sept 2023 at 16:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 12, 2023 at 02:19:34PM +0530, Naresh Kamboju wrote:
> > On Tue, 12 Sept 2023 at 07:55, Daniel D=C3=ADaz <daniel.diaz@linaro.org=
> wrote:
> > >
> > > Hello!
> > >
> > > On Mon, 11 Sept 2023 at 14:58, Daniel D=C3=ADaz <daniel.diaz@linaro.o=
rg> wrote:
> > > > On 11/09/23 7:40 a. m., Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 6.1.53 relea=
se.
> > > > > There are 600 patches in this series, all will be posted as a res=
ponse
> > > > > to this one.  If anyone has any issues with these being applied, =
please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> > > > > Anything received after that time might be too late.
> > > > >
> > > > > The whole patch series can be found in one patch at:
> > > > >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/=
patch-6.1.53-rc1.gz
> > > > > or in the git tree and branch at:
> > > > >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git linux-6.1.y
> > > > > and the diffstat can be found below.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > We're seeing this new warning:
> > > > -----8<-----
> > > >    /builds/linux/fs/udf/inode.c:892:6: warning: variable 'newblock'=
 is used uninitialized whenever 'if' condition is true [-Wsometimes-uniniti=
alized]
> > > >      892 |         if (*err < 0)
> > > >          |             ^~~~~~~~
> > > >    /builds/linux/fs/udf/inode.c:914:9: note: uninitialized use occu=
rs here
> > > >      914 |         return newblock;
> > > >          |                ^~~~~~~~
> > > >    /builds/linux/fs/udf/inode.c:892:2: note: remove the 'if' if its=
 condition is always false
> > > >      892 |         if (*err < 0)
> > > >          |         ^~~~~~~~~~~~~
> > > >      893 |                 goto out_free;
> > > >          |                 ~~~~~~~~~~~~~
> > > >    /builds/linux/fs/udf/inode.c:699:34: note: initialize the variab=
le 'newblock' to silence this warning
> > > >      699 |         udf_pblk_t newblocknum, newblock;
> > > >          |                                         ^
> > > >          |                                          =3D 0
> > > >    1 warning generated.
> > > > ----->8-----
> > > >
> > > > That's with Clang 17 (and nightly) on:
> > > > * arm
> > > > * powerpc
> > > > * s390
> > >
> > > For what it's worth, bisection points to 903b487b5ba6 ("udf: Handle
> > > error when adding extent to a file").
> >
> > I see the following commit is fixing the reported problem.
> >
> > commit 6d5ab7c2f7cf90877dab8f2bb06eb5ca8edc73ef
> > Author: Tom Rix <trix@redhat.com>
> > Date:   Fri Dec 30 12:53:41 2022 -0500
> >
> >     udf: initialize newblock to 0
> >
> >     The clang build reports this error
> >     fs/udf/inode.c:805:6: error: variable 'newblock' is used
> > uninitialized whenever 'if' condition is true
> > [-Werror,-Wsometimes-uninitialized]
> >             if (*err < 0)
> >                 ^~~~~~~~
> >     newblock is never set before error handling jump.
> >     Initialize newblock to 0 and remove redundant settings.
> >
> >     Fixes: d8b39db5fab8 ("udf: Handle error when adding extent to a fil=
e")
> >     Reported-by: Nathan Chancellor <nathan@kernel.org>
> >     Signed-off-by: Tom Rix <trix@redhat.com>
> >     Signed-off-by: Jan Kara <jack@suse.cz>
> >     Message-Id: <20221230175341.1629734-1-trix@redhat.com>
>
> Wait, where is this commit?  I don't see it in Linus's tree either, nor
> in linux-next.  Where did you find it?

Can you find this commit id ?

Commit id: 23970a1c9475b305770fd37bebfec7a10f263787
subject: ("udf: initialize newblock to 0")

- Naresh


>
> confused,
>
> greg k-h
