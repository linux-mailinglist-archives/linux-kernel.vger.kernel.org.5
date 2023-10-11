Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC397C5ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjJKU5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjJKUs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:48:57 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A8A91;
        Wed, 11 Oct 2023 13:48:55 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d77ad095f13so243781276.2;
        Wed, 11 Oct 2023 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697057335; x=1697662135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1dQU6FIoYZJ0/aPurc/poVNBiC0XLIUrsGQZ3Xn7ZE=;
        b=fEF6qA9PehkbZBQ2DGZcRRjtmnipedoAcUPEJEIJnNpncWqeZsGi2/YSxPUGokYSGf
         fHQwRQZ5PSB2HXX2jM/ZmP8zbND/w6k7AmOCfDcmvg0pTSqyI/rCKO5nAsMdWGmQ7RBc
         JDyt/jlkf98uxPY8M6rQltWAuRTxXhL5Be7bDKIvhHeGLX+wsMQR69SjSUDdw3+6ryPj
         aHdiOMmZaEwmZUVRoF3C934zPZMai3QJgYaN7SmPVBinz3gpUYS9spxsC5JtczCMDUhV
         ErvHviigDQu9yvBnkcL2ggvI/3p7kWqYi+DGcdJXAtxAbA1ngstRU6DLiDRHtDLlFksB
         pzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057335; x=1697662135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1dQU6FIoYZJ0/aPurc/poVNBiC0XLIUrsGQZ3Xn7ZE=;
        b=HTaeMB+LgZcK0x4mUj8SulM7BAFyK1qAV4mWxxkaD9npv7uJ2jQCz6WYtAu7z7SucJ
         UhXMEw/f/wEX9e0sOxSnubhlIvurUH0w/FK+qPzEEgGEMO60Y0Ox4pGtPhNWFwhwB5hD
         u2ngFG88f22RpY+fqSVlWDUnbRMtlUhabu4zCSnJCvL2WmtfIt5RfELWWF8jJGuAqydX
         YgXSkGjHQiQuC5J2WuWfLYashpnEqV9S1UxTWiParfHGzNeSMAnZzvKMwRJjvdLrANLz
         HaSqZ5pz1NS/M+MYLrMa2pwZLUxwcri9ALywJp2SA/xK0utXWCScZxgvWPcZRIxCGhNX
         1QaQ==
X-Gm-Message-State: AOJu0Yyl0hDmE1lzAIg46SXWuNfcLzbr2+pyIVvPaEVH2Tpvlqvqbwn5
        6AnNm9AWnb+bJzuMMDe0lvNmpaksh0/ld+Z2Lfw=
X-Google-Smtp-Source: AGHT+IFetHiXoVCCLI7ObePcZKTz4hG20W/mdVhuVmwTTswGtFDaeK4KOW6PelodU9NYgNylwRZYam9ReQOMNMrC7Zo=
X-Received: by 2002:a25:86c7:0:b0:d9a:576c:4a6b with SMTP id
 y7-20020a2586c7000000b00d9a576c4a6bmr5922920ybm.12.1697057334895; Wed, 11 Oct
 2023 13:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231009212053.2007-1-graf@amazon.com> <20231009212053.2007-2-graf@amazon.com>
 <2023101010-overwrite-parakeet-91d5@gregkh> <0ee221bc-ea99-4724-9ebd-436e91417e4b@amazon.com>
 <2023101009-accustom-manifesto-8bdb@gregkh> <b3a8c722-c0e2-4c8c-aef0-29af0a93572d@amazon.com>
 <2023101001-ocelot-veteran-10db@gregkh> <2339287b-8b17-413b-aa86-f618ea7fc3fa@app.fastmail.com>
 <2023101156-helper-waving-09df@gregkh>
In-Reply-To: <2023101156-helper-waving-09df@gregkh>
From:   Petre Eftime <petre.eftime@gmail.com>
Date:   Wed, 11 Oct 2023 23:48:43 +0300
Message-ID: <CAHO81f5m3Lgus-YBbmmHDHoNsrHQ1GYkddtyv3_rJ_g0NT5Nzw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Import CBOR library
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alexander Graf <graf@amazon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Kyunghwan Kwon <k@mononn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 8:46=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 11, 2023 at 02:24:48PM +0200, Arnd Bergmann wrote:
> > On Tue, Oct 10, 2023, at 10:27, Greg Kroah-Hartman wrote:
> > > On Tue, Oct 10, 2023 at 10:08:43AM +0200, Alexander Graf wrote:
> > >> On 10.10.23 10:03, Greg Kroah-Hartman wrote:
> > >>
> > >> > > Out of these, the NSM communication protocol uses all except Sem=
antic tags
> > >> > > and Floats. The CBOR library that this patch imports does not ha=
ve special
> > >> > > handling for Semantic tags, which leaves only floats which are a=
lready
> > >> > > #ifdef'ed out. That means there is not much to trim.
> > >> > >
> > >> > > What you see here is what's needed to parse CBOR in kernel - if =
that's what
> > >> > > we want to do. I'm happy to rip it out again and make it a pure =
user space
> > >> > > problem to do CBOR :).
> > >> > Yes, why are we parsing this in the kernel?  What could go wrong w=
ith
> > >> > adding yet-another-parser in privileged context?  :)
> > >> >
> > >> > Why does this have to be in the kernel, the data sent/recieved is =
over
> > >> > virtio, so why does the kernel have to parse it?  I couldn't figur=
e that
> > >> > out from the driver, yet the driver seems to have a lot of hard-co=
ded
> > >> > parsing logic in it to assume specific message formats?
> > >>
> > >>
> > >> The parsing doesn't have to be in kernel and it probably shouldn't b=
e
> > >> either. V3 of the patch was punting all the parsing to user space, a=
t which
> > >> point you and Arnd said I should give it a try to do the protocol pa=
rsing in
> > >> kernel space instead. That's why the parser is here.
> > >
> > > Arnd said that, not me :)
> > >
> > >> If we conclude that all this in-kernel parsing is not worth it, I'm =
very
> > >> happy to just go back to the the v3 ioctl interface and post v5 with=
 hwrng
> > >> merged into misc, but remove all CBOR logic again :)
> > >
> > > I think the less parsers we have in the kernel, the safer we are for
> > > obvious reasons.  Unless you have a parser for this in rust?  :)
> > >
> > > I don't really know, having a generic interface is good, but at the
> > > expense of this api is probably not good.  individual ioctls might be
> > > better if there are not going to be any other drivers for this type o=
f
> > > thing?
> >
> > I was definitely expecting something simpler than what was possible
> > in the v4 patch. I had another look now, and it's clear that the
> > ioctl interface is still not great because the variable data structures
> > shine through for some of the calls, and even to get to this point,
> > a whole lot of complexity is required underneath.
> >
> > To get anything better, one would probably have to redesign the entire
> > interface stack (hypervisor, kernel and userland) to use regular
> > fixed data structures, and this seems unlikely to happen.
>
> Why not fix this and do it properly?  What's preventing that from
> happening?  We don't want to create an interface here that is broken, or
> insecure, or a pain to maintain, right?
>
> thanks,
>
> greg k-h

I would think the proposal to have fixed structures would be a
downgrade in terms of maintainability, usability and security, not an
improvement.

This current interface allows the hypervisor to extend the existing
functionality at any time, and the Linux kernel does not have to
change anything for that to work, the application does not have to be
recompiled to use the new kernel headers at any point. Adding new
APIs, adding new fields to API responses, or adding optional
parameters to the API is fully backwards compatible, would also not
require changes in userspace, as the CBOR data structures that are not
recognized can simply be skipped. This allows easy backwards
compatibility in most cases, and the userspace would be able to opt in
to new features only if it requires them, without forcing the upgrade
if it's not required.

With fixed structures, then the driver would need to be more
explicitly versioned and would need to be able to handle multiple
versions of the API at the same time, which is both more complex, less
flexible and more prone to errors.

-- epetre
