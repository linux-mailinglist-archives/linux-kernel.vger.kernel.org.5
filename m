Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4FA79C35D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbjILCzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjILCzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:55:01 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A407BE03
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:25:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76dcf1d8957so309183285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694485515; x=1695090315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPH7BllVgYHUBzqVctyR+AwmpoGJ0bqUUfOFZqFnbbk=;
        b=CwOJNW5egcufsQY6bVALpWKxjNH9+cgxl3OsmXirRb6qzxUZnune6tSdXd/ohRL+Yj
         Ce9wOH7D4m8FiTPKwsAygKkIn3lAo6RltJNPnZztAKa3L7BKt+k/CGM7sJOAg1YEis9+
         wbevegduuz0Kllq1ppfR+M0ZZgFsn7ABKWerzR6tYlwElxbJAq9ljaG8Nq0ybZxM8wYY
         9eSrcddQURAD9LpNP9o3rHNEgX0op7u68XUEhiNghhUhIogY1XzxPFlfFUEyrrOK80NH
         zyN5BSVqknHDH/Y0sVHeU37sW5gCNzBxAIupff1sXgEBXrPj5rvObiOXJsZOxpKc0z2z
         0IeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694485515; x=1695090315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPH7BllVgYHUBzqVctyR+AwmpoGJ0bqUUfOFZqFnbbk=;
        b=po4bnzmD9K10Cwy93u2fs1HJKYTLHRTMQ9kD/O54Awz7v6zAAN7loRJ4UQb1KCCYIf
         IytqI7Qzl09s+lDpRQj+XDg+eRPdd3cQlkL8M97YRhMpSiSBoqVmv7q3fTNH1PJDLUtr
         2s7snw4/3+rKbMMyByfs+rL6RLsQLAw6OjCmAhwZjJZQPCbDUu+4Ftei2OsrBzFoqpns
         /Hdu5njpXhEVzyRCnCqyXoxujNLPLc6hqhBbooHntME+E/HuKXHQ2ZnnJ3Jnr4jx/oG9
         z6I7prS8kHgHKXCvuS2TUOyA14RujjbwH+GfZ+d4IRvCs5nzngxiFsZI0t9ZwuSBuU36
         h3GA==
X-Gm-Message-State: AOJu0YzY7zvMiB2inP65mvGwDP7kCLJUzI0UgIUu1qDz+S1B0D5quQC+
        8LZA/2micElQ74BjANkFFIuq7jaMiZFLvVg8wxSG1g==
X-Google-Smtp-Source: AGHT+IGrE5jMhbjwcI0STJIohBq/DbBZL++GuIpzAw5avk5UWgn5reyR+CTkf/20lvaYDnuHaKBywL/Ttmtxg9hnn5w=
X-Received: by 2002:a05:620a:c43:b0:76f:2c0f:9ddb with SMTP id
 u3-20020a05620a0c4300b0076f2c0f9ddbmr14110575qki.8.1694485515418; Mon, 11 Sep
 2023 19:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134633.619970489@linuxfoundation.org> <1ffe4f64-f238-859a-ab14-7559d03c4671@linaro.org>
In-Reply-To: <1ffe4f64-f238-859a-ab14-7559d03c4671@linaro.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 11 Sep 2023 20:25:03 -0600
Message-ID: <CAEUSe7_XA16yZAHA+YTbJygwaUYkU5gs=FnV9BAmQRYzwgVjvQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, 11 Sept 2023 at 14:58, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wr=
ote:
> On 11/09/23 7:40 a. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.53 release.
> > There are 600 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.53-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> We're seeing this new warning:
> -----8<-----
>    /builds/linux/fs/udf/inode.c:892:6: warning: variable 'newblock' is us=
ed uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized=
]
>      892 |         if (*err < 0)
>          |             ^~~~~~~~
>    /builds/linux/fs/udf/inode.c:914:9: note: uninitialized use occurs her=
e
>      914 |         return newblock;
>          |                ^~~~~~~~
>    /builds/linux/fs/udf/inode.c:892:2: note: remove the 'if' if its condi=
tion is always false
>      892 |         if (*err < 0)
>          |         ^~~~~~~~~~~~~
>      893 |                 goto out_free;
>          |                 ~~~~~~~~~~~~~
>    /builds/linux/fs/udf/inode.c:699:34: note: initialize the variable 'ne=
wblock' to silence this warning
>      699 |         udf_pblk_t newblocknum, newblock;
>          |                                         ^
>          |                                          =3D 0
>    1 warning generated.
> ----->8-----
>
> That's with Clang 17 (and nightly) on:
> * arm
> * powerpc
> * s390

For what it's worth, bisection points to 903b487b5ba6 ("udf: Handle
error when adding extent to a file").

In order to reproduce:

  #pip3 install -U tuxmake
  tuxmake --runtime podman \
    --target-arch arm \
    --toolchain clang-17 \
    --kconfig multi_v5_defconfig \
    LLVM=3D1 LLVM_IAS=3D1

or:

  #pip3 install -U tuxmake
  tuxmake --runtime podman \
    --target-arch powerpc \
    --toolchain clang-17 \
    --kconfig defconfig \
    LLVM=3D1 LLVM_IAS=3D0 LD=3Dpowerpc64le-linux-gnu-ld

or:

  #pip3 install -U tuxmake
  tuxmake --runtime podman \
    --target-arch s390 \
    --toolchain clang-17 \
    --kconfig defconfig \
    LLVM_IAS=3D1


Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
