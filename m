Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93A79F0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjIMSD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjIMSDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:03:25 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D12019BB;
        Wed, 13 Sep 2023 11:03:21 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bb07d274feso56370a34.0;
        Wed, 13 Sep 2023 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694628201; x=1695233001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTQ+RRbRuRtpDn9v8bCeJP7NnnGIRM2PudB4oWDtzbc=;
        b=Mg9jfBBJzqPFRd/LY71um27RaAwh+uTfOy3ePzLIRykrwv3Ia5zwkNaF5WIm8bCvVT
         IC7VcAi/eT4cVbKuxuOFud7OlvJH9lSLCeSbpevgun8hTu1pk2ZV2TK8HVSylc9JUZIH
         utk6aC4qJQUNdQ6wS6j+1PdiopGgHo6yxyrtSPTZpMMbbWhgWSAXnhMKu6eR9Z591LDu
         2/G1EO/dndAMA/Jrq/lrw/ByGeIqJrW+8YhLnFYmEn+ijeRC9PCUJ3cfQLmvcYTCca+4
         /fUUef/fGriHDz+9f8YYLyANc5O40Ojg2v0YR72ZBRME56NSIfwv3R19303G285PKyG7
         1RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694628201; x=1695233001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTQ+RRbRuRtpDn9v8bCeJP7NnnGIRM2PudB4oWDtzbc=;
        b=LuJugtLjBTtRA8YVzsLn+kB4odKEoIVmjK8pzOknNoyjLrz9MHjNjptRmSIKJFqrf0
         EeEnx6VLd+ix8Uv3gDz1JsE/ctZyR2uKnDohKMX/NPvmWboW/E+FZi3v5jGCOXPJN6nE
         rZhGjV6zm16qtL45JsLS5zmJdsY/4z2F4p086k1Tv4Y/ba4oHKTqmgDtGnEvAolRaLSb
         z4+GVeBOu3vnudIe06r8uX/r9J/JYyjfLX9OCTlrdn4BvDn/UpvjLG+5p2o6ryHvP7T+
         xE4iDltUECkaRfbsYEBoqNc00ozM7Mh3SiQnqhhVqgwV28+nBsOR4IMk2fNdxVQjgkGB
         eNlw==
X-Gm-Message-State: AOJu0YwwLKQHX1bEfmf357D/jmKk8d81TbYhZ7mKwzfigrmXWcwrtQoU
        I3Ns0K/sL2XZPUkEjU3IWMx+sK8ajzUtIAkgLp8=
X-Google-Smtp-Source: AGHT+IHrLFBsIo+OSlTogZIiUkVPShagbZTuPMGKv52HR8FtM4jsVmZUbJXOw57qmunzfgqnk6nNZ2Ipk2pM3RWvu8o=
X-Received: by 2002:a9d:6845:0:b0:6b8:9483:35ba with SMTP id
 c5-20020a9d6845000000b006b8948335bamr3641544oto.24.1694628200630; Wed, 13 Sep
 2023 11:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151220.166215-1-cgzones@googlemail.com>
 <CAEjxPJ7_CMFvRHFp1HVV+ppZEXPkWG6oH1MMEbjFESH44wZukg@mail.gmail.com> <CAHC9VhTiuZRCm2E3DkB=zD8R1OZccSCpsbr2mB=aOPGXkjUhhw@mail.gmail.com>
In-Reply-To: <CAHC9VhTiuZRCm2E3DkB=zD8R1OZccSCpsbr2mB=aOPGXkjUhhw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 13 Sep 2023 14:03:09 -0400
Message-ID: <CAEjxPJ5PVAK2LnzzkjjwZ-FtiXPeyrE8ZGCDxxCpY_AvTY3M4w@mail.gmail.com>
Subject: Re: [PATCH 2/6] selinux: dump statistics for more hash tables
To:     Paul Moore <paul@paul-moore.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Sep 7, 2023 at 1:42=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Fri, Aug 18, 2023 at 11:12=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Dump in the SELinux debug configuration the statistics for the
> > > conditional rules avtab, the role transition, and class and common
> > > permission hash tables.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/pol=
icydb.c
> > > index 84f02d4f8093..932e383bcad6 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -1158,6 +1158,8 @@ static int common_read(struct policydb *p, stru=
ct symtab *s, void *fp)
> > >                         goto bad;
> > >         }
> > >
> > > +       hash_eval(&comdatum->permissions.table, "common_permissions")=
;
> > > +
> > >         rc =3D symtab_insert(s, key, comdatum);
> > >         if (rc)
> > >                 goto bad;
> > > @@ -1339,6 +1341,8 @@ static int class_read(struct policydb *p, struc=
t symtab *s, void *fp)
> > >                         goto bad;
> > >         }
> > >
> > > +       hash_eval(&cladatum->permissions.table, "class_permissions");
> > > +
> > >         rc =3D read_cons_helper(p, &cladatum->constraints, ncons, 0, =
fp);
> > >         if (rc)
> > >                 goto bad;
> >
> > Do we want to embed the actual common and class keys in the output to
> > distinguish among the multiple common and class permissions tables?
>
> That seems reasonable, were you thinking of just adding it to the
> hash_eval()'s hash name string, e.g. "common_permissions[XXX]"?

Yes, otherwise you get a bunch of common_permissions and
class_permissions lines with no way to correlate.
