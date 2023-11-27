Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6827FA7F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjK0RcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjK0RcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:32:18 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275CCA5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:32:24 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-285699ebabcso2818398a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701106343; x=1701711143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts3VyCUe4cBea8IwRsP0b6P6Avs/GjtfVnV06MWxKQQ=;
        b=Xgi7usSDHLWs0scoNjZdVXFCTKEpBnIRZBqugTaUViX+H6lh8s2EkGi1o/MVjjSDkq
         m3g7JPmavK9J4sooPg3uDhXSQWYdPOflsr6alDo3r5RAaNx6RgwybPI8k+oUoqWfo+/8
         u0k12RCMK7Dm4uQLSr0D0pcPFClp39vXBIpeLqqwfm+QuYbQmbmLF5eplnmfFD6yW7Oa
         PcKaouEHu0kIfMMfmIxPBc5OTMaEYZ23RVpNYVqymihWJOMxP6OGDw7b93vKk8PS+Bt9
         rGb/4VJSrGKOIIAeha9Ypnvm3fEgWIq7PCKDfASIOQ97Ri+Nhc5xZEJea3U/LUctH2sT
         R56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701106343; x=1701711143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts3VyCUe4cBea8IwRsP0b6P6Avs/GjtfVnV06MWxKQQ=;
        b=cs0C/dSRxCzrHi0t/3RAJWClnoWUzm/tY6KrHera0wrn28BiovDCIYuHgj4LNsDIMF
         PJeym+FWkmxbmuOMotgMlTU2eg4mjUPgtvc6AeVLmIrnf+pxfJ/4uEUkWEn9tx6SO3mx
         V6auMXuHC001azVHNDlSYi4MCsUE+BEFQLAtThKehJhcD9PGoq03gYBWQS35c0H2u+78
         x3YzQ+vDCTT9ri3PPPCgOahEzzuEA2wJcghOYy/8JDE9lPY12pE5JeRKLZdGmD06DLff
         EB+HDwdh5qUUQEGSH0DTY+FD5wUvA8qUhgQ1TNPDQcQzMyMA+EkSInGAvlkWhEWAGmFp
         Nigg==
X-Gm-Message-State: AOJu0YypS8ID46lgU1Ew+hMoFQ01R1DNFZ+fMzykwRS0Fbd8bf7kaceW
        M1gtpIRp3RK8pVCJ87iiuy+IOtWyX6m7GKKTRFzvIw==
X-Google-Smtp-Source: AGHT+IFQ9zX3MumdTgfhvMAgaY7F9eqnRsilyyirYn4Z4DQcWwjkd+7Kv6KPcwAvs+qloWCPAyY87E+KudOL414aKTs=
X-Received: by 2002:a17:90b:1894:b0:280:23e4:4326 with SMTP id
 mn20-20020a17090b189400b0028023e44326mr20599735pjb.14.1701106343555; Mon, 27
 Nov 2023 09:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20231124172000.087816911@linuxfoundation.org> <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
 <20231127155557.xv5ljrdxcfcigjfa@quack3>
In-Reply-To: <20231127155557.xv5ljrdxcfcigjfa@quack3>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 27 Nov 2023 11:32:12 -0600
Message-ID: <CAEUSe7_PUdRgJpY36jZxy84CbNX5TTnynqU8derf0ZBSDtUOqw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/297] 5.15.140-rc1 review
To:     Jan Kara <jack@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, chrubis@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, 27 Nov 2023 at 09:56, Jan Kara <jack@suse.cz> wrote:
> Hello!
>
> On Fri 24-11-23 23:45:09, Daniel D=C3=ADaz wrote:
> > On 24/11/23 11:50 a. m., Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.15.140 release=
.
> > > There are 297 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.140-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > We are noticing a regression with ltp-syscalls' preadv03:
>
> Thanks for report!
>
> > -----8<-----
> >   preadv03 preadv03
> >   preadv03_64 preadv03_64
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'a' expectedly
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'a' expectedly
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'b' expectedly
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'a' expectedly
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'a' expectedly
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'b' expectedly
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> > ----->8-----
> >
> > This is seen in the following environments:
> > * dragonboard-845c
> > * juno-64k_page_size
> > * qemu-arm64
> > * qemu-armv7
> > * qemu-i386
> > * qemu-x86_64
> > * x86_64-clang
> >
> > and on the following RC's:
> > * v5.10.202-rc1
> > * v5.15.140-rc1
> > * v6.1.64-rc1
>
> Hum, even in 6.1? That's odd. Can you please test whether current upstrea=
m
> vanilla kernel works for you with this test? Thanks!

Yes, this is working for us on mainline and next:
  https://qa-reports.linaro.org/lkft/linux-mainline-master/tests/ltp-syscal=
ls/preadv03
  https://qa-reports.linaro.org/lkft/linux-next-master/tests/ltp-syscalls/p=
readv03
c.fr. 6.1:
  https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/tests/ltp-=
syscalls/preadv03

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
