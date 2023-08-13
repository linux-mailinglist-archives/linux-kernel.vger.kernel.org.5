Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1170277A4CE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 05:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHMDLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 23:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHMDLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 23:11:45 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D0C10FB;
        Sat, 12 Aug 2023 20:11:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so50197011fa.2;
        Sat, 12 Aug 2023 20:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691896306; x=1692501106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvzp1gQ+6XfFk/eBBQ2JFjiH09Yw2NiXqDxjmFGA8Fs=;
        b=ZAU8L+/3l6c5EOmAcZGSylH5KIYGymKiNm7cE+muL71RUAUKTBVcbA5L6U1mzR0WhW
         XCiaWnqPlmZ5wGIcrvKYNK5+uXUpMtUd9OMCL2zjeXclsGt4szAiLGfgF1BNycXjRIwq
         aeVx/jkiM8mnF+62JoXBi7c+GXuV7FJ7TDwaaTe4p88WVEfdWZi4HGTPOiUFaIBSi2Dc
         DzKgvb38d7aO4Epe09kLqo+1o+UcqC7qOGrG6biQ1otzwPxE4NtkafHQ3OI2gbtPTcDg
         t6KaJY7JMUWNi7BEkftPiCNQeCVj8fqNKlcLn03VCd9HkStAUhphS+mmcXWjfHXqD6jh
         +yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691896306; x=1692501106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvzp1gQ+6XfFk/eBBQ2JFjiH09Yw2NiXqDxjmFGA8Fs=;
        b=L1aBvp1qHq0yx5t+EfG2wxIoKXgutYL61xPtu5z0VcahZhu74FZO73RHguDB7jE6rx
         PYYwHJBWCcBjaZfJcKHiGcyOjF++TRLLUW9WlnexK15L9dJrg/rV7loLcXnIRXXn2Oe4
         YG+i7Y+jEWZUM15l+2cxSp/OHksomHT20xQ3O8eI7JUt/+euK+Wq8eZnP+nCeVmnKVIg
         rIcnkfU+WA6vbBl1FTCj4E/FioUMvluR10AGn1of7FPbVYqayipsBz3Vrm0IErvz/YSV
         c2lNfFN/AuhLZ+aM/J5LRUqyyMpEtf2EKaieZqDUOLvWKsuPNPu9MQGkgYW7QObK5J0H
         wsFw==
X-Gm-Message-State: AOJu0YzqnJUTsfh3dK/UDymdTwfEBbR7pQJPUh2ntcFhHkKd1ppwRgV8
        FJdgC11wFpwVSHS2TphRQgZFG98PH2llMdP6d0Q=
X-Google-Smtp-Source: AGHT+IFkSnAm0x250e+D/C0jcEvZDPRPt61ghBsO0eg6LDYjULpEWYzx6hQqLTCCrNkRtj8RJxGYJborIl4l4MzCsCE=
X-Received: by 2002:a05:6512:1154:b0:4f8:5635:2cd8 with SMTP id
 m20-20020a056512115400b004f856352cd8mr4747504lfg.32.1691896305579; Sat, 12
 Aug 2023 20:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
 <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
 <ZLhchajZaWEVM6D7@gallifrey> <79bbb44c-f3b1-5c5c-1ad4-bcaab0069666@oracle.com>
 <d1f7fbe9-8fe2-e3e3-d6ff-1544204202ff@talpey.com> <ZLnJzUynpTBvZGtA@gallifrey>
 <f8f4a2c5-05d3-0b2d-688f-b3274a98fc73@talpey.com> <ZLrxYzGXJzsLmGDs@gallifrey>
 <16f50dff126af9b20f9b99ca056ad5fa.pc@manguebit.com> <ZLr0wFMKhEaannov@gallifrey>
 <ZNgqZRZNgN8JdiL4@gallifrey>
In-Reply-To: <ZNgqZRZNgN8JdiL4@gallifrey>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 12 Aug 2023 22:11:31 -0500
Message-ID: <CAH2r5muAQ=gqCKk5qv9SX2Q-YR-2gvFsubTk6sd9p17XS43Acw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] dedupe smb unicode files
To:     "Dr. David Alan Gilbert" <dave@treblig.org>
Cc:     Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        linkinjeon@kernel.org, shaggy@kernel.org,
        linux-cifs@vger.kernel.org, krisman@collabora.com,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thx - should be doable to put in for-next soon unless we find objections

On Sat, Aug 12, 2023 at 7:57=E2=80=AFPM Dr. David Alan Gilbert <dave@trebli=
g.org> wrote:
>
> * Dr. David Alan Gilbert (dave@treblig.org) wrote:
> > * Paulo Alcantara (pc@manguebit.com) wrote:
> > > "Dr. David Alan Gilbert" <linux@treblig.org> writes:
> > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/scripts/checkpatch.pl#n3737
> > > >   if ($realfile =3D~ /\.(h|s|S)$/) {
> > > >           $comment =3D '/*';
> > > >   } elsif ($realfile =3D~ /\.(c|rs|dts|dtsi)$/) {
> > > >           $comment =3D '//';
> > > >
> > > > I don't get where that idea came from.
> > >
> > > Check Documentation/process/license-rules.rst.
> >
> > Oh, that's a painful history!
> > Hmm that landed just after I posted a v3 (of just this patch)
> >
> > Steve: Your call, do you want me to post a v4 with that comment
> > back and but with the copyright lineas as in v3?
>
> I've posted the v4.
>
> Dave
>
> > Dave
> >
> > --
> >  -----Open up your eyes, open up your mind, open up your code -------
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/



--=20
Thanks,

Steve
